<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewPassword.aspx.cs" Inherits="ReSetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>設定新密碼</title>
    <link id="Login_css" rel="stylesheet" href="resetpwmain.css" type="text/css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#txtPwd').blur(function () {
                var patten = /^(?=.*\d)(?=.*[a-z])(?=.*[\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\:\;\,\.\<\>\\\|\/\?\~\`\x22\x27]).{1,16}$/;
                if ($(this).val() != '') {
                    if ($(this).val().length < 8) {
                        //$(this).parent().next().html('密碼長度不夠');
                        $('#lbl_msg').html('密碼長度不夠');
                        $('#hidden_msg').val('密碼長度不夠');
                    }
                    else {
                        var valid = patten.test($(this).val());
                        if (!valid) {
                            //$(this).parent().next().html('密碼組合錯誤, 須包含英數字與特殊字元, 如@#$');
                            $('#lbl_msg').html('密碼組合錯誤, 須包含英數字與特殊字元, 如@#$');
                            $('#hidden_msg').val('密碼組合錯誤, 須包含英數字與特殊字元, 如@#$');
                        }
                        else {
                            // $(this).parent().next().html('');
                            $('#lbl_msg').html('');
                            $('#hidden_msg').val('');
                        }
                    }
                }
            });

            $('#txtPwd_Confirm').blur(function () {
                var patten = /^(?=.*\d)(?=.*[a-z])(?=.*[\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\:\;\,\.\<\>\\\|\/\?\~\`\x22\x27]).{1,16}$/;
                if ($(this).val() != '') {
                    if ($(this).val().length < 8) {
                        $('#lbl_msg_confirm').html('密碼長度不夠');
                        $('#hidden_msg_confirm').val('密碼長度不夠');
                    }
                    else {
                        var valid = patten.test($(this).val());
                        if (!valid) {
                            $('#lbl_msg_confirm').html('密碼組合錯誤, 須包含英數字與特殊字元, 如@#$');
                            $('#hidden_msg_confirm').val('密碼組合錯誤, 須包含英數字與特殊字元, 如@#$');
                        }
                        else {
                            $('#lbl_msg_confirm').html('');
                            $('#hidden_msg_confirm').val('');
                        }
                    }
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" method="post">
       <%-- <input id="hidden_msg_confirm" type="hidden" name="hidden_msg_confirm" />
        <input id="hidden_msg" type="hidden" name="hidden_msg" />--%>
        <input type="hidden" id="hidden_msg" name="hidden_msg" value="" />
        <input type="hidden" id="hidden_msg_confirm" name="hidden_msg_confirm" value="" />
       <%-- <asp:HiddenField ID="hidden_msg" runat="server"/>
        <asp:HiddenField ID="hidden_msg_confirm" runat="server"/>--%>
    <div class="content_left_div">
        <div class="content_left_top">
        &nbsp;&nbsp; 設定新密碼</div>
        <div class="content_left_bottom">
            <table>
                <tr>
                    <td class="td_left"></td>
                    <td class="td_right">
                       身分證字號 <asp:Label ID="User_ID" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td class="td_space_left">
                    </td>
                    <td class="td_space_right">
                    </td>
                </tr>
                <tr>
                    <td class="td_left">
                        <asp:Label ID="Label1" runat="server" Text="新密碼："></asp:Label>
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtPwd" runat="server" Height="19px" 
                            style="margin-left: 0px" Width="90%" TextMode="Password" MaxLength="16"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                        </td>
                    <td class="td_space_right">
                        <asp:Label ID="lbl_msg" runat="server" Text=""></asp:Label>
                        </td>
                </tr>
                <tr>
                    <td class="td_left">
                        <asp:Label ID="Label2" runat="server" Text="確認密碼："></asp:Label>
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtPwd_Confirm" runat="server" Height="19px" Width="90%" TextMode="Password" MaxLength="16"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">
                     <asp:Label ID="lbl_msg_confirm" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td class="td_left">
                        <asp:Label ID="Label4" runat="server" Text="Mail帳號："></asp:Label>
                    </td>
                    <td class="td_right">
                        <asp:TextBox ID="txtMail" runat="server" Height="19px" Width="90%" MaxLength="20"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">
                     <asp:Label ID="Label5" runat="server" Text="@webmail.mil.tw"></asp:Label></td>
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
                     </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">         
                     </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">         
                     </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">         
                     </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">         
                     </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">         
                     </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                    <td class="td_space_right">         
                     </td>
                </tr>
            </table>
            <div><li>密碼至少8個字元，至多16個字元。</li></div>
            <div><li>不能全為英文字母或全為數字。</li></div>
            <div><li>英文字母區分大小寫，例如A與a視為不同字母。</li></div>
            <div><li>密碼中不能包含空格。</li></div>
            <div><li>密碼須包含至少1個特殊字元(例如@#$等)。</li></div>
        </div>
    </div>       
    </form>
</body>
</html>
