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
                if (CheckDateTimeType(TextBox2.Text) == true & !string.IsNullOrEmpty(TextBox2.Text))
                {
                    //民國年轉西元年  
                    System.Globalization.CultureInfo tc = new System.Globalization.CultureInfo("zh-TW");
                    tc.DateTimeFormat.Calendar = new System.Globalization.TaiwanCalendar();
                    string newdate = DateTime.Parse(TextBox2.Text, tc).Date.ToString("d");

                    Dictionary<string, object> d = new Dictionary<string, object>();
                    Lib.DataUtility du = new Lib.DataUtility();
                    try
                    {
                        d.Clear();
                        //d.Add("id", Request.QueryString["id"].ToString());
                        //d.Add("date", Request.QueryString["date"].ToString());
                        d.Add("id", TextBox1.Text.ToUpper().ToString());
                        //d.Add("date", TextBox2.Text.ToString());
                        d.Add("date", newdate.ToString());
                        Title = TextBox1.Text + "成績單";

                        DataTable dt_Score = du.getDataTableBysp(@"Ex105_GetTranscriptsAndSeal", d);

                        if (dt_Score.Rows.Count == 1)
                        {
                            //if (dt_Score.Rows[0]["Seal_img1"] == System.DBNull.Value | dt_Score.Rows[0]["Seal_img2"] == System.DBNull.Value)
                            //{
                            //    if (!string.IsNullOrEmpty(dt_Score.Rows[0]["center_name"].ToString()))
                            //        Label7.Text = "受測日期無鑑測簽章檔案無法列印，請連絡：「" + dt_Score.Rows[0]["center_name"].ToString() + "鑑測站」確認，謝謝!!";
                            //    else
                            //        Label7.Text = "受測日期無鑑測簽章檔案無法列印，請連絡鑑測站確認，謝謝!!";
                            //    //MessageBox.Show("查無此受測人員成績");
                            //    //清空
                            //    LB_Situps_Name.InnerText = null;
                            //    LB_Situps_Count.InnerText = null;
                            //    LB_Situps_Score.InnerText = null;
                            //    LB_Situps_Status.InnerText = null;

                            //    LB_Pushups_Name.InnerText = null;
                            //    LB_Pushups_Count.InnerText = null;
                            //    LB_Pushups_Score.InnerText = null;
                            //    LB_Pushups_Status.InnerText = null;

                            //    LB_Run_Name.InnerText = null;
                            //    LB_Run_Count.InnerText = null;
                            //    LB_Run_Score.InnerText = null;
                            //    LB_Run_Status.InnerText = null;

                            //    LB_TotalStatus.InnerText = null;
                            //    Label5.Text = null;

                            //    Image1.ImageUrl = null;
                            //    Image2.ImageUrl = null;

                            //}
                            //else
                            //{


                                //處理鑑測官印章

                                //byte[] PhotoByte = (byte[])dt_Score.Rows[0]["Seal_img1"];
                                //ImageConverter ic = new ImageConverter();
                                //System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                                //Image1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);



                                //byte[] PhotoByte2 = (byte[])dt_Score.Rows[0]["Seal_img2"];
                                //ImageConverter ic2 = new ImageConverter();
                                //System.Drawing.Image Photo2 = (System.Drawing.Image)ic2.ConvertFrom(PhotoByte2);
                                //Image2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte2);



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
                                LB_Situps_Score.InnerText = dt_Score.Rows[0]["sit_ups_score"].ToString();
                                LB_Situps_Status.InnerText = dt_Score.Rows[0]["sit_ups_result"].ToString();

                                LB_Pushups_Name.InnerText = dt_Score.Rows[0]["push_ups_name"].ToString();
                                LB_Pushups_Count.InnerText = dt_Score.Rows[0]["push_ups"].ToString();
                                LB_Pushups_Score.InnerText = dt_Score.Rows[0]["push_ups_score"].ToString();
                                LB_Pushups_Status.InnerText = dt_Score.Rows[0]["push_ups_result"].ToString();

                                LB_Run_Name.InnerText = dt_Score.Rows[0]["run_name"].ToString();
                                LB_Run_Count.InnerText = dt_Score.Rows[0]["run"].ToString();
                                LB_Run_Score.InnerText = dt_Score.Rows[0]["run_score"].ToString();
                                LB_Run_Status.InnerText = dt_Score.Rows[0]["run_result"].ToString();

                                LB_TotalStatus.InnerText = dt_Score.Rows[0]["total_status"].ToString();
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["center_name"].ToString()))
                                    Label5.Text = dt_Score.Rows[0]["center_name"].ToString() + "鑑測站";


                            //}
                        }
                        //else if (dt_Score.Rows.Count == 0)
                        //{
                        //    //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "查無此受測人員成績" + "')", true);
                        //    Label7.Text = "查該無筆資料，請重新檢查輸入資料是否有誤!!";
                        //}
                        else
                        {
                            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('查無鑑測資料!!');", true);
                            Label7.Text = "查該無筆資料，請重新檢查輸入資料是否有誤!!";
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

                            Image1.ImageUrl = null;
                            Image2.ImageUrl = null;
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + ex.Message + "')", true);
                    }
                }
                else
                {
                    Label7.Text = "日期欄位空白或格式錯誤，請重新檢查";
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
                    Image1.ImageUrl = null;
                    Image2.ImageUrl = null;
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
                Image1.ImageUrl = null;
                Image2.ImageUrl = null;
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
        if (!string.IsNullOrEmpty(TextBox1.Text) & TextBox1.Text.Length == 10)
        {
            if (CheckDateTimeType(TextBox2.Text) == true & !string.IsNullOrEmpty(TextBox2.Text))
            {
                //民國年轉西元年  
                System.Globalization.CultureInfo tc = new System.Globalization.CultureInfo("zh-TW");
                tc.DateTimeFormat.Calendar = new System.Globalization.TaiwanCalendar();
                string newdate = DateTime.Parse(TextBox2.Text, tc).Date.ToString("d");

                Dictionary<string, object> d = new Dictionary<string, object>();
                Lib.DataUtility du = new Lib.DataUtility();
                try
                {
                    d.Clear();
                    //d.Add("id", Request.QueryString["id"].ToString());
                    //d.Add("date", Request.QueryString["date"].ToString());
                    d.Add("id", TextBox1.Text.ToUpper().ToString());
                    //d.Add("date", TextBox2.Text.ToString());
                    d.Add("date", newdate.ToString());
                    Title = TextBox1.Text + "成績單";

                    DataTable dt_Score = du.getDataTableBysp(@"Ex105_GetTranscriptsAndSeal", d);
                    
                    if (dt_Score.Rows.Count == 1)
                    {
                        if (dt_Score.Rows[0]["Seal_img1"] == System.DBNull.Value | dt_Score.Rows[0]["Seal_img2"] == System.DBNull.Value)
                        {
                            if (!string.IsNullOrEmpty(dt_Score.Rows[0]["center_name"].ToString()))
                            Label7.Text = "受測日期無鑑測簽章檔案無法列印，請連絡：「"+dt_Score.Rows[0]["center_name"].ToString()+"鑑測站」確認，謝謝!!";
                            else
                            Label7.Text = "受測日期無鑑測簽章檔案無法列印，請連絡鑑測站確認，謝謝!!";
                            //MessageBox.Show("查無此受測人員成績");
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
                            
                            Image1.ImageUrl = null;
                            Image2.ImageUrl = null;

                        }
                        else
                        {
                            

                           //處理鑑測官印章

                            byte[] PhotoByte = (byte[])dt_Score.Rows[0]["Seal_img1"];
                                    ImageConverter ic = new ImageConverter();
                                    System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                                    Image1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);



                                    byte[] PhotoByte2 = (byte[])dt_Score.Rows[0]["Seal_img2"];
                                    ImageConverter ic2 = new ImageConverter();
                                    System.Drawing.Image Photo2 = (System.Drawing.Image)ic2.ConvertFrom(PhotoByte2);
                                    Image2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte2);

                              
                           
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
                            LB_Situps_Score.InnerText = dt_Score.Rows[0]["sit_ups_score"].ToString();
                            LB_Situps_Status.InnerText = dt_Score.Rows[0]["sit_ups_result"].ToString();

                            LB_Pushups_Name.InnerText = dt_Score.Rows[0]["push_ups_name"].ToString();
                            LB_Pushups_Count.InnerText = dt_Score.Rows[0]["push_ups"].ToString();
                            LB_Pushups_Score.InnerText = dt_Score.Rows[0]["push_ups_score"].ToString();
                            LB_Pushups_Status.InnerText = dt_Score.Rows[0]["push_ups_result"].ToString();

                            LB_Run_Name.InnerText = dt_Score.Rows[0]["run_name"].ToString();
                            LB_Run_Count.InnerText = dt_Score.Rows[0]["run"].ToString();
                            LB_Run_Score.InnerText = dt_Score.Rows[0]["run_score"].ToString();
                            LB_Run_Status.InnerText = dt_Score.Rows[0]["run_result"].ToString();

                            LB_TotalStatus.InnerText = dt_Score.Rows[0]["total_status"].ToString();
                                if (!string.IsNullOrEmpty(dt_Score.Rows[0]["center_name"].ToString()))
                                    Label5.Text = dt_Score.Rows[0]["center_name"].ToString() + "鑑測站";

                            
                        }
                    }
                    //else if (dt_Score.Rows.Count == 0)
                    //{
                    //    //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "查無此受測人員成績" + "')", true);
                    //    Label7.Text = "查該無筆資料，請重新檢查輸入資料是否有誤!!";
                    //}
                    else
                    {
                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('查無鑑測資料!!');", true);
                        Label7.Text = "查該無筆資料，請重新檢查輸入資料是否有誤!!";
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

                        Image1.ImageUrl = null;
                        Image2.ImageUrl = null;
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + ex.Message + "')", true);
                }
            }
            else
            {
                Label7.Text = "日期欄位空白或格式錯誤，請重新檢查";
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
                Image1.ImageUrl = null;
                Image2.ImageUrl = null;
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
            Image1.ImageUrl = null;
            Image2.ImageUrl = null;
        }

        
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
}
