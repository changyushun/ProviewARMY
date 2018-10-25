using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AddDiscussion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void confirm_Click(object sender, EventArgs e)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("head", head.Text.Trim());
        d.Add("date", DateTime.Now);
        Lib.DataUtility du = new Lib.DataUtility();
        try
        {
            du.executeNonQueryByText("insert into discussion (head,date) values (@head,@date)", d);
            d.Clear();
            DataTable dt = du.getDataTableByText("select sid from discussion where head = @head", "head", head.Text.Trim());
            string _head_id = dt.Rows[0]["sid"].ToString();
            d.Add("head_sid", _head_id);
            d.Add("text", FTB_text.Text);
            d.Add("player", ((Lib.Player)(Session["player"])).ID);
            d.Add("date", DateTime.Now);
            du.executeNonQueryByText("insert into discussiondetail values (@head_sid,@text,@player,@date)", d);
            d.Clear();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('新增成功');", true);
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
