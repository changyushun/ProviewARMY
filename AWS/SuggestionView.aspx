<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SuggestionView.aspx.cs" Inherits="SuggestionView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" type="text/css" href="StyleSheet.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager> 
<ajaxToolkit:TabContainer ID="TabContainer1" runat="server" CssClass="ajax__tab_yuitabview-theme">
<ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="意見內容">
    <HeaderTemplate>
        意見內容
    </HeaderTemplate>
<ContentTemplate>
    <asp:FormView ID="FormView1" runat="server" BackColor="White" 
        BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" 
        CellSpacing="1" DataKeyNames="sid" DataSourceID="SqlDataSource1" 
        ondatabound="FormView1_DataBound" onitemcreated="FormView1_ItemCreated" 
        onload="FormView1_Load" onprerender="FormView1_PreRender">
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
        <EditItemTemplate>
            sid:
            <asp:Label ID="sidLabel1" runat="server" Text='<%# Eval("sid") %>' />
            <br />
            head:
            <asp:TextBox ID="headTextBox" runat="server" Text='<%# Bind("head") %>' />
            <br />
            text:
            <asp:TextBox ID="textTextBox" runat="server" Text='<%# Bind("text") %>' />
            <br />
            player:
            <asp:TextBox ID="playerTextBox" runat="server" Text='<%# Bind("player") %>' />
            <br />
            date:
            <asp:TextBox ID="dateTextBox" runat="server" Text='<%# Bind("date") %>' />
            <br />
            answer:
            <asp:TextBox ID="answerTextBox" runat="server" Text='<%# Bind("answer") %>' />
            <br />
            answer2:
            <asp:TextBox ID="answer2TextBox" runat="server" Text='<%# Bind("answer2") %>' />
            <br />
            answer3:
            <asp:TextBox ID="answer3TextBox" runat="server" Text='<%# Bind("answer3") %>' />
            <br />
            date_answer:
            <asp:TextBox ID="date_answerTextBox" runat="server" 
                Text='<%# Bind("date_answer") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="更新" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
        <InsertItemTemplate>
            head:
            <asp:TextBox ID="headTextBox" runat="server" Text='<%# Bind("head") %>' />
            <br />
            text:
            <asp:TextBox ID="textTextBox" runat="server" Text='<%# Bind("text") %>' />
            <br />
            player:
            <asp:TextBox ID="playerTextBox" runat="server" Text='<%# Bind("player") %>' />
            <br />
            date:
            <asp:TextBox ID="dateTextBox" runat="server" Text='<%# Bind("date") %>' />
            <br />
            answer:
            <asp:TextBox ID="answerTextBox" runat="server" Text='<%# Bind("answer") %>' />
            <br />
            answer2:
            <asp:TextBox ID="answer2TextBox" runat="server" Text='<%# Bind("answer2") %>' />
            <br />
            answer3:
            <asp:TextBox ID="answer3TextBox" runat="server" Text='<%# Bind("answer3") %>' />
            <br />
            date_answer:
            <asp:TextBox ID="date_answerTextBox" runat="server" 
                Text='<%# Bind("date_answer") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </InsertItemTemplate>
        <ItemTemplate>
            <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" 
                NavigateUrl="~/Suggestion.aspx">返回意見區列表</asp:HyperLink>
            <br />
            建立者:
            <asp:Label ID="playerLabel" runat="server" Text='<%# Bind("player") %>' />
            <br />
            建立日期:
            <asp:Label ID="dateLabel" runat="server" Text='<%# Bind("date") %>' />
            <br />
            意見標題:
            <asp:Label ID="headLabel" runat="server" Text='<%# Bind("head") %>' />
            <br />
            意見對象:
            <asp:Label ID="Label5" runat="server" Text='<%# Bind("unit_name") %>' />
            <br />
            意見內容:
            <br />
            <asp:Label ID="textLabel" runat="server" Text='<%# Bind("text") %>' />
            <br />
            <asp:Label ID="Label1" runat="server" Text="鑑測站回覆:" ForeColor="Red"></asp:Label>
            <asp:Label ID="answerLabel" runat="server" Text='<%# Bind("answer") %>'/>
            <br />
            <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="司令部回覆:"></asp:Label>
            <asp:Label ID="answer2Label" runat="server" Text='<%# Bind("answer2") %>' />
            <br />
            <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="國防部回覆:"></asp:Label>
            <asp:Label ID="answer3Label" runat="server" Text='<%# Bind("answer3") %>' />
            <br />
            <asp:Label ID="Label4" runat="server" ForeColor="Blue" Text="回覆時間:"></asp:Label>
            <asp:Label ID="date_answerLabel" runat="server" 
                Text='<%# Bind("date_answer") %>' />
            <br />
        </ItemTemplate>
        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
        <EditRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:MainDB %>" 
        SelectCommand="select s.sid,s.head,s.text,s.player,s.date,s.answer,s.answer2,s.answer3,s.date_answer ,(select unit_name from Unit_Complaint u where u.unit_code = s.acc) as unit_name from Suggestion s where s.sid = @sid and s.player = @player">
        <%--SelectCommand="SELECT [sid], [head], [text], [player], [date], [answer], [answer2], [answer3], [date_answer] FROM [Suggestion] WHERE (([sid] = @sid) AND ([player] = @player))"--%>
        <SelectParameters>
            <asp:Parameter Name="sid" Type="Int32" />
            <asp:Parameter Name="player" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</ContentTemplate>
</ajaxToolkit:TabPanel>
</ajaxToolkit:TabContainer>
</asp:Content>

