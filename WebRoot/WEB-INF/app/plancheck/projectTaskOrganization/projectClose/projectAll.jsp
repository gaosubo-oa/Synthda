<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/6/28
  Time: 13:48
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
		<title>项目关闭</title>
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">
		
<%--		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
		<%--		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/excel.js"></script>--%>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
		
		<style>
			
			html, body {
				width: 100%;
				height: 100%;
				background: #fff;
				user-select: none;
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
			
			.query {
				padding: 10px 0;
			}
			
			.query input, select {
				height: 35px;
			}
			
			.query .layui-form-label {
				width: 110px;
				height: 35px;
				padding: 0 15px;
				line-height: 35px;
				box-sizing: border-box;
			}
			
			.query .layui-form-item {
				height: 35px;
				margin: 0;
				clear: none;
			}
			
			.query .query_button_group {
				/*height: 100%;*/
				margin-top: 2px;
			}
			
			/*.query .query_btn {*/
			/*	float: right;*/
			/*	width: 55px;*/
			/*	margin-right: 20px;*/
			/*	margin-left: 0;*/
			/*}*/
			
			.layui-tab-content {
				padding: 0;
			}
			
			.titleSp {
				padding-left: 10px;
				font-size: 18px;
				cursor: pointer;
			}
			
			.ew-tree-table {
				margin: 0 !important;
			}
			
			.ew-tree-table-tool-right {
				display: none;
			}
			
			.layui-table-tool {
				height: 38px;
				min-height: 38px;
				padding: 3px 15px;
			}
			
			.layui-table-tool-self {
				top: 5px;
			}
			
			.layui-table-tool-temp {
				padding: 0;
			}
			
			.layui-treeSelect-body .button.switch {
				top: 1px !important;
			}
			
			.divShow {
				position: relative;
			}
			
			.operationDiv {
				display: none;
				position: absolute;
				top: -40px;
				left: 5px;
				border-radius: 5px;
				background: #fff;
				box-shadow: 0 0 3px 1px rgba(0, 0, 0, .3);
			}
			
			.divShow:hover .operationDiv {
				display: block;
			}
			
			.td_title {
				background: #F2F2F2;
				width: 150px;
			}
		
		</style>
		
		<script type="text/javascript">
            var funcUrl = location.pathname;
            var authorityObject = null;
            if (funcUrl) {
                $.ajax({
                    type: 'GET',
                    url: '/plcPriv/findPermissions',
                    data: {
                        funcUrl: funcUrl
                    },
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        if (res.flag) {
                            if (res.object && res.object.length > 0) {
                                authorityObject = {}
                                res.object.forEach(function (item) {
                                    authorityObject[item] = item;
                                });
                            }
                        }
                    },
                    error: function () {

                    }
                });
            }
		</script>
	
	</head>
	<body>
		<div class="container" style="padding-top: 10px;box-sizing: border-box">
			<%--<div class="header">
				<div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px">
                        <img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt="">
                        <span style="margin-left: 10px">项目关闭</span>
                    </span>
				</div>
			</div>
			<hr>--%>
			<div class="layui-tab layui-tab-brief" lay-filter="projectTabs">
				<ul class="layui-tab-title">
					<li class="layui-this">项目</li>
					<li projectstatus="0">在建</li>
					<li projectstatus="1">竣工</li>
					<li projectstatus="2">收尾</li>
					<li projectstatus="3">关闭</li>
				</ul>
				<div class="layui-tab-content">
					<div class="layui-tab-item layui-show">
						<input type="hidden" id="planId">
						<input type="hidden" id="planName">
						<div class="theParentBox" style="min-height: 500px;">
							<form class="layui-form query layui-row">
								<div class="layui-form-item layui-col-xs2">
									<label class="layui-form-label">项目名称:</label>
									<div class="layui-input-block">
										<input type="text" name="projectName" placeholder="请输入项目名称" autocomplete="off"
										       class="layui-input" style="width: 120px;">
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">所属单位:</label>
									<div class="layui-input-block">
										<select name="ownerUnit">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">项目地点:</label>
									<div class="layui-input-block">
										<select name="projectArea">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">项目类型:</label>
									<div class="layui-input-block">
										<select name="projectType"></select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">中标时间:</label>
									<div class="layui-input-block">
										<input type="text" id="queryWinTime" name="queryWinTime" readonly
										       placeholder="请选择中标时间" class="layui-input" style="width: 120px;">
									</div>
								</div>
								<div class="query_button_group layui-col-xs2" style="display: none;">
									<button type="reset" id="resetBtn" class="layui-btn layui-btn-sm query_btn" style="float: right;margin: 0 20px 0 10px;">重置
									</button>
									<button type="button" class="layui-btn layui-btn-sm query_btn search_one" style="float: right;">查询</button>
								</div>
							</form>
							<div class="project" style="padding: 0 20px;">
								<table id="projectTable" lay-filter="projectTable"></table>
							</div>
						</div>
						<div style="display: none;" class="theChildBox" style="min-height: 500px;">
							<form class="layui-form query layui-row">
								<div class="layui-form-item layui-col-xs2">
									<label class="layui-form-label">项目名称:</label>
									<div class="layui-input-block">
										<input type="text" name="projName" autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-form-item layui-col-xs2">
									<label class="layui-form-label">所属单位:</label>
									<div class="layui-input-block">
										<select name="ownerUnit" class="deptName" lay-verify="required">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">计划类型:</label>
									<div class="layui-input-block">
										<select name="planType" class="planType" lay-verify="required">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">年度:</label>
									<div class="layui-input-block">
										<select name="year" lay-filter="year">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">月度:</label>
									<div class="layui-input-block">
										<select name="month"></select>
									</div>
								</div>
								<div class="query_button_group layui-col-xs2" style="display: none;">
									<button type="button" class="layui-btn layui-btn-sm query_btn" style="float:right; margin: 0 20px 0 10px;">
										<i class="layui-icon layui-icon-spread-left icon"></i>
									</button>
									<button type="reset" id="resetChildBtn" class="layui-btn layui-btn-sm query_btn" style="float: right;">
										重置
									</button>
									<button type="button" class="layui-btn layui-btn-sm query_btn search_two" style="float: right;">查询</button>
								</div>
							</form>
							<div id="theChildPlanBox" style="padding: 0 20px;">
								<table id="theChildPlan" lay-filter="theChildPlan"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="projectBar">
			<div class="clearfix parent_tool_bar">
				{{# if(authorityObject && authorityObject['35']){ }}
				<a class="layui-btn layui-btn-sm" style="float: right; margin-right: 45px;" lay-event="filing">归档</a>
				{{# } }}
				{{# if(authorityObject && authorityObject['36']){ }}
				<a class="layui-btn layui-btn-sm" style="float: right; margin: 0 10px 0 0;" lay-event="summarizeExperience">经验总结</a>
				{{# } }}
			</div>
		</script>
		
		<script type="text/html" id="childDemo">
			<div>
				<span><i class="layui-icon layui-icon-next" style="color: green"></i><span
						class="titleSp" style="color: blue;"></span></span>
				{{# if(authorityObject && authorityObject['37']){ }}
				<a class="layui-btn layui-btn-sm" style="float: right; margin-right: 45px;"
				   lay-event="transformTemplate">转模板</a>
				{{# } }}
			</div>
		</script>
		
		<script type="text/javascript">

            initAuthority()

            var dictionaryObj = {
                PLAN_SYCLE: {},
                PLAN_TYPE: {},
                UNIT: {},
                PLAN_PHASE: {},
                CONTROL_LEVEL: {},
                CGCL_TYPE: {},
                RENWUJIHUA_TYPE: {},
                TG_TYPE: {}
            }
            var dictionaryStr = 'PLAN_SYCLE,PLAN_TYPE,UNIT,PLAN_PHASE,CONTROL_LEVEL,CGCL_TYPE,RENWUJIHUA_TYPE,TG_TYPE';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                            });
                        }
                    }
                }
                init();
            });

            //删除附件
            $(document).on('click', '.deImgs', function () {
                var _this = this;
                var attUrl = $(this).parents('.dech').attr('deUrl');
                layer.confirm('确定删除该附件吗？', function (index) {
                    $.ajax({
                        type: 'get',
                        url: '/delete?' + attUrl,
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag == true) {
                                layer.msg('删除成功', {icon: 1, time: 1000});
                                $(_this).parent().remove();
                            } else {
                                layer.msg('删除失败', {icon: 2, time: 1000});
                            }
                        }
                    });
                });
            });

            function init() {
                layui.use(['element', 'form', 'table', 'treeTable', 'laydate', 'soulTable', 'treeSelect', 'upload'], function () {
                    var form = layui.form,
                        table = layui.table,
                        element = layui.element,
                        treeTable = layui.treeTable,
                        laydate = layui.laydate,
                        soulTable = layui.soulTable,
                        treeSelect = layui.treeSelect,
                        upload = layui.upload;

                    var projectTable = null;

                    var initTreeTable = null;

                    // 获取项目地点数据
                    $.get('/ProjectInfo/selectInfoPlace', function (res) {
                        var projectPlace = res.obj;
                        var str = '<option value="">请选择</option>';
                        for (var i = 0; i < projectPlace.length; i++) {
                            str += '<option value="' + projectPlace[i].projectPlace + '">' + projectPlace[i].projectPlace + '</option>';
                        }
                        $('.query select[name="projectArea"]').html(str);
                        form.render();
                    });

                    // 获取项目类型数据
                    $.get('/ProjectInfo/selectProjectTypeByNo', function (res) {
                        var projectType = res.data;
                        var str = '<option value="">请选择</option>';
                        for (var i = 0; i < projectType.length; i++) {
                            str += '<option value="' + projectType[i].dictNo + '">' + projectType[i].dictName + '</option>';
                            // projectTypeObj[projectType[i].dictNo] = projectType[i].dictName;
                        }
                        $('.query select[name="projectType"]').html(str);
                        form.render();
                    });

                    // 获取所属单位数据
                    $.get('/plcOrg/selectYJ', function (res) {
                        var data = res.obj;
                        var str1 = '<option value="">请选择</option>';
                        for (var i = 0; i < data.length; i++) {
                            str1 += '<option value="' + data[i].projOrgId + '">' + data[i].contractorName + '</option>';
                        }
                        $('.query [name="ownerUnit"]').html(str1);
                        form.render();
                    });

                    //中标时间
                    laydate.render({
                        elem: '#queryWinTime' //指定元素
                    });

                    form.render();

                    initProjectTable();

                    // 切换项目
                    element.on('tab(projectTabs)', function (data) {

                        $('.theChildBox').hide();
                        $('.theParentBox').show();

                        // 重置查询表单
                        $('#resetBtn').trigger('click');
                        $('#resetChildBtn').trigger('click');

                        var projectStatus = $(this).attr('projectstatus') || '';

                        var toolBar = '';

                        if (projectStatus == 3) {
                            toolBar = '#projectBar';
                        }

                        initProjectTable(projectStatus, toolBar);
                    });

                    //子表-表标点击事件
                    $(document).on('click', '.titleSp', function () {
                        $('.theChildBox').hide();
                        $('.theParentBox').show();
                    });

                    //查看关键任务填报详情
                    $(document).on('click', '.target_detail', function () {
                        var tgId = $(this).attr('tgId')
                        $.ajax({
                            url: '/ProjectDaily/selectProjectDailyByItemId',
                            dataType: 'json',
                            type: 'get',
                            data: {tgId: tgId},
                            success: function (res) {
                                var data = res.data;
                                var targetData = res.object;
                                layer.open({
                                    type: 1,
                                    title: '填报详情',
                                    area: ['70%', '90%'],
                                    maxmin: true,
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: '<div id="target_detail" style="margin:10px"></div>',
                                    success: function () {
                                        var dayReport = '';

                                        if (!!targetData) {
                                            dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">关键任务详情</h3><table class="layui-table">' +
                                                '<tbody>' +
                                                '<tr>' +
                                                '<td class="td_title">关键任务编号</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.tgNo) + '</td>' +
                                                '<td class="td_title">关键任务名称</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.tgName) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">关注等级</td>' +
                                                '<td colspan="1">' + isShowNull(dictionaryObj['CONTROL_LEVEL']['object'][targetData.controlLevel]) + '</td>' +
                                                '<td class="td_title">周期类型</td>' +
                                                '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][targetData.planSycle]) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">关键任务类型</td>' +
                                                '<td colspan="1">' + isShowNull(dictionaryObj['TG_TYPE']['object'][targetData.tgType]) + '</td>' +
                                                '<td class="td_title">计划阶段</td>' +
                                                '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_PHASE']['object'][targetData.planStage]) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">设计量</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.designQuantity) + '</td>' +
                                                '<td class="td_title">工程量</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.itemQuantity) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">单位</td>' +
                                                '<td colspan="1">' + isShowNull(dictionaryObj['UNIT']['object'][targetData.itemQuantityNuit]) + '</td>' +
                                                '<td class="td_title">完成标准</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.resultStandard) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">负责人</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.dutyUserName).replace(/,$/, '') + '</td>' +
                                                '<td class="td_title">中心责任部门</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.mainCenterDeptName).replace(/,$/, '') + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">计划开始时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.planStartDate) {
                                                        return format(targetData.planStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">计划结束时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.planEndDate) {
                                                        return format(targetData.planEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">计划工期</td>' +
                                                '<td>' + isShowNull(targetData.planContinuedDate) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">实际开始时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.realStartDate) {
                                                        return format(targetData.realStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">实际结束时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.realEndDate) {
                                                        return format(targetData.realEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">实际工期</td>' +
                                                '<td>' + isShowNull(targetData.realContinuedDate) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">区域责任部门</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.mainAreaDeptName).replace(/,$/, '') + '</td>' +
                                                '<td class="td_title">总承包部责任部门</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.mainProjectDeptName).replace(/,$/, '') + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">难度系数</td>' +
                                                '<td>' + isShowNull(targetData.hardDegree) + '</td>' +
                                                '<td class="td_title">风险点</td>' +
                                                '<td>' + isShowNull(targetData.riskPoint) + '</td>' +
                                                '<td class="td_title">难度点</td>' +
                                                '<td>' + isShowNull(targetData.difficultPoint) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">提交的成果材料</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    if (!!targetData.attachments2 && targetData.attachments2.length > 0) {
                                                        var str = '';

                                                        targetData.attachments2.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() +
                                                '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">异常原因</td>' +
                                                '<td colspan="5">' + isShowNull(targetData.unusualRes) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">异常原因材料</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    if (!!targetData.attachments3 && targetData.attachments3.length > 0) {
                                                        var str = '';

                                                        targetData.attachments3.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() +
                                                '</td>' +
                                                '</tr>' +
                                                '</tbody>' +
                                                '</table>'
                                        }
                                        dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">关键任务填报信息</h3>';
                                        for (var i = 0; i < data.length; i++) {
                                            dayReport += '<table class="layui-table" style="margin-bottom: 5px">\n' +
                                                '  <tbody>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">每日填报人</td>\n' +
                                                '      <td>' + empty(data[i].ctreateUserName) + '</td>\n' +
                                                '      <td class="td_title">时间</td>\n' +
                                                '      <td>' + empty(data[i].ctreateTime) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">增加协作人</td>\n' +
                                                '      <td>' + empty(data[i].assistUserName) + '</td>\n' +
                                                '      <td class="td_title">当日完成量</td>\n' +
                                                '      <td>' + function () {
                                                    if (data[i].assistUserName || data[i].transfer) {
                                                        return '—'
                                                    } else {
                                                        return data[i].tadayProgress + '%'
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">转办</td>\n' +
                                                '      <td colspan="3">' + empty(data[i].transfer) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">进展日志</td>\n' +
                                                '      <td colspan="3">' + empty(data[i].tadayDesc) + '</td>\n' +
                                                '    </tr>\n' +
                                                '  </tbody>\n' +
                                                '</table>'
                                        }
                                        $('#target_detail').append(dayReport)
                                    }
                                })
                            }
                        })
                    });

                    // 外层查询
                    $('.search_one').on('click',function () {
                        var data = {_: new Date().getTime()};
                        var $queryEle = $('.theParentBox .query').find('[name]');
                        $queryEle.each(function (v, e) {
                            var key = $(e).attr('name');
                            var value = $(e).val();
                            data[key] = value ? value.trim() : '';
                        });
                        var configWhere = projectTable.config.where;
                        projectTable.reload({
                            where: $.extend({}, configWhere, data),
                            cur: {
                                page: 1
                            },
                            done: function (res) {
                                soulTable.render(this);
                            }
                        });
                    });

                    // 内层查询
                    $('.search_two').on('click',function () {
                        var searchData = {
                            parentPbagId: 0,
                            projectId: $('#planId').val()
                        }
                        var $queryEle = $('.theChildBox .query').find('[name]');
                        $queryEle.each(function (v, e) {
                            var key = $(e).attr('name');
                            var value = $(e).val();
                            searchData[key] = value ? value.trim() : '';
                        });
                        initTaskTable(searchData, function () {
                            $('.titleSp').text($('#planName').val());
                        });
                    });

                    /***
                     * 加载项目列表
                     * @param projectInfoStatus (项目进展状态 0-在建,1-收尾,2-竣工,3-关闭, 传空为显示全部)
                     * @param toolBar (头部工具条参数)
                     */
                    function initProjectTable(projectInfoStatus, toolBar) {
                        if (!projectTable) {
                            projectTable = table.render({
                                elem: '#projectTable',
                                url: '/plcPlan/getAllProjectInfo',
                                page: true,
                                cols: [[ //表头
                                    {type: 'checkbox'},
                                    {
                                        field: 'planName',
                                        title: '名称',
                                        align: 'left',
                                        event: 'nameLink',
                                        width: 500,
                                        style: 'cursor: pointer;'
                                        , templet: function (d) {
                                            return '<a style="color: blue;text-decoration: underline;">' + d.planName + '</a>'
                                        }
                                    },
                                    {
                                        field: 'planClass', title: '类型', templet: function (d) {
                                            var str = '';
                                            switch (d.planClass) {
                                                case '1':
                                                    str = '主项关键任务';
                                                    break;
                                                case '2':
                                                    str = '职能关键任务';
                                                    break;
                                                case '3':
                                                    str = '子任务计划';
                                                    break;
                                                default:
                                                    break;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'planCycle', title: '周期类型', templet: function (d) {
                                            return dictionaryObj['PLAN_SYCLE']['object'][d.planCycle] || '';
                                        }
                                    },
                                    {
                                        field: 'planType', title: '计划类型', templet: function (d) {
                                            if (d.planClass == 3) {
                                                return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.planType] || '';
                                            } else {
                                                return dictionaryObj['TG_TYPE']['object'][d.planType] || '';
                                            }
                                        }
                                    },
                                    {
                                        field: 'planYear', title: '年度'
                                    },
                                    {
                                        field: 'planMonth', title: '月度'
                                    },
                                    {field: 'dutyUserName', title: '责任人'},
                                    {field: 'belongtoUnitName', title: '所属单位'}
                                ]],
	                            limit: 50,
	                            height: 'full-120',
                                toolbar: toolBar || true,
                                defaultToolbar: ['filter'],
                                where: {
                                    projectInfoStatus: projectInfoStatus,
                                    _: new Date().getTime()
                                },
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    countName: 'totleNum',
                                    dataName: 'obj'
                                },
                                done: function () {
                                    soulTable.render(this);
                                }
                            });
                        } else {
                            projectTable.config.where = {
                                projectInfoStatus: projectInfoStatus,
                                _: new Date().getTime()
                            }
                            projectTable.reload({
                                toolbar: toolBar || true,
                                where: {
                                    projectInfoStatus: projectInfoStatus,
                                    _: new Date().getTime()
                                },
                                cur: {
                                    page: 1
                                },
                                done: function () {
                                    soulTable.render(this);
                                }
                            });
                        }
                    }

                    // 监听列表点击 
                    table.on('tool(projectTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;

                        switch (layEvent) {
                            case 'nameLink':// 点击项目名称
                                // 重置查询表单
                                $('#resetChildBtn').trigger('click');
                                $('#planId').val(data.belongtoProj);
                                $('#planName').val(data.planName);
                                var searchData = {
                                    parentPbagId: 0,
                                    projectId: data.belongtoProj
                                }
                                initTaskTable(searchData, function () {
                                    $('.titleSp').text(data.planName);
                                    $('.theChildBox').show();
                                    $('.theParentBox').hide();
                                });
                                break;
                        }
                    });

                    // 监听头部工具条点击
                    table.on('toolbar(projectTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;

                        var checkStatus = table.checkStatus('projectTable');

                        switch (layEvent) {
                            case 'summarizeExperience': // 经验总结

                                if (checkStatus.data.length == 0) {
                                    layer.msg('请选中至少一条数据！', {icon: 0, time: 1000});
                                    return false;
                                }

                                layer.open({
                                    type: 1,
                                    title: '经验总结',
                                    area: ['520px', '450px'],
                                    btn: ['保存', '退出'],
                                    content: '<div style="padding: 20px;">' +
                                        '<form class="layui-form" action="" lay-filter="example">' +
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">项目经验<b style="color: red">*</b></label>' +
                                        '<div class="layui-input-block">' +
                                        '<textarea name="experience" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                                        '</div>' +
                                        '</div>' +
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">项目经验附件<b style="color: red">*</b></label>' +
                                        '<div class="layui-input-block">' +
                                        '<div id="attachmentFileBox"></div>' +
                                        '<a href="javascript:;" id="attachment" class="openFile" style="float: left;margin-top:8px;position:relative">' +
                                        '<img src="/img/mg11.png" style="margin-top: -1px;">' +
                                        '<span style="margin-left: 5px;"><fmt:message code="email.th.addfile"/></span>' +
                                        '</a>' +
                                        '</div>' +
                                        '</div>' +
                                        '</form>' +
                                        '</div>',
                                    success: function () {
                                        // 初始化上传按钮
                                        var uploadInst = upload.render({
                                            elem: '#attachment', //绑定元素
                                            url: '/upload?module=plancheck', //上传接口
                                            done: function (res) {
                                                //上传完毕回调
                                                if (res.flag) {
                                                    if (res.obj) {
                                                        var data = res.obj;
                                                        var str = '';
                                                        for (var i = 0; i < data.length; i++) {
                                                            var gs = data[i].attachName.split('.')[1];
                                                            if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') { //后缀为这些的禁止上传
                                                                str += '';
                                                                layer.msg('jsp、css、js、html、java文件禁止上传!', {
                                                                    icon: 0,
                                                                    time: 1000
                                                                });
                                                            } else {
                                                                var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                                                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;

                                                                str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                                            }
                                                        }

                                                        $('#attachmentFileBox').append(str);
                                                    } else {
                                                        layer.msg('添加附件大小不能为空!', {icon: 0, time: 1000});
                                                    }
                                                } else {
                                                    layer.msg('上传失败!', {icon: 2, time: 1000});
                                                }
                                            },
                                            error: function () {
                                                //请求异常回调
                                                layer.msg('上传失败!', {icon: 2, time: 1000});
                                            }
                                        });
                                    },
                                    yes: function (index) {

                                        var experience = $('[name="experience"]').val().trim();

                                        if (!experience) {
                                            layer.msg('请输入项目经验', {icon: 0, time: 1000});
                                            return false;
                                        }

                                        //保存附件信息
                                        var experienceAttachmentId = '';
                                        var experienceAttachmentName = '';
                                        $('#attachment3FileBox .dech').each(function () {
                                            experienceAttachmentId += $(this).find('input').val();
                                            experienceAttachmentName += $(this).find('a').attr('name');
                                        });

                                        if (!experienceAttachmentId) {
                                            layer.msg('请上传项目经验附件', {icon: 0, time: 1000});
                                            return false;
                                        }

                                        var projectId = '';
                                        data.forEach(function (item) {
                                            projectId += item.belongtoProj + ',';
                                        });

                                        $.post('/ProjectInfo/updateExperience', {
                                            experience: experience,
                                            experienceAttachmentId: experienceAttachmentId,
                                            experienceAttachmentName: experienceAttachmentName,
                                            projectId: projectId
                                        }, function (res) {
                                            if (res.flag) {
                                                layer.msg('保存成功！', {icon: 1, time: 1000});
                                                layer.close(index);
                                            } else {
                                                layer.msg('保存失败！', {icon: 2, time: 1000});
                                            }
                                        });
                                    }
                                });
                                break;
                            case 'filing': // 归档
                                if (checkStatus.data.length == 0) {
                                    layer.msg('请选中至少一条数据！', {icon: 0, time: 1000});
                                    return false;
                                }
                                break;
                        }
                    });

                    // 监听树列表头部点击事件
                    treeTable.on('toolbar(theChildPlan)', function (obj) {
                        var ids = '';
                        initTreeTable.checkStatus().forEach(function (v, i) {
                            if (v.tgId) {
                                ids += (v.tgId) + ',';
                            }
                        });

                        if (!ids) {
                            layer.msg('请至少选择一项关键任务！', {icon: 0, time: 1000});
                            return false;
                        }

                        switch (obj.event) {
                            case 'transformTemplate': // 转换模板
                                layer.open({
                                    type: 1,
                                    title: '转模板',
                                    area: ['550px', '500px'],
                                    btn: ['保存', '退出'],
                                    content: '<div style="padding: 20px;">' +
                                        '<form class="layui-form" action="" lay-filter="example">' +
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">父级模板<b style="color: red">*</b></label>' +
                                        ' <div class="layui-input-block">' +
                                        '<input type="text" id="tree" lay-filter="tree" readonly placeholder="请选择父级模板" autocomplete="off" class="layui-input">' +
                                        '<input type="hidden" title="父级模板" id="parentTypeId" class="layui-input testNull">' +
                                        ' </div>' +
                                        ' </div>' +
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">编号<b style="color: red">*</b></label>' +
                                        ' <div class="layui-input-block">' +
                                        ' <input type="text" name="typeNo" lay-verify="title" autocomplete="off"  class="layui-input testNull" title="编号" readonly style="background:#e7e7e7;">' +
                                        ' </div>' +
                                        ' </div>' +
                                        ' <div class="layui-form-item">' +
                                        ' <label class="layui-form-label">模板名称<b style="color: red">*</b></label>' +
                                        '<div class="layui-input-block">' +
                                        '<input type="type" name="typeName" autocomplete="off" class="layui-input testNull" title="模板名称" >' +
                                        ' </div>' +
                                        ' </div>' +
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">模板类型<b style="color: red">*</b></label>' +
                                        ' <div class="layui-input-block">' +
                                        '  <select name="tplType" id="tplType" lay-filter="tplType" class="testNull" title="模板类型">' +
                                        '   <option value="">请选择</option>' +
                                        ' </select>' +
                                        ' </div>' +
                                        ' </div>' +
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">所属上级<b style="color: red">*</b></label>' +
                                        ' <div class="layui-input-block">' +
                                        '<input type="type" name="parentName" autocomplete="off" class="layui-input testNull" title="所属上级" readonly style="background:#e7e7e7;">' +
                                        ' </div>' +
                                        ' </div>' +
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label" style="padding: 0;width: 100px;">模板类型描述</label>' +
                                        ' <div class="layui-input-block">' +
                                        '<textarea type="type" style="height: 60px" name="tplTypeDesc" autocomplete="off" class="layui-input"></textarea>' +
                                        ' </select>' +
                                        ' </div>' +
                                        ' </div>' +
                                        '</form></div>'
                                    , success: function () {
                                        //编号
                                        $.get('/ProjectInfo/getMaxNo', {model: 'templateType'}, function (res) {
                                            $('input[name="typeNo"]').val(res);
                                        });

                                        //项目类型
                                        $.ajax({
                                            url: '/ProjectInfo/selectProjectTypeByNo',
                                            dataType: 'json',
                                            type: 'get',
                                            success: function (res) {
                                                var obj = res.data;
                                                var str = '';
                                                for (var i = 0; i < obj.length; i++) {
                                                    str += '<option value="' + obj[i].dictId + '">' + obj[i].dictName + '</option>';
                                                }
                                                $('[name="tplType"]').append(str);

                                                form.render('select');
                                            }
                                        });

                                        //所属上级-默认为一级
                                        $.get('/TemplateType/selectNameByParentId?tplTypeId=0', function (res) {
                                            $('input[name="parentName"]').val(res.data);
                                        });

                                        treeSelect.render({
                                            elem: '#tree',
                                            data: '/TemplateType/getAlltype',
                                            placeholder: '请选择父级模板',
                                            style: {   // 一些可定制的样式
                                                folder: {enable: true},
                                                line: {enable: true}
                                            },
                                            click: function (d) {
                                                $('#parentTypeId').val(d.current.id);
                                                $('input[name="parentName"]').val(d.current.name);
                                            }
                                        });
                                    },
                                    yes: function (index) {
                                        //必填项提示
                                        for (var i = 0; i < $('.testNull').length; i++) {
                                            if ($('.testNull').eq(i).val() == '') {
                                                layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0, time: 1000});
                                                return false;
                                            }
                                        }

                                        $.ajax({
                                            url: '/TemplateType/insertTypeAndImport',
                                            dataType: 'json',
                                            type: 'post',
                                            data: {
                                                parentTypeId: $('#parentTypeId').val(),
                                                typeNo: $('[name="typeNo"]').val(),
                                                typeName: $('[name="typeName"]').val(),
                                                tplType: $('[name="tplType"]').val(),
                                                tplTypeDesc: $('[name="tplTypeDesc"]').val(),
                                                targetId: ids
                                            },
                                            success: function (res) {
                                                if (res.flag) {
                                                    layer.msg('保存成功！', {icon: 1, time: 1000});
                                                    layer.close(index);
                                                    var searchData = {
                                                        parentPbagId: 0,
                                                        projectId: $('#planId').val()
                                                    }
                                                    initTaskTable(searchData, function () {
                                                        $('.titleSp').text($('#planName').val());
                                                    });
                                                } else {
                                                    layer.msg('保存失败！', {icon: 2, time: 1000});
                                                }
                                            }
                                        });
                                    }
                                });
                                break;
                        }

                    });

                    /**
                     * 渲染关键任务、子任务列表方法
                     * @param id (所属项目id)
                     * @param fn (回调函数)
                     */
                    function initTaskTable(searchData, fn) {
                        $('#targetTableBox').hide();
                        $('#theChildPlanBox').show();
                        $.get('/plcProjectBag/queryInfoBagTarget', searchData, function (res) {
                            var data = [];
                            if (res.flag) {
                                data = getTreeData(res.object);
                            }
                            initTreeTable = treeTable.render({
                                elem: '#theChildPlan',
                                data: data,
                                page: true, //开启分页
                                toolbar: '#childDemo',
                                defaultToolbar: ['filter'],
	                            height: 'full-300',
                                tree: {
                                    iconIndex: 1,
                                    // isPidData: true,
                                    idName: 'id',
                                    childName: 'children'
                                },
                                cols: [[
                                    {type: 'checkbox'},
                                    {
                                        field: 'tgNo', title: '编码', width: 300, templet: function (d) {
                                            if (d.projectNo) {
                                                return '<span>' + d.projectNo + '</span>'
                                            } else if (d.bagNumber) {
                                                return '<span>' + d.bagNumber + '</span>'
                                            } else if (d.tgNo) {
                                                return '<span>' + d.tgNo + '</span>'
                                            } else {
                                                return ''
                                            }
                                        }
                                    },
                                    {
                                        field: 'tgName', title: '子项目/关键任务名称', width: 400, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '<span id="' + d.id + '">【项目】' + d.pbagName + '</span>'
                                            } else {
                                                return '<span class="target_detail" style="color: blue; cursor: pointer;" tgId="' + d.tgId + '" id="' + d.id + '">【关键任务】' + d.tgName + '</span>'
                                            }
                                        }
                                    },
                                    {
                                        field: 'controlLevel',
                                        title: '关注等级',
                                        width: 150,
                                        templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'planSycle', title: '周期类型', width: 200, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'tgType', title: '计划类型', width: 90, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return dictionaryObj['TG_TYPE']['object'][d.tgType] || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'planStage', title: '计划阶段', width: 90, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'designQuantity', title: '设计量', width: 150, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.designQuantity || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'itemQuantity', title: '工程量', width: 90, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.itemQuantity || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'itemQuantityNuit', title: '单位', width: 100, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'dutyUserName', title: '责任人', width: 130, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.dutyUserName || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'mainCenterDeptName',
                                        title: '所属部门',
                                        width: 150,
                                        templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.mainCenterDeptName || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'planContinuedDate',
                                        title: '计划工期',
                                        width: 100,
                                        templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.planContinuedDate || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'planStartDate', title: '计划开始时间', width: 130, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return format(d.planStartDate) || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'planEndDate', title: '计划完成时间', width: 130, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return format(d.planEndDate) || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'resultStandard', title: '完成标准', width: 100, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.resultStandard || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'riskPoint', title: '风险点', width: 130, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.riskPoint || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'resultDict', title: '成果标准模板', width: 130, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                var resultDictName = '';
                                                if (!!d.resultDict) {
                                                    var resultDictList = d.resultDict.split(',');

                                                    resultDictList.forEach(function (item) {
                                                        resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                                    });
                                                }

                                                return resultDictName.replace(/,$/, '');
                                            }
                                        }
                                    }
                                    , {
                                        field: 'difficultPoint', title: '难度点', width: 90, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.difficultPoint || '';
                                            }
                                        }
                                    }
                                    , {
                                        field: 'tgDesc', title: '关键任务描述', width: 130, templet: function (d) {
                                            if (d.tgId == '' || d.tgId == undefined) {
                                                return '';
                                            } else {
                                                return d.tgDesc || '';
                                            }
                                        }
                                    }
                                ]]
                            });
                            if (fn) {
                                fn();
                            }
                        });
                    }
                });
            }

            //判断是否该为空
            function isUndefined(data) {
                if (data == 1) {
                    return '是'
                } else if (data == 0) {
                    return '否'
                } else {
                    return ''
                }
            }

            /**
             * 将毫秒数转为yyyy-MM-dd格式时间
             * @param t 时间
             * @returns {string}
             */
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            /**
             * 处理主项关键任务的数据为树结构
             * @param data 主项关键任务数据
             * @returns {[]} 返回树结构数组
             */
            function getTreeData(data) {
                var treeData = [];
                treeData = data.bags.concat(data.plcTarget);
                return treeData;
            }

            // 初始化页面操作权限
            function initAuthority() {
                // 是否设置页面权限
                if (authorityObject) {
                    // 检查查询权限
                    if (authorityObject['09']) {
                        $('.query_button_group').show();
                    }
                }
            }

            //判断是否显示空
            function isShowNull(data) {
                if (!!data) {
                    return data
                } else {
                    return ''
                }
            }

            //判断返回是否为空
            function empty(esName) {
                if (esName != undefined) {
                    return esName
                } else {
                    return ''
                }
            }

            // 附件查阅
            $(document).on('click', '.yulan', function () {
                var url = $(this).attr('data-url');
                pdurl($.UrlGetRequest('?' + url), url);
            });
		
		</script>
	
	</body>
</html>
