﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="AdminLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table>
    <tr>
    <td>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
    <td>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </td>
    <td>
        <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
