using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Net.Mail;
using System.IO;
using System.Net;
using System.Data;


public partial class ReSetpw : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        DataTable dt = new DataTable();
        try
        {
            dt = du.getDataTableByText("select info from Contact");
            if (dt.Rows.Count == 1)
            {
                information.Text = dt.Rows[0]["info"].ToString();
            }
        }
        catch
        { 
            
        }
    }
    protected void submit_Click(object sender, EventArgs e)
    {
        StreamReader _MailContentToUser = null;
        try
        {
            Player p = new Player(txtName.Text.Trim(), txtPwd.Text.Trim(), "mail");
            if (p.IsValid)
            {
                    /*
                    MailAddress from = new MailAddress("jiaming0508@gmail.com", "國軍基本體能鑑測網");
                    MailAddress to = new MailAddress("jiaming0508@gmail.com");
                    MailMessage _MailToUser = new MailMessage(from, to);
                     * */
                    #region 通知受測人員
                    string cwd = System.IO.Directory.GetCurrentDirectory();
                    string dd = Server.MapPath(Request.ApplicationPath);

                    MailMessage _MailToUser = new MailMessage();
                    _MailContentToUser = new StreamReader(dd + "\\Mail\\ReSetPasswordByUser.txt");
                    Lib.URLToken Token = new URLToken();
                    string TokenURL = Token.GenToken(p.ID, DateTime.Now);
                    _MailToUser.Body = _MailContentToUser.ReadToEnd();
                    _MailToUser.Body = _MailToUser.Body.Replace("%id%", p.ID);
                    _MailToUser.Body = _MailToUser.Body.Replace("%URLToken%", TokenURL);
                    _MailToUser.Body = _MailToUser.Body.Replace("%date%", System.DateTime.Now.ToString());
                    Lib.SysSetting.SaveLetter(p.Mail + "@webmail.mil.tw", "國軍基本體能鑑測網", _MailToUser.Body, "重設密碼函", "00");

                    /*
                    _MailToUser.Subject = "重設密碼函";
                    _MailToUser.SubjectEncoding = System.Text.Encoding.UTF8;
                    _MailToUser.IsBodyHtml = true;
                    _MailToUser.BodyEncoding = System.Text.Encoding.UTF8;//郵件內容編碼   
                    _MailToUser.Priority = MailPriority.Normal;//郵件優先級   

                    SmtpClient client = new SmtpClient();
                    client.Host = "smtp.gmail.com";
                    client.Port = 587;
                    client.Credentials = new NetworkCredential("jiaming0508@gmail.com", "angel540");
                    client.EnableSsl = true;
                    client.Send(_MailToUser);
                    client.SendCompleted += client_SendCompleted;
                     * */
                    #endregion
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('已寄送重設密碼函至個人信箱!!!')", true);
                    Msg.Style.Value = "color:blue";
                    Msg.InnerText = "重設密碼函已傳送至您的個人信箱!";
                    txtPwd.Text = string.Empty;
                    _MailContentToUser.Close();
                    _MailContentToUser.Dispose();
            }
            else
            {
                txtPwd.Text = "";
                Msg.Style.Value = "color:red";
                Msg.InnerText = "帳號與E-Mail驗證失敗!";
            }
        }
        catch (Exception ex)
        {
            _MailContentToUser.Close();
            _MailContentToUser.Dispose();
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            Msg.Style.Value = "color:red";
            Msg.InnerText = "資料輸入錯誤!";
        }
    }

    void client_SendCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
    {
        if (e.Error != null)
        {
            Msg.Style.Value = "color:red";
            Msg.InnerText = e.Error.ToString();   
        }
        else
        {
            Msg.Style.Value = "color:blue";
            Msg.InnerText = "重設密碼函已完成傳送!";   
        } 
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
