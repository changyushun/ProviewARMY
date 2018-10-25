<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SPtest.aspx.cs" Inherits="SPtest" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function() {
//        $.postJson('GetValueByCode.ashx',{mode:"rank",value:"all"},function(data,s){
//        if (s == 'success')
//        {
//        alert([data[0]);
//        }
 });
 
        
//            $(':text').keydown(function(e) {
//                if (e.keyCode == 13) {
//                    $.postJson('GetValueByCode.ashx', { mode: "rank", value: $(':text').val() }, function(data, s) {
//                        if (s == "success") {
//                            if (data[0] != null) {
//                                $(':text').next().html(data[0]["rank_title"]);
//                            }
//                            else {
//                                $(':text').next().html('');
//                            }
//                        }
//                    });
//                }
            //});



        });
    </script>
</head>
<body>
    
    <div>
    <span>rank code</span><input type="text" /><span></span>
        
    </div>
    <form id="form1" runat="server">
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:BoundField DataField="apply" HeaderText="apply" SortExpression="apply" />
            <asp:BoundField DataField="ip_new" HeaderText="ip_new" 
                SortExpression="ip_new" />
            <asp:BoundField DataField="ip_old" HeaderText="ip_old" 
                SortExpression="ip_old" />
            <asp:BoundField DataField="date" HeaderText="date" 
                SortExpression="date" />
            <asp:BoundField DataField="status" HeaderText="status" 
                SortExpression="status" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        
        SelectCommand="SELECT i.apply, i.ip_new, a.ip AS ip_old, i.date, i.status  FROM IP_Renew AS i INNER JOIN Account AS a ON i.apply = a.account WHERE (i.confirmer = @confirmer)">
        <SelectParameters>
            <asp:Parameter Name="confirmer" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
