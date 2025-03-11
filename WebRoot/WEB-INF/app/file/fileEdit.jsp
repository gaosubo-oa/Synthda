<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
body {
	background-color: #D6E4EF;
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

#fh {
	display: block;
	margin: 0 auto;
	outline: none;
	border-radius: 3px;
	border: none;
	background-color: #9be9fc;
	padding: 2px 5px;
}
</style>
<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
<script type="text/javascript">


    function closeCurrentWindow(){
 	  var sortNo=$('#sortno').val();
      var sortName=$('#sortname').val();
      var sortid=$('#sortid').val();
      $.ajax({
                url: "${pageContext.request.contextPath }/file/update",
                Type: "POST",
                data:{"sortNo":sortNo,"sortName":sortName,"sortId":sortid},
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
	<h1><fmt:message code="file.th.fileEdit"/></h1>
	<form id="form1">
		<table border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse;" width="50%">
			<tr>
				<td width="30%"><fmt:message code="file.th.Sort"/>:</td>
				<td width="70%"><input id="sortno" name="sortNo" type="text"
					value="${sortno}" />
				</td>
			</tr>
			<tr>
				<td width="30%"><fmt:message code="file.th.filename"/>：</td>
				<td width="70%"><input id="sortname" name="sortName"
					type="text" value="${sortname }" />
				</td>
			</tr>
			<tr>
				<td colspan="2"><input id="fh" type="button" value="<fmt:message code="global.lang.ok"/>"
					onclick="closeCurrentWindow()" />
				</td>
			</tr>
		
			<input id="sortid" type="hidden" name="sortId" value="${sortid}" />
		</table>
	</form>
</body>
</html>