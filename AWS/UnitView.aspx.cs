using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UnitView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Dictionary<string, Lib.Unit> units = new Dictionary<string, Lib.Unit>();
            Lib.UnitTree tree = new Lib.UnitTree();
            Lib.Unit army = tree.GetUnitWithChild("10001");
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
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Menu1.Items.Clear();
        Dictionary<string, Lib.Unit> units = new Dictionary<string, Lib.Unit>();
        Lib.UnitTree tree = new Lib.UnitTree();
        Lib.Unit army = tree.GetUnitWithChild(unit_code.Text.Trim());
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
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
