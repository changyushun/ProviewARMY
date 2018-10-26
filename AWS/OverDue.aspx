<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="OverDue.aspx.cs" Inherits="OverDue" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <style type="text/css">
        .auto-style2 {
            height: 145px;
        }
    </style>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript" language="javascript">
        function confirm_user() {
            if (confirm("確認要刪除該筆資料?") == true)
                return true;
            else
                return false;
        }
        
</script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme" Width="1020px" ActiveTabIndex="0">
        <ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="逾期處理">
            <ContentTemplate>
                <table>
                <tr>
                <td align="left" class="auto-style2">
                <table>
                <tr>
                <td>依照鑑測站</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource1" DataTextField="center_name" 
                        DataValueField="center_code" Width="150px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MainDB %>" SelectCommand="select center_code, center_name
from center where IsService='1' 
union
select 0, '全部'
order by center_code"></asp:SqlDataSource>
                </td><td>
                    <asp:Button ID="btnfindCenter" runat="server" Text="尋找" 
                            onclick="btnfindCenter_Click" /></td>
                            <td>
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <asp:Button ID="Button1" runat="server" Text="全部刪除" onclick="Button1_Click" 
                                    style="height: 21px" /></td>
                </tr>
                <tr>
                <td>依照身分證號</td>
                <td>
                    <asp:TextBox ID="txtID" runat="server" Width="150px"></asp:TextBox></td><td>
                    <asp:Button ID="btnfindbyID" runat="server" Text="尋找" onclick="btnfindbyID_Click" /></td>
                    <td></td>
                </tr>
                </table>
                
                </td>
                </tr>
                <tr>
                
                    <td align="left">
                        <asp:GridView ID="GridView1" runat="server" BackColor="White" 
                            BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                            GridLines="Horizontal" onrowdatabound="GridView1_RowDataBound" 
                            AutoGenerateColumns="False" DataKeyNames="流水號">
                        
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <Columns>
                                <asp:BoundField DataField="流水號" HeaderText="流水號" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="流水號" />
                                <asp:BoundField DataField="鑑測日期" HeaderText="鑑測日期" ReadOnly="True" 
                                    SortExpression="鑑測日期" />
                                <asp:BoundField DataField="身分證號" HeaderText="身分證號" SortExpression="身分證號" />
                                <asp:BoundField DataField="姓名" HeaderText="姓名" ReadOnly="True" 
                                    SortExpression="姓名" />
                                <asp:BoundField DataField="性別" HeaderText="性別" ReadOnly="True" 
                                    SortExpression="性別" />
                                <asp:BoundField DataField="級職" HeaderText="級職" SortExpression="級職" />
                                <asp:BoundField DataField="鑑測站" HeaderText="鑑測站" SortExpression="鑑測站" />
                                <asp:BoundField DataField="狀態" HeaderText="狀態" SortExpression="狀態" />
                                <asp:TemplateField HeaderText="刪除">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" onclick="btnDelete_Click" Text="確認" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        
                        </asp:GridView>
                        
                    </td>
                
                </tr>
                </table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="未到測處理">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                <asp:Label ID="lab_InqId" runat="server" Text="請輸入身分證："></asp:Label><asp:TextBox ID="txb_Id" runat="server" MaxLength="10"></asp:TextBox>
                    <asp:Button ID="btn_SearchId" runat="server" CssClass="search" onclick="btn_SearchId_Click" />
                    </div>
                <asp:Label ID="lab_InqResult" runat="server" Text="" Font-Size="Medium" ForeColor="Red"></asp:Label>
                 <div id="playeridnone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:查無資料</span>
                </div>
                <div>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
                        Width="980px" PageSize="25" >
                        <Columns>                           
                            <asp:BoundField DataField="sid" HeaderText="序號" SortExpression="sid" >
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="mail">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="id" HeaderText="身份證字號" SortExpression="id">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="status" HeaderText="鑑測狀態" SortExpression="password">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="刪除">
                                    <ItemTemplate>
                                        <asp:Button ID="btn_DelReTest" runat="server" onclick="btn_DelReTest_Click" Text="刪除報名資料" ForeColor="Red" BackColor="LightPink" OnClientClick="return confirm_user();" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                        </Columns>
                        <EditRowStyle CssClass="EditRowStyle" />
                        <HeaderStyle CssClass="HeaderStyle" Wrap="False" />
                        <PagerStyle CssClass="PagerStyle" />
                        <RowStyle CssClass="RowStyle" />
                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
</asp:Content>

