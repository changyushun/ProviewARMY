<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BatchAccMag.aspx.cs" Inherits="BatchAccMag" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="批次帳號維護">
<ContentTemplate>
    <asp:Label ID="Label1" runat="server" Text="請輸入單位代碼"></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server" MaxLength="5"></asp:TextBox>
    <asp:Button ID="Button1"
        runat="server" Text="搜尋" onclick="Button1_Click" />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" 
        DataKeyNames="sid" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="account" HeaderText="帳號" 
                SortExpression="account" />
            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
            <asp:BoundField DataField="id" HeaderText="身份証號" SortExpression="id" />
            <asp:BoundField DataField="rank_code" HeaderText="級職" 
                SortExpression="rank_code" />
            <asp:BoundField DataField="tel" HeaderText="電話" SortExpression="tel" />
            <asp:BoundField DataField="cellphone" HeaderText="行動電話" 
                SortExpression="cellphone" />
            <asp:BoundField DataField="mail" HeaderText="電子郵件" SortExpression="mail" />
            <asp:BoundField DataField="ip" HeaderText="網路位置" SortExpression="ip" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("sid") %>' />
                    <asp:Button ID="Button2" runat="server" Text="編輯" onclick="Button2_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT [sid], [account], [password], [name], [id], [unit_code], [rank_code], [tel], [cellphone], [mail], [ip] FROM [Account] WHERE (([unit_code] = @unit_code) AND ([role_code] = @role_code) AND ([byAcc] = @byAcc))">
        <SelectParameters>
            <asp:Parameter Name="unit_code" Type="String" />
            <asp:Parameter Name="byAcc" Type="String" />
            <asp:Parameter DefaultValue="3" Name="role_code" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

