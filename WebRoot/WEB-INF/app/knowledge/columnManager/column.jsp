

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%--/**
* 创建作者:   秦令泽
* 创建日期:   8:32 2019/9/15
* 方法介绍:  栏目新增
* @return
*/--%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>栏目新增</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <%--<script type="text/javascript" src="/lims/layer/layer.js?20201106"></script>--%>
    <style>
        .layui-card-header{
            border-bottom: 1px solid #eee;
            /*background: #fff;*/
            /*margin-top: 5px;*/
        }
        .main-row{
            display: flex;
            width: 100%;
            box-sizing: border-box;
            padding: 0 10px;
            font-size: 15px;
            line-height: 16px;
            margin-top: 15px;
        }
        .side-col{
            width: 30%;
            padding-right: 12px;
        }

        .panel {
            position: relative;
            /*margin-bottom: 20px;*/
            background-color: #fff;
            border: 1px solid transparent;
            border-radius: 4px;
            -webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05), 0 2px 6px 0 rgba(0,0,0,.045);
            box-shadow: 0 1px 1px rgba(0,0,0,.05), 0 2px 6px 0 rgba(0,0,0,.045);
        }
        .panel-heading {
            padding: 12px 48px 12px 20px;
            border-bottom: 1px solid transparent;
            border-top-left-radius: 3px;
            border-top-right-radius: 3px;
        }
        .panel-title {
            font-size: 14px;
            font-weight: 700;
            line-height: 20px;
            cursor: pointer;
        }
        .panel-body{
            padding: 20px;
            padding-top: 0;
        }
        .main-col{
            width: 70%;
        }

        .row-module + .row-module {
            margin-top: 5px;
        }

        .row-module {
            max-width: 550px;
            min-width: 400px;
        }
        .table-row {
            display: table;
            width: 100%;
            table-layout: fixed;
        }
        .col-module{
            min-width: 200px;
        }
        .col-shorts {
            width: 110px;
        }
        .table-form>tbody>tr>td, .table-form>tbody>tr>th, .table-form>tfoot>tr>td, .table-form>thead>tr>th {
            padding: 7px;
            vertical-align: middle;
            border-bottom: none;
        }
        .table td, .table th {
            padding: 8px 10px;
            line-height: 1.42857143;
            vertical-align: top;
            border-bottom: 1px solid #cbd0db;
            -webkit-transition: background .2s cubic-bezier(.175,.885,.32,1);
            -o-transition: background .2s cubic-bezier(.175,.885,.32,1);
            transition: background .2s cubic-bezier(.175,.885,.32,1);
        }
        .text-middle{
            font-size: 14px;
        }
        .text-middle img{
            width: 21px;
            margin-bottom: 4px;
        }
        .col-actions {
            width: 88px;
            padding-left: 5px;
        }
        .iptbox{
            display: flex;
            margin: 10px 0;
        }
        .longs{
            width: 310px;
        }
        .shorts{
            width: 220px;
        }
        .pnul{
            width: 60px;
        }
        .btnls{
            display: flex;
            align-items: center;
            margin-left: 5px;
        }
        .rtfix{
            overflow-y: auto;
        }

        /*滚动条样式*/
        .rtfix::-webkit-scrollbar {/*滚动条整体样式*/
            width: 4px;     /*高宽分别对应横竖滚动条的尺寸*/
            height: 4px;
        }
        .rtfix::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
            border-radius: 5px;
            -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            background: rgba(0,0,0,0.2);
        }
        .rtfix::-webkit-scrollbar-track { /*滚动条里面轨道*/
            -webkit-box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
            border-radius: 0;
            background: rgba(0, 0, 0, 0.1);
        }
        .layui-layer-btn .layui-layer-btn0{
            background-color: #009688 !important;
            border-color: #009688 !important;
        }
        .layui-layer-btn .layui-layer-btn1{
            background-color: #FF5722 !important;
            border-color: #FF5722 !important;
            color: #fff;
        }
        #hide{
            display: none;
        }
        .layui-colla-item {
            position: relative;
        }
        .eleTree-node-content-label{
            display: inline-block;
            width:99%!important;
        }
        .ele1 div.eleTree-node:nth-child(1){
            overflow: hidden;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="layui-card">
        <div class="layui-card-body">
            <div style="margin: 10px 0;height: 30px;text-align: right;">
                <button id="add" type="button" style="margin: 0 5px;" class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo">新建</button>
<%--                <button id="edit" type="button" style="margin: 0 5px;" class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo">修改</button>--%>
                <button id="del" type="button" style="margin: 0 5px;" class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo">删除</button>
            </div>
            <form class="layui-form" lay-filter="formTest" action=""style="width: 100%;
            margin: 0 auto;">
                <input type="text" name="equipId" style="display: none" id="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>
                        <div class="layui-input-block">
                            <input type="text" id="orderNo" name="orderNo" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>栏目名称</label>
                        <div class="layui-input-block">
                            <input type="text" name="columnName" id="columnName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                        </div>
                    </div>
<%--                <div class="layui-form-item">--%>
<%--                    <label class="layui-form-label"><span style="color: red;">*</span>栏目编码</label>--%>
<%--                    <div class="layui-input-block">--%>
<%--                        <input type="text" id="columnCode" name="columnCode" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
                <div class="layui-form-item">
                    <label class="layui-form-label">知识类别</label>
                    <div class="layui-input-block">
                        <input type="text" id="columnType" name="columnCode"   autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>父级栏目</label>
                        <div class="layui-input-block" id="parentColumnId" style="position: relative">
                            <input type="text" lay-verify="required" style="cursor: pointer" id="pele" pid name="ttitle" required="" lay-verify="required" placeholder="请输入标题" readonly="" autocomplete="off" class="layui-input">
                            <div class="eleTree ele1" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" >栏目说明</label>
                        <div class="layui-input-block" >
                            <textarea name="columnDesc"  id="columnDesc" placeholder="请输入内容" class="layui-textarea"></textarea>
                        </div>
                    </div>
                <div class="buttonbottom" style="text-align: center">
                    <button id="submit" style="" optype="2" type="button" class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo">保存编辑</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script type="text/javascript">
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var columnId = getUrlParam('columnTrId');
    var codeNo = getUrlParam('codeNo');
    var codeName = decodeURI(getUrlParam('codeName'));
    var PcolumnId;
    var parData =  parent.parData;
    var arr = parent.arr;
    layui.use(['table','layer','form','eleTree','element','treeSelect'], function(){
        var table = layui.table
            ,layer = layui.layer
            ,$ = layui.jquery
            ,treeSelect = layui.treeSelect
            ,element=layui.element
            ,eleTree = layui.eleTree
        //数据回显
        if(columnId != "undefined" ){
            $.ajax({
                type: "post",
                url: '/columManage/selectKnowledgeType?columnId='+columnId,
                dataType: "json",
                success:function (res) {
                    $("#orderNo").val(res.data[0].orderNo);
                    $("#columnName").val(res.data[0].columnName);
                    $("#columnDesc").val(res.data[0].columnDesc);
                    //$("#columnCode").val(res.data[0].columnCode);
                    $("#columnType").val(res.data[0].columnTypeName);
                    $("#pele").val(res.data[0].parentColumnIdName);
                    $("#pele").attr("pid",res.data[0].parentColumnId);
                    $("#pele").attr("pcode",res.data[0].sysCode);
                }
            })
        }else{
            $(".buttonbottom").css("display","block");
            $("#submit").attr("optype","1");
            $("#submit").html("保存新建");
            $("#orderNo").val("");
            $("#columnName").val("");
            $("#columnDesc").val("");
            //$("#columnCode").val("");
            $("#pele").val("");
            $("#pele").attr("pid","");
            $("#pele").attr("pcode","");
            $("#del").attr("style","display:none;")
            $("#columnType").val(codeName);
        }

        //新增操作
        $("#add").click(function () {
            $(".buttonbottom").css("display","block");
            $("#submit").attr("optype","1");
            $("#submit").html("保存新建");
            $("#orderNo").val("");
            $("#columnName").val("");
            $("#columnDesc").val("");
            //$("#columnCode").val("");
            $("#pele").val("");
            $("#pele").attr("pid","");
            $("#pele").attr("pcode","");
        })
        // //修改操作
        // $("#edit").click(function () {
        //     $(".buttonbottom").css("display","block");
        //     $("#submit").attr("optype","2");
        //     // $("#submit").html("修改");
        //     if(parData != "undefined" || parData != undefined){
        //         $("#orderNo").val(parData.orderNo);
        //         $("#columnName").val(parData.columnName);
        //         $("#columnDesc").val(parData.columnDesc);
        //         $("#columnCode").val(parData.columnCode);
        //         $("#columnType").val(parData.columnTypeName);
        //         $("#tree").val(parData.parentColumnIdName);
        //     }
        // })
        //修改操作
        $("#del").click(function () {
            if(columnId == undefined || columnId == undefined){
                layer.msg("参数错误，不可删除");
                return false;
            }else{
                layer.confirm("确定要删除吗", {
                    btn: ['确认','取消'],
                    icon: 7,
                    title: "系统提示"
                }, function () {
                    $.ajax({
                        type: "post",
                        url: '/knowledge/delKnowledgeType',
                        dataType: "json",
                        data:{
                            columnIds:columnId
                        },
                        success:function (res) {
                            if(res.code == "0" || res.code == 0){
                                layer.msg(res.msg,{icon:1,time:1500},function(d){
                                    parent.el.reload()
                                });
                            }else if(res.code == "3" || res.code == 3){
                                layer.confirm(res.msg, {
                                    btn: ['确认'],
                                    icon: 7,
                                    title: "系统提示"
                                }, function () {
                                    layer.closeAll();
                                });
                            }else{
                                layer.msg(res.msg);
                            }
                        }
                    })
                }, function () {
                    layer.closeAll();
                });
            }
        })
        //保存操作
        $("#submit").click(function () {
            var knowledgeColumn = {};
            knowledgeColumn.orderNo = $("#orderNo").val();
            knowledgeColumn.columnName = $("#columnName").val();
            knowledgeColumn.columnDesc = $("#columnDesc").val();
            //knowledgeColumn.columnCode = $("#columnCode").val();
            knowledgeColumn.columnType = codeNo;
            knowledgeColumn.parentColumnId = $("#pele").attr("pid");
            knowledgeColumn.sysCode = $("#pele").attr("pcode")
            var optype = $("#submit").attr("optype");
            if($("#columnName").val()==''||$("#orderNo").val()=='' ||$("#pele").val()==''){ //||$("#columnCode").val()==''
                layer.msg("必填项不能为空")
            }else{
                if(optype == "1"){
                    $.ajax({
                        type: "post",
                        url: '/columManage/insertKnowledgeType',
                        dataType: "json",
                        data:knowledgeColumn,
                        success:function (res) {
                            if(res.code == "0" || res.code == 0){
                                layer.msg(res.msg);
                                setTimeout(function(){
                                    parent.el.reload()
                                },1000)
                            }else{
                                layer.msg(res.msg);
                            }
                        }
                    })
                }else if(optype == "2"){
                    knowledgeColumn.columnId = columnId;
                    $.ajax({
                        type: "post",
                        url: '/columManage/updateKnowledgeType',
                        dataType: "json",
                        data:knowledgeColumn,
                        success:function (res) {
                            if(res.code == "0" || res.code == 0){
                                layer.msg(res.msg);
                                // $('#ulBox li.layui-this', parent.document).click();
                            }else{
                                layer.msg(res.msg);
                            }
                        }
                    })
                }
            }
        })
        var el;
        $("[name='ttitle']").on("click",function (e) {
            e.stopPropagation();
            if(!el){
                el=eleTree.render({
                    elem: '.ele1',
                    url:'/knowledge/childTree?codeNo='+codeNo,
                    expandOnClickNode: false,
                    highlightCurrent: true,
                    showLine:true,
                    done: function(res){

                    }
                });
            }
            $(".ele1").slideDown();
        })
        eleTree.on("nodeClick(data1)",function(d) {
            $("[name='ttitle']").val(d.data.currentData.label)
            $("#pele").attr("pid",d.data.currentData.id)
            $("#pele").attr("pcode",d.data.currentData.sysCode)
            PcolumnId = d.data.currentData.id;
            $(".ele1").slideUp();
        })
        $(document).on("click",function() {
            $(".ele1").slideUp();
        })
    });
    function childFunc(){
        columnId = parent.columnTrId;
        //数据回显
        $.ajax({
            type: "post",
            url: '/columManage/selectKnowledgeType?columnId='+columnId,
            dataType: "json",
            success:function (res) {
                $("#orderNo").val(res.data[0].orderNo);
                $("#columnName").val(res.data[0].columnName);
                $("#columnDesc").val(res.data[0].columnDesc);
                //$("#columnCode").val(res.data[0].columnCode);
                $("#columnType").val(res.data[0].columnTypeName);
                $("#pele").val(res.data[0].parentColumnIdName);
            }
        })
    }

    //假休眠
    function sleep(n) {
        var start = new Date().getTime();
        while (true) {
            if (new Date().getTime() - start > n) {
                break;
            }
        }
    }
</script>
</body>
</html>