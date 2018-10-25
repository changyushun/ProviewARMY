<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InqData.aspx.cs" Inherits="InqData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" Text="DB時間："></asp:Label>
    
    </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢DB時間" />
        <p>
            <asp:Label ID="Label2" runat="server" Text="WEB時間："></asp:Label>
        </p>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="查詢WEB時間" />
    </form>
</body>
</html>
