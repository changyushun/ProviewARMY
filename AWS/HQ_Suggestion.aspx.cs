using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HQ_Suggestion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["account"] != null)
            {
                Lib.Account a = (Lib.Account)Session["account"];
                if (a.Unit_Code == "00001")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "10007")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc in('10007','19204','19901','33I01','18600','19401','175J5') ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "07001")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '07001' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "91A00")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc in('91A00','93A06') ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "60002")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc in('60002','75096') ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "81A00")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '81A00' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "40001")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '40001' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "19204")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '19204' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "19901")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '19901' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "93A06")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '93A06' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "33I01")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '33I01' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "18600")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '18600' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "19401")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '19401' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "75096")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '75096' ORDER BY s.date DESC ";
                }
                if (a.Unit_Code == "175J5")
                {
                    SqlDataSource1.SelectCommand = "SELECT s.sid, s.head, p.name, s.date, s.status FROM Suggestion AS s INNER JOIN Player AS p ON s.player = p.id where s.acc = '175J5' ORDER BY s.date DESC ";
                }
            }
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[3].Text = Lib.SysSetting.ToRocDateFormat(e.Row.Cells[3].Text);
            if (e.Row.Cells[4].Text == "1")
            {
                e.Row.Cells[4].Text = "顯示";
            }
            if (e.Row.Cells[4].Text == "0")
            {
                e.Row.Cells[4].Text = "隱藏";
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
