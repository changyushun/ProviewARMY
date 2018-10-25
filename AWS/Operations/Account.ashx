<%@ WebHandler Language="C#" Class="Account" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;


public class Account : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);

        string mode = context.Request.Params["mode"];
        string json = string.Empty;
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        

        if (mode == "add")
        {
            d.Add("account", context.Request.Params["acc"]);
            d.Add("password", context.Request.Params["pwd"]);
            d.Add("role_code", context.Request.Params["role_code"]);
            d.Add("name", context.Request.Params["name"]);
            d.Add("id", context.Request.Params["id"]);
            d.Add("unit_code", context.Request.Params["unit"]);
            d.Add("rank_code", context.Request.Params["rank"]);
            d.Add("tel", context.Request.Params["tel"]);
            d.Add("cellphone", context.Request.Params["cell"]);
            d.Add("mail", context.Request.Params["mail"]);
            d.Add("ip", context.Request.Params["ip"]);
            d.Add("pwdChange", "0");
            d.Add("status", "1");
            d.Add("byacc", context.Request.Params["byacc"]);
            du.executeNonQueryBysp("AddAccount", d);
            Lib.SysSetting.AddLog("帳號管理", context.Request.Params["byacc"], context.Request.Params["acc"] + " 帳號資料被建立", DateTime.Now);
            Dictionary<string, object> o = new Dictionary<string, object>();
            if (context.Request.Params["option1"] != null && context.Request.Params["option1"] == "true")
            {
                o.Add("acc", context.Request.Params["acc"]);
                o.Add("optionCode", "1");
                du.executeNonQueryBysp("AddOptions", o);
                o.Clear();
            }
            if (context.Request.Params["option2"] != null && context.Request.Params["option2"] == "true")
            {
                o.Add("acc", context.Request.Params["acc"]);
                o.Add("optionCode", "2");
                du.executeNonQueryBysp("AddOptions", o);
                o.Clear();
            }
            if (context.Request.Params["option3"] != null && context.Request.Params["option3"] == "true")
            {
                o.Add("acc", context.Request.Params["acc"]);
                o.Add("optionCode", "3");
                du.executeNonQueryBysp("AddOptions", o);
                o.Clear();
            }
            if (context.Request.Params["option4"] != null && context.Request.Params["option4"] == "true")
            {
                o.Add("acc", context.Request.Params["acc"]);
                o.Add("optionCode", "4");
                du.executeNonQueryBysp("AddOptions", o);
                o.Clear();
            }
            if (context.Request.Params["option5"] != null && context.Request.Params["option5"] == "true")
            {
                o.Add("acc", context.Request.Params["acc"]);
                o.Add("optionCode", "5");
                du.executeNonQueryBysp("AddOptions", o);
                o.Clear();
            }
            json = "{\"status\" : \"done\"}";
        }

        if(mode == "ask")
        {
            try
            {
                d.Add("id", context.Request.Params["id"]);
                d.Add("name", context.Request.Params["name"]);
                d.Add("unit_code", context.Request.Params["unit_code"]);
                d.Add("rank_code", context.Request.Params["rank_code"]);
                d.Add("tel", context.Request.Params["tel"]);
                d.Add("cellphone", context.Request.Params["cellphone"]);
                d.Add("mail", context.Request.Params["mail"]);
                d.Add("ip", context.Request.Params["ip"]);
                du.executeNonQueryBysp("AddAskAccount", d);
                json = "{\"status\":\"done\"}";
            }
            catch (Exception ex)
            {
                json = "{\"status\":\"" + ex.Message + " \"}";
            }
        }
         
        if (mode == "find")
        {
            string type = context.Request.Params["type"];
            string value = context.Request.Params["value"];
            string role = context.Request.Params["role"];
            DataTable dt = new DataTable();
            Dictionary<string,object> list = new Dictionary<string,object>();
            if (type == "acc")
            {
                list.Add("type","acc");
                list.Add("value",value);
                dt = du.getDataTableBysp("GetAccount", list);
            }
            if (type == "role2")
            {
                list.Add("type", "role2");
                list.Add("value", value);
                dt = du.getDataTableBysp("GetAccount", list);
            }
            if (type == "role3")
            {
                list.Add("type", "role3");
                list.Add("value", value);
                dt = du.getDataTableBysp("GetAccount", list);
            }
            if (type == "id")
            {
                list.Add("type", "id");
                list.Add("value", value);
                dt = du.getDataTableBysp("GetAccount", list);
            }
            if (dt.Rows.Count == 1)
            {
                json = Lib.SysSetting.GetJsonFormatData(dt);
            }
            if (dt.Rows.Count == 0)
            {
                json = "{\"error\":\"沒有資料\"}";
            }
            else if (dt.Rows.Count != 1 && dt.Rows.Count != 0) 
            {
                json = "{\"error\":\"筆數錯誤\"}";
            }
            dt.Dispose();
        }

        if (mode == "update")
        {
            d.Add("updater", context.Request.Params["updater"]);
            d.Add("account",context.Request.Params["account"]);
            d.Add("password", context.Request.Params["password"]);
            d.Add("name", context.Request.Params["name"]);
            d.Add("id", context.Request.Params["id"]);
            d.Add("unit_code", context.Request.Params["unit_code"]);
            d.Add("rank_code", context.Request.Params["rank_code"]);
            d.Add("tel", context.Request.Params["tel"]);
            d.Add("cellphone", context.Request.Params["cellphone"]);
            d.Add("mail", context.Request.Params["mail"]);
            d.Add("ip", context.Request.Params["ip"]);
            du.executeNonQueryBysp("updateaccount", d);
            
            Lib.SysSetting.AddLog("帳號管理", context.Request.Params["updater"], context.Request.Params["account"] + " 帳號資料被更改", DateTime.Now);
            json = "{\"status\":\"done\"}";
        
        }
        if (mode == "delete")
        {
            d.Add("account", context.Request.Params["account"]);
            du.executeNonQueryBysp("DelAccount", d);
            Lib.SysSetting.AddLog("帳號管理", context.Request.Params["updater"], context.Request.Params["account"] + " 帳號被刪除", DateTime.Now);
            json = "{\"status\":\"done\"}";
        }
        
        context.Response.Write(json);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}