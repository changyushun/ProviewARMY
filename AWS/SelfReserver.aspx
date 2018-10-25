<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SelfReserver.aspx.cs" Inherits="SelfReserver" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<link id="Login_css" rel="stylesheet" href="main.css" type="text/css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
<script type="text/javascript" src="Script/jquery.blockUI.js"></script>
<script type="text/javascript">
    $(function() {
        $('#checkLimit').click(function() {
            var _center_code = $('select option:selected').val();
            var _date = $(':text').val();
            if (_center_code != "0" && _date != "") {
                $.postJson('GetValueByCode.ashx', { mode: "centerLimit", center_code: _center_code, date: _date }, function(d, s) {
                    if (s == "success") {
                        $('#checkLimit').next().html('當日剩餘員額 : ');
                        $('#checkLimit').next().next().html(d["status"]);
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Div2").style.display = "none";
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Nonenough").style.display = "none";
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_bereserve").style.display = "none";
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_beok").style.display = "none";
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_noreserve").style.display = "none";
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_ConnectError").style.display = "none";
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_againreserve").style.display = "none";
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_canreserve").style.display = "none";
                        //alert();
                    }
                });
            }
            else {
                $('#checkLimit').next().html('請選擇鑑測站與日期');
            }
        });
        $('.go').click(function() {
            window.open('TeamApply.aspx?code=' + $('select option:selected').val() + '&date=' + $(':text').val(), '', 'left=50,top=50,scrollbars=yes,width=700,height=600,location=no');
        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Button1').click(function() {
            if ($('#checkLimit').next().next().html() != '' && parseInt($('#checkLimit').next().next().html()) > 0) {
                $.blockUI({ message: $('#BusyBoxDiv').html() });
            }
            else {
            }
        });

    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<div>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel" HeaderText="基本項目報進作業">
    <HeaderTemplate>
        基本項目報進作業
    </HeaderTemplate>
<ContentTemplate>
<div id="BusyBoxDiv" style="display:none;">
	<span style="color: #ff8000; width: 200px; font-size: 30px; font-weight: bold; text-align: center;"><img src="images/processing.gif"/> 基本三項報進作業中...</span>
</div>
<div id="Div2" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">請選擇鑑測站與日期,且查看當日剩餘人數...</span>
</div>
<div id="Nonenough" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">當日餘額不足,請選擇其他日期或鑑測站</span>
</div>
<div id="bereserve" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">您已有1筆預約,本次報進失敗</span>
</div>
<div id="beok" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">您已經是合格人員,本次報進失敗</span>
</div>
<div id="noreserve" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">此月份已測驗,請報進其他月份</span>
</div>
<div id="ConnectError" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">報進作業異常,請重新報進</span>
</div>
<div id="canreserve" style="display:none;" runat="server">
	<span style="color:blue; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">報進成功,系統將寄送報進通知信至您的信箱</span>
</div>
<div id="againreserve" style="display:none;" runat="server">
	<span style="color:Green; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">報進成功,系統將寄送報進通知信至您的信箱</span>
	<br />
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">註:您為30天內補測人員,系統自動變更鑑測站為上次測驗之鑑測站</span>
</div>
<div id="OrderStep1" runat="server">
                <table border="0" cellspacing="0" cellpadding="5" >
                <tr><td class="Order_Section_tr1_td1">請選擇鑑測站</td><td class="Order_Section_tr1_td2">
                         <asp:DropDownList runat="server" ID="cneterSel" AutoPostBack="True" 
                            onselectedindexchanged="cneterSel_SelectedIndexChanged" 
                            DataSourceID="SqlDataSource1" DataTextField="center_name" 
                            DataValueField="center_code">
                            </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
                            SelectCommand="Ex103_GetCenterList" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource></td></tr><tr>
                    <td class="Order_Section_tr2_td1">請選擇鑑測日期</td><td class="Order_Section_tr2_td2">
                    <div>
                        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                            BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" 
                            DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" 
                            ForeColor="#003399" Height="200px" Width="220px" 
                            ondayrender="Calendar1_DayRender" 
                            onselectionchanged="Calendar1_SelectionChanged">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" 
                                Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                         </asp:Calendar>                     
                     </div>
                     <div id="dateDiv" runat="server">                            
                          <br/><asp:TextBox ID="selectDate" runat="server" Enabled="False"></asp:TextBox><br /><input type="button" value="查看當日剩餘人數" id="checkLimit" class="buttom_grey" />
                          <span style="color:Red"></span><span style="color:Red"></span><br />
                     </div>
                     </td>
                </tr>
             </table>          
</div>
<div id="SureTimeAndPlace" runat="server">
    <table>
        <tr>
            <td>
            <IMG src="images/dot.gif" width=100 height=10>&nbsp;&nbsp;&nbsp;</td><td align="right">
            <asp:Button ID="Button1" runat="server" Text="開始報進" CssClass="buttom_main" onclick="Button1_Click" /></td>
        </tr>
     </table>
</div>
</ContentTemplate>
</ajaxToolkit:TabPanel>

<ajaxToolkit:TabPanel ID="TabPane2" runat="server" HeaderText="查詢預約">
<ContentTemplate>
<div id="zerorder" style="display:none;" runat="server">
	<span style="color:blue; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">查無報進資訊。</span>
</div>
<%--<asp:Button ID="check" runat="server" Text="查詢" OnClick="check_OnClick" />--%>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" PageSize = "25" 
    OnRowDataBound="GridView2_OnRowDataBound" OnDataBound="GridView2_OnDataBound">
        <Columns>
            <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="date" />
            <asp:BoundField DataField="center_name" HeaderText="鑑測地點" SortExpression="center_name" />  
            <asp:HyperLinkField Text="變更" Target="_self" DataNavigateUrlFields="center_code,date" DataNavigateUrlFormatString="SelfReverserChange.aspx?center_code={0}&date={1}" HeaderText="變更"/>
            <asp:HyperLinkField Text="刪除" Target="_self" DataNavigateUrlFields="center_code,date" DataNavigateUrlFormatString="SelfReverserCancel.aspx?center_code={0}&date={1}" HeaderText="刪除"/>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>"
        SelectCommand="SELECT DISTINCT CONVERT(varchar(10), date,111) AS date, (SELECT center_name FROM Center AS c WHERE (center_code = r.center_code)) AS center_name, op_id, center_code FROM Result AS r WHERE (id = @op_id and status = '000' and date > @date and memo = '000' and (result is NULL or result = '777') )">
            <SelectParameters>
                <asp:Parameter Name="op_id" />
                <asp:Parameter Name="date" Type="DateTime" />
            </SelectParameters>
    </asp:SqlDataSource>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</div>
</asp:Content>

