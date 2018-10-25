<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditSuggestion.aspx.cs" Inherits="EditSuggestion" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div>
    <asp:Label ID="lbhead" runat="server"></asp:Label><br />
    <FTB:FreeTextBox ID="FTB_Text" runat="server"></FTB:FreeTextBox><br />
    <asp:Label ID="Label1" runat="server" Text="鑑測站回覆:"></asp:Label><br />
    <FTB:FreeTextBox ID="FTB_Answer" runat="server"></FTB:FreeTextBox><br />
    <asp:Label ID="Label2" runat="server" Text="司令部回覆:"></asp:Label><br />
    <FTB:FreeTextBox ID="FTB_Answer_2" runat="server"></FTB:FreeTextBox><br />
    <asp:Label ID="Label3" runat="server" Text="國防部回覆:"></asp:Label><br />
    <FTB:FreeTextBox ID="FTB_Answer_3" runat="server"></FTB:FreeTextBox><br />
    <table>
    <tr>
    <td style="width:514px">
    <asp:DropDownList ID="status" runat="server">
    <asp:ListItem Text="顯示" Value="1"></asp:ListItem>
    <asp:ListItem Text="隱藏" Value="0"></asp:ListItem>
    </asp:DropDownList>
    </td>
    <td>
    <asp:Button ID="confirm" runat="server" Text="確定回覆" onclick="confirm_Click" />
    </td>
    </tr>
    </table>
    
    </div>
    </div>
    </form>
</body>
</html>
