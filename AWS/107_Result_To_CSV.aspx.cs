using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _107_Result_To_CSV : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == true)
        {
            if (!string.IsNullOrEmpty(txb_Start_date.Text) & !string.IsNullOrEmpty(txb_End_date.Text))
            {
                Dictionary<string, object> d = new Dictionary<string, object>();
                Lib.DataUtility du = new Lib.DataUtility();
                try
                {
                    d.Add("start_date", txb_Start_date.Text);
                    d.Add("end_date", txb_End_date.Text);
                    DataTable dt = new DataTable();
                    //2017-11-23使用新的函式，加長timeout為120秒
                    dt = du.getDataTableBysp_BigData(@"Ex107_GetResultByDate", d);
                    if (dt.Rows.Count > 0)
                    {
                        string svPath = "Result(" + txb_Start_date.Text + "_" + txb_End_date.Text + ").csv";
                        Save_csv_toClient(dt,svPath);
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "成績儲存完成，共計「" + dt.Rows.Count.ToString() + "」筆" + "')", true);
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "查無資料!!" + "')", true);
                    }

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + ex.Message + "')", true);
                }

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "日期不可空白" + "')", true);
            }
        }
        else
        {
            txb_Start_date.Text = DateTime.Now.Year.ToString() + "-01-01";
            txb_End_date.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    //2018-1-12修正正確寫法，才能在Client端儲存檔案
    private void Save_csv_toClient(DataTable dt, string svPath)
    {
        System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
        response.ClearContent();
        response.Clear();
        response.ContentType = "text/plain";
        response.AddHeader("Content-Disposition", "attachment; filename="+svPath+";");
        StringBuilder sb = new StringBuilder();

        
        string data = "";

        foreach (DataRow row in dt.Rows)
        {
            foreach (DataColumn column in dt.Columns)
            {
                if (!string.IsNullOrEmpty(row[column].ToString().Trim()))
                {
                    if (column.ColumnName == "birth" | column.ColumnName == "date")
                    {
                        data += Convert.ToDateTime(row[column].ToString().Trim()).ToString("yyyy-MM-dd 00:00:00.000") + ",";
                    }
                    else
                        data += row[column].ToString().Trim() + ",";
                }
                else
                    data += "NULL,";
            }
            data += "";
            sb.AppendLine(data.Substring(0, (data.Length - 1)));
            data = "";
        }
        response.Write(sb.ToString());

        response.Flush();
        response.End();
    }
}