    <%--
      Created by IntelliJ IDEA.
      User: xoa
      Date: 2020-04-7
      Time: 09:31
      To change this template use File | Settings | File Templates.
    --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <html>
        <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>财务门户</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
        <link rel="stylesheet" type="text/css" href="/css/main/theme1/managementPortal.css" />
        <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
        <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="/js/echarts.min.js"></script>
        <script type="text/javascript" src="/lib/highcharts.js"></script>
            <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
        <style>
            html, body{
            font-family: "Microsoft Yahei" !important;
            }
        body{
        background: #F8F8F8;
        }
        .left1{
        width: 36%;
        background: #FFFFFF
        }
        .left1s{
        width: 60%;
        height: 8%;
        background: #FFFFFF
        }
        .right1{
        width: 65%;
        background: #ffffff;
        }
        .one ,.two ,.ones , .three ,.left1List , .left1List , .left1Item , .right1List{
        display: flex;
        }
        .item1{
        margin: 5px 10px;
        }
        .item2{
        margin-left: 50%;
        }
        .item3{
        /*margin: 5px 10px;*/
        margin: 5px 66px;
        }
        .item4{
        margin-top: 5px;
        }
        .left1Item{
        margin: 5px 10px;
        }
        .daishou li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        .yishou li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        .myshou li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        .daifa li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        .yifa li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        .myfa li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        text [x="5"]{
        font-size: 9pt;
        }
        text [x="21"]{
        font-size: 9pt;
        }
        .layui-tab-brief>.layui-tab-more li.layui-this:after, .layui-tab-brief>.layui-tab-title .layui-this:after{
        border-bottom: 2px solid #2A79D5;!important;
        }
        .layui-tab-brief>.layui-tab-title .layui-this{
        color:#2A79D5
        }
        .tds{
        width: 150px;
        text-align: center;
        }
        .tds:hover{
        background-color: #e9f0f5;
        color:#2A79D5;
        cursor:pointer;
        }
        .left1t{
        width: 36%;
        background: #FFFFFF;
        }
        .leftn{
        width: 36%;
        background: #FFFFFF;
        height: 8%;
        }
        .layui-laypage .layui-laypage-curr .layui-laypage-em{
        background-color:#2A79D5 ; !important;
        }
        </style>
        </head>
        <body>
        <div style="padding: 8px">
        <%--第一块内容--%>
        <div class="one" >
        <%--左侧第一块 图片--%>
        <div class="right1" style="width: 63%;">
        <img src="/img/financialIndex.png" style="width: 100%;height: 290px">
        </div>

        <div class="left1t" style="margin-left: 1%;height:290px ">

        <div class="titleLi">
        <img src="../../../../ui/img/vs.png" alt="">
        <span class="textLi">收支统计</span>
        </div>
        <div id="monthly" style="margin-top: 0px;height: 250px;margin-top: 10px"></div>

        </div>
        </div>

        <div class="ones" style="margin-top: 20px;">
        <%--左侧第一块 图片--%>
        <div class="left1s" style="width: 63%;">
        <%--<div style="width: 15%;height:65%;text-align: center;">--%>
        <%--<div><img src="../../../../ui/img/financial5.png" style="width:100%;height:100%"><br><p >111</p></div>--%>
        <%--</div>--%>
        <table>
        <tr class="left1s">
        <td class="tds">
        <div class="tdd" tid="550501" url="/contract/mine" onclick="parent.getMenuOpen(this)"><h2 style="display: none;">我的合同</h2><img src="../../../../ui/img/financial5.png" style="width:20%;height:30px;margin-top: 5%"><br><p style="margin-top: 4px;font-size: 13px;margin-bottom: 5%">我的合同</p></div>
        </td>
        <td class="tds">
        <div class="tdd" tid="550505" url="/contract/manager" onclick="parent.getMenuOpen(this)"><h2 style="display: none;">合同管理</h2><img src="../../../../ui/img/financial4.png" style="width:20%;height:30px;margin-top: 5%"><br><p style="margin-top: 4px;font-size: 13px;margin-bottom: 5%">合同管理</p></div>
        </td>
        <td class="tds">
        <div class="tdd" tid="550510" url="/contract/type" onclick="parent.getMenuOpen(this)"><h2 style="display: none;">合同类型</h2><img src="../../../../ui/img/financial6.png" style="width:20%;height:30px;margin-top: 5%"><br><p style="margin-top: 4px;font-size: 13px;margin-bottom: 5%">合同类型</p></div>
        </td>
        <td class="tds">
        <div class="tdd" tid="551501" url="/incomeexpense/record" onclick="parent.getMenuOpen(this)"><h2 style="display: none;">收支记录</h2><img src="../../../../ui/img/financial12%20.png" style="width:20%;height:30px;margin-top: 5%"><br><p style="margin-top: 4px;font-size: 13px;margin-bottom: 5%">收支记录</p></div>
        </td>
        <td class="tds">
        <div class="tdd" tid="551505" url="/incomeexpense/stat" onclick="parent.getMenuOpen(this)"><h2 style="display: none;">收支统计</h2><img src="../../../../ui/img/financial1.png" style="width:20%;height:30px;margin-top: 5%"><br><p style="margin-top: 4px;font-size: 13px;margin-bottom: 5%">收支统计</p></div>
        </td>
        <td class="tds">
        <div class="tdd" tid="551510" url="/incomeexpense/plan" onclick="parent.getMenuOpen(this)"><h2 style="display: none;">计划管理</h2><img src="../../../../ui/img/financial3.png" style="width:20%;height:30px;margin-top: 5%"><br><p style="margin-top: 4px;font-size: 13px;margin-bottom: 5%">计划管理</p></div>
        </td>
        </tr>
        </table>
        </div>


        <div class="leftn" style="margin-left: 1%;">
        <img src="../../../../ui/img/finals.png" style="width: 100%; height:60px;">

        </div>

        </div>

        <%--第二块内容--%>
        <div class="two" style="margin-top: 20px;">
        <%--左侧--%>
        <div style="width: 63%;background: #FFFFFF;" >
        <%--<h3 style="padding-left: 18px;margin-top:10px;font-weight: bold;">收文管理</h3>--%>
        <div class="titleLi">
        <img src="../../../../ui/img/ns.png" alt="">
        <span class="textLi">合同管理</span>
        </div>
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <div class="layui-tab-content">
        <div class="content" style="margin-top: -20px"><table class="layui-hide" id="plan" lay-filter="plan"></table></div>
        </div>
        </div>
        </div>
        <%--右侧--%>
        <div class="left1" style="margin-left: 1%;">
        <div class="titleLi">
        <img src="/img/zichan.png" alt="" style="height: 20px;width: 20px">
        <span class="textLi">合同明细</span>
        </div>
        <div id="containerHetong" style="min-width: 350px;height:260px;margin-top: 10px"></div>

        </div>
        </div>
        </div>


        </div>
        <div class="four" style="margin-top: 10px;background: #FFFFFF;">
        <div class="titleLi">
        <img src="/img/yszxbb.png" alt="" style="height: 23px;width: 23px">
        <span class="textLi">项目预算报表</span>
        </div>
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="containerls" style="width: 100%;height: 40%">

        </div>
        </div>
        </div>

        <script type="text/javascript">

        $(function () {


            layui.use('table', function(){
                    var  table = layui.table
            table.render({
            elem: '#plan'
            ,url:'/contract/selectContractAll?contractParameter=2'
            ,cols: [[
            {field:'contractNo',  title: '合同编号'}
            ,{field:'title', title: '合同标题'}
            ,{field:'typeName',  title: '合同类型'}
            ,{field:'targetName', title: '合同对象'}
            ,{field:'money', title: '合同金额'}
            ,{field:'userName', title: '跟进人'}
            ]]
            ,page: true
            });
                    // table.render({
                    // elem: '#plan'
                    // ,url:'/contract/selectContractAll'
                    // ,title: '合同管理'
                    // ,cols: [[
                    // {field:'contractNo',  title: '合同编号'}
                    // ,{field:'title', title: '合同标题'}
                    // ,{field:'typeName',  title: '合同类型'}
                    // ,{field:'targetName', title: '合同对象'}
                    // ,{field:'money', title: '合同金额'}
                    // ,{field:'userName', title: '跟进人'}
                    // ]],
                    // page:true,
                    //
                    // });

            })



        yuangongTongji('1');//员工统计初始数据

        $('.age').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').show();
        $('#containerSex').hide();
        $('#containerXueli').hide();
        $('#containerNianxian').hide();
        yuangongTongji('1');
        })
        $('.sex').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').hide();
        $('#containerSex').show();
        $('#containerXueli').hide();
        $('#containerNianxian').hide();
        yuangongTongji('2');
        })
        $('.education').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').hide();
        $('#containerSex').hide();
        $('#containerXueli').show();
        $('#containerNianxian').hide();
        yuangongTongji('3');
        })
        $('.workingLife').click(function(){
        $(this).addClass('liActive').siblings().removeClass('liActive');
        $('#containerYuangong').hide();
        $('#containerSex').hide();
        $('#containerXueli').hide();
        $('#containerNianxian').show();
        yuangongTongji('4');
        })

        var nowTime=getNowFormatDate()

        //    公告发布数统计接口
        $.ajax({
        type:'get',
        url:'/notice/selectByType',
        dataType:'json',
        success:function(res){
        var datas=res.data;
        var dataNum=[];
        for(var key in datas){
        var str=[];
        str.push(key);
        str.push(datas[key]);
        dataNum.push(str);
        }
        noteTongji(dataNum);
        }
        })
        //    新闻发布数统计接口
        $.ajax({
        type:'get',
        url:'/news/getNewCountByType',
        dataType:'json',
        success:function(res){
        var datas=res.data;
        var dataNum=[];
        for(var key in datas){
        var str=[];
        str.push(key);
        str.push(datas[key]);
        dataNum.push(str);
        }
        newsTongji(dataNum);
        }
        })
        //    合同到期员工统计
        $.ajax({
        type:'get',
        url:'/hr/contract/getMaturityContract',
        dataType:'json',
        data:{
        status:1
        },
        success:function (res) {
        var datas=res.obj;
        var str='';
        if(res.flag == true){
        if(datas.length>3){
        $('.moreDaoqi').show();
        }else {
        $('.moreDaoqi').hide();
        }
        var h = parent.document.documentElement.clientWidth;
        if(datas.length>0){
        for(var i=0;i<datas.length;i++){
        if(h >= 1673){
        if(i<3){
        str+='<li>' +
        '<div class="userInfo">'+
        '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
        '<span class="userSpan">'+
        '<p>'+datas[i].userName+'</p>'+
        '<p>'+datas[i].userPriv+'</p>'+
        '</span>'+
        '</div>' +
        '<div class="userInfo2">'+
        '<span>'+
        '<span>部门：</span><span>'+datas[i].deptName+'</span>'+
        '</span>'+
        '<span>'+
        '<span>到期时间：</span><span>'+datas[i].contractEndTime+'</span>'+
        '</span>'+
        '</div>'+
        '</li>'
        }
        }else{
        if(i<2){
        str+='<li>' +
        '<div class="userInfo">'+
        '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
        '<span class="userSpan">'+
        '<p>'+datas[i].userName+'</p>'+
        '<p>'+datas[i].userPriv+'</p>'+
        '</span>'+
        '</div>' +
        '<div class="userInfo2">'+
        '<span>'+
        '<span>部门：</span><span>'+datas[i].deptName+'</span>'+
        '</span>'+
        '<span>'+
        '<span>到期时间：</span><span>'+datas[i].contractEndTime+'</span>'+
        '</span>'+
        '</div>'+
        '</li>'
        }
        }

        }
        }else{
        str='<li class="no_notice" style="text-align: center;border: none;width: 100%;">' +
        '<img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">' +
        '<h2 style="text-align: center;color: #666;">暂无数据</h2>' +
        '</li>'
        }

        $('#hetongUl').html(str);
        }
        }
        })
        //    工作流统计
        $.ajax({
        type:'get',
        url:'/flowRun/queryFlowRunCount',
        dataType:'json',
        success:function(res){
        var data=res.datas
        if(res.flag == true){
        var arrFlow=[];
        for(var i=0;i<data.length;i++){
        var arrStr=[];
        arrStr.push(data[i].flowRunModelName);
        arrStr.push(data[i].flowRunModelPrcsCount);
        arrFlow.push(arrStr)
        }
        flowTongji(arrFlow)
        }
        }
        })
        //    员工合同统计
        // $.ajax({
        // type:'get',
        // url:'/hr/contract/getHrCountByType',
        // dataType:'json',
        // success:function (res) {
        // var datas=res.data;
        // if(res.flag == true){
        // var dataNum=[];
        // for(var key in datas){
        // var str=[];
        // str.push(key);
        // str.push(datas[key]);
        // dataNum.push(str);
        // }
        //
        //     console.log(dataNum,77777)
        // hetongTongji(dataNum)
        // }
        // }
        // })

        //合同明细
        //     $.ajax({
        //     type:'get',
        //     url:'/hr/contract/getHrCountByType',
        //     dataType:'json',
        //     success:function (res) {
        //     var datas=res.data;
        //     if(res.flag == true){
        //     var dataNum=[];
        //     for(var key in datas){
        //     var str=[];
        //     str.push(key);
        //     str.push(datas[key]);
        //     dataNum.push(str);
        //     }
        //
        //         console.log(dataNum,77777)
        //     hetongTongji(dataNum)
        //     }
        //     }
        //     })
                $.ajax({
                type:'get',
                url:'/contract/selectContractAll?page=1&limit=10',
                dataType:'json',
                success:function (res) {
                var datas=res.data;

                var dataNum=[];
                var str=[];
                for(var i = 0; i< datas.length; i++){

                dataNum.push(datas[i].title);

                str.push(datas[i].money);

            }



                hetongTongji(dataNum,str)
                }

                })






        //    员工请假统计
        $.ajax({
        type:'get',
        url:'/attendLeave/getAttendLeaveCount',
        dataType:'json',
        success:function (res) {
        var datas=res.data;
        var monthTime=[];
        var dataNum=[];
        if(res.flag == true){
        for(var i=0;i<datas.length;i++){
        monthTime.push(datas[i].monthname);
        dataNum.push(datas[i].id)
        }
        }
        }
        })
        //    新入职员工
        $.ajax({
        type:'get',
        url:'/hr/api/getHrStaffInfoNews',
        dataType:'json',
        success:function (res) {
        var data=res.datas;
        var str='';
        if(res.flag == true){
        var h = parent.document.documentElement.clientWidth;
        if(data.length>3){
        if(h >= 1673){

        }else{
        $('style').append('.insideDiv ul li{width: 47%;}.userSpan{margin-top: 40px;margin-left: 10%;}')
        }
        $('.moreXinruzhi').hide();
        }else{
        if(h >= 1673){
        $('.moreXinruzhi').hide();
        }else{
        $('style').append('.insideDiv ul li{width: 47%;}.userSpan{margin-top: 40px;margin-left: 10%;}')
        if(data.length == 3){
        $('.moreXinruzhi').hide();
        }else{
        $('.moreXinruzhi').hide();
        }
        }

        }
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        if(h >= 1673){
        if(i<3){
        str+='<li>'+
        '<div class="userInfo">'+
        '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
        '<span class="userSpan">'+
        '<p>'+data[i].userName+'</p>'+
        '<p>新入职员工</p>'+
        '</span>'+
        '</div>'+
        '<div class="userInfo2">'+
        '<span>'+
        '<span>性别：</span><span>'+function () {
        if(data[i].sex == '0'){
        return '男';
        }else if(data[i].sex == '1'){
        return '女';
        }
        }()+'</span>'+
        '</span>'+
        '<span>'+
        '<span>部门：</span><span>'+data[i].deptName+'</span>'+
        '</span>'+
        '<span>'+
        '<span>入职时间：</span><span>'+data[i].datesEmployed+'</span>'+
        '</span>'+
        '</div>'+
        '</li>';
        }
        }else{
        if(i<2){
        str+='<li>'+
        '<div class="userInfo">'+
        '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
        '<span class="userSpan">'+
        '<p>'+data[i].userName+'</p>'+
        '<p>新入职员工</p>'+
        '</span>'+
        '</div>'+
        '<div class="userInfo2">'+
        '<span>'+
        '<span>性别：</span><span>'+function () {
        if(data[i].sex == '0'){
        return '男';
        }else if(data[i].sex == '1'){
        return '女';
        }
        }()+'</span>'+
        '</span>'+
        '<span>'+
        '<span>部门：</span><span>'+data[i].deptName+'</span>'+
        '</span>'+
        '<span>'+
        '<span>入职时间：</span><span>'+data[i].datesEmployed+'</span>'+
        '</span>'+
        '</div>'+
        '</li>';
        }
        }
        }
        }else{
        str='<li class="no_notice" style="text-align: center;border: none;width: 100%;">' +
        '<img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">' +
        '<h2 style="text-align: center;color: #666;">暂无数据</h2>' +
        '</li>'
        }
        $('#xinruzhi').html(str);
        }
        }
        })
        });

        //获取当前时间，格式YYYY-MM-DD
        function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
        month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
        }
        var currentdate = year + seperator1 + month + seperator1 + strDate;
        return currentdate;
        }

        function yuangongTongji(typeNum) {
        $.ajax({
        type:'get',
        url:'/hr/api/getHrStaffInfoCount',
        dataType:'json',
        data:{
        type:typeNum
        },
        success:function(res){
        var datas=res.data;
        var dataTotal=[];
        if(res.flag == true){
        for(var key in datas){
        var str=[];
        str.push(key);
        str.push(datas[key]);
        dataTotal.push(str);
        }
        if(typeNum == '1'){
        nianlingTongji(dataTotal);
        }else if(typeNum == '2'){
        xingbieTongji(dataTotal);
        }else if(typeNum == '3'){
        xueliTongji(dataTotal);
        }else if(typeNum == '4'){
        nianxianTongji(dataTotal);
        }
        }
        }
        })
        }
        function nianlingTongji(data) {
        //员工统计(年龄)
        $('#containerYuangong').highcharts({
        chart: {
        type: 'column'
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        type: 'category',
        labels: {
        rotation: 30,
        style: {
        fontSize: '9pt',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        },
        yAxis: {
        min: 0,
        title: {
        text: ''
        }
        },
        legend: {
        enabled: false
        },
        tooltip: {
        pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '总量',
        data:data
        }]
        });
        }
        function xingbieTongji(data) {
        //员工统计(性别)
        $('#containerSex').highcharts({
        chart: {
        type: 'column'
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        type: 'category',
        labels: {
        rotation: 0,
        style: {
        fontSize: '9pt',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        },
        yAxis: {
        min: 0,
        title: {
        text: ''
        }
        },
        legend: {
        enabled: false
        },
        tooltip: {
        pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '总量',

        data:data
        }]
        });
        }
        function xueliTongji(data) {
        //员工统计(学历)
        $('#containerXueli').highcharts({
        chart: {
        type: 'column'
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        type: 'category',
        labels: {
        rotation: 30,
        style: {
        fontSize: '9pt',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        },
        yAxis: {
        min: 0,
        title: {
        text: ''
        }
        },
        legend: {
        enabled: false
        },
        tooltip: {
        pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '总量',
        data:data
        }]
        });
        }
        function nianxianTongji(data) {
        //员工统计(工作年限)
        $('#containerNianxian').highcharts({
        chart: {
        type: 'column'
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        type: 'category',
        labels: {
        rotation: 0,
        style: {
        fontSize: '9pt',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        },
        yAxis: {
        min: 0,
        title: {
        text: ''
        }
        },
        legend: {
        enabled: false
        },
        tooltip: {
        pointFormat: '人数: <b>{point.y}</b>'
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '总量',
        data:data
        }]
        });
        }
        function noteTongji(data) {
        //公告发布统计
        $('#container').highcharts({
        chart: {
        type: 'column'
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        type: 'category',
        labels: {
        rotation: 0,
        style: {
        fontSize: '13px',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        },
        yAxis: {
        min: 0,
        title: {
        text: ''
        }
        },
        legend: {
        enabled: false
        },
        tooltip: {
        pointFormat: '发布数量: <b>{point.y}</b>'
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '总量',
        data:data,
        dataLabels: {
        enabled: true,
        // rotation: -90,
        color: '#FFFFFF',
        align: 'center',
        format: '{point.y}', // one decimal
        y: 10, // 10 pixels down from the top
        style: {
        fontSize: '13px',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        }]
        });
        }
        function newsTongji(data) {
        //新闻发布统计
        $('#containerNews').highcharts({
        chart: {
        type: 'column'
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        type: 'category',
        labels: {
        rotation: 0,
        style: {
        fontSize: '13px',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        },
        yAxis: {
        min: 0,
        title: {
        text: ''
        }
        },
        legend: {
        enabled: false
        },
        tooltip: {
        pointFormat: '发布数量: <b>{point.y}</b>'
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '总量',
        data:data,
        dataLabels: {
        enabled: true,
        // rotation: -90,
        color: '#FFFFFF',
        align: 'center',
        format: '{point.y}', // one decimal
        y: 10, // 10 pixels down from the top
        style: {
        fontSize: '13px',
        fontFamily: 'Verdana, sans-serif'
        }
        }
        }]
        });
        }
        function flowTongji(data) {
        //    工作流统计
        $('#containerFlow').highcharts({
        chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false
        },
        title: {
        text: ''
        },
        colors: ['#0798d1', '#00acee', '#35c4fc', '#0176a2'],
        legend: {
        layout: 'vertical', // default
        itemDistance: 50,
        align: 'right',
        verticalAlign: 'top',
        x: 0,
        y: 50
        },
        tooltip: {
        headerFormat: '{series.name}<br>',
        pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
        pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
        enabled: true,
        format: '<b>{point.name}</b>: {point.percentage:.1f}%',
        style: {
        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
        }
        },
        showInLegend: true
        }
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        type: 'pie',
        name: '流程类型占比',
        // data: [
        //     ['已归档流程',   13],
        //     ['正在执行流程',       20],
        //     ['已办结流程',58],
        //     ['已中断流程',    9],
        // ]
        data:data
        }]
        });
        }
            //合同
            function hetongTongji(dataNum,str) {
            //合同统计
            $('#containerHetong').highcharts({
            chart: {
            type: 'column',
            },
            title: {
            text: ''
            },
            subtitle: {
            text: ''
            },
            xAxis: {
            categories:
            // '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
            dataNum ,
            crosshair: true
            },
            yAxis: {
            min: 0,
            title: {
            text: ''
            }
            },
            tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:.1f}亿元</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
            },
            plotOptions: {
            column: {
            borderWidth: 0
            }
            },
            credits: {
            enabled: false     //不显示LOGO
            },
            series: [{
            name: '合同金额',
            // data: [149.9, 171.5, 1106.4, 129.2, 144.0, 176.0, 1135.6, 1148.5, 1216.4, 194.1, 95.6, 54.4]
            data:str
            }]
            });
            }


        // function hetongTongji(data) {
        // //合同统计
        // $('#containerHetong').highcharts({
        // chart: {
        // plotBackgroundColor: null,
        // plotBorderWidth: null,
        // plotShadow: false
        // },
        // title: {
        // text: ''
        // },
        // colors: ['#f6b446', '#fed61f', '#00acee', '#f7896e','#4bcc94','#42bbd1','#5072b9'],
        // legend: {
        // layout: 'vertical', // default
        // itemDistance: 50,
        // align: 'right',
        // verticalAlign: 'top',
        // x: 0,
        // y: 50
        // },
        // tooltip: {
        // headerFormat: '{series.name}<br>',
        // pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
        // },
        // plotOptions: {
        // pie: {
        // allowPointSelect: true,
        // cursor: 'pointer',
        // dataLabels: {
        // enabled: true,
        // format: '<b>{point.name}</b>: {point.percentage:.1f} %',
        // style: {
        // color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
        // }
        // },
        // showInLegend: true
        // }
        // },
        // credits: {
        // enabled: false     //不显示LOGO
        // },
        // series: [{
        // type: 'pie',
        // name: '合同类型占比',
        // data:data
        // }]
        // });
        // }

        function qingjiaTongji(dataMonth,dataNum) {
        //    员工请假统计
        var chart = Highcharts.chart('containerQingjia', {
        chart: {
        type: 'line'
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },
        xAxis: {
        // categories: ['1月', '2月', '3月', '4月', '5月', '6月']
        categories:dataMonth
        },
        yAxis: {
        title: {
        text: ''
        }
        },
        plotOptions: {
        line: {
        dataLabels: {
        enabled: false          // 开启数据标签
        },
        enableMouseTracking: true, // 关闭鼠标跟踪，对应的提示框、点击事件会失效
        showInLegend: false
        }
        },
        credits: {
        enabled: false     //不显示LOGO
        },
        series: [{
        name: '请假',
        // data: [10, 18, 19, 25, 33, 20]
        data:dataNum
        }]
        });
        }

        //公司考勤
        function circleProgress(value,average){
        var canvas = document.getElementById("yuan");
        var context = canvas.getContext('2d');
        var _this = $(canvas),
        value= Number(value),// 当前数值
        average = Number(average),// 总数值
        color = "#80e5da",// 进度条、文字样式
        maxpercent = 100,//最大百分比,可设置
        c_width = 100,// canvas,宽度
        c_height =100;// canvas,高度
        // 判断设置当前显示颜色



        // 清空画布

        context.clearRect(0, 0, c_width, c_height);

        // 画初始圆

        context.beginPath();

        // 将起始点移到canvas中心

        context.moveTo(c_width/2+15, c_height/2+15);

        // 绘制一个中心点为（c_width/2, c_height/2），半径为c_height/2，起始点0，终止点为Math.PI * 2的 整圆

        context.arc(c_width/2+15, c_height/2+15, c_height/2+15, 0, Math.PI * 2, false);

        context.closePath();

        context.fillStyle = '#68b5fb'; //填充颜色

        context.fill();

        // 绘制内圆

        context.beginPath();

        context.strokeStyle = color;

        context.lineCap = 'square';

        context.closePath();

        context.fill();

        context.lineWidth = 8.0;//绘制内圆的线宽度



        function draw(cur){

        // 画内部空白

        context.beginPath();

        context.moveTo(24, 24);

        context.arc(c_width/2+15, c_height/2+15, c_height/2+7, 0, Math.PI * 2, true);

        context.closePath();

        context.fillStyle = 'rgba(255,255,255,1)';  // 填充内部颜色

        context.fill();

        // 画内圆

        context.beginPath();

        // 绘制一个中心点为（c_width/2, c_height/2），半径为c_height/2-5不与外圆重叠，

        // 起始点-(Math.PI/2)，终止点为((Math.PI*2)*cur)-Math.PI/2的 整圆cur为每一次绘制的距离

        context.arc(c_width/2+15, c_height/2+15, c_height/2-5, -(Math.PI / 2), ((Math.PI * 2) * cur ) - Math.PI / 2, false);

        context.stroke();

        // 在中间写字

        context.font = "10pt Arial";  // 字体大小，样式

        context.fillStyle = color;  // 颜色

        context.textAlign = 'center';  // 位置

        context.textBaseline = 'middle';

        context.moveTo(c_width/2+15, c_height/2+15);  // 文字填充位置

        context.fillText(value+'/'+average, c_width/2+15, c_height/2+5);

        context.stroke();

        context.fillStyle = '#666';

        context.fillText("出勤人员", c_width/2+15, c_height/2+25);

        }

        // 调用定时器实现动态效果

        var timer=null,n=0;

        function loadCanvas(nowT){

        timer = setInterval(function(){

        if(n>nowT){

        clearInterval(timer);

        }else{

        draw(n);

        n += 0.01;

        }

        },15);

        }

        loadCanvas((value/average));

        timer=null;

        };

        function progress_show (id,goal,raised,barColor) {
        $(id).jQMeter({
        goal:goal,
        raised:raised,
        width:'100%',
        height:'10px',
        bgColor:'#eeeeee',
        barColor:barColor,
        displayTotal:false
        });
        }
        function timers() {
        var timer=setTimeout(function () {
        location.reload();
        },100);
        }


        function undefindData(data) {
        if (data == undefined) {
        return '';
        } else {
        return data;
        }
        }
        var ajaxPage = {
        data: {
        page: 1,//当前处于第几页
        pageSize: 5,//一页显示几条
        useFlag: true,
        },
        init: function () {
        },
        page: function () {
        var me = this;
        $.ajax({
        type: 'get',
        url: '/budget/selStatistics',
        dataType: 'json',
        data: me.data,
        success: function (res) {
            if(!res.flag){
                return
            }
        // 图标信息
        if(res.object.length>0){
        if(res.object.length>=50){
        $('#containerls').css('height','380%')
        }else if(res.object.length<50 && res.object.length>=40){
        $('#containerls').css('height','300%')
        }else if(res.object.length<40 && res.object.length>=30){
        $('#containerls').css('height','250%')
        }else if(res.object.length<30 && res.object.length>=20){
        $('#containerls').css('height','200%')
        }else if(res.object.length<20 && res.object.length>=10){
        $('#containerls').css('height','150%')
        }else if(res.object.length<10 && res.object.length>=5){
        $('#containerls').css('height','100%')
        }else if(res.object.length<5){
        $('#containerls').css('height','50%')
        }
        var arr1 = [] //预算金额
        var arr2 = [] //
        var arr3 = []
        var arr4 = [] //项目名
        var arr6 = []
        var arr7=[]
        var arr8=[];//预支出金额
        var str=""

        for(var i=0,length=res.object.length;i<length;i++){
        var datas1 = {}
        var datas2 = {}
        var datas3 = {}
        var datas4 = {}
        var datas5={}
        var item =  res.object[i];
        datas1.y = parseFloat(item.itemMoney);
        datas1.id = item.budgetId
        datas2.y = parseFloat(item.actualExpenditure)
        datas2.id = item.budgetId
        datas3.y =parseFloat(item.isPayment)
        datas4.y = parseFloat(item.allAdvance)
        datas4.id = item.budgetId
        datas5.y = Number(((datas3.y)-(datas4.y)).toFixed(2))
        datas5.id = item.budgetId
        // console.log(datas5)


        datas3.id = item.budgetId
        arr1.push(datas1)//预算金额
        arr2.push(datas2)//支出金额
        arr3.push(datas3)//可用金额
        arr8.push(datas4)

        arr4.push(item.budgetItemName)//项目名称
        arr6.push(undefindData((Math.round(item.actualExpenditure / item.itemMoney * 10000) / 100.00)))//支出百分比
        arr7.push(item.budgetId)
        str+='<tr> ' +
        '<td><span style="color:rgb(43, 127, 224);cursor:pointer"  class="itemPro" title="'+item.budgetItemName+'" id="'+item.budgetId+'">'+item.budgetItemName+'</span></td> ' +
        '<td>'+item.itemMoney+'</td> ' +
        '<td>'+item.isPayment+'</td> ' +
        '<td>'+undefindData(item.allAdvance)+'</td> ' +
        '<td>'+item.actualExpenditure+'</td> ' +
        '<td style="text-align: left"><div style="width:70%;height:12px;display:inline-block;border-radius: 5px;background: #e0e0e0"><span style="height:12px;display: inline-block;float:left;border-radius: 5px;background: #1ea0fa;width:'+function(){
        return undefindData((Math.round(item.actualExpenditure / item.itemMoney * 10000) / 100.00 + "%"));
        }()+'"></span></div><div style="display:inline-block">'+function(){
        return undefindData((Math.round(item.actualExpenditure / item.itemMoney * 10000) / 100.00 + "%"));

        }()+'</div></td> ' +
        '<td><a href="javascript:;" class="detail" id="'+item.budgetId+'">支出详情</a></td> ' +
        '</tr>'
        }
        $('.list').html(str)
        //                        $('.btnss').css('display','block');
        //                         console.log(arr1)

        bar(arr4,arr1,arr2,arr3,arr6,arr8,'bar')

        }else{
        $('#containerls').html('');
        //                        $('.btnss').css('display','none');
        // $.layerMsg({content:'暂无数据',icon:6})
        }
        }

        })

        },

        }
        ajaxPage.page();

        function bar(arr4,arr1,arr2,arr3,arr6,arr8,type) {
        Highcharts.chart('containerls', {
        chart: {
        type: type,
        },
        credits: {
        enabled: false
        },
        title: {
        text: ''
        },
        subtitle: {
        text: ''
        },

        xAxis: {
        categories: arr4,
        title: {
        text: '项目名称'
        },

        labels: {
        maxStaggerLines:1,
        style: {
        y:20,
        fontSize:'12px',  //字体
        width:'30',
        display:'inline-block',
        overflow:'hidden',
        whiteSpace:'nowrap',
        textOverflow:'ellipsis'
        },
        formatter:function(){
        var val = this.value;
        if(val.length>6){
        val = val.substring(0,6)+'...'
        }else{
        val = val;
        }
        return val;
        }
        },

        crosshair: true
        },
        yAxis: {
        min: 0,
        title: {
        text: '金额',
        align: 'high'
        },
        labels: {
        overflow: 'justify'
        }
        },
        legend: {
        layout: 'horizontal',
        align: 'center',
        verticalAlign: 'top',
        x: 0,
        y: -15,
        floating: true,
        },


        tooltip: {

        headerFormat: '<span style="font-size:10px">{point.key}</span><br/>',
        pointFormatter:function(){
        if(this.series.name == '支出百分比'){
        return '<div><span style="color: '+ this.series.color + '">'+
        this.series.name+':</span>  <b>'+ this.y +'%</b><br/></div>'
        } else{
        return '<div><span style="color: '+ this.series.color + '">'+
        this.series.name+':</span>  <b>'+ this.y +'</b><br/></div>'
        }

        },

        shared: true,
        useHTML: true
        },
        exporting : {

        buttons: {
        title:"",
        contextButton: {

        enabled: false,
        },


        //                     symbolX: 0,
        //                     symbolY: -10,
        exportButton: {
        //                         align:'center',
        x:5,
        y:-15,
        text: '下载',// 修改文案
        // Use only the download related menu items from the default
        // context button

        menuItems: [
        'downloadPNG',// 这里会默认显示英文，我们可以修改JS中的源码来改成简体汉字，见下面
        'downloadJPEG',
        'downloadPDF',
        ]
        },
        printButton: {
        x:-30,
        y:-15,
        text: '打印',// 修改文案,
        onmouseover:function(){
        // console.log(this)
        },
        onclick: function () {

        this.print();
        }
        }
        }
        },
        plotOptions: {
        bar: {
        //                    pointPadding: 0.2,
        //                    borderWidth: 0,
        //                    pointWidth: 7,
        dataLabels: {
        enabled: true,
        //                        allowOverlap: true // 允许数据标签重叠
        },
        showInLegend: true,
        events: {
        click: function(e) {
        var id = e.point.options.id;
        layer.open({
        type:2,
        area: ['90%', '80%'],
        fix: false, //不固定
        //                                maxmin: true,
        content: '/budget/newjournal?type=3&budgetId='+id,
        })
        }
        }
        }

        },
        series:[

        {
        name: '预算金额',
        type: type,
        data: arr1,
        color:'#54c7fc'
        },
        {
        name: '可用金额',
        type: type,
        data: arr3,
        color:'#ff7466'
        },
        {
        name: '预支出金额',
        type: type,
        data: arr8,
        color:'pink'
        },
        {
        name: '支出金额',
        type: type,
        data: arr2,
        color:'#ffb54d'
        },

        {
        name: '支出百分比',
        type: type,
        data: arr6,
        color:'#44db5e'
        }
        ]

        });
        }


            $.ajax({
            type:'get',
            url:'/IncomeType/incomYearCount',
            dataType:'json',
            success:function (res) {
            var datas=res.obj;

            var dataNum=[]; //支出
            var str=[];    //收入
            var strs=[]
            for(var i = 0; i< datas.length; i++){

            dataNum.push(datas[i].expenseRecord);

            str.push(datas[i].inComeRecord);

            }
            shouzhi(dataNum,str)


            }

            })

            function shouzhi(dataNum,str) {
            var chart = Highcharts.chart('monthly', {
            title: {
            text: ''
            },
            subtitle: {
            text: ''
            },
            credits: {
            enabled: false
            },
            xAxis: {
            categories:[2016,2017,2018,2019,2020],

            crosshair: true
            },
            yAxis: {
            title: {
            text: '金额'
            },
            labels: {
            formatter: function () {
            return this.value + '元';
            }
            }
            },
            legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
            },
            plotOptions: {
            series: {
            label: {
            connectorAllowed: false
            },
            // pointStart: 2014
            }
            },
            series: [{
            name: '收入',
            data: str
            }, {
            name: '支出',
            data: dataNum
            }],
            responsive: {
            rules: [{
            condition: {
            maxWidth: 500
            },
            chartOptions: {
            legend: {
            layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom'
            }
            }
            }]
            }
            });
            }

        </script>
        </body>
        </html>
