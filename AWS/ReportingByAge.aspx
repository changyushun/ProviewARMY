<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportingByAge.aspx.cs" Inherits="ReportingByAge" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>年齡成績統計</title>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#resultTable td, #resultTable th, #resultTable tr, #resultTable').attr({ style: "border:solid 1px black" });

            $('#calculate').click(function() {
                $('#resultTable tbody tr').remove(); // 先將先前資料清空
                $('#GridView1 tr').each(function(index) {
                    if (index != 0) {
                        var unit_title = $(this).find('td:eq(0)').text();
                        $.postJson('Operations/Result.ashx', { type: 'age', unit_code: $(this).find('td:eq(1)').text(), date_start: $('#date_start').val(), date_stop: $('#date_stop').val() }, function(data, status) {
                            if (status == 'success') {
                                //alert(data[0]["pass_19_22"]);
                                // Main Data
                                var row = $('<tr></tr>');
                                row.append('<td rowspan="2">' + unit_title + '</td>');
                                row.append('<td>男</td>');
                                row.append('<td>' + data[0]["count_19_22"] + '</td>');
                                row.append('<td>' + data[0]["pass_19_22"] + '</td>');
                                row.append('<td>' + data[0]["rate_19_22"] + '</td>');
                                row.append('<td>' + data[0]["count_23_26"] + '</td>');
                                row.append('<td>' + data[0]["pass_23_26"] + '</td>');
                                row.append('<td>' + data[0]["rate_23_26"] + '</td>');
                                row.append('<td>' + data[0]["count_27_30"] + '</td>');
                                row.append('<td>' + data[0]["pass_27_30"] + '</td>');
                                row.append('<td>' + data[0]["rate_27_30"] + '</td>');
                                row.append('<td>' + data[0]["count_31_34"] + '</td>');
                                row.append('<td>' + data[0]["pass_31_34"] + '</td>');
                                row.append('<td>' + data[0]["rate_31_34"] + '</td>');
                                row.append('<td>' + data[0]["count_35_38"] + '</td>');
                                row.append('<td>' + data[0]["pass_35_38"] + '</td>');
                                row.append('<td>' + data[0]["rate_35_38"] + '</td>');
                                row.append('<td>' + data[0]["count_39_42"] + '</td>');
                                row.append('<td>' + data[0]["pass_39_42"] + '</td>');
                                row.append('<td>' + data[0]["rate_39_42"] + '</td>');
                                row.append('<td>' + data[0]["count_43_46"] + '</td>');
                                row.append('<td>' + data[0]["pass_43_46"] + '</td>');
                                row.append('<td>' + data[0]["rate_43_46"] + '</td>');
                                row.append('<td>' + data[0]["count_47_50"] + '</td>');
                                row.append('<td>' + data[0]["pass_47_50"] + '</td>');
                                row.append('<td>' + data[0]["rate_47_50"] + '</td>');
                                row.append('<td>' + data[0]["count_51_54"] + '</td>');
                                row.append('<td>' + data[0]["pass_51_54"] + '</td>');
                                row.append('<td>' + data[0]["rate_51_54"] + '</td>');
                                row.append('<td>' + data[0]["count_55_58"] + '</td>');
                                row.append('<td>' + data[0]["pass_55_58"] + '</td>');
                                row.append('<td>' + data[0]["rate_55_58"] + '</td>');
                                row.append('<td>' + data[0]["count_59"] + '</td>');
                                row.append('<td>' + data[0]["pass_59"] + '</td>');
                                row.append('<td>' + data[0]["rate_59"] + '</td>');
                                row.append('<td>' + data[0]["overall"] + '</td>');
                                row.append('<td>' + data[0]["overall_pass"] + '</td>');
                                row.append('<td>' + data[0]["overall_rate"] + '</td>');

                                $('#resultTable tbody').append(row).find('td').attr({ style: "border:solid 1px black" });

                                var row2 = $('<tr></tr>');
                                row2.append('<td>女</td>');
                                row2.append('<td>' + data[1]["count_19_22"] + '</td>');
                                row2.append('<td>' + data[1]["pass_19_22"] + '</td>');
                                row2.append('<td>' + data[1]["rate_19_22"] + '</td>');
                                row2.append('<td>' + data[1]["count_23_26"] + '</td>');
                                row2.append('<td>' + data[1]["pass_23_26"] + '</td>');
                                row2.append('<td>' + data[1]["rate_23_26"] + '</td>');
                                row2.append('<td>' + data[1]["count_27_30"] + '</td>');
                                row2.append('<td>' + data[1]["pass_27_30"] + '</td>');
                                row2.append('<td>' + data[1]["rate_27_30"] + '</td>');
                                row2.append('<td>' + data[1]["count_31_34"] + '</td>');
                                row2.append('<td>' + data[1]["pass_31_34"] + '</td>');
                                row2.append('<td>' + data[1]["rate_31_34"] + '</td>');
                                row2.append('<td>' + data[1]["count_35_38"] + '</td>');
                                row2.append('<td>' + data[1]["pass_35_38"] + '</td>');
                                row2.append('<td>' + data[1]["rate_35_38"] + '</td>');
                                row2.append('<td>' + data[1]["count_39_42"] + '</td>');
                                row2.append('<td>' + data[1]["pass_39_42"] + '</td>');
                                row2.append('<td>' + data[1]["rate_39_42"] + '</td>');
                                row2.append('<td>' + data[1]["count_43_46"] + '</td>');
                                row2.append('<td>' + data[1]["pass_43_46"] + '</td>');
                                row2.append('<td>' + data[1]["rate_43_46"] + '</td>');
                                row2.append('<td>' + data[1]["count_47_50"] + '</td>');
                                row2.append('<td>' + data[1]["pass_47_50"] + '</td>');
                                row2.append('<td>' + data[1]["rate_47_50"] + '</td>');
                                row2.append('<td>' + data[1]["count_51_54"] + '</td>');
                                row2.append('<td>' + data[1]["pass_51_54"] + '</td>');
                                row2.append('<td>' + data[1]["rate_51_54"] + '</td>');
                                row2.append('<td>' + data[1]["count_55_58"] + '</td>');
                                row2.append('<td>' + data[1]["pass_55_58"] + '</td>');
                                row2.append('<td>' + data[1]["rate_55_58"] + '</td>');
                                row2.append('<td>' + data[1]["count_59"] + '</td>');
                                row2.append('<td>' + data[1]["pass_59"] + '</td>');
                                row2.append('<td>' + data[1]["rate_59"] + '</td>');
                                row2.append('<td>' + data[1]["overall"] + '</td>');
                                row2.append('<td>' + data[1]["overall_pass"] + '</td>');
                                row2.append('<td>' + data[1]["overall_rate"] + '</td>');

                                $('#resultTable tbody').append(row2).find('td').attr({ style: "border:solid 1px black" });

                            }
                        });
                    }
                });

            });
        });

        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField ID="account" runat="server" />
    <div>
        <table>
            <tr>
                <td style="border: solid 1px black">
                    <asp:Menu ID="Menu1" runat="server" OnMenuItemClick="Menu1_MenuItemClick">
                    </asp:Menu>
                </td>
                <td rowspan="4" style="border: solid 1px black;text-align:center;vertical-align:top">
                <div style="margin-top:1px;top:1px;background-color:#FDF5E6">
                <table id="resultTable" style="margin-top:1px;padding-top:1px">
                        <thead>
                            <tr>
                                <th colspan="38" align="center">
                                    國軍體能測驗年齡成績分析統計表
                                </th>
                            </tr>
                            <tr>
                                <td colspan="2" rowspan="2" style="width: 50px;border:solid 1px black">
                                </td>
                                <td colspan="3">
                                    19-22歲
                                </td>
                                <td colspan="3">
                                    23-26歲
                                </td>
                                <td colspan="3">
                                    27-30歲
                                </td>
                                <td colspan="3">
                                    31-34歲
                                </td>
                                <td colspan="3">
                                    35-38歲
                                </td>
                                <td colspan="3">
                                    39-42歲
                                </td>
                                <td colspan="3">
                                    43-46歲
                                </td>
                                <td colspan="3">
                                    47-50歲
                                </td>
                                <td colspan="3">
                                    51-54歲
                                </td>
                                <td colspan="3">
                                    55-58歲
                                </td>
                                <td colspan="3">
                                    59歲
                                </td>
                                <td colspan="3">小計</td>
                            </tr>
                            <tr>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            <td>人數</td>
                            <td>合格數</td>
                            <td>合格率</td>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                    
                </td>
            </tr>
            <tr>
                <td style="border: solid 1px black">
                    <asp:GridView ID="GridView1" runat="server">
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="border: solid 1px black">
                    <asp:Button ID="Button1" runat="server" Text="重選" OnClick="Button1_Click" />
                </td>
            </tr>
            <tr>
                <td style="border: solid 1px black">
                    <table>
                        <tr>
                            <td>
                                開始日期
                            </td>
                            <td>
                                <input type="text" id="date_start" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                結束日期
                            </td>
                            <td>
                                <input type="text" id="date_stop" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="button" value="成績統計" id="calculate" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
