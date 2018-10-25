<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HQ_LogView.aspx.cs" Inherits="HQ_LogView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js">
    </script>

    <script type="text/javascript" src="Script/RankCode.ashx"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<ajaxToolkit:TabContainer ID="TabContainer" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="事件檢視錄">
<ContentTemplate>
<div>
<table>
<tr>
<td>事件種類</td>
<td><asp:DropDownList ID="DropDownList1" runat="server" 
        DataSourceID="SqlDataSourceTType" DataTextField="type" DataValueField="type">
    </asp:DropDownList></td>
    <td>關鍵字</td>
    <td>
        <asp:TextBox ID="TB_KeyWord" runat="server"></asp:TextBox></td>
        <td>起始日期</td>
        <td>
            <asp:TextBox ID="TB_TimeStart" runat="server" Width="50px"></asp:TextBox>
        </td>
        <td>結束日期</td>
        
        <td><asp:TextBox ID="TB_TimeEnd" runat="server" Width="50px"></asp:TextBox>
            </td>
    <td>
        <asp:Button ID="Button1" runat="server" CssClass="search" onclick="Button1_Click" /></td>
        <td>日期請輸入民國年格式 , 例如: 100/1/1</td>
</tr>
</table>
    
    <asp:SqlDataSource ID="SqlDataSourceTType" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT DISTINCT type FROM SysLog where type is not null">
    </asp:SqlDataSource>
</div>
<div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
            Width="861px" PageSize = "25" 
        onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="acc" HeaderText="帳號" SortExpression="acc" >
            </asp:BoundField>
            <asp:BoundField DataField="event" HeaderText="事件" SortExpression="event" >
            </asp:BoundField>
            <asp:BoundField DataField="eventTime" HeaderText="發生時間" 
                SortExpression="eventTime" >
            </asp:BoundField>
        </Columns>
        <EditRowStyle CssClass="EditRowStyle" />
        <HeaderStyle CssClass="HeaderStyle" />
        <PagerStyle CssClass="PagerStyle" />
        <RowStyle CssClass="RowStyle" />
        <SelectedRowStyle CssClass="SelectedRowStyle" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceLog" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        
        SelectCommand="Ex104_QuerySysLog" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="type" 
                PropertyName="SelectedValue" Type="String" />
            <asp:Parameter Name="KeyWord" Type="String" />    
            <asp:Parameter Name="TimeStart" Type="DateTime" />
            <asp:Parameter Name="TimeEnd" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>

</asp:Content>
