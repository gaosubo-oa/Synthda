<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>企业微信首页入口-组织</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script src="../../js/H5/dingtalk.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        header {
            background-color: #5077aa;
            height: 0.85rem;
            align-items: center;
            font-size: 0.28rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            text-align: center;
            line-height: 0.85rem;
            position: fixed;
            width: 100%;
            z-index: 1;
        }
        .hd{
            height: 0.85rem;
        }
        #con{
            /*text-align: right;*/
            /*margin-right: 2rem;*/
            font-size: 0.33rem;
            /*margin-top: 1rem;*/
        }
        #con p{
            padding-top: .2rem;
        }
        #con p input{
            position: relative;
            bottom: .03rem;
            left: .23rem;
        }
        #con p label span{
            display: inline-block;
            width: 80%;
            text-align: right;
        }
        .ent{
            width: 1.5rem;
            height: .65rem;
            background-color: #5077aa;
            text-align: center;
            line-height: .65rem;
            color: #fff;
            font-size: .28rem;
            border-radius: .16rem;
            margin: .7rem auto;
        }
        #adders{
            color: #fff;
        }
    </style>
</head>
<body>
<header>

    <span><fmt:message code="label.replace.name" /></span>

</header>
<div class="hd"></div>
<div id="con">
    <a href="https://open.work.weixin.qq.com/wwopen/sso/3rd_qrConnect?appid=<%=corpId%>&redirect_uri=http%3a%2f%2f192.168.0.138%3a8080&usertype=member">
        <img src="//rescdn.qqmail.com/node/ww/wwopenmng/style/images/independent/brand/300x40_blue$cecbbc4e.png" srcset="//rescdn.qqmail.com/node/ww/wwopenmng/style/images/independent/brand/300x40_blue_2x$c22687e4.png 2x" alt="企业微信登录">
    </a>
</div>

</body>
<script>
    var corpId = '<%=corpId%>';



</script>
</html>