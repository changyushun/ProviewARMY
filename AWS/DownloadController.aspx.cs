using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.IO;
using System.Text;
using System.Data.SqlClient;

public partial class DownloadController : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["AttachID"] != null)
        {
            string attachid = Request.QueryString["AttachID"];
            try
            {
                Lib.DataUtility du = new DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("attachid", attachid);
                //System.Data.DataTable dt = du.getDataTableByText("select filename, filepath, data from filemanage where [sid] = " + attachid);
                System.Data.DataTable dt = du.getDataTableByText("select filename, filepath, data from filemanage where [sid] = @attachid", d);
                if (dt.Rows.Count > 0)
                {
                    string filename = dt.Rows[0]["filename"].ToString();
                    if (Request.Browser.Browser == "IE")
                        filename = Server.UrlPathEncode(filename);
                    string filepath = dt.Rows[0]["filepath"].ToString();
                    filename += "." + filepath.Split(new string[] { "." }, StringSplitOptions.None)[1];
                    byte[] data = dt.Rows[0]["data"] as byte[];
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("Content-Length", data.Length.ToString());
                    Response.AddHeader("content-disposition", String.Format("inline; filename={0}; attachment", filename));
                    Response.BinaryWrite(data);
                    Response.Flush();
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                Label1.Text = "檔案不存在";
            }
        }


        #region OLD CODE
        //try
        //{
        //    string dd = Server.MapPath(Request.ApplicationPath);
        //    FileStream sourceFile = new FileStream(dd + "\\Uploads\\" + Request.QueryString["AttachID"], FileMode.Open);
        //    //if sourceFile.
        //    string extension = System.IO.Path.GetExtension(Request.QueryString["AttachID"]);
        //    if (extension == ".doc" || extension == ".docx") 
        //    {
        //        Response.ContentType = "application/ms-word";
        //        Response.ContentEncoding = Encoding.UTF8; 
        //        Response.AddHeader("content-disposition", "attachment; filename=" + Request.QueryString["AttachID"]);
        //    }
        //    else if (extension == ".PDF" || extension == ".pdf")
        //    {
        //        Response.ContentType = "application/PDF";
        //        Response.ContentEncoding = Encoding.UTF8;
        //        Response.AddHeader("content-disposition", "attachment; filename=" + Request.QueryString["AttachID"]);
        //    }
        //    long FileSize;
        //    FileSize = sourceFile.Length;
        //    byte[] getContent = new byte[(int)FileSize];
        //    sourceFile.Read(getContent, 0, (int)sourceFile.Length);
        //    sourceFile.Close();
        //    Response.BinaryWrite(getContent);
        //}
        //catch (Exception ex)
        //{
        //    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        //    Label1.Text = "檔案不存在";
        //}
        #endregion
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
