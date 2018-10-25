<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddDiscussion.aspx.cs" Inherits="AddDiscussion" ValidateRequest="false" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <span>討論主題</span><br />
    <asp:TextBox ID="head" runat="server" Width="590px"></asp:TextBox><br />
    <span>內文</span><br />
    <FTB:FreeTextBox ID="FTB_text" runat="server"></FTB:FreeTextBox><br />
    <asp:Button ID="confirm" runat="server" Text="確定" onclick="confirm_Click" />
    </div>
    </form>
</body>
</html>
