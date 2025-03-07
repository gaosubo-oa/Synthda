<%--
  Created by IntelliJ IDEA.
  User: 96394
  Date: 2020/6/12
  Time: 16:23
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
	<title>主项计划</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">

	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<script type="text/javascript" src="/js/common/fileupload.js"></script>

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

		.con_left {
			float: left;
			width: 230px;
			height: 100%;
		}

		.con_right {
			float: left;
			position: relative;
			width: calc(100% - 230px);
			height: 100%;
			padding-left: 10px;
			box-sizing: border-box;
		}

		.con_right .layui-table-view {
			margin: 0;
		}

		.query_form {
			padding: 10px 0;
			margin: 0;
		}

		.query_form .layui-form-item {
			clear: none;
			margin-bottom: 0px;
			height: 35px;
		}

		.query_form .layui-form-item .layui-form-label {
			height: 35px;
			padding: 0 15px;
			line-height: 35px;
		}

		.query_form .layui-form-item .layui-input-block {
			min-height: 35px;
		}

		.query_form .layui-form-item input, .query_form .layui-form-item select {
			height: 35px;
		}

		.query .query_button_group {
			margin-top: 2px;
		}

		.query_button_group .query_button {
			float: right;
		}

		.foldIcon {
			/*display: none;*/
			position: absolute;
			left: -11px;
			top: 42%;
			font-size: 30px;
			cursor: pointer;
		}

		.con_left ul li {
			padding: 5px;
		}

		.ew-tree-table .ew-tree-table-tool .ew-tree-table-tool-right {
			display: none;
		}

		.layui-btn-container {
			position: relative;
		}

		.layui-layer-btn {
			text-align: center;
		}

		.openFile input[type=file] {
			position: absolute;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			width: 100%;
			height: 18px;
			z-index: 99;
			opacity: 0;
		}

		.bar {
			height: 18px;
			background: green;
		}

		.layui-table-tool-temp {
			padding: 3px 15px;
			height: 38px;
		}

		.required_field {
			margin-right: 2px;
			font-size: 25px;
			line-height: 20px;
			vertical-align: text-top;
			color: red;
		}

		.target_module_tree {
			position: absolute;
			top: 41px;
			right: 0;
			bottom: 0;
			left: 0;
			overflow-x: auto;
		}

		.project_item {
			position: absolute;
			top: 5px;
			right: 15px;
			bottom: 10px;
			left: 250px;
		}

		.project_item .layui-table-view {
			margin: 0;
		}

		.layui-table-tool {
			min-height: 38px;
			height: 38px;
			padding: 0;
			box-sizing: border-box;
		}

		.layui-table-tool-self {
			top: 2px;
		}

		.td_title {
			width: 200px;
			background-color: #e7e7e7;
			border-color: #ccc !important;
		}

		.select{
			background: #eee;
		}

		/*附件详情--start*/
		.operationDiv {
			display: none;
			position: absolute;
			top: -50px;
			left: 5px;
			background: #fff;
			box-shadow: 0 0 5px 0 rgb(0, 0, 0);
			border-radius: 5px;
		}
		.divShow {
			position: relative;
		}
		.divShow:hover .operationDiv {
			display: block;
		}
		/*附件详情--end*/

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
<div class="container">
	<input type="hidden" id="leftId">
	<%--限制关键任务新建时间--%>
	<input type="hidden" id="plan_time">
	<form class="layui-form layui-row query_form" lay-filter="queryForm">
		<div class="layui-form-item layui-col-xs2">
			<label class="layui-form-label">关键任务名称：</label>
			<div class="layui-input-block">
				<input type="text" name="tgName" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item layui-col-xs2">
			<label class="layui-form-label">目标等级：</label>
			<div class="layui-input-block">
				<select name="tgGrade">
					<option value="">请选择</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item layui-col-xs2" style="width: 22%">
			<label class="layui-form-label" style="width: 100px">关键任务类型：</label>
			<div class="layui-input-block" style="margin-left: 132px">
				<%--<select name="tgType">
							<option value="">请选择</option>
						</select>--%>
				<input type="text" name="tgType" id="tgType_query" placeholder="请选择" readonly style="background-color: #e7e7e7;cursor: pointer;display: inline-block;width: 70%" class="layui-input">
				<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="tgTypeDel">清空</a>
			</div>
		</div>
		<div class="layui-form-item layui-col-xs2">
			<label class="layui-form-label">年度：</label>
			<div class="layui-input-block">
				<select name="year" lay-filter="year">
					<option value="">请选择</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item layui-col-xs2">
			<label class="layui-form-label">月度：</label>
			<div class="layui-input-block">
				<select name="month"></select>
			</div>
		</div>
		<div class="layui-col-xs2 query_button_group" style="display: none;width: 10%">
			<button type="reset" class="layui-btn layui-btn-sm query_button reset">重置</button>
			<button type="button" id="selectBtn" class="layui-btn layui-btn-sm query_button" style="margin-right: 10px">查询</button>
		</div>
	</form>
	<div style="padding: 0px 20px;" class="clearfix">
		<div class="con_left">
			<%--组织筛选--%>
			<div class="layui-form">
				<select name="deptName" lay-verify="required" lay-filter="deptName">
				</select>
			</div>
			<%--项目机构和项目信息--%>
			<div class="eleTree ele1" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeft"></div>
		</div>
		<div class="con_right">
			<div class="tishi" style="height: 100%;text-align: center;border: none;">
				<div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
				<h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧项目</h2>
			</div>
			<div class="table_box" style="display: none;">
				<table id="demo" lay-filter="demo"></table>
				<i class="layui-icon layui-icon-left foldIcon" title="折叠"></i>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container" style="height: 30px;">
		<%--				{{# if(authorityObject && authorityObject['07']){ }}--%>
		<button class="layui-btn layui-btn-sm" lay-event="initialization">初始化</button>
		<%--				{{# } }}--%>
		{{# if(authorityObject && authorityObject['21']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="report">提交</button>
		{{# } }}
		<%--暂时去掉修编和修编详情按钮--%>
		<%--{{#  if(authorityObject && authorityObject['06']){ }}
				<button class="layui-btn layui-btn-sm" lay-event="revision">修编</button>
				{{#  } }}
				{{#  if(authorityObject && authorityObject['39']){ }}
				<button class="layui-btn layui-btn-sm" lay-event="revisionDetail">修编详情</button>
				{{#  } }}--%>
		<div style="position:absolute;top: 0px;right: 45px;">
			<%--					{{#  if(authorityObject && authorityObject['01']){ }}--%>
			<%--					<button class="layui-btn layui-btn-sm" id="add" lay-event="add">新增</button>--%>
			<%--					{{#  } }}--%>
			<%--					{{#  if(authorityObject && authorityObject['19']){ }}--%>
			<%--					<button class="layui-btn layui-btn-sm" lay-event="submit">提交入库</button>--%>
			<%--					{{#  } }}--%>
			{{# if(authorityObject && authorityObject['05']){ }}
			<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
			{{# } }}
			{{# if(authorityObject && authorityObject['04']){ }}
			<button class="layui-btn layui-btn-sm" lay-event="del">删除</button>
			{{# } }}
			{{# if(authorityObject && authorityObject['02']){ }}
			<button class="layui-btn layui-btn-sm" lay-event="import">导入</button>
			{{# } }}
			{{# if(authorityObject && authorityObject['03']){ }}
			<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-right: 0;">导出</button>
			{{# } }}
		</div>
	</div>
</script>

<script type="text/javascript">
	/*左侧勾选的项目或子项目的id串*/
	var leftPbagIdArr = []
	var leftProjectIdArr = []
	/*初始化时勾选的tgId*/
	var tgIdsArr = []
	// var authorityObject = parent.authorityObject;

	initAuthority();

	$('.eleTree ').height($(window).height() - 130);
	var dictionaryObj = {
		PBAG_TYPE: {},
		PLAN_SYCLE: {},
		CONTROL_LEVEL: {},
		TG_TYPE: {},
		PLAN_PHASE: {},
		CGCL_TYPE: {},
		UNIT: {},
		ORGANIZATION_TYPE: {},
		TG_GRADE:{},
		DUTY_TYPE:{},
	}
	var dictionaryStr = 'PBAG_TYPE,PLAN_SYCLE,CONTROL_LEVEL,TG_TYPE,PLAN_PHASE,CGCL_TYPE,UNIT,ORGANIZATION_TYPE,TG_GRADE,DUTY_TYPE';
	var centerDutyType = '<option value="">请选择</option>'
	var areaDutyType = '<option value="">请选择</option>'
	// 获取数据字典数据
	$.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
		if (res.flag) {
			for (var dict in dictionaryObj) {
				dictionaryObj[dict] = {object: {}, str: ''}
				if (res.object[dict]) {
					res.object[dict].forEach(function (item) {
						dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
						dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
						if(item.parentNo == 'DUTY_TYPE'){
							centerDutyType += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
							areaDutyType += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
						}
					});
				}
			}
		}
		init();
	});

	//选人控件添加
	$(document).on('click', '.userAdd', function () {
		var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
		user_id = $(this).siblings('textarea').attr('id');
		if(user_id=='mainAreaUser' && !$('#mainAreaDept').attr('deptid')){
			layer.msg('请先选择区域责任部门！',{icon:0})
			return false
		}else if(user_id=='mainProjectUser' && !$('#mainProjectDept').attr('deptid')){
			layer.msg('请先选择总承包部责任部门！',{icon:0})
			return false
		}else{
			$.popWindow("/common/selectUser" + chooseNum);
		}
	})
	//选人控件删除
	$(document).on('click', '.userDel', function () {
		var userId = $(this).siblings('textarea').attr('id');
		$('#' + userId).val('');
		$('#' + userId).attr('user_id', '');
	})
	//选部门控件添加
	$(document).on('click', '.deptAdd', function () {
		var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
		dept_id = $(this).siblings('textarea').attr('id');
		$.popWindow("/projectTarget/selectProjectDept" + chooseNum+"&zr=1");
	});
	//选部门控件删除
	$(document).on('click', '.deptDel', function () {
		var deptId = $(this).siblings('textarea').attr('id');
		$('#' + deptId).val('');
		$('#' + deptId).attr('deptid', '');
	});
	//选总承包部责任部门控件添加（单独处理）
	$(document).on('click', '.deptAdd_project', function () {
		var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
		dept_id = $(this).siblings('textarea').attr('id');
		$.popWindow("/projectTarget/selectProjectDept" + chooseNum);
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

	//点击按钮收缩
	$('.foldIcon').on('click',function () {
		if ($(this).hasClass('layui-icon-left')) {
			$(this).attr('title', '展开');
			$('.con_left').hide();
			$('.con_right').css({
				'width': '100%',
				'margin-left': '5px'
			});
			$(this).addClass('layui-icon-right').removeClass('layui-icon-left');
		} else {
			$(this).attr('title', '折叠');
			$('.con_left').show().css('width', '230px');
			$('.con_right').css({
				'width': 'calc(100% - 230px)',
				'margin-left': '0px'
			});
			$(this).addClass('layui-icon-left').removeClass('layui-icon-right');
		}
	});

	// 初始化页面
	function init() {
		layui.use(['form', 'eleTree', 'laydate', 'table', 'upload'], function () {
			var form = layui.form,
					eleTree = layui.eleTree,
					laydate = layui.laydate,
					table = layui.table;
			upload = layui.upload;

			var insTree = null;
			var tableIns = null;

			// 计划期间年度列表
			var allYear = '';

			// 获取计划期间年度列表
			$.get('/planPeroidSetting/selectAllYear', function (res) {
				if (res.object.length > 0) {
					res.object.forEach(function (item) {
						allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
					});
				}
				$('.query_form [name="year"]').append(allYear);
				form.render('select');
			});

			// 获取月度
			form.on('select(year)', function (data) {
				if (data.value) {
					getPlanMonth(data.value, function (monthStr) {
						$('.query_form [name="month"]').html(monthStr);
						form.render('select');
					});
				} else {
					$('.query_form [name="month"]').html('<option value="">请选择</option>');
					form.render('select');
				}
			});

			$('.query_form select[name="pbagType"]').append(dictionaryObj['PBAG_TYPE']['str']);
			$('.query_form select[name="tgGrade"]').append(dictionaryObj['TG_GRADE']['str']);
			$('.query_form select[name="tgType"]').append(dictionaryObj['TG_TYPE']['str']);

			form.render();

			//左侧下拉框部门展示
			$.ajax({
				url: '/plcOrg/selectYJ',
				dataType: 'json',
				type: 'get',
				success: function (res) {
					var data = res.obj;
					var str = '<option value="">请选择</option>';
					for (var i = 0; i < data.length; i++) {
						str += '<option value="' + data[i].projOrgId + '">' + data[i].contractorName + '</option>';
					}
					$('.con_left [name="deptName"]').html(str);
					form.render();
					projectLeft($('.con_left [name="deptName"]').val());
				}
			});

			//加监听左侧下拉框部门选择
			form.on('select(deptName)', function (data) {
				tableIns = null;
				$('.tishi').show();
				$('.table_box').hide();
				projectLeft(data.value);
			});

			// 节点点击事件
			eleTree.on("nodeClick(projectLeft)", function (d) {
				$('.tishi').hide();
				$('.table_box').show();
				$('#leftId').attr('pTargetLevel', d.data.index.length);
				if ($('.eleTree-node-content-active').parent().attr('eletree-floor') == 0) {
					tableShow(d.data.currentData.projectId, '');
					$('#leftId').attr('projectId', d.data.currentData.projectId);
					$('#leftId').attr('projectName', d.data.currentData.projectName);
					$('#leftId').attr('pbagId', '');
					$('#plan_time').attr('minTime', d.data.currentData.statrtTime);
					$('#plan_time').attr('maxTime', d.data.currentData.endTime);
				} else {
					tableShow('', d.data.currentData.pbagId);
					$('#leftId').attr('pbagId', d.data.currentData.pbagId);
					$('#plan_time').attr('minTime', format(d.data.currentData.planBeginDate));
					$('#plan_time').attr('maxTime', format(d.data.currentData.planEndDate));
				}
			});

			// input被选中事件
			eleTree.on("nodeChecked(projectLeft)", function (d) {
				/*	console.log(d.data);    // 点击节点对应的数据
							console.log(d.isChecked);   // input是否被选中*/
				//只勾选子项目
				if (d.data.currentData.pbagId) {
					if (d.isChecked) {
						leftPbagIdArr.push(d.data.currentData.pbagId)
					} else {
						for (var i = 0; i < leftPbagIdArr.length; i++) {
							if (leftPbagIdArr[i] == d.data.currentData.pbagId) {
								leftPbagIdArr.splice(i, 1);
							}
						}
					}
					// console.log(leftPbagIdArr)
				}
				//勾选项目
				else {
					if (d.isChecked) {
						leftProjectIdArr.push(d.data.currentData.projectId)
					} else {
						for (var i = 0; i < leftProjectIdArr.length; i++) {
							if (leftProjectIdArr[i] == d.data.currentData.projectId) {
								leftProjectIdArr.splice(i, 1);
							}
						}
					}
					// console.log(leftProjectIdArr)
				}
			})

			// 表格头部工具条事件
			table.on('toolbar(demo)', function (obj) {
				var checkStatus = table.checkStatus(obj.config.id);

				switch (obj.event) {
						// 初始化
					case 'initialization':
						var projectIdPlus = $('.eleTree-node-content-active').parents('.eleTree-node[eletree-floor="0"]').attr('data-ids')
						/*周经理说只有项目未提交或者被退回时才可继续进行初始化*/
						var isInitializationTarget=isInitialization(projectIdPlus)
						if(isInitializationTarget){
							layer.msg('该项目已提交，不可再初始化！', {icon: 0});
							return false
						}
						//勾选后才可初始化
						if (leftPbagIdArr.length == 0 && leftProjectIdArr.length == 0) {
							layer.msg('请单独选择项目或子项目！', {icon: 0, time: 1000});
							return false;
						}
						//只能选一个项目
						if (leftProjectIdArr.length != 1 && leftProjectIdArr.length > 0) {
							layer.msg('请选择一项项目！', {icon: 0, time: 1000});
							return false;
						}
						//项目和子项目不能同时勾选
						if (leftPbagIdArr.length > 0 && leftProjectIdArr.length > 0) {
							layer.msg('请单独选择项目或子项目！', {icon: 0, time: 1000});
							return false;
						}
						var pTargetLevel = $('#leftId').attr('pTargetLevel');
						initProjectPlan(pTargetLevel);
						break;
						// 提交
					case 'report':
						/* if (checkStatus.data.length === 0) {
									 layer.msg('请至少选择一项关键任务！', {icon: 0, time: 1000});
									 return false;
								 }*/
						// var projectId = $('#leftId').attr('projectId');
						var projectName = $('#leftId').attr('projectName');
						var tgId = ''
						/*checkStatus.data.forEach(function (v, i) {
									tgId+=v.tgId+','
								});*/
						var projectId = $('#leftId').attr('projectId') || '';
						var pbagId = $('#leftId').attr('pbagId') || '';
						/*if ($('.eleTree-node-content-active').parent().attr('eletree-floor') == 0) {
									var projectIdPlus=$('#leftId').attr('projectId')
									var pbagIdPlus=''
								}else{
									var projectIdPlus=''
									var pbagIdPlus=$('#leftId').attr('pbagId')
								}*/
						var projectIdPlus = $('.eleTree-node-content-active').parents('.eleTree-node[eletree-floor="0"]').attr('data-ids')
						/*判断项目和工区下是否有关键任务*/
						var isSubmitTarget=isSubmit(projectIdPlus)
						if(isSubmitTarget){
							layer.msg('项目和工区下必须同时有关键任务才可提交！', {icon: 0});
							return false
						}
						$.ajax({
							url: '/projectTarget/selectTGByPro',
							dataType: 'json',
							type: 'post',
							data: {projectId: projectIdPlus},
							async: false,
							success: function (res) {
								var datas = res
								if (datas.length > 0) {
									for (var i = 0; i < datas.length; i++) {
										if (!datas[i].planStartDate) {
											layer.msg('请将关键任务中的“' + datas[i].tgName + '”的计划开始时间补充完整！', {icon: 0});
											return false
										}
										if (!datas[i].mainCenterDept && !datas[i].mainAreaDept && !datas[i].mainProjectDept) {
											layer.msg('请将关键任务中的“' + datas[i].tgName + '”的中心责任部门/区域责任部门/总承包部责任部门中其中一个补充完整！', {icon: 0});
											return false
										}
										tgId += datas[i].tgId + ','
									}
									reportPlan(projectId, projectName, tgId);
								} else {
									layer.msg('该项目下暂无关键任务可提交！', {icon: 0});
									return false
								}
							}
						})
						break;
						// 修编
					case 'revision':
						if (checkStatus.data.length === 0) {
							layer.msg('请至少选择一项关键任务！', {icon: 0, time: 1000});
							return false;
						}
						for (var i = 0; i < checkStatus.data.length; i++) {
							if (checkStatus.data[i].examineStatus != 2) {
								layer.msg('该关键任务还未同意，不可修编！', {icon: 0, time: 1000});
								return false;
							}
						}
						revisionProjectPlan(checkStatus.data);
						break;
						//修编详情
					case 'revisionDetail':
						if (checkStatus.data.length == 0) {
							layer.msg('请选择至少一项关键任务！', {icon: 0});
							return false
						}
						var tgId = ''
						checkStatus.data.forEach(function (v, i) {
							tgId += v.tgId + ','
						});
						openRevisionDetail(tgId)
						break;
						// 新增
					case 'add':
						newAndEdit(1);
						break;
						// 提交入库
					case 'submit':
						break;
						// 编辑
					case 'edit':
						if (checkStatus.data.length != 1) {
							layer.msg('请选择一项关键任务！', {icon: 0, time: 1000});
							return false;
						}
						if (checkStatus.data[0].examineStatus == 1) {
							layer.msg('该关键任务正在审批中，不可编辑！', {icon: 0, time: 1000});
							return false;
						} else if (checkStatus.data[0].examineStatus == 2) {
							layer.msg('该关键任务已同意，不可编辑！', {icon: 0, time: 1000});
							return false;
						} else if (checkStatus.data[0].examineStatus == 4) {
							layer.msg('该关键任务已上报，不可编辑！', {icon: 0, time: 1000});
							return false;
						}
						newAndEdit(2, checkStatus.data[0]);
						break;
						// 删除
					case 'del':
						if (checkStatus.data.length === 0) {
							layer.msg('请至少选择一项关键任务！', {icon: 0, time: 1000});
							return false;
						}
						var tgId = [];
						checkStatus.data.forEach(function (v, i) {
							tgId.push(v.tgId);
						});

						layer.confirm('确定删除该条数据吗？', function (index) {
							$.ajax({
								url: '/projectTarget/deleteContent',
								dataType: 'json',
								type: 'post',
								data: {id: tgId},
								traditional: true,
								success: function (res) {
									if (res.flag) {
										layer.msg('删除成功！', {icon: 1, time: 1000}, function () {
											layer.close(index);
											// 修改url时间戳，防止ie下数据没有刷新问题
											tableIns.config.where._ = new Date().getTime();
											tableIns.reload();
										});
									} else {
										layer.msg('删除失败！', {icon: 2, time: 1000});
									}
								}
							});
						});
						break;
					case 'import':
						layer.open({
							type: 1,
							area: ['531px', '400px'], //宽高
							title: '导入',
							maxmin: true,
							btn: ['确定'], //可以无限个按钮
							content: '<div style="margin: 43px auto;">' +
									'<form class="layui-form" action="">\n' +
									'  <div class="layui-form-item" name="template">\n' +
									'    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <a class="layui-form-mid" href="/file/dataReport/计划关键任务列表信息.xls" style="text-decoration: underline; color: blue;">下载模板</a>\n' +
									'    </div>\n' +
									'  </div>' +
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
									'    <div class="layui-form-mid layui-word-aux">1.导入数据源只支持xls文件</div>\n' +
									'  </div>' +
									'</form>' +
									'</div>',
							success: function () {
								//执行实例
								var uploadInst = upload.render({
									elem: '#test1' //绑定元素
									, url: '/projectTarget/imports?pbagId='+$('#leftId').attr('pbagId') //上传接口
									, accept: 'file'
									, auto: false
									, bindAction: '.layui-layer-btn0'
									, choose: function (obj) {
										//将每次选择的文件追加到文件队列
										var files = obj.pushFile();
										obj.preview(function (index, file, result) {
											$("#textfilter").text(file.name);
										});
									}
									, done: function (res) {
										if (res.flag) {
											layer.msg('导入成功！', {icon: 1});
										} else {
											layer.msg(res.msg, {icon: 0});
										}
									}
									, error: function () {
										//请求异常回调
										layer.msg('请上传正确的附件信息!', {icon: 0});
									}
								});

							},
							yes: function (index, layero) {
								layer.close(index);
							}
						});
						break;
					case 'export':
						var page=tableIns.config.page.curr
						var limit=tableIns.config.page.limit
						var projectId=$('#leftId').attr('projectId')
						var pbagId=$('#leftId').attr('pbagId')
						if(pbagId){
							projectId=''
						}
						window.location.href = '/projectTarget/selectByProOrBag?page='+page+'&limit='+limit+'&projectId='+projectId+'&pbagId='+pbagId+'&out=1'
						break;
				}
			});

			// 表格单元格单击
			table.on('tool(demo)', function (obj) {
				switch (obj.event) {
					case 'tgDetail':
						layer.open({
							type: 1,
							title: '关键任务详情',
							area: ['80%', '90%'],
							content: '<div id="tgDetailBox" style="padding: 0 10px;"></div>',
							success: function () {
								var data = obj.data;
								var tableStr = '<table class="layui-table">' +
										'<tr><td class="td_title">关键任务编号：</td><td>' + (data.tgNo || '') + '</td><td class="td_title">难度系数：</td><td>' + (data.hardDegree || '') + '</td></tr>' +
										'<tr><td class="td_title">关键任务名称：</td><td>' + (data.tgName || '') + '</td><td class="td_title">关注等级：</td><td>' + (dictionaryObj['CONTROL_LEVEL']['object'][data.controlLevel] || '') + '</td></tr>' +
										'<tr><td class="td_title">周期类型：</td><td>' + (dictionaryObj['PLAN_SYCLE']['object'][data.planSycle] || '') + '</td><td class="td_title">关键任务类型：</td><td>' + (dictionaryObj['TG_TYPE']['object'][data.tgType] || '') + '</td></tr>' +
										'<tr><td class="td_title">计划阶段：</td><td>' + (dictionaryObj['PLAN_PHASE']['object'][data.planStage] || '') + '</td><td class="td_title">单位：</td><td>' + (dictionaryObj['UNIT']['object'][data.itemQuantityNuit] || '') + '</td></tr>' +
										'<tr><td class="td_title">设计量：</td><td>' + (data.designQuantity || '') + '</td><td class="td_title">工程量：</td><td>' + (data.itemQuantity || '') + '</td></tr>' +
										'<tr><td class="td_title">中心责任部门责任人：</td><td>' + (data.dutyUserName || '').replace(/,$/, '') + '</td><td class="td_title">中心责任部门：</td><td>' + (data.mainCenterDeptName || '').replace(/,$/, '') + '</td></tr>' +
										'<tr><td class="td_title">区域责任部门责任人：</td><td>' + (data.mainAreaUserName || '').replace(/,$/, '') + '</td><td class="td_title">区域责任部门：</td><td>' + (data.mainAreaDeptName || '') + '</td></tr>' +
										'<tr><td class="td_title">总承包部责任部门责任人：</td><td>' + (data.mainProjectUserName || '').replace(/,$/, '') + '</td><td class="td_title">总承包部责任部门：</td><td>' + (data.mainProjectDeptName || '').replace(/,$/, '') + '</td></tr>' +
										'<tr><td class="td_title">计划开始时间：</td><td>' + (data.planStartDate || '') + '</td><td class="td_title">计划结束时间：</td><td>' + (data.planEndDate || '') + '</td></tr>' +
										'<tr><td class="td_title">计划工期：</td><td>' + (data.planContinuedDate || '') + '</td><td class="td_title">完成标准：</td><td>' + (data.resultStandard || '') + '</td></tr>' +
										'<tr><td class="td_title">难度点：</td><td>' + (data.difficultPoint || '') + '</td><td class="td_title">风险点：</td><td>' + (data.riskPoint || '') + '</td></tr>' +
										'<tr><td class="td_title">成果标准模板：</td><td>' + function () {
											if (!!data.resultDict) {
												var resultDictList = data.resultDict.split(',');
												var resultDictName = '';
												resultDictList.forEach(function (item) {
													resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
												})
												return resultDictName.replace(/,$/, '');
											}
										}() + '</td><td class="td_title">关键任务描述：</td><td>' + (data.tgDesc || '') + '</td></tr>' +
										'<tr><td class="td_title">提前几天提醒：</td><td>' +function () {
											if(data.earlyWarning){
												return data.earlyWarning+'天'
											}else{
												return ''
											}
										}()+ '</td><td class="td_title">目标等级：</td><td>' +(dictionaryObj['TG_GRADE']['object'][data.tgGrade] || '')+ '</td></tr>' +
										'<tr><td class="td_title">编制依据附件：</td><td colspan="3">' +function () {
											if (!!data.attachments4 && data.attachments4.length > 0) {
												var str = '';

												data.attachments4.forEach(function (item) {
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
										}()+ '</td></tr>' +
										'</table>';
								$('#tgDetailBox').html(tableStr);
							}
						});
						break;
				}
			});

			//监听行单击事件
			table.on('rowDouble(demo)', function (obj) {
				// console.log(obj.tr) //得到当前行元素对象
				// console.log(obj.data) //得到当前行数据
				if (obj.data.examineStatus == 1) {
					layer.msg('该关键任务正在审批中，不可编辑！', {icon: 0, time: 1000});
					return false;
				} else if (obj.data.examineStatus == 2) {
					layer.msg('该关键任务已同意，不可编辑！', {icon: 0, time: 1000});
					return false;
				} else if (obj.data.examineStatus == 4) {
					layer.msg('该关键任务已上报，不可编辑！', {icon: 0, time: 1000});
					return false;
				}
				newAndEdit(2, obj.data);
			});

			// 点击查询
			$('#selectBtn').on('click', function () {
				if (tableIns) {
					var projectId = $('#leftId').attr('projectId') || '';
					var pbagId = $('#leftId').attr('pbagId') || '';
					var data = {'projectId': projectId, 'pbagId': pbagId, _: new Date().getTime()};
					var $queryEle = $('.query_form').find('[name]');
					$queryEle.each(function (v, e) {
						var key = $(e).attr('name');
						var value = $(e).val();
						data[key] = value ? value.trim() : '';
					});
					data.tgType=$('#tgType_query').attr('dictNo') ? $('#tgType_query').attr('dictNo').replace(/,$/,'') : ''
					tableIns.reload({
						url: '/projectTarget/selectByProOrBag',
						where: data,
						page: {
							curr: 1
						}
					});
				}
			});

			//重置
			$('.reset').on('click',function () {
				$('#tgType_query').attr('dictNo','')
				$('#tgType_query').val('')
			})

			//左侧项目列表
			function projectLeft(deptId) {
				insTree = eleTree.render({
					elem: '.ele1',
					url: '/projectTarget/getProAndBagTreeByCount?projOrgId=' + deptId,
					highlightCurrent: true,
					showCheckbox: true,
					showLine: true,
					accordion: true, // 手风琴效果
					request: {
						name: "name", // 显示的内容
						key: "ids", // 节点id
						children: "bags",
					},
					response: {
						statusName: 'code',
						statusCode: 0,
						dataName: "obj"
					},
				});
			}

			// 渲染表格
			function tableShow(projectId, pbagId) {
				tableIns = table.render({
					elem: '#demo'
					, url: '/projectTarget/selectByProOrBag' //数据接口
					, page: true //开启分页
					, limit: 50
					, height: $(window).height() - 60
					, toolbar: '#toolbarDemo'
					, defaultToolbar: ['filter']
					, cols: [[ //表头
						{type: 'checkbox', fixed: 'left'}
						, {field: 'tgNo', title: '关键任务编号', width: 200,templet:function (d) {
								return '<span modifyBeforeYn="'+d.modifyBeforeYn+'">'+d.tgNo+'</span>'
							}}
						, {
							field: 'examineStatus', title: '审批状态', width: 100, templet: function (d) {
								if (d.examineStatus == 1) {
									return '<span class="examineStatus" examineStatus="' + d.examineStatus + '">正在审批中</span>'
								} else if (d.examineStatus == 2) {
									return '<span class="examineStatus" examineStatus="' + d.examineStatus + '">同意</span>'
								} else if (d.examineStatus == 3) {
									return '<span class="examineStatus" examineStatus="' + d.examineStatus + '">退回</span>'
								} else if (d.examineStatus == 4) {
									return '<span class="examineStatus" examineStatus="' + d.examineStatus + '">已上报</span>'
								} else {
									return '<span class="examineStatus"></span>'
								}
							}
						}
						, {
							field: 'tgName', title: '关键任务名称', width: 300, event: 'tgDetail', templet: function (d) {
								return '<span class="tgName" style="color: blue;cursor: pointer;" tgId="' + d.tgId + '" >' + d.tgName + '</span>'
							}
						}
						, {
							field: 'planStartDate', title: '计划开始时间', width: 130, templet: function (d) {
								if (authorityObject && authorityObject['05']) {
									var startDateStr = '<input type="text" class="layui-input table_date_start" style="height: 100%;" readonly tgId="' + d.tgId + '" value="' + (d.planStartDate || '') + '">';
									return startDateStr;
								} else {
									return format(d.planStartDate);
								}
							}
						}
						, {
							field: 'planEndDate', title: '计划完成时间', width: 130, templet: function (d) {
								if (authorityObject && authorityObject['05']) {
									var planEndDateStr = '<input type="text" class="layui-input table_date_end" style="height: 100%;" readonly tgId="' + d.tgId + '" value="' + (d.planEndDate || '') + '">';
									return planEndDateStr;
								} else {
									return format(d.planEndDate);
								}
							}
						}
						, {
							field: 'planContinuedDate', title: '计划工期', width: 100, templet: function (d) {
								return '<span class="table_planContinuedDate">' + (d.planContinuedDate || '') + '</span>';
							}
						}
						, {field: 'mainCenterDeptName', title: '中心责任部门', width: 130}
						, {field: 'centerDutyType', title: '中心职责类型', width: 130,templet:function (d) {
								return  dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
							}}
						, {field: 'mainAreaDeptName', title: '区域责任部门', width: 130}
						, {field: 'areaDutyType', title: '区域职责类型', width: 130,templet:function (d) {
								return  dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
							}}
						, {field: 'mainProjectDeptName', title: '总承包部责任部门', width: 150}
						, {
							field: 'controlLevel', title: '关注等级', width: 100, templet: function (d) {
								return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
							}
						}
						, {
							field: 'tgGrade', title: '目标等级', width: 100, templet: function (d) {
								return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
							}
						}
						, {
							field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
								return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
							}
						}
						, {
							field: 'tgType', title: '关键任务类型', width: 100, templet: function (d) {
								return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
							}
						}
						, {
							field: 'planStage', title: '计划阶段', width: 100, templet: function (d) {
								return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || '';
							}
						}
						, {field: 'designQuantity', title: '设计量', width: 100}
						, {field: 'itemQuantity', title: '工程量', width: 100}
						, {
							field: 'itemQuantityNuit', title: '单位', width: 100, templet: function (d) {
								return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
							}
						}
						, {
							field: 'dutyUserName', title: '中心责任部门责任人', width: 160, templet: function (d) {
								if (d.dutyUserName) {
									return d.dutyUserName.replace(/,$/, '');
								} else {
									return ''
								}
							}
						}
						, {field: 'mainAreaUserName', title: '区域责任部门责任人', width: 160}
						, {field: 'mainProjectUserName', title: '总承包部责任部门责任人', width: 200}
						, {field: 'resultStandard', title: '完成标准', width: 150}
						, {field: 'riskPoint', title: '风险点', width: 130}
						, {
							field: 'resultDict', title: '成果标准模板', width: 150, templet: function (d) {
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
						, {field: 'difficultPoint', title: '难度点', width: 130}
						, {field: 'tgDesc', title: '关键任务描述', width: 150}
					]]
					, where: {
						projectId: projectId,
						pbagId: pbagId,
						_: new Date().getTime()
					}
					, parseData: function (res) { //res 即为原始返回的数据
						return {
							"code": 0, //解析接口状态
							"data": res.obj, //解析数据列表
							"count": res.count, //解析数据长度
						};
					}
					, done: function () {
						// 选择时间控件
						var $tableTrEles = $('#demo').next().find('.layui-table-box .layui-table-main tr');
						var min = $('#plan_time').attr('minTime') || '1900-01-01';
						var max = $('#plan_time').attr('maxTime') || '2099-12-31';
						$tableTrEles.each(function () {
							var tableDateStartEle = $(this).find('.table_date_start').get(0);
							if (tableDateStartEle) {

								var startDatePickConfig = {
									elem: tableDateStartEle,
									format: 'yyyy-MM-dd',
									btns: ['now', 'confirm'],
									min: min,
									max: max,
									done: function (value, date) {
										var updateData = {planStartDate: value}
										var tgId = this.elem[0].getAttribute("tgId");

										var $tr = $(tableDateStartEle).parents('tr').eq(0);
										var planPeriod = timeRange(value, $tr.find('.table_date_end').eq(0).val());
										if (planPeriod > 0) {
											updateData.planContinuedDate = planPeriod + '天';
											$tr.find('.table_planContinuedDate').text(planPeriod + '天');
										}
										revisionUpdate(tgId, updateData);
										if (endDatePick.config.min) {
											endDatePick.config.min = {
												year: date.year || 1900,
												month: date.month - 1 || 0,
												date: date.date || 1,
											}
										} else {
											endDatePickConfig.min = value;
										}
									},
									trigger: 'click' //采用click弹出
								}
								var startDatePick = laydate.render(startDatePickConfig);

								var tableDateEndEle = $(this).find('.table_date_end').get(0);

								var endDatePickConfig = {
									elem: tableDateEndEle,
									format: 'yyyy-MM-dd',
									btns: ['now', 'confirm'],
									min: min,
									max: max,
									done: function (value, date) {
										var updateData = {planEndDate: value}
										var tgId = this.elem[0].getAttribute("tgId");

										var $tr = $(tableDateEndEle).parents('tr').eq(0);
										var planPeriod = timeRange($tr.find('.table_date_start').eq(0).val(), value);
										if (planPeriod > 0) {
											updateData.planContinuedDate = planPeriod + '天';
											$tr.find('.table_planContinuedDate').text(planPeriod + '天');
										}
										revisionUpdate(tgId, updateData);
										if (startDatePick.config.max) {
											startDatePick.config.max = {
												year: date.year || 2099,
												month: date.month - 1 || 11,
												date: date.date || 31
											}
										} else {
											startDatePickConfig.max = value;
										}
									},
									trigger: 'click' //采用click弹出
								}
								var endDatePick = laydate.render(endDatePickConfig);
							}

							//判断前置关键任务是否被修改
							if($(this).find('td[data-field="tgNo"] span').attr('modifyBeforeYn')=='1'){
								$(this).find('td[data-field="planStartDate"]').css('background','#bbbbe8')
								$(this).find('td[data-field="planEndDate"]').css('background','#bbbbe8')
							}else if($(this).find('td[data-field="tgNo"] span').attr('modifyBeforeYn')=='2'){
								$(this).find('td[data-field="planStartDate"]').css('background','#f2b5b5')
								$(this).find('td[data-field="planEndDate"]').css('background','#f2b5b5')
							}
						});
					}
				});
			}

			/**
			 * 新增、编辑方法
			 * @param[Number] type  (操作类型(1-新增，2-编辑))
			 * @param[Object] data (type为2时有效，当前选中行数据)
			 */
			function newAndEdit(type, data) {
				var title = '';
				var url = '';
				if (type === 1) {
					title = '新增';
					url = '/projectTarget/add?deptOrProject=0';
				} else if (type === 2) {
					title = '编辑';
					url = '/projectTarget/update';
				}

				layer.open({
					type: 1,
					title: title,
					area: ['100%', '100%'],
					maxmin: true,
					min: function () {
						$('.layui-layer-shade').hide();
					},
					btn: ['保存', '取消'],
					content: ['<form class="layui-form" id="newOrEditForm" lay-filter="formTest">' +

					//前置任务使用该参数
					'<input type="hidden" id="isEffectStart">'+

					//第一行
					'<div class="layui-row" style="margin-top:15px;">' +
					'<div class="newAndEdit layui-col-xs6" > <div class="layui-form-item" >\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="tgNo">*</span>编号</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="tgNo" readonly autocomplete="off" class="layui-input jinyong" style="width: 95%;display: inline-block;background:#e7e7e7;">\n' +
					'<a class="refresh_no" href="javascript:;" style="display: inline-block;visibility: hidden;color: #1e9fff;">刷新</a>' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
					/*此处难度系数对应工作项库的标准难度系数*/
					'    <label class="layui-form-label">难度系数</label>\n' +
					'    <div class="layui-input-block">\n' +
					// '      <input type="number" name="hardDegree"  autocomplete="off" class="layui-input jinyong">\n' +
					' <select name="hardDegree" lay-verify="required"  class="jinyong">\n' +
					'<option value="1">1</option>' +
					'<option value="2">2</option>' +
					'<option value="3">3</option>' +
					'<option value="4">4</option>' +
					'<option value="5">5</option>' +
					'<option value="6">6</option>' +
					'<option value="7">7</option>' +
					'<option value="8">8</option>' +
					'<option value="9">9</option>' +
					'<option value="10">10</option>' +
					'      </select>' +
					'    </div>\n' +
					'  </div></div>' +
					'</div>' +
					//第二行
					'<div class="layui-row">' +
					'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="tgName">*</span>关键任务名称</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="tgName"  autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'  </div></div>' +
					'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">关注等级</label>\n' +
					'    <div class="layui-input-block">' +
					// '      <input type="checkbox" name="controlLevel" title="是" lay-skin="primary" checked>'+
					' <select name="controlLevel" lay-verify="required" class="jinyong">\n' +
					'      </select>' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					//第二行
					'<div class="layui-row">' +
					'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">目标等级</label>\n' +
					'    <div class="layui-input-block">\n' +
					' <select name="tgGrade" lay-verify="required">\n' +
					'      </select>' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="submitDate">*</span>成果材料提交时间</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" class="layui-input" readonly autocomplete="off" name="submitDate" id="submitDate">' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					//第三行
					'<div class="layui-row">' +
					'<div class="newAndEdit layui-col-xs4"><div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="planSycle">*</span>周期类型</label>\n' +
					'    <div class="layui-input-block">\n' +
					' <select name="planSycle" lay-verify="required" class="jinyong">\n' +
					'      </select>' +
					'    </div>\n' +
					'  </div></div>' +
					'<div class="newAndEdit layui-col-xs4">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="tgType">*</span>关键任务类型</label>\n' +
					'    <div class="layui-input-block pbagNature">\n' +
					/*' <select name="tgType" lay-verify="required" class="jinyong">\n' +
                                '      </select>' +*/
					'		<input type="text" name="tgType" readonly style="background-color: #e7e7e7;cursor:not-allowed" class="layui-input">'+
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="planStage">*</span>计划阶段</label>\n' +
					'    <div class="layui-input-block">\n' +
					' <select name="planStage" lay-verify="required" class="jinyong">\n' +
					'      </select>' +
					'    </div>\n' +
					'  </div> </div>' +
					'</div>' +
					//第四行
					'<div class="layui-row">' +
					'<div class="newAndEdit layui-col-xs4">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">设计量</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="designQuantity"  autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">工程量</label>\n' +
					'    <div class="layui-input-block ">\n' +
					'      <input type="text" name="itemQuantity"  autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'  </div> </div>' +
					' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">单位</label>\n' +
					'    <div class="layui-input-block">\n' +
					' <select name="itemQuantityNuit" lay-verify="required" class="jinyong">\n' +
					'<option value="">请选择</option>' +
					'      </select>' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					//第五行
					'<div class="layui-row">' +
					' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">中心责任部门责任人</label>\n' +
					'    <div class="layui-input-block">\n' +
					'  <textarea  type="text" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
					//暂时不需选择，故注释2020.12.17
					/*   '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
                                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +*/
					'    </div>\n' +
					'  </div> </div>' +
					'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">中心责任部门</label>\n' +
					'    <div class="layui-input-block">\n' +
					'  <textarea  type="text" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
					//暂时不需选择，故注释2020.12.17
					/* '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
                                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +*/
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					//第六行
					'<div class="layui-row">' +
					'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">区域责任部门责任人</label>\n' +
					'    <div class="layui-input-block">\n' +
					'  <textarea  type="text" name="mainAreaUser" id="mainAreaUser" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
					'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
					' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">区域责任部门</label>\n' +
					'    <div class="layui-input-block">\n' +
					'  <textarea  type="text" name="mainAreaDept" id="mainAreaDept" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
					'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
					' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					//第七行
					'<div class="layui-row">' +
					'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">总承包部责任部门责任人</label>\n' +
					'    <div class="layui-input-block">\n' +
					'  <textarea type="text" name="mainProjectUser" id="mainProjectUser" readonly style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
					'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
					' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">总承包部责任部门</label>\n' +
					'    <div class="layui-input-block">\n' +
					'  <textarea type="text" name="mainProjectDept" id="mainProjectDept" readonly style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
					'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd_project">添加</a>\n' +
					' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					//第八行
					'<div class="newAndEdit layui-row"> <div class="layui-col-xs3" ><div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">中心职责</label>\n' +
					'    <div class="layui-input-block ">\n' +
					'         <input type="text" name="centerDuty"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					' </div></div>\n' +
					'<div class="layui-col-xs3" ><div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">中心职责类型</label>\n' +
					'    <div class="layui-input-block ">\n' +
					' <select name="centerDutyType" lay-verify="required">\n' +
					'      </select>' +
					'    </div>\n' +
					' </div></div>\n' +

					'<div class="layui-col-xs3" ><div class="layui-form-item" >' +
					'    <label class="layui-form-label">区域职责</label>\n' +
					'    <div class="layui-input-block ">\n' +
					'         <input type="text" name="areaDuty"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'</div></div>' +
					'<div class="layui-col-xs3" ><div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">区域职责类型</label>\n' +
					'    <div class="layui-input-block ">\n' +
					' <select name="areaDutyType" lay-verify="required">\n' +
					'      </select>' +
					'    </div>\n' +
					' </div></div>\n' +

					'</div>\n' +
					'<div class="newAndEdit layui-row"> <div class="layui-col-xs6" ><div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">总承包部职责</label>\n' +
					'    <div class="layui-input-block ">\n' +
					'         <input type="text" name="projectDuty"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					' </div></div>\n' +
					'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label" style="padding: 9px;width: 90px">提前几天提醒</label>\n' +
					'    <div class="layui-input-block">\n' +
					' <select name="earlyWarning" lay-verify="required" class="jinyong">\n' +
					'<option value="1">1</option>'+
					'<option value="2">2</option>'+
					'<option value="3">3</option>'+
					'<option value="4">4</option>'+
					'<option value="5">5</option>'+
					'<option value="6">6</option>'+
					'<option value="7">7</option>'+
					'<option value="8">8</option>'+
					'      </select>' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>\n' +
					//第八行
					'<div class="layui-row">' +
					' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="planStartDate">*</span>计划开始时间</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planStartDate" id="planStartDate">' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="planEndDate">*</span>计划结束时间</label>\n' +
					'    <div class="layui-input-block contractDept">\n' +
					'      <input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planEndDate" id="planEndDate">' +
					'    </div>\n' +
					'  </div> </div>' +
					' <div class="newAndEdit layui-col-xs4"><div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="planContinuedDate">*</span>计划工期</label>\n' +
					'    <div class="layui-input-inline">\n' +
					'      <input type="text" name="planContinuedDate" style="background-color: #e7e7e7;" readonly  autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'<div class="layui-form-mid layui-word-aux">根据开始时间和结束时间自动生成</div>' +
					'  </div></div>' +
					'</div>' +
					//第九行
					'<div class="layui-row">' +
					' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="resultStandard">*</span>完成标准</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="resultStandard" autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">难度点</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="difficultPoint"  autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'  </div> </div>' +
					'</div>' +
					//第十行
					'<div class="layui-row">' +
					' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">风险点</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="riskPoint"  autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
					'    <label class="layui-form-label"><span class="required_field" field_name="resultDict">*</span>成果标准模板</label>\n' +
					'    <div class="layui-input-block">\n' +
					'<input type="text" name="resultDict" readonly title="成果标准模板" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
					'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="resultDictAdd">添加</a>\n' +
					' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="resultDictDel">清空</a>\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					//第十一行
					'<div><div class="layui-form-item">' +
					'    <label class="layui-form-label">编制依据附件</label>\n' +
					'    <div class="layui-input-block">\n' +
					'    <div id="attachment4Box"></div>\n' +
					'	 <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top: 10px;">\n' +
					'       <img src="../img/mg11.png" alt="">\n' +
					'       <span><fmt:message code="email.th.addfile"/></span>\n' +
					'       <input type="file" multiple id="attachment4" data-url="/upload?module=plancheck" name="file">\n' +
					'    </a>\n' +
					'    </div>\n' +
					'</div>' +
					'</div>' +
					//第十一行
					'<div><div class="layui-form-item">' +
					'    <label class="layui-form-label">关键任务描述</label>\n' +
					'    <div class="layui-input-block">\n' +
					'<textarea name="tgDesc"  class="layui-textarea jinyong"></textarea>' +
					'    </div>\n' +
					'</div>' +
					'</div>' +
					//第十二行-----前置关键任务
					'<div class="layui-row">' +
					' <div class="newAndEdit layui-col-xs11"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">前置关键任务</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="preTgId" readonly  autocomplete="off" class="layui-input jinyong" style="background:#e7e7e7;">\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					' <div class="newAndEdit layui-col-xs1"> <div class="layui-form-item">\n' +
					'<button type="button" class="layui-btn settings" style="margin-left: 25px">设置</button>' +
					'  </div> </div>' +
					'</div>' +
					//第十三行----关联关键任务
					'<div class="layui-row">' +
					' <div class="newAndEdit layui-col-xs12"> <div class="layui-form-item">\n' +
					'    <label class="layui-form-label">关联关键任务</label>\n' +
					'    <div class="layui-input-block">\n' +
					'<input type="text" name="tgId" readonly style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input jinyong " title="关联关键任务">\n' +
					'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="relationAdd">添加</a>\n' +
					' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="relationDel">清空</a>\n' +
					'    </div>\n' +
					'  </div>' +
					'  </div>' +
					'</div>' +
					'</form>'].join(''),
					success: function () {

						fileuploadFn('#attachment4', $('#attachment4Box'));

						//设置
						$('.settings').on('click',function () {
							layer.open({
								type: 1,
								title: '前置关键任务',
								area: ['80%', '70%'],
								btn: ['确定', '取消'],
								content: ['<div style="margin-top: 15px" class="layui-form" id="targetSet">' +
								'<div class="layui-row" style="text-align: right;margin-right: 2%">' +
								'<div class="layui-col-xs4">' +
								'<div class="layui-form-item">\n' +
								'<label class="layui-form-label">年度:</label>\n' +
								'<div class="layui-input-block">\n' +
								'<select name="year" lay-filter="yearSet">\n' +
								'<option value="">请选择</option>\n' +
								'</select>\n' +
								'</div>\n' +
								'</div>' +
								'</div>' +
								'<div class="layui-col-xs4">' +
								'<div class="layui-form-item">\n' +
								'<label class="layui-form-label">月度:</label>\n' +
								'<div class="layui-input-block">\n' +
								'<select name="month">\n' +
								'</select>\n' +
								'</div>\n' +
								'</div>' +
								'</div>' +
								/*'<div class="layui-col-xs4">' +
											'<div class="layui-form-item">\n' +
											'<label class="layui-form-label">责任部门:</label>\n' +
											'<div class="layui-input-block">\n' +
											'<input type="text" name="mainCenterDept" readonly id="mainCenterDeptSet" autocomplete="off" class="layui-input"  readonly style="background:#e7e7e7;display: inline-block;width: 65%">' +
											'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_taskSet_dept">添加</span>' +
											'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_taskSet_dept">清空</span>' +
											'</div>\n' +
											'</div>'+
											'</div>'+*/
								'<button type="button" class="layui-btn layui-btn-sm addPreTask">增加</button></div>' +
								'<table class="layui-table preTaskTable" style="width: 98%;margin: 8px">\n' +
								'  <thead>\n' +
								'    <tr>\n' +
								'      <th>关键任务名称</th>\n' +
								'      <th>类型</th>\n' +
								'      <th>延隔时间(天)</th>\n' +
								'    </tr> \n' +
								'  </thead>\n' +
								'  <tbody>\n' +
								'  </tbody>\n' +
								'</table>' +
								'</div>'].join(''),
								success: function () {
									/***************************************************计划期间年度、月度*******************************************************/
											// 计划期间年度列表
									var allYear = '';
									// 获取计划期间年度列表
									$.get('/planPeroidSetting/selectAllYear', function (res) {
										if (res.object.length > 0) {
											res.object.forEach(function (item) {
												allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
											});
										}
										$('#targetSet [name="year"]').append(allYear);
										form.render('select');
										//新建时默认年度为当年、月度为当月
										$('#targetSet select[name="year"] option').each(function () {
											var nowYear = new Date().getFullYear()
											if ($(this).text() == nowYear) {
												$('#targetSet select[name="year"]').val($(this).val())
												form.render()
												getPlanMonth($(this).val(), function (monthSrt) {
													$('#targetSet select[name="month"]').html(monthSrt);
													form.render('select');
													//判断是否存在当月
													var nextMonth = new Date().getMonth() + 1
													$('#targetSet select[name="month"] option').each(function () {
														if (parseInt($(this).text()) == nextMonth) {
															$('#targetSet select[name="month"]').val($(this).val())
															form.render()
														}
													})
												});
											}
										})
									});

									// 获取月度
									form.on('select(yearSet)', function (data) {
										if (data.value) {
											getPlanMonth(data.value, function (monthStr) {
												$('#targetSet [name="month"]').html(monthStr);
												form.render('select');
											});
										} else {
											$('#targetSet [name="month"]').html('<option value="">请选择</option>');
											form.render('select');
										}
									});


									if ($('#newOrEditForm input[name="preTgId"]').attr('preTgId')) {
										$.get('/projectTarget/selectPreShow', {preTgIds: $('#newOrEditForm input[name="preTgId"]').attr('preTgId')}, function (res) {
											if (res.flag) {
												var data = res.obj
												data.forEach(function (item, index) {
													var str = ''
													str += '    <tr class="trTask">\n' +
															'      <td>' +
															'  <select name="workTargetName" lay-verify="required">\n' +
															function () {
																var projectId=''
																var pbagId=''
																if ($('#leftId').attr('pbagId')) {
																	pbagId = $('#leftId').attr('pbagId');
																} else {
																	projectId = $('#leftId').attr('projectId');
																}
																var name = allTarget('','',projectId,pbagId)
																return name
															}() +
															'      </select>' +
															'</td>\n' +
															'      <td>' +
															'  <select name="pretaskItemType" lay-verify="required">\n' +
															'        <option value=""></option>\n' +
															'        <option value="FS">完成-开始(FS)</option>\n' +
															'        <option value="SS">开始-开始(SS)</option>\n' +
															'        <option value="FF">完成-完成(FF)</option>\n' +
															'        <option value="SF">开始-完成(SF)</option>\n' +
															'      </select>' +
															'</td>\n' +
															'      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')"  name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
															'    </tr>\n'
													$('.preTaskTable tbody').append(str)
													$('.trTask').eq(index).find('select[name="workTargetName"]').val(item.tgId)
													$('.trTask').eq(index).find('select[name="pretaskItemType"]').val(item.pretaskItemType)
													$('.trTask').eq(index).find('input[name="extendDates"]').val(item.extendDates)
													form.render()
												})
											}
										})
									}
									$('.addPreTask').on('click',function () {
										var str = '    <tr class="trTask">\n' +
												'      <td>' +
												'  <select name="workTargetName" lay-verify="required">\n' +
												function () {
													var year = $('#targetSet select[name="year"]').val() || ''
													var month = $('#targetSet select[name="month"]').val() || ''
													//获取所选子项目的最高级项目的id
													// var projectId = $('.eleTree-node-content-active').parents('.eleTree-node[eletree-floor="0"]').attr('data-ids')
													var projectId=''
													var pbagId=''
													if ($('#leftId').attr('pbagId')) {
														pbagId = $('#leftId').attr('pbagId');
													} else {
														projectId = $('#leftId').attr('projectId');
													}
													var name = allTarget(year, month, projectId,pbagId)
													return name
												}() +
												'      </select>' +
												'</td>\n' +
												'      <td>' +
												'  <select name="pretaskItemType" lay-verify="required">\n' +
												'        <option value=""></option>\n' +
												'        <option value="FS">完成-开始(FS)</option>\n' +
												'        <option value="SS">开始-开始(SS)</option>\n' +
												'        <option value="FF">完成-完成(FF)</option>\n' +
												'        <option value="SF">开始-完成(SF)</option>\n' +
												'      </select>' +
												'</td>\n' +
												'      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')" value="0" name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
												'    </tr>\n'
										$('.preTaskTable tbody').append(str)
										form.render()
									})
								},
								yes: function (outIndex) {
									var arr = []
									var str = ''
									var isclose = true
									$('.trTask').each(function () {
										if ($(this).find('select[name="workTargetName"]').val() && $(this).find('select[name="pretaskItemType"]').val() && $(this).find('input[name="extendDates"]').val()) {
											var obj = {}
											obj.tgId = $(this).find('select[name="workTargetName"]').val()
											obj.workTargetName = $(this).find('select[name="workTargetName"] option:selected').text()
											obj.pretaskItemType = $(this).find('select[name="pretaskItemType"]').val()
											obj.extendDates = $(this).find('input[name="extendDates"]').val()
											arr.push(obj)
											str += obj.workTargetName + ','
										}
									})
									for(var i=0;i<arr.length;i++){
										//判断用户是否选择带有F结尾的类型，若带有，则提示，反之不用
										if(arr[i].pretaskItemType.substring(arr[i].pretaskItemType.length - 1) == 'F'){
											isclose=false
											layer.confirm('该设置可能影响任务的计划开始时间，是否强制使用该工期时间?', {
												btn: ['是','否'] //按钮
											}, function(index){
												$('#isEffectStart').val('1')
												layer.close(index)
												layer.close(outIndex)
											}, function(index){
												$('#isEffectStart').val('0')
												layer.close(index)
												layer.close(outIndex)
											});
											break;
										}
									}
							/*		$('#newOrEditForm input[name="preTgId"]').attr('preTgId',JSON.stringify(arr))
									$('#newOrEditForm input[name="preTgId"]').val(str)*/
									$.ajax({
										url: '/projectTarget/insertPretask',
										data: JSON.stringify(arr),
										contentType: "application/json;charset=UTF-8",
										dataType: 'json',
										type: 'post',
										success: function (res) {
											if (res.flag) {
												$('#newOrEditForm input[name="preTgId"]').attr('preTgId', res.data)
												$('#newOrEditForm input[name="preTgId"]').val(str)
												if(isclose){
													layer.close(outIndex)
												}
											}
										}
									})
								}
							})
						})

						//关联关键任务
						$('.relationAdd').on('click',function () {
							layer.open({
								type: 2,
								title: '添加关联关键任务',
								area: ['80%', '80%'],
								btn: ['确定', '取消'],
								// content:'<div  class="layui-form relation"  style="margin-top: 15px"></div>',
								content: '/projectTarget/relationProjectTarget',
								success: function () {
									/*var tgId=$('form input[name="tgId"]').attr('tgId')
											if(tgId){
												var tgArr=tgId.replace(/,$/, '').split(',')
											}
											$.get('/projectTarget/getDropDown',function (res) {
												if(res.flag){
													if(res.obj && res.obj.length>0){
														var data=res.obj
														var str=''
														for(var i=0;i<data.length;i++){
															str+='<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+res.obj[i].tgName+'" title="'+res.obj[i].tgName+'" value="'+res.obj[i].tgId+'" lay-skin="primary"> </div>'
														}
														$('.relation').html(str)
														form.render()
														if(tgArr){
															$('.relation input').each(function (index) {
																tgArr.forEach(function (v,i) {
																	if($('.relation input').eq(index).val()==v){
																		$('.relation input').eq(index).prop('checked','true')
																		form.render()
																	}
																})
															})
														}
													}
												}
											})*/
								},
								yes: function (index, layero) {
									var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
									// console.log(iframeWin.leftArr)
									var ids = iframeWin.leftArr.join()
									$.post('/projectTarget/selectByIds', {ids: ids}, function (res) {
										if (res.flag) {
											var tgId = ''
											var tgName = ''
											var str = '<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 10px;">\n' +
													'  <thead>\n' +
													'    <tr>\n' +
													'      <th>关键任务名称</th>\n' +
													'      <th>关注等级</th>\n' +
													'      <th>计划开始时间</th>\n' +
													'      <th>计划结束时间</th>\n' +
													'      <th>完成标准</th>\n' +
													'      <th>关键任务描述</th>\n' +
													'    </tr> \n' +
													'  </thead>\n' +
													'  <tbody>\n'
											res.obj.forEach(function (v, i) {
												tgId += v.tgId + ','
												tgName += v.tgName + ','
												str += '<tr>\n' +
														'<td>' + isShowNull(v.tgName) + '</td>\n' +
														'<td>' +(dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+ '</td>\n' +
														'<td>' + isShowNull(v.planStartDate) + '</td>\n' +
														'<td>' + isShowNull(v.planEndDate) + '</td>\n' +
														'<td>' + isShowNull(v.resultStandard) + '</td>\n' +
														'<td>' + function () {
															if (v.tgDesc) {
																return v.tgDesc
															} else {
																return ''
															}
														}() + '</td>\n' +
														'</tr>\n'
											})
											str += '</tbody></table>'
											$('#newOrEditForm input[name="tgId"]').val(tgName)
											$('#newOrEditForm input[name="tgId"]').attr('tgId', tgId)
											$('#newOrEditForm #targetDetail').remove()
											$('#newOrEditForm').append(str)
											layer.close(index)
										}
									})
								}
							})
						})
						$('.relationDel').on('click',function () {
							$('#newOrEditForm input[name="tgId"]').val('')
							$('#newOrEditForm input[name="tgId"]').attr('tgId', '')
							$('#targetDetail').remove()
						})

						// 成果标准模板
						$('.resultDictAdd').on('click',function () {
							layer.open({
								type: 1,
								title: '添加成果标准模板',
								area: ['30%', '70%'],
								btn: ['确定', '取消'],
								content: '<div  class="layui-form result"  style="margin-top: 15px"></div>',
								success: function () {
									var cgclTypeObject = dictionaryObj['CGCL_TYPE']['object'];
									var str = '';
									for (var key in cgclTypeObject) {
										if (cgclTypeObject.hasOwnProperty(key)) {
											str += '<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="' + cgclTypeObject[key] + '" title="' + cgclTypeObject[key] + '" value="' + key + '" lay-skin="primary"></div>';
										}
									}
									$('.result').html(str);
									form.render();

									var resultDict = $('form input[name="resultDict"]').attr('resultDict');
									if (!!resultDict) {
										var resultDictArr = resultDict.replace(/,$/, '').split(',');
										$('.result input').each(function (index) {
											resultDictArr.forEach(function (v, i) {
												if ($('.result input').eq(index).val() == v) {
													$('.result input').eq(index).prop('checked', 'true');
													form.render();
												}
											});
										});
									}
								},
								yes: function (index) {
									var resultDict = '';
									var resultDictName = '';
									$('.result input').each(function () {
										if ($(this).prop('checked')) {
											resultDict += $(this).val() + ',';
											resultDictName += $(this).attr('title') + ',';
										}
									});
									$('#newOrEditForm input[name="resultDict"]').val(resultDictName.replace(/,$/, ''));
									$('#newOrEditForm input[name="resultDict"]').attr('resultDict', resultDict.replace(/,$/, ''));
									layer.close(index);
								}
							});
						});
						// 清空成果标准模板
						$('.resultDictDel').on('click',function () {
							$('#newOrEditForm input[name="resultDict"]').val('');
							$('#newOrEditForm input[name="resultDict"]').attr('resultDict', '');
						});

						$('#newOrEditForm select[name="controlLevel"]').append(dictionaryObj['CONTROL_LEVEL']['str']);
						$('#newOrEditForm select[name="tgGrade"]').append(dictionaryObj['TG_GRADE']['str']);
						$('#newOrEditForm select[name="planSycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);
						// $('#newOrEditForm select[name="tgType"]').append(dictionaryObj['TG_TYPE']['str']);
						$('#newOrEditForm select[name="planStage"]').append(dictionaryObj['PLAN_PHASE']['str']);
						$('#newOrEditForm select[name="itemQuantityNuit"]').append(dictionaryObj['UNIT']['str']);
						$('#newOrEditForm select[name="areaDutyType"]').html(areaDutyType);
						$('#newOrEditForm select[name="centerDutyType"]').html(centerDutyType);;
						form.render();

						if (type === 1) {
							//默认难度系数为5
							$('#newOrEditForm  select[name="hardDegree"]').val('5')
							//默认提前几天提醒为3
							$('#newOrEditForm  select[name="earlyWarning"]').val('3')
							form.render()
							// 获取主项计划的编号
							getAutoNo({model: 'projectTarget'}, function (autoNo) {
								$('#newOrEditForm input[name="tgNo"]').val(autoNo);
							});

							$('.refresh_no').css('visibility', 'visible');
							$('.refresh_no').on('click', function () {
								getAutoNo({model: 'projectTarget'}, function (autoNo) {
									$('#newOrEditForm input[name="tgNo"]').val(autoNo);
								});
							});
						}

						if (type === 2) {
							//给表单赋值
							form.val("formTest", data);

							$('#dutyUser').val(data.dutyUserName);
							$('#dutyUser').attr('user_id', data.dutyUser);
							$('#mainCenterDept').val(data.mainCenterDeptName);
							$('#mainCenterDept').attr('deptid', data.mainCenterDept);
							$('#mainAreaDept').val(data.mainAreaDeptName || '');
							$('#mainAreaDept').attr('deptid', (data.mainAreaDept || ''));
							$('#mainProjectDept').val(data.mainProjectDeptName || '');
							$('#mainProjectDept').attr('deptid', (data.mainProjectDept || ''));
							$('#mainAreaUser').val(data.mainAreaUserName);
							$('#mainAreaUser').attr('user_id', data.mainAreaUser);
							$('#mainProjectUser').val(data.mainProjectUserName);
							$('#mainProjectUser').attr('user_id', data.mainProjectUser);
							$('#newOrEditForm [name="tgType"]').val(dictionaryObj['TG_TYPE']['object'][data.tgType])
							$('#newOrEditForm [name="tgType"]').attr('tgType', data.tgType)
							$('#newOrEditForm [name="areaDutyType"]').val(data.areaDutyType)
							$('#newOrEditForm [name="centerDutyType"]').val(data.centerDutyType)
							// 编制依据附件
							if (data.attachments4) {
								var files = data.attachments4;
								var str = '';
								for (var i = 0; i < files.length; i++) {
									var gs = files[i].attachName.split('.')[1];
									if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') { //后缀为这些的禁止上传
										str += '';
										layer.alert('jsp、css、js、html、java文件禁止上传!', {}, function () {
											layer.closeAll();
										});
									} else {
										var fileExtension = files[i].attachName.substring(files[i].attachName.lastIndexOf(".") + 1, files[i].attachName.length);//截取附件文件后缀
										var attName = encodeURI(files[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
										var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
										var deUrl = files[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + files[i].size;

										str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + files[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + files[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + files[i].aid + '@' + files[i].ym + '_' + files[i].attachId + ',"></div>';
									}
								}
								$('#attachment4Box').append(str);
							}

							/*//顶层关注回显
									if (data.controlLevel == 1) {
										$('#newOrEditForm [name="controlLevel"]').prop('checked', true)
									} else {
										$('#newOrEditForm [name="controlLevel"]').prop('checked', false)
									}*/

							//成果标准模板
							if (!!data.resultDict) {
								var resultDictList = data.resultDict.split(',');
								var resultDictName = '';
								resultDictList.forEach(function (item) {
									resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
								})
								$('#newOrEditForm input[name="resultDict"]').val(resultDictName.replace(/,$/, ''));
								$('#newOrEditForm input[name="resultDict"]').attr('resultDict', data.resultDict);
							}

							//判断如果是导入的模板则不可修改部分字段
							if (data.isImport == 1) {
								$('#newOrEditForm [name="tgName"]').attr('readonly', 'readonly').css('background', '#e7e7e7')
								$('#newOrEditForm [name="controlLevel"]').attr('disabled', 'disabled')
								$('#newOrEditForm [name="planSycle"]').attr('disabled', 'disabled')
								// $('#newOrEditForm [name="tgType"]').attr('disabled', 'disabled')
								$('#newOrEditForm [name="planStage"]').attr('disabled', 'disabled')
								form.render()
							}

							//前置关键任务
							if (data.preTarget) {
								$.get('/projectTarget/selectPreShow', {preTgIds: data.preTarget}, function (res) {
									if (res.flag) {
										var dataPre = res.obj
										var preTaskName = ''
										dataPre.forEach(function (item, index) {
											preTaskName += item.workTargetName + ','
										})
										$('#newOrEditForm input[name="preTgId"]').val(preTaskName)
										$('#newOrEditForm input[name="preTgId"]').attr('preTgId', data.preTarget)
									}
								})
							}

							//关联关键任务
							if (data.linkedTargetList) {
								var tgIds = data.linkedTargetList
								var tgId = ''
								var tgName = ''
								tgIds.forEach(function (item) {
									tgId += item.tgId + ','
									tgName += item.tgName + ','
								})
								$('#newOrEditForm input[name="tgId"]').val(tgName)
								$('#newOrEditForm input[name="tgId"]').attr('tgId', tgId)
								$.post('/projectTarget/selectByIds', {ids: tgId}, function (res) {
									if (res.flag) {
										var str = '<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 10px;">\n' +
												'  <thead>\n' +
												'    <tr>\n' +
												'      <th>关键任务名称</th>\n' +
												'      <th>关注等级</th>\n' +
												'      <th>计划开始时间</th>\n' +
												'      <th>计划结束时间</th>\n' +
												'      <th>完成标准</th>\n' +
												'      <th>关键任务描述</th>\n' +
												'    </tr> \n' +
												'  </thead>\n' +
												'  <tbody>\n'
										res.obj.forEach(function (v, i) {
											str += '<tr>\n' +
													'<td>' + isShowNull(v.tgName) + '</td>\n' +
													'<td>' + (dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+ '</td>\n' +
													'<td>' + isShowNull(v.planStartDate) + '</td>\n' +
													'<td>' + isShowNull(v.planEndDate) + '</td>\n' +
													'<td>' + isShowNull(v.resultStandard) + '</td>\n' +
													'<td>' + function () {
														if (v.tgDesc) {
															return v.tgDesc
														} else {
															return ''
														}
													}() + '</td>\n' +
													'</tr>\n'
										})
										str += '</tbody></table>'
										$('#newOrEditForm').append(str)
									}
								})
							} else {
								$('#newOrEditForm input[name="tgId"]').val('')
							}
						}

						var min = $('#plan_time').attr('minTime')
						var max = $('#plan_time').attr('maxTime')
						// 初始化计划开始时间
						var planStartLaydateConfig = {
							elem: '#planStartDate',
							min: min,
							max: max,
							done: function (value, date) {
								if ($('#planEndDate').val()) {
									var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
									$('input[name="planContinuedDate"]').val(planPeriod);
								}
								if (planEndLaydate.config.min) {
									// 修改开始时间最大选择日期
									planEndLaydate.config.min = {
										year: date.year || 1900,
										month: date.month - 1 || 0,
										date: date.date || 1,
									}
								} else {
									planEndLaydateConfig.min = value;
								}
							},
							trigger: 'click' //采用click弹出
						}
						if (data && data.planEndDate) {
							planStartLaydateConfig.max = data.planEndDate;
						}
						var planStartLaydate = laydate.render(planStartLaydateConfig);

						// 初始化计划结束时间
						var planEndLaydateConfig = {
							elem: '#planEndDate',
							min: min,
							max: max,
							done: function (value, date) {
								if ($('#planStartDate').val()) {
									var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
									$('input[name="planContinuedDate"]').val(planPeriod);
								}
								if (planStartLaydate.config.max) {
									// 修改开始时间最大选择日期
									planStartLaydate.config.max = {
										year: date.year || 2099,
										month: date.month - 1 || 11,
										date: date.date || 31,
									}
								} else {
									planStartLaydateConfig.max = value;
								}
							},
							trigger: 'click' //采用click弹出
						}
						if (data && data.planStartDate) {
							planEndLaydateConfig.min = data.planStartDate;
						}
						var planEndLaydate = laydate.render(planEndLaydateConfig);

						//成果材料提交时间
						laydate.render({
							elem: '#submitDate', //指定元素
							trigger: 'click' //采用click弹出
						});
					},
					yes: function (index) {
						var loadingIndex = layer.load();
						var datas = $('#newOrEditForm').serializeArray()
						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value.trim();
						});
						// 编制依据附件
						var attachmentId4 = '';
						var attachmentName4 = '';
						for (var i = 0; i < $('#attachment4Box .dech').length; i++) {
							attachmentId4 += $('#attachment4Box .dech').eq(i).find('input').val();
							attachmentName4 += $('#attachment4Box a').eq(i).attr('name');
						}
						obj.attachmentId4 = attachmentId4
						obj.attachmentName4 = attachmentName4
						//获取中心责任部门责任人的id
						obj.dutyUser = '';
						if ($('#dutyUser').attr('user_id')) {
							obj.dutyUser = $('#dutyUser').attr('user_id');
						}
						//获取中心责任部门的id
						obj.mainCenterDept = '';
						if ($('#mainCenterDept').attr('deptid')) {
							obj.mainCenterDept = $('#mainCenterDept').attr('deptid').replace(/,$/, '');
						}
						//获取区域责任部门的id
						obj.mainAreaDept = '';
						if ($('#mainAreaDept').attr('deptid')) {
							obj.mainAreaDept = $('#mainAreaDept').attr('deptid').replace(/,$/, '');
						}
						//获取总承包部责任部门的id
						obj.mainProjectDept = '';
						if ($('#mainProjectDept').attr('deptid')) {
							obj.mainProjectDept = $('#mainProjectDept').attr('deptid').replace(/,$/, '');
						}
						//获取区域责任部门责任人的id
						obj.mainAreaUser = '';
						if ($('#mainAreaUser').attr('user_id')) {
							obj.mainAreaUser = $('#mainAreaUser').attr('user_id').replace(/,$/, '');
						}
						//获取总承包部责任部门责任人的id
						obj.mainProjectUser = '';
						if ($('#mainProjectUser').attr('user_id')) {
							obj.mainProjectUser = $('#mainProjectUser').attr('user_id').replace(/,$/, '');
						}
						// 获取成果标准模板
						obj.resultDict = $('#newOrEditForm input[name="resultDict"]').attr('resultDict') || '';
						obj.tgName = $('#newOrEditForm [name="tgName"]').val()
						/*//判断顶层关注是否被勾选
								if($('#newOrEditForm [name="controlLevel"]').prop('checked')){
									obj.controlLevel = 1
								}else{
									obj.controlLevel = 0
								}*/
						obj.planSycle = $('#newOrEditForm [name="planSycle"]').val()
						obj.tgType = $('#newOrEditForm [name="tgType"]').attr('tgType')
						obj.planStage = $('#newOrEditForm [name="planStage"]').val()
						//前置关键任务
						obj.preTarget = $('#newOrEditForm input[name="preTgId"]').attr('preTgId') || ''
						//关联关键任务
						obj.linkedTarget = $('#newOrEditForm input[name="tgId"]').attr('tgid') || ''

						obj.isEffectStart=$('#isEffectStart').val()

						// 判断必填项
						var $requiredEles = $('.required_field', $('#newOrEditForm'));
						var lock = true;
						$requiredEles.each(function () {
							var key = $(this).attr('field_name');
							var value = $(this).parent().text();

							if (!obj[key]) {
								layer.close(loadingIndex);
								layer.msg(value.substring(1) + '不能为空！', {icon: 0, time: 1000});
								lock = false;
								return false;
							}
						});

						if (type === 1) {  //新增
							/*防止关联关键任务的id和主键id名称重复，新增时重设为空*/
							obj.tgId = ''
							if ($('#leftId').attr('pbagId')) {
								obj.pbagId = $('#leftId').attr('pbagId');
							} else {
								obj.projectId = $('#leftId').attr('projectId');
							}
							if (lock) {
								$.post(url, obj, function (res) {
									layer.close(loadingIndex);
									if (res.flag) {
										if (res.object == 1) {
											layer.msg('编号重复，请刷新编号后重试！', {icon: 0, time: 1000});
											return false;
										} else {
											layer.msg('新增成功！', {icon: 1, time: 1000});
										}
										layer.close(index);
										// 修改url时间戳，防止ie下数据没有刷新问题
										tableIns.config.where._ = new Date().getTime();
										tableIns.reload();
									} else {
										if (type === 1) {
											layer.msg('新增失败！', {icon: 2, time: 1000});
										} else if (type === 2) {
											layer.msg('修改失败！', {icon: 2, time: 1000});
										}
									}
								});
							}
						} else if (type === 2) {  //编辑
							obj.tgId = data.tgId;
							if (lock) {
								$.post('/projectTarget/updateCheck', obj, function (res) {
									if(res.object=='1' || res.object=='2'){
										var content=''
										res.object=='1' ? content='当前操作会被前置任务影响,是否修改本任务开始结束时间?' : content='会影响其他任务开始结束时间,是否修改其他任务开始结束时间？'
										layer.confirm(content, {
											btn: ['是','否'] //按钮
										}, function(){
											obj.color=1
											$.post(url, obj, function (res) {
												layer.close(loadingIndex);
												if (res.flag) {
													layer.msg('修改成功！', {icon: 1, time: 1000});
													layer.close(index);
													// 修改url时间戳，防止ie下数据没有刷新问题
													tableIns.config.where._ = new Date().getTime();
													tableIns.reload();
												} else {
													layer.msg('修改失败！', {icon: 2, time: 1000});
												}
											});
										}, function(){
											$.post(url, obj, function (res) {
												layer.close(loadingIndex);
												if (res.flag) {
													layer.msg('修改成功！', {icon: 1, time: 1000});
													layer.close(index);
													// 修改url时间戳，防止ie下数据没有刷新问题
													tableIns.config.where._ = new Date().getTime();
													tableIns.reload();
												} else {
													layer.msg('修改失败！', {icon: 2, time: 1000});
												}
											});
										});
									}else{
										$.post(url, obj, function (res) {
											layer.close(loadingIndex);
											if (res.flag) {
												layer.msg('修改成功！', {icon: 1, time: 1000});
												layer.close(index);
												// 修改url时间戳，防止ie下数据没有刷新问题
												tableIns.config.where._ = new Date().getTime();
												tableIns.reload();
											} else {
												layer.msg('修改失败！', {icon: 2, time: 1000});
											}
										});
									}
								});
							}
						}
					}
				});
			}

			/***
			 * 初始化主项计划
			 * @param pTargetLevel (项目层级)
			 */
			function initProjectPlan(pTargetLevel) {
				var projectItemTable = null;
				layer.open({
					type: 1,
					title: '主项关键任务-初始化',
					btn: ['保存', '退出'],
					area: ['60%', '85%'],
					maxmin: true,
					content: '<div style="position: relative;height: 100%; width: 100%;padding: 5px 10px;box-sizing: border-box;">' +
							'<div class="target_module" style="position: relative;float: left;height: 100%; width: 230px;">' +
							'<h3 style="padding: 10px 15px; text-align: center;">关键任务模板</h3>' +
							'<div class="eleTree target_module_tree" lay-filter="targetModuleTree"></div>' +
							'</div>' +
							'<div class="project_item">' +
							'<h3 style="padding: 10px 15px; text-align: center;">关键任务选择</h3>' +
							'<div>' +
							'<table id="projectItemTable" lay-filter="projectItemTable"></table>' +
							'</div>' +
							'</div>' +
							'</div>',
					success: function () {
						/*tgIdsArr=[]
								$.get('/TemplateItem/selectAllCheck',function (res) {
									res.obj.forEach(function (item) {
										tgIdsArr.push(item.tgId)
									})
								})*/
						// 初始化左侧关键任务模板树
						/*限制显示哪个层级*/
						var level=parseInt($('.eleTree-checkbox-checked').parents('.eleTree-node').eq(0).attr('eletree-floor'))+1
						var targetModuleTree = eleTree.render({
							elem: '.target_module_tree',
							url: '/TemplateType/findAllShow?level='+level,
							highlightCurrent: true,
							showLine: true,
							request: {
								name: "typeName", // 显示的内容
								key: "tplTypeId", // 节点id
								children: "son",
							},
							response: {
								statusName: 'flag',
								statusCode: true,
								dataName: "object"
							},
						});

						// 模板树节点点击
						eleTree.on("nodeClick(targetModuleTree)", function (d) {
							// console.log(d.data.currentData)
							//判断如果是最高父级，则展示该父级下所有关键任务
							if (d.data.currentData.parentTypeId == 0) {
								$('.project_item').hide()
								/*暂时注释不用*/
								/*$.get('/TemplateItem/selectAllByTplTypeId', {tplTypeId: d.data.currentData.tplTypeId}, function (res) {
                                            projectItemTable = table.render({
                                                elem: '#projectItemTable',
                                                data: res.obj,
                                                limit: Number.MAX_VALUE, // 数据表格默认全部显示
                                                cols: [[
                                                    {type: 'checkbox'},
                                                    {
                                                        field: 'tgName', align: 'left', title: '工作项名称', templet: function (d) {
                                                            return '<span  class="initTgId" tgId="' + d.tgId + '" >' + d.tgName + '</span>'
                                                        }
                                                    }
                                                ]],
                                                done: function (res) {
                                                    // console.log(res)
                                                    $('#projectItemTable').next().find('.layui-table-header').remove()
                                                    //选中的回显
                                                    $('.initTgId').each(function (index) {
                                                        tgIdsArr.forEach(function (v, i) {
                                                            if ($('.initTgId').eq(index).attr('tgid') == v) {
                                                                $('.initTgId').eq(index).parents('td').prev().find('input').prop('checked', 'true')
                                                                form.render()
                                                            }
                                                        })
                                                    })
                                                    //被强制勾选的回显且不可取消
                                                    var data = res.data
                                                    data.forEach(function (item, index) {
                                                        if (item.forceCheck == 1) {
                                                            // tgIdsArr.push(item.tgId)
                                                            $('.initTgId[tgid="' + item.tgId + '"]').parents('td').prev().find('input').prop('checked', 'true').attr('disabled', 'disabled')
                                                            form.render()
                                                        }
                                                    })
                                                    // console.log(tgIdsArr)
                                                }
                                            });
                                        })*/
							} else {
								$('.project_item').show()
								projectItemTable = table.render({
									elem: '#projectItemTable',
									url: '/TemplateItem/findTemplateByTypeId',
									// page: true,
									cols: [[
										{type: 'checkbox'},
										{
											field: 'tgName', align: 'left', title: '关键任务名称', templet: function (d) {
												return '<span  class="initTgId" tgId="' + d.tgId + '" >' + d.tgName + '</span>'
											}
										}
									]],
									where: {
										typeId: d.data.currentData.tplTypeId,
										useFlag: false
									},
									response: {
										statusName: 'flag',
										statusCode: true,
										msgName: 'msg',
										// countName: 'totleNum',
										dataName: 'obj'
									},
									done: function (res) {
										// console.log(res)
										// $('#projectItemTable').next().find('.layui-table-header').remove()
										//选中的回显
										$('.initTgId').each(function (index) {
											tgIdsArr.forEach(function (v, i) {
												if ($('.initTgId').eq(index).attr('tgid') == v) {
													$('.initTgId').eq(index).parents('td').prev().find('input').prop('checked', 'true')
													form.render()
												}
											})
										})
										//被强制勾选的回显且不可取消
										var data = res.obj
										data.forEach(function (item, index) {
											if (item.forceCheck == 1) {
												// tgIdsArr.push(item.tgId)
												$('.initTgId[tgid="' + item.tgId + '"]').parents('td').prev().find('input').prop('checked', 'true').attr('disabled', 'disabled')
												form.render()
											}
										})
										// console.log(tgIdsArr)
									}
								});
								/*if (projectItemTable) {
											projectItemTable.reload({
												where: {
													typeId: d.data.currentData.tplTypeId,
													useFlag: false
												}
											});
										} else {
											projectItemTable = table.render({
												elem: '#projectItemTable',
												url: '/TemplateItem/findTemplateByTypeId',
												// page: true,
												cols: [[
													{type: 'checkbox'},
													{field: 'tgName', align: 'left', title: '工作项名称',templet: function(d){
															return '<span  class="initTgId" tgId="'+d.tgId+'" >'+ d.tgName +'</span>'
														}}
												]],
												where: {
													typeId: d.data.currentData.tplTypeId,
													useFlag: false
												},
												response: {
													statusName: 'flag',
													statusCode: true,
													msgName: 'msg',
													// countName: 'totleNum',
													dataName: 'obj'
												},
												done:function (res) {
													// console.log(res)
													$('#projectItemTable').next().find('.layui-table-header').remove()
													//选中的回显
													$('.initTgId').each(function (index) {
														tgIdsArr.forEach(function (v,i) {
															if($('.initTgId').eq(index).attr('tgid')==v){
																$('.initTgId').eq(index).parents('td').prev().find('input').prop('checked','true')
																form.render()
															}
														})
													})
													//被强制勾选的回显且不可取消
													var data=res.obj
													data.forEach(function (item,index) {
														if(item.forceCheck==1){
															// tgIdsArr.push(item.tgId)
															$('.initTgId[tgid="'+item.tgId+'"]').parents('td').prev().find('input').prop('checked','true').attr('disabled','disabled')
															form.render()
														}
													})
													// console.log(tgIdsArr)
												}
											});
										}*/
							}
						});

						//监听复选框
						/*	table.on('checkbox(projectItemTable)', function(obj){
										// console.log(obj.checked); //当前是否选中状态
										// console.log(obj.data); //选中行的相关数据
										// console.log(obj.type); //如果触发的是全选，则为：all，如果触发的是单选，则为：one
										if(obj.checked){
											tgIdsArr.push(obj.data.tgId)
										}else{
											for(var i = 0; i < tgIdsArr.length; i++){
												if(tgIdsArr[i] ==obj.data.tgId){
													tgIdsArr.splice(i,1);
												}
											}
										}
										// console.log(tgIdsArr)
									});*/
					},
					yes: function (index) {
						// var checkStatus = table.checkStatus('projectItemTable');
						var tgIdsArr = []
						$('#projectItemTable').next().find('.layui-table-body .layui-table tr .layui-form-checked').each(function () {
							var tgId = $(this).parents('td').next().find('.initTgId').attr('tgId')
							tgIdsArr.push(tgId)
						})
						// console.log(tgIdsArr)
						if (tgIdsArr.length > 0) {
							var loadingIndex = layer.load();
							var workItemTgId = '';
							var obj = {}
							workItemTgId = tgIdsArr.join() + ',';
							/*  checkStatus.data.forEach(function (item) {
										  workItemTgId += item.tgId + ',';
									  });*/

							/*  if ($('#leftId').attr('pbagId')) {
										  obj.projectId = $('#leftId').attr('projectId') || '';
										  obj.pbagId = $('#leftId').attr('pbagId') || '';
									  } else {
										  obj.projectId = $('#leftId').attr('projectId') || '';
									  }*/

							//勾选项目初始化--只有一个
							if (leftProjectIdArr.length > 0) {
								obj.projectId = leftProjectIdArr.join()
							} else {
								obj.pbagIds = leftPbagIdArr.join() + ','
								//获取所选子项目的最高级项目的id
								obj.projectId = $('.eleTree-checkbox-checked').eq(0).parents('.eleTree-node[eletree-floor="0"]').attr('data-ids')
							}

							obj.workItemTgId = workItemTgId;
							obj.pTargetLevel = pTargetLevel;

							$.post('/projectTarget/initialize', obj, function (res) {
								layer.close(loadingIndex);
								if (res.flag) {
									layer.close(index);
									layer.msg('初始化成功！', {icon: 1, time: 1000});
									tableIns.config.where._ = new Date().getTime();
									tableIns.reload();
								} else {
									layer.msg('初始化失败！', {icon: 2, time: 1000});
								}
							});
						} else {
							layer.msg('请选择关键任务', {icon: 0, time: 1000});
						}
					}
				});
			}

			/***
			 * 修编主项计划
			 */
			function revisionProjectPlan(data) {
				//判断所选关键任务修编时间是否填写
				for (var i = 0; i < data.length; i++) {
					if (!data[i].planStartDate) {
						layer.msg('请将勾选的关键任务中的计划开始时间补充完整！', {icon: 0});
						return false
					} else if (!data[i].planEndDate) {
						layer.msg('请将勾选的关键任务中的计划结束时间补充完整！', {icon: 0});
						return false
					} else if (!data[i].planContinuedDate) {
						layer.msg('请将勾选的关键任务中的计划工期补充完整！', {icon: 0});
						return false
					}
				}
				layer.open({
					type: 1,
					title: '主项计划-修编',
					btn: ['确定', '取消'],
					area: ['60%', '85%'],
					content: '<div>' +
							'<div><table id="projectRevisionTable" lay-filter="projectRevisionTable"></table></div>' +
							'<div>' +
							/* '<form id="revisionForm">' +
									 '<div class="layui-form-item">' +
										 '<label class="layui-form-label">修编原因</label>' +
										 '<div class="layui-input-block">' +
											 '<textarea name="unusualStuff" class="layui-textarea"></textarea>' +
										 '</div>' +
									 '</div>' +
									 '<div class="layui-form-item">' +
										 '<label class="layui-form-label">支撑材料</label>' +
										 '<div class="layui-input-block">' +
											 '<div id="attachment3FileBox"></div>' +
											 '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">' +
												 '<img src="../img/mg11.png" alt="">' +
												 '<span><fmt:message code="email.th.addfile"/></span>' +
								                            '<input type="file" multiple id="attachment3" data-url="/upload?module=plancheck" name="file">' +
							                            '</a>' +
						                            '</div>' +
						                        '</div>' +
	                                        '</form>' +*/
							'</div>' +
							'</div>',
					success: function () {
						// 初始化上传按钮
						// fileuploadFn('#attachment3', $('#attachment3FileBox'));

						var projectRevisionTable = table.render({
							elem: '#projectRevisionTable',
							data: data,
							cols: [[
								{type: 'numbers'},
								{
									field: 'tgName', title: '关键任务名称', templet: function (d) {
										return '<span  class="tgName" tgId="' + d.tgId + '" >' + d.tgName + '</span>'
									}
								},
								{
									field: 'planStartDate', title: '计划开始时间', templet: function (d) {
										var startDateStr = '<input type="text" style="height: 100%;" readonly class="layui-input table_date_start" value="' + d.planStartDate + '">'
										return startDateStr;
									}
								},
								{
									field: 'planEndDate', title: '计划完成时间', templet: function (d) {
										var planEndDate = '<input type="text" style="height: 100%;" readonly class="layui-input table_date_end" value="' + d.planEndDate + '">'
										return planEndDate;
									}
								},
								{
									field: 'planContinuedDate', title: '计划工期', templet: function (d) {
										return '<span class="table_planContinuedDate">' + d.planContinuedDate + '</span>'
									}
								},
								{
									field: 'designQuantity', title: '设计量', edit: 'text', templet: function (d) {
										return '<span class="table_designQuantity">' + d.designQuantity + '</span>'
									}
								},
								{
									field: 'itemQuantity', title: '工程量', edit: 'text', templet: function (d) {
										return '<span class="table_itemQuantity">' + d.itemQuantity + '</span>'
									}
								},
							]],
							done: function (res) {
								var $tableTrEles = $('#projectRevisionTable').next().find('tr');

								res.data.forEach(function (item, index) {
									var tableDateStartEle = $tableTrEles.eq(index + 1).find('.table_date_start').get(0);
									var startDatePickConfig = {
										elem: tableDateStartEle,
										format: 'yyyy-MM-dd',
										btns: ['now', 'confirm'],
										max: item.planEndDate,
										done: function (value, date) {
											var $tr = $(tableDateStartEle).parents('tr').eq(0);
											var planPeriod = timeRange(value, $tr.find('.table_date_end').eq(0).val()) + '天';
											$tr.find('.table_planContinuedDate').text(planPeriod);

											if (endDatePick.config.min) {
												endDatePick.config.min = {
													year: date.year || 1900,
													month: date.month - 1 || 0,
													date: date.date || 1,
												}
											} else {
												endDatePickConfig.min = value;
											}
										},
										trigger: 'click' //采用click弹出
									}
									var startDatePick = laydate.render(startDatePickConfig);

									var tableDateEndEle = $tableTrEles.eq(index + 1).find('.table_date_end').get(0);
									var endDatePickConfig = {
										elem: tableDateEndEle,
										format: 'yyyy-MM-dd',
										btns: ['now', 'confirm'],
										min: item.planStartDate,
										done: function (value, date) {
											var $tr = $(tableDateEndEle).parents('tr').eq(0);
											var planPeriod = timeRange($tr.find('.table_date_start').eq(0).val(), value) + '天';
											$tr.find('.table_planContinuedDate').text(planPeriod);

											if (startDatePick.config.max) {
												startDatePick.config.max = {
													year: date.year || 2099,
													month: date.month - 1 || 11,
													date: date.date || 31
												}
											} else {
												startDatePickConfig.max = value;
											}
										},
										trigger: 'click' //采用click弹出
									}
									var endDatePick = laydate.render(endDatePickConfig);
								});
							}
						});
					},
					yes: function (index) {
						var arr = []
						$('#projectRevisionTable').next().find('.layui-table-box .layui-table-body tr').each(function () {
							if ($(this).find('.table_date_start').val() && $(this).find('.table_date_end').val() && $(this).find('.table_designQuantity').text() && $(this).find('.table_itemQuantity').text()) {
								var obj = {}
								obj.planStartDate = $(this).find('.table_date_start').val()
								obj.planEndDate = $(this).find('.table_date_end').val()
								obj.planContinuedDate = $(this).find('.table_planContinuedDate').text()
								obj.designQuantity = $(this).find('.table_designQuantity').text()
								obj.itemQuantity = $(this).find('.table_itemQuantity').text()
								obj.tgId = $(this).find('.tgName').attr('tgId')
								arr.push(obj)
							}
						})
						$.ajax({
							url: '/projectTarget/revision',
							data: JSON.stringify(arr),
							contentType: "application/json;charset=UTF-8",
							dataType: 'json',
							type: 'post',
							success: function (res) {
								if (res.flag) {
									layer.msg('修编成功！', {icon: 1});
									layer.close(index)
									tableIns.config.where._ = new Date().getTime();
									tableIns.reload();
								}
							}
						})
					}
				});
			}

			//修编详情
			function openRevisionDetail(tgId) {
				$.post('/EditRecord/selectByTgId', {tgId: tgId}, function (res) {
					layer.open({
						type: 1,
						title: '修编详情',
						area: ['80%', '70%'],
						content: '<div id="revision_view"></div>',
						success: function () {
							var data = res.obj
							if (res.flag && data.length > 0) {
								data.forEach(function (item, index) {
									if (item.length > 0) {
										var tableTitle = '<table class="layui-table"><thead><tr>' + '<th nowrap="nowrap">关键任务名称</th>'
										var str = '<tbody><tr>' + '<td>' + function () {
											if (item.length > 0) {
												return item[0].tgName
											} else {
												return ''
											}
										}() + '</td>'
										var editArr = []
										//对数据进行分割处理
										item.forEach(function (v, i) {
											if (i == 0) {
												var bEditContent = v.bEditContent.split('&')
												var aEditContent = v.aEditContent.split('&')
												editArr = editArr.concat(bEditContent).concat(aEditContent)
											} else {
												var aEditContent = v.aEditContent.split('&')
												editArr = editArr.concat(aEditContent)
											}
										})
										//对表头显示处理
										for (var i = 0; i < item.length + 1; i++) {
											if (i == item.length) {
												tableTitle += '<th nowrap="nowrap">计划开始时间</th>\n' +
														'      <th nowrap="nowrap">计划完成时间</th>\n' +
														'      <th nowrap="nowrap">计划工期</th>' +
														'      <th nowrap="nowrap">设计量</th>' +
														'      <th nowrap="nowrap">工程量</th></thead>'
											} else {
												tableTitle += '<th nowrap="nowrap">计划开始时间</th>\n' +
														'      <th nowrap="nowrap">计划完成时间</th>\n' +
														'      <th nowrap="nowrap">计划工期</th>' +
														'      <th nowrap="nowrap">设计量</th>' +
														'      <th nowrap="nowrap">工程量</th>'
											}
										}
										editArr.forEach(function (v, i) {
											if (i == editArr.length - 1) {
												str += '<td nowrap="nowrap">' + v + '</td></tr></tbody></table>'
											} else {
												str += '<td nowrap="nowrap">' + v + '</td>'
											}
										})

										$('#revision_view').append(tableTitle + str)
									} else {
										$('#revision_view').append('<p style="text-align: center">暂无修编详情</p>')
									}
								})
							}
						},
					})
				})
			}

			/***
			 * 修改表格内容方法
			 * @param tgId (关键任务id)
			 * @param updateData (需要修改的数据)
			 */
			function revisionUpdate(tgId, updateData) {
				$.post('/projectTarget/update', $.extend({}, {tgId: tgId}, updateData), function (res) {
					if (res.flag) {
						// layer.msg('修改成功！', {icon: 1, time: 1000});
						// tableIns.config.where._ = new Date().getTime();
						// tableIns.reload();
					} else {
						layer.msg('修改失败！', {icon: 2, time: 1000});
					}
				});
			}

			/***
			 * 主项关键任务上报方法
			 * @param targetType (关键任务类型)
			 * @param projectId (项目id)
			 * @param projectName (项目名称)
			 */
			function reportPlan(projectId, projectName, tgId) {
				layer.open({
					type: 1,
					title: '计划提交',
					btn: ['保存','退出'],
					area: ['1000px', '500px'],
					content: '<form class="layui-form" id="reportForm" style="padding: 20px 15px;" lay-filter="reportForm">' +
							'<div class="layui-row">' +
							'<div class="layui-col-xs6">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">计划编号<span class="required_field" field_name="planNo">*</span></label>' +
							'<div class="layui-input-block">' +
							'<input type="text" name="planNo" readonly autocomplete="off" class="layui-input" style="display: inline-block;width: 300px;background:#e7e7e7;">' +
							'<span class="refreshPlanNo" style="margin-left: 10px;color: rgb(30, 159, 255);cursor: pointer;">刷新</span>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-col-xs6">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">类型<span class="required_field" field_name="planClass">*</span></label>' +
							'<div class="layui-input-block">' +
							'<input type="text" name="planClass" readonly autocomplete="off" class="layui-input" value="主项关键任务" style="background:#e7e7e7;">' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-row">' +
							'<div class="layui-col-xs4">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">周期类型<span class="required_field" field_name="planCycle">*</span></label>' +
							'<div class="layui-input-block">' +
							'<select name="planCycle"></select>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-col-xs4">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">年度</label>' +
							'<div class="layui-input-block">' +
							'<select name="planYear" lay-filter="planYear">' +
							'<option value="">请选择</option>' +
							'</select>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-col-xs4">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">月度</label>' +
							'<div class="layui-input-block">' +
							'<select name="planMonth"></select>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-row">' +
							'<div class="layui-col-xs4">' +
							'<div class="layui-form-item">' +
							// '<label class="layui-form-label">关键任务类型<span class="required_field" field_name="planType">*</span></label>' +
							'<label class="layui-form-label">关键任务类型</label>' +
							'<div class="layui-input-block">' +
							// '<select name="planType"><option value="">请选择</option></select>' +
							'<input type="text" name="planType" readonly id="tgType_add" class="layui-input" style="display: inline-block; width: 150px;background-color: #e7e7e7;">' +
							'<span style="margin-left: 2px; color: red; cursor: pointer;" class="tgTypeAdd">添加</span>' +
							'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="tgTypeDel">清空</span>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-col-xs4">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">审批人<span class="required_field" field_name="dutyUser">*</span></label>' +
							'<div class="layui-input-block">' +
							'<input type="text" name="dutyUser" readonly id="reportDutyUser" class="layui-input" style="display: inline-block; width: 150px;background-color: #e7e7e7;">' +
							'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_user">添加</span>' +
							'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_user">清空</span>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-col-xs4">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">所属单位<span class="required_field" field_name="belongtoUnit">*</span></label>' +
							'<div class="layui-input-block">' +
							'<input type="text" name="belongtoUnit" id="belongtoUnit" readonly autocomplete="off" style="display: inline-block;background-color: #e7e7e7;" class="layui-input">' +
							/*  '<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_dept">添加</span>' +
                                '<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_dept">清空</span>' +*/
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-row">' +
							'<div class="layui-col-xs12">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">所属项目</label>' +
							'<div class="layui-input-block">' +
							'<input type="text" name="belongtoProj" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'<div class="layui-row">' +
							'<div class="layui-col-xs12">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label">计划名称<span class="required_field" field_name="planName">*</span></label>' +
							'<div class="layui-input-block">' +
							'<input type="text" name="planName" autocomplete="off" class="layui-input" style="display: inline-block;width: 88%">' +
							' <button type="button" class="layui-btn layui-btn-sm autoPlanName" style="margin-left: 15px">生成名称</button>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							' <div class="layui-form-item"  style="margin-top:15px">\n' +
							'    <label class="layui-form-label" style="padding:3px;width:90px">线下审批结果:</label>\n' +
							'    <div class="layui-input-block">\n' +
							' <div id="fileContent">\n' +
							'</div>\n' +
							'<a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
							'<img src="../img/mg11.png" alt="">\n' +
							'<span><fmt:message code="email.th.addfile"/></span>\n' +
							'<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
							'</a>\n' +
							'<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
							'<div class="bar" style="width: 0%;"></div>\n' +
							'</div>\n' +
							'<div class="barText" style="float: left;margin-left: 10px;"></div>'+
							'</div>\n' +
							'</div>' +

							'</form>',
					success: function () {
						fileuploadFn('#fileupload', $('#fileContent'));
						/*自动生成计划名称*/
						$('.autoPlanName').on('click',function () {
							var planYear = $('#reportForm select[name="planYear"]').val()
							var planMonth = $('#reportForm select[name="planMonth"]').val()
							var planCycle = $('#reportForm select[name="planCycle"] option:selected').text()
							var planClass = $('#reportForm input[name="planClass"]').val()
							var belongtoProj = $('#reportForm input[name="belongtoProj"]').val()
							$('#reportForm input[name="planName"]').val(function () {
								if (planYear) {
									return planYear + '年'
								} else {
									return ''
								}
							}() + planMonth + planCycle + planClass + '-' + belongtoProj)
						})
						//默认审批人为所属项目在组织机构的组织责任人
						$.get('/ProjectInfo/getOrgUser', {projectId: projectId, pbagId: ''}, function (res) {
							if (res.object) {
								$('#reportDutyUser').val(res.object.principalUserName || '')
								$('#reportDutyUser').attr('user_id', res.object.principalUser || '')
							}
						})
						//默认所属部门为所属项目所在组织机构
						$.get('/ProjectInfo/selectProjectInfoById', {projectId: projectId}, function (res) {
							if (res.obj) {
								$('#belongtoUnit').val(res.obj.respectiveRegionName || '')
								$('#belongtoUnit').attr('deptid', res.obj.deptId || '')
							}
						})
						$('#reportForm select[name="planCycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);
						// $('#reportForm select[name="planType"]').append(dictionaryObj['TG_TYPE']['str']);

						$('#reportForm select[name="planYear"]').append(allYear);

						form.render();

						getPlanMonth($('#reportForm select[name="planYear"]').val(), function (monthSrt) {
							$('#reportForm select[name="planMonth"]').html(monthSrt);
							form.render('select');
						});

						// 监听年度下拉框选择
						form.on('select(planYear)', function (data) {
							getPlanMonth(data.value, function (monthSrt) {
								$('#reportForm select[name="planMonth"]').html(monthSrt);
								form.render('select');
							});
						});

						getAutoNo({model: 'plcPlan', planClass: 1}, function (autoNo) {
							$('#reportForm [name="planNo"]').val(autoNo);
						});

						// 刷新编号
						$('.refreshPlanNo').on('click', function () {
							getAutoNo({model: 'plcPlan', planClass: 1}, function (autoNo) {
								$('#reportForm [name="planNo"]').val(autoNo);
							});
						});

						$('#reportForm [name="belongtoProj"]').val(projectName);

						//新建时默认年度为当年
						$('#reportForm select[name="planYear"] option').each(function () {
							var nowYear = new Date().getFullYear()
							if ($(this).text() == nowYear) {
								$('#reportForm select[name="planYear"]').val($(this).val())
								form.render()
							}
						})

						/*//提交时关键任务类型默认为整体目标
								$('#reportForm select[name="planType"] option').each(function () {
									if($(this).text()=='整体目标'){
										$('#reportForm select[name="planType"]').val($(this).val())
										form.render()
										return false
									}
								})*/

						$('.add_report_user').on('click', function () {
							user_id = 'reportDutyUser';
							$.popWindow("/common/selectUser?0");
						});
						$('.clear_report_user').on('click', function () {
							$('#reportDutyUser').val('');
							$('#reportDutyUser').attr('user_id', '');
						});
						/*    $('.add_report_dept').on('click', function () {
                                    dept_id = 'belongtoUnit';
                                    $.popWindow("/common/selectDept?0");
                                });
                                $('.clear_report_dept').on('click', function () {
                                    $('#belongtoUnit').val('');
                                    $('#belongtoUnit').attr('deptId', '');
                                });*/

					},
					yes: function (index) {
						var loadingIndex = layer.load();

						var datas = $('#reportForm').serializeArray();

						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value.trim();
						});

						obj.dutyUser = $('#reportDutyUser').attr('user_id') || '';
						obj.belongtoUnit = parseInt(($('#belongtoUnit').attr('deptId') || '').replace(/,$/, ''));
						obj.belongtoProj = projectId;
						obj.planClass = 1;
						obj.apprivalStatus = 1
						obj.tgIds = tgId
						obj.planType = $('#reportForm [name="planType"]').attr('dictNo') ? $('#reportForm [name="planType"]').attr('dictNo').replace(/,$/,'') : ''

						// 判断必填项
						var $requiredEles = $('.required_field', $('#reportForm'));
						var isLock = false;
						$requiredEles.each(function () {
							var key = $(this).attr('field_name');
							var value = $(this).parent().text();

							if (!obj[key]) {
								layer.close(loadingIndex);
								layer.msg(value.replace(/\*$/, '') + '不能为空！', {icon: 0, time: 1000});
								isLock = true;
								return false;
							}
						});

						//线下审批结果
						var attachmentId1 = '';
						var attachmentName1 = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId1 += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName1 += $('#fileContent a').eq(i).attr('name');
						}
						obj.attachmentId1=attachmentId1
						obj.attachmentName1=attachmentName1

						if (!isLock) {
							$.post('/plcPlan/addPlcPlan', obj, function (res) {
								layer.close(loadingIndex);
								if (res.flag) {
									if (res.object == 1) {
										layer.msg(res.msg, {icon: 2, time: 1000});
									} else {
										layer.msg('提交成功！', {icon: 1, time: 1000});
										layer.close(index);
										tableIns.config.where._ = new Date().getTime();
										tableIns.reload();
									}
								} else {
									layer.msg('保存失败！', {icon: 2, time: 1000});
								}
							});
						}
					},
					btn2: function (index) {
						var loadingIndex = layer.load();

						var datas = $('#reportForm').serializeArray();

						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value.trim();
						});

						obj.dutyUser = $('#reportDutyUser').attr('user_id') || '';
						obj.belongtoUnit = parseInt(($('#belongtoUnit').attr('deptId') || '').replace(/,$/, ''));
						;
						obj.belongtoProj = projectId;
						obj.planClass = 1;
						obj.tgIds = tgId
						obj.apprivalStatus = 1

						obj.planType = $('#reportForm [name="planType"]').attr('dictNo') ? $('#reportForm [name="planType"]').attr('dictNo').replace(/,$/,'') : ''


						// 判断必填项
						var $requiredEles = $('.required_field', $('#reportForm'));
						var isLock = false;
						$requiredEles.each(function () {
							var key = $(this).attr('field_name');
							var value = $(this).parent().text();

							if (!obj[key]) {
								layer.close(loadingIndex);
								layer.msg(value.replace(/\*$/, '') + '不能为空！', {icon: 0, time: 1000});
								isLock = true;
								return false;
							}
						});

						//线下审批结果
						var attachmentId1 = '';
						var attachmentName1 = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId1 += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName1 += $('#fileContent a').eq(i).attr('name');
						}
						obj.attachmentId1=attachmentId1
						obj.attachmentName1=attachmentName1

						var year = new Date().getFullYear();
						var month = new Date().getMonth()+1;
						var day = new Date().getDate();
						if (month < 10) {
							month = "0" + month;
						}
						if (day < 10) {
							day = "0" + day;
						}
						var today = year+"-" + month + "-" + day;
						obj.reportDate=today

						if (!isLock) {
							$.post('/plcPlan/addPlcPlan', obj, function (res) {
								layer.close(loadingIndex);
								if (res.flag) {
									if (res.object == 1) {
										layer.msg(res.msg, {icon: 2, time: 1000});
									} else {
										layer.msg('上报成功！', {icon: 1, time: 1000});
										layer.close(index);
										tableIns.config.where._ = new Date().getTime();
										tableIns.reload();
									}
								} else {
									layer.msg('上报失败！', {icon: 2, time: 1000});
								}
							});
						}
					}
				});
			}

			//查询--关键任务类型--弹出层选择
			$('#tgType_query').on('click',function () {
				tgTypeSelect(1)
			})

			//查询--关键任务类型-清空
			$(document).on('click','.tgTypeDel',function () {
				var id=$(this).siblings('input').attr('id')
				$('#'+id).val('')
				$('#'+id).attr('dictNo','')
			})

			$(document).on('click','.tgTypeAdd',function () {
				tgTypeSelect(1,$(this).siblings('input').attr('id'))
			})

			/*弹出层显示关键任务类型--tgType*/
			function tgTypeSelect(chooseNum,id) {
				var tgTypeChildren=null
				if($('#'+id).attr('dictNo')){
					var dictArr=$('#'+id).attr('dictNo').split(',')
					var dictNameArr=$('#'+id).val().split(',')
				}else{
					var dictArr=[]
					var dictNameArr=[]
				}
				layer.open({
					type: 1,
					title: '关键任务类型',
					btn: ['确定', '取消'],
					area: ['60%', '85%'],
					maxmin: true,
					content: '<div style="position: relative;height: 100%; width: 100%;padding: 5px 10px;box-sizing: border-box;">' +
							'<div class="target_module" style="position: relative;float: left;height: 100%; width: 230px;">' +
							'<h3 style="padding: 10px 15px; text-align: center;">关键任务类型父级</h3>' +
							'<div class="tgTypeParent"><ul style="margin-top: 8px"></ul></div>' +
							'</div>' +
							'<div class="project_item">' +
							'<h3 style="padding: 10px 15px; text-align: center;">关键任务类型子级</h3>' +
							'<div>' +
							'<table id="tgTypeChildren" lay-filter="tgTypeChildren"></table>' +
							'</div>' +
							'</div>' +
							'</div>',
					success: function () {
						// 初始化左侧关键任务类型
						$.get('/Dictonary/selectDictionaryByNo',{dictNo:'TG_TYPE_PARENT'},function (res) {
							var data=res.data
							var str=''
							for(var i=0;i<data.length;i++){
								str+='<li dictNo="'+data[i].dictNo+'" style="text-align: center;padding: 3px">'+data[i].dictName+'</li>';
							}
							$('.tgTypeParent ul').html(str)
						})
						// 节点点击事件
						$(document).on('click','.tgTypeParent ul li',function () {
							$(this).addClass('select').siblings().removeClass('select')
							var dictNo=$(this).attr('dictNo')
							//判断是单选还是多选
							if(chooseNum==1){
								var chooseType='radio'
							}else{
								var chooseType='checkbox'
							}
							tgTypeChildren = table.render({
								elem: '#tgTypeChildren',
								url: '/Dictonary/getTgTypeByDictNo',
								cols: [[
									{type:chooseType},
									{
										field: 'dictName', align: 'left', title: '关键任务类型', templet: function (d) {
											return '<span  class="initTgId" dictNo="' + d.dictNo + '" >' + d.dictName + '</span>'
										}
									}
								]],
								where: {
									dictNo: dictNo,
								},
								response: {
									statusName: 'flag',
									statusCode: true,
									msgName: 'msg',
									dataName: 'obj'
								},
								done: function (res) {
									//输入框选中的回显
									//弹出页面选择后切换回显
									if(dictArr.length>0){
										$('.initTgId').each(function (index) {
											dictArr.forEach(function (v, i) {
												if ($('.initTgId').eq(index).attr('dictNo') == v) {
													$('.initTgId').eq(index).parents('td').prev().find('input').prop('checked', 'true')
													form.render()
												}
											})
										})
									}
								}
							});
						})
						table.on('radio(tgTypeChildren)', function(obj){
							dictArr=[]
							dictNameArr=[]
							dictArr.push(obj.data.dictNo)
							dictNameArr.push(obj.data.dictName)
						});

						//监听复选框
						table.on('checkbox(tgTypeChildren)', function(obj){
							if(obj.checked){
								dictArr.push(obj.data.dictNo)
								dictNameArr.push(obj.data.dictName)
							}else{
								for(var i = 0; i < dictArr.length; i++){
									if(dictArr[i] ==obj.data.dictNo){
										dictArr.splice(i,1);
									}
								}
								for(var i = 0; i < dictNameArr.length; i++){
									if(dictNameArr[i] ==obj.data.dictName){
										dictNameArr.splice(i,1);
									}
								}
							}
						});
					},
					yes: function (index) {
						var dictNo=''
						var dictName=''
						dictArr.forEach(function (v) {
							dictNo += v+','
						})
						dictNameArr.forEach(function (v) {
							dictName += v+','
						})
						$('#'+id).val(dictName)
						$('#'+id).attr('dictNo',dictNo)
						layer.close(index)
					}
				});
			}
		});
	}

	//附件上传 方法
	var timer=null;
	function fileuploadFn(formId,element) {
		$(formId).fileupload({
			dataType:'json',
			progressall: function (e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
				element.siblings('.progress').find('.bar').css(
						'width',
						progress + '%'
				);
				element.siblings('.barText').html(progress + '%');
				if(progress >= 100){  //判断滚动条到100%清除定时器
					timer=setTimeout(function () {
						element.siblings('.progress').find('.bar').css(
								'width',
								0 + '%'
						);
						element.siblings('.barText').html('');
					},2000);

				}
			},
			done: function (e, data) {
				if(data.result.obj != ''){
					var data = data.result.obj;
					var str = '';
					var str1 = '';
					for (var i = 0; i < data.length; i++) {
						var gs = data[i].attachName.split('.')[1];
						if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
							str += '';
							layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
								layer.closeAll();
							});
						}
						else{
							var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
							var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
							var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
							var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

							str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
						}
					}
					element.append(str);
				}else{
					layer.alert('添加附件大小不能为空!',{},function(index){
						layer.close(index);
					});
				}
			}
		});
	}

	//判断是否该为空
	function isUndefined(data) {
		if (data == 1) {
			return '是';
		} else if (data == 0) {
			return '否';
		} else {
			return '';
		}
	}

	//将毫秒数转为yyyy-MM-dd格式时间
	function format(t) {
		if (t) {
			return new Date(t).Format("yyyy-MM-dd");
		} else {
			return '';
		}
	}

	/***
	 * 计算计划工期
	 * @param beginTime (开始时间)
	 * @param endTime (结束时间)
	 * @returns {number}
	 */
	function timeRange(beginTime, endTime) {
		var days = 0;
		if (!!beginTime && !!endTime) {
			var t1 = new Date(beginTime);
			var t2 = new Date(endTime);
			var time = t2.getTime() - t1.getTime();
			var days = parseInt(time / (1000 * 60 * 60 * 24)) + 1;
		}
		return days;
	}

	/***
	 * 获取计划期间月度
	 * @param year (月度对应年份)
	 * @param cb (回调函数)
	 */
	function getPlanMonth(year, fn) {
		$.get('/planPeroidSetting/showAllSet', {periodYear: year}, function (res) {
			var str = '<option value="">请选择</option>';
			if (res.object.length > 0) {
				res.object.forEach(function (item) {
					str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>'
				});
			}
			if (fn) {
				fn(str);
			}
		});
	}

	/***
	 * 获取编号
	 * @param data (参数)
	 * @param fn (回调函数)
	 */
	function getAutoNo(data, fn) {
		$.get('/ProjectInfo/getMaxNo', data, function (res) {
			if (fn) {
				fn(res);
			}
		});
	}

	//计划提交时的所属单位对应的是该项目属于哪个部门下，不对应审批人所在部门，故注释
	/***
	 * 计划上报选择责任人后
	 * @param userId (用户id)
	 */
	/* function checkOver(userId) {
                $.get('/hr/manage/selectOne', {userId: userId.replace(/,$/, '')}, function (res) {
                    $('#belongtoUnit').val(res.deptName);
                    $('#belongtoUnit').attr('deptId', res.deptId);
                });
            }*/

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

	//前置关键任务的项目下所有关键任务
	function allTarget(year, month, projectId,pbagId) {
		var allTarget = ''
		$.ajax({
			url: '/projectTarget/selectPre',
			dataType: 'json',
			type: 'get',
			async: false,
			data: {
				year: year,
				month: month,
				projectId: projectId,
				pbagId: pbagId,
			},
			success: function (res) {
				var data = res.obj
				var targetName = '<option value=""></option>'
				data.forEach(function (item) {
					targetName += '<option value="' + item.tgId + '">' + item.tgName + '</option>'
				})
				allTarget = targetName
			}
		})
		return allTarget
	}

	//判断是否显示空
	function isShowNull(data) {
		if (data) {
			return data
		} else {
			return ''
		}
	}

	/*判断项目和工区下是否有关键任务*/
	function isSubmit(projectId){
		var isOk = ''
		$.ajax({
			url: '/projectTarget/checkSubmit',
			data: {projectId:projectId},
			dataType: 'json',
			type: 'get',
			async: false,
			success: function (res) {
				if (res == 0) {
					isOk = true
				}
			}
		})
		return isOk
	}
	/*判断项目是否可初始化*/
	function isInitialization(projectId){
		var isOk = ''
		$.ajax({
			url: '/ProjectInfo/checkSubmit',
			data: {projectId:projectId},
			dataType: 'json',
			type: 'get',
			async: false,
			success: function (res) {
				if (res.code == 0) {
					isOk = true
				}
			}
		})
		return isOk
	}
</script>
</body>
</html>
