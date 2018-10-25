<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bulletin.aspx.cs" ValidateRequest="false" Inherits="Bulletin" %>

<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html,charset=BIG5" />
    <link rel="Stylesheet" type="text/css" href="css/calendar-blue2.css" />

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript" src="Script/RankCode.ashx"></script>

    <script type="text/javascript" src="JS/jquery.dynDateTimeMinGo.js"></script>

    <script type="text/javascript" src="lang/calendar-utf8roc.js"></script>

<script type="text/javascript">
    $(function() {

        $('#startDate, #endDate').dynDateTime({ifFormat:"%Z%m%d"});
    });
    //跳出是否確認
    function Confirm() {
        var v1 = document.getElementById("Label1").innerText;
        if (v1 != '') {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("請確認發佈單位為「" + v1 + "」是否正確??"))
            {
                confirm_value.value = "Yes";
                
            }
            else
            {
                confirm_value.value = "No";
                return false;
            }
            document.forms[0].appendChild(confirm_value);
        }
        else {
            alert('帳號尚未綁定單位名稱，無法發佈公告!!');
            return false;
        }
        
    }
    function check_filed(form) {
        if (form.test.value == '') {
            alert('必填欄位!!');
            return false;
        }
    }
</script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <span>發佈單位：<asp:Label ID="Label1" runat="server"></asp:Label>
        <br />
        <br />
        標題：</span>
        <asp:TextBox ID="header" runat="server"></asp:TextBox>
        <br />
        <span>開始日期：</span><input type="text" id="startDate" runat="server" />
        <br />
        <span>結束日期：</span><input type="text" id="endDate" runat="server" />
        <br />    
        <span>大綱：</span>   
        <FTB:FreeTextBox ID="Ftb2" runat="server" Height="100px" >
        </FTB:FreeTextBox>
        <br />
        <span>內文：</span>
        <br />
        <FTB:FreeTextBox ID="Ftb1" runat="server" Height="210px" >
        </FTB:FreeTextBox>
        <br />
        <asp:Button ID="confirm" runat="server" Text="確定" OnClick="confirm_Click" OnClientClick = "if(Confirm()==false){return false;}" />
    </div>
    </form>
</body>
</html>
