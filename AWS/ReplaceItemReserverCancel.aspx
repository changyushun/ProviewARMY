<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ReplaceItemReserverCancel.aspx.cs" Inherits="ReplaceItemReserverCancel" %>

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
        window.location.href = "ReplaceItemReserver.aspx";
        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_Button2').click(function() {
            $.blockUI({ message: $('#BusyBoxDiv').html() });
        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_GridView1_ctl01_selectall').click(function() {
            if ($(this)[0].checked == true) {
                $(':checkbox').each(function() {
                    $(this)[0].checked = true;
                });
            }
            else {
                $(':checkbox').each(function() {
                    $(this)[0].checked = false;
                });
            }
        });
    });
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<div>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel" HeaderText="替代項目取消作業">
    <HeaderTemplate>
        替代項目取消作業
    </HeaderTemplate>
<ContentTemplate>
<div id="nolistmessage" style="display:none;" runat="server">
	<span style="color:blue; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">查無報進資訊。</span>
</div>
<div id="nolist" style="" runat="server">  
<div><asp:Button ID="Button1" runat="server" Text="刪除" onclick="Button1_Click" CssClass="buttom_grey" OnClientClick="return confirm('確認刪除?');"/></div>
<div><span style="color:blue; width: 200px; font-size: 14px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">報進資訊：</span></div>
<div style="margin-bottom:10px">
    <table border="0" cellspacing="0" cellpadding="5" >
        <tr><td class="Order_Section_tr1_td1">鑑測站</td><td class="Order_Section_tr1_td2">
            <asp:Label ID="center" runat="server" Text="Label"></asp:Label></td></tr>
        <tr><td class="Order_Section_tr2_td1">鑑測日期</td><td class="Order_Section_tr2_td2">
            <asp:Label ID="date" runat="server" Text="Label"></asp:Label></td></tr>
    </table>
</div>  
<div><span style="color:blue; width: 200px; font-size: 14px; font-weight: bold; text-align: left; font-family: 微軟正黑體; ">報進名單：</span></div>
<div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" 
            DataSourceID="SqlDataSource1" DataKeyNames="sid" 
            ondatabound="GridView1_DataBound" >
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="selectall" runat="server" Text="" /> 
                    </HeaderTemplate> 
                    <ItemTemplate> 
                        <asp:CheckBox ID="ch1" runat="server" /> 
                    </ItemTemplate> 
                </asp:TemplateField>
                <asp:BoundField DataField="sid" HeaderText="編號" SortExpression="sid" 
                    InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
                <asp:BoundField DataField="id" HeaderText="身分證" SortExpression="id" />
                <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age" />
            </Columns>
            <EditRowStyle CssClass="EditRowStyle" />
            <HeaderStyle CssClass="HeaderStyle" />
            <PagerStyle CssClass="PagerStyle" />
            <RowStyle CssClass="RowStyle" />
            <SelectedRowStyle CssClass="SelectedRowStyle" />
        </asp:GridView>     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT [sid], [name], [id], [age] FROM [Result] WHERE (([date] = @date) AND ([id] = @op_id) AND ([center_code] = @center_code) AND ([status] = @status))">
        <SelectParameters>
            <asp:Parameter Name="date" Type="DateTime" />
            <asp:Parameter Name="op_id" Type="String" />
            <asp:Parameter Name="center_code" Type="String" />
            <asp:Parameter DefaultValue="000" Name="status" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</div> 
</div>           
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</div>
</asp:Content>

