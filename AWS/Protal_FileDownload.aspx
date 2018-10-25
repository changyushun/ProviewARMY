<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Protal_FileDownload.aspx.cs" Inherits="Protal_FileDownload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <link id="Login_css" rel="stylesheet" href="main.css" type="text/css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
	
    <script type="text/javascript">
        
    
        $(function() {
    
        
            $('#GridView1 span').each(function() {
            $(this).attr({ style: "cursor: pointer;cursor:hand" });
                $(this).click(function() {
                    var sid = $(this).next().val();
                    window.open('BulletinView.aspx?sid=' + sid, "", "menubar=no,resizable=yes,");
                });
            });

            $('#link').click(function() {
                var sid = $('#newid').val();
                window.open('BulletinView.aspx?sid=' + sid, "", "menubar=no,resizable=yes,");
            });

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
            window.location.href = "Protal_Info.aspx?sid=3";
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
            window.location.href = "Protal_Info.aspx?sid=7";
            });

            $('#Button10').click(function() {
            window.location.href = "Protal_Info.aspx?sid=8";
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
    <div class="content_div_protal">
        <div class="context_left_div_protal">            
           <input id="Button1" type="button" value="文件下載" class="buttom_main" /> 
           <input id="Button2" type="button" value="鑑測報進" class="buttom_main" /> 
           <span>=鑑測名冊檢視=</span>
           <input id="Button3" type="button" value="陸軍專校鑑測站" class="buttom_main" /> 
           <input id="Button4" type="button" value="陸軍北測中心鑑測站" class="buttom_main" /> 
           <input id="Button5" type="button" value="後備成功嶺鑑測站" class="buttom_main" /> 
           <input id="Button6" type="button" value="陸軍砲測中心鑑測站" class="buttom_main" /> 
           <input id="Button7" type="button" value="陸軍步校鑑測站" class="buttom_main" /> 
           <input id="Button8" type="button" value="陸軍南測中心鑑測站" class="buttom_main" /> 
           <input id="Button9" type="button" value="防訓中心鑑測站" class="buttom_main" /> 
           <input id="Button10" type="button" value="陸軍花防部鑑測站" class="buttom_main" /> 
        </div>
        
   
        <div class="content_right_div_protal">
            <center><span>文件下載<asp:HiddenField ID="newid" runat="server" /></span></center>            
            <div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AutoGenerateColumns="False" CssClass="protal_gridview_header" 
            Width="98%" PageSize = "15" DataKeyNames="sid"  ForeColor="#333333" GridLines="None"
         DataSourceID="SqlDataSource1" onrowdatabound="GridView1_RowDataBound" 
                    CellPadding="4" >
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
         <Columns>
         <asp:BoundField DataField="filename" HeaderText="標題" ReadOnly="True" SortExpression="filename" />
         <asp:HyperLinkField DataNavigateUrlFields="sid" HeaderText="檔案下載" Text="下載" datatextformatstring="{0:c}"
            datanavigateurlformatstring="~\DownloadController.aspx?AttachID={0}"           />
         <asp:BoundField DataField="uploaddate" HeaderText="更新日期" ReadOnly="True" SortExpression="uploaddate" />
         </Columns>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#999999" />
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
     </asp:GridView>
       <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
         ConnectionString="<%$ ConnectionStrings:MainDB %>" 
         SelectCommand="SELECT [sid], [filename], [filepath] , [uploaddate] FROM [FileManage] where [data] is not null Order by [uploaddate] desc">
     </asp:SqlDataSource> 
    </div>
        </div>
    </div>
    </form>
    </center>
</body>
</html>

