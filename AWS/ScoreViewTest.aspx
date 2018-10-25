<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ScoreViewTest.aspx.cs" Inherits="ScoreView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            margin-left: 7px;
            margin-bottom:15px;
        }
        .auto-style2 {
            margin-left: 26px;
        }
        .auto-style3 {
            width: 700px;
            margin-left: 13px;
        }
        .auto-style4 {
            height: 34%;
            width: 100%;
        }
    </style>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
     <script type="text/javascript">
         $(document).keydown(function (e) {
             // ESCAPE key pressed
             if (e.keyCode == 27) {
                 window.close();
             }
         });

         function toPrint() {
             document.getElementById("PrintScoreTable").style.display = 'none';
             window.print();
             document.getElementById("PrintScoreTable").style.display = '';
         }
    </script>
</head>
<body>
    <form id="form1" runat="server" style="padding-left:5%; border:thin none #000000; background-image:url('images/logo3.bmp'); background-position:center;background-repeat: no-repeat;  font-family: 標楷體; " class="auto-style3">
    <div>
    <input id="PrintScoreTable" type="button" value="列印成績單" onclick="toPrint()" />   
    <div style="text-align:center; font-size:0.8cm; font-weight:bold; padding-top:3%">國軍體能鑑測中心</div>   
    <div style="text-align:center; font-size:0.8cm; font-weight:bold"><label id="LB_CenterName" runat="server"></label></div>
    <div style="font-size: large; font-weight:bold; padding-left:60%; padding-top:2%"><label id="LB_Date" runat="server"></label></div>
    <div style="font-size: large; font-weight:bold; padding-left:60%; padding-bottom:0%"><label id="LB_Date_Re" runat="server">
        <br />
        </label></div>
    <%--<div style="font-size: large; font-weight:bold; padding-left:60%; padding-bottom:10%"><label id="LB_Date_Re" runat="server"></label></div>--%>
    </div>
    <div style=" height: 533px; width: 607px; font-family: 標楷體; font-size: large; font-weight:bold">
        <table class="auto-style4">
            <tbody>
                <tr>
                    <td colspan="2" style="height:20%">單位：<label id="LB_Unit" runat="server"></label></td>
                </tr>
                <tr>
                    <td  style="height:20%">級職：<label id="LB_Rank" runat="server"></label></td>
                    <td  style="height:20%">姓名：<label id="LB_Name" runat="server"></label></td>
                </tr>
                 <tr>
                    <td  style="height:20%">生日：<label id="LB_BirthAge" runat="server"></label></td>
                    <td  style="height:20%">身份證字號：<label id="LB_Id" runat="server"></label></td>
                </tr>
                 <tr>
                    <td  style="height:20%">BMI：<label id="LB_BMI" runat="server"></label></td>
                    <td  style="height:20%">體脂率：<label id="LB_BodyFat" runat="server"></label></td>
                </tr>
                <tr>
                    <td colspan="2"  style="height:20%"><label id="LB_Message" runat="server"></label></td>
                </tr>
            </tbody>
        </table>
        <table class="table_2" 
            style="border: thin solid #000000; height: 40%; width: 100%; text-align:center" >
            <tbody>
                <tr>
                    <td class="table_td">項目</td>
                    <td class="table_td">次數/時間</td>
                    <td class="table_td">成績</td>
                    <td class="table_td">判定</td>
                </tr>   
                <tr>
                    <td class="table_td"><label id="LB_Situps_Name" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Count" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Score" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Status" runat="server"></label></td></td>
                </tr>
                <tr>
                    <td class="table_td"><label id="LB_Pushups_Name" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Pushups_Count" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Pushups_Score" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Pushups_Status" runat="server"></label></td>
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

    <div style="width: 607px; font-family: 標楷體; font-size: large; font-weight:bold;">
    <table style="width:100%; ">
        <tbody>
            <tr>
                <td style="vertical-align:top; " class="style2">
                    <br />
                    <br />
                    <br />
                    總評：<label id="LB_TotalStatus" runat="server"></label></td>
                <td style="vertical-align:top; text-align: right" class="style3">鑑測官簽章：</td>
                 <td class="style4">
                    <%--<div style="border:1px solid #000000"></div>--%>
                    <table class="table_div" style="width:100%; height:75px"><tbody><tr class="table_div_tr">
                <td class="style1" style="text-align:center">
                    &nbsp;<br />
                    <asp:Image ID="Image1" runat="server" Height="40px" Width="125px" 
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
                    <asp:Image ID="Image2" runat="server" Height="40px" Width="125px" 
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
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="檢查碼：" Visible="False"></asp:Label>
        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Large" Visible="False"></asp:Label>
    </form>
</body>
</html>
