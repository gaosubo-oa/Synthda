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
    <title>学校汇总</title>
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
    <script src="../lib/echarts/echarts.common.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/echarts.min.js"></script>
</head>
<style>
    html{
        background-color: #fff;
    }
    .mbox{
        padding: 8px;
    }
    .layui-table td, .layui-table th{
        text-align: center;
    }
    th[data-field="去过重点地区"] , th[data-field="去过重点关注地区"] ,th[data-field="当日从其他地区返沪"] ,th[data-field="目前在家隔离"] ,th[data-field="目前集中隔离"] ,th[data-field="当日接触隔离"] ,th[data-field="2/23日前不返沪人数"]{
        background: #FEE4FF;
    }
    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        padding: 0px 0px;
        border-top: none;
        border-left: none;
    }
    #hig{
        width:600px;
        height: 450px;
        float: left;
        margin-left:50px;
        margin-top: 20px;
    }
    /*  .layui-table-body{
          overflow-y: auto !important;
      }*/
    #temp{
        width:600px;
        height: 450px;
        float: left;
        margin-left:50px;
    }
    #bingtu1{
        width:300px;
        height: 450px;
        float: left;
        /*margin-left:50px;*/
    }
    #bingtu2{
        width:300px;
        height: 450px;
        float: left;
        /*margin-left:50px;*/
    }
    #bingtu3{
        width:300px;
        height: 450px;
        float: left;
    }
    #stureturn{
        width:600px;
        height: 450px;
        float: left;
        margin-left:50px;
    }
    .stutab{
        margin: 0 auto;
        width: 1000px;
    }
    .stutabs{
        margin: 0 auto;
        width: 660px;
        margin-top:20px;
    }
    .sturetrn{
        margin: 0 auto;
        width: 660px;
    }
    .item{
        text-align: center;
        font-size: 40px;
        margin-bottom: 25px;
    }
    .leftTop{
        width: 210px;
        position: absolute;
        top: 270px;
        left: 300px;
        font-size: 22px;
    }
    .leftBot{
        width: 210px;
        position: absolute;
        top: 426px;
        left: 300px;
        font-size: 22px;
    }
    .rightTop{
        width: 210px;
        position: absolute;
        top: 270px;
        right: 300px;
        font-size: 22px;
    }
    .rightBot{
        width: 210px;
        position: absolute;
        top: 426px;
        right: 300px;
        font-size: 22px;
    }
</style>
<body>
<div class="mbox">
    <%--<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">按管理类型统计</li>
            <li>按街镇统计</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <table id="demo" lay-filter="test"></table>
            </div>
            <div class="layui-tab-item">
                <table id="jie" lay-filter="jie"></table>
            </div>
        </div>
    </div>--%>
        <div style="display: flex;margin-top: 15px;" class="layui-form">
            <div class="layui-form-item" style="width:20%">
                <label class="layui-form-label" style="padding: 9px 5px;width: 90px;">数据填报日期:</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input" id="guanTime">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">学校名称:</label>
                <div class="layui-input-block">
                    <input type="text" name="schoolName" required    autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">管理类型</label>
                <div class="layui-input-block">
                    <select name="schoolManageType" lay-verify="required">
                        <option value="">请选择</option>
                        <option value="1">机关与直属单位</option>
                        <option value="2">托育机构</option>
                        <option value="3">公办幼儿园</option>
                        <option value="4">民办幼儿园</option>
                        <option value="5">民办三级幼儿园</option>
                        <option value="6">外籍幼儿园</option>
                        <option value="7">公办小学</option>
                        <option value="8">公办中学</option>
                        <option value="9">随迁学校 </option>
                        <option value="10">民办中小学</option>
                        <option value="11">外籍中小学</option>
                        <option value="12">局管中职校</option>
                        <option value="13">行业中职校</option>
                        <option value="14">市属中职校</option>
                        <option value="15">成教中心社区学校老年大学</option>
                        <option value="16">全日制培训机构</option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn " style="margin-left: 20px;" id="guancha">查询数据</button>
            <button type="button" class="layui-btn " style="margin-left: 20px;" id="export">导出</button>
        </div>
        <table id="demo" lay-filter="test"></table>
</div>

<script>
    var table
    var tableIns1
    layui.use(['table','laydate','form'], function(){
        table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        form.render()
        laydate.render({
            elem: '#guanTime' //指定元素
        });
        $('#guanTime').val(nowformat)
        //导出
        $('#export').click(function () {
            window.location.href="/HealthyInfo/statisticsInfo?groupBy=dep.DEPT_ID&createTime="+$('#guanTime').val()+'&isExport='+true+'&schoolName='+$('input[name="schoolName"]').val()+'&schoolManageType='+$('select[name="schoolManageType"]').val()
        })
        $.ajax({
            url:'/HealthyInfo/statisticsInfo',
            type:'post',
            dataType:'json',
            data:{
                groupBy:'dep.DEPT_ID',
                // bol:true,
                createTime:$('#guanTime').val()
            },
            success:function (res) {
                 tableIns1= table.render({
                    elem: '#demo'
                    ,data: res.object
                    ,cellMinWidth:150
                    ,height:$(window).height()-110
                    ,cols: [[ //表头
                        {field: 'SCHOOL_NAME',fixed: 'left', title: '学校简称',rowspan: 2,templet: function(d){
                                // console.log(d)
                                if(d.SCHOOL_NAME!=undefined){
                                    return  '<span class="SCHOOL_NAME">'+d.SCHOOL_NAME+'</span>'
                                }else{
                                    return ''
                                }
                            }}
                        ,{field: 'identityName',fixed: 'left', title: '人员分类', rowspan: 2,templet: function(d){
                                if(d.identityName!=undefined){
                                    return  d.identityName
                                }else{
                                    return ''
                                }
                            }}
                         ,{field: '人员总数', title: '人员总数', rowspan: 2,templet: function(d){
                                 if(d.人员总数!=undefined && d.人员总数==0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                 }else if(d.人员总数!=undefined && d.人员总数==0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                 }else if(d.人员总数!=undefined && d.人员总数!=0  && d.identityName=='学生'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                 }else if(d.人员总数!=undefined && d.人员总数!=0  && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                 }else{
                                     return '0'
                                 }
                             }}
                        ,{field: '当日发现确诊人数', title: '当日发现确诊人数',rowspan: 2,templet: function(d){
                                // console.log(d)
                                if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数 ==0 && d.identityName=='学生' ){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                }else if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数 ==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                }else if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数 !=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                }else if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数 !=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '当日发现疑似人数', title: '当日发现疑似人数',rowspan: 2,templet: function(d){
                                if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                }else if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                }else if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                }else if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '当日健康异常人数', title: '当日健康异常人数',rowspan: 2,templet: function(d){
                                if(d.当日健康异常人数!=undefined && d.当日健康异常人数==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                }else if(d.当日健康异常人数!=undefined && d.当日健康异常人数==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                }else if(d.当日健康异常人数!=undefined && d.当日健康异常人数!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                }else if(d.当日健康异常人数!=undefined && d.当日健康异常人数!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '当日密切接触人数', title: '当日密切接触人数',rowspan: 2 ,templet: function(d){
                                if(d.当日密切接触人数!=undefined && d.当日密切接触人数==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                }else if(d.当日密切接触人数!=undefined && d.当日密切接触人数==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                }else if(d.当日密切接触人数!=undefined && d.当日密切接触人数!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                }else if(d.当日密切接触人数!=undefined && d.当日密切接触人数!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                         ,{field: '当日隔离人员数', title: '当日隔离人员数',rowspan: 2 ,templet: function(d){
                                 if(d.当日隔离人员数!=undefined && d.当日隔离人员数==0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                 }else if(d.当日隔离人员数!=undefined && d.当日隔离人员数==0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                 }else if(d.当日隔离人员数!=undefined && d.当日隔离人员数!=0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                 }else if(d.当日隔离人员数!=undefined && d.当日隔离人员数!=0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                 }else{
                                     return '0'
                                 }
                             }}
                        ,{field: '', title: '在沪人员',colspan:7}
                        ,{field: '', title: '在湖北',colspan:2}
                        // ,{field: '', title: '在重点关注地区',colspan:3}
                         ,{field: '当日在其他区域人数', title: '在其他地区人员（不含境外）',rowspan: 2,minWidth:300,templet: function(d){
                                 if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0  && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                 }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0  && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                 }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                 }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                 }else {
                                     return '0'
                                 }
                             }}
                         ,{field: '', title: '在境外人员（港澳台地区、国外）',colspan:3}
                        // ,{field: '', title: '返校途中',colspan:3}
                         ,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中人数',rowspan: 2,minWidth:300,templet: function(d){
                                 if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                 }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                 }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                 }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                 }else{
                                     return '0'
                                 }
                             }}
                        ,{field: '失联人数,手工填写', title: '失联人数',rowspan:2,templet: function(d){
                                if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;"  class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                }else if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;"  class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                }else if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                }else if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                }else {
                                    return '0'
                                }
                            }}
                    ],[
                        {field: '在沪人数', title: '在沪人数',templet: function(d){
                                if(d.在沪人数!=undefined && d.在沪人数==0  && d.identityName=='学生'){
                                    return '<a href="javascript:;"  class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                }else if(d.在沪人数!=undefined && d.在沪人数==0  && d.identityName=='教职员工'){
                                    return '<a href="javascript:;"  class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                }else if(d.在沪人数!=undefined && d.在沪人数!=0  && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                }else if(d.在沪人数!=undefined && d.在沪人数!=0  && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '留校人数', title: '其中在沪留校人数', templet: function(d){
                                if(d.留校人数!=undefined && d.留校人数==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                }else if(d.留校人数!=undefined && d.留校人数==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                }else if(d.留校人数!=undefined && d.留校人数!=0  && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                }else if(d.留校人数!=undefined && d.留校人数!=0  && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                       /* ,{field: '留校+密切接触患病', title: '在沪留校中密切接触未过隔离期人数', minWidth:270,templet: function(d){
                                if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                }else if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                }else if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single"  identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                }else if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                }else {
                                    return '0'
                                }
                            }}*/
                        ,{field: '去过重点地区', title: '当日从湖北（含途经）返沪人数',minWidth:250,templet: function(d){
                                if(d.去过重点地区!=undefined && d.去过重点地区==0  && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                }else if(d.去过重点地区!=undefined && d.去过重点地区==0  && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                }else if(d.去过重点地区!=undefined && d.去过重点地区!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                }else if(d.去过重点地区!=undefined && d.去过重点地区!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        /*,{field: '去过重点关注地区', title: '当日从重点关注地区返沪人数',minWidth:250,templet: function(d){
                                return '<a href="javascript:;" style="color: red" class="gdangri" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从重点关注地区返沪人数">'+d.去过重点关注地区+'</a>'
                            }}*/
                        ,{field: '当日从其他地区返沪', title: '当日从其他地区返沪人数',minWidth:250,templet: function(d){
                                if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                }else if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                }else if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                }else if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '目前在家隔离', title: '目前居家隔离人数', templet: function(d){
                                if(d.目前在家隔离!=undefined && d.目前在家隔离==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;"  class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                }else if(d.目前在家隔离!=undefined && d.目前在家隔离==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;"  class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                }else if(d.目前在家隔离!=undefined && d.目前在家隔离!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                }else if(d.目前在家隔离!=undefined && d.目前在家隔离!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '目前集中隔离', title: '目前集中隔离人数',templet: function(d){
                                if(d.目前集中隔离!=undefined && d.目前集中隔离==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                }else if(d.目前集中隔离!=undefined && d.目前集中隔离==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                }else if(d.目前集中隔离!=undefined && d.目前集中隔离!=0 && d.identityName=='学生' ){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                }else if(d.目前集中隔离!=undefined && d.目前集中隔离!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                }else{
                                    return '0'
                                }
                            } }
                        ,{field: '当日接触隔离', title: '当日解除隔离人数',templet: function(d){
                                if(d.当日接触隔离!=undefined && d.当日接触隔离==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;"  class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                }else if(d.当日接触隔离!=undefined && d.当日接触隔离==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;"  class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                }else if(d.当日接触隔离!=undefined && d.当日接触隔离!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                }else if(d.当日接触隔离!=undefined && d.当日接触隔离!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '当日在重点地区', title: '当日在湖北人数',templet: function(d){
                                if(d.当日在重点地区!=undefined && d.当日在重点地区==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                }else if(d.当日在重点地区!=undefined && d.当日在重点地区==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                }else if(d.当日在重点地区!=undefined && d.当日在重点地区!=0 && d.identityName=='学生' ){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                }else if(d.当日在重点地区!=undefined && d.当日在重点地区!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                         ,{field: '其中在武汉人员数', title: '其中在武汉人员数',templet: function(d){
                                 if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数==0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                 }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数==0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                 }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数!=0 && d.identityName=='学生' ){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                 }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数!=0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                 }else{
                                     return '0'
                                 }
                             }}
                       /* ,{field: '重点地区密切接触未过隔离期的人', title: '重点地区密切接触未过隔离期人数',minWidth:250,templet: function(d){
                                if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;"  class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                }else if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;"  class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                }else if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                }else if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                }else{
                                    return '0'
                                }
                            }}*/
                        /*  ,{field: '2/23日前不返沪人数', title: '2/23日前不返沪人数',minWidth:200,templet: function(d){
                                  if(d['2/23日前不返沪人数']!=undefined && d['2/23日前不返沪人数']==0){
                                      return '<a href="javascript:;"  class="gdangri"identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="2/23日前不返沪人数">'+d['2/23日前不返沪人数']+'</a>'
                                  }else if(d['2/23日前不返沪人数']!=undefined && d['2/23日前不返沪人数']!=0){
                                      return '<a href="javascript:;" style="color: red" class="gdangri"identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="2/23日前不返沪人数">'+d['2/23日前不返沪人数']+'</a>'
                                  }else{
                                      return ''
                                  }
                              }}*/
                        /* ,{field: '当日在重点关注地区人数', title: '当日在重点关注地区人数',minWidth:200,templet: function(d){
                                 return '<a href="javascript:;" style="color: red" class="gdangri" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在重点关注地区人数">'+d.当日在重点关注地区人数+'</a>'
                             }}
                         ,{field: '重点关注地区密切接触人数', title: '重点关注地区密切接触人数',minWidth:200,templet: function(d){
                                 return '<a href="javascript:;" style="color: red" class="gdangri" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="重点关注地区密切接触人数">'+d.重点关注地区密切接触人数+'</a>'
                             }}
                         ,{field: '重点关注地区途经湖北', title: '重点关注地区途经湖北',minWidth:200,templet: function(d){
                                 return '<a href="javascript:;" style="color: red" class="gdangri" schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="重点关注地区途经湖北">'+d.重点关注地区途经湖北+'</a>'
                             }}*/
                       /* ,{field: '其他区域密切接触人', title: '其他区域密切接触人数',minWidth:200,templet: function(d){
                                if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                }else if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                }else if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                }else if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '其他区域曾途经湖北人数', title: '其他区域曾途经湖北人数',minWidth:200,templet: function(d){
                                if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                }else if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                }else if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                }else if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}*/
                        /*,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中人数（当日10点前未到上海）',minWidth:300,templet: function(d){
                                if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '返校途中密切接触人数', title: '返校途中密切接触人数',minWidth:200,templet: function(d){
                                if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                }else if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                }else if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                }else if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}
                        ,{field: '返校途中途经湖北人数', title: '返校途中途经湖北人数',minWidth:200,templet: function(d){
                                if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数==0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                }else if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数==0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                }else if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数!=0 && d.identityName=='学生'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                }else if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数!=0 && d.identityName=='教职员工'){
                                    return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                }else{
                                    return '0'
                                }
                            }}*/
                         ,{field: '在境外人员', title: '核查人数',minWidth:200,templet: function(d){
                                 if(d.在境外人员!=undefined && d.在境外人员==0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                 }else if(d.在境外人员!=undefined && d.在境外人员==0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                 }else if(d.在境外人员!=undefined && d.在境外人员!=0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                 }else if(d.在境外人员!=undefined && d.在境外人员!=0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                 }else{
                                     return '0'
                                 }
                             }}
                         ,{field: '其中港澳台籍人员数', title: '其中港澳台籍人员数',minWidth:200,templet: function(d){
                                 if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数==0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                 }else if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数==0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                 }else if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数!=0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                 }else if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数!=0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                 }else{
                                     return '0'
                                 }
                             }}
                         ,{field: '其中外籍人员数', title: '其中外籍人员数',minWidth:200,templet: function(d){
                                 if(d.其中外籍人员数!=undefined && d.其中外籍人员数==0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                 }else if(d.其中外籍人员数!=undefined && d.其中外籍人员数==0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                 }else if(d.其中外籍人员数!=undefined && d.其中外籍人员数!=0 && d.identityName=='学生'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                 }else if(d.其中外籍人员数!=undefined && d.其中外籍人员数!=0 && d.identityName=='教职员工'){
                                     return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                 }else{
                                     return '0'
                                 }
                             }}
                        ]
                    ]
                    ,limit: 100000//显示的数量
                    ,parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.object //解析数据列表
                        };
                    }
                    ,done:function () {
                        for(var i=0;i<$('.layui-table-fixed .SCHOOL_NAME').length;i++){
                            if($('.layui-table-fixed .SCHOOL_NAME').eq(i).html()==$('.layui-table-fixed .SCHOOL_NAME').eq(i+1).html()){
                                $('.layui-table-fixed .SCHOOL_NAME').eq(i).parent().parent().attr('rowspan','2')
                                $('.layui-table-fixed .SCHOOL_NAME').eq(i+1).parent().parent().remove()
                            }
                        }
                    }
                });
            }
        })
        $(document).on('click','.gdangri',function(){
            if($(this).html()==0){
                return false
            }
            var identityType=$(this).attr('identityType');
            var deptId=$(this).attr('deptId');
            var data={
                identityType:identityType,
                deptId:deptId,
                // bol:true,
                createTime:$('#guanTime').val()
            }
            if($(this).attr('title')=='当日发现确诊人数'){
                data.type=1
                data.healthStatus=4
            }else if($(this).attr('title')=='当日发现疑似人数'){
                data.type=2
                data.healthStatus=3
            }else if($(this).attr('title')=='当日健康异常人数'){
                data.healthStatus=2
            }else if($(this).attr('title')=='当日密切接触人数'){
                data.healthStatus=5
            }else if($(this).attr('title')=='当日隔离人员数'){
                data.isolation='1,2'
            }else if($(this).attr('title')=='在沪人数'){
                data.dayStatus=1
            }else if($(this).attr('title')=='其中在沪留校人数'){
                data.detention=2
            }else if($(this).attr('title')=='当日从湖北（含途经）返沪人数'){
                data.type=3
                data.dayStatus=1
            }else if($(this).attr('title')=='当日从其他地区返沪人数'){
                data.type=6
                data.dayStatus=1
            }else if($(this).attr('title')=='目前居家隔离人数'){
                data.dayStatus=1
                data.isolation=2
            }else if($(this).attr('title')=='目前集中隔离人数'){
                data.dayStatus=1
                data.isolation=1
            }else if($(this).attr('title')=='当日解除隔离人数'){
                data.dayStatus=1
                data.isolation=4
            }else if($(this).attr('title')=='当日在湖北人数'){
                data.dayStatus='2,3'
            }else if($(this).attr('title')=='其中在武汉人员数'){
                data.dayStatus=2
            }else if($(this).attr('title')=='当日在其他区域人数'){
                data.dayStatus=4
            }else if($(this).attr('title')=='在境外人员'){
                data.dayStatus=5
            }else if($(this).attr('title')=='其中港澳台籍人员数'){
                data.type=4
                data.dayStatus=5
                data.nationality='台湾,香港,澳门'
            }else if($(this).attr('title')=='其中外籍人员数'){
                data.type=5
                data.dayStatus=5
                data.nationality='台湾,香港,澳门,中国'
            }else if($(this).attr('title')=='返校途中人数（当日10点前未到上海）'){
                data.dayStatus=6
            }else if($(this).attr('title')=='失联人数'){
                data.dayStatus=5
            }
           /* if($(this).attr('title')=='当日发现确诊人数'){
                data.type=1
                data.healthStatus=4
            }else if($(this).attr('title')=='当日发现疑似人数'){
                data.type=2
                data.healthStatus=3
            }else if($(this).attr('title')=='当日健康异常人数'){
                data.healthStatus=2
            }else if($(this).attr('title')=='当日密切接触人数'){
                data.healthStatus=5
            }else if($(this).attr('title')=='在沪人数'){
                data.dayStatus=1
            }else if($(this).attr('title')=='其中在沪留校人数'){
                data.detention=2
            }else if($(this).attr('title')=='在沪留校中密切接触未过隔离期人数'){
                data.detention=2
                data.healthStatus=5
            }else if($(this).attr('title')=='当日从湖北（含途经）返沪人数'){
                data.type=3
                data.dayStatus=1
            }else if($(this).attr('title')=='当日从其他地区返沪人数'){
                data.type=6
                data.dayStatus=1
            }else if($(this).attr('title')=='目前居家隔离人数'){
                data.dayStatus=1
                data.isolation=2
            }else if($(this).attr('title')=='目前集中隔离人数'){
                data.dayStatus=1
                data.isolation=1
            }else if($(this).attr('title')=='当日解除隔离人数'){
                data.dayStatus=1
                data.isolation=4
            }else if($(this).attr('title')=='当日在湖北人数'){
                data.dayStatus=2
            }else if($(this).attr('title')=='重点地区密切接触未过隔离期人数'){
                data.dayStatus=2
                data.healthStatus=5
            }else if($(this).attr('title')=='当日在其他区域人数'){
                data.dayStatus=3
            }else if($(this).attr('title')=='其他区域密切接触人数'){
                data.dayStatus=3
                data.channelRegion=5
            }else if($(this).attr('title')=='其他区域曾途经湖北人数'){
                data.type=5
                data.dayStatus=3
            }else if($(this).attr('title')=='返校途中人数（当日10点前未到上海）'){
                data.dayStatus=4
            }else if($(this).attr('title')=='返校途中密切接触人数'){
                data.dayStatus=4
                data.healthStatus=5
            }else if($(this).attr('title')=='返校途中途经湖北人数'){
                data.type=5
                data.dayStatus=4
            }else if($(this).attr('title')=='失联人数'){
                data.dayStatus=5
            }*/
            $.ajax({
                url: '/HealthyInfo/getCondition',
                type: 'post',
                dataType: 'json',
                data:data,
                success: function (res) {
                    var data=res.obj
                    layer.open({
                        type: 1,
                        closeBtn: 1,
                        title: '详情',
                        area: ['80%', '500px'], //宽高
                        content: '<table class="layui-table  details">\n' +
                            '  <thead>\n' +
                            '    <tr>\n' +
                            '      <th nowrap="nowrap">学校编码</th>\n' +
                            '      <th nowrap="nowrap">学校简称</th>\n' +
                            '      <th nowrap="nowrap">对象类型</th>\n' +
                            '      <th nowrap="nowrap">学生所在年级</th>\n' +
                            '      <th nowrap="nowrap">学生所在班级</th>\n' +
                            '      <th nowrap="nowrap">教职工职务</th>\n' +
                            '      <th nowrap="nowrap">姓名</th>\n' +
                            '      <th nowrap="nowrap">性别</th>\n' +
                            '      <th nowrap="nowrap">国籍</th>\n' +
                            // '      <th nowrap="nowrap">身份证号</th>\n' +
                            // '      <th nowrap="nowrap">护照号码</th>\n' +
                            '      <th nowrap="nowrap">手机</th>\n' +
                            '      <th nowrap="nowrap">当日状态</th>\n' +
                            '      <th nowrap="nowrap">留校情况</th>\n' +
                            '      <th nowrap="nowrap">离开湖北境内日期</th>\n' +
                            '      <th nowrap="nowrap">返沪前居住地址</th>\n' +
                            // '      <th nowrap="nowrap">途径区域</th>\n' +
                            '      <th nowrap="nowrap">返沪日期</th>\n' +
                            '      <th nowrap="nowrap">拟返沪日期</th>\n' +
                            '      <th nowrap="nowrap">在沪居住地所在街镇</th>\n' +
                            '      <th nowrap="nowrap">在沪居住地址</th>\n' +
                            '      <th nowrap="nowrap">本人健康状况</th>\n' +
                            '      <th nowrap="nowrap">是否注册健康云每日体温监测</th>\n' +
                            '      <th nowrap="nowrap">隔离情况</th>\n' +
                            '      <th nowrap="nowrap">隔离日期</th>\n' +
                            '      <th nowrap="nowrap">隔离地点</th>\n' +
                            '      <th nowrap="nowrap">解除隔离日期</th>\n' +
                            '      <th nowrap="nowrap">“疑似病例”确认日期</th>\n' +
                            '      <th nowrap="nowrap">“疑似病例”就诊医院</th>\n' +
                            '      <th nowrap="nowrap">“疑似病例”解除日期</th>\n' +
                            '      <th nowrap="nowrap">“确诊病例”确认日期</th>\n' +
                            '      <th nowrap="nowrap">“确诊病例”就诊医院</th>\n' +
                            '      <th nowrap="nowrap">“确诊病例”出院日期</th>\n' +
                            '      <th nowrap="nowrap">病例基本情况</th>\n' +
                            '      <th nowrap="nowrap">备注</th>\n' +
                            '      <th nowrap="nowrap">附件</th>\n' +
                            '    </tr> \n' +
                            '  </thead>\n' +
                            '  <tbody>\n' +
                            '  </tbody>\n' +
                            '</table>'
                        ,success:function () {
                            var str=''
                            for(var i=0;i<data.length;i++){
                                str+='    <tr>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].organNum!=undefined){
                                            return data[i].organNum
                                        }else {
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].schoolName!=undefined){
                                            return data[i].schoolName
                                        }else {
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].identityType==1){
                                            return  '学生'
                                        }else{
                                            return  '教职员工'
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].stuGrade==1){
                                            return '托育0-3'
                                        }else if(data[i].stuGrade==2){
                                            return '幼儿园托班'
                                        }else if(data[i].stuGrade==3){
                                            return '小班'
                                        }else if(data[i].stuGrade==4){
                                            return '中班'
                                        }else if(data[i].stuGrade==5){
                                            return '大班'
                                        }else if(data[i].stuGrade==6){
                                            return '一年级'
                                        }else if(data[i].stuGrade==7){
                                            return '二年级'
                                        }else if(data[i].stuGrade==8){
                                            return '三年级'
                                        }else if(data[i].stuGrade==9){
                                            return '四年级'
                                        }else if(data[i].stuGrade==10){
                                            return '五年级'
                                        }else if(data[i].stuGrade==11){
                                            return '六年级'
                                        }else if(data[i].stuGrade==12){
                                            return '七年级'
                                        }else if(data[i].stuGrade==13){
                                            return '八年级'
                                        }else if(data[i].stuGrade==14){
                                            return '九年级'
                                        }else if(data[i].stuGrade==15){
                                            return '十年级'
                                        }else if(data[i].stuGrade==16){
                                            return '十一年级'
                                        }else if(data[i].stuGrade==17){
                                            return '十二年级'
                                        }else if(data[i].stuGrade==18){
                                            return '中职校一年级'
                                        }else if(data[i].stuGrade==19){
                                            return '中职校二年级'
                                        }else if(data[i].stuGrade==20){
                                            return '中职校三年级'
                                        }else if(data[i].stuGrade==21){
                                            return '中职校四年级'
                                        }else if(data[i].stuGrade==22){
                                            return '成教中心社区学校老年大学'
                                        }else if(data[i].stuGrade==23){
                                            return '全日制培训机构'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].stuClass!=undefined){
                                            return data[i].stuClass
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].teaPost==1){
                                            return  '校级领导'
                                        }else if(data[i].teaPost==2){
                                            return  '中层干部'
                                        }else if(data[i].teaPost==3){
                                            return  '教师'
                                        }else if(data[i].teaPost==4){
                                            return  '外聘教师'
                                        }else if(data[i].teaPost==5){
                                            return  '教辅人员'
                                        }else if(data[i].teaPost==6){
                                            return  '施工人员'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].userName!=undefined){
                                            return data[i].userName
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].sex==1){
                                            return  '男'
                                        }else if(data[i].sex==2){
                                            return  '女'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        /*if(data[i].nationality==1){
                                            return '中国大陆'
                                        }else if(data[i].nationality==2){
                                            return '中国港澳台'
                                        }else if(data[i].nationality==3){
                                            return '外籍'
                                        }else{
                                            return ''
                                        }*/
                                        if(data[i].nationality!=undefined){
                                            return  data[i].nationality
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    /* '      <td nowrap="nowrap">'+function () {
                                         if(data[i].identityNo!=undefined){
                                             return data[i].identityNo
                                         }else{
                                             return ''
                                         }
                                     }()+'</td>\n' +*/
                                    /*'      <td nowrap="nowrap">'+function () {
                                        if(data[i].passportNo!=undefined){
                                            return data[i].passportNo
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +*/
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].phone!=undefined){
                                            return data[i].phone
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].dayStatus==1){
                                            return  '当日在沪'
                                        }else if(data[i].dayStatus==2){
                                            return  '当日在重点地区（湖北武汉）'
                                        }else if(data[i].dayStatus==3){
                                            return  '当日在重点地区（湖北其他地区）'
                                        }else if(data[i].dayStatus==4){
                                            return  '当日在国内其他地区'
                                        }else if(data[i].dayStatus==5){
                                            return  '当日在境外（含中国港澳台地区）'
                                        }else if(data[i].dayStatus==6){
                                            return  '返校途中'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].detention==1){
                                            return '未留校'
                                        }else if(data[i].detention==2){
                                            return '留校'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].departureTime!=undefined){
                                            return data[i].departureTime
                                        } else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].homeAddress!=undefined){
                                            return data[i].homeAddress
                                        } else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    /*  '      <td nowrap="nowrap">'+function () {
                                          if(data[i].channelRegion!=undefined){
                                              return  data[i].channelRegion
                                          }else {
                                              return ''
                                          }
                                      }()+'</td>\n' +*/
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].returnTime!=undefined){
                                            return data[i].returnTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].expectReturnTime!=undefined){
                                            return data[i].expectReturnTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].liveStreet==1){
                                            return  '江川路街道 '
                                        }else if(data[i].liveStreet==2){
                                            return '新虹街道'
                                        }else if(data[i].liveStreet==3){
                                            return '古美路街道'
                                        }else if(data[i].liveStreet==4){
                                            return '浦锦街道'
                                        }else if(data[i].liveStreet==5){
                                            return '莘庄镇'
                                        }else if(data[i].liveStreet==6){
                                            return '七宝镇'
                                        }else if(data[i].liveStreet==7){
                                            return '浦江镇'
                                        }else if(data[i].liveStreet==8){
                                            return '梅陇镇'
                                        }else if(data[i].liveStreet==9){
                                            return '虹桥镇'
                                        }else if(data[i].liveStreet==10){
                                            return '马桥镇'
                                        }else if(data[i].liveStreet==11){
                                            return '吴泾镇'
                                        }else if(data[i].liveStreet==12){
                                            return '华漕镇'
                                        }else if(data[i].liveStreet==13){
                                            return '颛桥镇'
                                        }else if(data[i].liveStreet==14){
                                            return '莘庄工业区'
                                        }else if(data[i].liveStreet==15){
                                            return '外区街镇'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].livePlace!=undefined){
                                            return data[i].livePlace
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].healthStatus==1){
                                            return '正常'
                                        }else if(data[i].healthStatus==2){
                                            return '异常（发烧、咳嗽、腹泻、呕吐、其他）'
                                        }else if(data[i].healthStatus==3){
                                            return '疑似'
                                        }else if(data[i].healthStatus==4){
                                            return '确诊'
                                        }else if(data[i].healthStatus==5){
                                            return '密切接触未过隔离期'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].temperatureYn ==0){
                                            return '否'
                                        }else if(data[i].temperatureYn==1){
                                            return '是'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].isolation==1){
                                            return '集中隔离'
                                        }else if(data[i].isolation==2){
                                            return '居家隔离'
                                        }else if(data[i].isolation==3){
                                            return '健康观察'
                                        }else if(data[i].isolation==4){
                                            return '解除隔离'
                                        }else if(data[i].isolation==5){
                                            return '未隔离'
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].isolationTime!=undefined){
                                            return data[i].isolationTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].isolationPlace!=undefined){
                                            return data[i].isolationPlace
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].remIsolationTime!=undefined){
                                            return  data[i].remIsolationTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].ebIllTime!=undefined){
                                            return data[i].ebIllTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].diagnosis!=undefined){
                                            return data[i].diagnosis
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].cureTime!=undefined){
                                            return data[i].cureTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].conEbIllTime!=undefined){
                                            return data[i].conEbIllTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].conDiagnosis!=undefined){
                                            return data[i].conDiagnosis
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].conCureTime!=undefined){
                                            return data[i].conCureTime
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].ebIllDesc!=undefined){
                                            return data[i].ebIllDesc
                                        }else {
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].remark!=undefined){
                                            return data[i].remark
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '      <td nowrap="nowrap">'+function () {
                                        if(data[i].attachmentId!=undefined){
                                            return data[i].attachmentId
                                        }else {
                                            return ''
                                        }
                                    }()+'</td>\n' +
                                    '    </tr>'
                            }
                            $('.details tbody ').html(str)
                        }
                    });
                }
            })
        })
    });
    //管理类型查询
    $('#guancha').click(function () {
        var createTime=$('#guanTime').val()
        var schoolName=$('input[name="schoolName"]').val()
        var schoolManageType=$('select[name="schoolManageType"]').val()
        if(createTime==''){
            layer.msg('请填写数据填报日期！', {icon: 0});
            return false
        }
        tableIns1.reload({
            url:'/HealthyInfo/statisticsInfo',
            where: { //设定异步数据接口的额外参数，任意设
                groupBy:'dep.DEPT_ID',
                // bol:true,
                createTime:createTime,
                schoolName:schoolName,
                schoolManageType:schoolManageType
            }
        });
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
</script>
</body>
</html>