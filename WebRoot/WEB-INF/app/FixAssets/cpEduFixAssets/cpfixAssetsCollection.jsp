<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>资产汇总</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>


    .mbox {
        padding: 8px;
    }

    .items {
        background-color: #f2f2f2;
        text-align: center;
        height: 30px;
        line-height: 30px;
    }

    .layui-form-item {
        margin-bottom: 5px;
    }

    .inpWhit {
        width: 300px;
    }

    /*下拉按钮*/
    .dropbtn {
        text-align: left;
        background-color: #009688;
        color: white;
        font-size: 12px;
        border: none;
        cursor: pointer;
        height: 30px;
        width: 90px;
    }

    /* 容器 <div> - 需要定位下拉内容 */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    /* 下拉内容 (默认隐藏) */
    .dropdown-content {
        margin-left: 0px;
        display: none;
        position: absolute;
        top: 32px;
        background-color: #fff;
        min-width: 115px;
        text-align: center;
        line-height: 36px;
        padding-top: 10px;
        box-shadow: 0px 8px 12px 0px rgba(0, 0, 0, 0.2);
        z-index: 999999999;
    }

    .licon {
        display: inline-block;
        width: 0;
        height: 0;
        border-style: dashed;
        border-color: transparent;
        position: absolute;
        right: 6px;
        top: 52%;
        margin-top: -3px;
        cursor: pointer;
        border-width: 6px;
        border-top-color: #fff;
        border-top-style: solid;
        transition: all .3s;
        -webkit-transition: all .3s;
    }

    * {
        font-family: "Microsoft Yahei" !important;
    }

    b {
        color: red;
    }

    /* 下拉菜单的链接 */
    .dropdown-content a {
        color: black;
        /*padding: 12px 16px;*/
        text-decoration: none;
        display: block;
    }

    /*!* 在鼠标移上去后显示下拉菜单 *!*/
    .icon-on {
        margin-top: -9px;
        -webkit-transform: rotate(180deg);
        transform: rotate(180deg);
    }

    .layui-table {
        width: 100% !important;
    }
    .bg{
        background: #f2f2f2;
    }

    nav div{
        float: left !important;
        margin: 15px;
    }
    nav{
        height: 50px;
        border-bottom: 1px solid #cfdbe2;
        background-color: #fafbfc;
        border-radius: 0;
    }
    .time{
        width: 90px;
        margin-left: 0px;
        display: inline;
    }
    .input{
        margin-left: 130px;
    }
    .layui-table-body{overflow-x: hidden;}

</style>
<body>

<div class="mbox">
    <form class="layui-form">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul  class="layui-tab-title" lay-filter="searchul">
                <li class="layui-this" value="0">资产汇总</li>
            </ul>
        </div>
            <div>
                <table id="demo" lay-filter="test"></table>
            </div>

        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">详情</a>
        </script>
    </form>

</div>

</div>

<script type="text/javascript">
    layui.use(['table', 'form', 'laydate','element'], function () {
        var table = layui.table;
        var form = layui.form
        var laydate = layui.laydate
        var element = layui.element
        //执行一个laydate实例
        laydate.render({
            elem: '#outTime' //指定元素
        });
        laydate.render({
            elem: '#test1'
        });
        //第一个实例
        var tableIns = table.render({
            elem: '#demo'
            , url: '/eduFixAssets/fixAssetsSummary' //数据接口
            , page: true //开启分页
            , id: 'tableOne'
            // , toolbar: '#toolbarDemo',
            , defaultToolbar: ['filter', 'print', 'exports', {
                title: '提示' //标题
                , layEvent: 'LAYTABLE_TIPS' //事件名，用于 toolbar 事件中使用
                , icon: 'layui-icon-tips' //图标类名
            }]
            , cols: [[ //表头
                {field: 'typeName',align: 'center', title: '资产分类名称'}
                , {field: 'typeId',align: 'center', title: '资产分类序号'}
                , {field: 'priceTotal',align: 'center', title: '分类资产数量'}
                , {field: 'cptlValTotal',align: 'center', title: '资产总价值',templet:function(d){
                        if(d.cptlValTotal== "null" ){
                            return ' '
                        }else if(d.cptlValTotal != "null"){
                            return  d.cptlValTotal
                        }else if(d.cptlValTotal== undefined ){
                            return ' '
                        }
                    }}
                , {field: 'cptlBalTotal',align: 'center', title: '资产残值',templet:function(d){
                        if(d.cptlBalTotal== "null" ){
                            return ' '
                        }else if(d.cptlBalTotal != "null"){
                            return  d.cptlBalTotal
                        }else if(d.cptlBalTotal== undefined ){
                            return ' '
                        }

                    }}
            ]],
            response: {
                statusName: 'flag',  //规定数据状态的字段名称，默认：code
                statusCode: true,   //规定成功的状态码，默认：0
                dataName: 'object',    //规定数据列表的字段名称，默认：data
                countName: 'totleNum'
            }
        });

    });

</script>
</body>
</html>

