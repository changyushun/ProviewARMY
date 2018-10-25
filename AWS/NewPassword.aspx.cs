using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReSetPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //User_ID.Text = Request.Params["ID"].ToString();
        if (Session["player"] != null)
        {
            Lib.Player player = (Lib.Player)Session["player"];
            if (!player.IsCanReSetPassword)
            {
                //如果Session不對的話, 重新導到哪一頁.
                Response.Redirect("Login.aspx");
            }
            else
            {
                if (!player.IsMustReSetPassword)
                {
                    User_ID.Text = player.ID;
                    txtMail.Visible = false;
                    Label4.Visible = false;
                    Label5.Visible = false;
                }
                else
                {
                    User_ID.Text = player.ID;
                    txtMail.Text = player.Mail;
                    txtMail.Visible = true;
                    Label4.Visible = true;
                    Label5.Visible = true;
                }
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }


    protected void submit_Click(object sender, EventArgs e)
    {
        if (this.IsPostBack)
        {
            Lib.Player player = (Lib.Player)Session["player"];
            if (player.IsCanReSetPassword)
            {
                if (txtPwd.Text.Trim() == txtPwd_Confirm.Text.Trim())
                {
                    if (string.IsNullOrEmpty(Request.Form["hidden_msg_confirm"]) && string.IsNullOrEmpty(Request.Form["hidden_msg"]))
                    {
                        if (!player.IsMustReSetPassword)
                        {
                            //如果Session正確的話, 重新導到哪一頁.
                            //才可以接受變更.
                            Lib.DataUtility du = new Lib.DataUtility();
                            Dictionary<string, object> d = new Dictionary<string, object>();
                            d.Add(@"id", player.ID);
                            d.Add(@"password", txtPwd_Confirm.Text.Trim());
                            du.executeNonQueryBysp(@"Ex105_UpdatePassword", d);
                            Session["player"] = null;
                            Response.Redirect("Redirect.html");
                        }
                        else
                        {
                            //如果Session正確的話, 重新導到哪一頁.
                            //才可以接受變更.
                            Lib.DataUtility du = new Lib.DataUtility();
                            Dictionary<string, object> d = new Dictionary<string, object>();
                            d.Add(@"id", player.ID);
                            d.Add(@"password", txtPwd_Confirm.Text.Trim());
                            d.Add(@"mail", Request.Form["txtMail"].Trim());
                            du.executeNonQueryBysp(@"Ex105_UpdatePasswordnMail", d);
                            Session["player"] = null;
                            Response.Redirect("Redirect.html");
                        }
                    }
                    else
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('密碼不正確');", true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('密碼不一致');", true);
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
                Session.Clear();
            }
        }
    }
}