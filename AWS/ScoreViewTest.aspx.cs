using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Security.Cryptography;

public partial class ScoreView : System.Web.UI.Page
{
    //MD5 s1 = MD5.Create();
    protected void Page_Load(object sender, EventArgs e)
    {
        Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.DataUtility du = new Lib.DataUtility();
        try
        {
            d.Clear();
            d.Add("id", Request.QueryString["id"].ToString());
            d.Add("date", Request.QueryString["date"].ToString());
            Title = Request.QueryString["id"].ToString() + "成績單";
            DataTable dt_Score = du.getDataTableBysp(@"Ex104_CalResultByID", d);
            if (dt_Score.Rows.Count == 1)
            {
                if (dt_Score.Columns.Contains("error"))
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "查無此受測人員成績" + "')", true);
                    //MessageBox.Show("查無此受測人員成績");
                }
                else
                {
                    LB_CenterName.InnerText = dt_Score.Rows[0]["center_name"].ToString() + "鑑測站成績單(人工)";
                    LB_Date.InnerText = "鑑測日期：" + dt_Score.Rows[0]["date"].ToString();
                    LB_Unit.InnerText = dt_Score.Rows[0]["unit_code"].ToString();
                    LB_Rank.InnerText = dt_Score.Rows[0]["rank_code"].ToString();
                    LB_BirthAge.InnerText = dt_Score.Rows[0]["birth"].ToString() + " (" + dt_Score.Rows[0]["age"].ToString() + "歲)";
                    if (dt_Score.Rows[0]["status"].ToString().Substring(0, 1) == "2")
                    {
                        LB_Date_Re.InnerText ="列印日期：" + Lib.SysSetting.ToRocDateFormat(System.DateTime.Today.ToString("yyyy/MM/dd"));
                    }
                    else
                    {
                        LB_Date_Re.InnerText = string.Empty;
                    }

                    if (dt_Score.Rows[0]["status"].ToString().Substring(2, 1) == "4")
                    {
                        LB_Message.InnerText = "BMI值(體脂率)未達鑑測標準(醫官簽名)";
                    }
                    else
                    {
                         LB_Message.InnerText = string.Empty;
                    }

                    if (!String.IsNullOrEmpty(dt_Score.Rows[0]["BMI"].ToString()))
                        LB_BMI.InnerText = dt_Score.Rows[0]["BMI"].ToString() + " %";
                    LB_Name.InnerText = dt_Score.Rows[0]["name"].ToString();
                    LB_Id.InnerText = dt_Score.Rows[0]["id"].ToString();
                    if (!String.IsNullOrEmpty(dt_Score.Rows[0]["bodyfat"].ToString()))
                        LB_BodyFat.InnerText = dt_Score.Rows[0]["bodyfat"].ToString() + " %";

                    d.Clear();
                    if (dt_Score.Rows[0]["sit_ups"].ToString().Length == 0)
                        d.Add("sit_ups", DBNull.Value);
                    else
                        d.Add("sit_ups", dt_Score.Rows[0]["sit_ups"]);

                    d.Add("sit_ups_score", dt_Score.Rows[0]["sit_ups_score"]);

                    if (dt_Score.Rows[0]["push_ups"].ToString().Length == 0)
                        d.Add("push_ups", DBNull.Value);
                    else
                        d.Add("push_ups", dt_Score.Rows[0]["push_ups"]);

                    d.Add("push_ups_score", dt_Score.Rows[0]["push_ups_score"]);

                    if (dt_Score.Rows[0]["run"].ToString().Length == 0)
                        d.Add("run", DBNull.Value);
                    else
                        d.Add("run", dt_Score.Rows[0]["run"]);

                    d.Add("run_score", dt_Score.Rows[0]["run_score"]);

                    d.Add("memo", dt_Score.Rows[0]["memo"].ToString());
                    d.Add("status", dt_Score.Rows[0]["status"].ToString());
                    DataTable dt = du.getDataTableBysp(@"GetItemTitleAndScore", d);
                    if (dt.Rows.Count == 1)
                    {
                        LB_Situps_Name.InnerText = dt.Rows[0]["sit_ups_name"].ToString();
                        LB_Situps_Count.InnerText = dt.Rows[0]["sit_ups"].ToString();
                        LB_Situps_Score.InnerText = dt.Rows[0]["sit_ups_score"].ToString();
                        LB_Situps_Status.InnerText = dt.Rows[0]["sit_ups_result"].ToString();

                        LB_Pushups_Name.InnerText = dt.Rows[0]["push_ups_name"].ToString();
                        LB_Pushups_Count.InnerText = dt.Rows[0]["push_ups"].ToString();
                        LB_Pushups_Score.InnerText = dt.Rows[0]["push_ups_score"].ToString();
                        LB_Pushups_Status.InnerText = dt.Rows[0]["push_ups_result"].ToString();

                        LB_Run_Name.InnerText = dt.Rows[0]["run_name"].ToString();
                        LB_Run_Count.InnerText = dt.Rows[0]["run"].ToString();
                        LB_Run_Score.InnerText = dt.Rows[0]["run_score"].ToString();
                        LB_Run_Status.InnerText = dt.Rows[0]["run_result"].ToString();

                        LB_TotalStatus.InnerText = dt.Rows[0]["status"].ToString();
                        
                        ////處理加密
                        //string id = Request.QueryString["id"].ToString();
                        //string sit = "";
                        //string push = "";
                        //string run = "";
                        //if (dt.Rows[0]["sit_ups_score"].ToString() == "-")
                        //{
                        //    sit = "";
                        //}
                        //else
                        //{
                        //    sit = dt.Rows[0]["sit_ups_score"].ToString();
                        //}
                        //if (dt.Rows[0]["push_ups_score"].ToString() == "-")
                        //{
                        //    push = "";
                        //}
                        //else
                        //{
                        //    push = dt.Rows[0]["push_ups_score"].ToString();
                        //}
                        //if (dt.Rows[0]["run_score"].ToString() == "-")
                        //{
                        //    run = "";
                        //}
                        //else
                        //{
                        //    run = dt.Rows[0]["run_score"].ToString();
                        //}
                        
                        //string date = dt_Score.Rows[0]["date"].ToString();
                        //string oldstring = id + sit + push + run + date;
                        //byte[] Original = Encoding.ASCII.GetBytes(oldstring);
                        //byte[] Change = s1.ComputeHash(Original);
                        //string cs = ""; //解碼後的32碼字串
                        //Label2.Text = null;
                        //foreach (byte b in Change)//轉成32位元以ASCII輸出
                        //{
                        //    string s = b.ToString("X2");
                        //    Label2.Text += s;

                        //}
                    }

                }
            }
            else if (dt_Score.Rows.Count == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "查無此受測人員成績" + "')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "依條件查詢 , 取得成績為" + dt_Score.Rows.Count.ToString() + "筆, 此為異常情況請洽鑑測官" + "')", true);
            }           
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + ex.Message + "')", true);
        }
    }
}