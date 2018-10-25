using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Drawing;

public partial class Jpggen : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // <snippet2>
        // Set the page's content type to JPEG files
        // and clears all content output from the buffer stream.
        Response.ContentType = "image/jpeg";
        Response.Clear();

        // Buffer response so that page is sent
        // after processing is complete.
        Response.BufferOutput = true;
        // </snippet2>

        // Create a font style.
        Font rectangleFont = new Font(
            "Arial", 10, FontStyle.Bold);

        // Create integer variables.
        int height = 100;
        int width = 200;

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


        g.SmoothingMode = SmoothingMode.AntiAlias;
        g.Clear(Color.LightGray);

        // Use the Graphics object to draw three rectangles.
        g.DrawRectangle(Pens.White, 1, 1, width - 3, height - 3);
        g.DrawRectangle(Pens.Aquamarine, 2, 2, width - 3, height - 3);
        g.DrawRectangle(Pens.Black, 0, 0, width, height);

        // Use the Graphics object to write a string
        // on the rectangles.
        g.DrawString(
            "海軍陸戰隊鑑測中心 網路成績單", rectangleFont,
            SystemBrushes.WindowText, new PointF(10, 40));

        // Apply color to two of the rectangles.
        g.FillRectangle(
            new SolidBrush(
                Color.FromArgb(a, 255, 128, 255)),
            x, 20, 100, 50);

        g.FillRectangle(
            new LinearGradientBrush(
                new Point(x, 10),
                new Point(x1 + 75, 50 + 30),
                Color.FromArgb(128, 0, 0, 128),
                Color.FromArgb(255, 255, 255, 240)),
            x1, 50, 75, 30);

        // <snippet3>    
        // Save the bitmap to the response stream and
        // convert it to JPEG format.
        bmp.Save(Response.OutputStream, ImageFormat.Jpeg);

        // Release memory used by the Graphics object
        // and the bitmap.
        g.Dispose();
        bmp.Dispose();

        // Send the output to the client.
        Response.Flush();
        // </snippet3>
    }
}