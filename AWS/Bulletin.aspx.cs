using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Bulletin : System.Web.UI.Page
{
    public string center_code = string.Empty;//鑑測站代碼
    public string center_name = string.Empty;//發佈單位名稱
    protected void Page_Load(object sender, EventArgs e)
    {
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        DataTable dt=new DataTable();
        d.Add("account", ((Lib.Account)Session["account"]).AccountName);

        dt = du.getDataTableByText("select center_code from Account where account=@account",d);
        if (dt.Rows.Count > 0 & !string.IsNullOrEmpty(dt.Rows[0]["center_code"].ToString()))
        {
            center_code = dt.Rows[0]["center_code"].ToString();
            if (center_code == "000")//國防部
            {
                center_name = "國防部";
            }
            else if (center_code == "111")//國防部陸軍司令部部本部
            {
                center_name = "國防部陸軍司令部部本部";
            }
            else if (center_code == "444")//國防部海軍司令部部本部
            {
                center_name = "國防部海軍司令部部本部";
            }
            else if (center_code == "666")//國防部空軍司令部部本部
            {
                center_name = "國防部空軍司令部部本部";
            }
            else//取出鑑測站代碼再找出對應名稱
            {
                Lib.DataUtility du1 = new Lib.DataUtility();
                Dictionary<string, object> d1 = new Dictionary<string, object>();
                DataTable dt1 = new DataTable();
                d1.Add("center_code", center_code);
                dt1 = du1.getDataTableByText("select center_name from Center where center_code=@center_code",d1);
                if (dt1.Rows.Count > 0)
                {
                    center_name = dt1.Rows[0]["center_name"].ToString();
                }
            }

        }
        if (!string.IsNullOrEmpty(center_name))
        {
            Label1.Text = center_name;
        }
        else
        {
            Label1.Text = null;
        }
        
        
    }
    protected void confirm_Click(object sender, EventArgs e)
    {
        // to do
        if (Session["account"] != null)
        {

            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            string _start = (Convert.ToInt32(startDate.Value.Substring(0, 3)) + 1911).ToString() + "/" + startDate.Value.Substring(3, 2) + "/" + startDate.Value.Substring(5, 2);
            string _end = (Convert.ToInt32(endDate.Value.Substring(0, 3)) + 1911).ToString() + "/" + endDate.Value.Substring(3, 2) + "/" + endDate.Value.Substring(5, 2);
            //新增單位名稱2016-5-4
            d.Add("unit_name", center_name);

            d.Add("head", header.Text.Trim());
            d.Add("text", Ftb1.Text);
            d.Add("acc", ((Lib.Account)Session["account"]).AccountName);
            d.Add("insertDate", DateTime.Now);
            d.Add("start", Convert.ToDateTime(_start));
            d.Add("deadline", Convert.ToDateTime(_end));
            d.Add("shorttext", Ftb2.Text);
            du.executeNonQueryBysp("AddBulletin", d);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('最新消息新增成功');window.close();", true);
            Lib.SysSetting.AddLog("最新消息", ((Lib.Account)Session["account"]).AccountName, "新增最新消息:" + header.Text.Trim(), System.DateTime.Now);


        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('您閒置過時，請複製內容後重新登入進行');", true);
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }


}
