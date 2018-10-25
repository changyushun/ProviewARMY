using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
public partial class CenterInforView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void cneterSel_SelectedIndexChanged(object sender, EventArgs e)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        DataTable dt = new DataTable();
        d.Add("center_code", cneterSel.SelectedValue);      
        dt = du.getDataTableByText("select information,imagepath from Center where center_code = @center_code",d);
        if(dt.Rows.Count == 1)
        {
            information.Text = dt.Rows[0]["information"].ToString();
            Image1.ImageUrl = dt.Rows[0]["imagepath"].ToString();
            //Image1.ImageUrl = "images/1.gif";
            Image1.Visible = true;
            //Image1.Height = 300;
            //Image1.Width = 200;
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
