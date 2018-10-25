 <%@ WebHandler Language="C#" Class="GetValueByCode" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;
using System.Text;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Net.Mail;

public class GetValueByCode : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        if (context.Request.Params["mode"] != null)
        {
            string mode = context.Request.Params["mode"];
            string json = string.Empty;
            Lib.DataUtility du = new Lib.DataUtility();
            System.Data.DataTable dt = new System.Data.DataTable();
            string value = context.Request.Params["value"];
            Dictionary<string, object> d = new Dictionary<string, object>();
            switch (mode)
            {

                case "rank":
                    dt = du.getDataTableBysp("getrank", "rank_code", value);
                    if (dt.Rows.Count == 0)
                    {
                        d.Add("status", "false");
                    }
                    else
                    {
                        d.Add("status", dt.Rows[0]["rank_title"].ToString());
                    }
                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;

                case "center":
                    d.Add("id", value);
                    dt = du.getDataTableByText("select center_name from center where center_code = @id", d);
                    json = Lib.SysSetting.GetJsonFormatData(dt);
                    break;

                case "accExist":
                    dt = du.getDataTableBysp("CheckAccExist", "acc", value);
                    if (dt.Rows[0][0].ToString() == "0")
                    {
                        d.Add("status", "flase");
                    }
                    else
                    {
                        d.Add("status", "true");
                    }
                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;

                case "askaccExist":
                    dt = du.getDataTableBysp("CheckAskExist", "id", value);
                    if (dt.Rows[0][0].ToString() == "0")
                    {
                        d.Add("status", "flase");
                    }
                    else
                    {
                        d.Add("status", "true");
                    }
                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;    

                case "playerExist":
                    dt = du.getDataTableBysp("CheckPlaExist", "id", value);
                    if (dt.Rows[0][0].ToString() == "0")
                    {
                        d.Add("status", "flase");
                    }
                    else
                    {
                        d.Add("status", "true");
                    }
                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;

                case "unit":
                    dt = du.getDataTableBysp("GetUnitName", "unit_code", value);

                    d.Add("status", dt.Rows[0][0].ToString());

                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;
                    
                case "parent_unit":
                    bool isFind = false;
                    DataTable _dt = du.getDataTableByText("select service_code from Unit where unit_code = @unit_code", "unit_code", value);
                    if (_dt.Rows.Count > 0)
                    {
                        dt = du.getDataTableByText("select distinct service_code from Account a , Unit u where a.role_code = @role_code and a.unit_code = u.unit_code", "role_code", "2");
                        foreach (DataRow row in dt.Rows)
                        {
                            if (_dt.Rows[0]["service_code"].ToString() == row["service_code"].ToString())
                            {
                                isFind = true; 
                            }
                        }
                    }
                    if (isFind)
                    {
                        dt = du.getDataTableBysp("GetUnitName", "unit_code", value);
                        d.Add("status", dt.Rows[0][0].ToString());
                    }
                    else
                    {
                        d.Add("status","");
                    }
                    json = Lib.SysSetting.GetJsonFormatData(d);
                    break;
                    
                case "centerLimit":
                    d.Add("center_code", context.Request.Params["center_code"]);
                    string _v = context.Request.Params["date"];
                    string _date = string.Empty;
                    string[] operater = { "/" };
                    string[] info = _v.Split(operater, StringSplitOptions.None);
                    _date = (Convert.ToInt32(info[0]) + 1911).ToString() + "/" + info[1] + "/" + info[2];
                    //try
                    //{
                    //    _date = (Convert.ToInt32(_v.Substring(0, 2)) + 1911).ToString() + _v.Substring(2, _v.Length - 2);
                    //}
                    //catch (Exception ex)
                    //{
                    //    _date = (Convert.ToInt32(_v.Substring(0, 3)) + 1911).ToString() + _v.Substring(3, _v.Length - 3);
                    //}
                    d.Add("date", Convert.ToDateTime(_date));
                    dt = du.getDataTableBysp("GetCenterLimit", d);
                    //json = _date;
                    json = "{\"status\":\"" + dt.Rows[0][0].ToString() + "\"}";
                    break;
                
                case "replaceitem":
                    try
                    {
                        d.Add("center_code", context.Request.Params["center_code"]);
                        dt = du.getDataTableByText("select IsSwin from Center where center_code =@center_code", d);
                        if (Convert.ToBoolean(dt.Rows[0]["IsSwin"]))
                        {
                            d.Clear();
                            d.Add("IsService", true);
                            dt = du.getDataTableByText("select rep_title from RepMent where IsService = @IsService", d);
                        }
                        else
                        {
                            d.Clear();
                            d.Add("IsSwinItem", false);
                            d.Add("IsService", true);
                            dt = du.getDataTableByText("select rep_title from RepMent where IsSwinItem =@IsSwinItem and IsService = @IsService", d);
                        }
                        string _result = "";
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            _result = _result + dt.Rows[i]["rep_title"].ToString() + "<br />";
                        }
                        json = "{\"status\":\"" + _result + "\"}";
                    }
                    catch(Exception ex)
                    {
                        
                    }
                    break;
                    
                case "player" :
                    d.Add("id", value);
                    dt = du.getDataTableByText("select id from player where id = @id", d);
                    if (dt.Rows.Count == 0)
                    {
                        json = "{\"status\":\"none\"}";
                    }
                    else
                    {
                        json = "{\"status\":\"false\"}";
                    }
                    break;
                    
                case "iprenew":
                    try
                    {
                        du.executeNonQueryBysp("iprenew", "apply", value);
                        json = "{\"status\":\"done\"}";
                        
                    }
                    catch (Exception ex)
                    {
                        json = "{\"status\":\"" + ex.Message + "\"}";
                    }
                    break;
                    
                case "deletesch":
                    try
                    {
                        du.executeNonQueryByText("delete daterule where sid = @sid", "sid", value);
                        Lib.SysSetting.AddLog("鑑測站", context.Request.Params["op_id"], "日期規則被刪除", DateTime.Now);
                        json = "{\"status\":\"done\"}";
                    }

                    catch (Exception ex)
                    {
                        json = "{\"status\":\"" + ex.Message + "\"}";
                    }
                    break;
                case "changelimit":
                    try
                    {
                        du.executeNonQueryByText("update center set limit = " + value + " where center_code = '" + context.Request.Params["sid"] + "'");
                        Lib.SysSetting.AddLog("鑑測站", context.Request.Params["who"], " 鑑測站 (代碼 " + context.Request.Params["sid"] + ") 人數限制被更改為 " + value , DateTime.Now);
                        json = "{\"status\":\"done\"}";
                    }
                    catch (Exception ex)
                    {
                        json = "{\"status\":\"" + ex.Message + "\"}";
                    }
                    break;
                case "setCenterlimit":
                    try
                    {
                        //du.executeNonQueryByText("update center set limit = " + value + " where center_code = '" + context.Request.Params["sid"] + "'");
                        //Lib.SysSetting.AddLog("鑑測站", context.Request.Params["who"], " 鑑測站 (代碼 " + context.Request.Params["sid"] + ") 人數限制被更改為 " + value, DateTime.Now);
                        string center_code = context.Request.Params["sid"];
                        string limit = context.Request.Params["limit"];
                        string[] lines = context.Request["date"].Split(new string[] { @"/" }, StringSplitOptions.None);
                        string date = (1911 + Convert.ToInt32(lines[0])).ToString() + "-" + lines[1] + "-" + lines[2];
                        Dictionary<string, object> list = new Dictionary<string, object>();
                        list.Add("date", date);
                        list.Add("center_code", center_code);
                        list.Add("limit", limit);
                        du.executeNonQueryBysp("Ex102_SetCenterLimit", list);
                        
                        
                        json = "{\"status\":\"done\"}";
                    }
                    catch (Exception ex)
                    {
                        json = "{\"status\":\"" + ex.Message + "\"}";
                    }
                    break;
                case "changestatus":
                    try
                    {
                        Dictionary<string, object> list = new Dictionary<string, object>();
                        list.Add("center_code",  context.Request.Params["sid"]);
                        du.executeNonQueryBysp("Ex103_SetCenterStatus", list);
                        Lib.SysSetting.AddLog("鑑測站", context.Request.Params["who"], " 鑑測站 (代碼 " + context.Request.Params["sid"] + ") 狀態已變更 ", DateTime.Now);
                        json = "{\"status\":\"done\"}";
                    }
                    catch (Exception ex)
                    {
                        json = "{\"status\":\"" + ex.Message + "\"}";
                    }
                    break;
                case "changeswin":
                    try
                    {
                        Dictionary<string, object> list = new Dictionary<string, object>();
                        list.Add("center_code", context.Request.Params["sid"]);
                        du.executeNonQueryBysp("Ex103_SetCenterSwin", list);
                        Lib.SysSetting.AddLog("鑑測站", context.Request.Params["who"], " 鑑測站 (代碼 " + context.Request.Params["sid"] + ") 游泳池狀態已變更 ", DateTime.Now);
                        json = "{\"status\":\"done\"}";
                    }
                    catch (Exception ex)
                    {
                        json = "{\"status\":\"" + ex.Message + "\"}";
                    }
                    break;        
                case "queryplayerbyresetpassword":
                    try
                    {
                        d.Add("id", context.Request.Params["id"]);
                        dt = du.getDataTableBysp(@"Ex105_QueryPlyerByReSetPassword", d);
                        d.Clear();
                        if (dt.Rows.Count == 1)
                        {
                            d.Add("status", "true");
                            d.Add("name", dt.Rows[0]["name"].ToString());
                            d.Add("id", dt.Rows[0]["id"].ToString());
                            d.Add("unit", dt.Rows[0]["unit"].ToString());
                            d.Add("rank", dt.Rows[0]["rank"].ToString());
                            d.Add("mail", dt.Rows[0]["mail"].ToString());
                        }
                        else
                        {
                            d.Add("status", "false");
                        }
                        json = Lib.SysSetting.GetJsonFormatData(d);            
                    }
                    catch (Exception ex)
                    {
                        d.Add("status", ex.Message); ;
                        json = Lib.SysSetting.GetJsonFormatData(d);
                    }
                    break;
                case "updatemail":
                    try
                    {
                        d.Add("id", context.Request.Params["id"]);
                        d.Add("mail", context.Request.Params["mail"]);
                        du.executeNonQueryBysp(@"Ex105_UpdateMailByID", d);
                        d.Clear();
                        d.Add("status", "true");
                        json = Lib.SysSetting.GetJsonFormatData(d);
                    }
                    catch (Exception ex)
                    {
                        d.Add("status", ex.Message); ;
                        json = Lib.SysSetting.GetJsonFormatData(d);
                    }
                    break;
                case "SendMail":
                    StreamReader _MailContentToUser = null;
                    try
                    {
                        /*
                        MailAddress from = new MailAddress("jiaming0508@gmail.com", "國軍基本體能鑑測網");
                        MailAddress to = new MailAddress("jiaming0508@gmail.com");
                         MailMessage _MailToUser = new MailMessage(from, to);
                        */
                        #region 通知受測人員
                        string cwd = System.IO.Directory.GetCurrentDirectory();
                        //string dd = Microsoft.SqlServer.Server.MapPath(Request.ApplicationPath);
                        string dd = context.Server.MapPath(context.Request.ApplicationPath);
                        if (!string.IsNullOrEmpty(context.Request.Params["mail"]))
                        {
                            MailMessage _MailToUser = new MailMessage();
                            _MailContentToUser = new StreamReader(dd + "\\Mail\\ReSetPasswordByManger.txt");
                            Lib.URLToken Token = new Lib.URLToken();
                            string TokenURL = Token.GenToken(context.Request.Params["id"], DateTime.Now);
                            _MailToUser.Body = _MailContentToUser.ReadToEnd();
                            _MailToUser.Body = _MailToUser.Body.Replace("%id%", context.Request.Params["id"]);
                            _MailToUser.Body = _MailToUser.Body.Replace("%URLToken%", TokenURL);
                            _MailToUser.Body = _MailToUser.Body.Replace("%date%", System.DateTime.Now.ToString());
                            Lib.SysSetting.SaveLetter(context.Request.Params["mail"] + "@webmail.mil.tw", "國軍基本體能鑑測網", _MailToUser.Body, "重設密碼函", "00");
                        }
                        else
                        {
                            d.Add("status", "Mail帳號錯誤, 請重新搜尋"); ;
                            json = Lib.SysSetting.GetJsonFormatData(d);
                        }
                    
                        /*
                       _MailToUser.Subject = "重設密碼函";
                       _MailToUser.SubjectEncoding = System.Text.Encoding.UTF8;
                       _MailToUser.IsBodyHtml = true;
                       _MailToUser.BodyEncoding = System.Text.Encoding.UTF8;//郵件內容編碼   
                       _MailToUser.Priority = MailPriority.Normal;//郵件優先級   

                       
                       SmtpClient client = new SmtpClient();
                       client.Host = "smtp.gmail.com";
                       client.Port = 587;
                       client.Credentials = new System.Net.NetworkCredential("jiaming0508@gmail.com", "angel540");
                       client.EnableSsl = true;
                       client.Send(_MailToUser);*/
                        #endregion
                        d.Add("status", "true");
                        json = Lib.SysSetting.GetJsonFormatData(d);
                    }
                    catch (Exception ex)
                    {
                        d.Add("status", ex.Message); ;
                        json = Lib.SysSetting.GetJsonFormatData(d);
                        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                    }
                    finally
                    {
                        _MailContentToUser.Close();
                        _MailContentToUser.Dispose();
                    }
                    break;          
                default:
                    break;           
            }

            d.Clear();
            dt.Dispose();
            context.Response.Write(json);
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