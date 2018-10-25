using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class AccEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.Params["sid"] != null)
            {
                Lib.DataUtility du = new Lib.DataUtility();
                DataTable dt = du.getDataTableByText("select * from account where sid = @sid", "sid", Request.Params["sid"]);
                if (dt.Rows.Count == 1)
                {
                    acc.Text = dt.Rows[0]["account"].ToString();
                    pwd.Text = dt.Rows[0]["password"].ToString();
                    name.Text = dt.Rows[0]["name"].ToString();
                    id.Text = dt.Rows[0]["id"].ToString();
                    unit_code.Text = dt.Rows[0]["unit_code"].ToString();
                    rank_code.Text = dt.Rows[0]["rank_code"].ToString();
                    tel.Text = dt.Rows[0]["tel"].ToString();
                    cell.Text = dt.Rows[0]["cellphone"].ToString();
                    email.Text = dt.Rows[0]["mail"].ToString();
                    ip.Text = dt.Rows[0]["ip"].ToString();
                    DataTable options = du.getDataTableByText("select * from optioncode where accname = @acc", "acc", dt.Rows[0]["account"].ToString());
                    if (options.Rows.Count != 0)
                    {
                        foreach (DataRow row in options.Rows)
                        {
                            foreach (ListItem item in CheckBoxList1.Items)
                            {
                                if (row["optioncode"].ToString() == item.Value)
                                {
                                    item.Selected = true;
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            if (acc.Text.Trim() != "" && pwd.Text.Trim() != "" && name.Text.Trim() != "" && id.Text.Trim() != "" &&
                unit_code.Text.Trim() != "" && rank_code.Text.Trim() != "" && tel.Text.Trim() != "" &&
                cell.Text.Trim() != "" && ip.Text.Trim() != "")
            {
                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string, object> d = new Dictionary<string, object>();
                d.Add("updater", ((Lib.Account)Session["account"]).AccountName);
                d.Add("account", acc.Text.Trim());
                d.Add("password", pwd.Text.Trim());
                d.Add("name", name.Text.Trim());
                d.Add("id", id.Text.Trim());
                d.Add("unit_code", unit_code.Text.Trim());
                d.Add("rank_code", rank_code.Text.Trim());
                d.Add("tel", tel.Text.Trim());
                d.Add("cellphone", cell.Text.Trim());
                d.Add("mail", email.Text.Trim());
                d.Add("ip", ip.Text.Trim());
                du.executeNonQueryByText("update account set password = @password, name = @name, id = @id, unit_code = @unit_code, rank_code = @rank_code, tel = @tel, cellphone = @cellphone, mail = @mail, ip = @ip where account = @account", d);
                //d.Clear();

                Dictionary<string, object> d_option = new Dictionary<string, object>();
                d_option.Add("accName", acc.Text.Trim());

                foreach (ListItem items in CheckBoxList1.Items)
                {
                    if (items.Selected == true)
                    {
                        d_option.Add("option" + items.Value, "true");
                    }
                    else
                    {
                        d_option.Add("option" + items.Value, "false");
                    }
                }
                du.executeNonQueryBysp("updateoptions", d_option);
                Lib.SysSetting.AddLog("帳號管理",((Lib.Account)Session["account"]).AccountName, acc.Text.Trim() + " 帳號資料被更改", DateTime.Now);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('更新成功!!!');window.close();", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('資料有缺漏!!!');", true);
            }
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            if (acc.Text.Trim() != "")
            {
                Dictionary<string, object> d = new Dictionary<string, object>();
                Lib.DataUtility du = new Lib.DataUtility();
                d.Add("account", acc.Text.Trim());
                du.executeNonQueryBysp("DelAccount", d);
                Lib.SysSetting.AddLog("帳號管理", ((Lib.Account)Session["account"]).AccountName, acc.Text.Trim() + " 帳號被刪除", DateTime.Now);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('帳號已刪除!!!');window.close();", true);
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
