<%--
  Created by IntelliJ IDEA.
  User: gsb
  Date: 2019/11/22
  Time: 17:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>字典定义</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .layui-form-label{width:100px;}
        .layui-input-block{margin-left:130px;}
        .layui-disabled, .layui-disabled:hover{color: #797979 !important;}
        .ztree *{
            font-size: 11pt!important;
        }
        #questionTree li{
            border-bottom:1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor:pointer;
            border-radius: 3px;
        }
        .select{
            background: #c7e1ff;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
</head>
<body>
<div class="layui-fluid" id="LAY-app-message">
    <input type="hidden" id="sortId">
    <div class="layui-row ">
        <div class="layui-lf" style="width:250px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                    <ul id="questionTree"  style="overflow:auto;height:100%">
                        <li class="select" url="/planTtemplate/planType">计划类别</li>
                        <li url="/planTtemplate/planLevel">计划级次</li>
                        <li url="/planTtemplate/planStage">计划阶段</li>
                        <li url="/planTtemplate/ctrlLevel">控制级别</li>
                    </ul>

                </div>
            </div>
        </div>
        <div class="layui-rt " style="width:calc(100% - 250px);float:left">
            <div class="layui-card rightHeight" style="">
                <iframe src="/planTtemplate/planType" style="width:100%;height: 100%" frameborder="0"></iframe>
            </div>
        </div>
    </div>
    <script id="toolbar" type="text/html" lay-filter="btn">
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="add" lay-event="add">新建</button>
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm del" id="del"  lay-event="del">删除</button>
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm import" id="import" lay-event="import">导入</button>
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm import" id="outport" lay-event="outport">导出</button>
    </script>
    <script id="barOperation" type="text/html" lay-filter="toolBtn">
        <button type="button" class="layui-btn  layui-btn-xs"  lay-event="edit">编辑</button>
        <button type="button" class="layui-btn  layui-btn-xs layui-btn-danger "  lay-event="del">删除</button>
    </script>
</div>
</body>
</html>
<script>
    var height = $(window).height()
    $('#leftHeight').height(height-30)
    $('.rightHeight').height(height-30)
    var type = $.GetRequest().type;
    var dataType = $.GetRequest().dataType;
    var shitiType=''
    $('#questionTree li').click(function(){
        var url = $(this).attr('url');
        $(this).addClass('select').siblings().removeClass('select')
        $('iframe').attr('src',url)
    })


    layui.use(['table','layer','laydate','form','element','eleTree'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var laydate = layui.laydate;
        var eleTree = layui.eleTree;
        var element = layui.element;

        form.render();

    })
</script>