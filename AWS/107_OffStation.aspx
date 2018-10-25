<%@ Page Language="C#" AutoEventWireup="true" CodeFile="107_OffStation.aspx.cs" Inherits="_107_OffStation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>臨時關站處理</title>
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        function checkOK() {
            try{
                var hf = document.getElementById("<%= HF_CheckDel.ClientID %>");
                var DRlist = document.getElementById("DropDownList1");
                var Inqdate = document.getElementById("txb_InqDate");
                var Reason = document.getElementById("txb_Reason");
                var count = document.getElementById("lab_count");
                hf.value = "no";
                if (Reason.value != "") {
                    if (DRlist.options[DRlist.selectedIndex].text != "" & count.innerText != "" & Inqdate.value != "") {
                        var msg = "< < < < <  注  意  > > > > >\n關閉鑑測站時將刪除當日受測人員資料，若個人資料有登記電子信箱者，系統將自動寄發取消報名信函至個人信箱。\n---------------------------------------------------------------------\n請核對關站資料是否正確：\n1.鑑測站名稱：" + DRlist.options[DRlist.selectedIndex].text + "\n2.關閉日期：" + Inqdate.value + "\n3.當日受測人數：" + count.innerText + "\n4.關站原因：" + Reason.value;
                        if (confirm(msg)) {
                            hf.value = "ok";
                            //先把站關起來
                            $.postJson('Operations/Schedule.ashx', {
                                mode: 'offstation',
                                center_code: DRlist.value,
                                op_id: 'admin',
                                //type: 1,
                                date: Inqdate.value,
                                note: '臨時關站',
                                log: null
                            }, function (data, s) {
                                if (s == 'success') {
                                    //alert('關站成功，確認後將執行人員名冊刪除及寄發通知信件!!');
                                    //$('#form1')[0].submit();
                                }
                            });

                        }
                        else {
                            hf.value = "no";
                            return false;
                        }
                    }
                    else {
                        alert("資料輸入不完整!!")
                        return false;
                    }

                }
                else {
                    alert("請先輸入關站原因!!")
                    return false;
                }
            }
            catch(ex){
                alert(ex);
            }
            

        }
    </script>
</head>
<body>
    <form id="form1" runat="server" submitdisabledcontrols="False">
    <div>
        <h1 style="color:blue">[臨時關站處理]</h1>
                        <table>
                            <tr>
                                <td>請選取鑑測站：</td>
                                <td>
                                <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="center_name" 
                        DataValueField="center_code" Width="150px"  >
                    </asp:DropDownList>
                            </td>
                            </tr>
                            <tr>
                                <td>請輸入關站日期：</td>
                                <td>
                                    <asp:TextBox ID="txb_InqDate" runat="server" ReadOnly="True" Enabled="False"></asp:TextBox>
                                    <asp:ImageButton ID="imgbtn_Calendar" runat="server" ImageUrl="~/images/Calendar.png" Width="30px" OnClick="imgbtn_Calendar_Click" BackColor="#99FF66" />
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Calendar ID="Calendar1" runat="server" Visible="False" OnSelectionChanged="Calendar1_SelectionChanged" OnDayRender="Calendar1_DayRender"></asp:Calendar>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    
                                </td>
                                <td>
                                    <asp:Button ID="btn_InqOffStation" runat="server" Text="查詢名單"  Font-Size="16px" OnClick="btn_InqOffStation_Click" BackColor="#CCFFFF" ForeColor="Blue" />
                                </td>
                            </tr>
                            <tr>
                                <td><asp:Label ID="lab_Reason" runat="server" Text="請輸入關站原因：" Visible="False"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="txb_Reason" runat="server" Width="560px" MaxLength="40" Visible="False"></asp:TextBox>
                                    
                                    <asp:Label ID="lab_Reason2" runat="server" Text="(內文限40字內)" ForeColor="Red" Visible="False"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:HiddenField ID="HF_CheckDel" runat="server" />
                                <asp:Button ID="btn_Delete" runat="server" Text="關閉鑑測站"  Font-Size="16px" BackColor="#FFCCFF" ForeColor="Red" OnClientClick="checkOK()"   Visible="False" /></td>
                            </tr>
                            <tr>
                                <td><asp:Label ID="lab_countTitle" runat="server" Text="資料筆數：" Visible="False" Font-Size="18px"></asp:Label></td>
                                <td><asp:Label ID="lab_count" runat="server" Text="" Visible="False" ForeColor="Blue" Font-Size="18px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:GridView ID="GridView2" runat="server" BackColor="White" 
                            BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                            GridLines="Both" 
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
                                <asp:BoundField DataField="e-mail" HeaderText="e-mail" SortExpression="e-mail" />
                                <%--<asp:TemplateField HeaderText="刪除">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" onclick="btnDelete_Click" Text="確認" />
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
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
                        
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MainDB %>" SelectCommand="select center_code, center_name
from center where IsService='1' order by center_code"></asp:SqlDataSource>
                    </div>
    </form>
</body>
</html>
