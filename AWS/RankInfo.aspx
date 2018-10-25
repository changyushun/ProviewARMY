<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RankInfo.aspx.cs" Inherits="RankInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link id="Login_css" rel="stylesheet" href="MasterPage.css" type="text/css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
             PageSize = "25" 
            DataKeyNames="rank_code" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="rank_code" HeaderText="級職代碼" ReadOnly="True" HeaderStyle-Wrap="false"
                    SortExpression="rank_code">
                <HeaderStyle />
                <ItemStyle  HorizontalAlign="Center" 
                    VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="rank_title" HeaderText="級職名稱" HeaderStyle-Wrap="false"
                    SortExpression="rank_title">
                <HeaderStyle />
                <ItemStyle  HorizontalAlign="Center" 
                    VerticalAlign="Middle" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
            SelectCommand="SELECT [rank_code], [rank_title] FROM [Rank]">
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
