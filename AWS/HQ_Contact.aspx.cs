using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
using System.Drawing;

public partial class HQ_Contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            if (!Page.IsPostBack)
            {
                Account a = (Account)Session["account"];
                if (a.Role == ((int)SysSetting.Role.admin_hq).ToString())
                {
                    Lib.DataUtility du = new Lib.DataUtility();
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    DataTable dt = new DataTable();
                    dt = du.getDataTableByText("select info from Contact");
                    if (dt.Rows.Count == 1)  //表示登入者的身分為鑑測站資訊管理者
                    {
                        information.Text = dt.Rows[0]["info"].ToString();
                    }
                    else
                    {

                    }
                }
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
                Account a = (Account)Session["account"];
                if (a.Role == ((int)SysSetting.Role.admin_hq).ToString())
                {
                    try
                    {
                        Lib.DataUtility du = new Lib.DataUtility();
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("info", information.Text);
                        du.executeNonQueryByText("update Contact SET info = @info", d);
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('成功更新聯絡資訊');", true);
                    }
                    catch (Exception ex)
                    {
                        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                    }
                }
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
