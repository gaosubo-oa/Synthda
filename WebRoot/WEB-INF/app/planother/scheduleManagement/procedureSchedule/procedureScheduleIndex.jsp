<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/18
  Time: 16:38
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
	<title>工序字典</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/table.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<script type="text/javascript" src="/js/common/fileupload.js"></script>
	<script type="text/javascript" src="/js/planbudget/common.js?20210413.1"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>

	<style>
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
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
			padding: 15px 0 10px;
			box-sizing: border-box;
		}

		.wrapper {
			position: relative;
			width: 100%;
			height: 100%;
			padding: 0 8px;
			box-sizing: border-box;
		}

		.wrap_left {
			position: relative;
			float: left;
			width: 230px;
			height: 100%;
			padding-right: 10px;
			box-sizing: border-box;
		}

		.wrap_left h2 {
			line-height: 35px;
			text-align: center;
		}

		.wrap_left .left_form {
			position: relative;
			overflow: hidden;
		}

		.left_form .layui-input {
			height: 35px;
			margin: 10px 0;
			padding-right: 25px;
		}

		.tree_module {
			position: absolute;
			top: 90px;
			right: 10px;
			bottom: 0;
			left: 0;
			overflow: auto;
			box-sizing: border-box;
		}

		.eleTree-node-content {
			overflow: hidden;
			word-break: break-all;
			white-space: nowrap;
			text-overflow: ellipsis;
		}

		.search_icon {
			position: absolute;
			top: 10px;
			right: 0;
			height: 35px;
			width: 25px;
			padding-top: 8px;
			text-align: center;
			cursor: pointer;
			box-sizing: border-box;
		}

		.search_icon:hover {
			color: #0aa3e3;
		}

		.wrap_right {
			position: relative;
			height: 100%;
			margin: 0 20px;
			overflow: auto;
		}

		.query_module .layui-input {
			height: 35px;
		}

		/* region 图标样式 */
		.icon_img {
			font-size: 25px;
			cursor: pointer;
		}

		.icon_img:hover {
			color: #0aa3e3;
		}
		/* endregion */

		.form_label {
			float: none;
			padding: 9px 0;
			text-align: left;
			width: auto;
		}

		.form_block {
			margin: 0;
		}

		.field_required {
			color: red;
			font-size: 16px;
		}

		.layer_wrap .layui_col {
			width: 20% !important;
			padding: 0 5px;
		}


		.refresh_no_btn, .refresh_sort_btn {
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2">
					<input type="text" name="wbsNo" placeholder="子项目编码" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="wbsName" placeholder="子项目名称/简称" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="approvalStatus">
						<option value="">请选择</option>
						<option value="0">未提交</option>
						<option value="1">审批中</option>
						<option value="2">批准</option>
						<option value="3">不批准</option>
					</select>
				</div>
				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
				</div>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box">
					<table id="tableIns" lay-filter="tableIns"></table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="toolbarHead">
	<div class="layui-btn-container" style="float: left; height: 30px;">
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
		<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
<%--		<button class="layui-btn layui-btn-sm one_click" lay-event="insert">插入节点</button>--%>
		<%--		<button class="layui-btn layui-btn-sm" lay-event="dayin">打印</button>--%>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn  layui-btn-xs display" lay-event="detail">查看详情</a>
</script>

<script>
	var tableIns = null;

	var tipIndex = null
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});


	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var _type = getUrlParam('type');


	//选选人控件添加
	//监督人
	$(document).on('click', '#scheduleUserName', function () {
		user_id = "scheduleUserName";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})
	//责任人
	$(document).on('click', '#supervisorUserName', function () {
		user_id = "supervisorUserName";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})

	// 获取数据字典数据
	var dictionaryObj = {
		PROGRESS_TYPE: {},
		SCHEDULE_INPORTANCE:{}
	}
	var dictionaryStr = 'PROGRESS_TYPE,SCHEDULE_INPORTANCE';
	$.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
		if (res.flag) {
			for (var dict in dictionaryObj) {
				dictionaryObj[dict] = {object: {}, str: ''}
				if (res.object[dict]) {
					res.object[dict].forEach(function (item) {
						dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
						dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
					});
				}
			}
		}
	});

	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','treeTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var treeTable = layui.treeTable;

		tableInit()

		form.render();


		
		// 监听列表头部按钮事件
		treeTable.on('toolbar(tableIns)', function (obj) {
			var checkStatus = tableIns.checkStatus();
			switch (obj.event) {
				case 'add':
					newOrEdit(0);

					break;
				case 'edit':
					if (checkStatus.length != 1) {
						layer.msg('请选择一项！', {icon: 0});
						return false
					}
					var operationDictionaryId = $('.table_box tbody .layui-form-checked').parents('tr').find('.documentNo').attr('operationDictionaryId')
					var loadIndex = layer.load();
					$.get('/operationDictionary/getById', {kayId:operationDictionaryId}, function (res) {
						layer.close(loadIndex);
						newOrEdit(1,res.obj)
					});

					break;
				case 'del':
					if (!checkStatus.length) {
						layer.msg('请至少选择一项！', {icon: 0});
						return false
					}
					var operationDictionaryId = ''
					var $trs = $('.table_box  tbody .layui-form-checked').parents('tr').find('.documentNo')
					$trs.each(function(){
						operationDictionaryId += $(this).attr('operationDictionaryId') + ','
					})
					// checkStatus.forEach(function (v, i) {
					// 	operationDictionaryId += v.operationDictionaryId + ','
					// })
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/operationDictionary/del', {ids: operationDictionaryId}, function (res) {
							if (res.code=='0') {
								layer.msg('删除成功！', {icon: 1});
							} else {
								layer.msg('删除失败！', {icon: 0});
							}
							layer.close(index)

							tableIns.reload()
						})
					});
					break;
			}
		});
		treeTable.on('tool(tableIns)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'detail') {
				var operationDictionaryId = $(obj.tr[0]).find('.documentNo').attr('operationDictionaryId')
				var loadIndex = layer.load();
				$.get('/operationDictionary/getById', {kayId:operationDictionaryId}, function (res) {
					layer.close(loadIndex);
					newOrEdit(4,res.obj)
				});
				// newOrEdit(4,data)
			}
		});

		function tableInit() {
			var searchObj = getSearchObj();
			searchObj.delFlag = "0";

			var cols = [
				{type: 'checkbox'},
				{field: 'documentNo', title: '编号', minWidth: 150,templet: function (d) {
						return '<span class="documentNo" operationDictionaryId="'+d.operationDictionaryId+'">'+(d.documentNo||'')+'</span>'
					}},
				{field: 'scheduleName', title: '任务名称', minWidth: 100},
				{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 130},
				{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 130},
				{field: 'scheduleDuration', title: '持续时间',minWidth: 110},
				// {field:'beforeSchedule',title:'紧前任务',minWidth: 110,templet: function (d) {
				// 		return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
				// 	}},
				// {field: 'nodeScheduleName', title: '节点计划',minWidth: 110},
				{field: 'scheduleUserName', title: '责任人',minWidth: 120},
				{field: 'supervisorUserName', title: '监督人',minWidth: 120},
				{field: 'importanceLevel', title: '重要性',minWidth: 120,templet: function (d) {
						if(d.importanceLevel) {
							return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
						}else {
							return ''
						}
					}},

			]

			if( _type!='model'){
				cols.push({
					fixed: 'right',
					align: 'center',
					toolbar: '#toolBar',
					title: '操作',
					minWidth: 200
				})
			}


			tableIns = treeTable.render({
				elem: '#tableIns',
				url: '/operationDictionary/select',
				where: searchObj,
				height: 'full-100',
				toolbar: _type=='model'? false:'#toolbarHead',
				defaultToolbar: ['filter'],
				// page: {
				// 	limits: [10, 20, 30, 40, 50]
				// },
				cols: [cols],
				tree: {
					iconIndex: 1,
					idName: 'scheduleId',
					childName: "child"
				},
				// parseData: function (res) { //res 即为原始返回的数据
				// 	return {
				// 		"code": 0, //解析接口状态
				// 		"data": res.data //解析数据列表
				// 	};
				// },
				// done:function(obj, curr, count){
				// 	if( _type=='model'){
				// 		$('.display').hide()
				// 	}
				// }
			});
		}

		// 新建/编辑
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			//var content = ''
			// var projectId = $('#leftId').attr('projId');
			if (type == '0') {
				title = '新增';
				url = '/operationDictionary/insert';
			} else if (type == '1') {
				title = '编辑';
				url = '/operationDictionary/updateById';
			}else if(type == '4'){
				title = '查看详情'
			}
			layer.open({
				type: 1,
				title: title,
				area: ['80%', '90%'],
				btn: type != '4'?['保存', '取消']:['确定'],
				btnAlign: 'c',
				content: ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
				'<div class="layui-collapse">\n' +
				/* region 任务信息 */
				'  <div class="layui-colla-item">\n' +
				'    <h2 class="layui-colla-title">任务信息</h2>\n' +
				'    <div class="layui-colla-content layui-show plan_base_info">' +
				/* region 第一行 */
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">编号</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="documentNo" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				/*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">排序号</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="companySort"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +*/
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">任务名称</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="scheduleName"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				// '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				// '                   <div class="layui-form-item">\n' +
				// '                       <label class="layui-form-label form_label">项目名称</label>\n' +
				// '                       <div class="layui-input-block form_block">\n' +
				// '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				// '                       </div>\n' +
				// '                   </div>' +
				// '               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">重要性<!--<span field="importanceLevel" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <select class="importanceLevel" name="importanceLevel" ></select>\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="scheduleUserName" id="scheduleUserName" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' ,
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">持续时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="number" name="scheduleDuration" id="scheduleDuration"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">开始时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="scheduleBeginDate" id="scheduleBeginDate" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">结束时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="scheduleEndDate" id="scheduleEndDate"  autocomplete="off" class="layui-input" >\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="supervisorUserName" id="supervisorUserName" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>',
					/* endregion */
					'    </div>\n' +
					'  </div>\n' +
					/* endregion  常规任务 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">上级任务</h2>\n' +
					'    <div class="layui-colla-content layui-show three_info">' +
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">上级任务<!--<span field="parentScheduleId" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="parentScheduleId" autocomplete="off" class="layui-input one_click">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">上级任务开始时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text"  id="schedule_BeginDate" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">上级任务结束时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text"  id="schedule_EndDate" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +

					'      		 </div>',
					'		</div>\n' +
					'  </div>' +
					/* endregion */
					'</div>' +
					'</form>'].join(''),
				success: function () {

					//回显项目名称
					// getProjName('#projectName',projectId?projectId:data.projectId)

					//类型
					var $select1 = $(".scheduleType");
					var optionStr = '<option value="">请选择</option>';
					optionStr += dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['str']
					$select1.html(optionStr);

					//重要性
					var $select2 = $(".importanceLevel");
					var optionStr2 = '<option value="">请选择</option>';
					optionStr2 += dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['str']
					$select2.html(optionStr2);

					laydate.render({
						elem: '#scheduleBeginDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						, done: function(value, date){ //监听日期被切换
							//紧前任务的结束时间
							var schedule_EndDate = $('#schedule_EndDate2').val()
							var beforeScheduleDate = ''
							//持续时间
							var scheduleDuration = $('#scheduleDuration').val()
							var scheduleEndDate = $('#scheduleEndDate').val()||''
							//console.log(dateParse(value))
							//反算紧前时间
							if(value&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,value)-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}
							//反算结束时间
							if(value&&scheduleDuration){
								scheduleEndDate = getNewDay(value,scheduleDuration,-1)
								$('#scheduleEndDate').val(scheduleEndDate)
							}

							//反算持续时间
							if(value&&scheduleEndDate){
								scheduleDuration = getDays(scheduleEndDate,value)+1
								$('#scheduleDuration').val(scheduleDuration)
							}
						}
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
					laydate.render({
						elem: '#scheduleEndDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
						, done: function(value, date) { //监听日期被切换
							//持续时间
							var scheduleDuration = $('#scheduleDuration').val()
							//开始时间
							var scheduleBeginDate = $('#scheduleBeginDate').val()||''
							//反算开始时间
							if(value&&scheduleDuration){
								scheduleBeginDate = getNewDay(value,-scheduleDuration,1)
								$('#scheduleBeginDate').val(scheduleBeginDate)
							}
							//反算持续时间
							if(value&&scheduleBeginDate){
								scheduleDuration = getDays(scheduleBeginDate,value)+1
								$('#scheduleDuration').val(scheduleDuration)
							}

							//紧前任务的结束时间
							var schedule_EndDate = $('#schedule_EndDate2').val()
							var beforeScheduleDate = ''
							//反算紧前时间
							if(value&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,$('#scheduleBeginDate').val())-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}
						}
					});

					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);
						//责任人id
						$('[name="scheduleUserName"]').attr('user_id',data.scheduleUser)
						//监督人id
						$('[name="supervisorUserName"]').attr('user_id',data.supervisorUser)

						//上级任务
						$('[name="parentScheduleId"]').val(data&&data.parentSchedule ? data.parentSchedule.scheduleName : '');
						$('[name="parentScheduleId"]').attr('parentScheduleId',data? data.parentScheduleId : '');
						//上级任务开始时间
						$('#schedule_BeginDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleBeginDate : '');
						//上级任务结束时间
						$('#schedule_EndDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleEndDate : '');
						//查看详情
						if(type==4){
							$('._disabled').find('input,select').attr('disabled', 'disabled');
							$('.refresh_no_btn').hide();
							// $('.file_upload_box').hide()
							// $('.deImgs').hide();
						}
					}else {
						// 获取自动编号
						getAutoNumber({autoNumberType: 'operationDictionary'}, function(res) {
							$('#baseForm input[name="documentNo"]').val(res.obj);
							$('#baseForm input[name="companySort"]').val(res.object.sort);
							$('#baseForm input[name="scheduleUserName"]').val(res.object.createUserName).attr('user_id',res.object.createUser);
						});
					}
					if(data&&data.beforeSchedule&&data.beforeSchedule.scheduleName){
						$('#beforeScheduleDate').attr('disabled',false).css("background","")
					}else {
						$('#beforeScheduleDate').attr('disabled',true).css("background","#e7e7e7").val('')
					}
					element.render();
					form.render()
				},
				yes: function (index,layero) {
					if(type!='4'){
						var datas = $('#baseForm').serializeArray();
						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value
						});

						//责任人id
						var scheduleUser = $('#baseForm input[name="scheduleUserName"]').attr('user_id')
						if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
							scheduleUser = scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
						}
						obj.scheduleUser = scheduleUser || '';

						//监督人id
						var supervisorUser = $('#baseForm input[name="supervisorUserName"]').attr('user_id')
						if(supervisorUser&&supervisorUser.indexOf(',')!=-1){
							supervisorUser = supervisorUser.substring(0,supervisorUser.lastIndexOf(','))
						}
						obj.supervisorUser = supervisorUser || '';

						//上级任务
						obj.parentScheduleId = $('[name="parentScheduleId"]').attr('parentScheduleId')||'0'

						// obj.projectId = projectId?projectId:data.projectId;


						if(type == '1'){
							obj.operationDictionaryId= data.operationDictionaryId;
						}


						// 判断必填项
						var requiredFlag = false;
						$('#baseForm').find('.field_required').each(function(){
							var field = $(this).attr('field');
							if (!obj[field]) {
								var fieldName = $(this).parent().text().replace('*', '');
								layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
								requiredFlag = true;
								return false;
							}
						});
						if (requiredFlag) {
							return false;
						}
						var loadIndex = layer.load();

						$.ajax({
							url: url,
							data: obj,
							dataType: 'json',
							type: 'post',
							success: function (res) {
								layer.close(loadIndex);
								if (res.code=='0') {
									var _data = res.object
									layer.msg('保存成功！', {icon: 1});
									layer.close(index);

									tableIns.reload();

								} else {
									layer.msg(res.msg, {icon: 7});
								}
							}
						});
					}else {
						layer.close(index);
					}

				}
			});
		}

		//监听紧前时间
		$(document).on('input propertychange', '#beforeScheduleDate', function () {
			var scheduleEndDate = $('#schedule_EndDate2').val()
			if(!scheduleEndDate){
				return false
			}
			var beforeScheduleDate = $(this).val()
			$('#scheduleBeginDate').val(getNewDay(scheduleEndDate,beforeScheduleDate,1))

			var scheduleDuration = $('#scheduleDuration').val()
			var scheduleBeginDate = $('#scheduleBeginDate').val()
			var scheduleEndDate = ''
			if(scheduleDuration&&scheduleBeginDate){
				scheduleEndDate = getNewDay(scheduleBeginDate,scheduleDuration,-1)
				$('#scheduleEndDate').val(scheduleEndDate)
			}
		})


		//监听持续时间
		$(document).on('input propertychange', '#scheduleDuration', function () {
			var scheduleDuration = $('#scheduleDuration').val()
			var scheduleBeginDate = $('#scheduleBeginDate').val()
			var scheduleEndDate = ''
			if(scheduleDuration&&scheduleBeginDate){
				scheduleEndDate = getNewDay(scheduleBeginDate,scheduleDuration,-1)
				$('#scheduleEndDate').val(scheduleEndDate)
			}
		})
		//监听紧前任务
		$(document).on('input blur', '[name="beforeScheduleId"]', function () {
			if($(this).val()){
				$('#beforeScheduleDate').attr('disabled',false).css("background","")
			}else {
				$('#beforeScheduleDate').attr('disabled',true).css("background","#e7e7e7").val('')
			}
		})


		//日期加上天数得到新的日期
		//dateTemp 需要参加计算的日期，days要添加的天数，返回新的日期，日期格式：YYYY-MM-DD
		//differ 相差几天
		function getNewDay(dateTemp, days,differ) {
			days = Number(days) + Number(differ)
			var dateTemp = dateTemp.split("-");
			var nDate = new Date(dateTemp[1] + '-' + dateTemp[2] + '-' + dateTemp[0]); //转换为MM-DD-YYYY格式
			var millSeconds = Math.abs(nDate) + (days * 24 * 60 * 60 * 1000);
			var rDate = new Date(millSeconds);
			var year = rDate.getFullYear();
			var month = rDate.getMonth() + 1;
			if (month < 10) month = "0" + month;
			var date = rDate.getDate();
			if (date < 10) date = "0" + date;
			return (year + "-" + month + "-" + date);
		}

		/**
		 * 日期解析，字符串转日期
		 * @param dateString 可以为2017-02-16，2017/02/16，2017.02.16
		 * @returns {Date} 返回对应的日期
		 */
		function dateParse(dateString){
			var SEPARATOR_BAR = "-";
			var SEPARATOR_SLASH = "/";
			var SEPARATOR_DOT = ".";
			var dateArray;
			if(dateString.indexOf(SEPARATOR_BAR) > -1){
				dateArray = dateString.split(SEPARATOR_BAR);
			}else if(dateString.indexOf(SEPARATOR_SLASH) > -1){
				dateArray = dateString.split(SEPARATOR_SLASH);
			}else{
				dateArray = dateString.split(SEPARATOR_DOT);
			}
			return new Date(dateArray[0], dateArray[1]-1, dateArray[2]).getTime();
		};
		//根据2个日期计算相差天数
		function getDays(strDateStart,strDateEnd){
			var strSeparator = "-"; //日期分隔符
			var oDate1;
			var oDate2;
			var iDays;
			oDate1= strDateStart.split(strSeparator);
			oDate2= strDateEnd.split(strSeparator);
			var strDateS = new Date(oDate1[0], oDate1[1]-1, oDate1[2]);
			var strDateE = new Date(oDate2[0], oDate2[1]-1, oDate2[2]);
			iDays = parseInt(Math.abs(strDateS - strDateE ) / 1000 / 60 / 60 /24)//把相差的毫秒数转换为天数
			return iDays ;
		}

		/**
		 * 获取查询条件
		 * @returns {}
		 */
		function getSearchObj() {
			var searchObj = {
				// wbsNo: $('input[name="wbsNo"]', $('.query_module')).val(),
				// wbsName: $('input[name="wbsName"]', $('.query_module')).val(),
				// approvalStatus: $('select[name="approvalStatus"]', $('.query_module')).val(),
			}
			return searchObj
		}

		// 查询
		$('#searchBtn').on('click', function () {
			var searchParams = {}
			var $seachData = $('.query_module [name]')
			$seachData.each(function () {
				searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
				// 将查询值保存至cookie中
				$.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
			})
			tableIns.reload({
				where: searchParams,
				page: {
					curr: 1 //重新从第 1 页开始
				}
			});
		});

		$(document).on('click', '.one_click', function () {
			var _this = this
			var _name = $(_this).attr('name')
			choiceNode(_name)

		});
		function choiceNode(type){
			var Settlement2 = null

			layer.open({
				type: 1,
				title: '选择',
				area: ['80%', '70%'],
				maxmin: true,
				btnAlign:'c',
				btn: ['确定', '取消'],
				content: ['<div class="layui-form" >' +
				//表格数据
				'       <div style="padding: 10px">' +
				'           <table id="Settlement2" lay-filter="SettlementFilter2"></table>' +
				'      </div>' +
				'</div>'].join(''),
				success: function () {
					Settlement2 = treeTable.render({
						elem: '#Settlement2',
						url: '/operationDictionary/select',//数据接口
						// page:true,
						// height: 'full-100',
						where:{delFlag: '0'},
						cols: [[//表头
							{type: 'radio'},
							{field: 'documentNo', title: '编号', minWidth:250},
							// {field:'companySort',title:'排序号',minWidth: 100},
							{field: 'scheduleName', title: '任务名称', minWidth: 200},
							{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 130,templet: function (d) {
									if(d.dataForm=='1'){
										return '<span></span>'
									}else {
										return '<span>'+(d.scheduleBeginDate||'')+'</span>'
									}
								}},
							{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 130},
							{field: 'scheduleDuration', title: '持续时间',minWidth: 110},
							// {field:'beforeSchedule',title:'紧前任务',minWidth: 110,templet: function (d) {
							// 		return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
							// 	}},
							{field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
									if(d.scheduleType) {
										return '<span>'+((dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['object'][d.scheduleType])||'')+'</span>'
									}else {
										return ''
									}
								}},
							{field: 'scheduleUserName', title: '责任人',minWidth: 100},
							{field: 'supervisorUserName', title: '监督人',minWidth: 100},
							{field: 'importanceLevel', title: '重要性',minWidth: 100,templet: function (d) {
									if(d.importanceLevel) {
										return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
									}else {
										return ''
									}
								}}
						]],
						tree: {
							iconIndex: 1,
							idName: 'scheduleId',
							childName: "child"
						},
						request: {
							pageName: 'page' //页码的参数名称，默认：page
							,limitName: 'pageSize' //每页数据量的参数名，默认：limit
						},
						done:function(res){
							var _dataa=res;
							var _parentScheduleId=$('[name="parentScheduleId"]').attr('parentScheduleId')
							if(_parentScheduleId!=undefined){
								for(var i = 0 ; i <_dataa.length;i++){
									if(_dataa[i].operationDictionaryId == _parentScheduleId){
										$('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
										//form.render('checkbox');
									}
								}
							}

						}
					});
				},
				yes: function (index) {
					var datas = Settlement2.checkStatus()[0];
					//上级任务
					$('[name="parentScheduleId"]').val(datas? datas.scheduleName : '');
					$('[name="parentScheduleId"]').attr('parentScheduleId',datas? datas.operationDictionaryId : '');
					$('#schedule_BeginDate').val(datas? datas.scheduleBeginDate : '');
					$('#schedule_EndDate').val(datas? datas.scheduleEndDate : '');

					layer.close(index);
				}
			});
		}
	});

	function getAutoNumber(params, callback) {
		$.get('/planningManage/autoNumber', params, function (res) {
			callback(res);
		});
	}
	function getRepairDate(){
		var datas = tableIns.checkStatus();
		if(datas.length<1){
			layui.layer.msg("请选择一条")
			return null;
		}else{
			return datas
		}
		return null;
	}
</script>
</body>
</html>
