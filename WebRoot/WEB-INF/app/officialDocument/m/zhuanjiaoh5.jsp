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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title><fmt:message code="document.th.nextStep" /></title>
    <link rel="stylesheet" href="../../css/workflow/work/m/style.css">
    <script src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/template.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/mustache.min.js"></script>
    <script src="../../js/base/base.js"></script>
    <style>
        body{
            font-size: 12px;
            font-family: "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Hiragino Sans GB", "Heiti SC", "Microsoft YaHei", "WenQuanYi Micro Hei", sans-serif;
        }
        .imgbox{
            width: 150px;
            height: 150px;
            margin: 0px auto;
            margin-top: 120px;
            margin-bottom: 10px;
        }
        .pclass span{
            color: #999;
            height: 30px;
            display: inline-block;
            line-height: 30px;
            font-size: 15px;
            text-align: center;
            width: 100%;
        }
        .pclass .zj{
            color: #333;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <div class="imgbox">
        <img src="/img/workflow/work/workformh5/beijingtu.png" alt="">
    </div>
    <div class="pclass">
        <span class="zj">转交成功</span>
        <span>2秒后跳转</span>
    </div>
<script>
    //封装的方法
    $.extend({
        getQueryString:function(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        }
    });
    //使用
    var backType = $.getQueryString("backType");
    $(function(){
        setTimeout(function(){
            if(backType==1){
                window.location.href='/document/getDispatchh5'
            }else if(backType==2){
                window.location.href='/document/getAgencyReceipth5'
            }else if(backType==3){
                window.location.href='/document/getSuperiorh5'
            }
        },2000)
    })
</script>
</body>
</html>