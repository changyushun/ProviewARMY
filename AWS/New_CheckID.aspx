<%@ Page Language="C#" AutoEventWireup="true" CodeFile="New_CheckID.aspx.cs" Inherits="Protal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <link id="Login_css" rel="stylesheet" href="main.css" type="text/css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
	<style type="text/css">
        .table_td
        {
            width: 25%;
            border:1px solid #000000
        }
        .table_2
        {
           border-collapse:collapse
        }
        .table_2_tr
        {    
            border:1px solid #000000
        }
        .table_div
        {
            border-collapse:collapse
        }
        .table_div_tr
        {
             border:1px solid #000000
        }
        .table_div_td
        {
           border:1px solid #000000
        } 
        .style1
        {
            border: 1px solid #000000;
            width: 12px;
        }
        .style2
        {
            width: 20%;
            height: 79px;
        }
        .style3
        {
            width: 50%;
            height: 79px;
        }
        .style4
        {
            width: 30%;
            height: 79px;
        }
        .auto-style1 {
            margin-left: 5px;
            margin-bottom:13px;
        }
        .auto-style2 {
            margin-left: 13px;
        }
        .auto-style3 {
            width: 25%;
            border: 1px solid #000000;
            height: 39px;
        }
    </style>
    
    
    <title>國軍基本體能鑑測網</title>
</head>
<body>
<center>
    <form id="form2" runat="server" submitdisabledcontrols="False">
    <div class="head_back_index">
    <a href="Protal.aspx" style="color:#0000FF">&nbsp;: : : 回首頁</a> | <a href="Login.aspx" style="color:#0000FF">登入</a> | <a href="New_CheckID.aspx" style="color:#0000FF">成績單驗證</a> |
    </div>
    <div class="head_space_div"> 
    </div>
    <div class="head_div">  
        &nbsp;: : : 現在位置﹥首頁
    </div>
        
    </form>
    </center>
    <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Overline="False" Font-Size="X-Large" ForeColor="Blue" Text="網路成績單驗證" Font-Underline="True" Font-Names="標楷體"></asp:Label>
    </p>
    <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label2" runat="server" Font-Size="Large" Text="身份證字號：" Font-Bold="True" Font-Names="標楷體"></asp:Label>
<asp:TextBox ID="TextBox1" runat="server" Font-Size="Large" Font-Names="標楷體"></asp:TextBox>
    </p>
    <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label3" runat="server" Font-Size="Large" Text="鑑測日期：" Font-Bold="True" Font-Names="標楷體"></asp:Label>
&nbsp;&nbsp;
<asp:TextBox ID="TextBox2" runat="server" Font-Size="Large" Font-Names="標楷體"></asp:TextBox>
    </p>
    <p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" OnClick="Button1_Click" Text="查詢成績" Font-Names="標楷體" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" Text="鑑測地點："></asp:Label>
    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large"></asp:Label>
    </p>
    <p>
        &nbsp;</p>
    <div style="padding-left:11%; border:thin none #000000; background-image:url('images/logo.bmp'); background-position:center ;background-repeat: no-repeat; height: 160px; width: 607px; font-family: 標楷體; font-size: large; font-weight:bold">
       
        <table class="table_2" 
            style="border: thin solid #000000; height: 100%; width: 100%; text-align:center" >
            <tbody>
                <tr>
                    <td class="auto-style3">項目</td>
                    <td class="auto-style3">次數/時間</td>
                    <td class="auto-style3">成績</td>
                    <td class="auto-style3">判定</td>
                </tr>   
                <tr>
                    <td class="table_td"><label id="LB_Situps_Name" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Count" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Score" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Status" runat="server"></label></td></td>
                </tr>
                <tr>
                    <td class="auto-style3"><label id="LB_Pushups_Name" runat="server"></label></td>
                    <td class="auto-style3"><label id="LB_Pushups_Count" runat="server"></label></td>
                    <td class="auto-style3"><label id="LB_Pushups_Score" runat="server"></label></td>
                    <td class="auto-style3"><label id="LB_Pushups_Status" runat="server"></label></td>
                </tr>
                <tr>
                    <td class="table_td"><label id="LB_Run_Name" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Run_Count" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Run_Score" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Run_Status" runat="server"></label></td>
                </tr>         
            </tbody>
        </table>
    </div>

    <div style="padding-left:11%; width: 607px; font-family: 標楷體; font-size: large; font-weight:bold; background-image:url('images/logo.bmp'); background-position:right; background-repeat:no-repeat;background-size: 200px;">
    <table style="width:100%; ">
        <tbody>
            <tr>
                <td style="vertical-align:top; background-image:url('images/logo.bmp'); background-position:right; background-repeat:no-repeat;background-size: 100px;" class="style2">總評：<label id="LB_TotalStatus" runat="server"></label></td>
                <td style="vertical-align:top; text-align: right" class="style3">鑑測官簽章：</td>
                 <td class="style4">
                    <%--<div style="border:1px solid #000000"></div>--%>
                    <table class="table_div" style="width:100%; height:75px"><tbody><tr class="table_div_tr">
                <td class="style1" style="text-align:center">
                    &nbsp;<br />
                    <asp:Image ID="Image1" runat="server" Height="40px" Width="150px" 
                        ImageUrl="~/images/sign2.jpg" ImageAlign="Middle" CssClass="auto-style1"/>
                        </td></tr></tbody></table>
                </td>
            </tr>
            <tr>
                <td style="width:20%; vertical-align:top"></td>
                <td style="width:50%; vertical-align:top; text-align: right; padding-top:6%">鑑測站主任簽章：</td>
                 <td style="width:30%; padding-top:6%">
                    <%--<div style="border:1px solid #000000"></div>--%>
                    <table class="table_div" style="width:100%; height:75px"><tbody><tr class="table_div_tr">
                    <td class="style1">
                    <asp:Image ID="Image2" runat="server" Height="40px" Width="150px" 
                        ImageUrl="~/images/sign1.jpg" CssClass="auto-style2" />
                        </td></tr></tbody></table>
                </td>
            </tr>
            <%--<tr>
                <td colspan="3" style="padding-top:20px; text-align:right; font-family:Arial">檢查碼 582167c4675f496920150b30cc423cf2</td>

            </tr>--%>
        </tbody>
    </table>
    </div>
</body>
</html>
