using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HQ_Bulletin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SqlDataSource1.SelectParameters["acc"].DefaultValue = ((Lib.Account)Session["account"]).AccountName;
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[3].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[3].Text);
            e.Row.Cells[4].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[4].Text);
            if (e.Row.Cells[5].Text == "1")
            {
                e.Row.Cells[5].Text = "顯示";
            }
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
