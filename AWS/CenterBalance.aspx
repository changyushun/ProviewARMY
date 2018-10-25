<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CenterBalance.aspx.cs" Inherits="CenterBalance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<link rel="Stylesheet" type="text/css" href="MasterPage.css"/>
    <title>即時查詢鑑測站報進人數</title>  
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function() {
            //setInterval(ref, 15000);
        });
        function ref() {

            document.form1.submit();
            //$('#form1')[0].submit();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <span>請輸入查詢日期(例：99/1/1)：</span><asp:TextBox ID="date" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" Text="查詢" onclick="Button1_Click" />    
    </div>
    <div style="text-align:center">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="400" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle">
             <Columns>
             <asp:BoundField DataField="center" HeaderText="鑑測站" SortExpression="center" ItemStyle-Wrap="false"/>
             <asp:BoundField DataField="num" HeaderText="報進人數" SortExpression="num" ItemStyle-Wrap="false"/>
             <asp:BoundField DataField="limit" HeaderText="報進限額" SortExpression="limit" ItemStyle-Wrap="false"/>
             </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
