using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Security.Cryptography;

public partial class Default3 : System.Web.UI.Page
{
    MD5 s1 = MD5.Create();
    protected void Page_Load(object sender, EventArgs e)
    {

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
        if (CheckDateTimeType(TextBox6.Text) == true & !string.IsNullOrEmpty(TextBox6.Text))
        {
            if (!string.IsNullOrEmpty(TextBox1.Text) & TextBox1.Text.Length == 10)
            {
                string id = TextBox1.Text.ToUpper(); //身份證字號
                string sit_ups_score = TextBox2.Text;   //仰臥起座分數
                string push_ups_score = TextBox3.Text;  //付地挺身分數
                string run_score = TextBox4.Text;       //三千公尺分數
                string data = TextBox6.Text;            //鑑測日期
                string check_ID = TextBox7.Text.ToUpper(); //檢查碼前六碼
                string oldstring = id + sit_ups_score + push_ups_score + run_score + data; //原始字串
                byte[] Original = Encoding.ASCII.GetBytes(oldstring);
                byte[] Change = s1.ComputeHash(Original);
                string cs = ""; //解碼後的32碼字串
                TextBox5.Text = null;
                foreach (byte b in Change)//轉成32位元以ASCII輸出
                {
                    string s = b.ToString("X2");
                    TextBox5.Text += s;

                    cs += s;
                }
                if (check_ID == cs.Substring(0, 6))
                {
                    Label11.Text = "正確";
                }
                else
                {
                    Label11.Text = "錯誤";
                }
            }
            else
            {
                Label11.Text = "身份證欄位空白或長度未達10碼，請重新檢查";
            }
        }
        else
        {
            Label11.Text = "日期欄位空白或格式錯誤，請重新檢查";
        }
        
        
    }
}