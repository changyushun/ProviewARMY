using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class _106_View_Web_Transcripts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //清空成績單
        ClearText();

        //開始處理變動表格
        Dictionary<string, object> d = new Dictionary<string, object>();
        Lib.DataUtility du = new Lib.DataUtility();
        try
        {
            string Center_code = string.Empty;
            string Status = string.Empty;

            d.Clear();
            d.Add("id", Request.QueryString["id"].ToString());
            d.Add("date", Request.QueryString["date"].ToString());
            DataTable dt_Score = du.getDataTableBysp(@"Ex106_GetTranscript_Date", d);
            if (!string.IsNullOrEmpty(dt_Score.Rows[0]["center_code"].ToString()))
                Center_code = dt_Score.Rows[0]["center_code"].ToString();
            if (!string.IsNullOrEmpty(dt_Score.Rows[0]["status"].ToString()))
                Status = dt_Score.Rows[0]["status"].ToString();
            if (dt_Score.Rows.Count == 1)
            {
                if (Status == "000" | Status == "001" | Status == "999" | Status == string.Empty)//成績未上傳或未測無法查詢
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "該筆成績尚未鑑測或成績未回傳無法列印!!" + "')", true);
                }
                else//資料正確開始處理
                {
                    //鑑測站名稱及鑑測日期
                    p_Center_Name.InnerText = dt_Score.Rows[0]["center_name"].ToString() + "鑑測站成績單(網路)";
                    p_Test_Date.InnerText = "鑑測日期：" + dt_Score.Rows[0]["date"].ToString();
                    p_Print_Date.InnerText = "列印日期：" + Lib.SysSetting.ToRocDateFormat(System.DateTime.Today.ToString("yyyy/MM/dd"));
                    //個人基本資料
                    p_Unit.InnerText = "單位："+dt_Score.Rows[0]["unit_code"].ToString();
                    p_Rank.InnerText = "級職："+dt_Score.Rows[0]["rank_code"].ToString();
                    p_Birth.InnerText = "生日："+dt_Score.Rows[0]["birth"].ToString() + " (" + dt_Score.Rows[0]["age"].ToString() + "歲)";
                    if (!String.IsNullOrEmpty(dt_Score.Rows[0]["BMI"].ToString()))
                        p_BMI.InnerText = "BMI：" + dt_Score.Rows[0]["BMI"].ToString() + " %";
                    else
                        p_BMI.InnerText = "BMI：";
                    p_Name.InnerText = "姓名："+dt_Score.Rows[0]["name"].ToString();
                    p_ID.InnerText = "身份證字號："+dt_Score.Rows[0]["id"].ToString();
                    if (!String.IsNullOrEmpty(dt_Score.Rows[0]["bodyfat"].ToString()))
                        p_BodyFat.InnerText = "體脂率："+dt_Score.Rows[0]["bodyfat"].ToString() + " %";
                    else
                        p_BodyFat.InnerText = "體脂率：";
                    //醫官判定
                    if (dt_Score.Rows[0]["status"].ToString().Substring(2, 1) == "4")
                    {
                        p_Message.InnerText = "BMI值(體脂率)未達鑑測標準(醫官簽名)";
                    }
                    else
                    {
                        p_Message.InnerText = "";
                    }
                    //sit_ups(仰臥起坐)成績
                    LB_Situps_Name.InnerText = dt_Score.Rows[0]["sit_ups_name"].ToString();
                    LB_Situps_Count.InnerText = dt_Score.Rows[0]["sit_ups"].ToString();
                    if (dt_Score.Rows[0]["sit_ups_score"].ToString() == "0")
                        LB_Situps_Score.InnerText = "-";
                        
                    else
                        LB_Situps_Score.InnerText = dt_Score.Rows[0]["sit_ups_score"].ToString();
                    LB_Situps_Status.InnerText = dt_Score.Rows[0]["sit_ups_result"].ToString();
                    //push_ups(俯地挺身)成績
                    LB_Pushups_Name.InnerText = dt_Score.Rows[0]["push_ups_name"].ToString();
                    LB_Pushups_Count.InnerText = dt_Score.Rows[0]["push_ups"].ToString();
                    if (dt_Score.Rows[0]["push_ups_score"].ToString() == "0")
                        LB_Pushups_Score.InnerText = "-";
                    else
                        LB_Pushups_Score.InnerText = dt_Score.Rows[0]["push_ups_score"].ToString();
                    LB_Pushups_Status.InnerText = dt_Score.Rows[0]["push_ups_result"].ToString();
                    //run(三千公尺)成績
                    LB_Run_Name.InnerText = dt_Score.Rows[0]["run_name"].ToString();
                    LB_Run_Count.InnerText = dt_Score.Rows[0]["run"].ToString();
                    if (dt_Score.Rows[0]["run_score"].ToString() == "0")
                        LB_Run_Score.InnerText = "-";
                    else
                        LB_Run_Score.InnerText = dt_Score.Rows[0]["run_score"].ToString();
                    LB_Run_Status.InnerText = dt_Score.Rows[0]["run_result"].ToString();

                    //驗證碼
                    //SID不足10碼前面補0補到10碼
                    if (string.IsNullOrEmpty(dt_Score.Rows[0]["sid"].ToString()) | dt_Score.Rows[0]["sid"].ToString() == "0")
                    {
                        p_Check_Code.InnerText = "<查無驗證碼>";
                    }
                    else
                    {
                        p_Check_Code.InnerText ="<驗證碼："+ String.Format("{0:0000000000}", Convert.ToInt64(dt_Score.Rows[0]["sid"].ToString()))+">";
                    }

                    //總評
                    p_TotalStatus.InnerText ="總評："+ dt_Score.Rows[0]["total_status"].ToString();

                    //抓鑑測官資料
                    //鑑測官單位
                    if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_unit1"].ToString()))
                    {
                        int SealUnit_len = 0;
                        SealUnit_len = dt_Score.Rows[0]["Seal_unit1"].ToString().Length;
                        switch (SealUnit_len)
                        {
                            case 1:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "0px");
                                break;
                            case 2:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "60px");
                                break;
                            case 3:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "24px");
                                break;
                            case 4:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "10px");
                                break;
                            case 5:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "3px");
                                break;
                            case 6:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "16px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "1px");
                                break;
                            case 7:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "14px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "1px");
                                break;
                            case 8:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "13px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "0px");
                                break;
                            case 9:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "12px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "0px");
                                break;
                            case 10:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "10px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "0px");
                                break;
                            case 11:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "0px");
                                break;
                            case 12:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "0px");
                                break;
                            default:
                                LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "8px");
                                LB_Seal_Unit1.Style.Add("letter-spacing", "0px");
                                break;
                        }
                        LB_Seal_Unit1.InnerText = dt_Score.Rows[0]["Seal_unit1"].ToString();
                    }
                    else
                    {
                        LB_Seal_Unit1.InnerText = "鑑測站簽章未上傳";
                        LB_Seal_Unit1.Style.Add(HtmlTextWriterStyle.FontSize, "17px");
                        LB_Seal_Unit1.Style.Add("letter-spacing", "5px");
                    }
                    //鑑測官級職
                    if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_rank1"].ToString()))
                    {
                        int SealRank_len = 0;
                        SealRank_len = dt_Score.Rows[0]["Seal_rank1"].ToString().Length;
                        switch (SealRank_len)
                        {
                            case 1:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "0px");
                                break;
                            case 2:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "60px");
                                break;
                            case 3:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "24px");
                                break;
                            case 4:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "10px");
                                break;
                            case 5:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "3px");
                                break;
                            case 6:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "16px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "1px");
                                break;
                            case 7:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "14px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "1px");
                                break;
                            case 8:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "13px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "0px");
                                break;
                            case 9:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "12px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "0px");
                                break;
                            case 10:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "10px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "0px");
                                break;
                            case 11:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "0px");
                                break;
                            case 12:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "0px");
                                break;
                            default:
                                LB_Seal_Rank1.Style.Add(HtmlTextWriterStyle.FontSize, "8px");
                                LB_Seal_Rank1.Style.Add("letter-spacing", "0px");
                                break;
                        }
                        LB_Seal_Rank1.InnerText = dt_Score.Rows[0]["Seal_rank1"].ToString();
                    }
                    else
                    {
                        LB_Seal_Rank1.InnerText = "";
                    }
                    //鑑測官姓名
                    if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_name1"].ToString()))
                    {
                        int SealName_len = 0;
                        SealName_len = dt_Score.Rows[0]["Seal_name1"].ToString().Length;
                        switch (SealName_len)
                        {
                            case 1:
                                LB_Seal_Name1.Style.Add(HtmlTextWriterStyle.FontSize, "26px");
                                LB_Seal_Name1.Style.Add("letter-spacing", "0px");
                                break;
                            case 2:
                                LB_Seal_Name1.Style.Add(HtmlTextWriterStyle.FontSize, "26px");
                                LB_Seal_Name1.Style.Add("letter-spacing", "20px");
                                break;
                            case 3:
                                LB_Seal_Name1.Style.Add(HtmlTextWriterStyle.FontSize, "20px");
                                LB_Seal_Name1.Style.Add("letter-spacing", "0px");
                                break;
                            case 4:
                                LB_Seal_Name1.Style.Add(HtmlTextWriterStyle.FontSize, "16px");
                                LB_Seal_Name1.Style.Add("letter-spacing", "0px");
                                break;
                            case 5:
                                LB_Seal_Name1.Style.Add(HtmlTextWriterStyle.FontSize, "14px");
                                LB_Seal_Name1.Style.Add("letter-spacing", "0px");
                                break;
                            case 6:
                                LB_Seal_Name1.Style.Add(HtmlTextWriterStyle.FontSize, "12px");
                                LB_Seal_Name1.Style.Add("letter-spacing", "0px");
                                break;
                            default:
                                LB_Seal_Name1.Style.Add(HtmlTextWriterStyle.FontSize, "8px");
                                LB_Seal_Name1.Style.Add("letter-spacing", "0px");
                                break;
                        }
                        LB_Seal_Name1.InnerText = dt_Score.Rows[0]["Seal_name1"].ToString();
                    }
                    else
                    {
                        LB_Seal_Name1.InnerText = "";
                    }

                    //抓鑑測主任資料
                    //鑑測主任單位
                    if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_unit2"].ToString()))
                    {
                        int SealUnit_len = 0;
                        SealUnit_len = dt_Score.Rows[0]["Seal_unit2"].ToString().Length;
                        switch (SealUnit_len)
                        {
                            case 1:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "0px");
                                break;
                            case 2:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "60px");
                                break;
                            case 3:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "24px");
                                break;
                            case 4:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "10px");
                                break;
                            case 5:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "3px");
                                break;
                            case 6:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "16px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "1px");
                                break;
                            case 7:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "14px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "1px");
                                break;
                            case 8:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "13px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "0px");
                                break;
                            case 9:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "12px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "0px");
                                break;
                            case 10:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "10px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "0px");
                                break;
                            case 11:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "0px");
                                break;
                            case 12:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "0px");
                                break;
                            default:
                                LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "8px");
                                LB_Seal_Unit2.Style.Add("letter-spacing", "0px");
                                break;
                        }
                        LB_Seal_Unit2.InnerText = dt_Score.Rows[0]["Seal_unit2"].ToString();
                    }
                    else
                    {
                        LB_Seal_Unit2.InnerText = "鑑測站簽章未上傳";
                        LB_Seal_Unit2.Style.Add(HtmlTextWriterStyle.FontSize, "17px");
                        LB_Seal_Unit2.Style.Add("letter-spacing", "5px");
                    }
                    //鑑測主任級職
                    if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_rank2"].ToString()))
                    {
                        int SealRank_len = 0;
                        SealRank_len = dt_Score.Rows[0]["Seal_rank2"].ToString().Length;
                        switch (SealRank_len)
                        {
                            case 1:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "0px");
                                break;
                            case 2:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "60px");
                                break;
                            case 3:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "24px");
                                break;
                            case 4:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "10px");
                                break;
                            case 5:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "18px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "3px");
                                break;
                            case 6:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "16px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "1px");
                                break;
                            case 7:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "14px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "1px");
                                break;
                            case 8:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "13px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "0px");
                                break;
                            case 9:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "12px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "0px");
                                break;
                            case 10:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "10px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "0px");
                                break;
                            case 11:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "0px");
                                break;
                            case 12:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "9px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "0px");
                                break;
                            default:
                                LB_Seal_Rank2.Style.Add(HtmlTextWriterStyle.FontSize, "8px");
                                LB_Seal_Rank2.Style.Add("letter-spacing", "0px");
                                break;
                        }
                        LB_Seal_Rank2.InnerText = dt_Score.Rows[0]["Seal_rank2"].ToString();
                    }
                    else
                    {
                        LB_Seal_Rank2.InnerText = "";
                    }
                    //鑑測主任姓名
                    if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_name2"].ToString()))
                    {
                        int SealName_len = 0;
                        SealName_len = dt_Score.Rows[0]["Seal_name2"].ToString().Length;
                        switch (SealName_len)
                        {
                            case 1:
                                LB_Seal_Name2.Style.Add(HtmlTextWriterStyle.FontSize, "26px");
                                LB_Seal_Name2.Style.Add("letter-spacing", "0px");
                                break;
                            case 2:
                                LB_Seal_Name2.Style.Add(HtmlTextWriterStyle.FontSize, "26px");
                                LB_Seal_Name2.Style.Add("letter-spacing", "20px");
                                break;
                            case 3:
                                LB_Seal_Name2.Style.Add(HtmlTextWriterStyle.FontSize, "20px");
                                LB_Seal_Name2.Style.Add("letter-spacing", "0px");
                                break;
                            case 4:
                                LB_Seal_Name2.Style.Add(HtmlTextWriterStyle.FontSize, "16px");
                                LB_Seal_Name2.Style.Add("letter-spacing", "0px");
                                break;
                            case 5:
                                LB_Seal_Name2.Style.Add(HtmlTextWriterStyle.FontSize, "14px");
                                LB_Seal_Name2.Style.Add("letter-spacing", "0px");
                                break;
                            case 6:
                                LB_Seal_Name2.Style.Add(HtmlTextWriterStyle.FontSize, "12px");
                                LB_Seal_Name2.Style.Add("letter-spacing", "0px");
                                break;
                            default:
                                LB_Seal_Name2.Style.Add(HtmlTextWriterStyle.FontSize, "8px");
                                LB_Seal_Name2.Style.Add("letter-spacing", "0px");
                                break;
                        }
                        LB_Seal_Name2.InnerText = dt_Score.Rows[0]["Seal_name2"].ToString();
                    }
                    else
                    {
                        LB_Seal_Name2.InnerText = "";
                    }

                    ////舊版(影像檔)
                    ////處理簽章
                    ////鑑測官
                    //if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_img1"].ToString()))
                    //{
                    //    byte[] PhotoByte = (byte[])dt_Score.Rows[0]["Seal_img1"];
                    //    ImageConverter ic = new ImageConverter();
                    //    System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                    //    Img1.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
                    //    Img1.BackColor = Color.Transparent;
                    //}
                    //else
                    //{
                    //    Img1.AlternateText = "鑑測站未上傳簽章";
                    //}
                    ////鑑測主任
                    //if (!string.IsNullOrEmpty(dt_Score.Rows[0]["Seal_img2"].ToString()))
                    //{
                    //    byte[] PhotoByte = (byte[])dt_Score.Rows[0]["Seal_img2"];
                    //    ImageConverter ic = new ImageConverter();
                    //    System.Drawing.Image Photo = (System.Drawing.Image)ic.ConvertFrom(PhotoByte);
                    //    Img2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(PhotoByte);
                    //    Img2.BackColor = Color.Transparent;
                    //}
                    //else
                    //{
                    //    Img2.AlternateText = "鑑測站未上傳簽章";
                    //}
                }
            }
            else if (dt_Score.Rows.Count == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "查無此受測人員成績" + "')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "取得單日成績單數量為：" + dt_Score.Rows.Count.ToString() + "筆,超過乙筆以上，此為異常情況請洽鑑測中心鑑測官" + "')", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "alert('" + "錯誤訊息："+ex.Message + "')", true);
        }

    }
    //清空內容
    private void ClearText()
    {
        //清空抬頭
        p_Center_Name.InnerText = "";
        p_Test_Date.InnerText = "";
        p_Print_Date.InnerText = "";
        //清空個人資料
        p_Unit.InnerText = "單位：";
        p_Rank.InnerText = "級職：";
        p_Birth.InnerText = "生日：";
        p_BMI.InnerText = "BMI：";
        p_Name.InnerText = "姓名：";
        p_ID.InnerText = "身份證字號：";
        p_BodyFat.InnerText = "體脂率：";
        //清空醫官判定
        p_Message.InnerText = "";
        //清空鑑測項目及成績
        LB_Situps_Name.InnerText = "";
        LB_Situps_Count.InnerText = "";
        LB_Situps_Score.InnerText = "";
        LB_Situps_Status.InnerText = "";
        LB_Pushups_Name.InnerText = "";
        LB_Pushups_Count.InnerText = "";
        LB_Pushups_Score.InnerText = "";
        LB_Pushups_Status.InnerText = "";
        LB_Run_Name.InnerText = "";
        LB_Run_Count.InnerText = "";
        LB_Run_Score.InnerText = "";
        LB_Run_Status.InnerText = "";
        //清空驗證碼
        p_Check_Code.InnerText = "";
        //清空總評
        p_TotalStatus.InnerText = "";
        //清空簽章
        LB_Seal_Unit1.InnerText = "";
        LB_Seal_Rank1.InnerText = "";
        LB_Seal_Name1.InnerText = "";
        LB_Seal_Unit2.InnerText = "";
        LB_Seal_Rank2.InnerText = "";
        LB_Seal_Name2.InnerText = "";


        //舊版
        //清空簽章
        //Img1.ImageUrl = null;
        //Img2.ImageUrl = null;
        //Img1.AlternateText = "";
        //Img2.AlternateText = "";
    }
}