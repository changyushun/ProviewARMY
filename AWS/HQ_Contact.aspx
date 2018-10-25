<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_Contact.aspx.cs" Inherits="HQ_Contact" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<link rel="Stylesheet" type="text/css" href="JS/htmileditor/jquery.cleditor.css" />
<%--<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script> --%>
<%--<script type="text/javascript" src="JS/htmileditor/jquery.cleditor.js"></script>--%>
<script type="text/javascript" src="JS/htmileditor/jquery.min.js"></script> 
<script type="text/javascript" src="JS/htmileditor/jquery.cleditor.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_information").cleditor({ width: 900, height: 180, useCSS: true });
    });     
</script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="聯絡資訊維護">
    <HeaderTemplate>
        聯絡資訊維護
    </HeaderTemplate>
<ContentTemplate>
<asp:Button ID="Button1" runat="server" Text="確認更新" onclick="Button1_Click" /></div>
<div><asp:Label ID="Label1" runat="server" Text="相關說明資訊 :"></asp:Label></div>
<div><asp:TextBox ID="information" runat="server" TextMode="MultiLine"></asp:TextBox></div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

