<%@ Page Language="C#" AutoEventWireup="true" CodeFile="107_PassRate.aspx.cs" Inherits="_107_PassRate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>訓練成效統計</title>
    <style type="text/css">
        table {
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            width: 3600px;
        }

        .td_w120 {
            width: 120px;
        }

        .td_w40 {
            width: 40px;
        }

        .td_w200 {
            width: 200px;
        }

        .td_w80 {
            width: 80px;
        }
    </style>
    <script type="text/javascript">
        function window_onload() {
            var start_date = window.document.getElementById('txb_Start_date');
            var end_date = window.document.getElementById('txb_End_date');
            var now = new Date();
            var fistday = (now.getYear() + 1990).toString() + '-01-01';
            var today = (now.getYear() + 1990).toString() + '-' + (now.getMonth() + 1).toString() + '-' + now.getDate().toString();
            start_date.value = fistday;
            end_date.value = today;
        }

        function check_date() {
            var re = new RegExp("^([0-9]{4})[.-]{1}([0-9]{1,2})[.-]{1}([0-9]{1,2})$");
            var strDataValue;
            var endDateValue;
            var infoValidation = true;
            var infoValidation_2 = true;
            var Start_str = window.document.getElementById('txb_Start_date').value;
            var End_str = window.document.getElementById('txb_End_date').value;
            //設定年月日
            var strY, strM, strD;
            var endY, endM, endD;
            if ((strDataValue = re.exec(Start_str)) != null) {
                
                strY = parseFloat(strDataValue[1]);
                if (strY <= 0 || strY > 9999) { /*年*/
                    infoValidation = false;
                }
                strM = parseFloat(strDataValue[2]);
                if (strM <= 0 || strM > 12) { /*月*/
                    infoValidation = false;
                }
                strD = parseFloat(strDataValue[3]);
                if (strD <= 0 || strD > 31) { /*日*/
                    infoValidation = false;
                }
            }
            else {
                infoValidation = false;
            }
            //檢查結束時間
            if ((endDateValue = re.exec(End_str)) != null) {
                
                endY = parseFloat(endDateValue[1]);
                if (endY <= 0 || endY > 9999) { /*年*/
                    infoValidation_2 = false;
                }
                endM = parseFloat(endDateValue[2]);
                if (endM <= 0 || endM > 12) { /*月*/
                    infoValidation_2 = false;
                }
                endD = parseFloat(endDateValue[3]);
                if (endD <= 0 || endD > 31) { /*日*/
                    infoValidation_2 = false;
                }
            }
            else {
                infoValidation_2 = false;
            }
            if (!infoValidation | !infoValidation_2) {
                alert("請輸入 YYYY-MM-DD 日期格式");
            }
            else {
                if (strY<=endY & strM<=endM & strD<=endD)
                {
                    document.getElementById("form1").submit();
                }
                else
                    alert("日期區間輸入錯誤!!");
            }
        }

        //匯出excel
        function fnExcelReport() {
            var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
            var textRange; var j = 0;
            tab = document.getElementById('table_rate'); // id of table
            var svname1 = window.document.getElementById('txb_Start_date');
            var svname2 = window.document.getElementById('txb_End_date');
            var savename = '訓練成效統計表(' + svname1.value + '至' + svname2.value + ').xls';

            for (j = 0 ; j < tab.rows.length ; j++) {
                tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
                //tab_text=tab_text+"</tr>";
            }

            tab_text = tab_text + "</table>";
            tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
            tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
            tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");

            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
            {
                txtArea1.document.open("txt/html", "replace");
                txtArea1.document.write(tab_text);
                txtArea1.document.close();
                txtArea1.focus();
                sa = txtArea1.document.execCommand("SaveAs", true, savename);
            }
            else                 //other browser not tested on IE 11
                sa = window.open('data:application/vnd.ms-excel;charset=utf-8;,' + encodeURIComponent(tab_text));


            return (sa);
        }
    </script>

</head>
<body>

    <div>
        <form id="form1" runat="server">
            <b>請輸入起始日期：</b><asp:TextBox ID="txb_Start_date" runat="server" Font-Size="Large" MaxLength="10"></asp:TextBox>

            <b>請輸入結束日期：</b><asp:TextBox ID="txb_End_date" runat="server" Font-Size="Large" MaxLength="10"></asp:TextBox>
            <input type="button" name="name" value="查 詢" onclick="check_date()" style="font-size: 20px; font-weight: 900; width: 100px; color: blue" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <iframe id="txtArea1" style="display:none"></iframe>
            <asp:Button ID="btn_ToExcel" runat="server" Text="匯出Excel" OnClientClick="fnExcelReport('table_rate')" Visible="False" style="font-size: 20px; font-weight: 900; width: 140px; color: red;background-color:lightgreen" OnClick="btn_ToExcel_Click" />
            <br />
            <b style="color: red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期格式：YYYY-MM-DD</b>
            <b style="color: red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期格式：YYYY-MM-DD</b>
            
        </form>
        <div>
            <table id="table_rate" border='1'>
                <tr>
                    <td rowspan="3" class="td_w120">單位</td>
                    <td rowspan="3" class="td_w40">軍階</td>
                    <td rowspan="3" class="td_w40">性別</td>
                    <td colspan="12">仰臥起坐</td>
                    <td colspan="12">俯地挺身</td>
                    <td colspan="12">三千公尺跑步</td>
                    <td rowspan="3">總受測人數</td>
                    <td rowspan="3">全項合格數</td>
                    <td rowspan="3">全項合格率</td>
                </tr>
                <tr>
                    <td colspan="2">基本項目</td>
                    <td colspan="2">800公尺游走</td>
                    <td colspan="2">5公里健走</td>
                    <td colspan="2">5分鐘跳繩</td>
                    <td colspan="2">引體向上/屈臂懸垂</td>
                    <td colspan="2">合格率</td>
                    <td colspan="2">基本項目</td>
                    <td colspan="2">800公尺游走</td>
                    <td colspan="2">5公里健走</td>
                    <td colspan="2">5分鐘跳繩</td>
                    <td colspan="2">引體向上/屈臂懸垂</td>
                    <td colspan="2">合格率</td>
                    <td colspan="2">基本項目</td>
                    <td colspan="2">800公尺游走</td>
                    <td colspan="2">5公里健走</td>
                    <td colspan="2">5分鐘跳繩</td>
                    <td colspan="2">引體向上/屈臂懸垂</td>
                    <td colspan="2">合格率</td>
                </tr>
                <tr>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">基本</td>
                    <td class="td_w80">替代</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">基本</td>
                    <td class="td_w80">替代</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">合格</td>
                    <td class="td_w80">不合格</td>
                    <td class="td_w80">基本</td>
                    <td class="td_w80">替代</td>
                </tr>
                <tr>
                    <td rowspan="6">陸軍司令部</td>
                    <td rowspan="2">軍官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_A0M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0M39" runat="server" Text="0"></asp:Label></td>
                </tr>

                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_A0F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A0F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_A1M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_A1F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A1F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士兵</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_A2M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_A2F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_A2F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="6">海軍司令部</td>
                    <td rowspan="2">軍官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_N0M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0M39" runat="server" Text="0"></asp:Label></td>
                </tr>

                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_N0F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N0F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_N1M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_N1F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N1F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士兵</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_N2M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_N2F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_N2F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="6">空軍司令部</td>
                    <td rowspan="2">軍官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_F0M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0M39" runat="server" Text="0"></asp:Label></td>
                </tr>

                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_F0F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F0F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_F1M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_F1F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F1F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士兵</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_F2M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_F2F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_F2F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="6">後備指揮部</td>
                    <td rowspan="2">軍官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_G0M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0M39" runat="server" Text="0"></asp:Label></td>
                </tr>

                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_G0F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G0F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_G1M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_G1F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G1F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士兵</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_G2M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_G2F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_G2F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="6">憲兵指揮部</td>
                    <td rowspan="2">軍官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_P0M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0M39" runat="server" Text="0"></asp:Label></td>
                </tr>

                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_P0F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P0F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_P1M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_P1F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P1F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士兵</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_P2M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_P2F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_P2F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="6">國防部直屬</td>
                    <td rowspan="2">軍官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_C0M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0M39" runat="server" Text="0"></asp:Label></td>
                </tr>

                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_C0F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C0F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_C1M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_C1F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C1F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士兵</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_C2M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_C2F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_C2F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="6">合計</td>
                    <td rowspan="2">軍官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_ALL0M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0M39" runat="server" Text="0"></asp:Label></td>
                </tr>

                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_ALL0F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL0F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士官</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_ALL1M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_ALL1F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL1F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="2">士兵</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_ALL2M1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2M39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_ALL2F1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALL2F39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td rowspan="3" colspan="2">總計</td>
                    <td>男</td>
                    <td>
                        <asp:Label ID="lab_ALLALLM1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLM39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>女</td>
                    <td>
                        <asp:Label ID="lab_ALLALLF1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLF39" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>全部</td>
                    <td>
                        <asp:Label ID="lab_ALLALLN1" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN2" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN3" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN4" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN5" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN6" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN7" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN8" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN9" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN10" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN11" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN12" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN13" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN14" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN15" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN16" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN17" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN18" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN19" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN20" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN21" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN22" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN23" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN24" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN25" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN26" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN27" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN28" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN29" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN30" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN31" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN32" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN33" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN34" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN35" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN36" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN37" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN38" runat="server" Text="0"></asp:Label></td>
                    <td>
                        <asp:Label ID="lab_ALLALLN39" runat="server" Text="0"></asp:Label></td>
                </tr>
            </table>
        </div>
    </div>

</body>
</html>
