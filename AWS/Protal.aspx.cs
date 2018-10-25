using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Lib;
using System.Collections.Generic;

public partial class Protal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.DataUtility du = new Lib.DataUtility();
        //SqlDataSource1.SelectParameters["date"].DefaultValue = System.DateTime.Today.ToShortDateString();
        try
        {
            d.Clear();
            //d.Add("date", System.DateTime.Today.ToShortDateString());
            //DataTable dt_Bulletin = du.getDataTableByText(@"select b.head, b.start,b.sid,b.deadline,(select unit_title from unit u where u.unit_code = a.unit_code) as unit_title from Account a ,Bulletin b where b.acc = a.account and b.deadline >= @date order by b.deadline DESC ", d);
            //GridView1.DataSource = dt_Bulletin;
            //GridView1.DataBind();
            

            d.Clear();
            d.Add("start", DateTime.Today);
            //2016-5-4家銘原版
            //System.Data.DataTable dt = du.getDataTableByText("select top(1) b.sid, b.shorttext, b.head , u.unit_title from bulletin b, Account a, Unit u where b.acc = a.account and a.unit_code = u.unit_code order by insertDate  desc", d);
            //2015-5-4修訂版，公告最上面消息只顯示國防部
            //System.Data.DataTable dt = du.getDataTableByText("select top(1) b.sid, b.shorttext, b.head , u.unit_title from bulletin b, Account a, Unit u where b.acc = a.account and a.unit_code = '00001' and deadline>=@start order by insertDate  desc", d);
            //System.Data.DataTable dt = du.getDataTableByText("select top(1) b.sid, b.shorttext, b.head , u.unit_title from bulletin b, Account a, Unit u where b.unit_name = '國防部' and deadline>=@start order by insertDate  desc", d);
            System.Data.DataTable dt = du.getDataTableByText("select top(1) b.sid, b.shorttext, b.head , u.unit_title,b.unit_name from bulletin b, Account a, Unit u where b.unit_name = '國防部' and deadline>=@start order by insertDate  desc", d);
            if (dt.Rows.Count == 1)
            {
                LB_head.Text = dt.Rows[0]["head"].ToString();
                LB_text.Text = dt.Rows[0]["shorttext"].ToString();
                LB_unit.Text = dt.Rows[0]["unit_name"].ToString();
                this.newid.Value = dt.Rows[0]["sid"].ToString();
            }
            else
            {
                LB_head.Text = "目前無公告內容";
                LB_text.Text = "目前無公告內容";
                LB_unit.Text = "國防部";
                this.newid.Value = null;
            }

            //this.Total.InnerText = " (" + GridView1.Rows.Count.ToString() + ")";
            //d.Clear();
            //d.Add("date", System.DateTime.Today.ToShortDateString());
            //dt = du.getDataTableByText(@"select count(b.sid) as total from Bulletin b where b.deadline > @date", d);
            //if (dt.Rows.Count == 1)
            //{
            //    this.Total.InnerText = " (" + dt.Rows[0]["total"].ToString() + ")";
            //}
        }
        catch (Exception ex)
        { 
        
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[1].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[1].Text);
            e.Row.Cells[2].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[2].Text);
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["date"].DefaultValue = System.DateTime.Today.ToShortDateString();
        SqlDataSource1.SelectParameters["unit_name"].DefaultValue = DropDownList1.SelectedValue.ToString();
        GridView1.DataBind();
        this.Total.InnerText = " (" + GridView1.Rows.Count.ToString() + ")";

    }
    protected void DropDownList1_PreRender(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["date"].DefaultValue = System.DateTime.Today.ToShortDateString();
        SqlDataSource1.SelectParameters["unit_name"].DefaultValue = DropDownList1.SelectedValue.ToString();
        this.Total.InnerText = " (" + GridView1.Rows.Count.ToString() + ")";
    }
}
