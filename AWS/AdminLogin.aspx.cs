using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (TextBox1.Text.Trim() == "sam" && TextBox2.Text.Trim() == "1qaz2wsx3edc")
        {
            Session["admin"] = true.ToString();
            Response.Redirect("~/Admin.aspx");
        }
    }
}
