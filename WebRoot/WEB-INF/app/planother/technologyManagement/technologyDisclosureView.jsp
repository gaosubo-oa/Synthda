<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/12
  Time: 9:41
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
	<title>技术交底预览</title>

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

		.objectives_Table .layui-table-cell,.objectives_Table .layui-table-box,.objectives_Table .layui-table-body {
			overflow: visible;
		}
		/* 设置下拉框的高度与表格单元格的高度相同 */
		.objectives_Table td .layui-form-select {
			margin-top: -10px;
			margin-left: -15px;
			margin-right: -15px;
		}
		.layui-disabled{
			background: #e7e7e7;
			color: black !important;
		}
	</style>
</head>
<body>

<div class="container" id="htm"></div>


<script>
	// 获取地址栏参数值
	function getQueryString(name){
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if(r!=null)return  unescape(r[2]); return null;
	}

	var runId = getQueryString("runId");

	var _disabled = getQueryString('disabled');
	//var type = getQueryString("type");
	var type;
	if('0'!=_disabled){
		type = 4
	}else {
		type = 1
	}

	var data = null
	var projectId = null

	var htm = ['<div class="layui-collapse">\n' +
	/* region 方案内容 */
	'  <div class="layui-colla-item">\n' +
	'    <h2 class="layui-colla-title">方案内容</h2>\n' +
	'    <div class="layui-colla-content layui-show plan_base_info">' +
	'       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
	/* region 第一行 */
	'           <div class="layui-row">' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">单据号<span field="documnetNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                       <input type="text" name="documnetNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">技术交底名称<span field="disclosureName" class="field_required">*</span></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="disclosureName" id="disclosureName"  autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">技术方案名称<span field="technicalName" class="field_required">*</span></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="technicalName" id="technicalName" readonly="" autocomplete="off" class="layui-input click_one" style="width: 60%; padding-right: 25px;color: blue;background:#e7e7e7;cursor: pointer;float: left">' +
	'							<a class="layui-btn chooseMtlPlanId2" style="width: 30%; float:right;">选择</a>' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">方案类型</label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                       	<select id="scheme_Type" name="schemeType" disabled style="background: #e7e7e7"></select>\n' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'           </div>' ,
		'<div class="layui-row">' +
		'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">方案概述</label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		' 							<textarea type="text" name="schemeSummary"  disabled  style="resize: vertical;min-height: 80px;" autocomplete="off" class="layui-input"></textarea>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'</div>',
		'           <div class="layui-row">' +
		'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">技术方案附件</label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		/*'<a href="javascript:;" class="open_file">' +
        '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
        '<input type="file" multiple id="fileupload" data-url="/upload?module=technologyDisclosure" name="file">' +
        '</a>' +*/
		/*'<div class="progress" id="progress">' +
        '<div class="bar"></div>\n' +
        '</div>' +*/
		'<div class="bar_text"></div>' +
		'</div>' +
		'</div>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'           </div>',
		/* endregion */
		'       </form>' +
		'    </div>\n' +
		'  </div>\n' +
		/* endregion */
		'  <div class="layui-colla-item">\n' +
		'    <h2 class="layui-colla-title">方案主要内容</h2>\n' +
		'    <div class="layui-colla-content layui-show project_detailed_information">' +
		'		<table id="detailedTable" lay-filter="detailedTable"></table>' +
		'    </div>\n' +
		'  </div>\n' +
		'  <div class="layui-colla-item _disabled">\n' +
		'    <h2 class="layui-colla-title">交底主要内容</h2>\n' +
		'    <div class="layui-colla-content layui-show project_objectives">' +
		'		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
		'    </div>\n' +
		'  </div>\n' +
		/* endregion */
		'           <div class="layui-row">' +
		'               <div class="layui-col-xs3" style="padding: 0 30px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">技术交底附件</label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent2" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		'<a href="javascript:;" class="open_file">' +
		'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
		'<input type="file" multiple id="fileupload2" data-url="/upload?module=technologyDisclosure" name="file">' +
		'</a>' +
		/*'<div class="progress" id="progress">' +
        '<div class="bar"></div>\n' +
        '</div>' +*/
		'<div class="bar_text"></div>' +
		'</div>' +
		'</div>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">交底会议纪要</label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent3" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		'<a href="javascript:;" class="open_file">' +
		'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
		'<input type="file" multiple id="fileupload3" data-url="/upload?module=technologyDisclosure" name="file">' +
		'</a>' +
		/*'<div class="progress" id="progress">' +
        '<div class="bar"></div>\n' +
        '</div>' +*/
		'<div class="bar_text"></div>' +
		'</div>' +
		'</div>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">交底签字记录</label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent4" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		'<a href="javascript:;" class="open_file">' +
		'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
		'<input type="file" multiple id="fileupload4" data-url="/upload?module=technologyDisclosure" name="file">' +
		'</a>' +
		/*'<div class="progress" id="progress">' +
        '<div class="bar"></div>\n' +
        '</div>' +*/
		'<div class="bar_text"></div>' +
		'</div>' +
		'</div>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">交底现场照片</label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent5" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		'<a href="javascript:;" class="open_file">' +
		'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
		'<input type="file" multiple id="fileupload5" data-url="/upload?module=technologyDisclosure" name="file">' +
		'</a>' +
		/*'<div class="progress" id="progress">' +
        '<div class="bar"></div>\n' +
        '</div>' +*/
		'<div class="bar_text"></div>' +
		'</div>' +
		'</div>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'           </div>',
		/* endregion */
		'</div>'].join('');

	$("#htm").html(htm)


	// 获取数据字典数据
	var dictionaryObj = {
		SCHEME_TYPE:{}
	}
	var dictionaryStr = 'SCHEME_TYPE';
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
		initPage();
	});



	function initPage() {
		layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer'], function () {
			var laydate = layui.laydate;
			var form = layui.form;
			var table = layui.table;
			var element = layui.element;
			var eleTree = layui.eleTree;
			var layer = layui.layer;


			var param = {};
			var fla = true;
			if(runId){
				param.runId=runId;
			}else{
				fla = false;
				layer.msg("信息获取失败！")
				return false;
			}
			if(fla){
				$.ajax({
					url:"/technologyDisclosure/getById",
					data:param,
					dataType:"json",
					success:function(res){
						if(res.code===0||res.code==="0"){
							data = res.obj;

							projectId = data.projectId
							//方案类型
							var $select1 = $("#scheme_Type");
							var optionStr = '<option value="">请选择</option>';
							optionStr += dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['str']
							$select1.html(optionStr);

							fileuploadFn('#fileupload2', $('#fileContent2'));
							fileuploadFn('#fileupload3', $('#fileContent3'));
							fileuploadFn('#fileupload4', $('#fileContent4'));
							fileuploadFn('#fileupload5', $('#fileContent5'));
							//回显项目名称
							getProjName('#projectName',projectId?projectId:data.projectId)

							//回显数据
							if (type == 1 || type == 4) {
								form.val("formTest", data);
								$('#technicalName').val((data.technologyScheme&&data.technologyScheme.technicalName)||'').attr('technologyId',data.technologyId||'')
								$('[name="schemeType"]').val((data.technologyScheme&&data.technologyScheme.schemeType)||'')
								$('[name="schemeSummary"]').val((data.technologyScheme&&data.technologyScheme.schemeSummary)||'')
								//附件
								if (data.technologyScheme&&data.technologyScheme.attachmentList && data.technologyScheme.attachmentList.length > 0) {
									var fileArr = data.technologyScheme.attachmentList;
									$('#fileContent').append(echoAttachment(fileArr));
								}
								//附件
								if (data.attachmentList2 && data.attachmentList2.length > 0) {
									var fileArr = data.attachmentList2;
									$('#fileContent2').append(echoAttachment(fileArr));
								}
								//附件
								if (data.attachmentList3 && data.attachmentList3.length > 0) {
									var fileArr = data.attachmentList3;
									$('#fileContent3').append(echoAttachment(fileArr));
								}
								//附件
								if (data.attachmentList4 && data.attachmentList4.length > 0) {
									var fileArr = data.attachmentList4;
									$('#fileContent4').append(echoAttachment(fileArr));
								}
								//附件
								if (data.attachmentList5 && data.attachmentList5.length > 0) {
									var fileArr = data.attachmentList5;
									$('#fileContent5').append(echoAttachment(fileArr));
								}
							}else{
								// 获取自动编号
								getAutoNumber({autoNumberType: 'technologyDisclosure'}, function(res) {
									$('input[name="documnetNo"]', $('#baseForm')).val(res.obj);
								});
								$('.refresh_no_btn').show().on('click', function() {
									getAutoNumber({autoNumberType: 'technologyDisclosure'}, function(res) {
										$('input[name="documnetNo"]', $('#baseForm')).val(res.obj);
									});
								});
							}

							//方案主要内容
							var cols = [
								{type: 'numbers', title: '序号'},
								{
									field: 'mainSchemeName', title: '名称', minWidth: 150, templet: function (d) {
										return '<span disclosureId="' + (d.disclosureId || '') + '" mainSchemeId="'+(d.mainSchemeId || '')+'" class="mainSchemeName" >' + (d.mainSchemeName || '') + '</span>'
									}
								},
								{field: 'mainSchemeContent', title: '主要内容', minWidth: 160},
								{field: 'completedUser', title: '完成人', minWidth: 160}
							]
							//交底主要内容
							var cols2 = [
								{type: 'numbers', title: '序号'},
								{
									field: 'mainSchemeName', title: '名称', minWidth: 150, templet: function (d) {
										return '<input disclosureId="' + (d.disclosureId || '') + '" mainSchemeId="'+(d.mainSchemeId || '')+'" type="text" name="mainSchemeName" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeName || '') + '">'
									}
								},
								{
									field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
										return '<input type="text" name="mainSchemeContent" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
									}
								},
								{
									field: 'responsibilityUser', title: '责任人', minWidth: 160, templet: function (d) {
										return '<input type="text" name="responsibilityUser" class="layui-input" style="height: 100%;" value="' + (d.responsibilityUser || '') + '">'
									}
								}
							]
							//查看详情
							if(type!=4){
								// cols.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
								cols2.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
							}
							table.render({
								elem: '#detailedTable',
								data: data&&data.technologyScheme&&data.technologyScheme.schemeDetailList||[],
								height: data&&data.technologyScheme&&data.technologyScheme.schemeDetailList&&data.technologyScheme.schemeDetailList.length>5?'full-350':false,
								// toolbar: type==4?false:'#toolbarPlan',
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols],
							});

							table.render({
								elem: '#objectivesTable',
								data: data&&data.disclosureLists||[],
								height: data&&data.disclosureLists&&data.disclosureLists.length>5?'full-350':false,
								toolbar: type==4?false:'#toolbarPlan',
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols2],
							});

							//查看详情
							if(type==4){
								$('._disabled [name]').attr('disabled', 'disabled');
								$('.refresh_no_btn').hide();
								$('.file_upload_box').hide()
								$('.deImgs').hide();
								$('.chooseMtlPlanId2').hide()
							}

							element.render();
							form.render();
						}else{
							layer.msg("信息获取失败！")
							return false;
						}
					}
				})
			}

			// 方案主要内容-加行
			table.on('toolbar(objectivesTable)', function (obj) {
				switch (obj.event) {
					case 'add':
						//遍历表格获取每行数据进行保存
						var dataArr = planningDetailsData().scheduleData;
						dataArr.push({});
						table.reload('objectivesTable', {
							data: dataArr,
							height: dataArr&&dataArr.length>5?'full-350':false,
						});
						break;
				}
			});
			// 方案主要内容-删行
			table.on('tool(objectivesTable)', function (obj) {
				var data = obj.data;
				var layEvent = obj.event;
				var $tr = obj.tr;
				if (layEvent === 'del') {
					if (data.mainSchemeId) {
						$.get('/technologyDisclosure/del', {ids: data.mainSchemeId,type:'schemeList'}, function (res) {
							if (res.flag) {
								layer.msg('删除成功!', {icon: 1, time: 2000});
								obj.del();
								table.reload('objectivesTable', {
									data: planningDetailsData().scheduleData,
									height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
								});
							} else {
								layer.msg('删除失败!', {icon: 2, time: 2000});
							}
						});
					} else {
						layer.msg('删除成功!', {icon: 1, time: 2000});
						obj.del();
						table.reload('objectivesTable', {
							data: planningDetailsData().scheduleData,
							height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false,
						});
					}
				}
			})
			$(document).on('click', '.chooseMtlPlanId2', function() {
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
						table.render({
							elem: '#Settlement2',
							url: '/technologyScheme/select',//数据接口
							page:true,
							where: {
								projId: projectId,
								projectId: projectId,
								delFlag: '0',
								auditerStatus:'2'
							},
							cols: [[//表头
								{type: 'radio'},
								{field: 'documnetNo', title: '单据号', minWidth: 90,sort: true, hide: false},
								{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
								{field: 'technicalName', title: '技术方案名称', minWidth: 120,sort: true, hide: false},
								{field: 'schemeType', title: '方案类型',minWidth: 100, sort: true, hide: false,templet: function (d) {
										if(d.schemeType) {
											return '<span>'+((dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['object'][d.schemeType])||'')+'</span>'
										}else {
											return ''
										}
									}}
							]],
							done:function(res){
								var _dataa=res.data;
								var technologyId = $('#technicalName').attr('technologyId')
								if(technologyId){
									for(var i = 0 ; i <_dataa.length;i++){
										if(_dataa[i].technologyId == technologyId){
											$('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
											//form.render('checkbox');
										}
									}
								}

							}
						});
					},
					yes: function (index) {
						var datas =table.checkStatus('Settlement2').data;
						if (datas.length > 0) {
							$('#technicalName').val(datas[0].technicalName).attr('technologyId',datas[0].technologyId)
							$('#baseForm [name="schemeType"]').val(datas[0].schemeType)
							$('#baseForm [name="schemeSummary"]').val(datas[0].schemeSummary)
							//附件
							if (datas[0]&&datas[0].attachmentList && datas[0].attachmentList.length > 0) {
								var fileArr = datas[0].attachmentList;
								$('#baseForm #fileContent').html(echoAttachment(fileArr));
							}
							table.reload('detailedTable', {
								data: datas[0]&&datas[0].schemeDetailList,
								height: datas[0]&&datas[0].schemeDetailList&&datas[0].schemeDetailList.length>5?'full-350':false,
							});
							layer.close(index);
						} else {
							layer.msg('请选择一项！', {icon: 0});
						}
					}
				});
			});

			$(document).on('click', '#technicalName', function() {
				var technologyId = $(this).attr('technologyId')
				if(!technologyId){
					return
				}
				var loadIndex = layer.load();
				$.get('/technologyScheme/getById', {kayId:technologyId}, function (res) {
					var _data = res.obj
					layer.open({
						type: 1,
						title: '技术方案详情',
						area: ['100%', '100%'],
						maxmin: true,
						btnAlign:'c',
						btn: ['确定'],
						content: ['<div class="layui-collapse _disabled2">\n' +
						/* region 方案内容 */
						'  <div class="layui-colla-item">\n' +
						'    <h2 class="layui-colla-title">方案内容</h2>\n' +
						'    <div class="layui-colla-content layui-show plan_base_info">' +
						'       <form class="layui-form" id="baseForm2" lay-filter="formTest">' +
						/* region 第一行 */
						'           <div class="layui-row">' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">单据号<span field="documnetNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="documnetNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="text" name="projectName" id="projectName2" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">技术方案名称<span field="technicalName" class="field_required">*</span></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="text" name="technicalName"  autocomplete="off" class="layui-input">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">方案类型<span field="schemeType" class="field_required">*</span></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       	<select class="schemeType" name="schemeType" ></select>\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'           </div>' ,
							'<div class="layui-row">' +
							'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
							'                   <div class="layui-form-item">\n' +
							'                       <label class="layui-form-label form_label">方案概述<span field="schemeSummary" class="field_required">*</span></label>\n' +
							'                       <div class="layui-input-block form_block">\n' +
							' 							<textarea type="text" name="schemeSummary" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
							'                       </div>\n' +
							'                   </div>' +
							'               </div>' +
							'</div>',
							'           <div class="layui-row">' +
							'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
							'                   <div class="layui-form-item">\n' +
							'                       <label class="layui-form-label form_label">附件<span field="attachmentId" class="field_required">*</span></label>' +
							'                       <div class="layui-input-block form_block">' +
							'<div class="file_module">' +
							'<div id="_fileContent" class="file_content"></div>' +
							'<div class="file_upload_box">' +
							// '<a href="javascript:;" class="open_file">' +
							// '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
							// '<input type="file" multiple id="fileupload" data-url="/upload?module=technologyScheme" name="file">' +
							// '</a>' +
							// '<div class="progress" id="progress">' +
							// '<div class="bar"></div>\n' +
							// '</div>' +
							'<div class="bar_text"></div>' +
							'</div>' +
							'</div>' +
							'                       </div>\n' +
							'                   </div>' +
							'               </div>' +
							'           </div>',
							/* endregion */
							'       </form>' +
							'    </div>\n' +
							'  </div>\n' +
							/* endregion */
							'  <div class="layui-colla-item">\n' +
							'    <h2 class="layui-colla-title">方案主要内容</h2>\n' +
							'    <div class="layui-colla-content layui-show">' +
							'		<table id="detailed_Table" lay-filter="detailed_Table"></table>' +
							'    </div>\n' +
							'  </div>\n' +
							'  <div class="layui-colla-item">\n' +
							'    <h2 class="layui-colla-title">策划要求</h2>\n' +
							'    <div class="layui-colla-content layui-show objectives_Table">' +
							'		<table id="objectives_Table" lay-filter="objectives_Table"></table>' +
							'    </div>\n' +
							'  </div>\n' +
							/* endregion */
							'</div>'].join(''),
						success: function () {

							//方案类型
							var $select1 = $("baseForm2 .schemeType");
							var optionStr = '<option value="">请选择</option>';
							optionStr += dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['str']
							$select1.html(optionStr);

							// fileuploadFn('#fileupload', $('#fileContent'));
							//回显项目名称
							getProjName('#projectName2',_data.projectId)

							//回显数据
							form.val("formTest", _data);
							$('input[name="documnetNo"]', $('#baseForm2')).val(_data.documnetNo);
							//附件
							if (_data.attachmentList && _data.attachmentList.length > 0) {
								var fileArr = _data.attachmentList;
								$('#_fileContent').append(echoAttachment(fileArr));
							}

							//方案主要内容
							var cols = [
								{type: 'numbers', title: '序号'},
								{
									field: 'mainSchemeName', title: '名称', minWidth: 150, templet: function (d) {
										return '<input technologyId="' + (d.technologyId || '') + '" mainSchemeId="'+(d.mainSchemeId || '')+'" type="text" name="mainSchemeName" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeName || '') + '">'
									}
								},
								{
									field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
										return '<input type="text" name="mainSchemeContent" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
									}
								},
								{
									field: 'completedUser', title: '完成人', minWidth: 160, templet: function (d) {
										return '<input type="text" name="completedUser" class="layui-input" style="height: 100%;" value="' + (d.completedUser || '') + '">'
									}
								}
							]
							//策划要求
							var cols2 = [
								{type: 'numbers', title: '序号'},
								{
									field: 'technical', title: '技术方案', minWidth: 140, templet: function (d) {
										return '<span technologyId="' + (d.technologyId || '') + '" planAskId="'+(d.planAskId || '')+'" planningTechnologyId="'+(d.planningTechnologyId || '')+'" class="technical">' + (d.technical || '') + '</span>'
									}
								},
								{field: 'technologyScheme', title: '方案描述', minWidth: 140},
								{field: 'importanceLevel', title: '重要级别', minWidth: 140},
								{
									field: 'projectUser', title: '项目责任人', minWidth: 140, templet: function (d) {
										return '<span projectUser="' + (d.projectUser || '') + '" class="projectUser">' + (d.projectUserName || '') + '</span>'
									}
								},
								{
									field: 'companyUser', title: '公司责任人', minWidth: 140, templet: function (d) {
										return '<span companyUser="' + (d.companyUser || '') + '" class="companyUser">' + (d.companyUserName || '') + '</span>'
									}
								},
								{field: 'plannedCompletionTime', title: '计划完成时间', minWidth: 160},
								{field: 'fruitAsk', title: '成果物要求', minWidth: 150},
								{
									field: 'isFinish', title: '是否已完成', minWidth: 150, templet: function (d) {
										return '<select name="isFinish">' +
												'<option value="">请选择</option>' +
												'<option value="0" '+(d.isFinish=='0'?'selected':'')+'>是</option>' +
												'<option value="1" '+(d.isFinish=='1'?'selected':'')+'>否</option>' +
												'</select>'
									}
								}
							]

							table.render({
								elem: '#detailed_Table',
								data: _data&&_data.schemeDetailList||[],
								height: _data&&_data.schemeDetailList&&_data.schemeDetailList.length>5?'full-350':false,
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols],
							});

							table.render({
								elem: '#objectives_Table',
								data: _data&&_data.schemeLists||[],
								height: _data&&_data.schemeLists&&_data.schemeLists.length>5?'full-350':false,
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols2],
							});


							$('._disabled2 [name]').attr('disabled', 'disabled');
							$('#baseForm2 .refresh_no_btn').hide();
							$('#baseForm2 .file_upload_box').hide()
							$('#baseForm2 .deImgs').hide();


							element.render();
							form.render();
						},
						yes: function (index) {
							layer.close(index);
						}
					});
					layer.close(loadIndex);
				});

			});

		})
	}

	/**
	 * 获取子表数据
	 */
	function planningDetailsData() {
		//遍历表格获取每行数据
		//交底主要内容
		var $trs = $('.project_objectives').find('.layui-table-main tr');
		var dataArr = [];
		$trs.each(function () {
			var dataObj = {
				disclosureId: $(this).find('input[name="mainSchemeName"]').attr('disclosureId') || '',
				mainSchemeId: $(this).find('input[name="mainSchemeName"]').attr('mainSchemeId') || '',
				mainSchemeName: $(this).find('input[name="mainSchemeName"]').val(),
				mainSchemeContent: $(this).find('input[name="mainSchemeContent"]').val(),
				responsibilityUser: $(this).find('input[name="responsibilityUser"]').val()
			}
			dataArr.push(dataObj);
		});


		return {
			scheduleData: dataArr
		}
	}




	function childFunc() {
		if('0'!=_disabled){
			return true
		}
		var datas = $('#baseForm').serializeArray();
		var obj = {}
		datas.forEach(function (item) {
			obj[item.name] = item.value
		});

		obj.technologyId = $('#technicalName').attr('technologyId')||''

		obj.projectId = data.projectId;


		if(type == '1'){
			obj.disclosureId= data.disclosureId;
		}

		// 附件
		var attachment2Id = '';
		var attachmen2Name = '';
		for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
			attachment2Id += $('#fileContent2 .dech').eq(i).find('input').val();
			attachmen2Name += $('#fileContent2 .dech').eq(i).find("a").eq(0).attr('name');
		}
		obj.attachment2Id = attachment2Id;
		obj.attachmen2Name = attachmen2Name;

		// 附件
		var attachment3Id = '';
		var attachment3Name = '';
		for (var i = 0; i < $('#fileContent3 .dech').length; i++) {
			attachment3Id += $('#fileContent3 .dech').eq(i).find('input').val();
			attachment3Name += $('#fileContent3 .dech').eq(i).find("a").eq(0).attr('name');
		}
		obj.attachment3Id = attachment3Id;
		obj.attachment3Name = attachment3Name;

		// 附件
		var attachment4Id = '';
		var attachment4Name = '';
		for (var i = 0; i < $('#fileContent4 .dech').length; i++) {
			attachment4Id += $('#fileContent4 .dech').eq(i).find('input').val();
			attachment4Name += $('#fileContent4 .dech').eq(i).find("a").eq(0).attr('name');
		}
		obj.attachment4Id = attachment4Id;
		obj.attachment4Name = attachment4Name;

		// 附件
		var attachment5Id = '';
		var attachment5Name = '';
		for (var i = 0; i < $('#fileContent5 .dech').length; i++) {
			attachment5Id += $('#fileContent5 .dech').eq(i).find('input').val();
			attachment5Name += $('#fileContent5 .dech').eq(i).find("a").eq(0).attr('name');
		}
		obj.attachment5Id = attachment5Id;
		obj.attachment5Name = attachment5Name;

		obj.disclosureLists = planningDetailsData().scheduleData

		// 判断必填项
		var requiredFlag = false;
		$('#baseForm').find('.field_required').each(function(){
			var field = $(this).attr('field');
			if (!obj[field]) {
				var fieldName = $(this).parent().text().replace('*', '');
				layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
				requiredFlag = true;
			}
		});
		if (requiredFlag) {
			return true;
		}
		var loadIndex = layer.load();


		var _flag = false;

		$.ajax({
			url: '/technologyDisclosure/updateById',
			data:JSON.stringify(obj),
			// data: obj ,
			dataType: 'json',
			contentType: "application/json;charset=UTF-8",
			type: 'post',
			success: function (res) {
				layer.close(loadIndex);
				if (res.flag) {
					layer.msg('保存成功！', {icon: 1});
					/*layer.close(index);
                    tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();*/
				} else {
					layer.msg(res.msg, {icon: 2});
					_flag = true
				}
			}
		});

		if(_flag){
			return false;
		}
		return true;

	}


</script>
</body>
</html>
