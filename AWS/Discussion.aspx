<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Discussion.aspx.cs" Inherits="Discussion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
<script type="text/javascript">
    $(function() {
        $('.Add').click(function() {
        window.open('AddDiscussion.aspx', '', 'scrollbars=yes,width=700,height=550,location=no', '');
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel" HeaderText="討論區列表">
<ContentTemplate>
<div>
<input type="button" id="Add" class="Add" value="新增討論" /><br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
    OnRowDataBound="GridView1_RowDataBound" 
        DataKeyNames="sid" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="sid" HeaderText="序號" InsertVisible="False" 
                ReadOnly="True" SortExpression="sid" />
            <asp:BoundField DataField="head" HeaderText="討論主題" SortExpression="head" />
            <asp:BoundField DataField="date" HeaderText="建立日期" SortExpression="date" DataFormatString="{0:yyyy/MM/dd}" />
            <asp:HyperLinkField DataNavigateUrlFields="sid" 
                DataNavigateUrlFormatString="DiscussionDetail.aspx?sid={0}" HeaderText="***" 
                Text="細節" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT [sid], [head], [date] FROM [Discussion] WHERE ([status] = @status) order by date desc"> 
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="status" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
 
 <div>
 
 </div>
</div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer> 

</asp:Content>

