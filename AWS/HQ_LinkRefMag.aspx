<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_LinkRefMag.aspx.cs" Inherits="HQ_LinkRefMag" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="相關連結維護">
    <HeaderTemplate>
        相關連結維護
    </HeaderTemplate>
<ContentTemplate>
 <table>
 <tbody>
 <tr>
 <td colspan="3">
 注意: 系統只接受(寬160px) * (高40px)的圖檔
 </td>
 </tr>
 <tr>
 <td colspan="3">
     <asp:GridView ID="GridView1" runat="server" AllowPaging="True" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" PageSize = "25" 
         AutoGenerateColumns="False" DataKeyNames="sid" 
         DataSourceID="SqlDataSource1" >
         <Columns>
             <asp:BoundField DataField="sid" HeaderText="編號" ReadOnly="True" 
                 SortExpression="sid" />
             <asp:TemplateField>
                <headertemplate>
                <asp:label id="label1" text="連結" runat="server"/>
                </headertemplate>
                <ItemTemplate>
                <asp:textbox id="url"
                text='<%#Eval("url")%>'
                runat="server" MaxLength="50"/>
                </ItemTemplate>
              </asp:TemplateField>    
             <asp:ImageField DataImageUrlField="path" HeaderText="圖片" ReadOnly="True">
             </asp:ImageField>
             <asp:TemplateField>
                <headertemplate>
                <asp:label id="label2" text="上傳圖片與確認更新" runat="server"/>
                </headertemplate>
                <EditItemTemplate>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Button ID="update" runat="server" Text="確認更新" ShowEditButton="true" 
                  onclick="update_Click" />
                  <asp:Button ID="Cancel" runat="server" CommandName="Cancel" Text="取消" />
                </EditItemTemplate>
                <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit" 
                  onclick="LinkButton1_Click">Edit</asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>

         </Columns>
     </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
         ConnectionString="<%$ ConnectionStrings:MainDB %>" 
         SelectCommand="SELECT [sid], [url], [path] FROM [RelatedLink]">
     </asp:SqlDataSource>
 </td>
 </tr>
 </tbody>
 </table>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

