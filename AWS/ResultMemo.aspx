<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResultMemo.aspx.cs" Inherits="ResultMemo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color:#FFF0F5">
    <form id="form1" runat="server">
    <div>
        <h4>
            說明</h4>
        <span>應測數為目前該單位於本系統註冊人數</span><br />
        <span>單項實測數為時間起迄內總成績合格與不合格人數加總</span><br />
        <span>單項合格數為時間起迄內總成績合格數中該單項合格數加總</span><br />
        <span>單項合格率為時間起迄內單項合格數加總除以單項實測數</span><br />
        <span>單項總合格率為時間起迄內單項合格數加總(含男女)除以單項實測數(含男女)</span><br />
        <span>全項合格率計算分母為實測數</span><br />
        <span>總全項合格率計算分母為應測數</span>
        
    </div>
    </form>
</body>
</html>
