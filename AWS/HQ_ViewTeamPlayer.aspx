<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_ViewTeamPlayer.aspx.cs" Inherits="HQ_ViewTeamPlayer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" /> 
<link rel="Stylesheet" type="text/css" href="main.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="受測人員生日查詢">
<ContentTemplate>
<div>
<span>輸入身份證字號：</span><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" Text="查詢" onclick="Button1_Click" />
</div>
<div id="Result" runat="server" style="display:none"><span>符合資料：</span><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label><span style="padding-left:5px">筆</span></div>
<div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" ondatabound="GridView1_DataBound" 
        lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" 
        onrowcommand="GridView1_RowCommand" >
        <Columns>
            <asp:BoundField DataField="id" HeaderText="身份證字號" SortExpression="id" />
            <asp:BoundField DataField="birth" HeaderText="生日" SortExpression="birth" />            
        </Columns>
        <EditRowStyle CssClass="EditRowStyle" />
        <HeaderStyle CssClass="HeaderStyle" />
        <PagerStyle CssClass="PagerStyle" />
        <RowStyle CssClass="RowStyle" />
        <SelectedRowStyle CssClass="SelectedRowStyle" />
    </asp:GridView>    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT CONVERT(nvarchar(10),birth,111)as birth, [id] FROM [Player] WHERE (([id] = @id) AND ([unit_code] = @unit_code))">
        <SelectParameters>
            <asp:Parameter Name="id" Type="String" />
            <asp:Parameter Name="unit_code" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

