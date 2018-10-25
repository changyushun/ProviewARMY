<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="sid" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="sid" HeaderText="sid" InsertVisible="False" 
                    ReadOnly="True" SortExpression="sid" />
                <asp:BoundField DataField="account" HeaderText="account" 
                    SortExpression="account" />
                <asp:BoundField DataField="password" HeaderText="password" 
                    SortExpression="password" />
                <asp:BoundField DataField="role_code" HeaderText="role_code" 
                    SortExpression="role_code" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" />
                <asp:BoundField DataField="unit_code" HeaderText="unit_code" 
                    SortExpression="unit_code" />
                <asp:BoundField DataField="rank_code" HeaderText="rank_code" 
                    SortExpression="rank_code" />
                <asp:BoundField DataField="tel" HeaderText="tel" SortExpression="tel" />
                <asp:BoundField DataField="cellphone" HeaderText="cellphone" 
                    SortExpression="cellphone" />
                <asp:BoundField DataField="mail" HeaderText="mail" SortExpression="mail" />
                <asp:BoundField DataField="ip" HeaderText="ip" SortExpression="ip" />
                <asp:BoundField DataField="pwdChange" HeaderText="pwdChange" 
                    SortExpression="pwdChange" />
                <asp:BoundField DataField="status" HeaderText="status" 
                    SortExpression="status" />
                <asp:BoundField DataField="byAcc" HeaderText="byAcc" SortExpression="byAcc" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:MainDB %>" 
            SelectCommand="SELECT Account.* FROM Account where Account = @acc">
            <SelectParameters>
                <asp:Parameter DefaultValue="admin" Name="acc" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
