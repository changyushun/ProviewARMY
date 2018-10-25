using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Net.Mail;
using System.IO;


public partial class ReSetpw : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void submit_Click(object sender, EventArgs e)
    {
        try
        {      
                Account a = new Account(txtName.Text.Trim(), txtPwd.Text.Trim(), Request.UserHostAddress.ToString(),"resetpw");
                // 2010/01/19 edit by angus
                if (a.IsValid)
                {
                    if (a.IsIPLock)
                    {
                        //RandomPassword tt = new RandomPassword
                        RandomPassword pw = new RandomPassword(8,16);
                        string Password = pw.PassWord;
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        DataUtility du = new DataUtility();
                        d.Add("password", Password);
                        d.Add("account", a.AccountName);
                        du.executeNonQueryByText("update Account set password = @password where account = @account", d);

                        #region 通知受測人員
                        string cwd = System.IO.Directory.GetCurrentDirectory();
                        string dd = Server.MapPath(Request.ApplicationPath);
                        MailMessage _MailToUser = new MailMessage();
                        StreamReader _MailContentToUser = new StreamReader(dd + "\\Mail\\ReSetPassword.txt");
                        _MailToUser.Body = _MailContentToUser.ReadToEnd();
                        _MailToUser.Body = _MailToUser.Body.Replace("%password%", Password);
                        Lib.SysSetting.SaveLetter(a.Mail + "@webmail.mil.tw", "國軍基本體能鑑測網", _MailToUser.Body, "變更密碼通知信", "00");
                        #endregion
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('已寄送新密碼至個人信箱!!!')", true);
                        //Session["account"] = a;
                        //Response.Redirect("~/Index.aspx");
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('登入之電腦IP錯誤 !!!')", true);
                    }
                }
                else
                {
                    txtPwd.Text = "";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('帳號與E-Mail驗證失敗 !!!')", true);
                }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('資料輸入錯誤');", true);
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
