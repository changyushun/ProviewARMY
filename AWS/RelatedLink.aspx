<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RelatedLink.aspx.cs" Inherits="RelatedLink" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<div>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">

<ajaxToolkit:TabPanel ID="TabPane2" runat="server" HeaderText="相關連結">
<ContentTemplate>
<div>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
            PageSize = "25" 
         AutoGenerateColumns="False" DataKeyNames="sid" 
         DataSourceID="SqlDataSource1" >
         <Columns>
             <asp:TemplateField>
                <headertemplate>
                <asp:label id="label1" text="國軍單位" runat="server" />
                </headertemplate>
                <ItemTemplate>
                <asp:HyperLink ID="url" runat="server" Text='<%#Eval("url")%>' NavigateUrl='<%#Eval("url")%>' ImageUrl='<%#Eval("path")%>'/>
                </ItemTemplate>
              </asp:TemplateField>    
         </Columns>
         <EditRowStyle CssClass="EditRowStyle" />
         <HeaderStyle CssClass="HeaderStyle" />
         <PagerStyle CssClass="PagerStyle" />
         <RowStyle CssClass="RowStyle" />
         <SelectedRowStyle CssClass="SelectedRowStyle" />
     </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT * FROM [RelatedLink]"></asp:SqlDataSource>
    </div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</div>
</asp:Content>


