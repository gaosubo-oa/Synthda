<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><fmt:message code="main.th.ProcessPortal" /></title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
        <link rel="stylesheet" type="text/css" href="../css/attend/myAttendance.css"/>
        <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
        <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="/js/echarts.min.js"></script>
        <script src="../../js/jquery/jquery.cookie.js"></script>
        <style>
                html, body{
                        font-family: "Microsoft Yahei" !important;
                }
                body{
                        background: #F8F8F8;
                }
                .oneList , .twoList , .threeList , .fourList{
                        display: flex;
                        width: 23%;
                        border-radius: 5px;
                        margin: 2px 0.5%;
                        padding: 15px;
                }
                .oneList{
                        background: #D3F0F4;
                }
                .twoList{
                        background: #E9E0F5;
                }
                .threeList{
                        background: #E9DAD7;
                }
                .fourList{
                        background: #DEF1ED;
                }
                .twoLeft , .twoRight {
                        width: 49%;
                        background: white;
                }
                .threeLeft{
                        width: 49%;
                        background: white;
                        margin-left: 0.5%;
                }
                .threeRight{
                        width: 49%;
                        background: white;
                        margin-left: 1%;
                }
                .item{
                        width: 37%;
                        margin-left: 10%;
                }
                .numerShow{
                        font-size: 22px;
                        font-weight: bold;
                }
                .fontShow{
                        color: #8B999F;
                        font-size: 13px;
                }
                li{
                        margin: 6px auto;
                }
                .layui-tab-content li:hover{
                        background: #e8f4fc;
                        cursor: pointer;
                }
                .layui-tab-content li{
                        list-style: disc;
                        padding: 5px 0px;
                        margin: 0;
                        font-size: 13px;
                }
                .fastItem{
                        width: 20%;
                        margin: 5% 8%;
                        cursor: pointer;
                }
                .apply{
                        margin-top: 15px;
                }
                .noData{
                        margin-top: 10%;
                }
        </style>
</head>
<body>
<div style="padding: 8px">
        <%--第一部分--%>
        <div style="display: flex">
                <%--第一块--%>
                <div class="oneList">
                        <div class="item">
                                <ul>
                                        <li><span class="numerShow allWork"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow "><fmt:message code="flowIndex.th.overallProcessApproval" /></li>
                                        <li><span class="numerShow waitWork"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow "><fmt:message code="workflow.th.executing" /></li>
                                </ul>
                        </div>
                        <img src="/img/menu/flow_chart.png" style="width: 60px;height: 65px;margin-top: 7%;margin-left: 15%;" />
                </div>
                <%--第二块--%>
                <div class="twoList">
                        <div class="item">
                                <ul>
                                        <li><span class="numerShow quarterQingJia"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow"><fmt:message code="flowIndex.th.numberOfLeaveDaysTakenThisQuarter" /></li>
                                        <li><span class="numerShow monthQingJia"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow"><fmt:message code="flowIndex.th.numberOfLeaveDaysInThisMonth" /></li>
                                </ul>
                        </div>
                        <img src="/img/menu/travel.png" style="width: 60px;height: 65px;margin-top: 7%;margin-left: 15%;" />
                </div>
                <%--第三块--%>
                <div class="threeList">
                        <div class="item">
                                <ul>
                                        <li><span class="numerShow quarterJiaBan"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow"><fmt:message code="flowIndex.th.numberOfOvertimeHoursInThisQuarter" /></li>
                                        <li><span class="numerShow monthJiaBan"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow"><fmt:message code="flowIndex.th.theNumberOfOvertimeHoursThisMonth" /></li>
                                </ul>
                        </div>
                        <img src="/img/menu/working_on_a_pc.png" style="width: 60px;height: 65px;margin-top: 7%;margin-left: 15%;" />
                </div>
                <%--第四块--%>
                <div class="fourList">
                        <div class="item">
                                <ul>
                                        <li><span class="numerShow quarterChuChai"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow"><fmt:message code="flowIndex.th.numberOfBusinessTripsInThisQuarter" /></li>
                                        <li><span class="numerShow monthChuChai"></span><span class="fontShow" style="margin-left:5px"><fmt:message code="vote.th.term" /></span></li>
                                        <li class="fontShow"><fmt:message code="flowIndex.th.theNumberOfBusinessTripsThisMonth" /></li>
                                </ul>
                        </div>
                        <img src="/img/menu/airplane.png" style="width: 60px;height: 65px;margin-top: 9%;margin-left: 15%;" />
                </div>
        </div>
        <%--第二部分--%>
        <div style="display: flex;margin-top: 10px;">
                <%--左侧--%>
                <div class="twoLeft" style="margin-left: 0.5%;">
                        <div style="margin-top: 15px;margin-left: 15px;font-weight: bold;"><fmt:message code="flowIndex.th.statisticalAnalysisOfCommonlyUsedProcessData" /></div>
                        <div id="main" style="height:300px;"></div>
                </div>
                <%--右侧--%>
                <div class="twoRight" style="margin-left: 1%;">
                        <div style="margin-top: 15px;margin-left: 15px;font-weight: bold;"><fmt:message code="flowIndex.th.quickAccess" /></div>
                        <%--右侧上--%>
                        <div style="display: flex">
                                <div class="fastItem" opttype="140" url="/workflow/work/newflowguider?flowId=140&flowStep=1&prcsId=1">
                                        <img src="/img/menu/rest.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.leave" /></div>
                                </div>
                                <div class="fastItem" opttype="141"  url="/workflow/work/newflowguider?flowId=141&flowStep=1&prcsId=1">
                                        <img src="/img/menu/working_on_laptop.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.overtimeApplication" /></div>
                                </div>
                                <div class="fastItem" opttype="143" url="/workflow/work/newflowguider?flowId=143&flowStep=1&prcsId=1">
                                        <img src="/img/menu/briefcase.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.outgoingApplication" /></div>
                                </div>
                                <div class="fastItem" opttype="142" url="/workflow/work/newflowguider?flowId=142&flowStep=1&prcsId=1">
                                        <img src="/img/menu/airplaneFast.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.businessTripApplication" /></div>
                                </div>
                        </div>
                        <%--右侧上--%>
                        <div style="display: flex">
                                <div class="fastItem" opttype="167" url="/workflow/work/newflowguider?flowId=167&flowStep=1&prcsId=1">
                                        <img src="/img/menu/money.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.expenseReimbursement" /></div>
                                </div>
                                <div class="fastItem" opttype="146" url="/workflow/work/newflowguider?flowId=146&flowStep=1&prcsId=1">
                                        <img src="/img/menu/tiaoxin.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.salaryAdjustmentApplication" /></div>
                                </div>
                                <div class="fastItem" opttype="144" url="/workflow/work/newflowguider?flowId=144&flowStep=1&prcsId=1">
                                        <img src="/img/menu/hotel.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.dutyRosterApplication" /></div>
                                </div>
                                <div class="fastItem" opttype="168" url="/workflow/work/newflowguider?flowId=168&flowStep=1&prcsId=1">
                                        <img src="/img/menu/contract.png" style="width: 60px;height: 65px;" />
                                        <div class="apply"><fmt:message code="workflow.th.contractApproval" /></div>
                                </div>
                        </div>
                </div>
        </div>
        <%--第三部分--%>
        <div style="display: flex;margin-top: 10px;">
                <%--左侧--%>
                <div class="threeLeft">
                        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                                <ul class="layui-tab-title">
                                        <li class="layui-this"><fmt:message code="workflow.th.wait" /></li>
                                        <li><fmt:message code="workflow.th.gowork" /></li>
                                        <li><fmt:message code="workflow.th.allwork" /></li>
                                        <li><fmt:message code="workflow.th.weizuo" /></li>
                                </ul>
                                <div class="layui-tab-content" style="height: 300px;overflow-y: auto">
                                        <div class="layui-tab-item layui-show daiWork"></div>
                                        <div class="layui-tab-item overWork"></div>
                                        <div class="layui-tab-item allWorkShow"></div>
                                        <div class="layui-tab-item weiWork"></div>
                                </div>
                        </div>
                </div>
                <%--右侧--%>
                <div class="threeRight">
                        <div id="main1" style="width:100%;height:400px;"></div>
                </div>
        </div>
</div>
<script type="text/javascript">
        $('#main div:first').css('width',$('#main').width());
        $('#main1 div:first').css('width',$('#main1').width());
        //流程数量
        $.ajax({
                type: 'post',
                url: '/workflow/work/queryCountData',
                dataType: 'json',
                success:function(res) {
                        var data = res.object||'';
                        $('.allWork').html(data.all)
                        $('.waitWork').html(data.wait)
                }
        })
        //本季度数量
        $.ajax({
                type: 'post',
                url:'/flowhook/queryCountDataByQuarter',
                // url: '/attend/queryCountDataByQuarter',
                // dataType: 'json',
                success:function(res) {
                        var data = res.object||'';

                        $('.quarterQingJia').html(data.本季度请假)
                        $('.quarterJiaBan').html(data.本季度加班)
                        $('.quarterChuChai').html(data.本季度出差)
                        $('.monthQingJia').html(data.本月请假)
                        $('.monthJiaBan').html(data.本月加班)
                        $('.monthChuChai').html(data.本月出差)
                }
        })
        //本月度数量
        // $.ajax({
        //     type: 'post',
        //     url:'/flowhook/queryCountDataByQuarter',
        //     // url: '/attend/queryCountDataByMonth',
        //     dataType: 'json',
        //     success:function(res) {
        //         var data=res.object
        //         $('.monthQingJia').html(data.qingJia)
        //         $('.monthJiaBan').html(data.jiaBan)
        //         $('.monthChuChai').html(data.chuChai)
        //     }
        // })
        //待办工作
        $.ajax({
                type: 'get',
                url: '/workflow/work/selectWork',
                dataType: 'json',
                data:{
                        page: 1,
                        pageSize: 100,
                        useFlag: true
                },
                success:function(res) {
                        var data = res.obj||'';
                        var str = ''
                        var $str
                        if(data.length > 0){
                                for(var i=0;i<data.length;i++){
                                        $str=$('<li style="display: flex" onclick ="js_methodDai(this)">'+'<div style="width: 58%;">'+data[i].flowType.flowName +'</div>'+'<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+'<div>'+data[i].receiptTime+'</div>'+'</li>')
                                        $str.data('data',data[i])
                                        $('.daiWork').append($str)
                                }
                        }else{
                                str += '<div class="noData" style="text-align: center;border: none;">' +
                                        '<img  src="/img/main_img/shouyekong.png" alt="">' +
                                        '<h6 style="text-align: center;color: #666;">'+'<fmt:message code="doc.th.NoData" />'+'</h6>' +
                                        '</div>';
                                $('.daiWork').append(str)
                        }

                }
        })
        //办结工作
        $.ajax({
                type: 'post',
                url: '/workflow/work/selectEndWord',
                dataType: 'json',
                data:{
                        page: 1,
                        pageSize: 11,
                        useFlag: true
                },
                success:function(res) {
                        var data = res.obj||''
                        var str = ''
                        var $str
                        if(data.length > 0){
                                for(var i = 0; i < data.length; i++){
                                        $str = $('<li style="display: flex" onclick ="js_method(this)">'+'<div style="width: 58%;">'+data[i].runName+'</div>'+'<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+'<div>'+data[i].deliverTime+'</div>'+'</li>')
                                        $str.data('data', data[i])
                                        $('.overWork').append($str)
                                }
                        }else{
                                str += '<div class="noData" style="text-align: center;border: none;">' +
                                        '<img  src="/img/main_img/shouyekong.png" alt="">' +
                                        '<h6 style="text-align: center;color: #666;">'+'<fmt:message code="doc.th.NoData" />'+'</h6>' +
                                        '</div>';
                                $('.overWork').append(str)
                        }

                }
        })
        //全部工作
        $.ajax({
                type: 'post',
                url: '/workflow/work/selectAll',
                dataType: 'json',
                data:{
                        page: 1,
                        pageSize: 100,
                        useFlag: true
                },
                success:function(res) {
                        var data = res.obj
                        var str = ''
                        var $str
                        if(data.length > 0){
                                for(var i=0;i<data.length;i++){
                                        $str=$('<li style="display: flex" onclick ="js_method(this)">'+'<div style="width: 58%;">'+data[i].flowRun.runName+'</div>'+'<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+'</li>')
                                        $str.data('data',data[i])
                                        $('.threeLeft .allWorkShow').append($str)
                                }
                        }else{
                                str += '<div class="noData" style="text-align: center;border: none;">' +
                                        '<img  src="/img/main_img/shouyekong.png" alt="">' +
                                        '<h6 style="text-align: center;color: #666;">'+'<fmt:message code="doc.th.NoData" />'+'</h6>' +
                                        '</div>';
                                $('.threeLeft .allWorkShow').append(str)
                        }

                }
        })
        //委托工作
        $.ajax({
                type: 'post',
                url: '/workflow/work/entrustWorkList',
                dataType: 'json',
                data:{
                        page: 1,
                        pageSize: 100,
                        useFlag: true,
                        userId: $.cookie('userId')
                },
                success:function(res) {
                        var data = res.obj||'';
                        var str = ''
                        var $str
                        if(data.length > 0){
                                for(var i = 0; i < data.length; i++){
                                        $str = $('<li style="display: flex" onclick ="js_method(this)">'+'<div style="width: 58%;">'+data[i].flowRun.runName.split(' ')[0]+'</div>'+'<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+'</li>')
                                        $str.data('data',data[i])
                                        $('.weiWork').append($str)
                                }
                        }else{
                                str += '<div class="noData" style="text-align: center;border: none;">' +
                                        '<img  src="/img/main_img/shouyekong.png" alt="">' +
                                        '<h6 style="text-align: center;color: #666;">'+'<fmt:message code="doc.th.NoData" />'+'</h6>' +
                                        '</div>';
                                $('.weiWork').append(str)
                        }

                }
        })
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var myChart1 = echarts.init(document.getElementById('main1'));
        //常用流程数据统计分析
        $.ajax({
                type: 'post',
                url: '/flow/findFlowDataByYear',
                data:{
                        flag: 1
                },
                dataType: 'json',
                success:function(res) {
                        var data = res.object||'';
                        var arr = []
                        var arrAll = []
                        var ss = []
                        for(var key in data){
                                arr.push(key)
                                arrAll.push(data[key])
                        }
                        // console.log(arrAll)
                        for(var i = 0; i < arrAll.length; i++){
                                var item = []
                                var monthObj = {}
                                // console.log(arrAll)
                                arrAll[i].forEach(function(month){
                                        monthObj[month.MONTH] = month.num
                                })
                                // console.log(monthObj)
                                for(var j=1;j< 13;j++){
                                        var num = 0
                                        if (monthObj[j]) {
                                                num = monthObj[j]
                                        }
                                        item.push(num)
                                }
                                ss.push(item)
                        }
                        // console.log(ss)
                        // 指定图表的配置项和数据
                        var option = {
                                color: ['#74A0C2','#D66F82','#5BBD8B','#FFB129','#DF5AC4'],
                                tooltip: {
                                        trigger: 'axis'
                                },
                                legend: {
                                        data: arr,
                                        top:'20px'
                                },
                                grid: {
                                        left: '3%',
                                        right: '4%',
                                        bottom: '3%',
                                        containLabel: true
                                },
                                xAxis: {
                                        type: 'category',
                                        boundaryGap: false,
                                        data: ['1<fmt:message code="global.lang.month" />', '2<fmt:message code="global.lang.month" />', '3<fmt:message code="global.lang.month" />', '4<fmt:message code="global.lang.month" />', '5<fmt:message code="global.lang.month" />', '6<fmt:message code="global.lang.month" />', '7<fmt:message code="global.lang.month" />','8<fmt:message code="global.lang.month" />','9<fmt:message code="global.lang.month" />','10<fmt:message code="global.lang.month" />','11<fmt:message code="global.lang.month" />','12<fmt:message code="global.lang.month" />']
                                },
                                yAxis: {
                                        type: 'value'
                                },
                                series: [
                                        {
                                                name: arr[0],
                                                type: 'line',
                                                smooth: true,
                                                data: ss[0]
                                        },
                                        {
                                                name: arr[1],
                                                type: 'line',
                                                smooth: true,
                                                data: ss[1]
                                        },
                                        {
                                                name: arr[2],
                                                type: 'line',
                                                smooth: true,
                                                data: ss[2]
                                        },
                                        {
                                                name: arr[3],
                                                type: 'line',
                                                smooth: true,
                                                data: ss[3]
                                        },{
                                                name: arr[4],
                                                type: 'line',
                                                smooth: true,
                                                data: ss[4]
                                        }
                                ]
                        };
                        myChart.setOption(option);
                        window.addEventListener('resize',function(){
                                myChart.resize();
                        })
                }
        })

        //柱状图显示
        $.ajax({
                type: 'post',
                url: '/flow/findFlowDataByYear',
                data:{
                        flag:2
                },
                dataType: 'json',
                success:function(res) {
                        var data = res.object||''
                        var arr = []
                        var arrAll = []
                        var ss = []
                        for(var key in data){
                                arr.push(key)
                                arrAll.push(data[key])
                        }
                        // console.log(arr)
                        // console.log(arrAll)
                        for(var i = 0; i < arrAll.length; i++){
                                var item = []
                                var monthObj = {}
                                arrAll[i].forEach(function(month){
                                        monthObj[month.PRCS_FLAG] = month.num
                                })
                                for(var j=1;j< 6;j++){
                                        var num = 0
                                        if (monthObj[j]) {
                                                num = monthObj[j]
                                        }
                                        item.push(num)
                                }
                                ss.push(item)
                        }
                        // console.log(ss)
                        var one = []
                        var two = []
                        var three = []
                        var four = []
                        var five = []
                        ss.forEach(function(item, index) {
                                one.push(item[0])
                                two.push(item[1])
                                three.push(item[2])
                                four.push(item[3])
                                five.push(item[4])
                        })
                        var option1 = {
                                color: ['#FCB7B5','#FAD04D','#81C7F7','#86F793','#F4CAFA'],
                                tooltip: {
                                        trigger: 'axis',
                                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                                type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                        }
                                },
                                legend: {
                                        data: ['<fmt:message code="lang.th.will" />', '<fmt:message code="lang.th.Process" />','<fmt:message code="main.th.ToStep" />','<fmt:message code="lang.th.HaveThrough" />','<fmt:message code="workflow.th.HasBeenSuspended" />'],
                                        top:'15px'
                                },
                                grid: {
                                        left: '3%',
                                        right: '4%',
                                        bottom: '3%',
                                        containLabel: true
                                },
                                xAxis: {
                                        type: 'value',
                                },
                                /* yAxis: {
                                type: 'category',
                                data: arr,
                                },*/
                                yAxis : [
                                        {
                                                type : 'category',
                                                data : arr,
                                                show:true,
                                                axisLine:{
                                                        show:false,
                                                },
                                                axisTick:{
                                                        show:false,
                                                },
                                                splitLine:{
                                                        show:false,
                                                },
                                                axisLabel:{
                                                        interval: 0,//标签设置为全部显示
                                                        formatter:function(params){
                                                                var newParamsName = "";// 最终拼接成的字符串
                                                                var paramsNameNumber = params.length;// 实际标签的个数
                                                                var provideNumber = 12;// 每行能显示的字的个数
                                                                var rowNumber = Math.ceil(paramsNameNumber / provideNumber);// 换行的话，需要显示几行，向上取整
                                                                // 条件等同于rowNumber>1
                                                                if (paramsNameNumber > provideNumber) {
                                                                        for (var p = 0; p < rowNumber; p++) {
                                                                                var tempStr = "";// 表示每一次截取的字符串
                                                                                var start = p * provideNumber;// 开始截取的位置
                                                                                var end = start + provideNumber;// 结束截取的位置
                                                                                // 此处特殊处理最后一行的索引值
                                                                                if (p == rowNumber - 1) {
                                                                                        // 最后一次不换行
                                                                                        tempStr = params.substring(start, paramsNameNumber);
                                                                                } else {
                                                                                        // 每一次拼接字符串并换行
                                                                                        tempStr = params.substring(start, end) + "\n";
                                                                                }
                                                                                newParamsName += tempStr;// 最终拼成的字符串
                                                                        }

                                                                } else {
                                                                        // 将旧标签的值赋给新标签
                                                                        newParamsName = params;
                                                                }
                                                                //将最终的字符串返回
                                                                return newParamsName
                                                        }
                                                }
                                        }
                                ],
                                series: [
                                        {
                                                name: '<fmt:message code="lang.th.will" />',
                                                type: 'bar',
                                                stack: '<fmt:message code="flowIndex.th.totalAmount" />',
                                                label: {
                                                        show: true,
                                                        position: 'insideRight'
                                                },
                                                data: one
                                        },
                                        {
                                                name: '<fmt:message code="lang.th.Process" />',
                                                type: 'bar',
                                                stack: '<fmt:message code="flowIndex.th.totalAmount" />',
                                                label: {
                                                        show: true,
                                                        position: 'insideRight'
                                                },
                                                data: two
                                        },
                                        {
                                                name: '<fmt:message code="main.th.ToStep" />',
                                                type: 'bar',
                                                stack: '<fmt:message code="flowIndex.th.totalAmount" />',
                                                label: {
                                                        show: true,
                                                        position: 'insideRight'
                                                },
                                                data: three
                                        },
                                        {
                                                name: '<fmt:message code="lang.th.HaveThrough" />',
                                                type: 'bar',
                                                stack: '<fmt:message code="flowIndex.th.totalAmount" />',
                                                label: {
                                                        show: true,
                                                        position: 'insideRight'
                                                },
                                                data: four
                                        },
                                        {
                                                name: '<fmt:message code="workflow.th.HasBeenSuspended" />',
                                                type: 'bar',
                                                stack: '<fmt:message code="flowIndex.th.totalAmount" />',
                                                label: {
                                                        show: true,
                                                        position: 'insideRight'
                                                },
                                                data: five
                                        }
                                ]
                        };
                        // 使用刚指定的配置项和数据显示图表。
                        myChart1.setOption(option1);
                        window.addEventListener('resize',function(){
                                myChart1.resize();
                        })
                }
        })

        //待办工作跳转
        function js_methodDai(data){
                var obj = $(data).data('data')
                // console.log($(data).data('data'))
                if (obj.opFlag == 1) {
                        huiqian = 'zhuban';
                } else {
                        huiqian = 'huiqian';
                }
                if(obj.sortMainType == 'BUDGETTYPE'){
                        window.open('/workflow/work/workform?opflag=' + obj.opFlag + '&flowId=' + obj.flowRun.flowId + '&prcsId=' + obj.flowProcess.prcsId + '&tableName=budget&flowStep=' + obj.prcsId
                                + '&runId=' + obj.runId);
                }else{
                        window.open('/workflow/work/workform?opflag=' + obj.opFlag + '&flowId=' + obj.flowRun.flowId + '&prcsId=' + obj.flowProcess.prcsId + '&flowStep=' + obj.prcsId
                                + '&runId=' + obj.runId);
                }

                // if(obj.sortMainType=='BUDGETTYPE'){
                //         window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&tableName=budget&runId='+obj.runId);
                // }else{
                //         window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&runId='+obj.runId);
                // }
        }
        //办结工作跳转
        function js_method(data){
                var obj=$(data).data('data')
                // console.log($(data).data('data'))
                if(obj.sortMainType == 'BUDGETTYPE'){
                        window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&tableName=budget&runId='+obj.runId);
                }else{
                        window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&runId='+obj.runId);
                }
        }
        var userId = $.cookie('userId');
        var userName = $.cookie('userName');
        if (userName == null || userId == null) {
            $.post('/user/getNowLoginUser', {}, function (json) {
                var obj = json.object;
                if (json.flag) {
                    userName = obj.userName;
                    userId = obj.userId
                }
            })
        }
        function getNowFormatDate() {

        return new Date().Format('yyyy-MM-dd hh:mm:ss');
        }
        $('.fastItem').click(function() {
        var url = $(this).attr('url')
        var flowId = $(this).attr('opttype')
        var title1 = $(this).find('.apply').text()
        if(title1 == '<fmt:message code="workflow.th.leave" />' || title1 == '<fmt:message code="workflow.th.overtimeApplication" />' || title1 == '<fmt:message code="workflow.th.outgoingApplication" />' || title1 == '<fmt:message code="workflow.th.businessTripApplication" />'){

            $.ajax({
                type: 'get',
                url: '/flow/checkWFNewPriv',
                dataType: 'json',
                data:{
                    flowId:flowId
                },
                success:function(res){
                    var data = res.success
                    if(!data){
                        layer.msg('flowIndex.th.youDoNotHaveTheAuthorityToHandleIt！', {icon: 3});
                    }else{
                        if(url==undefined || url==''){
                            layer.msg("<fmt:message code="flowIndex.th.thereIsNoSuchProcess" />！", {
                                icon: 0,
                                offset: '45%'
                            })
                        }else{
                            layer.open({
                                type: 1,
                                title: [title1, 'background-color:#2b7fe0;color:#fff;'],
                                area: ['520px', '280px'],
                                shadeClose: true, //点击遮罩关闭
                                btn: ['<fmt:message code="attend.th.Establish" />', '<fmt:message code="license.cancel" />'],
                                content: '<div class="newsAdd" style="padding-left: 5px;">' +
                                    '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
                                    '<tr class="applicant"><td style="width: 95px;padding-left: 59px;text-align: right"><fmt:message code="sup.th.Applicant" /> ：</td><td><input type="text" class="inp" name="userName" style="width: 180px;" value="  ' + userName + '" id="leaveUser" readonly="readonly" userId="' + userId + '" ></td></tr>' +
                                    '<tr><td style="width: 95px;padding-left: 59px;text-align: right"> <fmt:message code="hr.th.RegistrationTime" /> ：</td><td><input type="text" class="inp"  style="width: 180px;" name="begainTime" id="leaveTime" class="inputTd" readonly="readonly" value="  ' + getNowFormatDate() + '" /></td></tr>' +
                                    '</table></div>',
                                yes: function (index) {
                                    var attendUrl = '';
                                    if(title1 == '<fmt:message code="workflow.th.leave" />')
                                        attendUrl = '/attendLeave/addAttendLeave';
                                    if(title1 == '<fmt:message code="workflow.th.overtimeApplication" />')
                                        attendUrl = '/attendanceOvertime/addAttendanceOvertime';
                                    if(title1 == '<fmt:message code="workflow.th.outgoingApplication" />')
                                        attendUrl = '/attendOut/addAttendOut';
                                    if(title1 == '<fmt:message code="workflow.th.businessTripApplication" />')
                                        attendUrl = '/attendEvection/addAttendEvection';

                                    $.ajax({
                                        type: 'post',
                                        url: attendUrl,
                                        dataType: 'json',
                                        async: false,
                                        data: {
                                            userId: $('#leaveUser').attr('userId'),
                                            recordTime: $('#leaveTime').val(),
                                            createDate: $('#leaveTime').val()
                                        },
                                        async: false,
                                        success: function (res) {
                                            if(title1 == '<fmt:message code="workflow.th.leave" />')
                                                $.popWindow("../workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.data.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                            if(title1 == '<fmt:message code="workflow.th.overtimeApplication" />')
                                                $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.evectionId + '&isNomalType=true', '<fmt:message code="newWork.th.Quick" />', '0', '0', '1500px', '800px');

                                            if(title1 == '<fmt:message code="workflow.th.outgoingApplication" />')
                                                $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.outId + '&isNomalType=true', '<fmt:message code="newWork.th.Quick" />', '0', '0', '1500px', '800px');

                                            if(title1 == '<fmt:message code="workflow.th.businessTripApplication" />')
                                                $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.evectionId + '&isNomalType=true', '<fmt:message code="newWork.th.Quick" />', '0', '0', '1500px', '800px');

                                        }

                                    });

                                    layer.close(index);

                                },
                            });
                        }
                    }
                }
            })

        }else{
        var url=$(this).attr('url')
        var flowId = $(this).attr('opttype')
        $.ajax({
                type: 'get',
                url: '/flow/checkWFNewPriv',
                dataType: 'json',
                data:{
                        flowId:flowId
                },
                success:function(res){
                        var data = res.success
                        if(data==false){
                                layer.msg('flowIndex.th.youDoNotHaveTheAuthorityToHandleIt！', {icon: 3});
                        }else{
                                if(url==undefined || url==''){
                                        layer.msg("<fmt:message code="flowIndex.th.thereIsNoSuchProcess" />！", {
                                                icon: 0,
                                                offset: '45%'
                                        })
                                }else{
                                        window.open(url)
                                }
                        }
                }
        })
        }



        })
</script>
</body>
</html>
