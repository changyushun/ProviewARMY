using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class HQ_LogView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string TimeStart = TB_TimeStart.Text;
        string TimeEnd = TB_TimeEnd.Text;
        //if (!string.IsNullOrEmpty(TB_KeyWord.Text.Trim()))
        //    SqlDataSourceLog.SelectParameters["KeyWord"].DefaultValue = TB_KeyWord.Text.Trim();
        //else
        //    SqlDataSourceLog.SelectParameters["KeyWord"].DefaultValue = string.Empty;

        //SqlDataSourceLog.SelectParameters["TimeStart"].DefaultValue = String.Format("{0:yyyy/MM/dd}", Lib.SysSetting.ToWorldDate(TimeStart));
        //SqlDataSourceLog.SelectParameters["TimeEnd"].DefaultValue = String.Format("{0:yyyy/MM/dd}", Lib.SysSetting.ToWorldDate(TimeEnd));
        if (!string.IsNullOrEmpty(TimeStart) && !string.IsNullOrEmpty(TimeEnd))
        {
            try
            {
                Dictionary<string, object> d = new Dictionary<string, object>();
                Lib.DataUtility du = new Lib.DataUtility();
                d.Add("type", DropDownList1.Text);
                if (!string.IsNullOrEmpty(TB_KeyWord.Text.Trim()))
                    d.Add("KeyWord", TB_KeyWord.Text.Trim());
                else
                    d.Add("KeyWord", DBNull.Value);
                d.Add("TimeStart", Lib.SysSetting.ToWorldDate(TimeStart));
                d.Add("TimeEnd", Lib.SysSetting.ToWorldDate(TimeEnd));
                DataTable dt = du.getDataTableBysp(@"Ex104_QuerySysLog", d);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('請輸入起始與結束日期');", true);
        }

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[2].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[2].Text);
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
