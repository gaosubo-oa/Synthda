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
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
      <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
      <script src="../js/jquery/jquery.cookie.js"></script>
  </head>
  <script >
	  $.ajax({
          type : "post",
          url : "sys/getInterfaceInfo",
          dataType:'json',
          success : function(data) {
              if(data.flag){
                  var obj = data.object;
                  var url = 'zh_CN';
                  var language = $.cookie('language') || 'zh_CN';
                  switch (obj.template){
                      case '1':
                          url ="defaultIndex2";
                          break;
					  case '2':
                          url ="defaultIndex";
                          break;
                      case '3':
                          url ="defaultIndex3";
                          break;
                      case '4':
                          url ="defaultIndex4";
                          break;
                      case '5':
                          url ="defaultIndex5";
                          break;
                      case '6':
                      url ="defaultIndex6";
                          break;
                      case '9':
                          url ="defaultIndex9";
                          break;
                      case '10':
                          url ="defaultIndex10";
                          break;
                      default:
                          url ="defaultIndex2";
                  }
				  
            /*      window.location.href =url+"?lang="+language;*/
                  window.location.href ="/xoa?url="+url+"&lang="+language;
              }
		  }
	  })
  </script>
  <body>
  </body>
</html>
