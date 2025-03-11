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
	<title>流程业务表单管理</title>

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
	<script type="text/javascript" src="/js/planother/workSetting.js?20220223"></script>

	<style>

		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
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

		/* region 右侧样式 */
		.wrap_right {
			position: relative;
			height: 100%;
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

		#baseForm .layui-form-label {
			width: 165px;
			padding: 9px 0;
			font-weight: 600;
		}

		#baseForm .layui-input-block {
			margin-left: 180px;
		}

		#baseForm .layui-input:hover {
			border-color: #2F8AE3 !important;
		}

		#baseForm .layui-input:focus {
			border-color: #2F8AE3 !important;
		}

		#baseForm .layui-form-radio>i:hover, #baseForm .layui-form-radioed>i {
			color: #2F8AE3;
		}

		#flowTree .selected, #editPrcsObj .selected {
			background-color: #fff;
		}

		.form_data_btn {
			position: absolute;
			top: 8px;
			right: 0;
			color: #2F8AE3 !important;
			cursor: pointer;
		}

		.allacti {
			display: inline-block;
			width: 40%;
			max-width: 300px;
			height: 150px;
			margin-right: 20px;
			border: 1px solid #2F8AE3;
			border-radius: 3px;
			overflow: auto;
		}

		.li_item, .module_item {
			text-align: center;
			padding: 2px 5px;
			cursor: pointer;
			line-height: 20px;
		}

		.module_item .del_map {
			color: #f00;
			margin-left: 5px;
		}

		.li_item:hover {
			background-color: #2F8AE3;
			color: #fff;
		}

		.li_item.active {
			background-color: #2F8AE3;
			color: #fff;
		}

		#mapModule {
			position: relative;
			width: 80%;
			max-width: 620px;
			height: 100px;
			border: 1px solid #2F8AE3;
			border-radius: 3px;
			overflow: auto;
		}

	</style>
</head>
<body>
<div class="container">
	<div class="wrapper">
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2">
					<p style="margin-left: 10px">
						<img src="/img/commonTheme/${sessionScope.InterfaceModel}/jiekous.png" style="width: 25px;height: 24px;vertical-align: text-bottom;" alt="">
						<label  style=" font-size: 22px !important; color: #333333;">流程业务表单管理</label>
					</p>
				</div>
<%--				<div class="layui-col-xs2" style="margin-left: 15px;">--%>
<%--					<input type="text" name="stockInDate" placeholder="被罚单位"  readonly autocomplete="off" class="layui-input">--%>
<%--				</div>--%>
<%--				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">--%>
<%--					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>--%>
<%--					&lt;%&ndash;                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>&ndash;%&gt;--%>
<%--				</div>--%>
<%--				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">--%>
<%--					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>--%>
<%--					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>--%>
<%--				</div>--%>
			</div>
			<div style="position: relative">
				<div class="table_box">
					<table id="tableDemo" lay-filter="tableDemo"></table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
<%--		<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>--%>
<%--		<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>--%>
		<%--<div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>--%>
	</div>
</script>



<script type="text/html" id="detailBarDemo">
	<a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn  layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</script>

<script type="text/html" id="toolbarDemoIn">
	<div class="layui-btn-container" style="height: 30px;">
		<a class="layui-btn layui-btn-sm" lay-event="choice">新增</a>
	</div>
</script>
<script type="text/html" id="barDemo">
	<a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>
<script>
	var flowFormExtList = []

	var tableIns = null;
	var tableIns2 = null;
	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable','xmSelect'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var soulTable = layui.soulTable;
		var xmSelect = layui.xmSelect;


		form.render();
		//表格显示顺序
		var colShowObj = {
			formName: {field: 'formNameStr', title: '业务表单名称', minWidth: 140, sort: true, hide: false},
			formType: {field: 'formType', title: '业务表单类型', minWidth: 120, sort: true, hide: false, templet: function (d) {
					switch (d.formType) {
						case '1':
							return '系统内业务表单';
							break;
						case '2':
							return '外部系统业务表单';
							break;
						default:
							return ''
					}
				}},
			formDetailsUrl: {field: 'formDetailsUrl', title: '业务表单详情URL', minWidth: 200, sort: true, hide: false,templet: function (d) {
					return  decodeURIComponent(d.formDetailsUrl);
				}},
			flowName: {field: 'flowNameStr', title: '流程', minWidth: 90, sort: false, hide: false,},
			useFlag: {field: 'useFlag', title: '是否启用', minWidth: 120, sort: true, hide: false,templet: function (d) {
						switch (d.useFlag) {
							case '1':
								return '<span style="color: #09a009;">已启用</span>';
								break;
							case '2':
								return '<span style="color: #ffb100;">未启用</span>';
								break;
							default:
								return '<span style="color: #ffb100;">未启用</span>';
						}
					}},
		}

		var TableUIObj = new TableUI('plb_mtl_stock_in');

		// 获取数据字典数据
		var dictionaryObj = {
			FLOW_SETTING:{}
		}
		var dictionaryStr = 'FLOW_SETTING';
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

		TableUIObj.init(colShowObj,function () {
			tableShow()
		});




		// 上方按钮显示
		table.on('toolbar(tableDemo)', function (obj) {
			var checkStatus = table.checkStatus(obj.config.id);
			var dataTable = table.checkStatus(obj.config.id).data;
			switch (obj.event) {
				case 'add':
					newOrEdit(1);
					break;
				case 'del':
					var ids = ''
					dataTable.forEach(function (v) {
						ids += v.formId + ',';
					});
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.get('/plbWorkSetting/del', {ids: ids}, function (res) {
							if (res.code=='0') {
								// getData();
								tableIns.reload();
								layer.msg('删除成功！', {icon: 1});
								layer.close(index);
							} else {
								layer.msg('删除失败！', {icon: 2});
							}
						});
					});
					break;
			}
		});
		table.on('tool(tableDemo)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent == 'edit') {
				$.get('/plbWorkSetting/getById', {formId: data.formId}, function(res) {
					if (res.code=='0') {
						newOrEdit(2, res.obj);
					} else {
						layer.msg('获取信息失败!', {icon: 2, time: 2000});
					}
				});
			}else if(layEvent == 'del'){
				layer.confirm('确定删除该条数据吗？', function (index) {
					$.get('/plbWorkSetting/del', {ids: data.formId}, function (res) {
						if (res.code=='0') {
							//getData();
							tableIns.reload();
							layer.msg('删除成功！', {icon: 1});
							layer.close(index);
						} else {
							layer.msg('删除失败！', {icon: 2});
						}
					});
				});
			}
		});



		// 内部加行按钮
		table.on('toolbar(detailTable)', function (obj) {
			var data = obj.data;
			switch (obj.event) {
				case 'choice':
					subtable(1)
					break;
			}
		});
		// 内部删行操作
		table.on('tool(detailTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;

			if (layEvent === 'del') {
				//obj.del();
				if (data.formListId) {
					$.get('/plbWorkSetting/delDetails', {ids: data.formListId}, function (res) {
						$.ajax({
							url: '/plbWorkSetting/getFlowExtListByFormId?formId='+flowFormExtList[0].formId,
							dataType: 'json',
							type: 'post',
							success: function (res) {
								// if (res.code=='0') {
								// 	layer.msg('保存成功!', {icon: 1});
								// 	//getData();
								// 	tableIns2.reload();
								// 	layer.close(index);
								// } else {
								// 	layer.msg('保存失败!', {icon: 2});
								// }
								table.reload('detailTable', {
									data: res.data
								});
							}
						});
					});
				}

				/*table.reload('detailTable', {
					data: flowFormExtList
				});*/

			}else if (layEvent === 'edit') {
				subtable(2,data)
			}
		});
		function subtable(type,data){
			var title = ''
			if(type == '1'){
				title = '新增'
			}else if(type=='2'){
				title = '编辑'
			}

			if($("#formName").val()){
				title = $("#formName").val()
				title = dictionaryObj['FLOW_SETTING']['object'][title]
			}

			var url = $('#baseForm input[name="formDetailsUrl"]').val();

			var flowTreeObj = null;
			var editPrcsObj = null;

			var xhr = null;

			layer.open({
				type: 1,
				title: title,
				btn: ['确定','取消'],
				btnAlign: 'c',
				area: ['70%', '80%'],
				maxmin: true,
				content: [
					'<div style="padding: 20px;"><form class="layui-form" id="baseForm2" lay-filter="baseForm2">',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">流程</label>' +
					'                       <div class="layui-input-block">' +
					'                       <div id="flowTree" class="xm-select-demo"></div>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">可编辑节点</label>' +
					'                       <div class="layui-input-block">' +
					'                       <div id="editPrcsObj" class="xm-select-demo"></div>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">流程表单</label>' +
					'                       <div class="layui-input-block" style="padding-bottom: 50px;">' +
					'                       <div class="allacti business"></div>' +
					'                       <div class="allacti processS"></div>' +
					'<button class="add_map" type="button" style="position: absolute; left: 0; bottom: 7px;color:#fff;' +
					'background-color: #ccc;padding: 5px 10px;border-radius: 20px;cursor: pointer">添加映射</button>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">字段映射</label>' +
					'                       <div class="layui-input-block">' +
					'                       <div id="mapModule"></div>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">消息提醒展示字段</label>' +
					'                       <div class="layui-input-block">' +
					'                       <textarea id="smsColumn" name="smsColumn" style="width: 80%;;max-width: 620px;height: 50px;border: 1px solid #2F8AE3;border-radius: 3px;"></textarea>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12">' +
					'                   <div class="layui-form-item">' +
					'                       <div class="layui-input-block">' +
					'							<div class="conForm"></div>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'</form></div>'
				].join(''),
				success: function () {
					if(data){
						form.val('baseForm2', data);
					}
					form.render();
					if(data&&data.flowId){
						$.get('/flowhook/queryFormId', {folwId: data.flowId}, function (res) {
							getFlowData(res.object.formId);
						});
						getPrcsData(data.flowId, true);
					}

					// 获取流程数据
					xhr = $.get('/flow/selOneToAllType', function (res) {
						if (res.flag) {
							var treedata = buildFlowTree(res.datas);

							flowTreeObj = xmSelect.render({
								el: '#flowTree',
								model: {
									label: {
										type: 'text'
									}
								},
								iconfont: {
									parent: 'hidden' // 父节点隐藏图标
								},
								theme: {
									color: '#2F8AE3',
								},
								radio: true,
								filterable: true,
								clickClose: true,
								name: 'flowId',
								tree: {
									show: true,
									strict: false,
									expandedKeys: [-1],
								},
								prop: {
									name: 'name',
									value: 'id'
								},
								data: treedata,
								on: function (data) {
									if (data.isAdd) {
										var arr = data.change.slice(0, 1);
										getFlowData(arr[0].formId);
										getPrcsData(arr[0].id);
										return arr;
									}
								}
							});
							if(data&&data.flowId){
								flowTreeObj.setValue([data.flowId]);
							}
						}
					});

					// 获取节点数据
					function getPrcsData(flowId, flag) {
						$.get('/flowFormExt/showAllPrcsByFlowId', {flowId: flowId}, function (res) {
							editPrcsObj = xmSelect.render({
								el: '#editPrcsObj',
								toolbar: {
									show: true,
								},
								theme: {
									color: '#2F8AE3',
								},
								name: 'editPrcs',
								prop: {
									name: 'prcsName',
									value: 'prcsId'
								},
								data: res.obj
							});

							if (flag) {
								if (data.editPrcs) {
									var editPrcsArr = data.editPrcs.split(',');
									editPrcsObj.setValue(editPrcsArr);
								}
							}
						});
					}
					if(data&&(url||data.dataMap)){
						getFormData(url, data.dataMap);
					}else {
						getFormData(url);
					}

					// 添加映射关系
					$('.add_map').on('click', function () {
						var $business = $('.business').find('.active');
						var $processS = $('.processS').find('.active');
						if ($business.length == 0 || $processS.length == 0) {
							return false;
						}

						var businessObj = {
							key: $business.attr('filed'),
							name: $business.text()
						}

						var processObj = {
							key: $processS.attr('filed'),
							name: $processS.text()
						}

						var mapId = businessObj.key + '_' + processObj.name;

						if ($('#' + mapId).length > 0) {
							return false;
						}

						var mapValue = processObj.name + '=>' + businessObj.key;
						var str = '<div id="' + mapId + '" class="module_item"><span>' + businessObj.name + '-' + processObj.name + '</span><strong class="del_map">x</strong><input type="hidden" value="' + mapValue + '"></div>';

						$('#mapModule').append(str);

						$business.removeClass('active');
						$processS.removeClass('active');
					});
					// 获取流程表单字段
					function getFlowData(formId) {
						var timer = setTimeout(function() {
							workForm.init({formhtmlurl: '/form/formType', resdata: {fromId: formId}, flag: 3}, function (datas) {
								clearTimeout(timer);
								var str = '';
								datas.forEach(function(item) {
									str += '<div class="li_item" filed="' + item.name + '">' + item.title + '</div>';
								});
								$('.processS').html(str);
							}, 0);
						});
					}
					// 获取业务表单字段
					function getFormData(url, dataMap) {
						if (url) {
							url = url.replace(/^\/+/, '');
							$("#newIframe").remove();
							var $iframe = $('<iframe id="newIframe" src=/' + url + ' style="position: absolute;left: 0;bottom: 0;z-index: -9999;visibility: hidden"></iframe>');
							$('body').append($iframe);
							var timer = setTimeout(function () {
								clearTimeout(timer);
								var $baseForm = $("#newIframe").contents().find("#baseForm");
								var obj = {}
								$baseForm.find('[name]').each(function () {
									var type = $(this).attr('type')
									if (type == 'file') {
										return true;
									}
									var key = $(this).attr('name');
									var inpTyp = $(this).attr('type');
									if("hidden"!=inpTyp){
										var name = ($(this).parents('.layui-form-item').find('.layui-form-label').text() || '').replace(/\*$/, '');
										obj[key] = name;
									}
								});
								if (url.indexOf('editClaimForm') > -1) {
									obj.reimbursementDetails = '预算执行明细';
									if (url.indexOf('reimburseType=01') > -1 || url.indexOf('reimburseType=02') > -1) {
										obj.longDistanceCostTotal = '长途交通费合计';
										obj.stayCostsTotal = '住宿费用合计';
										obj.cityCostTotal = '市内交通费合计';
										obj.otherCostTotal = '其他费用合计';
										obj.subsidyAmountTotal = '补助费用合计';
										obj.adjustAmountTotal = '会计调整合计';
										obj.amountIncludingTaxTotal = '报销金额合计(含税)';
										obj.taxAmountTotal = '税额合计';
										obj.anountExcludingTaxTotal = '报销金额合计(不含税)';
									}
								}
								$("#newIframe").remove();
								var str = '';
								$.each(obj, function (k, o) {
									str += '<div class="li_item" filed="' + k + '">' + o + '</div>';
								});
								$('.business').html(str);

								if (dataMap) {
									var mapArr = dataMap.replace(/,$/, '').split(',');
									var str = '';
									mapArr.forEach(function (map) {
										var itemArr = map.split('=>');
										var name = itemArr[0];
										var key = itemArr[1];
										var mapId = key + '_' + name;

										var mapValue = name + '=>' + key;
										str += '<div id="' + mapId + '" class="module_item"><span>' + obj[key] + '-' + name + '</span><strong class="del_map">x</strong><input type="hidden" value="' + mapValue + '"></div>';
									});
									$('#mapModule').html(str);
								}

								var $trs = $('.business').find('div');
								var _str = '';
								$trs.each(function (index,value) {
									if($(this).text()){
										if((index+1)%3==0){
											_str+='<span>'+$(this).text()+':{'+$(this).attr('filed')+'}</span><br>'
										}else {
											_str+='<span style="margin-right: 40px">'+$(this).text()+':{'+$(this).attr('filed')+'}</span>'
										}
									}
								});
								$('.conForm').append(_str)

							}, 1000);
						}
					}
					form.render();
				},
				yes: function (index,layero) {
					var obj = {}
					var dataObj={}

					//主表
					var baseForm2 = $('#baseForm').serializeArray();
					baseForm2.forEach(function (item) {
						dataObj[item.name] = item.value;
					});

					dataObj.formDetailsUrl = encodeURIComponent(dataObj.formDetailsUrl);
					dataObj.formEditUrl = encodeURIComponent(dataObj.formEditUrl);
					dataObj.formRestful = encodeURIComponent(dataObj.formRestful);

					// 基本信息
					var baseForm = $('#baseForm2').serializeArray();
					baseForm.forEach(function (item) {
						obj[item.name] = item.value;
					});
					obj.flowNameStr = $('#flowTree .scroll').text()
					var dataMap = '';
					$('#mapModule').find('input').each(function () {
						dataMap += $(this).val() + ',';
					});
					obj.dataMap = dataMap;
					//obj.smsColumn = $('#smsColumn').val()||'';
					// if(data&&data.flowId){
					// 	obj.flowId = data.flowId;
					// }
					if(data&&data.formListId){
						obj.formListId = data.formListId;
					}
					//flowFormExtList.push(obj)

					dataObj.flowFormExtList = obj

					var _url = ''

					if ((data&&data.formId)||$('#baseForm').attr('formId')) {
						if(data&&data.formId){
							dataObj.formId = data&&data.formId
						}else if($('#baseForm').attr('formId')){
							dataObj.formId = $('#baseForm').attr('formId')
						}
						_url = '/plbWorkSetting/update';
					}else {
						_url = '/plbWorkSetting/insert';
					}

					$.ajax({
						url: _url,
						data: JSON.stringify(dataObj),
						dataType: 'json',
						contentType: "application/json;charset=UTF-8",
						type: 'post',
						success: function (res) {
							if (res.code=='0') {
								layer.msg('保存成功!', {icon: 1});
								//getData();
								//tableIns2.reload();
								table.reload('detailTable', {
									data: res.object.flowFormExtList
								});
								layer.close(index);
							} else {
								layer.msg('保存失败!', {icon: 2});
							}
						}
					});
					// layer.close(index);
					// table.reload('detailTable', {
					// 	data: flowFormExtList
					// });
				},
				end: function () {
					// 关闭请求
					xhr.abort();
				}
			})
		}

		$(document).on('click', '.del_map', function() {
			$(this).parent().remove();
		});

		$(document).on('click', '.li_item', function() {
			$(this).addClass('active').siblings().removeClass('active');
		});

		function newOrEdit (type, data) {
			var title = '';
			var url = '';
			flowFormExtList = []
			if (type == 1) {
				title = '新增';
				url = '/plbWorkSetting/insert';
			} else if (type == 2) {
				title = '编辑';
				url = '/plbWorkSetting/update';
				flowFormExtList = data.flowFormExtList?data.flowFormExtList:[];
			}

			layer.open({
				type: 1,
				title: title,
				area: ['80%', '90%'],
				btn: ['保存', '取消'],
				btnAlign: 'c',
				content: [
					'<div style="padding: 20px;"><form class="layui-form" id="baseForm" lay-filter="baseForm">',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">业务表单名称<span style="color: #f00; margin-left: 2px;">*</span></label>' +
					'                       <div class="layui-input-block">' +
					'							<select id="formName" name="formName"  lay-filter="test"></select>' +
					// '                       <input type="text" name="formName" autocomplete="off" class="layui-input">' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">业务表单类型<span style="color: #f00; margin-left: 2px;">*</span></label>' +
					'                       <div class="layui-input-block">' +
					'                       <select name="formType">' +
					'                       <option value="1">系统内业务表单</option>' +
					'                       <option value="2">外部系统业务表单</option>' +
					'						</select>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">是否启用</label>' +
					'                       <div class="layui-input-block">' +
					'                       <input type="radio" name="useFlag" value="1" title="是" checked>' +
					'                       <input type="radio" name="useFlag" value="0" title="否">' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">业务表单详情URL<span style="color: #f00; margin-left: 2px;">*</span></label>' +
					'                       <div class="layui-input-block"">' +
					'                       <input type="text" name="formDetailsUrl" autocomplete="off" class="layui-input">' +
					// '                       <a title="获取业务表单字段" class="form_data_btn"><i class="layui-icon layui-icon-templeate-1"></i></a>' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">详情URL密钥</label>' +
					'                       <div class="layui-input-block">' +
					'                       <input type="text" name="formDetailsUrlSecret" autocomplete="off" class="layui-input">' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">业务表单编辑URL</label>' +
					'                       <div class="layui-input-block">' +
					'                       <input type="text" name="formEditUrl" autocomplete="off" class="layui-input">' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">编辑URL密钥</label>' +
					'                       <div class="layui-input-block">' +
					'                       <input type="text" name="formEditUrlSecret" autocomplete="off" class="layui-input">' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs6">' +
					'                   <div class="layui-form-item">' +
					'                       <label class="layui-form-label">业务表单字段Restful接口</label>' +
					'                       <div class="layui-input-block">' +
					'                       <input type="text" name="formRestful" autocomplete="off" class="layui-input">' +
					'                       </div>' +
					'                   </div>' +
					'               </div>'+
					'           </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12">' +
					'		<table id="detailTable" lay-filter="detailTable"></table>' +
					'               </div>'+
					'			</div>' +
					'</form></div>'
				].join(''),
				success: function () {
					$('#baseForm').attr('formId',data&&data.formId)

					//渲染业务表单名称
					var $select1 = $("#formName");
					var optionStr = '<option value="">请选择</option>';
					optionStr += dictionaryObj['FLOW_SETTING']['str']
					$select1.html(optionStr);

					form.render();

					form.on('select(test)', function(data){
						console.log(data.value); //得到被选中的值
						$('#baseForm input[name="formDetailsUrl"]').val(decodeURIComponent(workSetting[data.value])||'');
					});

					if (type == 2) {
						//$("#formName").val(data.formName||'')
						data.formDetailsUrl = decodeURIComponent(data.formDetailsUrl);
						data.formEditUrl = decodeURIComponent(data.formEditUrl);
						data.formRestful = decodeURIComponent(data.formRestful);
						form.val('baseForm', data);
					}

					var cols = [
						{type: 'numbers', title: '序号'},
						{field: 'flowNameStr', title: '流程', minWidth: 100},
						{field: 'dataMap', title: '字段映射', minWidth: 160},
						{field: 'smsColumn', title: '消息提醒字段', minWidth: 160},
						{align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100}
					]

					 tableIns2 = table.render({
						elem: '#detailTable',
						data: flowFormExtList||[],
						toolbar: '#toolbarDemoIn',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols],
						done:function(res,curr,count){
							flowFormExtList = res.data
						}
					});

				},
				yes: function (index) {
					var dataObj = {}
					// 基本信息
					var baseForm = $('#baseForm').serializeArray();
					baseForm.forEach(function (item) {
						dataObj[item.name] = item.value;
					});

					dataObj.formDetailsUrl = encodeURIComponent(dataObj.formDetailsUrl);
					dataObj.formEditUrl = encodeURIComponent(dataObj.formEditUrl);
					dataObj.formRestful = encodeURIComponent(dataObj.formRestful);

					dataObj.flowFormExtList = flowFormExtList

					if (type == 2) {
						dataObj.formId = data.formId;
						_url = '/plbWorkSetting/update';
					}else {
						if (flowFormExtList&&flowFormExtList[0]&&flowFormExtList[0].formId) {
							dataObj.formId = flowFormExtList[0].formId;
							_url = '/plbWorkSetting/update';
						}else {
							_url = '/plbWorkSetting/insert';
						}
					}



					$.ajax({
						url: url,
						data: JSON.stringify(dataObj),
						dataType: 'json',
						contentType: "application/json;charset=UTF-8",
						type: 'post',
						success: function (res) {
							if (res.code=='0') {
								layer.msg('保存成功!', {icon: 1});
								//getData();
								tableIns.reload();
								layer.close(index);
							} else {
								layer.msg('保存失败!', {icon: 2});
							}
						}
					});
					// $.post(url, dataObj, function(res) {
					// 	if (res.code=='0') {
					// 		if (res.msg == 'ok') {
					// 			layer.msg('保存成功!', {icon: 1});
					// 			getData();
					// 			layer.close(index);
					// 		} else {
					// 			layer.msg(res.msg, {icon: 0});
					// 		}
					// 	} else {
					// 		layer.msg('保存失败!', {icon: 2});
					// 	}
					// });
				},
				btn2: function (index) {
					tableIns.reload();
				}
			});
		}


		// 渲染表格
		function tableShow() {
			var cols = [{checkbox: true}].concat(TableUIObj.cols)

			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#detailBarDemo',
				title: '操作',
				minWidth: 120,
			})

			tableIns = table.render({
				elem: '#tableDemo',
				url: '/plbWorkSetting/select',
				toolbar: '#toolbarDemo',
				cols: [cols],
				defaultToolbar: ['filter'],
				// height: 'full-80',
				page: {
					limit: TableUIObj.onePageRecoeds,
					limits: [10, 20, 30, 40, 50]
				},
				where: {
					useFlag: true
				},
				autoSort: false,
				// parseData: function (res) { //res 即为原始返回的数据
				//     return {
				//         "code": 0, //解析接口状态
				//         "data": res.obj, //解析数据列表
				//         "count": res.totleNum, //解析数据 长度
				//     };
				// },
				/*request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },*/
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


		//点击查询
		$('.searchData').click(function () {
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
	})
	function buildFlowTree(treeData) {
		var arr = []
		if (treeData && treeData.length > 0) {
			treeData.forEach(function (item) {
				var obj = {
					name: item.sortName,
					id: 'sort' + item.sortId
				}

				if (item.childs.length == 0 && item.flowTypeModels.length == 0){
					obj.disabled = true
				} else {
					obj.children = []

					if (item.flowTypeModels.length > 0) {
						item.flowTypeModels.forEach(function(flow){
							var flowObj = {
								id: flow.flowId,
								formId: flow.formId,
								name: flow.flowName
							}

							obj.children.push(flowObj);
						});
					}

					if (item.childs.length > 0) {
						obj.children = obj.children.concat(buildFlowTree(item.childs));
					}
				}

				arr.push(obj);
			});
		}
		return arr;
	}

</script>
<script src="/js/workflow/work/workform.js"></script>
</body>
</html>
