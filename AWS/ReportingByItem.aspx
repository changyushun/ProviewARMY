<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportingByItem.aspx.cs"
    Inherits="ReportingByItem" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>項目成績統計</title>

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript">
        $(function() {
            $('#resultTable td, #resultTable th, #resultTable tr, #resultTable').attr({ style: "border:solid 1px black" });

            $('#calculate').click(function() {
                $('#resultTable tbody tr').remove(); // 先將先前資料清空
                $('#GridView1 tr').each(function(index) {
                    if (index != 0) {
                        var unit_title = $(this).find('td:eq(0)').text();
                        $.postJson('Operations/Result.ashx', { type:'item', unit_code: $(this).find('td:eq(1)').text(), date_start: $('#date_start').val(), date_stop: $('#date_stop').val() }, function(data, status) {
                            if (status == 'success') {
                                // Male Data
                                var overall_players = data[0]["overall_players"]; //應測數
                                var row = $('<tr></tr>');
                                row.append('<td rowspan="2">' + unit_title + '</td>');
                                row.append('<td>男</td>');
                                // 仰臥起坐
                                row.append('<td>' + overall_players + '</td>');
                                row.append('<td>' + data[0]["situps_count"] + '</td>');
                                row.append('<td>' + data[0]["situps"] + '</td>');
                                row.append('<td>' + data[0]["situps_rate"] + '</td>');
                                row.append('<td rowspan="2">' + ((parseFloat(data[0]["situps"]) + parseFloat(data[1]["situps"])) / (parseFloat(data[0]["situps_count"]) + parseFloat(data[1]["situps_count"]))).toFixed(2) + '</td>'); //計算總合格率
                                // 俯地起身
                                row.append('<td>' + overall_players + '</td>');
                                row.append('<td>' + data[0]["pushups_count"] + '</td>');
                                row.append('<td>' + data[0]["pushups"] + '</td>');
                                row.append('<td>' + data[0]["pushups_rate"] + '</td>');
                                row.append('<td rowspan="2">' + ((parseFloat(data[0]["pushups"]) + parseFloat(data[1]["pushups"])) / (parseFloat(data[0]["pushups_count"]) + parseFloat(data[1]["pushups_count"]))).toFixed(2) + '</td>'); //計算總合格率
                                // 三千公尺
                                row.append('<td>' + overall_players + '</td>');
                                row.append('<td>' + data[0]["run_count"] + '</td>');
                                row.append('<td>' + data[0]["run"] + '</td>');
                                row.append('<td>' + data[0]["run_rate"] + '</td>');
                                row.append('<td rowspan="2">' + ((parseFloat(data[0]["run"]) + parseFloat(data[1]["run"])) / (parseFloat(data[0]["run_count"]) + parseFloat(data[1]["run_count"]))).toFixed(2) + '</td>'); //計算總合格率
                                //全項合格數
                                row.append('<td>' + data[0]["qualified"] + '</td>');
                                row.append('<td rowspan="2">' + (parseFloat(data[0]["qualified"]) + parseFloat(data[1]["qualified"])) + '</td>');
                                row.append('<td>' + data[0]["rate"] + '</td>');
                                row.append('<td rowspan="2">' + ((parseFloat(data[0]["qualified"]) + parseFloat(data[1]["qualified"])) / (parseFloat(data[0]["overall"]) + parseFloat(data[1]["overall"]))).toFixed(2) + '</td>');
                                row.append('<td rowspan="2">' + ((parseFloat(data[0]["qualified"]) + parseFloat(data[1]["qualified"])) / (parseFloat(data[0]["overall"]) + parseFloat(data[1]["overall"]))).toFixed(2) + '</td>');

                                $('#resultTable tbody').append(row).find('td').attr({ style: "border:solid 1px black" });

                                // Female Data
                                overall_players = data[1]["overall_players"];
                                var row_sec = $('<tr></tr>');
                                row_sec.append('<td>女</td>');
                                // 仰臥起坐
                                row_sec.append('<td>' + overall_players + '</td>');
                                row_sec.append('<td>' + data[1]["situps_count"] + '</td>');
                                row_sec.append('<td>' + data[1]["situps"] + '</td>');
                                row_sec.append('<td>' + data[1]["situps_rate"] + '</td>');
                                // 俯地起身
                                row_sec.append('<td>' + overall_players + '</td>');
                                row_sec.append('<td>' + data[1]["pushups_count"] + '</td>');
                                row_sec.append('<td>' + data[1]["pushups"] + '</td>');
                                row_sec.append('<td>' + data[1]["pushups_rate"] + '</td>');
                                // 三千公尺
                                row_sec.append('<td>' + overall_players + '</td>');
                                row_sec.append('<td>' + data[1]["run_count"] + '</td>');
                                row_sec.append('<td>' + data[1]["run"] + '</td>');
                                row_sec.append('<td>' + data[1]["run_rate"] + '</td>');
                                //全項合格數
                                row_sec.append('<td>' + data[1]["qualified"] + '</td>');
                                row_sec.append('<td>' + data[1]["rate"] + '</td>');
                                $('#resultTable tbody').append(row_sec).find('td').attr({ style: "border:solid 1px black" });
                                $('#resultTable tbody tr:odd').attr({ style: "color:#FF69B4" });
                                $('#resultTable tbody tr:even').attr({ style: "color:#7B68EE" });
                                $('#resultTable tbody tr td[rowSpan="2"]').attr({ style: "color:black;border:solid 1px black" });
                                $('#resultTable tbody td:contains("NaN")').text('0'); // 取代數學函式轉換錯誤

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
                <div style="margin-top:1px;top:1px;background-color:#F0FFFF">
                <table id="resultTable" style="margin-top:1px;padding-top:1px">
                        <thead>
                            <tr>
                                <th colspan="22">
                                    國軍體能測驗成績分析統計表
                                </th>
                            </tr>
                            <tr>
                                <td colspan="2" rowspan="2" style="width: 50px;border:solid 1px black">
                                </td>
                                <td colspan="5">
                                    仰臥起坐
                                </td>
                                <td colspan="5">
                                    俯地起身
                                </td>
                                <td colspan="5">
                                    三千公尺
                                </td>
                                <td colspan="2" rowspan="2">
                                    全項合格數
                                </td>
                                <td colspan="2" rowspan="2">
                                    全項合格率
                                </td>
                                <td rowspan="2">
                                    總全項合格率
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    應測
                                </td>
                                <td>
                                    實測
                                </td>
                                <td>
                                    合格數
                                </td>
                                <td>
                                    合格率
                                </td>
                                <td>
                                    總合格率
                                </td>
                                <td>
                                    應測
                                </td>
                                <td>
                                    實測
                                </td>
                                <td>
                                    合格數
                                </td>
                                <td>
                                    合格率
                                </td>
                                <td>
                                    總合格率
                                </td>
                                <td>
                                    應測
                                </td>
                                <td>
                                    實測
                                </td>
                                <td>
                                    合格數
                                </td>
                                <td>
                                    合格率
                                </td>
                                <td>
                                    總合格率
                                </td>
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
