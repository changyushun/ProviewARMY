<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Check_Md5.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<body>--%>
    <%--<form id="form1" runat="server">--%>
        <asp:Label ID="Label1" runat="server" Font-Size="XX-Large" ForeColor="#000099" Text="網路成績單驗證："></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label7" runat="server" Font-Size="Large" Text="鑑測日期："></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox6" runat="server" Font-Size="Large" ></asp:TextBox>
        <asp:Label ID="Label8" runat="server" Font-Size="Large" Text="(輸入格式&quot;年月日&quot;：101/01/31)"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Font-Size="Large" Text="身份證字號："></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox1" runat="server" Font-Size="Large" style="TEXT-TRANSFORM:   uppercase" MaxLength="10"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Font-Size="Large" Text="仰臥起坐成績："></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server" Font-Size="Large" MaxLength="3" ></asp:TextBox>
        <asp:Label ID="Label12" runat="server" Font-Size="Large" Text="(若採替代項目則保持空白)"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Font-Size="Large" Text="俯地挺身成績："></asp:Label>
        <asp:TextBox ID="TextBox3" runat="server" Font-Size="Large" MaxLength="3"></asp:TextBox>
        <asp:Label ID="Label13" runat="server" Font-Size="Large" Text="(若採替代項目則保持空白)"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Font-Size="Large" Text="三千公尺成績："></asp:Label>
        <asp:TextBox ID="TextBox4" runat="server" Font-Size="Large" MaxLength="3"></asp:TextBox>
        <asp:Label ID="Label14" runat="server" Font-Size="Large" Text="(若採替代項目則保持空白)"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label9" runat="server" Font-Size="Large" Text="檢查碼前六碼：" ForeColor="Blue"></asp:Label>
        <asp:TextBox ID="TextBox7" runat="server" Font-Size="Large" style="TEXT-TRANSFORM:   uppercase" MaxLength="6" ForeColor="Blue"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Font-Size="XX-Large" ForeColor="Red" OnClick="Button1_Click" Text="驗證" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label10" runat="server" Font-Size="XX-Large" ForeColor="#000099" Text="驗證結果："></asp:Label>
        <asp:Label ID="Label11" runat="server" Font-Size="XX-Large" ForeColor="Red"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Font-Size="XX-Large" ForeColor="Red" Text="驗證碼："></asp:Label>
        <asp:TextBox ID="TextBox5" runat="server" Font-Size="XX-Large" ReadOnly="True" Width="724px"></asp:TextBox>
    <%--</form>--%>
<%--</body>--%>
</asp:Content>

