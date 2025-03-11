<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
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
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
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
        /*#hig{*/
            /*width:400px;*/
            /*height: 400px;*/
            /*float: left;*/
            /*margin-right:100px;*/
        /*}*/
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
      /*  .laytable-cell-1-0-1 {
            font-size:14px;
            !*padding:0 5px;*!
            height:auto;
            overflow:visible;
            text-overflow:inherit;
            white-space:normal;
            word-break: break-all;
        }*/
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
            /*padding:5px 5px;*/
            /*box-sizing: border-box;*/
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
    <%--    <link rel="stylesheet" href="/duplopages/manage/standard/form/css/treeselect.css"/>--%>
</head>
<body>
<div style="margin-top: 20px;position: relative;">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span style="margin-left: 49px;font-size: 20px;">数据汇总查询</span>
</div>
<%--蓝色分割线--%>
<hr class="layui-bg-blue" style="height: 5px">
<div class="layui-fluid" id="LAY-app-message" style="background-color: #fff">
    <input type="hidden" id="sortId">
    <div class="layui-row ">
        <div class="layui-lf" style="width:250px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                    <div class="layui-form" lay-filter="selectStatus" style="margin:0px 0px 15px 0px;">
                        <select name="" id="" lay-filter="selectStatus">
                            <option value="a">请选择报表状态</option>
                            <option value="1">收集中</option>
                            <option value="2">已结束</option>
                        </select>
                    </div>
                    <ul id="questionTree"  style="overflow:auto;height:100%">
                    </ul>
                </div>
            </div>
        </div>
        <div class="layui-rt " style="width:calc(100% - 250px);float:left">
            <div class="layui-card rightHeight" style="padding-left: 10px;">
                <form class="layui-form" action="" style="display: inline-block">
                    <div>
                        <div class="layui-inline" style="margin: 9px auto 0px auto;">
                            <label class="layui-form-label">开始日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="date" id="datestar" lay-verify="date" placeholder="" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin: 9px auto 0px auto;">
                            <label class="layui-form-label">结束日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="date" id="dateend" lay-verify="date" placeholder="" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </form>
                <button type="button" class="layui-btn search" style="margin-top: 12px;margin-left: 50px;">查询</button>
                <button type="button" class="layui-btn excral" style="margin-top: 12px;margin-left: 20px;">汇总</button>
                <%--<button type="button" class="layui-btn iconanalysis" style="margin-top: 12px;margin-left: 50px;">图表分析</button>--%>
                <hr class="layui-bg-blue" style="height: 2px">
                <%--查询的表--%>
                <div id="tables">
                    <table id="questionTable" lay-filter="questionTable-table" onload=''></table>
                </div>
                <%--汇总的表--%>
                <div id="Sumquery" style="display: none">
                    <div style="display: none;position: relative" id="tableOne">
                        <button type="button" class="layui-btn" id="export" style="position:absolute;top: 14px;right:60px;z-index: 99999; ">导出</button>
                        <div  class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                            <ul class="layui-tab-title" style="margin-top:10px;line-height: 60px;height: 60px">
                                <li class="layui-this" style="font-size: 18px;height: 60px;line-height: 14px;">按学校汇总表</li>
                                <li class="school" style="font-size: 18px;height: 60px;line-height: 14px;">按学校类别汇总表</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <%--按学校汇总表--%>
                                    <div>
                                        <table class="taby tr_tds">
                                            <thead>
                                            <tr>
                                                <th style="background-color: #E2FFDA" rowspan="2">
                                                    序号
                                                </th>
                                                <th  style="background-color: #E2FFDA" rowspan="2">
                                                    编码缩写
                                                </th>
                                                <th  style="background-color: #E2FFDA"rowspan="2">
                                                    学校简称
                                                </th>
                                                <th  style="background-color: #E2FFDA"rowspan="2">
                                                    人员分类
                                                </th>
                                                <th  style="background-color: #E2FFDA"rowspan="2">
                                                    总数
                                                </th>
                                                <th  style="background-color: #E2FFDA" rowspan="2">
                                                    当日发现确诊
                                                </th>
                                                <th  style="background-color: #E2FFDA" rowspan="2">
                                                    当日发现疑似
                                                </th>
                                                <th  style="background-color: #E2FFDA"colspan="8">
                                                    在沪人员
                                                </th>
                                                <th  style="background-color: #E2FFDA" colspan="3">
                                                    在湖北
                                                </th>
                                                <th  style="background-color: #E2FFDA" colspan="2">
                                                    在其它地区
                                                </th>
                                                <th  style="background-color: #E2FFDA" colspan="2">
                                                    返校途中
                                                </th>
                                                <th  style="background-color: #E2FFDA" rowspan="2">
                                                    失联人数
                                                </th>
                                                <th  style="background-color: #B7DDE8;color:red;width:80px"rowspan="2">
                                                    更新日期
                                                </th>
                                                <th rowspan="2" style="background-color: #E2FFDA;width: 140px">
                                                    备注
                                                </th>
                                            </tr>
                                            <tr>
                                                <th  style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    其中留校
                                                </th>
                                                <th style="background-color: #E2FFDA">
                                                    留校中三类
                                                </th>
                                                <th  style="background-color: #EE93F6">
                                                    当日从湖北（含途径）返沪人数
                                                </th>
                                                <th  style="background-color: #EE93F6">
                                                    目前居家隔离人数
                                                </th>
                                                <th  style="background-color: #EE93F6">
                                                    目前集中隔离人数
                                                </th>
                                                <th  style="background-color: #EE93F6">
                                                    当日解除隔离人数
                                                </th>
                                                <th style="background-color: #FFC8B8">
                                                    当日从其他地区返沪人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    三类2型（密切接触）
                                                </th>
                                                <th  style="background-color: #EE93F6">
                                                    2月23日前不返沪人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    其中三类
                                                </th>
                                                <th style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    其中三类
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="layui-tab-item">
                                    <%--按学校类别汇总表--%>
                                    <div>
                                        <table class="taby tr_school">
                                            <thead>
                                            <tr>
                                                <th style="background-color: #E2FFDA" rowspan="2">
                                                    序号
                                                </th>
                                                <th  style="background-color: #E2FFDA"rowspan="2">
                                                    学校类别
                                                </th>
                                                <th  style="background-color: #E2FFDA;width: 30px"rowspan="2">
                                                    总数
                                                </th>
                                                <th  style="background-color: #E2FFDA" rowspan="2">
                                                    当日发现确诊
                                                </th>
                                                <th  style="background-color: #E2FFDA" rowspan="2">
                                                    当日发现疑似
                                                </th>
                                                <th  style="background-color: #E2FFDA"colspan="8">
                                                    在沪人员
                                                </th>
                                                <th  style="background-color: #E2FFDA" colspan="3">
                                                    在湖北
                                                </th>
                                                <th  style="background-color: #E2FFDA" colspan="2">
                                                    在其它地区
                                                </th>
                                                <th  style="background-color: #E2FFDA" colspan="2">
                                                    返校途中
                                                </th>
                                                <th  style="background-color: #E2FFDA" rowspan="2">
                                                    失联人数
                                                </th>
                                            </tr>
                                            <tr>
                                                <th  style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    其中留校
                                                </th>
                                                <th style="background-color: #E2FFDA">
                                                    留校中三类
                                                </th>
                                                <th  style="background-color: #FEE4FF">
                                                    从湖北（含途径）返沪人数
                                                </th>
                                                <th  style="background-color: #FEE4FF">
                                                    居家隔离人数
                                                </th>
                                                <th  style="background-color: #FEE4FF">
                                                    集中隔离人数
                                                </th>
                                                <th  style="background-color: #FEE4FF">
                                                    解除隔离人数
                                                </th>
                                                <th style="background-color: #FEE4FF">
                                                    从其他地区返沪人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    三类2型（密切接触）
                                                </th>
                                                <th  style="background-color: #FEE4FF">
                                                    2/23日前不返沪人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    其中三类
                                                </th>
                                                <th style="background-color: #E2FFDA">
                                                    核查人数
                                                </th>
                                                <th  style="background-color: #E2FFDA">
                                                    其中三类
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div style="display: none;width: 100%;" id="generalTable">
                        <div style="text-align: right;margin-right: 2%">
                            <button type="button" class="layui-btn" id="daoIn">导入</button>
                            <button type="button" class="layui-btn" id="daoOut">导出</button>
                        </div>
                        <table class="layui-table" >
                            <thead>
                            <tr>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%--如表--%>
                <div id="view" style="display: none">
                    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                        <ul class="layui-tab-title">
                            <li class="layui-this">在沪人员核查人数</li>
                            <li>在湖北核查人数</li>
                            <li>其它地区核查人数</li>
                        </ul>
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show">
                                <%--按学校汇总表--%>
                                <div>
                                    <div id="hig"></div>
                                </div>
                            </div>
                            <div class="layui-tab-item">
                                <%--按学校类别汇总表--%>
                                <div>
                                    <div id="main"></div>
                                </div>
                            </div>
                            <div class="layui-tab-item">
                                <%--按学校类别汇总表--%>
                                <div>
                                    <div id="people"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="barDemoq">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
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
    layui.use(['table','layer','form','laydate','element','upload'], function(){
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var element = layui.element;
        var upload = layui.upload;

        $("#datestar").val('');
        $("#dateend").val(nowformat);

        laydate.render({
            elem: '#datestar'
            , trigger: 'click'//呼出事件改成click
            , format: 'yyyy-MM-dd'
        });

        laydate.render({
            elem: '#dateend'
            , trigger: 'click'//呼出事件改成click
            , format: 'yyyy-MM-dd'
        });
        $('.excral').on('click',function(){
            var tableid=$('.select').attr('repTableId')
            if(tableid==undefined){
                layer.msg('请先创建报表!', {icon: 0});
                return false
            }
            $('#generalTable').show()
            $('#tableOne').hide()
            if(!mobiletype){
                $('#generalTable').width($(window).width()-305)
            }

            $('#generalTable').height($(window).height()-150)
            $('#generalTable').css('overflow-x','scroll')
            var params={
                tableId:$('.select').attr('repTableId'),
                startTime:$("#datestar").val(),
                endTime:$("#dateend").val()
            }
            $.ajax({
                url:'/repField/getFieldByTableId?tableId='+$('.select').attr('repTableId'),
                type:'get',
                dataType:'json',
                success:function(res){
                    var data=res.object.repFieldList
                    if(res.flag){
                        var str='<th nowrap="nowrap">序号</th>' +
                            '<th nowrap="nowrap">填报时间</th>'
                        for(var i=0;i<data.length;i++){
                            str+= '<th nowrap="nowrap" class="th" fieldType="'+data[i].fieldType+'" fieldId="data'+data[i].fieldId+'">'+data[i].fieldName+'</th>'
                        }
                        $('#generalTable thead tr ').html(str)
                        $.ajax({
                            url:'/repStatistics/findReportCondition',
                            type:'get',
                            contentType: 'application/json;charset=utf-8',
                            data:{json:JSON.stringify(params)},
                            dataType:'json',
                            success:function(res){
                                var data=res.obj
                                var str=''
                                if(data.length==0){
                                    var thLength=$('#generalTable thead tr th').length
                                    var noData='<tr><td colspan="'+thLength+'" style="text-align: center;">无数据</td></tr>'
                                    $('#generalTable tbody ').html(noData)
                                }else{
                                    for(var i=0;i<data.length;i++){
                                        str+=' <tr data-id="'+data[i].FLOW_ID+'"><td nowrap="nowrap">'+[i+1]+'</td>\n' +
                                            '      <td nowrap="nowrap">'+timestampToTime1(data[i].FLOW_DATE)+'</td>\n' +
                                            function () {
                                                var ss=''
                                                for(var f=0;f<$('#generalTable .th').length;f++){
                                                    if($('#generalTable .th').eq(f).attr('fieldType') == '7'){
                                                        ss+= '<td><button type="button" onclick="fileFun($(this))" class="layui-btn layui-btn-sm layui-btn-normal">附件操作</button></td>'
                                                    }else{
                                                        var sum=$('#generalTable .th').eq(f).attr('fieldId')
                                                        ss+=  '<td nowrap="nowrap">'+function () {
                                                            if(data[i][sum]==undefined){
                                                                return ''
                                                            }else{
                                                                return data[i][sum]
                                                            }
                                                        }()+'</td>'
                                                    }
                                                }
                                                return ss
                                            }()+'</tr>'

                                    }
                                    $('#generalTable tbody ').html(str)
                                }

                            }
                        })
                    }
                }
            })
            $('#tables').hide();
            $('#Sumquery').show()
            $('#view').hide()

        })
        //通用汇总表导入
        $("#daoIn").on('click',function () {
            var params={
                tableId:$('.select').attr('repTableId'),
                startTime:$("#datestar").val(),
                endTime:$("#dateend").val()
            }
            Import(params);
        });
        //通用汇总表导出
        $('#daoOut').on('click',function () {
            window.location.href="/repStatistics/ExportReportCondition?tableId="+$('.select').attr('repTableId')+'&startTime='+$("#datestar").val()+'&endTime='+$("#dateend").val()+'&template='+true
        })
        //导入
        function Import(data) {
            layer.open({
                type: 1,
                area: ['531px', '372px'], //宽高
                title:'导入',
                maxmin:true,
                btn: ['确定'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" id="load" style="text-decoration: underline; color: blue;cursor:pointer">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="test1">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">格式说明：</label>\n' +
                    '    <div class="layui-form-mid layui-word-aux">1.导入数据源只支持xls、xlsx格式</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success:function () {
                    $('#load').click(function () {

                        window.location.href="/repStatistics/ExportReportCondition?tableId="+$('.select').attr('repTableId')+'&startTime='+$("#datestar").val()+'&endTime='+$("#dateend").val()+'&template=false'+'&flag=1'
                    })
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        ,url: '/repStatistics/ImportReportCondition' //上传接口
                        ,accept:'file'
                        ,data:{json:JSON.stringify(data)}
                        ,auto:false
                        ,bindAction: '.layui-layer-btn0'
                        ,choose: function(obj){
                            //将每次选择的文件追加到文件队列
                            var files = obj.pushFile();
                            obj.preview(function(index, file, result) {
                                // console.log(index); //得到文件索引
                                // console.log(file); //得到文件对象
                                // console.log(result); //得到文件base64编码，比如图片
                                $("#textfilter").text(file.name);
                            });
                            // console.log(files);
                        }
                        ,done: function(res){
                            //上传完毕回调

                        }
                        ,error: function(){
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");
                        }
                    });
                },
                yes: function(index, layero){
                    layer.close(index);
                }
            });
        }


    })
    //附件操作
    function fileFun(e) {
        var _this = e;
        layer.open({
            type: 1,
            title: '附件详情',
            // shadeClose: true,
            btn:['确定'],
            // shade: 0.5,
            // maxmin: true, //开启最大化最小化按钮
            area: ['800px', '80%'],
            btnAlign:'c',
            content:' <div class="layui-form" id="fileBox">' +
                '</div>',
            success:function(){
                var flId = _this.parents('tr').attr('data-id');
                $.ajax({
                    url:'/repData/findRepDataByFlowId?flowId='+flId,
                    type:'get',
                    dataType:'json',
                    success:function(res){
                        var strfile = '';
                        var data=res.object.repDataList;
                        for(var i=0;i<data.length;i++){
                            if(data[i].fieldType == '7'){
                                if(data[i].attachmentList !=undefined && data[i].attachmentList.length>0){
                                    for(var l=0;l<data[i].attachmentList.length;l++){
                                        var fileExtension=data[i].attachmentList[l].attachName.substring(data[i].attachmentList[l].attachName.lastIndexOf(".")+1,data[i].attachmentList[l].attachName.length);//截取附件文件后缀
                                        var attName = encodeURI(data[i].attachmentList[l].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                        var deUrl = data[i].attachmentList[l].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].attachmentList[l].size;
                                        strfile += '<div class="dech" style="height: 40px;line-height: 40px;border-bottom: 1px solid #dddddd;" deUrl="' + deUrl+ '" attachid="'+data[i].attachmentList[l].attachId+'"  name ="'+data[i].attachmentList[l].attachName+'">' +
                                            '<a NAME="' + data[i].attachmentList[l].attachName + '*" style="text-decoration:none;margin-left:5px;width: 200px;display: inline-block;margin-left: 50px;">' +
                                            '<img  src="/img/attachment_icon.png"/>' + data[i].attachmentList[l].attachName + '</a>' +
                                            // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>删除' +
                                            '<a class="download" style="padding-left: 5px;margin-right: 50px;float: right;" href="/download?'+encodeURI(deUrl)+'" >' +
                                            '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                            '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="float: right;padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<input type="hidden" class="inHidden" value="' + data[i].attachmentList[l].aid + '@' + data[i].attachmentList[l].ym + '_' +data[i].attachmentList[l].attachId + ',">' +
                                            '</div>'
                                    }

                                }else{
                                    strfile='<div>暂无附件</div>';
                                }
                                $('#fileBox').html(strfile)
                            }
                        }
                    }
                })
            },
            yes:function(index){
                layer.close(index)
            },
        });
    }
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
    /*点击li的点击事件*/
    $('#questionTree').on('click','li',function(){
        var tableId = $(this).attr('repTableId');
        $(this).addClass('select').siblings().removeClass('select');
        // var  currentPage=1;
        table.reload('questionTable',{
            url : '/repData/findRepDatas',
            // data:{page:currentPage},
            // page:{/repField/getFieldByTableId
            //     curr:currentPage
            // },
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
    })
    $('#backTable').on('click',function(){
        if(mobiletype){
            $('.layui-rt').hide();
            $('.layui-lf ').show();
        }
    })
    $('.search').on('click',function(){
        var tableId = $('.select').attr('repTableId');
        if(tableId==undefined){
            layer.msg('请先创建报表!', {icon: 0});
            return false
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
                startTime:$("#datestar").val(),
                endTime:$("#dateend").val()
            }
        })
            $('#tables').show()
            $('#Sumquery').hide()
            $('#view').hide()
    })

    //根据选择的报表状态显示左侧列表
    layui.use(['form'], function() {
        var form = layui.form;
        form.render('select','selectStatus');
        layui.form.on('select(selectStatus)', function (data) {
            // console.log(data);
            if (data.value == 1) {
                for(var i=0; i<$(".isCollect").length; i++){
                    $(".isCollect").parent().eq(i).css('display','block');
                }
                $(".isOver").parent().css('display','none');
            }else if (data.value == 2) {
                for(var i=0; i<$(".isOver").length; i++){
                    var ac = $(".isOver").parent().eq(i)
                    $(".isOver").parent().eq(i).css('display','block');
                }
                $(".isCollect").parent().css('display','none');
            }else{
                $(".isCollect").parent().css('display','block');
                $(".isOver").parent().css('display','block');
            }
        })
    })
    //判断报表状态
    function tableStatus(myStatus){
        var isHtml = "";
        if(myStatus == 1){
            myStatus = '收集中';
            isHtml += '<span class="isCollect" style="color:mediumseagreen;float: right;margin-right: 10px;">'+ myStatus + '</span>'
            return isHtml;
        }else if(myStatus == 2){
            myStatus = '已结束';
            isHtml += '<span class="isOver" style="color: red;float: right;margin-right: 10px;">'+ myStatus + '</span>'
            return isHtml;
        }
    }
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
                    url:'/repTable/findRepTable?type=1',
                    type:'get',
                    async:false,
                    dataType:'json',
                    success:function(res){
                        if(res.flag){
                            var data = res.obj;
                            var str=''
                            for(var i=0;i<data.length;i++){
                                if(data[i].status != 0){//隐藏未启用（status=0）状态的报表
                                    if (i == 0) {
                                        str += '<li class="select liHeigh" title="' + data[i].repTableName +
                                            '" dictNo="' + data[i].repTableName + '"  repTableId="' + data[i].repTableId + '">' +'<div class="overflows">' +
                                            data[i].repTableName + '</div>' + tableStatus(data[i].status) + '</li>'
                                    } else {
                                        str += '<li class="liHeigh" dictNo="' + data[i].repTableName + '" repTableId="' + data[i].repTableId +
                                            '" title="' + data[i].repTableName + '">' + '<div class="overflows">' +
                                            data[i].repTableName + '</div>' + tableStatus(data[i].status) + '</li>'
                                    }
                                }
                            }
                            $('#questionTree').html(str);
                            if($('#questionTree li').length == 0){
                                layer.msg('请选择报表！', {icon: 0});
                            }else{
                                //判断出现滚动条时候的宽度
                                var isScroll = $(".layui-lf").prop('offsetWidth') > $(".layui-lf").prop('scrollWidth');
                                if(isScroll){
                                    $(".liHeigh span").css({"margin-right": "5px"});
                                }
                                if(data[0].repTableId != undefined || data[0].repTableId != ''){
                                    table.reload('questionTable', {
                                        url: '/repField/getFieldByTableId',
                                        where: {
                                            tableId: data[0].repTableId
                                        }
                                    })
                                }
                            }
                        }
                    }
                });
            }
            getlis();
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
                        $('#tables thead tr th[data-field="filedNo"] span').html(biao)
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
                                                           /* if((data[i].fieldName=='人员总数')&& res.object.repTableId==1){
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
                                    addNumBtn()
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
                                var fieldname=$('.testNum').eq(t).attr('fieldname')
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
                }
            });



        })
    }
    $(function(){
        setTimeout(x, 400);
    })

    //获取当前时间  年月日
    function nowformat() {
        var  nstr = "";
        var now = new Date();
        var nyear = now.getFullYear();
        var nmonth = now.getMonth()+1;
        var nday = now.getDate();
        if(nmonth<10){
            nmonth = "0"+nmonth;
        }
        if(nday<10){
            nday = "0"+nday;
        }
        nstr = nyear+"-"+nmonth+"-"+nday;
        return nstr;
    }
    //时间戳转变日期格式 年-月-日 时-分-秒
    function timestampToTime1(timestamp) {
        var date = new Date(timestamp );//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
        var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
        var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
        var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());
        return Y+M+D+h+m+s;
    }
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
