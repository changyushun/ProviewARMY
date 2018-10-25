using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using Lib;

public partial class UpdateSealtime : System.Web.UI.Page
{
    static string PrevSID = string.Empty;
    static string ThisSID = string.Empty;
    static string NextSID = string.Empty;
    static string Acc = string.Empty;
    static string old_time=string.Empty;
    static string old_unit = string.Empty;
    static string old_rank = string.Empty;
    static string old_name = string.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        Image1.ImageUrl = "~/images/106_Seal_Sample.JPG";
        Acc = Request.QueryString["Acc"].ToString();
        if (Page.IsPostBack == false)
        {
            hf_StartTime.Value = Label8.Text;
            hf_EndTime.Value = Label9.Text;
            //hf_start.Value = "2015/01/01";

            Dictionary<string, object> d = new Dictionary<string, object>();
            Lib.DataUtility du = new Lib.DataUtility();
            d.Add("sid", Request.QueryString["sid"].ToString());
            d.Add("center_code", Request.QueryString["centercode"].ToString());
            //DataTable dt = du.getDataTableByText("SELECT P.PrevSID,P.start1_date,P.end1_date,T.ThisSID,T.start2_date,T.end2_date, N.NextSID,N.start3_date,N.end3_date FROM ( SELECT MAX(A.sid) PrevSID, (select start_date FROM Center_Seal where sid = MAX(A.sid)) start1_date,(select end_date FROM Center_Seal where sid = MAX(A.sid)) end1_date from Center_Seal A where A.sid < @sid and A.center_code = @center_code and A.rank_code=(select rank_code from Center_Seal where sid=@sid)) P CROSS JOIN ( SELECT MAX(A.sid) ThisSID, (select start_date FROM Center_Seal where sid = MAX(A.sid)) start2_date,(select end_date FROM Center_Seal where sid = MAX(A.sid)) end2_date from Center_Seal A where A.sid = @sid and A.center_code = @center_code and A.rank_code=(select rank_code from Center_Seal where sid=@sid)) T CROSS JOIN( SELECT MIN(A.sid) NextSID, (select start_date FROM Center_Seal where sid = MIN(A.sid)) start3_date,(select end_date FROM Center_Seal where sid = MAX(A.sid)) end3_date from Center_Seal A where A.sid > @sid and A.center_code = @center_code and A.rank_code=(select rank_code from Center_Seal where sid=@sid)) N ",d);
            //2016-8-16改用sp
            DataTable dt = du.getDataTableBysp("Ex106_Update_Seal", d);
            //前一筆：PrevSID、start1_date、end1_date
            //當筆：ThisSID、start2_date、end2_date
            //後一筆：NextSID、start3_date、end3_date
            //d.Add("start_date", dt.Rows[0]["start_date"]);

            //沒前面一筆，有當筆，沒有後一筆(010)(最前面一筆，只有一筆)
            if (string.IsNullOrEmpty(dt.Rows[0]["PrevSID"].ToString()) & !string.IsNullOrEmpty(dt.Rows[0]["ThisSID"].ToString()) & string.IsNullOrEmpty(dt.Rows[0]["NextSID"].ToString()))
            {
                //設定時間
                PrevSID = dt.Rows[0]["PrevSID"].ToString();
                ThisSID = dt.Rows[0]["ThisSID"].ToString();
                NextSID = dt.Rows[0]["NextSID"].ToString();

                DateTime Now_startTime = (DateTime)dt.Rows[0]["start2_date"];
                Label6.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox1.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox2.Text = dt.Rows[0]["sing_unit"].ToString();
                TextBox3.Text = dt.Rows[0]["sing_rank"].ToString();
                TextBox4.Text = dt.Rows[0]["sing_name"].ToString();
                old_time = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                old_unit = dt.Rows[0]["sing_unit"].ToString();
                old_rank = dt.Rows[0]["sing_rank"].ToString();
                old_name = dt.Rows[0]["sing_name"].ToString();
                DateTime Today = DateTime.Now;
                Label8.Text = "106/01/01";
                Label9.Text = Lib.SysSetting.ToRocDateFormat(Today.ToString("yyyy/MM/dd"));
            }

            //沒前面一筆，有當筆，也有後一筆(011)(最前面一筆，有多筆)
            else if (string.IsNullOrEmpty(dt.Rows[0]["PrevSID"].ToString()) & !string.IsNullOrEmpty(dt.Rows[0]["ThisSID"].ToString()) & !string.IsNullOrEmpty(dt.Rows[0]["NextSID"].ToString()))
            {
                //設定時間
                PrevSID = dt.Rows[0]["PrevSID"].ToString();
                ThisSID = dt.Rows[0]["ThisSID"].ToString();
                NextSID = dt.Rows[0]["NextSID"].ToString();

                DateTime Now_startTime = (DateTime)dt.Rows[0]["start2_date"];
                DateTime Next_start_date = (DateTime)dt.Rows[0]["start3_date"];
                DateTime Next2_start_date = Next_start_date.AddDays(-2);
                Label6.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox1.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox2.Text = dt.Rows[0]["sing_unit"].ToString();
                TextBox3.Text = dt.Rows[0]["sing_rank"].ToString();
                TextBox4.Text = dt.Rows[0]["sing_name"].ToString();
                old_time = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                old_unit = dt.Rows[0]["sing_unit"].ToString();
                old_rank = dt.Rows[0]["sing_rank"].ToString();
                old_name = dt.Rows[0]["sing_name"].ToString();
                Label8.Text = "106/01/01";
                Label9.Text = Lib.SysSetting.ToRocDateFormat(Next2_start_date.ToString("yyyy/MM/dd"));

            }
            //有前面一筆，有當筆，沒後面一筆(110)(最後一筆)
            else if (!string.IsNullOrEmpty(dt.Rows[0]["PrevSID"].ToString()) & !string.IsNullOrEmpty(dt.Rows[0]["ThisSID"].ToString()) & string.IsNullOrEmpty(dt.Rows[0]["NextSID"].ToString()))
            {
                //設定時間
                PrevSID = dt.Rows[0]["PrevSID"].ToString();
                ThisSID = dt.Rows[0]["ThisSID"].ToString();
                NextSID = dt.Rows[0]["NextSID"].ToString();

                DateTime Now_startTime = (DateTime)dt.Rows[0]["start2_date"];
                DateTime Prev_start_date = (DateTime)dt.Rows[0]["start1_date"];
                DateTime Prev2_start_date = Prev_start_date.AddDays(+2);
                DateTime Today = DateTime.Now;
                Label6.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox1.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox2.Text = dt.Rows[0]["sing_unit"].ToString();
                TextBox3.Text = dt.Rows[0]["sing_rank"].ToString();
                TextBox4.Text = dt.Rows[0]["sing_name"].ToString();
                old_time = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                old_unit = dt.Rows[0]["sing_unit"].ToString();
                old_rank = dt.Rows[0]["sing_rank"].ToString();
                old_name = dt.Rows[0]["sing_name"].ToString();
                Label8.Text = Lib.SysSetting.ToRocDateFormat(Prev2_start_date.ToString("yyyy/MM/dd"));
                //Label9.Text = Lib.SysSetting.ToRocDateFormat(Today.ToString("yyyy/MM/dd"));
                Label9.Text = "";
            }

            //有三筆，前中後都要改(111)(多筆，剛好在中間)
            else if (!string.IsNullOrEmpty(dt.Rows[0]["PrevSID"].ToString()) & !string.IsNullOrEmpty(dt.Rows[0]["ThisSID"].ToString()) & !string.IsNullOrEmpty(dt.Rows[0]["NextSID"].ToString()))//有三筆，前中後都要改
            {
                //設定時間
                PrevSID = dt.Rows[0]["PrevSID"].ToString();
                ThisSID = dt.Rows[0]["ThisSID"].ToString();
                NextSID = dt.Rows[0]["NextSID"].ToString();

                DateTime Now_startTime = (DateTime)dt.Rows[0]["start2_date"];
                DateTime Prev_start_date = (DateTime)dt.Rows[0]["start1_date"];
                DateTime Next_start_date = (DateTime)dt.Rows[0]["start3_date"];
                DateTime Prev2_start_date = Prev_start_date.AddDays(+2);
                DateTime Next2_start_date = Next_start_date.AddDays(-2);
                Label6.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox1.Text = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                TextBox2.Text = dt.Rows[0]["sing_unit"].ToString();
                TextBox3.Text = dt.Rows[0]["sing_rank"].ToString();
                TextBox4.Text = dt.Rows[0]["sing_name"].ToString();
                old_time = Lib.SysSetting.ToRocDateFormat(Now_startTime.ToString("yyyy/MM/dd"));
                old_unit = dt.Rows[0]["sing_unit"].ToString();
                old_rank = dt.Rows[0]["sing_rank"].ToString();
                old_name = dt.Rows[0]["sing_name"].ToString();
                Label8.Text = Lib.SysSetting.ToRocDateFormat(Prev2_start_date.ToString("yyyy/MM/dd"));
                Label9.Text = Lib.SysSetting.ToRocDateFormat(Next2_start_date.ToString("yyyy/MM/dd"));
            }
            else
            {
                //查無資料
            }
        }

        if (Page.IsPostBack == true)
        {
            
            string new_time = string.Empty;
            if (CheckDateTimeType(TextBox1.Text) == true & !string.IsNullOrEmpty(TextBox1.Text) & !string.IsNullOrEmpty(TextBox2.Text) & !string.IsNullOrEmpty(TextBox3.Text) & !string.IsNullOrEmpty(TextBox4.Text))
            {
                Label3.Text = null;
                
                DateTime EndTime;//結束時間

                //2.判斷日期是否在合理範圍
                //轉回西元年
                try
                {
                    DateTime ChangeTime = Lib.SysSetting.ToWorldDate(TextBox1.Text);//更改的時間
                    DateTime StartTime = Lib.SysSetting.ToWorldDate(Label8.Text);//起始時間
                    new_time = Lib.SysSetting.ToRocDateFormat(ChangeTime.ToString("yyyy/MM/dd"));//更改的時間轉為民國作比較
                    if (Label9.Text == "")
                    {
                        EndTime = Lib.SysSetting.ToWorldDate("999/12/31");//結束時間
                    }
                    else
                    {
                        EndTime = Lib.SysSetting.ToWorldDate(Label9.Text);//結束時間
                    }
                    //EndTime = Lib.SysSetting.ToWorldDate(Label9.Text);//結束時間
                    //2016-8-16新增更新簽章單位、級職、姓名
                    string sing_unit = TextBox2.Text;
                    string sing_rank = TextBox3.Text;
                    string sing_name = TextBox4.Text;

                    if (ChangeTime >= StartTime & ChangeTime <= EndTime)
                    {

                        Dictionary<string, object> dd = new Dictionary<string, object>();
                        Lib.DataUtility duu = new Lib.DataUtility();
                        dd.Add("PrevSID", PrevSID);
                        dd.Add("ThisSID", ThisSID);
                        dd.Add("NextSID", NextSID);
                        dd.Add("start_date", ChangeTime);//當筆啟始時間
                        dd.Add("prev_date", (ChangeTime.AddDays(-1)));//上一筆結束時間
                        dd.Add("next_date", (ChangeTime.AddDays(+1)));//下一筆啟始時間
                        //2016-8-16新增更新簽章單位、級職、姓名
                        dd.Add("sing_unit", sing_unit);
                        dd.Add("sing_rank", sing_rank);
                        dd.Add("sing_name", sing_name);

                        //更新圖檔
                        //2016-8-16開始畫印章
                        string sing1_unit = string.Empty;
                        string sing1_rank = string.Empty;
                        string sing1_name = string.Empty;
                        //string jpg_Name = string.Empty;

                        sing1_unit = sing_unit;
                        sing1_rank = sing_rank;
                        sing1_name = sing_name;

                        Font s1_unit = null;//鑑測官-單位
                        Font s1_rank = null;//鑑測官-級職

                        Font seal_font_name = new Font("標楷體", 48, FontStyle.Bold);//姓名
                        if (sing1_unit.Length <= 6)
                        {
                            s1_unit = new Font("標楷體", 34, FontStyle.Bold);//6個字
                        }
                        else if (sing1_unit.Length == 7)
                        {
                            s1_unit = new Font("標楷體", 30, FontStyle.Bold);//7個字
                        }
                        else if (sing1_unit.Length == 8)
                        {
                            s1_unit = new Font("標楷體", 26, FontStyle.Bold);//8個字
                        }
                        else if (sing1_unit.Length == 9)
                        {
                            s1_unit = new Font("標楷體", 24, FontStyle.Bold);//9個字
                        }
                        else if (sing1_unit.Length == 10)
                        {
                            s1_unit = new Font("標楷體", 22, FontStyle.Bold);//10個字
                        }
                        else if (sing1_unit.Length == 11)
                        {
                            s1_unit = new Font("標楷體", 20, FontStyle.Bold);//11個字
                        }
                        else if (sing1_unit.Length == 12)
                        {
                            s1_unit = new Font("標楷體", 18, FontStyle.Bold);//12個字
                        }
                        else
                        {
                            s1_unit = new Font("標楷體", 16, FontStyle.Bold);//超過12個字
                        }
                        //判斷鑑測官-級職 字長度
                        if (sing1_rank.Length <= 6)
                        {
                            s1_rank = new Font("標楷體", 34, FontStyle.Bold);//6個字
                        }
                        else if (sing1_rank.Length == 7)
                        {
                            s1_rank = new Font("標楷體", 30, FontStyle.Bold);//7個字
                        }
                        else if (sing1_rank.Length == 8)
                        {
                            s1_rank = new Font("標楷體", 26, FontStyle.Bold);//8個字
                        }
                        else if (sing1_rank.Length == 9)
                        {
                            s1_rank = new Font("標楷體", 24, FontStyle.Bold);//9個字
                        }
                        else if (sing1_rank.Length == 10)
                        {
                            s1_rank = new Font("標楷體", 22, FontStyle.Bold);//10個字
                        }
                        else if (sing1_rank.Length == 11)
                        {
                            s1_rank = new Font("標楷體", 20, FontStyle.Bold);//11個字
                        }
                        else if (sing1_rank.Length == 12)
                        {
                            s1_rank = new Font("標楷體", 18, FontStyle.Bold);//12個字
                        }
                        else
                        {
                            s1_rank = new Font("標楷體", 16, FontStyle.Bold);//超過12個字
                        }

                        int height = 180;
                        int width = 480;

                        Bitmap bmp = new Bitmap(width, height, PixelFormat.Format24bppRgb);

                        Graphics g = Graphics.FromImage(bmp);
                        g.SmoothingMode = SmoothingMode.AntiAlias;
                        g.Clear(Color.White);

                        StringFormat stringFormat = new StringFormat();
                        stringFormat.Alignment = StringAlignment.Center;
                        stringFormat.LineAlignment = StringAlignment.Center;

                        Pen seal_pen = new Pen(Color.Red, 15);

                        g.DrawRectangle(seal_pen, 0, 0, 480, 180);//鑑測官外框
                        //鑑測章內容
                        SolidBrush redSB = new SolidBrush(Color.Red);//字設成紅色
                        Pen seal_pen2 = new Pen(Color.Red, 5);
                        StringFormat sealFormat = new StringFormat();
                        sealFormat.Alignment = StringAlignment.Center;
                        sealFormat.LineAlignment = StringAlignment.Center;

                        DrawSpacedText(g, s1_unit, redSB, new Point(3, 30), sing1_unit, 260);
                        DrawSpacedText(g, s1_rank, redSB, new Point(3, 100), sing1_rank, 260);
                        DrawSpacedText(g, seal_font_name, redSB, new Point(245, 60), sing1_name, 240);

                        byte[] bytedata = (byte[])ImageToByte(bmp);
                        dd.Add("img_byte", bytedata);//加入圖檔索引

                        //開始更新，判斷要更新的欄位
                        //只有當筆(010)
                        if (string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & string.IsNullOrEmpty(NextSID))
                        {
                            duu.executeNonQueryByText("update Center_Seal set start_date=@start_date,sing_unit=@sing_unit,sing_rank=@sing_rank,sing_name=@sing_name,img_byte=@img_byte where sid=@ThisSID", dd);//更新當筆
                            //2016-9-7更新資料寫入log
                            if (old_time == new_time & old_unit == sing1_unit & old_rank == sing1_rank & old_name == sing1_name)
                            {
                                //都一樣沒更改，不產生log
                            }
                            else
                            {
                                //資料有異動，產生log
                                string event_log = string.Empty;
                                event_log += "[SID：" + ThisSID + "] ";
                                if (old_time != new_time)
                                    event_log += "啟用時間：" + old_time + "->" + new_time + "。";
                                if (old_unit != sing1_unit)
                                    event_log += "單位：" + old_unit + "->" + sing1_unit + "。";
                                if (old_rank != sing1_rank)
                                    event_log += "級職：" + old_rank + "->" + sing1_rank + "。";
                                if (old_name != sing1_name)
                                    event_log += "姓名：" + old_name + "->" + sing1_name + "。";

                                SysSetting.AddLog("簽章維護", Acc, event_log, DateTime.Now);
                            }


                            Label3.Text = "簽章更新成功!!";
                            PrevSID = string.Empty;
                            ThisSID = string.Empty;
                            NextSID = string.Empty;
                            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.close();window.opener.location.reload()", true);
                            //2016-9-12測試成功，先把方法傳回母視窗(刷新列表)，再關掉子視窗
                            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.opener.outside();window.close()", true);

                        }
                        //沒前面一筆，有當筆，也有後一筆(011)(最前面一筆，有多筆)
                        else if (string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & !string.IsNullOrEmpty(NextSID))
                        {
                            duu.executeNonQueryByText("update Center_Seal set start_date=@start_date,sing_unit=@sing_unit,sing_rank=@sing_rank,sing_name=@sing_name,img_byte=@img_byte where sid=@ThisSID", dd);//更新當筆
                            //duu.executeNonQueryByText("update Center_Seal set start_date=@next_date where sid=@NextSID", dd);//更新下一筆啟始時間
                            //Response.Redirect(Request.Url.ToString());

                            //2016-9-7更新資料寫入log
                            if (old_time == new_time & old_unit == sing1_unit & old_rank == sing1_rank & old_name == sing1_name)
                            {
                                //都一樣沒更改，不產生log
                            }
                            else
                            {
                                //資料有異動，產生log
                                string event_log = string.Empty;
                                event_log += "[SID：" + ThisSID + "] ";
                                if (old_time != new_time)
                                    event_log += "啟用時間：" + old_time + "->" + new_time + "。";
                                if (old_unit != sing1_unit)
                                    event_log += "單位：" + old_unit + "->" + sing1_unit + "。";
                                if (old_rank != sing1_rank)
                                    event_log += "級職：" + old_rank + "->" + sing1_rank + "。";
                                if (old_name != sing1_name)
                                    event_log += "姓名：" + old_name + "->" + sing1_name + "。";

                                SysSetting.AddLog("簽章維護", Acc, event_log, DateTime.Now);
                            }

                            Label3.Text = "簽章更新成功!!";
                            PrevSID = string.Empty;
                            ThisSID = string.Empty;
                            NextSID = string.Empty;
                            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.close();window.opener.location.reload()", true);
                            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.opener.outside();window.close()", true);
                        }
                        ////有前面一筆，有當筆，沒後面一筆(110)(最後一筆)//TEST
                        else if (!string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & string.IsNullOrEmpty(NextSID))
                        {
                            duu.executeNonQueryByText("update Center_Seal set start_date=@start_date,sing_unit=@sing_unit,sing_rank=@sing_rank,sing_name=@sing_name,img_byte=@img_byte where sid=@ThisSID", dd);//更新當筆
                            duu.executeNonQueryByText("update Center_Seal set end_date=@prev_date where sid=@PrevSID", dd);//更新上一筆結束時間
                            //Response.Redirect(Request.Url.ToString());

                            //2016-9-7更新資料寫入log
                            if (old_time == new_time & old_unit == sing1_unit & old_rank == sing1_rank & old_name == sing1_name)
                            {
                                //都一樣沒更改，不產生log
                            }
                            else
                            {
                                //資料有異動，產生log
                                string event_log = string.Empty;
                                event_log += "[SID：" + ThisSID + "] ";
                                if (old_time != new_time)
                                    event_log += "啟用時間：" + old_time + "->" + new_time + "。";
                                if (old_unit != sing1_unit)
                                    event_log += "單位：" + old_unit + "->" + sing1_unit + "。";
                                if (old_rank != sing1_rank)
                                    event_log += "級職：" + old_rank + "->" + sing1_rank + "。";
                                if (old_name != sing1_name)
                                    event_log += "姓名：" + old_name + "->" + sing1_name + "。";

                                SysSetting.AddLog("簽章維護", Acc, event_log, DateTime.Now);
                            }

                            Label3.Text = "簽章更新成功!!";
                            PrevSID = string.Empty;
                            ThisSID = string.Empty;
                            NextSID = string.Empty;
                            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.close();window.opener.location.reload()", true);
                            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.opener.outside();window.close()", true);


                        }
                        //有三筆，前中後都要改(111)(多筆，剛好在中間)
                        else if (!string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & !string.IsNullOrEmpty(NextSID))
                        {
                            duu.executeNonQueryByText("update Center_Seal set start_date=@start_date,sing_unit=@sing_unit,sing_rank=@sing_rank,sing_name=@sing_name,img_byte=@img_byte where sid=@ThisSID", dd);//更新當筆
                            //duu.executeNonQueryByText("update Center_Seal set start_date=@next_date where sid=@NextSID", dd);//更新下一筆啟始時間
                            duu.executeNonQueryByText("update Center_Seal set end_date=@prev_date where sid=@PrevSID", dd);//更新上一筆結束時間
                            //Response.Redirect(Request.Url.ToString());

                            //2016-9-7更新資料寫入log
                            if (old_time == new_time & old_unit == sing1_unit & old_rank == sing1_rank & old_name == sing1_name)
                            {
                                //都一樣沒更改，不產生log
                            }
                            else
                            {
                                //資料有異動，產生log
                                string event_log = string.Empty;
                                event_log += "[SID：" + ThisSID + "] ";
                                if (old_time != new_time)
                                    event_log += "啟用時間：" + old_time + "->" + new_time + "。";
                                if (old_unit != sing1_unit)
                                    event_log += "單位：" + old_unit + "->" + sing1_unit + "。";
                                if (old_rank != sing1_rank)
                                    event_log += "級職：" + old_rank + "->" + sing1_rank + "。";
                                if (old_name != sing1_name)
                                    event_log += "姓名：" + old_name + "->" + sing1_name + "。";

                                SysSetting.AddLog("簽章維護", Acc, event_log, DateTime.Now);
                            }

                            Label3.Text = "簽章更新成功!!";
                            PrevSID = string.Empty;
                            ThisSID = string.Empty;
                            NextSID = string.Empty;
                            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.close();window.opener.location.reload()", true);
                            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.opener.outside();window.close()", true);

                        }
                        else
                        {

                        }
                    }
                    else
                    {
                        Label3.Text = "日期輸入範圍值錯誤，請查新檢查!!";
                    }
                }
                catch (Exception ex)
                {
                    Label3.Text = "日期格式錯誤";
                }
                
            }
            else
            {
                Label3.Text = "日期格式錯誤或欄位空白";
            }
        }
    }
    //字元寬度設定實作
    public void DrawSpacedText(Graphics g, Font font, Brush brush, PointF point, string text, int desiredWidth)
    {
        //Calculate spacing
        float widthNeeded = 0;
        foreach (char c in text)
        {
            widthNeeded += g.MeasureString(c.ToString(), font).Width;
        }
        float spacing = (desiredWidth - widthNeeded) / (text.Length - 1);

        //draw text
        float indent = 0;
        foreach (char c in text)
        {
            g.DrawString(c.ToString(), font, brush, new PointF(point.X + indent, point.Y));
            indent += g.MeasureString(c.ToString(), font).Width + spacing;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //1.判斷日期格式跟空白
        if (CheckDateTimeType(TextBox1.Text) == true & !string.IsNullOrEmpty(TextBox1.Text))
        {
            Label3.Text = null;
            //2.判斷日期是否在合理範圍
            //先轉回西元年
            DateTime ChangeTime = Lib.SysSetting.ToWorldDate(TextBox1.Text);//更改的時間
            DateTime StartTime = Lib.SysSetting.ToWorldDate(Label8.Text);//起始時間
            DateTime EndTime = Lib.SysSetting.ToWorldDate(Label9.Text);//結束時間
            if (ChangeTime >= StartTime & ChangeTime <= EndTime)
            {
                Dictionary<string, object> dd = new Dictionary<string, object>();
                Lib.DataUtility duu = new Lib.DataUtility();
                dd.Add("PrevSID", PrevSID);
                dd.Add("ThisSID", ThisSID);
                dd.Add("NextSID", NextSID);
                dd.Add("start_date", ChangeTime);//當筆啟始時間
                dd.Add("prev_date", (ChangeTime.AddDays(-1)));//上一筆結束時間
                dd.Add("next_date", (ChangeTime.AddDays(+1)));//下一筆啟始時間
                //2016-8-16新增更新簽章單位、級職、姓名

                //開始更新，判斷要更新的欄位
                //只有當筆(010)
                if (string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & string.IsNullOrEmpty(NextSID))
                {
                    duu.executeNonQueryByText("update Center_Seal set start_date=@start_date where sid=@ThisSID", dd);//更新當筆
                    Label3.Text = "簽章更新成功!!";

                }
                //沒前面一筆，有當筆，也有後一筆(011)(最前面一筆，有多筆)
                else if (string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & !string.IsNullOrEmpty(NextSID))
                {
                    duu.executeNonQueryByText("update Center_Seal set start_date=@start_date where sid=@ThisSID", dd);//更新當筆
                    //duu.executeNonQueryByText("update Center_Seal set start_date=@next_date where sid=@NextSID", dd);//更新下一筆啟始時間
                    Response.Redirect(Request.Url.ToString());
                    Label3.Text = "簽章更新成功!!";
                }
                ////有前面一筆，有當筆，沒後面一筆(110)(最後一筆)
                else if (!string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & string.IsNullOrEmpty(NextSID))
                {
                    duu.executeNonQueryByText("update Center_Seal set start_date=@start_date where sid=@ThisSID", dd);//更新當筆
                    duu.executeNonQueryByText("update Center_Seal set end_date=@prev_date where sid=@PrevSID", dd);//更新上一筆結束時間
                    Response.Redirect(Request.Url.ToString());
                    Label3.Text = "簽章更新成功!!";

                }
                //有三筆，前中後都要改(111)(多筆，剛好在中間)
                else if (!string.IsNullOrEmpty(PrevSID) & !string.IsNullOrEmpty(ThisSID) & !string.IsNullOrEmpty(NextSID))
                {
                    duu.executeNonQueryByText("update Center_Seal set start_date=@start_date where sid=@ThisSID", dd);//更新當筆
                    //duu.executeNonQueryByText("update Center_Seal set start_date=@next_date where sid=@NextSID", dd);//更新下一筆啟始時間
                    duu.executeNonQueryByText("update Center_Seal set end_date=@prev_date where sid=@PrevSID", dd);//更新上一筆結束時間
                    Response.Redirect(Request.Url.ToString());
                    Label3.Text = "簽章更新成功!!";
                }
                else
                {

                }
            }
            else
            {
                Label3.Text = "日期輸入範圍值錯誤，請查新檢查!!";
            }
        }
        else
        {
            Label3.Text = "日期格式錯誤或空白";
        }
    }
    //檢查日期格式用
    public bool CheckDateTimeType(string txtDateStart)
    {
        DateTime sd;//供判斷暫存之用
        if (String.IsNullOrEmpty(txtDateStart) || !DateTime.TryParse(txtDateStart, out sd))
        {
            return false;
        }
        return true;
    }
    private byte[] ImageToByte(Bitmap bmp)
    {
        ImageConverter converter = new ImageConverter();

        return (byte[])converter.ConvertTo(bmp, typeof(byte[]));
    }
    private Bitmap ByteToImageByte(byte[] bytedata)
    {
        ImageConverter converter = new ImageConverter();
        return (Bitmap)converter.ConvertFrom(bytedata);
    }
}