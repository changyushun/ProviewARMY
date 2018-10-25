using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Data;
public partial class New_Transcripts : System.Web.UI.Page
{
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
    protected void Page_Load(object sender, EventArgs e)
    {
        string t1 = "2016/12/31";
        string t2 = Request.QueryString["date"].ToString();
        DateTime tt1 = DateTime.Parse(t1);
        DateTime tt2 = DateTime.Parse(t2);
        if (tt1.CompareTo(tt2) < 0)
        {
            //加這段才能印中文成績單
            Response.HeaderEncoding = System.Text.Encoding.GetEncoding("big5");
            //開始處理變動表格
            Dictionary<string, object> d = new Dictionary<string, object>();
            Lib.DataUtility du = new Lib.DataUtility();
            string LB_CenterName = string.Empty;
            string LB_Date = string.Empty;
            string LB_Unit = string.Empty;
            string LB_Rank = string.Empty;
            string LB_BirthAge = string.Empty;
            string LB_Date_Re = string.Empty;
            string LB_Message = string.Empty;
            string LB_BMI = string.Empty;
            string LB_Name = string.Empty;
            string LB_Id = string.Empty;
            string LB_BodyFat = string.Empty;
            string LB_Situps_Name = string.Empty;
            string LB_Situps_Count = string.Empty;
            string LB_Situps_Score = string.Empty;
            string LB_Situps_Status = string.Empty;
            string LB_Pushups_Name = string.Empty;
            string LB_Pushups_Count = string.Empty;
            string LB_Pushups_Score = string.Empty;
            string LB_Pushups_Status = string.Empty;
            string LB_Run_Name = string.Empty;
            string LB_Run_Count = string.Empty;
            string LB_Run_Score = string.Empty;
            string LB_Run_Status = string.Empty;
            string LB_TotalStatus = string.Empty;
            string Jpg_Name = string.Empty;
            string Center_code = string.Empty;
            //2016-8-8新增sid，驗證碼
            string Sid = string.Empty;
            //2016-8-15新增鑑測官及主任章
            //鑑測官
            string sing1_unit = string.Empty;//單位
            string sing1_rank = string.Empty;//級職
            string sing1_name = string.Empty;//姓名
            //鑑測主任
            string sing2_unit = string.Empty;//單位
            string sing2_rank = string.Empty;//級職
            string sing2_name = string.Empty;//姓名
            byte[] img1 = null;
            byte[] img2 = null;
            //2016-12-6新增狀態碼status，在未受測之狀態無法列印
            string LB_Status = string.Empty;



            try
            {
                d.Clear();
                d.Add("id", Request.QueryString["id"].ToString());
                d.Add("date", Request.QueryString["date"].ToString());
                //西元轉民國
                string Rocdate = Lib.SysSetting.ToRocDateFormat(Request.QueryString["date"].ToString());
                Jpg_Name = Request.QueryString["id"].ToString() + "(" + Rocdate + ").jpg";
                //d.Add("id", "A121429819");
                //d.Add("date", "2015/07/28");
                //Title = Request.QueryString["id"].ToString() + "成績單";

                //舊sp
                //DataTable dt_Score = du.getDataTableBysp(@"Ex104_CalResultByID", d);
                //新sp
                DataTable dt_Score = du.getDataTableBysp(@"Ex106_GetTranscript_Date", d);
                Center_code = dt_Score.Rows[0]["center_code"].ToString();



                if (dt_Score.Rows.Count == 1)
                {
                    //2016-12-6新增判斷是否已受測
                    LB_Status = dt_Score.Rows[0]["status"].ToString();
                    if (LB_Status == "000" | LB_Status == "001" | LB_Status == "999")//成績未上傳或未測無法查詢
                    {
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "該筆成績尚未鑑測或成績未回傳無法列印!!" + "')", true);
                    }
                    else
                    {
                        //if (dt_Score.Rows[0]["Seal_img1"] == System.DBNull.Value | dt_Score.Rows[0]["Seal_img2"] == System.DBNull.Value)
                        //{
                        //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "受測日期無鑑測簽章檔案無法列印，請連絡該鑑測站確認，謝謝!!" + "')", true);
                        //}
                        //else
                        //{
                        //輸出圖片
                        if (dt_Score.Rows[0]["Seal_img1"] != System.DBNull.Value)
                            img1 = (byte[])dt_Score.Rows[0]["Seal_img1"];
                        if (dt_Score.Rows[0]["Seal_img2"] != System.DBNull.Value)
                            img2 = (byte[])dt_Score.Rows[0]["Seal_img2"];

                        LB_CenterName = dt_Score.Rows[0]["center_name"].ToString() + "鑑測站成績單(網路)";
                        LB_Date = "鑑測日期：" + dt_Score.Rows[0]["date"].ToString();
                        LB_Unit = dt_Score.Rows[0]["unit_code"].ToString();
                        LB_Rank = dt_Score.Rows[0]["rank_code"].ToString();
                        LB_BirthAge = dt_Score.Rows[0]["birth"].ToString() + " (" + dt_Score.Rows[0]["age"].ToString() + "歲)";
                        //if (dt_Score.Rows[0]["status"].ToString().Substring(0, 1) == "2")
                        //{
                        LB_Date_Re = "列印日期：" + Lib.SysSetting.ToRocDateFormat(System.DateTime.Today.ToString("yyyy/MM/dd"));
                        //}
                        //else
                        //{
                        //LB_Date_Re = string.Empty;
                        //}

                        if (dt_Score.Rows[0]["status"].ToString().Substring(2, 1) == "4")
                        {
                            LB_Message = "BMI值(體脂率)未達鑑測標準(醫官簽名)";
                        }
                        else
                        {
                            LB_Message = string.Empty;
                        }

                        if (!String.IsNullOrEmpty(dt_Score.Rows[0]["BMI"].ToString()))
                            LB_BMI = dt_Score.Rows[0]["BMI"].ToString() + " %";
                        LB_Name = dt_Score.Rows[0]["name"].ToString();
                        LB_Id = dt_Score.Rows[0]["id"].ToString();
                        if (!String.IsNullOrEmpty(dt_Score.Rows[0]["bodyfat"].ToString()))
                            LB_BodyFat = dt_Score.Rows[0]["bodyfat"].ToString() + " %";

                        LB_Situps_Name = dt_Score.Rows[0]["sit_ups_name"].ToString();
                        LB_Situps_Count = dt_Score.Rows[0]["sit_ups"].ToString();
                        //2016-12-20新增
                        if (dt_Score.Rows[0]["sit_ups_score"].ToString() == "0")
                            LB_Situps_Score = "-";
                        else
                            LB_Situps_Score = dt_Score.Rows[0]["sit_ups_score"].ToString();
                        LB_Situps_Status = dt_Score.Rows[0]["sit_ups_result"].ToString();


                        LB_Pushups_Name = dt_Score.Rows[0]["push_ups_name"].ToString();
                        LB_Pushups_Count = dt_Score.Rows[0]["push_ups"].ToString();
                        if (dt_Score.Rows[0]["push_ups_score"].ToString() == "0")
                            LB_Pushups_Score = "-";
                        else
                            LB_Pushups_Score = dt_Score.Rows[0]["push_ups_score"].ToString();
                        LB_Pushups_Status = dt_Score.Rows[0]["push_ups_result"].ToString();


                        LB_Run_Name = dt_Score.Rows[0]["run_name"].ToString();
                        LB_Run_Count = dt_Score.Rows[0]["run"].ToString();
                        if (dt_Score.Rows[0]["run_score"].ToString() == "0")
                            LB_Run_Score = "-";
                        else
                            LB_Run_Score = dt_Score.Rows[0]["run_score"].ToString();
                        LB_Run_Status = dt_Score.Rows[0]["run_result"].ToString();

                        //鑑測官印章資料
                        if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_unit1"].ToString()))//單位
                            sing1_unit = dt_Score.Rows[0]["Seal_unit1"].ToString();
                        if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_rank1"].ToString()))//級職
                            sing1_rank = dt_Score.Rows[0]["Seal_rank1"].ToString();
                        if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_name1"].ToString()))//姓名
                            sing1_name = dt_Score.Rows[0]["Seal_name1"].ToString();
                        //鑑測主任印章資料
                        if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_unit2"].ToString()))//單位
                            sing2_unit = dt_Score.Rows[0]["Seal_unit2"].ToString();
                        if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_rank2"].ToString()))//級職
                            sing2_rank = dt_Score.Rows[0]["Seal_rank2"].ToString();
                        if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_name2"].ToString()))//姓名
                            sing2_name = dt_Score.Rows[0]["Seal_name2"].ToString();

                        LB_TotalStatus = dt_Score.Rows[0]["total_status"].ToString();
                        //SID不足10碼前面補0補到10碼
                        if (string.IsNullOrEmpty(dt_Score.Rows[0]["sid"].ToString()) | dt_Score.Rows[0]["sid"].ToString() == "0")
                        {
                            Sid = "0";
                        }
                        else
                        {
                            Sid = String.Format("{0:0000000000}", Convert.ToInt64(dt_Score.Rows[0]["sid"].ToString()));
                        }

                        // <snippet2>
                        // Set the page's content type to JPEG files
                        // and clears all content output from the buffer stream.
                        Response.ContentType = "image/jpeg";
                        Response.Clear();
                        //加入這一段才能直接存檔
                        //Response.AddHeader("Content-Disposition", "attachment; filename = result.jpg");
                        //成績單名字
                        Response.AddHeader("Content-Disposition", "attachment; filename = " + Jpg_Name);

                        // Buffer response so that page is sent
                        // after processing is complete.
                        Response.BufferOutput = true;
                        // </snippet2>

                        // Create a font style.
                        Font Title_Font = new Font(
                            "標楷體", 72, FontStyle.Bold);

                        Font Content_Font = new Font(
                            "標楷體", 44, FontStyle.Bold);
                        Font Content_Font_Big = new Font(
                                "標楷體", 50, FontStyle.Bold);
                        Font Content_Font_Big2 = new Font(
                                    "標楷體", 58, FontStyle.Bold);
                        Font Content_Font_Small = new Font(
                                "標楷體", 30);

                        // Create integer variables.
                        //72dpi
                        //int height = 842;
                        //int width = 595;

                        //300dpi
                        int height = 3508;
                        int width = 2480;
                        //表格的長寬
                        int table_width = Convert.ToInt32(width * 0.8);
                        int table_height = Convert.ToInt32(height * 0.2); //0.188
                        //表格最左上角定位點
                        int table_x = Convert.ToInt32(width * 0.2) / 2;
                        int table_y = Convert.ToInt32(height * 0.43);


                        // Create a bitmap and use it to create a
                        // Graphics object.
                        Bitmap bmp = new Bitmap(width, height, PixelFormat.Format24bppRgb);
                        //Bitmap bmp = new Bitmap(width, height, PixelFormat.Format64bppPArgb);

                        Graphics g = Graphics.FromImage(bmp);


                        g.SmoothingMode = SmoothingMode.AntiAlias;
                        g.Clear(Color.White);
                        Bitmap logo = new Bitmap(Server.MapPath("~/images/106_Transcripts_logo.jpg")); //底圖

                        //底圖原尺寸
                        //g.DrawImage(logo, new RectangleF(0, 0, width, height));
                        //底圖縮小
                        g.DrawImage(logo, new RectangleF((float)(width * 0.06), (float)(height * 0.06), (float)(width * 0.88), (float)(height * 0.88)));




                        //// Use the Graphics object to draw three rectangles.
                        StringFormat stringFormat = new StringFormat();
                        stringFormat.Alignment = StringAlignment.Center;
                        stringFormat.LineAlignment = StringAlignment.Center;




                        //標題文字
                        g.DrawString("國軍體能鑑測中心", Title_Font, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1), width, 120), stringFormat);
                        //g.DrawString("陸軍成功嶺鑑測站成績單(人工)", Title_Font, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1) + 120, width, 120), stringFormat);
                        g.DrawString(LB_CenterName, Title_Font, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1) + 120, width, 120), stringFormat);

                        //個人資料固定文字(還沒改)
                        g.DrawString("單位：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y - 600, 0, 0));
                        g.DrawString("級職：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y - 480, 0, 0));
                        g.DrawString("生日：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y - 360, 0, 0));
                        g.DrawString("BMI：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y - 240, 0, 0));

                        g.DrawString("姓名：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 970, (float)table_y - 480, 0, 0));
                        g.DrawString("身份證字號：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 970, (float)table_y - 360, 0, 0));
                        g.DrawString("體脂率：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 970, (float)table_y - 240, 0, 0));

                        //g.DrawString("總評：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y + 1150, 0, 0));
                        g.DrawString("總評：", Content_Font_Big2, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y + 1350, 0, 0));

                        g.DrawString("鑑測官簽章：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 1000, (float)table_y + 1150, 0, 0));
                        g.DrawString("鑑測主任簽章：", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 940, (float)table_y + 1450, 0, 0));
                        //畫網路驗證碼
                        if (Sid == "0" | string.IsNullOrEmpty(Sid))
                        {
                            g.DrawString("<成績單驗證碼異常，無法取得驗證碼>", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 940, (float)table_y + 720, 0, 0));
                        }
                        else
                        {
                            g.DrawString("<驗證碼：" + Sid + ">", Content_Font_Big, SystemBrushes.WindowText, new RectangleF((float)table_x + 1280, (float)table_y + 720, 0, 0));
                        }



                        g.DrawString("成績單驗證流程：", Content_Font_Small, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y + 720, 0, 0));
                        g.DrawString("1、登入「國軍基本體能鑑測網」首頁。", Content_Font_Small, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y + 770, 0, 0));
                        g.DrawString("2、點選首頁上方「成績單驗證」連結至驗證頁面。", Content_Font_Small, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y + 820, 0, 0));
                        g.DrawString("3、輸入「身份證字號」及「驗證碼」即可進行驗證。", Content_Font_Small, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y + 870, 0, 0));
                        //固定欄位表格文字(直)
                        //g.DrawString("項目", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x,(float)table_y,(float)(table_width*0.25),(float)(table_height*0.25)),stringFormat);
                        //g.DrawString("仰臥起坐", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.25), (float)(table_height * 0.75)), stringFormat);
                        //g.DrawString("伏地挺身", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.25), (float)(table_height * 1.25)), stringFormat);
                        //g.DrawString("3000公尺跑步", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.25), (float)(table_height * 1.75)), stringFormat);
                        //固定欄位表格文字(橫)
                        g.DrawString("項目", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.25), (float)(table_height * 0.25)), stringFormat);
                        g.DrawString("次數/時間", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.75), (float)(table_height * 0.25)), stringFormat);
                        g.DrawString("成績", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.25), (float)(table_height * 0.25)), stringFormat);
                        g.DrawString("判定", Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.75), (float)(table_height * 0.25)), stringFormat);

                        //畫表格的線條 , 先畫橫線 , 因為 Rows = 4 , 所以每條線得間距是 25% * Height
                        Pen table_pen = new Pen(Color.Black, 2);
                        g.DrawLine(table_pen, new Point(table_x, table_y), new Point(width - table_x, table_y));
                        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 0.25)), new Point(width - table_x, table_y + (int)(table_height * 0.25)));
                        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 0.5)), new Point(width - table_x, table_y + (int)(table_height * 0.5)));
                        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 0.75)), new Point(width - table_x, table_y + (int)(table_height * 0.75)));
                        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 1)), new Point(width - table_x, table_y + (int)(table_height * 1)));

                        // 再來畫直線 , Columns = 4 , 參照TableLayoutPanel1的屬性Colums採用裡面設定的比例 , 每天線得間距依序為 : 30% 24% 25% 21%
                        g.DrawLine(table_pen, new Point(table_x, table_y), new Point(table_x, table_y + table_height));
                        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 0.25), table_y), new Point(table_x + (int)(table_width * 0.25), table_y + table_height));
                        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 0.5), table_y), new Point(table_x + (int)(table_width * 0.5), table_y + table_height));
                        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 0.75), table_y), new Point(table_x + (int)(table_width * 0.75), table_y + table_height));
                        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 1), table_y), new Point(table_x + (int)(table_width * 1), table_y + table_height));

                        //鑑測簽章表格
                        //鑑測官矩形表格
                        g.DrawRectangle(table_pen, table_x + 1400, table_y + 1150, 520, 220);
                        //鑑測主任矩形表格
                        g.DrawRectangle(table_pen, table_x + 1400, table_y + 1450, 520, 220);

                        //鑑測章內容
                        SolidBrush redSB = new SolidBrush(Color.Red);//字設成紅色
                        Pen seal_pen2 = new Pen(Color.Red, 5);
                        StringFormat sealFormat = new StringFormat();
                        sealFormat.Alignment = StringAlignment.Center;
                        sealFormat.LineAlignment = StringAlignment.Center;

                        //印章字體
                        Font s1_unit = null;//鑑測官-單位
                        Font s1_rank = null;//鑑測官-級職
                        Font s2_unit = null;//鑑測主任-單位
                        Font s2_rank = null;//鑑測主任-級職

                        ////測試用
                        //sing1_unit = "花防部鑑測站";
                        //sing1_rank = "鑑測官";
                        //sing1_name = "徐太宇";
                        //sing2_unit = "海軍陸戰隊學校";
                        //sing2_rank = "鑑測主任";
                        //sing2_name = "歐陽非凡";

                        //用switch處理
                        //鑑測官單位
                        int u1 = 0;
                        if (sing1_unit.Length <= 6)
                            u1 = 6;
                        else
                            u1 = sing1_unit.Length;
                        switch (u1)
                        {
                            case 6:
                                s1_unit = new Font("標楷體", 34, FontStyle.Bold);//6個字
                                break;
                            case 7:
                                s1_unit = new Font("標楷體", 30, FontStyle.Bold);//7個字
                                break;
                            case 8:
                                s1_unit = new Font("標楷體", 26, FontStyle.Bold);//8個字
                                break;
                            case 9:
                                s1_unit = new Font("標楷體", 24, FontStyle.Bold);//9個字
                                break;
                            case 10:
                                s1_unit = new Font("標楷體", 22, FontStyle.Bold);//10個字
                                break;
                            case 11:
                                s1_unit = new Font("標楷體", 20, FontStyle.Bold);//11個字
                                break;
                            case 12:
                                s1_unit = new Font("標楷體", 18, FontStyle.Bold);//12個字
                                break;
                            default:
                                s1_unit = new Font("標楷體", 16, FontStyle.Bold);//其他(超過12個字)
                                break;
                        }
                        //鑑測官級職
                        int r1 = 0;
                        if (sing1_rank.Length <= 6)
                            r1 = 6;
                        else
                            r1 = sing1_rank.Length;
                        switch (r1)
                        {
                            case 6:
                                s1_rank = new Font("標楷體", 34, FontStyle.Bold);//6個字
                                break;
                            case 7:
                                s1_rank = new Font("標楷體", 30, FontStyle.Bold);//7個字
                                break;
                            case 8:
                                s1_rank = new Font("標楷體", 26, FontStyle.Bold);//8個字
                                break;
                            case 9:
                                s1_rank = new Font("標楷體", 24, FontStyle.Bold);//9個字
                                break;
                            case 10:
                                s1_rank = new Font("標楷體", 22, FontStyle.Bold);//10個字
                                break;
                            case 11:
                                s1_rank = new Font("標楷體", 20, FontStyle.Bold);//11個字
                                break;
                            case 12:
                                s1_rank = new Font("標楷體", 18, FontStyle.Bold);//12個字
                                break;
                            default:
                                s1_rank = new Font("標楷體", 16, FontStyle.Bold);//其他(超過12個字)
                                break;
                        }
                        //鑑測主任單位
                        int u2 = 0;
                        if (sing2_unit.Length <= 6)
                            u2 = 6;
                        else
                            u2 = sing2_unit.Length;
                        switch (u2)
                        {
                            case 6:
                                s2_unit = new Font("標楷體", 34, FontStyle.Bold);//6個字
                                break;
                            case 7:
                                s2_unit = new Font("標楷體", 30, FontStyle.Bold);//7個字
                                break;
                            case 8:
                                s2_unit = new Font("標楷體", 26, FontStyle.Bold);//8個字
                                break;
                            case 9:
                                s2_unit = new Font("標楷體", 24, FontStyle.Bold);//9個字
                                break;
                            case 10:
                                s2_unit = new Font("標楷體", 22, FontStyle.Bold);//10個字
                                break;
                            case 11:
                                s2_unit = new Font("標楷體", 20, FontStyle.Bold);//11個字
                                break;
                            case 12:
                                s2_unit = new Font("標楷體", 18, FontStyle.Bold);//12個字
                                break;
                            default:
                                s2_unit = new Font("標楷體", 16, FontStyle.Bold);//其他(超過12個字)
                                break;
                        }
                        //鑑測官級職
                        int r2 = 0;
                        if (sing1_rank.Length <= 6)
                            r2 = 6;
                        else
                            r2 = sing1_rank.Length;
                        switch (r2)
                        {
                            case 6:
                                s2_rank = new Font("標楷體", 34, FontStyle.Bold);//6個字
                                break;
                            case 7:
                                s2_rank = new Font("標楷體", 30, FontStyle.Bold);//7個字
                                break;
                            case 8:
                                s2_rank = new Font("標楷體", 26, FontStyle.Bold);//8個字
                                break;
                            case 9:
                                s2_rank = new Font("標楷體", 24, FontStyle.Bold);//9個字
                                break;
                            case 10:
                                s2_rank = new Font("標楷體", 22, FontStyle.Bold);//10個字
                                break;
                            case 11:
                                s2_rank = new Font("標楷體", 20, FontStyle.Bold);//11個字
                                break;
                            case 12:
                                s2_rank = new Font("標楷體", 18, FontStyle.Bold);//12個字
                                break;
                            default:
                                s2_rank = new Font("標楷體", 16, FontStyle.Bold);//其他(超過12個字)
                                break;
                        }
                        

                        Font seal_font_name = new Font("標楷體", 48, FontStyle.Bold);//姓名

                        //鑑測印章外框
                        Pen seal_pen = new Pen(Color.Red, 15);

                        ////章用畫的，不是用img
                        ////鑑測官//先檢查有無資料
                        if (!string.IsNullOrEmpty(sing1_unit) & !string.IsNullOrEmpty(sing1_rank) & !string.IsNullOrEmpty(sing1_name))
                        {
                            DrawSpacedText(g, s1_unit, redSB, new Point(table_x + 1422, table_y + 1200), sing1_unit, 260);
                            DrawSpacedText(g, s1_rank, redSB, new Point(table_x + 1422, table_y + 1280), sing1_rank, 260);
                            DrawSpacedText(g, seal_font_name, redSB, new Point(table_x + 1662, table_y + 1230), sing1_name, 240);
                            g.DrawRectangle(seal_pen, table_x + 1420, table_y + 1170, 480, 180);//鑑測官外框
                        }
                        else
                        {
                            DrawSpacedText(g, Content_Font, redSB, new Point(table_x + 1422, table_y + 1230), "鑑測站簽章未上傳", 470);
                        }
                        ////鑑測主任//先檢查有無資料
                        if (!string.IsNullOrEmpty(sing2_unit) & !string.IsNullOrEmpty(sing2_rank) & !string.IsNullOrEmpty(sing2_name))
                        {
                            DrawSpacedText(g, s2_unit, redSB, new Point(table_x + 1422, table_y + 1500), sing2_unit, 260);
                            DrawSpacedText(g, s2_rank, redSB, new Point(table_x + 1422, table_y + 1580), sing2_rank, 260);
                            DrawSpacedText(g, seal_font_name, redSB, new Point(table_x + 1662, table_y + 1530), sing2_name, 240);
                            g.DrawRectangle(seal_pen, table_x + 1420, table_y + 1470, 480, 180);//鑑測主任外框
                        }
                        else
                        {
                            DrawSpacedText(g, Content_Font, redSB, new Point(table_x + 1422, table_y + 1530), "鑑測站簽章未上傳", 470);
                        }


                        //寫入鑑測及列印日期
                        g.DrawString(LB_Date, Content_Font, SystemBrushes.WindowText, new RectangleF((int)(width * 0.6) + 60, (int)(height * 0.1) + 240, 0, 0));
                        g.DrawString(LB_Date_Re, Content_Font, SystemBrushes.WindowText, new RectangleF((int)(width * 0.6) + 60, (int)(height * 0.1) + 320, 0, 0));
                        //寫入個人資料
                        g.DrawString(LB_Unit, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 180, (float)table_y - 600, 0, 0));
                        g.DrawString(LB_Rank, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 180, (float)table_y - 480, 0, 0));
                        g.DrawString(LB_BirthAge, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 180, (float)table_y - 360, 0, 0));
                        g.DrawString(LB_BMI, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 180, (float)table_y - 240, 0, 0));
                        g.DrawString(LB_Name, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 1150, (float)table_y - 480, 0, 0));
                        g.DrawString(LB_Id, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 1335, (float)table_y - 360, 0, 0));
                        g.DrawString(LB_BodyFat, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 1215, (float)table_y - 240, 0, 0));
                        //寫入醫官判定
                        g.DrawString(LB_Message, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y - 120, 0, 0));

                        //寫入個人成績
                        //先寫欄位名稱
                        g.DrawString(LB_Situps_Name, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.25), (float)(table_height * 0.75)), stringFormat);
                        g.DrawString(LB_Pushups_Name, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.25), (float)(table_height * 1.25)), stringFormat);
                        g.DrawString(LB_Run_Name, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.25), (float)(table_height * 1.75)), stringFormat);

                        //寫入次數/時間
                        g.DrawString(LB_Situps_Count, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.75), (float)(table_height * 0.75)), stringFormat);
                        g.DrawString(LB_Pushups_Count, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.75), (float)(table_height * 1.25)), stringFormat);
                        g.DrawString(LB_Run_Count, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 0.75), (float)(table_height * 1.75)), stringFormat);

                        //寫入成績
                        g.DrawString(LB_Situps_Score, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.25), (float)(table_height * 0.75)), stringFormat);
                        g.DrawString(LB_Pushups_Score, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.25), (float)(table_height * 1.25)), stringFormat);
                        g.DrawString(LB_Run_Score, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.25), (float)(table_height * 1.75)), stringFormat);

                        //寫入判定
                        g.DrawString(LB_Situps_Status, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.75), (float)(table_height * 0.75)), stringFormat);
                        g.DrawString(LB_Pushups_Status, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.75), (float)(table_height * 1.25)), stringFormat);
                        g.DrawString(LB_Run_Status, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x, (float)table_y, (float)(table_width * 1.75), (float)(table_height * 1.75)), stringFormat);

                        //寫入總評
                        //g.DrawString(LB_TotalStatus, Content_Font, SystemBrushes.WindowText, new RectangleF((float)table_x + 180, (float)table_y + 1150, 0, 0));
                        g.DrawString(LB_TotalStatus, Content_Font_Big2, SystemBrushes.WindowText, new RectangleF((float)table_x + 240, (float)table_y + 1350, 0, 0));

                        bmp.Save(Response.OutputStream, ImageFormat.Jpeg);

                        // Release memory used by the Graphics object
                        // and the bitmap.
                        g.Dispose();
                        bmp.Dispose();

                        // Send the output to the client.
                        Response.Flush();
                        Response.Clear();
                        // </snippet3>
                        //}
                    }

                }


                else if (dt_Score.Rows.Count == 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "查無此受測人員成績" + "')", true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "取得單日成績單數量為：" + dt_Score.Rows.Count.ToString() + "筆,超過乙筆以上，此為異常情況請洽鑑測中心鑑測官" + "')", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + ex.Message + "')", true);
            }

        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "電子成績單限「106/01/01」起之鑑測成績才能下載列印!!" + "')", true);
        }


    }

}