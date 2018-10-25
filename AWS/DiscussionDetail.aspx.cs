using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DiscussionDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            if (!Page.IsPostBack)
            {
                FTB_Text.Visible = false;
                confirm.Visible = false;
            }
        }

        //if (Session["player"] != null)
        //{ 
            
        //}

        //if (Request.Params["type"] == "view")
        //{
        //    FTB_Text.Visible = false;
        //    confirm.Visible = false;
        //}
    }
    protected void confirm_Click(object sender, EventArgs e)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("head_sid", Request.QueryString["sid"].ToString());
        d.Add("text", FTB_Text.Text);
        d.Add("player", ((Lib.Player)Session["player"]).ID);
        d.Add("date", DateTime.Now);
        Lib.DataUtility du = new Lib.DataUtility();
        try
        {
            du.executeNonQueryByText("insert into discussiondetail values (@head_sid,@text,@player,@date)", d);
            d.Clear();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('回覆成功');history.go(-2);", true);
            DataList1.DataBind();
            //Response.Redirect("index.aspx");
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + ex.Message + "');", true);
        }
        //Response.Redirect("index.aspx");
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
