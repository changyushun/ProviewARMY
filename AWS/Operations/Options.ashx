<%@ WebHandler Language="C#" Class="Options" %>

using System;
using System.Web;
using System.Collections.Generic;

public class Options : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        string json = string.Empty;
        
        if (context.Request.Params["mode"] != null)
        {
            string mode = context.Request.Params["mode"];
            Lib.DataUtility du = new Lib.DataUtility();
            System.Data.DataTable dt = new System.Data.DataTable();
            switch (mode)
            { 
                case "find":
                    dt = du.getDataTableBysp("GetOption", "accName", context.Request.Params["accName"]);
                    json = Lib.SysSetting.GetJsonFormatData(dt);
                    dt.Dispose();
                    break;
                case "update":
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    d.Add("accName", context.Request.Params["accName"]);
                    d.Add("option1", context.Request.Params["option1"]);
                    d.Add("option2", context.Request.Params["option2"]);
                    d.Add("option3", context.Request.Params["option3"]);
                    d.Add("option4", context.Request.Params["option4"]);
                    d.Add("option5", context.Request.Params["option5"]);
                    du.executeNonQueryBysp("updateoptions", d);
                    json = "{\"status\":\"done\"}";
                    break;
                default:
                    break;
            }
            context.Response.Write(json);
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}