<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_TeamReserve.aspx.cs" Inherits="HQ_TeamReserve" MaintainScrollPositionOnPostback="true" %>

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
            if (_date != '') {
                $.postJson('GetValueByCode.ashx', { mode: "centerLimit", center_code: _center_code, date: _date }, function(d, s) {
                    if (s == "success") {
                        $('#checkLimit').next().html('當日剩餘員額 : ');
                        //$('#checkLimit').next().html($('select option:selected').text());
                        $('#checkLimit').next().next().html(d["status"]);
                        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Label1').html(d["status"]);
                        document.getElementById("Div1").style.display = "none";
                        //alert();
                    }
                });
            }
            else {
                document.getElementById("Div1").style.display = "";
            }
        });

        $('td[style=$"green"]').each(function() {
            $(this).attr({ style: 'display:none' });
        });

        $('#Button1').click(function() {
            if ($('#checkLimit').next().next().html() != '' && parseInt($('#checkLimit').next().next().html()) > 0) {
                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_surecenter').text($('select option:selected').text());
                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_suredate').text($(':text').val());
                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Re_surecenter').text($('select option:selected').text());
                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Re_suredate').text($(':text').val());
                document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_SureTimeAndPlace").style.display = "none";
                document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_OrderStep1").style.display = "none";
                document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_SuccessDetails").style.display = "none";
                document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_failDatails").style.display = "none";
                document.getElementById("OrderStep2").style.display = "";
                document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_SureOrder").style.display = "";
                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_datehide').val($(':text').val());
                $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_centerhide').val($('select option:selected').text());
            }
            else {
                document.getElementById("Div1").style.display = "";
            }
        });

        $('#Button2').click(function() {
            $('#aspnetForm')[0].submit();
        });

        $('#Button4').click(function() {
            window.location.href = "HQ_TeamReserve.aspx";
        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Button3').click(function() {
            $.blockUI({ message: $('#BusyBoxDiv').html() });
        });

        $('#shrink').click(function() {
            var style = document.getElementById("show").style.display;
            if (style != "") {
                document.getElementById("show").style.display = "";
                document.getElementById("shrink").src = "images/minus.png";
            }
            else {
                document.getElementById("show").style.display = "none";
                document.getElementById("shrink").src = "images/plus.png";
            }
        });

        $('#shrinkfail').click(function() {
            var style = document.getElementById("showfail").style.display;
            if (style != "") {
                document.getElementById("showfail").style.display = "";
                document.getElementById("shrinkfail").src = "images/minus.png";
            }
            else {
                document.getElementById("showfail").style.display = "none";
                document.getElementById("shrinkfail").src = "images/plus.png";
            }
        });

        $('#shrinkerrorformat').click(function() {
            var style = document.getElementById("showerrorformat").style.display;
            if (style != "") {
                document.getElementById("showerrorformat").style.display = "";
                document.getElementById("shrinkerrorformat").src = "images/minus.png";
            }
            else {
                document.getElementById("showerrorformat").style.display = "none";
                document.getElementById("shrinkerrorformat").src = "images/plus.png";
            }
        });

    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<div>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel" HeaderText="團體報進作業">
    <HeaderTemplate>
        團體報進作業
    </HeaderTemplate>
<ContentTemplate>
<div><input id="datehide" type="hidden" runat="server" ></input>
</input>
</input>
</input>
</input>
</input>
</input>









<input id="centerhide" runat="server" type="hidden"></input>
</input>
</input>
</input>
</input>
</input>
</input>









</div><div id="Div1" style="display:none;">
	<span style="color:red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">請選擇日期且查看當日剩餘人數...</span>
</div>
<div id="OrderStep1" runat="server">
                <div style="margin-top:5px; margin-bottom:5px">團體報進作業需上傳報名名單，<asp:HyperLink 
                                ID="HyperLink2" runat="server" ForeColor="Blue" 
                                NavigateUrl="~/TeamReserver.txt">請下載名單範例</asp:HyperLink>。</div><table border="0" cellspacing="0" cellpadding="5" >
                <tr>
                    <td class="Order_Section_tr1_td1">請選擇鑑測站</td><td class="Order_Section_tr1_td2">
                        <asp:DropDownList 
                            runat="server" ID="cneterSel" AutoPostBack="True" 
                            onselectedindexchanged="cneterSel_SelectedIndexChanged" 
                            DataSourceID="SqlDataSource1" DataTextField="center_name" 
                            DataValueField="center_code"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
                            SelectCommand="Ex103_GetCenterList" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </td></tr><tr>
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
                          <span style="color:Red"></span><span style="color:Red"></span></div>
                     </td>
                </tr>
             </table>          
</div>
<div id="SureTimeAndPlace" runat="server" >
    <table>
        <tr>
            <td>
            <IMG src="images/dot.gif" width=100 height=10>&nbsp;&nbsp;&nbsp;</td><td align="right">
            <input type="button" value="確認時間與地點" id="Button1" class="buttom_main" />
                </td>
        </tr>
     </table>
</div>

<div id="OrderStep2" style="display:none">
     <div style="margin-top:5px; margin-bottom:5px">團體報進作業需上傳報名名單，<asp:HyperLink 
                ID="HyperLink1" runat="server" ForeColor="Blue" 
                NavigateUrl="~/TeamReserver.txt" Target="_blank">請下載名單範例</asp:HyperLink>。</div><table border=0 cellSpacing=0 cellPadding=5>
        <tr>
        <td class="Order_Section_tr1_td1">鑑測站</td><td class="Order_Section_tr1_td2"><asp:Label ID="surecenter" runat="server"></asp:Label></td></tr><tr>
        <td class="Order_Section_tr3_td1">鑑測日期</td><td class="Order_Section_tr3_td2"><asp:Label ID="suredate" runat="server"></asp:Label></td></tr><tr>
        <td class="Order_Section_tr3_td1">上傳名單</td><td class="Order_Section_tr3_td2"><asp:FileUpload ID="FileUpload1" runat="server" /></td>
        </tr>
        <tr>
        <td class="Order_Section_tr2_td1">剩餘人數</td><td class="Order_Section_tr2_td2">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></td></tr></table></div><div id="BusyBoxDiv" style="display:none;">
	<span style="color: #ff8000; width: 200px; font-size: 30px; font-weight: bold; text-align: center;"><img src="images/processing.gif"/> 預約報進作業中...</span>
</div>
<div id="SureOrder" style="display:none" runat="server">
    <table>
        <tr>
            <td><input type="button" value="回上一頁" id="Button2" class="buttom_grey" /></td><td align="right"><asp:Button 
                        ID="Button3" runat="server" Text="開始報進" CssClass="buttom_main" 
                        onclick="Button3_Click" /></td>
        </tr>
     </table>
</div>


<div id="Result" style="display:none" runat="server">
    <table border=0 cellSpacing=0 cellPadding=5>
        <tr><td class="Order_Section_tr1_td1">鑑測站</td><td class="Order_Section_tr1_td2"><asp:Label ID="Re_surecenter" runat="server"></asp:Label></td></tr><tr><td class="Order_Section_tr3_td1">鑑測日期</td><td class="Order_Section_tr3_td2"><asp:Label ID="Re_suredate" runat="server"></asp:Label></td></tr><tr><td class="Order_Section_tr3_td1">報進人數</td><td class="Order_Section_tr3_td2"><asp:Label ID="Re_Count" runat="server" Text="Label"></asp:Label></td></tr><tr><td class="Order_Section_tr3_td1">報進成功資訊</td><td class="Order_Section_tr3_td2"><div id="SuccessDetails" style="display:none" runat="server">
    <span style="font-family: 微軟正黑體;  font-size: 14px;font-weight: bold; "><img id="shrink" src="images/plus.png" />展開成功名單</span>
    <asp:Label 
                ID="Re_Success_Count" runat="server"></asp:Label></div ><div id="show" style="display:none">
    <asp:GridView 
                    ID="GridView1" runat="server" CssClass="GridViewStyle" OnRowDataBound="GridView3_OnRowDataBound"
            Width="861px" PageSize = "25" ><AlternatingRowStyle CssClass="AltRowStyle" /><EditRowStyle 
                    CssClass="EditRowStyle" /><HeaderStyle CssClass="HeaderStyle" /><PagerStyle 
                    CssClass="PagerStyle" /><RowStyle CssClass="RowStyle" /><SelectedRowStyle 
                    CssClass="SelectedRowStyle" /></asp:GridView></div></td></tr>
    <tr><td class="Order_Section_tr3_td1">報進失敗資訊</td><td class="Order_Section_tr3_td2"><div id="failDatails" style="display:none" runat="server">
    <span style="font-family: 微軟正黑體;  font-size: 14px;font-weight: bold; "><img id="shrinkfail" src="images/plus.png" />展開失敗名單</span>
    <asp:Label 
                    ID="Re_fail_Count" runat="server"></asp:Label></div ><div id="showfail" style="display:none">
    <asp:GridView 
                        ID="GridView3" runat="server" CssClass="GridViewStyle" OnRowDataBound="GridView3_OnRowDataBound"
            Width="861px" PageSize = "25" ><AlternatingRowStyle CssClass="AltRowStyle" /><EditRowStyle 
                        CssClass="EditRowStyle" /><HeaderStyle CssClass="HeaderStyle" /><PagerStyle 
                        CssClass="PagerStyle" /><RowStyle CssClass="RowStyle" /><SelectedRowStyle 
                        CssClass="SelectedRowStyle" /></asp:GridView></div></td></tr>
    <tr><td class="Order_Section_tr2_td1">格式錯誤資訊</td><td class="Order_Section_tr2_td2"><div id="Div2" style="display:none" runat="server">
    <span style="font-family: 微軟正黑體;  font-size: 14px;font-weight: bold; "><img id="shrinkerrorformat" src="images/plus.png" />展開格式錯誤名單</span>
    <br/><div id="showerrorformat" style="display:none"><asp:Label ID="error_format" runat="server"></asp:Label></div></div ></td></tr></table></div><div id="ReturnStep1" style="display:none" runat="server">
    <table>
        <tr>
            <td><input type="button" value="回報進首頁" id="Button4" class="buttom_grey" /></td><td align="right"></td>
        </tr>
     </table>
</div>

<div id="list_rule" style="padding-left:10px"  >
<li>請將網頁上的範例下載，再進行報名名單的編輯。如下圖請編輯紅線圈選的部分。<br />
<img src="images/團報注意事項.JPG" /></li><li><span>編輯完報進名單請另存新檔，且存檔時選擇編碼：UFT-8。</span><br />
<img src="images/團報注意事項2.jpg" /></li><li><span>報進完成後檢視名單，如顯示是亂碼，請刪除報進後，確認編碼是UFT-8並重新報進。</span></li><li>團報資料對"已註冊帳號"之「姓名」、「生日」、「信箱」將以原註冊資料為主，不會覆蓋原有資料，"未註冊帳號"之人員將依團報資料新增個人帳號。</li><li>個人資料中「姓名」、「信箱」若有錯誤請登入個人帳號自行修改，若「生日」有錯誤，請於鑑測當天檢錄時提交個人證件請檢錄人員作修改。</li><li>在行事曆上紅色的日期為周一至周五不接受報進，綠色的日期為周六、日接受報進。</li><li>如曾經團體報進出現亂碼，請使用出現亂碼的資料以受測人員身份登入，檢查個人資訊是否有亂碼。</li><li>名單中的WebMail請填寫信箱名稱，@Webmail.mil.tw不用填寫。</li></div></ContentTemplate></ajaxToolkit:TabPanel><ajaxToolkit:TabPanel ID="TabPane2" runat="server" HeaderText="變更預約">
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
            <asp:HyperLinkField Text="變更" Target="_self" DataNavigateUrlFields="center_code,date" DataNavigateUrlFormatString="HQ_TeamReserveChange.aspx?center_code={0}&date={1}" HeaderText="變更"/>
            <asp:HyperLinkField Text="刪除" Target="_self" DataNavigateUrlFields="center_code,date" DataNavigateUrlFormatString="HQ_TeamReserverCancel.aspx?center_code={0}&date={1}" HeaderText="刪除"/>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>"
        SelectCommand="SELECT DISTINCT CONVERT(varchar(10), date,111) AS date, (SELECT center_name FROM Center AS c WHERE (center_code = r.center_code)) AS center_name, op_id, center_code FROM Result AS r WHERE (op_id = @op_id and status = '000' and date > @date)">
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

