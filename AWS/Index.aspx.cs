using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Index : System.Web.UI.Page
{
    private bool isNeedAlert = false;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            SqlDataSource1.SelectParameters["date"].DefaultValue = System.DateTime.Today.ToShortDateString();
            if (Session["account"] != null)
            {
                Lib.Account acc = Session["account"] as Lib.Account;
                if (acc.OptionCode != null)
                {
                    foreach (KeyValuePair<string, string> pair in acc.OptionCode)
                    {
                        if (pair.Key == "意見管理")
                        {
                            Lib.DataUtility du = new Lib.DataUtility();
                            DataTable dt = du.getDataTableByText("select answer, answer2, answer3 from suggestion where acc = @acc", "acc", acc.Unit_Code);
                            if (dt.Rows.Count != 0)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    if (acc.Unit_Code == "00001")
                                    {
                                        if (row["answer3"].ToString() == "")
                                        {
                                            isNeedAlert = true;
                                        }
                                    }
                                    if (acc.Unit_Code == "10007" || acc.Unit_Code == "07001" || acc.Unit_Code == "91A00" || acc.Unit_Code == "60002" || acc.Unit_Code == "81A00" || acc.Unit_Code == "40001")
                                    {
                                        if (row["answer2"].ToString() == "")
                                        {
                                            isNeedAlert = true;
                                        }
                                    }
                                    if (acc.Unit_Code == "19204" || acc.Unit_Code == "19901" || acc.Unit_Code == "93A06"
    || acc.Unit_Code == "33I01" || acc.Unit_Code == "18600" || acc.Unit_Code == "19401" || acc.Unit_Code == "75096" || acc.Unit_Code == "175J5")
                                    {
                                        if (row["answer"].ToString() == "")
                                        {
                                            isNeedAlert = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if (isNeedAlert)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('您有意見待回覆!!!');", true);
                }
            }

        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[1].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[1].Text);
            e.Row.Cells[2].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[2].Text);
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[1].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[1].Text);
            e.Row.Cells[2].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[2].Text);
        }
    }
    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
        TabContainer1.ActiveTabIndex = 0;
    }
    protected void GridView2_PageIndexChanged(object sender, EventArgs e)
    {
        TabContainer1.ActiveTabIndex = 1;
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
    //protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    SqlDataSource1.SelectParameters["date"].DefaultValue = System.DateTime.Today.ToShortDateString();
    //    SqlDataSource1.SelectParameters["unit_name"].DefaultValue = DropDownList1.SelectedValue.ToString();
    //    GridView1.DataBind();
    //    this.Total.InnerText = " (" + GridView1.Rows.Count.ToString() + ")";
    //}
    //protected void DropDownList1_PreRender(object sender, EventArgs e)
    //{
    //    SqlDataSource1.SelectParameters["date"].DefaultValue = System.DateTime.Today.ToShortDateString();
    //    SqlDataSource1.SelectParameters["unit_name"].DefaultValue = DropDownList1.SelectedValue.ToString();
    //    this.Total.InnerText = " (" + GridView1.Rows.Count.ToString() + ")";
    //}
   
}
