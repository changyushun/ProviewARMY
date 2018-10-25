using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeamScore : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Lib.Account a = new Lib.Account();
            a = (Lib.Account)Session["account"];
            string op_id = a.AccountName;
            SqlDataSource1.SelectParameters["op_id"].DefaultValue = op_id;
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
            Lib.Account a = new Lib.Account();
            a = (Lib.Account)Session["account"];
            string op_id = a.AccountName;
            for (int i = 0; i < DropDownList1.Items.Count; i++)
            {
                DropDownList1.Items[i].Text = Lib.SysSetting.ToRocDateFormat(DropDownList1.Items[i].Text);
                    //Lib.SysSetting.ToRocDateFormat(Convert.ToDateTime(DropDownList1.Items[i].Text).ToShortDateString());
            }
            if (DropDownList1.Items.Count > 0)
            {
                SqlDataSource2.SelectParameters["type"].DefaultValue = "op_id";
                SqlDataSource2.SelectParameters["value"].DefaultValue = DropDownList1.SelectedValue;
                SqlDataSource2.SelectParameters["operator"].DefaultValue = op_id;
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
            Lib.Account a = new Lib.Account();
            a = (Lib.Account)Session["account"];
            string op_id = a.AccountName;
            SqlDataSource2.SelectParameters["type"].DefaultValue = "op_id";
            SqlDataSource2.SelectParameters["value"].DefaultValue = DropDownList1.SelectedValue;
            SqlDataSource2.SelectParameters["operator"].DefaultValue = op_id;
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
