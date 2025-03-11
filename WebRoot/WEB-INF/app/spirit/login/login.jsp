<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>OA精灵</title>
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="../css/spirit/login.css" />
</head>
<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
<script src="/lib/layer/layer.js?20201106"></script>
<script type="text/javascript" src="/js/base/base.js"></script>
<script type="text/javascript" src="/js/spirit/qwebchannel.js"></script>
<script type="text/javascript">
    $(function() {
        //m_strOaUrl = "http://192.168.0.17/xoa/spirit/login?I_VER=2&USERNAME=admin"
        var uname = $.getQueryString('USERNAME');
        var I_VER = $.getQueryString('PASSWORD');
        <%--var sessionId="${sessionId}";--%>
        //if(uname != ''){
        //	location.href = "main";
        //}
        var data = {
            username : uname
        }
        if (I_VER != "" && I_VER != null) {
            data["password"] = I_VER;
        } else {
            data["password"] = "";
        }
        login();
        function login() {
            $.post("/login", data, function(result) {
                if (result.flag == true) {
                    new QWebChannel(qt.webChannelTransport, function(channel) {
                        var content = channel.objects.interface;
                        content.xoa_sms("${gim_port}","${gim_ip}", "GIM_IP");
                        content.xoa_sms(result.msg,"", "JSESSIONID");
                        content.xoa_sms(JSON.stringify(result.object),result.object.uid,"userId");
                    });
                    <%--window.external.OA_SMS("","${gim_ip}", "GIM_IP");--%>
                    <%--window.external.OA_SMS("",result.object.uid, "userId");--%>
                    location.href = "main";
                } else {
                    new QWebChannel(qt.webChannelTransport, function(channel) {
                        var content = channel.objects.interface;
                        content.xoa_sms("error","error","error");
                    });
                }
            });
        }

        $("#login").click(function() {
            new QWebChannel(qt.webChannelTransport, function(channel) {
                var content = channel.objects.foo;
                content.someMethod("ceshi");
                console.log("this is run ")
            })
        })
    });
</script>

<body class="bodycolor" scroll="no" topmargin="5">
<div align="center">
	<form name="form1" method="post" >
		<table class="TableBlock" width="90%" align="center">
			<tr class="TableHeader">
				<td align="center">登录OA精灵</td>
			</tr>
			<tr class="TableControl">
				<td class="small"><img src="../img/spirit/login_user.gif"
									   align="absmiddle"><b>用户名：</b> <input type="text"
																			class="SmallInput" name="UNAME" size="10" value="admin"><br>
					<img src="../img/spirit/login_pass.gif" align="absmiddle"><b>密
						码：</b> <input type="password" class="SmallInput" name="PASSWORD"
									  size="10" value="">
				</td>
			</tr>
			<tr class="TableControl">
				<td align="center"><input style="width:40px;" type="bottom"
										  id="login" value="登录" />
				</td>
			</tr>

		</table>
	</form>
</div>


</body>
</html>