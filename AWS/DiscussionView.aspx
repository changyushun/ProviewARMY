<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiscussionView.aspx.cs" Inherits="DiscussionView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <table style="border:solid 1px black;width:700px">
                    <tr>
                        <td>
                            <span style="color:Gray">內容</span><br />
                            <asp:Label ID="textLabel" runat="server" Text='<%# Eval("text") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="color:Blue">討論者</span>
                            <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
                        </td>
                    </tr>
                </table>
                <hr />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MainDB %>"
            SelectCommand="SELECT DiscussionDetail.text, Player.name FROM DiscussionDetail INNER JOIN Player ON DiscussionDetail.player = Player.id WHERE (DiscussionDetail.head_sid = @head_sid)">
            <SelectParameters>
                <asp:QueryStringParameter Name="head_sid" QueryStringField="sid" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>