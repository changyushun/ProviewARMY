<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_SchMag.aspx.cs" Inherits="HQ_SchMag" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <style type="text/css">
#DIV1{
width:50%;�@
line-height:50px;�@
padding:20px;�@
border:2px blue solid;�@
margin-right:10px;�@
float:left;
}
#DIV2{
width:50%;
line-height:50px;
padding:20px;
border:2px green solid;
float:left;
}
</style>
<script type="text/javascript">
    $(function() {
        $(':button[value="Edit"]').each(function() {
            $(this).click(function() {
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
                try {
                    $(this).click(function () {
                        var msg;
                        var dt = new Date();
                        var nextyear = dt.getFullYear() + 1 - 1911;
                        msg = '�T�{��s���~(����' + nextyear.toString() + '�~)�u�@��p�U�G\n';
                        var ch1 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Mon');
                        var ch2 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Tue');
                        var ch3 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Wed');
                        var ch4 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Thu');
                        var ch5 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Fri');
                        var ch6 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Sat');
                        var ch7 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Sun');
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
                }
                catch (ex) {
                    alert(ex);
                }
                
            });
        });
        $(function () {
            $(':asp:button[value="�]�w"]').each(function () {
                try{
                    $(this).click(function () {
                        var msg;
                        var dt = new Date();
                        var nextyear = dt.getFullYear() + 1 - 1911;
                        msg = '�T�{�]�w���~(����' + nextyear.toString() + '�~)�u�@��p�U�G\n';

                        var ch1 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Mon');
                        var ch2 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Tue');
                        var ch3 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Wed');
                        var ch4 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Thu');
                        var ch5 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Fri');
                        var ch6 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Sat');
                        var ch7 = document.getElementById('ctl00_ContentPlaceHolder1_cb_Sun');
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
                }
                catch (ex) {
                    alert(ex);
                }
                
            });
        });
        <%--function checkOK() {
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

        }--%>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="content" style="margin-left:0px">        
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
             HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" 
            RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
            Width="861px" PageSize = "25" 
        CellPadding="4" DataKeyNames="center_code" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None" ondatabound="GridView1_DataBound" 
            onrowdatabound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="center_code" HeaderText="�Ǹ�" ReadOnly="True" 
                SortExpression="center_code" >
            <HeaderStyle Width="30px" HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="region" HeaderText="�a��" SortExpression="region" >
            <HeaderStyle HorizontalAlign="Center" Width="30px" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="center_name" HeaderText="Ų������" 
                SortExpression="center_name" >
            <HeaderStyle HorizontalAlign="Left" Width="150px" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="location" HeaderText="��m" 
                SortExpression="location" >
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
                SortExpression="IsService" >
            <HeaderStyle HorizontalAlign="Center"/>
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
             <asp:BoundField DataField="IsSwin" HeaderText="��a��" 
                SortExpression="IsSwin" >
            <HeaderStyle HorizontalAlign="Center"/>
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="address" HeaderText="�a�}" SortExpression="address" >
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
        SelectCommand="SELECT center_code, region, center_name, location, limit, address, IsService, IsSwin FROM Center">
    </asp:SqlDataSource>
        <div style=" margin-top:10px">
        <span>���~�~�פu�@��G</span>
        <table class="GridViewStyle" >
            <tbody>
                <tr class="RowStyle" style="background-color:yellow">
                    <td class="highlightRow">�~��</td>
                    <td class="highlightRow">�P���@</td>
                    <td class="highlightRow">�P���G</td>
                    <td class="highlightRow">�P���T</td>
                    <td class="highlightRow">�P���|</td>
                    <td class="highlightRow">�P����</td>
                    <td class="highlightRow">�P����</td>
                    <td class="highlightRow">�P����</td>
                </tr>
                <tr class="RowStyle">
                    <td><asp:Label ID="lab_ThisYear" runat="server" Text=""></asp:Label></td>
                    <td><asp:Label ID="lab_Mon" runat="server" Text=""></asp:Label></td>
                    <td><asp:Label ID="lab_Tue" runat="server" Text=""></asp:Label></td>
                    <td><asp:Label ID="lab_Wed" runat="server" Text=""></asp:Label></td>
                    <td><asp:Label ID="lab_Thu" runat="server" Text=""></asp:Label></td>
                    <td><asp:Label ID="lab_Fri" runat="server" Text=""></asp:Label></td>
                    <td><asp:Label ID="lab_Sat" runat="server" Text=""></asp:Label></td>
                    <td><asp:Label ID="lab_Sun" runat="server" Text=""></asp:Label></td>
                 </tr>
                
            </tbody>
        </table>    
    </div>
        <br />
        <br />
        <br />
        <div style=" margin-top:10px">
        <span style="color:blue">�]�w���~�~�פu�@��G</span>
        <table class="GridViewStyle">
            <tbody>
                <tr class="RowStyle">
                    <td class="highlightRow">�~��</td>
                    <td class="highlightRow">�P���@</td>
                    <td class="highlightRow">�P���G</td>
                    <td class="highlightRow">�P���T</td>
                    <td class="highlightRow">�P���|</td>
                    <td class="highlightRow">�P����</td>
                    <td class="highlightRow">�P����</td>
                    <td class="highlightRow">�P����</td>
                    <td class="highlightRow">�]�w���A</td>
                    <td class="highlightRow">�]�w</td>
                </tr>
                
                <tr class="RowStyle">
                    <td><asp:Label ID="lab_NextYear" runat="server" Text=""></asp:Label></td>
                    <td><asp:CheckBox ID="cb_Mon" runat="server" /></td>
                    <td><asp:CheckBox ID="cb_Tue" runat="server" /></td>
                    <td><asp:CheckBox ID="cb_Wed" runat="server" /></td>
                    <td><asp:CheckBox ID="cb_Thu" runat="server" /></td>
                    <td><asp:CheckBox ID="cb_Fri" runat="server" /></td>
                    <td><asp:CheckBox ID="cb_Sat" runat="server" /></td>
                    <td><asp:CheckBox ID="cb_Sun" runat="server" /></td>
                    <td><asp:Label ID="lab_Set_Status" runat="server" Text=""></asp:Label></td>
                    <td><asp:Button ID="btn_SetWorkWeek" runat="server" Text="�]�w" onclick="btn_SetWorkWeek_Click" /></td>
                </tr>
            </tbody>
        </table>    
    </div>
    <div style=" margin-top:10px">

        <span style="color:blue">�]�w���~�׶}����W�G</span>
        <table class="GridViewStyle">
            <tbody>
                <tr class="RowStyle">
                    <td class="highlightRow">�~��</td>
                    <td class="highlightRow">�ثe���A</td>
                    <td class="highlightRow">�ܧ󪬺A</td>
                </tr>
                <tr class="RowStyle">
                    <td><asp:Label ID="year" runat="server" Text="Label"></asp:Label></td>
                    <td><asp:Label ID="year_status" runat="server" Text="Label"></asp:Label></td>
                    <td><asp:Button ID="Button1" runat="server" Text="�}��" onclick="Button1_Click" OnClientClick="return confirm('�z�T�w�n�ܧ���~��ƾ��?')"/></td>
                </tr>
            </tbody>
        </table>    
    </div>
        <br />
        <br />
        <br />
        <div style=" margin-top:10px">

        <span style="color:red">�{�������B�z�G</span>
        <table class="GridViewStyle">
            <tbody>
                
                <tr class="RowStyle">
                    <td><input type="button" style="color:black;background-color:yellow;font-size:14px" value="�{�������B�z" onclick="window.open('107_OffStation.aspx')" /></td>
                    <%--<td><asp:Button ID="btn_OffStation" runat="server" Text="�{�������B�z"  OnClientClick="return confirm('�z�T�w�n�ܧ���~��ƾ��?')" ForeColor="Red" BackColor="#FFFF66" /></td>--%>
                </tr>
            </tbody>
        </table>    
    </div>
    
</div>
</asp:Content>

