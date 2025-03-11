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

<title><fmt:message code="file.th.newfile"/></title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<style type="text/css">
*{
	margin: 0;
	padding: 0;
}
h1 {
	font-size: 18px;
	text-align: center;
}

table {
	margin: 0 auto;
	border-color: #ddd;
}

table tr td {
	padding: 5px 5px;
	font-size: 14px;
	border-color: #ddd;
}

table tr td input:not (#fh ){
	width: 80%;
}

.fh {
	width: 70px;
	height: 28px;
	line-height: 28px;
	margin: 0 auto;
	background: url("../img/file/icon_confirm.png") no-repeat;
	background-size: 100% 100%;
}
</style>
<script type="text/javascript" src="js/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">

     function closeCurrentWindow(){
 
      var sortNo=$('#fileNoid').val();
      var sortName=$('#fileNameid').val();
        
         $.ajax({
                url: "${pageContext.request.contextPath }/file/add",
                Type: "POST",
                data:{"sortNo":sortNo,"sortName":sortName,"sortType":'5'},
                success:function (data){
                 if(data=="1"){
                  window.opener.location.href = window.opener.location.href;     
 		          if (window.opener.progressWindow)     
 		          {         
 		            window.opener.progressWindow.close();     
 		          }      
 		           window.close();
                  } 
                }
           });   
 	} 
</script>
</head>
<body>
	<h1><fmt:message code="file.th.newfile"/></h1>
	<form id="form1" name="form1" >
		<table border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse;" width="50%">
			<tr>
				<td width="30%"><fmt:message code="file.th.Sort"/></td>
				<td width="70%"><input id="fileNoid" name="sortNo" type="text" />
				</td>
			</tr>
			<tr>
				<td width="30%"><fmt:message code="file.th.filename"/></td>
				<td width="70%"><input id="fileNameid" name="sortName"
					type="text" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="fh" id="fh" onclick="closeCurrentWindow()"><span style="margin-left: 33px;"><fmt:message code="main.th.confirm"/></span></div>
					<%--<input id="fh" type="button" value="确认" onclick="closeCurrentWindow()" />--%>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
