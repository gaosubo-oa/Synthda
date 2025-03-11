<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-02
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>项目信息主页面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body{
            height: 100%;
            background: #fff;
        }
        hr{
            margin: 5px 0px;
        }
        .layui-input-block{
            margin-left: 150px;
        }
        .layui-form-label{
            width: 120px;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0px;
        }
        .layui-table-tool{
            min-height: 40px;
            padding: 5px 15px;
        }
        .layui-form-item{
            width: 49%;
            margin-bottom: 8px;
        }
        .newAndEdit{
            display: flex;
        }
        .layui-layer-btn{
            text-align: center;
        }
        .openFile input[type=file]{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        .layui-btn-container{
            position: relative;
        }
        .query .layui-form-item{
            width: 13%;
            margin-bottom: -5px;
            margin-top: 5px;
        }
        .query .layui-form-label{
            width: 60px;
        }
        .query .layui-input-block{
            margin-left: 90px;
        }
        .inputs .layui-form-select .layui-input{
            height: 30px; !important;
        }
        .layui-tab-item{
            height: 100%;
        }
        .layui-tab{
            margin:0px
        }
    </style>
    
    <script type="text/javascript">
        var funcUrl = location.pathname;
        var authorityObject = null;
        if (funcUrl) {
            $.ajax({
                type: 'GET',
                url: '/plcPriv/findPermissions',
                data: {
                    funcUrl: funcUrl
                },
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.flag) {
                        if (res.object && res.object.length > 0) {
                            authorityObject = {}
                            res.object.forEach(function (item) {
                                authorityObject[item] = item;
                            });
                        }
                    }
                },
                error: function () {
                    
                }
            });
        }
    </script>
    
</head>
<body>
<div style="padding-top: 10px">
    <%--<div class="headImg" style="padding-top: 10px">
        <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span  class="headTitle" style="margin-left: 10px">项目信息</span></span>
    </div>
    <hr>--%>
    <%--tab页签--%>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this" projectStatus="">项目</li>
            <li projectStatus="0">在建</li>
            <li projectStatus="2">竣工</li>
            <li projectStatus="1">收尾</li>
            <li projectStatus="3">关闭</li>
        </ul>
        <div class="layui-tab-content">
                <iframe id="iframeName" src="/ProjectInfo/goProjectInfo" style="width:100%;height: 100%" frameborder="0"></iframe>
        </div>
    </div>
</div>

<script>
    var height=$(window).height()-115
    $('.layui-tab-content').height(height)
    $('.layui-tab-content').css('padding','10px 0px')
    layui.use('element', function(){
        var element = layui.element;
        //监听Tab切换，以改变地址hash值
        element.on('tab(docDemoTabBrief)', function(){
            document.getElementById('iframeName').contentWindow.location.reload(true);
        });
    });
</script>
</body>

</html>
