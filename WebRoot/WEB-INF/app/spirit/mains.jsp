<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- saved from url=(0058)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5.html -->
<html>
<!--<![endif]-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>OA精灵</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="../css/spirit/ispirit_index.css">
	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="../js/spirit/sys_function_7a682d434e.js"></script>
	<%--<script type="text/javascript" src="../js/spirit/ispirit_index.js"></script>--%>
	<script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
	<script>
		var MYOA_JS_SERVER = "${paraName}";
		var MYOA_STATIC_SERVER = "${paraValue}";
		var bIMLogin = false;
		var i_ver = "2";
		var myoa_ver = "8.14.160415";
		var gz_postfix = "";
		var static_server = "";
		var myoa_use_os_browser = "";
		var sms_mon_ref = 30000;
		var sms_mon_flag = "";
		var online_mon_ref = 120000;
		var sms_on = "1";
		var call_sound = "1";
		var cur_uid = "${users.uid}";
		var cur_username = "${users.userName}";
		var cur_pwd = "${users.uid}";
		var cur_sid = "aaice7qefidm31ika2ig2jti10";
		var my_status = "${users.uid}";
		var on_status = "1";
		var upload_max_filesize = "2000";
		var is_un = "${users.uid}";
		var is_group = "${users.uid}";
		var group_no_show_dept = "";
		var group_no_op_dept = "";
		var priv_id_str = "1,";
		var window_caption = MYOA_STATIC_SERVER;
		var gbt_new = "1";
		var sns_name = "企业社区";
		var check_sms = "1";
		var online_title = "共 20 人，%s 人在线";
		var new_email_title = "点击查看新邮件";
		var new_sms_html = "<a href='#' onclick='javascript:show_sms(2);' title='点击查看新消息'><img src='/static/images/sms1.gif'border=0 height=10> 新消息</a>";
		var new_sms_sound_html = "<object id='sms_sound' classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='/static/js/swflash.cab' width='0' height='0'><param name='movie' value='/static/wav/1.swf'><param name=quality value=high><embed id='sms_sound' src='/static/wav/1.swf' width='0' height='0' quality='autohigh' wmode='opaque' type='application/x-shockwave-flash' plugspace='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash'></embed></object>";
		var my_func_id_str = "1,3,42,643,644,634,4,147,148,7,8,9,10,16,11,130,5,131,132,256,229,182,183,194,637,134,37,135,136,226,253,254,255,536,24,196,105,119,80,96,97,98,114,126,179,607,539,251,127,238,128,85,86,87,88,89,137,138,222,90,91,92,152,93,94,95,118,237,108,109,110,112,51,53,54,153,217,150,239,240,218,219,43,17,18,19,15,36,70,76,77,115,116,185,235,535,59,133,64,257,2,74,12,68,66,67,13,14,40,41,44,75,27,60,61,481,482,483,484,485,486,487,488,489,490,491,492,120,494,495,496,497,498,499,500,501,502,503,505,504,26,506,507,508,515,537,122,123,124,628,125,630,631,632,633,55,514,509,29,28,129,510,511,224,39,512,513,252,230,231,232,629,233,234,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,200,202,201,203,204,205,206,207,208,209,65,187,186,188,189,190,191,606,192,193,221,550,551,73,62,63,34,532,548,640,641,642,549,601,600,602,603,604,46,21,22,227,56,30,31,33,32,605,57,609,103,146,107,197,228,58,538,151,6,534,69,71,72,223,639,225,236,78,178,104,121,149,84,99,100,533,101,113,198,540,626,638,38,32,33,56,";
		var cur_time = "1492504726";

		function doQtFunc(url,type,name) {
			new QWebChannel(qt.webChannelTransport, function(channel) {
				var content = channel.objects.interface;
				content.xoa_sms(url,name,"web_url");
			});
		}
        function doQtPers(e){
            var url = e;
            //alert(111111)
            new QWebChannel(qt.webChannelTransport, function(channel) {
                var content = channel.objects.interface;
                content.xoa_sms(url, "", "SERALARMSUPDATE");
            });
        }
		function doQtDep(uid,datas) {
			 new QWebChannel(qt.webChannelTransport, function(channel) {
				var content = channel.objects.interface;
				 content.xoa_sms(uid,datas,"SEND_MSG");
			 });
		}
		function doQtPer(data,uid){
			new QWebChannel(qt.webChannelTransport, function(channel) {
				var content = channel.objects.interface;
				content.xoa_sms(uid,data,"SEND_MSG");
			});
		}

		function qtGetuserInfo() {
            new QWebChannel(qt.webChannelTransport, function (channel) {
                var content = channel.objects.interface;
                content.xoa_sms("true", ${users.uid}, "userId");
            });
        }
        $(function(){
            qtGetuserInfo();
        })

	</script>
	<style type="text/css">
		body {
			width: 100%;
			height: 100%;
		}
		#ipanel_container{
			border:none;
	}
	</style>
</head>

<body>
	<div id="ipanel_container" style="height: 100%!important;">
		<iframe id="ipanel" name="ipanel" src="dh" allowtransparency="true" border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0" style="width:100%;height:100%;"></iframe>
	</div>
</body>
</html>