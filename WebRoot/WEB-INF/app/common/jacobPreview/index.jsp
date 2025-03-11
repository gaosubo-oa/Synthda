<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2020/9/11
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/baseTwo.js?20201110.4"></script>
    <script type="text/javascript" src="/js/base/base.js?20210111.1"></script>
    <script type="text/javascript" src="/js/common/watermark.js?20230410.2"></script>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }
        body {
            margin: 0;
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 14px;
            line-height: 20px;
            color: #333;
            background-color: #e6e6e6;
        }
        .header{
            position: fixed;
            background: #2b579a;
            color: #e6e6e6;
            height: 50px;
            line-height: 50px;
            top: 0;
            right: 0;
            left: 0;
            z-index: 1030;
        }
        .headerTitle{
            margin-left: 60px;
            font-size: 18px;
        }
        .icon-img{
            width: 30px;
            position: absolute;
            top: 10px;
            left: 14px;
        }
        .content{
            background-color: #e6e6e6;
            padding-top: 75px;
            padding-right: 20px;
            padding-left: 20px;
            padding-bottom: 10px;
        }
        .contentPreview{
            line-height: normal;
            margin-right: auto;
            margin-left: auto;
            margin-bottom: 15px;
            max-width: 795px;
            min-height: calc(100% - 100px);
            border-radius: 1px;
            -moz-box-shadow: 0 0 10px 5px #888;
            -webkit-box-shadow: 0 0 10px 5px #888;
            box-shadow: 0 0 10px 5px #888;
            background-color: #FFF;
        }
        .contentBox{
            position: relative;
            max-width: 94%;
            word-wrap: break-word;
            word-break: break-all;
            margin: 0px auto;
            padding-top: 3%;
            padding-bottom: 10%;
            z-index: 0;
        }
        .contentBox table,.contentBox img{
            width: 100%;
            max-width: 100%;
        }
    </style>
</head>
<body>
<div class="header">
    <img class="icon-img" src="/img/office/office-word.png?20210201.1" >
    <div class="headerTitle">
        <span class="headerTitleText"></span>
        <span class="subText" style="font-family: Microsoft yahei; font-weight: bolder; font-size: 12pt; color:red; display: none;">机密级★</span>
    </div>
</div>
<div class="content">
    <div class="contentPreview">
        <div class="contentBox">

        </div>
    </div>
</div>
<script>
    var module = '';
    var aid = '';
    var diskId = '';
    var path = '';
    if(location.search&&location.search.split('?AID=')[1]){
        aid = location.search.split('?AID=')[1].split('&')[0];
        module = location.search.split('?AID=')[1].split('&MODULE=')[1];
    }

    diskId = $.GetRequest().diskId;

    //如果获取到的不是文件名称 请改成文件名成，因为decodeURI解码有时候浏览器识别不到
    if (window.name != undefined && window.name != ''){
        path = window.name
    }
    else {
        path = decodeURI($.GetRequest().path);
    }

    if(diskId!=undefined&&diskId!=''&&path!=undefined&&path != ''){
        var data = {
            path: path,
            diskId: diskId,
            type: 'preview'
        }
        url = "/netdisk/wordToHtmlPrivew"
    }else {
        var data = {
            module: module,
            aid: aid
        }
        url = "/wordToHtmlPrivew"
    }

    var status = false
    var myajax = $.ajax({
        url: url,
        data: data,
        type: "post",
        async:false,
        success: function(res) {
            var htmlStr = '<p>文档加载失败！</p>';
            if(res.flag){
                status = true
                var name = res.data.attachName
                htmlStr = res.data.htmlWordContent;
                $('.headerTitleText').html(name);
                $('title').html('Word 文档预览 - '+name);
                $('.contentBox').html(htmlStr);
            }else{
                // alert('文档加载失败！');
                $('title').html('Word 文档预览 ');
            }
            var img = $('img');
            if(img.length > 0){
                imgReloadWidth(img);
            }

        }
    });
    //判断页面是否需要显示机密级字样
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 1) {
                $(".subText").show()
            }else {
                $(".subText").hide()
            }
        }
    })
$.when(myajax).done(function(){
    if(status){
        window.onresize=function(){
            watermark();
        }
    }
})
</script>

</body>
</html>
