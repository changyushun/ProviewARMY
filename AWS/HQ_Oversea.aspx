<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HQ_Oversea.aspx.cs" Inherits="HQ_Oversea" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js">
    </script>

    <script type="text/javascript" src="Script/RankCode.ashx"></script>

    <script type="text/javascript">
        $(function() {
            var GoEdit_OK = false;
            $('tbody span').attr({ style: 'color:red' });

            // check id if exist block
            $('#id').blur(function() {
                if (checkID($(this).val())) {
                    $.postJson('GetValueByCode.ashx', { mode: 'player', value: $('#id').val() }, function(d, s) {
                        if (s == 'success') {
                            if (d["status"] == 'none') {
                                $('#id').next().html('');
                            }
                            if (d["status"] == "false") {
                                $('#id').next().html('該ID資料已經存在');
                            }
                        }
                    })
                }
                else {
                    $(this).next().html("格式錯誤");
                }
            });

            // check rank
            $('#rank_code').blur(function() {
                if ($(this).val() != '') {
                    var rank = GetRank($(this).val());
                    if (!rank) {
                        $(this).next().html('官階不存在');
                        $(this).next().next().val('');
                    }
                    else {
                        $(this).next().next().val($(this).val());
                        $(this).next().html('');
                        $(this).val(rank);
                    }
                }

            });

            // check unit
            $('#unit_code').blur(function() {
                $.postJson('GetValueByCode.ashx', { mode: 'unit', value: $(this).val() }, function(data, s) {
                    if (s == 'success') {
                        if (data["status"] == "") {
                            $("#unit_code").next().html('無此單位')
                            $("#unit_code").next().next().val('');
                        }
                        else {
                            $("#unit_code").next().next().val($('#unit_code').val());
                            $("#unit_code").next().html('');
                            $("#unit_code").val(data["status"]);

                        }
                    }
                    else {
                        $("#unit_code").next().html('查詢失敗');
                    }
                });

            });
            // defalut set gender is M 
            $('#chkM')[0].checked = true;
            // male check box
            $('#chkM').click(function() {
                $(this)[0].checked = true;
                $('#chkF')[0].checked = false;
            });
            $('#chkM_u').click(function() {
                $(this)[0].checked = true;
                $('#chkF_u')[0].checked = false;
            });
            // female check box
            $('#chkF').click(function() {
                $(this)[0].checked = true;
                $('#chkM')[0].checked = false;
            });
            $('#chkF_u').click(function() {
                $(this)[0].checked = true;
                $('#chkM_u')[0].checked = false;
            });

            // add oversea player block
            $('#confirm').click(function() {
                //alert($('#unit_v').val());
                if ($('#id').val() != '' && $('#id').next().html() == '' && $('#unit_v').val() != '' && $('#rank_v').val() != '' && $('#birth').val() != '' && $('#name').val() != '' && $('#mail').val() != '') {
                    var gender = "M";
                    if ($('#chkF')[0].checked == true) {
                        gender = "F";
                    }
                    $.postJson('Operations/Player.ashx', {
                        mode: 'add',
                        id: $('#id').val(),
                        gender: gender,
                        birth: $('#birth').val(),
                        name: $('#name').val(),
                        unit_code: $('#unit_v').val(),
                        rank_code: $('#rank_v').val(),
                        mail: $('#mail').val(),
                        oversea: '1'
                    }, function(d, s) {
                        if (s == 'success') {
                            if (d["status"] == 'done') {
                                alert('新增成功');
                            }
                            else {
                                alert(d["status"]);
                            }
                            $('tbody :text').val('');
                            $('tbody :hidden').val('');
                        }
                    });
                }
                else {
                    alert('資料不完全');
                }
            });

            // find oversea player
            $('#findoversea').click(function() {
                $.postJson('Operations/Player.ashx', { mode: 'find', id: $('#overseaid').val(), oversea: '1' }, function(d, s) {
                    if (s == 'success') {
                        if (d.length == 0) {
                            alert('沒有資料');
                            GoEdit_OK = false;
                        }
                        else {
                            $('#name_u').val(d[0]["name"]);
                            if (d[0]["gender"] == "M") {
                                $('#chkM_u')[0].checked = true;
                                $('#chkF_u')[0].checked = false;
                            }
                            else {
                                $('#chkF_u')[0].checked = true;
                                $('#chkM_u')[0].checked = false;
                            }
                            $('#unit_u').val(d[0]["unit_code"]);
                            $('#rank_u').val(d[0]["rank_code"]);
                            $('#mail_u').val(d[0]["mail"]);
                            GoEdit_OK = true;
                        }
                    }
                });
            });

            // update oversea player
            $('#updatePlayer').click(function() {
                var _gender = 'M';
                if ($('#chkF_u')[0].checked == true) {
                    _gender = 'F';
                }
                $.postJson('Operations/Player.ashx', {
                    mode: 'update',
                    id: $('#overseaid').val(),
                    gender: _gender,
                    name: $('#name_u').val(),
                    unit_code: $('#unit_u').val(),
                    rank_code: $('#rank_u').val(),
                    mail: $('#mail_u').val(),
                    oversea: '1'
                }, function(d, s) {
                    if (s == 'success') {
                        if (d["status"] == "done") {
                            alert('更新成功');
                        } else {
                            alert(d["status"]);
                        }
                    }

                });

            });

            $('#resultEdit').click(function() {
                if (GoEdit_OK) {

                    window.open('OverEdit.aspx?id=' + $('#overseaid').val(), '', 'menubar=no,toobar=no,height=500,width=400');

                }
                else {
                    alert('請選擇海外人員');
                }

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
        

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" ID="scriptmanger1">
    </asp:ScriptManager>
    <ajaxToolkit:TabContainer ID="TabContainer" runat="server" CssClass="ajax__tab_yuitabview-theme">
        <ajaxToolkit:TabPanel ID="tabpanel1" runat="server" HeaderText="新增海外人員資料">
            <ContentTemplate>
                <div>
                    <table>
                        <tbody>
                            <tr>
                                <td>
                                    身分證號
                                </td>
                                <td>
                                    <input type="text" id="id" /><span></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    性別
                                </td>
                                <td>
                                    男<input type="checkbox" id="chkM" />女<input type="checkbox" id="chkF" /><span></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    生日(ex.64/01/14)
                                </td>
                                <td>
                                    <input type="text" id="birth" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    姓名
                                </td>
                                <td>
                                    <input type="text" id="name" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    單位代碼
                                </td>
                                <td>
                                    <input type="text" id="unit_code" /><span></span>
                                    <input type="hidden" id="unit_v" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    級職代碼
                                </td>
                                <td>
                                    <input type="text" id="rank_code" /><span></span>
                                    <input type="hidden" id="rank_v" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    電子郵件
                                </td>
                                <td>
                                    <input type="text" id="mail" /><span>@webmail.mil.tw</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="right">
                                    <input type="button" id="confirm" value="確定" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel ID="tabpanel2" runat="server" HeaderText="海外人員資料維護">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                請輸入身份証號
                            </td>
                            <td>
                                <input type="text" id="overseaid" /><input type="button" value="搜尋" id="findoversea" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                姓名
                            </td>
                            <td>
                                <input type="text" id="name_u" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                性別
                            </td>
                            <td>
                                男<input type="checkbox" id="chkM_u" />女<input type="checkbox" id="chkF_u" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td>
                                生日
                            </td>
                            <td>
                                <input type="text" id="birth_u" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                單位
                            </td>
                            <td>
                                <input type="text" id="unit_u" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                官階
                            </td>
                            <td>
                                <input type="text" id="rank_u" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                電子郵件
                            </td>
                            <td>
                                <input type="text" id="mail_u" /><span>@webmail.mil.tw</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="button" id="updatePlayer" value="更新基本資料" style="width:150px" />
                            </td>
                        </tr>
                        <tr>
                        <td></td>
                        <td><input type="button" id="resultEdit" value="成績管理" style="width:150px" /></td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <%--<ajaxToolkit:TabPanel ID="TabPanel3" runat="server" HeaderText="海外人員成績管理">
        <ContentTemplate>
        <table>
            <tbody>
            <tr>
            <td>請輸入身份証號</td><td> <input type="text" id="Text1" /><input type="button" value="搜尋" id="Button1" /></td>
            </tr>
            <tr>
            <td>姓名</td>
            <td><input type="text" id="Text2" /></td>
            </tr>
            <tr>
            <td>性別</td>
            <td>
            男<input type="checkbox" id="Checkbox1" />女<input type="checkbox" id="Checkbox2" />
            </td>
            </tr>
            <tr style="display:none">
            <td>生日</td>
            <td><input type="text" id="Text3" /></td>
            </tr>
            <tr>
            <td>單位</td>
            <td><input type="text" id="Text4" /></td>
            </tr>
            <tr>
            <td>官階</td>
            <td><input type="text" id="Text5" /></td>
            </tr>
            <tr>
            <td>電子郵件</td>
            <td><input type="text" id="Text6" /><span>@webmail.mil.tw</span></td>
            </tr>
            <tr>
            <td></td>
            <td><input type="button" id="Button2" value="更新基本資料" /></td>
            </tr>
            </tbody>
            </table>
        </ContentTemplate>
        </ajaxToolkit:TabPanel>--%>
    </ajaxToolkit:TabContainer>
</asp:Content>
