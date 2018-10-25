<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegUser.aspx.cs" Inherits="RegUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">   
<head>
<title>國軍基本體能鑑測網</title>
    <link id="Login_css" rel="stylesheet" href="RegUser.css" type="text/css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript" src="Script/RankCode.ashx"></script>

    <script type="text/javascript">
        //blur事件：失去焦點時觸發
        $(function() {
            $('#idNum').blur(function() {
                $.postJson('GetValueByCode.ashx', { mode: 'playerExist', value: $('#idNum').val() }, function(data, s) {
                    if (s == 'success') {
                        if (data["status"] == "true") {
                            debugger;
                            $('#idNum').parent().next().html('此身份證已經存在');
                        }
                        else {
                            $('#idNum').next().html('');
                        }
                    }
                });

            });

            $('#password').blur(function () {
                var patten = /^(?=.*\d)(?=.*[a-z])(?=.*[\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\:\;\,\.\<\>\\\|\/\?\~\`\x22\x27]).{1,16}$/;
                if ($(this).val() != '') {
                    if ($(this).val().length < 8) {
                        $(this).parent().next().html('密碼長度不夠');
                    }
                    else {
                        var valid = patten.test($(this).val());
                        if (!valid) {
                            $(this).parent().next().html('密碼組合錯誤, 須包含英數字與特殊字元, 如@#$');
                        }
                        else {
                            $(this).parent().next().html('');
                        }
                    }
                }
            });

            $('#password_confirm').blur(function () {
                var patten = /^(?=.*\d)(?=.*[a-z])(?=.*[\!\@\#\$\%\^\&\*\(\)\_\+\-\=\[\]\{\}\:\;\,\.\<\>\\\|\/\?\~\`\x22\x27]).{1,16}$/;
                if ($(this).val() != '') {
                    if ($(this).val().length < 8) {
                        $(this).parent().next().html('密碼長度不夠');
                    }
                    else {
                        var valid = patten.test($(this).val());
                        if (!valid) {
                            $(this).parent().next().html('密碼組合錯誤, 須包含英數字與特殊字元, 如@#$');
                        }
                        else {
                            if($(this).val() == $('#password').val())
                            {
                                $(this).parent().next().html('');
                            }
                            else
                            {
                                $(this).parent().next().html('確認密碼不正確');
                            }
                        }
                    }
                }
            });

            $('#idNum').blur(function() {
                if (!checkID($(this).val())) {
                    $(this).parent().next().html('格式錯誤');
                }
                if (checkID($(this).val())) {
                    $(this).parent().next().html('');
                }
            });

            $('#unit_code').blur(function() {
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

            $('#mail').click(function() {
                $(this).val('');
            });

            $('#rank_code').blur(function() {


                var _code = $('#rank_code').val();
                var _rank = GetRank(_code);

                if (!_rank) {
                    $('#rank_code').parent().next().html('無此級職');
                }
                else {
                    $('#rank_code').parent().next().html(_rank);
                    //$('#')
                }

            });

            $('#rankmap').click(function() {
                window.open('RankInfo.aspx', '', 'left=100,top=0,scrollbars=yes,width=1024,height=650,location=no');
            });



            $('#AddAcc').click(function() {
                if ($('#idNum').val() != '' && $('#idNum').parent().next().html() == '') {
                    if ($('#unit_code').val() != '' && $('#unit_code').parent().next().html() != '無此單位') {
                        if ($('#rank_code').val() != '' && $('#rank_code').parent().next().html() != '無此級職') {
                            if ($('#name').val() != '') {
                                if ($('#birth').val() != '') {
                                    if ($('#mail').val() != '') {
                                        if ($('#password').val() != '' && $('#password').parent().next().html() == '') {
                                            if ($('#password_confirm').val() != '' && $('#password_confirm').parent().next().html() == '') {
                                                if (confirm('下列為您註冊的資料，請再次檢查是否正確。\n身份證字號：' + $('#idNum').val() + '\n中文姓名：' + $('#name').val() + '\n生日(民國)：' + $('#birth').val() + '\n單位代碼：' + $('#unit_code').val() + '\n級職代碼：' + $('#rank_code').val() + '\nMail帳號：' + $('#mail').val())) {
                                                    $.postJson('Operations/Player.ashx', {
                                                        mode: 'add',
                                                        id: $('#idNum').val(),
                                                        birth: $('#birth').val(),
                                                        name: $('#name').val(),
                                                        unit_code: $('#unit_code').val(),
                                                        rank_code: $('#rank_code').val(),
                                                        mail: $('#mail').val(),
                                                        password: $('#password').val()
                                                    }, function (data, s) {
                                                        if (s == 'success') {
                                                            if (data["status"] == "done") {
                                                                alert("受測人員註冊成功");
                                                                $('#AddAccDiv :text').val('');
                                                                $('#AddAccDiv :password').val('');
                                                            }
                                                            else {
                                                                alert(data["status"]);
                                                            }
                                                        }
                                                        else {
                                                            alert('帳號新增失敗');
                                                        }
                                                    });
                                                }
                                            } else { alert('請檢查確認密碼'); }
                                        } else { alert('請檢查密碼'); }
                                    } else { alert('請輸入mail'); }
                                } else { alert('請輸入生日'); }
                            } else { alert('請輸入姓名'); }
                        } else { alert('請檢查級職'); }
                    } else { alert('請檢查單位'); }
                }
                else {
                    alert('資料未完整 !');
                }
            });
        });

        function checkID(id) {
            tab = "ABCDEFGHJKLMNPQRSTUVXYWZIO"
            A1 = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3);
            A2 = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5);
            Mx = new Array(9, 8, 7, 6, 5, 4, 3, 2, 1, 1);
            var exId = id.substr(0, 5);
            if (id.length != 10) return false;
            if (exId.indexOf('01000')>-1) return true;
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
</head>
<body>
<center>
    <form id="form1" runat="server" submitdisabledcontrols="False">
    <div class="head_back_index">
    <a href="index.aspx">&nbsp;: : : 回首頁</a>
    </div>
    <div class="head_space_div"> 
    </div>
    <div class="head_div">  
        &nbsp;: : : 現在位置﹥受測人員註冊
    </div>
    <div class="content_div">
    <div class="content_left_div">
        <div class="content_left_top">
        &nbsp;&nbsp;&nbsp; 國軍基本體能鑑測網 - 受測人員註冊</div>
        <div id="AddAccDiv" class="content_left_bottom" style="margin-top:10px">
            <table>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">身份證字號：</td>
                    <td class="td_center">
                        <input id="idNum" type="text" maxlength="10" onblur="this.value = this.value.toUpperCase();"/><span></span>
                    </td>
                    <td class="td_right">
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">密碼(8-16碼)：</td>
                    <td class="td_center">
                        <input id="password" type="password" maxlength="16" /><span></span>
                    </td>
                    <td class="td_right">
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                 <tr>
                    <td class="td_left">確認密碼：</td>
                    <td class="td_center">
                        <input id="password_confirm" type="password" maxlength="16"/><span></span>
                    </td>
                    <td class="td_right">
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">
                        中文姓名：</td>
                    <td class="td_center">
                        <input id="name" type="text" maxlength="5" /><span></span>
                    </td>
                    <td class="td_right">
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">
                        生日(民國)：</td>
                    <td class="td_center">
                        <input id="birth" type="text" maxlength="9" />
                    </td>
                    <td class="td_right">如民國72年3月1日，應輸入72/3/1
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">
                        單位代碼：</td>
                    <td class="td_center">
                        <input id="unit_code" type="text" maxlength="5" onblur="this.value = this.value.toUpperCase();" /><span></span>
                    </td>
                    <td class="td_right">
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">
                        級職代碼<asp:HyperLink ID="HyperLink1" ForeColor="Blue" runat="server" NavigateUrl="javascript:void window.open('RankInfo.aspx','','left=800,top=0,scrollbars=yes,width=150,height=500,location=no')">對照表</asp:HyperLink>：</td>
                    <td class="td_center">
                        <input id="rank_code" type="text" maxlength="2" /><span></span>
                    </td>
                    <td class="td_right">
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">
                        Mail帳號：</td>
                    <td class="td_center">
                        <input id="mail" type="text" maxlength="20" />
                    </td>
                    <td class="td_right">@webmail.mil.tw
                    </td>
                </tr>
                <tr>
                    <td class="td_space_left">
                     </td>
                     <td class="td_space_center">
                     </td>                   
                    <td class="td_space_right">
                     </td>
                </tr>
                <tr>
                    <td class="td_left">
                    </td>
                    <td class="td_center">
                        <input id="AddAcc" type="button" value="確認" />
                        </td>
                     <td class="td_right">
                    </td>
                </tr>
                 <tr>
                    <td class="td_left">
                    </td>
                    <td class="td_center" colspan="2">
                        <li>密碼至少8個字元，至多16個字元。</li>
                    </td>
                </tr>
                 <tr>
                    <td class="td_left">
                    </td>
                    <td class="td_center" colspan="2">
                        <li>不能全為英文字母或全為數字。</li>
                    </td>
                </tr>
                 <tr>
                    <td class="td_left">
                    </td>
                    <td class="td_center" colspan="2">
                       <li>英文字母區分大小寫，例如A與a視為不同字母。</li>
                    </td>
                </tr>
                 <tr>
                    <td class="td_left">
                    </td>
                    <td class="td_center" colspan="2">
                         <li>密碼中不能包含空格。</li>
                    </td>
                </tr>
                 <tr>
                    <td class="td_left">
                    </td>
                    <td class="td_center" colspan="2">
                        <li>密碼須包含至少1個特殊字元(例如@#$等)。</li>
                    </td>
                </tr>
            </table>
        </div>      
    </div>
        
   </div>
    </form>
    </center>
</body>
</html>
