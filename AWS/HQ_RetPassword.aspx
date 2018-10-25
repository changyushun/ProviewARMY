<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_RetPassword.aspx.cs" Inherits="HQ_RetPassword" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js">
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="重設密碼">
<ContentTemplate>
<div>
<table>
<tr>
    <td>身分證字號</td>
    <td><asp:TextBox ID="TB_KeyWord" runat="server"></asp:TextBox></td>      
    <td><asp:Button ID="Button1" runat="server" CssClass="search" onclick="Button1_Click" /></td>
</tr>
</table>
   
</div>

</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>

</asp:Content>