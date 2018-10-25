<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Suggestion.aspx.cs" Inherits="Suggestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
<script type="text/javascript" src="Script/RankCode.ashx"></script>
<script type="text/javascript">
    $(function() {
        $('.Add').click(function() {
            var accountTo = $('select option:selected').val();
            window.open('AddSuggestion.aspx?account=' + accountTo, '', 'toolbar=no,menubar=no,width=600,height=600,resizable=yes');
        });
    });
    
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="意件區列表">
<ContentTemplate>
<div>
    <asp:Label ID="Label1" runat="server" Text="選擇意見對象："></asp:Label>
    <asp:DropDownList ID="DropDownList1" runat="server" 
        DataSourceID="SqlDataSource2" DataTextField="unit_name" 
        DataValueField="unit_code">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT [unit_name], [unit_code] FROM [Unit_Complaint]">
    </asp:SqlDataSource>
<input type="button" id="Add" value="新增意見" class="Add" />
</div>
<div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" DataKeyNames="sid" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="sid" ControlStyle-ForeColor="Blue"
                DataNavigateUrlFormatString="SuggestionView.aspx?head={0}" DataTextField="head" 
                DataTextFormatString="{0:c}" HeaderText="意見標題" />
            <asp:BoundField DataField="unit_name" HeaderText="意見對象" SortExpression="name" />    
            <asp:BoundField DataField="player" HeaderText="建立者" SortExpression="player" />   
            <asp:BoundField DataField="date" HeaderText="建立日期" 
                SortExpression="date" />
            <asp:BoundField DataField="date_answer" HeaderText="回覆日期" 
                SortExpression="date_answer" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT s.sid,s.head,s.player,s.date,s.date_answer,(select unit_name from Unit_Complaint u where u.unit_code = s.acc) as unit_name FROM Suggestion s WHERE s.player = @player">
        <%--SelectCommand="SELECT [sid], [head], [player], [date], [date_answer],(select unit_name from Unit_Com) FROM [Suggestion] WHERE ([player] = @player)">--%>
        <SelectParameters>
            <asp:Parameter Name="player" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>


</asp:Content>

