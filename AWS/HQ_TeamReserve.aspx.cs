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
using Lib;

public partial class HQ_TeamReserve : System.Web.UI.Page
{
    private Dictionary<string, DateTime> allow;
    private Dictionary<string, DateTime> deny;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Lib.Account a = new Lib.Account();
            a = (Lib.Account)Session["account"];
            //Account a = (Account)Session["account"];
            string op_id = a.AccountName;
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
            Response.Redirect("index.aspx");
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
           // selectDate.Text = "";
            allow = Lib.SysSetting.getAllowedDates(this.cneterSel.SelectedValue);
            deny = Lib.SysSetting.getDeniedDates(this.cneterSel.SelectedValue);
            //if (e.Day.IsWeekend)//判斷是不是非工作日
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
                            if (e.Cell.Controls.Count != 0)
                            {
                                LiteralControl l = (LiteralControl)e.Cell.Controls[0];
                                e.Cell.Controls.RemoveAt(0);
                                e.Cell.Text = l.Text;
                            }
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
        //selectDate.Text = Calendar1.SelectedDate.ToShortDateString();
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
    //    Lib.Account a = new Lib.Account();
    //    a = (Lib.Account)Session["account"];
    //    string op_id = a.AccountName;
    //    if (DateTime.Now > DateTime.Today.AddHours(Lib.SysSetting.reserveTimeUnit.TotalHours))
    //    {
    //        SqlDataSource2.SelectParameters["date"].DefaultValue = DateTime.Today.AddDays(1).ToShortDateString();
    //        SqlDataSource2.SelectParameters["op_id"].DefaultValue = op_id;
    //    }
    //    else
    //    {
    //        SqlDataSource2.SelectParameters["date"].DefaultValue = DateTime.Today.ToShortDateString();
    //        SqlDataSource2.SelectParameters["op_id"].DefaultValue = op_id;
    //    }
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
        //將所有日期轉成民國年格式
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[0].Text);
        }
    }

    protected void GridView3_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        //將所有日期轉成民國年格式
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[2].Text = Lib.SysSetting.ToRocDateFormat(Convert.ToDateTime(e.Row.Cells[2].Text).ToShortDateString());
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        int Reserver_Count = 0;
        if (FileUpload1.HasFile)
        {
            if (Session["account"] != null)
            {
                if (Lib.SysSetting.CheckYear(Convert.ToDateTime(datehide.Value)))
                {
                    string _OP = ((Lib.Account)Session["account"]).AccountName;
                    string _date = datehide.Value;
                    Lib.DataUtility dux = new Lib.DataUtility();
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    d.Add("account", _OP);
                    d.Add("center_name", centerhide.Value);
                    DataTable unit_code = dux.getDataTableByText("select unit_code,(select c.center_code from Center c where c.center_name = @center_name) as center_code from Account where account = @account", d);
                    string _unit_code = unit_code.Rows[0]["unit_code"].ToString();
                    string _center = unit_code.Rows[0]["center_code"].ToString();
                    HttpPostedFile file = FileUpload1.PostedFile;
                    StreamReader reader = new StreamReader(file.InputStream);
                    Lib.DataUtility du = new Lib.DataUtility();
                    int count = 0;
                    List<SqlParameter> list = new List<SqlParameter>();
                    #region 宣告 DataTable()
                    DataTable CanAccess = new DataTable();
                    DataTable DenyAccess = new DataTable();
                    DataTable AgainAccess = new DataTable();
                    DataTable NoSameUnit = new DataTable();
                    DataTable Qualified = new DataTable();
                    DataTable BeReserved = new DataTable();
                    #endregion
                    #region 宣告CanAccess資料表欄位
                    //insert into result (id,name,age,birth,gender,unit_code,rank_code,date,center_code,status,op_id)
                    CanAccess.Columns.Add("身份證");
                    CanAccess.Columns.Add("姓名");
                    CanAccess.Columns.Add("生日");
                    CanAccess.Columns.Add("性別");
                    CanAccess.Columns.Add("單位代碼");
                    CanAccess.Columns.Add("軍階代碼");
                    CanAccess.Columns.Add("預約日期");
                    CanAccess.Columns.Add("鑑測站代碼");
                    CanAccess.Columns.Add("Mail");
                    CanAccess.Columns.Add("海外人員");
                    CanAccess.Columns.Add("團報者帳號");
                    #endregion
                    #region 宣告DenyAccess資料表欄位
                    DenyAccess.Columns.Add("身份證");
                    DenyAccess.Columns.Add("姓名");
                    DenyAccess.Columns.Add("生日");
                    DenyAccess.Columns.Add("性別");
                    DenyAccess.Columns.Add("單位代碼");
                    DenyAccess.Columns.Add("軍階代碼");
                    DenyAccess.Columns.Add("預約日期");
                    DenyAccess.Columns.Add("鑑測站代碼");
                    DenyAccess.Columns.Add("Mail");
                    DenyAccess.Columns.Add("海外人員");
                    DenyAccess.Columns.Add("團報者帳號");
                    DenyAccess.Columns.Add("報進失敗說明");
                    #endregion
                    #region 宣告AgainAccess資料表欄位
                    AgainAccess.Columns.Add("身份證");
                    AgainAccess.Columns.Add("姓名");
                    AgainAccess.Columns.Add("生日");
                    AgainAccess.Columns.Add("性別");
                    AgainAccess.Columns.Add("單位代碼");
                    AgainAccess.Columns.Add("軍階代碼");
                    AgainAccess.Columns.Add("預約日期");
                    AgainAccess.Columns.Add("鑑測站代碼");
                    AgainAccess.Columns.Add("Mail");
                    AgainAccess.Columns.Add("海外人員");
                    AgainAccess.Columns.Add("團報者帳號");
                    #endregion
                    #region 宣告NoSameUnit資料表欄位
                    NoSameUnit.Columns.Add("身份證");
                    NoSameUnit.Columns.Add("姓名");
                    NoSameUnit.Columns.Add("生日");
                    NoSameUnit.Columns.Add("性別");
                    NoSameUnit.Columns.Add("單位代碼");
                    NoSameUnit.Columns.Add("軍階代碼");
                    NoSameUnit.Columns.Add("預約日期");
                    NoSameUnit.Columns.Add("鑑測站代碼");
                    NoSameUnit.Columns.Add("Mail");
                    NoSameUnit.Columns.Add("海外人員");
                    NoSameUnit.Columns.Add("團報者帳號");
                    #endregion
                    #region 宣告Qualified資料表欄位
                    Qualified.Columns.Add("身份證");
                    Qualified.Columns.Add("姓名");
                    Qualified.Columns.Add("生日");
                    Qualified.Columns.Add("性別");
                    Qualified.Columns.Add("單位代碼");
                    Qualified.Columns.Add("軍階代碼");
                    Qualified.Columns.Add("預約日期");
                    Qualified.Columns.Add("鑑測站代碼");
                    Qualified.Columns.Add("Mail");
                    Qualified.Columns.Add("海外人員");
                    Qualified.Columns.Add("團報者帳號");
                    #endregion
                    #region 宣告BeReserved資料表欄位
                    BeReserved.Columns.Add("身份證");
                    BeReserved.Columns.Add("姓名");
                    BeReserved.Columns.Add("生日");
                    BeReserved.Columns.Add("性別");
                    BeReserved.Columns.Add("單位代碼");
                    BeReserved.Columns.Add("軍階代碼");
                    BeReserved.Columns.Add("預約日期");
                    BeReserved.Columns.Add("鑑測站代碼");
                    BeReserved.Columns.Add("Mail");
                    BeReserved.Columns.Add("海外人員");
                    BeReserved.Columns.Add("團報者帳號");
                    #endregion

                    CultureInfo ci_en = new CultureInfo("en-US");
                    Thread.CurrentThread.CurrentCulture = ci_en;  //資料庫中存放的datetime為西元時區,所以需將時區變更為en-US 

                    DateTime reserveDate = Lib.SysSetting.ToWorldDate(datehide.Value);
                    DateTime firstday = new DateTime(reserveDate.Year, 1, 1);
                    DateTime lastday = new DateTime(reserveDate.Year, 12, 31);
                    DateTime Start = new DateTime(reserveDate.Year, reserveDate.Month, 1);
                    DateTime End = Start.AddMonths(1).AddDays(-1);
                    DateTime Checkover = reserveDate.AddDays(-30);
                    try
                    {
                        while (reader.Peek() >= 0)
                        {
                            Reserver_Count++;
                            string result = reader.ReadLine();
                            try
                            {
                                string[] operater = { "," };
                                string[] info = result.Split(operater, StringSplitOptions.None);
                                if (info[0] != "身分證字號")
                                {
                                    //string 
                                    string _gender = "";
                                    char[] _id = info[0].ToCharArray();
                                    if (_id[1] == '1')
                                        _gender = "M";
                                    if (_id[1] == '2')
                                        _gender = "F";
                                    #region New SqlParameter
                                    SqlParameter p1 = new SqlParameter("message", SqlDbType.NVarChar, 50);
                                    SqlParameter p2 = new SqlParameter("id", info[0]);
                                    SqlParameter p3 = new SqlParameter("gender", _gender);
                                    SqlParameter p4 = new SqlParameter("birth", Lib.SysSetting.ToWorldDate(info[2]));
                                    SqlParameter p5 = new SqlParameter("name", info[1]);
                                    SqlParameter p6 = new SqlParameter("unit_code", info[4]);
                                    SqlParameter p7 = new SqlParameter("rank_code", info[5]);
                                    SqlParameter p8 = new SqlParameter("mail", info[3]);
                                    SqlParameter p9 = new SqlParameter("oversea", "0");
                                    SqlParameter p10 = new SqlParameter("reserveDate", reserveDate);
                                    SqlParameter p11 = new SqlParameter("center_code", _center);
                                    SqlParameter p12 = new SqlParameter("op_id", _OP);
                                    SqlParameter p13 = new SqlParameter("start", Start);
                                    SqlParameter p14 = new SqlParameter("end", End);
                                    SqlParameter p15 = new SqlParameter("checkover", Checkover);
                                    SqlParameter p16 = new SqlParameter("firstday", firstday);
                                    SqlParameter p17 = new SqlParameter("lastday", lastday);
                                    #endregion
                                    p1.Direction = ParameterDirection.Output;
                                    int age_check = Lib.SysSetting.ConvertAge(Lib.SysSetting.ToWorldDate(info[2]), reserveDate);
                                    if (info[0].Length == 10)
                                    {
                                        if (info[4] == _unit_code)
                                        {
                                            if (age_check >= 18)
                                            {
                                                list.Clear();
                                                #region List.Add SqlParameter
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
                                                #endregion

                                                SqlParameter[] sqls = list.ToArray();
                                                du.executeNonQueryBysp("AddPlayerByTeam", sqls);
                                                if (p1.Value.ToString() == "canreserve")
                                                {
                                                    CanAccess.Rows.Add(info[0], info[1], Lib.SysSetting.ToWorldDate(info[2]), _gender, info[4], info[5], reserveDate, _center, info[3], "0", _OP);
                                                }
                                                if (p1.Value.ToString() == "noreserve")
                                                {
                                                    DenyAccess.Rows.Add(info[0], info[1], Lib.SysSetting.ToWorldDate(info[2]), _gender, info[4], info[5], reserveDate, _center, info[3], "0", _OP, "此月份已測驗,請報進其他月份");
                                                }
                                                if (p1.Value.ToString() == "againreserve")
                                                {
                                                    DenyAccess.Rows.Add(info[0], info[1], Lib.SysSetting.ToWorldDate(info[2]), _gender, info[4], info[5], reserveDate, _center, info[3], "0", _OP, "您為30天內補測人員,請使用個人報進");
                                                }
                                                if (p1.Value.ToString() == "bereserve")
                                                {
                                                    DenyAccess.Rows.Add(info[0], info[1], Lib.SysSetting.ToWorldDate(info[2]), _gender, info[4], info[5], reserveDate, _center, info[3], "0", _OP, "您已有1筆預約,本次報進失敗");
                                                }
                                                if (p1.Value.ToString() == "beok")
                                                {
                                                    DenyAccess.Rows.Add(info[0], info[1], Lib.SysSetting.ToWorldDate(info[2]), _gender, info[4], info[5], reserveDate, _center, info[3], "0", _OP, "您已經是合格人員,本次報進失敗");
                                                }
                                            }
                                            else
                                            {
                                                DenyAccess.Rows.Add(info[0], info[1], Lib.SysSetting.ToWorldDate(info[2]), _gender, info[4], info[5], reserveDate, _center, info[3], "0", _OP, "生日請使用民國格式");
                                            }
                                        }
                                        else
                                        {
                                            DenyAccess.Rows.Add(info[0], info[1], Lib.SysSetting.ToWorldDate(info[2]), _gender, info[4], info[5], reserveDate, _center, info[3], "0", _OP, "單位代碼錯誤");
                                        }
                                    }
                                    else
                                    {
                                        error_format.Text = error_format.Text + info[0] + "," + info[1] + "<br/>";
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                                error_format.Text = error_format.Text + result + "<br/>";
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('資料格式不符 , 請重新檢查');", true);
                    }
                    #region 控制資料表的顯示,且將允許報名的資料做報名的動作

                    ci_en = new CultureInfo("en-US");
                    Thread.CurrentThread.CurrentCulture = ci_en;  //資料庫中存放的datetime為西元時區,所以需將時區變更為en-US    
                    if (CanAccess.Rows.Count > 0)
                    {
                        list.Clear();
                        Lib.DataUtility _du = new Lib.DataUtility();
                        string _v = CanAccess.Rows[0]["預約日期"].ToString();
                        SqlParameter pp1 = new SqlParameter("message", SqlDbType.NVarChar, 50);
                        SqlParameter pp2 = new SqlParameter("center_code", _center);
                        SqlParameter pp3 = new SqlParameter("date", Convert.ToDateTime(_v));
                        SqlParameter pp4 = new SqlParameter("wanted", CanAccess.Rows.Count);
                        list.Add(pp1);
                        list.Add(pp2);
                        list.Add(pp3);
                        list.Add(pp4);
                        SqlParameter[] sqlss = list.ToArray();
                        pp1.Direction = ParameterDirection.Output;
                        _du.executeNonQueryBysp("CheckCenterLimit", sqlss);
                        if (pp1.Value.ToString() == "No")
                        {
                            Re_Success_Count.Text = "0人";
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('餘額不足 , 無法預約');", true);
                        }
                        else if (pp1.Value.ToString() == "Yes") //pp1.Value.ToString() == "Yes"
                        {
                            Lib.DataUtility _DataUtility = new Lib.DataUtility();
                            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString);
                            conn.Open();
                            SqlCommand comm = conn.CreateCommand();
                            SqlTransaction trans;
                            trans = conn.BeginTransaction("mytrans");
                            comm.Connection = conn;
                            comm.Transaction = trans;
                            try
                            {
                                for (int i = 0; i < CanAccess.Rows.Count; i++)
                                {
                                    try
                                    {
                                        comm.Parameters.Clear();
                                        SqlParameter _p1 = new SqlParameter("id", CanAccess.Rows[i]["身份證"]);
                                        SqlParameter _p2 = new SqlParameter("gender", CanAccess.Rows[i]["性別"]);
                                        SqlParameter _p3 = new SqlParameter("birth", Convert.ToDateTime(CanAccess.Rows[i]["生日"]));//不能複蓋
                                        SqlParameter _p4 = new SqlParameter("name", CanAccess.Rows[i]["姓名"]);//不能覆蓋
                                        SqlParameter _p5 = new SqlParameter("unit_code", CanAccess.Rows[i]["單位代碼"]);
                                        SqlParameter _p6 = new SqlParameter("rank_code", CanAccess.Rows[i]["軍階代碼"]);
                                        SqlParameter _p7 = new SqlParameter("mail", CanAccess.Rows[i]["Mail"]);//不能覆蓋
                                        SqlParameter _p8 = new SqlParameter("oversea", CanAccess.Rows[i]["海外人員"]);
                                        SqlParameter _p9 = new SqlParameter("reserveDate", Convert.ToDateTime(CanAccess.Rows[i]["預約日期"]));
                                        SqlParameter _p10 = new SqlParameter("center_code", CanAccess.Rows[i]["鑑測站代碼"]);
                                        SqlParameter _p11 = new SqlParameter("op_id", CanAccess.Rows[i]["團報者帳號"]);
                                        SqlParameter _p12 = new SqlParameter("age", Lib.SysSetting.ConvertAge(Convert.ToDateTime(CanAccess.Rows[i]["生日"]), Convert.ToDateTime(CanAccess.Rows[i]["預約日期"])));

                                        comm.Parameters.Add(_p1);
                                        comm.Parameters.Add(_p2);
                                        //如果改Rresult不依據player資料則上面二個不mark
                                        comm.Parameters.Add(_p3);
                                        comm.Parameters.Add(_p4);
                                        comm.Parameters.Add(_p5);
                                        comm.Parameters.Add(_p6);
                                        comm.Parameters.Add(_p7);
                                        comm.Parameters.Add(_p8);
                                        comm.Parameters.Add(_p9);
                                        comm.Parameters.Add(_p10);
                                        comm.Parameters.Add(_p11);
                                        comm.Parameters.Add(_p12);

                                        //2016-12-8最終大改版 一隻sp作掉
                                        comm.CommandType = CommandType.StoredProcedure;
                                        comm.CommandText = "Ex106_TeamReserve";
                                        comm.ExecuteNonQuery();
                                        //以上大改版，三行解決


                                        //comm.CommandType = CommandType.Text;
                                        //comm.CommandTyp = CommandType.StoredProcedure;
                                        
                                        
                                        //-----------版本1：團報時Result依照player資料為主------------
                                        //2016-12-6，測試把player的資料放到result
                                        //comm.Parameters.AddWithValue("id", CanAccess.Rows[i]["身份證"].ToString());
                                        //comm.CommandText = "select top 1 id,name,birth from player where id=@id";
                                        //DataTable dt1 = new DataTable();
                                        //dt1.Load(comm.ExecuteReader());
                                        //if (dt1.Rows.Count > 0)//有此id，更新資料
                                        //{
                                        //    comm.CommandText = "update Player set unit_code=@unit_code,rank_code=@rank_code,oversea=@oversea";
                                        //    comm.ExecuteNonQuery();
                                        //    //更新player資料測試
                                        //    if (!string.IsNullOrEmpty(dt1.Rows[0]["birth"].ToString()))//值不是空的才把player資料覆蓋過來
                                        //    _p3 = new SqlParameter("birth", Convert.ToDateTime(dt1.Rows[0]["birth"]));//不能複蓋
                                        //    if (!string.IsNullOrEmpty(dt1.Rows[0]["name"].ToString()))//值不是空的才把player資料覆蓋過來
                                        //        _p4 = new SqlParameter("name", dt1.Rows[0]["name"]);//不能覆蓋
                                        //    comm.Parameters.Add(_p3);
                                        //    comm.Parameters.Add(_p4);
                                            
                                        //}
                                        //else//無此id，直接新增
                                        //{
                                        //    comm.Parameters.Add(_p3);
                                        //    comm.Parameters.Add(_p4);
                                        //    comm.CommandText = "insert into player (id,gender,birth,name,unit_code,rank_code,mail,oversea) values (@id,@gender,@birth,@name,@unit_code,@rank_code,@mail,@oversea)";
                                        //    comm.ExecuteNonQuery();
                                        //}
                                        //-----------------以上為版本1---------------------
                                        

                                        //------------版本2:Result資料依照團報資料，Player一樣不覆蓋--------
                                        ////先mark，測試如果player有資料就直接抓來用
                                        ////2016-9-5更新較佳的方法(IF EXISTS ELSE)
                                        ////直接用sql判斷是否有該比資料，如果有就只更新單位、級職代碼，若沒有就新增一筆帳號。
                                        //comm.CommandText = "IF EXISTS (select * from Player where id=@id) update Player set unit_code=@unit_code,rank_code=@rank_code where id=@id ELSE insert into Player (id,name,gender,birth,mail,unit_code,rank_code,oversea) values(@id,@name,@gender,@birth,@mail,@unit_code,@rank_code,@oversea)";
                                        //comm.ExecuteNonQuery();
                                        ////以上先mark


                                        //原本處理Player表格方式先刪除資料再重新塞入資料(舊版-先mark)
                                        //comm.CommandText = "delete from player where id = @id";
                                        //comm.ExecuteNonQuery();
                                        //comm.CommandText = "insert into player (id,gender,birth,name,unit_code,rank_code,mail,oversea) values (@id,@gender,@birth,@name,@unit_code,@rank_code,@mail,@oversea)";
                                        //comm.ExecuteNonQuery();
                                        //----------------以上為版本2--------------------


                                        //處理Result表格(保留)
                                        //comm.CommandText = "delete from result where id = @id and date = @reserveDate";
                                        //comm.ExecuteNonQuery();
                                        //comm.CommandText = "insert into result (id,name,age,birth,gender,unit_code,rank_code,date,center_code,status,op_id) values(@id,@name,@age,@birth,@gender,@unit_code,@rank_code,@reserveDate,@center_code,'000',@op_id) ";
                                        //comm.ExecuteNonQuery();
                                        
                                    }
                                    catch (Exception ex)
                                    {
                                        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                                        error_format.Text = error_format.Text + CanAccess.Rows[i]["身份證"] + "," + CanAccess.Rows[i]["姓名"] + "<br/>";
                                        CanAccess.Rows.RemoveAt(i);
                                        i--;
                                    }
                                }
                                list.Clear();
                                string _vv = CanAccess.Rows[0]["預約日期"].ToString();
                                DataTable dt_reserved = new DataTable();
                                comm.Parameters.Clear();
                                comm.Parameters.Add("center_code", _center);
                                comm.Parameters.Add("date", Convert.ToDateTime(_vv));
                                comm.CommandType = CommandType.StoredProcedure;
                                comm.CommandText = "Ex102_GetCenterLimit";
                                dt_reserved.Load(comm.ExecuteReader());
                                //comm.CommandText = "select count (id) as reserved,(select limit from center where center_code = @center_code) as limit from result where center_code = @center_code and date = @date";
                                //dt_reserved.Load(comm.ExecuteReader());
                                //if (((Convert.ToInt32(dt_reserved.Rows[0]["limit"].ToString()) - Convert.ToInt32(dt_reserved.Rows[0]["reserved"].ToString())) >= 0))
                                if (Convert.ToInt32(dt_reserved.Rows[0]["allow"]) >= 0)
                                {
                                    trans.Commit();
                                    trans.Dispose();
                                    conn.Close();
                                    #region  寫Log
                                    CultureInfo ci = new CultureInfo("zh-TW");
                                    Thread.CurrentThread.CurrentCulture = ci;
                                    #endregion
                                    //寫入Result
                                    //使用迴圈一筆一筆寫入
                                    //資料來源為CanAccess    

                                    #region 通知受測人員
                                    string cwd = System.IO.Directory.GetCurrentDirectory();
                                    string dd = Server.MapPath(Request.ApplicationPath);
                                    string _detailtable = "";
                                    for (int i = 0; i < CanAccess.Rows.Count; i++)
                                    {
                                        _detailtable = _detailtable + "<tr><td>" + CanAccess.Rows[i]["姓名"] + "</td><td>" + CanAccess.Rows[i]["身份證"] + "</td><td>" + Lib.SysSetting.ToRocDateFormat(CanAccess.Rows[i]["生日"].ToString().Remove(9)) + "</td><td>" + CanAccess.Rows[i]["軍階代碼"] + "</td><td>" + CanAccess.Rows[i]["Mail"] + "</td></tr>";

                                        MailMessage _MailToUser = new MailMessage();
                                        StreamReader _MailContentToUser = new StreamReader(dd + "\\Mail\\TeamReserveUser.txt");
                                        //_MailToUser.Body = _MailContent.ReadToEnd().Replace("%detail%", _detailtable);
                                        _MailToUser.Body = _MailContentToUser.ReadToEnd();
                                        _MailToUser.Body = _MailToUser.Body.Replace("%date%", datehide.Value);
                                        _MailToUser.Body = _MailToUser.Body.Replace("%location%", centerhide.Value);
                                        Lib.SysSetting.SaveLetter(CanAccess.Rows[i]["Mail"] + "@webmail.mil.tw", "國軍基本體能鑑測網", _MailToUser.Body, "報進成功通知信", "00");
                                    }
                                    #endregion

                                    #region 通知團報負責人
                                    MailMessage _Mail = new MailMessage();
                                    StreamReader _MailContent = new StreamReader(dd + "\\Mail\\TeamReserveManger.txt");
                                    _Mail.Body = _MailContent.ReadToEnd().Replace("%detail%", _detailtable);
                                    _Mail.Body = _Mail.Body.Replace("%date%", datehide.Value);
                                    _Mail.Body = _Mail.Body.Replace("%location%", centerhide.Value);
                                    _Mail.Body = _Mail.Body.Replace("%total%", CanAccess.Rows.Count.ToString());
                                    Lib.SysSetting.SaveLetter(((Lib.Account)Session["account"]).Mail + "@webmail.mil.tw", "國軍基本體能鑑測網", _Mail.Body, "報進成功通知信", "00");
                                    Lib.SysSetting.AddLog("團體報進", _OP, "報進成功 , 日期:" + datehide.Value + " , 地點:" + centerhide.Value + " , 預約人數" + CanAccess.Rows.Count + "人", System.DateTime.Now);
                                    #endregion

                                    CanAccess.Columns.Remove("鑑測站代碼");
                                    CanAccess.Columns.Remove("海外人員");
                                    CanAccess.Columns.Remove("團報者帳號");
                                    CanAccess.Columns.Remove("預約日期");
                                    GridView1.DataSource = CanAccess;
                                    GridView1.DataBind();
                                    GridView1.Visible = true;
                                    Re_Success_Count.Text = CanAccess.Rows.Count.ToString() + "人";
                                }
                                else
                                {
                                    trans.Rollback();
                                    trans.Dispose();
                                    conn.Close();
                                    Re_Success_Count.Text = "0人";
                                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('餘額不足 , 無法預約');", true);
                                }
                            }
                            catch (Exception ex)
                            {
                                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                                trans.Rollback();
                                trans.Dispose();
                                conn.Close();
                                Re_Success_Count.Text = "0人";
                            }
                        }
                    }

                    DenyAccess.Columns.Remove("鑑測站代碼");
                    DenyAccess.Columns.Remove("海外人員");
                    DenyAccess.Columns.Remove("團報者帳號");
                    DenyAccess.Columns.Remove("預約日期");
                    GridView3.DataSource = DenyAccess;
                    GridView3.DataBind();
                    GridView3.Visible = true;
                    CultureInfo cii = new CultureInfo("zh-TW");
                    Thread.CurrentThread.CurrentCulture = cii;
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "$.unblockUI();$('#aspnetForm')[0].submit();", true);
                    Re_fail_Count.Text = DenyAccess.Rows.Count.ToString() + "人";
                    Re_Count.Text = (Reserver_Count - 1).ToString();
                    this.SuccessDetails.Style.Value = "";
                    this.failDatails.Style.Value = "";
                    this.OrderStep1.Style.Value = "display:none";
                    this.SureOrder.Style.Value = "display:none";
                    this.SureTimeAndPlace.Style.Value = "display:none";
                    this.Result.Style.Value = "";
                    this.Div2.Style.Value = "";
                    this.ReturnStep1.Style.Value = "";
                    Re_surecenter.Text = centerhide.Value;
                    Re_suredate.Text = datehide.Value;
                    #endregion

                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('此年度目前不開放報進 , 開放時系統將會公告');", true);
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
    protected void cneterSel_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectDate.Text = "";
        Calendar1.SelectedDates.Clear();
    }
}
