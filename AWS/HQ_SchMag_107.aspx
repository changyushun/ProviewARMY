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
            $(':asp:button[value="��s"]').each(function () {
                $(this).click(function () {
                    var msg;
                    var dt = new Date();
                    var nextyear = dt.getFullYear() + 1-1911;
                    msg = '�T�{��s���~(����' + nextyear.toString() + '�~)�u�@��p�U�G\n';
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
                        msg += '�P���@�G�}��\n';
                    else
                        msg += '�P���@�G����\n';
                    if (ch2.checked)
                        msg += '�P���G�G�}��\n';
                    else
                        msg += '�P���G�G����\n';
                    if (ch3.checked)
                        msg += '�P���T�G�}��\n';
                    else
                        msg += '�P���T�G����\n';
                    if (ch4.checked)
                        msg += '�P���|�G�}��\n';
                    else
                        msg += '�P���|�G����\n';
                    if (ch5.checked)
                        msg += '�P�����G�}��\n';
                    else
                        msg += '�P�����G����\n';
                    if (ch6.checked)
                        msg += '�P�����G�}��\n';
                    else
                        msg += '�P�����G����\n';
                    if (ch7.checked)
                        msg += '�P����G�}��\n';
                    else
                        msg += '�P����G����\n';
                    if (confirm('< < < < <  �`  �N  > > > > >\n�Y��s���~�u�@���A�t�αN�۰ʭ��m���~�UŲ�����ߤ���ƾ�C\n�Щ��s��A���s�]�w�UŲ�����ߤ���ƾ�!!')) {
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
            $(':asp:button[value="�]�w"]').each(function () {
                $(this).click(function () {
                    var msg;
                    var dt = new Date();
                    var nextyear = dt.getFullYear() + 1-1911;
                    msg = '�T�{�]�w���~(����' + nextyear.toString() + '�~)�u�@��p�U�G\n';
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
                        msg += '�P���@�G�}��\n';
                    else
                        msg += '�P���@�G����\n';
                    if (ch2.checked)
                        msg += '�P���G�G�}��\n';
                    else
                        msg += '�P���G�G����\n';
                    if (ch3.checked)
                        msg += '�P���T�G�}��\n';
                    else
                        msg += '�P���T�G����\n';
                    if (ch4.checked)
                        msg += '�P���|�G�}��\n';
                    else
                        msg += '�P���|�G����\n';
                    if (ch5.checked)
                        msg += '�P�����G�}��\n';
                    else
                        msg += '�P�����G����\n';
                    if (ch6.checked)
                        msg += '�P�����G�}��\n';
                    else
                        msg += '�P�����G����\n';
                    if (ch7.checked)
                        msg += '�P����G�}��\n';
                    else
                        msg += '�P����G����\n';
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
                    var msg = "< < < < <  �`  �N  > > > > >\n����Ų�����ɱN�R���������H����ơA�Y�ӤH��Ʀ��n�O�q�l�H�c�̡A�t�αN�۰ʱH�o�������W�H��ܭӤH�H�c�C\n---------------------------------------------------------------------\n�Юֹ�������ƬO�_���T�G\n1.Ų�����W�١G" + DRlist.options[DRlist.selectedIndex].text + "\n2.��������G" + Inqdate.value + "\n3.�������H�ơG" + count.innerText + "\n4.������]�G" + Reason.value;
                    if (confirm(msg)) {
                        hf.value = "ok";
                        //���⯸���_��
                        $.postJson('Operations/Schedule.ashx', {
                            mode: 'offstation',
                            center_code: DRlist.value,
                            op_id: 'admin',
                            //type: 1,
                            date: Inqdate.value,
                            note: '�{������',
                            log: null
                        }, function (data, s) {
                            if (s == 'success') {
                                //alert('�������\�A�T�{��N����H���W�U�R���αH�o�q���H��!!');
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
                    alert("��ƿ�J������!!")
                    return false;
                }
                
            }
            else {
                alert("�Х���J������]!!")
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
            <ajaxToolkit:TabPanel ID="TabPanel" runat="server" HeaderText="���~�פu�@��]�w">
                <ContentTemplate>
                    <div>
                        <asp:Label ID="Label2" runat="server" Text="�]�w���~�פu�@��" Font-Size="X-Large"></asp:Label>
                        <asp:Label ID="lab_LastYear" runat="server" Font-Size="X-Large" ForeColor="#009933" Font-Bold="True"></asp:Label>
                        <br />
                        <asp:Label ID="Label3" runat="server" Text="�]�w���A�G" Font-Size="X-Large"></asp:Label>
                        <asp:Label ID="lab_SetStatus" runat="server" Font-Size="X-Large" ForeColor="Red" Font-Bold="True"></asp:Label>
                        <br />
                        <asp:CheckBox ID="cb_Monday" runat="server" Text="�P���@�G" />
                        <br />
                        <asp:CheckBox ID="cb_Tuesday" runat="server" Text="�P���G�G" />
                        <br />
                        <asp:CheckBox ID="cb_Wednesday" runat="server" Text="�P���T�G" />
                        <br />
                        <asp:CheckBox ID="cb_Thursday" runat="server" Text="�P���|�G" />
                        <br />
                        <asp:CheckBox ID="cb_Friday" runat="server" Text="�P�����G" />
                        <br />
                        <asp:CheckBox ID="cb_Saturday" runat="server" Text="�P�����G" />
                        <br />
                        <asp:CheckBox ID="cb_Sunday" runat="server" Text="�P����G" />
                        <%--<asp:CheckBoxList ID="cbl_WeekCheck" runat="server" RepeatLayout="OrderedList" Font-Size="X-Large" OnSelectedIndexChanged="cbl_WeekCheck_SelectedIndexChanged">
                            <asp:ListItem Value="Monday">�P���@</asp:ListItem>
                            <asp:ListItem Value="Tuesday">�P���G</asp:ListItem>
                            <asp:ListItem Value="Wednesday">�P���T</asp:ListItem>
                            <asp:ListItem Value="Thursday">�P���|</asp:ListItem>
                            <asp:ListItem Value="Friday">�P����</asp:ListItem>
                            <asp:ListItem Value="Saturday">�P����</asp:ListItem>
                            <asp:ListItem Value="Sunday">�P����</asp:ListItem>
                        </asp:CheckBoxList>--%>
                        
                        <br />
                        <asp:Button ID="btn_SetWorkWeek" runat="server" Text="��s" ForeColor="Blue" Font-Size="X-Large" Font-Bold="True" OnClick="btn_SetWorkWeek_Click" />
                        
                        <br />

                        <br />

                    </div>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="��ƾ�޲z">
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
                                <asp:BoundField DataField="center_code" HeaderText="�Ǹ�" ReadOnly="True"
                                    SortExpression="center_code">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="region" HeaderText="�a��" SortExpression="region">
                                    <HeaderStyle HorizontalAlign="Center" Width="30px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="center_name" HeaderText="Ų������"
                                    SortExpression="center_name">
                                    <HeaderStyle HorizontalAlign="Left" Width="150px" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="location" HeaderText="��m"
                                    SortExpression="location">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="�H�ƭ���" SortExpression="limit">
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
                                <asp:BoundField DataField="IsService" HeaderText="�A�Ȫ��A"
                                    SortExpression="IsService">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IsSwin" HeaderText="��a��"
                                    SortExpression="IsSwin">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="address" HeaderText="�a�}" SortExpression="address">
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
                            <span>�]�w���~�צ�ƾ�</span>
                            <table class="GridViewStyle" style="font-size:18px">
                                <tbody>
                                    <tr class="RowStyle">
                                        <td class="highlightRow">�~��</td>
                                        <td class="highlightRow">�ثe���A</td>
                                        <td class="highlightRow">�ܧ󪬺A</td>
                                    </tr>
                                    <tr class="RowStyle">
                                        <td>
                                            <asp:Label ID="year" runat="server" Text="Label"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="year_status" runat="server" Text="Label"></asp:Label></td>
                                        <td>
                                            <asp:Button ID="Button1" runat="server" Text="�}��" OnClick="Button1_Click" OnClientClick="return confirm('�z�T�w�n�ܧ���~��ƾ��?')" /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </ContentTemplate>

            </ajaxToolkit:TabPanel>

            <ajaxToolkit:TabPanel ID="TabPanel2" runat="server" HeaderText="�{�������B�z">
                <ContentTemplate>
                    <div>
                        <table>
                            <tr>
                                <td>�п��Ų�����G</td>
                                <td>
                                <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="center_name" 
                        DataValueField="center_code" Width="150px"  OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                            </td>
                            </tr>
                            <tr>
                                <td>�п�J��������G</td>
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
                                    <asp:Button ID="btn_InqOffStation" runat="server" Text="�d�ߦW��"  Font-Size="16px" OnClick="btn_InqOffStation_Click" BackColor="#CCFFFF" ForeColor="Blue" />
                                </td>
                            </tr>
                            <tr>
                                <td><asp:Label ID="lab_Reason" runat="server" Text="�п�J������]�G" Visible="False"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="txb_Reason" runat="server" Width="560px" MaxLength="40" Visible="False"></asp:TextBox>
                                    
                                    <asp:Label ID="lab_Reason2" runat="server" Text="(���孭40�r��)" ForeColor="Red" Visible="False"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                    <asp:HiddenField ID="HF_CheckDel" runat="server" />
                                <asp:Button ID="btn_Delete" runat="server" Text="����Ų����"  Font-Size="16px" BackColor="#FFCCFF" ForeColor="Red" OnClientClick="checkOK()"   Visible="False" /></td>
                            </tr>
                            <tr>
                                <td><asp:Label ID="lab_countTitle" runat="server" Text="��Ƶ��ơG" Visible="False" Font-Size="18px"></asp:Label></td>
                                <td><asp:Label ID="lab_count" runat="server" Text="" Visible="False" ForeColor="Blue" Font-Size="18px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:GridView ID="GridView2" runat="server" BackColor="White" 
                            BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                            GridLines="Both" 
                            AutoGenerateColumns="False" DataKeyNames="�y����">
                        
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <Columns>
                                <asp:BoundField DataField="�y����" HeaderText="�y����" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="�y����" />
                                <asp:BoundField DataField="Ų�����" HeaderText="Ų�����" ReadOnly="True" 
                                    SortExpression="Ų�����" />
                                <asp:BoundField DataField="�����Ҹ�" HeaderText="�����Ҹ�" SortExpression="�����Ҹ�" />
                                <asp:BoundField DataField="�m�W" HeaderText="�m�W" ReadOnly="True" 
                                    SortExpression="�m�W" />
                                <asp:BoundField DataField="�ʧO" HeaderText="�ʧO" ReadOnly="True" 
                                    SortExpression="�ʧO" />
                                <asp:BoundField DataField="��¾" HeaderText="��¾" SortExpression="��¾" />
                                <asp:BoundField DataField="Ų����" HeaderText="Ų����" SortExpression="Ų����" />
                                <asp:BoundField DataField="���A" HeaderText="���A" SortExpression="���A" />
                                <asp:BoundField DataField="e-mail" HeaderText="e-mail" SortExpression="e-mail" />
                                <%--<asp:TemplateField HeaderText="�R��">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" onclick="btnDelete_Click" Text="�T�{" />
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

