<%@ Page Language="C#" AutoEventWireup="true" CodeFile="106_UpdateSealtime.aspx.cs" Inherits="UpdateSealtime" %>

<!DOCTYPE html >

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>更新簽章啟用日期</title>
    <style type="text/css">
        #div_left{
            width:65%;
           float:left;
           height:250px;
           /*background:#383;*/
        }
        #div_right{
            width:35%;
           float:left;
           height:250px;
           /*background:#338;*/
        }
    </style>
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
        function Send_data() {
            document.getElementById("form1").submit();
        }
        function myFunction() {
            try{
                window.opener.outside();
                var v1 = document.getElementById("TextBox1").value;
                var v2 = document.getElementById("Label8").innerText;
                var v3 = document.getElementById("Label9").innerText;

                var ch = dateValidationCheck(v1.trim());
                //alert(ch);
                if (ch == 1) {
                    var date1 = new Date(v1.trim());
                    var date2 = new Date(v2);
                    var date3 = new Date(v3);
                    var timeDiff = Math.ceil(date1.getTime() - date2.getTime());
                    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
                    var timeDiff2 = Math.ceil(date3.getTime() - date1.getTime());
                    var diffDays2 = Math.ceil(timeDiff2 / (1000 * 3600 * 24));
                    if (v3 == "") {
                        if (diffDays >= 0) {
                            //alert('日期輸入正確');
                            document.getElementById("form1").submit();
                        }


                        else
                            alert('輸入日期不在範圍值內，請重新檢查!!');
                    }
                    else {
                        if (diffDays >= 0 && diffDays2 >= 0) {
                            //alert('日期輸入正確');
                            document.getElementById("form1").submit();
                        }


                        else
                            alert('輸入日期不在範圍值內，請重新檢查!!');
                    }
                    //if (diffDays != 1)
                    //alert('指定日期不連續');
                    //alert(v2);
                    //if (v1 == 1234)
                    //document.getElementById("form1").submit();
                }
                else {
                    alert("請輸入民國年/月/日：YYY/MM/DD 日期格式");
                }
            }
            catch (err) {
                //alert(err.message);
                document.getElementById("form1").submit();
            }
            
        }


    </script>
    ​
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hf_ChangeTime" runat="server" />
        <asp:HiddenField ID="hf_StartTime" runat="server" />
        <asp:HiddenField ID="hf_EndTime" runat="server" />
        <div>
            <div id="div_left">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="X-Large" Font-Underline="True" ForeColor="Blue" Text="更新簽章資料"></asp:Label>
            <br />

            <asp:Label ID="Label7" runat="server" Font-Names="標楷體" Font-Size="Large" ForeColor="Red" Text="目前簽章啟用日期：" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label6" runat="server" Font-Names="標楷體" Font-Size="Large" Font-Bold="True" ForeColor="Red"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <asp:Label ID="Label5" runat="server" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue" Text="可輸入日期範圍值：" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label8" runat="server" Font-Names="標楷體" Font-Size="Large" Font-Bold="True" ForeColor="Blue"></asp:Label>
            <asp:Label ID="Label10" runat="server" Font-Names="標楷體" Font-Size="Large" ForeColor="Black" Font-Bold="True">～</asp:Label>
            <asp:Label ID="Label9" runat="server" Font-Names="標楷體" Font-Size="Large" Font-Bold="True" ForeColor="Blue"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Font-Names="標楷體" Font-Size="Large" Text="簽章啟用日期：" Font-Bold="True"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="9" Columns="26"></asp:TextBox>
            &nbsp;
        &nbsp;
            <br />
            <br />
            <asp:Label ID="Label12" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(1)簽章單位：" Font-Bold="True"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="12" Columns="26"></asp:TextBox>
            &nbsp; 
        <br />
            <br />
            <asp:Label ID="Label13" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(2)簽章職銜：" Font-Bold="True"></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="12" Columns="26"></asp:TextBox>
            &nbsp; 
        <br />
            <br />
            <asp:Label ID="Label14" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(3)簽章姓名：" Font-Bold="True"></asp:Label>
            <asp:TextBox ID="TextBox4" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="6" Columns="26"></asp:TextBox>
            &nbsp; 
        <br />
            <br />
                <%--2017拿掉onclick="myFunction()"，再把type="button" 改成 type="submit"--%>
            <input id="Button2" type="button" value="更新簽章" onclick="myFunction()" style="cursor: pointer; font-size: 18px; font-family: DFKai-sb; color: red; font-weight: bold" /><asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Red" Text="確認更新" OnClick="Button1_Click" Style="cursor: pointer" Visible="False" />
            <br />
            <asp:Label ID="Label3" runat="server" Font-Names="標楷體" Font-Size="Large" ForeColor="Red"></asp:Label>
            <br />
            </div>
            <asp:Label ID="Label15" runat="server" Font-Names="標楷體" Font-Size="Large" Font-Bold="True" ForeColor="#FF3300">簽章範例：</asp:Label>
            <br />
            <asp:Image ID="Image1" runat="server" Height="70px" Width="210px" />
            <div id="div_right"></div>
            
        </div>
    </form>
</body>
</html>
