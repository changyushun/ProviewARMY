<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Pro.aspx.cs" Inherits="Pro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript" src="Script/RankCode.ashx"></script>

    <script type="text/javascript">
        $(function() {
            var pwd_old_ok = false;
            var pwd_new_ok = false;
            $('.sender').val(''); // set default sender value
            $('#profile span').attr({ style: "color:black" });

            // get id from asp.net server        
            var prefix = "#ctl00_ContentPlaceHolder1_TabContainer1_tbpanel1_";

            $(prefix + 'pwd_u, .newpwd1').blur(function() {
            var patten = /^(?=.*\d)(?=.*[a-z])(?=.*[\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\:\;\,\.\<\>\\\|\/\?\~\`\x22\x27]).{1,16}$/;
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

            $(prefix + 'id_u').blur(function() {
                if (!checkID($(this).val())) {
                    $(this).next().html('格式錯誤');
                }
                if (checkID($(this).val())) {
                    $(this).next().html('');
                }

            });

            $(prefix + 'unit_u').blur(function() {
                $.postJson('GetValueByCode.ashx', { mode: 'unit', value: $(this).val() }, function(data, s) {
                    if (s == 'success') {
                        if (data["status"] == '') {
                            $(prefix + "unit_u").next().html('無此單位')
                        }
                        else {
                            
                            $(prefix + "unit_u").next().html(data["status"]);
                            

                        }
                    }
                    else {
                        $(pprefix + "unit_u").next().html('查詢失敗');
                    }
                });
            });

            $(prefix + 'rank_u').blur(function() {

                var _code = $(this).val();
                var _rank = GetRank(_code);

                if (!_rank) {
                    $(this).next().html('無此官階');
                }
                else {
                    
                    $(this).next().html(_rank);
                    
                }
            });

            $('#updateBtn').click(function() {
                if ($(prefix + 'pwd_u').val() != '' && $(prefix + 'pwd_u').next().html() == '') {
                    if ($(prefix + 'id_u').val() != '' && $(prefix + 'id_u').next().html() == '') {
                        if ($(prefix + 'unit_u').val() != '' && $(prefix + 'unit_u').next().html() != '無此單位') {
                            if ($(prefix + 'rank_u').val() != '' && $(prefix + 'rank_u').next().html() != '無此官階') {
                                $('#aspnetForm')[0].submit();
                            }
                        }
                    }
                }
                else {
                    alert('資料仍有誤');
                }
            });

            // change password
            

            $('#oldPwd').blur(function() {
                if ($(this).val() != $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_pwd_HF').val()) {
                    $(this).parent().next().html('*');
                    pwd_old_ok = false;
                }
                else {
                    $(this).parent().next().html('');
                    pwd_old_ok = true;
                }
            });

            $('#newPwd1').blur(function() {
                if ($(this).val() == '') {
                    $(this).parent().next().html('*');
                    pwd_new_ok = false;
                }
                else {
                    $(this).parent().next().html('');
                }
            });

            $('#newPwd2').blur(function() {
                var v = checkPwd($(this).val());
                //alert(v);
                if ($('#newPwd1').val() != '' && $(this).val() == $('#newPwd1').val() && checkPwd($('#newPwd2').val()) == '') {
                    $(this).parent().next().html('');
                    pwd_new_ok = true;
                }
                else {
                    $(this).parent().next().html('*');
                    pwd_new_ok = false;
                }
            });

            $('#pwdChgBtn').click(function() {
                if (pwd_new_ok == true && pwd_old_ok == true) {
                    $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_pwd_HF').val($('#newPwd2').val());
                    $('#ctl00_ContentPlaceHolder1_submitType').val('pwdchange');
                    $('#aspnetForm')[0].submit();
                }
                else {
                    alert('請檢核密碼');
                }

            });
            

            $('.confirm').click(function() {
                if ($('.oldpwd').val() != '' && $('.newpwd1').val() != '' && $('newpwd2').val() != '') {
                    $('.type').val('pwd');
                    $('#aspnetForm')[0].submit();
                }
                else {
                    alert('請輸入必填資料');
                }
            });

            // ip renew
            $('.iprenew').click(function() {
                window.open('IPRenew.aspx', '', 'menubar=no,toolbar=no,resizable=no,width=400,height=300,top=200,left=500', '');
            });

            // disable history case buton
            $.each($('.change'), function() {
                if ($(this).parent().prev().html() == "通過") {
                    $(this)[0].disabled = true;
                }
            });


            // grant ip block
            $('.change').click(function() {
                //alert($(this).parent().prev().html());
                var _apply = $(this).parent().prev().prev().prev().prev().prev().html();
                $.postJson('GetValueByCode.ashx', { mode: 'iprenew', value: _apply }, function(d, s) {
                    if (s == 'success') {
                        if (d["status"] == "done") {
                            alert('核准成功');
                            $('.sender').val('iprenew'); // set this value let server know who is sender
                            $('#aspnetForm')[0].submit();
                        }
                        else {
                            alert(d["status"]);
                        }
                    }
                });
            });
        });



        function checkID(id) {
            tab = "ABCDEFGHJKLMNPQRSTUVXYWZIO"
            A1 = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3);
            A2 = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5);
            Mx = new Array(9, 8, 7, 6, 5, 4, 3, 2, 1, 1);

            if (id.length != 10) return false;
            i = tab.indexOf(id.charAt(0));
            if (i == -1) return false;
            sum = A1[i] + A2[i] * 9;

            for (i = 1; i < 10; i++) {
                v = parseInt(id.charAt(i));
                if (isNaN(v)) return false;
                sum = sum + v * Mx[i];
            }
            if (sum % 10 != 0) return false;
            return true;
        }

        function checkPwd(pwd) {
            var patten = /^(?=.*\d)(?=.*[a-z])(?=.*[\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\:\;\,\.\<\>\\\|\/\?\~\`\x22\x27]).{1,16}$/;
            if (pwd.length == '') {
                return '空密碼';
            }
            if (pwd.length < 8) {
                return '長度不足';
            }
            if (!patten.test(pwd)) {
                return '組合錯誤';
            }
            if (patten.test(pwd)) {
                return '';
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptMager1" runat="server" />
    <asp:HiddenField ID="submitType" runat="server" />
    <div style="width: 100%; margin-left: 0px"> 
        <ajaxToolkit:TabContainer runat="server" ID="TabContainer1" CssClass="ajax__tab_yuitabview-theme">
            <ajaxToolkit:TabPanel runat="server" ID="tbpanel1" HeaderText="個人資料維護">
                <ContentTemplate>
                    <table id="profile">
                        <tbody>
                            <tr>
                                <td>
                                    帳號 <a style="border: solid 1px black"></a>
                                </td>
                                <td>
                                    <input type="text" id="acc_u" disabled="disabled" runat="server" maxlength="20" />
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td>
                                    密碼
                                </td>
                                <td>
                                    <input type="text" id="pwd_u" runat="server" maxlength="16"/>
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    姓名
                                </td>
                                <td>
                                    <input type="text" id="name_u" runat="server" maxlength="5"/>
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    身份字號
                                </td>
                                <td>
                                    <input runat="server" type="text" id="id_u" maxlength="10"/>
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    單位代碼
                                </td>
                                <td>
                                    <input type="text" id="unit_u" runat="server" maxlength="5"/>
                                    <span></span>
                                    <input type="hidden" runat="server" id="unit_value" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    級職代碼
                                </td>
                                <td>
                                    <input type="text" id="rank_u" runat="server" maxlength="2"/>
                                    <span></span>
                                    <input type="hidden" runat="server" id="rank_value" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    電話號碼
                                </td>
                                <td>
                                    <input type="text" id="tel_u" runat="server" maxlength="20"/>
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    行動電話
                                </td>
                                <td>
                                    <input type="text" id="cell_u" runat="server" maxlength="15"/>
                                    <span></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    電子郵件
                                </td>
                                <td>
                                    <input type="text" id="mail_u" runat="server" maxlength="20"/>
                                    <span>@webmail.mil.tw</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    IP位址
                                </td>
                                <td>
                                    <input type="text" id="ip_u" runat="server" maxlength="15"/>
                                    <span></span>
                                    <input type="button" value="IP異動" id="iprenew" class="iprenew" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    <input id="updateBtn" type="button" value="更新" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="TabPanel2" runat="server" HeaderText="密碼變更">
<ContentTemplate>
<div>
<asp:HiddenField ID="pwd_HF" runat="server" />
<table id="pwdchange" style="margin-left:10px">
<tbody>
<tr>
<td>舊密碼</td>
<td><input type="text" id="oldPwd" /></td>
<td></td>
</tr>
<tr>
<td>新密碼</td>
<td><input type="text" id="newPwd1" /></td>
<td></td>
</tr>
<tr>
<td>確認新密碼</td>
<td><input type="text" id="newPwd2" /></td>
<td></td>
</tr>
<tr>
<td colspan="3"><input type="button" id="pwdChgBtn" value="確認" /></td>
</tr>
<tr>
<td colspan="3">密碼建立原則: </td>
</tr>
<tr>
<td colspan="3"><li>密碼至少8個字元，至多16個字元。</li></td>
</tr>
<tr>
<td colspan="3"><li>不能全為英文字母或全為數字。</li></td>
</tr>
<tr>
<td colspan="3"><li>英文字母區分大小寫，例如A與a視為不同字母。</li></td>
</tr>
<tr>
<td colspan="3"><li>密碼中不能包含空格。</li></td>
</tr>
<tr>
<td colspan="3"><li>密碼須包含至少1個特殊字元(例如@#$等)。</li></td>
</tr>
</tbody>
</table>
</div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="tbpanel3" runat="server" HeaderText="網址審查">
                <ContentTemplate>
                <div id="noneipcheck" runat="server" style="display:none"><span style="font-family: 微軟正黑體;font-size: 14px;font-weight:bold">權限不足，無法使用此功能。</span></div>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" PageSize = "25" 
                        OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="apply" HeaderText="申請者" SortExpression="apply" />
                            <asp:BoundField DataField="ip_new" HeaderText="申請異動網址" SortExpression="ip_new" />
                            <asp:BoundField DataField="ip_old" HeaderText="現在網址" SortExpression="ip_old" />
                            <asp:BoundField DataField="date" HeaderText="申請日期" SortExpression="date" />
                            <asp:BoundField DataField="status" HeaderText="狀態" SortExpression="status" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <input type="button" id="change" value="核准" class="change" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MainDB %>"
                        SelectCommand="SELECT i.apply, i.ip_new, a.ip AS ip_old, i.date, i.status  FROM IP_Renew AS i INNER JOIN Account AS a ON i.apply = a.account WHERE (i.confirmer = @confirmer) order by date desc">
                        <SelectParameters>
                            <asp:Parameter Name="confirmer" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        </ajaxToolkit:TabContainer>
    </div>
    <div>
    <input type="hidden" runat="server" id="sender" class="sender" />
    
    </div>
</asp:Content>
