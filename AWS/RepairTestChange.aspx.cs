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

public partial class RepairTestChange : System.Web.UI.Page
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
                d.Add("op_id", ((Lib.Player)Session["player"]).ID);
                DataTable dt = du.getDataTableByText("select count(id) as count,(select center_name from Center where center_code = @center_code) as center_name from result where center_code = @center_code and date = @date and id =@op_id", d);
                oldcount.Text = dt.Rows[0]["count"].ToString();
                oldcenter.Text = dt.Rows[0]["center_name"].ToString();
                olddate.Text = (Convert.ToInt32(Request.QueryString["date"].ToString().Trim().Substring(0, Request.QueryString["date"].ToString().Trim().Length - 6)) - 1911).ToString() + Request.QueryString["date"].ToString().Trim().Substring(4, Request.QueryString["date"].ToString().Trim().Length - 4);

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
        else
        {

        }
    }

    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
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
            selectDate.Text = Calendar1.SelectedDate.ToShortDateString();
            TabContainer1.ActiveTabIndex = 0;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string _selectdate = selectDate.Text;
        if (Session["player"] != null && Request.QueryString["center_code"] != null && Request.QueryString["center_code"] != "" && Request.QueryString["date"] != null && Request.QueryString["date"] != "")
        {
            CultureInfo ci_en = new CultureInfo("en-US");
            Thread.CurrentThread.CurrentCulture = ci_en;
            Dictionary<string, object> d = new Dictionary<string, object>();
            DateTime reserveDate = Convert.ToDateTime(Request.QueryString["date"].ToString().Trim());
            DateTime Checkover = reserveDate.AddDays(-30);
            Lib.DataUtility du = new Lib.DataUtility();
            d.Add("id", ((Lib.Player)Session["player"]).ID);
            d.Add("reserveDate", reserveDate);
            d.Add("checkover", Checkover);
            DataTable dt_again = du.getDataTableByText("select count(id) as count from result where id = @id and status = '205' AND date BETWEEN @checkover AND @reserveDate", d);
            if (Convert.ToInt32(dt_again.Rows[0]["count"].ToString()) == 0)
            {   //檢查是否有補測人員
                DateTime newreserveDate = Lib.SysSetting.ToWorldDate(_selectdate);
                DateTime newCheckover = newreserveDate.AddDays(-30);
                DateTime firstday = new DateTime(newreserveDate.Year, 1, 1);
                DateTime lastday = new DateTime(newreserveDate.Year, 12, 31);
                DateTime Start = new DateTime(newreserveDate.Year, newreserveDate.Month, 1);
                DateTime End = Start.AddMonths(1).AddDays(-1);
                SqlParameter _p1 = new SqlParameter("message", SqlDbType.NVarChar, 50);
                SqlParameter _p2 = new SqlParameter("id", ((Lib.Player)Session["player"]).ID);
                SqlParameter _p3 = new SqlParameter("reserveDate", newreserveDate);
                SqlParameter _p4 = new SqlParameter("start", Start);
                SqlParameter _p5 = new SqlParameter("end", End);
                SqlParameter _p6 = new SqlParameter("checkover", newCheckover);
                SqlParameter _p7 = new SqlParameter("firstday", firstday);
                SqlParameter _p8 = new SqlParameter("lastday", lastday);
                _p1.Direction = ParameterDirection.Output;
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(_p1);
                list.Add(_p2);
                list.Add(_p3);
                list.Add(_p4);
                list.Add(_p5);
                list.Add(_p6);
                list.Add(_p7);
                list.Add(_p8);
                SqlParameter[] sqls = list.ToArray();
                du.executeNonQueryBysp("ChangePlayerByRepair", sqls);

                switch (_p1.Value.ToString())
                {
                    case "canreservefromno":
                        Boolean isCenter = false;
                        Boolean isOverTime = false;
                        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString);
                        conn.Open();
                        SqlCommand comm = conn.CreateCommand();
                        SqlTransaction trans;
                        trans = conn.BeginTransaction("mytrans");
                        comm.Connection = conn;
                        comm.Transaction = trans;
                        DataTable dt = new DataTable();
                        DataTable dt_center = new DataTable();
                        try
                        {

                            SqlParameter p4 = new SqlParameter("center_code", Request.QueryString["center_code"].ToString().Trim());
                            SqlParameter p5 = new SqlParameter("new_center_code", cneterSel.SelectedValue.ToString());
                            SqlParameter p6 = new SqlParameter("id", ((Lib.Player)Session["player"]).ID);
                            comm.Parameters.Add(p4);
                            comm.Parameters.Add(p5);
                            comm.Parameters.Add(p6);
                            comm.CommandText = "select top(1) memo from result where id = @id ORDER BY date DESC";
                            //comm.CommandText = "select top(1) (select IsSwin from Center where center_code = @center_code) as IsSwin ,  (select IsSwin from Center where center_code = @new_center_code) as new_IsSwin ,r.memo from result r where r.id = @id ORDER BY date DESC";
                            dt_center.Load(comm.ExecuteReader());
                            DataTable dt_center_ok = Lib.SysSetting.GetCenterFromMemo(dt_center.Rows[0]["memo"].ToString());
                            foreach (DataRow dr in dt_center_ok.Rows)
                            {
                                if (dr["center_code"].ToString() == cneterSel.SelectedValue.ToString())
                                {
                                    isCenter = true;
                                }
                            }
                            //if (dt_center.Rows[0]["memo"].ToString() == "000")
                            //{
                            //    isCenter = true;
                            //}
                            //else
                            //{
                            //    if (Convert.ToBoolean(dt_center.Rows[0]["IsSwin"]))
                            //    {
                            //        if (dt_center.Rows[0]["IsSwin"].ToString() == dt_center.Rows[0]["new_IsSwin"].ToString())
                            //        {
                            //            isCenter = true;
                            //        }
                            //        else
                            //        {
                            //            isCenter = false;
                            //        }
                            //    }
                            //    else //之前選擇的鑑測站沒有游泳池,所以可以任意選擇新的鑑測站
                            //    {
                            //        isCenter = true;
                            //    }
                            //}

                            if (isCenter)
                            {
                                DataTable dt_result = new DataTable();
                                DateTime _reserveDate = Lib.SysSetting.ToWorldDate(_selectdate);
                                //DateTime firstday = new DateTime(_reserveDate.Year, 1, 1);
                                //DateTime lastday = new DateTime(_reserveDate.Year, 12, 31);
                                SqlParameter p7 = new SqlParameter("firstday", firstday);
                                SqlParameter p8 = new SqlParameter("lastday", lastday);
                                SqlParameter p9 = new SqlParameter("id", ((Lib.Player)Session["player"]).ID);
                                comm.Parameters.Clear();
                                comm.Parameters.Add(p7);
                                comm.Parameters.Add(p8);
                                comm.Parameters.Add(p9);
                                comm.CommandText = "select count(id) from result where (status in ('203','204','205')) and (id = @id) and ( date BETWEEN @firstday and @lastday)";
                                dt_result.Load(comm.ExecuteReader());
                                int _count = Convert.ToInt32(dt_result.Rows[0][0]);
                                if (_count > 0)
                                {
                                    isOverTime = false;
                                }
                                else
                                {
                                    isOverTime = true;
                                }

                                if (!isOverTime)
                                {
                                    comm.Parameters.Clear();
                                    SqlParameter p1 = new SqlParameter("date", Convert.ToDateTime(Request.QueryString["date"].ToString().Trim()));
                                    SqlParameter p2 = new SqlParameter("center_code", Request.QueryString["center_code"].ToString().Trim());
                                    SqlParameter p3 = new SqlParameter("op_id", ((Lib.Player)Session["player"]).ID);
                                    comm.Parameters.Add(p1);
                                    comm.Parameters.Add(p2);
                                    comm.Parameters.Add(p3);
                                    comm.CommandText = "select sid,birth from Result where date = @date and center_code = @center_code and id = @op_id and status = '000'";
                                    dt.Load(comm.ExecuteReader());  //抓出要變更的那筆預約
                                    for (int i = 0; i < dt.Rows.Count; i++)
                                    {
                                        comm.Parameters.Clear();
                                        comm.Parameters.Add("age", Lib.SysSetting.ConvertAge(Convert.ToDateTime(dt.Rows[i]["birth"]), Lib.SysSetting.ToWorldDate(_selectdate)));
                                        comm.Parameters.Add("date", Lib.SysSetting.ToWorldDate(_selectdate));
                                        comm.Parameters.Add("center_code", cneterSel.SelectedValue.ToString());
                                        comm.Parameters.Add("op_id", ((Lib.Player)Session["player"]).ID);
                                        comm.Parameters.Add("sid", dt.Rows[i]["sid"].ToString());
                                        comm.CommandText = "UPDATE Result SET age = @age, date = @date, center_code = @center_code where sid = @sid and id = @op_id ";
                                        comm.ExecuteNonQuery();
                                    }
                                    DataTable dt_reserved = new DataTable();  //計算選定的鑑測站與鑑測日期所剩餘的人數
                                    comm.Parameters.Clear();
                                    comm.Parameters.Add("center_code", cneterSel.SelectedValue.ToString());
                                    comm.Parameters.Add("date", Lib.SysSetting.ToWorldDate(_selectdate));
                                    comm.CommandText = "select count (id) as reserved,(select limit from center where center_code = @center_code) as limit from result where center_code = @center_code and date = @date";
                                    dt_reserved.Load(comm.ExecuteReader());
                                    if (((Convert.ToInt32(dt_reserved.Rows[0]["limit"].ToString()) - Convert.ToInt32(dt_reserved.Rows[0]["reserved"].ToString())) >= 0))
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
                                        this.AgaginError.Style.Value = "display:none";
                                        this.nonecenter.Style.Value = "display:none";
                                        this.noreserve.Style.Value = "display:none";
                                        this.overtime.Style.Value = "display:none";
                                        this.ConnectError.Style.Value = "display:none";
                                        #region 通知受測人員變更報進
                                        MailMessage _MailToUser = new MailMessage();
                                        StreamReader _MailContentToUser = new StreamReader(Server.MapPath(Request.ApplicationPath) + "\\Mail\\UpdateSelfReserve.txt");
                                        _MailToUser.Body = _MailContentToUser.ReadToEnd();
                                        _MailToUser.Body = _MailToUser.Body.Replace("%olddate%", olddate.Text);
                                        _MailToUser.Body = _MailToUser.Body.Replace("%oldlocation%", oldcenter.Text);
                                        _MailToUser.Body = _MailToUser.Body.Replace("%newdate%", newdate.Text);
                                        _MailToUser.Body = _MailToUser.Body.Replace("%newlocation%", newcenter.Text);
                                        Lib.SysSetting.SaveLetter(((Lib.Player)Session["player"]).Mail + "@webmail.mil.tw", "國軍基本體能鑑測網", _MailToUser.Body, "報進變更通知信", "00");
                                        #endregion
                                    }
                                    else
                                    {
                                        trans.Rollback();
                                        this.Nonenough.Style.Value = "";
                                        this.Div1.Style.Value = "display:none";
                                        this.nonecenter.Style.Value = "display:none";
                                        this.noreserve.Style.Value = "display:none";
                                        this.overtime.Style.Value = "display:none";
                                        this.ConnectError.Style.Value = "display:none";
                                        this.AgaginError.Style.Value = "display:none";
                                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('餘額不足 , 無法預約');", true);
                                    }
                                }
                                else //超過可接受的補測時間,不可選擇跨年度
                                {
                                    trans.Rollback();
                                    this.overtime.Style.Value = "";
                                    this.Div1.Style.Value = "display:none";
                                    this.nonecenter.Style.Value = "display:none";
                                    this.noreserve.Style.Value = "display:none";
                                    this.Nonenough.Style.Value = "display:none";
                                    this.ConnectError.Style.Value = "display:none";
                                    this.AgaginError.Style.Value = "display:none";
                                }
                            }
                            else //使用者變更的鑑測站與原本選擇的鑑測站在可接受的鑑測項目上有差異
                            {
                                trans.Rollback();
                                this.nonecenter.Style.Value = "";
                                this.Div1.Style.Value = "display:none";
                                this.overtime.Style.Value = "display:none";
                                this.noreserve.Style.Value = "display:none";
                                this.Nonenough.Style.Value = "display:none";
                                this.ConnectError.Style.Value = "display:none";
                                this.AgaginError.Style.Value = "display:none";
                            }
                        }
                        catch (Exception ex)
                        {
                            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                            trans.Rollback();
                            this.Div1.Style.Value = "";
                            this.nonecenter.Style.Value = "display:none";
                            this.overtime.Style.Value = "display:none";
                            this.noreserve.Style.Value = "display:none";
                            this.Nonenough.Style.Value = "display:none";
                            this.ConnectError.Style.Value = "display:none";
                            this.AgaginError.Style.Value = "display:none";
                            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('網路連線異常 , 請重新作業');", true);
                        }
                        finally
                        {
                            trans.Dispose();
                            conn.Close();
                        }
                        break;
                    case "againreserve":
                        this.AgaginError.Style.Value = "";
                        this.Div1.Style.Value = "display:none";
                        this.overtime.Style.Value = "display:none";
                        this.nonecenter.Style.Value = "display:none";
                        this.Nonenough.Style.Value = "display:none";
                        this.ConnectError.Style.Value = "display:none";
                        this.noreserve.Style.Value = "display:none";
                        break;
                    
                    case "noreserve":
                        this.noreserve.Style.Value = "";
                        this.Div1.Style.Value = "display:none";
                        this.overtime.Style.Value = "display:none";
                        this.nonecenter.Style.Value = "display:none";
                        this.Nonenough.Style.Value = "display:none";
                        this.ConnectError.Style.Value = "display:none";
                        this.AgaginError.Style.Value = "display:none";
                        break;
                }
            }
            else
            {
                this.AgaginError.Style.Value = "";
                this.Div1.Style.Value = "display:none";
                this.overtime.Style.Value = "display:none";
                this.nonecenter.Style.Value = "display:none";
                this.Nonenough.Style.Value = "display:none";
                this.ConnectError.Style.Value = "display:none";
                this.noreserve.Style.Value = "display:none";
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
}
