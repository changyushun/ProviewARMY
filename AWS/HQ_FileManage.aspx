<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HQ_FileManage.aspx.cs" Inherits="HQ_FileManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <link id="Login_css" rel="stylesheet" href="main.css" type="text/css" />

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript">
        $(function() {
            $('#Button1').click(function() {
                if ($('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_filename').val() != '') {
                    encodeURI
                    window.open('HQ_FileUpload.aspx?myname=' + setEncodeURI($('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_filename').val()), '', 'left=100,top=0,scrollbars=no,width=300,height=255,location=no');
                }
                else {
                    alert('請輸入檔案名稱');
                }
            });

            function setEncodeURI(reqs) {
                return encodeURI(reqs);
            }
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1">
    </asp:ScriptManager>
    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="文件維護">
            <HeaderTemplate>
                文件維護
            </HeaderTemplate>
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; font-family: 微軟正黑體; font-size: 16px;
                    font-weight: bold; color: Red;">
                    <span>新增檔案：</span></div>
                <div style="margin-top: 5px; margin-bottom: 5px; font-family: 微軟正黑體; font-size: 12px;
                    font-weight: bold; color: Black;">
                    <span>可上傳檔案格式： pdf , doc , docx </span>
                </div>
                <div>
                    <table border="0" cellspacing="0" cellpadding="5">
                        <tr>
                            <td class="Order_Section_tr1_td1">
                                檔案名稱：
                            </td>
                            <td class="Order_Section_tr1_td2">
                                <asp:TextBox ID="filename" runat="server" MaxLength="25" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Order_Section_tr2_td1">
                                上傳檔案：
                            </td>
                            <td class="Order_Section_tr2_td2">
                                <input id="Button1" type="button" value="上傳檔案" />
                            </td>
                        </tr>
                    </table>
                </div>
                <%--<div><asp:label id="label3" text="選擇檔案 :" runat="server"/><asp:FileUpload ID="FileUpload2" runat="server" />
    <asp:Button ID="upload" runat="server" Text="新增上傳" ShowEditButton="true" 
        onclick="upload_Click" /></div>--%>
                <div style="margin-top: 5px; margin-bottom: 5px; font-family: 微軟正黑體; font-size: 16px;
                    font-weight: bold; color: Green;">
                    <span>檔案列表：</span></div>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" lternatingRowStyle-CssClass="AltRowStyle"
                                    CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle" HeaderStyle-CssClass="HeaderStyle"
                                    PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
                                    Width="861px" PageSize="25" AutoGenerateColumns="False" DataKeyNames="sid" DataSourceID="SqlDataSource1"
                                    OnRowDataBound="GridView1_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                刪除
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="Button1" runat="server" CommandName="Delete" OnClientClick="return confirm('您確定要刪除此文件嗎?');"
                                                    Text="刪除" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="sid" HeaderText="編號" ReadOnly="True" SortExpression="sid" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label ID="label1" Text="標題" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="name" Text='<%#Eval("filename")%>' runat="server" MaxLength="25" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:HyperLinkField DataNavigateUrlFields="sid" HeaderText="檔案連結" DataTextField="filename"
                                            DataTextFormatString="{0:c}" DataNavigateUrlFormatString="~\DownloadController.aspx?AttachID={0}" />
                                        <asp:BoundField DataField="uploaddate" HeaderText="上傳日期" ReadOnly="True" SortExpression="uploaddate" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label ID="label2" Text="變更標題名稱" runat="server" />
                                            </HeaderTemplate>
                                            <EditItemTemplate>
                                                <asp:Button ID="update" runat="server" Text="確認更新" ShowEditButton="true" OnClick="update_Click" />
                                                <asp:Button ID="Cancel" runat="server" CommandName="Cancel" Text="取消" />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit" OnClick="LinkButton1_Click">Edit</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MainDB %>"
                                    SelectCommand="SELECT [sid], [filename], [filepath] , [uploaddate] FROM [FileManage] where [data] is not null Order By [sid]"
                                    DeleteCommand="DELETE FileManage where sid = @sid"></asp:SqlDataSource>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
</asp:Content>
