using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
using System.Data.SqlClient;

public partial class DeleteArtificialScore : System.Web.UI.Page
{
    //這段要改
    Lib.DataUtility du = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack)
        //{
        
        
        //}


    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Inquiry();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Dictionary<string, object> d = new Dictionary<string,object>();
        //建立一個gridview刪除前的總筆數int
        int GVold = GridView2.Rows.Count;
        if (GridView2.Rows.Count>0)
        {
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>cancelalert();</script>");
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                CheckBox checkbox = (CheckBox)GridView2.Rows[i].Cells[0].Controls[1];
                if (checkbox.Checked == true)
                {
                    string DelId = GridView2.Rows[i].Cells[1].Text;
                    string date = GridView2.Rows[i].Cells[13].Text;
                    d.Clear();
                    d.Add("date", date);
                    d.Add("id", DelId);
                    du.executeNonQueryByText(@"delete from Result where date = @date and id = @id and result='222'", d);
                    Lib.SysSetting.AddLog("刪除人工鑑測成績", ((Lib.Account)Session["account"]).AccountName, 
                    " id : " + GridView2.Rows[i].Cells[1].Text + 
                    " 總評 : " +  GridView2.Rows[i].Cells[14].Text +
                    " 俯地挺身 : " + GridView2.Rows[i].Cells[7].Text +
                    " 俯地挺身成績 : " + GridView2.Rows[i].Cells[8].Text +
                    " 仰臥起坐 : " + GridView2.Rows[i].Cells[9].Text +
                    " 仰臥起坐成績 : " + GridView2.Rows[i].Cells[10].Text +
                    " 三千公尺 : " + GridView2.Rows[i].Cells[11].Text +
                    " 三千公尺成績 : " + GridView2.Rows[i].Cells[12].Text +
                    " 地點 : " + GridView2.Rows[i].Cells[5].Text +
                    " 時間 :  " + GridView2.Rows [i].Cells[13].Text, System.DateTime.Now);
                }
               
            }
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('資料刪除成功!!');</script>");
            DelInquiry();
            //建立一個gridview刪除後的總筆數int
            int Gvnew = GridView2.Rows.Count;
            int GvDifference = GVold - Gvnew;
            //按下刪除鍵後，新的少於舊的則表示資料有刪除
            if (Gvnew<GVold)
            {
                string Alert = "<script>alert('成功刪除資料：" + GvDifference + "筆');</script>";
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('資料刪除成功!!');</script>");
            }
            //按下刪除鍵後，新舊相等的話表示沒勾選
            else if (Gvnew == GVold)
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('請先勾選要刪除之資料!!');</script>");
            }
        }
        else
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('尚未查詢資料!!');</script>");
        }
        
    }
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    private void Inquiry()
    {
        string Id = TextBox1.Text;
        string Data = TextBox2.Text;
        DateTime Trytime;
        Dictionary<string, object> d = new Dictionary<string,object>();
        if (!string.IsNullOrEmpty(Id) & !string.IsNullOrEmpty(Data))
        {
            //檢查身份證字號長度是否正確
            if (Id.Length == 10)
            {
                //檢查日期輸入格式是否正確
                if (DateTime.TryParse(Data, out Trytime))
                {
                    d.Clear();
                    d.Add("id", Id);
                    d.Add("date", Data);
                    DataTable dt1 = du.getDataTableBysp(@"Ex104_DelArtificialScore", d);
                    GridView2.DataSource = dt1;
                    GridView2.DataBind();
                    if (dt1.Rows.Count > 0)
                    {
                        //string Alert = "<script>alert('成功查詢資料：" + dt1.Rows.Count + "筆');</script>";
                        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
                    }
                    else
                    {
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('查無相對應之資料!!');</script>");
                    }
                }
                else
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('日期格式輸入錯誤!!');</script>");
                }
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('身份證字號長度錯誤!!');</script>");
            }

        }
        else if (!string.IsNullOrEmpty(Id) & string.IsNullOrEmpty(Data))
        {
            if (Id.Length == 10)
            {
                d.Clear();
                d.Add("id", Id);
                d.Add("date", Data);
                DataTable dt2 = du.getDataTableBysp(@"Ex104_DelArtificialScore", d);
                GridView2.DataSource = dt2;
                GridView2.DataBind();
                if (dt2.Rows.Count > 0)
                {
                    //string Alert = "<script>alert('成功查詢資料：" + dt2.Rows.Count + "筆');</script>";
                    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
                }
                else
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('此身份證字號無人工鑑測之成績資料!!');</script>");
                }
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('身份證字號長度錯誤!!');</script>");
            }

        }
        else if (string.IsNullOrEmpty(Id) & !string.IsNullOrEmpty(Data))
        {
            if (DateTime.TryParse(Data, out Trytime))
            {
                d.Clear();
                d.Add("id", "");
                d.Add("date", Data);
                DataTable dt3 = du.getDataTableBysp(@"Ex104_DelArtificialScore", d);
                GridView2.DataSource = dt3;
                GridView2.DataBind();
                if (dt3.Rows.Count > 0)
                {
                    //string Alert = "<script>alert('成功查詢資料：" + dt3.Rows.Count + "筆');</script>";
                    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
                }
                else
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('當日無人工鑑測之成績資料!!');</script>");
                }
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('日期格式輸入錯誤!!');</script>");
            }

        }
        else
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('請先輸入查詢資料!!');</script>");
            GridView2.DataSource = null;
            GridView2.DataBind();
        }
    }
    private void DelInquiry()
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        string Id = TextBox1.Text;
        string Data = TextBox2.Text;
        DateTime Trytime;
        if (!string.IsNullOrEmpty(Id) & !string.IsNullOrEmpty(Data))
        {
            if (Id.Length == 10)
            {
                if (DateTime.TryParse(Data, out Trytime))
                {
                    d.Clear();
                    d.Add("id", Id);
                    d.Add("date", Data);
                    DataTable dt1 = du.getDataTableBysp(@"Ex104_DelArtificialScore", d);
                    GridView2.DataSource = dt1;
                    GridView2.DataBind();
                    if (dt1.Rows.Count > 0)
                    {
                        //string Alert = "<script>alert('成功查詢資料：" + dt1.Rows.Count + "筆');</script>";
                        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
                    }
                    else
                    {
                        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('查無相對應之資料!!');</script>");
                    }
                }
                else
                {
                    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('日期格式輸入錯誤!!');</script>");
                }
            }
            else
            {
                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('身份證字號長度錯誤!!');</script>");
            }

        }
        else if (!string.IsNullOrEmpty(Id) & string.IsNullOrEmpty(Data))
        {
            if (Id.Length == 10)
            {
                d.Clear();
                d.Add("id", Id);
                d.Add("date", Data);
                DataTable dt2 = du.getDataTableBysp(@"Ex104_DelArtificialScore", d);
                GridView2.DataSource = dt2;
                GridView2.DataBind();
                if (dt2.Rows.Count > 0)
                {
                    //string Alert = "<script>alert('成功查詢資料：" + dt2.Rows.Count + "筆');</script>";
                    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
                }
                else
                {
                    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('此身份證字號無人工鑑測之成績資料!!');</script>");
                }
            }
            else
            {
                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('身份證字號長度錯誤!!');</script>");
            }

        }
        else if (string.IsNullOrEmpty(Id) & !string.IsNullOrEmpty(Data))
        {
            if (DateTime.TryParse(Data, out Trytime))
            {
                d.Clear();
                d.Add("id", "");
                d.Add("date", Data);
                DataTable dt3 = du.getDataTableBysp(@"Ex104_DelArtificialScore", d);
                GridView2.DataSource = dt3;
                GridView2.DataBind();
                if (dt3.Rows.Count > 0)
                {
                    //string Alert = "<script>alert('成功查詢資料：" + dt3.Rows.Count + "筆');</script>";
                    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", Alert);
                }
                else
                {
                    //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('當日無人工鑑測之成績資料!!');</script>");
                }
            }
            else
            {
                //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('日期格式輸入錯誤!!');</script>");
            }

        }
        else
        {
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "msg", "<script>alert('請先輸入查詢資料!!');</script>");
            GridView2.DataSource = null;
            GridView2.DataBind();
        }
    }
}