using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Lib.Account a;
        if (!Page.IsPostBack)
        {
            if (Session["account"] != null)
            {
                
                a = new Lib.Account();
                a = (Lib.Account)Session["account"];
                pwd_HF.Value = a.Password;
                if (a.Role == "1")
                {
                    acc_u.Value = a.AccountName;
                    pwd_u.Value = a.Password;
                    name_u.Value = a.Name;
                    id_u.Value = a.ID;
                    unit_u.Value = a.Unit_Code;
                    unit_value.Value = a.Unit_Code;
                    rank_u.Value = a.Rank_Code;
                    rank_value.Value = a.Rank_Code;
                    tel_u.Value = a.Tel;
                    cell_u.Value = a.CellPhone;
                    ip_u.Value = a.IP;
                    mail_u.Value = a.Mail;
                    iprenew.Visible = false; // admin 直接改自己IP
                }
                if (a.Role == "2")
                {
                    acc_u.Value = a.AccountName;
                    pwd_u.Value = a.Password;
                    name_u.Value = a.Name;
                    id_u.Value = a.ID;
                    //id_u.Disabled = true;
                    unit_u.Value = a.Unit_Code;
                    unit_u.Disabled = true;
                    unit_value.Value = a.Unit_Code;
                    rank_u.Value = a.Rank_Code;
                    //rank_u.Disabled = true;
                    rank_value.Value = a.Rank_Code;
                    tel_u.Value = a.Tel;
                    cell_u.Value = a.CellPhone;
                    ip_u.Value = a.IP;
                    ip_u.Disabled = true; // 帳號管理者IP不能更改，需向系統管理員申請
                    mail_u.Value = a.Mail;
                }
                if (a.Role == "3")
                {
                    this.noneipcheck.Style.Value = "";
                    acc_u.Value = a.AccountName;
                    pwd_u.Value = a.Password;
                    name_u.Value = a.Name;
                    id_u.Value = a.ID;
                    //id_u.Disabled = true;
                    unit_u.Value = a.Unit_Code;
                    unit_u.Disabled = true;
                    unit_value.Value = a.Unit_Code;
                    rank_u.Value = a.Rank_Code;
                    //rank_u.Disabled = true;
                    rank_value.Value = a.Rank_Code;
                    tel_u.Value = a.Tel;
                    cell_u.Value = a.CellPhone;
                    ip_u.Value = a.IP;
                    ip_u.Disabled = true; // 帳號管理者IP不能更改，需向系統管理員申請
                    mail_u.Value = a.Mail;
                }
                SqlDataSource1.SelectParameters["confirmer"].DefaultValue = ((Lib.Account)Session["account"]).AccountName;
            }
        }
        else
        {
            if (submitType.Value == "pwdchange")
            {
                Lib.Account acc = (Lib.Account)Session["account"];
                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                var newPwd = pwd_HF.Value;
                d.Add("password", newPwd);
                d.Add("account", acc.AccountName);
                du.executeNonQueryByText("update account set password = @password where account = @account", d);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('更新成功');", true);
                acc.Password = newPwd;
                pwd_u.Value = newPwd;
                Session["account"] = acc;
                TabContainer1.ActiveTabIndex = 1;
                submitType.Value = "";
            }
            else
            {
                if (this.sender.Value != "iprenew")
                {
                    // update personal info block
                    Lib.DataUtility du = new Lib.DataUtility();
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    if (Session["account"] != null)
                    {
                        d.Add("updater", "self");
                        d.Add("account", acc_u.Value);
                        d.Add("password", pwd_u.Value);
                        d.Add("name", name_u.Value);
                        d.Add("id", id_u.Value);
                        d.Add("unit_code", unit_u.Value);
                        d.Add("rank_code", rank_u.Value);
                        d.Add("tel", tel_u.Value);
                        d.Add("cellphone", cell_u.Value);
                        d.Add("mail", mail_u.Value);
                        d.Add("ip", ip_u.Value);
                        try
                        {
                            du.executeNonQueryBysp("updateaccount", d);
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('更新資料成功');", true);
                            Lib.Account updatedAccount = new Lib.Account(acc_u.Value);
                            Session["account"] = updatedAccount;
                            if (updatedAccount.Role == "1")
                            {
                                acc_u.Value = updatedAccount.AccountName;
                                pwd_u.Value = updatedAccount.Password;
                                name_u.Value = updatedAccount.Name;
                                id_u.Value = updatedAccount.ID;
                                unit_u.Value = updatedAccount.Unit_Code;
                                unit_value.Value = updatedAccount.Unit_Code;
                                rank_u.Value = updatedAccount.Rank_Code;
                                rank_value.Value = updatedAccount.Rank_Code;
                                tel_u.Value = updatedAccount.Tel;
                                cell_u.Value = updatedAccount.CellPhone;
                                ip_u.Value = updatedAccount.IP;
                                mail_u.Value = updatedAccount.Mail;
                                iprenew.Visible = false; // admin 自己改IP
                            }
                            if (updatedAccount.Role == "2")
                            {
                                acc_u.Value = updatedAccount.AccountName;
                                pwd_u.Value = updatedAccount.Password;
                                name_u.Value = updatedAccount.Name;
                                id_u.Value = updatedAccount.ID;
                                unit_u.Value = updatedAccount.Unit_Code;
                                unit_value.Value = updatedAccount.Unit_Code;
                                rank_u.Value = updatedAccount.Rank_Code;
                                rank_value.Value = updatedAccount.Rank_Code;
                                tel_u.Value = updatedAccount.Tel;
                                cell_u.Value = updatedAccount.CellPhone;
                                ip_u.Value = updatedAccount.IP;
                                ip_u.Disabled = true;  // 帳號管理者IP不能更改，需向系統管理員申請
                                mail_u.Value = updatedAccount.Mail;
                            }
                        }
                        catch (Exception ex)
                        {
                            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + ex.Message + "');", true);
                        }
                    }
                }
                if (this.sender.Value == "iprenew")
                {
                    GridView1.DataBind();
                    TabContainer1.ActiveTabIndex = 2;
                }
            }
        }
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[4].Text == "0")
            {
                e.Row.Cells[4].Text = "未通過";
            }
            if (e.Row.Cells[4].Text == "1")
            {
                e.Row.Cells[4].Text = "通過";
            }
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
