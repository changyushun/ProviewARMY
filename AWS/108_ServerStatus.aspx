﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="108_ServerStatus.aspx.cs" Inherits="_108_ServerStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme" Width="1020px" ActiveTabIndex="0">
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="伺服器連線狀態">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">

                </div>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

    </ajaxToolkit:TabContainer>
</asp:Content>

