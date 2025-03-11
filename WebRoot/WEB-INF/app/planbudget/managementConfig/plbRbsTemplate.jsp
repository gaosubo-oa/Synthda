<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-07-12
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>RBS模板</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
	<script type="text/javascript" src="/js/planbudget/common.js?20210616.1"></script>

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
			padding: 10px 0;
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

		.button_box {
			text-align: center;
		}

		.list_module {
			position: absolute;
			top: 40px;
			right: 0;
			bottom: 0;
			left: 0;
			overflow: auto;
		}

		.list_item {
			position: relative;
			height: 32px;
			line-height: 32px;
			padding: 0 20px;
			cursor: pointer;
		}

		.list_item.active {
			background-color: #d6f3ff;
		}

		.list_item.active:before {
			position: absolute;
			top: 0;
			left: 0;
			content: "";
			height: 100%;
			width: 5px;
			background-color: #3f73c4;
		}

		.list_item:hover {
			background-color: #d6f3ff;
		}

		.list_item:hover:before {
			position: absolute;
			top: 0;
			left: 0;
			content: "";
			height: 100%;
			width: 5px;
			background-color: #3f73c4;
		}

		.wrap_right {
			position: relative;
			height: 100%;
			margin-left: 230px;
			padding-left: 10px;
			box-sizing: border-box;
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

		.refresh_no_btn,.refresh_sort_btn{
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}

		.layui-select-disabled .layui-disabled {
			color: #222 !important;
		}

		.export_moudle {
			display: none;
			position: absolute;
			top: 100%;
			right: 0;
			width: 120px;
			padding: 10px;
			background-color: #fff;
			text-align: left;
			color: #222;
			box-shadow: 0 0px 1px 0px rgb(0 0 0 / 50%);
			opacity: 1 !important;
		}

		.export_moudle > p:hover {
			cursor: pointer;
			color: #1E9FFF;
		}
	</style>
</head>
<body>
<div class="container">
	<div class="wrapper">
		<div class="query_module layui-form layui-row" style="position: relative">
			<div class="layui-col-xs2">
				<input type="text" name="rbsItemNo" placeholder="RBS编号" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-col-xs2" style="margin-left: 15px;">
				<input type="text" name="rbsItemName" placeholder="RBS名称" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-col-xs2" style="margin-left: 15px;">
				<input type="text" name="cbsName" placeholder="CBS名称" autocomplete="off" class="layui-input">
			</div>
			<div class="layui-col-xs2" style="margin: 3px 0 0 10px;text-align: left">
				<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
				<button type="button" class="layui-btn layui-btn-sm" id="">高级查询</button>
			</div>
			<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
				<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
				<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
			</div>
		</div>
		<table id="tableObj" lay-filter="tableObj"></table>
	</div>
</div>

<script type="text/html" id="toolbarHead">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm " lay-event="add">新增</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
			<img src="/img/planCheck/导入.png"style="width: 20px;height: 20px;margin-top: -4px;">导入
		</button>
		<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
			<img src="/img/planCheck/导出.png"style="width: 20px;height: 20px;margin-top: -4px;">导出
		</button>
		<div class="export_moudle">
			<p class="export_btn" type="1">导出所选数据</p>
			<p class="export_btn" type="2">导出当前页数据</p>
			<p class="export_btn" type="3">导出全部数据</p>
		</div>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
	// 表格显示顺序
	var colShowObj = {
		rbsItemNo: {field: 'rbsItemNo', title: 'RBS编号', minWidth: 120, sort: true, hide: false},
		rbsItemName: {field: 'rbsItemName', title: 'RBS名称', minWidth: 120, sort: true, hide: false},
		cbsId: {
			field: 'cbsId', title: 'CBS', minWidth: 120, sort: true, hide: false, templet: function (d) {
				return d.cbsName || '';
			}
		},
		explains: {field: 'explains', title: '说明', minWidth: 120, sort: true, hide: false},
		enableYn: {
			field: 'enableYn', title: '是否启用', minWidth: 120, sort: true, hide: false, templet: function (d) {
				return d.enableYn == '0' ? '是' : '否';
			}
		},
		requiredYn: {
			field: 'requiredYn', title: '是否必选', minWidth: 120, sort: true, hide: false, templet: function (d) {
				return d.requiredYn == '1' ? '是' : '否';
			}
		},
		budgetoccupy:{
			field:'budgetoccupy',title:'是否占用',minWidth:120,sort:true,hide:false,templet:function(d){
				return d.budgetoccupy == '0' ? '是' : '否';
			}
		}
	}

	var TableUIObj = new TableUI('plb_rbs_item');

	var dictionaryObj = {
		RBS_TYPE: {},
		RBS_CATEGORY: {},
		RBS_TEMPLATE: {}
	}
	var dictionaryStr = 'RBS_TYPE,RBS_CATEGORY,RBS_TEMPLATE';
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
		layui.use(['form', 'laydate', 'table', 'soulTable', 'xmSelect', 'eleTree'], function () {
			var layForm = layui.form,
					laydate = layui.laydate,
					layTable = layui.table,
					xmSelect = layui.xmSelect,
					eleTree = layui.eleTree,
					soulTable = layui.soulTable;
			$('.query_module [name="rbsItemType"]').append(dictionaryObj['RBS_TYPE']['str']);
			layForm.render();

			var tableObj = null;

			// 监听排序事件
			layTable.on('sort(tableObj)', function (obj) {
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
			layForm.on('checkbox()', function (data) {
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
			// 监听列表头部按钮事件
			layTable.on('toolbar(tableObj)', function (obj) {
				var checkStatus = layTable.checkStatus(obj.config.id);
				var leftTree=null
				switch (obj.event) {
					case 'add':
						addOrEdit(1)
						break;
					case 'del': // 删除
						if (checkStatus.data.length == 0) {
							layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
							return false;
						}

						var rbsItemIds = '';

						checkStatus.data.forEach(function (item) {
							rbsItemIds += item.rbsItemId + ',';
						});

						layer.confirm('确定删除该条数据吗？', function (index) {
							$.post('/plbRbsItem/delete', {rbsItemIds: rbsItemIds}, function (res) {
								layer.close(index)
								if (res.flag) {
									layer.msg('删除成功！', {icon: 1});
									tableObj.config.where._ = new Date().getTime();
									tableObj.reload();
								} else {
									layer.msg('删除失败！', {icon: 2});
								}
							});
						});

						break;
					case 'import':
						var parentIds=''
						var currentId=''
						layer.open({
							type: 1,
							title: '导入RBS项',
							area: ['100%', '100%'],
							btn: ['确定', '取消'],
							btnAlign: 'c',
							content: '<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>',
							success: function(){
								leftTree = eleTree.render({
									elem: '#leftTree',
									url:'/plbRbs/selectAll?'+'&_='+new Date().getTime(),
									highlightCurrent: true,
									showLine: true,
									showCheckbox: true,
									lazy:true,
									request: {
										key: 'rbsId',
										name: 'rbsName',
										children: "childList",
									},
									response: {
										statusName: 'flag',
										statusCode: true,
										dataName: "data"
									},
									load: function(data,callback) {
										$.post('/plbRbs/selectAll?parentId='+data.rbsId,function (res) {
											callback(res.data);//点击节点回调
										})
									},
								});
								// 树节点点击事件
								eleTree.on("nodeClick(leftTree)", function (d) {
									currentId=d.data.currentData.rbsId+','
									parentIds=''
									//获取父节点集合
									$(d.node[0]).parents('.eleTree-node').each(function () {
										parentIds+=$(this).attr('data-rbs-id')+','
									})
									// console.log(parentIds);
								});
							},
							yes: function(index) {
								var rbsIdsArr=leftTree.getChecked(true, false)
								if (rbsIdsArr.length > 0) {
									var plbdictno = '01';
									var rbsIds=''
									rbsIdsArr.forEach(function (item) {
										rbsIds += item.rbsId+','
									})
									$.post('/plbRbsItem/insert', {rbsIds: rbsIds, rbsTypeId: plbdictno}, function (res) {
										if (res.flag) {
											layer.msg('导入成功!', {icon: 1});
											layer.close(index);
											tableInit();
										} else {
											layer.msg('导出失败!', {icon: 2});
										}
									})
								} else {
									layer.msg('请选择需要导入的数据且只能选择节点末节点!', {icon: 0});
								}
							}
						})
						break;
					case 'export': // 导出
						$('.export_moudle').show();
						break;
				}
			});
			layTable.on('tool(tableObj)', function (obj) {
				var data = obj.data;
				var layEvent = obj.event;
				if (layEvent === 'detail') {
					$.get('/plbRbsItem/selectByRbsItemId', {rbsItemId: data.rbsItemId}, function (res) {
						if (res.flag) {
							addOrEdit(3, res.data);
						} else {
							layer.msg('获取信息失败！', {icon: 0});
						}
					});
				} else if (layEvent === 'edit') {
					// 获取rbs项信息
					$.get('/plbRbsItem/selectByRbsItemId', {rbsItemId: data.rbsItemId}, function (res) {
						if (res.flag) {
							addOrEdit(2, res.data);
						} else {
							layer.msg('获取信息失败！', {icon: 0});
						}
					});
				}
			});

			TableUIObj.init(colShowObj, function () {
				tableInit();
			});

			/**
			 * 加载表格方法
			 */
			function tableInit() {
				var searchObj = getSearchObj();
				searchObj.useFlag = true;
				searchObj.rbsTypeId = '';
				searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
				searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;
				searchObj.versionNumber='1'

				var cols = [{checkbox: true}].concat(TableUIObj.cols);

				cols.push({
					fixed: 'right',
					align: 'center',
					toolbar: '#toolBar',
					title: '操作',
					width: 140
				});

				var option = {
					elem: '#tableObj',
					url: '/plbRbsItem/selectAll',
					toolbar: '#toolbarHead',
					cols: [cols],
					defaultToolbar: ['filter'],
					height: 'full-80',
					page: {
						limit: TableUIObj.onePageRecoeds,
						limits: [10, 20, 30, 40, 50]
					},
					where: searchObj,
					autoSort: false,
					response: {
						statusName: 'flag',
						statusCode: true,
						msgName: 'msg',
						countName: 'totleNum',
						dataName: 'data'
					},
					done: function () {
						//增加拖拽后回调函数
						soulTable.render(this, function () {
							TableUIObj.dragTable('tableObj');
						});

						if (TableUIObj.onePageRecoeds != this.limit) {
							TableUIObj.update({onePageRecoeds: this.limit});
						}
					}
				}

				if (TableUIObj.orderbyFields) {
					option.initSort = {
						field: TableUIObj.orderbyFields,
						type: TableUIObj.orderbyUpdown
					}
				}

				tableObj = layTable.render(option);
			}

			/**
			 * 新增、编辑方法
			 * @param type 类型(1-新增，2-编辑, 3-查看详情)
			 * @param data 编辑时的信息
			 */
			function addOrEdit(type, data) {
				var title = '';
				var url = '';
				var btnArr = ['保存', '取消'];
				if (type == 1) {
					title = '新增项目';
					url = '/plbRbsItem/insertRbsItem';
				} else if (type == 2) {
					title = '编辑项目';
					url = '/plbRbsItem/update';
				} else if (type == 3) {
					title = '查看详情';
					btnArr = [];
				}
				var cbsSelectTree = null;
				var rbsSelectTree = null
				layer.open({
					type: 1,
					title: title,
					area: ['100%', '100%'],
					btn: btnArr,
					btnAlign: 'c',
					content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
						'<form class="layui-form" id="baseForm" lay-filter="baseForm">',
						/* region 第一行 */
						'<div class="layui-row">' +
						'<div class="layui-col-xs6" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">RBS编号<span field="rbsItemNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
						'<div class="layui-input-block form_block">' +
						'<input type="text" readonly name="rbsItemNo" autocomplete="off" class="layui-input">' +
						'</div>' +
						'</div>' +
						'</div>',
						'<div class="layui-col-xs6" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">RBS名称<span field="rbsItemName" class="field_required">*</span></label>' +
						'<div class="layui-input-block form_block">' +
						'<input type="text" name="rbsItemName" autocomplete="off" class="layui-input">' +
						'</div>' +
						'</div>' +
						'</div>',
						'</div>',
						/* endregion */
						/* region 第二行 */
						'<div class="layui-row">' +
						'<div class="layui-col-xs6" style="padding: 0 5px">' +
						'<div class="layui-form-item" style="position: relative">' +
						'<label class="layui-form-label form_label">RBS类型<span field="rbsTypeName" class="field_required">*</span></label>' +
						'<div class="layui-input-block form_block">' +
						'<textarea type="text" name="rbsTypeName" id="showTableDialogId" autocomplete="off" class="layui-input" style="width: 90%;position: absolute"></textarea>' +
						'<button type="button" id="clear" class=" layui-btn layui-btn-sm" style="position:absolute;left: 92%;top: 4px">清空</button>'+
						'</div>' +
						'</div>' +
						'</div>',
						'<div class="layui-col-xs6" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">CBS</label>' +
						'<div class="layui-input-block form_block">' +
						'<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
						'</div>' +
						'</div>' +
						'</div>',
						'</div>',
						/* endregion */
						/* region 第二行 */
						'<div class="layui-row">' +
						'<div class="layui-col-xs4" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">是否启用<span field="enableYn" class="field_required">*</span></label>' +
						'<div class="layui-input-block form_block">' +
						'<input type="radio" name="enableYn" value="0" title="否">' +
						'<input type="radio" name="enableYn" value="1" title="是" checked>' +
						'</div>' +
						'</div>' +
						'</div>',
						'<div class="layui-col-xs4" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">是否必选<span field="requiredYn" class="field_required">*</span></label>' +
						'<div class="layui-input-block form_block">' +
						'<input type="radio" name="requiredYn" value="0" title="否">' +
						'<input type="radio" name="requiredYn" value="1" title="是" checked>' +
						'</div>' +
						'</div>' +
						'</div>',
						'<div class="layui-col-xs4" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">是否占用<span field="budgetoccupy" class="field_required">*</span></label>' +
						'<div class="layui-input-block form_block">' +
						'<input type="radio" name="budgetoccupy" value="1" title="否">' +
						'<input type="radio" name="budgetoccupy" value="0" title="是" checked>' +
						'</div>' +
						'</div>' +
						'</div>',
						'</div>',
						/* endregion */
						/* region 第三行 */
						'<div class="layui-row">' +
						'<div class="layui-col-xs12" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">说明</label>' +
						'<div class="layui-input-block form_block">' +
						'<textarea name="explains" class="layui-textarea"></textarea>' +
						'</div>' +
						'</div>' +
						'</div>',
						'</div>',
						/* endregion */
						/* region 第四行 */
						'<div class="layui-row">' +
						'<div class="layui-col-xs12" style="padding: 0 5px">' +
						'<div class="layui-form-item">' +
						'<label class="layui-form-label form_label">备注</label>' +
						'<div class="layui-input-block form_block">' +
						'<textarea name="remarks" class="layui-textarea"></textarea>' +
						'</div>' +
						'</div>' +
						'</div>',
						'</div>',
						/* endregion */
						'</form>',
						'</div>'].join(''),
					success: function () {
						$('select[name="rbsItemType"]', $('#baseForm')).html(dictionaryObj['RBS_TYPE']['str']);
						$('select[name="rbsItemCategory"]', $('#baseForm')).html(dictionaryObj['RBS_CATEGORY']['str']);
						$('#clear').click(function(){
							$('#showTableDialogId').attr('mtlLibId','')
							$('#showTableDialogId').val('')
						})
						// getParentTree('', function(rbsData) {
						//     var rbsTreeData = xmSelect.render({
						//         el: '#rbsItemTypeTree',
						//         radio: true,
						//         clickClose: true,
						//         name: 'rbsType',
						//         disabled: type == 3,
						//         tree: {
						//             show: true,
						//             strict: false,
						//             expandedKeys: [-1],
						//             lazy: true,
						//             load: function(item, cb){
						//                 getParentTree(item.rbsId, function(data) {
						//                     cb(data);
						//                 });
						//             }
						//         },
						//         prop: {
						//             name: 'rbsName',
						//             value: 'rbsId',
						//             children: 'childList'
						//         },
						//         data: rbsData
						//     });
						//
						//     if ((type == 2 || type == 3) && data.rbsType) {
						//         rbsTreeData.setValue([{rbsId: data.rbsType, rbsName: data.rbsTypeName}])
						//     }
						// });
						//
						// function getParentTree (parentId, callback) {
						//     parentId = parentId || '';
						//     $.get('/plbRbs/selectAll', {parentId: parentId}, function (res) {
						//         var newData = []
						//         res.data.forEach(function(item) {
						//             if (!item.isLeaf) {
						//                 item.childList = []
						//                 newData.push(item);
						//             }
						//         });
						//         if (callback) {
						//             callback(newData);
						//         }
						//     });
						// }

						// 获取CBS数据
						$.get('/plbCbsType/getAllList', function (res) {
							var treeData = res.data;

							cbsSelectTree = xmSelect.render({
								el: '#cbsSelectTree',
								iconfont: {
									parent: 'hidden' // 父节点隐藏图标
								},
								radio: true,
								filterable: true,
								clickClose: true,
								name: 'cbsId',
								disabled: type == 3,
								tree: {
									show: true,
									strict: false,
									expandedKeys: [-1],
								},
								prop: {
									name: 'cbsName',
									value: 'cbsId',
									children: "childList"
								},
								data: treeData
							});

							if (type == 2 || type == 3) {
								if (data.cbsId) {
									cbsSelectTree.setValue([{cbsId: data.cbsId, cbsName: data.cbsName}]);
								}
							}
						});

						if (type == 2 || type == 3) {
							layForm.val("baseForm", data);
							$('#showTableDialogId').attr('mtllibid',data.rbsType)
						} else if (type == 1) {
							// 获取自动编号
							getAutoNumber({autoNumber: 'plbRbsItem'}, function(res) {
								$('input[name="rbsItemNo"]', $('#baseForm')).val(res);
							});
							$('.refresh_no_btn').show().on('click', function() {
								getAutoNumber({autoNumber: 'plbRbsItem'}, function(res) {
									$('input[name="rbsItemNo"]', $('#baseForm')).val(res);
								});
							});
						}

						if (type == 3) {
							$('#baseForm [name]').attr('disabled', true);
						}
						layForm.render();
					},
					yes: function (index) {
						var loadIndex = layer.load();

						var datas = $('#baseForm').serializeArray();
						var dataObj = {}
						datas.forEach(function (item) {
							dataObj[item.name] = item.value;
						});
						dataObj.rbsType = $('#showTableDialogId').attr('mtllibid')
						// 判断必填项
						var requiredFlag = false;
						$('#baseForm').find('.field_required').each(function () {
							var field = $(this).attr('field');
							if (field && !dataObj[field] && dataObj[field] != '0') {
								var fieldName = $(this).parent().text().replace('*', '');
								layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
								requiredFlag = true;
								return false;
							}
						});
						if (requiredFlag) {
							layer.close(loadIndex);
							return false;
						}

						if (type == 1) {
							dataObj.rbsTypeId = '01';
						} else {
							dataObj.rbsItemId = data.rbsItemId
						}

						$.ajax({
							url: url,
							data: JSON.stringify(dataObj),
							dataType: 'json',
							contentType: "application/json;charset=UTF-8",
							type: 'post',
							success: function (res) {
								layer.close(loadIndex);
								if (res.flag) {
									layer.msg('保存成功！', {icon: 1});
									layer.close(index);
									tableObj.config.where._ = new Date().getTime();
									tableObj.reload();
								} else {
									layer.msg(res.msg, {icon: 2});
								}
							}
						});
					}
				});
			}

			/**
			 * 获取查询条件
			 * @returns {{planNo: (*), planName: (*)}}
			 */
			function getSearchObj() {
				var searchObj = {
					rbsItemNo: $('input[name="rbsItemNo"]', $('.query_module')).val(),
					rbsItemName: $('input[name="rbsItemName"]', $('.query_module')).val(),
					cbsName: $('input[name="cbsName"]', $('.query_module')).val()
				}

				return searchObj
			}

			// 查询
			$('#searchBtn').on('click', function () {
				tableInit();
			});
			//点击文本域显示dialog层显示table数据
			$(document).on('click', '#showTableDialogId', function () {
				layer.open({
					type: 1,
					title: '选择',
					area: ['70%', '80%'],
					maxmin: true,
					btn: ['确定', '取消'],
					btnAlign: 'c',
					content: ['<div class="container">',
						'<table id="materialsTable" lay-filter="materialsTable"></table>' +
						'</div>'].join(''),
					success: function () {
						layTable.render({
							elem: '#materialsTable',
							url: '/plbMtlLibrary/queryRbsType',
							where: {
								useFlag: true
							},
							page: true, //开启分页
							limit: 10,
							cols: [[ //表头
								{type: 'checkbox'},
								{field: 'mtlNo', title: '材料编码', minWidth: 120, sort: true, hide: false},
								{field: 'mtlName', title: '材料名称', minWidth: 120, sort: true, hide: false},
								{field: 'mtlStandard', title: '材料规格', minWidth: 120, sort: true, hide: false},
							]],
							parseData: function (res) {
								return {
									"code": 0, //解析接口状态
									"data": res.data,//解析数据列表
									"count": res.totleNum, //解析数据长度
								};
							},
							request: {
								pageName: 'page', //页码的参数名称，默认：page
								limitName: 'pageSize' //每页数据量的参数名，默认：limit
							},
							done:function(res){
								var mtlLibId=$('#showTableDialogId').attr('mtlLibId')
								if(mtlLibId!=undefined){
									var mtlLibIdArr=mtlLibId.split(',');
									res.data.forEach(function(item,index){
										mtlLibIdArr.forEach(function(mtlItem){
											if(item.mtlLibId==mtlItem){
												$('div[lay-id="materialsTable"]').find('tr[data-index="'+index+'"]').find('.layui-unselect').addClass('layui-form-checked')
											}
										})
									})
								}
							}
						});
					},
					yes: function (index) {
						var checkStatus = layTable.checkStatus('materialsTable');
						if (checkStatus.data.length > 0) {
							var trData = checkStatus.data;
							var rbsName = '';
							var mtlLibId = '';
							for(var i=0; i<trData.length; i++){
								rbsName += trData[i].mtlName +','
								mtlLibId += trData[i].mtlLibId +','
							}
							var value=$('#showTableDialogId').val()
							var mtlLibIdObj=$('#showTableDialogId').attr('mtlLibId')
							if(value!=''){
								$('#showTableDialogId').val(value+rbsName)
								$('#showTableDialogId').attr('mtlLibId',mtlLibIdObj+mtlLibId)
							}else{
								$('#showTableDialogId').val(rbsName)
								$('#showTableDialogId').attr('mtlLibId',mtlLibId)
							}

							layer.close(index);
						} else {
							layer.msg('请选择一项！', {icon: 0});
						}
					}
				});
			});

			/*region 导出 */
			$(document).on('click', function () {
				$('.export_moudle').hide();
			});
			$(document).on('click', '.export_btn', function () {
				var type = $(this).attr('type');
				var fileName = 'RBS模板列表.xlsx';
				if (type == 1) {
					var checkStatus = layTable.checkStatus('tableObj');
					if (checkStatus.data.length == 0) {
						layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
						return false;
					}
					soulTable.export(tableObj, {
						filename: fileName,
						checked: true
					});
				} else if (type == 2) {
					soulTable.export(tableObj, {
						filename: fileName,
						curPage: true
					});
				} else if (type == 3) {
					soulTable.export(tableObj, {
						filename: fileName
					});
				}
			});
			/* endregion */
		});
	}
</script>
</body>
</html>

