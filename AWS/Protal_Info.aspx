<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Protal_Info.aspx.cs" Inherits="Protal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <link id="Login_css" rel="stylesheet" href="main.css" type="text/css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript" charset="UTF-8">
        $(document).ready(function() {
            $("#test").click(function() {

                var curTbl = document.getElementById('detail');
                //alert(curTbl);
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
                
            });
        });
    </script>
    <script type="text/javascript">
        $(function() {

        $('#Button1').click(function() {
            window.location.href = "Protal_FileDownload.aspx";
        });

        $('#Button2').click(function() {
            window.location.href = "Login.aspx";
        });

        $('#Button3').click(function() {
            window.location.href = "Protal_Info.aspx?sid=1";
        });

        $('#Button4').click(function() {
            window.location.href = "Protal_Info.aspx?sid=2";
        });

        $('#Button5').click(function() {
            window.location.href = "Protal_Info.aspx?sid=10";
        });

        $('#Button6').click(function() {
            window.location.href = "Protal_Info.aspx?sid=4";
        });

        $('#Button7').click(function() {
            window.location.href = "Protal_Info.aspx?sid=5";
        });

        $('#Button8').click(function() {
            window.location.href = "Protal_Info.aspx?sid=6";
        });

        $('#Button9').click(function() {
            window.location.href = "Protal_Info.aspx?sid=9";
        });

        $('#Button10').click(function() {
            window.location.href = "Protal_Info.aspx?sid=8";
        });

        $('#Button11').click(function () {
            window.location.href = "Protal_Info.aspx?sid=11";
        });

        });
    </script>
    <title>國軍基本體能鑑測網</title>
</head>
<body>
<center>
    <form id="form2" runat="server" submitdisabledcontrols="False">
    <div class="head_back_index">
    <a href="Protal.aspx" style="color:#0000FF">&nbsp;: : : 回首頁</a>
    </div>
    <div class="head_space_div"> 
    </div>
    <div class="head_div">  
        &nbsp;: : : 現在位置﹥首頁
    </div>
    <div class="content_div_protal_info">
        <div class="context_left_div_protal_info">
           <input id="Button1" type="button" value="文件下載" class="buttom_main" /> 
           <input id="Button2" type="button" value="鑑測報進" class="buttom_main" /> 
           <span>=鑑測名冊檢視=</span>
           <input id="Button3" type="button" value="陸軍專校鑑測站" class="buttom_main" /> 
           <input id="Button4" type="button" value="陸軍北測中心鑑測站" class="buttom_main" /> 
           <input id="Button5" type="button" value="陸軍成功嶺鑑測站" class="buttom_main" /> 
           <input id="Button6" type="button" value="陸軍砲測中心鑑測站" class="buttom_main" /> 
           <input id="Button7" type="button" value="陸軍步校鑑測站" class="buttom_main" /> 
           <input id="Button8" type="button" value="陸軍南測中心鑑測站" class="buttom_main" /> 
           <input id="Button9" type="button" value="空軍軍官學校鑑測站" class="buttom_main" /> 
           <input id="Button10" type="button" value="陸軍花防部鑑測站" class="buttom_main" /> 
           <input id="Button11" type="button" value="海軍陸戰隊學校鑑測站" class="buttom_main" /> 
        </div>
        
   
        <div class="content_right_div_protal_info">
            <div style="margin-bottom:6px; margin-top:6px; margin-left:6px"><span><a href="#" class="export" id="test">匯出名單成.excel檔案(僅支援IE瀏覽器)</a>  匯出名單前請先設定信任網站</span></div>
            <div id="detail">
            <span style=" margin-left:5px">鑑測站：</span><asp:Label ID="center_name" runat="server" Text="Label"></asp:Label><br />
            <span style=" margin-left:5px">今日報進總數：</span><asp:Label ID="total" runat="server" Text="Label"></asp:Label><br />
            <span style=" margin-left:5px">鑑測名冊：</span><span style="margin-left:30%">* 為替代項目受測人員</span><br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="protal_gridview_reserve" 
              DataSourceID="SqlDataSource1" onrowdatabound="GridView1_RowDataBound" 
                DataKeyNames="sid" >
        <Columns>
            <asp:BoundField DataField="sid" HeaderText="編號" 
                SortExpression="sid" />
            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
            <asp:BoundField DataField="unit_title" HeaderText="單位" 
                SortExpression="unit_title" />
            <asp:BoundField DataField="rank_title" HeaderText="級職" 
                SortExpression="rank_title" />
            
        </Columns>
    </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MainDB %>" SelectCommand="Ex102_QueryReserve" 
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="date" Type="DateTime" />
                <asp:SessionParameter Name="center_code" SessionField="center_code" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
            
        </div>
    </div>
    </form>
    </center>
</body>
</html>
