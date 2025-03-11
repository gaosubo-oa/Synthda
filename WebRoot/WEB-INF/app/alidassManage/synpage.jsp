<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Lims组织用户同步IDaas</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
</head>
<body>
<div>

</div>

<script type="text/javascript">
    // 获取一级父类部门
    $.ajax({
        url: '/alidaas_syn/getDepartment'
        , type: 'POST'
        , dataType: 'json'
        , data: {
            deptId: 0
        }
        , success: function(res) {
            if (res.flag) {
                console.log(res);
            }
        }
    });
</script>
</body>
</html>
