<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="108_Data_Update.aspx.cs" Inherits="_108_Data_Update" %>

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
            $(':button[value="基本資料異動"]').each(function () {
                $(this).click(function () {
                    var sid = $(this).parent().parent().find('td:eq(0)').html();
                    window.open("108_PlayerUpdate.aspx?sid=" + sid, "基本資料異動", config = 'height=720,width=720,scrollbars=yes');
                });
            });
        });
        $(function () {
            $(':button[value="成績補正"]').each(function () {
                $(this).click(function () {
                    var sid = $(this).parent().parent().find('td:eq(0)').html();
                    window.open("108_ResultUpdate.aspx?sid=" + sid, "成績補正", config = 'height=720,width=840,scrollbars=yes');
                });
            });
        });

        //接收子視窗回傳值要執行的方法。
        function outside(newid) {
            if (newid == "Err") {
                alert("更新失敗");
            } else {
                var newId = document.getElementById("ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_player_id");
                newId.innerText = newid;
                document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_search1').click();
                alert("更新成功");
            }
            
        }

        function outside_r(check) {
            if (check == "Err") {
                alert("補正失敗");
            } else {
                document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel2_search2').click();
                alert("補正成功");
            }
            
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme" Width="1230px" ActiveTabIndex="0">

        <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="基本資料異動">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                    <asp:Label ID="Label1" runat="server" Text="請輸入身分證："></asp:Label><asp:TextBox ID="player_id" runat="server" MaxLength="10"></asp:TextBox>
                    <asp:Button ID="search1" runat="server" CssClass="search" OnClick="search1_Click" />
                </div>
                <div id="playeridnone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:查無資料</span>
                </div>
                <div>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle"
                        Width="1200px" PageSize="25" >
                        <Columns>                           
                            <asp:BoundField DataField="sid" HeaderText="序號" SortExpression="sid" >
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="id" HeaderText="身份證字號" SortExpression="id">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="birth" HeaderText="出生年月日" SortExpression="birth">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="mail" HeaderText="電子信箱" SortExpression="mail">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="password" HeaderText="密碼" SortExpression="password">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <input type="button" id="EditSch" value="基本資料異動" style="cursor: pointer; background-color: #FF8888;" />
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

        <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="成績補正">
            <ContentTemplate>
                <div style="margin-top: 5px; margin-bottom: 5px; vertical-align: bottom; height: 22px;">
                    <asp:Label ID="Label2" runat="server" Text="請輸入身分證："></asp:Label><asp:TextBox ID="result_id" runat="server" MaxLength="10"></asp:TextBox>
                    <asp:Button ID="search2" runat="server" CssClass="search" OnClick="search2_Click" />
                </div>
                <div id="resultidnone" style="display: none;" runat="server">
                    <span style="color: red; width: 200px; font-size: 16px; font-weight: bold; text-align: left; font-family: 微軟正黑體;">搜尋結果:查無資料</span>
                </div>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" lternatingRowStyle-CssClass="AltRowStyle" CssClass="GridViewStyle" EditRowStyle-CssClass="EditRowStyle"
                    HeaderStyle-CssClass="HeaderStyle" PagerStyle-CssClass="PagerStyle" RowStyle-CssClass="RowStyle" SelectedRowStyle-CssClass="SelectedRowStyle"
                    Width="1200px" PageSize="25" HeaderStyle-Wrap="false">
                    <Columns>
                        <asp:BoundField DataField="sid" HeaderText="序號" SortExpression="sid" />
                        <asp:BoundField DataField="date" HeaderText="鑑測日期" SortExpression="date" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="id" HeaderText="身份證" SortExpression="id" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="birth" HeaderText="生日" SortExpression="birth" ItemStyle-Wrap="false" />
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
                                <input type="button" id="EditSch" value="成績補正" style="cursor: pointer; background-color: #FF8888;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>

        

        

        

    </ajaxToolkit:TabContainer>
</asp:Content>
