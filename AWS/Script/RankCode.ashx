<%@ WebHandler Language="C#" Class="RankCode" %>

using System;
using System.Web;
using System.Data;

public class RankCode : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        DataTable dt = new DataTable();
        Lib.DataUtility du = new Lib.DataUtility();
        dt = du.getDataTableBysp("getrank", "rank_code", "all");
        string script = string.Empty;
        script += "function rankObj (v1,v2){this.rank_code = v1;this.rank_title = v2;}";
        script += "var ranks = new Array();";
        foreach (DataRow row in dt.Rows)
        {
            script += "ranks.push(new rankObj('" + row["rank_code"] + "','" + row["rank_title"] + "'));";
        }
        script += "function GetRank(v){";
        script += "for (var i = 0; i < ranks.length; i++){";
        script += "if (ranks[i].rank_code == v){";
        script += "var rank = ranks[i].rank_title;";
        script += "return rank;";
        script += "}}}";
        context.Response.Write(script);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}