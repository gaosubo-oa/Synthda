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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>栏目管理</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lims/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <style>
        .layui-card-header{
            border-bottom: 1px solid #eee;
        }
        .mbox{
            padding: 8px;
        }
        .inbox{
            padding: 5px;
            padding-right: 30px;
        }
        .deptinput{
            display: inline-block;
            width: 75%;
        }
        .layui-btn{
            margin-left: 10px;
        }
        .layui-btn .layui-icon{
            margin-right: 0px;
        }
        .red{
            color: red;
            font-size: 16px;
        }
        .layui-form-label{
            padding: 8px 15px;
        }
        .layui-card-body{
            display: flex;
        }
        .layui-lf{
            min-width: 16%;
            overflow-x: auto;
            height: 600px !important;
        }
        .layui-rt{
            width: 84%;
            margin-left: 6px;
            margin-top: -10px;
        }
        .treeTitle{
            display: flex;
            box-sizing: border-box;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 30px;
            background-color: #00a0e9;
            color: #fff;
            padding: 15px;
            position: relative;
        }
        .layui-nav-item,.layadmin-flexible{
            position: absolute;
            left: 5px;
            top: 23px;
            z-index: 9999999;
        }
        .rtfix{
            width:200px;
            overflow-x: scroll;
        }
        .bg{
            background-color: #F2F2F2;
        }
        .bgs{
            background-color: #F2F2F2;
        }
        .back{
            background-color: #ccc;
        }
        /*滚动条样式*/
        /*.rtfix::-webkit-scrollbar {!*滚动条整体样式*!*/
        /*width: 4px;     !*高宽分别对应横竖滚动条的尺寸*!*/
        /*height: 10px;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-button{*/
        /*background-color: #000;*/
        /*border:1px solid #ccc;*/
        /*display:block;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-thumb {!*滚动条里面小方块*!*/
        /*border-radius: 5px;*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*background: rgba(0,0,0,0.2);*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-track {!*滚动条里面轨道*!*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*border-radius: 0;*/
        /*background: rgba(0,0,0,0.1);}*/
        .eleTree{
            cursor: pointer;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0;
        }
        .layui-tab layui-tab-card{
            margin-top: -4px;
        }
        .layui-tab-card>.layui-tab-title .layui-this:after {
            border-width: 0px;
        }
        .baseinfo td{
            padding: 5px 2px;
        }
        .active{
            display: none;
        }
        .back{
            background-color: #F2F2F2;
        }
        .layui-colla-item {
            position: relative;
        }
        .layui-collapse .layui-card-body{
            padding: 0 8px;
        }
        .repairLable{
            padding: 8px 15px;
            text-align: right;
            vertical-align: middle;
        }
        .layui-form-select dl dd{
            height: 32px;
            line-height: 32px;
        }
        .layui-form-select .layui-select-title .layui-input{
            height: 32px;
        }
        #formTest .layui-form-select input,#lendListTest .layui-form-select input{
            height: 32px;
        }
        .layui-input{
            height: 32px !important;
        }
        .layui-form-item{
            margin-bottom: 5px; !important;
        }
        .layui-form-label{
            width: 70px; !important;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="layui-tab layui-tab-card">
        <table id="Settlement" lay-filter="SettlementFilter"></table>
    </div>
</div>

<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>
<script type="text/javascript">
    layui.use(['table','layer','form','element','eleTree'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var selectName;//下拉框的值
        var selectVal;//搜索框的值
        // 树右侧表格实例
        var SettlementTable = layui.table.render({
            elem: '#Settlement'
            // , data: []
            , url: '/equipmentScrapping/selectAddEquipment'//数据接口
            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                , limits: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
                , first: false //不显示首页
                , last: false //不显示尾页
            } //开启分页
            , toolbar: '#toolbar'
            , cols: [[ //表头
                {type: 'checkbox'}
                , {field: 'equipNo', title: '固定资产编码'}
                , {field: 'equipName', title: '设备名称'}
                , {field: 'equipTypeName', title: '设备类型'}
                , {field: 'deptName', title: '所属部门'}
                , {field: 'equipStatuasName', title: '资产状态'}
                , {field: 'modelNo', title: '型号'}
                , {field: 'spec', title: '规格'}
                // ,{fixed: 'right',width:140, title: '操作',align:'center', toolbar: '#barOperation'}
            ]]
            , limit: 5
            , done: function (res) {
            }
        });
    })
</script>
</body>
</html>
