<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CenterSch.aspx.cs" Inherits="CenterSch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>行事曆管理</title>
    <style type="text/css">
        .tr {
            border: solid 1px black;
        }

        .td {
            border: solid 1px black;
        }

        .auto-style1 {
            height: 23px;
        }
    </style>

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript">
        $(function () {

            $('#new').keydown(function (e) {
                if (e.keyCode == 13) {
                    $.postJson('GetValueByCode.ashx', { mode: 'changelimit', sid: $('#centerCode').val(), value: $(this).val(), who: $('#OP_Value').val() }, function (d, s) {
                        if (s == 'success') {
                            if (d["status"] == 'done') {
                                alert('更改成功');
                                $('#form1')[0].submit();
                            }
                        }
                    });
                    $('#limit').val($(this).val());
                }
            });

            $('#updatelimit').click(function () {
                $.postJson('GetValueByCode.ashx', { mode: 'changelimit', sid: $('#centerCode').val(), value: $('#new').val(), who: $('#OP_Value').val() }, function (d, s) {
                    if (s == 'success') {
                        if (d["status"] == 'done') {
                            alert('更改成功');
                            $('#form1')[0].submit();
                        }
                    }
                    else {
                        alert('無法更改');
                    }
                });
                $('#limit').val($('#new').val());
            });

            $('#updatestatus').click(function () {
                $.postJson('GetValueByCode.ashx', { mode: 'changestatus', sid: $('#centerCode').val(), who: $('#OP_Value').val() }, function (d, s) {
                    if (s == 'success') {
                        if (d["status"] == 'done') {
                            alert('更改成功');
                            $('#form1')[0].submit();
                        }
                    }
                    else {
                        alert('無法更改');
                    }
                });
            });

            $('#updateswin').click(function () {
                $.postJson('GetValueByCode.ashx', { mode: 'changeswin', sid: $('#centerCode').val(), who: $('#OP_Value').val() }, function (d, s) {
                    if (s == 'success') {
                        if (d["status"] == 'done') {
                            alert('更改成功');
                            $('#form1')[0].submit();
                        }
                    }
                    else {
                        alert('無法更改');
                    }
                });
            });

            $('#setCenterLimit').click(function () {
                $.postJson('GetValueByCode.ashx', { mode: 'setCenterlimit', sid: $('#centerCode').val(), date: $('#date').val(), limit: $('#txtLimit').val(), who: $('#OP_Value').val() }, function (d, s) {
                    if (s == 'success') {
                        if (d["status"] == 'done') {
                            alert('更改成功');
                            $('#form1')[0].submit();
                        }
                    }
                    else {
                        alert('無法更改');
                    }
                });

            });

            $.postJson('GetValueByCode.ashx', { mode: 'center', value: $('#centerCode').val() }, function (data, s) {
                $('#center').html(data[0]['center_name']);
            });

            $('#GW tr').each(function (index) {
                //$(this).find('td:eq(3)').append('<span style="cursor:hand">確定</span>');
                $(this).find('td:eq(4)').append('<input type="button" value="刪除" style="cursor:hand;background-color:Gold;color:Red;font-size:16px"></input>');
            });

            $('#GW tr').each(function () {
                $(this).find('input').click(function () {
                    if (confirm('確認 「刪除」?')) {
                        var id = $(this).parent().parent().find('td:eq(5)').html();
                        var _row = $(this).parent().parent();
                        $.postJson('GetValueByCode.ashx', { mode: 'deletesch', value: id, op_id: $('#OP_Value').val() }, function (d, s) {
                            if (s == 'success') {
                                if (d["status"] == 'done') {
                                    _row.hide();
                                    location.replace(location.href);
                                    //alert('刪除完成');
                                }
                                else {
                                    alert(d["status"]);
                                }
                            }
                        });
                    }
                    else {
                        return false;
                    }
                });
            });

            $('#chkAllow').click(function () {
                $('#chkDeny').attr({ checked: "" });
                $(this).attr({ checked: "checked" });
            });
            $('#chkDeny').click(function () {
                $('#chkAllow').attr({ checked: "" });
                $(this).attr({ checked: "checked" });
            });
            $('#confirm').click(function () {
                $.postJson('Operations/Schedule.ashx', {
                    mode: 'add',
                    center_code: $('#centerCode').val(),
                    op_id: $('#OP_Value').val(),
                    //type: 1,
                    date: $('#date').val(),
                    note: null,
                    log: null
                }, function (data, s) {
                    if (s == 'success') {
                        $('#form1')[0].submit();
                        alert('新增成功 !');
                    }
                });
            });
        });
        function confirm_onclick() {

        }
        function clicktest(msg) {
            var work = document.getElementById('<%=selDate.ClientID%>').value;
            if (confirm(msg)) {
                $.postJson('Operations/Schedule.ashx', {
                    mode: 'add',
                    center_code: $('#centerCode').val(),
                    op_id: $('#OP_Value').val(),
                    //type: 1,
                    date: $('#date').val(),
                    note: null,
                    log: null
                }, function (data, s) {
                    if (s == 'success') {
                        //alert('新增成功 !');
                        $('#form1')[0].submit();
                    }
                });
            }
            else {
                return false;
            }
            
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="selDate" runat="server" />
        <asp:HiddenField ID="OP_Value" runat="server" />
        <div>
            <center>
                <table class="td">
                    <tr class="tr">
                        <td>
                            <span id="center"></span>
                        </td>
                        <td>
                            <asp:HiddenField ID="centerCode" runat="server" />
                        </td>
                        <td></td>
                    </tr>
                    <tr class="tr">
                        <td>服務狀態 :
                            <asp:Label ID="status" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            <input type="button" id="updatestatus" value="變更" onclick="return confirm_onclick()" />
                        </td>
                    </tr>
                    <tr class="tr">
                        <td>預設上限人數 :
                            <asp:Label ID="limit" runat="server" Text=""></asp:Label>
                        </td>
                        <td>更改人數 : 
            <input type="text" id="new" style="width: 40px" />
                        </td>
                        <td>
                            <input type="button" id="updatelimit" value="確定" onclick="return confirm_onclick()" />
                        </td>
                    </tr>
                    <tr class="tr">
                        <td>游泳池 :
                            <asp:Label ID="swin" runat="server" Text=""></asp:Label>
                        </td>
                        <td>
                            <input type="button" id="updateswin" value="變更" onclick="return confirm_onclick()" />
                        </td>
                    </tr>
                    <tr class="tr">
                        <td colspan="3">
                            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black"
                                BorderStyle="Solid" CellSpacing="1" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black"
                                Height="250px" NextPrevFormat="ShortMonth" Width="330px" OnSelectionChanged="Calendar1_SelectionChanged1"
                                OnDayRender="Calendar1_DayRender">
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <WeekendDayStyle BackColor="#666666" />
                                <TodayDayStyle BackColor="Aqua" ForeColor="#000099" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <DayStyle BackColor="#CCCCCC" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="White" />
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                <TitleStyle BackColor="#333399" BorderStyle="Solid" Font-Bold="True" Font-Size="12pt"
                                    ForeColor="White" Height="12pt" />
                            </asp:Calendar>
                        </td>
                    </tr>
                    <tr style="background-color: Gray">
                        <td class="auto-style1">選取日期
                        </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="date" runat="server" Width="80px"></asp:TextBox>
                        </td>
                        <td class="auto-style1"></td>
                    </tr>
                    <%--<tr class="tr" style="background-color:Navy;color:White">
                <td>
                    <span>上班關閉</span><input id="chkDeny" type="checkbox" />
                </td>
                <td>
                    <span>假日開放</span><input id="chkAllow" type="checkbox" />
                </td>
                <td>
                <input type="button" id="confirm" value="確定" onclick="return confirm_onclick()" />
                </td>
            </tr>--%>

                    <tr style="background-color: Green; color: White">
                        <td>該日上限人數</td>
                        <td>
                            <asp:TextBox ID="txtLimit" runat="server" Width="80px"></asp:TextBox>
                        </td>
                        <td>
                            <input type="button" id="setCenterLimit" value="更新" onclick="return confirm_onclick()" />
                        </td>
                    </tr>


                </table>
                <table>
                    <tr>
                        <td>
                            <asp:GridView ID="GW" runat="server" OnDataBound="GW_DataBound" OnRowDataBound="GW_OnRowDataBound">
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
