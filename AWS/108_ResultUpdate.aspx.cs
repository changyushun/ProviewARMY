using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Lib;

public partial class _108_ResultUpdate : System.Web.UI.Page
{
    static string Sid = string.Empty;
    static string Name = string.Empty;
    static string Birth = string.Empty;
    static string Age = string.Empty;
    static string ItemName1 = string.Empty;
    static string ItemName2 = string.Empty;
    static string ItemName3 = string.Empty;
    static string Item1 = string.Empty;
    static string Item2 = string.Empty;
    static string Item3 = string.Empty;
    static string ItemScore1 = string.Empty;
    static string ItemScore2 = string.Empty;
    static string ItemScore3 = string.Empty;
    static string Status = string.Empty;
    static string Old_Name = string.Empty;
    static string Old_Birth = string.Empty;
    static string Old_Age = string.Empty;
    static string Old_Item1 = string.Empty;
    static string Old_Item2 = string.Empty;
    static string Old_Item3 = string.Empty;
    static string Old_ItemScore1 = string.Empty;
    static string Old_ItemScore2 = string.Empty;
    static string Old_ItemScore3 = string.Empty;
    static string Old_Status = string.Empty;
    static string Memo = string.Empty;
    static bool Check_memo;
    const string Sec = "(總秒數)";
    const string Count = "(次數)";
    static string Even = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["account"] != null)
        {
            Account a = (Account)Session["account"];
            Check_memo = false;
            Sid = Request.QueryString["sid"].ToString();
            if (Page.IsPostBack == false)//剛開始載入頁面
            {
                Dictionary<string, object> d = new Dictionary<string, object>();
                Lib.DataUtility du = new Lib.DataUtility();
                d.Add("sid", Sid);
                DataTable dt = du.getDataTableBysp("Ex108_GetResultDataBySid", d);
                if (dt.Rows.Count > 0)
                {
                    //個人基本資料
                    if (!string.IsNullOrEmpty(dt.Rows[0]["name"].ToString()))
                    {
                        Name = dt.Rows[0]["name"].ToString();
                        txb_Name.Text = Name;
                        Old_Name = Name;
                        lab_OldName.Text = "(" + Old_Name + ")";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["birth"].ToString()))
                    {
                        Birth = dt.Rows[0]["birth"].ToString();
                        txb_Birth.Text = Birth;
                        Old_Birth = Birth;
                        lab_OldBirth.Text = "(" + Old_Birth + ")";
                    }
                    if (!string.IsNullOrEmpty(dt.Rows[0]["age"].ToString()))
                    {
                        Age = dt.Rows[0]["age"].ToString();
                        txb_Age.Text = Age;
                        Old_Age = Age;
                        lab_OldAge.Text = "(" + Age + ")";
                    }
                    //檢查項次欄位
                    if (!string.IsNullOrEmpty(dt.Rows[0]["memo"].ToString()))
                    {
                        Check_memo = true;
                        Memo = dt.Rows[0]["memo"].ToString();
                    }

                    //項次名稱
                    //項次1
                    if (!string.IsNullOrEmpty(dt.Rows[0]["sit_ups_name"].ToString()))
                    {
                        ItemName1 = dt.Rows[0]["sit_ups_name"].ToString();
                        lab_ItemScore1.Text = "(5)" + ItemName1 + "(成績)";
                        if (Check_memo == true)
                        {
                            if (Memo.Substring(0, 1) == "F" || Memo.Substring(0, 1) == "G" || Memo.Substring(0, 1) == "J")
                                lab_Item1.Text = "(4)" + ItemName1 + Sec;
                            else
                                lab_Item1.Text = "(4)" + ItemName1 + Count;
                        }
                        else
                        {
                            lab_Item1.Text = "(4)" + ItemName1 + "(次/秒數)";
                        }
                    }
                    //項次2
                    if (!string.IsNullOrEmpty(dt.Rows[0]["push_ups_name"].ToString()))
                    {
                        ItemName2 = dt.Rows[0]["push_ups_name"].ToString();
                        lab_ItemScore2.Text = "(7)" + ItemName2 + "(成績)";
                        if (Check_memo == true)
                        {
                            if (Memo.Substring(1, 1) == "F" || Memo.Substring(1, 1) == "G" || Memo.Substring(1, 1) == "J")
                                lab_Item2.Text = "(6)" + ItemName2 + Sec;
                            else
                                lab_Item2.Text = "(6)" + ItemName2 + Count;
                        }
                        else
                        {
                            lab_Item2.Text = "(6)" + ItemName2 + "(次/秒數)";

                        }

                    }
                    //項次3
                    if (!string.IsNullOrEmpty(dt.Rows[0]["run_name"].ToString()))
                    {
                        ItemName3 = dt.Rows[0]["run_name"].ToString();
                        lab_ItemScore3.Text = "(9)" + ItemName3 + "(成績)";
                        if (Check_memo == true)
                        {
                            if (Memo.Substring(2, 1) == "0" || Memo.Substring(2, 1) == "F" || Memo.Substring(2, 1) == "G" || Memo.Substring(2, 1) == "J")
                                lab_Item3.Text = "(8)" + ItemName3 + Sec;
                            else
                                lab_Item3.Text = "(8)" + ItemName3 + Count;
                        }
                        else
                        {
                            lab_Item3.Text = "(8)" + ItemName3 + "(次/秒數)";
                        }

                    }
                    //項次次數及成績
                    //項次1
                    if (!string.IsNullOrEmpty(dt.Rows[0]["sit_ups_score"].ToString()))
                    {
                        ItemScore1 = dt.Rows[0]["sit_ups_score"].ToString();
                        Old_ItemScore1 = ItemScore1;
                        if (ItemScore1 == "999")
                        {
                            lab_OldItem1.Text = "(未完測)";
                            lab_OldItemScore1.Text = "(未完測)";
                        }
                        else
                        {
                            Old_ItemScore1 = ItemScore1;
                            txb_ItemScore1.Text = ItemScore1;
                            lab_OldItemScore1.Text = "(" + Old_ItemScore1 + ")";
                        }
                        //項次1次/秒數
                        if (!string.IsNullOrEmpty(dt.Rows[0]["sit_ups"].ToString()))
                        {
                            Item1 = dt.Rows[0]["sit_ups"].ToString();
                            Old_Item1 = Item1;
                            txb_Item1.Text = Item1;
                            lab_OldItem1.Text = "(" + Old_Item1 + ")";
                        }
                        else
                        {
                            Item1 = string.Empty;
                            Old_Item1 = string.Empty;
                        }
                    }
                    else
                    {
                        ItemScore1 = string.Empty;
                        Old_ItemScore1 = string.Empty;
                        Item1 = string.Empty;
                        Old_Item1 = string.Empty;
                        lab_OldItem1.Text = "(未測驗)";
                        lab_OldItemScore1.Text = "(未測驗)";
                    }

                    //項次2
                    if (!string.IsNullOrEmpty(dt.Rows[0]["push_ups_score"].ToString()))
                    {
                        ItemScore2 = dt.Rows[0]["push_ups_score"].ToString();
                        Old_ItemScore2 = ItemScore2;
                        if (ItemScore2 == "999")
                        {
                            lab_OldItem2.Text = "(未完測)";
                            lab_OldItemScore2.Text = "(未完測)";
                        }
                        else
                        {
                            Old_ItemScore2 = ItemScore2;
                            txb_ItemScore2.Text = ItemScore2;
                            lab_OldItemScore2.Text = "(" + Old_ItemScore2 + ")";
                        }
                        //項次2次/秒數
                        if (!string.IsNullOrEmpty(dt.Rows[0]["push_ups"].ToString()))
                        {
                            Item2 = dt.Rows[0]["push_ups"].ToString();
                            Old_Item2 = Item2;
                            txb_Item2.Text = Item2;
                            lab_OldItem2.Text = "(" + Old_Item2 + ")";
                        }
                        else
                        {
                            Item2 = string.Empty;
                            Old_Item2 = string.Empty;
                        }
                    }
                    else
                    {
                        ItemScore2 = string.Empty;
                        Old_ItemScore2 = string.Empty;
                        Item2 = string.Empty;
                        Old_Item2 = string.Empty;
                        lab_OldItem2.Text = "(未測驗)";
                        lab_OldItemScore2.Text = "(未測驗)";
                    }
                    //項次3
                    if (!string.IsNullOrEmpty(dt.Rows[0]["run_score"].ToString()))
                    {
                        ItemScore3 = dt.Rows[0]["run_score"].ToString();
                        Old_ItemScore3 = ItemScore3;
                        if (ItemScore3 == "9999")
                        {
                            lab_OldItem3.Text = "(未完測)";
                            lab_OldItemScore3.Text = "(未完測)";
                        }
                        else
                        {
                            Old_ItemScore3 = ItemScore3;
                            txb_ItemScore3.Text = ItemScore3;
                            lab_OldItemScore3.Text = "(" + Old_ItemScore3 + ")";
                        }
                        //項次3次/秒數
                        if (!string.IsNullOrEmpty(dt.Rows[0]["run"].ToString()))
                        {
                            Item3 = dt.Rows[0]["run"].ToString();
                            Old_Item3 = Item3;
                            txb_Item3.Text = Item3;
                            lab_OldItem3.Text = "(" + Old_Item3 + ")";
                        }
                        else
                        {
                            Item3 = string.Empty;
                            Old_Item3 = string.Empty;
                        }
                    }
                    else
                    {
                        ItemScore3 = string.Empty;
                        Old_ItemScore3 = string.Empty;
                        Item3 = string.Empty;
                        Old_Item3 = string.Empty;
                        lab_OldItem3.Text = "(未測驗)";
                        lab_OldItemScore3.Text = "(未測驗)";
                    }

                    //總評
                    if (!string.IsNullOrEmpty(dt.Rows[0]["status"].ToString()))
                    {
                        Status = dt.Rows[0]["status"].ToString();
                        if (Status == "202")
                            ddl_Status.SelectedIndex = 0;
                        else
                            ddl_Status.SelectedIndex = 1;
                        Old_Status = Status;
                        lab_OldStatus.Text = (Status == "202") ? "(合格)" : "(不合格)";
                    }
                }
            }
            else//提交資料後回傳
            {
                Dictionary<string, object> d = new Dictionary<string, object>();
                Lib.DataUtility du = new Lib.DataUtility();
                Name = txb_Name.Text.Trim();
                Birth = txb_Birth.Text.Trim();
                Age = txb_Age.Text.Trim();
                d.Add("sid", Sid);
                d.Add("name", Name);
                d.Add("birth", Birth);
                d.Add("age", Age);
                //項次1次/秒數
                if (!string.IsNullOrEmpty(txb_Item1.Text))
                {
                    Item1 = txb_Item1.Text.Trim();
                    d.Add("sit_ups", Item1);
                }
                else
                {
                    Item1 = string.Empty;
                    d.Add("sit_ups", DBNull.Value);
                }
                //項次1成績
                if (!string.IsNullOrEmpty(txb_ItemScore1.Text))
                {
                    ItemScore1 = txb_ItemScore1.Text.Trim();
                    d.Add("sit_ups_score", ItemScore1);
                }
                else
                {
                    if (!string.IsNullOrEmpty(Old_ItemScore1) && Old_ItemScore3 == "999")
                    {
                        ItemScore1 = Old_ItemScore1;
                        d.Add("sit_ups_score", ItemScore1);
                    }
                    else
                    {
                        ItemScore1 = string.Empty;
                        d.Add("sit_ups_score", DBNull.Value);
                    }
                }
                //項次2次/秒數
                if (!string.IsNullOrEmpty(txb_Item2.Text))
                {
                    Item2 = txb_Item2.Text.Trim();
                    d.Add("push_ups", Item2);
                }
                else
                {
                    Item2 = string.Empty;
                    d.Add("push_ups", DBNull.Value);
                }
                //項次2成績
                if (!string.IsNullOrEmpty(txb_ItemScore2.Text))
                {
                    ItemScore2 = txb_ItemScore2.Text.Trim();
                    d.Add("push_ups_score", ItemScore2);
                }
                else
                {
                    if (!string.IsNullOrEmpty(Old_ItemScore2) && Old_ItemScore2 == "999")
                    {
                        ItemScore2 = Old_ItemScore2;
                        d.Add("push_ups_score", ItemScore2);
                    }
                    else
                    {
                        ItemScore2 = string.Empty;
                        d.Add("push_ups_score", DBNull.Value);
                    }
                }
                //項次3次/秒數
                if (!string.IsNullOrEmpty(txb_Item3.Text))
                {
                    Item3 = txb_Item3.Text.Trim();
                    d.Add("run", Item3);
                }
                else
                {
                    Item3 = string.Empty;
                    d.Add("run", DBNull.Value);
                }
                //項次3成績
                if (!string.IsNullOrEmpty(txb_ItemScore3.Text))
                {
                    ItemScore3 = txb_ItemScore3.Text.Trim();
                    d.Add("run_score", ItemScore3);
                }
                else
                {
                    if (!string.IsNullOrEmpty(Old_ItemScore3) && Old_ItemScore3 == "9999")
                    {
                        ItemScore3 = Old_ItemScore3;
                        d.Add("run_score", ItemScore3);
                    }
                    else
                    {
                        ItemScore3 = string.Empty;
                        d.Add("run_score", DBNull.Value);
                    }
                }
                //總評
                if (ddl_Status.SelectedIndex == 0)
                    Status = "202";
                else if (ddl_Status.SelectedIndex == 1)
                    Status = "203";
                else
                    Status = Old_Status;
                d.Add("status", Status);

                try
                {
                    du.executeNonQueryBysp("Ex108_UpdateResultData", d);
                    Even = string.Empty;
                    if (Old_Name != Name)
                        Even += "名[" + Old_Name + "," + Name + "]";
                    if (Old_Birth != Birth)
                        Even += "生[" + Old_Birth + "," + Birth + "]";
                    if (Old_Age != Age)
                        Even += "歲[" + Old_Age + "," + Age + "]";
                    Even += "項1[" + Old_ItemScore1 + "," + ItemScore1 + "]項2[" + Old_ItemScore2 + "," + ItemScore2 + "]項3[" + Old_ItemScore3 + "," + ItemScore3 + "]總[" + ((Old_Status == "202") ? "合格" : "不合格") + "," + ((Status == "202") ? "合格" : "不合格") + "]";
                    SysSetting.AddLog("成績補正", a.AccountName, Even, DateTime.Now);
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.opener.outside_r('ok');window.close()", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "", "window.opener.outside_r('Err');window.close()", true);
                }

            }
        }
        if (Session["account"] == null && Session["player"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}