using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
public partial class SuggestionView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sid = Request.QueryString["head"];
        Lib.Player p = (Lib.Player)Session["player"];
        SqlDataSource1.SelectParameters["sid"].DefaultValue = sid;
        SqlDataSource1.SelectParameters["player"].DefaultValue = p.ID;
        //FormView1.FindControl("answerLabel").t
        Label datelabel = (Label)FormView1.FindControl("dateLabel");
        Label date_answerLabel = (Label)FormView1.FindControl("date_answerLabel");
        datelabel.Text = Lib.SysSetting.ToRocDateFormat(datelabel.Text);
        date_answerLabel.Text = Lib.SysSetting.ToRocDateFormat(date_answerLabel.Text);
        Label answer1 = (Label)FormView1.FindControl("answerLabel");
        Label answer2 = (Label)FormView1.FindControl("answer2Label");
        Label answer3 = (Label)FormView1.FindControl("answer3Label");
        Label date_answer = (Label)FormView1.FindControl("date_answerLabel");
        if (answer1.Text.Trim() == "")
        {
            FormView1.FindControl("Label1").Visible = false;
        }
        if (answer2.Text.Trim() == "")
        {
            FormView1.FindControl("Label2").Visible = false;
        }
        if (answer3.Text.Trim() == "")
        {
            FormView1.FindControl("Label3").Visible = false;
        }
        if (date_answer.Text.Trim() == "")
        {
            FormView1.FindControl("Label4").Visible = false;
        }
    }
    protected void FormView1_DataBound(object sender, EventArgs e)
    {
            
    }
    protected void FormView1_PreRender(object sender, EventArgs e)
    {
        
    }
    protected void FormView1_Load(object sender, EventArgs e)
    {
        
    }
    protected void FormView1_ItemCreated(object sender, EventArgs e)
    {
        
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
