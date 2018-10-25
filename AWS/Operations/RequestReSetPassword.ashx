<%@ WebHandler Language="C#" Class="RequestReSetPassword" %>

using System;
using System.Web;
using Lib;
public class RequestReSetPassword : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Lib.URLToken Token = new URLToken();
        try
        {
            string Msg = string.Empty;
            bool IsVerify = Token.VerifyToken(context.Request.Params["ID"].ToString(), context.Request.Params["Token"].ToString(), DateTime.Now, ref Msg);
            if (IsVerify)
            {
                Lib.Player player = new Lib.Player();
                player.ID = context.Request.Params["ID"].ToString();
                player.IsCanReSetPassword = true;
                context.Session["player"] = player;
                context.Response.Redirect("~/NewPassword.aspx", false);
            }
            else
            {
                context.Session.Clear();
                context.Response.Redirect("~/InVaildRedirect.html?Msg=" + Msg, false);
                
            }        
        }        
        catch(Exception ex)
        {
            
        }      
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}