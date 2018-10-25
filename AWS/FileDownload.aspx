<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FileDownload.aspx.cs" Inherits="FileDownload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="文件下載">
    <HeaderTemplate>
        文件下載
    </HeaderTemplate>
<ContentTemplate>
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" PageSize = "25"  
         AutoGenerateColumns="False" DataKeyNames="sid" 
         DataSourceID="SqlDataSource1" onrowdatabound="GridView1_RowDataBound" >
         <Columns>
         <asp:BoundField DataField="filename" HeaderText="標題" ReadOnly="True" SortExpression="filename" />
         <asp:HyperLinkField DataNavigateUrlFields="sid" HeaderText="檔案下載" Text="下載" datatextformatstring="{0:c}"
            datanavigateurlformatstring="~\DownloadController.aspx?AttachID={0}"           />
         <asp:BoundField DataField="uploaddate" HeaderText="更新日期" ReadOnly="True" SortExpression="uploaddate" />
         </Columns>
     </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
         ConnectionString="<%$ ConnectionStrings:MainDB %>" 
         SelectCommand="SELECT [sid], [filename], [filepath] , [uploaddate] FROM [FileManage] where [data] is not null Order by [uploaddate] desc">
     </asp:SqlDataSource>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

