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
    <title>统计报表</title>
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
        width:800px;
        height: 500px;
        float: left;
        margin-left:300px;
        margin-top: 20px;
    }

    #temp{
        width:600px;
        height: 450px;
        float: left;
        margin-left:50px;
    }
    #stuteatu{
        width:600px;
        height: 450px;
        float: left;
        margin-left:50px;
    }
    #stutearorigin{
        width:600px;
        height: 450px;
        margin-left:50px;
    }
    #bingtu1{
        width:350px;
        height: 450px;
        float: left;
    }
    #bingtu2{
        width:350px;
        height: 450px;
        float: left;
    }
    #bingtu3{
        width:350px;
        height: 450px;
        float: left;
    }
    #stureturn{
        width:1000px;
        height: 450px;
        float: left;
        margin-left:-200px;
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
</style>
<body>
<div class="mbox">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">按管理类型统计</li>
            <li>按街镇统计</li>
            <li class="trend">健康数据趋势变化图</li>
            <li class="back">师生返沪情况</li>
            <li class="origin">师生来源地分析</li>
            <li class="residence">师生居住地分析</li>
            <li class="heathStatu">师生健康状况分析</li>
            <li class="management">师生健康管理</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <div style="display: flex;">
                    <div class="layui-form-item" style="width:20%">
                        <label class="layui-form-label" style="padding: 9px 5px;width: 90px;">数据填报日期:</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="guanTime">
                        </div>
                    </div>
                    <button type="button" class="layui-btn " style="margin-left: 20px;" id="guancha">查询数据</button>
                    <button type="button" class="layui-btn " style="margin-left: 20px;" id="guanExport">导出</button>
                </div>
                <table id="demo" lay-filter="test"></table>
            </div>
            <div class="layui-tab-item">
                <div style="display: flex;">
                    <div class="layui-form-item" style="width:20%">
                        <label class="layui-form-label"  style="padding: 9px 5px;width: 90px;">数据填报日期:</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="jieTime">
                        </div>
                    </div>
                    <button type="button" class="layui-btn" style="margin-left: 20px;" id="jiecha">查询数据</button>
                    <button type="button" class="layui-btn " style="margin-left: 20px;" id="jieExport">导出</button>
                </div>
                <table id="jie" lay-filter="jie"></table>
            </div>
            <%--图表--%>
            <div class="layui-tab-item">
                <form class="layui-form" action="" style="display: inline-block">
                        <div class="layui-inline">
                            <label class="layui-form-label">开始日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="date" id="datestar" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">结束日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="date" id="dateend" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <%--管理类型--%>
                        <div class="layui-inline">
                            <label class="layui-form-label" style="margin-left: -15px">管理类型</label>
                            <div class="layui-input-inline" style="width: 186px;">
                                <select name="schoolManageType" lay-verify="required" lay-search="" class="schoolManageType">
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
                        <%--所在街镇--%>
                        <div class="layui-inline">
                            <label class="layui-form-label" style="margin-left: -15px">所在街镇</label>
                            <div class="layui-input-inline" style="width: 186px;">
                                <select name="liveStreet" lay-verify="required" lay-search="" class="liveStreet">
                                    <option value="">请选择</option>\n' +
                                    <option value="1">江川路街道</option>
                                    <option value="2">新虹街道</option>
                                    <option value="3">古美路街道</option>
                                    <option value="4">浦锦街道</option>
                                    <option value="5">莘庄镇</option>
                                    <option value="6">七宝镇</option>
                                    <option value="7">浦江镇</option>
                                    <option value="8">梅陇镇</option>
                                    <option value="9">虹桥镇</option>
                                    <option value="10">马桥镇</option>
                                    <option value="11">吴泾镇</option>
                                    <option value="12">华漕镇</option>
                                    <option value="13">颛桥镇</option>
                                    <option value="14">莘庄工业区</option>
                                    <option value="15">外区街镇 </option>
                                </select>
                            </div>
                        </div>
                    <button type="button" class="layui-btn searbut" style="margin-left: 30px;">查询</button>
                </form>
                <%--图表分析--%>
                <div>
                    <div id="hig"></div>
                </div>
            </div>
            <%--师生返沪情况--%>
            <div class="layui-tab-item">
                <div class="stutab">
                    <div class="item">师生返沪情况</div>
                    <form class="layui-form" action="" style="display: inline-block;margin:0 328px;">
                        <div>
                            <div class="layui-inline" style="margin: 9px auto 0px auto;">
                                <label class="layui-form-label"  style="width:90px">数据填报日期</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="date" id="stustardate" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </form>
                    <div>
                        <div id="stuteatu" style="margin:0 165px"></div>
                    </div>
                </div>
            </div>
            <%--师生来源地分析--%>
            <div class="layui-tab-item">
                <div class="stutab">
                    <div class="item">师生来源地分析</div>
                    <form class="layui-form" action="" style="display: inline-block;margin:0 328px;">
                        <div>
                            <div class="layui-inline" style="margin: 9px auto 0px auto;">
                                <label class="layui-form-label"  style="width:90px">数据填报日期</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="date" id="datas" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </form>
                    <div style="margin:0 250px ;margin-top:10px">
                        <div id="stutearorigin"></div>
                    </div>
                </div>
            </div>
            <%--师生居住地分析--%>
            <div class="layui-tab-item">
                <div class="item">师生居住地分析</div>
                <form class="layui-form" action="" style="display: inline-block;margin-left:500px;">
                    <div>
                        <div class="layui-inline" style="margin: 9px auto 0px auto;">
                            <label class="layui-form-label"  style="width:90px">数据填报日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="date" id="stuenddate" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </form>
                <div class="stutabs">
                    <div id="stureturn"></div>
                </div>
            </div>
            <%--师生健康状况分析--%>
            <div class="layui-tab-item">
                <div class="item">师生健康状况分析</div>
                <form class="layui-form" action="" style="display: inline-block;margin-left:500px">
                    <div>
                        <div class="layui-inline" style="margin: 9px auto 0px auto;">
                            <label class="layui-form-label"  style="width:90px">数据填报日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="date" id="jkzk" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </form>
                <div class="sturetrn">
                    <div id="temp"></div>
                </div>
            </div>
            <%--师生健康管理--%>
            <div  class="layui-tab-item">
                <div class="item">师生健康管理</div>
                <form class="layui-form" action="" style="display: inline-block;margin-left:500px;">
                    <div>
                        <div class="layui-inline" style="margin: 9px auto 0px auto;">
                            <label class="layui-form-label" style="width:90px">数据填报日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="date" id="guanli" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </form>
                <div style="margin:0 auto;width: 1055px;">
                    <div style="height: 400px;position: relative;">
                        <div>
                            <div id="bingtu1" style="position:relative"></div>
                            <div style="position:absolute;left: 124px;bottom:10px;font-size: 25px;color:#f09c2a">居家隔离</div>
                        </div>
                        <div>
                            <div id="bingtu2" style="position:relative"></div>
                            <div style="position:absolute;left: 475px;bottom:10px;font-size: 25px;color:#377790">健康观测</div>
                        </div>
                        <div>
                            <div id="bingtu3" style="position:relative"></div>
                            <div style="position:absolute;right:24px;bottom:10px;font-size: 25px;color:#189a80">注册健康云每日健康观测</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    layui.use(['element','table','form','laydate'], function(){
        var element = layui.element;
        var table = layui.table;
        var form = layui.table;
        var laydate = layui.laydate;
        laydate.render({
            elem: '#guanTime' //指定元素
        });
        $('#guanTime').val(nowformat)
        //管理类型查询
        $('#guancha').click(function () {
            var createTime=$('#guanTime').val()
            if(createTime==''){
                layer.msg('请选择数据填报日期！', {icon: 0});
                return false
            }
            tableIns1.reload({
                url:'/HealthyInfo/statisticsInfo',
                where: { //设定异步数据接口的额外参数，任意设
                    groupBy:'SCHOOL_MANAGE_TYPE',
                    createTime:createTime
                }
            });

        })
        //管理类型导出
        $('#guanExport').click(function () {
            window.location.href="/HealthyInfo/statisticsInfo?groupBy=SCHOOL_MANAGE_TYPE&createTime="+$('#guanTime').val()+'&isExport='+true
        })
        laydate.render({
            elem: '#jieTime' //指定元素
        });
        $('#jieTime').val(nowformat)
        //街镇查询
        $('#jiecha').click(function () {
            var createTime=$('#jieTime').val()
            if(createTime==''){
                layer.msg('请选择数据填报日期！', {icon: 0});
                return false
            }
            tableIns2.reload({
                url:'/HealthyInfo/statisticsInfo',
                where: { //设定异步数据接口的额外参数，任意设
                    groupBy:'rhi.LIVE_STREET',
                    createTime:createTime
                }
            });
        })
        //街镇导出
        $('#jieExport').click(function () {
            window.location.href="/HealthyInfo/statisticsInfo?groupBy=rhi.LIVE_STREET&createTime="+$('#jieTime').val()+'&isExport='+true
        })
        //第一个实例
        var tableIns1= table.render({
            elem: '#demo'
            ,url: '/HealthyInfo/statisticsInfo' //数据接口
            ,where:{
                groupBy:'SCHOOL_MANAGE_TYPE',
                createTime:$('#guanTime').val()
            }
            ,cellMinWidth:150
            ,height:$(window).height()-195
            ,totalRow: true
            ,cols: [[ //表头
                {field: 'schoolManageName',fixed: 'left', title: '管理类型',totalRowText: '合计',rowspan: 2,templet: function(d){
                        return  '<span class="schoolTypeName">'+d.schoolManageName+'</span>'
                    }}
                ,{field: '机构总数',fixed: 'left', title: '机构总数',rowspan: 2 ,templet: function(d){
                        return  '<span class="jigouNum">'+d.机构总数+'</span>'
                    }}
                ,{field: 'identityName',fixed: 'left', title: '人员分类', rowspan: 2}
                ,{field: '人员总数', title: '人员总数', rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.人员总数!==undefined){
                            return  '<span class="xue1Single">'+d.人员总数+'</span>'
                        }else if(d.identityName=='教职员工' && d.人员总数!==undefined) {
                            return  '<span class="jiao1Single">'+d.人员总数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日发现确诊人数', title: '当日发现确诊人数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日发现确诊人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日发现确诊人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日发现确诊人数!==undefined) {
                            return  '<span class="jiao1Single">'+d.当日发现确诊人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日发现疑似人数', title: '当日发现疑似人数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日发现疑似人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日发现疑似人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日发现疑似人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日发现疑似人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日健康异常人数', title: '当日健康异常人数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日健康异常人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日健康异常人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日健康异常人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日健康异常人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日密切接触人数', title: '当日密切接触人数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日密切接触人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日密切接触人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日密切接触人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日密切接触人数+'</span>'
                        }else{
                            return '0'
                        }
                    } }
                    ,{field: '当日隔离人员数', title: '当日隔离人员数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日隔离人员数!==undefined){
                            return  '<span class="xue1Single">'+d.当日隔离人员数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日隔离人员数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日隔离人员数+'</span>'
                        }else{
                            return '0'
                        }
                    } }
                ,{field: '', title: '在沪人员',colspan:7}
                ,{field: '', title: '在湖北',colspan:2}
                // ,{field: '', title: '在重点关注地区',colspan:3}
                ,{field: '当日在其他区域人数', title: '在其他地区人员（不含境外）',rowspan: 2,minWidth:300,templet: function(d){
                        if(d.identityName=='学生' && d.当日在其他区域人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日在其他区域人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.当日在其他区域人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日在其他区域人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '', title: '在境外人员（港澳台地区、国外）',colspan:3}
                ,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中',rowspan: 2,minWidth:300,templet: function(d){
                        if(d.identityName=='学生' && d['返校途中人数（当日10点前未到上海）']!==undefined){
                            return  '<span class="xue1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else if(d.identityName=='教职员工' && d['返校途中人数（当日10点前未到上海）']!==undefined) {
                            return  '<span class="jiao1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '失联人数,手工填写', title: '失联人数',rowspan:2,templet: function(d){
                        if(d.identityName=='学生' && d['失联人数,手工填写']!==undefined){
                            return  '<span class="xue1Single">'+d['失联人数,手工填写']+'</span>'
                        }else if(d.identityName=='教职员工' && d['失联人数,手工填写']!==undefined){
                            return  '<span class="jiao1Single">'+d['失联人数,手工填写']+'</span>'
                        }else{
                            return '0'
                        }
                    }}
            ],[
                {field: '在沪人数', title: '在沪人数',templet: function(d){
                        if(d.identityName=='学生' && d.在沪人数!==undefined){
                            return  '<span class="xue1Single">'+d.在沪人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.在沪人数!==undefined){
                            return  '<span class="jiao1Single">'+d.在沪人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '留校人数', title: '其中在沪留校人数',templet: function(d){
                        if(d.identityName=='学生' && d.留校人数!==undefined){
                            return  '<span class="xue1Single">'+d.留校人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.留校人数!==undefined) {
                            return  '<span class="jiao1Single">'+d.留校人数+'</span>'
                        }else{
                            return '0'
                        }
                    } }
               /* ,{field: '留校+密切接触患病', title: '在沪留校中密切接触未过隔离期人数', minWidth:270,templet: function(d){
                        if(d.identityName=='学生' && d['留校+密切接触患病']!==undefined){
                            return  '<span class="xue1Single">'+d['留校+密切接触患病']+'</span>'
                        }else if(d.identityName=='教职员工' && d['留校+密切接触患病']!==undefined){
                            return  '<span class="jiao1Single">'+d['留校+密切接触患病']+'</span>'
                        }else{
                            return '0'
                        }
                    }}*/
                ,{field: '去过重点地区', title: '当日从湖北（含途经）返沪人数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.去过重点地区!==undefined){
                            return  '<span class="xue1Single">'+d.去过重点地区+'</span>'
                        }else if(d.identityName=='教职员工' && d.去过重点地区!==undefined){
                            return  '<span class="jiao1Single">'+d.去过重点地区+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                // ,{field: '去过重点关注地区', title: '当日从重点关注地区返沪人数',minWidth:250}
                ,{field: '当日从其他地区返沪', title: '当日从其他地区返沪人数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.当日从其他地区返沪!==undefined){
                            return  '<span class="xue1Single">'+d.当日从其他地区返沪+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日从其他地区返沪!==undefined){
                            return  '<span class="jiao1Single">'+d.当日从其他地区返沪+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '目前在家隔离', title: '目前居家隔离人数',templet: function(d){
                        if(d.identityName=='学生' && d.目前在家隔离!==undefined){
                            return  '<span class="xue1Single">'+d.目前在家隔离+'</span>'
                        }else if(d.identityName=='教职员工' && d.目前在家隔离!==undefined){
                            return  '<span class="jiao1Single">'+d.目前在家隔离+'</span>'
                        }else{
                            return '0'
                        }
                    } }
                ,{field: '目前集中隔离', title: '目前集中隔离人数',templet: function(d){
                        if(d.identityName=='学生' && d.目前集中隔离!==undefined){
                            return  '<span class="xue1Single">'+d.目前集中隔离+'</span>'
                        }else if(d.identityName=='教职员工' && d.目前集中隔离!==undefined){
                            return  '<span class="jiao1Single">'+d.目前集中隔离+'</span>'
                        }else{
                            return '0'
                        }
                    } }
                ,{field: '当日接触隔离', title: '当日解除隔离人数',templet: function(d){
                        if(d.identityName=='学生' && d.当日接触隔离!==undefined){
                            return  '<span class="xue1Single">'+d.当日接触隔离+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日接触隔离!==undefined){
                            return  '<span class="jiao1Single">'+d.当日接触隔离+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日在重点地区', title: '当日在湖北人数',templet: function(d){
                        if(d.identityName=='学生' && d.当日在重点地区!==undefined){
                            return  '<span class="xue1Single">'+d.当日在重点地区+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日在重点地区!==undefined){
                            return  '<span class="jiao1Single">'+d.当日在重点地区+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                /*,{field: '重点地区密切接触未过隔离期的人', title: '重点地区密切接触未过隔离期人数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.重点地区密切接触未过隔离期的人!==undefined){
                            return  '<span class="xue1Single">'+d.重点地区密切接触未过隔离期的人+'</span>'
                        }else if(d.identityName=='教职员工' && d.重点地区密切接触未过隔离期的人!==undefined){
                            return  '<span class="jiao1Single">'+d.重点地区密切接触未过隔离期的人+'</span>'
                        }else{
                            return '0'
                        }
                    }} */
                    ,{field: '其中在武汉人员数', title: '其中在武汉人员数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.其中在武汉人员数!==undefined){
                            return  '<span class="xue1Single">'+d.其中在武汉人员数+'</span>'
                        }else if(d.identityName=='教职员工' && d.其中在武汉人员数!==undefined){
                            return  '<span class="jiao1Single">'+d.其中在武汉人员数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                // ,{field: '2/23日前不返沪人数', title: '2/23日前不返沪人数',minWidth:200}
                /* ,{field: '当日在重点关注地区人数', title: '当日在重点关注地区人数',minWidth:200}
                 ,{field: '重点关注地区密切接触人数', title: '重点关注地区密切接触人数',minWidth:200}
                 ,{field: '重点关注地区途经湖北', title: '重点关注地区途经湖北',minWidth:200}*/
               /* ,{field: '当日在其他区域人数', title: '当日在其他区域人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.当日在其他区域人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日在其他区域人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日在其他区域人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日在其他区域人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '其他区域密切接触人', title: '其他区域密切接触人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.其他区域密切接触人!==undefined){
                            return  '<span class="xue1Single">'+d.其他区域密切接触人+'</span>'
                        }else if(d.identityName=='教职员工' && d.其他区域密切接触人!==undefined){
                            return  '<span class="jiao1Single">'+d.其他区域密切接触人+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '其他区域曾途经湖北人数', title: '其他区域曾途经湖北人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.其他区域曾途经湖北人数!==undefined){
                            return  '<span class="xue1Single">'+d.其他区域曾途经湖北人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.其他区域曾途经湖北人数!==undefined){
                            return  '<span class="jiao1Single">'+d.其他区域曾途经湖北人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}*/
                ,{field: '在境外人员', title: '核查人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.在境外人员!==undefined){
                            return  '<span class="xue1Single">'+d.在境外人员+'</span>'
                        }else if(d.identityName=='教职员工' && d.在境外人员!==undefined){
                            return  '<span class="jiao1Single">'+d.在境外人员+'</span>'
                        }else{
                            return '0'
                        }
                    }}
           ,{field: '其中港澳台籍人员数', title: '其中港澳台籍人员数',minWidth:200,templet: function(d){
                   if(d.identityName=='学生' && d.其中港澳台籍人员数!==undefined){
                       return  '<span class="xue1Single">'+d.其中港澳台籍人员数+'</span>'
                   }else if(d.identityName=='教职员工' && d.其中港澳台籍人员数!==undefined){
                       return  '<span class="jiao1Single">'+d.其中港澳台籍人员数+'</span>'
                   }else{
                       return '0'
                   }
               }}
           ,{field: '其中外籍人员数', title: '其中外籍人员数',minWidth:200,templet: function(d){
                   if(d.identityName=='学生' && d.其中外籍人员数!==undefined){
                       return  '<span class="xue1Single">'+d.其中外籍人员数+'</span>'
                   }else  if(d.identityName=='教职员工' && d.其中外籍人员数!==undefined){
                       return  '<span class="jiao1Single">'+d.其中外籍人员数+'</span>'
                   }else{
                       return '0'
                   }
               }}
                /*,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中人数（当日10点前未到上海）',minWidth:300,templet: function(d){
                        if(d.identityName=='学生' && d['返校途中人数（当日10点前未到上海）']!==undefined){
                            return  '<span class="xue1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else if(d.identityName=='教职员工' && d['返校途中人数（当日10点前未到上海）']!==undefined) {
                            return  '<span class="jiao1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '返校途中密切接触人数', title: '返校途中密切接触人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.返校途中密切接触人数!==undefined){
                            return  '<span class="xue1Single">'+d.返校途中密切接触人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.返校途中密切接触人数!==undefined){
                            return  '<span class="jiao1Single">'+d.返校途中密切接触人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '返校途中途经湖北人数', title: '返校途中途经湖北人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.返校途中途经湖北人数!==undefined){
                            return  '<span class="xue1Single">'+d.返校途中途经湖北人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.返校途中途经湖北人数!==undefined){
                            return  '<span class="jiao1Single">'+d.返校途中途经湖北人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}*/
            ]
            ]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.object //解析数据列表
                };
            }
            ,done:function () {
                if($('div[lay-id="demo"] .layui-none').html()=='无数据'){
                    $('div[lay-id="demo"] .layui-table-total').hide()
                }
                for(var i=0;i<$('.layui-table-fixed .schoolTypeName').length;i++){
                    if($('.layui-table-fixed .schoolTypeName').eq(i).html()==$('.layui-table-fixed .schoolTypeName').eq(i+1).html()){
                        $('.layui-table-fixed .schoolTypeName').eq(i).parent().parent().attr('rowspan','2')
                        $('.layui-table-fixed .schoolTypeName').eq(i+1).parent().parent().remove()
                    }
                }
                for(var i=0;i<$('.layui-table-fixed .jigouNum').length;i++){
                    if($('.layui-table-fixed .jigouNum').eq(i).parent().parent().prev().attr('rowspan')=='2'){
                        var xue=$('.layui-table-fixed .jigouNum').eq(i).html()
                        // var jiao=$('.jigouNum').eq(i+1).html()
                        // $('.jigouNum').eq(i).html(parseInt(xue)+parseInt(jiao))
                        $('.layui-table-fixed .jigouNum').eq(i).html(xue)
                        $('.layui-table-fixed .jigouNum').eq(i).parent().parent().attr('rowspan','2')
                        $('.layui-table-fixed .jigouNum').eq(i+1).parent().parent().remove()
                    }
                }
                // $('div[lay-id="demo"] .layui-table-fixed .layui-table tbody').append('<tr style="height: 50px">合计</tr>')
                $('div[lay-id="demo"] .layui-table-total tbody ').append('<tr><td class="jiao"></td><td class="jiao1"></td><td class="jiao2"></td><td class="jiao3"></td><td class="jiao4"></td><td class="jiao5"></td>' +
                    '<td class="jiao6"></td><td class="jiao7"></td><td class="jiao8"></td><td class="jiao9"></td><td class="jiao10"></td><td class="jiao11"></td><td class="jiao12"></td><td class="jiao13"></td><td class="jiao14"></td><td class="jiao15"></td><td class="jiao16"></td><td class="jiao17"></td>'+
                    '<td class="jiao18"></td><td class="jiao19"></td><td class="jiao20"></td><td class="jiao21"></td><td class="jiao22"></td>'+ '</tr>'+
                    '<tr><td class="zong"></td><td class="zong1"></td><td class="zong2"></td><td class="zong3"></td><td class="zong4"></td><td class="zong5"></td>' +
                    '<td class="zong6"></td><td class="zong7"></td><td class="zong8"></td><td class="zong9"></td><td class="zong10"></td><td class="zong11"></td><td class="zong12"></td><td class="zong13"></td><td class="zong14"></td><td class="zong15"></td><td class="zong16"></td><td class="zong17"></td>'+
                    '<td class="zong18"></td><td class="zong19"></td><td class="zong20"></td><td class="zong21"></td><td class="zong22"></td>'+ '</tr>'
                )
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="schoolManageName"]').attr('rowspan','3')
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="机构总数"]').attr('rowspan','3')
                //机构总数
                var jigouNum=0
                for(var i=0;i<$('div[lay-id="demo"]  .layui-table-fixed td[data-key="1-0-1"] .jigouNum').length;i++){
                    jigouNum+=parseInt($('div[lay-id="demo"]  .layui-table-fixed td[data-key="1-0-1"] .jigouNum').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="机构总数"] .layui-table-cell').append('<span>'+jigouNum+'</span>')
                //对象类型
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="identityName"] .layui-table-cell').append('<span>学生人数</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao').append('<span>教工人数</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong ').append('<span>师生总数</span>')
                //1人员总数
                var xue1=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="人员总数"] .xue1Single').length;i++){
                    xue1+=parseInt($('div[lay-id="demo"] td[data-field="人员总数"] .xue1Single').eq(i).html())
                }
                var jiao1=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="人员总数"] .jiao1Single').length;i++){
                    jiao1+=parseInt($('div[lay-id="demo"] td[data-field="人员总数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="人员总数"] .layui-table-cell').append('<span>'+xue1+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao1').append('<span>'+jiao1+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong1 ').append('<span>'+parseInt(xue1+jiao1)+'</span>')
                //2当日发现确诊人数
                var xue2=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日发现确诊人数"] .xue1Single').length;i++){
                    xue2+=parseInt($('div[lay-id="demo"]  td[data-field="当日发现确诊人数"] .xue1Single').eq(i).html())
                }
                var jiao2=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日发现确诊人数"] .jiao1Single').length;i++){
                    jiao2+=parseInt($('div[lay-id="demo"]  td[data-field="当日发现确诊人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日发现确诊人数"] .layui-table-cell').append('<span>'+xue2+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao2').append('<span>'+jiao2+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong2 ').append('<span>'+parseInt(xue2+jiao2)+'</span>')
                //3当日发现疑似人数
                var xue3=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日发现疑似人数"] .xue1Single').length;i++){
                    xue3+=parseInt($('div[lay-id="demo"]  td[data-field="当日发现疑似人数"] .xue1Single').eq(i).html())
                }
                var jiao3=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日发现疑似人数"] .jiao1Single').length;i++){
                    jiao3+=parseInt($('div[lay-id="demo"]  td[data-field="当日发现疑似人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日发现疑似人数"] .layui-table-cell').append('<span>'+xue3+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao3').append('<span>'+jiao3+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong3 ').append('<span>'+parseInt(xue3+jiao3)+'</span>')
                //4当日健康异常人数
                var xue4=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日健康异常人数"] .xue1Single').length;i++){
                    xue4+=parseInt($('div[lay-id="demo"]  td[data-field="当日健康异常人数"] .xue1Single').eq(i).html())
                }
                var jiao4=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日健康异常人数"] .jiao1Single').length;i++){
                    jiao4+=parseInt($('div[lay-id="demo"]  td[data-field="当日健康异常人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日健康异常人数"] .layui-table-cell').append('<span>'+xue4+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao4').append('<span>'+jiao4+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong4 ').append('<span>'+parseInt(xue4+jiao4)+'</span>')
                //5当日密切接触人数
                var xue5=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日密切接触人数"] .xue1Single').length;i++){
                    xue5+=parseInt($('div[lay-id="demo"]  td[data-field="当日密切接触人数"] .xue1Single').eq(i).html())
                }
                var jiao5=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日密切接触人数"] .jiao1Single').length;i++){
                    jiao5+=parseInt($('div[lay-id="demo"] td[data-field="当日密切接触人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日密切接触人数"] .layui-table-cell').append('<span>'+xue5+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao5').append('<span>'+jiao5+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong5 ').append('<span>'+parseInt(xue5+jiao5)+'</span>')
                //6当日隔离人员数
                var xue6=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日隔离人员数"] .xue1Single').length;i++){
                    xue6+=parseInt($('div[lay-id="demo"]  td[data-field="当日隔离人员数"] .xue1Single').eq(i).html())
                }
                var jiao6=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日隔离人员数"] .jiao1Single').length;i++){
                    jiao6+=parseInt($('div[lay-id="demo"] td[data-field="当日隔离人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日隔离人员数"] .layui-table-cell').append('<span>'+xue6+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao6').append('<span>'+jiao6+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong6 ').append('<span>'+parseInt(xue6+jiao6)+'</span>')

                //7在沪人数
                var xue7=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="在沪人数"] .xue1Single').length;i++){
                    xue7+=parseInt($('div[lay-id="demo"] td[data-field="在沪人数"] .xue1Single').eq(i).html())
                }
                var jiao7=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="在沪人数"] .jiao1Single').length;i++){
                    jiao7+=parseInt($('div[lay-id="demo"] td[data-field="在沪人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="在沪人数"] .layui-table-cell').append('<span>'+xue7+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao7').append('<span>'+jiao7+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong7 ').append('<span>'+parseInt(xue7+jiao7)+'</span>')
                //8其中在沪留校人数
                var xue8=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校人数"] .xue1Single').length;i++){
                    xue8+=parseInt($('div[lay-id="demo"] td[data-field="留校人数"] .xue1Single').eq(i).html())
                }
                var jiao8=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校人数"] .jiao1Single').length;i++){
                    jiao8+=parseInt($('div[lay-id="demo"] td[data-field="留校人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="留校人数"] .layui-table-cell').append('<span>'+xue8+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')
                /*//在沪留校中密切接触未过隔离期人数
                var xue8=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').length;i++){
                    xue8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').eq(i).html())
                }
                var jiao8=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').length;i++){
                    jiao8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="留校+密切接触患病"] .layui-table-cell').append('<span>'+xue8+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')*/
                //9当日从湖北（含途经）返沪人数
                var xue9=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="去过重点地区"] .xue1Single').length;i++){
                    xue9+=parseInt($('div[lay-id="demo"] td[data-field="去过重点地区"] .xue1Single').eq(i).html())
                }
                var jiao9=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="去过重点地区"] .jiao1Single').length;i++){
                    jiao9+=parseInt($('div[lay-id="demo"] td[data-field="去过重点地区"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="去过重点地区"] .layui-table-cell').append('<span>'+xue9+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao9').append('<span>'+jiao9+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong9 ').append('<span>'+parseInt(xue9+jiao9)+'</span>')
                //10当日从其他地区返沪人数
                var xue10=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日从其他地区返沪"] .xue1Single').length;i++){
                    xue10+=parseInt($('div[lay-id="demo"] td[data-field="当日从其他地区返沪"] .xue1Single').eq(i).html())
                }
                var jiao10=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="当日从其他地区返沪"] .jiao1Single').length;i++){
                    jiao10+=parseInt($('div[lay-id="demo"] td[data-field="当日从其他地区返沪"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日从其他地区返沪"] .layui-table-cell').append('<span>'+xue10+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao10').append('<span>'+jiao10+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong10 ').append('<span>'+parseInt(xue10+jiao10)+'</span>')
                //11目前居家隔离人数
                var xue11=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="目前在家隔离"] .xue1Single').length;i++){
                    xue11+=parseInt($('div[lay-id="demo"]  td[data-field="目前在家隔离"] .xue1Single').eq(i).html())
                }
                var jiao11=0
                for(var i=0;i<$('div[lay-id="demo"]  td[data-field="目前在家隔离"] .jiao1Single').length;i++){
                    jiao11+=parseInt($('div[lay-id="demo"]  td[data-field="目前在家隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="目前在家隔离"] .layui-table-cell').append('<span>'+xue11+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao11').append('<span>'+jiao11+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong11 ').append('<span>'+parseInt(xue11+jiao11)+'</span>')
                //12目前集中隔离人数
                var xue12=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="目前集中隔离"] .xue1Single').length;i++){
                    xue12+=parseInt($('div[lay-id="demo"] td[data-field="目前集中隔离"] .xue1Single').eq(i).html())
                }
                var jiao12=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="目前集中隔离"] .jiao1Single').length;i++){
                    jiao12+=parseInt($('div[lay-id="demo"] td[data-field="目前集中隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="目前集中隔离"] .layui-table-cell').append('<span>'+xue12+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao12').append('<span>'+jiao12+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong12 ').append('<span>'+parseInt(xue12+jiao12)+'</span>')
                //13当日解除隔离人数
                var xue13=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日接触隔离"] .xue1Single').length;i++){
                    xue13+=parseInt($('div[lay-id="demo"] td[data-field="当日接触隔离"] .xue1Single').eq(i).html())
                }
                var jiao13=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日接触隔离"] .jiao1Single').length;i++){
                    jiao13+=parseInt($('div[lay-id="demo"] td[data-field="当日接触隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日接触隔离"] .layui-table-cell').append('<span>'+xue13+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao13').append('<span>'+jiao13+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong13 ').append('<span>'+parseInt(xue13+jiao13)+'</span>')
                //14当日在湖北人数
                var xue14=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日在重点地区"] .xue1Single').length;i++){
                    xue14+=parseInt($('div[lay-id="demo"] td[data-field="当日在重点地区"] .xue1Single').eq(i).html())
                }
                var jiao14=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日在重点地区"] .jiao1Single').length;i++){
                    jiao14+=parseInt($('div[lay-id="demo"] td[data-field="当日在重点地区"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日在重点地区"] .layui-table-cell').append('<span>'+xue14+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao14').append('<span>'+jiao14+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong14 ').append('<span>'+parseInt(xue14+jiao14)+'</span>')
                //15其中在武汉人员数
                var xue15=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其中在武汉人员数"] .xue1Single').length;i++){
                    xue15+=parseInt($('div[lay-id="demo"] td[data-field="其中在武汉人员数"] .xue1Single').eq(i).html())
                }
                var jiao15=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其中在武汉人员数"] .jiao1Single').length;i++){
                    jiao15+=parseInt($('div[lay-id="demo"] td[data-field="其中在武汉人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="其中在武汉人员数"] .layui-table-cell').append('<span>'+xue15+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao15').append('<span>'+jiao15+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong15 ').append('<span>'+parseInt(xue15+jiao15)+'</span>')
                //16在其他地区人员（不含境外）
                var xue16=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日在其他区域人数"] .xue1Single').length;i++){
                    xue16+=parseInt($('div[lay-id="demo"] td[data-field="当日在其他区域人数"] .xue1Single').eq(i).html())
                }
                var jiao16=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="当日在其他区域人数"] .jiao1Single').length;i++){
                    jiao16+=parseInt($('div[lay-id="demo"] td[data-field="当日在其他区域人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="当日在其他区域人数"] .layui-table-cell').append('<span>'+xue16+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao16').append('<span>'+jiao16+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong16 ').append('<span>'+parseInt(xue16+jiao16)+'</span>')
               /* //17其他区域密切接触人数
                var xue17=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').length;i++){
                    xue17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').eq(i).html())
                }
                var jiao17=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').length;i++){
                    jiao17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="其他区域密切接触人"] .layui-table-cell').append('<span>'+xue17+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')*/
                //17在境外人员
                var xue17=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="在境外人员"] .xue1Single').length;i++){
                    xue17+=parseInt($('div[lay-id="demo"] td[data-field="在境外人员"] .xue1Single').eq(i).html())
                }
                var jiao17=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="在境外人员"] .jiao1Single').length;i++){
                    jiao17+=parseInt($('div[lay-id="demo"] td[data-field="在境外人员"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="在境外人员"] .layui-table-cell').append('<span>'+xue17+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')
                //18其中港澳台籍人员数
                var xue18=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其中港澳台籍人员数"] .xue1Single').length;i++){
                    xue18+=parseInt($('div[lay-id="demo"] td[data-field="其中港澳台籍人员数"] .xue1Single').eq(i).html())
                }
                var jiao18=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其中港澳台籍人员数"] .jiao1Single').length;i++){
                    jiao18+=parseInt($('div[lay-id="demo"] td[data-field="其中港澳台籍人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="其中港澳台籍人员数"] .layui-table-cell').append('<span>'+xue18+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao18').append('<span>'+jiao18+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong18 ').append('<span>'+parseInt(xue18+jiao18)+'</span>')
                //19其中外籍人员数
                var xue19=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其中外籍人员数"] .xue1Single').length;i++){
                    xue19+=parseInt($('div[lay-id="demo"] td[data-field="其中外籍人员数"] .xue1Single').eq(i).html())
                }
                var jiao19=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="其中外籍人员数"] .jiao1Single').length;i++){
                    jiao19+=parseInt($('div[lay-id="demo"] td[data-field="其中外籍人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="其中外籍人员数"] .layui-table-cell').append('<span>'+xue19+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao19').append('<span>'+jiao19+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong19 ').append('<span>'+parseInt(xue19+jiao19)+'</span>')
                //20返校途中人数（当日10点前未到上海）
                var xue20=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').length;i++){
                    xue20+=parseInt($('div[lay-id="demo"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').eq(i).html())
                }
                var jiao20=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').length;i++){
                    jiao20+=parseInt($('div[lay-id="demo"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="返校途中人数（当日10点前未到上海）"] .layui-table-cell').append('<span>'+xue20+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao20').append('<span>'+jiao20+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong20 ').append('<span>'+parseInt(xue20+jiao20)+'</span>')
                //21失联人数
                var xue21=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="失联人数,手工填写"] .xue1Single').length;i++){
                    xue21+=parseInt($('div[lay-id="demo"] td[data-field="失联人数,手工填写"] .xue1Single').eq(i).html())
                }
                var jiao21=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="失联人数,手工填写"] .jiao1Single').length;i++){
                    jiao21+=parseInt($('div[lay-id="demo"] td[data-field="失联人数,手工填写"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="失联人数,手工填写"] .layui-table-cell').append('<span>'+xue21+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao21').append('<span>'+jiao21+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong21 ').append('<span>'+parseInt(xue21+jiao21)+'</span>')
                //固定合计行
                $('div[lay-id="demo"]').css('position','relative')
                var heji='<div class="heji"><table cellspacing="0" cellpadding="0" border="0" class="layui-table"><tbody>' +
                    '<tr><td data-field="schoolManageName" data-key="1-0-0" class="" rowspan="3"><div class="layui-table-cell laytable-cell-1-0-0">合计</div></td>' +
                    '<td data-field="机构总数" data-key="1-0-1" class="" rowspan="3"><div class="layui-table-cell laytable-cell-1-0-1"><span>'+jigouNum+'</span></div></td>'+
                    '<td data-field="identityName" data-key="1-0-2" class=""><div class="layui-table-cell laytable-cell-1-0-2"><span>学生人数</span></div></td>'+
                    '</tr>'+
                    '<tr><td class="jiao"><span>教工人数</span></td></tr>'+
                    '<tr><td class="zong"><span>师生总数</span></td></tr>'+
                    '</tbody></table></div>'
                $('div[lay-id="demo"] .layui-table-total').append(heji)
                // $('div[lay-id="demo"] .heji ').css({'position':'absolute','top':'95%'})
                var gao=$('div[lay-id="demo"]').height()-30
                $('div[lay-id="demo"] .heji ').css({'position':'absolute','top':gao})
            }
        });
        //设置当前时间
        $("#datestar").val(getBeforeDate(5));
       $("#datestar").val(getBeforeDate(5));
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


        //监听行单击事件
        table.on('row(test)', function(obj){
            var schoolManageType
            if(obj.data.SCHOOL_MANAGE_TYPE==undefined){
                schoolManageType=''
            }else{
                schoolManageType=obj.data.SCHOOL_MANAGE_TYPE
            }
            $.ajax({
                url:'/HealthyInfo/statisticsInfo',
                type:'post',
                dataType:'json',
                data:{
                    schoolManageType:schoolManageType,
                    groupBy:'dep.DEPT_ID',
                    createTime:$('#guanTime').val()
                },
                success:function (res) {
                    layer.open({
                        type: 1,
                        closeBtn: 1,
                        title: '详情',
                        area: ['95%', '90%'], //宽高
                        content: '<table id="test1" lay-filter="test1"></table>'
                        ,success:function () {
                            table.render({
                                elem: '#test1'
                                ,data: res.object
                                ,cellMinWidth:150
                                ,height:$(window).height()-190
                                ,totalRow: true
                                ,cols: [[ //表头
                                    {field: 'SCHOOL_NAME',fixed: 'left', title: '学校简称',totalRowText: '合计',rowspan: 2,templet: function(d){
                                            // console.log(d)
                                            if(d.SCHOOL_NAME!=undefined){
                                                return  '<span class="SCHOOL_NAME">'+d.SCHOOL_NAME+'</span>'
                                            }else{
                                                return ''
                                            }
                                        }}
                                    /*,{field: '机构总数', title: '机构总数',rowspan: 2,templet: function(d){
                                            return  '<span class="xueNum">'+d.机构总数+'</span>'
                                        } }*/
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
                                            if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '', title: '在境外人员（港澳台地区、国外）',colspan:3}
                                    ,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中',rowspan: 2,minWidth:300,templet: function(d){
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
                                                return '<a href="javascript:;"  class=" xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                            }else if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class=" jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                            }else if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class=" xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                            }else if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class=" jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
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
                                  /*  ,{field: '重点地区密切接触未过隔离期的人', title: '重点地区密切接触未过隔离期人数',minWidth:250,templet: function(d){
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
                                    ,{field: '其中在武汉人员数', title: '其中在武汉人员数',minWidth:250,templet: function(d){
                                            if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="gdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="gdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  schoolManageType="'+d.SCHOOL_MANAGE_TYPE+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
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
                                    /*,{field: '当日在其他区域人数', title: '当日在其他区域人数',minWidth:200,templet: function(d){
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
                                    ,{field: '其他区域密切接触人', title: '其他区域密切接触人数',minWidth:200,templet: function(d){
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
                                    /*  for(var i=0;i<$('.xueNum').length;i++){
                                          if($('.xueNum').eq(i).parent().parent().prev().attr('rowspan')=='2'){
                                              var xue=$('.xueNum').eq(i).html()
                                              var jiao=$('.xueNum').eq(i+1).html()
                                              $('.xueNum').eq(i).html(parseInt(xue)+parseInt(jiao))
                                              $('.xueNum').eq(i).parent().parent().attr('rowspan','2')
                                              $('.xueNum').eq(i+1).parent().parent().remove()
                                          }
                                      }*/
                                    $('div[lay-id="test1"] .layui-table-total tbody ').append('<tr><td class="jiao"></td><td class="jiao1"></td><td class="jiao2"></td><td class="jiao3"></td><td class="jiao4"></td><td class="jiao5"></td>' +
                                        '<td class="jiao6"></td><td class="jiao7"></td><td class="jiao8"></td><td class="jiao9"></td><td class="jiao10"></td><td class="jiao11"></td><td class="jiao12"></td><td class="jiao13"></td><td class="jiao14"></td><td class="jiao15"></td><td class="jiao16"></td><td class="jiao17"></td>'+
                                        '<td class="jiao18"></td><td class="jiao19"></td><td class="jiao20"></td><td class="jiao21"></td><td class="jiao22"></td>'+ '</tr>'+
                                        '<tr><td class="zong"></td><td class="zong1"></td><td class="zong2"></td><td class="zong3"></td><td class="zong4"></td><td class="zong5"></td>' +
                                        '<td class="zong6"></td><td class="zong7"></td><td class="zong8"></td><td class="zong9"></td><td class="zong10"></td><td class="zong11"></td><td class="zong12"></td><td class="zong13"></td><td class="zong14"></td><td class="zong15"></td><td class="zong16"></td><td class="zong17"></td>'+
                                        '<td class="zong18"></td><td class="zong19"></td><td class="zong20"></td><td class="zong21"></td><td class="zong22"></td>'+ '</tr>'
                                    )
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="SCHOOL_NAME"]').attr('rowspan','3')
                                    //对象类型
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="identityName"] .layui-table-cell').append('<span>学生人数</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao').append('<span>教工人数</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong ').append('<span>师生总数</span>')
                                    //1人员总数
                                    var xue1=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="人员总数"] .xue1Single').length;i++){
                                        xue1+=parseInt($('div[lay-id="test1"] td[data-field="人员总数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao1=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="人员总数"] .jiao1Single').length;i++){
                                        jiao1+=parseInt($('div[lay-id="test1"] td[data-field="人员总数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="人员总数"] .layui-table-cell').append('<span>'+xue1+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao1').append('<span>'+jiao1+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong1 ').append('<span>'+parseInt(xue1+jiao1)+'</span>')
                                    //2当日发现确诊人数
                                    var xue2=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .xue1Single').length;i++){
                                        xue2+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao2=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .jiao1Single').length;i++){
                                        jiao2+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日发现确诊人数"] .layui-table-cell').append('<span>'+xue2+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao2').append('<span>'+jiao2+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong2 ').append('<span>'+parseInt(xue2+jiao2)+'</span>')
                                    //3当日发现疑似人数
                                    var xue3=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .xue1Single').length;i++){
                                        xue3+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao3=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .jiao1Single').length;i++){
                                        jiao3+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日发现疑似人数"] .layui-table-cell').append('<span>'+xue3+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao3').append('<span>'+jiao3+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong3 ').append('<span>'+parseInt(xue3+jiao3)+'</span>')
                                    //4当日健康异常人数
                                    var xue4=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .xue1Single').length;i++){
                                        xue4+=parseInt($('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao4=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .jiao1Single').length;i++){
                                        jiao4+=parseInt($('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日健康异常人数"] .layui-table-cell').append('<span>'+xue4+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao4').append('<span>'+jiao4+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong4 ').append('<span>'+parseInt(xue4+jiao4)+'</span>')
                                    //5当日密切接触人数
                                    var xue5=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日密切接触人数"] .xue1Single').length;i++){
                                        xue5+=parseInt($('div[lay-id="test1"]  td[data-field="当日密切接触人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao5=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日密切接触人数"] .jiao1Single').length;i++){
                                        jiao5+=parseInt($('div[lay-id="test1"] td[data-field="当日密切接触人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日密切接触人数"] .layui-table-cell').append('<span>'+xue5+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao5').append('<span>'+jiao5+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong5 ').append('<span>'+parseInt(xue5+jiao5)+'</span>')
                                    //6当日隔离人员数
                                    var xue6=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日隔离人员数"] .xue1Single').length;i++){
                                        xue6+=parseInt($('div[lay-id="test1"]  td[data-field="当日隔离人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao6=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日隔离人员数"] .jiao1Single').length;i++){
                                        jiao6+=parseInt($('div[lay-id="test1"] td[data-field="当日隔离人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日隔离人员数"] .layui-table-cell').append('<span>'+xue6+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao6').append('<span>'+jiao6+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong6 ').append('<span>'+parseInt(xue6+jiao6)+'</span>')

                                    //7在沪人数
                                    var xue7=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="在沪人数"] .xue1Single').length;i++){
                                        xue7+=parseInt($('div[lay-id="test1"] td[data-field="在沪人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao7=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="在沪人数"] .jiao1Single').length;i++){
                                        jiao7+=parseInt($('div[lay-id="test1"] td[data-field="在沪人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="在沪人数"] .layui-table-cell').append('<span>'+xue7+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao7').append('<span>'+jiao7+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong7 ').append('<span>'+parseInt(xue7+jiao7)+'</span>')
                                    //8其中在沪留校人数
                                    var xue8=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="留校人数"] .xue1Single').length;i++){
                                        xue8+=parseInt($('div[lay-id="test1"] td[data-field="留校人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao8=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="留校人数"] .jiao1Single').length;i++){
                                        jiao8+=parseInt($('div[lay-id="test1"] td[data-field="留校人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="留校人数"] .layui-table-cell').append('<span>'+xue8+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')
                                    /*//在沪留校中密切接触未过隔离期人数
                                    var xue8=0
                                    for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').length;i++){
                                        xue8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').eq(i).html())
                                    }
                                    var jiao8=0
                                    for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').length;i++){
                                        jiao8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="demo"] .layui-table-total tbody td[data-field="留校+密切接触患病"] .layui-table-cell').append('<span>'+xue8+'</span>')
                                    $('div[lay-id="demo"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                                    $('div[lay-id="demo"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')*/
                                    //9当日从湖北（含途经）返沪人数
                                    var xue9=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="去过重点地区"] .xue1Single').length;i++){
                                        xue9+=parseInt($('div[lay-id="test1"] td[data-field="去过重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao9=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="去过重点地区"] .jiao1Single').length;i++){
                                        jiao9+=parseInt($('div[lay-id="test1"] td[data-field="去过重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="去过重点地区"] .layui-table-cell').append('<span>'+xue9+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao9').append('<span>'+jiao9+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong9 ').append('<span>'+parseInt(xue9+jiao9)+'</span>')
                                    //10当日从其他地区返沪人数
                                    var xue10=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日从其他地区返沪"] .xue1Single').length;i++){
                                        xue10+=parseInt($('div[lay-id="test1"] td[data-field="当日从其他地区返沪"] .xue1Single').eq(i).html())
                                    }
                                    var jiao10=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日从其他地区返沪"] .jiao1Single').length;i++){
                                        jiao10+=parseInt($('div[lay-id="test1"] td[data-field="当日从其他地区返沪"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日从其他地区返沪"] .layui-table-cell').append('<span>'+xue10+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao10').append('<span>'+jiao10+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong10 ').append('<span>'+parseInt(xue10+jiao10)+'</span>')
                                    //11目前居家隔离人数
                                    var xue11=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="目前在家隔离"] .xue1Single').length;i++){
                                        xue11+=parseInt($('div[lay-id="test1"]  td[data-field="目前在家隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao11=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="目前在家隔离"] .jiao1Single').length;i++){
                                        jiao11+=parseInt($('div[lay-id="test1"]  td[data-field="目前在家隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="目前在家隔离"] .layui-table-cell').append('<span>'+xue11+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao11').append('<span>'+jiao11+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong11 ').append('<span>'+parseInt(xue11+jiao11)+'</span>')
                                    //12目前集中隔离人数
                                    var xue12=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="目前集中隔离"] .xue1Single').length;i++){
                                        xue12+=parseInt($('div[lay-id="test1"] td[data-field="目前集中隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao12=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="目前集中隔离"] .jiao1Single').length;i++){
                                        jiao12+=parseInt($('div[lay-id="test1"] td[data-field="目前集中隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="目前集中隔离"] .layui-table-cell').append('<span>'+xue12+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao12').append('<span>'+jiao12+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong12 ').append('<span>'+parseInt(xue12+jiao12)+'</span>')
                                    //13当日解除隔离人数
                                    var xue13=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日接触隔离"] .xue1Single').length;i++){
                                        xue13+=parseInt($('div[lay-id="test1"] td[data-field="当日接触隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao13=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日接触隔离"] .jiao1Single').length;i++){
                                        jiao13+=parseInt($('div[lay-id="test1"] td[data-field="当日接触隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日接触隔离"] .layui-table-cell').append('<span>'+xue13+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao13').append('<span>'+jiao13+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong13 ').append('<span>'+parseInt(xue13+jiao13)+'</span>')
                                    //14当日在湖北人数
                                    var xue14=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在重点地区"] .xue1Single').length;i++){
                                        xue14+=parseInt($('div[lay-id="test1"] td[data-field="当日在重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao14=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在重点地区"] .jiao1Single').length;i++){
                                        jiao14+=parseInt($('div[lay-id="test1"] td[data-field="当日在重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日在重点地区"] .layui-table-cell').append('<span>'+xue14+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao14').append('<span>'+jiao14+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong14 ').append('<span>'+parseInt(xue14+jiao14)+'</span>')
                                    //15其中在武汉人员数
                                    var xue15=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其中在武汉人员数"] .xue1Single').length;i++){
                                        xue15+=parseInt($('div[lay-id="test1"] td[data-field="其中在武汉人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao15=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其中在武汉人员数"] .jiao1Single').length;i++){
                                        jiao15+=parseInt($('div[lay-id="test1"] td[data-field="其中在武汉人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="其中在武汉人员数"] .layui-table-cell').append('<span>'+xue15+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao15').append('<span>'+jiao15+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong15 ').append('<span>'+parseInt(xue15+jiao15)+'</span>')
                                    //16在其他地区人员（不含境外）
                                    var xue16=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .xue1Single').length;i++){
                                        xue16+=parseInt($('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao16=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .jiao1Single').length;i++){
                                        jiao16+=parseInt($('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日在其他区域人数"] .layui-table-cell').append('<span>'+xue16+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao16').append('<span>'+jiao16+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong16 ').append('<span>'+parseInt(xue16+jiao16)+'</span>')
                                    /* //17其他区域密切接触人数
                                     var xue17=0
                                     for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').length;i++){
                                         xue17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').eq(i).html())
                                     }
                                     var jiao17=0
                                     for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').length;i++){
                                         jiao17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').eq(i).html())
                                     }
                                     $('div[lay-id="demo"] .layui-table-total tbody td[data-field="其他区域密切接触人"] .layui-table-cell').append('<span>'+xue17+'</span>')
                                     $('div[lay-id="demo"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                                     $('div[lay-id="demo"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')*/
                                    //17在境外人员
                                    var xue17=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="在境外人员"] .xue1Single').length;i++){
                                        xue17+=parseInt($('div[lay-id="test1"] td[data-field="在境外人员"] .xue1Single').eq(i).html())
                                    }
                                    var jiao17=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="在境外人员"] .jiao1Single').length;i++){
                                        jiao17+=parseInt($('div[lay-id="test1"] td[data-field="在境外人员"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="在境外人员"] .layui-table-cell').append('<span>'+xue17+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')
                                    //18其中港澳台籍人员数
                                    var xue18=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其中港澳台籍人员数"] .xue1Single').length;i++){
                                        xue18+=parseInt($('div[lay-id="test1"] td[data-field="其中港澳台籍人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao18=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其中港澳台籍人员数"] .jiao1Single').length;i++){
                                        jiao18+=parseInt($('div[lay-id="test1"] td[data-field="其中港澳台籍人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="其中港澳台籍人员数"] .layui-table-cell').append('<span>'+xue18+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao18').append('<span>'+jiao18+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong18 ').append('<span>'+parseInt(xue18+jiao18)+'</span>')
                                    //19其中外籍人员数
                                    var xue19=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其中外籍人员数"] .xue1Single').length;i++){
                                        xue19+=parseInt($('div[lay-id="test1"] td[data-field="其中外籍人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao19=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其中外籍人员数"] .jiao1Single').length;i++){
                                        jiao19+=parseInt($('div[lay-id="test1"] td[data-field="其中外籍人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="其中外籍人员数"] .layui-table-cell').append('<span>'+xue19+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao19').append('<span>'+jiao19+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong19 ').append('<span>'+parseInt(xue19+jiao19)+'</span>')
                                    //20返校途中人数（当日10点前未到上海）
                                    var xue20=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').length;i++){
                                        xue20+=parseInt($('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').eq(i).html())
                                    }
                                    var jiao20=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').length;i++){
                                        jiao20+=parseInt($('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="返校途中人数（当日10点前未到上海）"] .layui-table-cell').append('<span>'+xue20+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao20').append('<span>'+jiao20+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong20 ').append('<span>'+parseInt(xue20+jiao20)+'</span>')
                                    //21失联人数
                                    var xue21=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .xue1Single').length;i++){
                                        xue21+=parseInt($('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .xue1Single').eq(i).html())
                                    }
                                    var jiao21=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .jiao1Single').length;i++){
                                        jiao21+=parseInt($('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="失联人数,手工填写"] .layui-table-cell').append('<span>'+xue21+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao21').append('<span>'+jiao21+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong21 ').append('<span>'+parseInt(xue21+jiao21)+'</span>')
                                    /*//当日发现确诊人数
                                    var xue1=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .xue1Single').length;i++){
                                        xue1+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao1=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .jiao1Single').length;i++){
                                        jiao1+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现确诊人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日发现确诊人数"] .layui-table-cell').append('<span>'+xue1+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao1').append('<span>'+jiao1+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong1 ').append('<span>'+parseInt(xue1+jiao1)+'</span>')
                                    //当日发现疑似人数
                                    var xue2=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .xue1Single').length;i++){
                                        xue2+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao2=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .jiao1Single').length;i++){
                                        jiao2+=parseInt($('div[lay-id="test1"]  td[data-field="当日发现疑似人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日发现疑似人数"] .layui-table-cell').append('<span>'+xue2+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao2').append('<span>'+jiao2+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong2 ').append('<span>'+parseInt(xue2+jiao2)+'</span>')
                                    //当日健康异常人数
                                    var xue3=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .xue1Single').length;i++){
                                        xue3+=parseInt($('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao3=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .jiao1Single').length;i++){
                                        jiao3+=parseInt($('div[lay-id="test1"]  td[data-field="当日健康异常人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日健康异常人数"] .layui-table-cell').append('<span>'+xue3+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao3').append('<span>'+jiao3+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong3 ').append('<span>'+parseInt(xue3+jiao3)+'</span>')
                                    //当日密切接触人数
                                    var xue4=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日密切接触人数"] .xue1Single').length;i++){
                                        xue4+=parseInt($('div[lay-id="test1"]  td[data-field="当日密切接触人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao4=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日密切接触人数"] .jiao1Single').length;i++){
                                        jiao4+=parseInt($('div[lay-id="test1"] td[data-field="当日密切接触人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日密切接触人数"] .layui-table-cell').append('<span>'+xue4+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao4').append('<span>'+jiao4+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong4 ').append('<span>'+parseInt(xue4+jiao4)+'</span>')
                                    //人员总数
                                    var xue5=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="人员总数"] .xue1Single').length;i++){
                                        xue5+=parseInt($('div[lay-id="test1"] td[data-field="人员总数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao5=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="人员总数"] .jiao1Single').length;i++){
                                        jiao5+=parseInt($('div[lay-id="test1"] td[data-field="人员总数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="人员总数"] .layui-table-cell').append('<span>'+xue5+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao5').append('<span>'+jiao5+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong5 ').append('<span>'+parseInt(xue5+jiao5)+'</span>')
                                    //在沪人数
                                    var xue6=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="在沪人数"] .xue1Single').length;i++){
                                        xue6+=parseInt($('div[lay-id="test1"] td[data-field="在沪人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao6=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="在沪人数"] .jiao1Single').length;i++){
                                        jiao6+=parseInt($('div[lay-id="test1"] td[data-field="在沪人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="在沪人数"] .layui-table-cell').append('<span>'+xue6+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao6').append('<span>'+jiao6+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong6 ').append('<span>'+parseInt(xue6+jiao6)+'</span>')
                                    //其中在沪留校人数
                                    var xue7=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="留校人数"] .xue1Single').length;i++){
                                        xue7+=parseInt($('div[lay-id="test1"] td[data-field="留校人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao7=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="留校人数"] .jiao1Single').length;i++){
                                        jiao7+=parseInt($('div[lay-id="test1"] td[data-field="留校人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="留校人数"] .layui-table-cell').append('<span>'+xue7+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao7').append('<span>'+jiao7+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong7 ').append('<span>'+parseInt(xue7+jiao7)+'</span>')
                                    //在沪留校中密切接触未过隔离期人数
                                    var xue8=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="留校+密切接触患病"] .xue1Single').length;i++){
                                        xue8+=parseInt($('div[lay-id="test1"] td[data-field="留校+密切接触患病"] .xue1Single').eq(i).html())
                                    }
                                    var jiao8=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="留校+密切接触患病"] .jiao1Single').length;i++){
                                        jiao8+=parseInt($('div[lay-id="test1"] td[data-field="留校+密切接触患病"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="留校+密切接触患病"] .layui-table-cell').append('<span>'+xue8+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')
                                    //当日从湖北（含途经）返沪人数
                                    var xue9=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="去过重点地区"] .xue1Single').length;i++){
                                        xue9+=parseInt($('div[lay-id="test1"] td[data-field="去过重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao9=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="去过重点地区"] .jiao1Single').length;i++){
                                        jiao9+=parseInt($('div[lay-id="test1"] td[data-field="去过重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="去过重点地区"] .layui-table-cell').append('<span>'+xue9+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao9').append('<span>'+jiao9+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong9 ').append('<span>'+parseInt(xue9+jiao9)+'</span>')
                                    //当日从其他地区返沪人数
                                    var xue10=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日从其他地区返沪"] .xue1Single').length;i++){
                                        xue10+=parseInt($('div[lay-id="test1"] td[data-field="当日从其他地区返沪"] .xue1Single').eq(i).html())
                                    }
                                    var jiao10=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="当日从其他地区返沪"] .jiao1Single').length;i++){
                                        jiao10+=parseInt($('div[lay-id="test1"] td[data-field="当日从其他地区返沪"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日从其他地区返沪"] .layui-table-cell').append('<span>'+xue10+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao10').append('<span>'+jiao10+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong10 ').append('<span>'+parseInt(xue10+jiao10)+'</span>')
                                    //目前居家隔离人数
                                    var xue11=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="目前在家隔离"] .xue1Single').length;i++){
                                        xue11+=parseInt($('div[lay-id="test1"]  td[data-field="目前在家隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao11=0
                                    for(var i=0;i<$('div[lay-id="test1"]  td[data-field="目前在家隔离"] .jiao1Single').length;i++){
                                        jiao11+=parseInt($('div[lay-id="test1"]  td[data-field="目前在家隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="目前在家隔离"] .layui-table-cell').append('<span>'+xue11+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao11').append('<span>'+jiao11+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong11 ').append('<span>'+parseInt(xue11+jiao11)+'</span>')
                                    //目前集中隔离人数
                                    var xue12=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="目前集中隔离"] .xue1Single').length;i++){
                                        xue12+=parseInt($('div[lay-id="test1"] td[data-field="目前集中隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao12=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="目前集中隔离"] .jiao1Single').length;i++){
                                        jiao12+=parseInt($('div[lay-id="test1"] td[data-field="目前集中隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="目前集中隔离"] .layui-table-cell').append('<span>'+xue12+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao12').append('<span>'+jiao12+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong12 ').append('<span>'+parseInt(xue12+jiao12)+'</span>')
                                    //当日解除隔离人数
                                    var xue13=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日接触隔离"] .xue1Single').length;i++){
                                        xue13+=parseInt($('div[lay-id="test1"] td[data-field="当日接触隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao13=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日接触隔离"] .jiao1Single').length;i++){
                                        jiao13+=parseInt($('div[lay-id="test1"] td[data-field="当日接触隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日接触隔离"] .layui-table-cell').append('<span>'+xue13+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao13').append('<span>'+jiao13+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong13 ').append('<span>'+parseInt(xue13+jiao13)+'</span>')
                                    //当日在湖北人数
                                    var xue14=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在重点地区"] .xue1Single').length;i++){
                                        xue14+=parseInt($('div[lay-id="test1"] td[data-field="当日在重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao14=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在重点地区"] .jiao1Single').length;i++){
                                        jiao14+=parseInt($('div[lay-id="test1"] td[data-field="当日在重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日在重点地区"] .layui-table-cell').append('<span>'+xue14+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao14').append('<span>'+jiao14+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong14 ').append('<span>'+parseInt(xue14+jiao14)+'</span>')
                                    //重点地区密切接触未过隔离期人数
                                    var xue15=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="重点地区密切接触未过隔离期的人"] .xue1Single').length;i++){
                                        xue15+=parseInt($('div[lay-id="test1"] td[data-field="重点地区密切接触未过隔离期的人"] .xue1Single').eq(i).html())
                                    }
                                    var jiao15=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="重点地区密切接触未过隔离期的人"] .jiao1Single').length;i++){
                                        jiao15+=parseInt($('div[lay-id="test1"] td[data-field="重点地区密切接触未过隔离期的人"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="重点地区密切接触未过隔离期的人"] .layui-table-cell').append('<span>'+xue15+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao15').append('<span>'+jiao15+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong15 ').append('<span>'+parseInt(xue15+jiao15)+'</span>')
                                    //当日在其他区域人数
                                    var xue16=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .xue1Single').length;i++){
                                        xue16+=parseInt($('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao16=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .jiao1Single').length;i++){
                                        jiao16+=parseInt($('div[lay-id="test1"] td[data-field="当日在其他区域人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="当日在其他区域人数"] .layui-table-cell').append('<span>'+xue16+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao16').append('<span>'+jiao16+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong16 ').append('<span>'+parseInt(xue16+jiao16)+'</span>')
                                    //其他区域密切接触人数
                                    var xue17=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其他区域密切接触人"] .xue1Single').length;i++){
                                        xue17+=parseInt($('div[lay-id="test1"] td[data-field="其他区域密切接触人"] .xue1Single').eq(i).html())
                                    }
                                    var jiao17=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其他区域密切接触人"] .jiao1Single').length;i++){
                                        jiao17+=parseInt($('div[lay-id="test1"] td[data-field="其他区域密切接触人"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="其他区域密切接触人"] .layui-table-cell').append('<span>'+xue17+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')
                                    //其他区域曾途经湖北人数
                                    var xue18=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其他区域曾途经湖北人数"] .xue1Single').length;i++){
                                        xue18+=parseInt($('div[lay-id="test1"] td[data-field="其他区域曾途经湖北人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao18=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="其他区域曾途经湖北人数"] .jiao1Single').length;i++){
                                        jiao18+=parseInt($('div[lay-id="test1"] td[data-field="其他区域曾途经湖北人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="其他区域曾途经湖北人数"] .layui-table-cell').append('<span>'+xue18+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao18').append('<span>'+jiao18+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong18 ').append('<span>'+parseInt(xue18+jiao18)+'</span>')
                                    //返校途中人数（当日10点前未到上海）
                                    var xue19=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').length;i++){
                                        xue19+=parseInt($('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').eq(i).html())
                                    }
                                    var jiao19=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').length;i++){
                                        jiao19+=parseInt($('div[lay-id="test1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="返校途中人数（当日10点前未到上海）"] .layui-table-cell').append('<span>'+xue19+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao19').append('<span>'+jiao19+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong19 ').append('<span>'+parseInt(xue19+jiao19)+'</span>')
                                    //返校途中密切接触人数
                                    var xue20=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中密切接触人数"] .xue1Single').length;i++){
                                        xue20+=parseInt($('div[lay-id="test1"] td[data-field="返校途中密切接触人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao20=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中密切接触人数"] .jiao1Single').length;i++){
                                        jiao20+=parseInt($('div[lay-id="test1"] td[data-field="返校途中密切接触人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="返校途中密切接触人数"] .layui-table-cell').append('<span>'+xue20+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao20').append('<span>'+jiao20+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong20 ').append('<span>'+parseInt(xue20+jiao20)+'</span>')
                                    //返校途中途经湖北人数
                                    var xue21=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中途经湖北人数"] .xue1Single').length;i++){
                                        xue21+=parseInt($('div[lay-id="test1"] td[data-field="返校途中途经湖北人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao21=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="返校途中途经湖北人数"] .jiao1Single').length;i++){
                                        jiao21+=parseInt($('div[lay-id="test1"] td[data-field="返校途中途经湖北人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="test1"] .layui-table-total tbody td[data-field="返校途中途经湖北人数"] .layui-table-cell').append('<span>'+xue21+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao21').append('<span>'+jiao21+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong21 ').append('<span>'+parseInt(xue21+jiao21)+'</span>')
                                    //失联人数
                                    var xue22=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .xue1Single').length;i++){
                                        xue22+=parseInt($('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .xue1Single').eq(i).html())
                                    }
                                    var jiao22=0
                                    for(var i=0;i<$('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .jiao1Single').length;i++){
                                        jiao22+=parseInt($('div[lay-id="test1"] td[data-field="失联人数,手工填写"] .jiao1Single').eq(i).html())
                                    }*/
                                    /*$('div[lay-id="test1"] .layui-table-total tbody td[data-field="失联人数,手工填写"] .layui-table-cell').append('<span>'+xue22+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .jiao22').append('<span>'+jiao22+'</span>')
                                    $('div[lay-id="test1"] .layui-table-total tbody .zong22 ').append('<span>'+parseInt(xue22+jiao22)+'</span>')*/
                                    //固定合计行
                                    $('div[lay-id="test1"]').css('position','relative')
                                    var heji='<div class="heji"><table cellspacing="0" cellpadding="0" border="0" class="layui-table"><tbody>' +
                                        '<tr><td data-field="schoolManageName" data-key="1-0-0" class="" rowspan="3"><div class="layui-table-cell laytable-cell-1-0-0">合计</div></td>' +
                                        '<td data-field="identityName" data-key="1-0-2" class=""><div class="layui-table-cell laytable-cell-1-0-2"><span>学生人数</span></div></td>'+
                                        '</tr>'+
                                        '<tr><td class="jiao"><span>教工人数</span></td></tr>'+
                                        '<tr><td class="zong"><span>师生总数</span></td></tr>'+
                                        '</tbody></table></div>'
                                    $('div[lay-id="test1"] .layui-table-total').append(heji)
                                    // $('div[lay-id="test1"] .heji ').css({'position':'absolute','top':'95%'})
                                    var gao=$('div[lay-id="test1"]').height()-30
                                    $('div[lay-id="test1"] .heji ').css({'position':'absolute','top':gao})
                                }
                            });
                        }
                    });
                }
            })

        });
        //第一个实例
        var tableIns2=table.render({
            elem: '#jie'
            ,url: '/HealthyInfo/statisticsInfo' //数据接口
            ,where:{
                groupBy:'rhi.LIVE_STREET',
                createTime:$('#jieTime').val()
            }
            ,cellMinWidth:150
            ,height:$(window).height()-195
            ,totalRow: true
            ,cols: [[ //表头
                {field: 'liveStreetName',fixed: 'left', title: '街镇',totalRowText: '合计',rowspan: 2,templet: function(d){
                        return  '<span class="liveStreetName">'+d.liveStreetName+'</span>'
                    }}
                /*,{field: '机构总数', title: '机构总数',rowspan: 2 ,templet: function(d){
                        return  '<span class="jigouNum1">'+d.机构总数+'</span>'
                    }}*/
                ,{field: 'identityName',fixed: 'left', title: '人员分类', rowspan: 2}
                ,{field: '人员总数', title: '人员总数', rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.人员总数!==undefined){
                            return  '<span class="xue1Single">'+d.人员总数+'</span>'
                        }else if(d.identityName=='教职员工' && d.人员总数!==undefined) {
                            return  '<span class="jiao1Single">'+d.人员总数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日发现确诊人数', title: '当日发现确诊人数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日发现确诊人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日发现确诊人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日发现确诊人数!==undefined) {
                            return  '<span class="jiao1Single">'+d.当日发现确诊人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日发现疑似人数', title: '当日发现疑似人数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日发现疑似人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日发现疑似人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日发现疑似人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日发现疑似人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日健康异常人数', title: '当日健康异常人数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日健康异常人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日健康异常人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日健康异常人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日健康异常人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日密切接触人数', title: '当日密切接触人数',rowspan: 2 ,templet: function(d){
                        if(d.identityName=='学生' && d.当日密切接触人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日密切接触人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日密切接触人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日密切接触人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日隔离人员数', title: '当日隔离人员数',rowspan: 2,templet: function(d){
                        if(d.identityName=='学生' && d.当日隔离人员数!==undefined){
                            return  '<span class="xue1Single">'+d.当日隔离人员数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日隔离人员数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日隔离人员数+'</span>'
                        }else{
                            return '0'
                        }
                    } }
                ,{field: '', title: '在沪人员',colspan:7}
                ,{field: '', title: '在湖北',colspan:2}
                // ,{field: '', title: '在重点关注地区',colspan:3}
                ,{field: '当日在其他区域人数', title: '在其他地区人员（不含境外）',rowspan: 2,minWidth:300,templet: function(d){
                        if(d.identityName=='学生' && d.当日在其他区域人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日在其他区域人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.当日在其他区域人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日在其他区域人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '', title: '在境外人员（港澳台地区、国外）',colspan:3}
                ,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中',rowspan: 2,minWidth:300,templet: function(d){
                        if(d.identityName=='学生' && d['返校途中人数（当日10点前未到上海）']!==undefined){
                            return  '<span class="xue1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else if(d.identityName=='教职员工' && d['返校途中人数（当日10点前未到上海）']!==undefined) {
                            return  '<span class="jiao1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                // ,{field: '失联人数,手工填写', title: '失联人数',rowspan:2}
            ],[
                {field: '在沪人数', title: '在沪人数',templet: function(d){
                        if(d.identityName=='学生' && d.在沪人数!==undefined){
                            return  '<span class="xue1Single">'+d.在沪人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.在沪人数!==undefined){
                            return  '<span class="jiao1Single">'+d.在沪人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '留校人数', title: '其中在沪留校人数',templet: function(d){
                        if(d.identityName=='学生' && d.留校人数!==undefined){
                            return  '<span class="xue1Single">'+d.留校人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.留校人数!==undefined) {
                            return  '<span class="jiao1Single">'+d.留校人数+'</span>'
                        }else{
                            return '0'
                        }
                    } }
               /* ,{field: '留校+密切接触患病', title: '在沪留校中密切接触未过隔离期人数', minWidth:270,templet: function(d){
                        if(d.identityName=='学生' && d['留校+密切接触患病']!==undefined){
                            return  '<span class="xue1Single">'+d['留校+密切接触患病']+'</span>'
                        }else if(d.identityName=='教职员工' && d['留校+密切接触患病']!==undefined){
                            return  '<span class="jiao1Single">'+d['留校+密切接触患病']+'</span>'
                        }else{
                            return '0'
                        }
                    }}*/
                ,{field: '去过重点地区', title: '当日从湖北（含途经）返沪人数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.去过重点地区!==undefined){
                            return  '<span class="xue1Single">'+d.去过重点地区+'</span>'
                        }else if(d.identityName=='教职员工' && d.去过重点地区!==undefined){
                            return  '<span class="jiao1Single">'+d.去过重点地区+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                // ,{field: '去过重点关注地区', title: '当日从重点关注地区返沪人数',minWidth:250}
                ,{field: '当日从其他地区返沪', title: '当日从其他地区返沪人数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.当日从其他地区返沪!==undefined){
                            return  '<span class="xue1Single">'+d.当日从其他地区返沪+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日从其他地区返沪!==undefined){
                            return  '<span class="jiao1Single">'+d.当日从其他地区返沪+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '目前在家隔离', title: '目前居家隔离人数',templet: function(d){
                        if(d.identityName=='学生' && d.目前在家隔离!==undefined){
                            return  '<span class="xue1Single">'+d.目前在家隔离+'</span>'
                        }else if(d.identityName=='教职员工' && d.目前在家隔离!==undefined){
                            return  '<span class="jiao1Single">'+d.目前在家隔离+'</span>'
                        }else{
                            return '0'
                        }
                    }  }
                ,{field: '目前集中隔离', title: '目前集中隔离人数',templet: function(d){
                        if(d.identityName=='学生' && d.目前集中隔离!==undefined){
                            return  '<span class="xue1Single">'+d.目前集中隔离+'</span>'
                        }else if(d.identityName=='教职员工' && d.目前集中隔离!==undefined){
                            return  '<span class="jiao1Single">'+d.目前集中隔离+'</span>'
                        }else{
                            return '0'
                        }
                    } }
                ,{field: '当日接触隔离', title: '当日解除隔离人数',templet: function(d){
                        if(d.identityName=='学生' && d.当日接触隔离!==undefined){
                            return  '<span class="xue1Single">'+d.当日接触隔离+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日接触隔离!==undefined){
                            return  '<span class="jiao1Single">'+d.当日接触隔离+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '当日在重点地区', title: '当日在湖北人数',templet: function(d){
                        if(d.identityName=='学生' && d.当日在重点地区!==undefined){
                            return  '<span class="xue1Single">'+d.当日在重点地区+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日在重点地区!==undefined){
                            return  '<span class="jiao1Single">'+d.当日在重点地区+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                /*,{field: '重点地区密切接触未过隔离期的人', title: '重点地区密切接触未过隔离期人数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.重点地区密切接触未过隔离期的人!==undefined){
                            return  '<span class="xue1Single">'+d.重点地区密切接触未过隔离期的人+'</span>'
                        }else if(d.identityName=='教职员工' && d.重点地区密切接触未过隔离期的人!==undefined){
                            return  '<span class="jiao1Single">'+d.重点地区密切接触未过隔离期的人+'</span>'
                        }else{
                            return '0'
                        }
                    }}*/
                ,{field: '其中在武汉人员数', title: '其中在武汉人员数',minWidth:250,templet: function(d){
                        if(d.identityName=='学生' && d.其中在武汉人员数!==undefined){
                            return  '<span class="xue1Single">'+d.其中在武汉人员数+'</span>'
                        }else if(d.identityName=='教职员工' && d.其中在武汉人员数!==undefined){
                            return  '<span class="jiao1Single">'+d.其中在武汉人员数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                // ,{field: '2/23日前不返沪人数', title: '2/23日前不返沪人数',minWidth:200}
                /* ,{field: '当日在重点关注地区人数', title: '当日在重点关注地区人数',minWidth:200}
                 ,{field: '重点关注地区密切接触人数', title: '重点关注地区密切接触人数',minWidth:200}
                 ,{field: '重点关注地区途经湖北', title: '重点关注地区途经湖北',minWidth:200}*/
                /*,{field: '当日在其他区域人数', title: '当日在其他区域人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.当日在其他区域人数!==undefined){
                            return  '<span class="xue1Single">'+d.当日在其他区域人数+'</span>'
                        }else if(d.identityName=='教职员工' && d.当日在其他区域人数!==undefined){
                            return  '<span class="jiao1Single">'+d.当日在其他区域人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '其他区域密切接触人', title: '其他区域密切接触人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.其他区域密切接触人!==undefined){
                            return  '<span class="xue1Single">'+d.其他区域密切接触人+'</span>'
                        }else if(d.identityName=='教职员工' && d.其他区域密切接触人!==undefined){
                            return  '<span class="jiao1Single">'+d.其他区域密切接触人+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '其他区域曾途经湖北人数', title: '其他区域曾途经湖北人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.其他区域曾途经湖北人数!==undefined){
                            return  '<span class="xue1Single">'+d.其他区域曾途经湖北人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.其他区域曾途经湖北人数!==undefined){
                            return  '<span class="jiao1Single">'+d.其他区域曾途经湖北人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}*/
                ,{field: '在境外人员', title: '核查人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.在境外人员!==undefined){
                            return  '<span class="xue1Single">'+d.在境外人员+'</span>'
                        }else if(d.identityName=='教职员工' && d.在境外人员!==undefined){
                            return  '<span class="jiao1Single">'+d.在境外人员+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '其中港澳台籍人员数', title: '其中港澳台籍人员数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.其中港澳台籍人员数!==undefined){
                            return  '<span class="xue1Single">'+d.其中港澳台籍人员数+'</span>'
                        }else if(d.identityName=='教职员工' && d.其中港澳台籍人员数!==undefined){
                            return  '<span class="jiao1Single">'+d.其中港澳台籍人员数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '其中外籍人员数', title: '其中外籍人员数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.其中外籍人员数!==undefined){
                            return  '<span class="xue1Single">'+d.其中外籍人员数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.其中外籍人员数!==undefined){
                            return  '<span class="jiao1Single">'+d.其中外籍人员数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                /*,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中人数（当日10点前未到上海）',minWidth:300,templet: function(d){
                        if(d.identityName=='学生' && d['返校途中人数（当日10点前未到上海）']!==undefined){
                            return  '<span class="xue1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else if(d.identityName=='教职员工' && d['返校途中人数（当日10点前未到上海）']!==undefined) {
                            return  '<span class="jiao1Single">'+d['返校途中人数（当日10点前未到上海）']+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '返校途中密切接触人数', title: '返校途中密切接触人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.返校途中密切接触人数!==undefined){
                            return  '<span class="xue1Single">'+d.返校途中密切接触人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.返校途中密切接触人数!==undefined){
                            return  '<span class="jiao1Single">'+d.返校途中密切接触人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}
                ,{field: '返校途中途经湖北人数', title: '返校途中途经湖北人数',minWidth:200,templet: function(d){
                        if(d.identityName=='学生' && d.返校途中途经湖北人数!==undefined){
                            return  '<span class="xue1Single">'+d.返校途中途经湖北人数+'</span>'
                        }else  if(d.identityName=='教职员工' && d.返校途中途经湖北人数!==undefined){
                            return  '<span class="jiao1Single">'+d.返校途中途经湖北人数+'</span>'
                        }else{
                            return '0'
                        }
                    }}*/
            ]
            ]
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.object //解析数据列表
                };
            }
            ,done:function () {
                if($('div[lay-id="jie"] .layui-none').html()=='无数据'){
                    $('div[lay-id="jie"] .layui-table-total').hide()
                }
                for(var i=0;i<$('.layui-table-fixed .liveStreetName').length;i++){
                    if($('.layui-table-fixed .liveStreetName').eq(i).html()==$('.layui-table-fixed .liveStreetName').eq(i+1).html()){
                        $('.layui-table-fixed .liveStreetName').eq(i).parent().parent().attr('rowspan','2')
                        $('.layui-table-fixed .liveStreetName').eq(i+1).parent().parent().remove()
                    }
                }
                /* for(var i=0;i<$('.layui-table-main .jigouNum1').length;i++){
                     if($('.layui-table-main .jigouNum1').eq(i).parent().parent().prev().attr('rowspan')=='2'){
                         var xue=$('.layui-table-main .jigouNum1').eq(i).html()
                         var jiao=$('.layui-table-main .jigouNum1').eq(i+1).html()
                         $('.layui-table-main .jigouNum1').eq(i).html(parseInt(xue)+parseInt(jiao))
                         $('.layui-table-main .jigouNum1').eq(i).parent().parent().attr('rowspan','2')
                         $('.layui-table-main .jigouNum1').eq(i+1).parent().parent().remove()
                     }
                 }*/
                $('div[lay-id="jie"] .layui-table-total tbody ').append('<tr><td class="jiao"></td><td class="jiao1"></td><td class="jiao2"></td><td class="jiao3"></td><td class="jiao4"></td><td class="jiao5"></td>' +
                    '<td class="jiao6"></td><td class="jiao7"></td><td class="jiao8"></td><td class="jiao9"></td><td class="jiao10"></td><td class="jiao11"></td><td class="jiao12"></td><td class="jiao13"></td><td class="jiao14"></td><td class="jiao15"></td><td class="jiao16"></td><td class="jiao17"></td>'+
                    '<td class="jiao18"></td><td class="jiao19"></td><td class="jiao20"></td><td class="jiao21"></td>'+ '</tr>'+
                    '<tr><td class="zong"></td><td class="zong1"></td><td class="zong2"></td><td class="zong3"></td><td class="zong4"></td><td class="zong5"></td>' +
                    '<td class="zong6"></td><td class="zong7"></td><td class="zong8"></td><td class="zong9"></td><td class="zong10"></td><td class="zong11"></td><td class="zong12"></td><td class="zong13"></td><td class="zong14"></td><td class="zong15"></td><td class="zong16"></td><td class="zong17"></td>'+
                    '<td class="zong18"></td><td class="zong19"></td><td class="zong20"></td><td class="zong21"></td></td>'+ '</tr>'
                )
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="liveStreetName"]').attr('rowspan','3')
                //对象类型
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="identityName"] .layui-table-cell').append('<span>学生人数</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao').append('<span>教工人数</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong ').append('<span>师生总数</span>')

                //1人员总数
                var xue1=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="人员总数"] .xue1Single').length;i++){
                    xue1+=parseInt($('div[lay-id="jie"] td[data-field="人员总数"] .xue1Single').eq(i).html())
                }
                var jiao1=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="人员总数"] .jiao1Single').length;i++){
                    jiao1+=parseInt($('div[lay-id="jie"] td[data-field="人员总数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="人员总数"] .layui-table-cell').append('<span>'+xue1+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao1').append('<span>'+jiao1+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong1 ').append('<span>'+parseInt(xue1+jiao1)+'</span>')
                //2当日发现确诊人数
                var xue2=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日发现确诊人数"] .xue1Single').length;i++){
                    xue2+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现确诊人数"] .xue1Single').eq(i).html())
                }
                var jiao2=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日发现确诊人数"] .jiao1Single').length;i++){
                    jiao2+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现确诊人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日发现确诊人数"] .layui-table-cell').append('<span>'+xue2+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao2').append('<span>'+jiao2+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong2 ').append('<span>'+parseInt(xue2+jiao2)+'</span>')
                //3当日发现疑似人数
                var xue3=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .xue1Single').length;i++){
                    xue3+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .xue1Single').eq(i).html())
                }
                var jiao3=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .jiao1Single').length;i++){
                    jiao3+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日发现疑似人数"] .layui-table-cell').append('<span>'+xue3+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao3').append('<span>'+jiao3+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong3 ').append('<span>'+parseInt(xue3+jiao3)+'</span>')
                //4当日健康异常人数
                var xue4=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .xue1Single').length;i++){
                    xue4+=parseInt($('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .xue1Single').eq(i).html())
                }
                var jiao4=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .jiao1Single').length;i++){
                    jiao4+=parseInt($('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日健康异常人数"] .layui-table-cell').append('<span>'+xue4+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao4').append('<span>'+jiao4+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong4 ').append('<span>'+parseInt(xue4+jiao4)+'</span>')
                //5当日密切接触人数
                var xue5=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日密切接触人数"] .xue1Single').length;i++){
                    xue5+=parseInt($('div[lay-id="jie"]  td[data-field="当日密切接触人数"] .xue1Single').eq(i).html())
                }
                var jiao5=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日密切接触人数"] .jiao1Single').length;i++){
                    jiao5+=parseInt($('div[lay-id="jie"] td[data-field="当日密切接触人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日密切接触人数"] .layui-table-cell').append('<span>'+xue5+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao5').append('<span>'+jiao5+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong5 ').append('<span>'+parseInt(xue5+jiao5)+'</span>')
                //6当日隔离人员数
                var xue6=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日隔离人员数"] .xue1Single').length;i++){
                    xue6+=parseInt($('div[lay-id="jie"]  td[data-field="当日隔离人员数"] .xue1Single').eq(i).html())
                }
                var jiao6=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日隔离人员数"] .jiao1Single').length;i++){
                    jiao6+=parseInt($('div[lay-id="jie"] td[data-field="当日隔离人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日隔离人员数"] .layui-table-cell').append('<span>'+xue6+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao6').append('<span>'+jiao6+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong6 ').append('<span>'+parseInt(xue6+jiao6)+'</span>')

                //7在沪人数
                var xue7=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="在沪人数"] .xue1Single').length;i++){
                    xue7+=parseInt($('div[lay-id="jie"] td[data-field="在沪人数"] .xue1Single').eq(i).html())
                }
                var jiao7=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="在沪人数"] .jiao1Single').length;i++){
                    jiao7+=parseInt($('div[lay-id="jie"] td[data-field="在沪人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="在沪人数"] .layui-table-cell').append('<span>'+xue7+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao7').append('<span>'+jiao7+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong7 ').append('<span>'+parseInt(xue7+jiao7)+'</span>')
                //8其中在沪留校人数
                var xue8=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="留校人数"] .xue1Single').length;i++){
                    xue8+=parseInt($('div[lay-id="jie"] td[data-field="留校人数"] .xue1Single').eq(i).html())
                }
                var jiao8=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="留校人数"] .jiao1Single').length;i++){
                    jiao8+=parseInt($('div[lay-id="jie"] td[data-field="留校人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="留校人数"] .layui-table-cell').append('<span>'+xue8+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')
                /*//在沪留校中密切接触未过隔离期人数
                var xue8=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').length;i++){
                    xue8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').eq(i).html())
                }
                var jiao8=0
                for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').length;i++){
                    jiao8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="demo"] .layui-table-total tbody td[data-field="留校+密切接触患病"] .layui-table-cell').append('<span>'+xue8+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                $('div[lay-id="demo"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')*/
                //9当日从湖北（含途经）返沪人数
                var xue9=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="去过重点地区"] .xue1Single').length;i++){
                    xue9+=parseInt($('div[lay-id="jie"] td[data-field="去过重点地区"] .xue1Single').eq(i).html())
                }
                var jiao9=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="去过重点地区"] .jiao1Single').length;i++){
                    jiao9+=parseInt($('div[lay-id="jie"] td[data-field="去过重点地区"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="去过重点地区"] .layui-table-cell').append('<span>'+xue9+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao9').append('<span>'+jiao9+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong9 ').append('<span>'+parseInt(xue9+jiao9)+'</span>')
                //10当日从其他地区返沪人数
                var xue10=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日从其他地区返沪"] .xue1Single').length;i++){
                    xue10+=parseInt($('div[lay-id="jie"] td[data-field="当日从其他地区返沪"] .xue1Single').eq(i).html())
                }
                var jiao10=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日从其他地区返沪"] .jiao1Single').length;i++){
                    jiao10+=parseInt($('div[lay-id="jie"] td[data-field="当日从其他地区返沪"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日从其他地区返沪"] .layui-table-cell').append('<span>'+xue10+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao10').append('<span>'+jiao10+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong10 ').append('<span>'+parseInt(xue10+jiao10)+'</span>')
                //11目前居家隔离人数
                var xue11=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="目前在家隔离"] .xue1Single').length;i++){
                    xue11+=parseInt($('div[lay-id="jie"]  td[data-field="目前在家隔离"] .xue1Single').eq(i).html())
                }
                var jiao11=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="目前在家隔离"] .jiao1Single').length;i++){
                    jiao11+=parseInt($('div[lay-id="jie"]  td[data-field="目前在家隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="目前在家隔离"] .layui-table-cell').append('<span>'+xue11+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao11').append('<span>'+jiao11+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong11 ').append('<span>'+parseInt(xue11+jiao11)+'</span>')
                //12目前集中隔离人数
                var xue12=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="目前集中隔离"] .xue1Single').length;i++){
                    xue12+=parseInt($('div[lay-id="jie"] td[data-field="目前集中隔离"] .xue1Single').eq(i).html())
                }
                var jiao12=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="目前集中隔离"] .jiao1Single').length;i++){
                    jiao12+=parseInt($('div[lay-id="jie"] td[data-field="目前集中隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="目前集中隔离"] .layui-table-cell').append('<span>'+xue12+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao12').append('<span>'+jiao12+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong12 ').append('<span>'+parseInt(xue12+jiao12)+'</span>')
                //13当日解除隔离人数
                var xue13=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日接触隔离"] .xue1Single').length;i++){
                    xue13+=parseInt($('div[lay-id="jie"] td[data-field="当日接触隔离"] .xue1Single').eq(i).html())
                }
                var jiao13=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日接触隔离"] .jiao1Single').length;i++){
                    jiao13+=parseInt($('div[lay-id="jie"] td[data-field="当日接触隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日接触隔离"] .layui-table-cell').append('<span>'+xue13+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao13').append('<span>'+jiao13+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong13 ').append('<span>'+parseInt(xue13+jiao13)+'</span>')
                //14当日在湖北人数
                var xue14=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日在重点地区"] .xue1Single').length;i++){
                    xue14+=parseInt($('div[lay-id="jie"] td[data-field="当日在重点地区"] .xue1Single').eq(i).html())
                }
                var jiao14=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日在重点地区"] .jiao1Single').length;i++){
                    jiao14+=parseInt($('div[lay-id="jie"] td[data-field="当日在重点地区"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日在重点地区"] .layui-table-cell').append('<span>'+xue14+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao14').append('<span>'+jiao14+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong14 ').append('<span>'+parseInt(xue14+jiao14)+'</span>')
                //15其中在武汉人员数
                var xue15=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="其中在武汉人员数"] .xue1Single').length;i++){
                    xue15+=parseInt($('div[lay-id="jie"] td[data-field="其中在武汉人员数"] .xue1Single').eq(i).html())
                }
                var jiao15=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="其中在武汉人员数"] .jiao1Single').length;i++){
                    jiao15+=parseInt($('div[lay-id="jie"] td[data-field="其中在武汉人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="其中在武汉人员数"] .layui-table-cell').append('<span>'+xue15+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao15').append('<span>'+jiao15+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong15 ').append('<span>'+parseInt(xue15+jiao15)+'</span>')
                //16在其他地区人员（不含境外）
                var xue16=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日在其他区域人数"] .xue1Single').length;i++){
                    xue16+=parseInt($('div[lay-id="jie"] td[data-field="当日在其他区域人数"] .xue1Single').eq(i).html())
                }
                var jiao16=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日在其他区域人数"] .jiao1Single').length;i++){
                    jiao16+=parseInt($('div[lay-id="jie"] td[data-field="当日在其他区域人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日在其他区域人数"] .layui-table-cell').append('<span>'+xue16+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao16').append('<span>'+jiao16+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong16 ').append('<span>'+parseInt(xue16+jiao16)+'</span>')
                /* //17其他区域密切接触人数
                 var xue17=0
                 for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').length;i++){
                     xue17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').eq(i).html())
                 }
                 var jiao17=0
                 for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').length;i++){
                     jiao17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').eq(i).html())
                 }
                 $('div[lay-id="demo"] .layui-table-total tbody td[data-field="其他区域密切接触人"] .layui-table-cell').append('<span>'+xue17+'</span>')
                 $('div[lay-id="demo"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                 $('div[lay-id="demo"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')*/
                //17在境外人员
                var xue17=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="在境外人员"] .xue1Single').length;i++){
                    xue17+=parseInt($('div[lay-id="jie"] td[data-field="在境外人员"] .xue1Single').eq(i).html())
                }
                var jiao17=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="在境外人员"] .jiao1Single').length;i++){
                    jiao17+=parseInt($('div[lay-id="jie"] td[data-field="在境外人员"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="在境外人员"] .layui-table-cell').append('<span>'+xue17+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')
                //18其中港澳台籍人员数
                var xue18=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="其中港澳台籍人员数"] .xue1Single').length;i++){
                    xue18+=parseInt($('div[lay-id="jie"] td[data-field="其中港澳台籍人员数"] .xue1Single').eq(i).html())
                }
                var jiao18=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="其中港澳台籍人员数"] .jiao1Single').length;i++){
                    jiao18+=parseInt($('div[lay-id="jie"] td[data-field="其中港澳台籍人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="其中港澳台籍人员数"] .layui-table-cell').append('<span>'+xue18+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao18').append('<span>'+jiao18+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong18 ').append('<span>'+parseInt(xue18+jiao18)+'</span>')
                //19其中外籍人员数
                var xue19=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="其中外籍人员数"] .xue1Single').length;i++){
                    xue19+=parseInt($('div[lay-id="jie"] td[data-field="其中外籍人员数"] .xue1Single').eq(i).html())
                }
                var jiao19=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="其中外籍人员数"] .jiao1Single').length;i++){
                    jiao19+=parseInt($('div[lay-id="jie"] td[data-field="其中外籍人员数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="其中外籍人员数"] .layui-table-cell').append('<span>'+xue19+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao19').append('<span>'+jiao19+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong19 ').append('<span>'+parseInt(xue19+jiao19)+'</span>')
                //20返校途中人数（当日10点前未到上海）
                var xue20=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').length;i++){
                    xue20+=parseInt($('div[lay-id="jie"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').eq(i).html())
                }
                var jiao20=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').length;i++){
                    jiao20+=parseInt($('div[lay-id="jie"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="返校途中人数（当日10点前未到上海）"] .layui-table-cell').append('<span>'+xue20+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao20').append('<span>'+jiao20+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong20 ').append('<span>'+parseInt(xue20+jiao20)+'</span>')
                /*//当日发现确诊人数
                var xue1=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日发现确诊人数"] .xue1Single').length;i++){
                    xue1+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现确诊人数"] .xue1Single').eq(i).html())
                }
                var jiao1=0
                for(var i=0;i<$('div[lay-id="jie"] td[data-field="当日发现确诊人数"] .jiao1Single').length;i++){
                    jiao1+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现确诊人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日发现确诊人数"] .layui-table-cell').append('<span>'+xue1+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao1').append('<span>'+jiao1+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong1 ').append('<span>'+parseInt(xue1+jiao1)+'</span>')
                //当日发现疑似人数
                var xue2=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .xue1Single').length;i++){
                    xue2+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .xue1Single').eq(i).html())
                }
                var jiao2=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .jiao1Single').length;i++){
                    jiao2+=parseInt($('div[lay-id="jie"]  td[data-field="当日发现疑似人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日发现疑似人数"] .layui-table-cell').append('<span>'+xue2+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao2').append('<span>'+jiao2+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong2 ').append('<span>'+parseInt(xue2+jiao2)+'</span>')
                //当日健康异常人数
                var xue3=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .xue1Single').length;i++){
                    xue3+=parseInt($('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .xue1Single').eq(i).html())
                }
                var jiao3=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .jiao1Single').length;i++){
                    jiao3+=parseInt($('div[lay-id="jie"]  td[data-field="当日健康异常人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日健康异常人数"] .layui-table-cell').append('<span>'+xue3+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao3').append('<span>'+jiao3+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong3 ').append('<span>'+parseInt(xue3+jiao3)+'</span>')
                //当日密切接触人数
                var xue4=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日密切接触人数"] .xue1Single').length;i++){
                    xue4+=parseInt($('div[lay-id="jie"]  td[data-field="当日密切接触人数"] .xue1Single').eq(i).html())
                }
                var jiao4=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日密切接触人数"] .jiao1Single').length;i++){
                    jiao4+=parseInt($('div[lay-id="jie"]  td[data-field="当日密切接触人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日密切接触人数"] .layui-table-cell').append('<span>'+xue4+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao4').append('<span>'+jiao4+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong4 ').append('<span>'+parseInt(xue4+jiao4)+'</span>')
                //人员总数
                var xue5=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="人员总数"] .xue1Single').length;i++){
                    xue5+=parseInt($('div[lay-id="jie"]  td[data-field="人员总数"] .xue1Single').eq(i).html())
                }
                var jiao5=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="人员总数"] .jiao1Single').length;i++){
                    jiao5+=parseInt($('div[lay-id="jie"]  td[data-field="人员总数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="人员总数"] .layui-table-cell').append('<span>'+xue5+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao5').append('<span>'+jiao5+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong5 ').append('<span>'+parseInt(xue5+jiao5)+'</span>')
                //在沪人数
                var xue6=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="在沪人数"] .xue1Single').length;i++){
                    xue6+=parseInt($('div[lay-id="jie"]  td[data-field="在沪人数"] .xue1Single').eq(i).html())
                }
                var jiao6=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="在沪人数"] .jiao1Single').length;i++){
                    jiao6+=parseInt($('div[lay-id="jie"]  td[data-field="在沪人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="在沪人数"] .layui-table-cell').append('<span>'+xue6+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao6').append('<span>'+jiao6+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong6 ').append('<span>'+parseInt(xue6+jiao6)+'</span>')
                //其中在沪留校人数
                var xue7=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="留校人数"] .xue1Single').length;i++){
                    xue7+=parseInt($('div[lay-id="jie"]  td[data-field="留校人数"] .xue1Single').eq(i).html())
                }
                var jiao7=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="留校人数"] .jiao1Single').length;i++){
                    jiao7+=parseInt($('div[lay-id="jie"]  td[data-field="留校人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="留校人数"] .layui-table-cell').append('<span>'+xue7+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao7').append('<span>'+jiao7+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong7 ').append('<span>'+parseInt(xue7+jiao7)+'</span>')
                //在沪留校中密切接触未过隔离期人数
                var xue8=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="留校+密切接触患病"] .xue1Single').length;i++){
                    xue8+=parseInt($('div[lay-id="jie"]  td[data-field="留校+密切接触患病"] .xue1Single').eq(i).html())
                }
                var jiao8=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="留校+密切接触患病"] .jiao1Single').length;i++){
                    jiao8+=parseInt($('div[lay-id="jie"]  td[data-field="留校+密切接触患病"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="留校+密切接触患病"] .layui-table-cell').append('<span>'+xue8+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')
                //当日从湖北（含途经）返沪人数
                var xue9=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="去过重点地区"] .xue1Single').length;i++){
                    xue9+=parseInt($('div[lay-id="jie"]  td[data-field="去过重点地区"] .xue1Single').eq(i).html())
                }
                var jiao9=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="去过重点地区"] .jiao1Single').length;i++){
                    jiao9+=parseInt($('div[lay-id="jie"]  td[data-field="去过重点地区"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="去过重点地区"] .layui-table-cell').append('<span>'+xue9+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao9').append('<span>'+jiao9+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong9 ').append('<span>'+parseInt(xue9+jiao9)+'</span>')
                //当日从其他地区返沪人数
                var xue10=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日从其他地区返沪"] .xue1Single').length;i++){
                    xue10+=parseInt($('div[lay-id="jie"]  td[data-field="当日从其他地区返沪"] .xue1Single').eq(i).html())
                }
                var jiao10=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日从其他地区返沪"] .jiao1Single').length;i++){
                    jiao10+=parseInt($('div[lay-id="jie"]  td[data-field="当日从其他地区返沪"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日从其他地区返沪"] .layui-table-cell').append('<span>'+xue10+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao10').append('<span>'+jiao10+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong10 ').append('<span>'+parseInt(xue10+jiao10)+'</span>')
                //目前居家隔离人数
                var xue11=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="目前在家隔离"] .xue1Single').length;i++){
                    xue11+=parseInt($('div[lay-id="jie"]  td[data-field="目前在家隔离"] .xue1Single').eq(i).html())
                }
                var jiao11=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="目前在家隔离"] .jiao1Single').length;i++){
                    jiao11+=parseInt($('div[lay-id="jie"]  td[data-field="目前在家隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="目前在家隔离"] .layui-table-cell').append('<span>'+xue11+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao11').append('<span>'+jiao11+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong11 ').append('<span>'+parseInt(xue11+jiao11)+'</span>')
                //目前集中隔离人数
                var xue12=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="目前集中隔离"] .xue1Single').length;i++){
                    xue12+=parseInt($('div[lay-id="jie"]  td[data-field="目前集中隔离"] .xue1Single').eq(i).html())
                }
                var jiao12=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="目前集中隔离"] .jiao1Single').length;i++){
                    jiao12+=parseInt($('div[lay-id="jie"]  td[data-field="目前集中隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="目前集中隔离"] .layui-table-cell').append('<span>'+xue12+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao12').append('<span>'+jiao12+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong12 ').append('<span>'+parseInt(xue12+jiao12)+'</span>')
                //当日解除隔离人数
                var xue13=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日接触隔离"] .xue1Single').length;i++){
                    xue13+=parseInt($('div[lay-id="jie"]  td[data-field="当日接触隔离"] .xue1Single').eq(i).html())
                }
                var jiao13=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日接触隔离"] .jiao1Single').length;i++){
                    jiao13+=parseInt($('div[lay-id="jie"]  td[data-field="当日接触隔离"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日接触隔离"] .layui-table-cell').append('<span>'+xue13+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao13').append('<span>'+jiao13+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong13 ').append('<span>'+parseInt(xue13+jiao13)+'</span>')
                //当日在湖北人数
                var xue14=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日在重点地区"] .xue1Single').length;i++){
                    xue14+=parseInt($('div[lay-id="jie"]  td[data-field="当日在重点地区"] .xue1Single').eq(i).html())
                }
                var jiao14=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日在重点地区"] .jiao1Single').length;i++){
                    jiao14+=parseInt($('div[lay-id="jie"]  td[data-field="当日在重点地区"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日在重点地区"] .layui-table-cell').append('<span>'+xue14+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao14').append('<span>'+jiao14+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong14 ').append('<span>'+parseInt(xue14+jiao14)+'</span>')
                //重点地区密切接触未过隔离期人数
                var xue15=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="重点地区密切接触未过隔离期的人"] .xue1Single').length;i++){
                    xue15+=parseInt($('div[lay-id="jie"]  td[data-field="重点地区密切接触未过隔离期的人"] .xue1Single').eq(i).html())
                }
                var jiao15=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="重点地区密切接触未过隔离期的人"] .jiao1Single').length;i++){
                    jiao15+=parseInt($('div[lay-id="jie"]  td[data-field="重点地区密切接触未过隔离期的人"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="重点地区密切接触未过隔离期的人"] .layui-table-cell').append('<span>'+xue15+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao15').append('<span>'+jiao15+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong15 ').append('<span>'+parseInt(xue15+jiao15)+'</span>')
                //当日在其他区域人数
                var xue16=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日在其他区域人数"] .xue1Single').length;i++){
                    xue16+=parseInt($('div[lay-id="jie"]  td[data-field="当日在其他区域人数"] .xue1Single').eq(i).html())
                }
                var jiao16=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="当日在其他区域人数"] .jiao1Single').length;i++){
                    jiao16+=parseInt($('div[lay-id="jie"]  td[data-field="当日在其他区域人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="当日在其他区域人数"] .layui-table-cell').append('<span>'+xue16+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao16').append('<span>'+jiao16+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong16 ').append('<span>'+parseInt(xue16+jiao16)+'</span>')
                //其他区域密切接触人数
                var xue17=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="其他区域密切接触人"] .xue1Single').length;i++){
                    xue17+=parseInt($('div[lay-id="jie"]  td[data-field="其他区域密切接触人"] .xue1Single').eq(i).html())
                }
                var jiao17=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="其他区域密切接触人"] .jiao1Single').length;i++){
                    jiao17+=parseInt($('div[lay-id="jie"]  td[data-field="其他区域密切接触人"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="其他区域密切接触人"] .layui-table-cell').append('<span>'+xue17+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')
                //其他区域曾途经湖北人数
                var xue18=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="其他区域曾途经湖北人数"] .xue1Single').length;i++){
                    xue18+=parseInt($('div[lay-id="jie"]  td[data-field="其他区域曾途经湖北人数"] .xue1Single').eq(i).html())
                }
                var jiao18=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="其他区域曾途经湖北人数"] .jiao1Single').length;i++){
                    jiao18+=parseInt($('div[lay-id="jie"]  td[data-field="其他区域曾途经湖北人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="其他区域曾途经湖北人数"] .layui-table-cell').append('<span>'+xue18+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao18').append('<span>'+jiao18+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong18 ').append('<span>'+parseInt(xue18+jiao18)+'</span>')
                //返校途中人数（当日10点前未到上海）
                var xue19=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').length;i++){
                    xue19+=parseInt($('div[lay-id="jie"]  td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').eq(i).html())
                }
                var jiao19=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').length;i++){
                    jiao19+=parseInt($('div[lay-id="jie"]  td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="返校途中人数（当日10点前未到上海）"] .layui-table-cell').append('<span>'+xue19+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao19').append('<span>'+jiao19+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong19 ').append('<span>'+parseInt(xue19+jiao19)+'</span>')
                //返校途中密切接触人数
                var xue20=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="返校途中密切接触人数"] .xue1Single').length;i++){
                    xue20+=parseInt($('div[lay-id="jie"]  td[data-field="返校途中密切接触人数"] .xue1Single').eq(i).html())
                }
                var jiao20=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="返校途中密切接触人数"] .jiao1Single').length;i++){
                    jiao20+=parseInt($('div[lay-id="jie"]  td[data-field="返校途中密切接触人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="返校途中密切接触人数"] .layui-table-cell').append('<span>'+xue20+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao20').append('<span>'+jiao20+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong20 ').append('<span>'+parseInt(xue20+jiao20)+'</span>')
                //返校途中途经湖北人数
                var xue21=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="返校途中途经湖北人数"] .xue1Single').length;i++){
                    xue21+=parseInt($('div[lay-id="jie"]  td[data-field="返校途中途经湖北人数"] .xue1Single').eq(i).html())
                }
                var jiao21=0
                for(var i=0;i<$('div[lay-id="jie"]  td[data-field="返校途中途经湖北人数"] .jiao1Single').length;i++){
                    jiao21+=parseInt($('div[lay-id="jie"]  td[data-field="返校途中途经湖北人数"] .jiao1Single').eq(i).html())
                }
                $('div[lay-id="jie"] .layui-table-total tbody td[data-field="返校途中途经湖北人数"] .layui-table-cell').append('<span>'+xue21+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .jiao21').append('<span>'+jiao21+'</span>')
                $('div[lay-id="jie"] .layui-table-total tbody .zong21 ').append('<span>'+parseInt(xue21+jiao21)+'</span>')*/

                //固定合计行
                $('div[lay-id="jie"]').css('position','relative')
                var heji='<div class="heji"><table cellspacing="0" cellpadding="0" border="0" class="layui-table"><tbody>' +
                    '<tr><td data-field="schoolManageName" data-key="1-0-0" class="" rowspan="3"><div class="layui-table-cell laytable-cell-1-0-0">合计</div></td>' +
                    '<td data-field="identityName" data-key="1-0-2" class=""><div class="layui-table-cell laytable-cell-1-0-2"><span>学生人数</span></div></td>'+
                    '</tr>'+
                    '<tr><td class="jiao"><span>教工人数</span></td></tr>'+
                    '<tr><td class="zong"><span>师生总数</span></td></tr>'+
                    '</tbody></table></div>'
                $('div[lay-id="jie"] .layui-table-total').append(heji)
                // $('div[lay-id="jie"] .heji ').css({'position':'absolute','top':'95%'})
                var gao=$('div[lay-id="jie"]').height()-30
                $('div[lay-id="jie"] .heji ').css({'position':'absolute','top':gao})
            }
        });
        //监听行单击事件
        table.on('row(jie)', function(obj){
            var liveStreet
            if(obj.data.LIVE_STREET==undefined){
                liveStreet=''
            }else{
                liveStreet=obj.data.LIVE_STREET
            }
            $.ajax({
                url:'/HealthyInfo/statisticsInfo',
                type:'post',
                dataType:'json',
                data:{
                    liveStreet:liveStreet,
                    groupBy:'dep.DEPT_ID',
                    createTime:$('#jieTime').val()
                },
                success:function (res) {
                    layer.open({
                        type: 1,
                        closeBtn: 1,
                        title: '详情',
                        area: ['95%', '90%'], //宽高
                        content: '<table id="jie1" lay-filter="jie1"></table>'
                        ,success:function () {
                            table.render({
                                elem: '#jie1'
                                ,data: res.object
                                ,cellMinWidth:150
                                ,height:$(window).height()-190
                                ,totalRow: true
                                ,limit: 100000//显示的数量
                                ,cols: [[ //表头
                                    {field: 'SCHOOL_NAME',fixed: 'left', title: '学校简称',totalRowText: '合计',rowspan: 2,templet: function(d){
                                            if(d.SCHOOL_NAME!=undefined){
                                                return  '<span class="SCHOOL_NAME1">'+d.SCHOOL_NAME+'</span>'
                                            }else{
                                                return ''
                                            }
                                        }}
                                    /*,{field: '机构总数', title: '机构总数',rowspan: 2,templet: function(d){
                                            return  '<span class="xueNum1">'+d.机构总数+'</span>'
                                        } }*/
                                    ,{field: 'identityName',fixed: 'left', title: '人员分类', rowspan: 2,templet:function (d) {
                                            if(d.identityName!=undefined){
                                                return  d.identityName
                                            }else{
                                                return ''
                                            }
                                        }}
                                    ,{field: '人员总数', title: '人员总数', rowspan: 2,templet: function(d){
                                            if(d.人员总数!=undefined && d.人员总数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                            }else if(d.人员总数!=undefined && d.人员总数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                            }else if(d.人员总数!=undefined && d.人员总数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                            }else if(d.人员总数!=undefined && d.人员总数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="人员总数">'+d.人员总数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '当日发现确诊人数', title: '当日发现确诊人数',rowspan: 2,templet: function(d){
                                            // console.log(d)
                                            if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数==0 && d.identityName=='学生' ){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                            }else if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                            }else if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                            }else if(d.当日发现确诊人数!=undefined && d.当日发现确诊人数!=0  && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现确诊人数">'+d.当日发现确诊人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '当日发现疑似人数', title: '当日发现疑似人数',rowspan: 2,templet: function(d){
                                            if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                            }else if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                            }else if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                            }else if(d.当日发现疑似人数!=undefined && d.当日发现疑似人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日发现疑似人数">'+d.当日发现疑似人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '当日健康异常人数', title: '当日健康异常人数',rowspan: 2,templet: function(d){
                                            if(d.当日健康异常人数!=undefined && d.当日健康异常人数==0  && d.identityName=='学生' ){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                            }else if(d.当日健康异常人数!=undefined && d.当日健康异常人数==0  && d.identityName=='教职员工' ){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                            }else if(d.当日健康异常人数!=undefined && d.当日健康异常人数!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                            }else if(d.当日健康异常人数!=undefined && d.当日健康异常人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日健康异常人数">'+d.当日健康异常人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '当日密切接触人数', title: '当日密切接触人数',rowspan: 2 ,templet: function(d){
                                            if(d.当日密切接触人数!=undefined && d.当日密切接触人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                            }else if(d.当日密切接触人数!=undefined && d.当日密切接触人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                            }else if(d.当日密切接触人数!=undefined && d.当日密切接触人数!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                            }else if(d.当日密切接触人数!=undefined && d.当日密切接触人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日密切接触人数">'+d.当日密切接触人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                        ,{field: '当日隔离人员数', title: '当日隔离人员数',rowspan: 2 ,templet: function(d){
                                            if(d.当日隔离人员数!=undefined && d.当日隔离人员数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                            }else if(d.当日隔离人员数!=undefined && d.当日隔离人员数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                            }else if(d.当日隔离人员数!=undefined && d.当日隔离人员数!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                            }else if(d.当日隔离人员数!=undefined && d.当日隔离人员数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日隔离人员数">'+d.当日隔离人员数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '', title: '在沪人员',colspan:7}
                                    ,{field: '', title: '在湖北',colspan:2}
                                    // ,{field: '', title: '在重点关注地区',colspan:3}
                                    ,{field: '当日在其他区域人数', title: '在其他地区人员（不含境外）',rowspan: 2 ,templet: function(d){
                                            if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '', title: '在境外人员（港澳台地区、国外）',colspan:3}
                                    ,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中',minWidth:300,templet: function(d){
                                            if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    /*   ,{field: '失联人数,手工填写', title: '失联人数',rowspan:2,templet: function(d){
                                               if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']==0){
                                           return '<a href="javascript:;" class="jdangri" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                               }else if(d['失联人数,手工填写']!=undefined && d['失联人数,手工填写']!=0){
                                                   return '<a href="javascript:;" style="color: red" class="jdangri" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="失联人数">'+d['失联人数,手工填写']+'</a>'
                                               }else {
                                                   return ''
                                               }
                                           }}*/
                                ],[
                                    {field: '在沪人数', title: '在沪人数',templet: function(d){
                                            if(d.在沪人数!=undefined && d.在沪人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                            }else if(d.在沪人数!=undefined && d.在沪人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                            }else if(d.在沪人数!=undefined && d.在沪人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                            }else if(d.在沪人数!=undefined && d.在沪人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪人数">'+d.在沪人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '留校人数', title: '其中在沪留校人数', templet: function(d){
                                            if(d.留校人数!=undefined && d.留校人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                            }else if(d.留校人数!=undefined && d.留校人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                            }else if(d.留校人数!=undefined && d.留校人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                            }else if(d.留校人数!=undefined && d.留校人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在沪留校人数">'+d.留校人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    /*,{field: '留校+密切接触患病', title: '在沪留校中密切接触未过隔离期人数', minWidth:270,templet: function(d){
                                            if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                            }else if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                            }else if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                            }else if(d['留校+密切接触患病']!=undefined && d['留校+密切接触患病']!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在沪留校中密切接触未过隔离期人数">'+d['留校+密切接触患病']+'</a>'
                                            }else {
                                                return '0'
                                            }
                                        }}*/
                                    ,{field: '去过重点地区', title: '当日从湖北（含途经）返沪人数',minWidth:250,templet: function(d){
                                            if(d.去过重点地区!=undefined && d.去过重点地区==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                            }else if(d.去过重点地区!=undefined && d.去过重点地区==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                            }else if(d.去过重点地区!=undefined && d.去过重点地区!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                            }else if(d.去过重点地区!=undefined && d.去过重点地区!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从湖北（含途经）返沪人数">'+d.去过重点地区+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    /*,{field: '去过重点关注地区', title: '当日从重点关注地区返沪人数',minWidth:250,templet: function(d){
                                            return '<a href="javascript:;" style="color: red" class="jdangri" liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从重点关注地区返沪人数">'+d.去过重点关注地区+'</a>'
                                        }}*/
                                    ,{field: '当日从其他地区返沪', title: '当日从其他地区返沪人数',minWidth:250,templet: function(d){
                                            if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                            }else if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                            }else if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                            }else if(d.当日从其他地区返沪!=undefined && d.当日从其他地区返沪!=0  && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日从其他地区返沪人数">'+d.当日从其他地区返沪+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '目前在家隔离', title: '目前居家隔离人数', templet: function(d){
                                            if(d.目前在家隔离!=undefined && d.目前在家隔离==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                            }else if(d.目前在家隔离!=undefined && d.目前在家隔离==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                            }else if(d.目前在家隔离!=undefined && d.目前在家隔离!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                            }else if(d.目前在家隔离!=undefined && d.目前在家隔离!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single"  identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前居家隔离人数">'+d.目前在家隔离+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '目前集中隔离', title: '目前集中隔离人数',templet: function(d){
                                            if(d.目前集中隔离!=undefined && d.目前集中隔离==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                            }else if(d.目前集中隔离!=undefined && d.目前集中隔离==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                            }else if(d.目前集中隔离!=undefined && d.目前集中隔离!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                            }else if(d.目前集中隔离!=undefined && d.目前集中隔离!=0  && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="目前集中隔离人数">'+d.目前集中隔离+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        } }
                                    ,{field: '当日接触隔离', title: '当日解除隔离人数',templet: function(d){
                                            if(d.当日接触隔离!=undefined && d.当日接触隔离==0  && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                            }else if(d.当日接触隔离!=undefined && d.当日接触隔离==0  && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                            }else if(d.当日接触隔离!=undefined && d.当日接触隔离!=0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                            }else if(d.当日接触隔离!=undefined && d.当日接触隔离!=0  && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日解除隔离人数">'+d.当日接触隔离+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '当日在重点地区', title: '当日在湖北人数',templet: function(d){
                                            if(d.当日在重点地区!=undefined && d.当日在重点地区==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                            }else if(d.当日在重点地区!=undefined && d.当日在重点地区==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                            }else if(d.当日在重点地区!=undefined && d.当日在重点地区!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                            }else if(d.当日在重点地区!=undefined && d.当日在重点地区!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在湖北人数">'+d.当日在重点地区+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '其中在武汉人员数', title: '其中在武汉人员数',templet: function(d){
                                            if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else if(d.其中在武汉人员数!=undefined && d.其中在武汉人员数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中在武汉人员数">'+d.其中在武汉人员数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    /*,{field: '重点地区密切接触未过隔离期的人', title: '重点地区密切接触未过隔离期人数',minWidth:250,templet: function(d){
                                            if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                            }else if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                            }else if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                            }else if(d.重点地区密切接触未过隔离期的人!=undefined && d.重点地区密切接触未过隔离期的人!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="重点地区密切接触未过隔离期人数">'+d.重点地区密切接触未过隔离期的人+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}*/
                                    /*,{field: '2/23日前不返沪人数', title: '2/23日前不返沪人数',minWidth:200,templet: function(d){
                                            if(d['2/23日前不返沪人数']!=undefined && d['2/23日前不返沪人数']==0){
                                                return '<a href="javascript:;"  class="jdangri" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="2/23日前不返沪人数">'+d['2/23日前不返沪人数']+'</a>'
                                            }else if(d['2/23日前不返沪人数']!=undefined && d['2/23日前不返沪人数']!=0){
                                                return '<a href="javascript:;" style="color: red" class="jdangri" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="2/23日前不返沪人数">'+d['2/23日前不返沪人数']+'</a>'
                                            }else{
                                                return ''
                                            }
                                        }}*/
                                    /* ,{field: '当日在重点关注地区人数', title: '当日在重点关注地区人数',minWidth:200,templet: function(d){
                                             return '<a href="javascript:;" style="color: red" class="jdangri" liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在重点关注地区人数">'+d.当日在重点关注地区人数+'</a>'
                                         }}
                                     ,{field: '重点关注地区密切接触人数', title: '重点关注地区密切接触人数',minWidth:200,templet: function(d){
                                             return '<a href="javascript:;" style="color: red" class="jdangri" liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="重点关注地区密切接触人数">'+d.重点关注地区密切接触人数+'</a>'
                                         }}
                                     ,{field: '重点关注地区途经湖北', title: '重点关注地区途经湖北',minWidth:200,templet: function(d){
                                             return '<a href="javascript:;" style="color: red" class="jdangri" liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="重点关注地区途经湖北">'+d.重点关注地区途经湖北+'</a>'
                                         }}*/
                                   /* ,{field: '当日在其他区域人数', title: '当日在其他区域人数',minWidth:200,templet: function(d){
                                            if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else if(d.当日在其他区域人数!=undefined && d.当日在其他区域人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="当日在其他区域人数">'+d.当日在其他区域人数+'</a>'
                                            }else {
                                                return '0'
                                            }
                                        }}
                                    ,{field: '其他区域密切接触人', title: '其他区域密切接触人数',minWidth:200,templet: function(d){
                                            if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                            }else if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                            }else if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                            }else if(d.其他区域密切接触人!=undefined && d.其他区域密切接触人!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域密切接触人数">'+d.其他区域密切接触人+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '其他区域曾途经湖北人数', title: '其他区域曾途经湖北人数',minWidth:200,templet: function(d){
                                            if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                            }else if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                            }else if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                            }else if(d.其他区域曾途经湖北人数!=undefined && d.其他区域曾途经湖北人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其他区域曾途经湖北人数">'+d.其他区域曾途经湖北人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}*/
                                   /* ,{field: '返校途中人数（当日10点前未到上海）', title: '返校途中人数（当日10点前未到上海）',minWidth:300,templet: function(d){
                                            if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else if(d['返校途中人数（当日10点前未到上海）']!=undefined && d['返校途中人数（当日10点前未到上海）']!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中人数（当日10点前未到上海）">'+d['返校途中人数（当日10点前未到上海）']+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '返校途中密切接触人数', title: '返校途中密切接触人数',minWidth:200,templet: function(d){
                                            if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"  class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                            }else if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"  class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                            }else if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                            }else if(d.返校途中密切接触人数!=undefined && d.返校途中密切接触人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中密切接触人数">'+d.返校途中密切接触人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '返校途中途经湖北人数', title: '返校途中途经湖北人数',minWidth:200,templet: function(d){
                                            if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数==0  && d.identityName=='学生'){
                                                return '<a href="javascript:;" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                            }else if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数==0  && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                            }else if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                            }else if(d.返校途中途经湖北人数!=undefined && d.返校途中途经湖北人数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="返校途中途经湖北人数">'+d.返校途中途经湖北人数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}*/
                                    ,{field: '在境外人员', title: '核查人数',templet: function(d){
                                            if(d.在境外人员!=undefined && d.在境外人员==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                            }else if(d.在境外人员!=undefined && d.在境外人员==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                            }else if(d.在境外人员!=undefined && d.在境外人员!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                            }else if(d.在境外人员!=undefined && d.在境外人员!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="在境外人员">'+d.在境外人员+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '其中港澳台籍人员数', title: '其中港澳台籍人员数',templet: function(d){
                                            if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                            }else if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                            }else if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                            }else if(d.其中港澳台籍人员数!=undefined && d.其中港澳台籍人员数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中港澳台籍人员数">'+d.其中港澳台籍人员数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                    ,{field: '其中外籍人员数', title: '其中外籍人员数',templet: function(d){
                                            if(d.其中外籍人员数!=undefined && d.其中外籍人员数==0 && d.identityName=='学生'){
                                                return '<a href="javascript:;"class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                            }else if(d.其中外籍人员数!=undefined && d.其中外籍人员数==0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;"class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                            }else if(d.其中外籍人员数!=undefined && d.其中外籍人员数!=0 && d.identityName=='学生'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri xue1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                            }else if(d.其中外籍人员数!=undefined && d.其中外籍人员数!=0 && d.identityName=='教职员工'){
                                                return '<a href="javascript:;" style="color: red" class="jdangri jiao1Single" identityType="'+d.IDENTITY_TYPE+'"  liveStreet="'+d.LIVE_STREET+'" deptId="'+d.DEPT_ID+'" title="其中外籍人员数">'+d.其中外籍人员数+'</a>'
                                            }else{
                                                return '0'
                                            }
                                        }}
                                ]
                                ]
                                ,parseData: function(res){ //res 即为原始返回的数据
                                    return {
                                        "code": 0, //解析接口状态
                                        "data": res.object //解析数据列表
                                    };
                                }
                                ,done:function () {
                                    for(var i=0;i<$('.layui-table-fixed .SCHOOL_NAME1').length;i++){
                                        if($('.layui-table-fixed .SCHOOL_NAME1').eq(i).html()==$('.layui-table-fixed .SCHOOL_NAME1').eq(i+1).html()){
                                            $('.layui-table-fixed .SCHOOL_NAME1').eq(i).parent().parent().attr('rowspan','2')
                                            $('.layui-table-fixed .SCHOOL_NAME1').eq(i+1).parent().parent().remove()
                                        }
                                    }
                                    /*for(var i=0;i<$('.xueNum1').length;i++){
                                        if($('.xueNum1').eq(i).parent().parent().prev().attr('rowspan')=='2'){
                                            var xue=$('.xueNum1').eq(i).html()
                                            var jiao=$('.xueNum1').eq(i+1).html()
                                            $('.xueNum1').eq(i).html(parseInt(xue)+parseInt(jiao))
                                            $('.xueNum1').eq(i).parent().parent().attr('rowspan','2')
                                            $('.xueNum1').eq(i+1).parent().parent().remove()
                                        }
                                    }*/
                                    $('div[lay-id="jie1"] .layui-table-total tbody ').append('<tr><td class="jiao"></td><td class="jiao1"></td><td class="jiao2"></td><td class="jiao3"></td><td class="jiao4"></td><td class="jiao5"></td>' +
                                        '<td class="jiao6"></td><td class="jiao7"></td><td class="jiao8"></td><td class="jiao9"></td><td class="jiao10"></td><td class="jiao11"></td><td class="jiao12"></td><td class="jiao13"></td><td class="jiao14"></td><td class="jiao15"></td><td class="jiao16"></td><td class="jiao17"></td>'+
                                        '<td class="jiao18"></td><td class="jiao19"></td><td class="jiao20"></td><td class="jiao21"></td><td class="jiao22"></td>'+ '</tr>'+
                                        '<tr><td class="zong"></td><td class="zong1"></td><td class="zong2"></td><td class="zong3"></td><td class="zong4"></td><td class="zong5"></td>' +
                                        '<td class="zong6"></td><td class="zong7"></td><td class="zong8"></td><td class="zong9"></td><td class="zong10"></td><td class="zong11"></td><td class="zong12"></td><td class="zong13"></td><td class="zong14"></td><td class="zong15"></td><td class="zong16"></td><td class="zong17"></td>'+
                                        '<td class="zong18"></td><td class="zong19"></td><td class="zong20"></td><td class="zong21"></td><td class="zong22"></td>'+ '</tr>'
                                    )
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="SCHOOL_NAME"]').attr('rowspan','3')
                                    //对象类型
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="identityName"] .layui-table-cell').append('<span>学生人数</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao').append('<span>教工人数</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong ').append('<span>师生总数</span>')

                                    //1人员总数
                                    var xue1=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="人员总数"] .xue1Single').length;i++){
                                        xue1+=parseInt($('div[lay-id="jie1"] td[data-field="人员总数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao1=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="人员总数"] .jiao1Single').length;i++){
                                        jiao1+=parseInt($('div[lay-id="jie1"] td[data-field="人员总数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="人员总数"] .layui-table-cell').append('<span>'+xue1+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao1').append('<span>'+jiao1+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong1 ').append('<span>'+parseInt(xue1+jiao1)+'</span>')
                                    //2当日发现确诊人数
                                    var xue2=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .xue1Single').length;i++){
                                        xue2+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao2=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .jiao1Single').length;i++){
                                        jiao2+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日发现确诊人数"] .layui-table-cell').append('<span>'+xue2+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao2').append('<span>'+jiao2+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong2 ').append('<span>'+parseInt(xue2+jiao2)+'</span>')
                                    //3当日发现疑似人数
                                    var xue3=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .xue1Single').length;i++){
                                        xue3+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao3=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .jiao1Single').length;i++){
                                        jiao3+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日发现疑似人数"] .layui-table-cell').append('<span>'+xue3+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao3').append('<span>'+jiao3+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong3 ').append('<span>'+parseInt(xue3+jiao3)+'</span>')
                                    //4当日健康异常人数
                                    var xue4=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .xue1Single').length;i++){
                                        xue4+=parseInt($('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao4=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .jiao1Single').length;i++){
                                        jiao4+=parseInt($('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日健康异常人数"] .layui-table-cell').append('<span>'+xue4+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao4').append('<span>'+jiao4+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong4 ').append('<span>'+parseInt(xue4+jiao4)+'</span>')
                                    //5当日密切接触人数
                                    var xue5=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日密切接触人数"] .xue1Single').length;i++){
                                        xue5+=parseInt($('div[lay-id="jie1"]  td[data-field="当日密切接触人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao5=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日密切接触人数"] .jiao1Single').length;i++){
                                        jiao5+=parseInt($('div[lay-id="jie1"] td[data-field="当日密切接触人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日密切接触人数"] .layui-table-cell').append('<span>'+xue5+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao5').append('<span>'+jiao5+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong5 ').append('<span>'+parseInt(xue5+jiao5)+'</span>')
                                    //6当日隔离人员数
                                    var xue6=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日隔离人员数"] .xue1Single').length;i++){
                                        xue6+=parseInt($('div[lay-id="jie1"]  td[data-field="当日隔离人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao6=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日隔离人员数"] .jiao1Single').length;i++){
                                        jiao6+=parseInt($('div[lay-id="jie1"] td[data-field="当日隔离人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日隔离人员数"] .layui-table-cell').append('<span>'+xue6+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao6').append('<span>'+jiao6+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong6 ').append('<span>'+parseInt(xue6+jiao6)+'</span>')

                                    //7在沪人数
                                    var xue7=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="在沪人数"] .xue1Single').length;i++){
                                        xue7+=parseInt($('div[lay-id="jie1"] td[data-field="在沪人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao7=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="在沪人数"] .jiao1Single').length;i++){
                                        jiao7+=parseInt($('div[lay-id="jie1"] td[data-field="在沪人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="在沪人数"] .layui-table-cell').append('<span>'+xue7+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao7').append('<span>'+jiao7+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong7 ').append('<span>'+parseInt(xue7+jiao7)+'</span>')
                                    //8其中在沪留校人数
                                    var xue8=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="留校人数"] .xue1Single').length;i++){
                                        xue8+=parseInt($('div[lay-id="jie1"] td[data-field="留校人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao8=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="留校人数"] .jiao1Single').length;i++){
                                        jiao8+=parseInt($('div[lay-id="jie1"] td[data-field="留校人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="留校人数"] .layui-table-cell').append('<span>'+xue8+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')
                                    /*//在沪留校中密切接触未过隔离期人数
                                    var xue8=0
                                    for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').length;i++){
                                        xue8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .xue1Single').eq(i).html())
                                    }
                                    var jiao8=0
                                    for(var i=0;i<$('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').length;i++){
                                        jiao8+=parseInt($('div[lay-id="demo"] td[data-field="留校+密切接触患病"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="demo"] .layui-table-total tbody td[data-field="留校+密切接触患病"] .layui-table-cell').append('<span>'+xue8+'</span>')
                                    $('div[lay-id="demo"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                                    $('div[lay-id="demo"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')*/
                                    //9当日从湖北（含途经）返沪人数
                                    var xue9=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="去过重点地区"] .xue1Single').length;i++){
                                        xue9+=parseInt($('div[lay-id="jie1"] td[data-field="去过重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao9=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="去过重点地区"] .jiao1Single').length;i++){
                                        jiao9+=parseInt($('div[lay-id="jie1"] td[data-field="去过重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="去过重点地区"] .layui-table-cell').append('<span>'+xue9+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao9').append('<span>'+jiao9+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong9 ').append('<span>'+parseInt(xue9+jiao9)+'</span>')
                                    //10当日从其他地区返沪人数
                                    var xue10=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日从其他地区返沪"] .xue1Single').length;i++){
                                        xue10+=parseInt($('div[lay-id="jie1"] td[data-field="当日从其他地区返沪"] .xue1Single').eq(i).html())
                                    }
                                    var jiao10=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日从其他地区返沪"] .jiao1Single').length;i++){
                                        jiao10+=parseInt($('div[lay-id="jie1"] td[data-field="当日从其他地区返沪"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日从其他地区返沪"] .layui-table-cell').append('<span>'+xue10+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao10').append('<span>'+jiao10+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong10 ').append('<span>'+parseInt(xue10+jiao10)+'</span>')
                                    //11目前居家隔离人数
                                    var xue11=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .xue1Single').length;i++){
                                        xue11+=parseInt($('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao11=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .jiao1Single').length;i++){
                                        jiao11+=parseInt($('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="目前在家隔离"] .layui-table-cell').append('<span>'+xue11+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao11').append('<span>'+jiao11+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong11 ').append('<span>'+parseInt(xue11+jiao11)+'</span>')
                                    //12目前集中隔离人数
                                    var xue12=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="目前集中隔离"] .xue1Single').length;i++){
                                        xue12+=parseInt($('div[lay-id="jie1"] td[data-field="目前集中隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao12=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="目前集中隔离"] .jiao1Single').length;i++){
                                        jiao12+=parseInt($('div[lay-id="jie1"] td[data-field="目前集中隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="目前集中隔离"] .layui-table-cell').append('<span>'+xue12+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao12').append('<span>'+jiao12+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong12 ').append('<span>'+parseInt(xue12+jiao12)+'</span>')
                                    //13当日解除隔离人数
                                    var xue13=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日接触隔离"] .xue1Single').length;i++){
                                        xue13+=parseInt($('div[lay-id="jie1"] td[data-field="当日接触隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao13=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日接触隔离"] .jiao1Single').length;i++){
                                        jiao13+=parseInt($('div[lay-id="jie1"] td[data-field="当日接触隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日接触隔离"] .layui-table-cell').append('<span>'+xue13+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao13').append('<span>'+jiao13+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong13 ').append('<span>'+parseInt(xue13+jiao13)+'</span>')
                                    //14当日在湖北人数
                                    var xue14=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在重点地区"] .xue1Single').length;i++){
                                        xue14+=parseInt($('div[lay-id="jie1"] td[data-field="当日在重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao14=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在重点地区"] .jiao1Single').length;i++){
                                        jiao14+=parseInt($('div[lay-id="jie1"] td[data-field="当日在重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日在重点地区"] .layui-table-cell').append('<span>'+xue14+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao14').append('<span>'+jiao14+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong14 ').append('<span>'+parseInt(xue14+jiao14)+'</span>')
                                    //15其中在武汉人员数
                                    var xue15=0
                                    for(var i=0;i<$('div[lay-id="jie"] td[data-field="其中在武汉人员数"] .xue1Single').length;i++){
                                        xue15+=parseInt($('div[lay-id="jie"] td[data-field="其中在武汉人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao15=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其中在武汉人员数"] .jiao1Single').length;i++){
                                        jiao15+=parseInt($('div[lay-id="jie1"] td[data-field="其中在武汉人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="其中在武汉人员数"] .layui-table-cell').append('<span>'+xue15+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao15').append('<span>'+jiao15+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong15 ').append('<span>'+parseInt(xue15+jiao15)+'</span>')
                                    //16在其他地区人员（不含境外）
                                    var xue16=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .xue1Single').length;i++){
                                        xue16+=parseInt($('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao16=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .jiao1Single').length;i++){
                                        jiao16+=parseInt($('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日在其他区域人数"] .layui-table-cell').append('<span>'+xue16+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao16').append('<span>'+jiao16+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong16 ').append('<span>'+parseInt(xue16+jiao16)+'</span>')
                                    /* //17其他区域密切接触人数
                                     var xue17=0
                                     for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').length;i++){
                                         xue17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .xue1Single').eq(i).html())
                                     }
                                     var jiao17=0
                                     for(var i=0;i<$('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').length;i++){
                                         jiao17+=parseInt($('div[lay-id="demo"] td[data-field="其他区域密切接触人"] .jiao1Single').eq(i).html())
                                     }
                                     $('div[lay-id="demo"] .layui-table-total tbody td[data-field="其他区域密切接触人"] .layui-table-cell').append('<span>'+xue17+'</span>')
                                     $('div[lay-id="demo"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                                     $('div[lay-id="demo"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')*/
                                    //17在境外人员
                                    var xue17=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="在境外人员"] .xue1Single').length;i++){
                                        xue17+=parseInt($('div[lay-id="jie1"] td[data-field="在境外人员"] .xue1Single').eq(i).html())
                                    }
                                    var jiao17=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="在境外人员"] .jiao1Single').length;i++){
                                        jiao17+=parseInt($('div[lay-id="jie1"] td[data-field="在境外人员"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="在境外人员"] .layui-table-cell').append('<span>'+xue17+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')
                                    //18其中港澳台籍人员数
                                    var xue18=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其中港澳台籍人员数"] .xue1Single').length;i++){
                                        xue18+=parseInt($('div[lay-id="jie1"] td[data-field="其中港澳台籍人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao18=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其中港澳台籍人员数"] .jiao1Single').length;i++){
                                        jiao18+=parseInt($('div[lay-id="jie1"] td[data-field="其中港澳台籍人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="其中港澳台籍人员数"] .layui-table-cell').append('<span>'+xue18+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao18').append('<span>'+jiao18+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong18 ').append('<span>'+parseInt(xue18+jiao18)+'</span>')
                                    //19其中外籍人员数
                                    var xue19=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其中外籍人员数"] .xue1Single').length;i++){
                                        xue19+=parseInt($('div[lay-id="jie1"] td[data-field="其中外籍人员数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao19=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其中外籍人员数"] .jiao1Single').length;i++){
                                        jiao19+=parseInt($('div[lay-id="jie1"] td[data-field="其中外籍人员数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="其中外籍人员数"] .layui-table-cell').append('<span>'+xue19+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao19').append('<span>'+jiao19+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong19 ').append('<span>'+parseInt(xue19+jiao19)+'</span>')
                                    //20返校途中人数（当日10点前未到上海）
                                    var xue20=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').length;i++){
                                        xue20+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').eq(i).html())
                                    }
                                    var jiao20=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').length;i++){
                                        jiao20+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="返校途中人数（当日10点前未到上海）"] .layui-table-cell').append('<span>'+xue20+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao20').append('<span>'+jiao20+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong20 ').append('<span>'+parseInt(xue20+jiao20)+'</span>')

                                   /* //当日发现确诊人数
                                    var xue1=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .xue1Single').length;i++){
                                        xue1+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao1=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .jiao1Single').length;i++){
                                        jiao1+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现确诊人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日发现确诊人数"] .layui-table-cell').append('<span>'+xue1+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao1').append('<span>'+jiao1+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong1 ').append('<span>'+parseInt(xue1+jiao1)+'</span>')
                                    //当日发现疑似人数
                                    var xue2=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .xue1Single').length;i++){
                                        xue2+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao2=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .jiao1Single').length;i++){
                                        jiao2+=parseInt($('div[lay-id="jie1"]  td[data-field="当日发现疑似人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日发现疑似人数"] .layui-table-cell').append('<span>'+xue2+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao2').append('<span>'+jiao2+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong2 ').append('<span>'+parseInt(xue2+jiao2)+'</span>')
                                    //当日健康异常人数
                                    var xue3=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .xue1Single').length;i++){
                                        xue3+=parseInt($('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao3=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .jiao1Single').length;i++){
                                        jiao3+=parseInt($('div[lay-id="jie1"]  td[data-field="当日健康异常人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日健康异常人数"] .layui-table-cell').append('<span>'+xue3+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao3').append('<span>'+jiao3+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong3 ').append('<span>'+parseInt(xue3+jiao3)+'</span>')
                                    //当日密切接触人数
                                    var xue4=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日密切接触人数"] .xue1Single').length;i++){
                                        xue4+=parseInt($('div[lay-id="jie1"]  td[data-field="当日密切接触人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao4=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日密切接触人数"] .jiao1Single').length;i++){
                                        jiao4+=parseInt($('div[lay-id="jie1"] td[data-field="当日密切接触人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日密切接触人数"] .layui-table-cell').append('<span>'+xue4+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao4').append('<span>'+jiao4+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong4 ').append('<span>'+parseInt(xue4+jiao4)+'</span>')
                                    //人员总数
                                    var xue5=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="人员总数"] .xue1Single').length;i++){
                                        xue5+=parseInt($('div[lay-id="jie1"] td[data-field="人员总数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao5=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="人员总数"] .jiao1Single').length;i++){
                                        jiao5+=parseInt($('div[lay-id="jie1"] td[data-field="人员总数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="人员总数"] .layui-table-cell').append('<span>'+xue5+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao5').append('<span>'+jiao5+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong5 ').append('<span>'+parseInt(xue5+jiao5)+'</span>')
                                    //在沪人数
                                    var xue6=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="在沪人数"] .xue1Single').length;i++){
                                        xue6+=parseInt($('div[lay-id="jie1"] td[data-field="在沪人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao6=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="在沪人数"] .jiao1Single').length;i++){
                                        jiao6+=parseInt($('div[lay-id="jie1"] td[data-field="在沪人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="在沪人数"] .layui-table-cell').append('<span>'+xue6+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao6').append('<span>'+jiao6+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong6 ').append('<span>'+parseInt(xue6+jiao6)+'</span>')
                                    //其中在沪留校人数
                                    var xue7=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="留校人数"] .xue1Single').length;i++){
                                        xue7+=parseInt($('div[lay-id="jie1"] td[data-field="留校人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao7=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="留校人数"] .jiao1Single').length;i++){
                                        jiao7+=parseInt($('div[lay-id="jie1"] td[data-field="留校人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="留校人数"] .layui-table-cell').append('<span>'+xue7+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao7').append('<span>'+jiao7+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong7 ').append('<span>'+parseInt(xue7+jiao7)+'</span>')
                                    //在沪留校中密切接触未过隔离期人数
                                    var xue8=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="留校+密切接触患病"] .xue1Single').length;i++){
                                        xue8+=parseInt($('div[lay-id="jie1"] td[data-field="留校+密切接触患病"] .xue1Single').eq(i).html())
                                    }
                                    var jiao8=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="留校+密切接触患病"] .jiao1Single').length;i++){
                                        jiao8+=parseInt($('div[lay-id="jie1"] td[data-field="留校+密切接触患病"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="留校+密切接触患病"] .layui-table-cell').append('<span>'+xue8+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao8').append('<span>'+jiao8+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong8 ').append('<span>'+parseInt(xue8+jiao8)+'</span>')
                                    //当日从湖北（含途经）返沪人数
                                    var xue9=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="去过重点地区"] .xue1Single').length;i++){
                                        xue9+=parseInt($('div[lay-id="jie1"] td[data-field="去过重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao9=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="去过重点地区"] .jiao1Single').length;i++){
                                        jiao9+=parseInt($('div[lay-id="jie1"] td[data-field="去过重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="去过重点地区"] .layui-table-cell').append('<span>'+xue9+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao9').append('<span>'+jiao9+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong9 ').append('<span>'+parseInt(xue9+jiao9)+'</span>')
                                    //当日从其他地区返沪人数
                                    var xue10=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日从其他地区返沪"] .xue1Single').length;i++){
                                        xue10+=parseInt($('div[lay-id="jie1"] td[data-field="当日从其他地区返沪"] .xue1Single').eq(i).html())
                                    }
                                    var jiao10=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="当日从其他地区返沪"] .jiao1Single').length;i++){
                                        jiao10+=parseInt($('div[lay-id="jie1"] td[data-field="当日从其他地区返沪"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日从其他地区返沪"] .layui-table-cell').append('<span>'+xue10+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao10').append('<span>'+jiao10+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong10 ').append('<span>'+parseInt(xue10+jiao10)+'</span>')
                                    //目前居家隔离人数
                                    var xue11=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .xue1Single').length;i++){
                                        xue11+=parseInt($('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao11=0
                                    for(var i=0;i<$('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .jiao1Single').length;i++){
                                        jiao11+=parseInt($('div[lay-id="jie1"]  td[data-field="目前在家隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="目前在家隔离"] .layui-table-cell').append('<span>'+xue11+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao11').append('<span>'+jiao11+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong11 ').append('<span>'+parseInt(xue11+jiao11)+'</span>')
                                    //目前集中隔离人数
                                    var xue12=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="目前集中隔离"] .xue1Single').length;i++){
                                        xue12+=parseInt($('div[lay-id="jie1"] td[data-field="目前集中隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao12=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="目前集中隔离"] .jiao1Single').length;i++){
                                        jiao12+=parseInt($('div[lay-id="jie1"] td[data-field="目前集中隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="目前集中隔离"] .layui-table-cell').append('<span>'+xue12+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao12').append('<span>'+jiao12+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong12 ').append('<span>'+parseInt(xue12+jiao12)+'</span>')
                                    //当日解除隔离人数
                                    var xue13=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日接触隔离"] .xue1Single').length;i++){
                                        xue13+=parseInt($('div[lay-id="jie1"] td[data-field="当日接触隔离"] .xue1Single').eq(i).html())
                                    }
                                    var jiao13=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日接触隔离"] .jiao1Single').length;i++){
                                        jiao13+=parseInt($('div[lay-id="jie1"] td[data-field="当日接触隔离"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日接触隔离"] .layui-table-cell').append('<span>'+xue13+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao13').append('<span>'+jiao13+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong13 ').append('<span>'+parseInt(xue13+jiao13)+'</span>')
                                    //当日在湖北人数
                                    var xue14=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在重点地区"] .xue1Single').length;i++){
                                        xue14+=parseInt($('div[lay-id="jie1"] td[data-field="当日在重点地区"] .xue1Single').eq(i).html())
                                    }
                                    var jiao14=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在重点地区"] .jiao1Single').length;i++){
                                        jiao14+=parseInt($('div[lay-id="jie1"] td[data-field="当日在重点地区"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日在重点地区"] .layui-table-cell').append('<span>'+xue14+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao14').append('<span>'+jiao14+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong14 ').append('<span>'+parseInt(xue14+jiao14)+'</span>')
                                    //重点地区密切接触未过隔离期人数
                                    var xue15=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="重点地区密切接触未过隔离期的人"] .xue1Single').length;i++){
                                        xue15+=parseInt($('div[lay-id="jie1"] td[data-field="重点地区密切接触未过隔离期的人"] .xue1Single').eq(i).html())
                                    }
                                    var jiao15=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="重点地区密切接触未过隔离期的人"] .jiao1Single').length;i++){
                                        jiao15+=parseInt($('div[lay-id="jie1"] td[data-field="重点地区密切接触未过隔离期的人"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="重点地区密切接触未过隔离期的人"] .layui-table-cell').append('<span>'+xue15+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao15').append('<span>'+jiao15+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong15 ').append('<span>'+parseInt(xue15+jiao15)+'</span>')
                                    //当日在其他区域人数
                                    var xue16=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .xue1Single').length;i++){
                                        xue16+=parseInt($('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao16=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .jiao1Single').length;i++){
                                        jiao16+=parseInt($('div[lay-id="jie1"] td[data-field="当日在其他区域人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="当日在其他区域人数"] .layui-table-cell').append('<span>'+xue16+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao16').append('<span>'+jiao16+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong16 ').append('<span>'+parseInt(xue16+jiao16)+'</span>')
                                    //其他区域密切接触人数
                                    var xue17=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其他区域密切接触人"] .xue1Single').length;i++){
                                        xue17+=parseInt($('div[lay-id="jie1"] td[data-field="其他区域密切接触人"] .xue1Single').eq(i).html())
                                    }
                                    var jiao17=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其他区域密切接触人"] .jiao1Single').length;i++){
                                        jiao17+=parseInt($('div[lay-id="jie1"] td[data-field="其他区域密切接触人"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="其他区域密切接触人"] .layui-table-cell').append('<span>'+xue17+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao17').append('<span>'+jiao17+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong17 ').append('<span>'+parseInt(xue17+jiao17)+'</span>')
                                    //其他区域曾途经湖北人数
                                    var xue18=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其他区域曾途经湖北人数"] .xue1Single').length;i++){
                                        xue18+=parseInt($('div[lay-id="jie1"] td[data-field="其他区域曾途经湖北人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao18=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="其他区域曾途经湖北人数"] .jiao1Single').length;i++){
                                        jiao18+=parseInt($('div[lay-id="jie1"] td[data-field="其他区域曾途经湖北人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="其他区域曾途经湖北人数"] .layui-table-cell').append('<span>'+xue18+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao18').append('<span>'+jiao18+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong18 ').append('<span>'+parseInt(xue18+jiao18)+'</span>')
                                    //返校途中人数（当日10点前未到上海）
                                    var xue19=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').length;i++){
                                        xue19+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .xue1Single').eq(i).html())
                                    }
                                    var jiao19=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').length;i++){
                                        jiao19+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中人数（当日10点前未到上海）"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="返校途中人数（当日10点前未到上海）"] .layui-table-cell').append('<span>'+xue19+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao19').append('<span>'+jiao19+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong19 ').append('<span>'+parseInt(xue19+jiao19)+'</span>')
                                    //返校途中密切接触人数
                                    var xue20=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中密切接触人数"] .xue1Single').length;i++){
                                        xue20+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中密切接触人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao20=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中密切接触人数"] .jiao1Single').length;i++){
                                        jiao20+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中密切接触人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="返校途中密切接触人数"] .layui-table-cell').append('<span>'+xue20+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao20').append('<span>'+jiao20+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong20 ').append('<span>'+parseInt(xue20+jiao20)+'</span>')
                                    //返校途中途经湖北人数
                                    var xue21=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中途经湖北人数"] .xue1Single').length;i++){
                                        xue21+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中途经湖北人数"] .xue1Single').eq(i).html())
                                    }
                                    var jiao21=0
                                    for(var i=0;i<$('div[lay-id="jie1"] td[data-field="返校途中途经湖北人数"] .jiao1Single').length;i++){
                                        jiao21+=parseInt($('div[lay-id="jie1"] td[data-field="返校途中途经湖北人数"] .jiao1Single').eq(i).html())
                                    }
                                    $('div[lay-id="jie1"] .layui-table-total tbody td[data-field="返校途中途经湖北人数"] .layui-table-cell').append('<span>'+xue21+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .jiao21').append('<span>'+jiao21+'</span>')
                                    $('div[lay-id="jie1"] .layui-table-total tbody .zong21 ').append('<span>'+parseInt(xue21+jiao21)+'</span>')*/

                                    //固定合计行
                                    $('div[lay-id="jie1"]').css('position','relative')
                                    var heji='<div class="heji"><table cellspacing="0" cellpadding="0" border="0" class="layui-table"><tbody>' +
                                        '<tr><td data-field="schoolManageName" data-key="1-0-0" class="" rowspan="3"><div class="layui-table-cell laytable-cell-1-0-0">合计</div></td>' +
                                        '<td data-field="identityName" data-key="1-0-2" class=""><div class="layui-table-cell laytable-cell-1-0-2"><span>学生人数</span></div></td>'+
                                        '</tr>'+
                                        '<tr><td class="jiao"><span>教工人数</span></td></tr>'+
                                        '<tr><td class="zong"><span>师生总数</span></td></tr>'+
                                        '</tbody></table></div>'
                                    $('div[lay-id="jie1"] .layui-table-total').append(heji)
                                    // $('div[lay-id="jie1"] .heji ').css({'position':'absolute','top':'95%'})
                                    var gao=$('div[lay-id="jie1"]').height()-30
                                    $('div[lay-id="jie1"] .heji ').css({'position':'absolute','top':gao})
                                }
                            });
                        }
                    });
                }
            })

        });
        element.on('tab(docDemoTabBrief)', function(data){
            // console.log(data.index); //得到当前Tab的所在下标
            if(data.index==0){
                tableIns1.reload({
                    url:'/HealthyInfo/statisticsInfo',
                    where: { //设定异步数据接口的额外参数，任意设
                        groupBy:'SCHOOL_MANAGE_TYPE',
                        createTime:$('#guanTime').val()
                    }
                });
            }else{
                tableIns2.reload({
                    url:'/HealthyInfo/statisticsInfo',
                    where: { //设定异步数据接口的额外参数，任意设
                        groupBy:'rhi.LIVE_STREET',
                        createTime:$('#jieTime').val()
                    }
                });
            }
        });
        $(document).on('click','.gdangri',function(){
            if($(this).html()==0){
                return false
            }
            var identityType=$(this).attr('identityType');
            var schoolManageType=$(this).attr('schoolManageType');
            var deptId=$(this).attr('deptId');
            var data={
                identityType:identityType,
                schoolManageType:schoolManageType,
                deptId:deptId,
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
                                        if (data[i].dayStatus == 1) {
                                            return '当日在沪'
                                        } else if (data[i].dayStatus == 2) {
                                            return '当日在重点地区（湖北武汉）'
                                              } else if (data[i].dayStatus == 3) {
                                                return '当日在重点地区（湖北其他地区）'
                                              } else if (data[i].dayStatus == 4) {
                                                return '当日在国内其他地区'
                                              } else if (data[i].dayStatus == 5) {
                                                return '当日在境外（含中国港澳台地区）'
                                              } else if (data[i].dayStatus == 6) {
                                                return '返校途中'
                                        } else {
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
        $(document).on('click','.jdangri',function(){
            if($(this).html()==0){
                return false
            }
            var identityType=$(this).attr('identityType');
            var liveStreet=$(this).attr('liveStreet');
            var deptId=$(this).attr('deptId');
            var data={
                identityType:identityType,
                liveStreet:liveStreet,
                deptId:deptId,
                createTime:$('#jieTime').val()
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
            }
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
                        content: '<table class="layui-table  jdetails">\n' +
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
                                    /*    '      <td nowrap="nowrap">'+function () {
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
                            $('.jdetails tbody ').html(str)
                        }
                    });
                }
            })
        })
        /*健康数据趋势变化图 */
        $('.trend').click(function(){
            var myChart = echarts.init(document.getElementById('hig'));
            var healthTime = new Array()
            var obj = {};
            var zc = 0;
            var yc = 0;
            var ys = 0;
            var qz = 0;
            var jc = 0;
           $.ajax({
               url:'/HealthyInfo/chartAnalysis',
               type:'post',
               dataType:'json',
               data:{
                   type:2,
                   groupBy:'HEALTH_STATUS',
                   stateTime:$('#datestar').val(),
                   endTime:$('#dateend').val(),
               },
               success:function(res){
                   var obj = res.object
                   option = {
                       grid: {
                           left: '3%',
                           right: '4%',
                           bottom: '3%',
                           containLabel: true
                       },
                       legend: {
                           data: ['健康', '异常', '疑似', '确诊','密切接触未过隔离期']
                       },
                       xAxis: {
                           type: 'category',
                           boundaryGap: false,
                           data:res.obj1,
                           axisTick: {
                               alignWithLabel: true
                           },
                           axisLabel: {interval:0,rotate:40 }
                       },
                       yAxis: {
                           type: 'value'
                       },
                       series: [
                           {
                               name: '健康',
                               type: 'line',
                               stack: '总量',
                               data: obj[1]
                           },
                           {
                               name: '异常',
                               type: 'line',
                               stack: '总量',
                               data: obj[2]
                           },
                           {
                               name: '疑似',
                               type: 'line',
                               stack: '总量',
                               data: obj[3]
                           },
                           {
                               name: '确诊',
                               type: 'line',
                               stack: '总量',
                               data: obj[4]
                           },
                           {
                               name: '密切接触未过隔离期',
                               type: 'line',
                               stack: '总量',
                               data: obj[5]
                           },

                       ]
                   };
                   myChart.setOption(option);

               }
           })
           $('.searbut').click(function(){
               var healthTime = new Array()
               var obj = {};
               var zc = 0;
               var yc = 0;
               var ys = 0;
               var qz = 0;
               var jc = 0;
               $.ajax({
                   url:'/HealthyInfo/chartAnalysis',
                   type:'post',
                   dataType:'json',
                   data:{
                       type:2,
                       groupBy:'HEALTH_STATUS',
                       stateTime:$('#datestar').val(),
                       endTime:$('#dateend').val(),
                       schoolManageType:$('.schoolManageType').val(),
                       liveStreet:$('.liveStreet').val()
                   },
                   success:function(res){
                       var obj = res.object
                       option = {
                           grid: {
                               left: '3%',
                               right: '4%',
                               bottom: '3%',
                               containLabel: true
                           },
                           legend: {
                               data: ['健康', '异常', '疑似', '确诊','密切接触未过隔离期']
                           },
                           xAxis: {
                               type: 'category',
                               boundaryGap: false,
                               data:res.obj1,
                               axisTick: {
                                   alignWithLabel: true
                               },
                               axisLabel: {interval:0,rotate:40 }
                           },
                           yAxis: {
                               type: 'value'
                           },
                           series: [
                               {
                                   name: '健康',
                                   type: 'line',
                                   stack: '总量',
                                   data: obj[1]
                               },
                               {
                                   name: '异常',
                                   type: 'line',
                                   stack: '总量',
                                   data: obj[2]
                               },
                               {
                                   name: '疑似',
                                   type: 'line',
                                   stack: '总量',
                                   data: obj[3]
                               },
                               {
                                   name: '确诊',
                                   type: 'line',
                                   stack: '总量',
                                   data: obj[4]
                               },
                               {
                                   name: '密切接触未过隔离期',
                                   type: 'line',
                                   stack: '总量',
                                   data: obj[5]
                               },

                           ]
                       };
                       myChart.setOption(option);

                   }
               })
           })
        })

        /*师生返沪情况*/
        $('.back').click(function(){
            var meCharts = echarts.init(document.getElementById('stuteatu'));
            $("#stustardate").val(nowformat);
            laydate.render({
                elem: '#stustardate'
                , trigger: 'click'//呼出事件改成click
                , format: 'yyyy-MM-dd'
                ,done:function(value,data){
                    $.ajax({
                        url:'/HealthyInfo/BacktoShanghai',
                        type:'get',
                        dataType:'json',
                        data:{
                            time:value
                        },
                        success:function(res){
                            var student
                            var teacher
                            var WaitStudent
                            var WaitTeacher
                            if(res.object == "" || res.object == undefined){
                                student = 0
                                teacher = 0
                                WaitStudent = 0
                                WaitTeacher = 0
                            }else{
                                teacher = res.object.teacher
                                student = res.object.student
                                WaitStudent = res.object.WaitStudent
                                WaitTeacher = res.object.WaitTeacher
                            }
                            option = {
                                color: ['#3398DB'],
                                tooltip: {},
                                xAxis: [
                                    {
                                        type: 'category',
                                        data: ['在沪教师', '在沪学生', '待返沪教师', '待返沪学生'],
                                    }
                                ],
                                yAxis: [
                                    {
                                        type: 'value'
                                    }
                                ],
                                series: [
                                    {
                                        // name: '直接访问',
                                        type: 'bar',
                                        barWidth: '40%',
                                        data: [teacher, student, WaitTeacher, WaitStudent ],
                                        itemStyle: {
                                            normal: {
                                                color: function(params) {
                                                    var colorList = [
                                                        '#189A80','#377790','#F09c2a','#d24132'
                                                    ];
                                                    return colorList[params.dataIndex]

                                                },
                                                label: {
                                                    show: true,		//开启显示
                                                    position: 'top',	//在上方显示
                                                    textStyle: {	    //数值样式
                                                        color: 'black',
                                                        fontSize: 16
                                                    }
                                                }
                                            }
                                        },
                                    }
                                ]
                            };
                            meCharts.setOption(option);
                        }
                    })
                }
            });
            $.ajax({
                url:'/HealthyInfo/BacktoShanghai',
                type:'get',
                dataType:'json',
                data:{
                    time:$('#stustardate').val()
                },
                success:function(res){
                    var student
                    var teacher
                    var WaitStudent
                    var WaitTeacher
                    if(res.object == "" || res.object == undefined){
                        student = 0
                        teacher = 0
                        WaitStudent = 0
                        WaitTeacher = 0
                    }else{
                        teacher = res.object.teacher
                        student = res.object.student
                        WaitStudent = res.object.WaitStudent
                        WaitTeacher = res.object.WaitTeacher
                    }
                    option = {
                        color: ['#3398DB'],
                        tooltip: {},
                        xAxis: [
                            {
                                type: 'category',
                                data: ['在沪教师', '在沪学生', '待返沪教师', '待返沪学生'],
                            }
                        ],
                        yAxis: [
                            {
                                type: 'value'
                            }
                        ],
                        series: [
                            {
                                type: 'bar',
                                barWidth: '40%',
                                data: [teacher, student, WaitTeacher, WaitStudent],
                                itemStyle: {
                                    normal: {
                                        color: function(params) {
                                            var colorList = [
                                                '#189A80','#377790','#F09c2a','#d24132'
                                            ];
                                            return colorList[params.dataIndex]

                                        },
                                        label: {
                                            show: true,		//开启显示
                                            position: 'top',	//在上方显示
                                            textStyle: {	    //数值样式
                                                color: 'black',
                                                fontSize: 16
                                            }
                                        }
                                    }
                                },
                            }
                        ]
                    };
                    meCharts.setOption(option);
                }
            })
        })
            /*师生来源地分析*/
        $('.origin').click(function(){
            var orgCharts = echarts.init(document.getElementById('stutearorigin'));
            $('#datas').val(nowformat)
            laydate.render({
                elem: '#datas'
                , trigger: 'click'//呼出事件改成click
                , format: 'yyyy-MM-dd'
                ,done:function(value,data){
                    $.ajax({
                        url:'/HealthyInfo/AnalysisOfOrigin',
                        type:'get',
                        dataType:'json',
                        data:{
                            time:value
                        },
                        success:function(res){
                            var rettear
                            var retstu
                            var focus
                            var focusband
                            if(res.object == "" || res.object == undefined){
                                rettear =0
                                retstu =0
                                focus =0
                                focusband =0
                            }else{
                                rettear = res.object["重点地区待返沪学生"]
                                retstu = res.object["重点地区待返沪教师"]
                                focus = res.object["其他地区待返沪学生"]
                                focusband = res.object["其他地区待返沪教师"]
                            }
                            option = {
                                tooltip:{
                                    trigger: 'item',
                                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                                legend: {
                                    // orient: 'vertical',
                                    left: 'left',
                                    data: ['重点地区待返沪学生', '重点地区待返沪教师', '其他地区待返沪学生', '其他地区待返沪教师']
                                },
                                series: [
                                    {
                                        type: 'pie',
                                        radius: '55%',
                                        center: ['50%', '60%'],
                                        data: [
                                            {value: rettear, name: '重点地区待返沪学生'},
                                            {value: retstu, name: '重点地区待返沪教师'},
                                            {value: focus, name: '其他地区待返沪学生'},
                                            {value: focusband, name: '其他地区待返沪教师'},
                                        ],
                                    }
                                ]
                            };
                            orgCharts.setOption(option);
                        }
                    })
                }
            });
            $.ajax({
                url:'/HealthyInfo/AnalysisOfOrigin',
                type:'get',
                dataType:'json',
                data:{
                    time:$('#datas').val()
                },
                success:function(res){
                    var rettear
                    var retstu
                    var focus
                    var focusband
                    if(res.object == "" || res.object == undefined){
                        rettear =0
                        retstu =0
                        focus =0
                        focusband =0
                    }else{
                        rettear = res.object["重点地区待返沪学生"]
                        retstu = res.object["重点地区待返沪教师"]
                        focus = res.object["其他地区待返沪学生"]
                        focusband = res.object["其他地区待返沪教师"]
                    }
                    option = {
                        tooltip:{
                            // orient: 'vertical',
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            left: 'left',
                            data: ['重点地区待返沪学生', '重点地区待返沪教师', '其他地区待返沪学生', '其他地区待返沪教师']
                        },
                        series: [
                            {
                                type: 'pie',
                                radius: '45%',
                                // center: ['50%', '50%'],
                                data: [
                                    {value: rettear, name: '重点地区待返沪学生'},
                                    {value: retstu, name: '重点地区待返沪教师'},
                                    {value: focus, name: '其他地区待返沪学生'},
                                    {value: focusband, name: '其他地区待返沪教师'},
                                ],
                                itemStyle:{
                                    normal:{
                                        label:{
                                            show: true,
                                            formatter: '{b} : {c} ({d}%)'
                                        },
                                        labelLine :{show:true}
                                    }
                                }
                            }
                        ]
                    };
                    orgCharts.setOption(option);
                }
            })
        })

        /*师生居住地分析*/
        $('.residence').click(function(){
            var myCharts = echarts.init(document.getElementById('stureturn'));
            $("#stuenddate").val(nowformat);
            var LIVE_STREET = new Array();
            var student = new Array();
            var teacher = new  Array();
            laydate.render({
                elem: '#stuenddate'
                , trigger: 'click'//呼出事件改成click
                , format: 'yyyy-MM-dd',
                done:function(value,data){
                    $.ajax({
                        url:'/HealthyInfo/liveanalysis',
                        type:'get',
                        dataType:'json',
                        data:{
                            time:$('#stuenddate').val()
                        },
                        success:function(res){
                            var objs = res.obj
                            for(var i=0;i<objs.length;i++){
                                if(res.obj == "" || res.obj== undefined){
                                    LIVE_STREET[i] = 0
                                    student[i]= 0
                                    teacher[i]=0
                                }else{
                                    LIVE_STREET[i] = objs[i].LIVE_STREET
                                    student[i] = objs[i].student
                                    teacher[i] = objs[i].teacher
                                }
                            }
                            option = {
                                tooltip: {},
                                legend: {
                                    data: ['在沪学生', '在沪教师']
                                },
                                xAxis: [
                                    {
                                        type: 'category',
                                        data: LIVE_STREET,
                                        axisTick: {
                                            alignWithLabel: true
                                        },
                                        axisLabel: {interval:0,rotate:40 },
                                        axisLabel: {
                                            interval: 0,// 0 强制显示所有，1为隔一个标签显示一个标签，2为隔两个
                                            rotate: 50,//标签旋转角度，在标签显示不下的时可通过旋转防止重叠
                                            textStyle: {
                                                fontSize: 13,//字体大小
                                            }
                                        }
                                    }
                                ],
                                yAxis: [
                                    {
                                        type: 'value'
                                    }
                                ],
                                series: [
                                    {
                                        name: '在沪学生',
                                        type: 'bar',
                                        data:student,
                                        itemStyle: {
                                            normal: {
                                                color: function(params) {
                                                    var colorList = [
                                                        '#189A80'

                                                    ];

                                                    return colorList[params.dataIndex]
                                                },
                                                label: {
                                                    show: true,		//开启显示
                                                    position: 'top',	//在上方显示
                                                    textStyle: {	    //数值样式
                                                        color: 'black',
                                                        fontSize: 16
                                                    }
                                                }
                                            }

                                        },
                                        barWidth:'45%',
                                        barGap:'1%'
                                    },
                                    {
                                        name: '在沪教师',
                                        type: 'bar',
                                        data: teacher,
                                        barWidth:'45%',
                                        itemStyle: {
                                            normal: {
                                                color: function(params) {
                                                    var colorList = [
                                                        '#377790'
                                                    ];
                                                    return colorList[params.dataIndex]
                                                },
                                                label: {
                                                    show: true,		//开启显示
                                                    position: 'top',	//在上方显示
                                                    textStyle: {	    //数值样式
                                                        color: 'black',
                                                        fontSize: 16
                                                    }
                                                }
                                            }
                                        },
                                    }
                                ]
                            };
                            myCharts.setOption(option);
                        }
                    })
                }

            });
            $.ajax({
                url:'/HealthyInfo/liveanalysis',
                type:'get',
                dataType:'json',
                data:{
                    time:$('#stuenddate').val()
                },
                success:function(res){
                    var objs = res.obj
                    for(var i=0;i<objs.length;i++){
                        if(res.obj == "" || res.obj== undefined){
                            LIVE_STREET[i] = 0
                            student[i]= 0
                            teacher[i]=0
                        }else{
                            LIVE_STREET[i] = objs[i].LIVE_STREET
                            student[i] = objs[i].student
                            teacher[i] = objs[i].teacher
                        }
                    }
                    option = {
                        tooltip: {},
                        legend: {
                            data: ['在沪学生', '在沪教师']
                        },
                        // calculable: true,
                        xAxis: [
                            {
                                type: 'category',
                                data: LIVE_STREET,
                                right:'30%',
                                axisTick: {
                                    alignWithLabel: true
                                },
                                axisLabel: {interval:0,rotate:40 },
                                axisLabel: {
                                    interval: 0,// 0 强制显示所有，1为隔一个标签显示一个标签，2为隔两个
                                    rotate: 50,//标签旋转角度，在标签显示不下的时可通过旋转防止重叠
                                    textStyle: {
                                        fontSize: 13,//字体大小
                                    }
                                }
                            }
                        ],
                        yAxis: [
                            {
                                type: 'value'
                            }
                        ],
                        series: [
                            {
                                name: '在沪学生',
                                type: 'bar',
                                data:student,
                                itemStyle: {
                                    normal: {
                                        color: function(params) {
                                            var colorList = [
                                                '#189A80'

                                            ];

                                            return colorList[params.dataIndex]

                                        },
                                        label: {
                                            show: true,		//开启显示
                                            position: 'top',	//在上方显示
                                            textStyle: {	    //数值样式
                                                color: 'black',
                                                fontSize: 16
                                            }
                                        }
                                    }

                                },
                                barWidth:'45%',
                                barGap:'1%'
                            },
                            {
                                name: '在沪教师',
                                type: 'bar',
                                data: teacher,
                                barWidth:'45%',
                                itemStyle: {
                                    normal: {
                                        color: function(params) {
                                            var colorList = [
                                                '#377790'
                                            ];
                                            return colorList[params.dataIndex]

                                        },
                                        label: {
                                            show: true,		//开启显示
                                            position: 'top',	//在上方显示
                                            textStyle: {	    //数值样式
                                                color: 'black',
                                                fontSize: 16
                                            }
                                        }
                                    }

                                },
                            }
                        ]
                    };
                    myCharts.setOption(option);
                }
            })
        })

        /*师生健康状况分析*/
        $('.heathStatu').click(function(){
            var myCharttemp = echarts.init(document.getElementById('temp'));
            $('#jkzk').val(nowformat)
            var stateTime = $('jkzk').val()
            var endTime = $('jkzk').val()
            //监听时间在done里面写
            laydate.render({
                elem: '#jkzk'
                , trigger: 'click'//呼出事件改成click
                , format: 'yyyy-MM-dd'
                ,done:function(value,data){
                    $.ajax({
                        url:'/HealthyInfo/chartAnalysis',
                        type:'post',
                        dataType:'json',
                        data:{
                            type:1,
                            stateTime:value,
                            endTime:value,
                            groupBy:"HEALTH_STATUS"
                        },
                        success:function(res){
                            var data = res.object;
                            var zc = 0;
                            var yc = 0;
                            var ys = 0;
                            var qz = 0;
                            var jc = 0;
                            for(var i = 0 ; i < data.length ;i++){
                                switch(data[i].HEALTH_STATUS){
                                    case "1":
                                        zc = data[i].numbers;
                                        break;
                                    case "2":
                                        yc = data[i].numbers;
                                        break;
                                    case "3":
                                        ys = data[i].numbers;
                                        break;
                                    case "4":
                                        qz = data[i].numbers;
                                        break;
                                    case "5":
                                        jc = data[i].numbers;
                                        break;
                                }
                            }
                            option = {
                                tooltip: {},
                                xAxis: {
                                    type: 'category',
                                    data: ['健康正常', '健康异常', '疑似', '确诊', '密切接触未过隔离期']
                                },
                                yAxis: {
                                    type: 'value'
                                },
                                series: [{
                                    data: [zc, yc, ys, qz, jc],
                                    type: 'bar',
                                    itemStyle: {
                                        normal: {
                                            color: function(params) {
                                                var colorList = [
                                                    '#189A80','#377790','#F09c2a','#d24132','#562466'
                                                ];
                                                return colorList[params.dataIndex]

                                            },
                                            label: {
                                                show: true,		//开启显示
                                                position: 'top',	//在上方显示
                                                textStyle: {	    //数值样式
                                                    color: 'black',
                                                    fontSize: 16
                                                }
                                            }
                                        }
                                    }
                                }]
                            };
                            myCharttemp.setOption(option);
                        }})
                }
            });
            $.ajax({
                url:'/HealthyInfo/chartAnalysis',
                type:'post',
                dataType:'json',
                data:{
                    type:1,
                    stateTime:$('#jkzk').val(),
                    endTime:$('#jkzk').val(),
                    groupBy:"HEALTH_STATUS"
                },
                success:function(res){
                    var data = res.object;
                    var zc = 0;
                    var yc = 0;
                    var ys = 0;
                    var qz = 0;
                    var jc = 0;
                    for(var i = 0 ; i < data.length ;i++){
                        switch(data[i].HEALTH_STATUS){
                            case "1":
                                zc = data[i].numbers;
                                break;
                            case "2":
                                yc = data[i].numbers;
                                break;
                            case "3":
                                ys = data[i].numbers;
                                break;
                            case "4":
                                qz = data[i].numbers;
                                break;
                            case "5":
                                jc = data[i].numbers;
                                break;
                        }
                    }
                    option = {
                        tooltip: {},
                        xAxis: {
                            type: 'category',
                            data: ['健康正常', '健康异常', '疑似', '确诊', '密切接触未过隔离期']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: [zc, yc, ys, qz, jc],
                            type: 'bar',
                            itemStyle: {
                                normal: {
                                    color: function(params) {
                                        var colorList = [
                                            '#189A80','#377790','#F09c2a','#d24132','#562466'
                                        ];
                                        return colorList[params.dataIndex]

                                    },
                                    label: {
                                        show: true,		//开启显示
                                        position: 'top',	//在上方显示
                                        textStyle: {	    //数值样式
                                            color: 'black',
                                            fontSize: 16
                                        }
                                    }
                                }
                            },
                        }]
                    };
                    myCharttemp.setOption(option);
                }})
            });

        /*师生健康管理*/
        $('.management').click(function(){
            var myChartbing1 = echarts.init(document.getElementById('bingtu1'));
            var myChartbing2 = echarts.init(document.getElementById('bingtu2'));
            var myChartbing3 = echarts.init(document.getElementById('bingtu3'));
            $('#guanli').val(nowformat)
            laydate.render({
                elem: '#guanli'
                , trigger: 'click'//呼出事件改成click
                , format: 'yyyy-MM-dd'
                ,done:function(value,data){
                    $.ajax({
                        url:'/HealthyInfo/HealthManagement',
                        type:'get',
                        dataType:'json',
                        data:{time:value},
                        success:function(res){
                            var Home
                            var hearth
                            var registered
                            if(res.object==undefined || res.object == ""){
                                Home = 0
                                hearth=0
                                registered=0
                            }else{
                                Home = res.object.HomeIsolation
                                hearth = res.object.HealthWatch
                                registered = res.object.registered
                            }
                            option = {
                                tooltip: {
                                    formatter: '{a} <br/>{b} : {c}%'
                                },
                                series: [
                                    {
                                        name:'居家隔离',
                                        type: 'gauge',
                                        // detail: {formatter: '{value}%'},
                                        data: [{value: Home}]
                                    }
                                ]
                            };
                            myChartbing1.setOption(option);

                            option = {
                                tooltip: {
                                    formatter: '{a} <br/>{b} : {c}%'
                                },
                                series: [
                                    {
                                        name:'健康观测',
                                        type: 'gauge',
                                        data: [{value: hearth}]
                                    }
                                ]
                            };
                            myChartbing2.setOption(option);
                            option = {
                                tooltip: {
                                    formatter: '{a} <br/>{b} : {c}%'
                                },
                                series: [
                                    {
                                        name:'注册健康云每日健康观测',
                                        type: 'gauge',
                                        data: [{value: registered}]
                                    }
                                ]
                            };
                            myChartbing3.setOption(option);
                        }
                    })
                }
            });
            $.ajax({
                url:'/HealthyInfo/HealthManagement',
                type:'get',
                dataType:'json',
                data:{time:$('#guanli').val()},
                success:function(res){
                    var Home
                    var hearth
                    var registered
                    if(res.object==undefined || res.object == ""){
                        Home = 0
                        hearth=0
                        registered=0
                    }else{
                        Home = res.object.HomeIsolation
                        hearth = res.object.HealthWatch
                        registered = res.object.registered
                    }
                    option = {
                        tooltip: {
                            formatter: '{a} <br/>{b} : {c}%'
                        },
                        series: [
                            {
                                name:'居家隔离',
                                type: 'gauge',
                                detail: {formatter: '{value}%'},
                                data: [{value: Home}]
                            }
                        ]
                    };
                    myChartbing1.setOption(option);

                    option = {
                        tooltip: {
                            formatter: '{a} <br/>{b} : {c}%'
                        },
                        series: [
                            {
                                name:'健康观测',
                                type: 'gauge',
                                detail: {formatter: '{value}%'},
                                data: [{value: hearth}]
                            }
                        ]
                    };
                    myChartbing2.setOption(option);
                    option = {
                        tooltip: {
                            formatter: '{a} <br/>{b} : {c}%'
                        },
                        series: [
                            {
                                name: '注册健康云每日健康观测',
                                type: 'gauge',
                                detail: {formatter: '{value}%'},
                                data: [{value: registered}]
                            }
                        ]
                    };
                    myChartbing3.setOption(option);
                }
            })
        })

    });
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
    function getBeforeDate(n) {
        var n = n;
        var d = new Date();
        var year = d.getFullYear();
        var mon = d.getMonth() + 1;
        var day = d.getDate();
        if(day <= n) {
            if(mon > 1) {
                mon = mon - 1;
            } else {
                year = year - 1;
                mon = 12;
            }
        }
        d.setDate(d.getDate() - n);
        year = d.getFullYear();
        mon = d.getMonth() + 1;
        day = d.getDate();
        s = year + "-" + (mon < 10 ? ('0' + mon) : mon) + "-" + (day < 10 ? ('0' + day) : day);
        return s;
    }
</script>
</body>
</html>