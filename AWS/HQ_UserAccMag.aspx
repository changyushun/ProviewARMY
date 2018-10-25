<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HQ_UserAccMag.aspx.cs" Inherits="HQ_UserAccMag" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript" src="Script/RankCode.ashx"></script>

    <script type="text/javascript">
        $(function() {

            $('#rankinfo').click(function() {
                window.open('RankInfo.aspx', '', 'height=550,width=100');
            });

            $('#AddAccDiv span, #EditAccDiv span').attr({ style: "color:black" });

            $('#acc').blur(function() {
                $.postJson('GetValueByCode.ashx', { mode: 'accExist', value: $('#acc').val() }, function(data, s) {
                    if (s == 'success') {
                        if (data["status"] == "true") {
                            $('#acc').next().html('帳號已經存在');
                        }
                        else {
                            $('#acc').next().html('');
                        }
                    }
                });
            });

            $('#pwd, #pwd_u').blur(function() {
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

            $('#id, #id_u').blur(function() {
                if (!checkID($(this).val())) {
                    $(this).next().html('格式錯誤');
                }
                if (checkID($(this).val())) {
                    $(this).next().html('');
                }
            });

            $('#unit_code').blur(function() {
                //if ($('#unit_code').next().next().val() == '') {

                $.postJson('GetValueByCode.ashx', { mode: 'unit', value: $(this).val() }, function(data, s) {
                    if (s == 'success') {
                        if (data["status"] == "") {
                            $("#unit_code").next().html('無此單位')
                        }
                        else {

                            $("#unit_code").next().html(data["status"]);
                            /*
                            $("#unit_code").next().next().val($('#unit_code').val());
                            $("#unit_code").next().html('');
                            $("#unit_code").val(data["status"]);
                            */
                        }
                    }
                    else {
                        $("#unit_code").next().html('查詢失敗');
                    }
                });
                //}
            });
            $('#unit_u').blur(function() {

                $.postJson('GetValueByCode.ashx', { mode: 'unit', value: $(this).val() }, function(data, s) {
                    if (s == 'success') {
                        if (data["status"] == "") {
                            $("#unit_u").next().html('無此單位')
                        }
                        else {
                            $("#unit_u").next().html(data["status"]);
                            /*
                            $("#unit_u").next().next().val($('#unit_u').val());
                            $("#unit_u").next().html('');
                            $("#unit_u").val(data["status"]);*/

                        }
                    }
                    else {
                        $("#unit_u").next().html('查詢失敗');
                    }
                });


            });
            $('#rank_code').blur(function() {
                if ($('#rank_code').next().next().val() == '') {
                    var _code = $('#rank_code').val();
                    var _rank = GetRank(_code);

                    if (!_rank) {
                        $('#rank_code').next().html('無此官階');
                    }
                    else {
                        $('#rank_code').next().html(_rank);
                        /*
                        $('#rank_code').next().next().val(_code);
                        $('#rank_code').next().html('');
                        $('#rank_code').val(_rank);
                        */
                    }
                }
            });

            $('#rank_u').blur(function() {


                var _code = $('#rank_u').val();
                var _rank = GetRank(_code);

                if (!_rank) {
                    $('#rank_u').next().html('無此官階');
                }
                else {
                    $('#rank_u').next().html(_rank);
                    /*
                    $('#rank_u').next().next().val(_code);
                    $('#rank_u').next().html('');
                    $('#rank_u').val(_rank);*/
                }

            });
            //2016-12-12國防部規定 帳號不能跟身份證字號一樣，所以需新增判斷
            //使用indexOf()方法來比對字串，如果沒有相同的會回傳-1
            $('#AddAcc').click(function() {
                //alert($('#ctl00_ContentPlaceHolder1_TabContainer_TabPanel2_who').val());
                if ($('#acc').val().trim().indexOf($('#id').val().trim()) == -1) {
                    if ($('#acc').val() != '' && $('#acc').next().html() == "") {
                        if ($('#pwd').val() != '' && $('#pwd').next().html() == "") {
                            if ($('#id').val() != '' && $('#id').next().html() == "") {
                                if ($('#unit_code').val() != '' && $('#unit_code').next().html() != "無此單位") {
                                    if ($('#rank_code').val() != '' && $('#rank_code').next().html() != "無此官階") {
                                        if ($('#name').val() != '') {
                                            if ($('#tel').val() != '') {
                                                if ($('#cellphone').val != '') {
                                                    if ($('#mail').val() != '') {
                                                        if ($('#ip').val() != '') {
                                                            if ($('#ckb1')[0].checked != false || $('#ckb2')[0].checked != false || $('#ckb3')[0].checked != false || $('#ckb4')[0].checked != false || $('#ckb5')[0].checked != false) {


                                                                $.postJson('Operations/Account.ashx', {
                                                                    mode: 'add',
                                                                    acc: $('#acc').val(),
                                                                    pwd: $('#pwd').val(),
                                                                    role_code: '3',
                                                                    name: $('#name').val(),
                                                                    id: $('#id').val(),
                                                                    unit: $('#unit_code').val(),
                                                                    rank: $('#rank_code').val(),
                                                                    tel: $('#tel').val(),
                                                                    cell: $('#cellphone').val(),
                                                                    mail: $('#mail').val(),
                                                                    ip: $('#ip').val(),
                                                                    byacc: $('#ctl00_ContentPlaceHolder1_TabContainer_TabPanel2_who').val(),
                                                                    option1: $('#ckb1')[0].checked,
                                                                    option2: $('#ckb2')[0].checked,
                                                                    option3: $('#ckb3')[0].checked,
                                                                    option4: $('#ckb4')[0].checked,
                                                                    option5: $('#ckb5')[0].checked
                                                                }, function (data, s) {
                                                                    if (s == 'success') {
                                                                        if (data["status"] == "done") {
                                                                            alert("帳號新增成功");
                                                                            $('#AddAccDiv :text').val('');
                                                                            $('#AddAccDiv :hidden').val('');
                                                                        }
                                                                        else {
                                                                            alert('資料庫發生錯誤');
                                                                        }
                                                                    }
                                                                    else {
                                                                        alert('帳號新增失敗');
                                                                    }
                                                                });

                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    alert('創建帳號不可使用與身份證字號相同的字串!!');
                }
                

            });


            //$('#byAcc').attr({ checked: "checked" });
            $('#findAcc').click(function() {
                if ($('#toFind').val() == '') {
                    alert('尚未輸入資料比對搜尋');
                }
                else {
                    $.postJson('Operations/Account.ashx', { mode: "find", type: "role3", value: $('#toFind').val() }, function(data, s) {
                        if (s == 'success') {
                            if (data["error"]) {
                                alert(data["error"]);
                                $('#EditAccDiv :text').val('');
                                $('#Checkbox1_u').attr({ checked: "" });
                                $('#Checkbox2_u').attr({ checked: "" });
                                $('#Checkbox3_u').attr({ checked: "" });
                                $('#Checkbox4_u').attr({ checked: "" });
                                $('#Checkbox5_u').attr({ checked: "" });
                            }
                            else {
                                $('#acc_u').val(data[0]["account"]);
                                $('#pwd_u').val(data[0]["password"]);
                                $('#name_u').val(data[0]["name"]);
                                $('#id_u').val(data[0]["id"]);
                                $('#unit_u').val(data[0]["unit_code"]);
                                $('#unit_u').next().next().val(data[0]["unit_code"]);
                                $('#rank_u').val(data[0]["rank_code"]);
                                $('#rank_u').next().next().val(data[0]["rank_code"]);
                                $('#tel_u').val(data[0]["tel"]);
                                $('#cell_u').val(data[0]["cellphone"]);
                                $('#mail_u').val(data[0]["mail"]);
                                $('#ip_u').val(data[0]["ip"]);

                            }
                        }
                    });

                    $('#EditAccDiv :checkbox').attr({ checked: "" });

                    $.postJson('Operations/Options.ashx', { mode: 'find', accName: $('#toFind').val() }, function(d, s) {

                        if (s == 'success') {
                            $.each($(d), function(index, item) {
                                if (item["optionCode"] == '1') {
                                    $('#Checkbox1_u').attr({ checked: "checked" });
                                }
                                if (item["optionCode"] == '2') {
                                    $('#Checkbox2_u').attr({ checked: "checked" });
                                }
                                if (item["optionCode"] == '3') {
                                    $('#Checkbox3_u').attr({ checked: "checked" });
                                }
                                if (item["optionCode"] == '4') {
                                    $('#Checkbox4_u').attr({ checked: "checked" });
                                }
                                if (item["optionCode"] == '5') {
                                    $('#Checkbox5_u').attr({ checked: "checked" });
                                }

                            });
                        }
                    });

                }

            });
            // update account data event
            $('#UpdateAccBtn').click(function() {

                if ($('#EditAccDiv :text').val() != '') {
                    if ($('#pwd_u').val() != '' && $('#pwd_u').next().html() == '') {
                        if ($('#id_u').val() != '' && $('#id_u').next().html() == '') {
                            if ($('#unit_u').val() != '') {
                                if ($('#rank_u').val() != '') {
                                    if ($('#name_u').val() != '') {
                                        $.postJson('Operations/Account.ashx', { mode: 'update', updater: $('#ctl00_OP_Value').val(), account: $('#acc_u').val(), password: $('#pwd_u').val(), name: $('#name_u').val(), id: $('#id_u').val(), rank_code: $('#rank_u').val(), unit_code: $('#unit_u').val(), tel: $('#tel_u').val(), cellphone: $('#cell_u').val(), mail: $('#mail_u').val(), ip: $('#ip_u').val()
                                        }, function(d, s) {
                                            if (s == 'success') {
                                                if (d["status"] == 'done') {
                                                    $.postJson('Operations/Options.ashx', {
                                                        mode: 'update',
                                                        accName: $('#acc_u').val(),
                                                        option1: $('#Checkbox1_u')[0].checked,
                                                        option2: $('#Checkbox2_u')[0].checked,
                                                        option3: $('#Checkbox3_u')[0].checked,
                                                        option4: $('#Checkbox4_u')[0].checked,
                                                        option5: $('#Checkbox5_u')[0].checked

                                                    }, function(data, status) {
                                                        if (status == 'success') {
                                                            alert('更新成功');
                                                        }
                                                    });


                                                }
                                            }
                                        });
                                    }
                                }
                            }
                        }
                    }
                }

            });
            // Delete Account
            $('#delAcc').click(function() {
                if ($('#acc_u').val() != '') {
                    $.postJson('Operations/Account.ashx', { mode: 'delete', updater: $('#ctl00_OP_Value').val(), account: $('#acc_u').val() }, function(data, s) {
                        if (s == 'success') {
                            if (data["status"] == "done") {
                                alert('刪除成功!');
                            }
                        }
                    });
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
    <asp:ScriptManager ID="SM1" runat="server">
    </asp:ScriptManager>
    <div>
        <ajaxToolkit:TabContainer ID="TabContainer" runat="server" CssClass="ajax__tab_yuitabview-theme">
            <ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="批次建立帳號">
                <ContentTemplate>
                    <div style="height: 534px">
                        <table id="demo">
                            <tr>
                                <td colspan="3">
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/AccCreate_b.txt" >下載範例檔案</asp:HyperLink><span>(註:本作業之使用者預設功能為團體報進功能)</span>
                                </td>
                            </tr>
                            <tr style="margin-top:5px">
                                <td>
                                    請選擇檔案
                                </td>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="button1" Text="確定" OnClick="button1_Click" />
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" PageSize = "25" 
                            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="#DCDCDC" />
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="TabPanel2" runat="server" HeaderText="新增一般管理者">
                <ContentTemplate>
                    <input type="hidden" id="who" runat="server" class="who" />
                    <div id="AddAccDiv" style="height: 534px">
                        <table>
                            <tbody>
                            <%--<tr><td colspan="2"><span id="rankinfo" style="cursor:pointer">級職對照表</span></td></tr>--%>
                                <tr>
                                    <td>
                                        帳號                    
                                    &nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                        <input id="acc" type="text" maxlength="20"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        密碼
                                    </td>
                                    <td>
                                        <input id="pwd" type="text" maxlength="16"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        姓名
                                    </td>
                                    <td>
                                        <input id="name" type="text" maxlength="5"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        身份字號
                                    </td>
                                    <td>
                                        <input type="text" id="id" maxlength="10" /><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        單位代碼
                                    </td>
                                    <td>
                                        <input type="text" id="unit_code" maxlength="5" onblur="this.value = this.value.toUpperCase();"/><span></span><input type="hidden">
                                    </td></tr><tr>
                                    <td>
                                        級職代碼<asp:HyperLink ID="HyperLink2" ForeColor="Blue" runat="server" NavigateUrl="javascript:void window.open('RankInfo.aspx','','left=800,top=0,scrollbars=yes,width=150,height=500,location=no')">對照表</asp:HyperLink>
                                    </td>
                                    <td>
                                        <input type="text" id="rank_code" maxlength="2"/><span></span><input type="hidden"><br /></td>
                                </tr>
                                <tr>
                                    <td>
                                        電話號碼
                                    </td>
                                    <td>
                                        <input type="text" id="tel" maxlength="20"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        手機號碼
                                    </td>
                                    <td>
                                        <input type="text" id="cellphone" maxlength="15"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        電子郵件
                                    </td>
                                    <td>
                                        <input type="text" id="mail" maxlength="20"/><span>@webmail.mil.tw</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        IP位址
                                    </td>
                                    <td>
                                        <input type="text" id="ip" maxlength="15"/><span></span>
                                    </td>
                                </tr>
                                <%--optionArea--%>
                                <tr>
                                    <td colspan="2">
                                        1.<input type="checkbox" id="ckb1" />團報功能 2.<input type="checkbox" id="ckb2" />最新消息功能
                                        3.<input type="checkbox" id="ckb3" />意見管理功能 4.<input type="checkbox" id="ckb4" />討論區功能<br />
                                        5.<input type="checkbox" id="ckb5" />鑑測站資訊
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <input id="AddAcc" type="button" value="確定" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="TabPanel3" runat="server" HeaderText="一般管理者維護">
                <ContentTemplate>
                    <div id="EditAccDiv" style="height: 534px">
                        <table>
                            <tr>
                                <td>
                                    輸入帳號
                                </td>
                                <td style="display: none">
                                    <span>依身份字號</span><input type="checkbox" id="byId" />
                                </td>
                                <td>
                                    <input type="text" id="toFind" />
                                </td>
                                <td>
                                    <input type="button" id="findAcc" value="搜尋" />
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tbody>
                                <tr>
                                    <td>
                                        帳號
                                    </td>
                                    <td>
                                        <input type="text" id="acc_u" disabled="disabled" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        密碼
                                    </td>
                                    <td>
                                        <input type="text" id="pwd_u" maxlength="16"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        姓名
                                    </td>
                                    <td>
                                        <input type="text" id="name_u" maxlength="5"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        身份字號
                                    </td>
                                    <td>
                                        <input type="text" id="id_u" maxlength="10"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        單位代碼
                                    </td>
                                    <td>
                                        <input type="text" id="unit_u" disabled="disabled"/><span></span><input type="hidden" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        級職代碼<asp:HyperLink ID="HyperLink3" ForeColor="Blue" runat="server" NavigateUrl="javascript:void window.open('RankInfo.aspx','','left=800,top=0,scrollbars=yes,width=150,height=500,location=no')">對照表</asp:HyperLink>
                                    </td>
                                    <td>
                                        <input type="text" id="rank_u" maxlength="2"/><span></span><input type="hidden" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        電話號碼
                                    </td>
                                    <td>
                                        <input type="text" id="tel_u" maxlength="20"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        行動電話
                                    </td>
                                    <td>
                                        <input type="text" id="cell_u" maxlength="15"/><span></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        電子郵件
                                    </td>
                                    <td>
                                        <input type="text" id="mail_u" maxlength="20"/><span>@webmail.mil.tw</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        IP位址
                                    </td>
                                    <td>
                                        <input type="text" id="ip_u" maxlength="15"/><span></span>
                                    </td>
                                </tr>
                                <%--updateOptionArea--%>
                                <tr>
                                    <td colspan="2">
                                        1.<input type="checkbox" id="Checkbox1_u" />團報功能 2.<input type="checkbox" id="Checkbox2_u" />最新消息功能
                                        3.<input type="checkbox" id="Checkbox3_u" />意見管理功能 4.<input type="checkbox" id="Checkbox4_u" />討論區功能<br />
                                        5.<input type="checkbox" id="Checkbox5_u" />鑑測站資訊
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right">
                                    <input type="button" id="delAcc" value="刪除帳號" />
                                        <input id="UpdateAccBtn" type="button" value="更新" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        </ajaxToolkit:TabContainer>
    </div>
</asp:Content>
