<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*" %>
<%
    Long datetime = new Date().getTime(); // 获取系统时间
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>计划执行效率分析</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/base.js?<%=datetime%>"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?<%=datetime%>"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
            overflow-x: hidden;
        }

        /*伪元素是行内元素 正常浏览器清除浮动方法*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }

        .clearfix {
            *zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
        }

        .container {
            position: relative;
            width: 100%;
            height: 100%;
        }

        /* 查询表单样式 START */
        .search_module {
            position: relative;
            height: 35px;
        }

        .query_item {
            float: left;
        }

        .search_form input, select {
            height: 35px;
        }

        .search_form .layui-form-label {
            width: 80px;
            height: 35px;
            padding: 0 10px;
            line-height: 35px;
            box-sizing: border-box;
        }

        .search_form .layui-form-item {
            height: 35px;
            margin: 0;
            clear: none;
        }

        .search_form .layui-input-block {
            margin-left: 80px;
        }

        .search_form .query_button_group {
            /*height: 100%;*/
            margin-top: 2px;
        }

        .search_form .query_btn {
            float: right;
            width: 55px;
            margin-right: 20px;
            margin-left: 0;
        }

        /* 查询表单样式 EDN */
    </style>

</head>
<body>
<div class="container">
    <div class="search_module">
        <form class="layui-form clearfix search_form" lay-filter="searchForm">
            <div class="layui-row" style="padding: 5px 0;">
                <div class="layui-form-item query_item layui-col-xs5">
                    <label class="layui-form-label">年度:</label>
                    <div class="layui-input-block">
                        <select name="year" lay-filter="year">

                        </select>
                    </div>
                </div>
                <div class="layui-form-item query_item layui-col-xs5">
                    <label class="layui-form-label" style="width: 95px">单位/部门:</label>
                    <div class="layui-input-block" style="margin-left: 95px">
                        <input type="text" name="deptIds" id="deptIds" readonly placeholder="请选择"  style="cursor: pointer; background-color: #e7e7e7;" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="query_button_group query_item layui-col-xs2">
                    <button type="button" id="searchBtn" class="layui-btn layui-btn-sm" style="margin-left: 15px">查询</button>
                    <button type="button" id="resetBtn" class="layui-btn layui-btn-sm">重置</button>
                    <button type="button" class="layui-btn layui-btn-sm back_prev">返回上级</button>
                </div>
            </div>
        </form>
    </div>
    <div class="content">
        <div class="echarts_module">
            <div class="layui-row" style="margin-top: 30px;">
                <div class="layui-col-xs3">
                    <div id="chartOne" style="height: 340px;"></div>
                </div>
                <div class="layui-col-xs3">
                    <div id="chartTwo" style="height: 340px;"></div>
                </div>
                <div class="layui-col-xs3">
                    <div id="chartThree" style="height: 340px;"></div>
                </div>
                <div class="layui-col-xs3">
                    <div id="chartFour" style="height: 340px;"></div>
                </div>
            </div>
            <div class="layui-row" style="margin-top: 30px;">
                <div class="layui-col-xs3">
                    <div id="pieShow" style="height: 340px;"></div>
                </div>
                <div class="layui-col-xs9">
                    <div id="barShow" style="height: 340px;"></div>
                </div>
            </div>
            <div id="chartBottom" style="margin: 30px auto;height: 340px;"></div>
        </div>
    </div>
</div>

<script>
    var form = layui.form;
    form.render()
    // 计划期间年度列表
    var allYear = '';
    // 获取计划期间年度列表
    $.get('/planPeroidSetting/selectAllYear', function (res) {
        var nowYearNo = '';
        if (res.object.length > 0) {
            res.object.forEach(function (item) {
                allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>';
                if (!nowYearNo && (new Date().getFullYear() == item.periodYear)) {
                    nowYearNo = item.periodYear;
                }
            });
        }
        $('.search_form [name="year"]').append(allYear);
        if (nowYearNo) {
            $('.search_form [name="year"]').val(nowYearNo);
        }
        $('#searchBtn').trigger('click');
        form.render('select');
    });
    //选部门控件添加
    $(document).on('click', '#deptIds', function () {
        dept_id = 'deptIds'
        $.popWindow("/common/selectDept");
    });
    var chartOne = echarts.init(document.getElementById('chartOne'));

    var chartTwo = echarts.init(document.getElementById('chartTwo'));

    var chartThree = echarts.init(document.getElementById('chartThree'));

    var chartFour = echarts.init(document.getElementById('chartFour'));

    var myChartPie = echarts.init(document.getElementById('pieShow'));

    var myChartBar = echarts.init(document.getElementById('barShow'));

    var myChartBottomBar = echarts.init(document.getElementById('chartBottom'));

    // 查询
    $('#searchBtn').click(function () {
        var $selectEle = $('.search_form [name]');
        var searchData = {}
        $selectEle.each(function () {
            var key = $(this).attr('name');
            var value = $(this).val();
            searchData[key] = value;
        });
        searchData.deptIds=$('#deptIds').attr('deptid')
        //加载四个柱状图
        initChart(searchData);
        // 加载饼图
        initPie(searchData);
        //加载柱状图
        initBar(searchData);
        //加载底部柱状图
        initBottomBar(searchData);
    });

    // 清空查询条件
    $('#resetBtn').click(function () {
        $('#deptIds').val('')
        $('#deptIds').attr('deptid','')
        $('#searchBtn').trigger('click');
    });

    // 返回上级
    $('.back_prev').on('click', function () {
        $('#searchBtn').trigger('click');
    });

    /**
     * 配置基础参数
     * @param type,data
     * @returns option
     */
    function optionConfig(type,data){
        var legendData=[]
        var timelyReportingData=[]
        var supplementData=[]
        var text=''
        var itemOne=''
        var itemTwo=''
        if(type==1){
            text='上报及时率'
            itemOne='timelyReporting'
            itemTwo='supplement'
            legendData= [ '及时上报计划', '补报计划']
        }else if(type==2){
            text='审批及时率'
            itemOne='timely'
            itemTwo='overtime'
            legendData= [ '及时审批计划', '超时审批计划']
        }else if(type==3){
            text='分配及时率'
            itemOne='timely'
            itemTwo='overtime'
            legendData= [ '及时分配计划', '超时分配计划']
        }else if(type==4){
            text='考核及时率'
            itemOne='timely'
            itemTwo='overtime'
            legendData= [ '及时考核计划', '超时考核计划']
        }
        data[itemOne].forEach(function (item) {
            timelyReportingData.push(item.data)
        })
        data[itemTwo].forEach(function (item) {
            supplementData.push(item.data)
        })
        var option = {
            title: {
                text: text,
                left: "center",
            },
            color:['#5B9BD5','#ED7D31'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: legendData,
                bottom:'0'
            },
            grid: {
                left: '3%',
                right: '4%',
                top: '13%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: ['1', '2', '3', '4', '5', '6', '7','8', '9', '10', '11','12'],
                    axisLabel:{
                        interval: 0
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name:'(月)',
                    nameTextStyle: {// 名称样式
                       fontSize: 11,
                    },
                    nameLocation:'start',
                    nameGap:8
                }
            ],
            series: [
                {
                    name: legendData[0],
                    type: 'bar',
                    stack: '计划',
                    data: timelyReportingData
                },
                {
                    name: legendData[1],
                    type: 'bar',
                    stack: '计划',
                    data: supplementData
                }
            ]
        };
        return option
    }

    // 加载四个柱状图
    function initChart(searchData) {
        chartOne.showLoading();
        chartTwo.showLoading();
        chartThree.showLoading();
        chartFour.showLoading();
        $.get('/ExecuteAnalysis/timelyReportingRate', searchData, function (res) {
            chartOne.hideLoading();
            if (res.flag) {
                // 使用刚指定的配置项和数据显示图表。
                var optionOne=optionConfig('1',res.data)
                chartOne.setOption(optionOne);
            }
        });
        $.get('/ExecuteAnalysis/approvalReportingRate', searchData, function (res) {
            chartTwo.hideLoading();
            if (res.flag) {
                // 使用刚指定的配置项和数据显示图表。
                var optionTwo=optionConfig('2',res.data)
                chartTwo.setOption(optionTwo);
            }
        });
        $.get('/ExecuteAnalysis/timelyDistribution', searchData, function (res) {
            chartThree.hideLoading();
            if (res.flag) {
                // 使用刚指定的配置项和数据显示图表。
                var optionThree=optionConfig('3',res.data)
                chartThree.setOption(optionThree);
            }
        });
        $.get('/ExecuteAnalysis/getAssessmentTimely', searchData, function (res) {
            chartFour.hideLoading();
            if (res.flag) {
                // 使用刚指定的配置项和数据显示图表。
                var optionFour=optionConfig('4',res.data)
                chartFour.setOption(optionFour);
            }
        });
    }

    /**
     * 加载饼图
     */
    function initPie(searchData) {
        myChartPie.showLoading();
        searchData = searchData || {}
        $.get('/ExecuteAnalysis/yearPlanExecutionCoverage', searchData, function (res) {
            myChartPie.hideLoading();
            if (res.flag) {
                var data = res.data;
                var legendData = ['已填报','未填报']
                var pieData = [
                    {value: data.completed, name: '已填报'},
                    {value: data.notFilledIn, name: '未填报'},

                ]

                myChartPie.setOption({
                    title: {
                        text: '年度计划覆盖率',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c} ({d}%)'
                    },
                    color: ['#5B9BD5', '#ED7D31'],
                    legend: {
                        orient: 'vertical',
                        left: '10%',
                        top: '30%',
                        data: legendData
                    },
                    series: [
                        {
                            name: '状态',
                            type: 'pie',
                            selectedMode: 'multiple',
                            label: {
                                show: true,
                                position: 'outside',
                                formatter: '{b} : {c} ({d}%)'
                            },
                            radius: '55%',
                            center: ['60%', '60%'],
                            data: pieData,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                });
            }
        });
    }


    /**
     * 加载柱状图
     * @param searchData
     */
    function initBar(searchData) {
        myChartBar.showLoading();
        searchData = searchData || {}
        $.get('/ExecuteAnalysis/monthPlanExecutionCoverage',searchData,function (res) {
            myChartBar.hideLoading();
            if(res.flag){
                var data=res.data
                var notFilledInData=[]
                var completedData=[]
                var coverage=[]
                data.notFilledIn.forEach(function (item) {
                    notFilledInData.push(item.data)
                })
                data.completed.forEach(function (item) {
                    coverage.push(item.proportion)
                    completedData.push(item.data)
                })
                myChartBar.setOption({
                    color:['#ED7D31','#5B9BD5','#A5A5A5'],
                    title: {
                        text: '月度计划执行覆盖率',
                        left: "center",
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            crossStyle: {
                                color: '#999'
                            }
                        }
                    },
                    legend: {
                        data: ['未填报人员数量', '已填报人员数量', '覆盖率'],
                        bottom:'0'
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                            axisPointer: {
                                type: 'shadow'
                            }
                        }
                    ],
                    yAxis: [{}, {}],
                    series: [
                        {
                            name: '未填报人员数量',
                            type: 'bar',
                            data: notFilledInData
                        },
                        {
                            name: '已填报人员数量',
                            type: 'bar',
                            data: completedData
                        },
                        {
                            name: '覆盖率',
                            type: 'line',
                            yAxisIndex: 1,
                            data: coverage
                        }
                    ]
                });
            }
        })
    }

    /**
     * 加载底部柱状图
     * @param searchData
     */
    function initBottomBar(searchData) {
        myChartBottomBar.showLoading();
        searchData = searchData || {}
        $.get('/ExecuteAnalysis/planQualityAnalysis',searchData,function (res) {
            myChartBottomBar.hideLoading();
            if(res.flag){
                var data=res.data
                var xAxisData=[]
                var seriesItemOne=[]
                var seriesItemTwo=[]
                data.forEach(function (item) {
                    xAxisData.push(item.deptName)
                    seriesItemOne.push(item.data.undifferentiated)
                    seriesItemTwo.push(item.data.decomposed)
                })
                myChartBottomBar.setOption({
                    title: {
                        text: '计划编制质量分析',
                        left: "center",
                    },
                    color:['#5B9BD5','#ED7D31'],
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    legend: {
                        data: [ '未分解关键任务数量', '已分解关键任务数量'],
                        orient: 'vertical',
                        left: '2%',
                        top: '30%',
                    },
                    grid: {
                        left: '14%',
                        right: '4%',
                        top: '13%',
                        containLabel: true
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: xAxisData,
                            axisLabel:{
                                interval: 0
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
                            name: '未分解关键任务数量',
                            type: 'bar',
                            stack: '关键任务数量',
                            data: seriesItemOne
                        },
                        {
                            name: '已分解关键任务数量',
                            type: 'bar',
                            stack: '关键任务数量',
                            data: seriesItemTwo
                        }
                    ]
                });
            }
        })
    }


    window.onresize = function () {
        chartOne.resize();
        chartTwo.resize();
        chartThree.resize();
        chartFour.resize();
        myChartPie.resize();
        myChartBar.resize();
        myChartBottomBar.resize();
    }

</script>

</body>
</html>
