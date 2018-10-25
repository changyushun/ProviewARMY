<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_Discuss.aspx.cs" Inherits="HQ_Discuss" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="討論區管理">
<ContentTemplate>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="sid" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="sid" HeaderText="編號" InsertVisible="False" 
                    ReadOnly="True" SortExpression="sid" />
                <asp:BoundField DataField="head" HeaderText="標題" SortExpression="head" />
                <asp:BoundField DataField="date" HeaderText="發表日期" SortExpression="date" />
                <asp:HyperLinkField DataNavigateUrlFields="sid" 
                DataNavigateUrlFormatString="DiscussionView.aspx?sid={0}" HeaderText="***" 
                Text="內容" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
            DeleteCommand="Delete From Discussion where sid = @sid"
            SelectCommand="SELECT * FROM [Discussion]">
            <DeleteParameters>
                <asp:Parameter Name="sid" Type="string"/>
            </DeleteParameters>
            </asp:SqlDataSource>
           
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

