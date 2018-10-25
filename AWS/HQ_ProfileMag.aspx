<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_ProfileMag.aspx.cs" Inherits="HQ_ProfileMag" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="檔案上傳更新">
<ContentTemplate>
 <table>
 <tbody>
 <tr>
 <td colspan="3">
     <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/wholeUnit.csv">下載範例</asp:HyperLink>
 </td>
 </tr>
 <tr>
 <td colspan="3">請選擇檔案<asp:FileUpload ID="FileUpload1" runat="server" /><asp:Button ID="Button1" runat="server" Text="上傳" onclick="Button1_Click" /></td>
 </tr>
 <tr>
 <td colspan="3">
     <asp:GridView ID="GridView1" runat="server" AllowPaging="True" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" PageSize = "25" 
         AutoGenerateColumns="False" DataKeyNames="unit_code" 
         DataSourceID="SqlDataSource1">
         <Columns>
             <asp:BoundField DataField="unit_code" HeaderText="單位代碼" ReadOnly="True" 
                 SortExpression="unit_code" />
             <asp:BoundField DataField="unit_title" HeaderText="單位名稱" 
                 SortExpression="unit_title" />
             <asp:BoundField DataField="parent_unit_code" HeaderText="父層單位" 
                 SortExpression="parent_unit_code" />
         </Columns>
     </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
         ConnectionString="<%$ ConnectionStrings:MainDB %>" 
         SelectCommand="SELECT [unit_code], [unit_title], [parent_unit_code] FROM [Unit]">
     </asp:SqlDataSource>
 </td>
 </tr>
 </tbody>
 </table>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

