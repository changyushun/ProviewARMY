<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReSetpw.aspx.cs" Inherits="ReSetpw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>登入</title>
    <link id="Login_css" rel="stylesheet" href="resetpwmain.css" type="text/css" />
    <style type="text/css">
        #Submit2
        {
            width: 98px;
        }
    </style>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#loginType').click(function() {
                var type = $('select option:selected').val();
                if (type == "user") {
                    $('#Label1').html('身分證號 : ');
                    $('#Label2').html('出生年月日(民國) : ');
                    $('#Label3').html('例:民國72年2月29號, 格式為72/2/29');
                    $('#HyperLink1').hide();
                }
                if (type == "advance") {
                    $('#Label1').html('帳號 : ');
                    $('#Label2').html('密碼 : ');
                    $('#Label3').html('');
                    $('#HyperLink1').show();
                }

            });

        });
    </script>
    
</head>
<body>
<center>
    <form id="form1" runat="server" submitdisabledcontrols="False">
    <div class="head_back_index">
    <a href="index.aspx" style="color:#0000FF">&nbsp;: : : 回首頁</a>
    </div>
    <div class="head_space_div"> 
    </div>
    <div class="head_div">  
        &nbsp;: : : 現在位置﹥忘記密碼
    </div>
    <div class="content_div">
    <div class="content_left_div">
        <div class="content_left_top">
        &nbsp;&nbsp; 進階使用者 重新設定密碼</div>
        <div class="content_left_bottom">
            <table>
                <tr>
                    <td class="td_left_one" colspan="2">
                        請先輸入您的帳號和電子郵件地址，系統將會寄送新密碼至您的個人信箱。</td>
                </tr>
               <%-- <tr>
                    <td class="td_space_left">
                    </td>
                    <td class="td_space_right">
                    </td>
                </tr>--%>
                <tr>
                    <td class="td_left">
                        <asp:Label ID="Label1" runat="server" Text="帳號："></asp:Label>
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtName" runat="server" Height="19px" 
                            style="margin-left: 0px" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                        </td>
                    <td class="td_space_right">
                        </td>
                </tr>
                <tr>
                    <td class="td_left">
                        <asp:Label ID="Label2" runat="server" Text="E-mail："></asp:Label>
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtPwd" runat="server" Height="19px" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">
                     <asp:Label ID="Label3" runat="server" Text="@webmail.mil.tw"></asp:Label></td>
                </tr>
                <tr>
                    <td class="td_left">
                    </td>
                    <td class="td_right">
                        <asp:Button ID="submit" runat="server" Text="確認" onclick="submit_Click" />
                        </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">         
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/ReSetpw.aspx" ForeColor="#0000FF">忘記密碼？</asp:HyperLink>
                     </td>
                </tr>
            </table>
        </div>
    </div>
   
    <div class="content_right_div">
        <div class="content_right_top">
        &nbsp; 註冊&nbsp; 成為體能鑑測中心使用者</div>
        <div class="content_right_bottom">
            <table style="width:100%;">
                <tr>
                    <td class="td_right_registry">
                        <ul>
                            <li>一般受測人員請申請受測人員帳號，才可使用個人報進完成鑑測報名程序。</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <button onclick="javascript:window.location.href=('RegUser.aspx');return false">註冊</button></td>
                </tr>
                <tr>
                    <td class="td_right_registry">
                        <ul>
                            <li>各單位負責團體報進人員，請申請成為進階使用者，才可使用團體報進完成鑑測報名程序。</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <button onclick="javascript:window.location.href=('RegAdvancedUser.aspx');return false">申請</button></td>
                </tr>
            </table>
        </div>
    </div>
    </div>
    </form>
    </center>
</body>
</html>
