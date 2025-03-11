<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><fmt:message code="common.th.notHaveAccess" /></title><%--当前用户没有该模块的访问权限，详情请咨询管理员--%>
		<style type="text/css">
			*{margin: 0;padding: 0;}
			html,body{width: 100%;height: 100%;font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;}
			.developo{width: 100%;height: 100%;}
			.developo .text{width: 100%;position: relative;height: 100%;}
			.developo .text img{display: block;position: absolute;left: 50%;top: 50%;margin-left: -169px;margin-top: -82px;}
			div{text-align:center}

		</style>
	</head>
	<body>
		<div class="developo">
			<div class="text">
				<%--<img src="../img/common/development.png"/>--%>
					<img src="/img/common/developmentfw.png"/>

			</div>
		</div>
	</body>
</html>

