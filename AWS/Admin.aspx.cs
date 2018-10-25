using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HiddenField1.Value = "hello";
        if (Session["admin"] == null && (string)Session["admin"] != "true")
        {
            Response.Redirect("~/AdminLogin.aspx");
        }
        else
        {
            exMsg.Text = "";
            if (!Page.IsPostBack)
            {
            timeunit.Text = Lib.SysSetting.reserveTimeUnit.TotalHours.ToString();
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            GridView1.DataSource = new Lib.DataUtility().getDataTableByText(TextBox1.Text.Trim());
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            exMsg.Text = ex.Message;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            new Lib.DataUtility().executeNonQueryByText(TextBox2.Text.Trim());
            Label1.Text = "update done!!!";
        }
        catch (Exception ex)
        {
            Label1.Text = ex.Message;
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Lib.SysSetting.setReserveTimeUnit(Convert.ToInt32(timeunit.Text.Trim()));

    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        GridView1.DataSource = new Lib.DataUtility().getDataTableByText("select * from INFORMATION_SCHEMA.COLUMNS where table_name = '" + TextBox1.Text.Trim() + "'");
        GridView1.DataBind();
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        Microsoft.VisualBasic.Devices.ComputerInfo info = new Microsoft.VisualBasic.Devices.ComputerInfo();
        Response.Write("AvailablePhysicalMemory : " + info.AvailablePhysicalMemory.ToString() + "<br />");
        Response.Write("AvailableVirtualMemory : " + info.AvailableVirtualMemory.ToString() + "<br />");
        Response.Write("TotalPhysicalMemory : " + info.TotalPhysicalMemory.ToString() + "<br />");
        Response.Write("TotalVirtualMemory : " + info.TotalVirtualMemory.ToString());
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        Dictionary<string,object> list = new Dictionary<string,object>();
        GridView1.DataSource = new Lib.DataUtility().getDataTableBysp("sp_who2", list);
        GridView1.DataBind();
    }
    protected void Button7_Click(object sender, EventArgs e)
    {
        HiddenField1.Value = "hello";
    }
    protected void Button7_Click1(object sender, EventArgs e)
    {
        GridView2.DataSourceID = SqlDataSource1.ID;
        GridView2.DataBind();
    }
}
