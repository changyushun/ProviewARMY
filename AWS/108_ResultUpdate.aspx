<%@ Page Language="C#" AutoEventWireup="true" CodeFile="108_ResultUpdate.aspx.cs" Inherits="_108_ResultUpdate" %>

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
                var name = document.getElementById("txb_Name").value;
                var birth = document.getElementById("txb_Birth").value;
                var age = document.getElementById("txb_Age").value;
                
                //檢查欄位是否空白
                if (name.trim() != "" && birth.trim() != "" && age.trim() != "") {
                    //檢查日期格式
                    var ch = dateValidationCheck(date.trim());
                    //alert(ch);
                    if (ch == 1) {
                        document.getElementById("form1").submit();
                    }
                    else {
                        alert("生日格式錯誤，請輸入西元年/月/日：YYYY/MM/DD 日期格式");
                    }
                }
                else {
                    alert("個人基本資料欄位不可空白!!");
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="X-Large" Font-Underline="True" ForeColor="Blue" Text="成績補正"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(1)姓名：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Name" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldName" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(2)出生年月日：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Birth" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldBirth" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(3)年齡：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_Age" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldAge" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="lab_Item1" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(4)項次1(次/秒數)：" Font-Bold="True"></asp:Label>
        <%--<asp:CheckBox ID="cb_UndoneItem1" Text="未完測" runat="server" Font-Names="標楷體"/>--%>
        <asp:TextBox ID="txb_Item1" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldItem1" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="lab_ItemScore1" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(5)項次1成績：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_ItemScore1" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldItemScore1" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="lab_Item2" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(6)項次2(次/秒數)：" Font-Bold="True"></asp:Label>
        <%--<asp:CheckBox ID="cb_UndoneItem2" Text="未完測" runat="server" Font-Names="標楷體"/>--%>
        <asp:TextBox ID="txb_Item2" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldItem2" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="lab_ItemScore2" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(7)項次2成績：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_ItemScore2" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldItemScore2" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="lab_Item3" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(8)項次3(次/秒數)：" Font-Bold="True"></asp:Label>
        <%--<asp:CheckBox ID="cb_UndoneItem3" Text="未完測" runat="server" Font-Names="標楷體"/>--%>
        <asp:TextBox ID="txb_Item3" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldItem3" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="lab_ItemScore3" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(9)項次3成績：" Font-Bold="True"></asp:Label>
        <asp:TextBox ID="txb_ItemScore3" runat="server" Font-Names="標楷體" Font-Size="Medium" MaxLength="10" Columns="26"></asp:TextBox>
        <asp:Label ID="lab_OldItemScore3" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label11" runat="server" Font-Names="標楷體" Font-Size="Large" Text="(10)總評：" Font-Bold="True"></asp:Label>
        <asp:DropDownList ID="ddl_Status" runat="server" Font-Names="標楷體" Font-Size="Medium">
            <asp:ListItem>合格</asp:ListItem>
            <asp:ListItem>不合格</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lab_OldStatus" runat="server" Font-Names="標楷體" Font-Size="Large" Text="" ForeColor="Gray" ></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label12" runat="server" Font-Names="標楷體" Font-Size="Large" Text="[備註1：若該項目「未測」及「未完測」，欄位請空白]" ForeColor="Red" Font-Bold="True"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label13" runat="server" Font-Names="標楷體" Font-Size="Large" Text="[備註2：除「未測」及「未完測」之項目，其餘欄位不可空白]" ForeColor="Red" Font-Bold="True"></asp:Label>
        <br />
        <br />
        <input id="Button2" type="button" value="儲存更新" onclick="myFunction()" style="cursor: pointer; font-size: 18px; font-family: DFKai-sb; color: red; font-weight: bold" />
    </div>
    </form>
</body>
</html>
