<%@ Page Language="C#" AutoEventWireup="true" CodeFile="107_Result_To_CSV.aspx.cs" Inherits="_107_Result_To_CSV" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>成績資料表轉CSV檔</title>
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
                if (strY<endY )
                {
                    document.getElementById("form1").submit();
                }
                else if (strY == endY)
                {
                    if (strM < endM) {
                        document.getElementById("form1").submit();
                    }
                    else if (strM == endM)
                    {
                        if (strD < endD) {
                            document.getElementById("form1").submit();
                        }
                        else if (strD == endD) {
                            document.getElementById("form1").submit();
                        }
                        else {
                            alert("日期區間輸入錯誤!!");
                        }
                    }
                    else {
                        alert("日期區間輸入錯誤!!");
                    }
                }
                else
                {
                    alert("日期區間輸入錯誤!!");
                }
                   
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <b>請輸入起始日期：</b><asp:TextBox ID="txb_Start_date" runat="server" Font-Size="Large" MaxLength="10"></asp:TextBox>

            <b>請輸入結束日期：</b><asp:TextBox ID="txb_End_date" runat="server" Font-Size="Large" MaxLength="10"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <b style="color: red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期格式：YYYY-MM-DD</b>
            <b style="color: red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期格式：YYYY-MM-DD</b>
        <br />
        <br />
        <input type="button" name="name" value="匯出CSV檔" onclick="check_date()" style="font-size: 20px; font-weight: 900; width: 140px; color: blue" />
        <br />
        <br />
            <b style="color: blue">(1、因查詢資料量大，建議單次匯出資料量上限為3個月，避免資料下載時中斷!!)</b>
<%--        <br />
            <b style="color: blue">(2、檔案預設儲存位置及名稱為C:\成績名冊(查詢日期區間).csv)</b>--%>
    </div>
    </form>
</body>
</html>
