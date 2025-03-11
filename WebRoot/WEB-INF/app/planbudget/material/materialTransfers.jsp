<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/25
  Time: 10:13
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
		<title>材料调拨</title>

		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?20210604.1"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
		<script type="text/javascript" src="/js/common/fileupload.js"></script>
		<script type="text/javascript" src="/js/planbudget/common.js?20210604.1"></script>

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
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId">
			<div class="wrapper">
				<div class="wrap_left">
					<h2>材料调拨</h2>
					<div class="left_form">
						<div class="search_icon">
							<i class="layui-icon layui-icon-search"></i>
						</div>
						<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input" />
					</div>
					<div class="tree_module">
						<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
					</div>
				</div>
				<div class="wrap_right">
					<div class="query_module layui-form layui-row" style="position: relative">
						<div class="layui-col-xs2">
							<input type="text" name="mtlOutNo" placeholder="调拨编号" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="mtlStockOutName" placeholder="出仓库名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="mtlStockInName" placeholder="入仓库名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="mtlName" placeholder="材料名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
							<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
							<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>
						</div>
						<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
							<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
							<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
						</div>
					</div>
					<div style="position: relative">
						<div class="table_box" style="display: none">
							<table id="tableObj" lay-filter="tableObj"></table>
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

		<script type="text/html" id="toolbarHead">
			<div style="position:absolute;top: 10px;right:60px;">
				<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
				<button class="layui-btn layui-btn-sm" lay-event="transfer" style="margin-left:10px;">调拨</button>
			</div>
		</script>

		<script type="text/html" id="toolBar">
			<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
		</script>

		<script>
			var tipIndex = null;
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text');
                tipIndex = layer.tips(tip, this);
            }, function () {
                layer.close(tipIndex);
            });

            // 表格显示顺序
            var colShowObj = {
                mtlOutNo: {field: 'mtlOutNo', title: '调拨编号', minWidth: 120, sort: true, hide: false},
                mtlStockOutId: {
                    field: 'mtlStockOutId', title: '出库仓库', minWidth: 120, sort: true, hide: false, templet: function (d) {
                        return isShowNull(d.mtlStockOutName);
                    }
                },
                mtlStockInId: {
                    field: 'mtlStockInId',
                    title: '入库仓库',
					minWidth: 120,
                    sort: true,
                    hide: false,
                    templet: function (d) {
                        return isShowNull(d.mtlStockInName);
                    }
                },
	            mtlName: {
                    field: 'mtlName', title: '材料名称', minWidth: 120, sort: true, hide: false, templet: function (d) {
                        return isShowNull(d.mtlName);
                    }
                },
	            mtlAmount: {
                    field: 'mtlAmount', title: '数量', minWidth: 90, sort: true, hide: false, templet: function (d) {
                        return isShowNull(d.mtlAmount);
                    }
                },
				currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
				approvalStatus: {
                    field: 'approvalStatus', title: '审批状态', minWidth: 120, sort: true, hide: false, templet: function (d) {
						if (d.approvalStatus == '1') {
							return '<span style="color: orange">审批中</span>'
						} else if (d.approvalStatus == '2') {
							return '<span style="color: green">批准</span>'
						} else if (d.approvalStatus == '3') {
							return '<span style="color: red">不批准</span>'
						} else {
							return '未提交'
						}
                    }
                },
	            createUser: {
                    field: 'createUser', title: '调拨人', minWidth: 90, sort: true, hide: false, templet: function (d) {
                        return isShowNull(d.createUser);
                    }
                },
                createTime: {
                    field: 'createTime', title: '调拨时间', minWidth: 120, sort: true, hide: false, templet: function (d) {
                        return format(d.createTime);
                    }
                },
	            remark: {field: 'remark', title: '调拨备注', minWidth: 120, sort: true, hide: false}
            }

            var TableUIObj = new TableUI('plb_mtl_out_in');

			// 获取数据字典数据
			var dictionaryObj = {
                CBS_UNIT: {}
            }
            var dictionaryStr = 'CBS_UNIT';
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

            layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
                var layForm = layui.form,
                    laydate = layui.laydate,
                    layTable = layui.table,
                    layElement = layui.element,
                    soulTable = layui.soulTable,
                    eleTree = layui.eleTree,
                    xmSelect = layui.xmSelect;

                var tableIns = null;
				TableUIObj.init(colShowObj, function(){
					// $('.no_data').hide();
					// $('.table_box').show();
					// tableInit();
				});

                layForm.render();

                /* region 修改左侧项目名称 */
                var searchTimer = null
                $('#search_project').on('input propertychange', function () {
                    clearTimeout(searchTimer)
                    searchTimer = null
                    var val = $(this).val()
                    searchTimer = setTimeout(function () {
                        projectLeft(val)
                    }, 300)
                })
                $('.search_icon').on('click', function () {
                    projectLeft($('#search_project').val())
                })
                /* endregion */

                projectLeft();

                /**
                 * 左侧项目信息列表
                 * @param projectName 项目名称
                 */
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
                            })
                        }
                    })
                }

                // 树节点点击事件
                eleTree.on("nodeClick(leftTree)", function (d) {
                    var currentData = d.data.currentData;
                    if (currentData.projId) {
                        $('#leftId').attr('projId', currentData.projId)
	                    $('#leftId').attr('projName', currentData.projAbbreviation)
                        $('.no_data').hide()
                        $('.table_box').show()
                        tableInit(currentData.projId)
                    } else {
                        $('.table_box').hide()
                        $('.no_data').show()
                    }
                });

				// 监听排序事件
                layTable.on('sort(tableObj)', function (obj) {
                    var param = {
                        orderbyFields: obj.field,
                        orderbyUpdown: obj.type
                    }

                    TableUIObj.update(param, function () {
                        tableInit($('#leftId').attr('projId') || '');
                    })
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
					switch (obj.event) {
						case 'submit': // 提交
							var checkStatus = layTable.checkStatus(obj.config.id);
							if (checkStatus.data.length != 1) {
								layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 1500});
								return false;
							}
							if (checkStatus.data[0].approvalStatus > 0) {
								layer.msg('该条数据已提交！', {icon: 0});
								return false;
							}
							var mtlOutInData = checkStatus.data[0]
							layer.open({
								type: 1,
								title: '选择流程',
								area: ['70%', '80%'],
								btn: ['确定', '取消'],
								btnAlign: 'c',
								content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
								success: function () {
									$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '23'}, function (res) {
										var flowData = []
										$.each(res.data.flowData, function (k, v) {
											flowData.push({
												flowId: k,
												flowName: v
											});
										});
										layTable.render({
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
									var checkStatus = layTable.checkStatus('flowTable');
									if (checkStatus.data.length > 0) {
										var flowData = checkStatus.data[0];

										newWorkFlow(flowData.flowId, JSON.stringify(mtlOutInData), function (res) {
											var submitData = {
												mtlOutInId: mtlOutInData.mtlOutInId,
												runId: res.flowRun.runId,
												approvalStatus: '1'
											}
											$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

											$.post('/plbMtlOutIn/update', submitData, function(res) {
												layer.close(loadIndex);
												if (res.flag) {
													layer.closeAll();
													layer.msg('提交成功!', {icon: 1});
													tableIns.config.where._ = new Date().getTime();
													tableIns.reload();
												} else {
													layer.msg(res.msg, {icon: 2});
												}
											});
										});
									} else {
										layer.close(loadIndex);
										layer.msg('请选择一项！', {icon: 0});
									}
								}
							});
							break;
						case 'transfer': // 调拨
							if (!$('#leftId').attr('projId')) {
								layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
								return false;
							}
							addOrEdit($('#leftId').attr('projId'));
							break;
                    }
                });
				layTable.on('tool(tableObj)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					if (layEvent === 'detail') {
						layer.open({
							type: 2,
							title: '材料调拨详情',
							area: ['100%', '100%'],
							content: '/plbMtlOutIn/mtlTransfers?type=2&mtlOutInId=' + data.mtlOutInId
						});
					}
				});

                /**
                 * 加载表格方法
                 */
                function tableInit(projId) {
					var searchObj = getSearchObj();
					searchObj.projId = projId || '';
					searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
					searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                    var cols = [{checkbox: true}].concat(TableUIObj.cols);

					cols.push({
						fixed: 'right',
						align: 'center',
						toolbar: '#toolBar',
						title: '操作',
						width: 100
					});

                    var option = {
						elem: '#tableObj',
						url: '/plbMtlOutIn/queryAll',
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
						request: {
							limitName: 'pageSize'
						},
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

                    tableIns = layTable.render(option);
                }

                /**
                 * 调拨方法
                 * @param projId (左侧项目id)
                 */
	            function addOrEdit(projId) {
                    var mtlStockInTable = null;
                    var mtlStockInListTable = null;

                    layer.open({
                        type: 1,
                        title: '材料调拨',
                        area: ['100%', '100%'],
                        btn: ['调拨出入库', '取消'],
	                    btnAlign: 'c',
                        content: ['<div class="layui-collapse">',
                            '<div class="layui-colla-item"><h2 class="layui-colla-title">入库单</h2>',
                            '<div class="layui-colla-content layui-show">',
                            '<table id="mtlStockInTable" lay-filter="mtlStockInTable"></table>',
                            '</div>',
                            '</div>',
                            '<div class="layui-colla-item"><h2 class="layui-colla-title">入库单明细</h2>',
                            '<div class="layui-colla-content layui-show">',
                            '<table id="mtlStockInListTable" lay-filter="mtlStockInListTable"></table>',
                            '</div>',
                            '</div>',
                            '</div>'].join(''),
                        success: function () {
                            layElement.render();

                            mtlStockInTable = layTable.render({
                                elem: '#mtlStockInTable',
                                url: '/plbMtlStockIn/getDataByCondition',
                                where: {
                                    projId: projId
                                },
                                page: {
                                    limit: 10,
                                    limits: [10]
                                },
                                request: {
                                    limitName: 'pageSize'
                                },
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    countName: 'totleNum',
                                    dataName: 'data'
                                },
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'mtlStockInNo', title: '入库单编号', align: 'center'},
                                    {field: 'warehouseName', title: '仓库名称', align: 'center'},
                                    {field: 'projName', title: '所属项目', align: 'center'},
                                    {field: 'customerName', title: '供应商名称', align: 'center'},
                                    {field: 'stockInTotal', title: '入库总数量', align: 'center'},
                                    {field: 'stockInDate', title: '入库日期', align: 'center'}
                                ]]
                            });

                            layTable.on('radio(mtlStockInTable)', function (obj) {
                                laodMtlStockInListTable(obj.data.mtlStockInId);
                            });

                            function laodMtlStockInListTable(mtlStockInId) {
                                mtlStockInListTable = layTable.render({
                                    elem: '#mtlStockInListTable',
                                    url: '/plbMtlStockIn/getChildList',
                                    where: {
                                        mtlStockInId: mtlStockInId
                                    },
                                    page: {
                                        limit: 10,
                                        limits: [10]
                                    },
                                    request: {
                                        limitName: 'pageSize'
                                    },
                                    response: {
                                        statusName: 'flag',
                                        statusCode: true,
                                        msgName: 'msg',
                                        countName: 'totleNum',
                                        dataName: 'data'
                                    },
                                    cols: [[
                                        {type: 'checkbox', title: '选择'},
                                        {field: 'mtlName', title: '材料名称', align: 'center'},
                                        {field: 'mtlStandard', title: '材料规格', align: 'center'},
	                                    {field: 'stockInQuantity', title: '本次入库数量', align: 'center'},
	                                    {field: 'sumSurplusQuantity', title: '剩余库存数量', align: 'center'},
	                                    {field: 'stockInPrice', title: '含税单价', align: 'center'},
                                        {field: 'noTaxPeice', title: '不含税单价', align: 'center'},
                                        {field: 'taxRate', title: '税率', align: 'center'},
                                        {field: 'stockInDate', title: '入库时间', align: 'center'}
                                    ]]
                                });
                            }
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('mtlStockInListTable');

                            if (checkStatus.data.length > 0) {
                            	var chooseStockInData = layTable.checkStatus('mtlStockInTable');
                                var chooseData = checkStatus.data;

								chooseData.forEach(function (item) {
									item.projName = chooseStockInData.data[0].projName;
								});

                                var transferOutgoing = null;
                                var transferWarehouseg = null;

                                var warehouseId = chooseData[0].warehouseId;

                                layer.open({
                                    type: 1,
                                    title: '材料调拨',
                                    area: ['100%', '100%'],
                                    btn: ['保存', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div class="layui-collapse">',
                                        '<div class="layui-colla-item"><h2 class="layui-colla-title">调拨出库</h2>',
                                        '<div class="layui-colla-content layui-show">',
	                                    '<form class="layui-form">',
	                                    '<div class="layui-form-item" style="margin-bottom: 0;">',
                                        '<div class="layui-inline" style="margin-bottom: 0;">',
                                        '<label class="layui-form-label">领料人:</label>',
                                        '<div class="layui-input-inline">',
                                        '<input type="text" id="stockOutReceiver" name="stockOutReceiver" autocomplete="off" class="layui-input" readonly style="cursor: pointer;">',
                                        '</div>',
                                        '</div>',
	                                    '<div class="layui-inline" style="margin-bottom: 0;">',
                                        '<label class="layui-form-label">出库备注:</label>',
                                        '<div class="layui-input-inline" style="width: 500px;">',
                                        '<input type="text" name="outRemark" autocomplete="off" class="layui-input">',
                                        '</div>',
                                        '</div>',
	                                    '</div>',
	                                    '</form>',
                                        '<div id="transferOutgoingBox"><table id="transferOutgoing" lay-filter="transferOutgoing"></table></div>',
                                        '</div>',
                                        '</div>',
                                        '<div class="layui-colla-item"><h2 class="layui-colla-title">调拨入库</h2>',
                                        '<div class="layui-colla-content layui-show">',
	                                    '<form class="layui-form">',
	                                    '<div class="layui-form-item" style="margin-bottom: 0;">',
                                        '<div class="layui-inline" style="margin-bottom: 0;">',
                                        '<label class="layui-form-label">项目名称:</label>',
                                        '<div class="layui-input-inline">',
                                        '<select id="showProject" name="showProject" lay-filter="showProject"></select>',
                                        '</div>',
										'</div>',
										'<div class="layui-inline" style="margin-bottom: 0;">',
										'<label class="layui-form-label">仓库:</label>',
										'<div class="layui-input-inline">',
										'<select id="inWarehouseId" name="inWarehouseId"></select>',
										'</div>',
										'</div>',
	                                    '</div>',
	                                    '</form>',
                                        '<div id="transferWarehousegBox"><table id="transferWarehouseg" lay-filter="transferWarehouseg"></table></div>',
                                        '</div>',
                                        '</div>',
                                        '</div>'].join(''),
                                    success: function () {
                                        layElement.render();

                                        transferOutgoing = layTable.render({
                                            elem: '#transferOutgoing',
                                            data: chooseData,
                                            cols: [[
												{field: 'wbsName', title: 'WBS', align: 'center', minWidth: 90},
												{field: 'cbsName', title: 'CBS', align: 'center', minWidth: 90},
												{field: 'projName', title: '项目名称', align: 'center', minWidth: 90},
                                                {
                                                    field: 'mtlName', title: '材料名称', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="mtlLibId" mtlLibId="' + d.mtlLibId + '">' + isShowNull(d.mtlName) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'mtlStandard', title: '材料规格', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="mtlStandard">' + isShowNull(d.mtlStandard) + '</span>';
                                                    }
                                                },
												{
													field: 'stockInQuantity', title: '入库数量', align: 'center', minWidth: 90, templet: function (d) {
														return '<span class="stockInQuantity">' + isShowNull(d.stockInQuantity) + '</span>';
													}
												},
												{
													field: 'sumDeliveryQuantity', title: '已出库数量', align: 'center', minWidth: 100, templet: function (d) {
														return '<span class="sumDeliveryQuantity">' + isShowNull(d.sumDeliveryQuantity) + '</span>';
													}
												},
												{
													field: 'onWayOutAmount', title: '在途中出库数量', align: 'center', minWidth: 130, templet: function (d) {
														return '<span class="onWayOutAmount">' + isShowNull(d.onWayOutAmount) + '</span>';
													}
												},
												{
													field: 'outInTotal', title: '累计调拨数量', align: 'center', minWidth: 120, templet: function (d) {
														return '<span class="outInTotal">' + isShowNull(d.outInTotal) + '</span>';
													}
												},
												{
													field: 'onWayOutInAmount', title: '在途中调拨数量', align: 'center', minWidth: 130, templet: function (d) {
														return '<span class="onWayOutInAmount">' + isShowNull(d.onWayOutInAmount) + '</span>';
													}
												},
												{
													field: 'stockOutQuantity', title: '本次出库数量', align: 'center', minWidth: 120, templet: function (d) {
														return '<input type="text" name="mtl_' + d.stockInListId + '" autocomplete="off" handleCallback="afterIntChange" class="layui-input stockOutQuantity input_floatNum" style="height: 100%;" value="' + isShowNull(d.stockOutQuantity) + '">'
													}
												},
                                                {
                                                    field: 'stockInPrice', title: '含税单价', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="taxPeice">' + isShowNull(d.stockInPrice) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'noTaxPeice', title: '不含税单价', align: 'center', minWidth: 100, templet: function (d) {
                                                        return '<span class="noTaxPeice">' + isShowNull(d.noTaxPeice) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'taxRate', title: '税率', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="taxRate">' + isShowNull(d.taxRate) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'stockInMoney', title: '含税总价', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="stockInMoney">' + isShowNull(d.stockInMoney) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'noTaxMoney', title: '不含税总价', align: 'center', minWidth: 100, templet: function (d) {
                                                        return '<span class="noTaxMoney">' + isShowNull(d.noTaxMoney) + '</span>';
                                                    }
                                                },
                                                {
													field: 'usePlace', title: '需用部位', align: 'center', minWidth: 100, templet: function (d) {
														return '<span class="usePlace">' + isShowNull(d.usePlace) + '</span>';
													}
                                                }
                                            ]]
                                        });

                                        transferWarehouseg = layTable.render({
                                            elem: '#transferWarehouseg',
                                            data: chooseData,
                                            cols: [[
                                                {
													field: 'mtlName', title: '材料名称', align: 'center', minWidth: 90, templet: function (d) {
														return '<span class="mtlName" stockInListId="' + d.stockInListId + '" mtlLibId="' + d.mtlLibId + '">' + isShowNull(d.mtlName) + '</span>';
													}
                                                },
                                                {
                                                    field: 'mtlStandard', title: '材料规格', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="mtlStandard">' + isShowNull(d.mtlStandard) + '</span>';
                                                    }
                                                },
												{
													field: 'mtlValuationUnit', title: '单位', align: 'center', minWidth: 90, templet: function (d) {
														return '<span class="mtlValuationUnit">' + isShowNull(d.mtlValuationUnit) + '</span>';
													}
												},
                                                {
                                                    field: 'stockInQuantity', title: '本次入库数量', align: 'center', minWidth: 120, templet: function (d) {
                                                        return '<input type="text" readonly name="mtl_' + d.stockInListId + '" autocomplete="off" class="layui-input stockInQuantity" style="height: 100%;">'
                                                    }
                                                },
                                                {
                                                    field: 'stockInPrice', title: '含税单价', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="stockInPrice">' + isShowNull(d.stockInPrice) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'noTaxPeice', title: '不含税单价', align: 'center', minWidth: 100, templet: function (d) {
                                                        return '<span class="noTaxPeice">' + isShowNull(d.noTaxPeice) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'taxRate', title: '税率', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<span class="taxRate">' + isShowNull(d.taxRate) + '</span>';
                                                    }
                                                },
												{
													field: 'stockInMoney', title: '含税总价', align: 'center', minWidth: 90, templet: function (d) {
														return '<span class="stockInMoney">' + isShowNull(d.stockInMoney) + '</span>';
													}
												},
												{
													field: 'noTaxMoney', title: '不含税总价', align: 'center', minWidth: 100, templet: function (d) {
														return '<span class="noTaxMoney">' + isShowNull(d.noTaxMoney) + '</span>';
													}
												},
                                                {
                                                    field: 'checkState', title: '质量验收情况', align: 'center', minWidth: 120, templet: function (d) {
                                                        return '<span class="checkState">' + isShowNull(d.checkState) + '</span>';
                                                    }
                                                },
                                                {
                                                    field: 'remark', title: '备注', align: 'center', minWidth: 90, templet: function (d) {
                                                        return '<input type="text" name="remark" autocomplete="off" class="layui-input remark" style="height: 100%;">'
                                                    }
                                                }
                                            ]]
                                        });

										$.get('/plbWarehouse/showProject', function (res) {
											var str = '<option value="">请选择</option>';
											if (res.flag && res.data.length > 0) {
												res.data.forEach(function (item) {
													str += '<option value="' + item.projId + '">' + item.projName + '</option>';
												});
											}
											$('#showProject').html(str);
											layForm.render('select');
										});

                                        $('#stockOutReceiver').on('click', function(){
                                            user_id = 'stockOutReceiver';
                                            $.popWindow('/common/selectUser?0');
                                        });

                                        $('.mtl').on('input propertychange', function(){
                                            var name = $(this).attr('name');
                                            $('input[name="' + name + '"]').val($(this).val());
                                        });

										layForm.on('select(showProject)', function (data) {
											var value = data.value
											if (value) {
												$.get('/plbWarehouse/selectAll', {projId: value}, function (res) {
													var str = '<option value="">请选择</option>';
													if (res.flag && res.obj.length > 0) {
														res.obj.forEach(function (item) {
															str += '<option value="' + item.warehouseId + '">' + item.warehouseName + '</option>';
														});
													}
													$('#inWarehouseId').html(str);
													layForm.render('select');
												});
											} else {
												$('#inWarehouseId').empty();
												layForm.render('select');
											}
										});
									},
                                    yes: function () {
                                        var loadIndex = layer.load();
                                        // 入库
                                        var plbMtlStockOutListWithBLOBsList = [];
                                        var $tr1 = $('#transferOutgoingBox').find('.layui-table-main tr');
                                        $tr1.each(function(i, v){
                                            var obj = {
                                                mtlLibId: $(v).find('.mtlLibId').attr('mtlLibId'),
                                                mtlName: $(v).find('.mtlName').text(),
	                                            mtlStandard: $(v).find('.mtlStandard').text(),
	                                            mtlStockInNo: $(v).find('.mtlStockInNo').text(),
	                                            taxPeice: $(v).find('.taxPeice').text(),
	                                            noTaxPeice: $(v).find('.noTaxPeice').text(),
	                                            taxRate: $(v).find('.taxRate').text(),
	                                            taxMoney: $(v).find('.taxMoney').text(),
	                                            noTaxMoney: $(v).find('.noTaxMoney').text(),
                                                stockInQuantity: $(v).find('.stockOutQuantity').val(),
	                                            usePlace: $(v).find('.usePlace').text()
                                            }
											plbMtlStockOutListWithBLOBsList.push(obj);
                                        });

                                        // 出库
                                        var plbMtlStockInListWithBLOBsList = [];
                                        var $tr2 = $('#transferWarehousegBox').find('.layui-table-main tr');
                                        $tr2.each(function(i, v){
                                            var obj = {
                                                mtlLibId: $(v).find('.mtlLibId').attr('mtlLibId'),
												stockInListId: $(v).find('.mtlLibId').attr('stockInListId'),
                                                mtlName: $(v).find('.mtlName').text(),
	                                            mtlStandard: $(v).find('.mtlStandard').text(),
	                                            stockOutQuantity: $(v).find('.stockInQuantity').val(),
	                                            stockInQuantity: $(v).find('.stockInQuantity').val(),
	                                            stockInPrice: $(v).find('.stockInPrice').text(),
	                                            noTaxPeice: $(v).find('.noTaxPeice').text(),
	                                            taxRate: $(v).find('.taxRate').text(),
	                                            checkState: $(v).find('.checkState').text(),
	                                            remark: $(v).find('.remark').val()
                                            }
											plbMtlStockInListWithBLOBsList.push(obj);
                                        });

                                        var obj = {
                                            projId: projId,
	                                        outWarehouseId: warehouseId,
	                                        inWarehouseId: $('#inWarehouseId').val(),
	                                        outRemark: $('input[name="outRemark"]').val(),
	                                        stockOutReceiver: $('#stockOutReceiver').attr('user_id') || '',
											plbMtlStockOutListWithBLOBsList: plbMtlStockOutListWithBLOBsList,
											plbMtlStockInListWithBLOBsList: plbMtlStockInListWithBLOBsList
                                        }

                                        $.ajax({
                                            url: '/plbMtlOutIn/allocation',
                                            data: JSON.stringify(obj),
                                            dataType: 'json',
                                            contentType: "application/json;charset=UTF-8",
                                            type: 'post',
                                            success: function (res) {
                                                layer.close(loadIndex);
                                                if (res.flag) {
                                                    layer.msg('保存成功！', {icon: 1});
                                                    layer.closeAll();
                                                    tableIns.config.where._ = new Date().getTime();
                                                    tableIns.reload();
                                                } else {
                                                    layer.msg('保存失败！', {icon: 2});
                                                }
                                            }
                                        });
                                    }
                                });
                            } else {
                                layer.msg('请选择入库明细！', {icon: 0, time: 2000});
                            }
                        }
                    });
	            }

				// 查询
				$('#searchBtn').on('click', function(){
					tableInit($('#leftId').attr('projId') || '');
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
					var searchObj = {
						mtlOutNo: $('input[name="mtlOutNo"]', $('.query_module')).val(),
						mtlStockOutName: $('input[name="mtlStockOutName"]', $('.query_module')).val(),
						mtlStockInName: $('input[name="mtlStockInName"]', $('.query_module')).val(),
						mtlName: $('input[name="mtlName"]', $('.query_module')).val()
					}

					return searchObj
				}
            });

			function afterIntChange(value, ele) {
				var name = $(ele).attr('name');
				var $tr = $(ele).parents('tr');
				// 入库数量
				var stockInQuantity = checkFloatNum($tr.find('.stockInQuantity').text());
				// 累计出库数量
				var sumDeliveryQuantity = checkFloatNum($tr.find('.sumDeliveryQuantity').text());

				var count = BigNumber(stockInQuantity).minus(sumDeliveryQuantity);

				if (BigNumber(value).gt(count)) {
					value = count;
					$(ele).val(value);
				}

				// 含税单价
				var taxPeice = checkFloatNum($tr.find('.taxPeice').text());
				// 不含税单价
				var noTaxPeice = checkFloatNum($tr.find('.noTaxPeice').text());
				// 含税总价
				var stockInMoney = BigNumber(value).multipliedBy(taxPeice);
				// 不含税总价
				var noTaxMoney = BigNumber(value).multipliedBy(noTaxPeice);
				$('input[name="' + name + '"]').val(value);
				var $tr2 = $('#transferWarehousegBox input[name="' + name + '"]').parents('tr');
				$tr.find('.stockInMoney').text(stockInMoney);
				$tr.find('.noTaxMoney').text(noTaxMoney);
				$tr2.find('.stockInMoney').text(stockInMoney);
				$tr2.find('.noTaxMoney').text(noTaxMoney);
			}

			/**
			 * 新建流程方法
			 * @param flowId
			 * @param approvalData
			 * @param cb
			 */
			function newWorkFlow(flowId, approvalData, cb) {
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
						isBudgetFlow: true, // 是否为预算审批流
						approvalData: approvalData, // (tab页面)
						isTabApproval: true // 是否为tab方式打开
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
		</script>
	</body>
</html>
