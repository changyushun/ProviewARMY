using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        { 
           // to do
           // first load page
        }

    }
    protected void submit_Click(object sender, EventArgs e)
    {
        try
        {
            if (loginType.SelectedValue == "advance")
            {
                Account a = new Account(txtName.Text.Trim(), txtPwd.Text.Trim(), Request.UserHostAddress.ToString());

                // 2010/01/19 edit by angus
                if (a.IsValid)
                {
                    if (a.IsIPLock)
                    {
                        Session["account"] = a;
                        SysSetting.AddLog("登入", a.AccountName, "進階使用者登入成功,登入IP : " + Request.UserHostAddress.ToString(), DateTime.Now);
                        Response.Redirect("~/Index.aspx",false);
                        
                    }
                    else
                    {
                        SysSetting.AddLog("登入", txtName.Text, "進階使用者登入IP錯誤,登入IP : " + Request.UserHostAddress.ToString(), DateTime.Now);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('登入之電腦IP錯誤 !!!')", true);
                        
                    }
                }
                else
                {
                    txtPwd.Text = "";
                    SysSetting.AddLog("登入", txtName.Text, "進階使用者登入密碼驗證失敗,登入IP : " + Request.UserHostAddress.ToString(), DateTime.Now);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('帳號密碼驗證失敗 !!!')", true);
                    
                }
            }
            else if (loginType.SelectedValue == "user")
            {
                Lib.Player player = new Player(txtName.Text.Trim(), txtPwd.Text.Trim(), "password");
                if (player.IsExist)
                {
                    if (player.IsValid)
                    {
                        Session["player"] = player;
                        Lib.SysSetting.AddLog("登入", player.ID, "一般受測人員登入成功,登入IP : " + Request.UserHostAddress.ToString(), DateTime.Now);
                        //Response.Redirect("~/Index.aspx",false);
                        if (player.IsMustReSetPassword == false)
                            Response.Redirect("~/Index.aspx", false);
                        else
                            Response.Redirect("~/NewPassword.aspx", false);
                    }
                    if (!player.IsValid)
                    {
                        txtPwd.Text = "";
                        Lib.SysSetting.AddLog("登入", txtName.Text, "一般受測人員登入失敗,帳號密碼錯誤,登入IP : " + Request.UserHostAddress.ToString(), DateTime.Now);
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('身分證字號或生日錯誤');", true);
                        
                    }
                }
                if (!player.IsExist)
                {
                    txtName.Text = "";
                    txtPwd.Text = "";
                    Lib.SysSetting.AddLog("登入", txtName.Text, "一般受測人員登入失敗,帳號不存在,登入IP : " + Request.UserHostAddress.ToString(), DateTime.Now);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('您輸入的帳號不存在');", true);
                    
                }
            }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            Lib.SysSetting.AddLog("登入", "system", ex.Message + "登入IP : " + Request.UserHostAddress.ToString(), DateTime.Now);
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
