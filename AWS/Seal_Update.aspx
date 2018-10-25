<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Seal_Update.aspx.cs" Inherits="Seal_Update" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <div>
    
        <asp:Panel ID="Panel1" runat="server">
            
            <asp:Label ID="Label1b" runat="server" Font-Names="標楷體" Font-Size="XX-Large" Text="鑑測站簽章維護：" Font-Bold="True" ForeColor="Blue"></asp:Label>
            <asp:Label ID="Label2b" runat="server" Font-Names="標楷體" Font-Size="X-Large"></asp:Label>
            
            <br />
            <br />
            
            <br />
            <br />
            
            <div style="background-color:#82FF82 ;border-style:double;">
            <br />
            <br />
            <asp:Label ID="Label3b" runat="server" Font-Names="標楷體" Font-Size="Large">鑑測官簽章：</asp:Label>
            <asp:Image ID="Image1b" runat="server" Height="40px" Width="150px" />
&nbsp;<asp:Label ID="Label7b" runat="server" Font-Names="標楷體" Font-Size="Large"></asp:Label>
            <br />
            <br />
            <br />
            <asp:Label ID="Label5b" runat="server" Font-Names="標楷體" Font-Size="Large">鑑測官簽章上傳：</asp:Label>
            <br />
            <asp:FileUpload ID="FileUpload1b" runat="server" Font-Names="標楷體" Font-Size="Large" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2b" runat="server" Font-Names="標楷體" Font-Size="Large" Height="28px" Text="上傳更新" />
            <br />
            <br />
            <br />
                </div>
            <br />
            <br />
            <br />
            <div style="background-color:#30FFFF ;border-style:double;">
            <br />
            <br />
            <asp:Label ID="Label4b" runat="server" Font-Names="標楷體" Font-Size="Large">鑑測主任簽章：</asp:Label>
            <asp:Image ID="Image2b" runat="server" Height="40px" Width="150px" />
&nbsp;<asp:Label ID="Label8b" runat="server" Font-Names="標楷體" Font-Size="Large"></asp:Label>
            <br />
            <br />
            <br />
            <asp:Label ID="Label6b" runat="server" Font-Names="標楷體" Font-Size="Large">鑑測主任簽章上傳：</asp:Label>
            <br />
            <asp:FileUpload ID="FileUpload2b" runat="server" Font-Names="標楷體" Font-Size="Large" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button3b" runat="server" Font-Names="標楷體" Font-Size="Large" Height="28px" Text="上傳更新" />
                <br />
                <br />
                <br />
                </div>
        </asp:Panel>
    
    </div>
    </form>
</body>
</html>
