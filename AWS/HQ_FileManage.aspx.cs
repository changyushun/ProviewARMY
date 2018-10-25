using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Drawing;
using System.IO;

public partial class HQ_FileManage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void update_Click(object sender, EventArgs e)
    {
        try
        {
            Account a = (Account)Session["account"];
            if (a.Role == ((int)SysSetting.Role.admin_hq).ToString())
            {
                int index = GridView1.EditIndex;
                GridViewRow row = GridView1.Rows[index];
                TextBox _filename = (TextBox)row.FindControl("name");
                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("sid", row.Cells[1].Text);
                d.Add("filename", _filename.Text);
                d.Add("uploaddate", System.DateTime.Now);
                du.executeNonQueryByText("update FileManage set filename = @filename, uploaddate = @uploaddate where sid = @sid", d);
                GridView1.DataBind();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('已更新標題名稱');", true);
            }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            Response.Redirect("index.aspx");
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {  
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[4].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[4].Text);
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
