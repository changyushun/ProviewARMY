using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.IO;
using System.Data;

public partial class CheckAdvancedUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Lib.Account acc = (Lib.Account)Session["account"];
            if (acc.Role == "2")
            {
                SqlDataSource1.SelectParameters["service_code"].DefaultValue = acc.Service_Code;
            }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Lib.Account a = (Lib.Account)Session["account"];
        if (a.Role == "2")
        {
            try
            {
                int index = GridView1.SelectedIndex;
                GridViewRow row = GridView1.Rows[index];
                sid.Text = row.Cells[0].Text;
                acc.Text = row.Cells[3].Text;
                id.Text = row.Cells[1].Text;
                unit_code.Text = row.Cells[3].Text;
                name.Text = row.Cells[2].Text;
                rank_code.Text = row.Cells[4].Text;
                tel.Text = row.Cells[6].Text;
                mail.Text = row.Cells[5].Text;
                cellphone.Text = row.Cells[7].Text;
                ip.Text = row.Cells[8].Text;
                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("unit_code", row.Cells[3].Text.Trim());
                d.Add("rank_code", row.Cells[4].Text.Trim());
                DataTable dt = du.getDataTableByText("select unit_title,(select rank_title from Rank where rank_code = @rank_code) As rank_title from Unit where unit_code = @unit_code", d);
                unit_code_name.Text = dt.Rows[0]["unit_title"].ToString();
                rank_code_name.Text = dt.Rows[0]["rank_title"].ToString();
            }
            catch (Exception ex)
            {
                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            }
        }
    }

    protected void AddAcc_Click(object sender, EventArgs e)
    {
        Lib.Account a = (Lib.Account)Session["account"];
        if (a.Role == "2")
        {
            if (password.Text.Length > 0 && acc_random.Text.Length > 0)
            {
                try
                {
                    Lib.DataUtility du = new Lib.DataUtility();
                    DataTable dt = du.getDataTableBysp("CheckAccExist", "acc", acc.Text + acc_random.Text);
                    if (dt.Rows[0][0].ToString() == "0")
                    {    
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        //Lib.DataUtility du = new Lib.DataUtility();
                        int index = GridView1.SelectedIndex;
                        GridViewRow row = GridView1.Rows[index];
                        d.Add("sid", sid.Text);
                        d.Add("account", acc.Text + acc_random.Text);
                        d.Add("acc", a.AccountName);
                        d.Add("password", password.Text);
                        du.executeNonQueryBysp("InsertAccByAsk", d);
                        d.Clear();
                        d.Add("sid", sid.Text);
                        du.executeNonQueryByText("delete from AskAccount where sid = @sid", d);
                        d.Clear();
                        d.Add("acc", acc.Text + acc_random.Text);
                        d.Add("optionCode", "1");
                        du.executeNonQueryBysp("AddOptions", d);

                        #region 通知申請者
                        string cwd = System.IO.Directory.GetCurrentDirectory();
                        string dd = Server.MapPath(Request.ApplicationPath);
                        MailMessage _MailToUser = new MailMessage();
                        StreamReader _MailContentToUser = new StreamReader(dd + "\\Mail\\CheckAdvancedUser.txt");
                        //_MailToUser.Body = _MailContent.ReadToEnd().Replace("%detail%", _detailtable);
                        _MailToUser.Body = _MailContentToUser.ReadToEnd();
                        _MailToUser.Body = _MailToUser.Body.Replace("%account%", acc.Text + acc_random.Text);
                        _MailToUser.Body = _MailToUser.Body.Replace("%password%", password.Text);
                        Lib.SysSetting.SaveLetter(mail.Text + "@webmail.mil.tw", "國軍基本體能鑑測網", _MailToUser.Body, "團體報進負責人申請成功通知信", "00");
                        Lib.SysSetting.AddLog("審核帳號", a.AccountName, "新增團體報進帳號:" + acc.Text + acc_random.Text, DateTime.Now);
                        #endregion

                        acc.Text = "";
                        acc_random.Text = "";
                        password.Text = "";
                        sid.Text = "";
                        id.Text = "";
                        unit_code.Text = "";
                        name.Text = "";
                        rank_code.Text = "";
                        tel.Text = "";
                        mail.Text = "";
                        cellphone.Text = "";
                        ip.Text = "";
                        GridView1.DataBind();
                        this.accexist.Style.Value = "display:none";
                        this.error.Style.Value = "display:none";
                        this.success.Style.Value = "";
                    }
                    else
                    {
                        this.accexist.Style.Value = "";
                        this.error.Style.Value = "display:none";
                        this.success.Style.Value = "display:none";
                    }
                }
                catch (Exception ex)
                {
                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                    acc.Text = "";
                    password.Text = "";
                    acc_random.Text = "";
                    sid.Text = "";
                    id.Text = "";
                    unit_code.Text = "";
                    name.Text = "";
                    rank_code.Text = "";
                    tel.Text = "";
                    mail.Text = "";
                    cellphone.Text = "";
                    ip.Text = "";
                }
            }
            else
            {
                this.error.Style.Value = "";
                this.success.Style.Value = "display:none";
                this.accexist.Style.Value = "display:none";
            }
        }
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count == 0)
        {
            this.tablelist.Style.Value = "display:none";
            this.success.Style.Value = "display:none";
            this.accexist.Style.Value = "display:none";
            this.error.Style.Value = "display:none";
            this.status.Style.Value = "";
        }
    }
    protected void getpassword_Click(object sender, EventArgs e)
    {
        Lib.RandomPassword pw = new Lib.RandomPassword(8, 16);
        password.Text = pw.PassWord;
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
