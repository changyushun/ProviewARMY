using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;

public partial class IPRenew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("apply", ((Lib.Account)Session["account"]).AccountName);
            DataTable dt = du.getDataTableByText("select ip_new from ip_renew where apply=@apply and status = '0'", d);
            if (dt.Rows.Count == 0)
            {

                oldip.Value = ((Lib.Account)Session["account"]).IP;
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('案件審查中');window.close();", true);
            }
            d.Clear();
            dt.Dispose();
        }
    }
    protected void confirm_Click(object sender, EventArgs e)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("apply", ((Lib.Account)Session["account"]).AccountName);
        d.Add("ip_new", newip.Value.Trim());
        d.Add("date", DateTime.Now);
        try
        {
            du.executeNonQueryBysp("updateip", d);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('申請成功，請等候審查');window.close();", true);
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + ex.Message + "');", true);
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
