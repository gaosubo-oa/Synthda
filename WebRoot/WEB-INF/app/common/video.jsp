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
<head lang="en">
    <meta charset="UTF-8">
    <title>查看视频</title>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css" />
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1" />
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
</head>
<body>
    <video width="630px" height="360px" controls="" autoplay="">
        <source src="" type="video/mp4" class="videos">
        <source src="http://www.runoob.com/try/movie.ogg" type="video/ogg">
        <source src="http://www.runoob.com/try/movie.webm" type="video/webm">
    </video>
    <script>
        $(function(){
            var atturl = location.href.split('?videoatturlsplit=')[1];
            if(location.href.indexOf('/netdisk') > -1){
                $('.videos').attr('src',atturl);
            }else{
                $('.videos').attr('src','/download?'+atturl)
            }
        })

    </script>
</body>
</html>
