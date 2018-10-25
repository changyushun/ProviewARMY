<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HQ_Bulletin.aspx.cs" Inherits="HQ_Bulletin" ValidateRequest="false" %>

<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript">
        $(function() {
            $('#add').click(function() {
                window.open('Bulletin.aspx', '', 'toolbar=no,width=630,height=680,resizable=yes');
            });
        });
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div >
        <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
            <ajaxToolkit:TabPanel ID="TabPanel" runat="server" HeaderText="最新消息維護">
                <ContentTemplate>
                    <div style="height: 534px">
                        <table>
                            <tbody>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <input id="add" type="button" value="新增最新消息" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                            lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
            Width="861px" PageSize = "25" 
                            AutoGenerateColumns="False" DataKeyNames="sid" DataSourceID="SqlDataSource1" 
                            onrowdatabound="GridView1_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="sid" HeaderText="sid" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="sid" Visible="False" />
                                <asp:HyperLinkField DataTextField="head" HeaderText="最新消息" 
                                    DataNavigateUrlFormatString="BulletinView.aspx?sid={0}" 
                                    DataNavigateUrlFields="sid" >
                                    <HeaderStyle Width="270px" />
                                </asp:HyperLinkField>
                                <asp:BoundField DataField="insertDate" HeaderText="建立日期" 
                                    SortExpression="insertDate" Visible="False"
                                    HtmlEncode="False" DataFormatString="{0:yyyy/MM/dd}"
                                    />
                                <asp:BoundField DataField="start" HeaderText="發佈日期" SortExpression="start" 
                                    HtmlEncode="False" DataFormatString="{0:yyyy/MM/dd}" />
                                <asp:BoundField DataField="deadline" HeaderText="結束日期" 
                                    SortExpression="deadline" HtmlEncode="False" 
                                    DataFormatString="{0:yyyy/MM/dd}" />
                    
                                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
                                    
                            </Columns>
                            <EditRowStyle CssClass="EditRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <PagerStyle CssClass="PagerStyle" />
                            <RowStyle CssClass="RowStyle" />
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
                            DeleteCommand="DELETE from Bulletin where sid = @sid"
                            SelectCommand="SELECT [sid], [head], [insertDate], [start], [deadline], [status] FROM [Bulletin] WHERE ([acc] = @acc)">
                            <SelectParameters>
                                <asp:Parameter Name="acc" Type="String" />
                            </SelectParameters>
                            <DeleteParameters>
                                 <asp:Parameter Name="sid" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </div>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        </ajaxToolkit:TabContainer>
        
    </div>

</asp:Content>
