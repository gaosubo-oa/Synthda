<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
    <title>数据汇总查询</title>
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
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529"></script>
    <style>
        html{
            background-color: #fff;
        }
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
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .select{
            background: #c7e1ff;
        }
        .layui-form-select{
            width: 100%!important;
        }
        .item1{
            margin-left: 5%;
            font-size: 16px;
            font-weight: bold;
        }
        .item2{
            width: 90%;
            margin: 2px auto;
        }
        .num{
            color: #2F7CE7;
        }
        .required{
            color: #CE5841;
            margin-left: 1%;
            font-size: 13px;
        }
        .itemTotal{
            margin: 13px 0px;
        }
        .layui-input{
            height: 30px;
            border-radius: 5px;
            line-height: 30px;
        }
        .layui-input[fieldtype='2']{
            text-align: center;
        }
        .fieldDesc{
            font-size: 13px;
            color: #292929;
            margin: 5px 0px;
            margin-left: 5%;
        }
        .fieldName{
            margin-left: 1%;
        }
        .layui-form-radio>i{
            font-size: 18px;
        }
        .layui-form-radio{
            margin: 0px 10px 0px 0px;
        }
        .baoTitle{
            font-size: 20px;
            margin: 17px 0px 0px 10px;
            font-weight: bold;
        }
        #hig{
            width:600px;
            height: 450px;
            float: left;
            margin-left:50px;
        }
        #main{
            width:600px;
            height: 450px;
            float: left;
            margin-left:50px;
        }
        #people{
            width:600px;
            height: 450px;
            float: left;
            margin-left:50px;
        }
        .taby{
            width:100%;
            min-height: 25px;
            line-height: 25px;
            text-align: center;
            border:1px solid #e6e6e6;
            border-collapse: collapse;
        }
        td{
            border:1px solid #e6e6e6;
            height: 40px;
            line-height: 40px;
        }
        th{
            border:1px solid #e6e6e6;
        }
        #Sumquery .layui-tab-title li {
            display: inline-block;
            *display: inline;
            *zoom: 1;
            vertical-align: middle;
            font-size: 14px;
            transition: all .2s;
            -webkit-transition: all .2s;
            position: relative;
            line-height: 40px;
            min-width: 65px;
            padding: 0 15px;
            text-align: center;
            cursor: pointer;
            top: 19px;
        }
        input[disabled], select[disabled], textarea[disabled], select[readonly], textarea[readonly] {
            cursor: not-allowed;
            background-color: #eeeeee!important;
        }
        .layui-bg-gray {
            background-color: #b5b2b2!important;
        }
        .layui-table-tool{
            display: none;
        }
        .overflows{
            width: 140px;
            overflow: hidden;/*超出部分隐藏*/
            white-space: nowrap;/*禁止换行*/
            text-overflow: ellipsis;/*省略号*/
            display: inline-block;
        }
        .liHeigh{
            height: 42px;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
</head>
<body>
<div style="margin-top: 20px;position: relative;">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span style="margin-left: 49px;font-size: 20px;">回收站</span>
</div>
<%--蓝色分割线--%>
<hr class="layui-bg-blue" style="height: 5px">
<div class="layui-fluid" id="LAY-app-message" style="background-color: #fff">
    <input type="hidden" id="sortId">
    <div class="layui-row ">
        <div class="layui-lf" style="width:250px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                    <ul id="questionTree"  style="overflow:auto;height:100%">
                    </ul>
                </div>
            </div>
        </div>
        <div class="layui-rt " style="width:calc(100% - 250px);float:left">
            <div class="layui-card rightHeight" style="padding-left: 10px;">
                <form class="layui-form" action="" style="display: inline-block">
<%--                    <div>--%>
<%--                        <div class="layui-inline" style="margin: 9px auto 0px auto;">--%>
<%--                            <label class="layui-form-label">开始日期</label>--%>
<%--                            <div class="layui-input-inline">--%>
<%--                                <input type="text" name="date" id="datestar" lay-verify="date" placeholder="" autocomplete="off" class="layui-input">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="layui-inline" style="margin: 9px auto 0px auto;">--%>
<%--                            <label class="layui-form-label">结束日期</label>--%>
<%--                            <div class="layui-input-inline">--%>
<%--                                <input type="text" name="date" id="dateend" lay-verify="date" placeholder="" autocomplete="off" class="layui-input">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                </form>
<%--                <button type="button" class="layui-btn search" style="margin-top: 12px;margin-left: 50px;">查询</button>--%>
                <button id="restoreBtn" type="button" title="恢复选中报表" class="layui-btn" style="margin-top: 12px;">恢复报表</button>
                <button id="backBtn" type="button" class="layui-btn excral" style="margin-top: 12px;margin-bottom: 10px;float: right;">返回</button>
                <hr class="layui-bg-blue" style="height: 2px">
                <%--查询的表--%>
                <div id="tables">
                    <table id="questionTable" lay-filter="questionTable-table" onload=''></table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var form
    var table
    var height = $(window).height()
    $('#leftHeight').height(height-130)
    $('.rightHeight').height(height-110)
    var mobiletype = false;
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        mobiletype = true;
    } else if (/(Android)/i.test(navigator.userAgent)) {
        mobiletype = true;
    }
    if(mobiletype){
        $('.layui-lf').width('100%');
        $('.layui-rt').width('100%').hide().find('.rightHeight').height('auto');
        $('head').append('<style>.layui-btn{height: 30px;\n' +
            '    line-height: 30px;\n' +
            '    padding: 0 10px;margin-left: 20px!important;}</style>');
        $('.search').before('<button type="button" class="layui-btn layui-bg-red" style="margin-top: 12px;margin-right: 0px;" id="backTable">返回</button>');
    }
    //返回
    $("#backBtn").click(function(){
        window.location.href='/repField/epidemic';
    })
    layui.use(['table','layer','form','laydate','element','upload'], function() {
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var element = layui.element;
        var upload = layui.upload;
        /*点击li的点击事件*/
        $('#questionTree').on('click','li',function(){
            var tableId = $(this).attr('repTableId');
            $(this).addClass('select').siblings().removeClass('select');
            // var  currentPage=1;
            table.reload('questionTable',{
                url : '/repData/findRepDatas',
                where:{
                    tableId:tableId,
                    startTime:$("#datestar").val(),
                    endTime:$("#dateend").val()
                }
            })
            $('#tables').show()
            $('#generalTable').hide()
            if(mobiletype){
                $('.layui-rt').show();
                $('.layui-lf').hide();
            }

            //恢复被删除的报表
            $("#restoreBtn").click(function(){
                $.ajax({
                    url: '/repTable/updateRepTabless',
                    data: {repTableId: tableId},
                    type: 'get',
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag) {
                            layer.msg('恢复报表成功', {icon: 1})
                            location.reload();
                        } else {
                            layer.msg('恢复报表失败', {icon: 2})
                        }
                    }
                })
            })
        })
        function x() {
            layui.use(['table','layer','form','laydate'], function(){
                var layer = layui.layer;
                var laydate = layui.laydate;
                table = layui.table;
                form = layui.form;
                var w1 = 115;
                var w2 = 121;
                var w3 = 196;
                var w4 = 196;
                var w5 = 221;
                var w6 = 179;
                if(!mobiletype){
                    var sum = $(window).width()-292;
                    var w1 = (w1/1035)*sum;
                    var w2 = (w2/1035)*sum;
                    var w3 = (w3/1035)*sum;
                    var w4 = (w4/1035)*sum;
                    var w5 = (w5/1035)*sum;
                    var w6 = (w6/1035)*sum;
                }
                //循环的li样式
                function getlis(){
                    $.ajax({
                        url:'/repTable/findRepTables',
                        type:'get',
                        async:false,
                        dataType:'json',
                        success:function(res){
                            // console.log(res);
                            if(res.flag){
                                var data = res.obj;
                                var str=''
                                for(var i=0;i<data.length;i++){
                                    if(data[i].status != 0){//隐藏未启用（status=0）状态的报表
                                        if (i == 0) {
                                            str += '<li class="select liHeigh" title="' + data[i].repTableName +
                                                '" dictNo="' + data[i].repTableName + '"  repTableId="' + data[i].repTableId + '">' +'<div class="overflows">' +
                                                data[i].repTableName + '</div>' + '</li>'
                                        } else {
                                            str += '<li class="liHeigh" dictNo="' + data[i].repTableName + '" repTableId="' + data[i].repTableId +
                                                '" title="' + data[i].repTableName + '">' + '<div class="overflows">' +
                                                data[i].repTableName + '</div>' + '</li>'
                                        }
                                    }
                                }
                                $('#questionTree').html(str);
                                if($('#questionTree li').length == 0){
                                    layer.msg('请选择报表！', {icon: 0});
                                    $("#restoreBtn").hide();
                                }else{
                                    $("#restoreBtn").show();
                                    //判断出现滚动条时候的宽度
                                    var isScroll = $(".layui-lf").prop('offsetWidth') > $(".layui-lf").prop('scrollWidth');
                                    if(isScroll){
                                        $(".liHeigh span").css({"margin-right": "5px"});
                                    }
                                    if(typeof(data[0].repTableId) != undefined){
                                        //恢复被删除的报表
                                        $("#restoreBtn").click(function(){
                                            $.ajax({
                                                url: '/repTable/updateRepTabless',
                                                data: {repTableId: data[0].repTableId},
                                                type: 'get',
                                                dataType: 'json',
                                                success: function (res) {
                                                    if (res.flag) {
                                                        layer.msg('恢复报表成功', {icon: 1})
                                                        location.reload();
                                                    } else {
                                                        layer.msg('恢复报表失败', {icon: 2})
                                                    }
                                                }
                                            })
                                        })
                                    }
                                }
                            }
                        }
                    })
                }
                getlis();
                // console.log($('.select').attr('repTableId'))
                var tableIns=table.render({
                    elem: '#questionTable'
                    ,url:'/repData/findRepDatas'
                    ,where:{
                        tableId:$('.select').attr('repTableId'),
                        startTime:$("#datestar").val(),
                        endTime:$("#dateend").val(),
                        useFlag:true
                    }
                    ,toolbar:'#toolbar'
                    ,cols: [[
                        {field:'flowId', title:'流水号'}
                        ,{field: 'filedNo', title: '列1',templet: function(d){
                                let repDataList=d.repDataList;
                                if (repDataList.length >0){
                                    var fieldName=d.repDataList[0].data
                                    if(fieldName!==undefined){
                                        return fieldName
                                    }
                                }
                                return '';
                            }}
                        ,{field:'userName', title:'填报人'}
                        ,{field:'deptName', title:'所属部门'}
                        ,{field:'flowTime', title:'填报时间'}
                        ,{title: '操作',  align:'center' , toolbar: '#barDemo'}
                    ]]
                    ,page: true
                    ,parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": 0,
                            "data": res.obj,
                            "count": res.totleNum
                        };
                    }
                    ,done: function(res, curr, count){
                        if(res.data.length!==0){
                            var biao=res.data[0].repFieldList[0].fieldName;
                            $('#tables thead tr th[data-field="filedNo"] span').html(biao);
                        }else{
                            if($('.select').attr('repTableId') != undefined){
                                $.ajax({
                                    url:'/repStatistics/findminfield?tableId='+$('.select').attr('repTableId'),
                                    type:'get',
                                    dataType:'json',
                                    success:function(res){
                                        if(res.flag){
                                            var biao=res.object.FIELD_NAME;
                                        }else{
                                            var biao='列';
                                        }

                                        $('#tables thead tr th[data-field="filedNo"] span').html(biao)
                                    }
                                });
                            }
                        }

                    }
                });
                if($('.select').attr('repTableId')==undefined){
                    $('#tables .layui-table-body').hide()
                }
                //监听工具条
                table.on('tool(questionTable-table)', function(obj){
                    // console.log(obj)
                    //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                    var flowId = obj.data.flowId;
                    var tableId=obj.data.repTableId
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

                });



            })
        }
        $(function(){
            setTimeout(x, 400);
        })
    })
</script>
</body>
</html>
