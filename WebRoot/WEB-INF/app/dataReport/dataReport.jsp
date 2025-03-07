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
    <title>数据上报</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
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
            /*width: 90%;*/
            /*margin: 2px auto;*/
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
        .laytable-cell-1-0-0 , .laytable-cell-1-0-1 ,.laytable-cell-1-0-2 , .laytable-cell-1-0-3 {
            font-size:14px;
            /*padding:0 5px;*/
            height:auto;
            overflow:visible;
            text-overflow:inherit;
            white-space:normal;
            word-break: break-all;
        }
        .layui-btn+.layui-btn{
            margin: 0px;
        }
        .layui-btn-xs{
            height: 25px;
            line-height: 25px;
            padding: 0 10px;
            font-size: 13px;
            margin: 8px 0px;
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
        .overflows{
            width: 180px;
            overflow: hidden;/*超出部分隐藏*/
            white-space: nowrap;/*禁止换行*/
            text-overflow: ellipsis;/*省略号*/
            display: inline-block;
        }
        .liHeigh{
            height: 42px;
        }
        .layui-fluid {
            position: relative;
            margin: 0px 0px 0px 15px;
            padding: 0;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
    <%--    <link rel="stylesheet" href="/duplopages/manage/standard/form/css/treeselect.css"/>--%>
</head>
<body>
<div style="margin-top: 20px;position: relative;" class="head">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span style="margin-left: 49px;font-size: 20px;">数据上报</span>
</div>
<%--蓝色分割线--%>
<hr class="layui-bg-blue" style="height: 5px;">
<div class="layui-fluid" id="LAY-app-message">
    <input type="hidden" id="sortId">
    <%--<div class="layui-row " style="min-width: 500px" >--%>
    <div class="layui-row " >
        <div class=" layui-col-xs3 layui-col-sm3 layui-col-md2">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                    <ul id="questionTree"  style="overflow:auto;height:100%">

                    </ul>
                </div>
            </div>
        </div>
        <div class="layui-col-xs9 layui-col-sm9 layui-col-md10 rightBox"  style="float:left">
            <div class="layui-card rightHeight" style="padding: 0 18px;">
                <%--<div style="text-align: right;margin-right: 2%;">--%>
                <div style="display: flex;justify-content:space-between">
                    <div class="baoTitle"></div>
                    <div>
                        <button type="button" class="layui-btn " style="margin-top: 12px;" id="addTable">新建</button>
                    </div>
                </div>
                <table id="questionTable" lay-filter="questionTable-table" ></table>
            </div>
        </div>
    </div>
</div>
<script src="/js/base/vconsole.min.js"></script>
<script>
    //var vConsole = new VConsole();
    var form
    var table
    var height = $(window).height();

    $('#leftHeight').height(height-130);
    $('.rightHeight').height(height-110);
    var userobject = {flag:false};
    //alert(navigator.userAgent)
    console.log(navigator.userAgent)
    var mobiletype = false;
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) ) {
        mobiletype = true;
    } else if (/(Android)/i.test(navigator.userAgent)) {
        mobiletype = true;
    }
    if(mobiletype){
        $('.layui-col-xs3').width('100%');
        $('.layui-col-xs9 ').width('100%').hide();
        $('head').append('<style>.layui-btn{height: 30px;\n' +
            '    line-height: 30px;\n' +
            '    padding: 0 10px;}</style>');
        $('#addTable').before('<button type="button" class="layui-btn layui-bg-red" style="margin-top: 12px;margin-right: 10px;" id="backTable">返回</button>');
    }

    $.ajax({
        type: "get",
        url: "/user/findUserByuserId",
        dataType: 'json',
        data: {
            userId:"${userId}"
        },
        async:false,
        success: function (obj) {
            userobject = obj;
        }
    });
    /* var type = $.GetRequest().type;
     var dataType = $.GetRequest().dataType;
     var shitiType=''*/

    $('#questionTree').on('click','li',function(){
        var tableId = $(this).attr('tableId');
        $(this).addClass('select').siblings().removeClass('select');
        $('.baoTitle').html($('.select').text());
        if(mobiletype){
            $('.layui-col-xs9').show();
            $('.layui-col-xs3 ').hide();
        }
        var abc = $(this).attr("editPerm");
        if(abc!=undefined&&abc=='false'){
            $('#addTable').hide();
        }else{
            $('#addTable').show();
        }
        // var  currentPage=1;
        table.reload('questionTable',{
            url : '/repData/findRepDatas',
            // data:{page:currentPage},
            // page:{
            //     curr:currentPage
            // },
            where:{
                tableId:tableId,
                type:1
            }
        })
    })

    function addNumBtn(){
        var index = layer.load();
        for(var i=0;i<$('input[fieldtype=2]').length;i++){
            var $this = $('input[fieldtype=2]').eq(i);
            $this.css({
                'display': 'inline-block',
                'padding-right': '10px',
                'width': '63px'
            });
            $this.before('<i class="layui-icon layui-icon-subtraction" style="color: #1E9FFF;font-weight: bold;" onclick="subtraction($(this))"></i>&nbsp;');
            $this.after('&nbsp;<i class="layui-icon layui-icon-addition" onclick="addition($(this))" style="\n' +
                '    color: #1E9FFF;\n' +
                '    font-weight: bold;\n' +
                '"></i>');
        }
        layer.close(index);
    }
    function subtraction(e) {
        var $this = e.next();
        if($this.val() != ''){
            var val = parseInt($this.val());
        }else{
            var val = 1;
        }
        if(val != 0){
            $this.val(val-1);
        }
    }
    function addition(e) {
        var $this = e.prev();
        if($this.val() != ''){
            var val = parseInt($this.val());

        }else{
            var val = -1;
        }
        $this.val(val+1);
    }
    function getlis(){
        $.ajax({
            url:'/repTable/findRepTable?type=0',
            type:'get',
            dataType:'json',
            async : false,
            success:function(res){
                if(res.flag){
                    var str=''
                    for(var i=0;i<res.obj.length;i++){
                        if(i==0){
                            str += '<li class="select liHeigh" title="'+res.obj[i].repTableName
                                +'" tableId="'+res.obj[i].repTableId+'" editPerm = "'+res.obj[i].editPerm+'">'
                                + '<div class="overflows">' + res.obj[i].repTableName+'</div></li>'
                            if(res.obj[i].editPerm==false){
                                $('#addTable').hide();
                            }
                        }else{
                            str += '<li class="liHeigh" tableId="'+res.obj[i].repTableId
                                +'" title="'+res.obj[i].repTableName+'" editPerm = "'+res.obj[i].editPerm+'">'
                                + '<div class="overflows">' + res.obj[i].repTableName+'</div></li>'

                        }

                    }
                    $('#questionTree').html(str)
                }
            }
        })
    }
    getlis();
    function x() {
        if($('.select').attr('tableId')==undefined){
            $('.rightHeight').hide()
            layer.msg('未选择报表!', {icon: 0});
        }else{
            $('.baoTitle').html($('.select').text())
            layui.use(['table','layer','form','laydate'], function(){
                var layer = layui.layer;
                var laydate=layui.laydate
                table = layui.table;
                form = layui.form;
                var tableIns=table.render({
                    elem: '#questionTable'
                    ,url: '/repData/findRepDatas?type=1&tableId='+ $('.select').attr('tableId')//数据接口
                    ,cellMinWidth:50
                    ,defaultToolbar:['']
                    ,cols: [[ //表头
                        {field: 'flowId', title: ' 流水号',width:80,align: 'center'}
                        ,{field: 'data', title: '列1',align: 'center',templet: function(d){
                                let repDataList = d.repDataList;
                                if(repDataList.length>0){
                                    var fieldName=repDataList[0].data;
                                    if(fieldName != undefined){
                                        return fieldName;
                                    }
                                }

                                return '';
                            }}
                        ,{field: 'flowTime', title: '填报时间',align: 'center'}
                        ,{title: '操作',align: 'center',templet: function(d){
                                var privlookstr = '<a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="look">查看</a>\n';
                                if(d.privlook){
                                    privlookstr += '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>\n' +
                                        '<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>';
                                }
                                return privlookstr;
                            }}
                    ]]
                    ,parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj //解析数据列表
                        };
                    }
                    ,done: function(res, curr, count){
                        // console.log(res)
                        if(res.data.length!==0){
                            var biao=res.data[0].repFieldList[0].fieldName
                            $('thead tr th[data-field="data"] span').html(biao)
                        }else{
                            $.ajax({
                                url:'/repStatistics/findminfield?tableId='+$('.select').attr('tableId'),
                                type:'get',
                                dataType:'json',
                                success:function(res){
                                    if(res.object !=undefined){
                                        var biao=res.object.FIELD_NAME
                                        $('thead tr th[data-field="data"] span').html(biao)
                                    }
                                }
                            })
                        }

                    }
                });

                //监听工具条
                table.on('tool(questionTable-table)', function(obj){
                    var flowId = obj.data.flowId;
                    var tableId=obj.data.repTableId
                    var layEvent = obj.event;
                    var tr = obj.tr;
                    if(layEvent === 'edit'){
                        layer.open({
                            type: 1,
                            title: '编辑',
                            // shadeClose: true,
                            btn:['确定','取消'],
                            shade: 0.5,
                            maxmin: true, //开启最大化最小化按钮
                            area: ['75%', '90%'],
                            content:' <div class="layui-form" id="report1">' +
                                '</div>',
                            success:function(){
                                if($(window).width()<768){
                                    $('.layui-layer').width('90%')
                                    $('.layui-layer').css('left','20px')
                                }else if($(window).width()>=768&&$(window).width()<=992){
                                    $('.layui-layer').width('80%')
                                }else if($(window).width()>=992&&$(window).width()<=1200){
                                    $('.layui-layer').width('70%')
                                }else if($(window).width()>=1200){
                                    $('.layui-layer').width('60%')
                                    $('.layui-layer').css('left','300px')
                                }
                                $.ajax({
                                    url:'/repData/findRepDataByFlowId?flowId='+flowId,
                                    type:'get',
                                    dataType:'json',
                                    success:function(res){
                                        if(res.object != undefined){
                                            var data=res.object.repFieldList;
                                            var data1=res.object.repDataList;
                                            var data1object = {};
                                            var data1object2 = {};
                                            for(var i=0;i<data1.length;i++){
                                                data1object[data1[i].fieldId] = data1[i].data;
                                                if(data1[i].attachmentList != undefined){
                                                    data1object2[data1[i].fieldId] = data1[i].attachmentList
                                                }
                                            }
                                            $('#report1').attr('repTableId',res.object.repTableId);
                                            var z = 0;
                                            var num = 0;
                                            for(var i=0;i<data.length;i++){
                                                var disabled = '';
                                                if(data[i].children != undefined){
                                                    var item1='<div class="itemTotal">\n' +
                                                        ' <hr class="layui-bg-gray" style="width: 92%;margin: 15px auto 10px auto;height: 2px;"><div class="item1"><span class="fieldName">'+data[i].fieldGroup+'：</span></div>\n';
                                                    for(var j=0;j<data[i].children.length;j++){
                                                        var thisdata = data[i].children[j];
                                                        var fieldName = thisdata.fieldName;
                                                        if(fieldName.indexOf('：') > -1){
                                                            fieldName = '&nbsp;&nbsp;&nbsp;&nbsp;'+fieldName.split('：')[1];
                                                        }
                                                        if(thisdata.fieldDesc!=undefined && thisdata.fieldDesc!=''){
                                                            thisdata.fieldDesc = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+thisdata.fieldDesc;
                                                        }

                                                        if(thisdata.readonly == 1){
                                                            disabled = 'disabled';
                                                        }
                                                        if(j == data[i].children.length-1){
                                                            var style = 'style="margin: 13px 0 50px 0;"';
                                                        }else{
                                                            var style = '';
                                                        }
                                                        if(thisdata.fieldType==1){ //单行文本
                                                            item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                                ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                    if(thisdata.ismust==1){
                                                                        return '(必填)'
                                                                    }else {
                                                                        return ''
                                                                    }
                                                                }()+'</span></div>\n' +
                                                                '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                                ' <div class="item2">' +
                                                                function () {
                                                                    if(data1object[thisdata.fieldId] != undefined){
                                                                        return   '<input '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" value="'+data1object[thisdata.fieldId]+'">'

                                                                    }else{
                                                                        return   '<input '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" >';

                                                                    }
                                                                }()+
                                                                '</div>\n' +
                                                                '            </div>';
                                                            $('#report1').append(item1)
                                                        }
                                                        if(thisdata.fieldType==2 ){ //单行数字
                                                            item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                                ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                    if(thisdata.ismust==1){
                                                                        return '(必填)'
                                                                    }else {
                                                                        return ''
                                                                    }
                                                                }()+'</span></div>\n' +
                                                                '<div class="fieldDesc">'+
                                                                function () {
                                                                    if(thisdata.fieldDesc==undefined || thisdata.fieldDesc=='' ){
                                                                        return '<span  style="color: red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;要求为数字</span>'
                                                                    }else{
                                                                        return thisdata.fieldDesc+'<span style="color: red;margin-left: 10px;">要求为数字</span>'
                                                                    }
                                                                }()
                                                                +'</div>'+
                                                                ' <div class="item2">' +
                                                                function () {
                                                                    if(data1object[thisdata.fieldId] != undefined){
                                                                        /*if((thisdata.fieldName=='人员总数')&& res.object.repTableId==1){
                                                                            return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleTotal testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                        }else if((thisdata.fieldName=='在沪人员：核查人数'|| thisdata.fieldName=='在湖北：核查人数'|| thisdata.fieldName=='在其它地区：核查人数'|| thisdata.fieldName=='返校途中：核查人数'|| thisdata.fieldName=='失联人数')&& res.object.repTableId==1 ){
                                                                            return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleNum testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                        }else{
                                                                            return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                        }*/
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                    }else{
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" >'

                                                                    }

                                                                }()+
                                                                '</div>\n' +
                                                                '            </div>';
                                                            $('#report1').append(item1)
                                                        }
                                                        if(thisdata.fieldType==3 ){ //多行文本
                                                            item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                                ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                    if(thisdata.ismust==1){
                                                                        return '(必填)'
                                                                    }else {
                                                                        return ''
                                                                    }
                                                                }()+'</span></div>\n' +
                                                                '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                                ' <div class="item2">' +
                                                                function () {
                                                                    if(data1object[thisdata.fieldId] != undefined){
                                                                        return   '<textarea '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+data1object[thisdata.fieldId]+'</textarea>'

                                                                    }else{
                                                                        return   '<textarea '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+'</textarea>'

                                                                    }
                                                                }()+
                                                                '</div>\n' +
                                                                '            </div>';
                                                            $('#report1').append(item1)
                                                        }
                                                        if(thisdata.fieldType==4 ){ //日期
                                                            item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                                ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                    if(thisdata.ismust==1){
                                                                        return '(必填)'
                                                                    }else {
                                                                        return ''
                                                                    }
                                                                }()+'</span></div>\n' +
                                                                '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                                ' <div class="item2">' +
                                                                function () {
                                                                    if(data1object[thisdata.fieldId] != undefined){
                                                                        return  '<input '+ disabled +' ismust="'+thisdata.ismust+'"  fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'" value="'+data1object[thisdata.fieldId]+'">'

                                                                    }else{
                                                                        return  '<input '+ disabled +' ismust="'+thisdata.ismust+'"  fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'">'

                                                                    }
                                                                }()+
                                                                '</div>\n' +
                                                                '            </div>';
                                                            $('#report1').append(item1)
                                                            //执行一个laydate实例
                                                            laydate.render({
                                                                elem: '#test' +[z]//指定元素
                                                            });
                                                            z++;
                                                        }
                                                        if(thisdata.fieldType==5){ //单选
                                                            item1 +=' <div class="itemTotal" '+ style +'>\n' +
                                                                ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                    if(thisdata.ismust==1){
                                                                        return '(必填)'
                                                                    }else {
                                                                        return ''
                                                                    }
                                                                }()+'</span></div>\n' +
                                                                '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                                ' <div class="item2 radio" ismust="'+thisdata.ismust+'" fieldName="'+thisdata.fieldName+'" > ' +
                                                                function () {
                                                                    var arr=thisdata.fieldContent.split('/')
                                                                    var str='';
                                                                    if(data1object[thisdata.fieldId] != undefined){
                                                                        for(var k=0;k<arr.length;k++){
                                                                            if(data1object[thisdata.fieldId] == arr[k]){
                                                                                str+= '<div><input '+ disabled +' fieldId="'+thisdata.fieldId+'" type="radio" name="'+thisdata.fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                            }else{
                                                                                str+= '<div><input '+ disabled +' fieldId="'+thisdata.fieldId+'" type="radio" name="'+thisdata.fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                            }
                                                                        }
                                                                    }else{
                                                                        for(var k=0;k<arr.length;k++){
                                                                            str+= '<div><input '+ disabled +' fieldId="'+thisdata.fieldId+'" type="radio" name="'+thisdata.fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                        }
                                                                    }
                                                                    return   str
                                                                }()+
                                                                '</div>\n' +
                                                                '            </div>';
                                                            $('#report1').append(item1);
                                                            form.render('radio')
                                                        }
                                                        if(thisdata.fieldType==6 ){ //多选
                                                            item1 +=' <div class="itemTotal" '+ style +'>\n' +
                                                                ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                    if(thisdata.ismust==1){
                                                                        return '(必填)'
                                                                    }else {
                                                                        return ''
                                                                    }
                                                                }()+'</span></div>\n' +
                                                                '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                                ' <div class="item2 checkbox" ismust="'+thisdata.ismust+'"  fieldName="'+thisdata.fieldName+'">\n' +
                                                                function () {
                                                                    var arr=thisdata.fieldContent.split('/')
                                                                    var str=''
                                                                    if(data1object[thisdata.fieldId] != undefined){
                                                                        for(var k=0;k<arr.length;k++){
                                                                            if(data1object[thisdata.fieldId].indexOf(arr[k]) != -1){
                                                                                str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                            }else{
                                                                                str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                            }
                                                                        }
                                                                    }else{
                                                                        for(var k=0;k<arr.length;k++){
                                                                            str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                        }
                                                                    }
                                                                    return str
                                                                }()+
                                                                '  </div>\n' +
                                                                '            </div>'
                                                            $('#report1').append(item1)
                                                            form.render('checkbox')
                                                        }

                                                        if(thisdata.fieldType==7){ //附件
                                                            var fileD = '#'+"fileupload"+i
                                                            var all= '#'+"fileAll"+i
                                                            var strfile = ''
                                                            if(data1object2[data[i].fieldId] != undefined){
                                                                var  dataFile = data1object2[data[i].fieldId]
                                                            }else{
                                                                var  dataFile = ''
                                                            }
                                                            if(dataFile !=undefined && dataFile.length>0){
                                                                for(var l=0;l<dataFile.length;l++){
                                                                    var fileExtension=dataFile[l].attachName.substring(dataFile[l].attachName.lastIndexOf(".")+1,dataFile[l].attachName.length);//截取附件文件后缀
                                                                    var attName = encodeURI(dataFile[l].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                                    var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                                                    var deUrl = dataFile[l].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+dataFile[l].size;
                                                                    strfile += '<div class="dech" deUrl="' + deUrl+ '" attachid="'+dataFile[l].attachId+'"  name ="'+dataFile[l].attachName+'">' +
                                                                        '<a NAME="' + dataFile[l].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                                                        '<img  src="/img/attachment_icon.png"/>' + dataFile[l].attachName + '</a>' +
                                                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>删除' +
                                                                        '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                                                        '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                                        '<a class="download" style="padding-left: 5px;" href="/download?'+encodeURI(deUrl)+'" >' +
                                                                        '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                                                        '<input type="hidden" class="inHidden" value="' + dataFile[l].aid + '@' + dataFile[l].ym + '_' +dataFile[l].attachId + ',">' +
                                                                        '</div>'
                                                                }

                                                            }else{
                                                                strfile='';
                                                            }
                                                            item1 +=' <div class="itemTotal itemTotal11" '+ style +' fileD="fileupload'+i+'"  all="fileAll'+i+'">\n' +
                                                                ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                    if(thisdata.ismust==1){
                                                                        return '(必填)'
                                                                    }else {
                                                                        return ''
                                                                    }
                                                                }()+'</span></div>\n' +
                                                                // '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                                ' <div class="item2 file" ismust="'+thisdata.ismust+'" fieldName="'+thisdata.fieldName+'" > \n' +
                                                                function () {
                                                                    var arr=thisdata.fieldContent.split('/')
                                                                    var str=''
                                                                    for(var k=0;k<arr.length;k++){
                                                                        // str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                        str+= '    <div class="layui-input-inline  fieldId" file="file" lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'">\n' +
                                                                            '<div id="fujians"></div>' +
                                                                            ' <div class="aaa" id="fileAll'+i+'">\n' +strfile+
                                                                            '</div>\n' +
                                                                            '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                                                                            '<img src="../img/mg11.png" alt="">\n' +
                                                                            '<span>添加附件</span>\n' +
                                                                            '<input type="file" class="fileupload" multiple id="fileupload'+i+'"  data-url="/upload?module=detaReport" name="file">\n' +
                                                                            '</a>\n' +
                                                                            '</div>\n'
                                                                    }
                                                                    return   str
                                                                }()+
                                                                '    </div>\n' +
                                                                '            </div>';

                                                            $('#report1').append(item1)
                                                            fileuploadFn(fileD, $(all));
                                                        }
                                                        item1 = '';
                                                        num++;
                                                    }
                                                }else{
                                                    if(data[i].readonly == 1){
                                                        disabled = 'disabled';
                                                    }
                                                    if(data[i].fieldType==1){ //单行文本
                                                        var item1=''
                                                        item1+=' <div class="itemTotal">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                                if(data[i].ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[data[i].fieldId] != undefined){
                                                                    return   '<input '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" value="'+data1object[data[i].fieldId]+'">'

                                                                }else{
                                                                    return   '<input '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" >'

                                                                }
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>'
                                                        $('#report1').append(item1)
                                                    }
                                                    if(data[i].fieldType==2 ){ //单行数字
                                                        var item2=''
                                                        item2+=' <div class="itemTotal">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                                if(data[i].ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+
                                                            function () {
                                                                if(data[i].fieldDesc==undefined || data[i].fieldDesc=='' ){
                                                                    return '<span  style="color: red;">要求为数字</span>'
                                                                }else{
                                                                    return data[i].fieldDesc+'<span style="color: red;margin-left: 10px;">要求为数字</span>'
                                                                }
                                                            }()
                                                            +'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[data[i].fieldId] != undefined){
                                                                    /*if((data[i].fieldName=='人员总数')&& res.object.repTableId==1){
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleTotal testNum" value="'+data1object[data[i].fieldId]+'">'
                                                                    }else if((data[i].fieldName=='在沪人员：核查人数'|| data[i].fieldName=='在湖北：核查人数'|| data[i].fieldName=='在其它地区：核查人数'|| data[i].fieldName=='返校途中：核查人数'|| data[i].fieldName=='失联人数')&& res.object.repTableId==1 ){
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleNum testNum" value="'+data1object[data[i].fieldId]+'">'
                                                                    }else{
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[data[i].fieldId]+'">'
                                                                    }*/
                                                                    return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[data[i].fieldId]+'">'
                                                                }else{
                                                                    return   '<input '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" >'

                                                                }
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>'
                                                        $('#report1').append(item2)
                                                    }
                                                    if(data[i].fieldType==3 ){ //多行文本
                                                        var item3=''
                                                        item3+=' <div class="itemTotal">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                                if(data[i].ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[data[i].fieldId] != undefined){
                                                                    return   '<textarea '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+data1object[data[i].fieldId]+'</textarea>'

                                                                }else{
                                                                    return   '<textarea '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+'</textarea>'

                                                                }

                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>'
                                                        $('#report1').append(item3)
                                                    }
                                                    if(data[i].fieldType==4 ){ //日期
                                                        var item4=''
                                                        item4+=' <div class="itemTotal">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                                if(data[i].ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[data[i].fieldId] != undefined){
                                                                    return  '<input '+ disabled +' ismust="'+data[i].ismust+'"  fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'" value="'+data1object[data[i].fieldId]+'">'

                                                                }else{
                                                                    return  '<input '+ disabled +' ismust="'+data[i].ismust+'"  fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'">'

                                                                }
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>'
                                                        $('#report1').append(item4)
                                                        //执行一个laydate实例
                                                        laydate.render({
                                                            elem: '#test' +[z]//指定元素
                                                        });
                                                        z++;
                                                    }
                                                    if(data[i].fieldType==5){ //单选
                                                        var item5=''
                                                        item5+=' <div class="itemTotal">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                                if(data[i].ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                            ' <div class="item2 radio" ismust="'+data[i].ismust+'" fieldName="'+data[i].fieldName+'" > ' +
                                                            function () {
                                                                var arr=data[i].fieldContent.split('/')
                                                                var str=''
                                                                if(data1object[data[i].fieldId] != undefined){
                                                                    for(var k=0;k<arr.length;k++){
                                                                        if(data1object[data[i].fieldId]==arr[k]){
                                                                            str+= '<div><input '+ disabled +' fieldId="'+data[i].fieldId+'" type="radio" name="'+data[i].fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                        }else{
                                                                            str+= '<div><input '+ disabled +' fieldId="'+data[i].fieldId+'" type="radio" name="'+data[i].fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                        }
                                                                    }
                                                                }else{
                                                                    for(var k=0;k<arr.length;k++){
                                                                        str+= '<div><input '+ disabled +' fieldId="'+data[i].fieldId+'" type="radio" name="'+data[i].fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    }
                                                                }
                                                                return   str
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>'
                                                        $('#report1').append(item5)
                                                        form.render('radio')
                                                    }
                                                    if(data[i].fieldType==6 ){ //多选
                                                        var item6=''
                                                        item6+=' <div class="itemTotal">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                                if(data[i].ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                            ' <div class="item2 checkbox" ismust="'+data[i].ismust+'"  fieldName="'+data[i].fieldName+'">\n' +
                                                            function () {
                                                                var arr=data[i].fieldContent.split('/')
                                                                var str=''
                                                                if(data1object[data[i].fieldId] != undefined){
                                                                    for(var k=0;k<arr.length;k++){
                                                                        if(data1object[data[i].fieldId].indexOf(arr[k]) != -1){
                                                                            str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                        }else{
                                                                            str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                        }
                                                                    }
                                                                }else{
                                                                    for(var k=0;k<arr.length;k++){
                                                                        str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    }
                                                                }

                                                                return str
                                                            }()+
                                                            '  </div>\n' +
                                                            '            </div>'
                                                        $('#report1').append(item6)
                                                        form.render('checkbox')
                                                    }
                                                    if(data[i].fieldType==7){ //附件
                                                        var fileD = '#'+"fileupload"+i
                                                        var all= '#'+"fileAll"+i
                                                        var strfile = '';
                                                        var item7 = '';
                                                        if(data1object2[data[i].fieldId] != undefined){
                                                            var  dataFile = data1object2[data[i].fieldId]
                                                        }else{
                                                            var  dataFile = ''
                                                        }

                                                        if(dataFile !=undefined && dataFile.length>0){
                                                            for(var l=0;l<dataFile.length;l++){
                                                                var fileExtension=dataFile[l].attachName.substring(dataFile[l].attachName.lastIndexOf(".")+1,dataFile[l].attachName.length);//截取附件文件后缀
                                                                var attName = encodeURI(dataFile[l].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                                                var deUrl = dataFile[l].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+dataFile[l].size;
                                                                strfile += '<div class="dech" deUrl="' + deUrl+ '"  attachid="'+dataFile[l].attachId+'"  name ="'+dataFile[l].attachName+'">' +
                                                                    '<a NAME="' + dataFile[l].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                                                    '<img  src="/img/attachment_icon.png"/>' + dataFile[l].attachName + '</a>' +
                                                                    '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>删除' +
                                                                    '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                                    '<a class="download" style="padding-left: 5px;" href="/download?'+encodeURI(deUrl)+'" >' +
                                                                    '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                                                    '<input type="hidden" class="inHidden" value="' + dataFile[l].aid + '@' + dataFile[l].ym + '_' +dataFile[l].attachId + ',">' +
                                                                    '</div>'
                                                            }

                                                        }else{
                                                            strfile='';
                                                        }
                                                        item7 +=' <div class="itemTotal itemTotal11" '+ style +' fileD="fileupload'+i+'"  all="fileAll'+i+'">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                                if(data[i].ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            // '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                            ' <div class="item2 file" ismust="'+data[i].ismust+'" fieldName="'+data[i].fieldName+'" > \n' +
                                                            function () {
                                                                var arr=data[i].fieldContent.split('/')
                                                                var str=''
                                                                for(var k=0;k<arr.length;k++){
                                                                    // str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    str+= '    <div class="layui-input-inline  fieldId" file="file" lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'">\n' +
                                                                        '<div id="fujians"></div>' +
                                                                        ' <div class="aaa" id="fileAll'+i+'">\n' +strfile+
                                                                        '</div>\n' +
                                                                        '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                                                                        '<img src="../img/mg11.png" alt="">\n' +
                                                                        '<span>添加附件</span>\n' +
                                                                        '<input type="file" class="fileupload" multiple id="fileupload'+i+'"  data-url="/upload?module=detaReport" name="file">\n' +
                                                                        '</a>\n' +
                                                                        '</div>\n'
                                                                }
                                                                return   str
                                                            }()+
                                                            '    </div>\n' +
                                                            '            </div>';

                                                        $('#report1').append(item7)
                                                        fileuploadFn(fileD, $(all));
                                                    }
                                                    num++;
                                                }

                                            }
                                            addNumBtn();
                                        }
                                    }
                                })


                            },
                            yes:function(index){
                                for(var r=0;r<$('.radio input').length;r++){
                                    if($('.radio input').eq(r).next().hasClass('layui-form-radioed')){
                                        $('.radio input').eq(r).addClass('fieldId')
                                    }
                                }
                                for(var c=0;c<$('.checkbox input').length;c++){
                                    if($('.checkbox input').eq(c).next().hasClass('layui-form-checked')){
                                        $('.checkbox input').eq(c).addClass('fieldId')
                                    }
                                }
                                //检验数字
                                for(var t=0;t<$('.testNum').length;t++){
                                    var tt=$('.testNum').eq(t).val()
                                    var fieldname=$('.testNum').eq(t).attr('fieldname');
                                    if(tt != ''){
                                        if(tt.length!==1){
                                            if(tt.split('.').length-1 >1){
                                                layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                                return false
                                            }
                                            if(tt.substring(0,1)==0 && tt.substring(1,2)!=='.'){
                                                layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                                return false
                                            }
                                            if(tt.substring(0,1)==0 &&tt.substring(1,2)=='.'&&tt.substring(2,3)==''){
                                                layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                                return false
                                            }
                                            if(tt.substring(0,1)=='.'){
                                                layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                                return false
                                            }
                                        }else {
                                            if(tt=='.'){
                                                layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                                return false
                                            }
                                        }
                                    }
                                }
                                /*//提示用户输入字段类型
                                for(var i=0;i<$('.fieldType').length;i++){
                                    if((!isNaN($('.fieldType').eq(i).val()))&&$('.fieldType').eq(i).attr('fieldType')==1){
                                        layer.msg('请将'+$('.fieldType').eq(i).attr('fieldname')+'输入为文本', {icon: 0});
                                        return false
                                    }
                                  /!*  if((isNaN($('.fieldType').eq(i).val()))&&$('.fieldType').eq(i).attr('fieldType')==2){
                                        layer.msg('请将'+$('.fieldType').eq(i).attr('fieldname')+'输入为数字', {icon: 0});
                                        return false
                                    }*!/
                                    if((!isNaN($('.fieldType').eq(i).val()))&&$('.fieldType').eq(i).attr('fieldType')==3){
                                        layer.msg('请将'+$('.fieldType').eq(i).attr('fieldname')+'输入为文本', {icon: 0});
                                        return false
                                    }
                                }*/
                                //限制用户输入字段长度
                                var fieldSize=$('.fieldSize')
                                for(var i=0;i<fieldSize.length;i++){
                                    var fieldSizeValueLength=fieldSize.eq(i).val().split('').length
                                    var fieldSizeLength=fieldSize.eq(i).attr('fieldSize')
                                    var fieldname=fieldSize.eq(i).attr('fieldname')
                                    if(fieldSizeValueLength>fieldSizeLength){
                                        layer.msg(fieldname+'长度不能大于'+fieldSizeLength, {icon: 0});
                                        return false
                                    }
                                }
                                //判断输入是否有空值
                                for(var i=0;i<$('.ismust').length;i++){
                                    if($('.ismust').eq(i).val()==''&&$('.ismust').eq(i).attr('ismust')==1){
                                        layer.msg($('.ismust').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                        return false
                                    }
                                }
                                //校验数据符合要求
                                if($('.pepleTotal').val()!==undefined){
                                    var pepleTotal=$('.pepleTotal').val()
                                    var sum=0
                                    for(var i=0;i<$('.pepleNum').length;i++){
                                        sum += parseInt($('.pepleNum').eq(i).val())
                                    }
                                    if((pepleTotal-sum)!==0){
                                        layer.msg('请检查数据符合以下要求：学生总数（教职员工）-在沪核查人数-在湖北核查人数-在其他地区核查人数-在返校途中核查人数-失联人数=0', {icon: 0});
                                        return false
                                    }
                                }

                                //判断单选是否没选
                                for (var i=0;i<$('.radio ').length;i++) {
                                    if(!$('.radio').eq(i).find('div').hasClass('layui-form-radioed')){
                                        layer.msg($('.radio').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                        return false
                                    }
                                }
                                //判断多选是否没选
                                for (var i=0;i<$('.checkbox ').length;i++) {
                                    if(!$('.checkbox').eq(i).find('div').hasClass('layui-form-checked')){
                                        layer.msg($('.checkbox').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                        return false
                                    }
                                }
                                /*  //获取fieldId和data
                                  var fieldIdList=[]
                                  var fieldValueList=[]
                                  for(var i=0;i<$('.fieldId').length;i++){
                                      var fieldId=$('.fieldId').eq(i).attr('fieldId')
                                      fieldIdList.push(fieldId)
                                      var fieldValue=$('.fieldId').eq(i).val()
                                      fieldValueList.push(fieldValue)
                                  }
                                  // console.log(fieldIdList)
                                  // console.log(fieldValueList)
                                  var repDataList=[]
                                  for(var i=0;i<fieldIdList.length;i++){
                                      var repDataObj={}
                                      repDataObj.fieldId=fieldIdList[i]
                                      repDataObj.data=fieldValueList[i]
                                      repDataList.push(repDataObj)
                                  }
                                  console.log(repDataList)
                                  console.log(repDataObj)*/
                                //判断附件是否上传
                                var file=$('.file')
                                for(var i=0;i<file.length;i++){
                                    if(file.eq(i).find('.dech').length < 1 && $('.ismust').eq(i).attr('ismust')==1){
                                        layer.msg(file.eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                        return false
                                    }
                                }

                                //获取fieldId和data
                                var map = {};
                                for(var i=0;i<$('.fieldId').length;i++){

                                    if($('.fieldId').eq(i).attr('file') == 'file'){
                                        var fieldValueId = {}
                                        // var fieldValueName = {}
                                        var fileId = ''
                                        var fileName = ''
                                        // let obj ={}
                                        var fieldId=$('.fieldId').eq(i).attr('fieldId')
                                        for(var t=0;t<$('.fieldId').eq(i).find('.dech').length;t++){
                                            fileId+=($('.fieldId').eq(i).find('.dech').eq(t).attr('attachid'))+','
                                            fileName+=($('.fieldId').eq(i).find('.dech').eq(t).attr('name'))+'*'
                                        }

                                        fieldValueId.attachId =fileId;
                                        fieldValueId.attachName =fileName;
                                        var fieldValue = JSON.stringify(fieldValueId)

                                    }else {
                                        var fieldId=$('.fieldId').eq(i).attr('fieldId')
                                        var fieldValue=$('.fieldId').eq(i).val()
                                    }


                                    // var fieldId=$('.fieldId').eq(i).attr('fieldId')
                                    // var fieldValue=$('.fieldId').eq(i).val()
                                    if(map[fieldId] != undefined){
                                        map[fieldId] += '/'+fieldValue;
                                    }else{
                                        map[fieldId] = fieldValue;
                                    }
                                }
                                var repDataList=[]
                                for(var prop in map){
                                    if(map.hasOwnProperty(prop)){
                                        var repDataObj={}
                                        repDataObj.fieldId=prop;
                                        repDataObj.data=map[prop];
                                        repDataList.push(repDataObj)
                                    }
                                }
                                var data={
                                    flowId:flowId,
                                    repTableId:$('#report1').attr('repTableId'),
                                    repDataList:repDataList
                                }
                                $.ajax({
                                    url:'/repData/updateRepDatas',
                                    type:'post',
                                    dataType:'json',
                                    contentType: 'application/json;charset=utf-8',
                                    data:JSON.stringify(data),
                                    success:function(res){
                                        if(res.flag){
                                            layer.msg('修改成功',{icon:1});
                                            layer.close(index);
                                            tableIns.reload()
                                        }
                                    }
                                })
                            },
                        });
                    } else if(layEvent === 'del'){
                        layer.confirm('确定要删除该数据吗？', function(index){
                            $.ajax({
                                url:'/repData/delRepDataByFlowId',
                                data:{
                                    tableId:tableId,
                                    flowId:flowId
                                },
                                dataType:'json',
                                type:'get',
                                success:function(res){
                                    if(res.flag){
                                        layer.msg('删除成功',{icon:1});
                                        tableIns.reload()
                                    }
                                }
                            })
                            layer.close(index);

                        });
                    } else if(layEvent === 'look'){
                        layer.open({
                            type: 1,
                            title: '查看',
                            btn:['返回'],
                            shade: 0.5,
                            maxmin: true,
                            area: ['75%', '90%'],
                            content:' <div class="layui-form" id="report1">' +
                                '</div>',
                            success:function(){
                                if($(window).width()<768){
                                    $('.layui-layer').width('90%')
                                    $('.layui-layer').css('left','20px')
                                }else if($(window).width()>=768&&$(window).width()<=992){
                                    $('.layui-layer').width('80%')
                                }else if($(window).width()>=992&&$(window).width()<=1200){
                                    $('.layui-layer').width('70%')
                                }else if($(window).width()>=1200){
                                    $('.layui-layer').width('60%')
                                    $('.layui-layer').css('left','300px')
                                }
                                $.ajax({
                                    url:'/repData/findRepDataByFlowId?flowId='+flowId,
                                    type:'get',
                                    dataType:'json',
                                    success:function(res){
                                        var data=res.object.repFieldList;
                                        var data1=res.object.repDataList;
                                        var data1object = {};
                                        var data1object2 = {};
                                        for(var i=0;i<data1.length;i++){
                                            data1object[data1[i].fieldId] = data1[i].data;
                                            if(data1[i].attachmentList != undefined){
                                                data1object2[data1[i].fieldId] = data1[i].attachmentList
                                            }
                                        }
                                        $('#report1').attr('repTableId',res.object.repTableId);
                                        var z = 0;
                                        var num = 0;
                                        for(var i=0;i<data.length;i++){
                                            var disabled = '';
                                            if(data[i].children != undefined){
                                                var item1='<div class="itemTotal">\n' +
                                                    ' <hr class="layui-bg-gray" style="width: 92%;margin: 15px auto 10px auto;height: 2px;"><div class="item1"><span class="fieldName">'+data[i].fieldGroup+'：</span></div>\n';
                                                for(var j=0;j<data[i].children.length;j++){
                                                    var thisdata = data[i].children[j];
                                                    var fieldName = thisdata.fieldName;
                                                    if(fieldName.indexOf('：') > -1){
                                                        fieldName = '&nbsp;&nbsp;&nbsp;&nbsp;'+fieldName.split('：')[1];
                                                    }
                                                    if(thisdata.fieldDesc!=undefined && thisdata.fieldDesc!=''){
                                                        thisdata.fieldDesc = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+thisdata.fieldDesc;
                                                    }

                                                    if(thisdata.readonly == 1){
                                                        disabled = 'disabled';
                                                    }
                                                    if(j == data[i].children.length-1){
                                                        var style = 'style="margin: 13px 0 50px 0;"';
                                                    }else{
                                                        var style = '';
                                                    }
                                                    if(thisdata.fieldType==1){ //单行文本
                                                        item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                if(thisdata.ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[thisdata.fieldId] != undefined){
                                                                    return   '<input '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" value="'+data1object[thisdata.fieldId]+'">'

                                                                }else{
                                                                    return   '<input '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" >';

                                                                }
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>';
                                                        $('#report1').append(item1)
                                                    }
                                                    if(thisdata.fieldType==2 ){ //单行数字
                                                        item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                if(thisdata.ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+
                                                            function () {
                                                                if(thisdata.fieldDesc==undefined || thisdata.fieldDesc=='' ){
                                                                    return '<span  style="color: red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;要求为数字</span>'
                                                                }else{
                                                                    return thisdata.fieldDesc+'<span style="color: red;margin-left: 10px;">要求为数字</span>'
                                                                }
                                                            }()
                                                            +'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[thisdata.fieldId] != undefined){
                                                                    /*if((thisdata.fieldName=='人员总数')&& res.object.repTableId==1){
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleTotal testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                    }else if((thisdata.fieldName=='在沪人员：核查人数'|| thisdata.fieldName=='在湖北：核查人数'|| thisdata.fieldName=='在其它地区：核查人数'|| thisdata.fieldName=='返校途中：核查人数'|| thisdata.fieldName=='失联人数')&& res.object.repTableId==1 ){
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleNum testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                    }else{
                                                                        return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                    }*/
                                                                    return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[thisdata.fieldId]+'">'
                                                                }else{
                                                                    return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" >'

                                                                }

                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>';
                                                        $('#report1').append(item1)
                                                    }
                                                    if(thisdata.fieldType==3 ){ //多行文本
                                                        item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                if(thisdata.ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[thisdata.fieldId] != undefined){
                                                                    return   '<textarea '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+data1object[thisdata.fieldId]+'</textarea>'

                                                                }else{
                                                                    return   '<textarea '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+'</textarea>'

                                                                }
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>';
                                                        $('#report1').append(item1)
                                                    }
                                                    if(thisdata.fieldType==4 ){ //日期
                                                        item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                if(thisdata.ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                            ' <div class="item2">' +
                                                            function () {
                                                                if(data1object[thisdata.fieldId] != undefined){
                                                                    return  '<input '+ disabled +' ismust="'+thisdata.ismust+'"  fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'" value="'+data1object[thisdata.fieldId]+'">'

                                                                }else{
                                                                    return  '<input '+ disabled +' ismust="'+thisdata.ismust+'"  fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'">'

                                                                }
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>';
                                                        $('#report1').append(item1)
                                                        //执行一个laydate实例
                                                        laydate.render({
                                                            elem: '#test' +[z]//指定元素
                                                        });
                                                        z++;
                                                    }
                                                    if(thisdata.fieldType==5){ //单选
                                                        item1 +=' <div class="itemTotal" '+ style +'>\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                if(thisdata.ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                            ' <div class="item2 radio" ismust="'+thisdata.ismust+'" fieldName="'+thisdata.fieldName+'" > ' +
                                                            function () {
                                                                var arr=thisdata.fieldContent.split('/')
                                                                var str='';
                                                                if(data1object[thisdata.fieldId] != undefined){
                                                                    for(var k=0;k<arr.length;k++){
                                                                        if(data1object[thisdata.fieldId] == arr[k]){
                                                                            str+= '<div><input '+ disabled +' fieldId="'+thisdata.fieldId+'" type="radio" name="'+thisdata.fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                        }else{
                                                                            str+= '<div><input '+ disabled +' fieldId="'+thisdata.fieldId+'" type="radio" name="'+thisdata.fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                        }
                                                                    }
                                                                }else{
                                                                    for(var k=0;k<arr.length;k++){
                                                                        str+= '<div><input '+ disabled +' fieldId="'+thisdata.fieldId+'" type="radio" name="'+thisdata.fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    }
                                                                }
                                                                return   str
                                                            }()+
                                                            '</div>\n' +
                                                            '            </div>';
                                                        $('#report1').append(item1);
                                                        form.render('radio')
                                                    }
                                                    if(thisdata.fieldType==6 ){ //多选
                                                        item1 +=' <div class="itemTotal" '+ style +'>\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                if(thisdata.ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                            ' <div class="item2 checkbox" ismust="'+thisdata.ismust+'"  fieldName="'+thisdata.fieldName+'">\n' +
                                                            function () {
                                                                var arr=thisdata.fieldContent.split('/')
                                                                var str=''
                                                                if(data1object[thisdata.fieldId] != undefined){
                                                                    for(var k=0;k<arr.length;k++){
                                                                        if(data1object[thisdata.fieldId].indexOf(arr[k]) != -1){
                                                                            str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                        }else{
                                                                            str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                        }
                                                                    }
                                                                }else{
                                                                    for(var k=0;k<arr.length;k++){
                                                                        str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    }
                                                                }
                                                                return str
                                                            }()+
                                                            '  </div>\n' +
                                                            '            </div>'
                                                        $('#report1').append(item1)
                                                        form.render('checkbox')
                                                    }
                                                    if(thisdata.fieldType==7){ //附件
                                                        var fileD = '#'+"fileupload"+i
                                                        var all= '#'+"fileAll"+i
                                                        var strfile = '';
                                                        if(data1object2[data[i].fieldId] != undefined){
                                                            var  dataFile = data1object2[data[i].fieldId]
                                                        }else{
                                                            var  dataFile = ''
                                                        }
                                                        if(dataFile !=undefined && dataFile.length>0){
                                                            for(var l=0;l<dataFile.length;l++){
                                                                var fileExtension=dataFile[l].attachName.substring(dataFile[l].attachName.lastIndexOf(".")+1,dataFile[l].attachName.length);//截取附件文件后缀
                                                                var attName = encodeURI(dataFile[l].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                                                var deUrl = dataFile[l].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+dataFile[l].size;
                                                                strfile += '<div class="dech" deUrl="' + deUrl+ '" attachid="'+dataFile[l].attachId+'"  name ="'+dataFile[l].attachName+'">' +
                                                                    '<a NAME="' + dataFile[l].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                                                    '<img  src="/img/attachment_icon.png"/>' + dataFile[l].attachName + '</a>' +
                                                                    // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>删除' +
                                                                    '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                                    '<a class="download" style="padding-left: 5px;" href="/download?'+encodeURI(deUrl)+'" >' +
                                                                    '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                                                    '<input type="hidden" class="inHidden" value="' + dataFile[l].aid + '@' + dataFile[l].ym + '_' +dataFile[l].attachId + ',">' +
                                                                    '</div>'
                                                            }

                                                        }else{
                                                            strfile='';
                                                        }
                                                        item1 +=' <div class="itemTotal itemTotal11" '+ style +' fileD="fileupload'+i+'"  all="fileAll'+i+'">\n' +
                                                            ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                                if(thisdata.ismust==1){
                                                                    return '(必填)'
                                                                }else {
                                                                    return ''
                                                                }
                                                            }()+'</span></div>\n' +
                                                            // '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                            ' <div class="item2 file" ismust="'+thisdata.ismust+'" fieldName="'+thisdata.fieldName+'" > \n' +
                                                            function () {
                                                                var arr=thisdata.fieldContent.split('/')
                                                                var str=''
                                                                for(var k=0;k<arr.length;k++){
                                                                    // str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    str+= '    <div class="layui-input-inline  fieldId" file="file" lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'">\n' +
                                                                        '<div id="fujians"></div>' +
                                                                        ' <div class="aaa" id="fileAll'+i+'">\n' +strfile+
                                                                        '</div>\n' +
                                                                        // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                                                                        // '<img src="../img/mg11.png" alt="">\n' +
                                                                        // '<span>添加附件</span>\n' +
                                                                        // '<input type="file" class="fileupload" multiple id="fileupload'+i+'"  data-url="/upload?module=detaReport" name="file">\n' +
                                                                        // '</a>\n' +
                                                                        '</div>\n'
                                                                }
                                                                return   str
                                                            }()+
                                                            '    </div>\n' +
                                                            '            </div>';
                                                        $('#report1').append(item1)
                                                        fileuploadFn(fileD, $(all));
                                                    }
                                                    item1 = '';
                                                    num++;
                                                }
                                            }else{
                                                if(data[i].readonly == 1){
                                                    disabled = 'disabled';
                                                }
                                                if(data[i].fieldType==1){ //单行文本
                                                    var item1=''
                                                    item1+=' <div class="itemTotal">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                            if(data[i].ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                        ' <div class="item2">' +
                                                        function () {
                                                            if(data1object[data[i].fieldId] != undefined){
                                                                return   '<input '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" value="'+data1object[data[i].fieldId]+'">'

                                                            }else{
                                                                return   '<input '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" >'

                                                            }
                                                        }()+
                                                        '</div>\n' +
                                                        '            </div>'
                                                    $('#report1').append(item1)
                                                }
                                                if(data[i].fieldType==2 ){ //单行数字
                                                    var item2=''
                                                    item2+=' <div class="itemTotal">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                            if(data[i].ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+
                                                        function () {
                                                            if(data[i].fieldDesc==undefined || data[i].fieldDesc=='' ){
                                                                return '<span  style="color: red;">要求为数字</span>'
                                                            }else{
                                                                return data[i].fieldDesc+'<span style="color: red;margin-left: 10px;">要求为数字</span>'
                                                            }
                                                        }()
                                                        +'</div>'+
                                                        ' <div class="item2">' +
                                                        function () {
                                                            if(data1object[data[i].fieldId] != undefined){
                                                                /*if((data[i].fieldName=='人员总数')&& res.object.repTableId==1){
                                                                    return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleTotal testNum" value="'+data1object[data[i].fieldId]+'">'
                                                                }else if((data[i].fieldName=='在沪人员：核查人数'|| data[i].fieldName=='在湖北：核查人数'|| data[i].fieldName=='在其它地区：核查人数'|| data[i].fieldName=='返校途中：核查人数'|| data[i].fieldName=='失联人数')&& res.object.repTableId==1 ){
                                                                    return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleNum testNum" value="'+data1object[data[i].fieldId]+'">'
                                                                }else{
                                                                    return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[data[i].fieldId]+'">'
                                                                }*/
                                                                return  '<input '+ disabled +' oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum" value="'+data1object[data[i].fieldId]+'">'
                                                            }else{
                                                                return   '<input '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust" >'

                                                            }
                                                        }()+
                                                        '</div>\n' +
                                                        '            </div>'
                                                    $('#report1').append(item2)
                                                }
                                                if(data[i].fieldType==3 ){ //多行文本
                                                    var item3=''
                                                    item3+=' <div class="itemTotal">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                            if(data[i].ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                        ' <div class="item2">' +
                                                        function () {
                                                            if(data1object[data[i].fieldId] != undefined){
                                                                return   '<textarea '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+data1object[data[i].fieldId]+'</textarea>'

                                                            }else{
                                                                return   '<textarea '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+'</textarea>'

                                                            }

                                                        }()+
                                                        '</div>\n' +
                                                        '            </div>'
                                                    $('#report1').append(item3)
                                                }
                                                if(data[i].fieldType==4 ){ //日期
                                                    var item4=''
                                                    item4+=' <div class="itemTotal">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                            if(data[i].ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                        ' <div class="item2">' +
                                                        function () {
                                                            if(data1object[data[i].fieldId] != undefined){
                                                                return  '<input '+ disabled +' ismust="'+data[i].ismust+'"  fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'" value="'+data1object[data[i].fieldId]+'">'

                                                            }else{
                                                                return  '<input '+ disabled +' ismust="'+data[i].ismust+'"  fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'">'

                                                            }
                                                        }()+
                                                        '</div>\n' +
                                                        '            </div>'
                                                    $('#report1').append(item4)
                                                    //执行一个laydate实例
                                                    laydate.render({
                                                        elem: '#test' +[z]//指定元素
                                                    });
                                                    z++;
                                                }
                                                if(data[i].fieldType==5){ //单选
                                                    var item5=''
                                                    item5+=' <div class="itemTotal">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                            if(data[i].ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                        ' <div class="item2 radio" ismust="'+data[i].ismust+'" fieldName="'+data[i].fieldName+'" > ' +
                                                        function () {
                                                            var arr=data[i].fieldContent.split('/')
                                                            var str=''
                                                            if(data1object[data[i].fieldId] != undefined){
                                                                for(var k=0;k<arr.length;k++){
                                                                    if(data1object[data[i].fieldId]==arr[k]){
                                                                        str+= '<div><input '+ disabled +' fieldId="'+data[i].fieldId+'" type="radio" name="'+data[i].fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                    }else{
                                                                        str+= '<div><input '+ disabled +' fieldId="'+data[i].fieldId+'" type="radio" name="'+data[i].fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    }
                                                                }
                                                            }else{
                                                                for(var k=0;k<arr.length;k++){
                                                                    str+= '<div><input '+ disabled +' fieldId="'+data[i].fieldId+'" type="radio" name="'+data[i].fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                }
                                                            }
                                                            return   str
                                                        }()+
                                                        '</div>\n' +
                                                        '            </div>'
                                                    $('#report1').append(item5)
                                                    form.render('radio')
                                                }
                                                if(data[i].fieldType==6 ){ //多选
                                                    var item6=''
                                                    item6+=' <div class="itemTotal">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                            if(data[i].ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                        ' <div class="item2 checkbox" ismust="'+data[i].ismust+'"  fieldName="'+data[i].fieldName+'">\n' +
                                                        function () {
                                                            var arr=data[i].fieldContent.split('/')
                                                            var str=''
                                                            if(data1object[data[i].fieldId] != undefined){
                                                                for(var k=0;k<arr.length;k++){
                                                                    if(data1object[data[i].fieldId].indexOf(arr[k]) != -1){
                                                                        str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" checked ></div>'
                                                                    }else{
                                                                        str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                    }
                                                                }
                                                            }else{
                                                                for(var k=0;k<arr.length;k++){
                                                                    str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                }
                                                            }

                                                            return str
                                                        }()+
                                                        '  </div>\n' +
                                                        '            </div>'
                                                    $('#report1').append(item6)
                                                    form.render('checkbox')
                                                }
                                                if(data[i].fieldType==7){ //附件
                                                    var fileD = '#'+"fileupload"+i
                                                    var all= '#'+"fileAll"+i
                                                    var strfile = '';
                                                    var item7 = ''
                                                    if(data1object2[data[i].fieldId] != undefined){
                                                        var  dataFile = data1object2[data[i].fieldId]
                                                    }else{
                                                        var  dataFile = ''
                                                    }
                                                    if(dataFile !=undefined && dataFile.length>0){
                                                        for(var l=0;l<dataFile.length;l++){
                                                            var fileExtension=dataFile[l].attachName.substring(dataFile[l].attachName.lastIndexOf(".")+1,dataFile[l].attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(dataFile[l].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                                            var deUrl = dataFile[l].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+dataFile[l].size;
                                                            strfile += '<div class="dech" deUrl="' + deUrl+ '" attachid="'+dataFile[l].attachId+'"  name ="'+dataFile[l].attachName+'">' +
                                                                '<a NAME="' + dataFile[l].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                                                '<img  src="/img/attachment_icon.png"/>' + dataFile[l].attachName + '</a>' +
                                                                // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>删除' +
                                                                '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                                                '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                                '<a class="download" style="padding-left: 5px;" href="/download?'+encodeURI(deUrl)+'" >' +
                                                                '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                                                '<input type="hidden" class="inHidden" value="' + dataFile[l].aid + '@' + dataFile[l].ym + '_' +dataFile[l].attachId + ',">' +
                                                                '</div>'
                                                        }

                                                    }else{
                                                        strfile='';
                                                    }
                                                    item7 +=' <div class="itemTotal itemTotal11" '+ style +' fileD="fileupload'+i+'"  all="fileAll'+i+'">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                            if(data[i].ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        // '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                        ' <div class="item2 file" ismust="'+data[i].ismust+'" fieldName="'+data[i].fieldName+'" > \n' +
                                                        function () {
                                                            var arr=data[i].fieldContent.split('/')
                                                            var str=''
                                                            for(var k=0;k<arr.length;k++){
                                                                // str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                str+= '    <div class="layui-input-inline  fieldId" file="file" lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'">\n' +
                                                                    '<div id="fujians"></div>' +
                                                                    ' <div class="aaa" id="fileAll'+i+'">\n' +strfile+
                                                                    '</div>\n' +
                                                                    // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                                                                    // '<img src="../img/mg11.png" alt="">\n' +
                                                                    // '<span>添加附件</span>\n' +
                                                                    // '<input type="file" class="fileupload" multiple id="fileupload'+i+'"  data-url="/upload?module=detaReport" name="file">\n' +
                                                                    // '</a>\n' +
                                                                    '</div>\n'
                                                            }
                                                            return   str
                                                        }()+
                                                        '    </div>\n' +
                                                        '            </div>';
                                                    $('#report1').append(item7)
                                                    // $('#report').append(item1)
                                                    fileuploadFn(fileD, $(all));
                                                }
                                                num++;
                                            }

                                        }
                                        addNumBtn();
                                    }
                                })
                            },
                            yes:function(index){
                                layer.close(index);
                            },
                        });

                    }
                });
                //移动端右侧返回
                $('#backTable').on('click',function(){
                    if(mobiletype){
                        $('.layui-col-xs9').hide();
                        $('.layui-col-xs3 ').show();
                    }
                });
                //右侧新建
                $('#addTable').on('click',function(){
                    var tableId=$('.select').attr('tableId')
                    layer.open({
                        type: 1,
                        title: '新建',
                        // shadeClose: true,
                        btn:['确定','取消'],
                        shade: 0.5,
                        maxmin: true, //开启最大化最小化按钮
                        area: ['75%', '90%'],
                        content:' <div class="layui-form" id="report">' +
                            '</div>',
                        success:function(){
                            // console.log($(window).width())
                            if($(window).width()<768){
                                $('.layui-layer').width('90%')
                                $('.layui-layer').css('left','20px')
                            }else if($(window).width()>=768&&$(window).width()<=992){
                                $('.layui-layer').width('80%')
                            }else if($(window).width()>=992&&$(window).width()<=1200){
                                $('.layui-layer').width('70%')
                            }else if($(window).width()>=1200){
                                $('.layui-layer').width('60%')
                                $('.layui-layer').css('left','300px')
                            }
                            $.ajax({
                                url:'/repField/getFieldByTableId?type=1&tableId='+$('.select').attr('tableId'),
                                type:'get',
                                dataType:'json',
                                success:function(res){
                                    var data=res.object.repFieldList;
                                    $('#report').attr('repTableId',res.object.repTableId);
                                    var z= 0;
                                    var num = 0;
                                    var gs = '';
                                    for(var i=0;i<data.length;i++){
                                        var disabled = '';
                                        if(data[i].children != undefined){
                                            var item1='<div class="itemTotal">\n' +
                                                ' <hr class="layui-bg-gray" style="width: 92%;margin: 15px auto 10px auto;height: 2px;"><div class="item1"><span class="fieldName">'+data[i].fieldGroup+'：</span></div>\n';
                                            for(var j=0;j<data[i].children.length;j++){
                                                var thisdata = data[i].children[j];
                                                var fieldName = thisdata.fieldName;
                                                if(fieldName.indexOf('：') > -1){
                                                    fieldName = '&nbsp;&nbsp;&nbsp;&nbsp;'+fieldName.split('：')[1];
                                                }
                                                if(thisdata.fieldDesc!=undefined && thisdata.fieldDesc!=''){
                                                    thisdata.fieldDesc = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+thisdata.fieldDesc;
                                                }
                                                if(thisdata.readonly == 1){
                                                    disabled = 'disabled';
                                                }
                                                if(j == data[i].children.length-1){
                                                    var style = 'style="margin: 13px 0 50px 0;"';
                                                }else{
                                                    var style = '';
                                                }
                                                gs = thisdata.fieldContent;
                                                var value = '';
                                                if(thisdata.fieldType==2){
                                                    var value = '0';
                                                }
                                                if(gs == '[姓名]'&&userobject['flag'] == true){
                                                    var value = userobject.object.userName||'';
                                                }else if(gs == '[部门]'&&userobject['flag'] == true){
                                                    var value = userobject.object.deptName||'';
                                                }else if(gs == '[手机号]'&&userobject['flag'] == true){
                                                    var value = userobject.object.mobilNo||'';
                                                }
                                                if(thisdata.fieldType==1){ //单行文本
                                                    item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                            if(thisdata.ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                        ' <div class="item2"><input '+ disabled +' value="'+ value +'"  ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="'+thisdata.fieldName+'" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust"></div>\n' +
                                                        '            </div>';
                                                    $('#report').append(item1);

                                                }
                                                if(thisdata.fieldType==2){ //单行数字
                                                    item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                            if(thisdata.ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+
                                                        function () {
                                                            if(thisdata.fieldDesc==undefined || thisdata.fieldDesc==''){
                                                                return '<span  style="color: red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;要求为数字</span>'
                                                            }else{
                                                                return thisdata.fieldDesc+'<span style="color: red;margin-left: 10px;">要求为数字</span>'

                                                            }
                                                        }()
                                                        +'</div>'+
                                                        ' <div class="item2">' +
                                                        function () {
                                                            if((data[i].fieldName=='人员总数')&& res.object.repTableId==1){
                                                                return  '<input '+ disabled +' value="'+ value +'"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleTotal testNum">'
                                                            }else if((data[i].fieldName=='在沪人员：核查人数'|| data[i].fieldName=='在湖北：核查人数'|| data[i].fieldName=='在其它地区：核查人数'|| data[i].fieldName=='返校途中：核查人数'|| thisdata.fieldName=='失联人数')&& res.object.repTableId==1){
                                                                return  '<input '+ disabled +' value="'+ value +'"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleNum testNum">'
                                                            }
                                                            else{
                                                                return  '<input '+ disabled +' value="'+ value +'"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum ">'
                                                            }
                                                        }()+
                                                        '</div>\n' +
                                                        '            </div>';
                                                    $('#report').append(item1);
                                                }
                                                if(thisdata.fieldType==3){ //多行文本
                                                    item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                            if(thisdata.ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                        ' <div class="item2"><textarea '+ disabled +' ismust="'+thisdata.ismust+'" fieldType="'+thisdata.fieldType+'" fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'"  fieldSize="'+thisdata.fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+ value +'</textarea></div>\n' +
                                                        '            </div>';
                                                    $('#report').append(item1);
                                                }
                                                if(thisdata.fieldType==4){ //日期
                                                    item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                            if(thisdata.ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                        ' <div class="item2"><input '+ disabled +'  ismust="'+thisdata.ismust+'"  fieldName="'+thisdata.fieldName+'" fieldId="'+thisdata.fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'"></div>\n' +
                                                        '            </div>';
                                                    $('#report').append(item1);
                                                    //执行一个laydate实例
                                                    laydate.render({
                                                        elem: '#test' +[z]//指定元素
                                                    });
                                                    z++;
                                                }
                                                if(thisdata.fieldType==5){ //单选
                                                    item1+=' <div class="itemTotal" '+ style +'>\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+thisdata.fieldName+'</span><span class="required">'+function () {
                                                            if(thisdata.ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                        ' <div class="item2 radio" ismust="'+thisdata.ismust+'" fieldName="'+thisdata.fieldName+'" > ' +
                                                        function () {
                                                            var arr=thisdata.fieldContent.split('/')
                                                            var str=''
                                                            for(var k=0;k<arr.length;k++){
                                                                str+= '<div><input '+ disabled +' fieldId="'+thisdata.fieldId+'" type="radio" name="'+thisdata.fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                            }
                                                            return   str
                                                        }()+
                                                        ' </div>';
                                                    $('#report').append(item1)
                                                    form.render('radio')
                                                }
                                                if(thisdata.fieldType==6){ //多选
                                                    item1 +=' <div class="itemTotal" '+ style +'>\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                            if(thisdata.ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                        ' <div class="item2 checkbox" ismust="'+thisdata.ismust+'" fieldName="'+thisdata.fieldName+'" > \n' +
                                                        function () {
                                                            var arr=thisdata.fieldContent.split('/')
                                                            var str=''
                                                            for(var k=0;k<arr.length;k++){
                                                                str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                            }
                                                            return   str
                                                        }()+
                                                        '    </div>\n' +
                                                        '            </div>';
                                                    $('#report').append(item1)
                                                    form.render('checkbox')
                                                }
                                                if(thisdata.fieldType==7){ //附件
                                                    var fileD = '#'+"fileupload"+i
                                                    var all= '#'+"fileAll"+i
                                                    item1 +=' <div class="itemTotal itemTotal11" '+ style +' fileD="fileupload'+i+'"  all="fileAll'+i+'">\n' +
                                                        ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+fieldName+'</span><span class="required">'+function () {
                                                            if(thisdata.ismust==1){
                                                                return '(必填)'
                                                            }else {
                                                                return ''
                                                            }
                                                        }()+'</span></div>\n' +
                                                        // '<div class="fieldDesc">'+thisdata.fieldDesc+'</div>'+
                                                        ' <div class="item2 file" ismust="'+thisdata.ismust+'" fieldName="'+thisdata.fieldName+'" > \n' +
                                                        function () {
                                                            var arr=thisdata.fieldContent.split('/')
                                                            var str=''
                                                            for(var k=0;k<arr.length;k++){
                                                                // str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                                str+= '    <div class="layui-input-inline fieldId" file="file" lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'">\n' +
                                                                    '<div id="fujians"></div>' +
                                                                    ' <div class="aaa"  id="fileAll'+i+'">\n' +
                                                                    '</div>\n' +
                                                                    '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                                                                    '<img src="../img/mg11.png" alt="">\n' +
                                                                    '<span>添加附件</span>\n' +
                                                                    '<input type="file" class="fileupload" multiple id="fileupload'+i+'" data-url="/upload?module=detaReport" name="file">\n' +
                                                                    '</a>\n' +
                                                                    '</div>\n'
                                                            }
                                                            return   str
                                                        }()+
                                                        '    </div>\n' +
                                                        '            </div>';

                                                    $('#report').append(item1)
                                                    fileuploadFn(fileD, $(all));
                                                }
                                                item1 = '';

                                                num++;
                                            }

                                        }else{
                                            if(data[i].readonly == 1){
                                                disabled = 'disabled';
                                            }
                                            gs = data[i].fieldContent;
                                            var value = '';
                                            if(data[i].fieldType==2){
                                                var value = '0';
                                            }
                                            if(gs == '[姓名]'&&userobject['flag'] == true){
                                                var value = userobject.object.userName||'';
                                            }else if(gs == '[部门]'&&userobject['flag'] == true){
                                                var value = userobject.object.deptName||'';
                                            }else if(gs == '[手机号]'&&userobject['flag'] == true){
                                                var value = userobject.object.mobilNo||'';
                                            }
                                            if(data[i].fieldType==1){ //单行文本
                                                var item1=''
                                                item1+=' <div class="itemTotal">\n' +
                                                    ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                        if(data[i].ismust==1){
                                                            return '(必填)'
                                                        }else {
                                                            return ''
                                                        }
                                                    }()+'</span></div>\n' +
                                                    '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                    ' <div class="item2"><input '+ disabled +' value="'+ value +'"  ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="'+data[i].fieldName+'" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust"></div>\n' +
                                                    '            </div>'
                                                $('#report').append(item1)
                                            }
                                            if(data[i].fieldType==2){ //单行数字
                                                var item2=''
                                                item2+=' <div class="itemTotal">\n' +
                                                    ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                        if(data[i].ismust==1){
                                                            return '(必填)'
                                                        }else {
                                                            return ''
                                                        }
                                                    }()+'</span></div>\n' +
                                                    '<div class="fieldDesc">'+
                                                    function () {
                                                        if(data[i].fieldDesc==undefined || data[i].fieldDesc==''){
                                                            return '<span  style="color: red;">要求为数字</span>'
                                                        }else{
                                                            return data[i].fieldDesc+'<span style="color: red;margin-left: 10px;">要求为数字</span>'

                                                        }
                                                    }()
                                                    +'</div>'+
                                                    ' <div class="item2">' +
                                                    function () {
                                                        if((data[i].fieldName=='人员总数')&& res.object.repTableId==1){
                                                            return  '<input '+ disabled +' value="'+ value +'"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleTotal testNum">'
                                                        }else if((data[i].fieldName=='在沪人员：核查人数'|| data[i].fieldName=='在湖北：核查人数'|| data[i].fieldName=='在其它地区：核查人数'|| data[i].fieldName=='返校途中：核查人数'|| data[i].fieldName=='失联人数')&& res.object.repTableId==1){
                                                            return  '<input '+ disabled +' value="'+ value +'"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleNum testNum">'
                                                        }
                                                        else{
                                                            return  '<input '+ disabled +' value="'+ value +'"  oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum ">'
                                                        }
                                                    }()+
                                                    '</div>\n' +
                                                    '            </div>'
                                                $('#report').append(item2)
                                            }
                                            if(data[i].fieldType==3){ //多行文本
                                                var item3=''
                                                item3+=' <div class="itemTotal">\n' +
                                                    ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                        if(data[i].ismust==1){
                                                            return '(必填)'
                                                        }else {
                                                            return ''
                                                        }
                                                    }()+'</span></div>\n' +
                                                    '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                    ' <div class="item2"><textarea '+ disabled +' ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust">'+ value +'</textarea></div>\n' +
                                                    '            </div>'
                                                $('#report').append(item3)
                                            }
                                            if(data[i].fieldType==4){ //日期
                                                var item4=''
                                                item4+=' <div class="itemTotal">\n' +
                                                    ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                        if(data[i].ismust==1){
                                                            return '(必填)'
                                                        }else {
                                                            return ''
                                                        }
                                                    }()+'</span></div>\n' +
                                                    '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                    ' <div class="item2"><input '+ disabled +' ismust="'+data[i].ismust+'"  fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'" type="text" class="layui-input fieldId ismust" id="test'+[z]+'"></div>\n' +
                                                    '            </div>'
                                                $('#report').append(item4)
                                                //执行一个laydate实例
                                                laydate.render({
                                                    elem: '#test' +[z]//指定元素
                                                });
                                                z++;
                                            }
                                            if(data[i].fieldType==5){ //单选
                                                var item5=''
                                                item5+=' <div class="itemTotal">\n' +
                                                    ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                        if(data[i].ismust==1){
                                                            return '(必填)'
                                                        }else {
                                                            return ''
                                                        }
                                                    }()+'</span></div>\n' +
                                                    '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                    ' <div class="item2 radio" ismust="'+data[i].ismust+'" fieldName="'+data[i].fieldName+'" > ' +
                                                    function () {
                                                        var arr=data[i].fieldContent.split('/')
                                                        var str=''
                                                        for(var k=0;k<arr.length;k++){
                                                            str+= '<div><input '+ disabled +' fieldId="'+data[i].fieldId+'" type="radio" name="'+data[i].fieldId+'" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                        }
                                                        return   str
                                                    }()+
                                                    ' </div>'
                                                $('#report').append(item5)
                                                form.render('radio')
                                            }
                                            if(data[i].fieldType==6){ //多选
                                                var item6=''
                                                item6+=' <div class="itemTotal">\n' +
                                                    ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                        if(data[i].ismust==1){
                                                            return '(必填)'
                                                        }else {
                                                            return ''
                                                        }
                                                    }()+'</span></div>\n' +
                                                    '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                    ' <div class="item2 checkbox" ismust="'+data[i].ismust+'" fieldName="'+data[i].fieldName+'" > \n' +
                                                    function () {
                                                        var arr=data[i].fieldContent.split('/')
                                                        var str=''
                                                        for(var k=0;k<arr.length;k++){
                                                            str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                        }
                                                        return   str
                                                    }()+
                                                    '    </div>\n' +
                                                    '            </div>'
                                                $('#report').append(item6)
                                                form.render('checkbox')
                                            }
                                            if(data[i].fieldType==7){
                                                var item7 = '';
                                                var fileD = '#'+"fileupload"+i
                                                var all= '#'+"fileAll"+i
                                                item7 +=' <div class="itemTotal itemTotal11" '+ style +' fileD="fileupload'+i+'"  all="fileAll'+i+'">\n' +
                                                    ' <div class="item1"><span class="num">'+[num+1]+'</span><span class="fieldName">'+data[i].fieldName+'</span><span class="required">'+function () {
                                                        if(data[i].ismust==1){
                                                            return '(必填)'
                                                        }else {
                                                            return ''
                                                        }
                                                    }()+'</span></div>\n' +
                                                    // '<div class="fieldDesc">'+data[i].fieldDesc+'</div>'+
                                                    ' <div class="item2 file" ismust="'+data[i].ismust+'" fieldName="'+data[i].fieldName+'" > \n' +
                                                    function () {
                                                        var arr=data[i].fieldContent.split('/')
                                                        var str=''
                                                        for(var k=0;k<arr.length;k++){
                                                            // str+= '<div style="margin: 5px 0px;"><input '+ disabled +' lay-skin="primary" fieldId="'+thisdata.fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'" ></div>'
                                                            str+= '    <div class="layui-input-inline  fieldId" file="file" lay-skin="primary" fieldId="'+data[i].fieldId+'" type="checkbox" name="" value="'+arr[k]+'" title="'+arr[k]+'">\n' +
                                                                '<div id="fujians"></div>' +
                                                                ' <div class="aaa" id="fileAll'+i+'">\n' +
                                                                '</div>\n' +
                                                                '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                                                                '<img src="../img/mg11.png" alt="">\n' +
                                                                '<span>添加附件</span>\n' +
                                                                '<input type="file" class="fileupload" multiple id="fileupload'+i+'"  data-url="/upload?module=detaReport" name="file">\n' +
                                                                '</a>\n' +
                                                                '</div>\n'
                                                        }
                                                        return   str
                                                    }()+
                                                    '    </div>\n' +
                                                    '            </div>';

                                                $('#report').append(item7)
                                                fileuploadFn(fileD, $(all));
                                            }
                                            num++;
                                        }

                                    }

                                    addNumBtn();
                                }
                            })




                        },
                        yes:function(index){
                            for(var r=0;r<$('.radio input').length;r++){
                                if($('.radio input').eq(r).next().hasClass('layui-form-radioed')){
                                    $('.radio input').eq(r).addClass('fieldId')
                                }
                            }
                            for(var c=0;c<$('.checkbox input').length;c++){
                                if($('.checkbox input').eq(c).next().hasClass('layui-form-checked')){
                                    $('.checkbox input').eq(c).addClass('fieldId')
                                }
                            }
                            for(var t=0;t<$('.testNum').length;t++){
                                var tt=$('.testNum').eq(t).val()
                                var fieldname=$('.testNum').eq(t).attr('fieldname');
                                if(tt != ''){
                                    if(tt.length!==1){
                                        if(tt.split('.').length-1 >1){
                                            layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                            return false
                                        }
                                        if(tt.substring(0,1)==0 && tt.substring(1,2)!=='.'){
                                            layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                            return false
                                        }
                                        if(tt.substring(0,1)==0 &&tt.substring(1,2)=='.'&&tt.substring(2,3)==''){
                                            layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                            return false
                                        }
                                        if(tt.substring(0,1)=='.'){
                                            layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                            return false
                                        }
                                    }else {
                                        if(tt=='.'){
                                            layer.msg('请检验'+fieldname+'是否是整数或者小数', {icon: 0});
                                            return false
                                        }
                                    }
                                }

                            }
                            /*//提示用户输入字段类型
                            for(var i=0;i<$('.fieldType').length;i++){
                                if((!isNaN($('.fieldType').eq(i).val()))&&$('.fieldType').eq(i).attr('fieldType')==1){
                                    layer.msg('请将'+$('.fieldType').eq(i).attr('fieldname')+'输入为文本', {icon: 0});
                                    return false
                                }
                                // if((isNaN($('.fieldType').eq(i).val()))&&$('.fieldType').eq(i).attr('fieldType')==2){
                                //     layer.msg('请将'+$('.fieldType').eq(i).attr('fieldname')+'输入为数字', {icon: 0});
                                //     return false
                                // }
                                if((!isNaN($('.fieldType').eq(i).val()))&&$('.fieldType').eq(i).attr('fieldType')==3){
                                    layer.msg('请将'+$('.fieldType').eq(i).attr('fieldname')+'输入为文本', {icon: 0});
                                    return false
                                }
                            }*/
                            //限制用户输入字段长度
                            var fieldSize=$('.fieldSize')
                            for(var i=0;i<fieldSize.length;i++){
                                var fieldSizeValueLength=fieldSize.eq(i).val().split('').length
                                var fieldSizeLength=fieldSize.eq(i).attr('fieldSize')
                                var fieldname=fieldSize.eq(i).attr('fieldname')
                                if(fieldSizeValueLength>fieldSizeLength){
                                    layer.msg(fieldname+'长度不能大于'+fieldSizeLength, {icon: 0});
                                    return false
                                }
                            }
                            //判断输入是否有空值
                            for(var i=0;i<$('.ismust').length;i++){
                                if($('.ismust').eq(i).val()==''&&$('.ismust').eq(i).attr('ismust')==1){
                                    layer.msg($('.ismust').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                    return false
                                }
                            }
                            //校验数据符合要求
                            if($('.pepleTotal').val()!==undefined){
                                var pepleTotal=$('.pepleTotal').val()
                                var sum=0
                                for(var i=0;i<$('.pepleNum').length;i++){
                                    sum += parseInt($('.pepleNum').eq(i).val())
                                }
                                if((pepleTotal-sum)!==0){
                                    layer.msg('请检查数据符合以下要求：学生总数（教职员工）-在沪核查人数-在湖北核查人数-在其他地区核查人数-在返校途中核查人数-失联人数=0', {icon: 0});
                                    return false
                                }
                            }
                            //判断单选是否没选
                            for (var i=0;i<$('.radio ').length;i++) {
                                if(!$('.radio').eq(i).find('div').hasClass('layui-form-radioed')){
                                    layer.msg($('.radio').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                    return false
                                }
                            }
                            //判断多选是否没选
                            for (var i=0;i<$('.checkbox ').length;i++) {
                                if(!$('.checkbox').eq(i).find('div').hasClass('layui-form-checked')){
                                    layer.msg($('.checkbox').eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                    return false
                                }
                            }
                            //判断附件是否上传
                            var file=$('.file')
                            for(var i=0;i<file.length;i++){
                                if(file.eq(i).find('.dech').length < 1 && $('.ismust').eq(i).attr('ismust')==1){
                                    layer.msg(file.eq(i).attr('fieldname')+'为必填项', {icon: 0});
                                    return false
                                }
                            }

                            //获取fieldId和data
                            var map = {};
                            for(var i=0;i<$('.fieldId').length;i++){

                                if($('.fieldId').eq(i).attr('file') == 'file'){
                                    var fieldValueId = {}
                                    // var fieldValueName = {}
                                    var fileId = ''
                                    var fileName = ''
                                    // let obj ={}
                                    var fieldId=$('.fieldId').eq(i).attr('fieldId')
                                    for(var t=0;t<$('.fieldId').eq(i).find('.dech').length;t++){
                                        fileId+=($('.fieldId').eq(i).find('.dech').eq(t).attr('attachid'))+','
                                        fileName+=($('.fieldId').eq(i).find('.dech').eq(t).attr('name'))+'*'
                                    }

                                    fieldValueId.attachId =fileId;
                                    fieldValueId.attachName =fileName;
                                    var fieldValue = JSON.stringify(fieldValueId)

                                }else {
                                    var fieldId=$('.fieldId').eq(i).attr('fieldId')
                                    var fieldValue=$('.fieldId').eq(i).val()
                                }
                                if(map[fieldId] != undefined){
                                    map[fieldId] += '/'+fieldValue;
                                }else{
                                    map[fieldId] = fieldValue;
                                }
                            }
                            var repDataList=[]
                            for(var prop in map){
                                if(map.hasOwnProperty(prop)){
                                    var repDataObj={}
                                    repDataObj.fieldId=prop;
                                    repDataObj.data=map[prop];
                                    repDataList.push(repDataObj)
                                }
                            }
                            /*console.log(repDataList)*/
                            var data={
                                repTableId:$('#report').attr('repTableId'),
                                repDataList:repDataList
                            }
                            $.ajax({
                                url:'/repData/inserRepDatas',
                                type:'post',
                                dataType:'json',
                                contentType: 'application/json;charset=utf-8',
                                data:JSON.stringify(data),
                                success:function(res){
                                    if(res.flag){
                                        layer.msg('新建成功',{icon:1});
                                        layer.close(index);
                                        tableIns.reload()
                                    }
                                }
                            })
                        },
                    });
                })

            })
        }

    }
    //
    // $('.fileupload').click(function(){
    //     var thatF = $(this)
    //     var fileAll = '#' + thatF.parent('#fujians').find('.aaa').attr('id').attr('id')
    //     fileuploadFn('#fileupload', $(fileAll));
    // })

    $(function(){
        setTimeout(x, 200);
    })
    //删除附件
    $(document).on('click', '.deImgs',function(){
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        $.ajax({
            type: 'get',
            url: '/delete?'+attUrl,
            dataType: 'json',
            success:function(res){

                if(res.flag == true){
                    layer.msg('删除成功', { icon:6});
                    $(_this).parent().remove();
                }else{
                    layer.msg('删除失败', { icon:6});
                }
            }
        })
    });




</script>
</body>
</html>
