<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CenterInforView.aspx.cs" Inherits="CenterInforView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="鑑測站交通資訊">
    <HeaderTemplate>
        鑑測站交通資訊
    </HeaderTemplate>
<ContentTemplate>
<div style="font-family:微軟正黑體; font-size:14px; font-weight:bold; margin-top:5px; margin-bottom:5px;">請選擇鑑測站：
<asp:DropDownList runat="server" ID="cneterSel" AutoPostBack="True" 
                            onselectedindexchanged="cneterSel_SelectedIndexChanged" 
                            DataSourceID="SqlDataSource1" DataTextField="center_name" 
                            DataValueField="center_code">
                            </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
                            SelectCommand="Ex103_GetCenterList" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
</div>
<div style="font-family:微軟正黑體; font-size:14px; font-weight:bold; margin-top:5px;"><asp:Label ID="traffic" runat="server" Text="交通資訊："></asp:Label></div>
<div style="font-family:微軟正黑體; font-size:14px; font-weight:bold; margin-top:5px;"><asp:Label ID="information" runat="server"></asp:Label></div>
<div style="margin-top:5px;"><asp:Image ID="Image1" runat="server" Visible="false" /></div>
    
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

