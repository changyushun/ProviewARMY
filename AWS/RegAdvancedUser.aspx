<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegAdvancedUser.aspx.cs" Inherits="RegAdvancedUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>國軍基本體能鑑測網</title>
    <link id="Login_css" rel="stylesheet" href="RegAdvancedUser.css" type="text/css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript" src="Script/RankCode.ashx"></script>

    <script type="text/javascript">
        $(function() {
            //#region Add Account Scrip Block
            $('#AddAccDiv span, #EditAccDiv span').css({ "color": "red" });
            
            $('#id').blur(function() {
                $.postJson('GetValueByCode.ashx', { mode: 'askaccExist', value: $('#id').val() }, function(data, s) {
                    if (s == 'success') {
                        if (data["status"] == "true") {
                            $('#id').parent().next().html('已有一筆申請待審核');
                            //$('#id').next().html('已有一筆申請待審核');
                        }
                        else {
                            //$('#id').parent().next().html('');
                            //$('#id').next().html('');
                        }
                    }
                });
            });
            
            //$('#id').blur(function() {
             //   if (!checkID($(this).val())) {
             //       $(this).next().html('格式錯誤');
             //   }
             //   if (checkID($(this).val())) {
             //       $(this).next().html('');
             //   }
            //});
            
            $('#id').blur(function() {
                if (!checkID($(this).val())) {
                    $(this).parent().next().html('格式錯誤');
                }
                if (checkID($(this).val())) {
                    $(this).parent().next().html('');
                }
            });


            $('#unit_code').blur(function() {
            $.postJson('GetValueByCode.ashx', { mode: 'parent_unit', value: $(this).val() }, function(data, s) {
                if (s == 'success') {
                    if (data["status"] == "") {
                            $("#unit_code").parent().next().html('此單位目前不接受申請')
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


            $('#rank_u').blur(function() {


                var _code = $('#rank_u').val();
                var _rank = GetRank(_code);

                if (!_rank) {
                    $('#rank_u').parent().next().html('無此級職');
                }
                else {
                    $('#rank_u').parent().next().html(_rank);
                }

            });

            $('#AddAcc').click(function() {
            //alert($('.who').val());  $('#unit_code').next().html() != '此單位目前不接受申請'
            if ($('#id').val() != '' && $('#id').parent().next().html() == '') {
                if ($('#unit_code').val() != '' && $('#unit_code').parent().next().html() != '此單位目前不接受申請') {
                    if ($('#rank_u').val() != '' && $('#rank_u').parent().next().html() != '無此級職') {
                                    if ($('#name').val() != '') {
                                        if ($('#tel').val() != '') {
                                            if ($('#cellphone').val != '') {
                                                if ($('#mail').val() != '') {
                                                    if ($('#ip').val() != '') {
                                                        //alert($('#rank_code').next().next().val());
                                                        $.postJson('Operations/Account.ashx', {
                                                            mode: 'ask',
                                                            id: $('#id').val(),
                                                            unit_code: $('#unit_code').val(),
                                                            rank_code: $('#rank_u').val(),
                                                            name: $('#name').val(),
                                                            tel: $('#tel').val(),
                                                            cellphone: $('#cellphone').val(),
                                                            mail: $('#mail').val(),
                                                            ip: $('#ip').val()
                                                        }, function(data, s) {
                                                            if (s == 'success') {
                                                                if (data["status"] == "done") {
                                                                    alert("帳號新增成功");
                                                                    $('#AddAccDiv :text').val('');
                                                                    $('#AddAccDiv :hidden').val('');
                                                                }
                                                                else {
                                                                    alert('申請失敗,請確認資料');
                                                                }
                                                            }
                                                            else {
                                                                alert('申請失敗,請確認資料');
                                                            }
                                                        });
                                                    }
                                                    else {alert('請輸入ip');}                                                        
                                                }else {alert('請輸入mail');}
                                            }else {alert('請輸入行動電話');}
                                        }else {alert('請輸入聯絡電話');}
                                    } else { alert('資料未完整 !'); }
                                } else { alert('資料未完整 !'); }
                            } else { alert('資料未完整 !'); }
                        }
                    else 
                    {
                        alert('資料未完整 !');
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
</head>
<body>
<center>
    <form id="form1" runat="server" submitdisabledcontrols="False">
    <div class="head_back_index">
    <a href="index.aspx">: : : 回首頁</a>
    </div>
    <div class="head_space_div"> 
    </div>
    <div class="head_div">  
        &nbsp;: : : 現在位置﹥進階使用者申請
    </div>
    <div class="content_div">
    <div class="content_left_div">
        <div class="content_left_top">
        &nbsp;&nbsp;&nbsp; 國軍基本體能鑑測網 - 進階使用者申請</div>
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
                        <input id="id" type="text" maxlength="10" onblur="this.value = this.value.toUpperCase();"/><span></span>
                    </td>
                    <td class="td_right"></td>
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
                        <input id="name" type="text" maxlength="5"/><span></span>
                    </td>
                    <td class="td_right"></td>
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
                        <input id="unit_code" type="text" maxlength="5" onblur="this.value = this.value.toUpperCase();"/><span></span>
                    </td>
                    <td class="td_right"></td>
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
                    <input id="rank_u" type="text" maxlength="2"/><span></span>
                    </td>
                    <td class="td_right"></td>
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
                        <input id="mail" type="text" maxlength="20"/>      
                    </td>
                    <td class="td_right">@Webmail.mil.tw</td>
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
                        電話號碼：</td>
                    <td class="td_center">
                        <input id="tel" type="text" maxlength="20"/>      
                    </td>
                    <td class="td_right"></td>
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
                        行動電話：</td>
                    <td class="td_center">
                        <input id="cellphone" type="text" maxlength="15"/>      
                    </td>
                    <td class="td_right"></td>
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
                        IP位址：</td>
                    <td class="td_center">
                        <input id="ip" type="text" maxlength="15"/>      
                    </td>
                    <td class="td_right"></td>
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
                        <input id="AddAcc" type="button" value="確定" /></td>
                     <td class="td_right"></td>
                </tr>
            </table>
        </div>
    </div>
    </div>
    </form>
    </center>
</body>
</html>
