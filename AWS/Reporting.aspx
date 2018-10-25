<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Reporting.aspx.cs" Inherits="Reporting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />

    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script>

    <script type="text/javascript">
        $(function() {
            $('h2').each(function() {
                $(this).attr({ style: "cursor:pointer" });
            });

            $('#item').click(function() {
                window.open('ReportingSumItem.aspx?type=item', '', '');
            });

            $('#rank').click(function() {
                window.open('ReportingSumItem.aspx?type=rank', '', '');
            });

            $('#age').click(function() {
                window.open('ReportingSumItem.aspx?type=age', '', '');
            });

            $('#PassRate').click(function () {
                window.open('107_PassRate.aspx?type=age', '', '');
            });

            $('#ResultToCSV').click(function () {
                window.open('107_Result_To_CSV.aspx?type=age', '', '');
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
        <ajaxToolkit:TabPanel ID="TabPanel1" runat="server" HeaderText="成績統計">
            <ContentTemplate>
                <br />
                <table>
                    <tr>
                        <td>
                            <h2 id="item">
                                項目報表</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h2 id="rank">
                                級職報表</h2>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>
                            <h2 id="age">
                                年齡報表</h2>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>
                            <h2 id="PassRate" style="color:blue">
                                訓練成效統計</h2>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>
                            <h2 id="ResultToCSV" style="color:blue">
                                成績名冊匯出</h2>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
</asp:Content>
