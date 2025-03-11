<%--
  Created by IntelliJ IDEA.
  User: rongchenglu
  Date: 2020/4/3
  Time: 13:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>营销门户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <script type="text/javascript" src="/lib/highcharts.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            user-select: none;
            font-family: "Microsoft Yahei" !important;
        }

        .container {
            position: relative;
            padding: 10px;
            width: 100%;
            height: 100%;
            background-color: #f8f8f8;
            box-sizing: border-box;
            overflow: hidden;
            min-width: 1215px;
        }

        .content {
            position: relative;
            width: 100%;
            height: 100%;
            padding-right: 15px;
            background-color: #f8f8f8;
            overflow-y: auto;
            overflow-x: hidden;
            box-sizing: border-box;
        }

        img {
            width: 100%;
            /*height: 100%*/
        }

        .con_box {
            margin-bottom: 15px;
        }

        .con_left {
            padding-right: 5px;
        }

        .con_right {
            padding-left: 5px;
        }

        .con_item {
            padding: 6px 0;
            background-color: #fff;
        }

        .icon {
            display: inline-block;
            background-position: 0 0;
            background-repeat: no-repeat;
            background-size: cover;
        }

        .con_item_title {
            display: inline-block;
            height: 28px;
            line-height: 28px;
            font-size: 15px;
            margin-top: 5px;
        }

        .title_icon {
            width: 24px;
            height: 24px;
            vertical-align: top;
            margin-top: 2px;
            margin-right: 10px;
            background-image: url('/img/main_img/menu/market/title-icon.png');
        }

        .content_one .con_item {
            height: 212px;
        }

        .statistic_item {
            height: 77px;
            padding: 15px 0 0 10px;
        }

        .statistic_icon {
            float: left;
            width: 36px;
            height: 36px;
            margin-right: 10px;
        }

        .order_icon {
            background-image: url('/img/main_img/menu/market/dingdan.png');
        }

        .product_icon {
            background-image: url('/img/main_img/menu/market/chanpin.png');
        }

        .supplier_icon {
            background-image: url('/img/main_img/menu/market/gongying.png');
        }

        .contract_icon {
            background-image: url('/img/main_img/menu/market/hetong.png');
        }

        .statistic_num {
            font-size: 20px;
            font-weight: 500;
        }

        thead {
            border-bottom: 1px solid rgb(233, 233, 233);
        }

        thead th {
            text-align: left;
            font-weight: 500;
            padding: 5px 10px;
            font-size: 15px;
        }

        tbody tr {
            cursor: pointer;
        }

        tbody tr:hover {
            background-color: #e8f4fc;
        }

        tbody tr:hover td {
            color: rgb(77, 76, 76) !important;
        }

        tbody td {
            text-align: left;
            font-weight: 400;
            font-size: 14px;
            padding: 5px 10px;
            color: rgb(123, 122, 122);
            font-family: 微软雅黑 !important;
        }

        .cover_scroll {
            position: absolute;
            top: 0;
            right: 10px;
            height: 100%;
            width: 25px;
            z-index: 1;
            background-color: #fff;
        }

        .tab_item {
            height: 260px;
            overflow: hidden;
        }

        .con_heat_tool {
            float: right;
            outline: none;
        }

        .con_heat_tool .layui-form-item{
            margin-bottom: 0;
        }

        .con_heat_tool .layui-form-item .layui-inline {
            margin: 0;
        }

        .con_heat_tool .layui-form-item .layui-input-inline {
            margin-right: 0;
        }

        .con_heat_tool .layui-form-item .layui-form-label {
            width: auto;
        }
    .layui-tab-brief>.layui-tab-more li.layui-this:after, .layui-tab-brief>.layui-tab-title .layui-this:after{
    border-bottom: 2px solid #1296DB;!important;
    }
    .layui-tab-brief>.layui-tab-title .layui-this{
    color:#1296DB
    }

    </style>
</head>

<body>
    <div class="container">
        <div class="content">
            <div class="con_box content_one">
                <div class="layui-fluid" style="padding: 0">
                    <div class="layui-row">
                        <div class="layui-col-xs8 con_left">
                            <div class="con_item" style="padding: 6px;">
                                <img alt="" src="/img/main_img/menu/market/crm02.jpg" style="height: 212px;object-fit: cover;">
                            </div>
                        </div>
                        <div class="layui-col-xs4 con_right">
                            <div class="con_item">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        <h4 class="con_item_title">
                                            <i class="icon title_icon"></i>
                                            CRM数据统计
                                        </h4>
                                    </div>
                                    <div class="layui-card-body">
                                        <div class="layui-row">
                                            <div class="layui-col-xs6 statistic_item" style="border-right: 1px dashed #ccc;border-bottom: 1px dashed #ccc;color: #56ab02;">
                                                <i class="icon statistic_icon order_icon"></i>
                                                <div>
                                                    <p><span class="statistic_num order_num">0</span></p>
                                                    <p>订单数量</p>
                                                </div>
                                            </div>
                                            <div class="layui-col-xs6 statistic_item" style="border-bottom: 1px dashed #ccc; color: #4891ff;">
                                                <i class="icon statistic_icon product_icon"></i>
                                                <div>
                                                    <p><span class="statistic_num product_num">0</span></p>
                                                    <p>产品数量</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-row">
                                            <div class="layui-col-xs6 statistic_item" style="border-right: 1px dashed #ccc; color: #869fac;">
                                                <i class="icon statistic_icon supplier_icon"></i>
                                                <div>
                                                    <p><span class="statistic_num supplier_num">0</span> </p>
                                                    <p>供应商数量</p>
                                                </div>
                                            </div>
                                            <div class="layui-col-xs6 statistic_item" style="color: #6cad53;">
                                                <i class="icon statistic_icon contract_icon"></i>
                                                <div>
                                                    <p><span class="statistic_num contract_num">0</span></p>
                                                    <p>客户合同数量</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="con_box content_two">
                <div class="layui-fluid" style="padding: 0">
                    <div class="layui-row">
                        <div class="layui-col-xs8 con_left">
                            <div class="con_item" style="padding: 6px;">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        <h4 class="con_item_title">
                                            <i class="icon title_icon"></i>
                                            CRM销售工作台
                                        </h4>
                                    </div>
                                    <div class="layui-card-body" style="height: 280px;overflow: hidden;position: relative;">
                                        <div class="cover_scroll"></div>
                                        <div style="height: 100%;width: 100%;overflow-y: auto;overflow-x: hidden;">
                                            <table id="salesDesk" style="width: 100%;text-align: left;">
                                                <thead id="salesDeskBodys">
                                                    <th>客户名称</th>
                                                    <th>客户经理</th>
                                                    <th>客户级别</th>
                                                    <th>客户状态</th>
                                                    <th>客户来源</th>
                                                </thead>
                                                <tbody id="salesDeskBody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4 con_right">
                            <div class="con_item">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        <h4 class="con_item_title">
                                            <i class="icon title_icon"></i>
                                            员工销售统计
                                        </h4>
                                    </div>
                                    <div class="layui-card-body">
                                        <div id="main" style="width: 100%;height: 280px;display: none"></div>
                                        <div id="containers" style="width: 100%;height: 280px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="con_box content_three">
                <div class="layui-fluid" style="padding: 0">
                    <div class="layui-row">
                        <div class="layui-col-xs8 con_left">
                            <div class="con_item" style="padding: 6px;">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        <h4 class="con_item_title">
                                            <i class="icon title_icon"></i>
                                            进销存销售列表
                                        </h4>

                                    </div>
                                    <div class="layui-card-body" style="overflow: hidden;position: relative;">
                                        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                                            <ul class="layui-tab-title">
                                                <li class="layui-this">月销售</li>
                                                <li>日销售</li>
                                                <li>员工销售</li>
                                                <li>客户销售</li>
                                                <li>客户欠款</li>
                                                <li>供货商欠款</li>
                                            </ul>
                                            <div class="layui-tab-content" style="position: relative;">
                                                <div class="layui-tab-item layui-show tab_item">
                                                    <div style="height: 100%;width: 100%;overflow-y: auto;overflow-x: hidden;">
                                                        <table id="monthSales" style="width: 100%;text-align: left;">
                                                            <thead>
                                                                <tr id="monthSaless">
                                                                    <th>月份</th>
                                                                    <th>实际销售金额</th>
                                                                    <th>销售出货金额</th>
                                                                    <th>销售退货金额</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="layui-tab-item tab_item">
                                                    <div style="height: 100%;width: 100%;overflow-y: auto;overflow-x: hidden;">
                                                        <table id="daysSales" style="width: 100%;text-align: left;">
                                                            <thead>
                                                                <tr id="daysSaless">
                                                                    <th>日</th>
                                                                    <th>实际销售金额</th>
                                                                    <th>销售出货金额</th>
                                                                    <th>销售退货金额</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="layui-tab-item tab_item">
                                                    <div class="Data" style="height: 100%;width: 100%;overflow-y: auto;overflow-x: hidden;">
                                                        <table id="employeeData" style="width: 100%;text-align: left;">
                                                            <thead id="employeeDatas">
                                                                <tr>
                                                                    <th>员工</th>
                                                                    <th>销售金额</th>
                                                                    <th>所占百分比</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>

                                                            </tbody>
                                                        </table>
                                                    </div>



                                                </div>
                                                <div class="layui-tab-item tab_item">
                                                    <div style="height: 100%;width: 100%;overflow-y: auto;overflow-x: hidden;">
                                                        <table id="customerData" style="width: 100%;text-align: left;">
                                                            <thead>
                                                                <tr id="customerDatas">
                                                                    <th>客户</th>
                                                                    <th>销售金额</th>
                                                                    <th>所占百分比</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="layui-tab-item tab_item">
                                                    <div style="height: 100%;width: 100%;overflow-y: auto;overflow-x: hidden;">
                                                        <table id="customerArrearsData" style="width: 100%;text-align: left;">
                                                            <thead>
                                                                <tr id="customerArrearsDatas">
                                                                    <th>客户</th>
                                                                    <th>已付金额</th>
                                                                    <th>欠款金额</th>
                                                                    <th>合计</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="layui-tab-item tab_item">
                                                    <div style="height: 100%;width: 100%;overflow-y: auto;overflow-x: hidden;">
                                                        <table id="supplyArrearsData" style="width: 100%;text-align: left;">
                                                            <thead>
                                                                <tr id="supplyArrearsDatas">
                                                                    <th>供应商</th>
                                                                    <th>已付金额</th>
                                                                    <th>欠款金额</th>
                                                                    <th>合计</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div class="cover_scroll"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4 con_right">
                            <div class="con_item">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        <h4 class="con_item_title">
                                            <i class="icon title_icon"></i>
                                            进销存销售统计
                                        </h4>
                                    </div>
                                    <div class="layui-card-body">
                                        <div id="salesPic" style="width: 100%; height: 321px;display: none"></div>
                                        <div id="histogram" style="width: 100%; height: 321px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var initData = {
            monthData: function() { // 月销售数据
                var str = ''

                 $.ajax({
                     type:'get',
                     url:'/salesShipment/shipCount',
                     dataType:'json',
                     success:function (res) {
                     var datas=res.object;
                        if(datas.length>0){
                        for(var i = 0; i< datas.length; i++){
                        str += '<tr><td>'+datas[i].returnMonth+'</td><td>'+datas[i].realPrice+'</td><td>'+datas[i].saleShipPrice+'</td><td>'+datas[i].saleReturnPrice+'</td></tr>'
                        }
                        }else{
                        $('#monthSaless').hide();
                        str = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                        '<img src="/img/main_img/shouyekong.png" alt="">' +
                        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                        '</div>';
                        }

                     $('#monthSales tbody').html(str)
                     }

                })
            },
            daysData: function(){ // 模拟生成日销售数据
                var str = ''
                         $.ajax({
                         type:'get',
                         url:'/salesShipment/shipDayCount',
                         dataType:'json',
                         success:function (res) {
                         var datas=res.object;
                         if(datas.length>0){
                         for(var i = 0; i< datas.length; i++){
                         str += '<tr><td>'+datas[i].returnMonth+'</td><td>'+datas[i].realPrice+'</td><td>'+datas[i].saleShipPrice+'</td><td>'+datas[i].saleReturnPrice+'</td></tr>'
                         }
                         }else{
                         $('#daysSaless').hide();
                         str = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                         '<img src="/img/main_img/shouyekong.png" alt="">' +
                         '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                         '</div>';
                         }

                        $('#daysSales tbody').html(str)
                         }
                         })
            },
            employeeData: function() {
                        var str = ''
                             $.ajax({
                             type:'get',
                             url:'/salesShipment/shipEmployeeCount',
                                data:{
                                 flag:1
                                },
                             dataType:'json',
                             success:function (res) {
                             var datas=res.object;
                                if(datas.length>0){
                                 for(var i = 0; i< datas.length; i++){
                                 str += '<tr><td>'+datas[i].userName+'</td><td>'+datas[i].sumShipMent+'</td><td>'+datas[i].saleShipper+'</td></tr>'
                                 }

                                }else{
                                $('#employeeDatas').hide();
                                str = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                                '<img src="/img/main_img/shouyekong.png" alt="">' +
                                '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                                '</div>';
                                }
                                $('#employeeData tbody').html(str)
                             }
                             })

            },
            customerData: function() {
                     var str = ''
                     $.ajax({
                        type:'get',
                        url:'/salesShipment/shipCustomerCount',
                        data:{
                        flag:1
                        },
                        dataType:'json',
                        success:function (res) {
                        var datas=res.object;
                        if(datas.length>0){
                        for(var i = 0; i< datas.length; i++){
                        str += '<tr><td>'+datas[i].userName+'</td><td>'+datas[i].sumShipMent+'</td><td>'+datas[i].saleShipper+'</td></tr>'
                        }
                        }else{
                         $('#customerDatas').hide();
                         str = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                         '<img src="/img/main_img/shouyekong.png" alt="">' +
                         '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                         '</div>';
                         }

                        $('#customerData tbody').html(str)
                        }
                        })

                    },
            customerArrearsData: function() {
                 var str = ''
                    $.ajax({
                    type:'get',
                    url:'/salesShipment/selectAllSales',
                    data:{
                    isArrears:1
                    },
                    dataType:'json',
                    success:function (res) {
                    var datas=res.obj;
                    if(datas.length>0){
                    for(var i = 0; i< datas.length; i++){
                    str += '<tr><td>'+datas[i].customerName+'</td><td>'+datas[i].shipmentPaid+'</td><td>'+datas[i].shipmentArrears+'</td><td>'+datas[i].shipmentTotal+'</td></tr>'
                    }
                    }else{
                    $('#customerArrearsDatas').hide();
                    str = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                    '<img src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                    }

                    $('#customerArrearsData tbody').html(str)
                    }
                    })


            },
            supplyArrearsData: function() {
                        var str = ''
                        $.ajax({
                        type:'get',
                        url:'/poCommodityEnter/selectProductInfo',
                        data:{
                        isArrears:1
                        },
                        dataType:'json',
                        success:function (res) {
                        var datas=res.obj;
                        if(datas.length>0){
                        for(var i = 0; i< datas.length; i++){
                        str += '<tr><td>'+datas[i].supplierName+'</td><td>'+datas[i].enterPaid+'</td><td>'+datas[i].enterArrears+'</td><td>'+datas[i].enterTotal+'</td></tr>'
                        }
                        }else{
                        $('#supplyArrearsDatas').hide();
                        str = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                        '<img src="/img/main_img/shouyekong.png" alt="">' +
                        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                        '</div>';
                        }
                        $('#supplyArrearsData tbody').html(str)
                        }
                        })
                                }
                 }


        $(function () {
    var globalData = {};
    var realPrice  //实际销售金额
    var saleShipPrice//销售出货金额
    var saleReturnPrice//销售退货金额
    $.ajax({
    url:'/salesShipment/shipCount',
    type: 'get',
    dataType: "JSON",
    success:function (res) {
    realPrice =[] //实际销售金额
    saleShipPrice =[]//销售出货金额
    saleReturnPrice =[] //销售退货金额
    var mon = res.object
    for(var i=0;i<mon.length;i++){
    realPrice.push(mon[i].realPrice)
    saleShipPrice.push(mon[i].saleShipPrice)
    saleReturnPrice.push(mon[i].saleReturnPrice)
    }
    //月的柱状图
    var chart = Highcharts.chart('histogram',{
    chart: {
    type: 'column'
    },
    title: {
    text: ''
    },
    colors: ['#7CB5EC', '#90ED7D', '#8085E9'],
    xAxis: {
    categories: [
    '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
    ],
    crosshair: true
    },
    yAxis: {
    min: 0,
    title: {
    text: '金额'
    }
    },
    tooltip: {
    // head + 每个 point + footer 拼接成完整的 table
    headerFormat: '<span style="font-size:7px">{point.key}</span><table style="width: 160px;height: 20px">',
    pointFormat: '<tr><td style="color:{series.color};padding:0;">{series.name}: </td>' +
    '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
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
    enabled: false
    },
    series: [{
    name: '实际销售金额',
    data: realPrice
    }, {
    name: '销售出货金额',
    data: saleShipPrice
    }, {
    name: '销售退货金额',
    data: saleReturnPrice
    }]
    });

    }
    })

    
    //员工销售

    $.ajax({
    type:'get',
    url:'/salesShipment/shipEmployeeCount',
    data:{
    flag:1
    },
    dataType:'json',
    success:function (res) {
    var datas=res.object;

    var dataNum=[]; //名称
    var strs=[]; //金额
    for(var i = 0; i< datas.length; i++){

    dataNum.push(datas[i].userName);

    strs.push(parseInt(datas[i].sumShipMent));

    }
    hetongTongji(dataNum,strs)
    }
    })
    function hetongTongji(dataNum,strs) {
    var chart = Highcharts.chart('containers', {
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
    categories:dataNum,

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

    }
    },
    series: [{
    name: '销售金额',
    data: strs
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



            // 获取订单管理数据
            $.get('/order/insearchOrder',  { useFlag: false }, function(res) {
                if (res.flag) {
                    $('.order_num').text(res.obj.length);
                }
            });

            // 获取产品管理数据
            $.get('/product/selectByConditionProduct',  { useFlag: false }, function(res) {
                if (res.flag) {
                    $('.product_num').text(res.obj.length);
                }
            });

            // 获取供应商管理数据
            $.get('/supplier/selectByCount',  { useFlag: false }, function(res) {
                if (res.flag) {
                    $('.supplier_num').text(res.obj.length);
                }
            });

            // 获取客户合同管理数据
            $.get('/crmContract/selectCrmContract',  { useFlag:false,flag:0 }, function(res) {
                if (res.flag) {
                    $('.contract_num').text(res.datas.length);
                }
            });

            var myChart = echarts.init(document.getElementById('main'));
            var myChart2 = echarts.init(document.getElementById('salesPic'));

            // 获取销售工作台数据
            $.get('/customer/potentialCustomer', { useFlag: false }, function (res) {

                if (res.flag && res.obj.length > 0) {
                    var str = '';
                    res.obj.forEach(function (item) {
                        str += '<tr><td>' + (item.customerName ? item.customerName : '') + '</td>' +
                        '<td>' + (item.customerManager ? item.customerManager : '') + '</td>' +
                        '<td>' + (function () {
                            switch (item.customerLevel) {
                                case '01':
                                    return "A(重要客户)";
                                    break;
                                case '02':
                                    return "B(普通客户)";
                                    break;
                                case '03':
                                    return "C(一般客户)";
                                    break;
                                case '04':
                                    return "D(不重要客户)";
                                    break;
                                default:
                                    return "";
                                    break;
                            }
                        })() + '</td>' +
                        '<td>' + (function () {
                            switch (item.customerStatus) {
                                case '01':
                                    return "初步接触";
                                    break;
                                case '02':
                                    return "客户拜访";
                                    break;
                                case '03':
                                    return "需求沟通";
                                    break;
                                case '04':
                                    return "方案报价";
                                    break;
                                case '05':
                                    return "商务谈判";
                                    break;
                                case '06':
                                    return "签约成功";
                                    break;
                                default:
                                    return "";
                                    break;
                            }
                        })() + '</td>' +
                        '<td>' + (function () {
                            switch (item.customerFrom) {
                                case '01':
                                    return "广告推广";
                                    break;
                                case '02':
                                    return "会议营销";
                                    break;
                                case '03':
                                    return "客户介绍";
                                    break;
                                case '04':
                                    return "网上搜索";
                                    break;
                                case '05':
                                    return "渠道拓展";
                                    break;
                                case '06':
                                    return "伙伴介绍";
                                    break;
                                case '07':
                                    return "独立开发";
                                    break;
                                case '08':
                                    return "社群营销";
                                    break;
                                default:
                                    return "";
                                    break;
                            }
                        })() + '</td>' +
                        '</tr>'
                    });

                }else{
                 $('#salesDeskBodys').hide();
                 str = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                 '<img src="/img/main_img/shouyekong.png" alt="">' +
                 '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                 '</div>';
                 }
            $('#salesDeskBody').html(str);
                // var option = {
                //     xAxis: {
                //         type: 'category',
                //         data: ['第一季度', '第二季度', '第三季度', '第四季度']
                //     },
                //     yAxis: {
                //         type: 'value'
                //     },
                //     series: [{
                //         data: initLineData(res.obj),
                //         type: 'line'
                //     }]
                // }

                // myChart.setOption(option);

            });
    
            var t = setTimeout(function(){
                globalData['monthData'] = initData.monthData(7, 5)
                // initPie(myChart2, globalData['monthData']);
                clearTimeout(t)
            }, 100);

            layui.use(['layer', 'laydate', 'element', 'form'], function () {
                var layer = layui.layer,
                    laydate = layui.laydate,
                    element = layui.element,
                    form = layui.form;
                form.render();
                
                //切换tab事件
                element.on('tab(docDemoTabBrief)', function (data) {
                    switch (data.index) {
                        case 0:
                            if (!globalData.monthData) {
                                var t = setTimeout(function(){
                                    globalData['monthData'] = initData.monthData(7, 5)
                                    // initPie(myChart2, globalData['monthData']);
                                    clearTimeout(t)
                                }, 100);
                            } else {
                                // initPie(myChart2, globalData.monthData)
                            }
                            break;
                        case 1:
                            if (!globalData.daysData) {
                                var t = setTimeout(function(){
                                    globalData['daysData'] = initData.daysData(7, 3)
                                    // initPie(myChart2, globalData['daysData']);
                                    clearTimeout(t)
                                }, 100);
                            } else {
                                // initPie(myChart2, globalData.daysData)
                            }
                            break;
                        case 2:
                            if (!globalData.employeeData) {
                                initData.employeeData(myChart2,7, 4)
                            } else {
                                // initPie(myChart2, globalData.employeeData)
                            }
                            break;
                        case 3:
                            if (!globalData.customerData) {
                                initData.customerData(myChart2,7, 4)
                            } else {
                                // initPie(myChart2, globalData.customerData)
                            }
                            break;
                        case 4:
                            if (!globalData.customerArrearsData) {
                                initData.customerArrearsData(myChart2,7, 4)
                            } else {
                                // initPie(myChart2, globalData.customerArrearsData)
                            }
                            break;
                        case 5:
                            if (!globalData.supplyArrearsData) {
                                initData.supplyArrearsData(myChart2,7, 4)
                            } else {
                                // initPie(myChart2, globalData.supplyArrearsData)
                            }
                            break;
                    }
                });
            });
        });
        
        // 初始化折线图数据
        // function initLineData(data) {
        //     var arr = [0, 0, 0, 0];
        //     if (data && data.length > 0) {
        //         data.forEach(function (item) {
        //             var month = new Date(item.createdTime.replace(/-/g, "/")).getMonth() + 1;
        //             if (month >= 1 || month <= 3) {
        //                 arr[0]++;
        //             } else if (month <= 6) {
        //                 arr[1]++;
        //             } else if (month <= 9) {
        //                 arr[2]++;
        //             } else if (month <= 12) {
        //                 arr[3]++;
        //             }
        //         });
        //     }
        //     return arr;
        // }
        
        // 初始化饼状图
        // function initPie(myChart, charData) {
        //     var option2 = {
        //         // color: ['#66CCFF','#B6ED13'],
        //         title: {
        //             text: charData.title,
        //             top: '10px',
        //             left: 'center'
        //         },
        //         left: 'right',
        //         //提示框组件,鼠标移动上去显示的提示内容
        //         tooltip: {
        //             // show:false,
        //             trigger: 'item',
        //             formatter: "{a} <br/>{b}: {c} ({d}%)" //模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。
        //         },
        //         //图例
        //         legend: {
        //             type: 'scroll',
        //             orient: 'vertical',
        //             right: 10,
        //             top: 20,
        //             bottom: 20,
        //             data: charData.legendData, //data中的名字要与series-data中的列名对应，方可点击操控
        //             selected: charData.selected
        //         },
        //
        //         series: [{
        //             name: charData.seriesName,
        //             type: 'pie',
        //             //饼状图
        //             avoidLabelOverlap: false,
        //             radius: '50%',
        //             center: ['40%', '50%'],
        //             //标签
        //             label: {
        //                 normal: {
        //                     show: true,
        //                     formatter: '{d}%', //模板变量有 {a}、{b}、{c}、{d}，分别表示系列名，数据名，数据值，百分比。{d}数据会根据value值计算百分比
        //                     textStyle: {
        //                         align: 'center',
        //                         baseline: 'middle',
        //                         fontFamily: '微软雅黑',
        //                         fontSize: 12,
        //                         fontWeight: 'bolder'
        //                     }
        //                 },
        //             },
        //             data: charData.seriesData,
        //             emphasis: {
        //                 itemStyle: {
        //                     shadowBlur: 10,
        //                     shadowOffsetX: 0,
        //                     shadowColor: 'rgba(0, 0, 0, 0.5)'
        //                 }
        //             }
        //         }]
        //     }
        //     myChart.setOption(option2);
        // }
    
        // 获取指定月份天数
        function mGetDate(){
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth()+1;
            var d = new Date(year, month, 0);
            var days = d.getDate()
            var data = []
            for (var i = 1; i <= days; i++) {
                var str = year + '-' + month + '-' + (i < 10 ? '0' + i : i)
                data.push(str)
            }
            return data;
        }
        
        // 获取随机数字
        function getRandomNum (count) {
            return Math.round(Math.random() * count)
        }
        
    </script>
</body>
</html>