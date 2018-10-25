<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_Suggestion.aspx.cs" Inherits="HQ_Suggestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
<script type="text/javascript">

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="意見案件列表">
<ContentTemplate>
<div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="sid" DataSourceID="SqlDataSource1" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="sid" HeaderText="案件編號" InsertVisible="False" 
                ReadOnly="True" SortExpression="sid" />
            <asp:BoundField DataField="head" HeaderText="主旨" SortExpression="head" />
            <asp:BoundField DataField="name" HeaderText="意見提交者" SortExpression="name" />
            <asp:BoundField DataField="date" HeaderText="提交日期" SortExpression="date" />
            <asp:BoundField DataField="status" HeaderText="狀態" 
                SortExpression="status" />
            <asp:HyperLinkField DataNavigateUrlFields="sid" 
                DataNavigateUrlFormatString="EditSuggestion.aspx?sid={0}" HeaderText="***" 
                Text="回覆" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>">
    </asp:SqlDataSource>
</div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>

</asp:Content>

