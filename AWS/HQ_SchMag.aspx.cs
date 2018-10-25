using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
using System.Drawing;

public partial class HQ_SchMag : System.Web.UI.Page
{
    public bool isopen = false;
    Lib.WorkWeek thisYear_wk;
    Lib.WorkWeek nextYear_wk;
    public int next_Year;
    public bool ch1;
    public bool ch2;
    public bool ch3;
    public bool ch4;
    public bool ch5;
    public bool ch6;
    public bool ch7;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            Account a = (Account)Session["account"];
            if (a.Role != ((int)SysSetting.Role.admin_hq).ToString())
            {
                Response.Redirect("~/index.aspx");
            }
            else
            {
                //顯示年度工作日
                ch1 = cb_Mon.Checked;
                ch2 = cb_Tue.Checked;
                ch3 = cb_Wed.Checked;
                ch4 = cb_Thu.Checked;
                ch5 = cb_Fri.Checked;
                ch6 = cb_Sat.Checked;
                ch7 = cb_Sun.Checked;

                int year_addone = System.DateTime.Now.Year + 1 - 1911;
                year.Text = "民國" + year_addone.ToString() + "年度";
                next_Year = System.DateTime.Now.Year + 1;//西元明年

                thisYear_wk = new Lib.WorkWeek(System.DateTime.Now.Year);//今年
                nextYear_wk = new Lib.WorkWeek(System.DateTime.Now.Year + 1);//明年
                lab_ThisYear.Text = "民國" + (year_addone - 1).ToString() + "年";
                lab_NextYear.Text = "民國" + year_addone.ToString() + "年";
                //顯示今年資料
                if (thisYear_wk.isSetYear == true)
                {
                    if (thisYear_wk.DicWeek[DayOfWeek.Monday] == true)
                    {
                        lab_Mon.Text = "ON";
                        lab_Mon.ForeColor = Color.Green;
                    }
                    else
                    {
                        lab_Mon.Text = "OFF";
                        lab_Mon.ForeColor = Color.Red;
                    }
                    if (thisYear_wk.DicWeek[DayOfWeek.Tuesday] == true)
                    {
                        lab_Tue.Text = "ON";
                        lab_Tue.ForeColor = Color.Green;
                    }
                    else
                    {
                        lab_Tue.Text = "OFF";
                        lab_Tue.ForeColor = Color.Red;
                    }
                    if (thisYear_wk.DicWeek[DayOfWeek.Wednesday] == true)
                    {
                        lab_Wed.Text = "ON";
                        lab_Wed.ForeColor = Color.Green;
                    }
                    else
                    {
                        lab_Wed.Text = "OFF";
                        lab_Wed.ForeColor = Color.Red;
                    }
                    if (thisYear_wk.DicWeek[DayOfWeek.Thursday] == true)
                    {
                        lab_Thu.Text = "ON";
                        lab_Thu.ForeColor = Color.Green;
                    }
                    else
                    {
                        lab_Thu.Text = "OFF";
                        lab_Thu.ForeColor = Color.Red;
                    }
                    if (thisYear_wk.DicWeek[DayOfWeek.Friday] == true)
                    {
                        lab_Fri.Text = "ON";
                        lab_Fri.ForeColor = Color.Green;
                    }
                    else
                    {
                        lab_Fri.Text = "OFF";
                        lab_Fri.ForeColor = Color.Red;
                    }
                    if (thisYear_wk.DicWeek[DayOfWeek.Saturday] == true)
                    {
                        lab_Sat.Text = "ON";
                        lab_Sat.ForeColor = Color.Green;
                    }
                    else
                    {
                        lab_Sat.Text = "OFF";
                        lab_Sat.ForeColor = Color.Red;
                    }
                    if (thisYear_wk.DicWeek[DayOfWeek.Sunday] == true)
                    {
                        lab_Sun.Text = "ON";
                        lab_Sun.ForeColor = Color.Green;
                    }
                    else
                    {
                        lab_Sun.Text = "OFF";
                        lab_Sun.ForeColor = Color.Red;
                    }
                    //簡化版
                    //lab_Mon.Text = (wk.DicWeek[DayOfWeek.Monday] == true) ? "ON" : "OFF";
                    //lab_Tue.Text = (wk.DicWeek[DayOfWeek.Tuesday] == true) ? "ON" : "OFF";
                    //lab_Wed.Text = (wk.DicWeek[DayOfWeek.Wednesday] == true) ? "ON" : "OFF";
                    //lab_Thu.Text = (wk.DicWeek[DayOfWeek.Thursday] == true) ? "ON" : "OFF";
                    //lab_Fri.Text = (wk.DicWeek[DayOfWeek.Friday] == true) ? "ON" : "OFF";
                    //lab_Sat.Text = (wk.DicWeek[DayOfWeek.Saturday] == true) ? "ON" : "OFF";
                    //lab_Sun.Text = (wk.DicWeek[DayOfWeek.Sunday] == true) ? "ON" : "OFF";
                }
                else
                {
                    lab_Mon.Text = "未設定";
                    lab_Tue.Text = "未設定";
                    lab_Wed.Text = "未設定";
                    lab_Thu.Text = "未設定";
                    lab_Fri.Text = "未設定";
                    lab_Sat.Text = "未設定";
                    lab_Sun.Text = "未設定";
                }

                //顯示明年資料
                if (nextYear_wk.isSetYear == true)
                {
                    cb_Mon.Checked = nextYear_wk.DicWeek[DayOfWeek.Monday];
                    cb_Tue.Checked = nextYear_wk.DicWeek[DayOfWeek.Tuesday];
                    cb_Wed.Checked = nextYear_wk.DicWeek[DayOfWeek.Wednesday];
                    cb_Thu.Checked = nextYear_wk.DicWeek[DayOfWeek.Thursday];
                    cb_Fri.Checked = nextYear_wk.DicWeek[DayOfWeek.Friday];
                    cb_Sat.Checked = nextYear_wk.DicWeek[DayOfWeek.Saturday];
                    cb_Sun.Checked = nextYear_wk.DicWeek[DayOfWeek.Sunday];
                    lab_Set_Status.Text = "已設定";
                    lab_Set_Status.ForeColor = Color.Blue;
                    btn_SetWorkWeek.Text = "更新";
                    btn_SetWorkWeek.ForeColor = Color.Blue;
                    btn_SetWorkWeek.BackColor = Color.Aquamarine;
                }
                else
                {
                    cb_Mon.Checked = false;
                    cb_Tue.Checked = false;
                    cb_Wed.Checked = false;
                    cb_Thu.Checked = false;
                    cb_Fri.Checked = false;
                    cb_Sat.Checked = false;
                    cb_Sun.Checked = false;
                    lab_Set_Status.Text = "未設定";
                    lab_Set_Status.ForeColor = Color.Red;
                    btn_SetWorkWeek.Text = "設定";
                    btn_SetWorkWeek.ForeColor = Color.Red;
                    btn_SetWorkWeek.BackColor = Color.Pink;
                }


                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("year", System.DateTime.Now.Year + 1);
                DataTable dt = du.getDataTableByText("select * from year where year = @year", d);
                if (dt.Rows.Count == 1)
                {
                    if (Convert.ToBoolean(dt.Rows[0][2]))
                    {
                        year_status.Text = "關閉報進";
                        year_status.ForeColor = Color.Red;
                        Button1.Text = "開放";
                        Button1.ForeColor = Color.Green;
                        Button1.BackColor = Color.PaleGreen;
                        isopen = Convert.ToBoolean(dt.Rows[0]["islock"]);
                        //原版
                        //year_status.Text = "關閉報進";
                        //Button1.Text = "開放";
                        //isopen = Convert.ToBoolean(dt.Rows[0][2]);
                    }
                    else
                    {
                        year_status.Text = "開放報進";
                        year_status.ForeColor = Color.Green;
                        Button1.Text = "關閉";
                        Button1.ForeColor = Color.Red;
                        Button1.BackColor = Color.Pink;
                        isopen = Convert.ToBoolean(dt.Rows[0]["islock"]);
                        //原版
                        //year_status.Text = "開放報進";
                        //Button1.Text = "關閉";
                        //isopen = Convert.ToBoolean(dt.Rows[0][2]);
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
                        if (Convert.ToBoolean(dt.Rows[0][2]))
                        {
                            year_status.Text = "開放報進";
                            Button1.Text = "關閉";
                            isopen = Convert.ToBoolean(dt.Rows[0][2]);
                        }
                        else
                        {
                            year_status.Text = "關閉報進";
                            Button1.Text = "開放";
                            isopen = Convert.ToBoolean(dt.Rows[0][2]);
                        }
                    }
                }
            }
        }
        else
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
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
    //設定年度工作日
    protected void btn_SetWorkWeek_Click(object sender, EventArgs e)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("year", next_Year);
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
}
