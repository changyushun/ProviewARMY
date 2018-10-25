using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;

/// <summary>
/// WebService 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下一行。
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService () {

        //如果使用設計的元件，請取消註解下行程式碼 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }
    [WebMethod]
    public string Datatable(System.Data.DataTable dt)
    {
        foreach (DataRow row in dt.Rows)
        {
            var title = row["unit_title"].ToString();
        }
        return dt.ToString();
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
    public string UploadResult(DataTable dt, string type)
    {
        try
        {
            Lib.DataUtility main = new Lib.DataUtility();
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            switch (type)
            {
                case "102":
                    foreach (DataRow row in dt.Rows)
                    {
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("sid", row["sid"]);
                        d.Add("birth", row["birth"]);
                        //2018-1-24新增鑑測站年齡覆蓋原本的
                        d.Add("age", row["age"]);
                        d.Add("height", row["height"]);
                        d.Add("weight", row["weight"]);
                        d.Add("BMI", row["BMI"]);
                        d.Add("bodyfat", row["bodyfat"]);
                        d.Add("sit_ups", row["sit_ups"]);
                        d.Add("sit_ups_score", row["sit_ups_score"]);
                        d.Add("push_ups", row["push_ups"]);
                        d.Add("push_ups_score", row["push_ups_score"]);
                        d.Add("run", row["run"]);
                        d.Add("run_score", row["run_score"]);
                        d.Add("status", "202");  // 202 已上傳合格
                        d.Add("memo", row["memo"]);
                        
                        list.Add(d);
                    }
                    main.executeNonQueryByText("update result set birth=@birth, age=@age, height = @height, weight=@weight, BMI = @BMI, bodyfat = @bodyfat, sit_ups = @sit_ups, sit_ups_score = @sit_ups_score, push_ups = @push_ups, push_ups_score = @push_ups_score, run = @run, run_score = @run_score, status = @status, memo = @memo where sid = @sid", list);
                    //上傳成績會覆蓋player表格的生日
                    main.executeNonQueryByText("update Player set birth = @birth where id = (select id from Result where sid = @sid)", list); 
                    break;
                case "103":
                    foreach (DataRow row in dt.Rows)
                    {
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("sid", row["sid"]);
                        d.Add("birth", row["birth"]);
                        //2018-1-24新增鑑測站年齡覆蓋原本的
                        d.Add("age", row["age"]);
                        d.Add("height", row["height"]);
                        d.Add("weight", row["weight"]);
                        d.Add("BMI", row["BMI"]);
                        d.Add("bodyfat", row["bodyfat"]);
                        d.Add("sit_ups", row["sit_ups"]);
                        d.Add("sit_ups_score", row["sit_ups_score"]);
                        d.Add("push_ups", row["push_ups"]);
                        d.Add("push_ups_score", row["push_ups_score"]);
                        d.Add("run", row["run"]);
                        d.Add("run_score", row["run_score"]);
                        d.Add("status", "203");  // 203 已上傳不合格
                        d.Add("memo", row["memo"]);
                        list.Add(d);
                    }
                    main.executeNonQueryByText("update result set birth = @birth, age=@age, height = @height, weight=@weight, BMI = @BMI, bodyfat = @bodyfat, sit_ups = @sit_ups, sit_ups_score = @sit_ups_score, push_ups = @push_ups, push_ups_score = @push_ups_score, run = @run, run_score = @run_score, status = @status, memo = @memo where sid = @sid", list);
                    main.executeNonQueryByText("update Player set birth = @birth where id = (select id from Result where sid = @sid)", list); 
                    break;
                case "104":
                    foreach (DataRow row in dt.Rows)
                    {
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("sid", row["sid"]);
                        d.Add("birth", row["birth"]);
                        //2018-1-24新增鑑測站年齡覆蓋原本的
                        d.Add("age", row["age"]);
                        d.Add("height", row["height"]);
                        d.Add("weight", row["weight"]);
                        d.Add("BMI", row["BMI"]);
                        d.Add("bodyfat", row["bodyfat"]);
                        d.Add("sit_ups", row["sit_ups"]);
                        d.Add("sit_ups_score", row["sit_ups_score"]);
                        d.Add("push_ups", row["push_ups"]);
                        d.Add("push_ups_score", row["push_ups_score"]);
                        d.Add("run", row["run"]);
                        d.Add("run_score", row["run_score"]);
                        d.Add("status", "204");  // 204 已上傳免測
                        d.Add("memo", row["memo"]);
                        list.Add(d);
                    }
                    main.executeNonQueryByText("update result set birth = @birth, age=@age, height = @height, weight=@weight, BMI = @BMI, bodyfat = @bodyfat, sit_ups = @sit_ups, sit_ups_score = @sit_ups_score, push_ups = @push_ups, push_ups_score = @push_ups_score, run = @run, run_score = @run_score, status = @status, memo = @memo where sid = @sid", list);
                    main.executeNonQueryByText("update Player set birth = @birth where id = (select id from Result where sid = @sid)", list); 
                    break;
                case "105":
                    foreach (DataRow row in dt.Rows)
                    {
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("sid", row["sid"]);
                        d.Add("birth", row["birth"]);
                        //2018-1-24新增鑑測站年齡覆蓋原本的
                        d.Add("age", row["age"]);
                        d.Add("height", row["height"]);
                        d.Add("weight", row["weight"]);
                        d.Add("BMI", row["BMI"]);
                        d.Add("bodyfat", row["bodyfat"]);
                        d.Add("sit_ups", row["sit_ups"]);
                        d.Add("sit_ups_score", row["sit_ups_score"]);
                        d.Add("push_ups", row["push_ups"]);
                        d.Add("push_ups_score", row["push_ups_score"]);
                        d.Add("run", row["run"]);
                        d.Add("run_score", row["run_score"]);
                        d.Add("status", row["status"].ToString().Replace("1", "2"));  // 205 已上傳原地測
                        d.Add("memo", row["memo"]);
                        list.Add(d);
                    }
                    main.executeNonQueryByText("update result set birth = @birth, age=@age, height = @height, weight=@weight, BMI = @BMI, bodyfat = @bodyfat, sit_ups = @sit_ups, sit_ups_score = @sit_ups_score, push_ups = @push_ups, push_ups_score = @push_ups_score, run = @run, run_score = @run_score, status = @status, memo = @memo where sid = @sid", list);
                    main.executeNonQueryByText("update Player set birth = @birth where id = (select id from Result where sid = @sid)", list); 
                    break;
                case "pending":
                    foreach (DataRow row in dt.Rows)
                    {
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("sid", row["sid"]);
                        d.Add("status", row["status"]);
                        list.Add(d);
                    }
                    main.executeNonQueryByText("update result set status = @status where sid = @sid", list);
                    break;
                case "present":
                    foreach (DataRow row in dt.Rows)
                    {
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("id", row["id"]);
                        d.Add("name", row["name"]);
                        d.Add("age", row["age"]);
                        d.Add("birth", row["birth"]);
                        d.Add("gender", row["gender"]);
                        d.Add("unit_code", row["unit_code"]);
                        d.Add("rank_code", row["rank_code"]);
                        d.Add("height", row["height"]);
                        d.Add("weight", row["weight"]);
                        d.Add("BMI", row["BMI"]);
                        d.Add("bodyfat", row["bodyfat"]);
                        d.Add("sit_ups", row["sit_ups"]);
                        d.Add("sit_ups_score", row["sit_ups_score"]);
                        d.Add("push_ups", row["push_ups"]);
                        d.Add("push_ups_score", row["push_ups_score"]);
                        d.Add("run", row["run"]);
                        d.Add("run_score", row["run_score"]);
                        d.Add("date", row["date"]);
                        d.Add("center_code", row["center_code"]);
                        d.Add("result", "777");
                        d.Add("status", row["status"].ToString().Replace("1","2"));  // 現報處理
                        d.Add("memo", row["memo"]);
                        list.Add(d);
                    }//現場報名:Upadte Player's birth , 如果總部此人員無註冊資料 , 則生日無法更新
                    //2017-1-4現報一天只能存在一筆資料，所以要先刪掉原有的
                    main.executeNonQueryByText("delete Result where id=@id and date=@date", list);
                    main.executeNonQueryByText("insert into result (id,name,age,birth,gender,unit_code,rank_code,height,weight,BMI,bodyfat,sit_ups,sit_ups_score,push_ups,push_ups_score,run,run_score,date,center_code,result,status,memo) values (@id,@name,@age,@birth,@gender,@unit_code,@rank_code,@height,@weight,@BMI,@bodyfat,@sit_ups,@sit_ups_score,@push_ups,@push_ups_score,@run,@run_score,@date,@center_code,@result,@status,@memo)", list);
                    main.executeNonQueryByText("update player set birth = @birth where id = @id", list);
                    break;
                default:
                    break;
            }
            return "done";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }
    [WebMethod]
    public string Unit_Version()
    {
        return Lib.SysSetting.GetUnitVersion().ToString();
    }
    [WebMethod]
    public string Per_Version()
    {
        return Lib.SysSetting.GetPerVersion().ToString();
    }

    [WebMethod]
    public DataTable UnitData()
    {
        Lib.DataUtility du = new Lib.DataUtility();
        DataTable dt = du.getDataTableByText("select * from unit");
        dt.TableName = "unit";
        return dt;
    }
    [WebMethod]
    public DataTable GetResultByID(string id, string year)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        DataTable dt = null;
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("id", id);
        d.Add("year", (Convert.ToInt32(year) + 1911).ToString());
        dt = du.getDataTableBysp("GetResultByID_WS", d);
        dt.TableName = "ResultByID";
        return dt;
    }
    [WebMethod]
    public DataSet GetDataSetTest()
    {
        Lib.DataUtility du = new Lib.DataUtility();
        DataTable dt = new DataTable();
        dt = du.getDataTableByText("select * from unit");
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        return ds;
    }
    
}

