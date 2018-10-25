using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.IO;

public partial class Default3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "image/jpeg";
        Response.Clear();
        
        // Buffer response so that page is sent
        // after processing is complete.
        Response.BufferOutput = true;
        Response.AddHeader("Content-Disposition", "attachment; filename = 成績單.jpg");
        // </snippet2>

        // Create a font style.
        Font Title_Font = new Font(
            "標楷體", 96, FontStyle.Bold);

        Font Content_Font = new Font(
            "標楷體", 56, FontStyle.Bold);
        // Create integer variables.
        int height = 3508;
        int width = 2480;

        int table_width = Convert.ToInt32(width * 0.8);
        int table_height = Convert.ToInt32(height * 0.2);
        // Create a random number generator and create
        // variable values based on it.
        Random r = new Random();
        int x = r.Next(75);
        int a = r.Next(155);
        int x1 = r.Next(100);

        // Create a bitmap and use it to create a
        // Graphics object.
        Bitmap bmp = new Bitmap(
            width, height, PixelFormat.Format24bppRgb);
        Graphics g = Graphics.FromImage(bmp);
        g.FillRectangle(Brushes.White, 0, 0, bmp.Width, bmp.Height);

        g.SmoothingMode = SmoothingMode.AntiAlias;
        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
        g.PixelOffsetMode = PixelOffsetMode.HighQuality;
        g.CompositingQuality = CompositingQuality.HighQuality;
        g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;

        //g.Clear(Color.LightGray);
        Bitmap logo = new Bitmap(Server.MapPath("~/images/FotoFlexer_Photo.png"));
        g.DrawImage(logo, new RectangleF(0, 0, width, height));

        //// Use the Graphics object to draw three rectangles.
        //g.DrawRectangle(Pens.White, 1, 1, width - 3, height - 3);
        //g.DrawRectangle(Pens.Aquamarine, 2, 2, width - 3, height - 3);
        //g.DrawRectangle(Pens.Black, 0, 0, width, height);
        StringFormat stringFormat = new StringFormat();
        stringFormat.Alignment = StringAlignment.Center;
        stringFormat.LineAlignment = StringAlignment.Center;
        g.DrawString("國軍體能鑑測中心", Title_Font, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1), width, 160), stringFormat);
        g.DrawString("陸軍成功嶺鑑測站成績單(人工)", Title_Font, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1) + 160, width, 160), stringFormat);

        g.DrawString("鑑測日期：", Content_Font, SystemBrushes.WindowText, new RectangleF((int)(width * 0.6), (int)(height * 0.1) + 320, 0, 0));
        g.DrawString("補印日期：", Content_Font, SystemBrushes.WindowText, new RectangleF((int)(width * 0.6), (int)(height * 0.1) + 400, 0, 0));
        //g.DrawString("陸軍成功嶺鑑測站成績單(人工)", rectangleFont, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1) + 20, width, 20), stringFormat);
        //g.DrawString("國軍體能鑑測中心", rectangleFont, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1), width, 20), stringFormat);
        //g.DrawString("陸軍成功嶺鑑測站成績單(人工)", rectangleFont, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1) + 20, width, 20), stringFormat);
        //g.DrawString("國軍體能鑑測中心", rectangleFont, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1), width, 20), stringFormat);
        //g.DrawString("陸軍成功嶺鑑測站成績單(人工)", rectangleFont, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1) + 20, width, 20), stringFormat);
        //g.DrawString("國軍體能鑑測中心", rectangleFont, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1), width, 20), stringFormat);
        //g.DrawString("陸軍成功嶺鑑測站成績單(人工)", rectangleFont, SystemBrushes.WindowText, new RectangleF(0, (int)(height * 0.1) + 20, width, 20), stringFormat);

        int table_x = Convert.ToInt32(width * 0.2) / 2;
        int table_y = Convert.ToInt32(height * 0.38);
        //畫表格的線條 , 先畫橫線 , 因為 Rows = 4 , 所以每條線得間距是 25% * Height
        Pen table_pen = new Pen(Color.Black, 4);
        g.DrawLine(table_pen, new Point(table_x, table_y), new Point(width - table_x, table_y));
        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 0.25)), new Point(width - table_x, table_y + (int)(table_height * 0.25)));
        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 0.5)), new Point(width - table_x, table_y + (int)(table_height * 0.5)));
        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 0.75)), new Point(width - table_x, table_y + (int)(table_height * 0.75)));
        g.DrawLine(table_pen, new Point(table_x, table_y + (int)(table_height * 1)), new Point(width - table_x, table_y + (int)(table_height * 1)));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X, pic2.Location.Y + pic.Location.Y + (int)(pic2.Height * 0.25)), new Point(pic2.Location.X + pic2.Width + pic.Location.X, pic2.Location.Y + pic.Location.Y + (int)(pic2.Height * 0.25)));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X, pic2.Location.Y + pic.Location.Y + (int)(pic2.Height * 0.5)), new Point(pic2.Location.X + pic2.Width + pic.Location.X, pic2.Location.Y + pic.Location.Y + (int)(pic2.Height * 0.5)));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X, pic2.Location.Y + pic.Location.Y + (int)(pic2.Height * 0.75)), new Point(pic2.Location.X + pic2.Width + pic.Location.X, pic2.Location.Y + pic.Location.Y + (int)(pic2.Height * 0.75)));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X, pic2.Location.Y + pic.Location.Y + pic2.Height), new Point(pic2.Location.X + pic2.Width + pic.Location.X, pic2.Location.Y + pic.Location.Y + pic2.Height));
        // 再來畫直線 , Columns = 4 , 參照TableLayoutPanel1的屬性Colums採用裡面設定的比例 , 每天線得間距依序為 : 30% 24% 25% 21%
        g.DrawLine(table_pen, new Point(table_x, table_y), new Point(table_x, table_y + table_height));
        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 0.3), table_y), new Point(table_x + (int)(table_width * 0.3), table_y + table_height));
        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 0.54), table_y), new Point(table_x + (int)(table_width * 0.54), table_y + table_height));
        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 0.79), table_y), new Point(table_x + (int)(table_width * 0.79), table_y + table_height));
        g.DrawLine(table_pen, new Point(table_x + (int)(table_width * 1), table_y), new Point(table_x + (int)(table_width * 1), table_y + table_height));
        //// 再來畫直線 , Columns = 4 , 參照TableLayoutPanel1的屬性Colums採用裡面設定的比例 , 每天線得間距依序為 : 30% 24% 25% 21%
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X, pic2.Location.Y + pic.Location.Y), new Point(pic2.Location.X + pic.Location.X, pic2.Location.Y + pic.Location.Y + pic2.Height));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 0.3), pic2.Location.Y + pic.Location.Y), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 0.3), pic2.Location.Y + pic.Location.Y + pic2.Height));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 0.54), pic2.Location.Y + pic.Location.Y), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 0.54), pic2.Location.Y + pic.Location.Y + pic2.Height));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 0.79), pic2.Location.Y + pic.Location.Y), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 0.79), pic2.Location.Y + pic.Location.Y + pic2.Height));
        //g.DrawLine(new Pen(Color.Black), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 1), pic2.Location.Y + pic.Location.Y), new Point(pic2.Location.X + pic.Location.X + (int)(pic2.Width * 1), pic2.Location.Y + pic.Location.Y + pic2.Height));

        //// Use the Graphics object to write a string
        //// on the rectangles.
        //g.DrawString(
        //    "ASP.NET Samples", rectangleFont,
        //    SystemBrushes.WindowText, new PointF(10, 40));

        //// Apply color to two of the rectangles.
        //g.FillRectangle(
        //    new SolidBrush(
        //        Color.FromArgb(a, 255, 128, 255)),
        //    x, 20, 100, 50);

        //g.FillRectangle(
        //    new LinearGradientBrush(
        //        new Point(x, 10),
        //        new Point(x1 + 75, 50 + 30),
        //        Color.FromArgb(128, 0, 0, 128),
        //        Color.FromArgb(255, 255, 255, 240)),
        //    x1, 50, 75, 30);

        // <snippet3>    
        // Save the bitmap to the response stream and
        // convert it to JPEG format.
        //Bitmap final = Resize(bmp, 0.25);
        bmp.Save(Response.OutputStream, ImageFormat.Png);

        // Release memory used by the Graphics object
        // and the bitmap.
        g.Dispose();
        bmp.Dispose();

        // Send the output to the client.
        Response.Flush();
    }

    public static Bitmap Resize(Bitmap originImage, Double times)
    {
        int width = Convert.ToInt32(originImage.Width * times);
        int height = Convert.ToInt32(originImage.Height * times);

        return Process(originImage, originImage.Width, originImage.Height, width, height);
    }

    private static Bitmap Process(Bitmap originImage, int oriwidth, int oriheight, int width, int height)
    {
        Bitmap resizedbitmap = new Bitmap(width, height);
        Graphics g = Graphics.FromImage(resizedbitmap);
        g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
        g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
        g.Clear(Color.Transparent);
        g.DrawImage(originImage, new Rectangle(0, 0, width, height), new Rectangle(0, 0, oriwidth, oriheight), GraphicsUnit.Pixel);
        return resizedbitmap;
    }
}