using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
/// <summary>
/// WebService2 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下一行。
// [System.Web.Script.Services.ScriptService]
public class WebService2 : System.Web.Services.WebService {

    public WebService2 () {

        //如果使用設計的元件，請取消註解下行程式碼 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public DataTable QueryPlayer(string id, string date)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        string msg = string.Empty;
        d.Add("id", id);
        d.Add("date", date);
        DataTable dt = du.getDataTableBysp("Ex104_QueryPlayerIsExist", d);
        dt.TableName = "GetPlayer";
        //1. 先檢查此id是否註冊
        //2. 再檢查此id在這個受測日期是否已經有一筆測驗
        //3. 取得此id的個人基本資料

        return dt;
    }

    [WebMethod]
    public string UploadResult(DataTable dt, string type)
    {
        try
        {
            Lib.DataUtility main = new Lib.DataUtility();
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            List<Dictionary<string, object>> list_Del = new List<Dictionary<string, object>>();
            switch (type)
            {
                case "present":
                    foreach (DataRow row in dt.Rows)
                    {
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        Dictionary<string, object> d_Del = new Dictionary<string, object>();
                        d.Add("id", row["id"]);
                        d.Add("name", row["name"]);
                        d.Add("age", row["age"]);
                        d.Add("birth", row["birth"]);
                        d.Add("gender", row["gender"]);
                        d.Add("unit_code", row["unit_code"]);
                        d.Add("rank_code", row["rank_code"]);
                        //d.Add("height", row["height"]);
                        //d.Add("weight", row["weight"]);
                        //d.Add("BMI", row["BMI"]);
                        //d.Add("bodyfat", row["bodyfat"]);
                        d.Add("sit_ups", row["sit_ups"]);
                        d.Add("sit_ups_score", row["sit_ups_score"]);
                        d.Add("push_ups", row["push_ups"]);
                        d.Add("push_ups_score", row["push_ups_score"]);
                        d.Add("run", row["run"]);
                        d.Add("run_score", row["run_score"]);
                        d.Add("date", row["date"]);
                        d.Add("center_code", row["center_code"]);
                        d.Add("result", "222");
                        d.Add("status", row["status"].ToString().Replace("1", "2"));  // 現報處理
                        d.Add("memo", row["memo"]);
                        d_Del.Add("id", row["id"]);
                        d_Del.Add("date", row["date"]);
                        d_Del.Add("status", row["status"].ToString().Replace("1", "2"));  
                        list.Add(d);
                        list_Del.Add(d_Del);
                    }//現場報名:Upadte Player's birth , 如果總部此人員無註冊資料 , 則生日無法更新
                    //2017-3-7人工鑑測一天只能存在一筆資料，所以要先刪掉原有的
                    main.executeNonQueryByText("delete Result where id=@id and date=@date", list);
                    main.executeNonQueryByText("insert into result (id,name,age,birth,gender,unit_code,rank_code,sit_ups,sit_ups_score,push_ups,push_ups_score,run,run_score,date,center_code,result,status,memo) values (@id,@name,@age,@birth,@gender,@unit_code,@rank_code,@sit_ups,@sit_ups_score,@push_ups,@push_ups_score,@run,@run_score,@date,@center_code,@result,@status,@memo)", list);  
                    main.executeNonQueryByText("update player set birth = @birth where id = @id", list);
                    main.executeNonQueryBysp(@"Ex104_DelThisYearReserver", list_Del);  
                    //main.executeNonQueryByText("Delete From Result where id = @id and status = '103'", list);
                    //if (row["status"].ToString() == "102")
                    //{
                    //    main.executeNonQueryByText("insert into result (id,name,age,birth,gender,unit_code,rank_code,sit_ups,sit_ups_score,push_ups,push_ups_score,run,run_score,date,center_code,result,status,memo) values (@id,@name,@age,@birth,@gender,@unit_code,@rank_code,@sit_ups,@sit_ups_score,@push_ups,@push_ups_score,@run,@run_score,@date,@center_code,@result,@status,@memo)", list);  
                    //}
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

}
