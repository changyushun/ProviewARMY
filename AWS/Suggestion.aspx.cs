using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Suggestion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["player"] != null)
        {
            Lib.Player a = (Lib.Player)Session["player"];
            SqlDataSource1.SelectParameters["player"].DefaultValue = a.ID;
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[3].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[3].Text);
        e.Row.Cells[2].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[2].Text);
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
