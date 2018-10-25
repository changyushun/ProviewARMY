using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddSuggestion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Lib.Player player = (Lib.Player)Session["player"];
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        if (TextBox1.Text != "")
        {
            d.Add("head", TextBox1.Text.Trim());
            d.Add("text", FTB.Text);
            d.Add("player", player.ID);
            d.Add("date", DateTime.Now);
            d.Add("acc", Request.Params["account"]);
            try
            {
                du.executeNonQueryByText("insert into suggestion (head,text,player,date,acc) values (@head,@text,@player,@date,@acc)", d);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('新增成功');window.close();", true);
            }
            catch (Exception ex)
            {
                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, sender.ToString());
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + ex.Message + "');", true);
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('請輸入標題');", true);
        }

    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
