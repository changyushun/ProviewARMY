using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Configuration;

public partial class _108_Data_Update : System.Web.UI.Page
{
    public string _date;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            TabContainer1.ActiveTabIndex = 0;
        }
        else
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
    protected void search1_Click(object sender, EventArgs e)
    {   
        //查詢個人基本資料
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("value", player_id.Text.Trim());
        d.Add("type", "id");
        DataTable dt = du.getDataTableBysp("Ex108_GetPlayerData", d);

        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
            GridView1.DataBind();

        if (dt.Rows.Count == 0)
            this.playeridnone.Style.Value = "";
        else
            this.playeridnone.Style.Value = "display:none";

        TabContainer1.ActiveTabIndex = 0;


    }

    protected void search2_Click(object sender, EventArgs e)
    {   
        //查詢個人成績資料
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("id", result_id.Text.Trim());
        DataTable dt = du.getDataTableBysp("Ex108_GetResultData", d);

        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
            GridView2.DataBind();
        }
        else
            GridView2.DataBind();

        if (dt.Rows.Count == 0)
            this.resultidnone.Style.Value = "";
        else
            this.resultidnone.Style.Value = "display:none";

        TabContainer1.ActiveTabIndex = 1;
    }

    
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }



}