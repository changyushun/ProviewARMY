using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
using System.Drawing;
using System.Net.Mail;
using System.IO;

public partial class HQ_SchMag : System.Web.UI.Page
{
    public bool isopen = false;
    Lib.WorkWeek wk;
    public int Year;
    public bool ch1;
    public bool ch2;
    public bool ch3;
    public bool ch4;
    public bool ch5;
    public bool ch6;
    public bool ch7;

    protected void Page_Load(object sender, EventArgs e)
    {

        Account a = (Account)Session["account"];
        if (a.Role != ((int)SysSetting.Role.admin_hq).ToString())
        {
            Response.Redirect("~/index.aspx");
        }
        else
        {
            //ch1 = cbl_WeekCheck.Items[0].Selected;
            //ch2 = cbl_WeekCheck.Items[1].Selected;
            //ch3 = cbl_WeekCheck.Items[2].Selected;
            //ch4 = cbl_WeekCheck.Items[3].Selected;
            //ch5 = cbl_WeekCheck.Items[4].Selected;
            //ch6 = cbl_WeekCheck.Items[5].Selected;
            //ch7 = cbl_WeekCheck.Items[6].Selected;
            ch1 = cb_Monday.Checked;
            ch2 = cb_Tuesday.Checked;
            ch3 = cb_Wednesday.Checked;
            ch4 = cb_Thursday.Checked;
            ch5 = cb_Friday.Checked;
            ch6 = cb_Saturday.Checked;
            ch7 = cb_Sunday.Checked;

            int year_addone = System.DateTime.Now.Year + 1 - 1911;
            year.Text = "民國" + year_addone.ToString() + "年度";
            Year = System.DateTime.Now.Year + 1;//西元明年

            wk = new Lib.WorkWeek(System.DateTime.Now.Year + 1);
            lab_LastYear.Text = "(民國" + year_addone.ToString() + "年)";
            if (wk.isSetYear == true)
            {
                lab_SetStatus.Text = "已設定";
                lab_SetStatus.ForeColor = Color.Blue;
                btn_SetWorkWeek.Text = "更新";
                btn_SetWorkWeek.ForeColor = Color.Blue;
                btn_SetWorkWeek.BackColor = Color.Aquamarine;
                //cbl_WeekCheck.Items[0].Selected = wk.DicWeek[DayOfWeek.Monday];
                //cbl_WeekCheck.Items[1].Selected = wk.DicWeek[DayOfWeek.Tuesday];
                //cbl_WeekCheck.Items[2].Selected = wk.DicWeek[DayOfWeek.Wednesday];
                //cbl_WeekCheck.Items[3].Selected = wk.DicWeek[DayOfWeek.Thursday];
                //cbl_WeekCheck.Items[4].Selected = wk.DicWeek[DayOfWeek.Friday];
                //cbl_WeekCheck.Items[5].Selected = wk.DicWeek[DayOfWeek.Saturday];
                //cbl_WeekCheck.Items[6].Selected = wk.DicWeek[DayOfWeek.Sunday];
                cb_Monday.Checked = wk.DicWeek[DayOfWeek.Monday];
                cb_Tuesday.Checked = wk.DicWeek[DayOfWeek.Tuesday];
                cb_Wednesday.Checked = wk.DicWeek[DayOfWeek.Wednesday];
                cb_Thursday.Checked = wk.DicWeek[DayOfWeek.Thursday];
                cb_Friday.Checked = wk.DicWeek[DayOfWeek.Friday];
                cb_Saturday.Checked = wk.DicWeek[DayOfWeek.Saturday];
                cb_Sunday.Checked = wk.DicWeek[DayOfWeek.Sunday];
            }
            else
            {
                lab_SetStatus.Text = "未設定";
                lab_SetStatus.ForeColor = Color.Red;
                btn_SetWorkWeek.Text = "設定";
                btn_SetWorkWeek.ForeColor = Color.Red;
                btn_SetWorkWeek.BackColor = Color.Pink;
                //cbl_WeekCheck.Items[0].Selected = false;
                //cbl_WeekCheck.Items[1].Selected = false;
                //cbl_WeekCheck.Items[2].Selected = false;
                //cbl_WeekCheck.Items[3].Selected = false;
                //cbl_WeekCheck.Items[4].Selected = false;
                //cbl_WeekCheck.Items[5].Selected = false;
                //cbl_WeekCheck.Items[6].Selected = false;
                cb_Monday.Checked = false;
                cb_Tuesday.Checked = false;
                cb_Wednesday.Checked = false;
                cb_Thursday.Checked = false;
                cb_Friday.Checked = false;
                cb_Saturday.Checked = false;
                cb_Sunday.Checked = false;
            }



            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("year", System.DateTime.Now.Year + 1);
            DataTable dt = du.getDataTableByText("select * from year where year = @year", d);
            if (dt.Rows.Count == 1)
            {
                if (Convert.ToBoolean(dt.Rows[0]["islock"]))
                {
                    year_status.Text = "關閉報進";
                    year_status.ForeColor = Color.Red;
                    Button1.Text = "開放";
                    Button1.ForeColor = Color.Green;
                    Button1.BackColor = Color.PaleGreen;
                    isopen = Convert.ToBoolean(dt.Rows[0]["islock"]);
                }
                else
                {
                    year_status.Text = "開放報進";
                    year_status.ForeColor = Color.Green;
                    Button1.Text = "關閉";
                    Button1.ForeColor = Color.Red;
                    Button1.BackColor = Color.Pink;
                    isopen = Convert.ToBoolean(dt.Rows[0]["islock"]);
                }
            }


            if (IsPostBack)
            {

                //int year_addone = System.DateTime.Now.Year + 1 - 1911;
                year.Text = "民國" + year_addone.ToString() + "年度";
                d.Clear();
                d.Add("year", System.DateTime.Now.Year + 1);
                dt = du.getDataTableByText("select * from year where year = @year", d);
                if (dt.Rows.Count == 1)
                {
                    if (Convert.ToBoolean(dt.Rows[0]["islock"]))
                    {
                        year_status.Text = "關閉報進";
                        year_status.ForeColor = Color.Red;
                        Button1.Text = "開放";
                        Button1.ForeColor = Color.Green;
                        Button1.BackColor = Color.PaleGreen;
                        isopen = Convert.ToBoolean(dt.Rows[0]["islock"]);
                    }
                    else
                    {
                        year_status.Text = "開放報進";
                        year_status.ForeColor = Color.Green;
                        Button1.Text = "關閉";
                        Button1.ForeColor = Color.Red;
                        Button1.BackColor = Color.Pink;
                        isopen = Convert.ToBoolean(dt.Rows[0]["islock"]);
                    }
                }
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
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Lib.DataUtility du = new DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        if (isopen)
        {
            //set is lock = false;
            d.Add("year", System.DateTime.Now.Year + 1);
            d.Add("islock", false);
            du.executeNonQueryByText("update Year set islock = @islock where year = @year", d);
        }
        else
        {
            // set is lock = true;
            d.Add("year", System.DateTime.Now.Year + 1);
            d.Add("islock", true);
            du.executeNonQueryByText("update Year set islock = @islock where year = @year", d);
        }
        Response.Redirect(Request.FilePath);
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[5].Text == "True")
                e.Row.Cells[5].Text = "啟用";
            else
                e.Row.Cells[5].Text = "停用";
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[6].Text == "True")
                e.Row.Cells[6].Text = "啟用";
            else
                e.Row.Cells[6].Text = "停用";
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btn_SetWorkWeek_Click(object sender, EventArgs e)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("year", Year);
        d.Add("Monday", ch1);
        d.Add("Tuesday", ch2);
        d.Add("Wednesday", ch3);
        d.Add("Thursday", ch4);
        d.Add("Friday", ch5);
        d.Add("Saturday", ch6);
        d.Add("Sunday", ch7);
        try
        {
            du.executeNonQueryBysp("Ex107_SetWorkWeek", d);

            Response.Redirect(Request.FilePath);

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('更新失敗');", true);
        }
    }
    protected void cbl_WeekCheck_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void imgbtn_Calendar_Click(object sender, ImageClickEventArgs e)
    {
        if (Calendar1.Visible == false)
            Calendar1.Visible = true;
        else
            Calendar1.Visible = false;
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
    protected void btn_InqOffStation_Click(object sender, EventArgs e)//查詢關站名單
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
    protected void btn_Delete_Click(object sender, EventArgs e)//關站
    {
        //關站移去page_load做
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
