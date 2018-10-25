<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TeamScore.aspx.cs" Inherits="TeamScore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
<div>
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">

<ajaxToolkit:TabPanel ID="TabPane2" runat="server" HeaderText="團體報進成績查詢">
<ContentTemplate>
    <div><asp:Label ID="Label1" runat="server" Text="請選擇鑑測日期"></asp:Label>
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" 
        DataSourceID="SqlDataSource1" DataTextField="date" DataValueField="date" 
        ondatabound="DropDownList1_DataBound" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
    </asp:DropDownList>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>"
        SelectCommand="SELECT DISTINCT CONVERT(VARCHAR(10), [date], 111) AS [date] FROM [Result] WHERE ([op_id] = @op_id and status in ('000','999','202','203','204','205','206')) ORDER BY [date] DESC">
            <SelectParameters>
                <asp:Parameter Name="op_id" Type="String" />
            </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" AllowSorting="true"  lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="1000px" PageSize = "25" AllowPaging="true" >
        <Columns>
            <asp:BoundField DataField="date" HeaderText="鑑測日期" ReadOnly="True" ItemStyle-Wrap="false"
                SortExpression="date" />
            <asp:BoundField DataField="id" HeaderText="身份證" SortExpression="id" ItemStyle-Wrap="false"/>
            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" ItemStyle-Wrap="false"/>  
            <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age" ItemStyle-Wrap="false"/>
            <asp:BoundField DataField="gender" HeaderText="性別" ReadOnly="True" ItemStyle-Wrap="false"
                SortExpression="gender" />
            <asp:BoundField DataField="sit_ups" HeaderText="仰臥起坐" ReadOnly="True" ItemStyle-Wrap="false"
                SortExpression="sit_ups" />
            <asp:BoundField DataField="sit_ups_score" HeaderText="仰臥起坐成績" HeaderStyle-Wrap="false"  
                ReadOnly="True" SortExpression="sit_ups_score" />
            <asp:BoundField DataField="push_ups" HeaderText="俯地挺身" ReadOnly="True" ItemStyle-Wrap="false"
                SortExpression="push_ups" />
            <asp:BoundField DataField="push_ups_score" HeaderText="俯地挺身成績" ItemStyle-Wrap="false"
                ReadOnly="True" SortExpression="push_ups_score" />
            <asp:BoundField DataField="run" HeaderText="三千公尺" ReadOnly="True" ItemStyle-Wrap="false"
                SortExpression="run" />
            <asp:BoundField DataField="run_score" HeaderText="三千公尺成績" ReadOnly="True" ItemStyle-Wrap="false"
                SortExpression="run_score" />
            <asp:BoundField DataField="center_name" HeaderText="鑑測地點" 
                ReadOnly="True" SortExpression="center_name" ItemStyle-Wrap="false" />
            <asp:BoundField DataField="status" HeaderText="鑑測結果" ReadOnly="True" ItemStyle-Wrap="false"
                SortExpression="status" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>"
        SelectCommand="QueryResultByTeam" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="type" Type="String" />
                <asp:Parameter Name="operator" Type="String" />
                <asp:Parameter Name="value" Type="String" />
            </SelectParameters>
    </asp:SqlDataSource>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</div>
</asp:Content>

