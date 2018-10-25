using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net.Mail;
using System.IO;
using Lib;

public partial class _107_OffStation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
            {
                //前端已經先關好站了，再來處理關站刪除
                if (HF_CheckDel.Value == "ok")
                {
                    HF_CheckDel.Value = "no";
                    //逐筆寄信後刪除
                    string date = txb_InqDate.Text;
                    string center_name = DropDownList1.SelectedItem.Text;
                    string reason = txb_Reason.Text;//關站原因
                    for (int i = 0; i < GridView2.Rows.Count; i++)
                    {
                        string sid = GridView2.Rows[i].Cells[0].Text;
                        string id = GridView2.Rows[i].Cells[2].Text;
                        string mail = GridView2.Rows[i].Cells[8].Text;
                        

                        //檢查信箱欄位，有的才寄信
                        //信件文字檔案夾位置
                        string dd = Server.MapPath(Request.ApplicationPath);
                        StreamReader _MailContentToUser = new StreamReader(dd + "\\Mail\\OffStation.txt");
                        //先寄信
                        if (!string.IsNullOrEmpty(mail) & mail != "&nbsp;")//表格空字串會變成「&nbsp;」
                        {
                            MailMessage _MailToUser = new MailMessage();
                            _MailToUser.Body = _MailContentToUser.ReadToEnd();
                            _MailToUser.Body = _MailToUser.Body.Replace("%reason%", reason);
                            _MailToUser.Body = _MailToUser.Body.Replace("%id%", (id.Substring(0, id.Length - 3) + "***"));
                            _MailToUser.Body = _MailToUser.Body.Replace("%date%", date);
                            _MailToUser.Body = _MailToUser.Body.Replace("%location%", center_name);
                            Lib.SysSetting.SaveLetter(mail + "@webmail.mil.tw", "國軍體能鑑測中心", _MailToUser.Body, "臨時關站取消報名通知信", "00");
                        }
                        Lib.DataUtility du = new Lib.DataUtility();
                        //再刪報名
                        du.executeNonQueryBysp("Ex107_DelResultbySid", "sid", sid);
                    }
                    Lib.SysSetting.AddLog("臨時關站", "admin", "臨時關站取消報名 , 日期:" + date + " , 地點:" + center_name, System.DateTime.Now);
                    GridView2.DataSource = null;
                    GridView2.DataBind();
                    CloseEnter();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('鑑測站已關閉，報名資料已刪除。');", true);

                    //重新整理網頁
                    //Response.Redirect(Request.FilePath);
                }
            }
    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        txb_InqDate.Text = Calendar1.SelectedDate.ToShortDateString();
        Calendar1.Visible = false;
        HiddenField1.Value = null;
        GridView2.DataSource = null;
        GridView2.DataBind();
        CloseEnter();
    }
    protected void btn_InqOffStation_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txb_InqDate.Text))
        {
            HF_CheckDel.Value = "no";
            string center_code = DropDownList1.SelectedValue;

            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> list = new Dictionary<string, object>();
            list.Add("date", Convert.ToDateTime(txb_InqDate.Text));
            list.Add("center_code", center_code);
            DataTable chday_dt = du.getDataTableBysp("Ex107_CheackCanOff", list);
            if (chday_dt.Rows.Count > 0)
            {
                if (chday_dt.Rows[0]["do"].ToString() == "1")//開站，要重設
                {
                    DataTable dt = du.getDataTableBysp("Ex107_GetOffStation", list);
                    if (dt.Rows.Count > 0)
                    {
                        HiddenField1.Value = center_code;
                        GridView2.DataSource = dt;
                        GridView2.DataBind();
                        OpenEnter();
                        lab_count.Text = dt.Rows.Count.ToString() + "筆";
                    }
                    else
                    {
                        HiddenField1.Value = center_code;
                        GridView2.DataSource = dt;
                        GridView2.DataBind();
                        OpenEnter();
                        lab_count.Text = "0筆";
                    }
                }
                else//本來就關站
                {
                    GridView2.DataSource = null;
                    GridView2.DataBind();
                    CloseEnter();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('預設為「關站」，無法關閉!!');", true);
                }
            }

        }
        else
        {
            CloseEnter();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('請先選取日期!!');", true);
        }
    }
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        string Date = e.Day.Date.ToShortDateString();
        DateTime CheckTime = Convert.ToDateTime(Date + " 12:00:00");
        DateTime NowTime = DateTime.Now.AddDays(+1);
        if (DateTime.Compare(CheckTime, NowTime) < 0)
        {
            //e.Cell.Visible = false;
            e.Cell.Controls.Clear();
        }
    }
    private void OpenEnter()
    {
        lab_Reason.Visible = true;
        lab_Reason2.Visible = true;
        txb_Reason.Visible = true;
        lab_countTitle.Visible = true;
        lab_count.Visible = true;
        btn_Delete.Visible = true;
    }
    private void CloseEnter()
    {
        lab_Reason.Visible = false;
        lab_Reason2.Visible = false;
        txb_Reason.Visible = false;
        lab_countTitle.Visible = false;
        lab_count.Visible = false;
        btn_Delete.Visible = false;
        HF_CheckDel.Value = "no";
    }

    protected void imgbtn_Calendar_Click(object sender, ImageClickEventArgs e)
    {
        if (Calendar1.Visible == false)
            Calendar1.Visible = true;
        else
            Calendar1.Visible = false;
    }

}