using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditSuggestion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            if (!Page.IsPostBack)
            {
                Lib.Account a = (Lib.Account)Session["account"];
                if (a.Role == ((int)Lib.SysSetting.Role.user_hg).ToString())
                {
                    foreach (KeyValuePair<string, string> item in a.OptionCode)
                    {
                        if (item.Key == "意見管理")
                        {
                            string _sid = Request.QueryString["sid"];
                            Lib.DataUtility du = new Lib.DataUtility();
                            DataTable dt = du.getDataTableByText("select acc, head, text, answer , answer2 , answer3, status from suggestion where sid = @sid", "sid", _sid);
                            lbhead.Text = dt.Rows[0]["head"].ToString();
                            string _acc = dt.Rows[0]["acc"].ToString();
                            FTB_Text.Text = dt.Rows[0]["text"].ToString();
                            FTB_Answer.Text = dt.Rows[0]["answer"].ToString();
                            FTB_Answer_2.Text = dt.Rows[0]["answer2"].ToString();
                            FTB_Answer_3.Text = dt.Rows[0]["answer3"].ToString();
                            if (dt.Rows[0]["status"].ToString() == "1")
                            {
                                status.Items[0].Selected = true;
                            }
                            if (dt.Rows[0]["status"].ToString() == "0")
                            {
                                status.Items[1].Selected = true;
                            }

                            if (a.Unit_Code == "00001")
                            {
                                FTB_Answer.ReadOnly = true;
                                FTB_Answer_2.ReadOnly = true;
                                FTB_Answer_3.ReadOnly = false;
                            }
                            else if (a.Unit_Code == "10007" || a.Unit_Code == "07001" || a.Unit_Code == "91A00" || a.Unit_Code == "60002" || a.Unit_Code == "81A00" || a.Unit_Code == "40001")
                            {
 
                                FTB_Answer.ReadOnly = true;
                                FTB_Answer_2.ReadOnly = false;
                                FTB_Answer_3.ReadOnly = true;        
                            }
                            else if (a.Unit_Code == "19204" || a.Unit_Code == "19901" || a.Unit_Code == "93A06" || a.Unit_Code == "33I01" || a.Unit_Code == "18600" || a.Unit_Code == "19401" || a.Unit_Code == "75096" || a.Unit_Code == "175J5")
                            {
                                FTB_Answer.ReadOnly = false;
                                FTB_Answer_2.ReadOnly = true;
                                FTB_Answer_3.ReadOnly = true;      
                            }

                            if (_acc == "00001")
                            {
                                FTB_Answer.Visible = false;
                                FTB_Answer_2.Visible = false;
                                FTB_Answer_3.Visible = true;
                                Label1.Visible = false;
                                Label2.Visible = false;
                                Label3.Visible = true;
                            }
                            else if (_acc == "10007" || _acc == "07001" || _acc == "91A00" || _acc == "60002" || _acc == "81A00" || _acc == "40001")
                            {
                                FTB_Answer.Visible = false;
                                FTB_Answer_2.Visible = true;
                                FTB_Answer_3.Visible = true;
                                Label1.Visible = false;
                                Label2.Visible = true;
                                Label3.Visible = true;
                            }
                            else if (_acc == "19204" || _acc == "19901" || _acc == "93A06" || _acc == "33I01" || _acc == "18600" || _acc == "19401" || _acc == "75096" || _acc == "175J5")
                            {
                                FTB_Answer.Visible = true;
                                FTB_Answer_2.Visible = true;
                                FTB_Answer_3.Visible = true;
                                Label1.Visible = true;
                                Label2.Visible = true;
                                Label3.Visible = true;
                            }
                        }
                    }
                }
                
            }
        }
    }
    protected void confirm_Click(object sender, EventArgs e)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.Account a = (Lib.Account)Session["account"];
        FTB_Answer.ReadOnly = false;
        FTB_Answer_2.ReadOnly = false;
        FTB_Answer_3.ReadOnly = false;
        d.Add("answer", FTB_Answer.Text);
        d.Add("answer2", FTB_Answer_2.Text);
        d.Add("answer3", FTB_Answer_3.Text);
        //d.Add("acc", ((Lib.Account)Session["account"]).AccountName);
        d.Add("date_answer", DateTime.Now);
        //d.Add("status", status.SelectedValue);
        d.Add("sid", Request.QueryString["sid"]);
        Lib.DataUtility du = new Lib.DataUtility();
        try
        {
            if (a.Unit_Code == "00001")
            {
                du.executeNonQueryByText("update suggestion set answer3 = @answer3 , date_answer = @date_answer where sid = @sid", d);
            }
            else if (a.Unit_Code == "10007" || a.Unit_Code == "07001" || a.Unit_Code == "91A00" || a.Unit_Code == "60002" || a.Unit_Code == "81A00" || a.Unit_Code == "40001")
            {

                du.executeNonQueryByText("update suggestion set answer2 = @answer2, date_answer = @date_answer where sid = @sid", d);
            }
            else if (a.Unit_Code == "19204" || a.Unit_Code == "19901" || a.Unit_Code == "93A06" || a.Unit_Code == "33I01" || a.Unit_Code == "18600" || a.Unit_Code == "19401" || a.Unit_Code == "75096" || a.Unit_Code == "175J5")
            {
                du.executeNonQueryByText("update suggestion set answer = @answer, date_answer = @date_answer where sid = @sid", d);
            }
            //du.executeNonQueryByText("update suggestion set answer = @answer, answer2 = @answer2 , answer3 = @answer3 , date_answer = @date_answer where sid = @sid", d);
            d.Clear();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('回覆成功!');window.location='HQ_Suggestion.aspx';", true);
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + ex.Message +"')", true);
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
