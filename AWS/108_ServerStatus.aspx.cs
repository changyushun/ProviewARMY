using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _108_ServerStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_PingIp_Click(object sender, EventArgs e)
    {
        string ip = txb_Ip.Text;
        //if (ByPing(ip))
        //    lab_pingIpResult.Text = "成功";
        //else
        //    lab_pingIpResult.Text = "失敗";
        lab_pingIpResult.Text = GetIPConfigReturns();
    }
    public bool ByPing(string ip)
    {
        IPAddress tIP = IPAddress.Parse(ip);
        Ping tPingControl = new Ping();
        PingReply tReply = tPingControl.Send(tIP);
        tPingControl.Dispose();
        if (tReply.Status != IPStatus.Success)
            return false;
        else
            return true;
    }
    public static string GetIPConfigReturns()
    {
        string version = System.Environment.OSVersion.VersionString;

        if (version.Contains("Windows"))
        {
            //调用ipconfig ,并传入参数: /all
            System.Diagnostics.ProcessStartInfo psi = new System.Diagnostics.ProcessStartInfo("ipconfig", "");

            psi.CreateNoWindow = true; //若为false，则会出现cmd的黑窗体
            psi.RedirectStandardOutput = true;
            psi.UseShellExecute = false;

            System.Diagnostics.Process p = System.Diagnostics.Process.Start(psi);

            return p.StandardOutput.ReadToEnd();
        }

        return string.Empty;
    }
}