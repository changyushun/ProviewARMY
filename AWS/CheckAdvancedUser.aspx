<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CheckAdvancedUser.aspx.cs" Inherits="CheckAdvancedUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
<script type="text/javascript">
    $(function() {
//        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').blur(function() {
//            $.postJson('GetValueByCode.ashx', { mode: 'accExist', value: $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc').val() + $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').val() }, function(data, s) {
//                if (s == 'success') {
//                    if (data["status"] == "true") {
//                        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').next().html('帳號已經存在');
//                    }
//                    else {
//                        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').next().html('可使用此帳號');
//                    }
//                }
//            });
//        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_password').blur(function() {
            var patten = /^(?=.*\d)(?=.*[a-z])(?=.*[\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\:\;\,\.\<\>\\\|\/\?\~\`\x22\x27]).{1,12}$/;
            if ($(this).val() != '') {
                if ($(this).val().length < 8) {
                    $(this).next().html('密碼長度不夠');
                }
                else {
                    var valid = patten.test($(this).val());
                    if (!valid) {
                        $(this).next().html('密碼組合錯誤');
                    }
                    else {
                        $(this).next().html('');
                    }
                }
            }
        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_unit_code').blur(function() {
            $.postJson('GetValueByCode.ashx', { mode: 'unit', value: $(this).val() }, function(data, s) {
                if (s == 'success') {
                    if (data["status"] == "") {
                        $("#unit_code").parent().next().html('無此單位')
                    }
                    else {
                        $("#unit_code").parent().next().html(data["status"]);
                    }
                }
                else {
                    $("#unit_code").parent().next().html('查詢失敗');
                }
            });

        });
        
//        $('#AddAcc').click(function() {
//            if ($('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').val() != '' && $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').next().html() == '') {
//                if ($('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_password').val() != '' && $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_password').next().html() == '') {

//                } else { alert('資料未完整'); }
//            } else { alert('資料未完整'); }
//        });
//        
//        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_AddAcc').click(function() {
//            if ($('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').val() != '' && $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_acc_random').next().html() == '') {
//                if ($('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_password').val() != '' && $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane1_password').next().html() == '') {
//                    
//                } else { alert('資料未完整'); }
//            } else { alert('資料未完整'); }
//        });
    });
 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<div>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPane1" runat="server" HeaderText="團報管理者審核">
<ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
            Width="900px" AllowSorting="True" AllowPaging="True"
        DataKeyNames="sid" DataSourceID="SqlDataSource1"  
        onselectedindexchanged="GridView1_SelectedIndexChanged"   
        ondatabound="GridView1_DataBound" >
        <Columns>
            <asp:BoundField DataField="sid" HeaderText="申請編號" InsertVisible="False" 
                ReadOnly="True" SortExpression="sid" />
            <asp:BoundField DataField="id" HeaderText="身份證字號" SortExpression="id" />
            <asp:BoundField DataField="name" HeaderText="中文姓名" SortExpression="name" />
            <asp:BoundField DataField="unit_code" HeaderText="單位代碼" 
                SortExpression="unit_code" />
            <asp:BoundField DataField="rank_code" HeaderText="級職代碼" 
                SortExpression="rank_code" />
            <asp:BoundField DataField="mail" HeaderText="Mail帳號" SortExpression="mail" />
            <asp:BoundField DataField="tel" HeaderText="電話號碼" SortExpression="tel" />
            <asp:BoundField DataField="cellphone" HeaderText="行動電話" 
                SortExpression="cellphone" />
            <asp:BoundField DataField="ip" HeaderText="IP位址" SortExpression="ip"  />
            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" 
                ShowSelectButton="True" />
        </Columns>
        <EditRowStyle CssClass="EditRowStyle" />
        <HeaderStyle CssClass="HeaderStyle" />
        <PagerStyle CssClass="PagerStyle" />
        <RowStyle CssClass="RowStyle" />
        <SelectedRowStyle CssClass="SelectedRowStyle" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT a.sid, a.id, a.name, a.unit_code, a.rank_code, a.mail, a.tel, a.cellphone, a.ip FROM AskAccount AS a INNER JOIN Unit AS u ON a.unit_code = u.unit_code WHERE (u.service_code = @service_code)" 
        DeleteCommand="DELETE FROM AskAccount WHERE (sid = @sid)">
        <SelectParameters>
            <asp:Parameter Name="service_code" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="sid" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <div id="status" runat="server" style="display:none"><span style="font-family: 微軟正黑體;font-size: 14px;font-weight:bold">目前無待審核申請。</span>
    </div>
    <div id="accexist" runat="server" style="display:none"><span style="color:Red;font-family:微軟正黑體;font-size: 14px;font-weight:bold">此帳號已經存在，請選擇其他帳號。</span>
    </div>
    <div id="error" runat="server" style="display:none"><span style="color:Red;font-family:微軟正黑體;font-size: 14px;font-weight:bold">請填入帳號與產生密碼。</span>
    </div>
    <div id="success" runat="server" style="display:none"><span style="color:Blue;font-family:微軟正黑體;font-size: 14px;font-weight:bold">審核完成，已寄發通知信函給申請者。</span>
    </div>
    <div id="tablelist" runat="server">
    <table>
                            <tbody>
                                <tr><td>申請編號</td><td><asp:TextBox ID="sid" runat="server" Enabled="False"></asp:TextBox><span></span></td>
                                </tr>
                                <tr><td>帳號</td><td><asp:TextBox ID="acc" runat="server" Enabled="False"></asp:TextBox> + <asp:TextBox ID="acc_random" runat="server" MaxLength="15"></asp:TextBox><span></span></td>
                                </tr>
                                <tr><td>密碼</td><td><asp:TextBox ID="password" runat="server" Enabled="False"></asp:TextBox>
                                    <asp:Button ID="getpassword"
                                        runat="server" Text="產生密碼" onclick="getpassword_Click" /><span></span></td>
                                </tr>
                                <tr>
                                    <td>
                                        姓名
                                    </td>
                                    <td>
                                        <asp:TextBox ID="name" runat="server" Enabled="False"></asp:TextBox><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        身份字號
                                    </td>
                                    <td>
                                        <asp:TextBox ID="id" runat="server" Enabled="False"></asp:TextBox><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        單位代碼
                                    </td>
                                    <td>
                                        <asp:TextBox ID="unit_code" runat="server" Enabled="False"></asp:TextBox>
                                        <asp:Label ID="unit_code_name" runat="server" Text=""></asp:Label><span></span><input type="hidden">
                                    </td></tr><tr>
                                    <td>
                                        級職代碼
                                    </td>
                                    <td>
                                        <asp:TextBox ID="rank_code" runat="server" Enabled="False"></asp:TextBox>
                                        <asp:Label ID="rank_code_name" runat="server" Text=""></asp:Label><span></span><input type="hidden">
                                </td>
                                </tr>
                                <tr>
                                    <td>
                                        電話號碼
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tel" runat="server" Enabled="False"></asp:TextBox><span></span></td></tr><tr>
                                    <td>
                                        手機號碼
                                    </td>
                                    <td>
                                        <asp:TextBox ID="cellphone" runat="server" Enabled="False"></asp:TextBox><span></span></td></tr><tr>
                                    <td>
                                        電子郵件
                                    </td>
                                    <td>
                                        <asp:TextBox ID="mail" runat="server" Enabled="False"></asp:TextBox><span>@webmail.mil.tw</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        IP位址
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ip" runat="server" Enabled="False"></asp:TextBox><span></span></td></tr><tr>
                                    <td colspan="2" align="left">
                                        <asp:Button ID="AddAcc" runat="server" Text="確定" 
                                            onclick="AddAcc_Click" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</div>
</asp:Content>


