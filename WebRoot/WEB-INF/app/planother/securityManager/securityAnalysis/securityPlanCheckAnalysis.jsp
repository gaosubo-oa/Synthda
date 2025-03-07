<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/9/13
  Time: 9:44
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
	<title>安全分析</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20210527.1"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<%--        <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
	<script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?222021080915083"></script>

<%--	<script type="text/javascript" src="/js/planbudget/projectCostAnalysis.js?1202108301508"></script>--%>

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

		.wrap_right {
			position: relative;
			height: 100%;
			/*margin-left: 230px;*/
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
		.openFile input[type=file]{
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
		.mtl_info td[data-field="attachName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}

		.refresh_no_btn {
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}

		.layui-col-xs6{
			width: 20%;
		}

		/*.eleTree-node-content {*/
		/*	overflow: hidden;*/
		/*	word-break: break-all;*/
		/*	white-space: nowrap;*/
		/*	text-overflow: ellipsis;*/
		/*	text-align: left;*/
		/*}*/

		/*.eleTree-node-content:hover, .eleTree-node-content.eleTree-node-content-active {*/
		/*	background-color: #888;*/
		/*}*/

	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId">
	<div class="wrapper">
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2" style="text-align: center;position:relative;">
					<input type="text" id="ele_Tree" name="ele_Tree" readonly placeholder="请选择项目" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 6px;">
					<div class="eleTree ele2" lay-filter="data2" style="text-align: left;display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:5px;width: 100%;"></div>
				</div>
				<div class="layui-col-xs1" style="margin-left: 15px;">
					<input type="text" name="beginDate"  placeholder="开始时间" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs1" style="margin-left: 15px;">
					<input type="text" name="endDate"  placeholder="结束时间"  autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
					<%--					<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>--%>
				</div>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div class="table_box" style="position: relative">
				<div class="_two">
					<table id="tableDemo" lay-filter="tableDemo"></table>
				</div>
				<div class="_one">
					<table id="tableObj" lay-filter="tableObj"></table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="toolbarDemo">
	<div>
		<h2>安全检查计划</h2>
	</div>
</script>
<script type="text/html" id="toolbarDemo2">
	<div>
		<h2>安全检查</h2>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>


<script>
	var securityInfoDate = null


	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});


	// 表格显示顺序
	var colShowObj = {
		projectName:{field:'projectName',title:'项目名称'},
		securityKnowledgeName: {field: 'securityKnowledgeName', title: '检查项'},
		securityDangerDesc: {field: 'securityDangerDesc', title: '检查内容'},
		securityRegionName: {field: 'securityRegionName', title: '检查区域'},
		checkTime: {field: 'checkTime', title: '检查日期', sort: true, hide: false},
		checkSituation: {field: 'checkSituation', title: '检查情况'},
		needRecification: {field: 'needRecification', title: '是否需要整改', minWidth: 200, templet: function (d) {
			if(d.needRecification=='1'){
				return '<input type="checkbox"  disabled name="needRecification" needRecification="1" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
			}else{
				return '<input type="checkbox" disabled checked="" name="needRecification" needRecification="0" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
			}
			//return '<input type="text" name="needRecification" class="layui-input" style="height: 100%;" value="' + (d.needRecification || '') + '">'
		}},
		rectificationPersion: {field: 'rectificationPersion', title: '整改人'},
		rectificationPeriod: {field: 'rectificationPeriod', title: '整改期限'},
		recificationStatus: {field: 'recificationStatus', title: '整改状态'}
	}

	//表格显示顺序
	var colShowObj2 = {
		// documentNo: {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false,templet: function (d) {
		// 		return '<span securityPlanId="'+(d.securityPlanId||'')+'">'+(d.documentNo||'')+'</span>'
		// 	}},
		projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
		securityKnowledgeName2: {field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120,sort: true, hide: false},
		solutions:{field: 'solutions', title: '检查项描述', minWidth: 160},
		personLiableName: {field: 'personLiableName', title: '责任人', minWidth: 100,sort: true, hide: false},
		checkFrequency:{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
				return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
			}},
		solutions2:{field: 'workPlanningName', title: '所属策划', minWidth: 160},
		importance:{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
				return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
			}},
		securityPlanBeginDate: {field: 'securityPlanBeginDate', title: '计划检查开始日期', minWidth: 140,sort: true, hide: false},
		securityPlanEndDate: {field: 'securityPlanEndDate', title: '计划检查结束日期', minWidth: 140,sort: true, hide: false},
		securityKnowledgeName:{field: 'securityKnowledgeName', title: '检查详细内容',minWidth: 150, templet: function (d) {
				return '<span workPlanningId="' + (d.workPlanningId || '') + '" securityTermId="'+(d.securityTermId || '')+'" personLiable="'+(d.personLiable || '')+'" class="securityKnowledgeName chooseMaterials2"  style="cursor: pointer;color: blue;">' + (d.securityKnowledgeName || '') + '</span>'
			}},
	}

	var TableUIObj = new TableUI('plb_security_checklist');
	var TableUIObj2 = new TableUI('plb_security_plant1');

	// 获取数据字典数据
	var dictionaryObj = {

		CHECK_FREQUENCY:{},
		SCHEDULE_INPORTANCE:{}
	}
	var dictionaryStr = 'CHECK_FREQUENCY,SCHEDULE_INPORTANCE';
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

	$('[name="beginDate"]').val(getMonthBeforeFormatAndDay(0,'-',1))
	$('[name="endDate"]').val(getMonthBeforeFormatAndDay(1,'-',1))

	//选部门控件添加
	// $(document).on('click', '#testDeptName', function () {
	// 	dept_id = "testDeptName";
	// 	$.popWindow("/common/selectDept?0");
	// });
	//选选人控件添加
	// $(document).on('click', '#testLeaderName', function () {
	// 	user_id = "testLeaderName";
	// 	$.popWindow("/projectTarget/selectOwnDeptUser?0");
	// })

	var tableObj = null;
	var tableIns = null;
	layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree','treeTable'], function () {
		var form = layui.form,
				laydate = layui.laydate,
				table = layui.table,
				layElement = layui.element,
				soulTable = layui.soulTable,
				eleTree = layui.eleTree;
		treeTable = layui.treeTable;

		laydate.render({
			elem: '[name="beginDate"]'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			// ,value: new Date()
		});

		laydate.render({
			elem: '[name="endDate"]'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});

		var el;
		$("[name='ele_Tree']").on("click",function (e) {
			//debugger
			e.stopPropagation();
			if(!el){
				var loadingIndex = layer.load();
				$.get('/plbOrg/treeListOrg', function (res) {
					layer.close(loadingIndex);
					if (res.flag) {
						eleTree.render({
							elem: '.ele2',
							data: res.data,
							highlightCurrent: true,
							showLine: true,
							defaultExpandAll: false,
							expandOnClickNode: false,
							showCheckbox: false,
							checked: false,
							request: {
								name: 'name',
								children: "plbProjList",
							}
						});
						// tableShow('')
					}
				});
			}
			$(".ele2").slideDown();
		})
		$(document).on("click",function() {
			$(".ele2").slideUp();
		})

		//节点点击事件
		eleTree.on("nodeClick(data2)",function(d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#ele_Tree').val(currentData.projName).attr('projId',currentData.projId)
			} else {
				$('#ele_Tree').val('').attr('projId','')
			}
		})


		TableUIObj.init(colShowObj, function(){
			// $('.no_data').hide();
			// $('.table_box').show();
			tableInit();
		});
		TableUIObj2.init(colShowObj2, function(){
			// $('.no_data').hide();
			// $('.table_box').show();
			tableShow();
		});



		// 监听排序事件
		table.on('sort(tableObj)', function (obj) {
			var param = {
				orderbyFields: obj.field,
				orderbyUpdown: obj.type
			}

			TableUIObj.update(param, function () {
				tableInit();
			});
		});
		// 监听筛选列
		var checkboxTimer = null;
		form.on('checkbox()', function (data) {
			//判断监听的复选框是筛选列下的复选框
			if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
				checkboxTimer = null;
				clearTimeout(checkboxTimer);
				setTimeout(function () {
					var $parent = $(data.elem).parent().parent();
					var arr = [];
					$parent.find('input[type="checkbox"]').each(function () {
						var obj = {
							showFields: $(this).attr('name'),
							isShow: !$(this).prop('checked')
						}
						arr.push(obj);
					});
					var param = {showFields: JSON.stringify(arr)}
					TableUIObj.update(param);
				}, 1000);
			}
		});
		table.on('tool(tableObj)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'detail') {
				$.get('/workflow/acceptanceManager/getByContentId?securityContentId='+data.securityContentId,function(res){
					newOrEdit(res.obj)
				})
			}
		});

		/**
		 * 加载表格方法
		 */
		function tableInit(projId) {
			var searchObj = getSearchObj();
			searchObj.delFlag = 0
			searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
			searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;
			searchObj.inspectionlevel = "02";

			var cols = [{type:'numbers'}].concat(TableUIObj.cols);

			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#toolBar',
				title: '操作',
				width: 100
			});

			var option = {
				elem: '#tableObj',
				url: '/securityAnalysis/securityInfoAnalysis',
				cols: [cols],
				toolbar: '#toolbarDemo2',
				defaultToolbar: ['filter'],
				height: ($(document).height()-250),
				/*page: {
					limit: TableUIObj.onePageRecoeds,
					limits: [10, 20, 30, 40, 50]
				},*/
				limit:10000000,
				where: searchObj,
				// height: '500',
				autoSort: false,
				/*request: {
                    limitName: 'pageSize'
                },
                response: {
                    statusName: 'flag',
                    statusCode: true,
                    msgName: 'msg',
                    countName: 'totleNum',
                    dataName: 'data'
                },*/
				done: function (res) {
					layuiRowspan('._one','projectName',1);

					//增加拖拽后回调函数
					soulTable.render(this, function () {
						TableUIObj.dragTable('tableObj')
					})

					if (TableUIObj.onePageRecoeds != this.limit) {
						TableUIObj.update({onePageRecoeds: this.limit})
					}
				}
			}

			if (TableUIObj.orderbyFields) {
				option.initSort = {
					field: TableUIObj.orderbyFields,
					type: TableUIObj.orderbyUpdown
				}
			}

			tableObj = table.render(option);
		}

		//安全 检查详细内容
		$(document).on('click', '.chooseMaterials2', function () {
			var loadIndex = layer.load();
			$.post('/securityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
				new_Edit2(res.obj)
				layer.close(loadIndex);
			})
		})

		//安全 检查详细内容
		function new_Edit2(data) {
			var projectId = $('#leftId').attr('projId');
			layer.open({
				type: 1,
				title: '检查详细内容',
				area: ['90%', '90%'],
				btn: ['确定'],
				btnAlign: 'c',
				content: '<div style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
				success: function () {

					//检查计划明细
					var cols = [
						// {type: 'radio'},
						{type: 'numbers', title: '序号'},
						{field: 'securityDanger', minWidth:150,title: '检查内容'},
						{field: 'securityDangerMeasures', minWidth:150,title: '整改措施'},
						{field: 'securityDangerGrade',minWidth:100, title: '隐患级别',templet:function(d){
								if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
									if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
									}else{
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
									}
								}else{
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
								}
							}
						}
					]

					table.render({
						elem: '#detailed_Table',
						data: data&&data.detailList||[],
						defaultToolbar: [''],
						limit: 10000000,
						cols: [cols],
						done:function(res){

						}
					});

					form.render();
				},
				yes: function (index) {
					layer.close(index);
				}
			});
		}
		var dom = '.layui-table-body [data-field="securityDanger"] div,' +
				'.layui-table-body [data-field="securityDangerMeasures"] div'
		$(document).on('mouseenter', dom, function() {
			var content = $(this).text();
			if(!content){
				return false
			}

			this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
				time: -1
				,maxWidth: 280
				,tips: [3, '#3A3D49']
			});
		}).on('mouseleave', dom,function(){
			layer.close(this.index);
		});
		// 监听排序事件
		table.on('sort(tableDemo)', function (obj) {
			var param = {
				orderbyFields: obj.field,
				orderbyUpdown: obj.type
			}

			TableUIObj2.update(param, function () {
				tableShow()
			})
		});

		// 渲染表格
		function tableShow(projId) {
			var searchObj = getSearchObj();
			searchObj.delFlag = 0;
			searchObj.importance = "02";

			var cols = [{type:'numbers'}].concat(TableUIObj2.cols)

			// cols.push({
			//     fixed: 'right',
			//     align: 'center',
			//     toolbar: '#detailBarDemo',
			//     title: '操作',
			//     width: 100
			// })

			tableIns = table.render({
				elem: '#tableDemo',
				url: '/security2Plan/select',
				toolbar: '#toolbarDemo',
				cols: [cols],
				defaultToolbar: ['filter'],
				height: ($(document).height()-250),
				// height: 'full-80',
				// page: {
				//     limit: TableUIObj2.onePageRecoeds,
				//     limits: [10, 20, 30, 40, 50]
				// },
				limit:100000000,
				where: searchObj,
				autoSort: false,
				// parseData: function (res) { //res 即为原始返回的数据
				//     return {
				//         "code": 0, //解析接口状态
				//         "data": res.data, //解析数据列表
				//         "count": res.totleNum, //解析数据长度
				//     };
				// },
				/*request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },*/
				done: function (res) {
					layuiRowspan('._two','projectName',1);
					//增加拖拽后回调函数
					soulTable.render(this, function () {
						TableUIObj2.dragTable('tableDemo')
					})

					if (TableUIObj2.onePageRecoeds != this.limit) {
						TableUIObj2.update({onePageRecoeds: this.limit})
					}
				},
				initSort: {
					field: TableUIObj2.orderbyFields,
					type: TableUIObj2.orderbyUpdown
				}
			});
		}


		/**
		 * 查看详情
		 */
		function newOrEdit(data) {
			securityInfoDate=data;
			layer.open({
				type: 2,
				title: '查看详情',
				area: ['100%', '100%'],
				btn: ['确定'],
				btnAlign: 'c',
				content:'/workflow/secirityManager/addRectification?urlType=dangerAccount',
				success: function () {

				},
				yes: function (index,layero) {
					layer.close(index);
				}
			})
		}

		// 查询
		$('#searchBtn').on('click', function(){
			tableInit()
			tableShow()
		});

		// 高级查询
		$('#advancedQuery').on('click', function(){
			layer.msg('功能完善中')
		});

		/**
		 * 获取查询条件
		 * @returns {{planNo: (*), planName: (*)}}
		 */
		function getSearchObj() {
			var searchObj = {}

			if($('.query_module [name="ele_Tree"]').attr('projId')){
				searchObj.projectId=$('.query_module [name="ele_Tree"]').attr('projId')
			}
			if($('.query_module [name="beginDate"]').val()){
				searchObj.beginDate=$('.query_module [name="beginDate"]').val()
			}
			if($('.query_module [name="endDate"]').val()){
				searchObj.endDate=$('.query_module [name="endDate"]').val()
			}

			return searchObj
		}
	});

	var _urlImg = ''
	var drawing_id;

	function drawingImg(_this){
		drawing_id = _this.attr('id');
		var url =''
		if($(_this).attr('attrurl')){
			//url+='urls='+$(_this).attr('attrurl')+'&'
			_urlImg = $(_this).attr('attrurl')
		}
		if($(_this).attr('regionX')){
			url+='regionX='+$(_this).attr('regionX')+'&'
		}
		if($(_this).attr('regionY')){
			url+='regionY='+$(_this).attr('regionY')
		}

		$.popWindow("/workflow/secirityManager/selectDrawing?type=manage&"+url);
	}


	//判断undefined
	function undefind_nullStr(value) {
		if(value==undefined || value == "undefined"){
			return ""
		}
		return value
	}


	var execRowspan = function(dom,fieldName,index,flag){
		// 1为不冻结的情况，左侧列为冻结的情况
		let fixedNode = index=="1"?$(dom+" .layui-table-body")[index - 1]:(index=="3"?$(dom+" .layui-table-fixed-r"):$(dom+" .layui-table-fixed-l"));
		// 左侧导航栏不冻结的情况
		let child = $(fixedNode).find("td");
		let childFilterArr = [];
		// 获取data-field属性为fieldName的td
		for(let i = 0; i < child.length; i++){
			if(child[i].getAttribute("data-field") == fieldName){
				childFilterArr.push(child[i]);
			}
		}
		// 获取td的个数和种类
		let childFilterTextObj = {};
		for(let i = 0; i < childFilterArr.length; i++){
			let childText = flag?childFilterArr[i].innerHTML:childFilterArr[i].textContent;
			if(childFilterTextObj[childText] == undefined){
				childFilterTextObj[childText] = 1;
			}else{
				let num = childFilterTextObj[childText];
				childFilterTextObj[childText] = num*1 + 1;
			}
		}
		let canRowspan = true;
		let maxNum;//以前列单元格为基础获取的最大合并数
		let finalNextIndex;//获取其下第一个不合并单元格的index
		let finalNextKey;//获取其下第一个不合并单元格的值
		for(let i = 0; i < childFilterArr.length; i++){
			(maxNum>9000||!maxNum)&&(maxNum = $(childFilterArr[i]).prev().attr("rowspan")&&fieldName!="8"?$(childFilterArr[i]).prev().attr("rowspan"):9999);
			let key = flag?childFilterArr[i].innerHTML:childFilterArr[i].textContent;//获取下一个单元格的值
			let nextIndex = i+1;
			let tdNum = childFilterTextObj[key];
			let curNum = maxNum<tdNum?maxNum:tdNum;
			if(canRowspan){
				for(let j =1;j<=curNum&&(i+j<childFilterArr.length);){//循环获取最终合并数及finalNext的index和key
					finalNextKey = flag?childFilterArr[i+j].innerHTML:childFilterArr[i+j].textContent;
					finalNextIndex = i+j;
					if((key!=finalNextKey&&curNum>1)||maxNum == j){
						canRowspan = true;
						curNum = j;
						break;
					}
					j++;
					if((i+j)==childFilterArr.length){
						finalNextKey=undefined;
						finalNextIndex=i+j;
						break;
					}
				}
				childFilterArr[i].setAttribute("rowspan",curNum);
				if($(childFilterArr[i]).find("div.rowspan").length>0){//设置td内的div.rowspan高度适应合并后的高度
					$(childFilterArr[i]).find("div.rowspan").parent("div.layui-table-cell").addClass("rowspanParent");
					$(childFilterArr[i]).find("div.layui-table-cell")[0].style.height= curNum*38-10 +"px";
				}
				canRowspan = false;
			}else{
				childFilterArr[i].style.display = "none";
			}
			if(--childFilterTextObj[key]==0|--maxNum==0|--curNum==0|(finalNextKey!=undefined&&nextIndex==finalNextIndex)){//||(finalNextKey!=undefined&&key!=finalNextKey)
				canRowspan = true;
			}
		}
	}
	//合并数据表格行
	var layuiRowspan = function(fieldNameTmp,index,flag){
		let fieldName = [];
		if(typeof fieldNameTmp == "string"){
			fieldName.push(fieldNameTmp);
		}else{
			fieldName = fieldName.concat(fieldNameTmp);
		}
		for(let i = 0;i<fieldName.length;i++){
			execRowspan(fieldName[i],index,flag);
		}
	}

	//求自然月日期
	function getMonthBeforeFormatAndDay(num, format, day) {
		var date = new Date();
		date.setMonth(date.getMonth() + (num*1), 1);
		//读取日期自动会减一，所以要加一
		var mo = date.getMonth() + 1;
		//小月
		if (mo == 4 || mo == 6 || mo == 9 || mo == 11) {
			if (day > 30) {
				day = 30
			}
		}
		//2月
		else if (mo == 2) {
			if (isLeapYear(date.getFullYear())) {
				if (day > 29) {
					day = 29
				} else {
					day = 28
				}
			}
			if (day > 28) {
				day = 28
			}
		}
		//大月
		else {
			if (day > 31) {
				day = 31
			}
		}

		if(day>0&&day<10){
			day = '0'+day
		}

		retureValue = date.format('yyyy' + format + 'MM' + format + day);

		return retureValue;
	}

	//JS判断闰年代码
	function isLeapYear(Year) {
		if (((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
			return (true);
		} else { return (false); }
	}

	//日期格式化
	Date.prototype.format = function (format) {
		var o = {
			"M+": this.getMonth() + 1, // month
			"d+": this.getDate(), // day
			"h+": this.getHours(), // hour
			"m+": this.getMinutes(), // minute
			"s+": this.getSeconds(), // second
			"q+": Math.floor((this.getMonth() + 3) / 3), // quarter
			"S": this.getMilliseconds()
			// millisecond
		}

		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		for (var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	}
</script>
</body>
</html>
