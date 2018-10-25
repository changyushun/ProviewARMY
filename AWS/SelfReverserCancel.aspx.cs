using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Configuration;
using System.Net.Mail;
using System.Collections;

public partial class SelfReverserCancel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["player"] != null)
        {
            if (Request.QueryString["date"] != null && Request.QueryString["date"] != "" && Request.QueryString["center_code"] != null && Request.QueryString["center_code"] != "")
            {
                try
                {
                    Lib.DataUtility du = new Lib.DataUtility();
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    d.Add("center_code", Request.QueryString["center_code"].ToString());
                    DataTable dt = du.getDataTableByText("select center_name from Center where center_code = @center_code", d);
                    date.Text = Request.QueryString["date"].ToString();
                    center.Text = dt.Rows[0]["center_name"].ToString();
                    SqlDataSource1.SelectParameters["date"].DefaultValue = Convert.ToDateTime(date.Text).ToShortDateString();
                    SqlDataSource1.SelectParameters["op_id"].DefaultValue = ((Lib.Player)Session["player"]).ID;
                    SqlDataSource1.SelectParameters["center_code"].DefaultValue = Request.QueryString["center_code"].ToString();
                }
                catch (Exception ex)
                {
                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                }
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ArrayList alist = new ArrayList();
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "window.close();", true);
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            System.Web.UI.WebControls.CheckBox cbb = (System.Web.UI.WebControls.CheckBox)GridView1.Rows[i].FindControl("ch1");
            if (cbb.Checked == true)
            {
                int id = Convert.ToInt32(GridView1.Rows[i].Cells[1].Text);
                alist.Add(id);
            }
        }

        string _detailtable = "";
        string cwd = System.IO.Directory.GetCurrentDirectory();
        string dd = Server.MapPath(Request.ApplicationPath);
        if (Session["player"] != null)
        {
            if (Request.QueryString["center_code"] != null && Request.QueryString["date"] != null)
            {
                string _OP = "";
                _OP = ((Lib.Player)Session["player"]).ID;
                for (int j = 0; j < alist.Count; j++)
                {
                    d.Add("sid", alist[j]);
                    DataTable dt = du.getDataTableByText("Select p.name ,p.id ,p.birth ,p.rank_code ,p.mail from result r , player p where r.sid = @sid and r.id = p.id", d);
                    _detailtable = _detailtable + "<tr><td>" + dt.Rows[0]["name"] + "</td><td>" + dt.Rows[0]["id"] + "</td><td>" + Lib.SysSetting.ToRocDateFormat(dt.Rows[0]["birth"].ToString().Remove(9)) + "</td><td>" + dt.Rows[0]["rank_code"] + "</td><td>" + dt.Rows[0]["mail"] + "</td></tr>";
                    //移除Result
                    du.executeNonQueryByText("Delete from Result where sid = @sid", d);
                    d.Clear();

                    #region 通知受測人員取消報進
                    MailMessage _MailToUser = new MailMessage();
                    StreamReader _MailContentToUser = new StreamReader(dd + "\\Mail\\CancelTeamReserveUser.txt");
                    _MailToUser.Body = _MailContentToUser.ReadToEnd();
                    _MailToUser.Body = _MailToUser.Body.Replace("%date%", date.Text);
                    _MailToUser.Body = _MailToUser.Body.Replace("%location%", center.Text);
                    Lib.SysSetting.SaveLetter(dt.Rows[0]["mail"] + "@webmail.mil.tw", "國軍體能鑑測中心", _MailToUser.Body, "報進取消通知信", "00");
                    Lib.SysSetting.AddLog("基本項目取消報進", ((Lib.Player)Session["player"]).ID, "取消報進 , 日期:" + Lib.SysSetting.ToRocDateFormat(date.Text) + " , 地點:" + center.Text, System.DateTime.Now);
                    #endregion
                }
                //#region 通知團報負責人取消報進
                //MailMessage _Mail = new MailMessage();
                //StreamReader _MailContent = new StreamReader(dd + "\\Mail\\CancelTeamReserveManger.txt");
                //_Mail.Body = _MailContent.ReadToEnd().Replace("%detail%", _detailtable);
                //_Mail.Body = _Mail.Body.Replace("%date%", date.Text);
                //_Mail.Body = _Mail.Body.Replace("%location%", center.Text);
                //_Mail.Body = _Mail.Body.Replace("%total%", alist.Count.ToString());
                //Lib.SysSetting.SaveLetter(((Lib.Player)Session["player"]).Mail + "@webmail.mil.tw", "國軍體能鑑測中心", _Mail.Body, "報進取消通知信", "00");
                //#endregion
                //寫入Log
                ////Lib.SysSetting.AddLog("團體報進", _OP, "取消報進,鑑測日期:" + date.Text + " , 鑑測地點:" + center.Text + "取消報進人數:" + alist.Count.ToString() + "人", System.DateTime.Now);

            }
        }
        GridView1.DataBind();
        TabContainer1.ActiveTabIndex = 0;
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count == 0)
        {
            this.nolist.Style.Value = "display:none";
            this.nolistmessage.Style.Value = "";
        }
        else
        {
            this.nolist.Style.Value = "";
            this.nolistmessage.Style.Value = "display:none";
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
