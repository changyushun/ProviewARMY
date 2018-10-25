using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HQ_ViewTeamPlayer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {

        }
        else
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (TextBox1.Text != "")
        {
            Lib.Account a = new Lib.Account();
            a = (Lib.Account)Session["account"];
            SqlDataSource1.SelectParameters["id"].DefaultValue = TextBox1.Text.Trim();
            SqlDataSource1.SelectParameters["unit_code"].DefaultValue = a.Unit_Code;
            this.Result.Style.Value = "";
        }
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        Label1.Text = GridView1.Rows.Count.ToString();
        if (GridView1.Rows.Count > 0)
        {
            GridView1.Rows[0].Cells[1].Text = Lib.SysSetting.ToRocDateFormat(GridView1.Rows[0].Cells[1].Text);
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
