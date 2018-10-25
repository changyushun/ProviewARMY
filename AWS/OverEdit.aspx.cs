using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OverEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Lib.DataUtility du = new Lib.DataUtility();
            DataTable dt = du.getDataTableByText("select name, gender, birth, unit_code,rank_code from player where id = @id", "id", Request.Params["id"]);
            lbName.Text = dt.Rows[0]["name"].ToString();
            gender.Value = dt.Rows[0]["gender"].ToString();
            birth.Value = dt.Rows[0]["birth"].ToString();
            unit_code.Value = dt.Rows[0]["unit_code"].ToString();
            rank_code.Value = dt.Rows[0]["rank_code"].ToString();
            dt.Clear();
            int year = DateTime.Now.Year;
            dt = du.getDataTableByText("select * from result where id = @id and date between '" + year.ToString() + "' and '" + (year + 1).ToString() + "'", "id", Request.Params["id"]);
            if (dt.Rows.Count == 0)
            {
                // 當年度沒有資料，可以輸入
                canEdit.Value = "true";


            }
            else if (dt.Rows.Count == 1)
            { 
                //當年度有資料，不能輸入，將資料顯現頁面
                canEdit.Value = "false";
                height.Text = dt.Rows[0]["height"].ToString();
                weight.Text = dt.Rows[0]["weight"].ToString();
                age.Text = dt.Rows[0]["age"].ToString();
                bmi.Text = dt.Rows[0]["BMI"].ToString();
                body.Text = dt.Rows[0]["bodyfat"].ToString();
                situp.Text = dt.Rows[0]["sit_ups"].ToString();
                situp_r.Text = dt.Rows[0]["sit_ups_score"].ToString();
                pushup.Text = dt.Rows[0]["push_ups"].ToString();
                pushup_r.Text = dt.Rows[0]["push_ups_score"].ToString();
                int _run = Convert.ToInt32(dt.Rows[0]["run"].ToString());
                string min = (_run / 60).ToString();
                string sec = (_run % 60).ToString();
                run.Text = min + ":" + sec;
                run_r.Text = dt.Rows[0]["run_score"].ToString();
                var v = dt.Rows[0]["status"].ToString();
                if (v == "203")
                {
                    ddl.SelectedValue = "0";
                }
                else
                {
                    ddl.SelectedValue = "1";
                }
            
            }
            
        }
        if (Page.IsPostBack)
        {
            if (!run.Text.Contains(":"))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('3000公尺秒數格式錯誤');", true);
            }
            else
            {
                Lib.DataUtility du = new Lib.DataUtility();
                Dictionary<string, object> d = new Dictionary<string,object>();
                string run_string = run.Text.Trim();
                int min = Convert.ToInt32(run_string.Substring(0, 2)) * 60;
                int sec = Convert.ToInt32(run_string.Substring(3, 2));

                d.Add("id", Request.Params["id"]);
                d.Add("name", lbName.Text);
                d.Add("age", Convert.ToInt32(age.Text.Trim()));
                d.Add("birth", Convert.ToDateTime(birth.Value));
                d.Add("gender", gender.Value);
                d.Add("unit_code", unit_code.Value);
                d.Add("rank_code", rank_code.Value);
                d.Add("height", Convert.ToDouble(height.Text.Trim()));
                d.Add("weight", Convert.ToDouble(weight.Text.Trim()));
                d.Add("BMI", Convert.ToDouble(bmi.Text.Trim()));
                d.Add("bodyfat", Convert.ToDouble(body.Text.Trim()));
                d.Add("sit_ups", Convert.ToInt32(situp.Text.Trim()));
                d.Add("sit_ups_score", Convert.ToInt32(situp_r.Text.Trim()));
                d.Add("push_ups", Convert.ToInt32(pushup.Text.Trim()));
                d.Add("push_ups_score", Convert.ToInt32(pushup_r.Text.Trim()));
                d.Add("run", (min + sec));
                d.Add("run_score", Convert.ToInt32(run_r.Text.Trim()));
                d.Add("date", DateTime.Now.Date);
                d.Add("center_code", "0");
                d.Add("status", (ddl.SelectedValue == "1" ? "202" : "203"));
                d.Add("op_id", ((Lib.Account)Session["account"]).AccountName);

                try
                {
                    du.executeNonQueryByText("insert into result (id,name,age,birth,gender,unit_code,rank_code,height,weight,BMI,bodyfat,sit_ups,sit_ups_score,push_ups,push_ups_score,run,run_score,date,center_code,status,op_id) values (@id,@name,@age,@birth,@gender,@unit_code,@rank_code,@height,@weight,@BMI,@bodyfat,@sit_ups,@sit_ups_score,@push_ups,@push_ups_score,@run,@run_score,@date,@center_code,@status,@op_id)", d);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('作業成功');", true);
                    canEdit.Value = "false";
                }
                catch (Exception ex)
                {
                    Lib.SysSetting.ExceptionLog(ex.GetType().ToString(), ex.Message, this.ToString());
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "alert('" + ex.Message + "');", true);
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
