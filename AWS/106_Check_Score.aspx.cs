using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;
using System.Text;
using System.Drawing;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == true)
        {
            if (!string.IsNullOrEmpty(TextBox1.Text) & TextBox1.Text.Length == 10)
            {
                if (!string.IsNullOrEmpty(txb_check_code.Text) & txb_check_code.Text.Length == 10)
                {
                    //民國年轉西元年  
                    System.Globalization.CultureInfo tc = new System.Globalization.CultureInfo("zh-TW");
                    tc.DateTimeFormat.Calendar = new System.Globalization.TaiwanCalendar();

                    Dictionary<string, object> d = new Dictionary<string, object>();
                    Lib.DataUtility du = new Lib.DataUtility();
                    try
                    {
                        d.Clear();

                        d.Add("id", TextBox1.Text.ToUpper().ToString());

                        Title = TextBox1.Text + "成績單";
                        //2015-8-8
                        d.Add("sid", txb_check_code.Text.ToString());

                        DataTable dt_Score = du.getDataTableBysp(@"Ex106_GetTranscript_Sid", d);

                        if (dt_Score.Rows.Count == 1)
                        {
                            //2016-12-6新增檢查狀態碼
                            string LB_Status = string.Empty;
                            LB_Status = dt_Score.Rows[0]["sit_ups_name"].ToString();
                            LB_Status = dt_Score.Rows[0]["status"].ToString();
                            if (LB_Status == "000" | LB_Status == "001" | LB_Status == "999")//成績未上傳或未測無法查詢
                            {
                                //Label7.Text = "該筆成績尚未鑑測或成績未回傳無法查詢!!";
                                Label7.Text = "查無該筆資料，請重新檢查輸入資料是否有誤!!";
                                LB_Situps_Name.InnerText = null;
                                LB_Situps_Count.InnerText = null;
                                LB_Situps_Score.InnerText = null;
                                LB_Situps_Status.InnerText = null;

                                LB_Pushups_Name.InnerText = null;
                                LB_Pushups_Count.InnerText = null;
                                LB_Pushups_Score.InnerText = null;
                                LB_Pushups_Status.InnerText = null;

                                LB_Run_Name.InnerText = null;
                                LB_Run_Count.InnerText = null;
                                LB_Run_Score.InnerText = null;
                                LB_Run_Status.InnerText = null;

                                LB_TotalStatus.InnerText = null;
                                Label5.Text = null;
                                lab_unit.Text = null;
                                lab_rank.Text = null;
                                lab_name.Text = null;
                                lab_time.Text = null;

                                Image1.ImageUrl = null;
                                Image2.ImageUrl = null;
                                Image1.AlternateText = "";
                                Image2.AlternateText = "";
                            }
                            else
                            {
                                if (dt_Score.Rows[0]["status"].ToString().Substring(2, 1) == "4")
                                {
                                    Label7.Text = "BMI值(體脂率)未達鑑測標準(醫官簽名)";
                                }
                                else
                                {
                                    Label7.Text = string.Empty;
                                }

                                LB_Situps_Name.InnerText = dt_Score.Rows[0]["sit_ups_name"].ToString();
                                LB_Situps_Count.InnerText = dt_Score.Rows[0]["sit_ups"].ToString();
                                //2016-12-20新增
                                if (dt_Score.Rows[0]["sit_ups_score"].ToString() == "0")
                                    LB_Situps_Score.InnerText = "-";
                                else
                                    LB_Situps_Score.InnerText = dt_Score.Rows[0]["sit_ups_score"].ToString();
                                LB_Situps_Status.InnerText = dt_Score.Rows[0]["sit_ups_result"].ToString();

                                LB_Pushups_Name.InnerText = dt_Score.Rows[0]["push_ups_name"].ToString();
                                LB_Pushups_Count.InnerText = dt_Score.Rows[0]["push_ups"].ToString();
                                if (dt_Score.Rows[0]["push_ups_score"].ToString() == "0")
                                    LB_Pushups_Score.InnerText = "-";
                                else
                                    LB_Pushups_Score.InnerText = dt_Score.Rows[0]["push_ups_score"].ToString();
                                LB_Pushups_Status.InnerText = dt_Score.Rows[0]["push_ups_result"].ToString();

                                LB_Run_Name.InnerText = dt_Score.Rows[0]["run_name"].ToString();
                                LB_Run_Count.InnerText = dt_Score.Rows[0]["run"].ToString();
                                if (dt_Score.Rows[0]["run_score"].ToString() == "0")
                                    LB_Run_Score.InnerText = "-";
                                else
                                    LB_Run_Score.InnerText = dt_Score.Rows[0]["run_score"].ToString();
                                LB_Run_Status.InnerText = dt_Score.Rows[0]["run_result"].ToString();
                                LB_TotalStatus.InnerText = dt_Score.Rows[0]["total_status"].ToString();

                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["center_name"].ToString()))
                                    Label5.Text = dt_Score.Rows[0]["center_name"].ToString() + "鑑測站";
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["unit_code"].ToString()))
                                    lab_unit.Text = dt_Score.Rows[0]["unit_code"].ToString();
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["rank_code"].ToString()))
                                    lab_rank.Text = dt_Score.Rows[0]["rank_code"].ToString();
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["name"].ToString()))
                                    lab_name.Text = dt_Score.Rows[0]["name"].ToString();
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["date"].ToString()))
                                    lab_time.Text = dt_Score.Rows[0]["date"].ToString();

                                //處理簽章
                                //鑑測官
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_img1"].ToString()))
                                {
                                    byte[] PhotoByte = (byte[])dt_Score.Rows[0]["Seal_img1"];
                                    ImageConverter ic = new ImageConverter();
                                    System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                                    Image1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
                                }
                                else
                                {
                                    Image1.AlternateText = "鑑測站未上傳簽章";
                                }
                                //鑑測主任
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_img2"].ToString()))
                                {
                                    byte[] PhotoByte = (byte[])dt_Score.Rows[0]["Seal_img2"];
                                    ImageConverter ic = new ImageConverter();
                                    System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                                    Image2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
                                }
                                else
                                {
                                    Image2.AlternateText = "鑑測站未上傳簽章";
                                }
                            }



                        }

                        else
                        {
                            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('查無鑑測資料!!');", true);
                            Label7.Text = "查無該筆資料，請重新檢查輸入資料是否有誤!!";
                            //清空
                            LB_Situps_Name.InnerText = null;
                            LB_Situps_Count.InnerText = null;
                            LB_Situps_Score.InnerText = null;
                            LB_Situps_Status.InnerText = null;

                            LB_Pushups_Name.InnerText = null;
                            LB_Pushups_Count.InnerText = null;
                            LB_Pushups_Score.InnerText = null;
                            LB_Pushups_Status.InnerText = null;

                            LB_Run_Name.InnerText = null;
                            LB_Run_Count.InnerText = null;
                            LB_Run_Score.InnerText = null;
                            LB_Run_Status.InnerText = null;

                            LB_TotalStatus.InnerText = null;
                            Label5.Text = null;
                            lab_unit.Text = null;
                            lab_rank.Text = null;
                            lab_name.Text = null;
                            lab_time.Text = null;

                            Image1.ImageUrl = null;
                            Image2.ImageUrl = null;
                            Image1.AlternateText = "";
                            Image2.AlternateText = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + ex.Message + "')", true);
                    }
                }
                else
                {
                    Label7.Text = "驗證碼空白或長度未達10碼，請重新檢查";
                    //清空
                    LB_Situps_Name.InnerText = null;
                    LB_Situps_Count.InnerText = null;
                    LB_Situps_Score.InnerText = null;
                    LB_Situps_Status.InnerText = null;

                    LB_Pushups_Name.InnerText = null;
                    LB_Pushups_Count.InnerText = null;
                    LB_Pushups_Score.InnerText = null;
                    LB_Pushups_Status.InnerText = null;

                    LB_Run_Name.InnerText = null;
                    LB_Run_Count.InnerText = null;
                    LB_Run_Score.InnerText = null;
                    LB_Run_Status.InnerText = null;

                    LB_TotalStatus.InnerText = null;
                    Label5.Text = null;
                    lab_unit.Text = null;
                    lab_rank.Text = null;
                    lab_name.Text = null;
                    lab_time.Text = null;

                    Image1.ImageUrl = null;
                    Image2.ImageUrl = null;
                    Image1.AlternateText = "";
                    Image2.AlternateText = "";
                }
            }
            else
            {
                Label7.Text = "身份證欄位空白或長度未達10碼，請重新檢查";

                //清空
                LB_Situps_Name.InnerText = null;
                LB_Situps_Count.InnerText = null;
                LB_Situps_Score.InnerText = null;
                LB_Situps_Status.InnerText = null;

                LB_Pushups_Name.InnerText = null;
                LB_Pushups_Count.InnerText = null;
                LB_Pushups_Score.InnerText = null;
                LB_Pushups_Status.InnerText = null;

                LB_Run_Name.InnerText = null;
                LB_Run_Count.InnerText = null;
                LB_Run_Score.InnerText = null;
                LB_Run_Status.InnerText = null;

                LB_TotalStatus.InnerText = null;
                Label5.Text = null;
                lab_unit.Text = null;
                lab_rank.Text = null;
                lab_name.Text = null;
                lab_time.Text = null;

                Image1.ImageUrl = null;
                Image2.ImageUrl = null;
                Image1.AlternateText = "";
                Image2.AlternateText = "";
            }


        }

    }
    //檢查日期格式用
    public bool CheckDateTimeType(string txtDateStart)
    {
        DateTime sd;//供判斷暫存之用
        if (String.IsNullOrEmpty(txtDateStart) || !DateTime.TryParse(txtDateStart, out sd))
        {
            return false;
        }
        return true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    protected void submit_Click(object sender, EventArgs e)
    {

    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {

    }
}
