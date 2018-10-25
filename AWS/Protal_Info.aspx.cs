using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Lib;
using System.Collections.Generic;

public partial class Protal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["date"].DefaultValue = DateTime.Today.ToShortDateString();
        SqlDataSource1.SelectParameters["center_code"].DefaultValue = Request.QueryString["sid"].Trim();

        Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.DataUtility du = new DataUtility();
        d.Add("date", DateTime.Today.ToShortDateString());
        d.Add("center_code", Request.QueryString["sid"].Trim());
        DataTable dt = du.getDataTableBysp(@"Ex102_QueryReserve_Infor", d);
        if (dt.Rows.Count == 1)
        {
            center_name.Text = dt.Rows[0]["center_name"].ToString();
            total.Text = dt.Rows[0]["total"].ToString() + "人";         
        }
 
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.DataItemIndex > -1)
        e.Row.Cells[0].Text = (e.Row.DataItemIndex + 1).ToString();
    }
}
