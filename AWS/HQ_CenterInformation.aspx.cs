using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

public partial class HQ_CenterInformation : System.Web.UI.Page
{
    static public int page;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(hf_page.Value))
            page = Convert.ToInt16(hf_page.Value);
        
        if (page == 1)
        {
            TabContainer1.ActiveTabIndex = 1;
            page = 0;
        }
        else if (page == 2)
        {
            TabContainer1.ActiveTabIndex = 2;
            page = 0;
        }
        else
        {
            TabContainer1.ActiveTabIndex = 0;
            page = 0;
        }
        
        Image4.ImageUrl = "~/images/106_Seal_Sample.JPG";
        if (!IsPostBack)
        {
            Button4.OnClientClick = "return confirm('確認要刪除資料??')";
            //Button2.OnClientClick = "return confirm('注意~請再次確認新增資料是否正確~新增簽章後將無法刪除!!')";
            Button2.OnClientClick = "var date = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox1').value;var unit = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox3').value;var rank = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox4').value;var name = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox5').value;if (date == '' | unit == '' | rank == '' | name == ''){alert('輸入欄位不可空白');return false;}else{var ch = dateValidationCheck(date.trim());if(ch == 1) {var st1=document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_hf_start_time1').value;var date1 = new Date(date.trim());var date2 = new Date(st1);var timeDiff = Math.ceil(date1.getTime() - date2.getTime());var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));if (diffDays >= 0 ){if(confirm('注意!!請確認新增資料是否正確，新增簽章後將無法刪除!!')){return true;}else{return false;};}else{alert('輸入日期不在範圍值內，請重新檢查!!');return false;}}else{alert('日期格式錯誤');return false;}}";
            //Button2.OnClientClick = "check_data1()";//用這個還是會回傳sv
            //Button3b.OnClientClick = "return confirm('注意~請再次確認新增資料是否正確~新增簽章後將無法刪除!!')";
            Button3b.OnClientClick = "var date2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox2').value;var unit2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox6').value;var rank2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox7').value;var name2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_TextBox8').value;if (date2 == '' | unit2 == '' | rank2 == '' | name2 == ''){alert('輸入欄位不可空白');return false;}else{var ch2 = dateValidationCheck(date2.trim());if(ch2 == 1) {var st2=document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_hf_start_time2').value;var date11 = new Date(date2.trim());var date22 = new Date(st2);var timeDiff2 = Math.ceil(date11.getTime() - date22.getTime());var diffDays2 = Math.ceil(timeDiff2 / (1000 * 3600 * 24));if (diffDays2 >= 0 ){if(confirm('注意!!請確認新增資料是否正確，新增簽章後將無法刪除!!')){return true;}else{return false;};}else{alert('輸入日期不在範圍值內，請重新檢查!!');return false;}}else{alert('日期格式錯誤');return false;}}";
            
        }
        string cnter_code = string.Empty;
        if (Session["account"] != null)
        {
            if (!Page.IsPostBack)
            {
                hf_start_time1.Value = string.Empty;
                hf_start_time2.Value = string.Empty;
                Account a = (Account)Session["account"];
                //查詢登入帳號有無單位代碼欄位資料center_code,000是總部或國防部
                if (string.IsNullOrEmpty(a.center_code) | a.center_code == "000")
                {
                    TabPanel1.Enabled = false;
                    TabPanel2.Enabled = false;
                    TabPanel3.Enabled = false;
                    TabContainer1.ActiveTabIndex = -1;
                    TabContainer1.Enabled = false;
                }
                else
                {
                    if (a.Role == ((int)SysSetting.Role.user_hg).ToString())
                    {
                        Lib.DataUtility du = new Lib.DataUtility();
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        DataTable dt = new DataTable();
                        DataTable dt1 = new DataTable();
                        DataTable dt2 = new DataTable();
                        DataTable dt11 = new DataTable();
                        DataTable dt22 = new DataTable();
                        d.Add("unit_code", a.Unit_Code);
                        d.Add("center_code", a.center_code);
                        //2015-12-14新增center_code,center_name查詢
                        dt = du.getDataTableByText("select center_code,center_name,information,imagepath from Center where unit_code = @unit_code", d);
                        //2016-9-9改由account的center_code去查
                        dt = du.getDataTableByText("select center_code,center_name,information,imagepath from Center where center_code = @center_code", d);
                        if (dt.Rows.Count == 1)  //表示登入者的身分為鑑測站資訊管理者
                        {
                            Image1.ImageUrl = dt.Rows[0]["imagepath"].ToString();
                            information.Text = dt.Rows[0]["information"].ToString();
                            Label2b.Text = dt.Rows[0]["center_name"].ToString();
                            Label6.Text = dt.Rows[0]["center_name"].ToString();
                            //2016-9-9先拿掉下面這行
                            //d.Add("center_code", dt.Rows[0]["center_code"].ToString());
                            //Label4.Text = dt.Rows[0]["center_code"].ToString();
                            hf_Center_code.Value = dt.Rows[0]["center_code"].ToString();
                            hf_Center_code_SQL.Value = dt.Rows[0]["center_code"].ToString();
                            //Label7.Text = dt.Rows[0]["center_code"].ToString();
                            //Label_Acc.Text = a.AccountName;
                            hf_Acc.Value = a.AccountName;
                            //查詢最新鑑測官簽章
                            dt1 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='1' and start_date<GETDATE() order by start_date desc", d);
                            dt11 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='1'  order by start_date desc", d);
                            //查詢最新鑑測主任簽章
                            dt2 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='2' and start_date<GETDATE() order by start_date desc", d);
                            dt22 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='2'  order by start_date desc", d);
                            //GridView1.DataSource = dt1;
                            //GridView1.DataBind();
                            if (dt1.Rows.Count == 1)  //表示有資料
                            {

                                if (!string.IsNullOrEmpty(dt1.Rows[0]["img_byte"].ToString()))
                                {
                                    byte[] PhotoByte = (byte[])dt1.Rows[0]["img_byte"];
                                    ImageConverter ic = new ImageConverter();
                                    System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                                    Image1b.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
                                    Label7a.Text = "目前使用簽章啟用日期：";
                                    Label7b.Text = Lib.SysSetting.ToRocDateFormat(Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).ToString("yyyy/MM/dd"));
                                    //DateTime d1 = Convert.ToDateTime((Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd 00:00:00"));
                                    //DateTime d2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd 00:00:00"));
                                    //if (d1 > d2)
                                    //    Label14.Text = "與前筆資料之「啟用時間」間隔未達二天無法上傳簽章!!";
                                    //else
                                    //    Label14.Text = "(日期輸入範圍值：" + Lib.SysSetting.ToRocDateFormat((Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd")) + "～" + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy/MM/dd)"));
                                    Label14.Text = "(啟用日期輸入範圍：" + Lib.SysSetting.ToRocDateFormat((Convert.ToDateTime(dt11.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd")) + "～)";
                                    hf_start_time1.Value = Lib.SysSetting.ToRocDateFormat((Convert.ToDateTime(dt11.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd"));

                                }
                                else
                                {
                                    Image1b.AlternateText = "請先新增鑑測官簽章資料!!";
                                    Label7a.Text = null;
                                    Label7b.Text = null;
                                    //Label14.Text = "(日期輸入範圍值：105/01/01" + "～" + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy/MM/dd)"));
                                    Label14.Text = "(啟用日期輸入範圍：106/01/01" + "～)";
                                    hf_start_time1.Value = "106/01/01";
                                }

                            }
                            else
                            {
                                Image1b.AlternateText = "請先新增鑑測官簽章資料!!";
                                Label7a.Text = null;
                                Label7b.Text = null;
                                //Label14.Text = "(日期輸入範圍值：105/01/01" + "～" + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy/MM/dd)"));
                                Label14.Text = "(啟用日期輸入範圍：106/01/01" + "～)";
                                hf_start_time1.Value = "106/01/01";
                            }

                            if (dt2.Rows.Count == 1)
                            {
                                if (!string.IsNullOrEmpty(dt2.Rows[0]["img_byte"].ToString()))
                                {
                                    byte[] PhotoByte = (byte[])dt2.Rows[0]["img_byte"];
                                    ImageConverter ic = new ImageConverter();
                                    System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                                    Image2b.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
                                    Label8a.Text = "目前使用簽章啟用日期：";
                                    Label8b.Text = Lib.SysSetting.ToRocDateFormat(Convert.ToDateTime(dt2.Rows[0]["start_date"].ToString()).ToString("yyyy/MM/dd"));

                                    //DateTime d1 = Convert.ToDateTime((Convert.ToDateTime(dt2.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd 00:00:00"));
                                    //DateTime d2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd 00:00:00"));
                                    //if (d1 > d2)
                                    //    Label15.Text = "與前筆資料之「啟用時間」間隔未達二天無法上傳簽章!!";
                                    //else
                                    //    Label15.Text = "(日期輸入範圍值：" + Lib.SysSetting.ToRocDateFormat((Convert.ToDateTime(dt2.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd")) + "～" + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy/MM/dd)"));
                                    Label15.Text = "(啟用日期輸入範圍：" + Lib.SysSetting.ToRocDateFormat((Convert.ToDateTime(dt22.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd")) + "～)";
                                    hf_start_time2.Value = Lib.SysSetting.ToRocDateFormat((Convert.ToDateTime(dt22.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd"));

                                }
                                else
                                {
                                    Image2b.AlternateText = "請先新增鑑測主任簽章資料!!";
                                    Label8a.Text = null;
                                    Label8b.Text = null;
                                    //Label15.Text = "(日期輸入範圍值：105/01/01" + "～" + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy/MM/dd)"));
                                    Label15.Text = "(啟用日期輸入範圍：106/01/01" + "開始";
                                    hf_start_time2.Value = "106/01/01";
                                }


                            }
                            else
                            {
                                Image2b.AlternateText = "請先新增鑑測主任簽章資料!!";
                                Label8a.Text = null;
                                Label8b.Text = null;
                                //Label15.Text = "(日期輸入範圍值：105/01/01" + "～" + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy/MM/dd)"));
                                Label15.Text = "(啟用日期輸入範圍：106/01/01" + "～)";
                                hf_start_time2.Value = "106/01/01";
                            }

                        }
                        else
                        {

                        }
                    }
                }
                
            }
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            Account a = (Account)Session["account"];
            if (a.Role == ((int)SysSetting.Role.user_hg).ToString())
            {
                try
                {
                    HttpPostedFile file = FileUpload1.PostedFile;
                    if (FileUpload1.HasFile && file.ContentLength < 2097152 && Lib.SysSetting.IsImage(file) == true)
                    {

                        string dd = Server.MapPath(Request.ApplicationPath);
                        Bitmap s = new Bitmap(file.InputStream, true);
                        int x, y;
                        x = s.Width;
                        y = s.Height;
                        //if (x == 600 && y == 454)
                        //{
                        file.SaveAs(dd + "\\images\\Center\\" + FileUpload1.FileName);
                        Lib.DataUtility du = new Lib.DataUtility();
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("information", information.Text);
                        d.Add("imagepath", "~/images/Center/" + FileUpload1.FileName);
                        d.Add("unit_code", a.Unit_Code);
                        du.executeNonQueryByText("update Center SET information = @information , imagepath = @imagepath where unit_code = @unit_code", d);
                        Image1.ImageUrl = "~/images/Center/" + FileUpload1.FileName;
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('成功更新圖檔與說明資訊');", true);
                        //}
                        //else
                        //{
                        //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('圖檔需符合(600 * 454)像素');", true);
                        //}
                    }
                    else if (FileUpload1.HasFile == false)
                    {
                        Lib.DataUtility du = new Lib.DataUtility();
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("information", information.Text);
                        d.Add("unit_code", a.Unit_Code);
                        du.executeNonQueryByText("update Center SET information = @information where unit_code = @unit_code", d);
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('成功說明資訊');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('系統只接受小於2MB的圖檔');", true);
                    }
                }
                catch (Exception ex)
                {
                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
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
    //鑑測官圖章上傳
    protected void Button2_Click1(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            Account a = (Account)Session["account"];
            if (a.Role == ((int)SysSetting.Role.user_hg).ToString())
            {
                try
                {
                    //HttpPostedFile file = FileUpload1b.PostedFile;//檢查資料夾是否空白
                    //if (FileUpload1b.HasFile && file.ContentLength < 2097152 && Lib.SysSetting.IsImage(file) == true)
                    //{
                    //檢查日期是格式及是否空白
                    if (CheckDateTimeType(TextBox1.Text) == true & !string.IsNullOrEmpty(TextBox1.Text) & !string.IsNullOrEmpty(TextBox3.Text) & !string.IsNullOrEmpty(TextBox4.Text) & !string.IsNullOrEmpty(TextBox5.Text))
                    {
                        DateTime ChangeTime = Convert.ToDateTime(Lib.SysSetting.ToWorldDate(TextBox1.Text));//更改的時間
                        DateTime YesterdayTime = ChangeTime.AddDays(-1);
                        DateTime st1 = Convert.ToDateTime("2017/01/01 00:00:00");
                        //if (!string.IsNullOrEmpty(Label7b.Text))
                            //st1 = Convert.ToDateTime(Lib.SysSetting.ToWorldDate(Label7b.Text)).AddDays(+2);
                        if (!string.IsNullOrEmpty(hf_start_time1.Value))
                            st1 = Convert.ToDateTime(Lib.SysSetting.ToWorldDate(hf_start_time1.Value));

                        string end = DateTime.Now.ToString("yyyy/MM/dd 00:00:00");
                        DateTime end1 = Convert.ToDateTime(end);
                        //判斷是否在時間範圍內
                        //if (ChangeTime >= st1 & ChangeTime <= end1)
                        if (ChangeTime >= st1)//修改不限制結束時間，可以設定以後任何時間
                        {
                            //2016-8-16測試
                            string sing1_unit = string.Empty;
                            string sing1_rank = string.Empty;
                            string sing1_name = string.Empty;
                            //string jpg_Name = string.Empty;

                            sing1_unit = TextBox3.Text;
                            sing1_rank = TextBox4.Text;
                            sing1_name = TextBox5.Text;
                            //jpg_Name = "Seal_Sid" + Request.QueryString["sid"].ToString() + ".jpg";

                            // <snippet2>
                            // Set the page's content type to JPEG files
                            // and clears all content output from the buffer stream.
                            //Response.ContentType = "image/jpeg";
                            //Response.Clear();
                            //加入這一段才能直接存檔
                            //Response.AddHeader("Content-Disposition", "attachment; filename = result.jpg");
                            //圖片名字
                            //Response.AddHeader("Content-Disposition", "attachment; filename = " + jpg_Name);
                            // Buffer response so that page is sent
                            // after processing is complete.
                            //Response.BufferOutput = true;
                            // </snippet2>

                            //印章字體
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

                            //300dpi
                            //int height = 3508;
                            //int width = 2480;

                            //72dpi
                            //int height = 842;
                            //int width = 842;
                            int height = 180;
                            int width = 480;

                            //表格最左上角定位點
                            //int table_x = Convert.ToInt32(width * 0.2) / 2;
                            //int table_y = Convert.ToInt32(height * 0.43);
                            // Create a bitmap and use it to create a
                            // Graphics object.
                            
                            //2016-8-22產生圖檔需try catch
                            Bitmap bmp = new Bitmap(width, height, PixelFormat.Format24bppRgb);

                            //Bitmap bmp = new Bitmap(width, height, PixelFormat.Format64bppPArgb);
                            Graphics g = Graphics.FromImage(bmp);
                            g.SmoothingMode = SmoothingMode.AntiAlias;
                            g.Clear(Color.White);

                            StringFormat stringFormat = new StringFormat();
                            stringFormat.Alignment = StringAlignment.Center;
                            stringFormat.LineAlignment = StringAlignment.Center;

                            Pen seal_pen = new Pen(Color.Red, 15);
                            //g.DrawRectangle(seal_pen, 175, 350, 480, 180);//鑑測官外框
                            g.DrawRectangle(seal_pen, 0, 0, 480, 180);//鑑測官外框
                            //鑑測章內容
                            SolidBrush redSB = new SolidBrush(Color.Red);//字設成紅色
                            Pen seal_pen2 = new Pen(Color.Red, 5);
                            StringFormat sealFormat = new StringFormat();
                            sealFormat.Alignment = StringAlignment.Center;
                            sealFormat.LineAlignment = StringAlignment.Center;

                            //DrawSpacedText(g, s1_unit, redSB, new Point(178, 380), sing1_unit, 260);
                            //DrawSpacedText(g, s1_rank, redSB, new Point(178, 460), sing1_rank, 260);
                            //DrawSpacedText(g, seal_font_name, redSB, new Point(420,410), sing1_name, 240);
                            DrawSpacedText(g, s1_unit, redSB, new Point(3, 30), sing1_unit, 260);
                            DrawSpacedText(g, s1_rank, redSB, new Point(3, 100), sing1_rank, 260);
                            DrawSpacedText(g, seal_font_name, redSB, new Point(245, 60), sing1_name, 240);
                            g.Dispose();
                            //bmp.Save(Response.OutputStream, ImageFormat.Jpeg);

                            //// Release memory used by the Graphics object
                            //// and the bitmap.
                            //g.Dispose();
                            //bmp.Dispose();

                            //// Send the output to the client.
                            //Response.Flush();
                            // </snippet3>
                            //2016-8-16測試
                            //Bitmap bmp = new Bitmap(file.InputStream, true);

                            byte[] bytedata = (byte[])ImageToByte(bmp);
                            bmp.Dispose();
                            //string bt = string.Empty;


                            string Nowtime = ChangeTime.ToString("yyyy-MM-dd");//現在時間
                            string Yesterday = YesterdayTime.ToString("yyyy-MM-dd");//昨天
                            Lib.DataUtility du = new Lib.DataUtility();
                            Dictionary<string, object> d = new Dictionary<string, object>();
                            try
                            {
                                //d.Add("center_code", Label4.Text);
                                d.Add("center_code", hf_Center_code.Value);
                                d.Add("rank_code", "1");
                                d.Add("start_date", Nowtime);
                                d.Add("img_byte", bytedata);
                                d.Add("end_date", Yesterday);
                                d.Add("sing_unit", sing1_unit);
                                d.Add("sing_rank", sing1_rank);
                                d.Add("sing_name", sing1_name);

                                //查看看有幾筆，0筆就只塞，1筆以上就更新上一筆再塞下一筆新的
                                DataTable dt = du.getDataTableByText("select top 1 * from Center_Seal where center_code=@center_code and rank_code='1' ORDER BY sid desc", d);
                                if (dt.Rows.Count == 0)//0筆只更新
                                {
                                    du.executeNonQueryByText(@"insert into Center_Seal(center_code,rank_code,start_date,img_byte,sing_unit,sing_rank,sing_name) values(@center_code,@rank_code,@start_date,@img_byte,@sing_unit,@sing_rank,@sing_name)", d);
                                }
                                else if (dt.Rows.Count > 0)//1筆以上就更新上一筆的結束時間，再塞入新的一筆
                                {
                                    d.Add("sid", dt.Rows[0]["sid"].ToString());
                                    du.executeNonQueryByText(@"insert into Center_Seal(center_code,rank_code,start_date,img_byte,sing_unit,sing_rank,sing_name) values(@center_code,@rank_code,@start_date,@img_byte,@sing_unit,@sing_rank,@sing_name)", d);
                                    du.executeNonQueryByText(@"update Center_Seal set end_date=@end_date where sid=@sid", d);
                                }
                                else
                                {

                                }
                            }
                            catch (Exception ex)
                            {
                                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                            }
                            //錯誤位置
                            //g.Dispose();
                            //bmp.Dispose();
                            //d.Clear();
                            //// Send the output to the client.
                            //Response.Flush();
                            
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('「鑑測官」簽章圖檔成功上傳!!');", true);
                            //Response.Redirect(Request.Url.ToString());
                            //Response.Write("<script type=\"javascript\">window.location.href=document.URL;</script>");
                            
                            //2016-9-7將新增結果寫入log
                            string event_log = string.Empty;
                            event_log = "簽章啟用日期：" + Nowtime + "，單位：" + sing1_unit + "，級職：" + sing1_rank + "，姓名：" + sing1_name;
                            SysSetting.AddLog("新增簽章",a.AccountName,event_log,DateTime.Now);
                            page = 1;
                            
                            Response.AddHeader("Refresh", "0");
                        
                            d.Clear();
                            //TabContainer1.ActiveTabIndex = 1;       
                            //TabContainer1.TabIndex = 1;
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('日期輸入範圍值錯誤~請重新檢查!!');", true);
                        }


                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('日期格式錯誤或上傳欄位空白');", true);
                    }



                    //}
                    //else if (FileUpload1b.HasFile == false)
                    //{
                    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('請先選擇上傳檔案!!');", true);

                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('系統只接受小於2MB的圖檔');", true);
                    //}
                }
                catch (Exception ex)
                {
                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                }
            }
        }
        //Response.Redirect(Request.Url.ToString());
    }
    //鑑測主任圖章上傳
    protected void Button3b_Click1(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            Account a = (Account)Session["account"];
            if (a.Role == ((int)SysSetting.Role.user_hg).ToString())
            {
                try
                {
                    //HttpPostedFile file = FileUpload2b.PostedFile;
                    //if (FileUpload2b.HasFile && file.ContentLength < 2097152 && Lib.SysSetting.IsImage(file) == true)
                    //{
                    //檢查日期是格式及是否空白
                    if (CheckDateTimeType(TextBox2.Text) == true & !string.IsNullOrEmpty(TextBox2.Text) & !string.IsNullOrEmpty(TextBox6.Text) & !string.IsNullOrEmpty(TextBox7.Text) & !string.IsNullOrEmpty(TextBox8.Text))
                    {
                        DateTime ChangeTime = Convert.ToDateTime(Lib.SysSetting.ToWorldDate(TextBox2.Text));//更改的時間
                        DateTime YesterdayTime = ChangeTime.AddDays(-1);//更改日期的前一天
                        DateTime st2 = Convert.ToDateTime("2017/01/01 00:00:00");
                        //if (!string.IsNullOrEmpty(Label8b.Text))
                        //    st2 = Convert.ToDateTime(Lib.SysSetting.ToWorldDate(Label8b.Text)).AddDays(+2);
                        if (!string.IsNullOrEmpty(hf_start_time2.Value))
                            st2 = Convert.ToDateTime(Lib.SysSetting.ToWorldDate(hf_start_time2.Value));
                        string end = DateTime.Now.ToString("yyyy/MM/dd 00:00:00");
                        DateTime end2 = Convert.ToDateTime(end);
                        //判斷是否在時間範圍內
                        //if (ChangeTime >= st2 & ChangeTime <= end2)
                        if (ChangeTime >= st2 )//修改不限制結束時間，可以設定以後任何時間
                        {
                            //2016-8-16測試
                            string sing1_unit = string.Empty;
                            string sing1_rank = string.Empty;
                            string sing1_name = string.Empty;
                            //string jpg_Name = string.Empty;

                            sing1_unit = TextBox6.Text;
                            sing1_rank = TextBox7.Text;
                            sing1_name = TextBox8.Text;
                            //jpg_Name = "Seal_Sid" + Request.QueryString["sid"].ToString() + ".jpg";

                            // <snippet2>
                            // Set the page's content type to JPEG files
                            // and clears all content output from the buffer stream.
                            //Response.ContentType = "image/jpeg";
                            //Response.Clear();
                            //加入這一段才能直接存檔
                            //Response.AddHeader("Content-Disposition", "attachment; filename = result.jpg");
                            //圖片名字
                            //Response.AddHeader("Content-Disposition", "attachment; filename = " + jpg_Name);
                            // Buffer response so that page is sent
                            // after processing is complete.
                            //Response.BufferOutput = true;
                            // </snippet2>

                            //印章字體
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

                            //300dpi
                            //int height = 3508;
                            //int width = 2480;

                            //72dpi
                            //int height = 842;
                            //int width = 842;
                            int height = 180;
                            int width = 480;

                            //表格最左上角定位點
                            //int table_x = Convert.ToInt32(width * 0.2) / 2;
                            //int table_y = Convert.ToInt32(height * 0.43);
                            // Create a bitmap and use it to create a
                            // Graphics object.
                            Bitmap bmp = new Bitmap(width, height, PixelFormat.Format24bppRgb);
                            //Bitmap bmp = new Bitmap(width, height, PixelFormat.Format64bppPArgb);
                            Graphics g = Graphics.FromImage(bmp);
                            g.SmoothingMode = SmoothingMode.AntiAlias;
                            g.Clear(Color.White);

                            StringFormat stringFormat = new StringFormat();
                            stringFormat.Alignment = StringAlignment.Center;
                            stringFormat.LineAlignment = StringAlignment.Center;

                            Pen seal_pen = new Pen(Color.Red, 15);
                            //g.DrawRectangle(seal_pen, 175, 350, 480, 180);//鑑測官外框
                            g.DrawRectangle(seal_pen, 0, 0, 480, 180);//鑑測官外框
                            //鑑測章內容
                            SolidBrush redSB = new SolidBrush(Color.Red);//字設成紅色
                            Pen seal_pen2 = new Pen(Color.Red, 5);
                            StringFormat sealFormat = new StringFormat();
                            sealFormat.Alignment = StringAlignment.Center;
                            sealFormat.LineAlignment = StringAlignment.Center;

                            //DrawSpacedText(g, s1_unit, redSB, new Point(178, 380), sing1_unit, 260);
                            //DrawSpacedText(g, s1_rank, redSB, new Point(178, 460), sing1_rank, 260);
                            //DrawSpacedText(g, seal_font_name, redSB, new Point(420,410), sing1_name, 240);
                            DrawSpacedText(g, s1_unit, redSB, new Point(3, 30), sing1_unit, 260);
                            DrawSpacedText(g, s1_rank, redSB, new Point(3, 100), sing1_rank, 260);
                            DrawSpacedText(g, seal_font_name, redSB, new Point(245, 60), sing1_name, 240);


                            g.Dispose();
                            //bmp.Dispose();

                            //// Send the output to the client.
                            //Response.Flush();
                            // </snippet3>
                            //2016-8-16測試
                            //Bitmap bmp = new Bitmap(file.InputStream, true);

                            byte[] bytedata = (byte[])ImageToByte(bmp);
                            bmp.Dispose();

                            string Nowtime = ChangeTime.ToString("yyyy-MM-dd");//現在時間
                            string Yesterday = YesterdayTime.ToString("yyyy-MM-dd");//昨天
                            Lib.DataUtility duu = new Lib.DataUtility();
                            Dictionary<string, object> dd = new Dictionary<string, object>();
                            try
                            {
                                
                                //dd.Add("center_code", Label4.Text);
                                dd.Add("center_code", hf_Center_code.Value);
                                dd.Add("rank_code", "2");
                                dd.Add("start_date", Nowtime);
                                dd.Add("img_byte", bytedata);
                                dd.Add("end_date", Yesterday);
                                dd.Add("sing_unit", sing1_unit);
                                dd.Add("sing_rank", sing1_rank);
                                dd.Add("sing_name", sing1_name);
                                //duu.executeNonQueryByText(@"insert into Center_Seal(center_code,rank_code,start_date,img_byte) values(@center_code,@rank_code,@start_date,@img_byte)", dd);

                                //查看看有幾筆，0筆就只塞，1筆以上就更新上一筆再塞下一筆新的
                                DataTable dt = duu.getDataTableByText("select top 1 * from Center_Seal where center_code=@center_code and rank_code='2' ORDER BY sid desc", dd);
                                if (dt.Rows.Count == 0)//0筆只更新
                                {
                                    duu.executeNonQueryByText(@"insert into Center_Seal(center_code,rank_code,start_date,img_byte,sing_unit,sing_rank,sing_name) values(@center_code,@rank_code,@start_date,@img_byte,@sing_unit,@sing_rank,@sing_name)", dd);
                                }
                                else if (dt.Rows.Count > 0)//1筆以上就更新上一筆的結束時間，再塞入新的一筆
                                {
                                    dd.Add("sid", dt.Rows[0]["sid"].ToString());
                                    duu.executeNonQueryByText(@"insert into Center_Seal(center_code,rank_code,start_date,img_byte,sing_unit,sing_rank,sing_name) values(@center_code,@rank_code,@start_date,@img_byte,@sing_unit,@sing_rank,@sing_name)", dd);
                                    duu.executeNonQueryByText(@"update Center_Seal set end_date=@end_date where sid=@sid", dd);
                                }
                                else
                                {

                                }
                            }
                            catch (Exception ex)
                            {
                                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                            }

                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('「鑑測主任」簽章圖檔成功上傳!!');", true);
                            //Response.Redirect(Request.Url.ToString());

                            //2016-9-7將新增結果寫入log
                            string event_log = string.Empty;
                            event_log = "簽章啟用日期：" + Nowtime + "，單位：" + sing1_unit + "，級職：" + sing1_rank + "，姓名：" + sing1_name;
                            SysSetting.AddLog("新增簽章", a.AccountName, event_log, DateTime.Now);
                            page = 1;
                            Response.AddHeader("Refresh", "0");
                            
                            
                            dd.Clear();
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('日期輸入範圍值錯誤~請重新檢查!!');", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('日期格式錯誤或上傳欄位空白!!');", true);
                    }



                    //}
                    //else if (FileUpload2b.HasFile == false)
                    //{
                    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('請先選擇上傳檔案!!');", true);

                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('系統只接受小於2MB的圖檔');", true);
                    //}
                }
                catch (Exception ex)
                {
                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                }
            }
        }
        //Response.Redirect(Request.Url.ToString());
    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
        page = 2;
        Response.Redirect(Request.Url.ToString());
        
    }
    //刪除確認
    protected void Button4_Click(object sender, EventArgs e)
    {
        //Lib.DataUtility du3 = new DataUtility();
        //Dictionary<string, object> d3 = new Dictionary<string, object>();
        ////建立一個gridview刪除前的總筆數int
        //int GVold = GridView1.Rows.Count;
        //if (GridView1.Rows.Count > 0)
        //{
        //    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>cancelalert();</script>");
        //    for (int i = 0; i < GridView1.Rows.Count; i++)
        //    {
        //        CheckBox checkbox = (CheckBox)GridView1.Rows[i].Cells[0].Controls[1];
        //        if (checkbox.Checked == true)
        //        {
        //            string sid = GridView1.Rows[i].Cells[1].Text;
        //            string date = GridView1.Rows[i].Cells[2].Text;
        //            d3.Clear();
        //            //d3.Add("center_code", Label7.Text);
        //            d3.Add("center_code", hf_Center_code.Value);
        //            d3.Add("sid", sid);

        //            du3.executeNonQueryByText(@"delete from Center_Seal where sid = @sid and center_code = @center_code ", d3);

        //        }


        //    }
        //    GridView1.DataBind();
        //    //建立一個gridview刪除後的總筆數int
        //    int Gvnew = GridView1.Rows.Count;
        //    int GvDifference = GVold - Gvnew;
        //    //按下刪除鍵後，新的少於舊的則表示資料有刪除
        //    if (Gvnew < GVold)
        //    {
        //        string Alert = "<script>alert('成功刪除資料：" + GvDifference + "筆');</script>";
        //        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
        //        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('資料刪除成功!!');</script>");
        //    }
        //    //按下刪除鍵後，新舊相等的話表示沒勾選
        //    else if (Gvnew == GVold)
        //    {
        //        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('請先勾選要刪除之資料!!');</script>");
        //    }
        //}
        //else
        //{
        //    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('查無資料!!');</script>");
        //}

        ////刪除後刷新最新鑑測簽章
        //Account a = (Account)Session["account"];
        //if (a.Role == ((int)SysSetting.Role.user_hg).ToString())
        //{
        //    Lib.DataUtility du = new Lib.DataUtility();
        //    Dictionary<string, object> d = new Dictionary<string, object>();
        //    DataTable dt = new DataTable();
        //    DataTable dt1 = new DataTable();
        //    DataTable dt2 = new DataTable();
        //    DataTable dt11 = new DataTable();
        //    DataTable dt22 = new DataTable();
        //    d.Add("unit_code", a.Unit_Code);
        //    //2015-12-14新增center_code,center_name查詢
        //    dt = du.getDataTableByText("select center_code,center_name,information,imagepath from Center where unit_code = @unit_code", d);
        //    if (dt.Rows.Count == 1)  //表示登入者的身分為鑑測站資訊管理者
        //    {
        //        Image1.ImageUrl = dt.Rows[0]["imagepath"].ToString();
        //        information.Text = dt.Rows[0]["information"].ToString();
        //        Label2b.Text = dt.Rows[0]["center_name"].ToString();
        //        Label6.Text = dt.Rows[0]["center_name"].ToString();
        //        d.Add("center_code", dt.Rows[0]["center_code"].ToString());
        //        //Label4.Text = dt.Rows[0]["center_code"].ToString();
        //        hf_Center_code.Value = dt.Rows[0]["center_code"].ToString();
        //        hf_Center_code_SQL.Value = dt.Rows[0]["center_code"].ToString();
        //        //Label7.Text = dt.Rows[0]["center_code"].ToString();
        //        //Label_Acc.Text = a.AccountName;
        //        hf_Acc.Value = a.AccountName;
        //        //查詢最新鑑測官簽章
        //        dt1 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='1'order and start_date<GETDATE() by start_date desc", d);
        //        dt11 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='1'order  by start_date desc", d);
        //        //查詢最新鑑測主任簽章
        //        dt2 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='2' and start_date<GETDATE() order by start_date desc", d);
        //        dt22 = du.getDataTableByText(@"select top 1 * from Center_Seal where center_code=@center_code and rank_code='2' order by start_date desc", d);
        //        //GridView1.DataSource = dt1;
        //        //GridView1.DataBind();
        //        if (dt1.Rows.Count == 1)  //表示有資料
        //        {

        //            if (!string.IsNullOrEmpty(dt1.Rows[0]["img_byte"].ToString()))
        //            {
        //                byte[] PhotoByte = (byte[])dt1.Rows[0]["img_byte"];
        //                ImageConverter ic = new ImageConverter();
        //                System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
        //                Image1b.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
        //                Label7a.Text = "目前使用簽章啟用日期：";
        //                Label7b.Text = Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).ToString("yyyy/MM/dd");
        //                //DateTime d1 = Convert.ToDateTime((Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd 00:00:00"));
        //                //DateTime d2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd 00:00:00"));
        //                //if (d1 > d2)
        //                //    Label14.Text = "與前筆資料之「啟用時間」間隔未達二天無法上傳簽章!!";
        //                //else
        //                    //Label14.Text = "(日期輸入範圍值：" + (Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd") + "～" + DateTime.Now.ToString("yyyy/MM/dd)");
        //                    Label14.Text = "(啟用日期輸入範圍：" + (Convert.ToDateTime(dt11.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd") + "～)";
        //            }
        //            else
        //            {
        //                Image1b.AlternateText = "請先新增鑑測官簽章資料!!";
        //                Label7b.Text = "2016/01/01";
        //                //Label14.Text = "(日期輸入範圍值：2016/01/01" + "～" + DateTime.Now.ToString("yyyy/MM/dd)");
        //                Label14.Text = "(啟用日期輸入範圍：：2016/01/01" + "～)" ;
        //            }

        //        }
        //        else
        //        {
        //            Image1b.ImageUrl = null;
        //            Image1b.AlternateText = "請先新增鑑測官簽章資料!!";
        //            Label7b.Text = "2016/01/01";
        //            Label14.Text = "(啟用日期輸入範圍：2016/01/01" + "～)";
        //        }

        //        if (dt2.Rows.Count == 1)
        //        {
        //            if (!string.IsNullOrEmpty(dt2.Rows[0]["img_byte"].ToString()))
        //            {
        //                byte[] PhotoByte = (byte[])dt2.Rows[0]["img_byte"];
        //                ImageConverter ic = new ImageConverter();
        //                System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
        //                Image2b.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
        //                Label8a.Text = "目前使用簽章啟用日期：";
        //                Label8b.Text = Convert.ToDateTime(dt2.Rows[0]["start_date"].ToString()).ToString("yyyy/MM/dd");
        //                //DateTime d1 = Convert.ToDateTime((Convert.ToDateTime(dt2.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd 00:00:00"));
        //                //DateTime d2 = Convert.ToDateTime(DateTime.Now.ToString("yyyy/MM/dd 00:00:00"));
        //                //if (d1 > d2)
        //                //    Label15.Text = "與前筆資料之「啟用時間」間隔未達二天無法上傳簽章!!";
        //                //else
        //                    //Label15.Text = "(日期輸入範圍值：" + (Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd") + "～" + DateTime.Now.ToString("yyyy/MM/dd)");
        //                    Label15.Text = "(啟用日期輸入範圍：" + (Convert.ToDateTime(dt11.Rows[0]["start_date"].ToString()).AddDays(+2)).ToString("yyyy/MM/dd") + "～)";
        //            }
        //            else
        //            {
        //                Image2b.AlternateText = "請先新增鑑測主任簽章資料!!";
        //                Label8b.Text = "2016/01/01";
        //                //Label15.Text = "(日期輸入範圍值：2016/01/01" + "～" + DateTime.Now.ToString("yyyy/MM/dd)");
        //                Label15.Text = "(啟用日期輸入範圍：2016/01/01" + "開始";
        //            }


        //        }
        //        else
        //        {
        //            Image2b.ImageUrl = null;
        //            Image2b.AlternateText = "請先新增鑑測主任簽章資料!!";
        //            Label8b.Text = "2016/01/01";
        //            //Label15.Text = "(日期輸入範圍值：2016/01/01" + "～" + DateTime.Now.ToString("yyyy/MM/dd)");
        //            Label15.Text = "(啟用日期輸入範圍：2016/01/01" + "開始";
        //        }

        //    }
        //    else
        //    {

        //    }

        //}
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
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }
    protected void Button5_Click1(object sender, EventArgs e)
    {
        page = 1;
        Response.Redirect(Request.Url.ToString());
        
    }
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

}
