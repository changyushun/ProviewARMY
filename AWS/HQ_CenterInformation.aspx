<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HQ_CenterInformation.aspx.cs" Inherits="HQ_CenterInformation" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
<link rel="Stylesheet" type="text/css" href="JS/htmileditor/jquery.cleditor.css" />
    <%--<script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js"></script> --%><%--<script type="text/javascript" src="JS/htmileditor/jquery.cleditor.js"></script>--%>
    <style type="text/css">
        #div_left{
            width:79%;
           float:left;
           height:100px;
           /*background:#383;*/
        }
        #div_right{
            width:21%;
           float:left;
           height:100px;
           /*background:#338;*/
        }
    </style>
<script type="text/javascript" src="JS/htmileditor/jquery.min.js"></script> 
<script type="text/javascript" src="JS/htmileditor/jquery.cleditor.min.js"></script>

    <script type="text/javascript">
        //$(function () {
        //    $(':button[value="更新簽章"]').each(function () {
        //        $(this).click(function () {
        //            var sid = $(this).parent().parent().find('td:eq(0)').html();
        //            window.open('106_UpdateSealtime.aspx?sid=' + sid + '&centercode=' + $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel3_Label7').text() + '&Acc=' + $('#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel3_Label_Acc').text(), '', 'toolbar=no,scrollbars=yes,resizable=yes,location=no,width=550,height=450,top=100,left=200');
        //        });
        //        //alert($(this).parent().parent().find('td:eq(0)').html());
        //    });



        //});
</script>
    <script type="text/javascript">
        $(function () {           
            $(':button[value="更新簽章"]').each(function () {
                $(this).click(function () {
                    var sid = $(this).parent().parent().find('td:eq(0)').html();
                    window.open('106_UpdateSealtime.aspx?sid=' + sid + '&centercode=' + document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_hf_Center_code').value + '&Acc=' + document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_hf_Acc').value, '', 'toolbar=no,scrollbars=yes,resizable=yes,location=no,width=650,height=400,top=100,left=200');                   
                });
                //alert($(this).parent().parent().find('td:eq(0)').html());
            }); 
        });
</script>

    <script type="text/javascript">
        //$(function () {
        //    $(':button[value="放大預覽"]').each(function () {
        //        $(this).click(function () {
        //            var sid = $(this).parent().parent().find('td:eq(0)').html();
        //            var unit = $(this).parent().parent().find('td:eq(4)').html();
        //            var rank = $(this).parent().parent().find('td:eq(5)').html();
        //            var name = $(this).parent().parent().find('td:eq(6)').html();
        //            window.open('106_ViewSeal.aspx?sid=' + sid + '&unit=' + unit + '&rank=' + rank + '&name='+name, '', 'toolbar=no,scrollbars=yes,resizable=yes,location=no,width=550,height=450,top=100,left=200');
        //        });
        //        //alert($(this).parent().parent().find('td:eq(0)').html());
        //    });
        //});
</script>
    <script type="text/javascript">
        function View() {
            var sid = $(this).parent().parent().find('td:eq(0)').html();
                        var unit = $(this).parent().parent().find('td:eq(4)').html();
                        var rank = $(this).parent().parent().find('td:eq(5)').html();
                        var name = $(this).parent().parent().find('td:eq(6)').html();
                        var img  = $(this).parent().parent().find('td:eq(7)').html();
                        window.open('106_ViewSeal.aspx?sid=' + sid + '&unit=' + unit + '&rank=' + rank + '&name='+name +'&img='+img, '', 'toolbar=no,scrollbars=yes,resizable=yes,location=no,width=550,height=450,top=100,left=200');
        }
    </script>
    <script type="text/javascript">
        
    </script>
    <%-- 加入下面這段script才能使用全選功能 --%>
    <script type="text/javascript">
        function SelectAllCheckboxes(spanChk) {
            elm = document.forms[0];
            for (i = 0; i <= elm.length - 1; i++) {
                if (elm[i].type == "checkbox" && elm[i].id != spanChk.id) {
                    if (elm.elements[i].checked != spanChk.checked)
                        elm.elements[i].click();
                }
            }
        }
</script> 
    <script type="text/javascript">
        //檢查日期格式
        function dateValidationCheck(str) {
            var re = new RegExp("^([0-9]{3})[./]{1}([0-9]{1,2})[./]{1}([0-9]{1,2})$");
            var strDataValue;
            var infoValidation = true;
            var a = 1;
            var b = 0;
            if ((strDataValue = re.exec(str)) != null) {
                var i;
                i = parseFloat(strDataValue[1]);
                if (i <= 0 || i > 999) { /*年*/
                    infoValidation = false;
                }
                i = parseFloat(strDataValue[2]);
                if (i <= 0 || i > 12) { /*月*/
                    infoValidation = false;
                }
                i = parseFloat(strDataValue[3]);
                if (i <= 0 || i > 31) { /*日*/
                    infoValidation = false;
                }
            } else {
                infoValidation = false;
            }
            if (!infoValidation) {
                //alert("請輸入 YYYY/MM/DD 日期格式");
                return b;
            }
            else {
                return a;
                //return infoValidation;
            }
        }
    </script>
   
    <script type="text/javascript">
        //接收子視窗回傳值要執行的方法。
        function outside() {
            document.getElementById('ctl00_ContentPlaceHolder1_TabContainer1_TabPanel3_Button3').click();
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_TabContainer1_TabPanel1_information").cleditor({ width: 900, height: 180, useCSS: true });
        });
</script> 
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme" ActiveTabIndex="0" >
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="鑑測站資訊維護">
    <HeaderTemplate>
        鑑測站資訊維護
    </HeaderTemplate>
<ContentTemplate>
    <asp:HiddenField ID="hf_Center_code" runat="server" />
    <asp:HiddenField ID="hf_Acc" runat="server" />
    <asp:HiddenField ID="hf_start_time1" runat="server" />
    <asp:HiddenField ID="hf_start_time2" runat="server" />
    <asp:HiddenField ID="hf_page" runat="server" />
<div><asp:Label ID="Label2" runat="server" Text="圖檔上傳 : "></asp:Label><asp:FileUpload ID="FileUpload1" runat="server" />
<asp:Button ID="Button1" runat="server" Text="確認更新" onclick="Button1_Click" /></div>
<div><asp:Label ID="Label3" runat="server" Text="鑑測站圖片 : 圖檔需小於2MB , 檔名只接受英數字"></asp:Label>
    
    
    
    </div>
<div><asp:Image ID="Image1" runat="server" /></div>
<div><asp:Label ID="Label1" runat="server" Text="相關說明資訊 :"></asp:Label></div>
<div><asp:TextBox ID="information" runat="server" TextMode="MultiLine"></asp:TextBox></div>
</ContentTemplate>
</ajaxToolkit:TabPanel>
    <ajaxToolkit:TabPanel ID="TabPanel2" runat="server" HeaderText="新增鑑測簽章">
          <HeaderTemplate>
        新增鑑測簽章
    </HeaderTemplate>
<ContentTemplate>
    <div ID="div_out">
        <div id="div_left">
             <asp:Label ID="Label1b" runat="server" Font-Names="標楷體" Font-Size="X-Large" Text="新增鑑測站簽章：" Font-Bold="True" ForeColor="Blue"></asp:Label>
            <asp:Label ID="Label2b" runat="server" Font-Names="標楷體" Font-Size="X-Large"></asp:Label>
            
            
            <br /><br /><br />
   <asp:Button ID="Button5" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue" Height="28px" OnClick="Button5_Click1" style="cursor:pointer" Text="刷新列表" />
            
            
            <br />
            
            
            <%--<asp:Label ID="Label4" runat="server" Font-Names="標楷體" Font-Size="Smaller" ForeColor="White"></asp:Label>--%>
        </div>
        <div id="div_right">
             <asp:Label ID="Label23" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="#FF3300">簽章範例：</asp:Label>
    <br />
    <asp:Image ID="Image4" runat="server" Height="70px" Width="210px" />
        </div>
    </div>

    
    <br /><br /><br /><br /><br /><br />
            
            
            
            
            
            <div style="background-color:#82FF82 ;border-style:double;">
            <br />
            <br />
            <asp:Label ID="Label3b" runat="server" Font-Names="標楷體" Font-Size="Large"><b>目前使用鑑測官簽章：</b></asp:Label>
&nbsp;&nbsp;<asp:Image ID="Image1b" runat="server" Height="90px" Width="270px" />
                &nbsp;<asp:Label ID="Label7a" runat="server" Font-Names="標楷體" Font-Size="Large"></asp:Label>
                <asp:Label ID="Label7b" runat="server" Font-Names="標楷體" Font-Size="Large"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
               
            <asp:Label ID="Label5b" runat="server" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue" Font-Bold="True" >新增鑑測官簽章：</asp:Label>
                <asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue"></asp:Label>
                <br />
                <asp:Label ID="Label5b0" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">簽章啟用日期：</asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="9" Columns="26"></asp:TextBox>
                <br /><br />
                <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">(1)簽章單位：</asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="12" Columns="30"></asp:TextBox><b style="color:blue;font-family:DFKai-SB;font-size:20px">(上限12個字)</b>
                <br /><br />
                <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">(2)簽章職銜：</asp:Label>
                <asp:TextBox ID="TextBox4" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="12" Columns="30"></asp:TextBox><b style="color:blue;font-family:DFKai-SB;font-size:20px">(上限12個字)</b>
                <br /><br />
                <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">(3)簽章姓名：</asp:Label>
                <asp:TextBox ID="TextBox5" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="6" Columns="30"></asp:TextBox><b style="color:blue;font-family:DFKai-SB;font-size:20px">(上限6個字)</b>
                
            <br /><br />
                <asp:Button ID="Button2" runat="server" Font-Names="標楷體" Font-Size="Large" Height="28px" Text="新增簽章" OnClick="Button2_Click1" ForeColor="Red" Font-Bold="True" style="cursor:pointer" />
                    
            <br />
            <br />
            
                </div>
            <br />
            <br />
            
            <div style="background-color:#30FFFF ;border-style:double;">
            <br />
            <br />
            <asp:Label ID="Label4b" runat="server" Font-Names="標楷體" Font-Size="Large"><b>目前使用鑑測主任簽章：</b></asp:Label>
            <asp:Image ID="Image2b" runat="server" Height="90px" Width="270px" />
&nbsp;<asp:Label ID="Label8a" runat="server" Font-Names="標楷體" Font-Size="Large"></asp:Label>
                <asp:Label ID="Label8b" runat="server" Font-Names="標楷體" Font-Size="Large"></asp:Label>
            <br />
            <br />
            <br />
            <asp:Label ID="Label6b" runat="server" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue" Font-Bold="True" >新增鑑測主任簽章：</asp:Label>
                <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue"></asp:Label>
                <br />
                <asp:Label ID="Label5b1" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">簽章啟用日期：</asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="9" Columns="26"></asp:TextBox>
            <br /><br />
                <asp:Label ID="Label20" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">(1)簽章單位：</asp:Label>
                <asp:TextBox ID="TextBox6" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="12" Columns="30"></asp:TextBox><b style="color:blue;font-family:DFKai-SB;font-size:20px">(上限12個字)</b>
                <br /><br />
                <asp:Label ID="Label21" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">(2)簽章職銜：</asp:Label>
                <asp:TextBox ID="TextBox7" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="12" Columns="30"></asp:TextBox><b style="color:blue;font-family:DFKai-SB;font-size:20px">(上限12個字)</b>
                <br /><br />
                <asp:Label ID="Label22" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">(3)簽章姓名：</asp:Label>
                <asp:TextBox ID="TextBox8" runat="server" Font-Names="標楷體" Font-Size="Large" MaxLength="6" Columns="30"></asp:TextBox><b style="color:blue;font-family:DFKai-SB;font-size:20px">(上限6個字)</b>
                
            <br /><br />
                <asp:Button ID="Button3b" runat="server" Font-Names="標楷體" Font-Size="Large" Height="28px" Text="新增簽章" OnClick="Button3b_Click1" ForeColor="Red" Font-Bold="True" style="cursor:pointer" />
                <br />
                <br />
                <br />
                </div>
    </ContentTemplate>
    </ajaxToolkit:TabPanel>
    
    <ajaxToolkit:TabPanel ID="TabPanel3" runat="server" HeaderText="簽章查詢維護">
        <HeaderTemplate>
            簽章查詢維護
        </HeaderTemplate>
        
        <ContentTemplate>
            <asp:Label ID="Label5" runat="server" Text="簽章查詢維護：" Font-Names="標楷體" Font-Size="X-Large" ForeColor="Blue" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label6" runat="server" Font-Names="標楷體" Font-Size="X-Large" ForeColor="Black"></asp:Label>
            <%--<asp:Label ID="Label7" runat="server" Font-Size="Smaller" ForeColor="White"></asp:Label><asp:Label ID="Label_Acc" runat="server" Font-Size="Smaller" ForeColor="White"></asp:Label>--%>
            <br />
            <br />
            <asp:Button ID="Button3" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue" Text="刷新列表" OnClick="Button3_Click" style="cursor:pointer" />
            <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Blue">(資料更新後請&quot;刷新列表&quot;)</asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button4" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Red" Text="刪除資料" OnClick="Button4_Click" style="cursor:pointer" Visible="False" />
            <br />
            <br />
            <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Names="標楷體" Font-Size="Large" ForeColor="Black">鑑測簽章列表：</asp:Label>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableModelValidation="True" AllowPaging="True" AllowSorting="True" Font-Size="Larger">
               
                <Columns>
                     <asp:BoundField DataField="sid" HeaderText="sid" InsertVisible="False" ReadOnly="True"  />
                    <asp:BoundField DataField="start_date" HeaderText="啟用日期"  />
                     <%--<asp:BoundField DataField="end_date" HeaderText="結束日期" SortExpression="end_date" />--%>
                    <asp:BoundField DataField="rank" HeaderText="簽章項目"  />
                    <asp:BoundField DataField="sing_unit" HeaderText="簽章單位"  />
                    <asp:BoundField DataField="sing_rank" HeaderText="簽章職銜"  />
                    <asp:BoundField DataField="sing_name" HeaderText="簽章姓名"  />
                    <asp:TemplateField HeaderText="簽章圖片(點擊放大)" >
            <HeaderTemplate><b style="color:blue">簽章圖片(點擊圖片放大)</b></HeaderTemplate>
            <ItemTemplate>
                <img src='data:image/jpg;base64,<%# Eval("img_byte") != System.DBNull.Value ? Convert.ToBase64String((byte[])Eval("img_byte")) : string.Empty %>' alt="image" height="60" width="180" style="cursor:pointer" title="點擊圖片放大(再點一下即回復)" 
                    onclick="if (this.height == 60 & this.width == 180) 
                    {this.width=this.width*2;this.height=this.height*2}
            else 
                    {this.width=this.width/2;this.height=this.height/2}">
            </ItemTemplate>
        </asp:TemplateField>

                    <asp:TemplateField>            
            <ItemTemplate>
            <input type="button" id="EditSch" value="更新簽章" style="cursor:pointer;font-size:larger;color:blue;font-weight:900" />
            </ItemTemplate>
            </asp:TemplateField>

                </Columns>
               
            </asp:GridView>
            <asp:HiddenField ID="hf_Center_code_SQL" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MainDB %>" SelectCommand="SELECT sid, (CASE WHEN (rank_code) = '1' THEN '鑑測官' WHEN (rank_code) = '2' THEN '鑑測主任' ELSE '' END) AS 'rank', center_code,(SELECT CONVERT(VARCHAR(3),CONVERT(VARCHAR(4),start_date,20) - 1911) + '/' +
        SUBSTRING(CONVERT(VARCHAR(10),start_date,20),6,2) + '/' +
        SUBSTRING(CONVERT(VARCHAR(10),start_date,20),9,2))start_date, (SELECT CONVERT(VARCHAR(3),CONVERT(VARCHAR(4),end_date,20) - 1911) + '/' +
        SUBSTRING(CONVERT(VARCHAR(10),end_date,20),6,2) + '/' +
        SUBSTRING(CONVERT(VARCHAR(10),end_date,20),9,2))end_date, img_byte,sing_unit,sing_rank,sing_name FROM Center_Seal WHERE (center_code = @center_code) order by rank_code,sid desc" OnSelecting="SqlDataSource1_Selecting">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hf_Center_code_SQL" Name="center_code" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            </ContentTemplate>
    </ajaxToolkit:TabPanel>
       
</ajaxToolkit:TabContainer>
    
</asp:Content>

