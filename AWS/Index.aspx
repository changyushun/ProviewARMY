<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
<script type="text/javascript">
    $(function() {
        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_GridView1 span').each(function() {
            $(this).attr({ style: "cursor:hand" });
            $(this).click(function() {
                var sid = $(this).next().val();
                window.open('BulletinView.aspx?sid=' + sid, "", "menubar=no,resizable=yes,");
            });
        });

        $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_GridView2 span').each(function() {
            $(this).attr({ style: "cursor:hand" });
            $(this).click(function() {
                var sid = $(this).next().val();
                window.open('DiscussionDetail.aspx?type=view&sid=' + sid, "", "menubar=no,resizable=yes,scrollbars=yes");
            });
        });

    });

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="scriptMager1" runat="server" />
    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
    <ajaxToolkit:TabPanel ID="TabPanel" runat="server" HeaderText="最新消息">
    <ContentTemplate>
     <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
     onrowdatabound="GridView1_RowDataBound"
            AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
            onpageindexchanged="GridView1_PageIndexChanged">
            <Columns>
                <asp:BoundField DataField="head" HeaderText="主旨" SortExpression="head">
                <HeaderStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="start" HeaderText="公告有效日期" SortExpression="start" DataFormatString="{0:yyyy/MM/dd}">
                <HeaderStyle Width="100px" Wrap="True" />
                </asp:BoundField>
                <asp:BoundField DataField="deadline" HeaderText="公告結束日期" SortExpression="deadline" DataFormatString="{0:yyyy/MM/dd}">
                <HeaderStyle Width="100px" Wrap="True" />
                </asp:BoundField>
                <asp:BoundField DataField="unit_title" HeaderText="公告單位" 
                    SortExpression="unit_title">
                <HeaderStyle Width="200px" />
                </asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text="查看"></asp:Label>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("sid") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
          SelectCommand="select b.head, b.start,b.sid,b.deadline,b.unit_name as unit_title from Account a ,Bulletin b where b.acc = a.account and b.deadline > @date order by b.insertDate DESC ">
          <%--2016-5-4改版--%>
          
          <%--舊版--%>
            <%--SelectCommand="select b.head, b.start,b.sid,b.deadline,(select unit_title from unit u where u.unit_code = a.unit_code) as unit_title from Account a ,Bulletin b where b.acc = a.account and b.deadline > @date order by b.insertDate DESC ">--%>

            <%--SelectCommand="SELECT b.head, b.start, u.unit_title, b.sid FROM Bulletin AS b INNER JOIN Account AS a ON b.acc = a.account INNER JOIN Unit AS u ON a.unit_code = u.unit_code WHERE b.deadline > GETDATE() ORDER BY b.deadline DESC">--%>
            <SelectParameters>
                <asp:Parameter Name="date" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </ContentTemplate>
    </ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel  ID="TabPanel2" runat="server" HeaderText="討論區文章">
    <ContentTemplate>
   <%-- <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="sid" DataSourceID="SqlDataSource2" 
            onrowdatabound="GridView2_RowDataBound"
            onpageindexchanged="GridView2_PageIndexChanged">
            <Columns>
                
                <asp:BoundField DataField="head" HeaderText="討論主題" SortExpression="head" >
                <HeaderStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="date" HeaderText="日期" SortExpression="date"
                DataFormatString="{0:yyyy/MM/dd}"/>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text="查看"></asp:Label>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("sid") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
            SelectCommand="SELECT [sid], [head], [date] FROM [Discussion] WHERE ([status] = @status) order by [date] desc">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="status" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>--%>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
    DataKeyNames="sid" DataSourceID="SqlDataSource2" 
            onrowdatabound="GridView2_RowDataBound"
            onpageindexchanged="GridView2_PageIndexChanged">
        <Columns>
            <asp:BoundField DataField="sid" HeaderText="序號" InsertVisible="False" 
                ReadOnly="True" SortExpression="sid" />
            <asp:BoundField DataField="head" HeaderText="討論主題" SortExpression="head" />
            <asp:BoundField DataField="date" HeaderText="建立日期" SortExpression="date" DataFormatString="{0:yyyy/MM/dd}" />
            <asp:HyperLinkField DataNavigateUrlFields="sid" 
                DataNavigateUrlFormatString="DiscussionDetail.aspx?sid={0}" HeaderText="***" 
                Text="細節" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="SELECT [sid], [head], [date] FROM [Discussion] WHERE ([status] = @status)">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="status" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </ContentTemplate>
    </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
</asp:Content>

