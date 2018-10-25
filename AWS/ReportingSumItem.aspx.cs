using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class ReportingSumItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 設定報表種類
        if (Request.QueryString["type"] != null)
        {
            type.Value = Request.QueryString["type"];
            if (type.Value == "rank")
            {
                Label1.Text = "級職";
                txtAge.Visible = false;
                ddlRank.Visible = true;
            }
            if (type.Value == "age")
            {
                Label1.Text = "年齡";
                txtAge.Visible = true;
                txtAge.Text = "25-35";
                ddlRank.Visible = false;
            }
            if (type.Value == "item")
            {
                Label1.Visible = false;
                txtAge.Visible = false;
                ddlRank.Visible = false;
            }
        }
        

        if (!Page.IsPostBack)
        {
            if (Session["account"] != null)
            {
                // 設定預設日期
                date_start.Value = (DateTime.Now.Year - 1911).ToString() + "/1/1";
                date_stop.Value = (DateTime.Now.Year - 1911).ToString() + "/12/31";
                
                

                //DropDownList2.Visible = false;
                Lib.Account acc = Session["account"] as Lib.Account;
                ListItem item = null;
                Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(acc.Unit_Code);

                ////2016-11-14選項先空白(先不改)
                //item = new ListItem();
                //item.Text = string.Empty;
                //item.Value = "00000";
                //DropDownList1.Items.Add(item);

                item = new ListItem();
                item.Text = unit.Unit_Title;
                item.Value = unit.Unit_Code;
                DropDownList1.Items.Add(item);
    
                if (unit.ChildUnit != null && unit.ChildUnit.Count != 0)
                {
                    
                    foreach (KeyValuePair<string, Lib.Unit> pair in unit.ChildUnit)
                    {
                        Lib.Unit child = pair.Value as Lib.Unit;
                        item = new ListItem();
                        item.Text = child.Unit_Title;
                        item.Value = child.Unit_Code;
                        DropDownList1.Items.Add(item);
                        
                    }
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        ////2016-11-14先判斷是不是有選取單位(先不改)
        //if (DropDownList1.SelectedValue!="00000")
        //{
            
        //}
        ListItem item = null;
        Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(DropDownList1.SelectedValue);
        DropDownList2.Items.Clear();
        DropDownList3.Items.Clear();
        DropDownList4.Items.Clear();
        DropDownList5.Items.Clear();
        if (unit.ChildUnit != null && unit.ChildUnit.Count != 0)
        {
            foreach (KeyValuePair<string, Lib.Unit> pair in unit.ChildUnit)
            {
                Lib.Unit child = pair.Value as Lib.Unit;
                item = new ListItem();
                item.Text = child.Unit_Title;
                item.Value = child.Unit_Code;
                DropDownList2.Items.Add(item);
            }
        }
    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListItem item = null;
        Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(DropDownList2.SelectedValue);
        DropDownList3.Items.Clear();
        DropDownList4.Items.Clear();
        DropDownList5.Items.Clear();
        if (unit.ChildUnit != null && unit.ChildUnit.Count != 0)
        {
            foreach (KeyValuePair<string, Lib.Unit> pair in unit.ChildUnit)
            {
                Lib.Unit child = pair.Value as Lib.Unit;
                item = new ListItem();
                item.Text = child.Unit_Title;
                item.Value = child.Unit_Code;
                DropDownList3.Items.Add(item);
            }
            if (unit.ChildUnit.Count == 1)
            {
                Lib.Unit onlyChild = new Lib.UnitTree().GetUnitWithChild(DropDownList3.Items[0].Value);
                if (onlyChild.ChildUnit != null && onlyChild.ChildUnit.Count != 0)
                {
                    foreach (KeyValuePair<string, Lib.Unit> pair in onlyChild.ChildUnit)
                    {
                        Lib.Unit child = pair.Value as Lib.Unit;
                        item = new ListItem();
                        item.Text = child.Unit_Title;
                        item.Value = child.Unit_Code;
                        DropDownList4.Items.Add(item);
                    }
                }
            }
        }
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListItem item = null;
        Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(DropDownList3.SelectedValue);
        DropDownList4.Items.Clear();
        DropDownList5.Items.Clear();
        if (unit.ChildUnit != null && unit.ChildUnit.Count != 0)
        {

            foreach (KeyValuePair<string, Lib.Unit> pair in unit.ChildUnit)
            {
                Lib.Unit child = pair.Value as Lib.Unit;
                item = new ListItem();
                item.Text = child.Unit_Title;
                item.Value = child.Unit_Code;
                DropDownList4.Items.Add(item);
            }
            if (unit.ChildUnit.Count == 1)
            {

                Lib.Unit onlyChild = new Lib.UnitTree().GetUnitWithChild(DropDownList4.Items[0].Value);
                if (onlyChild.ChildUnit != null && onlyChild.ChildUnit.Count != 0)
                {
                    foreach (KeyValuePair<string, Lib.Unit> pair in onlyChild.ChildUnit)
                    {
                        Lib.Unit child = pair.Value as Lib.Unit;
                        item = new ListItem();
                        item.Text = child.Unit_Title;
                        item.Value = child.Unit_Code;
                        DropDownList5.Items.Add(item);
                    }
                }
            }
        }
    }
    
    protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListItem item = null;
        Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(DropDownList4.SelectedValue);
        DropDownList5.Items.Clear();
        if (unit.ChildUnit != null && unit.ChildUnit.Count != 0)
        {

            foreach (KeyValuePair<string, Lib.Unit> pair in unit.ChildUnit)
            {
                Lib.Unit child = pair.Value as Lib.Unit;
                item = new ListItem();
                item.Text = child.Unit_Title;
                item.Value = child.Unit_Code;
                DropDownList5.Items.Add(item);
            }

        }
    }

    protected void DropDownList5_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("單位名稱");
        dt.Columns.Add("單位代碼");
        DataRow row = null;
        if (DropDownList5.Items.Count == 0)
        {
            if (DropDownList4.Items.Count == 0)
            {
                if (DropDownList3.Items.Count == 0)
                {
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + DropDownList1.SelectedItem.Text + "');", true);
                    titleUnit.Value = DropDownList1.SelectedItem.Text;
                    // 加上自己的單位計算
                    row = dt.NewRow();
                    row[0] = DropDownList1.SelectedItem.Text;
                    row[1] = DropDownList1.SelectedItem.Value;
                    dt.Rows.Add(row);
                    foreach (ListItem items in DropDownList2.Items)
                    {
                        row = dt.NewRow();
                        row[0] = items.Text;
                        row[1] = items.Value;
                        dt.Rows.Add(row);
                    }
                    GridView1.DataSource = dt;
                    GridView1.DataBind();

                }

                else
                {
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + DropDownList2.SelectedItem.Text + "');", true);
                    titleUnit.Value = DropDownList2.SelectedItem.Text;
                    // 加上自己的單位計算
                    row = dt.NewRow();
                    row[0] = DropDownList2.SelectedItem.Text;
                    row[1] = DropDownList2.SelectedItem.Value;
                    dt.Rows.Add(row);

                    foreach (ListItem items in DropDownList3.Items)
                    {
                        row = dt.NewRow();
                        row[0] = items.Text;
                        row[1] = items.Value;
                        dt.Rows.Add(row);
                    }
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
            else
            {
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + DropDownList3.SelectedItem.Text + "');", true);
                titleUnit.Value = DropDownList3.SelectedItem.Text;
                // 加上自己的單位計算
                row = dt.NewRow();
                row[0] = DropDownList3.SelectedItem.Text;
                row[1] = DropDownList3.SelectedItem.Value;
                dt.Rows.Add(row);
                foreach (ListItem items in DropDownList4.Items)
                {
                    row = dt.NewRow();
                    row[0] = items.Text;
                    row[1] = items.Value;
                    dt.Rows.Add(row);
                }
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        else
        {
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + DropDownList4.SelectedItem + "');", true);
            titleUnit.Value = DropDownList4.SelectedItem.Text;
            // 加上自己的單位計算
            row = dt.NewRow();
            row[0] = DropDownList4.SelectedItem.Text;
            row[1] = DropDownList4.SelectedItem.Value;
            dt.Rows.Add(row);
            foreach (ListItem items in DropDownList5.Items)
            {
                row = dt.NewRow();
                row[0] = items.Text;
                row[1] = items.Value;
                dt.Rows.Add(row);
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
