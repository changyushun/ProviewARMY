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

public partial class HQ_TeamReserveChange : System.Web.UI.Page
{
    private Dictionary<string, DateTime> allow;
    private Dictionary<string, DateTime> deny;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["center_code"] != null && Request.QueryString["date"] != null)
        {
            if (!Page.IsPostBack)
            {
                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("center_code", Request.QueryString["center_code"].ToString().Trim());
                d.Add("date", Convert.ToDateTime(Request.QueryString["date"].ToString().Trim()));
                d.Add("op_id", ((Lib.Account)Session["account"]).AccountName);
                DataTable dt = du.getDataTableByText("select count(id) as count,(select center_name from Center where center_code = @center_code) as center_name from result where center_code = @center_code and date = @date and op_id =@op_id", d);
                oldcount.Text = dt.Rows[0]["count"].ToString();
                oldcenter.Text = dt.Rows[0]["center_name"].ToString();
                olddate.Text = (Convert.ToInt32(Request.QueryString["date"].ToString().Trim().Substring(0, Request.QueryString["date"].ToString().Trim().Length - 6)) - 1911).ToString() + Request.QueryString["date"].ToString().Trim().Substring(4, Request.QueryString["date"].ToString().Trim().Length - 4);
                Calendar1.Visible = false;
                dateDiv.Visible = false;
            }
            else if (Page.IsPostBack)
            {
                Calendar1.Visible = true;
                TaiwanCalendar tc = new TaiwanCalendar();
                CultureInfo ci = new CultureInfo("zh-TW");
                ci.DateTimeFormat.Calendar = tc;
                ci.DateTimeFormat.YearMonthPattern = "民國yy年MM月";
                ci.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Sunday;
                Thread.CurrentThread.CurrentCulture = ci;
                dateDiv.Visible = true;
            }    
        }
        else
        {
            
        }        
    }

    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        Calendar1.Visible = true;
        TaiwanCalendar tc = new TaiwanCalendar();
        CultureInfo ci = new CultureInfo("zh-TW");
        ci.DateTimeFormat.Calendar = tc;
        ci.DateTimeFormat.YearMonthPattern = "民國yy年MM月";
        ci.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Sunday;
        Thread.CurrentThread.CurrentCulture = ci;
        if (Page.IsPostBack)
        {
            allow = Lib.SysSetting.getAllowedDates(this.cneterSel.SelectedValue);
            deny = Lib.SysSetting.getDeniedDates(this.cneterSel.SelectedValue);
            if (e.Day.IsWeekend)
            {
                DateTime dt = Lib.SysSetting.ToWorldDate(e.Day.Date.ToShortDateString());
                bool _isOver = Lib.SysSetting.isOverTime(dt);
                if (_isOver == true)
                {
                    LiteralControl l = (LiteralControl)e.Cell.Controls[0];
                    e.Cell.Controls.RemoveAt(0);
                    e.Cell.Text = l.Text;
                }
                else
                {
                    int i = 0;
                    foreach (KeyValuePair<string, DateTime> s in allow)
                    {
                        if (e.Day.Date == s.Value)
                        {
                            e.Cell.BackColor = System.Drawing.Color.Green;
                            e.Cell.ForeColor = System.Drawing.Color.White;
                        }
                        else
                        {
                            i++;
                        }
                    }
                    if (i == allow.Count)
                    {
                        LiteralControl l = (LiteralControl)e.Cell.Controls[0];
                        e.Cell.Controls.RemoveAt(0);
                        e.Cell.Text = l.Text;
                    }
                }
            }
            if (!e.Day.IsWeekend)
            {
                DateTime dt = Lib.SysSetting.ToWorldDate(e.Day.Date.ToShortDateString());
                bool _isOver = Lib.SysSetting.isOverTime(dt);
                if (_isOver == true)
                {
                    LiteralControl l = (LiteralControl)e.Cell.Controls[0];
                    e.Cell.Controls.RemoveAt(0);
                    e.Cell.Text = l.Text;
                }
                else
                {
                    foreach (KeyValuePair<string, DateTime> d in deny)
                    {
                        if (e.Day.Date == d.Value)
                        {
                            e.Cell.BackColor = System.Drawing.Color.Red;
                            e.Cell.ForeColor = System.Drawing.Color.White;
                            LiteralControl l = (LiteralControl)e.Cell.Controls[0];
                            e.Cell.Controls.RemoveAt(0);
                            e.Cell.Text = l.Text;
                        }
                    }
                }
            }
        }
        Calendar1.Visible = true;
        ci.DateTimeFormat.Calendar = tc;
        ci.DateTimeFormat.YearMonthPattern = "民國yy年MM月";
        ci.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Sunday;
        Thread.CurrentThread.CurrentCulture = ci;
    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        //Thread.CurrentThread.CurrentCulture = new CultureInfo("en");
        DateTime s = Lib.SysSetting.ToWorldDate(Calendar1.SelectedDate.ToShortDateString());
        bool _isOver = Lib.SysSetting.isOverTime(s);
        if (_isOver == true)
        {
            string CanReserve = System.DateTime.Now.AddDays(1).ToString("yyyy/MM/dd");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('不可預約此時段 , 請選擇 " + CanReserve + " 以後的日期');", true);
            TabContainer1.ActiveTabIndex = 0;
        }
        else if (_isOver == false)
        {
            TaiwanCalendar tc = new TaiwanCalendar();
            CultureInfo ci = new CultureInfo("zh-TW");
            ci.DateTimeFormat.Calendar = tc;
            ci.DateTimeFormat.YearMonthPattern = "民國yy年MM月";
            ci.DateTimeFormat.FirstDayOfWeek = DayOfWeek.Sunday;
            Thread.CurrentThread.CurrentCulture = ci;
            selectDate.Text = Calendar1.SelectedDate.ToShortDateString();
            TabContainer1.ActiveTabIndex = 0;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string _selectdate = selectDate.Text;
        if (Session["account"] != null && Request.QueryString["center_code"] != null && Request.QueryString["center_code"] != "" && Request.QueryString["date"] != null && Request.QueryString["date"] != "")
        {
            if (Lib.SysSetting.ToWorldDate(_selectdate) > Convert.ToDateTime(Request.QueryString["date"].ToString().Trim()) && Lib.SysSetting.ToWorldDate(_selectdate).Year == Convert.ToDateTime(Request.QueryString["date"].ToString().Trim()).Year )
            {
                if (Lib.SysSetting.CheckYear(Lib.SysSetting.ToWorldDate(_selectdate)))
                {
                    CultureInfo ci_en = new CultureInfo("en-US");
                    Thread.CurrentThread.CurrentCulture = ci_en;
                    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString);
                    conn.Open();
                    SqlCommand comm = conn.CreateCommand();
                    SqlTransaction trans;
                    trans = conn.BeginTransaction("mytrans");
                    comm.Connection = conn;
                    comm.Transaction = trans;
                    DataTable dt = new DataTable();
                    try
                    {
                        comm.Parameters.Clear();
                        SqlParameter p1 = new SqlParameter("date", Convert.ToDateTime(Request.QueryString["date"].ToString().Trim()));
                        SqlParameter p2 = new SqlParameter("center_code", Request.QueryString["center_code"].ToString().Trim());
                        SqlParameter p3 = new SqlParameter("op_id", ((Lib.Account)Session["account"]).AccountName);
                        comm.Parameters.Add(p1);
                        comm.Parameters.Add(p2);
                        comm.Parameters.Add(p3);
                        comm.CommandType = CommandType.Text;
                        comm.CommandText = "select sid,birth from Result where date = @date and center_code = @center_code and op_id = @op_id and status = '000'";
                        dt.Load(comm.ExecuteReader());
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            comm.Parameters.Clear();
                            comm.Parameters.Add("age", Lib.SysSetting.ConvertAge(Convert.ToDateTime(dt.Rows[i]["birth"]), Lib.SysSetting.ToWorldDate(_selectdate)));
                            comm.Parameters.Add("date", Lib.SysSetting.ToWorldDate(_selectdate));
                            comm.Parameters.Add("center_code", cneterSel.SelectedValue.ToString());
                            comm.Parameters.Add("op_id", ((Lib.Account)Session["account"]).AccountName);
                            comm.Parameters.Add("sid", dt.Rows[i]["sid"].ToString());
                            comm.CommandType = CommandType.Text;
                            comm.CommandText = "UPDATE Result SET age = @age, date = @date, center_code = @center_code where sid = @sid and op_id = @op_id ";
                            comm.ExecuteNonQuery();
                        }
                        DataTable dt_reserved = new DataTable();
                        comm.Parameters.Clear();
                        comm.Parameters.Add("center_code", cneterSel.SelectedValue.ToString());
                        comm.Parameters.Add("date", Lib.SysSetting.ToWorldDate(_selectdate));
                        comm.CommandType = CommandType.StoredProcedure;
                        comm.CommandText = "Ex102_GetCenterLimit";
                        dt_reserved.Load(comm.ExecuteReader());
                        //comm.CommandText = "select count (id) as reserved,(select limit from center where center_code = @center_code) as limit from result where center_code = @center_code and date = @date";
                        //dt_reserved.Load(comm.ExecuteReader());
                        //if (((Convert.ToInt32(dt_reserved.Rows[0]["limit"].ToString()) - Convert.ToInt32(dt_reserved.Rows[0]["reserved"].ToString())) >= 0))
                        if (Convert.ToInt32(dt_reserved.Rows[0]["allow"]) >= 0)
                        {
                            //if ((Convert.ToInt32(oldcount.Text) <= (Convert.ToInt32(dt_reserved.Rows[0]["limit"].ToString()) - Convert.ToInt32(dt_reserved.Rows[0]["reserved"].ToString()))))
                            trans.Commit();
                            newcenter.Text = cneterSel.SelectedItem.Text;
                            newcount.Text = oldcount.Text;
                            newdate.Text = _selectdate;
                            this.Result.Style.Value = "";
                            this.ReturnStep1.Style.Value = "";
                            this.OrderStep1.Style.Value = "display:none";
                            this.SureTimeAndPlace.Style.Value = "display:none";
                            this.Div1.Style.Value = "display:none";
                            this.Nonenough.Style.Value = "display:none";
                            this.ConnectError.Style.Value = "display:none";
                            this.onlylater.Style.Value = "display:none";
                            string dd = Server.MapPath(Request.ApplicationPath);
                            MailMessage _Mail = new MailMessage();
                            StreamReader _MailContent = new StreamReader(dd + "\\Mail\\UpdateTeamReserveManger.txt");
                            _Mail.Body = _MailContent.ReadToEnd();
                            _Mail.Body = _Mail.Body.Replace("%olddate%", olddate.Text);
                            _Mail.Body = _Mail.Body.Replace("%oldlocation%", oldcenter.Text);
                            _Mail.Body = _Mail.Body.Replace("%newdate%", newdate.Text);
                            _Mail.Body = _Mail.Body.Replace("%newlocation%", newcenter.Text);
                            _Mail.Body = _Mail.Body.Replace("%total%", newcount.Text);
                            Lib.SysSetting.SaveLetter(((Lib.Account)Session["account"]).Mail + "@webmail.mil.tw", "國軍基本體能鑑測網", _Mail.Body, "報進變更通知信", "00");
                            Lib.SysSetting.AddLog("團體變更報進", ((Lib.Account)Session["account"]).AccountName, "變更報進 , 日期:" + newdate.Text + " , 地點:" + newcenter.Text + " , 預約人數" + newcount.Text + "人", System.DateTime.Now);

                            //Lib.SysSetting.SaveLetter(((Lib.Account)Session["account"]).Mail + "@webmail.mil.tw", "國軍基本體能鑑測網", _Mail.Body, "報進成功通知信", "00");
                        }
                        else
                        {
                            trans.Rollback();
                            this.Nonenough.Style.Value = "";
                            this.Div1.Style.Value = "display:none";
                            this.ConnectError.Style.Value = "display:none";
                            this.onlylater.Style.Value = "display:none";
                            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('餘額不足 , 無法預約');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                        trans.Rollback();
                        this.Div1.Style.Value = "";
                        this.Nonenough.Style.Value = "display:none";
                        this.ConnectError.Style.Value = "display:none";
                        this.onlylater.Style.Value = "display:none";
                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('網路連線異常 , 請重新作業');", true);
                    }
                    finally
                    {
                        trans.Dispose();
                        conn.Close();
                    }
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('此年度目前不開放報進 , 開放時系統將會公告');", true);
                }
            }
            else
            {
                this.onlylater.Style.Value = "";
                this.Nonenough.Style.Value = "display:none";
                this.ConnectError.Style.Value = "display:none";
                this.Div1.Style.Value = "display:none";
            }
        }
        CultureInfo cii = new CultureInfo("zh-TW");
        Thread.CurrentThread.CurrentCulture = cii;
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
    protected void cneterSel_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectDate.Text = "";
        Calendar1.SelectedDates.Clear();
    }
}
