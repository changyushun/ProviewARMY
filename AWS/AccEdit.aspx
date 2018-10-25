<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccEdit.aspx.cs" Inherits="AccEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color:#FFF8DC">
    <form id="form1" runat="server">
    <div>
    <table style="background-color:#7FFFD4;border:solid 1px black">
    <tr>
    <td>帳號</td><td><asp:TextBox ID="acc" runat="server" Enabled="False"></asp:TextBox></td>
    </tr>
    <tr><td>密碼</td><td>
        <asp:TextBox ID="pwd" runat="server"></asp:TextBox></td></tr>
    <tr><td>姓名</td><td><asp:TextBox ID="name" runat="server"></asp:TextBox></td></tr>
    <tr><td>身份字號</td><td><asp:TextBox ID="id" runat="server"></asp:TextBox></td></tr>
    <tr><td>單位代碼</td><td><asp:TextBox ID="unit_code" runat="server" Enabled="false"></asp:TextBox></td></tr>
    <tr><td>級職代碼</td><td><asp:TextBox ID="rank_code" runat="server"></asp:TextBox></td></tr>
    <tr><td>電話號碼</td><td><asp:TextBox ID="tel" runat="server"></asp:TextBox></td></tr>
    <tr><td>行動電話</td><td><asp:TextBox ID="cell" runat="server"></asp:TextBox></td></tr>
    <tr><td>電子郵件</td><td><asp:TextBox ID="email" runat="server"></asp:TextBox></td></tr>
    <tr><td>IP位址</td><td><asp:TextBox ID="ip" runat="server"></asp:TextBox></td></tr>
    <tr>
    <td colspan="2">
    <table>
    <tr>
    <td>
        <asp:CheckBoxList ID="CheckBoxList1" runat="server">
            <asp:ListItem Value="1">團報功能</asp:ListItem>
            <asp:ListItem Value="2">最新消息管理</asp:ListItem>
            <asp:ListItem Value="3">意見管理</asp:ListItem>
            <asp:ListItem Value="4">討論區管理</asp:ListItem>
            <asp:ListItem Value="5">鑑測站資訊管理</asp:ListItem>
        </asp:CheckBoxList>
    </td>
    </tr>
    <tr>
    <td>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="更新資料" />
        <asp:Button
            ID="Button2" runat="server" Text="刪除帳號" onclick="Button2_Click" />
        </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    
    </div>
    </form>
</body>
</html>
