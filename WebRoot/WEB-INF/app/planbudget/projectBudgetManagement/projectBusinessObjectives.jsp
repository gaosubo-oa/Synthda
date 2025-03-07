<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/6
  Time: 17:40
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
		<title>项目经营目标</title>

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
<%--        <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
		<script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
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

			.layui-select-disabled .layui-disabled {
				color: #222 !important;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId" class="layui-input">
			<div class="wrapper">
				<div class="wrap_left">
					<h2 style="text-align: center;line-height: 35px;">项目经营目标</h2>
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
					<div class="query_module layui-form layui-row" style="position: relative">
						<div class="layui-col-xs2">
							<input type="text" name="itemNo" placeholder="预算科目编号" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="budgetName" placeholder="科目名称" autocomplete="off" class="layui-input">
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
							<button type="button" class="layui-btn layui-btn-sm">高级查询</button>
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
							<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧子项目</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script type="text/html" id="toolbarHead">
		    <div class="layui-btn-container" style="height: 30px;">
		        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
		    </div>
		    <div style="position:absolute;top: 10px;right:60px;">
			    <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
		        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
		        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
				<div class="export_moudle">
					<p class="export_btn" type="1">导出所选数据</p>
					<p class="export_btn" type="2">导出当前页数据</p>
					<p class="export_btn" type="3">导出全部数据</p>
				</div>
		    </div>
		</script>

		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-xs" lay-event="edit">编制</a>
			<a class="layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
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
				itemNo: {field: 'itemNo', title: '预算科目编号',minWidth:120, sort: true, hide: false},
				projId: {
					field: 'projName', title: '所属项目', minWidth:100,sort: true, hide: false,
				},
				wbsId: {
					field: 'wbsId', title: 'WBS',minWidth:150, hide: false, templet: function (d) {
						if (d.plbProjWbs && d.plbProjWbs.wbsName) {
							return d.plbProjWbs.wbsName;
						} else {
							return '';
						}
					}
				},
				rbsId: {
					field: 'rbsId', minWidth: 150, title: 'RBS', hide: false, templet: function (d) {
						if (d.plbRbs) {
							return d.plbRbs.rbsName || '';
						} else {
							return '';
						}
					}
				},
				cbsId: {
					field: 'cbsId', title: 'CBS',minWidth:100, hide: false, templet: function (d) {
						if (d.plbCbsTypeWithBLOBs && d.plbCbsTypeWithBLOBs.cbsName) {
							return d.plbCbsTypeWithBLOBs.cbsName;
						} else {
							return '';
						}
					}
				},
				itemUnit:{
					field:'itemUnit',minWidth:80,title:'单位',sort:false,hide:false,templet:function (d) {
						return dictionaryObj['CBS_UNIT']['object'][d.itemUnit]||'';
					}
				},
				controlType: {
					field: 'controlType', minWidth: 110, title: '控制类型', sort: true, hide: false, templet: function (d) {
						return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
					}
				},
				runTarAmount:{
					field:'runTarAmount',minWidth:110,title:'经营目标金额',sort:true,hide:false,templet:function(d){
						if(d.plbProjBudgetWithBLOBs&&d.plbProjBudgetWithBLOBs.runTarAmount){
							return d.plbProjBudgetWithBLOBs.runTarAmount;
						}else {
							return '0';
						}
					}
				},
				approvalStatusOpt: {
					field: 'approvalStatusOpt', title: '状态', minWidth:80,sort: true, hide: false, templet: function (d) {
						if (d.approvalStatusOpt == '1') {
							return '<span style="color: orange">审批中</span>';
						} else if (d.approvalStatusOpt == '2') {
							return '<span style="color: green">批准</span>';
						} else if (d.approvalStatusOpt == '3') {
							return '<span style="color: red">不批准</span>';
						} else {
							return '未提交';
						}
					}
				},
            }

            var TableUIObj = new TableUI('plb_proj_budget');

			// 获取数据字典数据
			var dictionaryObj = {
				ITEM_TYPE: {},
				CONTROL_TYPE: {},
				CBS_UNIT: {}
			}
			var dictionaryStr = 'ITEM_TYPE,CONTROL_TYPE,CBS_UNIT';
			$.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
				if (res.flag) {
					for (var dict in dictionaryObj) {
						dictionaryObj[dict] = {object: {}, str: '<option value=""></option>'}
						if (res.object[dict]) {
							res.object[dict].forEach(function (item) {
								dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
								dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
							});
						}
					}
				}
			});

            layui.use(['form', 'laydate', 'table', 'soulTable', 'eleTree'], function () {
                var layForm = layui.form,
                    laydate = layui.laydate,
                    layTable = layui.table,
                    soulTable = layui.soulTable,
                    eleTree = layui.eleTree;

                layForm.render();

                var tableObj = null;
				TableUIObj.init(colShowObj, function() {
					$('.no_data').hide();
					$('.table_box').show();
					tableInit();
				});

                /* region 修改左侧项目名称 */
                var searchTimer = null;
                $('#search_project').on('input propertychange', function () {
                    clearTimeout(searchTimer);
                    searchTimer = null;
                    var val = $(this).val();
                    searchTimer = setTimeout(function () {
                        projectLeft(val);
                    }, 300);
                });
                $('.search_icon').on('click', function () {
                    projectLeft($('#search_project').val());
                });
                /* endregion */

                projectLeft();

                /**
                 * 左侧项目信息列表
                 * @param deptName 项目名称
                 */
                function projectLeft(projectName) {
                    projectName = projectName ? projectName : '';
                    var loadingIndex = layer.load();
                    $.get('/plbProj/getProjTreeData', {projectName: projectName}, function (res) {
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
                                    children: "child",
                                }
                            });
                        }
                    });
                }

                // 树节点点击事件
                eleTree.on("nodeClick(leftTree)", function (d) {
                    var currentData = d.data.currentData;
                    if (currentData.wbsId) {
                        $('#leftId').attr('projId', currentData.projId);
                        $('#leftId').attr('wbsId', currentData.wbsId);
                        $('#leftId').attr('wbsName', currentData.name);
                        $('.no_data').hide();
                        $('.table_box').show();
                        tableInit(currentData.wbsId);
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
                        tableInit($('#leftId').attr('wbsId'));
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
                // 普通表格头部工具条事件监听
                layTable.on('toolbar(tableObj)', function (obj) {
                    var checkStatus = layTable.checkStatus(obj.config.id);
                    switch (obj.event) {
                        case 'del':
                            if (checkStatus.data.length == 0) {
                                layer.msg('请选择需要删除的数据！', {icon: 0});
                                return false
                            }
                            var projBudgetIds = ''
                            checkStatus.data.forEach(function (v) {
								if (!(checkStatus.data[0].approvalStatusRun > 0)) {
									projBudgetIds += v.projBudgetId + ',';
								}
                            });
                            layer.confirm('确定删除该条数据吗？', function (index) {
                                $.post('/plbProjBudget/delete', {projBudgetIds: projBudgetIds}, function (res) {
                                    layer.close(index);
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
                        case 'submit':
							var loadIndex = layer.load();
							var projId = $('#leftId').attr('projId') || '';
							// approvalType 后台定义
							$.get('/plbProjBudget/judgeProjectApproval', {projId: projId, approvalType: '08'}, function (res) {
								layer.close(loadIndex);
								if (res.data) {
									layer.msg('该项目已提交！', {icon: 0});
								} else {
									layer.open({
										type: 1,
										title: '选择流程',
										area: ['70%', '80%'],
										btn: ['确定', '取消'],
										btnAlign: 'c',
										content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
										success: function () {
											// 数据字典  FLOW_SETTING
											$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '14'}, function (res) {
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
												// approvalType 数据字典 RELATION_APPROVAL_PAGE
												var urlParameter = 'projId=' + projId + '&approvalType=06'
												newWorkFlow(flowData.flowId, urlParameter, function (res) {
													$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

													$.get('/plbProjBudget/approval', {
														projId: projId,
														runId: res.flowRun.runId,
														approvalType: '08' // approvalType 后台定义
													}, function (res) {
														layer.closeAll();
														if (res.flag) {
															layer.msg('提交审批成功！', {icon: 1});
															tableObj.config.where._ = new Date().getTime();
															tableObj.reload();
														} else {
															layer.msg('提交审批失败！', {icon: 2});
														}
													});
												});
											} else {
												layer.close(loadIndex);
												layer.msg('请选择一项！', {icon: 0});
											}
										}
									});
								}
							});
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
                        iframeLayerIndex = layer.open({
                            type: 2,
                            title: '查看详情',
                            area: ['100%', '100%'],
                            content: '/plbProj/projectBudgetDetail?budgetType=2&disabled=1&budgetItemId=' + data.budgetItemId
                        });
                    } else if (layEvent === 'edit') {
						if (data.approvalStatusRun > 0) {
							layer.msg('该项目已提交！', {icon: 0});
							return false;
						}

						$.get('/plbBudgetItem/getBudgetByItemId', {itemId: data.budgetItemId}, function (res) {
							if (res.flag) {
								if (res.data.plbProjBudgetWithBLOBs) {
									var plbData=res.data.plbProjBudgetWithBLOBs;
									plbData["itemUnit"]=res.data.itemUnit;
									newOrEdit(2, res.data.plbProjBudgetWithBLOBs);
								} else {
									newOrEdit(1, res.data);
								}
							} else {
								layer.msg('获取信息失败！', {icon: 0});
							}
						});
					}
                });

                /**
                 * 加载表格方法
                 */
                function tableInit(wbsId) {
					var searchObj = getSearchObj();
					searchObj.wbsId = wbsId || '';
					searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
					searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                    var cols = [{checkbox: true}].concat(TableUIObj.cols);

                    cols.push({
                        fixed: 'right',
                        align: 'center',
                        toolbar: '#barDemo',
                        title: '操作',
                        width: 140
                    });

                    var option = {
                        elem: '#tableObj',
                        url: '/plbProjBudget/getDataByCondition',
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
                 * @param type 类型(1-新增，2-编辑)
                 * @param data 编辑时的信息
                 */
                function newOrEdit(type, data) {
                    var title = '';
                    var url = '';
                    if (type == 1) {
                        title = '新建';
                        url = '/plbProjBudget/insert';
                    } else if (type == 2) {
                        title = '编辑';
                        url = '/plbProjBudget/update';
                    }

                    layer.open({
                        type: 1,
                        title: title,
                        area: ['80%', '90%'],
                        btn: ['保存', '取消'],
	                    btnAlign: 'c',
                        content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
                            '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                            /* region 第一行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">预算编号<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="budgetNo" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">项目名称<span class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="projectName" id="projectName" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">预算名称<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="budgetName" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">单位</label>' +
							'<div class="layui-input-block form_block">' +
							'<select disabled name="itemUnit"></select>' +
							'</div>' +
							'</div>' +
							'</div>',
                            '</div>',
                            /* endregion */
                            /* region 第二行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">收入目标数量<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="incomeTarNum" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">收入目标单价</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="incomeTarPrice" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
	                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">收入目标金额<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="incomeTarAmount" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">收入目标说明</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="incomeTarExplain" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '</div>',
                            /* endregion */
                            /* region 第三行 */
                            '<div class="layui-row">' +
	                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">经营目标收入金额</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="runTarNum" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">经营目标利润金额</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="runTarPrice" autocomplete="off" minusFlag="1" pointFlag="1" pointNum="3" handleCallback="afterFloatChange" class="layui-input input_floatNum">' +
							'</div>' +
							'</div>' +
							'</div>',
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">经营目标说明</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="runTarExplain" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">编制日期<span field="planDate" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="planDate" readonly autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
                            '</div>',
                            /* endregion */
	                        /* region 第四行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs3" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">备注</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<textarea name="remarks" placeholder="请输入内容" class="layui-textarea" style="min-height: 38px;height: 38px"></textarea>' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-row">' +
							'<div class="layui-col-xs12" style="padding: 0 5px;">' +
							'<div class="layui-form-item">\n' +
							'<label class="layui-form-label form_label">经营目标附件</label>' +
							'<div class="layui-input-block form_block">' +
							'<div class="file_module">' +
							'<div id="fileContentTar" class="file_content"></div>' +
							'<div class="file_upload_box">' +
							'<a href="javascript:;" class="open_file">' +
							'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
							'<input type="file" multiple id="fileuploadTar" data-url="/upload?module=planbudget" name="file">' +
							'</a>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>' +
							'</div>'+
							'</div>',
                            // '<div class="layui-col-xs12" style="padding: 0 5px;">' +
                            // '<div class="layui-form-item">\n' +
                            // '<label class="layui-form-label form_label">附件</label>' +
                            // '<div class="layui-input-block form_block">' +
                            // '<div class="file_module">' +
                            // '<div id="fileContent" class="file_content"></div>' +
                            // '<div class="file_upload_box">' +
                            // '<a href="javascript:;" class="open_file">' +
                            // '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            // '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                            // '</a>' +
                            // '</div>' +
                            // '</div>' +
                            // '</div>' +
                            // '</div>' +
                            // '</div>',
                            '</div>',
                            /* endregion */
                            '</form>',
                            '</div>'].join(''),
                        success: function () {
							if(data&&data.projId){
								//回显项目名称
								getProjName('#projectName',data.projId)
							}

                            fileuploadFn('#fileupload', $('#fileContent'));
							fileuploadFn('#fileuploadTar', $('#fileContentTar'));
							$('select[name="itemUnit"]', $('#baseForm')).html(dictionaryObj['CBS_UNIT']['str']);
                            layForm.render();

	                        if (type == 2) {
	                            layForm.val("baseForm", data);
								$('select[name="itemUnit"]', $('#baseForm')).val(dictionaryObj['CBS_UNIT']['str'][data.itemUnit]);
	                            // 经营目标附件
								$('#fileContentTar').html(getFileEleStr(data.attachmentTarList, true));

								// 附件
								$('#fileContent').html(getFileEleStr(data.attachmentList, true));
	                        } else {
                                layForm.val("baseForm", {
                                    "budgetNo": data.itemNo,
                                    "budgetName": data.itemName,
									"itemUnit": data.itemUnit
                                });
	                        }
                        },
                        yes: function (index) {
                            var loadIndex = layer.load();
                            var datas = $('#baseForm').serializeArray();
                            var obj = {}
                            datas.forEach(function (item) {
                                obj[item.name] = item.value;
                            });

							// 经营目标附件
							var attachmentTarId = '';
							var attachmentTarName = '';
							for (var i = 0; i < $('#fileContentTar .dech').length; i++) {
								attachmentTarId += $('#fileContentTar .dech').eq(i).find('input').val();
								attachmentTarName += $('#fileContentTar a').eq(i).attr('name');
							}
							obj.attachmentTarId = attachmentTarId;
							obj.attachmentTarName = attachmentTarName;

                            // 附件
                            var attachmentId = '';
                            var attachmentName = '';
                            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                attachmentName += $('#fileContent a').eq(i).attr('name');
                            }
                            obj.attachmentId = attachmentId;
                            obj.attachmentName = attachmentName;

							// 判断必填项
							var requiredFlag = false;
							$('#baseForm').find('.field_required').each(function(){
								var field = $(this).attr('field');
								if (field && !obj[field] && obj[field] != '0') {
									var fieldName = $(this).parent().text().replace('*', '');
									layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
									requiredFlag = true;
									return false;
								}
							});

							if (requiredFlag) {
								layer.close(loadIndex);
								return false;
							}

                            if (type == 2) {
                                obj.projBudgetId = data.projBudgetId;
                            } else {
                                obj.budgetItemId = data.budgetItemId;
                                obj.cbsId = data.cbsId;
                                obj.projId = data.projId;
                            }

                            $.post(url, obj, function (res) {
                                layer.close(loadIndex);
                                if (res.flag) {
                                    layer.msg('保存成功！', {icon: 1});
                                    layer.close(index);
                                    tableObj.config.where._ = new Date().getTime();
                                    tableObj.reload();
                                } else {
                                    layer.msg('保存失败！', {icon: 2});
                                }
                            });
                        }
                    });
                }

				// 查询
				$('#searchBtn').on('click', function(){
					tableInit($('#leftId').attr('wbsId') || '');
				});

				/**
				 * 获取查询条件
				 */
				function getSearchObj() {
					var searchObj = {
						itemNo: $('input[name="itemNo"]', $('.query_module')).val(),
						budgetName: $('input[name="budgetName"]', $('.query_module')).val(),
						approvalStatus: $('select[name="approvalStatus"]', $('.query_module')).val()
					}

					return searchObj;
				}

				/*region 导出 */
				$(document).on('click', function () {
					$('.export_moudle').hide();
				});
				$(document).on('click', '.export_btn', function () {
					var type = $(this).attr('type');
					var fileName = '项目经营目标列表.xlsx';
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

			/**
			 * 输入内容回调
			 * @param value 输入内容
			 * @param ele dom节点
			 */
			function afterFloatChange (value, ele) {
				var name = $(ele).attr('name');

				if (name == 'runTarNum') {
					var price = checkFloatNum($('[name="runTarPrice"]', $('#baseForm')).val(), 3);

					var money = checkFloatNum(BigNumber(value).multipliedBy(price));

					$('[name="runTarAmount"]', $('#baseForm')).val(money);
				} else if (name == 'runTarPrice') {
					var count = checkFloatNum($('[name="runTarNum"]', $('#baseForm')).val(), 3);

					var money = checkFloatNum(BigNumber(value).multipliedBy(count));

					$('[name="runTarAmount"]', $('#baseForm')).val(money);
				}
			}

			/**
			 * 新建流程方法
			 * @param flowId
			 * @param urlParameter
			 * @param cb
			 */
			function newWorkFlow(flowId, urlParameter, cb) {
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
						urlParameter: urlParameter, // 封装所有参数 (内嵌页面)
						approvalType: '06', // 预算关联审批页面【数据字典配置 RELATION_APPROVAL_PAGE】(内嵌页面)
						//approvalData: approvalData, // (tab页面)
						isTabApproval: false // 是否为tab方式打开
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
			function getFileEleStr(fileList, isDel) {
				var fileStr = '';
				if (fileList && fileList.length > 0) {
					var delImg = isDel ? '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' : '';
					for (var i = 0; i < fileList.length; i++) {
						var fileExtension = fileList[i].attachName.substring(fileList[i].attachName.lastIndexOf(".") + 1, fileList[i].attachName.length);//截取附件文件后缀
						var attName = encodeURI(fileList[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
						var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
						var deUrl = fileList[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileList[i].size;

						fileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileList[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileList[i].attachName + '</a>' + delImg + '<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))" href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileList[i].aid + '@' + fileList[i].ym + '_' + fileList[i].attachId + ',"></div>';
					}
				}
				return fileStr;
			}
		</script>
	</body>
</html>
