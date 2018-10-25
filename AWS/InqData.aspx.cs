using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InqData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Label1.Text = "DB時間：";
        //Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.DataUtility du = new Lib.DataUtility();
        DataTable dt = new DataTable();
        dt = du.getDataTableByText(" select GETDATE()");
        if (dt.Rows.Count > 0)
        {
            Label1.Text = "DB時間：" + dt.Rows[0][0].ToString();
        }
        else
        {
            Label1.Text = "查詢DB時間失敗";
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Label2.Text = "WEB時間：";
        Label2.Text = "WEB時間：" + DateTime.Now.ToString();
    }
}