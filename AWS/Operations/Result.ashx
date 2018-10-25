<%@ WebHandler Language="C#" Class="Result" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;



public class Result : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        if (context.Request.Params["type"] != null)
        {

            string type = context.Request.Params["type"];
            Lib.UnitTree Tree = new Lib.UnitTree();
            DataTable dt = new DataTable();
            string index = context.Request.Params["index"];
            if (index == "1")
            {   
                // 第一個都是只查該單位
                dt.Columns.Add("unit_code");
                DataRow row = dt.NewRow();
                row[0] = context.Request.Params["unit_code"];
                dt.Rows.Add(row);
            }
            else
            {
                // 其餘的都是查該單位以下的(含自己)
                dt = Tree.GetUnitWithChild(context.Request.Params["unit_code"]).ChildUnitCodeTable;
            }
            switch (type)
            {

                case "item":
                    d.Add("type", type);
                    d.Add("unit_code", context.Request.Params["unit_code"]);
                    d.Add("date_start", Lib.SysSetting.ToWorldDate(context.Request.Params["date_start"]));
                    d.Add("date_stop", Lib.SysSetting.ToWorldDate(context.Request.Params["date_stop"]));
                    d.Add("rank", "");
                    d.Add("age_s", 0);
                    d.Add("age_e", 0);
                    DataSet ds_item = du.getDataSet("GetResultByUnit", d, "tempTable", dt);

                    // Get Male Data
                    string result1_item = Lib.SysSetting.GetJsonFormatData(ds_item.Tables[0]);
                    result1_item = result1_item.Substring(0, result1_item.Length - 1);
                    
                    // Get Female Data
                    string result2_item = Lib.SysSetting.GetJsonFormatData(ds_item.Tables[1]);
                    result2_item = result2_item.Substring(1, result2_item.Length - 1);

                    context.Response.Write(result1_item + "," + result2_item);
                    break;

                case "age":
                    d.Add("type", type);
                    d.Add("unit_code", context.Request.Params["unit_code"]);
                    d.Add("date_start", Lib.SysSetting.ToWorldDate(context.Request.Params["date_start"]));
                    d.Add("date_stop", Lib.SysSetting.ToWorldDate(context.Request.Params["date_stop"]));
                    d.Add("rank", "");
                    string[] spliter = new string[]{"-"};
                    string[] age = context.Request.Params["age"].Split(spliter, StringSplitOptions.None);
                    d.Add("age_s", Convert.ToInt32(age[0]));
                    d.Add("age_e", Convert.ToInt32(age[1]));
                    DataSet ds_age = du.getDataSet("GetResultByUnit", d, "tempTable", dt);

                    // Get Male Data
                    string result1_age = Lib.SysSetting.GetJsonFormatData(ds_age.Tables[0]);
                    result1_age = result1_age.Substring(0, result1_age.Length - 1);

                    // Get Female Data
                    string result2_age = Lib.SysSetting.GetJsonFormatData(ds_age.Tables[1]);
                    result2_age = result2_age.Substring(1, result2_age.Length - 1);

                    context.Response.Write(result1_age + "," + result2_age);
                    break;
                    
                case "rank":
                    d.Add("type", type);
                    d.Add("unit_code", context.Request.Params["unit_code"]);
                    d.Add("date_start", Lib.SysSetting.ToWorldDate(context.Request.Params["date_start"]));
                    d.Add("date_stop", Lib.SysSetting.ToWorldDate(context.Request.Params["date_stop"]));
                    d.Add("rank", context.Request.Params["rank"]);
                    d.Add("age_s", 0);
                    d.Add("age_e", 0);
                    DataSet ds_rank = du.getDataSet("GetResultByUnit", d, "tempTable", dt);

                    // Get Male Data
                    string result1_rank = Lib.SysSetting.GetJsonFormatData(ds_rank.Tables[0]);
                    result1_rank = result1_rank.Substring(0, result1_rank.Length - 1);
                    
                    // Get Female Data
                    string result2_rank = Lib.SysSetting.GetJsonFormatData(ds_rank.Tables[1]);
                    result2_rank = result2_rank.Substring(1, result2_rank.Length - 1);

                    context.Response.Write(result1_rank + "," + result2_rank);
                    break;

                default:
                    break;
            }
        }


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}