<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SearchScore.aspx.cs" Inherits="SearchScore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>
    <script type="text/javascript">
        function submitFormwithEnter(myfield, e) {
            var keycode;
            if (window.event) {
                keycode = window.event.keyCode;
            }
            else if (e) {
                keycode = e.which;
            }
            else {
                return true;
            }

            if (keycode == 13) {
                myfield.form.submit();
                return false;
            }
            else {
                return true;
            }
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $(':button[value="網頁預覽列印"]').each(function () {
                $(this).click(function () {
                    var id = $(this).parent().parent().find('td:eq(2)').html();
                    var s2 = $(this).parent().parent().find('td:eq(0)').html();
                    var DateArr = s2.split("/");
                    var date = (parseInt(DateArr[0]) + 1911).toString() + "/" + DateArr[1].toString() + "/" + DateArr[2].toString();//民國轉西元年
                    var s1 = "2016/12/31";
                    var t1 = Date.parse(s1);
                    var t2 = Date.parse(date);
                    if (t1 < t2) {
                        window.open("106_View_Web_Transcripts.aspx?id=" + id + "&date=" + date);
                        window.open("106_Print_Teach.aspx", "列印說明", config = 'height=720,width=720,scrollbars=yes');
                    }
                    else {
                        alert('網路成績單僅限「106/01/01」起之鑑測成績才能預覽列印!!');
                    }
                });

            });
        });
        $(function () {
            $(':button[value="下載成績單"]').each(function () {
                $(this).click(function () {
                    var id = $(this).parent().parent().find('td:eq(2)').html();
                    var s2 = $(this).parent().parent().find('td:eq(0)').html();
                    var DateArr = s2.split("/");
                    var date = (parseInt(DateArr[0]) + 1911).toString() + "/" + DateArr[1].toString() + "/" + DateArr[2].toString();//民國轉西元年
                    var s1 = "2016/12/31";
                    var t1 = Date.parse(s1);
                    var t2 = Date.parse(date);
                    if (t1 < t2) {
                        window.open("106_Web_Transcripts.aspx?id=" + id + "&date=" + date);
                    }
                    else {
                        alert('網路成績單僅限「106/01/01」起之鑑測成績才能下載列印!!');
                    }
                });

            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme" Width="1230px" ActiveTabIndex="2">

        <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="身份證查詢">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                    <asp:Label ID="Label1" runat="server" Text="請輸入身分證："></asp:Label><asp:TextBox ID="id" runat="server" MaxLength="10"></asp:TextBox>
                    <asp:Button ID="search1" runat="server" CssClass="search" OnClick="search1_Click" />
                </div>
                <div id="idnone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:目前無成績</span>
                </div>
                <div>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
                        Width="1200px" PageSize="25" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="date">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="unit_code" HeaderText="單位" SortExpression="unit_code">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="id" HeaderText="身份證" SortExpression="id">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="center_name" HeaderText="鑑測地點" SortExpression="center_name">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sit_ups" HeaderText="仰臥起坐" ReadOnly="True"
                                SortExpression="sit_ups">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sit_ups_score" HeaderText="仰臥起坐成績" SortExpression="sit_ups_score">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="push_ups" HeaderText="俯地挺身" ReadOnly="True"
                                SortExpression="push_ups">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="push_ups_score" HeaderText="俯地挺身成績" SortExpression="push_ups_score">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="run" HeaderText="三千公尺" ReadOnly="True"
                                SortExpression="run">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="run_score" HeaderText="三千公尺成績" SortExpression="run_score">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="status" HeaderText="鑑測結果" SortExpression="status">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <input type="button" id="EditSchWeb" value="網頁預覽列印" style="cursor: pointer; margin-right: 5px; background-color: #66FF66;" />
                                    <input type="button" id="EditSch" value="下載成績單" style="cursor: pointer; background-color: #FF8888;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle CssClass="EditRowStyle" />
                        <HeaderStyle CssClass="HeaderStyle" Wrap="False" />
                        <PagerStyle CssClass="PagerStyle" />
                        <RowStyle CssClass="RowStyle" />
                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

        <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="姓名查詢">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                    <asp:Label ID="Label2" runat="server" Text="請輸入姓名："></asp:Label><asp:TextBox ID="name" runat="server" MaxLength="5"></asp:TextBox>
                    <asp:Button ID="search2" runat="server" CssClass="search" OnClick="search2_Click" />
                </div>
                <div id="namenone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:目前無成績</span>
                </div>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
                    HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
                    Width="1200px" PageSize="25" HeaderStyle-Wrap="false">
                    <Columns>
                        <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="date" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="unit_code" HeaderText="單位" SortExpression="unit_code" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="id" HeaderText="身份證" SortExpression="id" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="center_name" HeaderText="鑑測地點" SortExpression="center_name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="sit_ups" HeaderText="仰臥起坐" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="sit_ups" />
                        <asp:BoundField DataField="sit_ups_score" HeaderText="仰臥起坐成績" SortExpression="sit_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="push_ups" HeaderText="俯地挺身" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="push_ups" />
                        <asp:BoundField DataField="push_ups_score" HeaderText="俯地挺身成績" SortExpression="push_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="run" HeaderText="三千公尺" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="run" />
                        <asp:BoundField DataField="run_score" HeaderText="三千公尺成績" SortExpression="run_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="status" HeaderText="鑑測結果" SortExpression="status" ItemStyle-Wrap="false" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <input type="button" id="EditSchWeb" value="網頁預覽列印" style="cursor: pointer; margin-right: 5px; background-color: #66FF66;" />
                                <input type="button" id="EditSch" value="下載成績單" style="cursor: pointer; background-color: #FF8888;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

        <ajaxToolkit:TabPanel runat="server" ID="TabPanel3" HeaderText="單位代碼查詢">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                    <asp:Label ID="Label3" runat="server" Text="請輸入單位代碼："></asp:Label><asp:TextBox ID="unit_code" runat="server" MaxLength="5"></asp:TextBox>
                    <asp:Button ID="search3" runat="server" CssClass="search" OnClick="search3_Click" />
                </div>
                <div id="unitnone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:目前無成績</span>
                </div>
                <div id="noright" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:權限不足</span>
                </div>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
                    HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
                    Width="1200px" PageSize="25" HeaderStyle-Wrap="false">
                    <Columns>
                        <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="date" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="unit_code" HeaderText="單位" SortExpression="unit_code" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="id" HeaderText="身份證" SortExpression="id" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="center_name" HeaderText="鑑測地點" SortExpression="center_name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="sit_ups" HeaderText="仰臥起坐" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="sit_ups" />
                        <asp:BoundField DataField="sit_ups_score" HeaderText="仰臥起坐成績" SortExpression="sit_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="push_ups" HeaderText="俯地挺身" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="push_ups" />
                        <asp:BoundField DataField="push_ups_score" HeaderText="俯地挺身成績" SortExpression="push_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="run" HeaderText="三千公尺" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="run" />
                        <asp:BoundField DataField="run_score" HeaderText="三千公尺成績" SortExpression="run_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="status" HeaderText="鑑測結果" SortExpression="status" ItemStyle-Wrap="false" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

        <ajaxToolkit:TabPanel runat="server" ID="TabPanel4" HeaderText="鑑測時間查詢">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                    <asp:Label ID="Label4" runat="server" Text="請輸入鑑測時間："></asp:Label><asp:TextBox ID="date" runat="server" MaxLength="9"></asp:TextBox>
                    <asp:Button ID="search4" runat="server" CssClass="search" OnClick="search4_Click" />
                </div>
                <div id="datenone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:目前無成績</span>
                </div>
                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
                    HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
                    Width="1200px" PageSize="25" HeaderStyle-Wrap="false">
                    <Columns>
                        <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="date" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="unit_code" HeaderText="單位" SortExpression="unit_code" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="id" HeaderText="身份證" SortExpression="id" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="center_name" HeaderText="鑑測地點" SortExpression="center_name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="sit_ups" HeaderText="仰臥起坐" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="sit_ups" />
                        <asp:BoundField DataField="sit_ups_score" HeaderText="仰臥起坐成績" SortExpression="sit_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="push_ups" HeaderText="俯地挺身" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="push_ups" />
                        <asp:BoundField DataField="push_ups_score" HeaderText="俯地挺身成績" SortExpression="push_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="run" HeaderText="三千公尺" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="run" />
                        <asp:BoundField DataField="run_score" HeaderText="三千公尺成績" SortExpression="run_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="status" HeaderText="鑑測結果" SortExpression="status" ItemStyle-Wrap="false" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

        <ajaxToolkit:TabPanel runat="server" ID="TabPanel5" HeaderText="鑑測站查詢">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                    <asp:Label ID="Label6" runat="server" Text="請輸入鑑測時間："></asp:Label><asp:TextBox ID="TextBox1" runat="server" MaxLength="9"></asp:TextBox>
                    <asp:Label ID="Label5" runat="server" Text="請選擇鑑測站："></asp:Label>
                    <asp:DropDownList
                        runat="server" ID="cneterSel" AutoPostBack="False"
                        DataSourceID="SqlDataSource1" DataTextField="center_name"
                        DataValueField="center_code">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:MainDB %>"
                        SelectCommand="Ex103_GetCenterList" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    <asp:Button ID="search5" runat="server" CssClass="search" OnClick="search5_Click" />
                </div>
                <div id="centernone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:目前無成績</span>
                </div>
                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
                    HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
                    Width="1200px" PageSize="25" HeaderStyle-Wrap="false">
                    <Columns>
                        <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="date" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="unit_code" HeaderText="單位" SortExpression="unit_code" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="id" HeaderText="身份證" SortExpression="id" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="age" HeaderText="年齡" SortExpression="age" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="center_name" HeaderText="鑑測地點" SortExpression="center_name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="sit_ups" HeaderText="仰臥起坐" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="sit_ups" />
                        <asp:BoundField DataField="sit_ups_score" HeaderText="仰臥起坐成績" SortExpression="sit_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="push_ups" HeaderText="俯地挺身" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="push_ups" />
                        <asp:BoundField DataField="push_ups_score" HeaderText="俯地挺身成績" SortExpression="push_ups_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="run" HeaderText="三千公尺" ReadOnly="True" ItemStyle-Wrap="false"
                            SortExpression="run" />
                        <asp:BoundField DataField="run_score" HeaderText="三千公尺成績" SortExpression="run_score" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="status" HeaderText="鑑測結果" SortExpression="status" ItemStyle-Wrap="false" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

    </ajaxToolkit:TabContainer>
</asp:Content>
