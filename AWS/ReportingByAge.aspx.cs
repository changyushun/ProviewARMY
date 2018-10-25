using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ReportingByAge : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["account"] != null)
            {
                Lib.Account acc = (Lib.Account)Session["account"];
                account.Value = acc.AccountName;
                #region 選單製作
                Lib.UnitTree tree = new Lib.UnitTree();
                Lib.Unit army = tree.GetUnitWithChild(acc.Unit_Code);
                MenuItem selfItem = new MenuItem();
                selfItem.Text = acc.Unit;
                selfItem.Value = acc.Unit_Code;
                Menu1.Items.Add(selfItem);
                if (army != null)
                {
                    if (army.ChildUnit != null)
                    {
                        foreach (KeyValuePair<string, Lib.Unit> child in army.ChildUnit)
                        {
                            MenuItem item = new MenuItem();
                            item.Text = ((Lib.Unit)child.Value).Unit_Title;
                            item.Value = ((Lib.Unit)child.Value).Unit_Code;
                            Menu1.Items.Add(item);
                            if (((Lib.Unit)child.Value).ChildUnit != null)
                            {
                                foreach (KeyValuePair<string, Lib.Unit> child_d in ((Lib.Unit)child.Value).ChildUnit)
                                {
                                    MenuItem item2 = new MenuItem();
                                    item2.Text = ((Lib.Unit)child_d.Value).Unit_Title;
                                    item2.Value = ((Lib.Unit)child_d.Value).Unit_Code;
                                    item.ChildItems.Add(item2);
                                    if (((Lib.Unit)child_d.Value).ChildUnit != null)
                                    {
                                        foreach (KeyValuePair<string, Lib.Unit> child_d_d in ((Lib.Unit)child_d.Value).ChildUnit)
                                        {
                                            MenuItem item3 = new MenuItem();
                                            item3.Text = ((Lib.Unit)child_d_d.Value).Unit_Title;
                                            item3.Value = ((Lib.Unit)child_d_d.Value).Unit_Code;
                                            item2.ChildItems.Add(item3);
                                            if (((Lib.Unit)child_d_d.Value).ChildUnit != null)
                                            {
                                                foreach (KeyValuePair<string, Lib.Unit> child_d_d_d in ((Lib.Unit)child_d_d.Value).ChildUnit)
                                                {
                                                    MenuItem item4 = new MenuItem();
                                                    item4.Text = ((Lib.Unit)child_d_d_d.Value).Unit_Title;
                                                    item4.Value = ((Lib.Unit)child_d_d_d.Value).Unit_Code;
                                                    item3.ChildItems.Add(item4);
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }
                }
                #endregion

                // 設定預設日期
                date_start.Value = (DateTime.Now.Year - 1911).ToString() + "/1/1";
                date_stop.Value = (DateTime.Now.Year - 1911).ToString() + "/12/31";

            }
        }
    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        if (Session["units"] == null)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("單位名稱");
            dt.Columns.Add("單位代碼");
            DataRow row = dt.NewRow();
            row[0] = Menu1.SelectedItem.Text;
            row[1] = Menu1.SelectedValue;
            dt.Rows.Add(row);
            Session["units"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            DataTable dt = (DataTable)Session["units"];
            DataRow row = dt.NewRow();
            row[0] = Menu1.SelectedItem.Text;
            row[1] = Menu1.SelectedValue;
            dt.Rows.Add(row);
            Session["units"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["units"] != null)
        {
            DataTable dt = (DataTable)Session["units"];
            dt.Rows.Clear();
            Session["units"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
