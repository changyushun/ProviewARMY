<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportingSumItem.aspx.cs"
    Inherits="ReportingSumItem" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript">
        $(function() {
            $('#resultTable td, #resultTable th, #resultTable tr, #resultTable').attr({ style: "border:solid 1px black" });
            $('#memo').click(function() {
                window.open('ResultMemo.aspx', null, 'location=no,width=600,height=300,top=0,left=0');
            });
            $('#ToExcel').click(function() {
                var curTbl = document.getElementById('resultTable');
                var oXL = new ActiveXObject("Excel.Application");
                //var ExcelSheet = new ActiveXObject("Excel.Sheet");
                var oWB = oXL.Workbooks.Add();
                var oSheet = oWB.ActiveSheet;
                var sel = document.body.createTextRange();
                sel.moveToElementText(curTbl);
                sel.select();
                sel.execCommand("Copy");
                oSheet.Paste();
                oXL.Visible = true;
                // Make Excel visible through the Application object.
                //ExcelSheet.Application.Visible = true;
                // Place some text in the first cell of the sheet.
                //ExcelSheet.ActiveSheet.Cells(1, 1).Value = $('#resultTable').html();
                //                var x = $('#resultTable')[0].rows.length;
                //                for (var i = 0; i < x; i++) {
                //                    var y = $('#resultTable')[0].rows[i].cells.length;
                //                    for (var j = 0; j < y; j++) {
                //                        ExcelSheet.ActiveSheet.Cells(i + 1, j + 1).Value = $('#resultTable')[0].rows[i].cells[j].innerText;
                //                    }
                //                }
                // Save the sheet.
                //ExcelSheet.SaveAs("C:\\TEST.XLS");
                // Close Excel with the Quit method on the Application object.
                //ExcelSheet.Application.Quit();


            });
            //成績統計
            $('#calculate').click(function() {
                //顯示標題文字
                if ($('#type').val() == "item") {
                    $('#title_span').text($('#titleUnit').val() + '體能測驗成績分析統計表');
                }
                if ($('#type').val() == "rank") {
                    $('#title_span').text($('#titleUnit').val() + $('#ddlRank :selected').text() + '體能測驗成績分析統計表');
                }
                if ($('#type').val() == "age") {
                    $('#title_span').text($('#titleUnit').val() + $('#txtAge').val() + '歲體能測驗成績分析統計表');
                }
                $('#resultTable tbody tr').remove(); // 先將先前資料清空
                $('#GridView1 tr').each(function(index) {
                    if (index != 0) {
                        var unit_title = $(this).find('td:eq(0)').text();
                        $.postJson('Operations/Result.ashx', { type: $('#type').val(), unit_code: $(this).find('td:eq(1)').text(), date_start: $('#date_start').val(), date_stop: $('#date_stop').val(), index: index, rank: $('#ddlRank :selected').val(), age: $('#txtAge').val() }, function(data, status) {
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
                                row.append('<td>' + (parseFloat(data[0]["qualified"]) / parseFloat(data[0]["overall_players"])).toFixed(2) + '</td>');
                                row.append('<td rowspan="2">' + ((parseFloat(data[0]["qualified"]) + parseFloat(data[1]["qualified"])) / (parseFloat(data[0]["overall_players"]) + parseFloat(data[1]["overall_players"]))).toFixed(2) + '</td>');
                                //替代方案合格數
                                row.append('<td>' + data[0]["qualified_rep"] + '</td>');
                                row.append('<td rowspan="2">' + (parseFloat(data[0]["qualified_rep"]) + parseFloat(data[1]["qualified_rep"])) + '</td>');
                                row.append('<td rowspan="2">' + ((parseFloat(data[0]["qualified_all"]) + parseFloat(data[1]["qualified_all"])) / (parseFloat(data[0]["overall_players"]) + parseFloat(data[1]["overall_players"]))).toFixed(6) + '</td>');


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
                                row_sec.append('<td>' + (parseFloat(data[1]["qualified"]) / parseFloat(data[1]["overall_players"])).toFixed(2) + '</td>');
                                row_sec.append('<td>' + data[1]["qualified_rep"] + '</td>');
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

    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td class="auto-style1">
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="DropDownList5" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td class="auto-style1">
                    <asp:Button ID="Button1" runat="server" Text="選擇單位" OnClick="Button1_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <div>
                        <table>
                            <tr>
                                <td colspan="2" valign="top" style="vertical-align: top">
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <asp:GridView ID="GridView1" runat="server">
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                開始時間
                                            </td>
                                            <td>
                                                <input type="text" id="date_start" runat="server" style="width: 100px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                結束時間
                                            </td>
                                            <td>
                                                <input type="text" id="date_stop" runat="server" style="width: 100px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlRank" runat="server" DataSourceID="SqlDataSourceRank" DataTextField="rank_title"
                                                    DataValueField="rank_code">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSourceRank" runat="server" ConnectionString="<%$ ConnectionStrings:MainDB %>"
                                                    SelectCommand="SELECT [rank_code], [rank_title] FROM [Rank]"></asp:SqlDataSource>
                                                <asp:TextBox ID="txtAge" runat="server" Width="72px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <input type="button" id="calculate" value="統計成績" />
                                                <asp:HiddenField ID="type" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td rowspan="4" style="border: solid 1px black; text-align: center; vertical-align: top;
                                    background-color: #F0FFFF">
                                    <table id="resultTable" style="margin-top: 1px; padding-top: 1px;">
                                        <thead>
                                            <tr>
                                                <th colspan="24">
                                                    <input type="hidden" runat="server" id="titleUnit" />
                                                    <span id="title_span">國軍體能測驗成績分析統計表</span><br />
                                                    <span id="memo" style="cursor:pointer">說明</span>
                                                    
                                                </th>
                                            </tr>
                                            <tr>
                                                <td colspan="2" rowspan="2" style="width: 50px; border: solid 1px black">
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
                                                <td colspan="2" rowspan="2">
                                                    替代方案合格數
                                                </td>
                                                <td rowspan="2">
                                                    總全項合格率<br />
                                                    (含替代方案)
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
                                    <input type="button" id="ToExcel" value="Excel輸出" /><br />
                                    <span>請將本網站加入瀏覽器中信任的網站，並將安全等級設為低</span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
