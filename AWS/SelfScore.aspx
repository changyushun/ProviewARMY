<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SelfScore.aspx.cs" Inherits="SelfScore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        
        $(function () {
            $(':button[value="下載成績單"]').each(function () {
                $(this).click(function () {
                    var s1 = "2016/12/31";
                    var s2 = $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_DropDownList1').val();
                    var t1 = Date.parse(s1);
                    var t2 = Date.parse(s2);
                    if (t1 < t2) {
                        window.open("106_Web_Transcripts.aspx?id=" + $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_Label2').text() + "&date=" + $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_DropDownList1').val());
                    }
                    else {
                        alert('網路成績單僅限「106/01/01」起之鑑測成績才能下載列印!!');
                    }
                });

            });
        });

        $(function () {
            $(':button[value="網頁預覽列印"]').each(function () {
                $(this).click(function () {
                    var s1 = "2016/12/31";
                    var s2 = $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_DropDownList1').val();
                    var t1 = Date.parse(s1);
                    var t2 = Date.parse(s2);
                    if (t1 < t2) {
                        window.open("106_View_Web_Transcripts.aspx?id=" + $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_Label2').text() + "&date=" + $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_DropDownList1').val());
                        window.open("106_Print_Teach.aspx", "列印說明", config = 'height=720,width=720,scrollbars=yes');
                    }
                    else {
                        alert('網路成績單僅限「106/01/01」起之鑑測成績才能預覽列印!!');
                    }
                });

            });
        });
    </script>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var result = $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_GridView2 tr:eq(1) td:eq(3)').html();
            var result_push = $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_GridView2 tr:eq(1) td:eq(5)').html();
            var result_run = $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_GridView2 tr:eq(1) td:eq(7)').html();
            var row = $('<tr></tr>');
            /********仰臥起坐 0-30 分********/
            if (result < 30 || result == '-' || result == '') {

                row.append('<td colspan="9">仰臥起坐-訓練處方</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">C組 體能成績 30分以下</td>');
                row.append('<td>半仰臥起坐</td>');
                row.append('<td>3</td>');
                row.append('<td>30</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>90</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥屈腿</td>');
                row.append('<td>2</td>');
                row.append('<td>40</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>120</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥起肩</td>');
                row.append('<td>2</td>');
                row.append('<td>40</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>120</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥起坐</td>');
                row.append('<td>3</td>');
                row.append('<td>20</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>4</td>');
                row.append('<td>80</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
            }
            /********仰臥起坐 31-59 分********/
            if (result >= 30 && result < 60) {
                row = $('<tr></tr>');
                row.append('<td colspan="9">仰臥起坐-訓練處方</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">B組 體能成績 30-60 分</td>');
                row.append('<td>半仰臥起坐</td>');
                row.append('<td>3</td>');
                row.append('<td>40</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>4 min</td>');
                row.append('<td>3</td>');
                row.append('<td>120</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>坐姿舉腿</td>');
                row.append('<td>2</td>');
                row.append('<td>40</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>4 min</td>');
                row.append('<td>3</td>');
                row.append('<td>120</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥起坐</td>');
                row.append('<td>3</td>');
                row.append('<td>30</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>4 min</td>');
                row.append('<td>3</td>');
                row.append('<td>90</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥舉腿</td>');
                row.append('<td>3</td>');
                row.append('<td>20</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>4 min</td>');
                row.append('<td>4</td>');
                row.append('<td>80</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
            }
            /********仰臥起坐 60-100 分********/
            if (result >= 60) {
                row = $('<tr></tr>');
                row.append('<td colspan="9">仰臥起坐-訓練處方</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">A組 體能成績 60分以上</td>');
                row.append('<td>仰臥起坐</td>');
                row.append('<td>4</td>');
                row.append('<td>20</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>1 min</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥屈伸</td>');
                row.append('<td>4</td>');
                row.append('<td>20</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>1 min</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥起坐</td>');
                row.append('<td>3</td>');
                row.append('<td>40</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>4 min</td>');
                row.append('<td>3</td>');
                row.append('<td>120</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>仰臥舉腿</td>');
                row.append('<td>3</td>');
                row.append('<td>20</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>1 min</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#sit_ups tbody').append(row).find('tbody').attr({});
            }

            /********俯地挺身 0-30 分********/
            if (result_push < 30 || result_push == '-' || result_push == '') {
                row = $('<tr></tr>');
                row.append('<td colspan="9">俯地挺身-訓練處方</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">C組 體能成績 30分以下</td>');
                row.append('<td>跪膝俯地挺身</td>');
                row.append('<td>2</td>');
                row.append('<td>50</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>150</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>啞鈴二頭肌彎舉</td>');
                row.append('<td>2</td>');
                row.append('<td>30</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>1 min</td>');
                row.append('<td>3 min</td>');
                row.append('<td>3</td>');
                row.append('<td>90</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>上斜體俯地挺身</td>');
                row.append('<td>2</td>');
                row.append('<td>60</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>180</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>擴胸運動</td>');
                row.append('<td>2</td>');
                row.append('<td>20</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
            }
            /********俯地挺身 31-59 分********/
            if (result_push >= 30 && result_push < 60) {
                row = $('<tr></tr>');
                row.append('<td colspan="9">俯地挺身-訓練處方</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">B組 體能成績 30-60 分</td>');
                row.append('<td>俯地挺身</td>');
                row.append('<td>3</td>');
                row.append('<td>30</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>90</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>槓鈴二頭肌彎曲</td>');
                row.append('<td>2</td>');
                row.append('<td>20</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>1 min</td>');
                row.append('<td>3 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>上體扶撐椅</td>');
                row.append('<td>3</td>');
                row.append('<td>20</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>上斜體俯地挺身</td>');
                row.append('<td>2</td>');
                row.append('<td>40</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>120</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
            }
            /********俯地挺身 60-100 分********/
            if (result_push >= 60) {
                row = $('<tr></tr>');
                row.append('<td colspan="9">俯地挺身-訓練處方</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">A組 體能成績 60分以上</td>');
                row.append('<td>下斜俯地挺身</td>');
                row.append('<td>4</td>');
                row.append('<td>20</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>倂掌俯地挺身</td>');
                row.append('<td>4</td>');
                row.append('<td>20</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>寬臂俯地挺身</td>');
                row.append('<td>4</td>');
                row.append('<td>20</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>下斜體屈臂俯撐</td>');
                row.append('<td>4</td>');
                row.append('<td>30</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>10 sec</td>');
                row.append('<td>30 sec</td>');
                row.append('<td>1</td>');
                row.append('<td>30</td>');
                $('#push_ups tbody').append(row).find('tbody').attr({});
            }

            /********3000公尺 0-30 分********/
            if (result_run < 30 || result_run == '-' || result_run == '') {
                row = $('<tr></tr>');
                row.append('<td colspan="9">三千公尺跑步-訓練處方</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">C組 體能成績 30分以下</td>');
                row.append('<td>徒手蹲屈</td>');
                row.append('<td>2</td>');
                row.append('<td>30</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3 min</td>');
                row.append('<td>2</td>');
                row.append('<td>60</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>負重提踵</td>');
                row.append('<td>2</td>');
                row.append('<td>30</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3 min</td>');
                row.append('<td>2</td>');
                row.append('<td>60</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>跳繩</td>');
                row.append('<td>2</td>');
                row.append('<td>50</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>1 min</td>');
                row.append('<td>3 min</td>');
                row.append('<td>3</td>');
                row.append('<td>150</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>5000m 慢跑</td>');
                row.append('<td>2</td>');
                row.append('<td>1</td>');
                row.append('<td>2-3 次/週</td>');
                row.append('<td>30 min</td>');
                row.append('<td>操作完休息</td>');
                row.append('<td>1</td>');
                row.append('<td>5000m</td>');
                $('#run tbody').append(row).find('tbody').attr({});
            }
            /********3000公尺 31-59 分********/
            if (result_run >= 30 && result_run < 60) {
                row = $('<tr></tr>');
                row.append('<td colspan="9">三千公尺跑步-訓練處方</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">B組 體能成績 30-60 分</td>');
                row.append('<td>負重蹲屈</td>');
                row.append('<td>3</td>');
                row.append('<td>30</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>2 min</td>');
                row.append('<td>3 min</td>');
                row.append('<td>3</td>');
                row.append('<td>90</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>開合跳</td>');
                row.append('<td>2</td>');
                row.append('<td>50</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>3 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>150</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>抬腿運動</td>');
                row.append('<td>2</td>');
                row.append('<td>20</td>');
                row.append('<td>3-5 次/週</td>');
                row.append('<td>1 min</td>');
                row.append('<td>3 min</td>');
                row.append('<td>3</td>');
                row.append('<td>60</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>3000m 慢跑</td>');
                row.append('<td>2</td>');
                row.append('<td>1</td>');
                row.append('<td>2-3 次/週</td>');
                row.append('<td>20 min</td>');
                row.append('<td>操作完休息</td>');
                row.append('<td>1</td>');
                row.append('<td>3000m</td>');
                $('#run tbody').append(row).find('tbody').attr({});
            }
            /********3000公尺 60-100 分********/
            if (result_run >= 60) {
                row = $('<tr></tr>');
                row.append('<td colspan="9">三千公尺跑步-訓練處方</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>組別</td>');
                row.append('<td>項目</td>');
                row.append('<td>強度</td>');
                row.append('<td>次數</td>');
                row.append('<td>頻率</td>');
                row.append('<td>時間</td>');
                row.append('<td>休息</td>');
                row.append('<td>組數</td>');
                row.append('<td>訓練量</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td rowspan="4">A組 體能成績 60分以上</td>');
                row.append('<td>跳繩</td>');
                row.append('<td>2</td>');
                row.append('<td>100</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>3 min</td>');
                row.append('<td>5 min</td>');
                row.append('<td>3</td>');
                row.append('<td>300</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>50m 衝刺跑</td>');
                row.append('<td>4</td>');
                row.append('<td>1</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>10 sec</td>');
                row.append('<td>1 min</td>');
                row.append('<td>5</td>');
                row.append('<td>250m</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>500m 快跑</td>');
                row.append('<td>4</td>');
                row.append('<td>5</td>');
                row.append('<td>3 次/週</td>');
                row.append('<td>3 min</td>');
                row.append('<td>4 min</td>');
                row.append('<td>1</td>');
                row.append('<td>2500m</td>');
                $('#run tbody').append(row).find('tbody').attr({});
                row = $('<tr></tr>');
                row.append('<td>3000m 跑步</td>');
                row.append('<td>3</td>');
                row.append('<td>1</td>');
                row.append('<td>2-3 次/週</td>');
                row.append('<td>15 min</td>');
                row.append('<td>操作完休息</td>');
                row.append('<td>1</td>');
                row.append('<td>3000m</td>');
                $('#run tbody').append(row).find('tbody').attr({});
            }

        });
        //    $(document).ready(function() {
        //        //var t1 = document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_GridView2");
        //        var myTable = document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPane2_GridView2");
        //        //var mytablebody = myTable.getElementsByTagName("tbody")[0];
        //        var tds = myTable.getElementsByTagName("td");
        //        alert(tds[0].innerText);
        //    });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">

            <ajaxToolkit:TabPanel ID="TabPane2" runat="server" HeaderText="個人成績查詢">
                <ContentTemplate>
                    <div id="noresult" style="display: none;" runat="server"><span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:目前無成績</span> </div>
                    <div id="haveresult" runat="server">
                        <div>
                            <asp:Label ID="Label2" runat="server"></asp:Label><asp:Label ID="Label1" runat="server" Text="請選擇鑑測日期"></asp:Label><asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True"
                                DataSourceID="SqlDataSource1" DataTextField="date" DataValueField="date"
                                OnDataBound="DropDownList1_DataBound" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:MainDB %>"
                            SelectCommand="SELECT DISTINCT CONVERT(VARCHAR(10), [date], 111) AS [date] FROM [Result] WHERE ([id] = @id and status in ('000','999','202','203','204','205','206')) ORDER BY [date] DESC" OnSelecting="SqlDataSource1_Selecting">
                            <SelectParameters>
                                <asp:Parameter Name="id" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
                            Width="1000px" PageSize="25"
                            DataSourceID="SqlDataSource2"
                            OnRowDataBound="GridView2_RowDataBound" OnDataBound="GridView2_DataBound" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="date" HeaderText="鑑測日期" ReadOnly="True"
                                    SortExpression="date">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sit_ups" HeaderText="仰臥起坐" ReadOnly="True"
                                    SortExpression="sit_ups">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sit_ups_score" HeaderText="仰臥起坐成績"
                                    ReadOnly="True" SortExpression="sit_ups_score">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="push_ups" HeaderText="俯地挺身" ReadOnly="True"
                                    SortExpression="push_ups">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="push_ups_score" HeaderText="俯地挺身成績"
                                    ReadOnly="True" SortExpression="push_ups_score">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="run" HeaderText="三千公尺" ReadOnly="True"
                                    SortExpression="run">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="run_score" HeaderText="三千公尺成績" ReadOnly="True"
                                    SortExpression="run_score">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="center_name" HeaderText="鑑測地點"
                                    ReadOnly="True" SortExpression="center_name">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="status" HeaderText="鑑測結果" ReadOnly="True"
                                    SortExpression="status">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <input type="button" id="EditSchWeb" value="網頁預覽列印" style="cursor: pointer; margin-right: 5px; background-color: #66FF66;" /><input type="button" id="EditSch" value="下載成績單" style="cursor: pointer; background-color: #FF8888;" /></ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle CssClass="EditRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <PagerStyle CssClass="PagerStyle" />
                            <RowStyle CssClass="RowStyle" />
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                        </asp:GridView>
                        <br>
                            <br />
                            <br>
                                <br>
                                    <br>
                                        <br>
                                            <br>
                                                <br></br>
                                                <span>訓練處方籤:</span>
                                                <table id="sit_ups" border="0" cellpadding="0" cellspacing="1" class="Prescription" style="width: 842px; background-color: #90c734; padding-top: 10px">
                                                    <tbody></tbody>
                                                </table>
                                                <table id="push_ups" border="0" cellpadding="0" cellspacing="1" class="Prescription" style="width: 842px; background-color: #90c734; padding-top: 10px">
                                                    <tbody></tbody>
                                                </table>
                                                <table id="run" border="0" cellpadding="0" cellspacing="1" class="Prescription" style="width: 842px; background-color: #90c734; padding-top: 10px">
                                                    <tbody></tbody>
                                                </table>
                                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MainDB %>" OnSelecting="SqlDataSource2_Selecting" SelectCommand="QueryResultByTeam" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="type" Type="String" />
                                                        <asp:Parameter Name="operator" Type="String" />
                                                        <asp:Parameter Name="value" Type="String" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <br>
                                                    <br>
                                                        <br>
                                                            <br>
                                                                <br></br>
                                                                <br>
                                                                    <br>
                                                                        <br>
                                                                            <br></br>
                                                                            <br>
                                                                                <br>
                                                                                    <br>
                                                                                        <br></br>
                                                                                        <br>
                                                                                            <br>
                                                                                                <br></br>
                                                                                                <br>
                                                                                                    <br>
                                                                                                        <br></br>
                                                                                                        <br>
                                                                                                            <br>
                                                                                                                <br></br>
                                                                                                                <br>
                                                                                                                    <br>
                                                                                                                        <br></br>
                                                                                                                        <br>
                                                                                                                            <br></br>
                                                                                                                            <br>
                                                                                                                                <br></br>
                                                                                                                                <br>
                                                                                                                                    <br></br>
                                                                                                                                    <br>
                                                                                                                                        <br></br>
                                                                                                                                        <br>
                                                                                                                                            <br></br>
                                                                                                                                            <br>
                                                                                                                                                <br></br>
                                                                                                                                                <br>
                                                                                                                                                    <br></br>
                                                                                                                                                    <br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                        <br></br>
                                                                                                                                                    </br>
                                                                                                                                                </br>
                                                                                                                                            </br>
                                                                                                                                        </br>
                                                                                                                                    </br>
                                                                                                                                </br>
                                                                                                                            </br>
                                                                                                                        </br>
                                                                                                                    </br>
                                                                                                                </br>
                                                                                                            </br>
                                                                                                        </br>
                                                                                                    </br>
                                                                                                </br>
                                                                                            </br>
                                                                                        </br>
                                                                                    </br>
                                                                                </br>
                                                                            </br>
                                                                        </br>
                                                                    </br>
                                                                </br>
                                                            </br>
                                                        </br>
                                                    </br>
                                                </br>
                                            </br>
                                        </br>
                                    </br>
                                </br>
                            </br>
                        </br>
                    </div>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        </ajaxToolkit:TabContainer>
    </div>
</asp:Content>

