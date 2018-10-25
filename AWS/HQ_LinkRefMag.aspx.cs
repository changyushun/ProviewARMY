using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.IO;
using Lib;
public partial class HQ_LinkRefMag : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Account a = (Account)Session["account"];
        if (a.Role != ((int)SysSetting.Role.admin_hq).ToString())
        {
            Response.Redirect("~/index.aspx");
        }
    }

    protected void update_Click(object sender, EventArgs e)
    {
        Account a = (Account)Session["account"];
        if (a.Role == ((int)SysSetting.Role.admin_hq).ToString())
        {
            try
            {
                int index = GridView1.EditIndex;
                GridViewRow row = GridView1.Rows[index];
                FileUpload t = (FileUpload)row.FindControl("FileUpload1");
                TextBox turl = (TextBox)row.FindControl("url");
                HttpPostedFile file = t.PostedFile;
                
                if (t.HasFile && file.ContentLength < 524300 && Lib.SysSetting.IsImage(file)==true)
                {
                    string dd = Server.MapPath(Request.ApplicationPath);
                    Bitmap s = new Bitmap(file.InputStream, true);
                    int x, y;
                    string filename = (index + 1).ToString();
                    x = s.Width;
                    y = s.Height;
                    if (x == 160 && y == 40)
                    {
                        file.SaveAs(dd + "\\images\\Linkimage\\" + filename + ".jpg");
                        Lib.DataUtility du = new Lib.DataUtility();
                        Dictionary<string, object> d = new Dictionary<string, object>();
                        d.Add("sid", row.Cells[0].Text);
                        d.Add("url", turl.Text);
                        d.Add("path", "~/images/Linkimage/" + filename + ".jpg");
                        du.executeNonQueryBysp("updateRelatedLink", d);
                        Lib.SysSetting.AddLog("系統", ((Lib.Account)(Session["account"])).AccountName, "網站連接資料更新圖檔", DateTime.Now);
                        GridView1.DataBind();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('圖檔需符合(140 * 60)像素');", true);
                    }
                }
                else if (t.HasFile == false)
                {
                    Lib.DataUtility du = new Lib.DataUtility();
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    d.Add("sid", row.Cells[0].Text);
                    d.Add("url", turl.Text);
                    du.executeNonQueryByText("update RelatedLink set url = @url where sid = @sid", d);
                    Lib.SysSetting.AddLog("系統", ((Lib.Account)(Session["account"])).AccountName, "網站連接資料更新超連結", DateTime.Now);
                    GridView1.DataBind();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('系統只接受小於512KB的圖檔');", true);    
                }
            }
            catch (Exception ex)
            {
                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                Response.Redirect("~/Index.aspx");
            }
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
       
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }

}
