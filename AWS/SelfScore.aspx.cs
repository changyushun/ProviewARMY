using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SelfScore : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Lib.Player p = new Lib.Player();
            p = (Lib.Player)Session["player"];
            string id = p.ID;
            SqlDataSource1.SelectParameters["id"].DefaultValue = id;
            Label2.Text = id;
            if (GridView2.Rows.Count > 0)
            {

            }
            else
            {
                //sit_ups_pic.Visible = false;
                //push_ups_pic.Visible = false;
                //run_pic.Visible = false;
            }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        }
    }

    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        try
        {
            Lib.Player p = new Lib.Player();
            p = (Lib.Player)Session["player"];
            string id = p.ID;
            for (int i = 0; i < DropDownList1.Items.Count; i++)
            {
                //DropDownList1.Items[i].Text = Lib.SysSetting.ToRocDateFormat(Convert.ToDateTime(DropDownList1.Items[i].Text).ToShortDateString());
                DropDownList1.Items[i].Text = Lib.SysSetting.ToRocDateFormat(DropDownList1.Items[i].Text);
            }
            if (DropDownList1.Items.Count > 0)
            {
                SqlDataSource2.SelectParameters["type"].DefaultValue = "id";
                SqlDataSource2.SelectParameters["value"].DefaultValue = DropDownList1.SelectedValue;
                SqlDataSource2.SelectParameters["operator"].DefaultValue = id;
            }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Lib.Player p = new Lib.Player();
            p = (Lib.Player)Session["player"];
            string id = p.ID;
            SqlDataSource2.SelectParameters["type"].DefaultValue = "id";
            SqlDataSource2.SelectParameters["value"].DefaultValue = DropDownList1.SelectedValue;
            SqlDataSource2.SelectParameters["operator"].DefaultValue = id;
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }

    protected void GridView2_DataBound(object sender, EventArgs e)
    {
        if (GridView2.Rows.Count == 0)
        {
            this.noresult.Style.Value = "";
            this.haveresult.Style.Value = "display:none";
        }
        else
        {
            this.noresult.Style.Value = "display:none";
            this.haveresult.Style.Value = "";
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
