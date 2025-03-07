<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/2
  Time: 9:16
  To change this template use File | Settings | File Templates.
--%>
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
	<head>
		<title>任务中心</title>
		<meta charset="UTF-8">
		<meta name="renderer" content="webkit">
	    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">

	    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		<link rel="stylesheet" href="/lib/swiper-4.5.0/swiper.min.css">

	    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	    <script type="text/javascript" src="/js/planbudget/echarts.min.js"></script>
	    <script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/swiper-4.5.0/swiper.min.js"></script>

		<style>
			html, body {
                width: 100%;
                height: 100%;
                background-color: #f8f8f8;
				font-family: "Microsoft Yahei" !important;
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

			.wrapper {
	            position: relative;
                width: 100%;
                height: 100%;
				background-color: #f8f8f8;
	            box-sizing: border-box;
            }

			.wrap_left {
				position: relative;
				float: left;
				width: 60%;
				padding: 0 20px;
				box-sizing: border-box;
			}

			.wrap_right {
				position: relative;
				margin-left: 60%;
				padding: 0 20px;
				box-sizing: border-box;
			}

            .card_box {
                position: relative;
	            /*margin-bottom: 20px;*/
                background-color: #fff;
            }

			/* region 导航样式 */
            .nav_module {
                position: relative;
                width: 100%;
                height: 170px;
                padding: 10px 20px;
                box-sizing: border-box;
            }

            .set {
                position: absolute;
                top: 10px;
                right: 20px;
                width: 20px;
                height: 20px;
                background-image: url('/img/main_img/index/setting.png');
                background-position: center;
                background-size: 100%;
	            cursor: pointer;
                z-index: 2;
            }

            .swiper-container {
                width: 100%;
                height: 100%;
	            background-color: #fff;
            }

            .swiper-slide {
	            height: 140px;
	            margin-top: 5px;
            }

            .swiper_btn {
	            display: none;
            }

            .nav_module:hover .swiper_btn{
	            display: block;
            }

            .nav_item {
	            position: relative;
                height: 140px;
	            padding-top: 30px;
	            box-sizing: border-box;
	            text-align: center;
            }

            .nav_item .con {
	            display: inline-block;
	            padding: 10px;
	            border-radius: 5px;
	            box-sizing: border-box;
	            transition: .3s;
	            cursor: pointer;
            }

            .nav_item:hover .con {
                box-shadow: 0 0 6px -1px rgba(0, 0, 0, .15);
            }

            .nav_item img {
	            width: 50px;
            }

            .nav_item .t_box {
                display: inline-block;
                vertical-align: middle;
	            margin-left: 5px;
            }

            .nav_item .nav_t {
                font-weight: bold;
                font-size: 17px;
            }

            .nav_item .nav_num {
                font-weight: bold;
                font-size: 26px;
            }
            /* endregion */

			.layui-tab {
				margin: 0;
			}

            .layui-tab-brief > .layui-tab-title .layui-this {
                color: #1296DB;
            }

            .layui-tab-brief > .layui-tab-more li.layui-this:after, .layui-tab-brief > .layui-tab-title .layui-this:after {
                border-bottom: 2px solid #1296DB;
            }

            .chart_box {
	            position: relative;
	            padding: 5px;
	            box-sizing: border-box;
                overflow: hidden;
            }

            .cover_scroll {
                position: absolute;
                top: 0;
                right: 10px;
                height: 100%;
                width: 17px;
                z-index: 1;
                background-color: #fff;
            }

            .item_child_box {
                display: none;
                position: fixed;
                top: 155px;
                min-width: 370px;
                max-width: 630px;
	            max-height: 490px;
                background: #fff;
                box-shadow: 0 0px 12px 1px rgba(0, 0, 0, .1);
                z-index: 2;
                overflow-y: auto;
	            overflow-x: hidden;
            }

            .item_child_con {
	            padding-top: 10px;
	            padding-right: 10px;
	            overflow: hidden;
            }

            .item_child {
                float: left;
                width: 110px;
                height: 110px;
                margin-left: 10px;
                margin-bottom: 10px;
                text-align: center;
                font-size: 17px;
	            font-weight: 600;
	            color: #fff;
                background-color: #00adff;
	            border-radius: 3px;
	            transition: .3s;
	            cursor: pointer;
            }
            .item_child:hover {
                box-shadow: 0 0 8px 0 rgba(0, 0, 0, .5);
            }

            .card_head {
                position: relative;
                height: 42px;
                line-height: 42px;
                padding: 0 15px;
                border-bottom: 1px solid #f6f6f6;
                color: #333;
                border-radius: 2px 2px 0 0;
                font-size: 14px;
            }

            .card_tittle {
                display: inline-block;
                height: 28px;
                line-height: 28px;
                font-size: 15px;
                margin-top: 5px;
            }

            .title_icon {
                display: inline-block;
                width: 24px;
                height: 24px;
                vertical-align: top;
                margin-top: 2px;
                margin-right: 10px;
                background-image: url(/img/main_img/menu/market/title-icon.png);
                background-position: 0 0;
                background-repeat: no-repeat;
                background-size: cover;
            }

            .card_label {
	            margin-bottom: 0;
	            border: 1px dashed #ccc;
            }

            .order_label {
                float: none;
	            padding-left: 0;
                margin-left: 50px;
                width: auto;
                text-align: left;
	            cursor: move;
            }

            .order_label p {
                word-break: break-all;
                white-space: nowrap;
                text-overflow: ellipsis;
                overflow: hidden;
            }

            .layui-input-block {
                margin: 0;
                float: left;
                width: 50px;
                text-align: center;
            }

            .card_label .layui-form-checkbox {
                padding: 0 !important;
                vertical-align: top;
            }
		</style>
	</head>
	<body>
		<div class="wrapper">
			<input type="hidden" id="fId" value="">
			<input type="hidden" id="taskStatus" value="0">
			<input type="hidden" id="menuInfo">
			<span style="display: none;" class="jump_span" tid="" url=""><h2 class="menu_name">新闻</h2></span>
			<div class="nav_module">
				<a class="set"></a>
				<div class="swiper-container">
					<div class="swiper-wrapper"></div>

					<!-- Add Arrows -->
					<div class="swiper-button-next swiper_btn"></div>
					<div class="swiper-button-prev swiper_btn"></div>
				</div>
			</div>
			<div class="wrap_left">
				<div class="card_box">
					<div class="card_head">
						<h4 class="card_tittle">
							<i class="icon title_icon"></i>
							<span>任务列表</span>
						</h4>
					</div>
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
						<ul class="layui-tab-title">
							<li class="layui-this">待办</li>
							<li>已办</li>
							<li>超时</li>
						</ul>
						<div class="layui-tab-content" style="position: relative;">
							<div class="layui-tab-item layui-show">
								<div>
									<table id="dataTable" lay-filter="dataTable"></table>
								</div>
							</div>
							<div class="cover_scroll"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="wrap_right">
				<div class="card_box" style="margin-bottom: 10px;">
					<div class="chart_box" id="chartOne"></div>
				</div>
				<div class="card_box">
					<div class="chart_box" id="chartTwo"></div>
				</div>
			</div>

			<div class="item_child_box">
				<div class="item_child_con"></div>
			</div>
		</div>

		<script>
			var swiper = null;

			var navTitle = '';

            window.onresize = function () {
                resizeTable();
                chartOne.resize();
                chartTwo.resize();
            };

            resizeTable();

            function resizeTable () {
                var windowHeight = $(window).height();

                $('.chart_box').height((windowHeight - 200) / 2);
            }

            var chartOne = echarts.init(document.getElementById('chartOne'));

            var chartTwo = echarts.init(document.getElementById('chartTwo'));

            var colorArr = ['#FFB800', '#6BDF06', '#ea7ccc', '#1296DB', '#FF1222', '#9304ff'];

            var showMenuArr = [];

            $.get('/userPrivateSet/taskCenterShouMeunTree', function (res) {
                if (res.object.personal) {
                    var globalArr = res.object.global.replace(/,$/, '').split(',');
                    showMenuArr = res.object.personal.split(',');
                    var arr = [];
                    globalArr.forEach(function (item) {
                        if (showMenuArr.indexOf(item) == -1) {
                            showMenuArr.push(item);
                        }
                    });
                } else {
                    res.data.forEach(function (item) {
                        if (item.child && item.child.length > 0) {
                            item.child.forEach(function (child) {
                                showMenuArr.push(child.fId);
                            });
                        }
                    });
                }
            });

            layui.use(['element','table','form','xmSelect'], function () {
                var element = layui.element,
                    table = layui.table,
                    form = layui.form,
	                xmSelect = layui.xmSelect;

                // 一些事件监听
                element.on('tab(docDemoTabBrief)', function (data) {
                    $('#taskStatus').val(data.index);
                    loadTable({
	                    taskStatus: data.index,
                        funcId: $('#fId').val()
                    });
                });

                // 获取各个模块中的待办数量
                $.get('/taskCenter/getAllDataCount', function (res) {
                    if (res.flag) {
                        res.data.forEach(function (item, index) {
                            var hasChild = item.child && item.child.length > 0 ? 1 : 0;

                            var flag = index % 6;

                            var str = '<div class="swiper-slide">' +
                                '<div class="nav_item" hasChild="' + hasChild + '">' +
                                '<div class="con">' +
                                '<img src="/img/main_img/${sessionScope.InterfaceModel}/' + item.img + '.png"/>' +
                                '<div class="t_box" style="color: '+ colorArr[flag] +';">' +
                                '<h3 class="nav_t">' + item.name + '</h3>' +
                                '<span class="nav_num">' + item.messageNum + '</span>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>';

                            var $ele = $(str);
                            $ele.data('childdata', item.child);
                            $('.swiper-wrapper').append($ele);
                        });

                        swiper = new Swiper('.swiper-container', {
                            slidesPerView: 6,
                            spaceBetween: 30,
                            slidesPerGroup: 6,
                            loop: false,
                            loopFillGroupWithBlank: true,
                            navigation: {
                                nextEl: '.swiper-button-next',
                                prevEl: '.swiper-button-prev',
                            }
                        });
                    }
                });

                // 移入
	            $(document).on('click', '.nav_item', function(){
	                return false;
	            });
                $(document).on('mouseenter', '.nav_item', function () {
                    $('.item_child_con').empty();

                    var hasChild = $(this).attr('hasChild');

                    navTitle = $(this).find('.nav_t').text();

                    if (hasChild == 1) {
                        var windowWidth = $(window).width();
                        var offset = $(this).offset();
                        var childData = $(this).parent().data('childdata');
                        var str = '';
                        childData.forEach(function (item) {
                            if (showMenuArr.indexOf(item.fId.toString()) > -1) {
                                str += '<div class="item_child" menu_id="' + item.id + '" fId="' + item.fId + '"><p style="margin-top: 20px;">' + item.name + '</p><p style="margin-top: 5px;">' + item.messageNum + '</p></div>';
                            }
                        });

                        if (str) {
                            if (childData.length > 20) {
                                $('.item_child_box').css('max-width', '630px');
                            } else {
                                $('.item_child_box').css('max-width', '610px');
                            }

                            if (offset.left < (windowWidth / 3 * 2)) {
                                $('.item_child_box').css('left', offset.left + 'px');
                                $('.item_child_box').css('right', 'unset');
                            } else {
                                var width = $(this).width();
                                var right = windowWidth - offset.left - width;
                                $('.item_child_box').css('right', right + 'px');
                                $('.item_child_box').css('left', 'unset');
                            }

                            $('.item_child_con').html(str);
                            $('.item_child_box').show();
                        }
                    }
                });
                $(document).on('mouseleave', '.nav_item', function () {
                    $('.item_child_box').hide();
                });

                $('.item_child_box').hover(function () {
                    $(this).show();
                }, function () {
                    $(this).hide();
                });

                $(document).on('click', function () {
                    $('.item_child_box').hide();
                });

                $(document).on('click', '.item_child', function(){
                    var fId = $(this).attr('fId');

                    $('#fId').val(fId);

                    var name = $(this).find('p').eq(0).text();

                    $('.card_tittle').find('span').text(navTitle + '->' + name);

                    $('#menuInfo').attr('menu_id', $(this).attr('menu_id'));
					$('#menuInfo').val(name);
                    loadTable({
	                    taskStatus: $('#taskStatus').val(),
                        funcId: fId
                    });
                });

                $(document).on('click', '.table_li', function () {
                    var url = $(this).attr('url');
                    if (url) {
                        // 流程和公文用新窗口打开，其他的通过菜单打开
                        if (url.indexOf('/workform') > -1 || url.indexOf('/workformPreView') > -1) {
                            window.open(url);
                        } else {
                            parent.getMenuOpen(this);
                        }
                    }
                });

                table.on('row(dataTable)', function (obj) {
	                var url = obj.data.doUrl;
                    if (url) {
                        // 流程和公文用新窗口打开，其他的通过菜单打开
                        if (url.indexOf('/workform') > -1 || url.indexOf('/workformPreView') > -1) {
                            window.open(url);
                        } else {
                            var menu_id = $('#menuInfo').attr('menu_id');
                            var menuName = $('#menuInfo').val();
                            $('.jump_span').attr('tid', (menu_id || obj.data.funcId));
                            $('.jump_span').attr('url', url);
                            $('.menu_name').text(menuName || obj.data.funcName);
                            $('.jump_span').trigger('click');
                        }
                    }
                });

                $('.jump_span').on('click', function () {
                    parent.getMenuOpen(this);
                });

                $('.set').on('click', function(){
                    var setTree = null;
                    layer.open({
                        type: 1,
                        title: '个人设置',
                        area: ['500px', '600px'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div style="height: 100%; overflow:hidden;padding: 10px;box-sizing: border-box;"><div id="setTree" class="xm-select-demo"></div></div>',
                        success: function () {
                            $.get('/userPrivateSet/taskCenterShouMeunTree', function (res) {

                                var globalArr = res.object.global.split(',');
                                var personalArr = res.object.personal ? res.object.personal.split(',') : [];

                                res.data.forEach(function (item) {
                                    item.fId = 'f_' + item.id;
                                    if (item.child && item.child.length > 0) {
                                        item.child.forEach(function (child) {
                                            if (res.object.personal) {
                                                if (personalArr.indexOf(child.fId.toString()) > -1){
                                                    child.selected = true;
                                                }
                                            } else {
                                                child.selected = true;
                                            }

                                            if (globalArr.indexOf(child.fId.toString()) > -1) {
                                                child.selected = true;
                                                child.disabled = true;
                                            }
                                        });
                                    }
                                });

                                setTree = xmSelect.render({
                                    el: '#setTree',
                                    autoRow: true,
                                    filterable: true,
                                    tree: {
                                        show: true,
                                        showFolderIcon: true,
                                        showLine: true,
                                        indent: 20,
                                        expandedKeys: [-3],
                                    },
                                    toolbar: {
                                        show: true,
                                    },
                                    name: 'taskSet',
                                    prop: {
                                        name: 'name',
                                        value: 'fId',
                                        children: 'child'
                                    },
                                    data: res.data
                                });
                            });
                        },
                        yes: function (index) {
	                        var value = setTree.getValue('valueStr');
                            $.post('/userPrivateSet/personalSettings', {taskSet: value}, function (res) {
                                if (res.flag) {
                                    window.location.reload();
                                } else {
                                    layer.msg('保存失败！', {icon: 2, time: 2000});
                                }
                            });
                        }
                    });
                });

                loadTable({taskStatus: 0});

                // 获取列表数据
                function loadTable(queryData) {
                    queryData = queryData ? queryData : {}

                    var taskStatus = $('#taskStatus').val();

                    if (taskStatus == 2) {
                        queryData.taskStatus = 0;
                        queryData.timeOut = 0;
                    }

					// 执行渲染
                    table.render({
                        elem: '#dataTable',
	                    url: '/taskCenter/getTaskCenters',
	                    where: queryData,
	                    page: true,
                        height: 'full-310',
                        cols: [[
                            {
                                field: 'taskName', title: '任务名称', templet: function (d) {
                                    var str = '';
                                    if (d.taskLevel == 2) {
                                        str = '<span style="color: #f00">[特急]</span>' + d.taskName;
                                    } else if (d.taskLevel == 1) {
                                        str = '<span style="color: #ff8d00">[紧急]</span>' + d.taskName;
                                    } else {
                                        str = d.taskName;
                                    }
                                    return str;
                                }
                            },
	                        {field: 'funcName', title: '分类'},
                            {
                                field: 'beginTime', title: '开始时间', templet: function (d) {
                                    return format(d.beginTime);
                                }
                            },
                            {
                                field: 'planEndTime', title: '结束时间', templet: function (d) {
                                    var time = '';
                                    if (taskStatus == 0 || taskStatus == 2) {
                                        time = format(d.planEndTime);
                                    } else if (taskStatus == 1) {
                                        time = format(d.endTime);
                                    }
                                    return time;
                                }
                            },
	                        {field: 'fromUserName', title: '发送人'}
                        ]],
	                    request: {
                            limitName: 'pageSize'
                        },
                        response: {
                            statusName: 'flag',
                            statusCode: true,
                            msgName: 'msg',
                            countName: 'totleNum',
                            dataName: 'data'
                        }
                    });
                }
            });

            /**
             * 将毫秒数转为yyyy-MM-dd格式时间
             * @param t
             * @returns {string|*}
             */
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            loadChartOne()

            chartOne.on('click', function (params) {
                var nameArr = params.name.split('-');
                var year = nameArr[0];
	            var month = nameArr[1];
                laodChartTwo(year, month);
            });

            function loadChartOne() {
                chartOne.showLoading();
                $.get('/taskCenter/analysisByMonth', function (res) {
                    chartOne.hideLoading();
                    if (res.flag) {
                        var dataArr = [];

                        $.each(res.data, function (k, o) {
                            dataArr.push({
                                key: parseInt(k.replace('-', '')),
                                name: k,
                                value: o
                            });
                        });

                        for (var i = 0; i < dataArr.length; i++) {
                            for (var j = 0; j < dataArr.length - i - 1; j++) {
                                if (dataArr[j].key > dataArr[j + 1].key) {
                                    var temp = dataArr[j]
                                    dataArr[j] = dataArr[j + 1]
                                    dataArr[j + 1] = temp
                                }
                            }
                        }

                        var xAxisData = [];
                        var gobalData = []
						var personalData = [];

                        dataArr.forEach(function (item) {
                            xAxisData.push(item.name);
                            gobalData.push(item.value.globalMonthCount);
                            personalData.push(item.value.personalMonthCount);
                        });

                        chartOne.setOption({
                            title: {
                                text: '任务数量(个)'
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                }
                            },
                            legend: {
                                data: ['公司人均', '个人']
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: {
                                type: 'value',
                                boundaryGap: [0, 0.01]
                            },
                            yAxis: {
                                type: 'category',
                                data: xAxisData
                            },
                            series: [
                                {
                                    name: '公司人均',
                                    type: 'bar',
                                    data: gobalData
                                },
                                {
                                    name: '个人',
                                    type: 'bar',
                                    data: personalData
                                }
                            ]
                        }, true);
                    } else {
                        chartOne.setOption({}, true);
                    }
                });
            }

            laodChartTwo();

            function laodChartTwo() {
                chartTwo.showLoading();

                $.get('/taskCenter/analysisByMonthPrescription', function (res) {
                    chartTwo.hideLoading();
                    if (res.flag) {
                        var dataArr = [];

                        $.each(res.data, function (k, o) {
                            dataArr.push({
                                key: parseInt(k.replace('-', '')),
                                name: k,
                                value: o
                            });
                        });

                        for (var i = 0; i < dataArr.length; i++) {
                            for (var j = 0; j < dataArr.length - i - 1; j++) {
                                if (dataArr[j].key > dataArr[j + 1].key) {
                                    var temp = dataArr[j]
                                    dataArr[j] = dataArr[j + 1]
                                    dataArr[j + 1] = temp
                                }
                            }
                        }

                        var xAxisData = [];
                        var gobalData = []
						var personalData = [];

                        dataArr.forEach(function (item) {
                            xAxisData.push(item.name);
                            gobalData.push(item.value.globalMonth);
                            personalData.push(item.value.personalMonth);
                        });

                        chartTwo.setOption({
                            title: {
                                text: '办理效能(小时)'
                            },
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                }
                            },
                            legend: {
                                data: ['公司平均', '个人']
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis: {
                                type: 'category',
                                data: xAxisData
                            },
                            yAxis: {
                                type: 'value',
                                boundaryGap: [0, 0.01]
                            },
                            series: [
                                {
                                    name: '公司平均',
                                    type: 'bar',
                                    data: gobalData
                                },
                                {
                                    name: '个人',
                                    type: 'bar',
                                    data: personalData
                                }
                            ]
                        }, true);
                    } else {
                        chartTwo.setOption({}, true);
                    }
                });
            }

		</script>
	</body>
</html>
