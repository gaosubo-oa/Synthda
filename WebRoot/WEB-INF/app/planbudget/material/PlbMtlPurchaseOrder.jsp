<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/1/12
  Time: 17:06
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
		<title>材料采购订单</title>

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
		<script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
		<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108311508"></script>
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

			.refresh_no_btn {
				display: none;
				margin-left: 8%;
				color: #00c4ff !important;
				font-weight: 600;
				cursor: pointer;
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
			.layui-col-xs6{
				width: 20%;
			}
			.layui-col{
				width: 19%;
			}
			.choose_mtl_plan_box .layui-input-block{
				margin-left: 50px;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId">
			<div class="wrapper">
				<div class="wrap_left">
					<h2>材料采购订单</h2>
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
							<input type="text" name="orderNo" placeholder="订单编号" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="mtlNo" placeholder="材料编号" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="mtlName" placeholder="材料名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<select name="auditerStatus">
								<option value="">请选择审批状态</option>
								<option value="0">未提交</option>
								<option value="1">审批中</option>
								<option value="2">批准</option>
								<option value="3">不批准</option>
							</select>
						</div>
						<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
							<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
<%--							<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>--%>
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
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
				<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
				<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
<%--				<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="closeOrder">关闭订单</button>--%>
				<button class="layui-btn layui-btn-sm " lay-event="dayin">打印模板</button>
			</div>
			<div style="position:absolute;top: 10px;right:60px;">
				<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
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

		<script type="text/html" id="toolbarDemoIn">
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
			</div>
		</script>

		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
		</script>

		<script type="text/html" id="toolBar">
			<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
		</script>

		<script>
			var tipIndex = null
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text')
                tipIndex = layer.tips(tip, this)
            }, function () {
                layer.close(tipIndex)
            });

			var leftTreeData = null;

            // 表格显示顺序
            var colShowObj = {
                orderNo: {field: 'orderNo', title: '订单编号', minWidth: 110, sort: true, hide: false},
                mtlContractId: {
                    field: 'mtlContractId', title: '材料采购合同', minWidth: 130, sort: true, hide: false, templet: function (d) {
                        return undefind_nullStr(d.mtlContractName)
                    }
                },
				projName: {field: 'projName', title: '所属项目', minWidth: 110, sort: true, hide: false},
				customerName : {field: 'customerName', title: '供应商', minWidth: 110, sort: true, hide: false},
				thisPurchaseNum: {field: 'thisPurchaseNum', title: '本次采购订单总数量', minWidth: 180, sort: true, hide: false},
				currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
                auditerStatus: {
                    field: 'auditerStatus',
                    title: '审核状态',
					minWidth: 110,
                    sort: true,
                    hide: false,
                    templet: function (d) {
						var str = '';
						switch (d.auditerStatus) {
							case '0':
								str = '未提交';
								break;
							case '1':
								var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
								str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
								break;
							case '2':
								var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
								str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
								break;
							case '3':
								var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
								str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
								break;
						}
						return str;
                    }
                },
				businessDate: {
                    field: 'businessDate', title: '业务日期', minWidth: 110, sort: true, hide: false
                },
                createUser: {
                    field: 'createUser', title: '编制人', minWidth: 110, sort: true, hide: false, templet: function (d) {
                        return undefind_nullStr(d.createUser)
                    }
                }
            }

            var TableUIObj = new TableUI('plb_mtl_order');

			// 获取数据字典数据
			var dictionaryObj = {
                CONTROL_MODE: {},
                CBS_UNIT: {},
				QUALITY_REQUIREMENT: {},
				CONTRACT_TYPE: {},
				PAYMENT_METHOD: {}
            }
            var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,QUALITY_REQUIREMENT,CONTRACT_TYPE,PAYMENT_METHOD';
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
			var option=null;
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
                    projectName = projectName ? projectName : '';
                    var loadingIndex = layer.load();
                    $.get('/plbOrg/treeListOrg', {projectName: projectName}, function (res) {
                        layer.close(loadingIndex);
                        if (res.flag) {
							leftTreeData = res.data;
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
						console.log(currentData)
                        $('#leftId').attr('projId', currentData.projId);
	                    $('#leftId').attr('projName', currentData.projName);
                        $('.no_data').hide();
                        $('.table_box').show();
                        tableInit(currentData.projId)
                    } else {
                        $('.table_box').hide();
                        $('.no_data').show();
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

                     option =layui.table.render({
						 elem: '#tableObj',
						 url: '/plbMtlOrder/queryPlbMtlOrder',
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
							 dataName: 'object'
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
					 })

					if (TableUIObj.orderbyFields) {
						option.initSort = {
							field: TableUIObj.orderbyFields,
							type: TableUIObj.orderbyUpdown
						}
					}

                    tableIns = layTable.render(option);
                }
				// 监听列表头部按钮事件
				layTable.on('toolbar(tableObj)', function (obj) {
					var checkStatus = layTable.checkStatus(obj.config.id);
					var dataTable=layTable.checkStatus(obj.config.id).data;
					switch (obj.event) {
						case 'add': // 新增
							if (!$('#leftId').attr('projId')) {
								layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
								return false;
							}
							addOrEdit(1);
							break;
						case 'edit': // 编辑
							if (checkStatus.data.length != 1) {
								layer.msg('请选择一条需要编辑的数据！', {icon: 0, time: 1500});
								return false;
							}

							if (checkStatus.data[0].auditerStatus != 0) {
								layer.msg('该订单已提交，不可编辑！', {icon: 0});
								return false;
							}

							$.get('/plbMtlOrder/getDataByIdMelOrderId', {melOrderId: checkStatus.data[0].melOrderId}, function (res) {
								if (res.flag) {
									addOrEdit(2, res.data);
								} else {
									layer.msg('获取信息失败！', {icon: 0, time: 2000});
								}
							});
							break;
						case 'del': // 删除
							if (checkStatus.data.length == 0) {
								layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
								return false;
							}

							var mtlOrderIds = '';

							checkStatus.data.forEach(function(item){
								if (!(checkStatus.data[0].auditerStatus > 0)) {
									mtlOrderIds += item.melOrderId + ',';
								}
							});

							layer.confirm('确定删除该条数据吗？', function (index) {
								$.post('/plbMtlOrder/delPlbMtlOrder', {mtlOrderIds: mtlOrderIds}, function (res) {
									layer.close(index)
									if (res.flag) {
										layer.msg('删除成功！', {icon: 1});
										option.config.where._ = new Date().getTime();
										option.reload();
									} else {
										layer.msg('删除失败！', {icon: 2});
									}
								});
							});

							break;
						case 'closeOrder': // 关闭订单
							layer.msg('关闭订单');
							break;
						case 'submit': // 提交审批
							if (checkStatus.data.length != 1) {
								layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
								return false;
							}
							if(checkStatus.data[0].auditerStatus != '0'){
								layer.msg('该数据已提交！', {icon: 0, time: 2000});
								return false;
							}
							layer.open({
								type: 1,
								title: '选择流程',
								area: ['70%', '80%'],
								btn: ['确定', '取消'],
								btnAlign: 'c',
								content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
								success: function () {
									$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '20'}, function (res) {
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
									var checkStatus1 = layTable.checkStatus('flowTable');
									if (checkStatus1.data.length > 0) {
										var flowData = checkStatus1.data[0];
										var approvalData =checkStatus.data[0];
										approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
										approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
										newWorkFlow(flowData.flowId,JSON.stringify(approvalData) , function (res) {
											var submitData = {
												melOrderId: checkStatus.data[0].melOrderId,
												runId: res.flowRun.runId
												//auditerStatus: 1
											}
											$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

											$.ajax({
												url: '/plbMtlOrder/updatePlbMtlOrder',
												data: JSON.stringify(submitData),
												dataType: 'json',
												contentType: "application/json;charset=UTF-8",
												type: 'post',
												success: function (res) {
													layer.close(loadIndex);
													if (res.flag) {
														layer.closeAll();
														layer.msg('提交成功!', {icon: 1});
														tableIns.config.where._ = new Date().getTime();
														option.reload();
													} else {
														layer.msg(res.msg, {icon: 2});
													}
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
						case 'import': // 导入
							layer.msg('导入');
							break;
						case 'export': // 导出
							$('.export_moudle').show();
							break;
						case 'dayin':
							if (checkStatus.data.length != 1) {
								layer.msg('请选择一条需要打印的数据！', {icon: 0, time: 2000});
								return false;
							}
							if(checkStatus.data[0].auditerStatus != 0){
								var index=layer.load();
								var runId=dataTable[0].runId;
								$.ajax({
									url:'/generateDocx/generateDocxByType?runId='+runId+'&type=mtlOrder',
									success:function(res){
										if(res.flag){
											layer.close(index);
											if(res.obj.reportAttachmentList[0]==""||res.obj.reportAttachmentList==undefined){
												layer.msg('查询失败请刷新重试！', {icon: 0, time: 2000});
												return
											}else{
												console.log(res.obj)
												var atturl=res.obj.reportAttachmentList[0].attUrl;
												pdurlss(atturl)
											}
										}else{
											layer.close(index);
										}

									}
								})
							}else{
								layer.msg('未提交审批不可打印！', {icon: 0, time: 2000});
							}
							break;
					}
				});
				layTable.on('tool(tableObj)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					if (layEvent === 'detail') {
						layer.open({
							type: 2,
							title: '材料采购订单详情',
							btn: ['确定'],
							btnAlign: 'c',
							area: ['100%', '100%'],
							content: '/plbMtlOrder/mtlPurchaseOrder?type=4&melOrderId=' + data.melOrderId,
							yes: function (index) {
								layer.close(index);
							}
						});
					}
				});
                // 内部加行按钮
                layTable.on('toolbar(detailTable)', function (obj) {
                    switch (obj.event) {
                        case 'add':
							var projId = $('#leftId').attr('projId');

							if (!projId) {
								var checkStatus = layTable.checkStatus('tableObj');
								projId = checkStatus.data[0].projId;
							}

							var wbsSelectTree = null;
							var rbsSelectTree = null;
							var cbsSelectTree = null;

							layer.open({
								type: 1,
								title: '选择材料需求计划',
								btn: ['确定', '取消'],
								btnAlign: 'c',
								area: ['90%', '80%'],
								content: ['<div class="choose_mtl_plan_box" style="padding: 5px;">',
									/* region 查询 */
									'<div class="layui-row">',
									'<div class="layui-col-xs4 layui-col">',
									'<div class="layui-form-item" style="margin-bottom: 10px;">',
									/*'<label class="layui-form-label" style="width: 95px; padding-left: 0;">材料计划编号</label>',*/
									'<div class="layui-input-block">',
									'<input type="text" name="listNo" placeholder="请输入材料计划编号" autocomplete="off" class="layui-input">',
									'</div>',
									'</div>',
									'</div>',
									'<div class="layui-col-xs4 layui-col">',
									'<div class="layui-form-item" style="margin-bottom: 10px;">',
									/*'<label class="layui-form-label" style="width: 95px; padding-left: 0;">材料计划名称</label>',*/
									'<div class="layui-input-block">',
									'<input type="text" name="planMtlName" placeholder="请输入材料计划名称" autocomplete="off" class="layui-input">',
									'</div>',
									'</div>',
									'</div>',
									'<div class="layui-col-xs4 layui-col">',
									'<div class="layui-form-item" style="margin-bottom: 10px;">',
									'<label class="layui-form-label" style="text-align: initial">WBS</label>',
									'<div class="layui-input-block">',
									'<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>',
									'</div>',
									'</div>',
									'</div>',
									'<div class="layui-col-xs4 layui-col">',
									'<div class="layui-form-item" style="margin-bottom: 10px;">',
									'<label class="layui-form-label" style="text-align: initial">RBS</label>',
									'<div class="layui-input-block">',
									'<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>',
									'</div>',
									'</div>',
									'</div>',
									'<div class="layui-col-xs4 layui-col">',
									'<div class="layui-form-item" style="margin-bottom: 10px;">',
									'<label class="layui-form-label" style="text-align: initial">CBS</label>',
									'<div class="layui-input-block">',
									'<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>',
									'</div>',
									'</div>',
									'</div>',
									'<div class="layui-col-xs4" style="width: 4%">',
									'<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 15px;">查询</button>',
									'</div>',
										'</div>',
										'<div class="layui-row">',

									'</div>',
									/* endregion */
									'<table id="mtlPlanTable" lay-filter="mtlPlanTable"></table>',
									'</div>'].join(''),
								success: function () {
									// 获取WBS数据
									$.get('/plbProjWbs/getWbsTreeByProjId', {projId: projId}, function (res) {
										wbsSelectTree = xmSelect.render({
											el: '#wbsSelectTree',
											data: res.obj,
											name: 'wbsName',
											radio: true,
											clickClose: true,
											filterable: true,
											toolbar: {
												show: true,
												list: [
													{
														icon: 'layui-icon layui-icon-subtraction',
														name: '折叠',
														method: function (data) {
															cbsSelectTree.changeExpandedKeys(false);
														}
													},
													{
														icon: 'layui-icon layui-icon-addition',
														name: '展开',
														method: function (data) {
															cbsSelectTree.changeExpandedKeys(true);
														}
													}
												]
											},
											prop: {
												name: 'wbsName',
												value: 'wbsId',
												children: 'child'
											},
											tree: {
												show: true,
												strict: false,
												showFolderIcon: true,
												showLine: true,
												indent: 20
											}
										});
									});


									//获取RBS数据
									rbsSelectTree = xmSelect.render({
										el: '#rbsSelectTree',
										content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search rbsSearch" style="width: 80%;margin: 5px"><div id="rbsTree" class="eleTree" lay-filter="rbsTree"></div>',
										name: 'rbsName',
										prop: {
											name: 'rbsName',
											value: 'rbsId'
										}
									});
									rbsData();
									// 树节点点击事件
									eleTree.on("nodeClick(rbsTree)", function (d) {
										var currentData = d.data.currentData;
										var obj = {
											rbsName: currentData.rbsName,
											rbsId: currentData.rbsId
										}
										rbsSelectTree.setValue([obj]);
									});
									var searchTimerRBS = null
									$('.rbsSearch').on('input propertychange', function () {
										clearTimeout(searchTimerRBS)
										searchTimerRBS = null
										var val = $(this).val()
										searchTimerRBS = setTimeout(function () {
											rbsData(val,'1')
										}, 300)
									});
									function rbsData(parentId,type){
										var obj = {};
										if(type == '1'){
											obj.rbsName=parentId?parentId:'';
										}else {
											obj.parentId=parentId?parentId:'1';
										}
										// 获取RBS数据
										$.get('/plbRbs/selectAll',obj, function (res) {
											var rbsTreeData = res.data || [];

											eleTree.render({
												elem: '#rbsTree',
												data: rbsTreeData,
												highlightCurrent: true,
												showLine: true,
												defaultExpandAll: false,
												accordion: true,
												lazy: true,
												request: {
													name: 'rbsName',
													children: "childList"
												},
												load: function (data, callback) {
													$.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
														callback(res.data);//点击节点回调
													})
												}
											});

										});
									}


									// 获取CBS数据
									$.get('/plbCbsType/getAllList', function (res) {
										cbsSelectTree = xmSelect.render({
											el: '#cbsSelectTree',
											data: res.data,
											name: 'cbsName',
											radio: true,
											clickClose: true,
											filterable: true,
											toolbar: {
												show: true,
												list: [
													{
														icon: 'layui-icon layui-icon-subtraction',
														name: '折叠',
														method: function (data) {
															cbsSelectTree.changeExpandedKeys(false);
														}
													},
													{
														icon: 'layui-icon layui-icon-addition',
														name: '展开',
														method: function (data) {
															cbsSelectTree.changeExpandedKeys(true);
														}
													}
												]
											},
											prop: {
												name: 'cbsName',
												value: 'cbsId',
												children: 'childList'
											},
											tree: {
												show: true,
												strict: false,
												showFolderIcon: true,
												showLine: true,
												indent: 20
											}
										});
									});

									$('.search_mtl').on('click', function () {
										var listNo = $('.choose_mtl_plan_box input[name="listNo"]').val();
										var planMtlName = $('.choose_mtl_plan_box input[name="planMtlName"]').val();
										var cbsId = cbsSelectTree.getValue('valueStr');
										var wbsId = wbsSelectTree.getValue('valueStr');
										var rbsId= rbsSelectTree.getValue('valueStr');

										getPlbMtlPlanList(wbsId,rbsId, cbsId, listNo, planMtlName);
									});

									getPlbMtlPlanList();

									/**
									 * 获取材料需求计划列表
									 * @param cbsId
									 * @param wbsId
									 * @param listNo
									 * @param planMtlName
									 */
									function getPlbMtlPlanList(wbsId,rbsId,cbsId,listNo, planMtlName) {
										layTable.render({
											elem: '#mtlPlanTable',
											url: '/plbMtlPlanList/getPlbMtlPlanListData',
											where: {
												projId: projId,
												cbsId: cbsId || '',
												wbsId: wbsId || '',
												rbsId:rbsId || '',
												listNo: listNo || '',
												planMtlName: planMtlName || '',
												auditerStatusFlag:"true",
												isOrder:"order"
											},
											page: true,
											limit: 20,
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
												{type: 'checkbox', title: '选择', fixed: 'left'},
												{field: 'planNo', title: '材料计划编号', minWidth: 140},
												{field: 'planName', title: '材料计划名称', minWidth: 140},
												{field: 'wbsName', title: 'WBS', minWidth: 120},
												{field: 'rbsName', title: 'RBS', minWidth: 120},
												{field: 'cbsName', title: 'CBS', minWidth: 120},
												{
													field: 'controlMode', title: '控制方式', minWidth: 90, templet: function (d) {
														return dictionaryObj['CONTROL_MODE']['object'][d.controlMode] || '';
													}
												},
												{
													field: 'planMtlName', title: '材料名称', minWidth: 90, templet: function (d) {
														return d.plbMtlLibrary ? d.plbMtlLibrary.mtlName : d.planMtlName;
													}
												},
												{
													field: 'planMtlStandard', title: '材料规格', minWidth: 90, templet: function (d) {
														var mtlStandard = d.plbMtlLibrary ? d.plbMtlLibrary.mtlStandard : d.planMtlStandard;
														return mtlStandard || '';
													}
												},
												// {field: 'directUnitPrice', title: '指导单价', minWidth: 90},
												{field: 'estiUnitPrice', title: '预计单价', minWidth: 90},
												{field: 'thisAmount', title: '需求计划量', minWidth: 100},
												{field: 'demandPlanning', title: '已下采购订单数量', minWidth: 80, templet: function (d) {
														return d.demandPlanning ? d.demandPlanning : 0;
													}},
												{field: 'thisTotalPrice', title: '需求计划总金额', minWidth: 80, templet: function (d) {
														return d.thisTotalPrice ? d.thisTotalPrice : 0;
													}},
												{field: 'totalAmountOfPurchaseOrder', title: '已下采购订单总金额', minWidth: 80, templet: function (d) {
														return d.totalAmountOfPurchaseOrder ? d.totalAmountOfPurchaseOrder : 0;
													}},

											]]
										});
									}
								},
								yes: function (index) {
									var checkStatus = layTable.checkStatus('mtlPlanTable');

									if (checkStatus.data.length > 0) {
										var chooseData = checkStatus.data[0];
										var newDataArr = [];

										checkStatus.data.forEach(function(item) {
											var newDataObj = {
												mtlLibId: item.mtlLibId, // 材料id
												listNo: item.plbMtlLibrary ? item.plbMtlLibrary.mtlNo : item.mtlLibNo, // 材料编号
												mtlPlanListId: item.mtlPlanListId, // 材料计划明细id
												planMtlName: item.plbMtlLibrary ? item.plbMtlLibrary.mtlName : item.planMtlName, // 材料名称
												wbsId: item.wbsId, // wbs id
												wbsName: item.wbsName, // wbs 名称
												rbsId: item.rbsId, // rbs id
												rbsName: item.rbsName, // rbs 名称
												cbsId: item.cbsId, // cbs id
												cbsName: item.cbsName, // cbs 名称
												planMtlStandard: item.plbMtlLibrary ? item.plbMtlLibrary.mtlStandard : item.planMtlStandard, // 材料规格
												controlType: item.controlMode, // 控制方式
												usePlace: item.usePlace, // 使用部位
												estimatedPrice: item.estiUnitPrice, // 预计单价
												directUnitPrice: item.directUnitPrice, // 指导单价
												valuationUnit: item.valuationUnit, // 计量单位
												mtlUnit: item.valuationUnit, // 计量单位
												thisAmount: item.thisAmount||0, // 需求计划数量
												demandPlanning: item.demandPlanning||0, // 已下订单数量
												thisTotalPrice: item.thisTotalPrice||0, // 需求计划总金额
												totalAmountOfPurchaseOrder: item.totalAmountOfPurchaseOrder||0 // 已下订单总金额
											}
											newDataArr.push(newDataObj);
										});

										//遍历表格获取每行数据进行保存
										var $tr = $('.mtl_info').find('.layui-table-main tr');
										var oldDataArr = []
										$tr.each(function () {
											var oldDataObj = {
												mtlOrderLisId: $(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId') || '', // 订单明细id
												mtlPlanListId: $(this).find('.mtl_info_planMtlName').attr('mtlPlanListId') || '', // 材料计划明细id
												mtlLibId: $(this).find('.mtl_info_planMtlName').attr('mtlLibId') || '', // 材料id
												wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId'), // wbs id
												wbsName: $(this).find('.mtl_info_wbsName').text(), // wbs名称
												rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId'), // rbs id
												rbsName: $(this).find('.mtl_info_rbsName').text(), // rbs 名称
												cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId'), // cbs id
												cbsName: $(this).find('.mtl_info_cbsName').text(), // cbs 名称
												listNo: $(this).find('.mtl_info_listNo').text(), // 材料编号
												planMtlName: $(this).find('.mtl_info_planMtlName').text(), // 材料名称
												planMtlStandard: $(this).find('.mtl_info_planMtlStandard').text(), // 材料规格
												controlType: $(this).find('.mtl_info_controlType').attr('controlType') || '', // 控制方式
												valuationUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
												mtlUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
												estimatedPrice: $(this).find('input[name="estimatedPrice"]').val(), // 预计单价
												directUnitPrice: $(this).find('.mtl_info_directUnitPrice').text(), // 指导单价
												purchaseQuantity: $(this).find('input[name="purchaseQuantity"]').val(), // 采购数量
												thisAmount: $(this).find('.mtl_info_thisAmount').text()||0, // 需求计划数量
												demandPlanning: $(this).find('.mtl_info_demandPlanning').text()||0, // 已下订单数量
												thisTotalPrice: $(this).find('.mtl_info_thisTotalPrice').text()||0, // 需求计划总金额
												totalAmountOfPurchaseOrder: $(this).find('.mtl_info_totalAmountOfPurchaseOrder').text()||0, // 已下订单总金额
												total: $(this).find('input[name="total"]').val(), // 本次合价
												usePlace: $(this).find('.mtl_info_usePlace').text(), // 使用部位
												qualityRequirement: $(this).find('input[name="qualityRequirement"]').attr('qualityRequirement') || '' // 质量要求
											}
											oldDataArr.push(oldDataObj);
										});
										oldDataArr = oldDataArr.concat(newDataArr);
										layTable.reload('detailTable', {
											data: oldDataArr
										});
										layer.close(index);
									} else {
										layer.msg('请选择一项！', {icon: 0, time: 2000});
									}
								}
							});
                            break;
                    }
                });
                // 内部删行操作
                layTable.on('tool(detailTable)', function (obj) {
                    var data = obj.data;
                    var layEvent = obj.event;
                    var $tr = obj.tr;

                    if (layEvent === 'del') {
                        obj.del();
                        if (data.mtlOrderLisId) {
                            $.get('/plbMtlOrder/delPlbMtlOrderList', {mtlOrderListIds: data.mtlOrderLisId}, function (res) {

                            });
                        }
                        //遍历表格获取每行数据进行保存
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
								mtlOrderLisId: $(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId') || '', // 订单明细id
								mtlPlanListId: $(this).find('.mtl_info_planMtlName').attr('mtlPlanListId') || '', // 材料计划明细id
								mtlLibId: $(this).find('.mtl_info_planMtlName').attr('mtlLibId') || '', // 材料id
								wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId'), // wbs id
								wbsName: $(this).find('.mtl_info_wbsName').text(), // wbs名称
								rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId'), // rbs id
								rbsName: $(this).find('.mtl_info_rbsName').text(), // rbs 名称
								cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId'), // cbs id
								cbsName: $(this).find('.mtl_info_cbsName').text(), // cbs 名称
								listNo: $(this).find('.mtl_info_listNo').text(), // 材料编号
								planMtlName: $(this).find('.mtl_info_planMtlName').text(), // 材料名称
								planMtlStandard: $(this).find('.mtl_info_planMtlStandard').text(), // 材料规格
								controlType: $(this).find('.mtl_info_controlType').attr('controlType') || '', // 控制方式
								valuationUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
								mtlUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
								estimatedPrice: $(this).find('input[name="estimatedPrice"]').val(), // 预计单价
								directUnitPrice: $(this).find('.mtl_info_directUnitPrice').text(), // 指导单价
								purchaseQuantity: $(this).find('input[name="purchaseQuantity"]').val(), // 采购数量
								thisAmount: $(this).find('.mtl_info_thisAmount').text(), // 需求计划数量
								demandPlanning: $(this).find('.mtl_info_demandPlanning').text(), // 已下订单数量
								thisTotalPrice: $(this).find('.mtl_info_thisTotalPrice').text(), // 需求计划总金额
								totalAmountOfPurchaseOrder: $(this).find('.mtl_info_totalAmountOfPurchaseOrder').text(), // 已下订单总金额
								total: $(this).find('input[name="total"]').val(), // 本次合价
								usePlace: $(this).find('.mtl_info_usePlace').text(), // 使用部位
								qualityRequirement: $(this).find('input[name="qualityRequirement"]').attr('qualityRequirement') || '' // 质量要求
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        layTable.reload('detailTable', {
                            data: oldDataArr
                        });
                    } else if (layEvent === 'chooseQualityRequirement') {
                        layer.open({
                            type: 1,
                            title: '选择质量要求',
                            area: ['400px', '400px'],
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: '<table id="chooseQualityRequirement" lay-filter="chooseQualityRequirement"></table>',
                            success: function () {
                                var dataArr = []
                                $.each(dictionaryObj['QUALITY_REQUIREMENT']['object'], function (k, o) {
                                    var obj = {
                                        qualityRequirement: k,
                                        qualityRequirementStr: o
                                    }
                                    dataArr.push(obj);
                                });
                                layTable.render({
                                    elem: '#chooseQualityRequirement',
                                    data: dataArr,
                                    cols: [[
                                        {type: 'radio', title: '选择'},
                                        {field: 'qualityRequirementStr', title: '质量要求'}
                                    ]]
                                });
                            },
                            yes: function (index) {
                                var checkStatus = layTable.checkStatus('chooseQualityRequirement');
                                if (checkStatus.data.length > 0) {
                                    $tr.find('input[name="qualityRequirement"]').val(checkStatus.data[0].qualityRequirementStr);
                                    $tr.find('input[name="qualityRequirement"]').attr('qualityRequirement', checkStatus.data[0].qualityRequirement);
                                    layer.close(index);
                                } else {
                                    layer.msg('请选择一项！', {icon: 0, time: 2000});
                                }
                            }
                        });
                    }
                });

                /**
                 * 新增/编辑方法
                 * @param type (1-新增，2-编辑)
                 * @param data (编辑时的订单信息)
                 */
	            function addOrEdit(type, data) {
					var title = '';
					var url = '';
					var projId = $('#leftId').attr('projId');
					var projName = $('#leftId').attr('projName');
					var melOrderId = '';
					if (type == 1) {
						title = '新增材料采购订单'
						url = '/plbMtlOrder/addPlbMtlOrder'
					} else if (type == 2) {
						title = '编辑材料采购订单';
						url = '/plbMtlOrder/updatePlbMtlOrder';
						melOrderId = data.melOrderId;
						if (!projId) {
							projId = data.projId;

							var projObj = searchTreeNode(leftTreeData, data.projId, 'projId', 'plbProjList');

							projName = projObj.projName;
						}
					}

                    layer.open({
                        type: 1,
                        title: title,
                        area: ['100%', '100%'],
                        btn: ['保存', '提交', '取消'],
	                    btnAlign: 'c',
                        content: ['<div class="layer_wrap"><div class="layui-collapse">',
                            /* region 材料计划 */
                            '<div class="layui-colla-item"><h2 class="layui-colla-title">材料采购订单</h2>' +
                            '<div class="layui-colla-content layui-show order_base_info">',
                            /* region 第一行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">订单编号<span field="orderNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="orderNo" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目名称<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly autocomplete="off" value="' + projName + '" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">合同名称<span field="mtlContractId" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="mtlContractId" autocomplete="off" style="cursor: pointer;background-color: #e7e7e7;" placeholder="请选择合同" class="layui-input choose_contract">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">供应商</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="customerId" readonly autocomplete="off" style="background-color: #e7e7e7;" class="layui-input choose_customerId">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">本次采购订单量合计</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="thisPurchaseNum" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
                            '</div>',
                            /* endregion */
							/* region 第二行 */
							// '<div class="layui-row">' +
							//
							//
							// '</div>',
							/* endregion */
							/* region 第三行 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">本次采购订单总金额合计</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="totalNumber" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">业务日期<span field="businessDate" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="businessDate" autocomplete="off" id="businessDate" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">备注</label>' +
							'<div class="layui-input-block form_block">' +
							'<textarea name="remarks" class="layui-input" style="resize: none;width:100%"></textarea>' +
							'</div>' +
							'</div>' +
							'</div>',
							'</div>',
							/* endregion */
                            /* region 第四行 */
                            // '<div class="layui-row">' +
							//
                            // '</div>',
                            /* endregion */
								/* region 第五行 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs12" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">附件</label>' +//<span field="attachmentId" class="field_required">*</span>
							'<div class="layui-input-block form_block">' +
							'<div class="file_module">' +
							'<div id="fileContent" class="file_content"></div>' +
							'<div class="file_upload_box">' +
							'<a href="javascript:;" class="open_file">' +
							'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
							'<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
							'</a>' +
							'<div class="progress">' +
							'<div class="bar"></div>\n' +
							'</div>' +
							'<div class="bar_text"></div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>'+
							'</div>',
								/* endregion */
                            '</div>' +
                            '</div>',
                            /* endregion */
                            /* region 材料明细 */
                            '<div class="layui-colla-item"><h2 class="layui-colla-title">材料明细</h2>' +
                            '<div class="layui-colla-content layui-show mtl_info">' +
                            '<div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>' +
                            '</div>' +
                            '</div>',
                            /* endregion */
                            /* region 其他 */
                            '<div class="layui-colla-item"><h2 class="layui-colla-title">其他</h2>' +
                            '<div class="layui-colla-content layui-show">',
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs4" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">编制人<span style="margin: 0 20px;">流程定义某节点为编制节点</span>编制时间</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" autocomplete="off" readonly class="layui-input" id="createTime">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs4" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">审批人<span style="margin: 0 20px;">流程定义某节点为审批节点</span>审批时间</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" autocomplete="off" readonly class="layui-input" id="approvalTime">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs4" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">审核人<span style="margin: 0 20px;">流程定义某节点为审核节点</span>审核时间</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" autocomplete="off" readonly class="layui-input" id="auditerTime">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '</div>',
                            '</div>' +
                            '</div>',
                            /* endregion */
                            '</div></div>'].join(''),
                        success: function () {
                            fileuploadFn('#fileupload', $('#fileContent'));

							laydate.render({
								elem: '#businessDate'
								, trigger: 'dblclick'
								, format: 'yyyy-MM-dd'
								// , format: 'yyyy-MM-dd HH:mm:ss'
								//, value: (data&&data.businessDate)||new Date()
							});
                            laydate.render({
                                elem: '#createTime' //指定元素
                                , trigger: 'click' //采用click弹出
                                , value: data ? format(data.createTime) : ''
                            });
                            laydate.render({
                                elem: '#approvalTime' //指定元素
                                , trigger: 'click' //采用click弹出
                                , value: data ? format(data.approvalTime) : ''
                            });
                            laydate.render({
                                elem: '#auditerTime' //指定元素
                                , trigger: 'click' //采用click弹出
                                , value: data ? format(data.auditerTime) : ''
                            });

                            var materialDetailsTableData = [];

                            // 编辑时显示数据
                            if (type == 2) {
								$('.order_base_info input[name="orderNo"]').val(data.orderNo || '');
								$('.order_base_info input[name="mtlContractId"]').attr('mtlContractId', data.mtlContractId || '').val(data.mtlContractName || '');
								$('.order_base_info input[name="customerId"]').attr('customerId', data.customerId || '').val(data.customerName || '');
								$('.order_base_info [name="remarks"]').val(data.remarks || '');
								$('.order_base_info input[name="thisPurchaseNum"]').val(data.thisPurchaseNum || '');
								$('.order_base_info input[name="totalNumber"]').val(data.totalNumber || '');
								$('.order_base_info input[name="businessDate"]').val(data.businessDate || '');

								materialDetailsTableData = data.mtlOrderList || [];

								/*$('#fileContent').html(getFileEleStr(data.attachmentList, true));*/
								if (data.attachmentList && data.attachmentList.length > 0) {
									var fileArr = data.attachmentList;
									$('#fileContent').append(echoAttachment(fileArr));
								}
                            } else {
								// 获取自动编号
								getAutoNumber({autoNumber: 'plbMtlOrder'}, function(res) {
									$('input[name="orderNo"]', $('.order_base_info')).val(res);
								});
								$('.refresh_no_btn').show().on('click', function() {
									getAutoNumber({autoNumber: 'plbMtlOrder'}, function(res) {
										$('input[name="orderNo"]', $('.order_base_info')).val(res);
									});
								});
                            }

                            layElement.render();

                            // 初始化付款结算列表
							layTable.render({
								elem: '#detailTable',
								data: materialDetailsTableData,
								toolbar: '#toolbarDemoIn',
								defaultToolbar: [''],
								limit: 1000,
								cols: [[
									{type: 'numbers', title: '序号'},
									{
										field: 'wbsName', title: 'WBS', minWidth: 160, templet: function (d) {
											return '<span class="mtl_info_wbsName" wbsId="' + (d.wbsId || '') + '">' + undefind_nullStr(d.wbsName) + '</span>';
										}
									},
									{
										field: 'cbsName', title: 'RBS', minWidth: 160, templet: function (d) {
											return '<span class="mtl_info_rbsName" rbsId="' + (d.rbsId || '') + '">' + undefind_nullStr(d.rbsName) + '</span>';
										}
									},
									{
										field: 'cbsName', title: 'CBS', minWidth: 120, templet: function (d) {
											return '<span class="mtl_info_cbsName" cbsId="' + (d.cbsId || '') + '">' + undefind_nullStr(d.cbsName) + '</span>';
										}
									},
									{
										field: 'planMtlName', title: '材料名称', minWidth: 100, templet: function (d) {
											if (d.plbMtlLibrary) {
												return '<span class="mtl_info_planMtlName" mtlLibId="' + (d.plbMtlLibrary.mtlLibId || '') + '" mtlOrderLisId="' + (d.mtlOrderLisId || '') + '" mtlPlanListId="' + (d.mtlPlanListId || '') + '">' + undefind_nullStr(d.plbMtlLibrary.mtlName) + '</span>';
											} else {
												return '<span class="mtl_info_planMtlName" mtlLibId="' + (d.mtlLibId || '') + '" mtlOrderLisId="' + (d.mtlOrderLisId || '') + '" mtlPlanListId="' + (d.mtlPlanListId || '') + '">' + undefind_nullStr(d.planMtlName) + '</span>';
											}
										}
									},
									{
										field: 'planMtlStandard', title: '材料规格', minWidth: 100, templet: function (d) {
											if (d.plbMtlLibrary) {
												return '<span class="mtl_info_planMtlStandard">' + (d.plbMtlLibrary.mtlStandard || '') + '</span>';
											} else {
												return '<span class="mtl_info_planMtlStandard">' + (d.planMtlStandard || '') + '</span>';
											}
										}
									},
									{
										field: 'mtlUnit', title: '计量单位', minWidth: 120, templet: function (d) {
											// if (d.plbMtlLibrary) {
											// 	if(d.controlType!=undefined&&d.controlType=="01"){
											// 		return '<span class="mtl_info_valuationUnit" valuationUnit="' + (d.plbMtlLibrary.mtlValuationUnit || '') + '">' + (dictionaryObj['CBS_UNIT']['object'][d.plbMtlLibrary.mtlValuationUnit] || '') + '</span>';
											// 	}else{
											// 		return '<span class="mtl_info_valuationUnit" valuationUnit="' + (d.plbMtlLibrary.mtlValuationUnit || '') + '">' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.plbMtlLibrary.mtlValuationUnit] || '') + '</span>';
											// 	}
											// } else {
											// 	if(d.controlType!=undefined&&d.controlType=="01"){
											// 		return '<span class="mtl_info_valuationUnit" mtlUnit="' + (d.valuationUnit || '') + '" valuationUnit="' + (d.valuationUnit || '') + '">' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '</span>';
											// 	}else{
											// 		return '<span class="mtl_info_valuationUnit" mtlUnit="' + (d.valuationUnit || '') + '" valuationUnit="' + (d.valuationUnit || '') + '">' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '') + '</span>';
											// 	}
											//}
											return '<span class="mtl_info_valuationUnit" mtlUnit="' + (d.valuationUnit || '') + '" valuationUnit="' + (d.valuationUnit || '') + '">' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '</span>';

										}
									},
									// {
									// 	field: 'controlType', title: '控制方式', minWidth: 100, templet: function (d) {
									// 		return '<span class="mtl_info_controlType" controlType="' + (d.controlType || '') + '">' + (dictionaryObj['CONTROL_MODE']['object'][d.controlType] || '') + '</span>';
									// 	}
									// },
									{
										field: 'thisAmount', title: '需求计划数量', minWidth: 120, templet: function (d) {
											return '<span class="mtl_info_thisAmount">' + undefind_nullStr(d.thisAmount) + '</span>';
										}
									},
									{
										field: 'demandPlanning', title: '已下订单数量', minWidth: 120, templet: function (d) {
											return '<span class="mtl_info_demandPlanning">' + (d.demandPlanning|| 0) + '</span>';
										}
									},
									{
										field: 'thisTotalPrice', title: '需求计划总金额', minWidth: 140, templet: function (d) {
											return '<span class="mtl_info_thisTotalPrice">' + (d.thisTotalPrice|| 0) + '</span>';
										}
									},
									{
										field: 'totalAmountOfPurchaseOrder', title: '已下订单总金额', minWidth: 140, templet: function (d) {
											return '<span class="mtl_info_totalAmountOfPurchaseOrder">' + undefind_nullStr(d.totalAmountOfPurchaseOrder) + '</span>';
										}
									},
									{
										field: 'estimatedPrice', title: '预计单价', minWidth: 120, templet: function (d) {
											return '<input type="text" name="estimatedPrice" autocomplete="off" pointFlag="1" pointNum="3" handleCallback="afterFloatChange" class="layui-input input_floatNum" style="height: 100%" value="' + (d.estimatedPrice || '') + '">'
										}
									},
									// {
									// 	field: 'directUnitPrice', title: '指导单价', minWidth: 120, templet: function (d) {
									// 		if (d.plbMtlLibrary) {
									// 			return '<span class="mtl_info_directUnitPrice">' + undefind_nullStr(d.plbMtlLibrary.mtlPriceUnit) + '</span>';
									// 		} else {
									// 			return '<span class="mtl_info_directUnitPrice">' + undefind_nullStr(d.directUnitPrice) + '</span>';
									// 		}
									// 	}
									// },
									{
										field: 'purchaseQuantity', title: '采购数量*', minWidth: 120, templet: function (d) {
											return '<input type="text" name="purchaseQuantity" autocomplete="off" pointFlag="1" pointNum="3" handleCallback="afterFloatChange" class="layui-input input_floatNum" style="height: 100%" value="' + (d.purchaseQuantity || '') + '">'
										}
									},
									{
										field: 'total', title: '本次合价*', minWidth: 120, templet: function (d) {
											return '<input type="text" name="total" readonly autocomplete="off" class="layui-input total" style="height: 100%;background-color: #e7e7e7;" value="' + (d.total || '') + '">'
										}
									},
									{
										field: 'usePlace', title: '使用部位', minWidth: 120, templet: function (d) {
											return '<span class="mtl_info_usePlace">' + undefind_nullStr(d.usePlace) + '</span>';
										}
									},
									{
										field: 'qualityRequirement',
										title: '质量要求',
										minWidth: 120,
										event: 'chooseQualityRequirement',
										templet: function (d) {
											var _quality = ''
											if(dictionaryObj['QUALITY_REQUIREMENT']['object']){
												if(d.qualityRequirement){
													_quality = dictionaryObj['QUALITY_REQUIREMENT']['object'][d.qualityRequirement]
												}else {
													_quality = dictionaryObj['QUALITY_REQUIREMENT']['object']['01']
												}
											}
											return '<input type="text" name="qualityRequirement" qualityRequirement="' + (d.qualityRequirement || '01') + '" readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" value="' + _quality + '">'
										}
									},
									{fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
								]]
							});

                            // 选择合同
                            $('.choose_contract').on('click', function () {
                                layer.open({
                                    type: 1,
                                    title: '选择合同',
									maxmin:true,
                                    area: ['80%', '80%'],
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: '<div id="contractTableModule"><div class="layui-row" style="margin-top: 10px;">' +
											'<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractNo" type="text" autocomplete="off" placeholder="合同编号" class="layui-input" /></div>' +
											'<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractName" type="text" autocomplete="off" placeholder="合同名称" class="layui-input" /></div>' +
											'<div class="layui-col-xs3" style="padding: 0 5px;"><input name="customerName" type="text" autocomplete="off" placeholder="供应商" class="layui-input" /></div>' +
											'<div class="layui-col-xs3" style="padding-top: 3px;"><button class="layui-btn layui-btn-sm" id="searchContract">查询</button></div>' +
											'</div>' +
											'<table id="chooseplbMtlContractTable" lay-filter="chooseplbMtlContractTable"></table></div>',
                                    success: function () {
                                    	var contractTableObj = null
										$('#searchContract').on('click', function () {
											var contractNo = $('input[name="contractNo"]', $('#contractTableModule')).val();
											var contractName = $('input[name="contractName"]', $('#contractTableModule')).val();
											var customerName=$('input[name="customerName"]',$('#contractTableModule')).val();
											contractTableObj.reload({
												where: {
													contractNo: contractNo,
													contractName: contractName,
													customerName:customerName,
													projId: projId,
													changeFlag:"1"
												}
											});
										});

										contractTableObj = layTable.render({
                                            elem: '#chooseplbMtlContractTable',
                                            url: '/plbMtlContract/selectAll',
                                            page: true,
                                            where: {
                                                projId: projId,
												changeFlag:"1",
												useFlag:true
                                            },
                                            request: {
                                                limitName: 'pageSize'
                                            },
                                            response: {
                                                statusName: 'flag',
                                                statusCode: true,
                                                msgName: 'msg',
                                                countName: 'totleNum',
                                                dataName: 'obj'
                                            },
                                            cols: [[
                                                {type: 'radio'},
                                                {field: 'contractNo', title: '合同编号', sort: true, hide: false},
                                                {field: 'contractName', title: '合同名称', sort: true, hide: false},
												{field:'contractAName',title:'甲方',sort:false,hide:false},
												{field:'customerName',title:'乙方',sort:false,hide:false},
												{field:'contractMoney',title:'合同金额',sort:false,hide:false},
                                                {
                                                    field: 'contractType', title: '合同类型', sort: true, hide: false, templet: function (d) {
                                                        return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
                                                    }
                                                },
                                                {
                                                    field: 'signDate', title: '合同签订日期', sort: true, hide: false, templet: function (d) {
                                                        return format(d.signDate);
                                                    }
                                                },
                                                // {field: 'customerName', title: '供应商单位', sort: true, hide: false},
                                                // {
                                                //     field: 'paymentType', title: '付款方式', sort: true, hide: false, templet: function (d) {
                                                //         return dictionaryObj['PAYMENT_METHOD']['object'][d.contractType] || '';
                                                //     }
                                                // }, {
                                                //     field: 'effectiveDate', title: '生效日期', sort: true, hide: false, templet: function (d) {
                                                //         return format(d.effectiveDate);
                                                //     }
                                                // }
                                            ]],
											done:function(res){
                                            	delete this.where.contractNo;
												delete this.where.contractName;
												delete this.where.customerName;
											}
                                        });
                                    },
                                    yes: function (index) {
                                        var checkStatus = layTable.checkStatus('chooseplbMtlContractTable');

                                        if (checkStatus.data.length > 0) {
                                            var contractData = checkStatus.data[0];
                                            $('.choose_contract').val(contractData.contractName);
                                            $('.choose_contract').attr('mtlContractId', contractData.mtlContractId);
											$('.choose_customerId').attr('customerId', contractData.customerId);
											$('.choose_customerId').val(contractData.customerName);
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                            });
                        },
                        yes: function (index) {
                            var loadIndex = layer.load();
                            // 材料订单数据
							var obj = getSaveData(type, false, loadIndex, melOrderId, projId).dataObj;
							if(obj!=undefined){
								$.ajax({
									url: url,
									data: JSON.stringify(obj),
									dataType: 'json',
									contentType: "application/json;charset=UTF-8",
									type: 'post',
									success: function (res) {
										layer.close(loadIndex);
										if (res.flag) {
											layer.msg('保存成功！', {icon: 1});
											layer.close(index);
											tableIns.config.where._ = new Date().getTime();
											option.reload();
										} else {
											layer.msg(res.msg, {icon: 2});
										}
									}
								});
							}
                        },
                        btn2: function (index) {
							// 提交前先保存
							var loadIndex = layer.load();

							var baseData = getSaveData(type, true, loadIndex, melOrderId, projId);

							$.ajax({
								url: url,
								data: JSON.stringify(baseData.dataObj),
								dataType: 'json',
								contentType: "application/json;charset=UTF-8",
								type: 'post',
								success: function (res) {
									layer.close(loadIndex);
									if (res.flag) {
										var resultData = res.data;
										if (type == 1) {
											melOrderId = res.object;
										}
										layer.open({
											type: 1,
											title: '选择流程',
											area: ['70%', '80%'],
											btn: ['确定', '取消'],
											btnAlign: 'c',
											content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
											success: function () {
												$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '20'}, function (res) {
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
													var approvalData = resultData;
													approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
													approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
													newWorkFlow(flowData.flowId, JSON.stringify(approvalData), function (res) {
														var submitData = {
															melOrderId: melOrderId,
															runId: res.flowRun.runId
															//auditerStatus: '1'
														}
														$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

														$.ajax({
															url: '/plbMtlOrder/updatePlbMtlOrder',
															data: JSON.stringify(submitData),
															dataType: 'json',
															contentType: "application/json;charset=UTF-8",
															type: 'post',
															success: function (res) {
																layer.close(loadIndex);
																if (res.flag) {
																	layer.closeAll();
																	layer.msg('提交成功!', {icon: 1});
																	tableIns.config.where._ = new Date().getTime();
																	option.reload();
																} else {
																	layer.msg(res.msg, {icon: 2});
																}
															}
														});
													});
												} else {
													layer.close(loadIndex);
													layer.msg('请选择一项！', {icon: 0});
												}
											}
										});
									} else {
										layer.msg(res.msg, {icon: 2});
									}
								}
							});
							return false;
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
						orderNo: $('input[name="orderNo"]', $('.query_module')).val(),
						mtlNo: $('input[name="mtlNo"]', $('.query_module')).val(),
						mtlName: $('input[name="mtlName"]', $('.query_module')).val(),
						auditerStatus: $('input[name="auditerStatus"]', $('.query_module')).val(),
					}

					return searchObj
				}

				/**
				 * 获取需要保存的数据
				 * @param saveType (1-新增, 2-编辑)
				 * @param isSubmit (是否提交)
				 * @param loadIndex
				 * @param melOrderId (采购订单id)
				 * @param projId
				 */
				function getSaveData(saveType, isSubmit, loadIndex, melOrderId, projId) {
					// 材料订单数据
					var dataObj = {
						orderNo: $('.order_base_info input[name="orderNo"]').val(),
						mtlContractId: $('.order_base_info input[name="mtlContractId"]').attr('mtlContractId') || '',
						customerId: $('.order_base_info input[name="customerId"]').attr('customerId') || '',
						thisPurchaseNum: retainDecimal($('.order_base_info input[name="thisPurchaseNum"]').val(),3),
						totalNumber: retainDecimal($('.order_base_info input[name="totalNumber"]').val(),2),
						businessDate:$('.order_base_info input[name="businessDate"]').val()||'',
						remarks: $('.order_base_info [name="remarks"]').val()
					}

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent a').eq(i).attr('name');
					}
					dataObj.attachmentId = attachmentId;
					dataObj.attachmentName = attachmentName;

					//if (isSubmit) {
						// 判断必填项
						var requiredFlag = false;
						$('.order_base_info').find('.field_required').each(function(){
							var field = $(this).attr('field');
							if (field && !dataObj[field] && dataObj[field] != '0') {
								if(field=="mtlContractId"){
									layer.msg('请选择合同！', {icon: 0, time: 2000});
									requiredFlag = true;
									return false;
								}else{
									var fieldName = $(this).parent().text().replace('*', '');
									layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
									requiredFlag = true;
									return false;
								}
							}
						});


					//}

					var baseObj = JSON.parse(JSON.stringify(dataObj));

					// 材料明细数据
					var $tr = $('.mtl_info').find('.layui-table-main tr');
					var materialDetailsArr = [];
					var lock=false;
					$tr.each(function () {
						// if($(this).find('input[name="estimatedPrice"]').val() == ''){
						// 	layer.msg('请填写预计单价！', {icon: 0});
						// 	lock = true;
						// 	return false
						// }
						if($(this).find('input[name="purchaseQuantity"]').val() == ''){
							layer.msg('请填写采购数量！', {icon: 0});
							lock = true;
							return false
						}
						var thisAmount = $(this).find('.mtl_info_thisAmount').text()||0;//需求计划数量
						var demandPlanning = $(this).find('.mtl_info_demandPlanning').text()||0;//已下订单数量
						var purchaseQuantity= $(this).find('input[name="purchaseQuantity"]').val()||0; // 采购数量
						var numm = sub(sub(thisAmount,demandPlanning),purchaseQuantity)
						if(numm<0){
							layer.msg('采购数量+已下订单数量不能大于需求计划数量！', {icon: 0});
							lock = true;
							return false
						}
						var materialDetailsObj = {
							mtlPlanListId: $(this).find('.mtl_info_planMtlName').attr('mtlPlanListId'), // 材料计划明细id
							mtlLibId: $(this).find('.mtl_info_planMtlName').attr('mtlLibId') || '', // 材料id
							wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId'),
							rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId'),
							cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId'),
							controlType:$(this).find('.mtl_info_controlType').attr('controlType'),//控制方式
							mtlUnit:$(this).find('.mtl_info_valuationUnit').attr('mtlUnit'),//计量单位
							qualityRequirement: $(this).find('input[name="qualityRequirement"]').attr('qualityRequirement') || '', // 质量要求
							usePlace: $(this).find('.mtl_info_usePlace').text(), // 使用部位
							purchaseQuantity: retainDecimal($(this).find('input[name="purchaseQuantity"]').val(),3), // 采购数量
							total: retainDecimal($(this).find('input[name="total"]').val(),2), // 本次合价
							estimatedPrice: retainDecimal($(this).find('input[name="estimatedPrice"]').val(),3), // 预计单价
							thisAmount : $(this).find('.mtl_info_thisAmount').text()||0,//需求计划数量
							demandPlanning: $(this).find('.mtl_info_demandPlanning').text()||0, // 已下订单数量
							totalAmountOfPurchaseOrder: $(this).find('.mtl_info_totalAmountOfPurchaseOrder').text()||0, // 已下订单总金额
						}
						if ($(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId')) {
							materialDetailsObj.mtlOrderLisId = $(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId');
						}
						materialDetailsArr.push(materialDetailsObj);
					});
					if (requiredFlag) {
						layer.close(loadIndex);
						return false;
					}
					if (lock) {
						layer.close(loadIndex);
						return false;
					}
					dataObj.mtlOrderList = materialDetailsArr;

					//其他数据
					dataObj.createTime = $('#createTime').val();
					dataObj.approvalTime = $('#approvalTime').val();
					dataObj.auditerTime = $('#auditerTime').val();

					if (saveType == 2) {
						dataObj.melOrderId = melOrderId
					} else {
						dataObj.projId = projId;
					}
					return {
						dataObj: dataObj,
						baseObj: baseObj
					}
				}

				/*region 导出 */
				$(document).on('click', function () {
					$('.export_moudle').hide();
				});
				$(document).on('click', '.export_btn', function () {
					var type = $(this).attr('type');
					var fileName = '材料采购订单列表.xlsx';
					if (type == 1) {
						var checkStatus = layTable.checkStatus('tableObj');
						if (checkStatus.data.length == 0) {
							layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
							return false;
						}
						soulTable.export(tableIns, {
							filename: fileName,
							checked: true
						});
					} else if (type == 2) {
						soulTable.export(tableIns, {
							filename: fileName,
							curPage: true
						});
					} else if (type == 3) {
						soulTable.export(tableIns, {
							filename: fileName
						});
					}
				});
				/* endregion */
			});

			function afterFloatChange(value, ele) {
				var name = $(ele).attr('name');

				if (name == 'estimatedPrice') { // 预计单价
					var $tr = $(ele).parents('tr');
					// 采购数量
					var purchaseQuantity = checkFloatNum($tr.find('input[name="purchaseQuantity"]').val(), 3);
					// 本次合价
					var total = checkFloatNum(BigNumber(purchaseQuantity).multipliedBy(value), 3);
					$tr.find('.total').val(total);

					var $trs = $('.mtl_info').find('.layui-table-main tr');
					var totalNumber = 0;
					$trs.each(function () {
						var total = checkFloatNum($(this).find('input[name="total"]').val(), 3); // 本次合价
						totalNumber = BigNumber(total).plus(totalNumber);
					});
					$('input[name="totalNumber"]', $('.order_base_info')).val(totalNumber);
				} else if (name == 'purchaseQuantity') { // 采购数量
					var $tr = $(ele).parents('tr');
					// 预计单价
					var estimatedPrice = checkFloatNum($tr.find('input[name="estimatedPrice"]').val(), 3);
					// 本次合价
					var total = checkFloatNum(BigNumber(value).multipliedBy(estimatedPrice), 3);
					$tr.find('.total').val(total);

					var $trs = $('.mtl_info').find('.layui-table-main tr');
					var thisPurchaseNum = 0;
					var totalNumber = 0;
					$trs.each(function () {
						var purchaseQuantity = checkFloatNum($(this).find('input[name="purchaseQuantity"]').val(), 3); // 采购数量
						var total = checkFloatNum($(this).find('input[name="total"]').val(), 3); // 本次合价
						thisPurchaseNum = BigNumber(purchaseQuantity).plus(thisPurchaseNum);
						totalNumber = BigNumber(total).plus(totalNumber);
					});
					$('input[name="thisPurchaseNum"]', $('.order_base_info')).val(thisPurchaseNum);
					$('input[name="totalNumber"]', $('.order_base_info')).val(totalNumber);
				}
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

			//判断undefined
			function undefind_nullStr(value) {
				if(value==undefined || value == "undefined"){
					return ""
				}
				return value
			}

			//数据列表点击审批状态查看流程功能
			$(document).on('click', '.preview_flow', function() {
				var flowId = $(this).attr('flowId'),
						runId = $(this).attr('runId');
				if (flowId && runId) {
					$.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
				}
			});
			function openRold(){ //流程转交下一步后会调用此方法
				//刷新表格
				 option.reload({
					page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			}

			//打印模板
			function pdurlss(that,workNum) { //附件预览点击调取
				var attrUrl=that.split('&FILESIZE')[0];
				var url = attrUrl;
				if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1&&attrUrl.indexOf('isOld=1') == -1){
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
				var type = UrlGetRequest('?'+attrUrl)||'docx';
				type = type.toLowerCase();
				if(type == 'pdf'){
					//$.popWindow('/common/pdfPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
					$.popWindow("/common/PDFBrowser?"+url,PreviewPage,'0','0','1200px','600px');
				}else if(type == 'png' || type == 'jpg' ||  type == 'txt'){
					$.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
				}else if(type == 'doc'||type == 'docx'||type == 'xls'||type == 'xlsx'||type == 'ppt'||type == 'pptx'){
					$.ajax({
						type:'get',
						url:'/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
						dataType:'json',
						success:function (res) {
							if(res.flag){
								documentPreviewOpen = res.object[0].paraValue;
								if(documentPreviewOpen == 1){
									$.ajax({
										type:'get',
										url:'/sysTasks/getOfficePreviewSetting',
										dataType:'json',
										success:function (res) {
											if(res.flag){
												var strOfficeApps = res.object.previewUrl;//在线预览服务地址

												$.ajax({
													url:'/onlyOfficeCode',
													dataType: 'json',
													type: 'post',
													success:function(res){
														if(res.flag){
															var code = res.obj;
															$.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
														}
													}
												})
											}
										}
									})
								}else if(documentPreviewOpen == 2){
									if(type == 'xls'||type == 'xlsx'){
										$.popWindow('/common/excelPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
									}else if(type == 'ppt'||type == 'pptx'){
										$.popWindow('/common/pptPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
									}else{
										$.popWindow('/common/officereader?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
									}
								}else if(documentPreviewOpen == 3){
									$.popWindow("/wps/info?"+ url +"&permission=read",'','0','0','1200px','600px');
								}else if(documentPreviewOpen == 4){
									$.popWindow("/common/onlyoffice?"+ url +"&edit=false",'','0','0','1200px','600px');
								}
							}
						}
					})
				} else{
					$.ajax({
						type:'get',
						url:'/sysTasks/getOfficePreviewSetting',
						dataType:'json',
						success:function (res) {
							if(res.flag){
								var strOfficeApps = res.object.previewUrl;//在线预览服务地址
								if(strOfficeApps == ''){
									strOfficeApps = 'https://owa-box.vips100.com';
								}

								$.ajax({
									url:'/onlyOfficeCode',
									dataType: 'json',
									type: 'post',
									success:function(res){
										if(res.flag){
											var code = res.obj;
											$.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
										}
									}
								})


							}
						}
					})
				}
			}
		</script>
	</body>
</html>
