using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BulletinView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["sid"] != null)
            {
                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string,object> d = new Dictionary<string,object>();
                d.Add("sid",Request.QueryString["sid"]);
                System.Data.DataTable dt = du.getDataTableByText("select text, head from bulletin where sid = @sid", d);
                //this.Header.Title = "最新消息 - " + (string)dt.Rows[0]["head"];
                if (dt.Rows.Count != 0)
                {
                    this.Header.Title = "最新消息 - " + (string)dt.Rows[0]["head"];
                    div.InnerHtml = (string)dt.Rows[0][0];
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
