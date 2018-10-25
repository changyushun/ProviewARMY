<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPRenew.aspx.cs" Inherits="IPRenew" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table>
    <tbody>
    <tr>
    <td>原始IP</td><td><input type="text" runat="server" id="oldip" disabled="disabled" /></td>
    </tr>
    <tr>
    <td>申請IP</td><td><input type="text" runat="server" id="newip" /></td>
    </tr>
    <tr>
    <td></td><td><asp:Button runat="server" ID="confirm" Text="確定" 
            onclick="confirm_Click" /></td>
    </tr>
    </tbody>
    </table>
    </div>
    </form>
</body>
</html>
