<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Protal.aspx.cs" Inherits="Protal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
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
    <a href="Protal.aspx" style="color:#0000FF">&nbsp;: : : 回首頁</a> | <a href="Login.aspx" style="color:#0000FF">登入</a> | 
        <a href="106_Check_Score.aspx" style="color:#0000FF">成績單驗證</a> |
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
           <input id="Button5" type="button" value="陸軍成功嶺鑑測站" class="buttom_main" /> 
           <input id="Button6" type="button" value="陸軍砲測中心鑑測站" class="buttom_main" /> 
           <input id="Button7" type="button" value="陸軍步校鑑測站" class="buttom_main" /> 
           <input id="Button8" type="button" value="陸軍南測中心鑑測站" class="buttom_main" /> 
           <input id="Button9" type="button" value="空軍軍官學校鑑測站" class="buttom_main" /> 
           <input id="Button10" type="button" value="陸軍花防部鑑測站" class="buttom_main" />
           <input id="Button11" type="button" value="海軍陸戰隊學校鑑測站" class="buttom_main" /> 
        </div>
        
   
        <div class="content_right_div_protal">
            <center><span>國防部最新消息<asp:HiddenField ID="newid" runat="server" /></span></center>
            <table style="border:1px solid #C0C0C0; width:98%; font-weight:normal;margin-left :1%">
                <tr>
                    <td style="border:1px solid #C0C0C0; width:10%; font-weight:bold">公告單位</td>
                    <td style="border:1px solid #C0C0C0; font-weight:bold"><asp:Label ID="LB_unit" runat="server" Text="單位"></asp:Label></td>
                </tr>
                <tr>
                    <td style="border:1px solid #C0C0C0; width:10%; font-weight:bold">主旨</td>
                    <td style="border:1px solid #C0C0C0; font-weight:bold"><asp:Label ID="LB_head" runat="server" Text="標題"></asp:Label></td>
                </tr>
                <tr>
                    <td style="border:1px solid #C0C0C0;" colspan=2><asp:Label ID="LB_text" runat="server" Text="大綱"></asp:Label><br /><a id="link" runat="server" style="color:#0000FF;cursor: pointer;cursor:hand" >(詳看全文...)</a></td>
                </tr>
            </table>
            
            <div style="margin-top:4px; margin-bottom:4px">
            <span style="margin-left :1%">最新消息列表</span><span id="Total" runat="server" style="color:#0000FF;margin-left :1px"></span><span style="margin-left:50%">分類</span>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"
                DataSourceID="SqlDataSource2" DataTextField="unit_name" 
                DataValueField="unit_name" 
                onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
                onprerender="DropDownList1_PreRender">
            </asp:DropDownList>
            </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:MainDB %>" 
                SelectCommand="Ex102_GetBulletinUnit" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
            <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="protal_gridview_header"  DataSourceID="SqlDataSource1" 
            onrowdatabound="GridView1_RowDataBound"  Width="98%" CellPadding="4" AllowPaging="true" PageSize="5" 
                    ForeColor="#333333" GridLines="None">
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <Columns>
                <asp:BoundField DataField="head" HeaderText="主旨" SortExpression="head">
                <HeaderStyle Width="50%" />
                </asp:BoundField>
                <asp:BoundField DataField="start" HeaderText="有效日期" SortExpression="start" DataFormatString="{0:yyyy/MM/dd}">
                <HeaderStyle Width="100px" Wrap="True" />
                </asp:BoundField>
                <asp:BoundField DataField="deadline" HeaderText="結束日期" SortExpression="deadline" DataFormatString="{0:yyyy/MM/dd}">
                <HeaderStyle Width="100px" Wrap="True" />
                </asp:BoundField>
                <asp:BoundField DataField="unit_name" HeaderText="單位" 
                    SortExpression="unit_name">
                <HeaderStyle Width="200px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="內容">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text="查看"></asp:Label>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("sid") %>' />
                    </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </asp:TemplateField>
                
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
            SelectCommand="select head, start,sid,deadline,unit_name  from Bulletin  where deadline >= @date and unit_name = @unit_name order by insertDate DESC ">
            <%--SelectCommand="select b.head, b.start,b.sid,b.deadline,(select unit_title from unit u where u.unit_code = a.unit_code) as unit_title from Account a ,Bulletin b where b.acc = a.account and b.deadline >= @date and a.unit_code = @unit_code order by b.insertDate DESC ">--%>
            <SelectParameters>
                <asp:Parameter Name="date" Type="DateTime" />
                <%--<asp:Parameter Name="unit_code" Type="String" />--%>
                <asp:Parameter Name="unit_name" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>    
    </div>
        </div>
    </div>
    </form>
    </center>
</body>
</html>
