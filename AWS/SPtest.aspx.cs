using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Lib;


public partial class SPtest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string c = ((int)SysSetting.Role.admin_center).ToString();

        //DataUtility du = new DataUtility();
        //List<Dictionary<string, object>> collection = new List<Dictionary<string, object>>();
        //for (int i = 0; i < 3; i++)
        //{
        //    Dictionary<string, object> list = new Dictionary<string, object>();
        //    list.Add("account", "sam");
        //    list.Add("password", "1q2w3e4r%");
        //    list.Add("role_code", i.ToString());
        //    list.Add("name", "sam" + i.ToString());
        //    list.Add("id", "N123287561");
        //    list.Add("unit_code", "1");
        //    list.Add("rank_code", "42");
        //    list.Add("tel", "0277287799");
        //    list.Add("cellphone", "0916250310");
        //    list.Add("mail", "sam@123.com");
        //    list.Add("ip", "192.168.0.100");
        //    list.Add("pwdChange", "0");
        //    list.Add("status", "0");
        //    collection.Add(list);
            
        //}
        //try
        //{
        //    du.executeNonQueryBysp("addaccount", collection);
        //}
        //catch (Exception ex)
        //{ 
        
        //}
        //Dictionary<string, object> list = new Dictionary<string, object>();
        //list.Add("type", "id");
        //list.Add("value", "N123287561");
        //DataTable dt = du.getDataTableBysp("getaccount", list);
        //GridView1.DataSource = dt;
        //GridView1.DataBind();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
}
