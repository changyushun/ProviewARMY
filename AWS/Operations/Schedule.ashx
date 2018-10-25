<%@ WebHandler Language="C#" Class="Schedule" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Data;


public class Schedule : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        TaiwanCalendar tc = new TaiwanCalendar();
        CultureInfo ci = new CultureInfo("zh-TW");
        ci.DateTimeFormat.Calendar = tc;
        ci.DateTimeFormat.YearMonthPattern = "民國yy年MM月";
        ci.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Monday;
        Thread.CurrentThread.CurrentCulture = ci;
        string json = string.Empty;
        if (context.Request.Params["mode"] != null)
        {
            string mode = context.Request.Params["mode"];
            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            switch (mode)
            {
                case "add":

                    d.Add("center_code", context.Request.Params["center_code"]);
                    d.Add("op_id", "admin");
                    //d.Add("mode", Convert.ToInt16(context.Request.Params["type"]));
                    d.Add("date", Convert.ToDateTime(context.Request.Params["date"]));
                    d.Add("note", context.Request.Params["note"]);
                    d.Add("log", DateTime.Now);
                    

                    du.executeNonQueryBysp("Ex107_addDateRule", d);//設定工作日關閉及假日開放的sp
                    Lib.SysSetting.AddLog("鑑測站", context.Request.Params["op_id"], "鑑測站 (代碼" + context.Request.Params["center_code"] + ") 新增日期規則", DateTime.Now);
                    d.Clear();
                    d.Add("status", "done");
                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;
                case "delete":
                    int sid = Convert.ToInt16(context.Request.Params["sid"]);
                    du.executeNonQueryBysp("DeleteDateRule", "sid", sid);
                    Lib.SysSetting.AddLog("鑑測站", context.Request.Params["op_id"], "鑑測站 (代碼" + context.Request.Params["center_code"] + ") 刪除日期規則", DateTime.Now);
                    d.Add("status", "done");
                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;
                case "offstation":
                    d.Add("center_code", context.Request.Params["center_code"]);
                    d.Add("date", context.Request.Params["date"]);
                    DataTable dt = new DataTable();
                    dt = du.getDataTableBysp("Ex107_GetWeekSetDay", d);
                    if (dt.Rows.Count > 0)//刪除
                    {
                        d.Clear();
                        int sid1 = Convert.ToInt32(dt.Rows[0]["sid"].ToString());
                        du.executeNonQueryBysp("DeleteDateRule", "sid", sid1);
                        Lib.SysSetting.AddLog("鑑測站", context.Request.Params["op_id"], "鑑測站 (代碼" + context.Request.Params["center_code"] + ") 刪除日期規則", DateTime.Now);
                        d.Add("status", "done");
                        json = Lib.SysSetting.GetJsonFormatData(d);
                    }
                    else//新增
                    {
                        d.Add("op_id", "admin");
                        d.Add("note", context.Request.Params["note"]);
                        d.Add("log", DateTime.Now);
                        du.executeNonQueryBysp("Ex107_addDateRule", d);//設定工作日關閉及假日開放的sp
                        Lib.SysSetting.AddLog("鑑測站", context.Request.Params["op_id"], "鑑測站 (代碼" + context.Request.Params["center_code"] + ") 新增日期規則", DateTime.Now);
                        d.Clear();
                        d.Add("status", "done");
                        json = Lib.SysSetting.GetJsonFormatData(d);
                    }
                    break;
                default:
                    break;
            }
        }

        context.Response.Write(json);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}