<%@ WebHandler Language="C#" Class="Player" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;

public class Player : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);

        string mode = context.Request.Params["mode"];
        string json = string.Empty;
        Lib.DataUtility du = new Lib.DataUtility();
        DataTable dt = new DataTable();
        Dictionary<string, object> d = new Dictionary<string, object>();
        if (mode == "add")
        {
            string _gender = "";
            if(context.Request.Params["id"].Trim().Length > 0)
            {
                char[] gender = context.Request.Params["id"].Trim().ToCharArray();
                if (gender[1] == '1')
                {
                    _gender = "M"; 
                }
                else if (gender[1] == '2')
                {
                    _gender = "F";
                }
            }      
            try
            {
                int _age = Lib.SysSetting.ConvertAge(Lib.SysSetting.ToWorldDate(context.Request.Params["birth"].Trim()), System.DateTime.Today);
                if (_age >= 15)
                {
                    d.Add("id", context.Request.Params["id"].Trim());
                    d.Add("gender", _gender);
                    d.Add("birth", (Lib.SysSetting.ToWorldDate(context.Request.Params["birth"].Trim())));
                    d.Add("name", context.Request.Params["name"].Trim());
                    d.Add("unit_code", context.Request.Params["unit_code"].Trim());
                    d.Add("rank_code", context.Request.Params["rank_code"].Trim());
                    d.Add("mail", context.Request.Params["mail"].Trim());
                    d.Add("oversea", "0");
                    d.Add("password", context.Request.Params["password"].Trim());
                    du.executeNonQueryBysp("AddPlayer", d);
                    json = "{\"status\":\"done\"}";
                }
                else
                {
                    json = "{\"status\":\"生日請使用民國格式\"}";
                }
            }
            catch (Exception ex)
            {
                json = "{\"status\":\"" + ex.Message + " \"}";
            }
        }
        if (mode == "find")
        {
            d.Add("id", context.Request.Params["id"]);
            d.Add("oversea", context.Request.Params["oversea"]);
            dt = du.getDataTableByText("select * from player where id = @id and oversea = @oversea", d);
            json = Lib.SysSetting.GetJsonFormatData(dt);

        }

        if (mode == "update")
        {
            d.Add("id", context.Request.Params["id"].Trim());
            d.Add("gender", context.Request.Params["gender"].Trim());
            d.Add("name", context.Request.Params["name"].Trim());
            d.Add("unit_code", context.Request.Params["unit_code"].Trim());
            d.Add("rank_code", context.Request.Params["rank_code"].Trim());
            d.Add("mail", context.Request.Params["mail"].Trim());
            d.Add("oversea", context.Request.Params["oversea"].Trim());
            try
            {
                du.executeNonQueryByText("update player set gender = @gender, name = @name, unit_code = @unit_code, rank_code = @rank_code, mail = @mail,oversea = @oversea where id = @id", d);
                json = "{\"status\":\"done\"}";
            }
            catch (Exception ex)
            {
                json = "{\"status\":\"" + ex.Message + " \"}";
            }

        }

        dt.Dispose();
        d.Clear();
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