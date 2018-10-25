using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sourceupload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null && (string)Session["admin"] != "true")
        {
            Response.Redirect("~/AdminLogin.aspx");
        }
        else
        {
            if (Request.QueryString["url"] != null)
            {
                Response.Write("Your Target File is <h3>" + Request.QueryString["url"].ToString() + "</h3>");
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string old_src = Request.QueryString["url"].ToString();

            string new_src = FileUpload1.PostedFile.FileName;

            string[] spliter = { "\\" };

            string[] checks_old = old_src.Split(spliter, StringSplitOptions.None);

            string[] checks_new = new_src.Split(spliter,StringSplitOptions.None);

            if (checks_old[checks_old.Length - 1] == checks_new[checks_new.Length - 1])
            {
                HttpPostedFile file = FileUpload1.PostedFile;

                file.SaveAs(old_src);

                Response.Write("Upload Done!!!");
            }
            else
            {
                Response.Write("Wrong File Upload");
            }
        }
    }
}
