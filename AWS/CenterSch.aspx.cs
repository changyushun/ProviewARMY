using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;
using System.Data;
using System.Drawing;


public partial class CenterSch : System.Web.UI.Page
{
    private Dictionary<string, DateTime> allow;
    private Dictionary<string, DateTime> deny;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            OP_Value.Value = ((Lib.Account)(Session["account"])).AccountName;
        }
        Lib.DataUtility du = new Lib.DataUtility();
        //DataTable dt_limit = du.getDataTableByText("select limit from center where center_code = '" + Request.Params["center"] + "'");
        //limit.Text = dt_limit.Rows[0][0].ToString();
        Dictionary<string, object> list = new Dictionary<string, object>();
        if (string.IsNullOrEmpty(date.Text))
        {
            list.Add("date", DateTime.Now.ToShortDateString());
        }
        else
        {
            string rocDate = date.Text;
            string[] lines = rocDate.Split(new string[] { @"/" }, StringSplitOptions.None);
            if (lines.Length > 0)
            {
                list.Add("date", (1911 + Convert.ToInt32(lines[0])).ToString() + "-" + lines[1] + "-" + lines[2]);
            }
            else
            {
                list.Add("date", DateTime.Now.ToShortDateString());
            }
        }
        list.Add("center_code", Request.Params["center"]);
        DataTable dt_limit = du.getDataTableBysp("Ex102_GetCenterLimit", list);
        limit.Text = dt_limit.Rows[0]["default"].ToString();

        list.Clear();
        list.Add("center_code", Request.Params["center"]);
        DataTable dt_IsService = du.getDataTableBysp("Ex103_GetCenterStatus", list);
        status.Text = dt_IsService.Rows[0]["IsService"].ToString();

        list.Clear();
        list.Add("center_code", Request.Params["center"]);
        DataTable dt_IsSwin = du.getDataTableBysp("Ex103_GetCenterSwin", list);
        swin.Text = dt_IsSwin.Rows[0]["IsSwin"].ToString();

        //txtLimit.Text = dt_limit.Rows[0]["allow"].ToString();
        centerCode.Value = (Request.Params["center"] == null ? "" : Request.Params["center"]);
        TaiwanCalendar tc = new TaiwanCalendar();
        CultureInfo ci = new CultureInfo("zh-TW");
        ci.DateTimeFormat.Calendar = tc;
        ci.DateTimeFormat.YearMonthPattern = "民國yy年MM月";
        ci.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Monday;
        Thread.CurrentThread.CurrentCulture = ci;


        DataTable dt = new DataTable();
        string center_code = (Request.Params["center"] == null ? "1" : Request.Params["center"]);

        Dictionary<string, DateTime> allow = Lib.SysSetting.getAllowedDates(center_code);//取得假日開放有修改的日期
        Session["allow"] = allow;
        Dictionary<string, DateTime> deny = Lib.SysSetting.getDeniedDates(center_code);//取出平日關閉有修改開放的日期
        Session["deny"] = deny;
        dt.Columns.Add("序號");
        dt.Columns.Add("狀態");
        dt.Columns.Add("日期");
        dt.Columns.Add("星期");
        dt.Columns.Add("刪除");
        dt.Columns.Add("sid");
        dt.Columns.Add("天數", typeof(int));
        foreach (KeyValuePair<string, DateTime> item in allow)
        {
            DataRow row = dt.NewRow();
            row[5] = item.Key;
            row[1] = "開放";
            row[2] = item.Value.ToShortDateString();
            row[3] = Convert.ToDateTime(item.Value.ToShortDateString()).ToString("ddd");
            dt.Rows.Add(row);
            row[6] = (item.Value.Date - DateTime.Now.Date).Days;
        }
        foreach (KeyValuePair<string, DateTime> item in deny)
        {
            DataRow row = dt.NewRow();
            row[5] = item.Key;
            row[1] = "關閉";
            row[2] = item.Value.ToShortDateString();
            row[3] = Convert.ToDateTime(item.Value.ToShortDateString()).ToString("ddd");
            dt.Rows.Add(row);
            row[6] = (item.Value.Date - DateTime.Now.Date).Days;
        }
        dt.DefaultView.Sort = "天數 ASC";
        
        //隱藏天數及序號
        //dt.Columns.Remove("sid");
        dt.Columns.Remove("天數");
        GW.DataSource = dt;
        
        GW.DataBind();

        for (int i = 0; i < GW.Rows.Count; i++)
        {
            GW.Rows[i].Cells[0].Text = (i + 1).ToString();
        }




    }

    protected void Calendar1_SelectionChanged1(object sender, EventArgs e)
    {
        if (DateTime.Compare(Calendar1.SelectedDate, DateTime.Now.AddDays(-1)) > 0)//日期要大於今天
        {
            //查詢日期有沒有被設定，有的話就不作動作
            string center_code = Request.Params["center"];
            string Seldt = Calendar1.SelectedDate.Year.ToString() + "/" + Calendar1.SelectedDate.Month.ToString() + "/" + Calendar1.SelectedDate.Day.ToString();
            Dictionary<string, object> list = new Dictionary<string, object>();
            list.Add("center_code", center_code);
            list.Add("date", Seldt);
            Lib.DataUtility du1 = new Lib.DataUtility();
            DataTable dt1 = du1.getDataTableBysp("Ex107_GetWeekSetDay", list);
            if (dt1.Rows.Count == 0)//工作日表格沒設定值才動作
            {
                list.Clear();
                dt1.Dispose();
                //設定假日開放及平日關閉工能鍵
                //2017-10-25建立一個判斷星期的物件
                Lib.WorkWeek wk = new Lib.WorkWeek(Calendar1.SelectedDate.Year);
                date.Text = Calendar1.SelectedDate.ToShortDateString();

                if (string.IsNullOrEmpty(date.Text))
                {
                    list.Add("date", DateTime.Now.ToShortDateString());
                }
                else
                {
                    string rocDate = date.Text;
                    string[] lines = rocDate.Split(new string[] { @"/" }, StringSplitOptions.None);
                    if (lines.Length > 0)
                    {
                        list.Add("date", (1911 + Convert.ToInt32(lines[0])).ToString() + "-" + lines[1] + "-" + lines[2]);
                    }
                    else
                    {
                        list.Add("date", DateTime.Now.ToShortDateString());
                    }
                }
                list.Add("center_code", Request.Params["center"]);
                Lib.DataUtility du = new Lib.DataUtility();
                DataTable dt_limit = du.getDataTableBysp("Ex102_GetCenterLimit", list);
                //limit.Text = dt_limit.Rows[0]["default"].ToString();
                txtLimit.Text = dt_limit.Rows[0]["limit"].ToString();
                //2017-10-25更改工作日判斷方式
                //if (Calendar1.SelectedDate.DayOfWeek == DayOfWeek.Sunday || Calendar1.SelectedDate.DayOfWeek == DayOfWeek.Saturday)
                if (wk.isSetYear == true)
                {
                    if (wk.DicWeek[Calendar1.SelectedDate.DayOfWeek] == false)
                    {
                        selDate.Value = "week";
                        if (!Page.ClientScript.IsStartupScriptRegistered("clicktest"))
                        {
                            ScriptManager.RegisterStartupScript(Page, GetType(), "clicktest", "<script>clicktest('確認 「開放」?')</script>", false);
                        }
                    }
                    else
                    {
                        selDate.Value = "work";
                        if (!Page.ClientScript.IsStartupScriptRegistered("clicktest"))
                        {
                            ScriptManager.RegisterStartupScript(Page, GetType(), "clicktest", "<script>clicktest('確認 「關閉」?')</script>", false);
                        }
                    }
                }
                
            }
            else
            {
                list.Clear();
                dt1.Dispose();
                //設定假日開放及平日關閉工能鍵
                //2017-10-25建立一個判斷星期的物件
                Lib.WorkWeek wk = new Lib.WorkWeek(Calendar1.SelectedDate.Year);
                date.Text = Calendar1.SelectedDate.ToShortDateString();

                if (string.IsNullOrEmpty(date.Text))
                {
                    list.Add("date", DateTime.Now.ToShortDateString());
                }
                else
                {
                    string rocDate = date.Text;
                    string[] lines = rocDate.Split(new string[] { @"/" }, StringSplitOptions.None);
                    if (lines.Length > 0)
                    {
                        list.Add("date", (1911 + Convert.ToInt32(lines[0])).ToString() + "-" + lines[1] + "-" + lines[2]);
                    }
                    else
                    {
                        list.Add("date", DateTime.Now.ToShortDateString());
                    }
                }
                list.Add("center_code", Request.Params["center"]);
                Lib.DataUtility du = new Lib.DataUtility();
                DataTable dt_limit = du.getDataTableBysp("Ex102_GetCenterLimit", list);
                //limit.Text = dt_limit.Rows[0]["default"].ToString();
                txtLimit.Text = dt_limit.Rows[0]["limit"].ToString();
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('無法變更當日之前之設定!!');", true);
        }
    }

    protected void GW_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        string s = string.Empty;
        s = e.Row.Cells[1].Text;
        if (e.Row.Cells[1].Text == "關閉")
        {
            e.Row.Cells[1].ForeColor = Color.Red;
            e.Row.Cells[1].BackColor = Color.Pink;
        }
        else if (e.Row.Cells[1].Text == "開放")
        {
            e.Row.Cells[1].ForeColor = Color.Green;
            e.Row.Cells[1].BackColor = Color.LightGreen;
        }
        else
        {

        }
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    LinkButton l = (LinkButton)e.Row.FindControl("LinkButton1");
        //    l.Attributes.Add("onclick", "javascript:return " +
        //    "confirm('Are you sure you want to delete this record " +
        //    DataBinder.Eval(e.Row.Cells[0].Text, "sid") + "')");
        //}

        // int s = Convert.ToInt16(e.Row.Cells[1].Text);
        // SqlDataSource2.DeleteParameters.Add("sid","s");
    }

    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        //設定假日開放及平日關閉工能鍵
        //2017-10-25建立一個判斷星期的物件
        Lib.WorkWeek wk = new Lib.WorkWeek(e.Day.Date.Year);

        #region render center limit control
        Label label_limit = new Label();
        Dictionary<string, object> list = new Dictionary<string, object>();

        string rocDate = e.Day.Date.ToShortDateString();
        string[] lines = rocDate.Split(new string[] { @"/" }, StringSplitOptions.None);
        if (lines.Length > 0)
        {
            list.Add("date", (1911 + Convert.ToInt32(lines[0])).ToString() + "-" + lines[1] + "-" + lines[2]);
        }
        else
        {
            list.Add("date", DateTime.Now.ToShortDateString());
        }

        list.Add("center_code", Request.Params["center"]);
        DataTable dt_limit = new Lib.DataUtility().getDataTableBysp("Ex102_GetCenterLimit", list);
        label_limit.Text = dt_limit.Rows[0]["limit"].ToString();
        if (dt_limit.Rows[0]["limit"].ToString() != dt_limit.Rows[0]["default"].ToString())
            label_limit.ForeColor = System.Drawing.Color.Red;
        else
            label_limit.ForeColor = System.Drawing.Color.Yellow;
        e.Cell.Controls.Add(new LiteralControl("<br />"));


        #endregion
        allow = (Dictionary<string, DateTime>)Session["allow"];
        deny = (Dictionary<string, DateTime>)Session["deny"];

        if (wk.isSetYear == true)//2017-10-25先判斷年份是否已開啟
        {
            if (wk.DicWeek[e.Day.Date.DayOfWeek] == true)//工作日
            {
                if (deny.Count > 0)
                {
                    foreach (KeyValuePair<string, DateTime> d in deny)
                    {
                        if (e.Day.Date == d.Value)//可是關閉
                        {
                            e.Cell.BackColor = System.Drawing.Color.Red;
                            e.Cell.ForeColor = System.Drawing.Color.White;
                            e.Cell.Controls.Remove(label_limit);
                            break;
                        }
                        else
                        {
                            e.Cell.Controls.Add(label_limit);
                        }
                    }
                }
                else
                {
                    e.Cell.Controls.Add(label_limit);
                }

            }

            else//非工作日
            {
                if (allow.Count > 0)
                {
                    foreach (KeyValuePair<string, DateTime> d in allow)
                    {
                        if (e.Day.Date == d.Value)//可是有開放
                        {
                            e.Cell.BackColor = System.Drawing.Color.Green;
                            e.Cell.ForeColor = System.Drawing.Color.White;
                            e.Cell.Controls.Add(label_limit);
                            break;
                        }
                        else
                        {
                            e.Cell.BackColor = System.Drawing.Color.DimGray;
                            e.Cell.Controls.Remove(label_limit);
                        }
                    }
                }
                else
                {

                }

            }
        }
        else
        {
            e.Cell.Visible = false;
        }


    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
    protected void GW_DataBound(object sender, EventArgs e)
    {

    }
}
