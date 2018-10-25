<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OverEdit.aspx.cs" Inherits="OverEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function() {
            var isOK = false;
            if ($('#canEdit').val() == 'false') {
                $('#confirm').attr({ style: 'disabled:disabled' });
            }
            $('#confirm').click(function() {
                if ($('#canEdit').val() == 'true') {
                    $(':text').each(function() {
                        if ($(this).val() == '') {
                            isOK = false;
                        }
                        else {
                            isOK = true;
                        }
                    });
                    if (isOK == true) {
                        $('#form1')[0].submit();
                    }
                    else {
                        alert('資料未完整');
                    }
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="canEdit" runat="server" />
        <asp:HiddenField ID="gender" runat="server" />
        <asp:HiddenField ID="birth" runat="server" />
        <asp:HiddenField ID="name" runat="server" />
        <asp:HiddenField ID="unit_code" runat="server" />
        <asp:HiddenField ID="rank_code" runat="server" />
        <table style="border:solid 2px black;background-color:#66FFCC">
        <thead>
        <tr>
        <th colspan="2">海外人員成績維護</th>
        </tr>
        <tr>
        <th>姓名</th>
        <th>
            <asp:Label ID="lbName" runat="server" Text=""></asp:Label></th>
        </tr>
        </thead>
            <tbody>
                <tr>
                    <td>
                        身高
                    </td>
                    <td>
                        <asp:TextBox ID="height" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        體重
                    </td>
                    <td>
                        <asp:TextBox ID="weight" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        年齡
                    </td>
                    <td>
                        <asp:TextBox ID="age" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        BMI
                    </td>
                    <td>
                        <asp:TextBox ID="bmi" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        體脂率
                    </td>
                    <td>
                        <asp:TextBox ID="body" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        仰臥起坐(次)
                    </td>
                    <td>
                        <asp:TextBox ID="situp" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        仰臥起坐(分數)
                    </td>
                    <td>
                        <asp:TextBox ID="situp_r" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        俯地挺身(次)
                    </td>
                    <td>
                        <asp:TextBox ID="pushup" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        俯地挺身(分數)
                    </td>
                    <td>
                        <asp:TextBox ID="pushup_r" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        3000公尺(mm:ss)
                    </td>
                    <td>
                        <asp:TextBox ID="run" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        3000公尺(分數)
                    </td>
                    <td>
                        <asp:TextBox ID="run_r" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        總評()
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl" runat="server">
                        <asp:ListItem Text="合格" Value="1"></asp:ListItem>
                        <asp:ListItem Text="不合格" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                <td colspan="2" align="right">
                <input type="button" id="confirm" value="確認" />
                </td>
                
                </tr>
            </tbody>
        </table>
    </div>
    </form>
</body>
</html>
