<%@ Page Language="C#" AutoEventWireup="true" CodeFile="108_PlayerUpdate.aspx.cs" Inherits="_108_PlayerUpdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        function dateValidationCheck(str) {
            var re = new RegExp("^([0-9]{4})[./]{1}([0-9]{1,2})[./]{1}([0-9]{1,2})$");
            var strDataValue;
            var infoValidation = true;
            var a = 1;
            var b = 0;
            if ((strDataValue = re.exec(str)) != null) {
                var i;
                i = parseFloat(strDataValue[1]);
                if (i <= 0 || i > 9999) { /*年*/
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
            try {
                //window.opener.outside();//先mark，cs有執行一次了
                var id = document.getElementById("txb_Id").value;
                var name = document.getElementById("txb_Name").value;
                var birth = document.getElementById("txb_Birth").value;
                var mail = document.getElementById("txb_Mail").value;
                var password = document.getElementById("txb_Password").value;
                //檢查欄位是否空白
                if (id.trim() != "" && name.trim() != "" && birth.trim() != "" && mail.trim() != "" && password.trim() != '') {
                    //檢查日期格式
                    var ch = dateValidationCheck(birth.trim());
                    //alert(ch);
                    if (ch == 1) {
                        document.getElementById("form1").submit();
                    }
                    else {
                        alert("生日格式錯誤，請輸入西元年/月/日：YYYY/MM/DD 日期格式");
                    }
                }
                else {
                    alert("欄位不可空白!!");
                }
                
            }
            catch (err) {
                //alert(err.message);
                document.getElementById("form1").submit();
            }

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="X-Large" Font-Underline="True" ForeColor="Blue" Text="基本資料異動"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(1)姓名：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Name" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldName" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(2)身份證字號：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Id" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldId" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(3)出生年月日：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Birth" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldBirth" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(4)電子信箱：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Mail" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="20" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldMail" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(5)密碼：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Password" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="16" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldPassword" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <input id="Button2" type="button" value="儲存更新" onclick="myFunction()" style="cursor: pointer; font-size: 18px; font-family: DFKai-sb; color: red; font-weight: bold" />
    </div>
    </form>
</body>
</html>
