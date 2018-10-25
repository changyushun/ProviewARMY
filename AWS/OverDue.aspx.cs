using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class OverDue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnfindCenter_Click(object sender, EventArgs e)
    {
        string center_code = DropDownList1.SelectedValue;
        
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> list = new Dictionary<string, object>();
        list.Add("unit", 5);
        list.Add("center_code", center_code);
        DataTable dt = du.getDataTableBysp("Ex102_GetOverDueByCenter", list);
        if (dt.Rows.Count > 0)
        {
            HiddenField1.Value = center_code;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            HiddenField1.Value = null;
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }
    protected void btnfindbyID_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtID.Text))
        {
            string id = txtID.Text.Trim().ToUpper();
            Dictionary<string, object> list = new Dictionary<string, object>();
            list.Add("unit", 5);
            list.Add("id", id);
            Lib.DataUtility du = new Lib.DataUtility();
            DataTable dt = du.getDataTableBysp("Ex102_GetOverDueByID", list);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
        string sid = row.Cells[0].Text;
        Dictionary<String, object> list = new Dictionary<string, object>();
        list.Add("unit", 5);
        list.Add("sid", Convert.ToInt32(sid));
        Lib.DataUtility du = new Lib.DataUtility();
        du.executeNonQueryBysp("Ex102_DeleteOverDueBySID", list);
        GridView1.Rows[row.RowIndex].Visible = false;
        //GridView1.DataBind();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (HiddenField1.Value != null)
        {
            Dictionary<String, object> list = new Dictionary<string, object>();
            list.Add("unit", 5);
            list.Add("center_code", Convert.ToInt32(HiddenField1.Value));
            Lib.DataUtility du = new Lib.DataUtility();
            du.executeNonQueryBysp("Ex102_DeleteOverDueByCenter", list);
            GridView1.DataSource = null;
            GridView1.DataBind();

        }
    }
    
    protected void btn_SearchId_Click(object sender, EventArgs e)
    {
        lab_InqResult.Text = "";
        GridView2.DataSource = null;
        string id = txb_Id.Text;
        Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.DataUtility du = new Lib.DataUtility();

        d.Add("id", id);

        DataTable dt = du.getDataTableBysp("Ex108_GetNear60DayResult", d);
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
        }
        else
            lab_InqResult.Text = "查無資料";

        GridView2.DataBind();
        TabContainer1.ActiveTabIndex = 1;
    }
    protected void btn_DelReTest_Click(object sender, EventArgs e)
    {
        GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
        string sid = row.Cells[0].Text;
        string id = row.Cells[2].Text;
        Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.DataUtility du = new Lib.DataUtility();
        d.Add("id", id);
        du.executeNonQueryByText("delete Result where sid='" + sid + "'");

        DataTable dt = du.getDataTableBysp("Ex108_GetNear60DayResult", d);
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
        }
        else
            lab_InqResult.Text = "查無資料";

        GridView2.DataBind();
        TabContainer1.ActiveTabIndex = 1;
    }
}
