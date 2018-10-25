using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class CenterBalance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (date.Text != "")
            {
                Dictionary<string, object> d = new Dictionary<string, object>();
                Lib.DataUtility du = new Lib.DataUtility();
                d.Add("date_s",Lib.SysSetting.ToWorldDate(date.Text));
                d.Add("date_e",Lib.SysSetting.ToWorldDate(date.Text));
                DataTable dt = du.getDataTableBysp("CenterMonitor", d);
                GridView1.DataSource = dt;
                GridView1.DataBind();
                //SqlDataSource1.SelectParameters["date_s"].DefaultValue = Lib.SysSetting.ToWorldDate(date.Text).ToShortDateString();
               //SqlDataSource1.SelectParameters["date_e"].DefaultValue = Lib.SysSetting.ToWorldDate(date.Text).ToShortDateString();
            }
        }
        catch (Exception ex) 
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('日期格式不正確 , 請重新檢查');", true);
        }
    }
}
