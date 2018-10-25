using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class MyTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        // Demo how to use datatable object for parameter list
        // In Database must create customer data type
        // CREATE TYPE unit_code_table AS TABLE(unit_code nvarchar(255) NOT NULL PRIMARY KEY)
        string[] unit_code_List = { "10001", "2", "1" };
        DataTable dt = new DataTable();
        dt.Columns.Add("unit_code");
        foreach (string s in unit_code_List)
        {
            DataRow row = dt.NewRow();
            row[0] = s;
            dt.Rows.Add(row);
        }

        string conStr = new Lib.DataUtility().connectionString;
        SqlConnection con = new SqlConnection();
        con.ConnectionString = conStr;
        try
        {
            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = "select * from result where unit_code in (select * from @tempTable) order by unit_code";
            cmd.Parameters.Add("@tempTable", SqlDbType.Structured);
            cmd.Parameters["@tempTable"].Direction = ParameterDirection.Input;
            cmd.Parameters["@tempTable"].TypeName = "unit_code_table";
            cmd.Parameters["@tempTable"].Value = dt;
            DataTable data = new DataTable();
            data.Load(cmd.ExecuteReader());
            con.Close();
            GridView1.DataSource = data;
            GridView1.DataBind();

        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
            Response.Write(ex.Message);
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Lib.UnitTree Tree = new Lib.UnitTree();
        Lib.Unit unit = Tree.GetUnitWithChild("00001");
        Lib.DataUtility du = new Lib.DataUtility();

        DataTable dt = du.getDataTableByText("select * from unit");
        foreach (DataRow row in dt.Rows)
        {
            int count = 0;
            foreach (KeyValuePair<string, string> pair in unit.ChildUnitList)
            {
                if (row["unit_code"].ToString() == pair.Key)
                {
                    count++;
                }
            }
            if (count != 1)
            {
                Response.Write(row["unit_code"].ToString() + " , " + row["unit_title"].ToString() + " , " + row["parent_unit_code"].ToString() + "<br />");
            }
        
        }

        //foreach (KeyValuePair<string, string> d in unit.ChildUnitList)
        //{
        //    int count = 0;
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        if (row["unit_code"].ToString() == d.Key)
        //        {
        //            count++;
        //        }
        //    }
        //    if (count != 1)
        //    {
        //        Response.Write(d.Key + " , " + d.Value + " , " + count.ToString() + "<br />");
        //    }
        //}

    }
}
