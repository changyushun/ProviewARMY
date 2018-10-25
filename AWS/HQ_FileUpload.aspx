<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HQ_FileUpload.aspx.cs" Inherits="HQ_FileUpload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>上傳檔案</title>
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Script/jquery-1.3.2-vsdoc2.js" ></script>
	<script type="text/javascript" src="js/swfupload.js"></script>
	<script type="text/javascript" src="js/handlers.js"></script>
	<script type="text/javascript">

	    window.onload = function() {
	    var swfu;
			    swfu = new SWFUpload({
				// Backend Settings
			    upload_url: "upload.aspx",
			    post_params: {
			    "ASPSESSID": "<%=Session.SessionID %>", "myname": $('#Label1').text()
			},
				// File Upload Settings
                file_size_limit: "4 MB",
				file_types : "*.doc;*.docx;*.pdf",
				file_types_description : "doc || pdf",
				file_upload_limit : "0",    // Zero means unlimited

				// Event Handler Settings - these functions as defined in Handlers.js
				//  The handlers are not part of SWFUpload but are part of my website and control how
				//  my website reacts to the SWFUpload events.
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,

				// Button settings
				button_image_url : "images/XPButtonNoText_160x22.png",
				button_placeholder_id : "spanButtonPlaceholder",
				button_width: 180,
				button_height: 24,
				button_text : '<span class="button">請選擇檔案<span class="buttonSmall">(4 MB Max)</span></span>',
				button_text_style: '.button { 微軟正黑體; font-size: 15px; } .buttonSmall { font-size: 10pt; }',
				button_text_top_padding: 1,
				button_text_left_padding: 5,

				// Flash Settings
				flash_url: "swfupload/swfupload.swf", // Relative to this file

				custom_settings : {
					upload_target : "divFileProgressContainer"
				},

				// Debug Settings
				debug: false
			});
		}
    
        function QueryString(name)
	    {
	        var AllVars = window.location.search.substring(1);
	        var Vars = AllVars.split("&");
	        for (i = 0; i < Vars.length; i++)
	        {
	            var Var = Vars[i].split("=");
	            if (Var[0] == name) return Var[1];
        }
	        return "";
	    }
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="filenamearea" runat="server" style="text-align:center">
    <span id="span1">檔案名稱：</span><asp:Label ID="Label1" runat="server" Text="231"></asp:Label> 
    </div>
    <div id="filearea" runat="server" style="text-align:center">
        <div id="swfu_container" style="margin: 0px 10px;">
		    <div>
				<span id="spanButtonPlaceholder"></span>
		    </div>
		    <div id="divFileProgressContainer" style="height: 75px;"></div>
		    <%--<div id="thumbnails"></div>--%>
	    </div>
    </div>
    <div style="text-align:center"><asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="return window.close();">[關閉視窗]</asp:LinkButton></div>
    </form>
</body>
</html>
