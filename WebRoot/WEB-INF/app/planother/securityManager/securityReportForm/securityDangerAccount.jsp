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
	<title>安全隐患台账</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
	<script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
	<script src="../js/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>

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

		/* region 左侧样式 */
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

		/* endregion */

		/* region 右侧样式 */
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

		/* endregion */

		/* region 上传附件样式 */
		.file_upload_box {
			position: relative;
			height: 22px;
			overflow: hidden;
		}

		.open_file {
			float: left;
			position: relative;
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

		/*选中行样式*/
		.selectTr {
			background: #009688 !important;
			color: #fff !important;
		}

		.refresh_no_btn {
			display: none;
			margin-left: 2%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}
		.layui-col-xs4{
			width: 20%;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">安全隐患台账</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off"
					   class="layui-input"/>
			</div>
			<div class="tree_module">
				<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
			</div>
		</div>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2">
					<input type="text" name="rectificationTimeDateStart" id="rectificationTimeDateStart" placeholder="开始时间" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="rectificationTimeDateEnd" id="rectificationTimeDateEnd"  placeholder="结束时间"  autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="needRectificationUser" id="needRectificationUser" placeholder="整改人" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="rectificationFlag" id="rectificationFlag">
						<option value="">请选择整改状态</option>
						<option value="0">未整改</option>
						<option value="1">已整改</option>
						<option value="10">未验收通过</option>
					</select>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
					<%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
					<i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
				</div>
				<%--<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>--%>
			</div>
			<div style="position: relative">
				<div class="table_box" style="display: none">
					<div class="layui-tab" lay-filter="demo">
						<ul class="layui-tab-title">
							<li class="layui-this">未完成</li>
							<li>已完成</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show">
								<table id="tableDemo" lay-filter="tableDemo"></table>
							</div>
							<div class="layui-tab-item">
								<table id="tableDemo1" lay-filter="tableDemo1"></table>
							</div>
						</div>
					</div>
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

<script type="text/html" id="detailBarDemo">
	<a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>

	var _index = ''

	var securityInfoDate = null;

	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});

	//选选人控件添加
	$(document).on('click', '#needRectificationUser', function () {
		user_id = "needRectificationUser";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})

	var tableIns = null;

	var animateFlag = true
	$(".screen-full").click(function(){
		$(".wrap_left").animate({
			width:'toggle'
		});
		$(".wrap_right").animate({
			marginLeft:'0'
		},function(){
			$('.searchData').click()
		});
		if(animateFlag){
			$(this).removeClass("layui-icon-screen-full").addClass('layui-icon-screen-restore').attr('title','退出全屏');

		}else {
			$(this).removeClass("layui-icon-screen-restore").addClass('layui-icon-screen-full').attr('title','全屏');
		}

		animateFlag = !animateFlag
	});

	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var soulTable = layui.soulTable;

		laydate.render({
			elem: '#rectificationTimeDateStart'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});

		laydate.render({
			elem: '#rectificationTimeDateEnd'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});

		element.on('tab(demo)', function(data){
			_index = data.index?data.index:''
			tableShow($('#leftId').attr('projId'));
		});

		form.render();
		//表格显示顺序
		var colShowObj = {
			// documentNo: {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			rectificationFlag: {field: 'rectificationFlag', title: '整改状态',minWidth: 120,templet: function (d) {
					if(d.detailsInfo&&d.detailsInfo.needAcceptance==0){
						if(d.rectificationFlag&&d.rectificationFlag==1&&d.acceptance&&d.acceptance.auditerStatus==2){
							return  '<span>已完成</span>'
						}else if(d.rectificationFlag&&d.rectificationFlag==1&&d.acceptance&&d.acceptance.auditerStatus!=2){
							return  '<span style="color: red">已整改未验收</span>'
						}else if(d.rectificationFlag&&d.rectificationFlag==1&&!d.acceptance){
							return  '<span style="color: red">已整改未验收</span>'
						}else if(d.rectificationFlag&&d.rectificationFlag==0){
							return  '<span style="color: red">未整改</span>'
						}else{
							return  '<span style="color: red">未验收</span>'
						}
					}else if(d.rectificationFlag&&d.rectificationFlag==0){
						return  '<span style="color: red">未整改</span>'
					}else if(d.rectificationFlag&&d.rectificationFlag==10){
						return  '<span style="color: red">未通过验收</span>'
					}else if(d.detailsInfo&&d.detailsInfo.needAcceptance==1&&d.rectificationFlag&&d.rectificationFlag==1){
						return  '<span>已完成</span>'
					}else{
						return  '<span></span>'
					}
				}},
			createTime: {field: 'createTime', title: '检查时间',minWidth: 120, sort: true, hide: false,templet: function (d) {
					return '<span>'+(d.checklist?d.checklist.createTime:'')+'</span>'
				}},
			securityKnowledgeName: {field: 'securityKnowledgeName', title: '检查项',minWidth: 120, sort: true, hide: false,templet: function (d) {
					return '<span>'+(d.detailsInfo?d.detailsInfo.securityKnowledgeName:'')+'</span>'
				}},
			securityDangerDesc: {field: 'securityDangerDesc', title: '检查内容',minWidth: 120, sort: true, hide: false,templet: function (d) {
					return '<span>'+(d.detailsInfo?d.detailsInfo.securityDangerDesc:'')+'</span>'
				}},
			securityGrade: {field: 'securityGrade', title: '隐患级别',minWidth: 120, sort: true, hide: false, templet: function (d) {
					if(d.detailsInfo){
						if(d.detailsInfo.securityGrade==0){
							return '<span class="securityGrade" securityGrade="'+d.detailsInfo.securityGrade+'" style="color: red" >重大隐患</span>'
						}else if(d.detailsInfo.securityGrade==1){
							return '<span class="securityGrade" securityGrade="'+d.detailsInfo.securityGrade+'">一般隐患</span>'
						}else{
							return '<span class="securityGrade"></span>'
						}
					}else {
						return '<span class="securityGrade"></span>'
					}

				}},
			dangerLocation: {field: 'dangerLocation', title: '隐患位置',minWidth: 120, sort: true, hide: false,templet: function (d) {
					return '<span>'+(d.detailsInfo?d.detailsInfo.dangerLocation:'')+'</span>'
				}},
			securityDangerMeasures: {field: 'securityDangerMeasures', title: '整改措施',minWidth: 200, sort: true, hide: false,templet: function (d) {
					return '<span>'+(d.detailsInfo?d.detailsInfo.securityDangerMeasures:'')+'</span>'
				}},
			rectificationPeriod: {field: 'rectificationPeriod', title: '整改期限',minWidth: 120, sort: true, hide: false,templet: function (d) {
					return '<span>'+(d.detailsInfo&&d.detailsInfo.rectificationPeriod?d.detailsInfo.rectificationPeriod:'')+'</span>'
				}},
			createUserName: {field: 'createUserName', title: '检查人',minWidth: 120, sort: true, hide: false,templet: function (d) {
					return '<span>'+(d.checklist?d.checklist.createUserName:'')+'</span>'
				}},
			rectificationUser: {field: 'needRectificationUserName',minWidth: 120, title: '整改人', sort: true, hide: false}
		}

		var TableUIObj = new TableUI('plb_security_punishment');


		// 初始化左侧项目
		projectLeft();

		table.on('tool(tableDemo)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if(layEvent === 'detail'){
				newOrEdit(data)
			}
		});
		table.on('tool(tableDemo1)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if(layEvent === 'detail'){
				newOrEdit(data)
			}
		});
		// 监听排序事件
		table.on('sort(tableDemo'+_index+')', function (obj) {
			var param = {
				orderbyFields: obj.field,
				orderbyUpdown: obj.type
			}

			TableUIObj.update(param, function () {
				tableShow($('#leftId').attr('projId'))
			})
		});



		// 监听筛选列
		form.on('checkbox()', function (data) {
			//判断监听的复选框是筛选列下的复选框
			if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
				setTimeout(function () {
					var $parent = $(data.elem).parent().parent()
					var arr = []
					$parent.find('input[type="checkbox"]').each(function () {
						var obj = {
							showFields: $(this).attr('name'),
							isShow: !$(this).prop('checked')
						}
						arr.push(obj)
					})
					var param = {showFields: JSON.stringify(arr)}
					TableUIObj.update(param)
				}, 1000)
			}
		});

		var searchTimer = null
		$('#search_project').on('input propertychange', function () {
			clearTimeout(searchTimer)
			searchTimer = null
			var val = $(this).val()
			searchTimer = setTimeout(function () {
				projectLeft(val)
			}, 300)
		});
		$('.search_icon').on('click', function () {
			projectLeft($('#search_project').val())
		});

		//左侧项目信息列表
		function projectLeft(projectName) {
			projectName = projectName ? projectName : ''
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
					TableUIObj.init(colShowObj,function () {
						// tableShow('')
					});
				}
			});
		}

		// 树节点点击事件
		eleTree.on("nodeClick(leftTree)", function (d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#leftId').attr('projId', currentData.projId);
				$('.no_data').hide();
				$('.table_box').show();
				tableShow(currentData.projId);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 渲染表格
		function tableShow(projId) {
			var obj = {
				projId: projId,
				projectId: projId,
				//orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
				//orderbyUpdown: TableUIObj.orderbyUpdown
			}
			if(_index&&_index==1){
				obj.closeFlag = 'closeFlag'
			}else {
				obj.closeFlag = 'false'
			}
			var cols = [{checkbox: true},{title: '序号',type:'numbers'}].concat(TableUIObj.cols)

			if(_index&&_index==1){
				cols.push({field: 'acceptanceUser', title: '验收人',minWidth: 120, sort: true, hide: false,templet: function (d) {
						return '<span>'+(d.acceptance?d.acceptance.acceptanceUser:'')+'</span>'
					}})
			}
			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#detailBarDemo',
				title: '操作',
				width: 100
			})

			tableIns = table.render({
				elem: '#tableDemo'+_index,
				url: '/workflow/rectification/select',
				toolbar: '#toolbarDemo',
				cols: [cols],
				defaultToolbar: ['filter'],
				// height: 'full-80',
				page: {
					limit: TableUIObj.onePageRecoeds,
					limits: [10, 20, 30, 40, 50]
				},
				where: obj,
				autoSort: false,
				done: function (res) {
					//增加拖拽后回调函数
					soulTable.render(this, function () {
						TableUIObj.dragTable('tableDemo')
					})

					if (TableUIObj.onePageRecoeds != this.limit) {
						TableUIObj.update({onePageRecoeds: this.limit})
					}
				},
				initSort: {
					field: TableUIObj.orderbyFields,
					type: TableUIObj.orderbyUpdown
				}
			});

		}

		// 查看详情
		function newOrEdit(data) {
			securityInfoDate = data
			layer.open({
				type: 2,
				title: '查看详情',
				area: ['100%', '100%'],
				btn: '确定',
				btnAlign: 'c',
				content: '/workflow/secirityManager/addRectification?urlType=dangerAccount',
				success: function () {

				},
				yes: function (index) {
					layer.close(index);
				}
			});
		}

		//点击查询
		$('.searchData').click(function () {
			var searchParams = {
				projId: $('#leftId').attr('projId'),
				projectId: $('#leftId').attr('projId'),
			}
			if($('#rectificationTimeDateStart').val()){
				searchParams.rectificationTimeDateStart=$('#rectificationTimeDateStart').val()
			}
			if($('#rectificationTimeDateEnd').val()){
				searchParams.rectificationTimeDateEnd=$('#rectificationTimeDateEnd').val()
			}
			if($('#needRectificationUser').attr('user_id')){
				searchParams.needRectificationUser=$('#needRectificationUser').attr('user_id').replace(",","")
			}
			if($('#rectificationFlag').val()){
				searchParams.rectificationFlag=$('#rectificationFlag').val()
			}
			tableIns.reload({
				where: searchParams,
				page: {
					curr: 1 //重新从第 1 页开始
				}
			});

		});

	});

</script>
</body>
</html>
