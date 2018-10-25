using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Lib;
using System.Drawing;

public partial class Seal_Update : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["account"] != null)
        //{
        //    if (!Page.IsPostBack)
        //    {
        //        Account a = (Account)Session["account"];
        //        if (a.Role == ((int)SysSetting.Role.user_hg).ToString())
        //        {
                    Lib.DataUtility du = new Lib.DataUtility("Data Source=192.168.0.29;Initial Catalog=Main;User ID=myap;Password=proview");
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    DataTable dt1 = new DataTable();
                    DataTable dt2 = new DataTable();
                    //d.Add("unit_code", a.Unit_Code);
                    d.Add("unit_code","00001");
                    //dt = du.getDataTableByText("select information,imagepath from Center where unit_code = @unit_code", d);
                    //查詢最新鑑測官簽章
                    dt1 = du.getDataTableByText(@"select top 1 * from Center_Seal where unit_code='00001' and rank_code='1'order by start_date desc", d);
                    //查詢最新鑑測主任簽章
                    dt2 = du.getDataTableByText(@"select top 1 * from Center_Seal where unit_code='00001' and rank_code='2' order by start_date desc",d);
                    if (dt1.Rows.Count == 1 )  //表示登入者的身分為鑑測站資訊管理者
                    {
                        //Image1.ImageUrl = dt.Rows[0]["imagepath"].ToString();
                        //information.Text = dt.Rows[0]["information"].ToString();
                        Image1b.ImageUrl = dt1.Rows[0]["seal_img"].ToString();
                        Label7b.Text = "圖片更新時間：" + Convert.ToDateTime(dt2.Rows[0]["start_date"].ToString()).ToString("yyyy年MM月dd日 HH時mm分)"); 
                    }
                    else
                    {
                        Label7b.Text = "目前單位尚未上傳鑑測官簽章圖檔!!";
                    }
                    if (dt2.Rows.Count == 1)
                    {
                        Image2b.ImageUrl = dt2.Rows[0]["seal_img"].ToString();
                        Label8b.Text = "(圖片更新時間：" + Convert.ToDateTime(dt1.Rows[0]["start_date"].ToString()).ToString("yyyy年MM月dd日 HH時mm分)"); 
                    }
                    else
                    {
                        Label7b.Text = "目前單位尚未上傳鑑測主任簽章圖檔!!";
                    }
                }
    //        }
    //    }

    //}
}