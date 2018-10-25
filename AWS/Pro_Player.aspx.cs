using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pro_Player : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Lib.Player p;
        if (Session["player"] != null)
        {
            if (!Page.IsPostBack)
            {
                p = new Lib.Player();
                p = (Lib.Player)Session["player"];
                acc_u.Value = p.ID.Trim();
                name_u.Value = p.Name.Trim();
                pwd_u.Value = Lib.SysSetting.ToRocDateFormat(p.Birth.ToShortDateString()).Trim();
                unit_u.Value = p.Unit_Code.Trim();
                rank_u.Value = p.Rank_Code.Trim();
                mail_u.Value = p.Mail.Trim();
                pwd_HF.Value = p.Password.Trim();
            }
            else
            {
                //string tt = submitType.Value;
                if (submitType.Value == "updateBtn")
                {
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    Lib.DataUtility du = new Lib.DataUtility();
                    d.Add("id", acc_u.Value);
                    d.Add("name", name_u.Value);
                    d.Add("unit_code", unit_u.Value);
                    d.Add("rank_code", rank_u.Value);
                    d.Add("mail", mail_u.Value);
                    du.executeNonQueryByText("update player set name = @name , unit_code = @unit_code , rank_code = @rank_code , mail = @mail where id = @id", d);
                    p = new Lib.Player();
                    p = (Lib.Player)Session["player"];
                    p.Name = name_u.Value;
                    p.Unit_Code = unit_u.Value;
                    p.Rank_Code = rank_u.Value;
                    p.Mail = mail_u.Value;
                    Session["player"] = p;
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('更新成功');", true);
                }
                else if (submitType.Value == "pwdchange")
                {
                    p = new Lib.Player();
                    p = (Lib.Player)Session["player"];
                    Lib.DataUtility du = new Lib.DataUtility();
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    var newPwd = pwd_HF.Value;
                    d.Add(@"id", p.ID);
                    d.Add(@"password", newPwd);
                    du.executeNonQueryBysp(@"Ex105_UpdatePassword", d);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('更新成功');", true);
                    /* Reset Player Session
                    cc.Password = newPwd;
                    pwd_u.Value = newPwd;
                    Session["account"] = acc; */
                    TabContainer1.ActiveTabIndex = 1;
                    submitType.Value = "";
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
