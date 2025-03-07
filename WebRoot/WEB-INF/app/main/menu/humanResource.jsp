<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>人力资源门户</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/dest/layui.all.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/highcharts.js"></script>
    <style src="/lib/Highcharts-5.0.14/code/highcharts.js"></style>
    <style>
        * {
            font-family: "Microsoft Yahei" !important;
            /*overflow-y: hidden;*/
        }

        nav button {
            margin-left: 5px;
            padding: .25rem .5rem;
            font-size: .875rem;
            border-radius: .2rem;
            margin-top: 10px;
        }

        nav div {
            float: left !important;
            margin: 15px;
        }

        nav {
            height: 50px;
            border-bottom: 1px solid #cfdbe2;
            background-color: #fafbfc;
            border-radius: 0;
        }

        .layui-tab {
            margin: 0;
        }

        .content {
            overflow: auto;
            padding: 14px;
            /*background: #fff;*/
        }

        .layui-tab-content {
            background-color: #F5F7FA;
        }
        .upperUl{
            width: 76.5%;
            display: flex;
            justify-content: space-between;
        }

        .detail {
            height: 100px;
            border-radius: 5px;
            /*width: calc(80% / 5);*/
            /*min-width: 180px;*/
            display: table-cell;
            vertical-align: middle;
            width: inherit;
        }

        .detail img {
            float: left;
            margin-left: 15px;
            margin-top: 10px;
            width: 40px;
        }

        .upperUl li {
            float: left;
            margin-right: 10px;
            /*width: calc(74% / 5);*/
            width: 20%;
        }

        .upperDiv {
            width: calc(75% / 2);
            background: #FFFFFF;
            height: 200px;
            float: left;
            margin-right: 20px;
        }

        .middleDiv {
            width: calc(98% / 2);
            background: #FFFFFF;
            height: 420px;
            float: left;
            margin-top: 20px;
        }

        h1 {
            color: white;
        }

        h3 {
            color: white;
        }

        i {
            float: right;
            color: white;
            padding-right: 10px;
            margin-top: -10px;
        }

        .upperDiv ul li {
            width: calc(98% / 2);
            float: left;
        }

        .layui-tab-content {
            padding: 20px;
        }
    </style>
</head>
<body>
<div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <div class="layui-tab-content content">
            <%--<div class="content">--%>
            <div class="upperPart ">
                <div>
                    <ul class="upperUl">
                        <li>
                            <div class="detail" style="background:#8393e1;">
                                <i class="layui-icon layui-icon-about" style="color: white"></i>
                                <img src="../ui/img/menu/people.png"/>
                                <span style="float:left;width: 1px;height: 60%; background: #f5f7fa;margin-left: 12%;"></span>
                                <div style="float: right; padding-right: 20%;">
                                    <h1 class="should">0</h1>
                                    <h3>应出勤</h3>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="detail" style="background: #fbaa8a">
                                <i class="layui-icon layui-icon-about" style="color: white"></i>
                                <img src="../img/menu/late.png"/>
                                <span style="float:left;width: 1px;height: 60%; background: #f5f7fa;margin-left: 12%;"></span>
                                <div style="float: right;width: 78px;">
                                    <h1 class="practical">0</h1>
                                    <h3>实际出勤</h3>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="detail" style="background: #f2807a">
                                <i class="layui-icon layui-icon-about" style="color: white"></i>
                                <img src="../img/menu/belate.png"/>
                                <span style="float:left;width: 1px;height: 60%; background: #f5f7fa;margin-left: 12%;"></span>
                                <div style="float: right; padding-right: 20%;">
                                    <h1 class="late">0</h1>
                                    <h3>迟到</h3>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="detail" style="background: #edd374">
                                <i class="layui-icon layui-icon-about" style="color: white"></i>
                                <img src="../ui/img/menu/punch.png"/>
                                <span style="float:left;width: 1px;height: 60%; background: #f5f7fa;margin-left: 12%;"></span>
                                <div style="float: right;padding-right: 20%;">
                                    <h1 class="leave">0</h1>
                                    <h3>请假</h3>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="detail" style="background: #7983b4">
                                <i class="layui-icon layui-icon-about" style="color: white"></i>
                                <img src="../ui/img/menu/vacation.png"/>
                                <span style="float:left;width: 1px;height: 60%; background: #f5f7fa;margin-left: 12%;"></span>
                                <div style="float: right;    padding-right: 20%;">
                                    <h1 class="overtime">0</h1>
                                    <h3>加班</h3>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <br/>
                    <div class="upperDiv">
                        <ul>
                            <li style="border-right: 5px solid ghostwhite;">
                                <div id="sex"></div>
                            </li>
                            <li>
                                <div id="education"></div>
                            </li>
                        </ul>
                    </div>
                    <div class="upperDiv">
                        <ul>
                            <li style="border-right: 5px solid ghostwhite;">
                                <div id="duty"></div>

                            </li>
                            <li>
                                <div id="nativePlace"></div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div style="height: 335px;width: 23%;min-width:240px;background: #8393e1;float:right;margin-top: -336px; border-radius: 5px;">
                    <div id="checkingIn" style="padding-top: 20px"></div>
                </div>
            </div>

            <div class="middlePart">
                <div class="middleDiv" style="margin-right: 20px">
                    <div id="checking" style="margin-top: 20px"></div>
                </div>
                <div class="middleDiv">
                    <div id="reward" style="margin-top: 20px"></div>
                </div>
            </div>
            <div class="solicitude" style="margin-top: 645px">
                <table class="layui-hide" id="solicitudeTable" lay-filter="solicitudeTable"></table>
            </div>
        </div>
    </div>
    <%--</div>--%>
</div>
</body>
<script>
    $(function () {
        $.ajax({
            url: "/portals/selPortalsUser",
            type: "get",
            dataType: "json",
            success: function (res) {
                var deptId = res.object.deptId
                var userId = res.object.userId
                checking(deptId, userId)
            }
        });
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth() + 1;
        var date = myDate.getDate();
        var beginDate = year + '-' + p(month) + "-" + p(01);
        var endDate = year + '-' + p(month) + "-" + p(date);

        function checking(deptId, userId) {
            $.ajax({
                url: "/attend/findDateList",
                type: "get",
                dataType: "json",
                success: function (res) {
                    $('.should').text(res.data.yingchuqin);
                    $('.practical').text(res.data.chuqin);
                    $('.late').text(res.data.chidao);
                    $('.leave').text(res.data.qingjia);
                    $('.overtime').text(res.data.jiaban);

                }
            })
        }

        $.ajax({
            url: "/hr/manage/selLaborNums",
            type: "get",
            dataType: "json",
            data: {
                abilityName: 1
            },
            success: function (res) {
                var str = [];
                var arr = [];
                for (var i = 0; i < res.obj.length; i++) {
                    str.push(res.obj[i].abilityName)
                    arr.push(res.obj[i].nums)
                }
                var checkingIn = Highcharts.chart('checkingIn', {
                    title: {
                        text: '劳动技能',
                        style: {
                            color: '#fff',      //字体颜色
                            "fontSize": "15px",
                        }
                    },
                    chart: {
                        backgroundColor: '#8393e1',
                        height: 320,
                    },
                    subtitle: {
                        text: ''
                    },
                    yAxis: {
                        title: {
                            text: '',
                        }
                    },
                    xAxis: {
                        categories: str,
                        labels: {
                            style: {
                                color: '#fff',
                            }
                        }, plotLines: [{
                            color: '#fff'
                        }],
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle'
                    },
                    credits: {
                        enabled: false
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: false
                            },
                            showInLegend: true
                        }
                    },
                    series: [{
                        name: '人数',
                        data: arr,
                        color: '#FFFF33',
                        showInLegend: false
                    }],
                    responsive: {
                        rules: [{
                            condition: {
                                maxWidth: 1000
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
        })


    })
    function p(s) {
        return s < 10 ? '0' + s : s;
    }
    $.ajax({
        url: "/hr/manage/selInfoNums",
        type: "post",
        dataType: "json",
        data: {
            staffSex: 1
        },
        success: function (res) {
            var arr = [];
            for (var i = 0; i < res.obj.length; i++) {
                arr.push({name: res.obj[i].staffSexName, y: res.obj[i].nums});
            }
            var sex = Highcharts.chart('sex', {
                chart: {
                    height: 200,
                },
                title: {
                    floating: true,
                    text: '性别'
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: false,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        },
                    }
                },
                series: [{
                    type: 'pie',
                    innerSize: '80%',
                    name: '性别',
                    data: arr
                }]
            }, function (c) { // 图表初始化完毕后的会掉函数
                // 环形图圆心
                var centerY = c.series[0].center[1],
                    titleHeight = parseInt(c.title.styles.fontSize);
                // 动态设置标题位置
                c.setTitle({
                    y: centerY + titleHeight / 2
                });
            });
        }
    })
    $.ajax({
        url: "/hr/manage/selInfoNums",
        type: "post",
        dataType: "json",
        data: {
            presentPosition: 1
        },
        success: function (res) {
            var arr = [];
            for (var i = 0; i < res.obj.length; i++) {
                var presentPositionName;
                if (res.obj[i].presentPositionName == '' || res.obj[i].presentPositionName == undefined) {
                    presentPositionName = '其他'
                } else {
                    presentPositionName = res.obj[i].presentPositionName
                }
                arr.push({name: presentPositionName, y: res.obj[i].nums});
            }
            var duty = Highcharts.chart('duty', {
                chart: {
                    height: 200,
                },
                title: {
                    floating: true,
                    text: '职务'
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: false,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        },
                    }
                },
                series: [{
                    type: 'pie',
                    innerSize: '80%',
                    name: '职务',
                    data: arr
                }]
            }, function (c) { // 图表初始化完毕后的会掉函数
                // 环形图圆心
                var centerY = c.series[0].center[1],
                    titleHeight = parseInt(c.title.styles.fontSize);
                // 动态设置标题位置
                c.setTitle({
                    y: centerY + titleHeight / 2
                });
            });
        }
    })
    $.ajax({
        url: "/hr/manage/selInfoNums",
        type: "post",
        dataType: "json",
        data: {
            staffHighestSchool: 1
        },
        success: function (res) {
            var arr = [];
            for (var i = 0; i < res.obj.length; i++) {
                arr.push({name: res.obj[i].staffHighestSchoolName, y: res.obj[i].nums});
            }
            var education = Highcharts.chart('education', {
                chart: {
                    height: 200,
                },
                title: {
                    floating: true,
                    text: '学历'
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: false,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        },
                    }
                },
                series: [{
                    type: 'pie',
                    name: '学历',
                    innerSize: '80%',
                    data: arr
                }]
            }, function (c) { // 图表初始化完毕后的会掉函数
                // 环形图圆心
                var centerY = c.series[0].center[1],
                    titleHeight = parseInt(c.title.styles.fontSize);
                // 动态设置标题位置
                c.setTitle({
                    y: centerY + titleHeight / 2
                });
            });
        }

    })
    $.ajax({
        url: "/hr/manage/selectNumPost",
        type: "post",
        dataType: "json",
        success: function (res) {
            var data = [];
            var arr = [];
            for (var i = 0; i < res.obj.length; i++) {
                if (res.obj[i].WORK_POST != '' && res.obj[i].WORK_POST != undefined) {
                    arr.push(res.obj[i].WORK_POST);
                    data.push(res.obj[i].num);
                }
            }

            var checking = Highcharts.chart('checking', {
                chart: {
                    type: 'column',
                    height: 400,
                },
                credits: {
                    enabled: false
                },
                title: {
                    text: '岗位人数分析'
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    categories: arr,
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: '人数（人）'
                    }
                },
                tooltip: {},
                plotOptions: {
                    column: {
                        borderWidth: 0
                    }
                },
                series: [{name: '人数', data: data}]
            });
        }
    })
    $.ajax({
        url: "/hr/manage/selInfoNums",
        type: "post",
        dataType: "json",
        data: {
            staffNativePlace: 1
        },
        success: function (res) {
            var arr = [];
            for (var i = 0; i < res.obj.length; i++) {
                arr.push({name: res.obj[i].staffNativePlace, y: res.obj[i].nums});
            }
            var nativePlace = Highcharts.chart('nativePlace', {
                chart: {
                    height: 200,
                },

                title: {
                    floating: true,
                    text: '籍贯'
                },
                credits: {
                    enabled: false
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: false,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        },
                    }
                },
                series: [{
                    type: 'pie',
                    innerSize: '80%',
                    name: '籍贯',
                    data: arr
                }]
            }, function (c) { // 图表初始化完毕后的会掉函数
                // 环形图圆心
                var centerY = c.series[0].center[1],
                    titleHeight = parseInt(c.title.styles.fontSize);
                // 动态设置标题位置
                c.setTitle({
                    y: centerY + titleHeight / 2
                });
            });
        }
    })
    $.ajax({
        url: "/hr/manage/selIncNums",
        type: "get",
        dataType: "json",
        data: {
            incentiveItem: 1,
            deptId: ''
        },
        success: function (res) {
            var arr = [];
            var str = [];
            for (var i = 0; i < res.obj.length; i++) {
                str.push(res.obj[i].incentiveItem1);
                arr.push(res.obj[i].nums)
            }
            var reward = Highcharts.chart('reward', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: '奖罚项目'
                },
                subtitle: {
                    text: ''
                },
                xAxis: {
                    categories: str
                },
                yAxis: {
                    title: {
                        text: '分数'
                    }
                },
                plotOptions: {
                    line: {
                        dataLabels: {
                            // 开启数据标签
                            enabled: true
                        },
                        // 关闭鼠标跟踪，对应的提示框、点击事件会失效
                        enableMouseTracking: false
                    }
                },
                credits: {
                    enabled: false
                },
                series: [{
                    name: '奖罚项目',
                    data: arr
                }]
            });
        }
    })
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#solicitudeTable'
            , url: '/hr/manage/selectHrStaffCares'
            , cols: [[
                {field: 'careType', title: '关怀类型'}
                , {field: 'byCareStaffs', title: '被关怀员工'}
                , {field: 'careFees', title: '关怀开支费用/人'}
                , {field: 'participants', title: '	参与人', edit: true}
                , {field: 'careDate', title: '关怀日期', edit: true}
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.obj //解析数据列表
                };
            }
            , page: true
        });
    });

</script>

</html>
