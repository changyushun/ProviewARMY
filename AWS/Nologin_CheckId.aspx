<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Nologin_CheckId.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>國軍基本體能鑑測網</title>
    <link id="Login_css" rel="stylesheet" href="main.css" type="text/css" />
    <style type="text/css">
        #Submit2
        {
            width: 98px;
        }
    </style>
    <style type="text/css">
        .table_td
        {
            width: 25%;
            border:1px solid #000000
        }
        .table_2
        {
           border-collapse:collapse
        }
        .table_2_tr
        {    
            border:1px solid #000000
        }
        .table_div
        {
            border-collapse:collapse
        }
        .table_div_tr
        {
             border:1px solid #000000
        }
        .table_div_td
        {
           border:1px solid #000000
        } 
        .style1
        {
            border: 1px solid #000000;
            width: 12px;
        }
        .style2
        {
            width: 20%;
            height: 79px;
        }
        .style3
        {
            width: 50%;
            height: 79px;
        }
        .style4
        {
            width: 30%;
            height: 79px;
        }
        .auto-style1 {
            margin-left: 5px;
            margin-bottom:13px;
        }
        .auto-style2 {
            margin-left: 13px;
        }
        .auto-style3 {
            width: 25%;
            border: 1px solid #000000;
            height: 39px;
        }
        .auto-style4 {
            width: 812px;
            height: 20px;
            float: inherit;
            text-align: left;
            font-size: 12px;
            margin-left: 0px;
        }
    </style>
    <script type="text/javascript" src="JS/htmileditor/jquery.min.js"></script> 
<script type="text/javascript" src="JS/htmileditor/jquery.cleditor.min.js"></script>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function() {
            //$('#HyperLink1').hide(); //先隱藏忘記密碼
            $('#loginType').click(function() {
                var type = $('select option:selected').val();
                if (type == "user") {
                    $('#Label1').html('身分證號 : ');
                    //$('#Label2').html('出生年月日(民國) : ');
                    $('#Label2').html('密碼 : ');
                    $('#Label3').html('例:民國72年2月29號, 格式為72/2/29');
                    var yourElement = document.getElementById('HyperLink1');
                    yourElement.setAttribute('href', 'ReSetpwByUser.aspx');
                    $('#HyperLink1').show();
                }
                if (type == "advance") {
                    $('#Label1').html('帳號 : ');
                    $('#Label2').html('密碼 : ');
                    $('#Label3').html('');
                    var yourElement = document.getElementById('HyperLink1');
                    yourElement.setAttribute('href', 'ReSetpw.aspx');
                    $('#HyperLink1').show();
                }               
            });

        });
    </script>
     <script type="text/javascript">
         function dateValidationCheck(str) {
             var re = new RegExp("^([0-9]{3})[./]{1}([0-9]{1,2})[./]{1}([0-9]{1,2})$");
             var strDataValue;
             var infoValidation = true;
             var a = 1;
             var b = 0;
             if ((strDataValue = re.exec(str)) != null) {
                 var i;
                 i = parseFloat(strDataValue[1]);
                 if (i <= 0 || i > 999) { /*年*/
                     infoValidation = false;
                 }
                 i = parseFloat(strDataValue[2]);
                 if (i <= 0 || i > 12) { /*月*/
                     infoValidation = false;
                 }
                 i = parseFloat(strDataValue[3]);
                 if (i <= 0 || i > 31) { /*日*/
                     infoValidation = false;
                 }
             } else {
                 infoValidation = false;
             }
             if (!infoValidation) {
                 //alert("請輸入 YYYY/MM/DD 日期格式");
                 return b;
             }
             else {
                 return a;
                 //return infoValidation;
             }

         }
    </script>
    <script type="text/javascript">
        function CheckIDandDate() {
            var id = document.getElementById("TextBox1").value;
            var date = document.getElementById("TextBox2").value;

            var Chid = checkID(id.trim());//1=正確，0=錯誤
            var Chdate = dateValidationCheck(date.trim());//1=正確，0=錯誤
            //alert(Chid);
            //alert(Chdate);
            if (Chid==1  && Chdate == 1) {
                //alert("身份證及日期格式均正確");
                document.getElementById("form1").submit();
            }
            else if (Chid==1 && Chdate==0) {
                alert("身份證格式正確，日期格式錯誤或空白");
            }
            else if (Chid==0 && Chdate == 1) {
                alert("身份證格式錯誤或空白，日期格式正確");
            }
            else {
                alert("身份證及日期格式錯誤或空白");
            }
            //alert(ch);
            //if (ch == 1) {
            //    var date1 = new Date(v1.trim());
            //    var date2 = new Date(v2);
            //    var date3 = new Date(v3);
            //    var timeDiff = Math.ceil(date1.getTime() - date2.getTime());
            //    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
            //    var timeDiff2 = Math.ceil(date3.getTime() - date1.getTime());
            //    var diffDays2 = Math.ceil(timeDiff2 / (1000 * 3600 * 24));

            //    if (diffDays >= 0 & diffDays2 >= 0) {
            //        //alert('日期輸入正確');
            //        document.getElementById("form1").submit();
            //    }
            //    else
            //        alert('輸入日期不在範圍值內，請重新檢查!!');
            //    //if (diffDays != 1)
            //    //alert('指定日期不連續');
            //    //alert(v2);
            //    //if (v1 == 1234)
            //    //document.getElementById("form1").submit();
            //}
            //else {
            //    alert("請輸入 YYYY/MM/DD 日期格式");
            //}
        }
</script>
    <script type="text/javascript">
        function checkID(idStr) {
            // 依照字母的編號排列，存入陣列備用。
            var letters = new Array('A', 'B', 'C', 'D',
                'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M',
                'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
                'X', 'Y', 'W', 'Z', 'I', 'O');
            // 儲存各個乘數
            var multiply = new Array(1, 9, 8, 7, 6, 5,
                                     4, 3, 2, 1);
            var nums = new Array(2);
            var firstChar;
            var firstNum;
            var lastNum;
            var total = 0;
            var a = 1;
            var b = 0;
            // 撰寫「正規表達式」。第一個字為英文字母，
            // 第二個字為1或2，後面跟著8個數字，不分大小寫。
            var regExpID = /^[a-z](1|2)\d{8}$/i;
            // 使用「正規表達式」檢驗格式
            if (idStr.search(regExpID) == -1) {
                // 基本格式錯誤
                //alert("請仔細填寫身份證號碼");
                //return false;
                return b;
            } else {
                // 取出第一個字元和最後一個數字。
                firstChar = idStr.charAt(0).toUpperCase();
                lastNum = idStr.charAt(9);
            }
            // 找出第一個字母對應的數字，並轉換成兩位數數字。
            for (var i = 0; i < 26; i++) {
                if (firstChar == letters[i]) {
                    firstNum = i + 10;
                    nums[0] = Math.floor(firstNum / 10);
                    nums[1] = firstNum - (nums[0] * 10);
                    break;
                }
            }
            // 執行加總計算
            for (var i = 0; i < multiply.length; i++) {
                if (i < 2) {
                    total += nums[i] * multiply[i];
                } else {
                    total += parseInt(idStr.charAt(i - 1)) *
                             multiply[i];
                }
            }
            // 和最後一個數字比對
            if ((10 - (total % 10)) != lastNum) {
                //alert("身份證號碼寫錯了！");
                //return false;
                return b;
            }
            //return true;
            return a;
        }
    </script>
    
</head>
<body>
<center>
    <form id="form1" runat="server" submitdisabledcontrols="False">
    <div class="auto-style4">
    <a href="Protal.aspx" style="color:#0000FF">&nbsp;: : : 回首頁</a>
    </div>
    <div class="head_space_div"> 
    </div>
    <div class="head_div">  
        &nbsp;: : : 現在位置﹥成績單驗證
        
    </div>
        <div style="text-align:left;align-content:center;width:812px" >
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="XX-Large" Font-Underline="True" ForeColor="Blue" Text="成績單驗證"></asp:Label>
            </div>
        <br />
        <div style="text-align:left;align-content:center;width:812px">
<asp:Label ID="Label3" runat="server" Font-Size="Large" Text="身份證字號：" Font-Bold="True" Font-Names="標楷體"></asp:Label>
<asp:TextBox ID="TextBox1" runat="server" Font-Size="Large" Font-Names="標楷體" style="TEXT-TRANSFORM:   uppercase" MaxLength="10"></asp:TextBox>
        &nbsp;
        <br />
        <br />
<asp:Label ID="Label4" runat="server" Font-Size="Large" Text="鑑測日期：" Font-Bold="True" Font-Names="標楷體"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox2" runat="server" Font-Size="Large" Font-Names="標楷體" MaxLength="9"></asp:TextBox>
    <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large">(請輸入民國年/月/日:104/01/31)</asp:Label>
        <br />
        <br />
    <input type="button" id="btn_sch" value="查詢成績" onclick="CheckIDandDate()" style="cursor:pointer;font-size:18px;font-family:DFKai-sb;color:red;font-weight:bold"/>
            <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Red" OnClick="Button1_Click" Text="查詢成績" Font-Names="標楷體" style="cursor:pointer" Visible="False" />
            
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" Text="鑑測地點："></asp:Label>
    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large"></asp:Label>
            <br />
            <br />
    <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Red"></asp:Label>
            </div>
        <br />
    
    
        <div style="padding-left:11%; border:thin none #000000; background-image:url('images/logo.bmp'); background-position:right ;background-repeat: no-repeat; height: 160px; width: 607px; font-family: 標楷體; font-size: large; font-weight:bold">
       
        <table class="table_2" 
            style="border: thin solid #000000; height: 100%; width: 100%; text-align:center" >
            <tbody>
                <tr>
                    <td class="auto-style3">項目</td>
                    <td class="auto-style3">次數/時間</td>
                    <td class="auto-style3">成績</td>
                    <td class="auto-style3">判定</td>
                </tr>   
                <tr>
                    <td class="table_td"><label id="LB_Situps_Name" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Count" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Score" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Situps_Status" runat="server"></label></td>
                </tr>
                <tr>
                    <td class="table_td"><label id="LB_Pushups_Name" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Pushups_Count" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Pushups_Score" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Pushups_Status" runat="server"></label></td>
                </tr>
                <tr>
                    <td class="table_td"><label id="LB_Run_Name" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Run_Count" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Run_Score" runat="server"></label></td>
                    <td class="table_td"><label id="LB_Run_Status" runat="server"></label></td>
                </tr>         
            </tbody>
        </table>
    </div>
        <div style="padding-left:11%; width: 607px; font-family: 標楷體; font-size: large; font-weight:bold; background-image:url('images/logo.bmp'); background-position:right; background-repeat:no-repeat;background-size: 200px;">
    <table style="width:100%; ">
        <tbody>
            <tr>
                <td style="vertical-align:top; background-image:url('images/logo.bmp'); background-position:right; background-repeat:no-repeat;background-size: 100px;" class="style2">總評：<label id="LB_TotalStatus" runat="server"></label></td>
                <td style="vertical-align:top; text-align: right" class="style3">鑑測官簽章：</td>
                 <td class="style4">
                    <%--<div style="border:1px solid #000000"></div>--%>
                    <table class="table_div" style="width:100%; height:75px"><tbody><tr class="table_div_tr">
                <td class="style1" style="text-align:center">
                    &nbsp;<br />
                    <asp:Image ID="Image1" runat="server" Height="40px" Width="150px" ImageAlign="Middle" CssClass="auto-style1"/>
                        </td></tr></tbody></table>
                </td>
            </tr>
            <tr>
                <td style="width:20%; vertical-align:top"></td>
                <td style="width:50%; vertical-align:top; text-align: right; padding-top:6%">鑑測站主任簽章：</td>
                 <td style="width:30%; padding-top:6%">
                    <%--<div style="border:1px solid #000000"></div>--%>
                    <table class="table_div" style="width:100%; height:75px"><tbody><tr class="table_div_tr">
                    <td class="style1">
                    <asp:Image ID="Image2" runat="server" Height="40px" Width="150px" ImageAlign="Middle" CssClass="auto-style2" />
                        </td></tr></tbody></table>
                </td>
            </tr>
            <%--<tr>
                <td colspan="3" style="padding-top:20px; text-align:right; font-family:Arial">檢查碼 582167c4675f496920150b30cc423cf2</td>

            </tr>--%>
        </tbody>
    </table>
    </div>


    </form>
    </center>
</body>
</html>
