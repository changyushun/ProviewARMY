using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;

/// <summary>
/// WebService3 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
public class WebService3 : System.Web.Services.WebService {

    public WebService3 () {

        //如果使用設計的元件，請取消註解下列一行
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public DataTable DownLoadResult(string center_code)
    {
        Lib.DataUtility main = new Lib.DataUtility();
        DateTime _date = DateTime.Now.Date.AddDays(1);
        DateTime deadline = _date.AddHours((-Lib.SysSetting.reserveTimeUnit.TotalHours));
        DataTable dt = new DataTable();
        if (DateTime.Now < deadline)
        {
            _date = DateTime.Now.Date;
        }
        try
        {
            dt = main.getDataTableByText("select sid, id, name, gender, birth, age, unit_code, rank_code, date, center_code, op_id, sit_ups, sit_ups_score, push_ups, push_ups_score, run, run_score, memo from result where center_code = @center_code and status = '000' and date <= '" + _date.ToString("yyyy/MM/dd") + "'", "center_code", center_code);
            dt.TableName = "download";
            if (dt.Rows.Count != 0)
            {
                main.executeNonQueryByText("update result set status = '999' where center_code = @center_code and status = '000' and date <='" + _date.ToString("yyyy/MM/dd") + "'", "center_code", center_code);
            }

            return dt;
        }
        catch (Exception ex)
        {
            dt.TableName = "download";
            return dt;
        }

    }

    [WebMethod]
    public DataTable Re_DownLoadResult(string center_code)//2017-11-8手動重覆下載
    {
        Lib.DataUtility main = new Lib.DataUtility();
        DateTime _date = DateTime.Now.Date.AddDays(1);//當天日期+1天
        DateTime deadline = _date.AddHours((-Lib.SysSetting.reserveTimeUnit.TotalHours));//再減12小時，指當天中午12點
        DataTable dt = new DataTable();
        if (DateTime.Now < deadline)//如果在當天中午12點前就是以當天為主，如果過了12點就是以明天日期為主
        {
            _date = DateTime.Now.Date;
        }
        try
        {
            dt = main.getDataTableByText("select sid, id, name, gender, birth, age, unit_code, rank_code, date, center_code, op_id, sit_ups, sit_ups_score, push_ups, push_ups_score, run, run_score, memo from result where center_code = @center_code and status in ('000','999') and date = '" + _date.ToString("yyyy/MM/dd") + "'", "center_code", center_code);
            dt.TableName = "download";
            if (dt.Rows.Count != 0)
            {
                main.executeNonQueryByText("update result set status = '999' where center_code = @center_code and status = '000' and date ='" + _date.ToString("yyyy/MM/dd") + "'", "center_code", center_code);
            }

            return dt;
        }
        catch (Exception ex)
        {
            dt.TableName = "download";
            return dt;
        }
    }

    [WebMethod]
    public DataTable Get_7DayResultCount(string center_code)//下載未來七日測考人數(含當天)
    {
        Lib.DataUtility main = new Lib.DataUtility();
        DataTable dt = new DataTable();
        Dictionary<string, object> dic = new Dictionary<string, object>();
        try
        {
            dic.Add("center_code", center_code);
            //改取web_SV的時間，不取DB的時間，所以多加入開始時間參數
            dic.Add("start_date", DateTime.Now);
            dt = main.getDataTableBysp("Ex107_Get_7dayResultCount", dic);
            dt.TableName = "7dayResultCount";
            return dt;
        }
        catch (Exception ex)
        {
            dt.TableName = "7dayResultCount";
            return dt;
        }
    }

    [WebMethod]
    public DateTime Get_Web_DateTime()
    {
        DateTime dt;
        dt = DateTime.Now;
        return dt;
    }
}
