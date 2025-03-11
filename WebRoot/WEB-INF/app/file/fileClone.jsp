<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="/">

<title>My JSP 'fileClone.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<script type="text/javascript">
    function submit(){
    document.form1.submit();
    }
    function close(){
    window.close();
    }
    </script>
<body>
	<h1><fmt:message code="file.th.clone"/></h1>
	<form id="form1" name="form1"
		action="${pageContext.request.contextPath }/fileUpdate">
		<fmt:message code="file.th.Sort"/>: <input id="fileNoid" name="sort_no" type="text"
			value="${sort_no}" /><br> <fmt:message code="file.th.filename"/>：<input id="fileNameid"
			name="sort_name" type="text" value="${sort_name }" /><br> <input
			id="qr" type="button" value="<fmt:message code="main.th.confirm"/>" onclick="submit()" /><br> <input
			id="fh" type="button" value="<fmt:message code="notice.th.return"/>" onclick="close()" />
	</form>
</body>
</html>
