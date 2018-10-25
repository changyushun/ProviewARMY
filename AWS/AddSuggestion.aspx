<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddSuggestion.aspx.cs" Inherits="AddSuggestion" ValidateRequest="false" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <span>意見主旨</span><br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
    <span>意見內容</span><br />
    <FTB:FreeTextBox ID="FTB" runat="server">
    </FTB:FreeTextBox><br />
        <asp:Button ID="Button1" runat="server" Text="確定" onclick="Button1_Click" />
    </div>
    </form>
</body>
</html>
