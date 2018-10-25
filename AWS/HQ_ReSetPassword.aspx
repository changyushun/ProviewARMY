<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_ReSetPassword.aspx.cs" Inherits="HQ_ReSetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <link rel="Stylesheet" type="text/css" href="HQ_ReSetPassword.css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script language="javascript" type="text/javascript">
        $(function () {
            $('#query').click(function () {
                $('#UpdateMail').next().html('');
                if ($('#keyword').val().length == 10) {
                    $.postJson('GetValueByCode.ashx', {
                        mode: 'queryplayerbyresetpassword', id: $('#keyword').val()
                    }, function (data, s) {
                        if (s == 'success') {
                            if (data["status"] == "true") {
                                //alert('ok');
                                document.getElementById("Msg_Div").style.color = "blue";
                                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('搜尋結果 : 1筆');
                                
                                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_id').html(data["id"]);
                                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_id').val(data["id"]);
                                $('#name').html(data["name"]);
                                $('#rank').html(data["rank"]);
                                $('#unit').html(data["unit"]);
                                $('#mail').val(data["mail"]);
                                document.getElementById("result").style.display = "";
                            }
                            else {
                                document.getElementById("Msg_Div").style.color = "red";
                                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('查無資料');                         
                                document.getElementById("result").style.display = "none";
                            }
                        }
                        else {
                            document.getElementById("Msg_Div").style.color = "red";
                            $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('查無資料');
                            document.getElementById("result").style.display = "none";
                        }
                    });
                }
                else {
                    document.getElementById("Msg_Div").style.color = "red";
                    $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('身分證長度不足');
                    document.getElementById("result").style.display = "none";
                    
                    //alert('長度不足');
                }
            });

            $('#UpdateMail').click(function () {
                $('#UpdateMail').next().html('');
                if ($('#mail').val().length > 0 && $('#mail').val().length <= 20) {
                    $.postJson('GetValueByCode.ashx', {
                        mode: 'updatemail', id: $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_id').html(), mail: $('#mail').val()
                    }, function (data, s) {
                        if (s == 'success') {
                            if (data["status"] == "true") {
                                $('#UpdateMail').next().html('更新完成');
                            }
                            else {
                                $('#UpdateMail').next().html('更新失敗');
                            }
                        }
                        else {
                            $('#UpdateMail').next().html('更新失敗');
                        }
                    });
                }
                else {
                    $('#UpdateMail').next().html('Mail不得為空白, 且長度需小於20個字元');
                }
            });

            $('#Send').click(function () {
                $('#UpdateMail').next().html('');
                if ($('#mail').val().length > 0 && $('#mail').val().length <= 20) {
                    $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('');
                    $.postJson('GetValueByCode.ashx', {
                        mode: 'SendMail', id: $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_id').html(), mail: $('#mail').val()
                    }, function (data, s) {
                        if (s == 'success') {
                            if (data["status"] == "true") {
                                document.getElementById("Msg_Div").style.color = "blue";
                                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('重設密碼函已完成傳送');
                            }
                            else {
                                document.getElementById("Msg_Div").style.color = "red";
                                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('重設密碼函傳送失敗');
                            }
                        }
                        else {
                            document.getElementById("Msg_Div").style.color = "red";
                            $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('重設密碼函傳送失敗');
                        }
                    });
                }
                else {
                    document.getElementById("Msg_Div").style.color = "red";
                    $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_Msg').html('Mail不得為空白, 且長度需小於20個字元');
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="重設密碼">
<ContentTemplate>
<div style="padding-left:8px;">
<table>
<tr>
    <td>身分證字號 : </td>
    <td>
        <input id="keyword" size="10" />
        <%--<asp:TextBox ID="TB_KeyWord" runat="server"></asp:TextBox>--%>
    </td>
    <td>
        <button class="search" id="query" onclick="return false;"></button>
        <%--<asp:Button ID="Button1" runat="server" CssClass="search"/>--%></td>
</tr>
</table>
</div>
<div style="padding-left:10px; padding-bottom:10px" id="Msg_Div">
     <span id ="Msg" runat="server"></span>
    <%--<span>搜尋結果 </span> <span id="count">0筆</span>--%>
</div>
<div class="divborder" id="result" style="display:none;">
    <div style="padding-left:10px; padding-top:10px">
        <span>姓名 : </span> 
        <span id="name">張*銘</span>
    </div>
    <div style="padding-left:10px; padding-top:10px">
        <span>身分證字號 : </span>
        <span id="id" runat="server">L12354****</span>
    </div>
    <div style="padding-left:10px; padding-top:10px">
        <span>單位 : </span>
        <span id="unit">國防部</span>
    </div>
    <div style="padding-left:10px; padding-top:10px">
        <span>級職 : </span>
        <span id="rank">少校</span>
    </div>
    <div style="padding-left:10px; padding-top:10px">
        <span>Mail : </span>
        <input id="mail" size="10" />@webmail.mil.tw
        <button id="UpdateMail" onclick="return false;">更新信箱</button>
        <span></span>
    </div>
    <div style="padding-top:5px">
       <%-- <asp:Button ID="Send" Text="寄送密碼函" runat="server" OnClick="Send_Click" CssClass="buttom_main" />--%>
       <%-- <span id ="Msg" runat="server"></span>--%>
        <button id="Send" class="buttom_main" onclick="return false;">寄送密碼函</button>
    </div>
</div>

 </ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

