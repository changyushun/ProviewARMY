<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_SchMag_107.aspx.cs" Inherits="HQ_SchMag" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        $(function () {
            $(':button[value="Edit"]').each(function () {
                $(this).click(function () {
                    var id = $(this).parent().parent().find('td:eq(0)').html();
                    window.open('CenterSch.aspx?center=' + id, '', 'toolbar=no,scrollbars=yes,resizable=yes,location=no,width=700,height=950,top=100,left=200');
                });
                //alert($(this).parent().parent().find('td:eq(0)').html());
            });
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $(':asp:button[value="更新"]').each(function () {
                $(this).click(function () {
                    var msg;
                    var dt = new Date();
                    var nextyear = dt.getFullYear() + 1-1911;
                    msg = '確認更新明年(民國' + nextyear.toString() + '年)工作日如下：\n';
                    //var ch1 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_0');
                    //var ch2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_1');
                    //var ch3 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_2');
                    //var ch4 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_3');
                    //var ch5 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_4');
                    //var ch6 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_5');
                    //var ch7 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_6');
                    var ch1 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Monday');
                    var ch2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Tuesday');
                    var ch3 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Wednesday');
                    var ch4 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Thursday');
                    var ch5 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Friday');
                    var ch6 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Saturday');
                    var ch7 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Sunday');
                    if (ch1.checked)
                        msg += '星期一：開啟\n';
                    else
                        msg += '星期一：關閉\n';
                    if (ch2.checked)
                        msg += '星期二：開啟\n';
                    else
                        msg += '星期二：關閉\n';
                    if (ch3.checked)
                        msg += '星期三：開啟\n';
                    else
                        msg += '星期三：關閉\n';
                    if (ch4.checked)
                        msg += '星期四：開啟\n';
                    else
                        msg += '星期四：關閉\n';
                    if (ch5.checked)
                        msg += '星期五：開啟\n';
                    else
                        msg += '星期五：關閉\n';
                    if (ch6.checked)
                        msg += '星期六：開啟\n';
                    else
                        msg += '星期六：關閉\n';
                    if (ch7.checked)
                        msg += '星期日：開啟\n';
                    else
                        msg += '星期日：關閉\n';
                    if (confirm('< < < < <  注  意  > > > > >\n若更新明年工作日後，系統將自動重置明年各鑑測中心之行事曆。\n請於更新後，重新設定各鑑測中心之行事曆!!')) {
                        if (confirm(msg)) {

                        }
                        else {
                            return false;
                        }
                    }
                    else {
                        return false;
                    }
                    
                });
                //alert($(this).parent().parent().find('td:eq(0)').html());
            });
        });
        $(function () {
            $(':asp:button[value="設定"]').each(function () {
                $(this).click(function () {
                    var msg;
                    var dt = new Date();
                    var nextyear = dt.getFullYear() + 1-1911;
                    msg = '確認設定明年(民國' + nextyear.toString() + '年)工作日如下：\n';
                    //var ch1 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_0');
                    //var ch2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_1');
                    //var ch3 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_2');
                    //var ch4 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_3');
                    //var ch5 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_4');
                    //var ch6 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_5');
                    //var ch7 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cbl_WeekCheck_6');
                    var ch1 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Monday');
                    var ch2 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Tuesday');
                    var ch3 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Wednesday');
                    var ch4 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Thursday');
                    var ch5 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Friday');
                    var ch6 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Saturday');
                    var ch7 = document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel_cb_Sunday');
                    if (ch1.checked)
                        msg += '星期一：開啟\n';
                    else
                        msg += '星期一：關閉\n';
                    if (ch2.checked)
                        msg += '星期二：開啟\n';
                    else
                        msg += '星期二：關閉\n';
                    if (ch3.checked)
                        msg += '星期三：開啟\n';
                    else
                        msg += '星期三：關閉\n';
                    if (ch4.checked)
                        msg += '星期四：開啟\n';
                    else
                        msg += '星期四：關閉\n';
                    if (ch5.checked)
                        msg += '星期五：開啟\n';
                    else
                        msg += '星期五：關閉\n';
                    if (ch6.checked)
                        msg += '星期六：開啟\n';
                    else
                        msg += '星期六：關閉\n';
                    if (ch7.checked)
                        msg += '星期日：開啟\n';
                    else
                        msg += '星期日：關閉\n';
                    if (confirm(msg)) {

                    }
                    else {
                        return false;
                    }

                });
                //alert($(this).parent().parent().find('td:eq(0)').html());
            });
        });
        function checkOK() {
            var hf = document.getElementById("<%= HF_CheckDel.ClientID %>");
            var DRlist = document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_DropDownList1");
            var Inqdate = document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_txb_InqDate");
            var Reason = document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_txb_Reason");
            var count = document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_lab_count");
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div id="content" style="margin-left: 0px">
        <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
            <ajaxToolkit:TabPanel ID="TabPanel" runat="server" HeaderText="明年度工作日設定">
                <ContentTemplate>
                    <div>
                        <asp:Label ID="Label2" runat="server" Text="設定明年度工作日" Font-Size="X-Large"></asp:Label>
                        <asp:Label ID="lab_LastYear" runat="server" Font-Size="X-Large" ForeColor="#009933" Font-Bold="True"></asp:Label>
                        <br />
                        <asp:Label ID="Label3" runat="server" Text="設定狀態：" Font-Size="X-Large"></asp:Label>
                        <asp:Label ID="lab_SetStatus" runat="server" Font-Size="X-Large" ForeColor="Red" Font-Bold="True"></asp:Label>
                        <br />
                        <asp:CheckBox ID="cb_Monday" runat="server" Text="星期一：" />
                        <br />
                        <asp:CheckBox ID="cb_Tuesday" runat="server" Text="星期二：" />
                        <br />
                        <asp:CheckBox ID="cb_Wednesday" runat="server" Text="星期三：" />
                        <br />
                        <asp:CheckBox ID="cb_Thursday" runat="server" Text="星期四：" />
                        <br />
                        <asp:CheckBox ID="cb_Friday" runat="server" Text="星期五：" />
                        <br />
                        <asp:CheckBox ID="cb_Saturday" runat="server" Text="星期六：" />
                        <br />
                        <asp:CheckBox ID="cb_Sunday" runat="server" Text="星期日：" />
                        <%--<asp:CheckBoxList ID="cbl_WeekCheck" runat="server" RepeatLayout="OrderedList" Font-Size="X-Large" OnSelectedIndexChanged="cbl_WeekCheck_SelectedIndexChanged">
                            <asp:ListItem Value="Monday">星期一</asp:ListItem>
                            <asp:ListItem Value="Tuesday">星期二</asp:ListItem>
                            <asp:ListItem Value="Wednesday">星期三</asp:ListItem>
                            <asp:ListItem Value="Thursday">星期四</asp:ListItem>
                            <asp:ListItem Value="Friday">星期五</asp:ListItem>
                            <asp:ListItem Value="Saturday">星期六</asp:ListItem>
                            <asp:ListItem Value="Sunday">星期日</asp:ListItem>
                        </asp:CheckBoxList>--%>
                        
                        <br />
                        <asp:Button ID="btn_SetWorkWeek" runat="server" Text="更新" ForeColor="Blue" Font-Size="X-Large" Font-Bold="True" OnClick="btn_SetWorkWeek_Click" />
                        
                        <br />

                        <br />

                    </div>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="行事曆管理">
                <ContentTemplate>
                    <div>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                            lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
                            HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle"
                            RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
                            Width="861px" PageSize="25"
                            CellPadding="4" DataKeyNames="center_code" DataSourceID="SqlDataSource1"
                            ForeColor="#333333" GridLines="None" OnDataBound="GridView1_DataBound"
                            OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:BoundField DataField="center_code" HeaderText="序號" ReadOnly="True"
                                    SortExpression="center_code">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="region" HeaderText="地區" SortExpression="region">
                                    <HeaderStyle HorizontalAlign="Center" Width="30px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="center_name" HeaderText="鑑測中心"
                                    SortExpression="center_name">
                                    <HeaderStyle HorizontalAlign="Left" Width="150px" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="location" HeaderText="位置"
                                    SortExpression="location">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="人數限制" SortExpression="limit">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("limit") %>'></asp:Label>
                                        <%--<input type="text" runat="server" id="txt_limit" value='<%# Eval("limit") %>' style="width:40px" />--%>
                                        <%--<asp:TextBox ID="txt1_limit" runat="server" Text='<%# Bind("limit") %>' Width="40px"></asp:TextBox>--%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("limit") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="IsService" HeaderText="服務狀態"
                                    SortExpression="IsService">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IsSwin" HeaderText="游泳池"
                                    SortExpression="IsSwin">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="address" HeaderText="地址" SortExpression="address">
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <input type="button" id="EditSch" value="Edit" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:MainDB %>"
                            SelectCommand="SELECT center_code, region, center_name, location, limit, address, IsService, IsSwin FROM Center"></asp:SqlDataSource>
                        <div style="margin-top: 10px">
                            <span>設定明年度行事曆</span>
                            <table class="GridViewStyle" style="font-size:18px">
                                <tbody>
                                    <tr class="RowStyle">
                                        <td class="highlightRow">年度</td>
                                        <td class="highlightRow">目前狀態</td>
                                        <td class="highlightRow">變更狀態</td>
                                    </tr>
                                    <tr class="RowStyle">
                                        <td>
                                            <asp:Label ID="year" runat="server" Text="Label"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="year_status" runat="server" Text="Label"></asp:Label></td>
                                        <td>
                                            <asp:Button ID="Button1" runat="server" Text="開啟" OnClick="Button1_Click" OnClientClick="return confirm('您確定要變更明年行事曆嗎?')" /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </ContentTemplate>

            </ajaxToolkit:TabPanel>

            <ajaxToolkit:TabPanel ID="TabPanel2" runat="server" HeaderText="臨時關站處理">
                <ContentTemplate>
                    <div>
                        <table>
                            <tr>
                                <td>請選取鑑測站：</td>
                                <td>
                                <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="center_name" 
                        DataValueField="center_code" Width="150px"  OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
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
                </ContentTemplate>

            </ajaxToolkit:TabPanel>
        </ajaxToolkit:TabContainer>
    </div>
</asp:Content>

