using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lib;
using System.Data;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.MaintainScrollPositionOnPostBack = true;
        if (Session["account"] != null)
        {
            if (!Page.IsPostBack)
            {
                
                //Page.MaintainScrollPositionOnPostBack = true;
                
                Account a = (Account)Session["account"];
                OP_Value.Value = a.AccountName;

                userInfo.Text = "歡迎 " + a.AccountName + " 來到國軍基本體能鑑測網, <A style=\"COLOR: blue\" id=ctl00_logout href=\"Logout.aspx\">登出</A>" +" , 現在是中華民國 " + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy")) + " 年 " + DateTime.Now.Month.ToString() + " 月 " + DateTime.Now.Day.ToString() + " 日 " + Lib.SysSetting.ToRocWeekFormat(DateTime.Now.DayOfWeek);
                #region
                //DataUtility du = new DataUtility();
                //Dictionary<string, object> d = new Dictionary<string, object>();
                //DataTable dt = du.getDataTableByText("select * from RelatedLink");
                //for (int i = 0; i < dt.Rows.Count; i++)
                //{
                //    MenuItem test = new MenuItem();
                //    test.ImageUrl = dt.Rows[i]["path"].ToString();
                //    test.NavigateUrl = dt.Rows[i]["url"].ToString();
                //    test.Target = "_blank";
                //    Menu3.Items.Add(test);
                //}
                #endregion
                if (a.Role == ((int)SysSetting.Role.admin_hq).ToString())
                {
                    //2016-11-29新增公告功能
                    MenuItem i1 = new MenuItem("最近消息管理", "", "images/nav_break.gif");
                    i1.NavigateUrl = "~/HQ_Bulletin.aspx";
                    Menu1.Items.Add(i1);

                    MenuItem i2 = new MenuItem("鑑測站行事曆","", "images/nav_break.gif");
                    i2.NavigateUrl = "~/HQ_SchMag.aspx";
                    Menu1.Items.Add(i2);
                    MenuItem i3 = new MenuItem("帳號管理者", "", "images/nav_break.gif");
                    i3.NavigateUrl = "~/HQ_MagAccMag.aspx";
                    Menu1.Items.Add(i3);
                    //MenuItem i4 = new MenuItem("國軍單位資料", "", "images/nav_break.gif");
                    //i4.NavigateUrl = "~/HQ_ProfileMag.aspx";
                    //Menu1.Items.Add(i4);
                    MenuItem i4 = new MenuItem("重設密碼", "", "images/nav_break.gif");
                    i4.NavigateUrl = "~/HQ_ReSetPassword.aspx";
                    Menu1.Items.Add(i4);
                    MenuItem i5 = new MenuItem("相關連結", "", "images/nav_break.gif");
                    i5.NavigateUrl = "~/HQ_LinkRefMag.aspx";
                    Menu1.Items.Add(i5);
                    MenuItem i6 = new MenuItem("事件記錄檢視", "", "images/nav_break.gif");
                    i6.NavigateUrl = "~/HQ_LogView.aspx";
                    Menu1.Items.Add(i6);
                    MenuItem i8 = new MenuItem("文件區維護", "", "images/nav_break.gif");
                    i8.NavigateUrl = "~/HQ_FileManage.aspx";
                    Menu1.Items.Add(i8);
                    MenuItem i9 = new MenuItem("成績統計", "", "images/nav_break.gif");
                    i9.NavigateUrl = "~/Reporting.aspx";
                    Menu1.Items.Add(i9);
                    MenuItem i10 = new MenuItem("成績查詢", "", "images/nav_break.gif");
                    i10.NavigateUrl = "~/SearchScore.aspx";
                    Menu1.Items.Add(i10);
                    MenuItem i11 = new MenuItem("逾期處理", "", "images/nav_break.gif");
                    i11.NavigateUrl = "~/OverDue.aspx";
                    Menu1.Items.Add(i11);
                    MenuItem i7 = new MenuItem("設定個人資訊", "", "images/nav_break.gif");
                    i7.NavigateUrl = "~/Pro.aspx";
                    Menu1.Items.Add(i7);
                    MenuItem i12 = new MenuItem("刪除人工鑑測成績", "", "images/nav_break.gif");
                    i12.NavigateUrl = "~/DeleteArtificialScore.aspx";
                    Menu2.Items.Add(i12);
                    MenuItem i13 = new MenuItem("設定聯絡資訊", "", "images/nav_break.gif");
                    i13.NavigateUrl = "~/HQ_Contact.aspx";
                    Menu2.Items.Add(i13);
                    //108年維保新增
                    MenuItem i14 = new MenuItem("資料查詢及異動", "", "images/nav_break.gif");
                    i14.NavigateUrl = "~/108_Data_Update.aspx";
                    Menu2.Items.Add(i14);
                    
                }
                if (a.Role == ((int)SysSetting.Role.mag_hq).ToString())
                {
                    MenuItem i2 = new MenuItem("進階使用者", "", "images/nav_break.gif");
                    i2.NavigateUrl = "~/HQ_UserAccMag.aspx";
                    Menu1.Items.Add(i2);
                    MenuItem i4 = new MenuItem("批次帳號維護", "", "images/nav_break.gif");
                    i4.NavigateUrl = "~/BatchAccMag.aspx";
                    Menu1.Items.Add(i4);
                    MenuItem i6 = new MenuItem("團報管理者審核", "", "images/nav_break.gif");
                    i6.NavigateUrl = "~/CheckAdvancedUser.aspx";
                    Menu1.Items.Add(i6);
                    MenuItem i8 = new MenuItem("重設密碼", "", "images/nav_break.gif");
                    i8.NavigateUrl = "~/HQ_ReSetPassword.aspx";
                    Menu1.Items.Add(i8);
                    MenuItem i5 = new MenuItem("成績統計", "", "images/nav_break.gif");
                    i5.NavigateUrl = "~/Reporting.aspx";
                    Menu1.Items.Add(i5);
                    MenuItem i7 = new MenuItem("成績查詢", "", "images/nav_break.gif");
                    i7.NavigateUrl = "~/SearchScore.aspx";
                    Menu1.Items.Add(i7);
                    MenuItem i3 = new MenuItem("設定個人資訊", "", "images/nav_break.gif");
                    i3.NavigateUrl = "~/Pro.aspx";
                    Menu1.Items.Add(i3);
                    //暫時開啟
                    if (a.AccountName == "cola" | a.AccountName == "asz1330")
                    {
                        MenuItem i12 = new MenuItem("刪除人工鑑測成績", "", "images/nav_break.gif");
                        i12.NavigateUrl = "~/DeleteArtificialScore.aspx";
                        Menu1.Items.Add(i12);
                    }

                    /*
                    MenuItem i2 = new MenuItem("個人資料維護");
                    i2.NavigateUrl = "~/Pro.aspx";
                    Menu1.Items.Add(i2);*/
                }
                if (a.Role == ((int)SysSetting.Role.user_hg).ToString())
                {
                    foreach (KeyValuePair<string, string> item in a.OptionCode)
                    {
                        MenuItem i = new MenuItem(item.Key, "", "images/nav_break.gif");
                        i.NavigateUrl = "~/" + item.Value;
                        Menu1.Items.Add(i);
                        if (item.Key == "團體報進")
                        {
                            MenuItem i2 = new MenuItem("團體報進成績", "", "images/nav_break.gif");
                            i2.NavigateUrl = "~/TeamScore.aspx";
                            Menu1.Items.Add(i2);

                            MenuItem i3 = new MenuItem("成績查詢", "", "images/nav_break.gif");
                            i3.NavigateUrl = "~/SearchScore.aspx";
                            Menu1.Items.Add(i3);

                            MenuItem i4 = new MenuItem("成績統計", "", "images/nav_break.gif");
                            i4.NavigateUrl = "~/Reporting.aspx";
                            Menu1.Items.Add(i4);

                            MenuItem i5 = new MenuItem("生日查詢", "", "images/nav_break.gif");
                            i5.NavigateUrl = "~/HQ_ViewTeamPlayer.aspx";
                            Menu1.Items.Add(i5);
                        }
                    }
                    MenuItem i1 = new MenuItem("設定個人資訊", "", "images/nav_break.gif");
                    i1.NavigateUrl = "~/Pro.aspx";
                    Menu1.Items.Add(i1);
                }
            }
        }

        if (Session["player"] != null)
        {
            Lib.Player p = (Lib.Player)Session["player"];
            if (p.IsMustReSetPassword == true)
            {
                Session.Clear();
                Response.Redirect("~/Login.aspx");
            }
            OP_Value.Value = p.Name;
            userInfo.Text = "歡迎 " + p.ID + " 來到國軍基本體能鑑測網, <A style=\"COLOR: blue\" id=ctl00_logout href=\"Logout.aspx\">登出</A>" + " , 現在是中華民國 " + Lib.SysSetting.ToRocDateFormat(DateTime.Now.ToString("yyyy")) + " 年 " + DateTime.Now.Month.ToString() + " 月 " + DateTime.Now.Day.ToString() + " 日 " + Lib.SysSetting.ToRocWeekFormat(DateTime.Now.DayOfWeek);
            #region
            //DataUtility du = new DataUtility();
            //Dictionary<string, object> d = new Dictionary<string, object>();
            //DataTable dt = du.getDataTableByText("select * from RelatedLink");
            //if (Menu3.Items.Count == 0)
            //{
            //    for (int i = 0; i < dt.Rows.Count; i++)
            //    {
            //            MenuItem test = new MenuItem();
            //            test.ImageUrl = dt.Rows[i]["path"].ToString();
            //            test.NavigateUrl = dt.Rows[i]["url"].ToString();
            //            test.Target = "_blank";
            //            Menu3.Items.Add(test);                  
            //    }
            //}
            #endregion
            if (!Page.IsPostBack)
            {
                MenuItem i1 = new MenuItem("基本項目報進", "", "images/nav_break.gif");
                i1.NavigateUrl = "~/SelfReserver.aspx";
                Menu1.Items.Add(i1);
                MenuItem i8 = new MenuItem("替代項目報進", "", "images/nav_break.gif");
                i8.NavigateUrl = "~/ReplaceItemReserver.aspx";
                Menu1.Items.Add(i8);
                //MenuItem i9 = new MenuItem("申請補測報進", "", "images/nav_break.gif");
                //i9.NavigateUrl = "~/RepairTest.aspx";
                //Menu1.Items.Add(i9);
                MenuItem i6 = new MenuItem("個人成績", "", "images/nav_break.gif");
                i6.NavigateUrl = "~/SelfScore.aspx";
                Menu1.Items.Add(i6);
                MenuItem i2 = new MenuItem("意見區", "", "images/nav_break.gif");
                i2.NavigateUrl = "~/Suggestion.aspx";
                Menu1.Items.Add(i2);
                //MenuItem i3 = new MenuItem("討論區", "", "images/nav_break.gif");
                //i3.NavigateUrl = "~/Discussion.aspx";
                //Menu1.Items.Add(i3);
                MenuItem i7 = new MenuItem("設定個人資訊", "", "images/nav_break.gif");
                i7.NavigateUrl = "~/Pro_Player.aspx";
                Menu1.Items.Add(i7);
            }
        }
        if (Session["account"] == null && Session["player"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
    }

    protected void logOut_Click(object sender, EventArgs e)
    {
        if (Session["account"] != null || Session["player"] != null)
        {
            
            string userName = string.Empty;
            if (Session["account"] == null)
            {
                userName = ((Lib.Player)(Session["player"])).ID;
                SysSetting.AddLog("登入", userName, "一般受測人員登出成功", DateTime.Now);
            }
            else
            {
                userName = ((Lib.Account)(Session["account"])).ID;
                SysSetting.AddLog("登入", userName, "進階使用者登出成功", DateTime.Now);
            }
            
            Session.Clear();
            Response.Redirect("~/Login.aspx");

        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {

    }
}
