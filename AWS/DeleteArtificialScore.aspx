<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DeleteArtificialScore.aspx.cs" Inherits="DeleteArtificialScore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <script type="text/javascript">
        function cancelalert() {
            var confirmed = confirm("By clicking OK you are submitting the form.");

            if (confirmed) {
                return true; // will sumbit the form. Do a redirect on the server side
            }
            else {
                return false
            }

        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme" ActiveTabIndex="0">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="刪除人工鑑測成績">
    <HeaderTemplate>
        刪除人工鑑測成績       
    </HeaderTemplate>
<ContentTemplate>
    
<div>
    <asp:Label ID="Label1" runat="server" Text="請輸入身份證字號："></asp:Label> <asp:TextBox ID="TextBox1" runat="server" MaxLength="10" Width="90px"></asp:TextBox> 
    <asp:Label ID="Label2" runat="server" Text="選取或輸入日期(格式2015/01/31)："></asp:Label><asp:TextBox ID="TextBox2" runat="server" Width="90px"></asp:TextBox>
    <ajaxToolkit:CalendarExtender ID="TextBox2_CalendarExtender" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="TextBox2">
    </ajaxToolkit:CalendarExtender>
    <asp:Button ID="Button1" runat="server" Text="查詢" OnClick="Button1_Click" />
    <asp:Button ID="Button2" runat="server" Text="刪除勾選資料" OnClick="Button2_Click" />
    <asp:GridView ID="GridView2" runat="server" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" PageSize="500">
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="CheckBox1" onclick="SelectAllCheckboxes(this);" runat="server"  Text="全選" ToolTip="按一次全選，再按一次取消" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox2" runat="server" ToolTip="單項選取" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MainDB %>" SelectCommand="SELECT [sid], [id], [name], [age], [birth], [gender], [unit_code], [rank_code], [sit_ups], [sit_ups_score], [push_ups], [push_ups_score], [run], [run_score], [center_code], [date], [status] FROM [Result] WHERE ([result] = @result)" OnSelecting="SqlDataSource1_Selecting">
        <SelectParameters>
            <asp:Parameter DefaultValue="222" Name="result" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
</ContentTemplate>
    
</ajaxToolkit:TabPanel>
   
</ajaxToolkit:TabContainer>
    <%-- 加入下面這段script才能使用全選功能 --%>
    <script type="text/javascript">
        function SelectAllCheckboxes(spanChk) {
            elm = document.forms[0];
            for (i = 0; i <= elm.length - 1; i++) {
                if (elm[i].type == "checkbox" && elm[i].id != spanChk.id) {
                    if (elm.elements[i].checked != spanChk.checked)
                        elm.elements[i].click();
                }
            }
        }
</script> 
</asp:Content>


