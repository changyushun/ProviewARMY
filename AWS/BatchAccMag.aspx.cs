using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BatchAccMag : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["unit_code"].DefaultValue = TextBox1.Text.Trim();
        SqlDataSource1.SelectParameters["byAcc"].DefaultValue = ((Lib.Account)Session["Account"]).AccountName;
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
        string sid = ((HiddenField)row.Cells[8].FindControl("HiddenField1")).Value;
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "window.open('AccEdit.aspx?sid=' + " + sid + ",'','toolbars=no,width=300,height=500');", true);
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
