using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections.Generic;

public partial class upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		try
		{
			// Get the data
            HttpPostedFile jpeg_image_upload = Request.Files["Filedata"];
            byte[] data = new byte[jpeg_image_upload.ContentLength];
            jpeg_image_upload.InputStream.Read(data, 0, data.Length);
            jpeg_image_upload.InputStream.Close();
            var check = Request.Params["myname"];
            string dd = Server.MapPath(Request.ApplicationPath);
            string s = System.IO.Path.GetExtension(jpeg_image_upload.FileName);
            string _filetitle = System.DateTime.Now.ToFileTimeUtc().ToString();
            jpeg_image_upload.SaveAs(dd + "\\Uploads\\" + _filetitle + s);
            //jpeg_image_upload.SaveAs("D:\\Uploads\\" + _filetitle + s);
            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("filename", check);
            d.Add("filepath", _filetitle + s);
            d.Add("uploaddate", System.DateTime.Now);
            d.Add("data", data);
            du.executeNonQueryBysp("AddFile", d); 
		}
		catch(Exception ex)
		{
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
			Response.StatusCode = 500;
			Response.Write("An error occured");
			Response.End();
		}
		finally
		{
			Response.End();
		}	
	}
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
