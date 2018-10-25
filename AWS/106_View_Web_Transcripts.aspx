<%@ Page Language="C#" AutoEventWireup="true" CodeFile="106_View_Web_Transcripts.aspx.cs" Inherits="_106_View_Web_Transcripts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>成績單預覽</title>
    <style type="text/css">
        /*tr {
            border: solid;
            border-width: 1px;
        }

        th {
            border: solid;
            border-width: 1px;
        }

        td {
            border: solid;
            border-width: 1px;
        }*/
        .tbset1 {
            border: solid;
            border-width: 1px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 800px; height: 1150px; margin: 0 auto; background-image: url('images/106_Transcripts_logo.jpg'); background-position: center; background-size: cover">
            <p style="text-align: center; padding-top: 52px; margin-bottom: 1px; font-family: DFKai-SB; font-size: 38px; font-weight: bold">國軍體能鑑測中心</p>
            <p id="p_Center_Name" runat="server" style="text-align: center; font-family: DFKai-SB; margin-top: 1px; margin-bottom: 1px; font-size: 38px; font-weight: bold"></p>
            <p id="p_Test_Date" runat="server" style="text-align: right; font-family: DFKai-SB; font-size: 24px; font-weight: bold; margin-bottom: 1px; margin-top: 1px; margin-right: 5%">鑑測日期：</p>
            <p id="p_Print_Date" runat="server" style="text-align: right; font-family: DFKai-SB; font-size: 24px; font-weight: bold; margin-top: 1px; margin-right: 5%; margin-bottom: 16px">列印日期：</p>
            <div style="float: left; width: 400px; height: 200px; margin-top: 16px; margin-bottom: 43px">
                <p id="p_Unit" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold">單位：</p>
                <p id="p_Rank" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold">級職：</p>
                <p id="p_Birth" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold">生日：</p>
                <p id="p_BMI" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold; margin-left: 1%">BMI：</p>
                <p id="p_Message" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold; margin-left: 1%">醫官判定</p>
            </div>
            <div style="float: right; width: 400px; height: 200px; margin-top: 10px; margin-bottom: 43px">
                <p id="p_Name" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold; margin-top: 66px">姓名：</p>
                <p id="p_ID" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold">身份證字號：</p>
                <p id="p_BodyFat" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 22px; font-weight: bold">體脂率：</p>
            </div>
            <table class="tbset1" style="width: 100%; height: 270px; border: solid; table-layout: fixed; text-align: center; font-family: DFKai-SB; font-size: 22px; font-weight: bold; margin-top: 43px; margin-bottom: 1px; border-width: 1px;" rules="all">
                <tr>
                    <th>項目</th>
                    <th>次數/時間</th>
                    <th>成績</th>
                    <th>判定</th>
                </tr>
                <tr>
                    <td>
                        <label id="LB_Situps_Name" runat="server">仰臥起坐</label></td>
                    <td>
                        <label id="LB_Situps_Count" runat="server"></label>
                    </td>
                    <td>
                        <label id="LB_Situps_Score" runat="server"></label>
                    </td>
                    <td>
                        <label id="LB_Situps_Status" runat="server"></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label id="LB_Pushups_Name" runat="server">俯地挺身</label></td>
                    <td>
                        <label id="LB_Pushups_Count" runat="server"></label>
                    </td>
                    <td>
                        <label id="LB_Pushups_Score" runat="server"></label>
                    </td>
                    <td>
                        <label id="LB_Pushups_Status" runat="server"></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label id="LB_Run_Name" runat="server">*5公里健走</label></td>
                    <td>
                        <label id="LB_Run_Count" runat="server"></label>
                    </td>
                    <td>
                        <label id="LB_Run_Score" runat="server"></label>
                    </td>
                    <td>
                        <label id="LB_Run_Status" runat="server"></label>
                    </td>
                </tr>

            </table>
            <div>
                <div style="float: left; width: 500px; height: 158px; margin-top: 1px">
                    <pre style="text-align: left; font-family: DFKai-SB; font-size: 17px; margin-top: 5px">
成績單驗證流程：
1、登入「國軍基本體能鑑測網」首頁。
2、點選首頁上面「成績單驗證」連結至驗證頁面。
3、輸入「身份證字號」及「驗證碼」即可進行驗證。
            </pre>
                </div>
                <div style="float: right; width: 300px; height: 158px; margin-top: 1px">
                    <p id="p_Check_Code" runat="server" style="text-align: right; font-family: DFKai-SB; font-size: 26px; font-weight: bold; margin-top: 5px"></p>
                </div>
            </div>
            <div>
                <div style="float: left; width: 230px; height: 200px; margin-top: 1px">
                    <p id="p_TotalStatus" runat="server" style="text-align: left; font-family: DFKai-SB; font-size: 28px; font-weight: bold; margin-top: 76px; margin-left: 43px">總評：不合格</p>
                </div>
                <div style="float: right; width: 570px; height: 200px; margin-top: 1px">
                    <div style="float: left; width: 340px; height: 200px; margin-top: 1px">
                        <div style="float: left; width: 100%; height: 50%">
                            <p style="text-align: right; font-family: DFKai-SB; font-size: 22px; font-weight: bold; margin-top: 5px; margin-right: 10px">鑑測官簽章：</p>
                        </div>
                        <div style="float: left; width: 100%; height: 50%">
                            <p style="text-align: right; font-family: DFKai-SB; font-size: 22px; font-weight: bold; margin-top: 15px; margin-right: 10px">鑑測主任簽章：</p>
                        </div>

                    </div>
                    <div style="float: right; width: 230px; height: 200px; margin-top: 1px">
                        <div style="float: left; width: 100%; height: 50%;">
                            <table style="width: 88%; height: 84%; border: double; table-layout: fixed; text-align: center; border-width: 10px; border-color: red; margin-top: 5px;">
                                <tbody>
                                    <tr>
                                        <td style="width: 60%;">
                                            <label id="LB_Seal_Unit1" runat="server" style="text-align: left; font-family: DFKai-SB; font-weight: bold; font-size: 9px; color: red; white-space: nowrap; letter-spacing: 0px;"></label>
                                        </td>
                                        <td style="width: 40%;" rowspan="2">
                                            <label id="LB_Seal_Name1" runat="server" style="text-align: left; font-family: DFKai-SB; font-weight: bold; font-size: 12px; color: red; white-space: nowrap; letter-spacing: 0px"></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 60%;">
                                            <label id="LB_Seal_Rank1" runat="server" style="text-align: left; font-family: DFKai-SB; font-weight: bold; font-size: 9px; color: red; white-space: nowrap; letter-spacing: 0px;"></label>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td>
                                            <asp:Image ID="Img1" runat="server" Height="68px" Width="180px" ImageAlign="Middle" />
                                        </td>

                                    </tr>--%>
                                </tbody>

                            </table>

                        </div>
                        <div style="float: left; width: 100%; height: 50%;">
                            <table style="width: 88%; height: 84%; border: double; table-layout: fixed; text-align: center; border-width: 10px; border-color: red; margin-top: 5px;">
                                <tbody>
                                    <tr>
                                        <td style="width: 60%;">
                                            <label id="LB_Seal_Unit2" runat="server" style="text-align: left; font-family: DFKai-SB; font-weight: bold; font-size: 9px; color: red; white-space: nowrap; letter-spacing: 0px;"></label>
                                        </td>
                                        <td style="width: 40%;" rowspan="2">
                                            <label id="LB_Seal_Name2" runat="server" style="text-align: left; font-family: DFKai-SB; font-weight: bold; font-size: 12px; color: red; white-space: nowrap; letter-spacing: 0px"></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 60%;">
                                            <label id="LB_Seal_Rank2" runat="server" style="text-align: left; font-family: DFKai-SB; font-weight: bold; font-size: 9px; color: red; white-space: nowrap; letter-spacing: 0px;"></label>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td>
                                            <asp:Image ID="Img2" runat="server" Height="68px" Width="180px" ImageAlign="Middle" />
                                        </td>

                                    </tr>--%>
                                </tbody>

                            </table>

                        </div>
                    </div>

                </div>

            </div>
        </div>
    </form>
</body>
</html>
