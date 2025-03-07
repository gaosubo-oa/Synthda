<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>实施策划交底列表查询界面</title>
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/common.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<script src="/lib/layui/layui/layui.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
	<script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../../js/common/fileupload.js"></script>
	<style>
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
			color: #000000;
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

		.left_form  {
			height: 38px;
			margin: 10px 0;
			padding-right: 25px;
			width: 100%;
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
			top: 3px;
			right: 32px;
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
			margin-left: 230px;
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

		/* region 上传附件样式 */
		.file_upload_box {
			position: relative;
			height: 22px;
			overflow: hidden;
		}
		.open_file {
			float: left;
			position:relative;
		}
		.open_file input[type=file] {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			z-index: 2;
			opacity: 0;
		}

		.progress {
			float: left;
			width: 200px;
			margin-left: 10px;
			margin-top: 2px;
		}

		.bar {
			width: 0%;
			height: 18px;
			background: green;
		}

		.bar_text {
			float: left;
			margin-left: 10px;
		}
		/* endregion */

		.refresh_no_btn, .refresh_sort_btn {
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}
		.search_module {
			position: relative;
			height: 40px;
		}
		.layui-col-xs5{
			width: 31%;
		}
		.inputWidth{
			width: 150px !important;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">实施策划交底</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input"/>
			</div>
			<div class="tree_module">
				<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
			</div>
		</div>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative;top: 6px">
				<%--表格上方搜索栏--%>
					<form class="layui-form" action="" >
						<div class="demoTable"  >
							<div class="layui-row">
								<div class="layui-col-xs2">
									<div class="layui-form-item">
										<div class="layui-inline">
											<div class="layui-input-inline inputWidth">
												<input class="layui-input " name="embodimentNo" id="embodimentNo" autocomplete="off" placeholder="请输入单据号">
											</div>
										</div>
									</div>
								</div>
								<div class="layui-col-xs2" style="margin-left: 10px;">
									<div class="layui-form-item">
										<div class="layui-inline">
											<div class="layui-input-inline inputWidth">
												<input class="layui-input" name="projectName" id="projectName" autocomplete="off" placeholder="请输入项目名称">
											</div>
										</div>
									</div>
								</div>
								<div class="layui-col-xs2" style="margin-left: 10px">
									<div class="layui-form-item">
										<div class="layui-inline">
											<div class="layui-input-inline inputWidth" style="margin: 0">
												<input class="layui-input" name="planingName" id="planingName" autocomplete="off" placeholder="请输入实施策划名称">
											</div>
										</div>
									</div>
								</div>
								<div class="layui-col-xs2" style="margin-left: 10px">
									<div class="layui-form-item">
										<div class="layui-inline">
											<div class="layui-input-inline inputWidth" style="margin: 0">
												<select id="embodimentType" name="embodimentType" class="layui-input"></select>
											</div>
										</div>
									</div>
								</div>
								<div class="layui-col-xs2" style="margin-left: 10px;width: 27%">
									<div class="layui-form-item">
										<div class="layui-inline">
											<div class="layui-input-inline" style="margin: 0;width: 163px">
												<input class="layui-input" name="embodimentName" id="embodimentName" autocomplete="off" placeholder="请输入实施策划交底名称">
											</div>
										</div>
										<a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="margin-bottom:6px;height:32px;line-height: 32px;">搜索</a>
									</div>
								</div>
							</div>
						</div>
					</form>
			</div>
			<div style="position: relative;top: -5px">
				<div class="table_box">
					<table id="Settlement" lay-filter="SettlementFilter"></table>
				</div>
				<div class="no_data" style="text-align: center;">
					<div class="no_data_img" style="margin-top:12%;">
						<img style="margin-top: 2%;" src="/img/noData.png">
					</div>
					<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧项目</p>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/html" id="toolbar">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="addTest" >新增</button>
		<button class="layui-btn layui-btn-sm" lay-event="editTest">编辑</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delTest">删除</button>
		<div style="position:absolute;top: 10px;right: 12%;">
			<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
			<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入</button>
			<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出</button>
		</div>
	</div>
</script>
<script type="text/html" id="toolDemo">
	<button class="layui-btn layui-btn-sm" lay-event="details">查看详情</button>
</script>


<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
	var urlType = getUrlParam("urlType");
	console.log(urlType)
	var toolbar;
	var colsType;
	if(urlType=='addImplementationPlanning'){
		toolbar = ''
		colsType = 'radio'
	}else {
		toolbar = '#toolbar'
		colsType = 'checkbox'
	}

	var securityInfoDate;

	var detailsInit;
	var detailsInitData=[];

	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var columnId = parent.columnTrId;//getUrlParam('columnId');
	var SettlementTable;

	layui.use(['table','layer','form','element','eleTree','upload','layedit','laydate'], function() {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var upload = layui.upload;
		var layedit = layui.layedit;
		var laydate = layui.laydate;

		projectLeft();

		/**
		 * 左侧项目信息列表
		 * @param projectName 项目名称
		 */
		function projectLeft(projectName) {
			projectName = projectName ? projectName : '';
			var loadingIndex = layer.load();
			$.get('/plbOrg/treeListOrg', {projectName: projectName}, function (res) {
				layer.close(loadingIndex);
				if (res.flag) {
					eleTree.render({
						elem: '#leftTree',
						data: res.data,
						highlightCurrent: true,
						showLine: true,
						defaultExpandAll: false,
						request: {
							name: 'name',
							children: "plbProjList",
						}
					});

				}
			});
		}

		// 树节点点击事件
		eleTree.on("nodeClick(leftTree)", function (d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#leftId').attr('projId', currentData.projId);
				$('#leftId').attr('decomposeLevel', currentData.decomposeLevel);
				tableInit(currentData.projId);
				projectIdd = currentData.projId;
				projectNamee = currentData.projName;
				$('.no_data').hide();
				$('.table_box').show();
			}else{
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		//渲染交底程度
		var $select1 = $("#embodimentType");
		var optionStr = '<option value="">请选择</option>';
		$.ajax({ //查询文档等级
			url: '/plbDictonary/selectDictionaryByNo?plbDictNo=EMBODIMENT_DEGREE',
			type: 'get',
			dataType: 'json',
			async:false,
			success: function (res) {
				var data=res.data
				if(data!=undefined&&data.length>0){
					for(var i=0;i<data.length;i++){
						optionStr += '<option value="' + data[i].plbDictNo + '">' + data[i].dictName + '</option>'
					}
				}
			}
		})
		$select1.html(optionStr);

		form.render();

		//头工具栏事件
		// 更多查询
		$('.more_query').click(function(){
			var isShow = $(this).attr('isshow');
			if (isShow == 0) {
				$(this).children().removeClass('layui-icon-down').addClass('layui-icon-up');
				$('.hide_query').show();
				$(this).attr('isshow', 1);
				$('.search_module').css('height','96px')
			} else {
				$(this).children().removeClass('layui-icon-up').addClass('layui-icon-down');
				$('.hide_query').hide();
				$(this).attr('isshow', 0);
				$('.search_module').css('height','40px')
			}
		});

		$('#searchCust').click(function () {
			var serchObjUrl = "/planningManage/selectEmbodiment?";
			//var searchtext = $("#securityRegionName").attr("pid3");
			var searchtext1 = $("#embodimentNo").val();
			var searchtext2 = $("#pele").val();
			var searchtext3 = $("#planingName").val();
			var searchtext4 = $("#embodimentName").val();
			var searchtext5 = $("#embodimentType").val();
			if(searchtext1!=""&&searchtext1!=undefined){
				serchObjUrl+="&embodimentNo="+searchtext1;
			}
			if(searchtext2!=""&&searchtext2!=undefined){
				serchObjUrl+="&projectName="+searchtext2;
			}
			if(searchtext3!=""&&searchtext3!=undefined){
				serchObjUrl+="&planingName="+searchtext3;
			}
			if(searchtext4!=""&&searchtext4!=undefined){
				serchObjUrl+="&embodimentName="+searchtext4;
			}
			if(searchtext5!=""&&searchtext5!=undefined){
				serchObjUrl+="&embodimentType="+searchtext5;
			}

			table.reload("Settlement",{
				url: serchObjUrl
			});
		})
		// 渲染数据表格
		function tableInit(projectId) {
			// 树右侧表格实例
			SettlementTable = layui.table.render({
				elem: '#Settlement'
				// , data: []
				, url: '/planningManage/selectEmbodiment?projectId='+projectId//数据接口
				, page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
					layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
					, limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
					, first: false //不显示首页
					, last: false //不显示尾页
				} //开启分页
				, toolbar: toolbar
				, cols: [[ //表头
					{type: colsType}
					, {field: 'embodimentNo', title: '单据号'}
					, {field: 'projectName', title: '项目名称'}
					// , {field: 'projectTypeName', title: '项目类别'}
					, {field: 'planingName', title: '实施策划名称'}
					, {field: 'embodimentName', title: '实施策划交底名称'}
					, {field: 'embodimentTypeName', title: '交底程度'}
					, {field: 'userName', title: '填报人'}
					, {field: 'createTime', title: '填报时间'}
					, {field:'auditerStatus',title:"审批状态",templet: function (d) {
							var str = '';
							if (d.auditerStatus == '1') {
								var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
								str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
							} else if (d.auditerStatus == '2') {
								var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
								str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
							} else if (d.auditerStatus == '3') {
								str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
							} else {
								str = '未提交';
							}
							return str;
						}}
					,{title:'操作',align:'center',toolbar:'#toolDemo',minWidth:130}
				]]
				, limit: 10
				, done: function (res) {
				}
			});
		}
		//表格头工具事件
		table.on('toolbar(SettlementFilter)', function(obj){
			var checkStatus = table.checkStatus("Settlement").data;
			securityInfoDate = checkStatus[0];
			var event = obj.event;
			if(event === 'addTest'){ //新增
				layer.open({
					type: 2,
					area: ['100%', '100%'], //宽高
					title: '新增实施策划交底',
					maxmin: true,
					btn: ['保存','提交','取消'],
					btnAlign:'c',
					content: '/planningManage/addImplementationEmbodiment?urlType=addTest&projectId='+projectIdd,
					yes: function (index, layero) {
						var childData  = $(layero).find("iframe")[0].contentWindow.getDate();
						$.ajax({
							url:'/planningManage/insertEmbodiment',
							dataType:'json',
							type:'post',
							data:childData,
							success:function(res){
								if(res.code===0||res.code==="0"){
									layer.msg(res.msg,{icon:1});
									SettlementTable.reload()
									layer.close(index)
								}else{
									layer.msg(res.msg,{icon:0});
								}
							}
						})
					}, btn2: function (index, layero) {
						var childData  = $(layero).find("iframe")[0].contentWindow.getDate();
						$.ajax({
							url:'/planningManage/insertEmbodiment',
							dataType:'json',
							type:'post',
							data:childData,
							success:function(res){
								if(res.code===0||res.code==="0"){
									layer.close(index)
									layer.open({
										type: 1,
										title: '选择流程',
										area: ['70%', '80%'],
										btn: ['确定', '取消'],
										btnAlign: 'c',
										content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
										success: function () {
											$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '40'}, function (res) {
												var flowData = []
												$.each(res.data.flowData, function (k, v) {
													flowData.push({
														flowId: k,
														flowName: v
													});
												});
												table.render({
													elem: '#flowTable',
													data: flowData,
													cols: [[
														{type: 'radio'},
														{field: 'flowName', title: '流程名称'}
													]]
												})
											});
										},
										yes: function (index) {
											var loadIndex = layer.load();
											var checkStatusFlow = table.checkStatus('flowTable');
											if (checkStatusFlow.data.length > 0) {
												var flowData = checkStatusFlow.data[0];
												var approvalData = res.obj
												newWorkFlow(flowData.flowId, function (res) {
													var submitData = {
														embodimentId:approvalData.embodimentId,
														runId: res.flowRun.runId,
														auditerStatus:1
													}
													$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

													$.ajax({
														url: '/planningManage/updateEmbodiment',
														data: submitData,
														dataType: 'json',
														type: 'post',
														success: function (res) {
															layer.close(loadIndex);
															if (res.code===0||res.code==="0") {
																layer.close(index);
																layer.msg('提交成功!', {icon: 1});
																SettlementTable.config.where._ = new Date().getTime();
																SettlementTable.reload()
															} else {
																layer.msg(res.msg, {icon: 2});
															}
														}
													});
												},approvalData);
											} else {
												layer.close(loadIndex);
												layer.msg('请选择一项！', {icon: 0});
											}
										}
									});
									SettlementTable.reload()
								}else{
									layer.msg(res.msg,{icon:0});
								}
							}
						})
					}
				});
			}else if (event == 'delTest') {//删除
				if(checkStatus.length<1){
					layer.msg("请至少选择一条");
				}else{
					layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title:'提示'}, function(index){
						var ids="";
						for(var i=0;i<checkStatus.length;i++){
							ids+=checkStatus[i].embodimentId+",";
						}
						$.ajax({
							url:'/planningManage/delEmbodiment?ids='+ids,
							type: 'post',
							dataType: 'json',
							success:function(res){
								layer.msg(res.msg);
								SettlementTable.reload();
							}
						});
						layer.close(index);
					});
				}
			}else if(event === 'editTest'){ //编辑
				if(checkStatus.length!=1){
					layer.msg("请选择一条");
					return
				}
				if(securityInfoDate.auditerStatus!="0"){
					layer.msg('该数据已提交,不可编辑', {icon: 0, time: 2000});
					return
				}
					layer.open({
						type: 2,
						area: ['100%', '100%'], //宽高
						title: '编辑',
						maxmin: true,
						btn: ['保存','提交','取消'],
						btnAlign:'c',
						content: '/planningManage/addImplementationEmbodiment?urlType=editTest&projectId='+projectIdd+'&embodimentId='+securityInfoDate.embodimentId,
						yes: function (index, layero) {
							var childData  = $(layero).find("iframe")[0].contentWindow.getDate();
							$.ajax({
								url:'/planningManage/updateEmbodiment?embodimentId='+securityInfoDate.embodimentId,
								dataType:'json',
								type:'post',
								data:childData,
								success:function(res){
									if(res.code===0||res.code==="0"){
										layer.msg(res.msg,{icon:1});
										SettlementTable.reload()
										layer.close(index)
									}else{
										layer.msg(res.msg,{icon:0});
									}
								}
							})
						}, btn2: function (index, layero) {
							var childData  = $(layero).find("iframe")[0].contentWindow.getDate();
							$.ajax({
								url:'/planningManage/updateEmbodiment?embodimentId='+securityInfoDate.embodimentId,
								dataType:'json',
								type:'post',
								data:childData,
								success:function(res){
									if(res.code===0||res.code==="0"){
										layer.close(index)
										layer.open({
											type: 1,
											title: '选择流程',
											area: ['70%', '80%'],
											btn: ['确定', '取消'],
											btnAlign: 'c',
											content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
											success: function () {
												$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '40'}, function (res) {
													var flowData = []
													$.each(res.data.flowData, function (k, v) {
														flowData.push({
															flowId: k,
															flowName: v
														});
													});
													table.render({
														elem: '#flowTable',
														data: flowData,
														cols: [[
															{type: 'radio'},
															{field: 'flowName', title: '流程名称'}
														]]
													})
												});
											},
											yes: function (index) {
												var loadIndex = layer.load();
												var checkStatusFlow = table.checkStatus('flowTable');
												if (checkStatusFlow.data.length > 0) {
													var flowData = checkStatusFlow.data[0];
													var approvalData = res.obj
													newWorkFlow(flowData.flowId, function (res) {
														var submitData = {
															embodimentId:approvalData.embodimentId,
															runId: res.flowRun.runId,
															auditerStatus:1
														}
														$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

														$.ajax({
															url: '/planningManage/updateEmbodiment',
															data: submitData,
															dataType: 'json',
															type: 'post',
															success: function (res) {
																layer.close(loadIndex);
																if (res.code===0||res.code==="0") {
																	layer.close(index);
																	layer.msg('提交成功!', {icon: 1});
																	SettlementTable.config.where._ = new Date().getTime();
																	SettlementTable.reload()
																} else {
																	layer.msg(res.msg, {icon: 2});
																}
															}
														});
													},approvalData);
												} else {
													layer.close(loadIndex);
													layer.msg('请选择一项！', {icon: 0});
												}
											}
										});
										SettlementTable.reload()

									}else{
										layer.msg(res.msg,{icon:0});
									}
								}
							})
						}
					});

			}else if (event == 'export') {//导出
				window.location = '/planningManage/exportEmbodiment'
			}else if (event == 'submit') {//提交审批
				if (checkStatus.length != 1) {
					layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
					return false;
				}
				if(checkStatus[0].auditerStatus != '0'){
					layer.msg('该数据已提交！', {icon: 0, time: 2000});
					return false;
				}
				layer.open({
					type: 1,
					title: '选择流程',
					area: ['70%', '80%'],
					btn: ['确定', '取消'],
					btnAlign: 'c',
					content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
					success: function () {
						$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '40'}, function (res) {
							var flowData = []
							$.each(res.data.flowData, function (k, v) {
								flowData.push({
									flowId: k,
									flowName: v
								});
							});
							table.render({
								elem: '#flowTable',
								data: flowData,
								cols: [[
									{type: 'radio'},
									{field: 'flowName', title: '流程名称'}
								]]
							})
						});
					},
					yes: function (index) {
						var loadIndex = layer.load();
						var checkStatusFlow = table.checkStatus('flowTable');
						if (checkStatusFlow.data.length > 0) {
							var flowData = checkStatusFlow.data[0];
							var approvalData = checkStatus[0]
							newWorkFlow(flowData.flowId, function (res) {
								var submitData = {
									embodimentId:approvalData.embodimentId,
									runId: res.flowRun.runId,
									auditerStatus:1
								}
								$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

								$.ajax({
									url: '/planningManage/updateEmbodiment',
									data: submitData,
									dataType: 'json',
									type: 'post',
									success: function (res) {
										layer.close(loadIndex);
										if (res.code===0||res.code==="0") {
											layer.close(index);
											layer.msg('提交成功!', {icon: 1});
											SettlementTable.config.where._ = new Date().getTime();
											SettlementTable.reload()
										} else {
											layer.msg(res.msg, {icon: 2});
										}
									}
								});
							},approvalData);
						} else {
							layer.close(loadIndex);
							layer.msg('请选择一项！', {icon: 0});
						}
					}
				});
			}
		});
        table.on('tool(SettlementFilter)',function(obj){
        	var data=obj.data;
			var layEvent=obj.event;
			if(layEvent=="details"){
				layer.open({
					type: 2,
					area: ['100%', '100%'],
					title: '查看实施策划交底',
					maxmin: true,
					btn: ['确定'],
					btnAlign: 'c',
					content: '/planningManage/addImplementationEmbodiment?urlType=editTest&projectId='+projectIdd+'&embodimentId='+data.embodimentId,
					yes:function(index){
						layer.close(index);
					}
				})
			}
		})



		//数据列表点击审批状态查看流程功能
		$(document).on('click', '.preview_flow', function() {
			var flowId = $(this).attr('flowId'),
					runId = $(this).attr('runId');
			if (flowId && runId) {
				$.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
			}
		});

	})

	function getDate1(){
		var checkStatus = layui.table.checkStatus("Settlement").data;
		var obj = {};
		obj.embodimentId  = checkStatus[0].embodimentId;
		obj.embodimentName = checkStatus[0].embodimentName;
		return obj;
	}

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
						layer.msg('删除成功', {icon: 6, time: 1000});
						$(_this).parent().remove();
					} else {
						layer.msg('删除失败', {icon: 2, time: 1000});
					}
				}
			})
		});
	});

	function childFunc(){
		columnId = parent.columnTrId
		SettlementTable.reload({
			url: '/fileManage/getFile?columnIds='+columnId//数据接口
		});
	}
	function lookFile(repalogId){//查看附件
		if (repalogId == undefined || repalogId == "") {
			layer.msg("文件已被损坏，无法查看");
		} else {
			selectFile1(repalogId,'knowlage');
			//window.location.href = "/equipment/limsDownload?model=" + model + "&attachId=" + attachId  下载
		}
	}
	//查看附件
	function selectFile1(attchId,model) {
		if(attchId){
			//查看附件
			var data={
				attachId:attchId,
				model:model
			}
			var res=toAjaxT1("/equipment/selectAttchUrl",data);
			if(res.code==0){
				if(res.object){
					limsPreview1(res.object);
				}
			}
		}

	}
	//附件预览点击调取
	function limsPreview1(attrUrl) {
		var url = '';
		if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1){
			var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
			var atturl2 = '';
			if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
				for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
					atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
				}
				url = atturl1 + atturl2;
			}else{
				url = atturl1;
			}
		}
		if(limsUrlGetRequest('?'+attrUrl) == 'pdf' || limsUrlGetRequest('?'+attrUrl) == 'PDF'){
			layui.layer.open({
				type: 2,
				title: '预览',
				offset:["20px",""],
				content: "/pdfPreview?"+url,
				area: ['80%', '80%']
			})
			// $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
		}else if(limsUrlGetRequest('?'+attrUrl) == 'png' || limsUrlGetRequest('?'+attrUrl) == 'PNG'|| limsUrlGetRequest('?'+attrUrl) == 'jpg' || limsUrlGetRequest('?'+attrUrl) == 'JPG'|| limsUrlGetRequest('?'+attrUrl) == 'txt'|| limsUrlGetRequest('?'+attrUrl) == 'TXT'){
			layui.layer.open({
				type: 2,
				title: '预览',
				content: "/xs?"+url,
				offset:["20px",""],
				area: ['80%', '80%'],
				success:function(layero, index){
					var iframeWindow = window['layui-layer-iframe'+ index];
					var doc = $(iframeWindow.document);
					doc.find('img').css("width","100%");
				}
			})
			// $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
		}else{
			pdurl1(limsUrlGetRequest('?'+attrUrl),attrUrl)
			// $.ajax({
			//     type:'get',
			//     url:'/sysTasks/getOfficePreviewSetting',
			//     dataType:'json',
			//     success:function (res) {
			//         if(res.flag){
			//             var strOfficeApps = res.object.previewUrl;//在线预览服务地址
			//             if(strOfficeApps == ''){
			//                 strOfficeApps = 'https://view.officeapps.live.com';
			//             }
			//             layui.layer.open({
			//                 type: 2,
			//                 title: '预览',
			//                 offset:["20px",""],
			//                 content: strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),
			//                 area: ['80%', '80%']
			//             })
			//             // $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),'','0','0','1200px','600px')
			//         }
			//     }
			// })

		}
	}
	//判断是否显示空
	function isShowNull2(data) {
		if(data){
			return data
		}else{
			return "";
		}
	}
	//同步
	function toAjaxT1(url,data) {
		var result;
		$.ajax({
			url:url,
			data:data,
			type: 'post',
			async:false,
			dataType: 'json',
			success: function (res){
				result=res;
			}
		});
		return result;
	}
	//截取附件文件后缀
	function limsUrlGetRequest(name) {
		var attach=name
		return attach.substring(attach.lastIndexOf(".")+1,attach.length);
	}
	function pdurl1(gs,atturl){ //根据后缀判断选择调取那种打开方式
		if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
			var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
			var atturl2 = '';
			if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
				for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
					atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
				}
				atturl = atturl1 + atturl2;
			}else{
				atturl = atturl1;
			}
		}
		if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
			$.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
		}else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
			layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
			layer.msg('点击任意处关闭');
		}else if(gs == 'pdf'||gs == 'PDF'){
			$.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
		}else{
			var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
			$.ajax({
				url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
				type:'post',
				datatype:'json',
				async:false,
				success: function (res) {
					if(res.flag){
						if(res.object[0].paraValue == 0){
							//默认加载NTKO插件 进行跳转
							url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
						}else if(res.object[0].paraValue == 2){
							//默认加载NTKO插件 进行跳转
							url = "/wps/info?"+ atturl +"&permission=read";
						}
					}

				}
			})
			setTimeout(function(){
				$.popWindow(url,PreviewPage,'0','0','1200px','600px');
			}, 1000);
		}
	}
	function undefind_nullStr(value) {
		if(value==undefined){
			return ""
		}
		return value
	}
	function getAttachIds(obj) {
		return obj.aid+"@"+obj.ym+"_"+obj.attachId;
	}

	/**
	 * 新建流程方法
	 * @param flowId
	 * @param urlParameter
	 * @param cb
	 */
	function newWorkFlow(flowId, cb,approvalData) {
		$.ajax({
			url: '/workflow/work/workfastAdd',
			type: 'get',
			dataType: 'json',
			data: {
				flowId: flowId,
				prcsId: 1,
				flowStep: 1,
				runId: '',
				preView: 0,
				isBudgetFlow: true,
				approvalData:JSON.stringify(approvalData),
				isTabApproval:true,
			},
			async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
			success: function (res) {
				if (res.flag == true) {
					var data = res.object;
					cb(data);
				}
			}
		});
	}
	function getDatta(){
		var datas = layui.table.checkStatus('reportTable').data;
		if(datas&&datas.length>0){
			return datas[0];
		}else{
			layui.layer.msg("请选择一条实施策划")
		}
		// var checkStatus=[];
		// $('#objectives .layui-table-body .laytable-cell-radio').each(function(indexNum,item){
		// 	if($(item).find('.layui-form-radioed').length>0){
		// 		checkStatus.push(tableData[indexNum]);
		// 	}
		// })
		return null;
	}
	function openRold(){ //流程转交下一步后会调用此方法
		//刷新表格
		SettlementTable.reload();
	}
</script>
</body>
</html>
