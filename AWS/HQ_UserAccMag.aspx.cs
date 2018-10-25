using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class HQ_UserAccMag : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            who.Value = ((Lib.Account)Session["account"]).AccountName;
        }
        else
        {
            who.Value = ((Lib.Account)Session["account"]).AccountName;
        }
    }
    protected void button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            try
            {
                HttpPostedFile file = FileUpload1.PostedFile;
                StreamReader reader = new StreamReader(file.InputStream);
                DataTable dt = new DataTable();
                dt.Columns.Add("帳號");
                dt.Columns.Add("預設密碼");
                dt.Columns.Add("單位代碼");
                dt.Columns.Add("IP位址");
                dt.Columns.Add("處理狀態");
                while (reader.Peek() >= 0)
                {
                    string row = reader.ReadLine();
                    string[] split = { "," };
                    string[] info = row.Split(split, StringSplitOptions.None);
                    if (info[0] != "帳號")
                    {
                        DataRow _row = dt.NewRow();
                        _row["帳號"] = info[0];
                        _row["預設密碼"] = info[1];
                        _row["單位代碼"] = info[2];
                        _row["IP位址"] = info[3];
                        _row["處理狀態"] = ProcessResult(info, ((Lib.Account)Session["account"]).AccountName);
                        Lib.SysSetting.AddLog("帳號管理", ((Lib.Account)(Session["account"])).AccountName, "批次建立帳號，帳號名稱 : " + info[0], DateTime.Now);
                        dt.Rows.Add(_row);
                    }
                }
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('資料格式不符 , 請重新檢查');", true);
            }
        }
    }

    private static string ProcessResult(string[] info, string byAcc)
    {
        try
        {
            Lib.DataUtility du = new Lib.DataUtility();
            DataTable dt = du.getDataTableByText("select account from account where account = @acc", "acc", info[0]);
            Dictionary<string, object> d = new Dictionary<string, object>();
            if (dt.Rows.Count == 0)
            {
                d.Add("account", info[0]);
                d.Add("password", info[1]);
                d.Add("role_code", "3");
                d.Add("unit_code", info[2]);
                d.Add("ip", info[3]);
                d.Add("byacc", byAcc);
                du.executeNonQueryByText("insert into account (account, password, role_code, unit_code, ip, byacc) values (@account, @password, @role_code, @unit_code, @ip, @byacc)", d);
                du.executeNonQueryByText("insert into optioncode values (@acc,'1')", "acc", info[0]);
                return "新增成功";
            }
            else
            {
                return "帳號重複";
            }
        }
        catch (Exception ex)
        {
            Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, "HQ_UserAccMag.aspx");
            return ex.Message;
        }
    }
    public void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();
        Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
        Server.ClearError();
    }
}
