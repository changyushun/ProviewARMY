<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_TeamReserveChange.aspx.cs" Inherits="HQ_TeamReserveChange" MaintainScrollPositionOnPostback="true" %>

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
                        //$('#checkLimit').next().html($('select option:selected').text());
                        $('#checkLimit').next().next().html(d["status"]);
                        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Label1').html(d["status"]);
                        document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Div1").style.display = "none";
                        //alert();
                    }
                });
            }
            else {
                $('#checkLimit').next().html('請選擇鑑測站與日期');
            }
        });

        $('td[style=$"green"]').each(function() {
            $(this).attr({ style: 'display:none' });
        });

        $('#Button4').click(function() {
            window.location.href = "HQ_TeamReserve.aspx";
        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Button2').click(function() {
            $.blockUI({ message: $('#BusyBoxDiv').html() });
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<div>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel" HeaderText="團體報進變更作業">

    <HeaderTemplate>
        團體報進變更作業
    </HeaderTemplate>

<ContentTemplate>
<div>
<div id="BusyBoxDiv" style="display:none;">
	<span style="color: #ff8000; width: 200px; font-size: 30px; font-weight: bold; text-align: center;"><img src="images/processing.gif"/> 變更報進作業中...</span>
</div>
<div id="Div1" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">請查看當日剩餘人數...</span>
</div>
</div><div id="Nonenough" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">當日餘額不足 , 請選擇其他日期或鑑測站</span>
</div>
</div><div id="ConnectError" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">網路連線異常 , 請重新作業</span>
</div>
<div id="onlylater" style="display:none;" runat="server">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">系統只接受延期變更(僅限變更至今年度) , 若想將鑑測日期提前 , 請重新報進</span>
</div>
<div id="OrderStep1" runat="server">
                <table border="0" cellspacing="0" cellpadding="5" >
                <tr><td class="Order_Section_tr1_td1">原鑑測站</td><td class="Order_Section_tr1_td2"><asp:Label ID="oldcenter" runat="server" Text="Label"></asp:Label></td></tr><tr><td class="Order_Section_tr2_td1">原鑑測日期</td><td class="Order_Section_tr2_td2"><asp:Label ID="olddate" runat="server" Text="Label"></asp:Label></td></tr><tr><td class="Order_Section_tr2_td1">原鑑測人數</td><td class="Order_Section_tr2_td2"><asp:Label ID="oldcount" runat="server" Text="Label"></asp:Label></td></tr><tr>
                    <td class="Order_Section_tr2_td1">請選擇新鑑測站</td><td class="Order_Section_tr2_td2">
                        <asp:DropDownList runat="server" ID="cneterSel" AutoPostBack="True" 
                            onselectedindexchanged="cneterSel_SelectedIndexChanged" 
                            DataSourceID="SqlDataSource1" DataTextField="center_name" 
                            DataValueField="center_code">
                            </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
                            SelectCommand="Ex103_GetCenterList" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </td></tr><tr>
                    <td class="Order_Section_tr2_td1">請選擇新鑑測日期</td><td class="Order_Section_tr2_td2">
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
            <asp:Button 
                        ID="Button2" runat="server" Text="變更報進地點/日期" CssClass="buttom_main" 
                        onclick="Button2_Click" /></td>
        </tr>
     </table>
</div>
<div id="Result" runat="server" style="display:none">
    <table>
        <tr><td class="Order_Section_tr1_td1">新鑑測站</td><td class="Order_Section_tr1_td2">
            <asp:Label ID="newcenter" runat="server" Text="Label"></asp:Label></td></tr><tr><td class="Order_Section_tr3_td1">新鑑測日期</td><td class="Order_Section_tr3_td2">
            <asp:Label ID="newdate" runat="server" Text="Label"></asp:Label></td></tr><tr><td class="Order_Section_tr2_td1">鑑測人數</td><td class="Order_Section_tr2_td2">
            <asp:Label ID="newcount" runat="server" Text="Label"></asp:Label></td></tr></table></div><div id="ReturnStep1" style="display:none" runat="server">
    <table>
        <tr>
            <td><input type="button" value="回報進首頁" id="Button4" class="buttom_grey" /></td><td align="right"></td>
        </tr>
     </table>
</div>         
</div>           
</ContentTemplate></ajaxToolkit:TabPanel></ajaxToolkit:TabContainer></div></asp:Content>