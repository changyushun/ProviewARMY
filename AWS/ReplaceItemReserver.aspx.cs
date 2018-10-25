using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;
using System.Text;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Configuration;

public partial class ReplaceItemReserver : System.Web.UI.Page
{
    private Dictionary<string, DateTime> allow;
    private Dictionary<string, DateTime> deny;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Lib.Player a = new Lib.Player();
            a = (Lib.Player)Session["player"];
            string op_id = a.ID;
            //if (DateTime.Now > DateTime.Today.AddHours(Lib.SysSetting.reserveTimeUnit.TotalHours))
            if (DateTime.Now > DateTime.Today.AddDays(1).AddHours(-Lib.SysSetting.reserveTimeUnit.TotalHours))
            {
                SqlDataSource2.SelectParameters["date"].DefaultValue = DateTime.Today.AddDays(1).ToShortDateString();
                SqlDataSource2.SelectParameters["op_id"].DefaultValue = op_id;
            }
            else
            {
                SqlDataSource2.SelectParameters["date"].DefaultValue = DateTime.Today.ToShortDateString();
                SqlDataSource2.SelectParameters["op_id"].DefaultValue = op_id;
            }

            if (!Page.IsPostBack)
            {
                Calendar1.Visible = false;
                dateDiv.Visible = false;
            }
            else
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
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            Response.Redirect("Login.aspx");
        }
    }
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        //2017-10-25建立一個判斷星期的物件
        Lib.WorkWeek wk = new Lib.WorkWeek(e.Day.Date.Year);

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
            //if (e.Day.IsWeekend)//判斷是不是非工作日

            //2017-11-29要先檢查是不是null
            if (wk.DicWeek[e.Day.Date.DayOfWeek] == false)//2017-10-25新寫法
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
            //if (!e.Day.IsWeekend)//判斷是不是工作日
            if (wk.DicWeek[e.Day.Date.DayOfWeek] == true)//2017-10-25新寫法
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
    //protected void check_OnClick(object sender, EventArgs e)
    //{
    //    Lib.Player a = new Lib.Player();
    //    a = (Lib.Player)Session["player"];
    //    string op_id = a.ID;
    //    SqlDataSource2.SelectParameters["op_id"].DefaultValue = op_id;
    //}

    protected void GridView2_OnDataBound(object sender, EventArgs e)
    {
        if (GridView2.Rows.Count == 0)
        {
            this.zerorder.Style.Value = "";
        }
        else
        {
            this.zerorder.Style.Value = "display:none";
        }
    }

    protected void GridView2_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[0].Text);
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["player"] != null)
        {
            if (selectDate.Text != "" && cneterSel.SelectedValue != "0")
            {
                if (Lib.SysSetting.CheckYear(Convert.ToDateTime(selectDate.Text)))
                {
                    try
                    {
                        string _OP = ((Lib.Player)Session["player"]).ID;
                        string _center = cneterSel.SelectedItem.Value.ToString();
                        string _date = selectDate.Text;
                        Lib.DataUtility dux = new Lib.DataUtility();
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("account", _OP);
                        DataTable _player = dux.getDataTableByText("select id,gender,CONVERT(VARCHAR(10),Player.birth, 111) AS birth,name,unit_code,rank_code,mail,oversea from Player where id = @account", d);

                        string _id = _player.Rows[0]["id"].ToString();
                        string _gender = _player.Rows[0]["gender"].ToString();
                        string _birth = _player.Rows[0]["birth"].ToString(); // _birth格式為yyyy/mm/dd
                        //DateTime ss = Convert.ToDateTime(_birth);
                        string _name = _player.Rows[0]["name"].ToString();
                        string _unit_code = _player.Rows[0]["unit_code"].ToString();
                        string _rank_code = _player.Rows[0]["rank_code"].ToString();
                        string _mail = _player.Rows[0]["mail"].ToString();
                        string _oversea = _player.Rows[0]["oversea"].ToString();

                        CultureInfo ci_en = new CultureInfo("en-US");
                        Thread.CurrentThread.CurrentCulture = ci_en;  //資料庫中存放的datetime為西元時區,所以需將時區變更為en-US      

                        DateTime reserveDate = Lib.SysSetting.ToWorldDate(_date);
                        DateTime firstday = new DateTime(reserveDate.Year, 1, 1);
                        DateTime lastday = new DateTime(reserveDate.Year, 12, 31);
                        DateTime Start = new DateTime(reserveDate.Year, reserveDate.Month, 1);
                        DateTime End = Start.AddMonths(1).AddDays(-1);
                        DateTime Checkover = reserveDate.AddDays(-30);
                        SqlParameter p1 = new SqlParameter("message", SqlDbType.NVarChar, 50);
                        SqlParameter p2 = new SqlParameter("id", _id); //身份證號
                        SqlParameter p3 = new SqlParameter("gender", _gender);
                        SqlParameter p4 = new SqlParameter("birth", Convert.ToDateTime(_birth)); //生日
                        SqlParameter p5 = new SqlParameter("name", _name);
                        SqlParameter p6 = new SqlParameter("unit_code", _unit_code);
                        SqlParameter p7 = new SqlParameter("rank_code", _rank_code);
                        SqlParameter p8 = new SqlParameter("mail", _mail);
                        SqlParameter p9 = new SqlParameter("oversea", _oversea);
                        SqlParameter p10 = new SqlParameter("reserveDate", reserveDate);
                        SqlParameter p11 = new SqlParameter("center_code", _center);
                        SqlParameter p12 = new SqlParameter("op_id", _OP);
                        SqlParameter p13 = new SqlParameter("start", Start);
                        SqlParameter p14 = new SqlParameter("end", End);
                        SqlParameter p15 = new SqlParameter("checkover", Checkover);
                        SqlParameter p16 = new SqlParameter("firstday", firstday);
                        SqlParameter p17 = new SqlParameter("lastday", lastday);
                        p1.Direction = ParameterDirection.Output;
                        Lib.DataUtility du = new Lib.DataUtility();
                        List<SqlParameter> list = new List<SqlParameter>();
                        list.Add(p1);
                        list.Add(p2);
                        list.Add(p3);
                        list.Add(p4);
                        list.Add(p5);
                        list.Add(p6);
                        list.Add(p7);
                        list.Add(p8);
                        list.Add(p9);
                        list.Add(p10);
                        list.Add(p11);
                        list.Add(p12);
                        list.Add(p13);
                        list.Add(p14);
                        list.Add(p15);
                        list.Add(p16);
                        list.Add(p17);
                        SqlParameter[] sqls = list.ToArray();
                        du.executeNonQueryBysp("AddPlayerBySelf", sqls);

                        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString);
                        conn.Open();
                        SqlCommand comm = conn.CreateCommand();
                        SqlTransaction trans;
                        trans = conn.BeginTransaction("mytrans");
                        comm.Connection = conn;
                        comm.Transaction = trans;
                        DataTable dt_reserved = new DataTable();

                        string cwd = System.IO.Directory.GetCurrentDirectory();
                        string dd = Server.MapPath(Request.ApplicationPath);
                        MailMessage _MailToUser = new MailMessage();
                        StreamReader _MailContentToUser = new StreamReader(dd + "\\Mail\\SelfReserve.txt");

                        switch (p1.Value.ToString())
                        {
                            case "canreserve":
                                try
                                {
                                    comm.Parameters.Clear();
                                    SqlParameter _p2 = new SqlParameter("id", _id);
                                    SqlParameter _p5 = new SqlParameter("name", _name);
                                    SqlParameter _p4 = new SqlParameter("birth", Convert.ToDateTime(_birth));
                                    SqlParameter _p3 = new SqlParameter("gender", _gender);
                                    SqlParameter _p6 = new SqlParameter("unit_code", _unit_code);
                                    SqlParameter _p7 = new SqlParameter("rank_code", _rank_code);
                                    SqlParameter _p10 = new SqlParameter("reserveDate", reserveDate);
                                    SqlParameter _p11 = new SqlParameter("center_code", _center);
                                    SqlParameter _p12 = new SqlParameter("op_id", _OP);
                                    comm.Parameters.Add(_p2);
                                    comm.Parameters.Add(_p5);
                                    comm.Parameters.Add("age", Lib.SysSetting.ConvertAge(Convert.ToDateTime(_birth), reserveDate));
                                    comm.Parameters.Add(_p4);
                                    comm.Parameters.Add(_p3);
                                    comm.Parameters.Add(_p6);
                                    comm.Parameters.Add(_p7);
                                    comm.Parameters.Add(_p10);
                                    comm.Parameters.Add(_p11);
                                    comm.Parameters.Add(_p12);
                                    comm.CommandType = CommandType.Text;
                                    comm.CommandText = "insert into result (id,name,age,birth,gender,unit_code,rank_code,date,center_code,status,op_id,memo) values(@id,@name,@age,@birth,@gender,@unit_code,@rank_code,@reserveDate,@center_code,'000',@op_id,'999')";
                                    comm.ExecuteNonQuery();

                                    comm.Parameters.Clear();
                                    //comm.Parameters.Add(_p11);
                                    //comm.Parameters.Add(_p10);
                                    //comm.CommandText = "select count (id) as reserved,(select limit from center where center_code = @center_code) as limit from result where center_code = @center_code and date = @reserveDate ";
                                    comm.Parameters.Add("center_code", cneterSel.SelectedValue.ToString());
                                    comm.Parameters.Add("date", Lib.SysSetting.ToWorldDate(_date));
                                    comm.CommandType = CommandType.StoredProcedure;
                                    comm.CommandText = "Ex102_GetCenterLimit";
                                    dt_reserved.Load(comm.ExecuteReader());
                                    //if (((Convert.ToInt32(dt_reserved.Rows[0]["limit"].ToString()) - Convert.ToInt32(dt_reserved.Rows[0]["reserved"].ToString())) >= 0))
                                    if (Convert.ToInt32(dt_reserved.Rows[0]["allow"]) >= 0)
                                    {
                                        trans.Commit();
                                        this.canreserve.Style.Value = "";
                                        this.Nonenough.Style.Value = "display:none";
                                        this.ConnectError.Style.Value = "display:none";
                                        this.bereserve.Style.Value = "display:none";
                                        this.noreserve.Style.Value = "display:none";
                                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                        #region 通知受測人員
                                        _MailToUser.Body = _MailContentToUser.ReadToEnd();
                                        _MailToUser.Body = _MailToUser.Body.Replace("%date%", selectDate.Text);
                                        _MailToUser.Body = _MailToUser.Body.Replace("%location%", cneterSel.SelectedItem.Text);
                                        Lib.SysSetting.SaveLetter(((Lib.Player)Session["player"]).Mail + "@webmail.mil.tw", "國軍體能鑑測中心", _MailToUser.Body, "報進成功通知信", "00");
                                        Lib.SysSetting.AddLog("替代項目報進", ((Lib.Player)Session["player"]).ID, "報進成功 , 日期:" + selectDate.Text + " , 地點:" + cneterSel.SelectedItem.Text, System.DateTime.Now);
                                        #endregion
                                    }
                                    else
                                    {
                                        trans.Rollback();
                                        this.Nonenough.Style.Value = "";
                                        this.ConnectError.Style.Value = "display:none";
                                        this.canreserve.Style.Value = "display:none";
                                        this.bereserve.Style.Value = "display:none";
                                        this.noreserve.Style.Value = "display:none";
                                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                                    trans.Rollback();
                                }
                                finally
                                {
                                    trans.Dispose();
                                    conn.Close();
                                }
                                break;

                            case "againreserve":
                                try
                                {
                                    DataTable dt_again = new DataTable();
                                    comm.Parameters.Clear();
                                    SqlParameter _p10 = new SqlParameter("reserveDate", reserveDate);
                                    SqlParameter _p2 = new SqlParameter("id", _id);
                                    SqlParameter _p15 = new SqlParameter("checkover", Checkover);
                                    comm.Parameters.Add(_p2);
                                    comm.Parameters.Add(_p10);
                                    comm.Parameters.Add(_p15);
                                    comm.CommandType = CommandType.Text;
                                    comm.CommandText = "select top(1) id,center_code from result where (id = @id) AND (status = '205') AND (date BETWEEN @checkover AND @reserveDate) ORDER BY date DESC";
                                    dt_again.Load(comm.ExecuteReader());
                                    SqlParameter _p11 = new SqlParameter("center_code", dt_again.Rows[0]["center_code"].ToString());
                                    comm.Parameters.Add("age", Lib.SysSetting.ConvertAge(Convert.ToDateTime(_birth), reserveDate));
                                    comm.CommandText = "insert into result (id,name,age,birth,gender,unit_code,rank_code,date,center_code,result,status,memo,op_id,sit_ups,sit_ups_score,push_ups,push_ups_score,run,run_score)"
                                        + "select top(1) r.id,r.name,@age,r.birth,r.gender,r.unit_code,r.rank_code,@reserveDate,r.center_code,r.result,'000',r.memo,r.id,r.sit_ups,r.sit_ups_score,r.push_ups,r.push_ups_score,r.run,r.run_score from result r where (r.id = @id) AND (r.status = '205') AND (r.date BETWEEN @checkover AND @reserveDate) ORDER BY r.date DESC ";
                                    comm.ExecuteNonQuery();
                                    //comm.Parameters.Add(_p11);
                                    //comm.CommandText = "select count (id) as reserved,(select limit from center where center_code = @center_code) as limit from result where center_code = @center_code and date = @reserveDate ";
                                    comm.Parameters.Clear();
                                    comm.Parameters.Add("center_code", cneterSel.SelectedValue.ToString());
                                    comm.Parameters.Add("date", Lib.SysSetting.ToWorldDate(_date));
                                    comm.CommandType = CommandType.StoredProcedure;
                                    comm.CommandText = "Ex102_GetCenterLimit";
                                    dt_reserved.Load(comm.ExecuteReader());
                                    //if (((Convert.ToInt32(dt_reserved.Rows[0]["limit"].ToString()) - Convert.ToInt32(dt_reserved.Rows[0]["reserved"].ToString())) >= 0))
                                    if (Convert.ToInt32(dt_reserved.Rows[0]["allow"]) >= 0)
                                    {
                                        trans.Commit();
                                        this.againreserve.Style.Value = "";
                                        this.Nonenough.Style.Value = "display:none";
                                        this.ConnectError.Style.Value = "display:none";
                                        this.bereserve.Style.Value = "display:none";
                                        this.noreserve.Style.Value = "display:none";
                                        this.Div2.Style.Value = "display:none";
                                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                        #region 通知受測人員
                                        _MailToUser.Body = _MailContentToUser.ReadToEnd();
                                        _MailToUser.Body = _MailToUser.Body.Replace("%date%", selectDate.Text);
                                        _MailToUser.Body = _MailToUser.Body.Replace("%location%", cneterSel.SelectedItem.Text);
                                        Lib.SysSetting.SaveLetter(((Lib.Player)Session["player"]).Mail + "@webmail.mil.tw", "國軍基本體能鑑測網", _MailToUser.Body, "報進成功通知信", "00");
                                        #endregion
                                    }
                                    else
                                    {
                                        trans.Rollback();
                                        this.Nonenough.Style.Value = "";
                                        this.ConnectError.Style.Value = "display:none";
                                        this.canreserve.Style.Value = "display:none";
                                        this.bereserve.Style.Value = "display:none";
                                        this.noreserve.Style.Value = "display:none";
                                        this.Div2.Style.Value = "display:none";
                                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                                    trans.Rollback();
                                }
                                finally
                                {
                                    trans.Dispose();
                                    conn.Close();
                                }
                                break;
                            case "bereserve":
                                this.bereserve.Style.Value = "";
                                this.ConnectError.Style.Value = "display:none";
                                this.canreserve.Style.Value = "display:none";
                                this.againreserve.Style.Value = "display:none";
                                this.Nonenough.Style.Value = "display:none";
                                this.Div2.Style.Value = "display:none";
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                break;
                            case "beok":
                                this.ConnectError.Style.Value = "display:none";
                                this.beok.Style.Value = "";
                                this.canreserve.Style.Value = "display:none";
                                this.againreserve.Style.Value = "display:none";
                                this.Nonenough.Style.Value = "display:none";
                                this.Div2.Style.Value = "display:none";
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                break;
                            case "noreserve":
                                this.noreserve.Style.Value = "";
                                this.ConnectError.Style.Value = "display:none";
                                this.canreserve.Style.Value = "display:none";
                                this.againreserve.Style.Value = "display:none";
                                this.Nonenough.Style.Value = "display:none";
                                this.Div2.Style.Value = "display:none";
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                break;
                            case "noenough":
                                this.Nonenough.Style.Value = "";
                                this.ConnectError.Style.Value = "display:none";
                                this.canreserve.Style.Value = "display:none";
                                this.againreserve.Style.Value = "display:none";
                                this.Div2.Style.Value = "display:none";
                                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                                break;
                            default:
                                break;
                        }
                        GridView2.DataBind();
                        CultureInfo cii = new CultureInfo("zh-TW");
                        Thread.CurrentThread.CurrentCulture = cii;
                    }
                    catch (Exception ex)
                    {
                        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                        CultureInfo cii = new CultureInfo("zh-TW");
                        Thread.CurrentThread.CurrentCulture = cii;
                        this.ConnectError.Style.Value = "";
                        this.Div2.Style.Value = "display:none";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('此年度目前不開放報進 , 開放時系統將會公告');", true);
                }
            }
            else
            {
                this.Div2.Style.Value = "";
            }
        }
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
