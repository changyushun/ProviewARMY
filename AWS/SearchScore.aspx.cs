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

public partial class SearchScore : System.Web.UI.Page
{
    public string _date;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {

        }
        else
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }

    protected void search1_Click(object sender, EventArgs e)
    {   //身份證查詢
        bool isRight = false;
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("id", id.Text.Trim());
        DataTable dt = du.getDataTableByText("select distinct unit_code from result where id = @id", d);
        DataSet ds = new DataSet();
        DataTable dt_id = new DataTable();
        dt_id.Columns.Add("unit_code");
        if (dt.Rows.Count > 0)
        { 
            Lib.Account acc = Session["account"] as Lib.Account;
            Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(acc.Unit_Code);
            DataTable _dt = unit.ChildUnitCodeTable;

            //綁定三組帳號
            if (acc.AccountName == "admin" | acc.AccountName == "cola" | acc.AccountName == "asz1330")
            {
                isRight = true;
            }
            else
            {
                //只要曾經有一個單位代碼在這底下的就能查他成績
                foreach (string t in unit.ChildUnitCodeArray)
                {
                    if (isRight == true) break;
                    foreach (DataRow tt in dt.Rows)
                    {
                        if (isRight == true) break;
                        //var check = dt.Rows[0]["unit_code"].ToString().Trim().ToUpper();
                        var check = tt["unit_code"].ToString().Trim().ToUpper();
                        if (check == t)
                        {
                            //dt_id.Rows.Add(check.ToString().Trim());
                            isRight = true;
                        }
                    }
                }
            }
            
            if (isRight)
            {
                foreach (DataRow tt in dt.Rows)
                {
                    var check = tt["unit_code"].ToString().Trim().ToUpper();
                    dt_id.Rows.Add(check.ToString().Trim());
                }

                d.Clear();
                d.Add("type", "id");
                d.Add("value", id.Text.Trim());
                ds = du.getDataSet("QueryResult", d, "tempTable", dt_id);
                GridView1.DataSource = ds.Tables[0];
                GridView1.DataBind();
            }
        }
        else
            GridView1.DataBind();

        if (ds.Tables.Count == 0)
            this.idnone.Style.Value = "";
        else
            this.idnone.Style.Value = "display:none";

        TabContainer1.ActiveTabIndex = 0;

        
    }

    protected void search2_Click(object sender, EventArgs e)
    {   //姓名查詢
        bool isRight = false;
        Lib.DataUtility du = new Lib.DataUtility();
        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("name", name.Text.Trim());
        DataTable dt = du.getDataTableByText("select distinct unit_code from result where name = @name", d);
        DataSet ds = new DataSet();
        DataTable dt_name = new DataTable();
        dt_name.Columns.Add("unit_code");
        if (dt.Rows.Count > 0)
        {
            Lib.Account acc = Session["account"] as Lib.Account;
            Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(acc.Unit_Code);
            DataTable _dt = unit.ChildUnitCodeTable;

            //綁定三組帳號
            if (acc.AccountName == "admin" | acc.AccountName == "cola" | acc.AccountName == "asz1330")
            {
                isRight = true;
            }
            else
            {
                //只要曾經有一個單位代碼在這底下的就能查他成績
                foreach (string t in unit.ChildUnitCodeArray)
                {
                    if (isRight == true) break;
                    foreach (DataRow tt in dt.Rows)
                    {
                        if (isRight == true) break;
                        //var check = dt.Rows[0]["unit_code"].ToString().Trim().ToUpper();
                        var check = tt["unit_code"].ToString().Trim().ToUpper();
                        if (check == t)
                        {
                            //dt_id.Rows.Add(check.ToString().Trim());
                            isRight = true;
                        }
                    }
                }
            }
            
            if (isRight)
            {
                foreach (DataRow tt in dt.Rows)
                {
                    var check = tt["unit_code"].ToString().Trim().ToUpper();
                    dt_name.Rows.Add(check.ToString().Trim());
                    isRight = true;
                }

                d.Clear();
                d.Add("type", "name");
                d.Add("value", name.Text.Trim());
                ds = du.getDataSet("QueryResult", d, "tempTable", dt_name);
                GridView2.DataSource = ds.Tables[0];
                GridView2.DataBind();
            }
        }
        else
            GridView2.DataBind();

        if (ds.Tables.Count == 0)
            this.namenone.Style.Value = "";
        else
            this.namenone.Style.Value = "display:none";

        TabContainer1.ActiveTabIndex = 1;
    }

    protected void search3_Click(object sender, EventArgs e)
    {   //單位代碼查詢
        bool isRight = false;
        try
        {
            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            Lib.Account acc = Session["account"] as Lib.Account;
            Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(acc.Unit_Code);
            DataTable _dt = unit.ChildUnitCodeTable;
            DataSet ds = new DataSet();
            foreach (string t in unit.ChildUnitCodeArray)
            {
                if (unit_code.Text.Trim().ToUpper() == t)
                {
                    isRight = true;
                }
            }
            if (isRight)
            {
                d.Clear();
                d.Add("type", "unit_code");
                d.Add("value", unit_code.Text.Trim());
                ds = du.getDataSet("QueryResult", d, "tempTable", _dt);
                GridView3.DataSource = ds.Tables[0];
                GridView3.DataBind();
            }
            else
            {
                this.unitnone.Style.Value = "display:none";
            }
            //if(ds.Tables.Count == 0)
            //if (ds.Tables[0].Rows.Count == 0)
            if (ds.Tables.Count == 0)
                this.unitnone.Style.Value = "";
            else
                this.unitnone.Style.Value = "display:none";
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            this.unitnone.Style.Value = "";
            GridView3.DataBind();
        }
        finally
        {
            TabContainer1.ActiveTabIndex = 2;
        }   
    }

    protected void search4_Click(object sender, EventArgs e)
    {   //鑑測日期查詢
        try
        {
            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            Lib.Account acc = Session["account"] as Lib.Account;
            Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(acc.Unit_Code);
            DataTable _dt = unit.ChildUnitCodeTable;
            d.Clear();
            d.Add("type", "date");
            d.Add("value", Lib.SysSetting.ToWorldDate(date.Text.Trim()).ToShortDateString());
            DataSet ds = du.getDataSet("QueryResult", d, "tempTable", _dt);
            //if (ds.Tables[0].Rows.Count == 0)
            if (ds.Tables.Count == 0)
            {
                this.datenone.Style.Value = "";
                GridView4.DataBind();
            }
            else
            {
                GridView4.DataSource = ds.Tables[0];
                GridView4.DataBind();
                this.datenone.Style.Value = "display:none";
            }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            this.datenone.Style.Value = "";
            GridView4.DataBind();
        }
        finally 
        {
            TabContainer1.ActiveTabIndex = 3;
        }
    }

    protected void search5_Click(object sender, EventArgs e)
    {   //鑑測站與時間查詢 , 另外使用Stroe Precedure
        try
        {
            Lib.DataUtility du = new Lib.DataUtility();
            Dictionary<string, object> d = new Dictionary<string, object>();
            Lib.Account acc = Session["account"] as Lib.Account;
            Lib.Unit unit = new Lib.UnitTree().GetUnitWithChild(acc.Unit_Code);
            DataTable _dt = unit.ChildUnitCodeTable;
            d.Clear();
            d.Add("type", "center");
            d.Add("value", cneterSel.SelectedValue);
            d.Add("date", Lib.SysSetting.ToWorldDate(TextBox1.Text.Trim()).ToShortDateString());
            DataSet ds = du.getDataSet("QueryResultByCenter", d, "tempTable", _dt);     
            if (ds.Tables[0].Rows.Count == 0)
            {
                this.centernone.Style.Value = "";
                GridView5.DataBind();
            }
            else
            {
                this.centernone.Style.Value = "display:none";
                GridView5.DataSource = ds.Tables[0];
                GridView5.DataBind();    
            }        
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            this.centernone.Style.Value = "";
            GridView5.DataBind();
        }
        finally
        {
            TabContainer1.ActiveTabIndex = 4;
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }

    

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btn_print_Click(object sender, EventArgs e)
    {
        
    }
}
