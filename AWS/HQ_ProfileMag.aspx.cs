using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using Lib;

public partial class HQ_ProfileMag : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Account a = (Account)Session["account"];
        if (a.Role != ((int)SysSetting.Role.admin_hq).ToString())
        {
            Response.Redirect("~/index.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            HttpPostedFile file = FileUpload1.PostedFile;
            StreamReader reader = new StreamReader(file.InputStream);
            while (reader.Peek() > 0)
            {
                var row = reader.ReadLine();
                string[] split = { "," };
                string[] info = row.Split(split, StringSplitOptions.None);
                if (info[0] != "unit_code")
                {
                    Dictionary<string, object> d = new Dictionary<string, object>();
                    d.Add("unit_code", info[0]);
                    d.Add("unit_title", info[1]);
                    d.Add("parent_unit_code", info[2]);
                    d.Add("service_code", info[3]);
                    list.Add(d);
                }
            }
            try
            {
                Lib.DataUtility du = new Lib.DataUtility();
                du.executeNonQueryByText("truncate table unit");
                du.executeNonQueryByText("insert into unit values (@unit_code,@unit_title,@parent_unit_code,@service_code)", list);
                du.executeNonQueryByText("update centerupdate set status = '0' where type = @type", "type", "unit");
                list.Clear();
                //Lib.SysSetting.Unit_Version = ((Lib.SysSetting.GetUnitVersion()) + 1).ToString();
                Lib.SysSetting.AddLog("系統", ((Lib.Account)(Session["account"])).AccountName, "單位代碼資料檔案上傳更新", DateTime.Now);
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert(\"" + ex.Message + "\");", true);
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
