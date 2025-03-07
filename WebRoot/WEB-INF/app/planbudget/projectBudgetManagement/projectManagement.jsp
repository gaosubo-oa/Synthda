<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/1
  Time: 17:12
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
		<title>项目信息</title>

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
		<script type="text/javascript" src="/js/planother/planotherUtil.js?2211202108301508"></script>
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
			<input type="hidden" id="leftId" class="layui-input">
			<div class="wrapper">
				<div class="wrap_left">
					<h2 style="text-align: center;line-height: 35px;">项目信息</h2>
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
							<input type="text" name="planNo" placeholder="项目编号" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="planName" placeholder="项目名称/简称" autocomplete="off" class="layui-input">
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
						<div class="table_box">
							<table id="tableObj" lay-filter="tableObj"></table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script type="text/html" id="toolbarHead">
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
<%--				<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>--%>
				<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
				<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="budgetControl">预算控制</button>
			</div>
			<div style="position:absolute;top: 10px;right:60px;">
				<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">计划系统导入</button>
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

		<script type="text/html" id="toolbarDemo">
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
			</div>
		</script>

		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
		</script>

		<script>
			var user_id = '';
			var orgIds = '';
			var tableIns
			var tipIndex = null
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text');
                tipIndex = layer.tips(tip, this);
            }, function () {
                layer.close(tipIndex);
            });

			// 表格显示顺序
            var colShowObj = {
                projNo: {field: 'projNo', title: '项目编号', sort: true, hide: false},
                projName: {field: 'projName', title: '项目名称', sort: true, hide: false},
                projAbbreviation: {field: 'projAbbreviation', title: '项目简称', sort: true, hide: false},
                // dutyDeptId: {
                //     field: 'dutyDeptId', title: '责任部门', sort: true, hide: false, templet: function (d) {
                //         return d.dutyDeptName || '';
                //     }
                // },
                contractMoney: {
                    field: 'contractMoney', title: '合同金额', sort: true, hide: false, templet: function (d) {
                        return numFormat(d.contractMoney);
                    }
                },
	            budgetAllMoney: {
                    field: 'budgetAllMoney', title: '预算收入目标', sort: true, hide: false, templet: function (d) {
                        return numFormat(d.budgetAllMoney);
                    }
                },
				decomposeLevel: {
					field: 'decomposeLevel', title: '允许分解层级', sort: true, hide: false, templet: function (d) {
						return dictionaryObj['DECOMPOSE_LEVEL']['object'][d.decomposeLevel] || '';
					}
				}
            }

            var TableUIObj = new TableUI('plb_proj');

            var dictionaryObj = {
                PROJ_TYPE: {},
				DECOMPOSE_LEVEL: {}
            }
            var dictionaryStr = 'PROJ_TYPE,DECOMPOSE_LEVEL';
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

            layui.use(['form', 'laydate', 'table', 'soulTable', 'eleTree', 'dropdown','element'], function () {
				var layForm = layui.form,
						laydate = layui.laydate,
						table = layui.table,
						eleTree = layui.eleTree,
						dropdown = layui.dropdown,
						soulTable = layui.soulTable,
						element = layui.element;
                layForm.render();

                var tableObj = null;

				TableUIObj.init(colShowObj, function () {
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
                function projectLeft(deptName) {
                    deptName = deptName ? deptName : '';
                    var loadingIndex = layer.load();
                    $.get('/plbOrg/selectAll', {deptName: deptName}, function (res) {
                        layer.close(loadingIndex);
                        if (res.flag) {
                            eleTree.render({
                                elem: '#leftTree',
                                data: res.obj,
                                highlightCurrent: true,
                                showLine: true,
                                defaultExpandAll: false,
                                request: {
                                    name: 'deptName',
                                    children: "orgList",
                                }
                            });
                        }
                    });
                }

                // 树节点点击事件
                eleTree.on("nodeClick(leftTree)", function (d) {
                    var currentData = d.data.currentData;
					$('#leftId').attr('deptId', currentData.deptId);
					$('#leftId').attr('deptName', currentData.deptName);
					tableInit(currentData.deptId);
                });

                // 监听排序事件
                table.on('sort(tableObj)', function (obj) {
                    var param = {
                        orderbyFields: obj.field,
                        orderbyUpdown: obj.type
                    }

                    TableUIObj.update(param, function () {
                        tableInit($('#leftId').attr('deptId') || '');
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
				table.on('toolbar(tableObj)', function (obj) {
					var checkStatus = table.checkStatus(obj.config.id);
					switch (obj.event) {
						case 'add': // 新增
							if (!$('#leftId').attr('deptId')) {
								layer.msg('请选择左侧部门！', {icon: 0, time: 2000});
								return false
							}
							addOrEdit(1);
							break;
						case 'del': // 删除
							layer.msg('删除');
							if (checkStatus.data.length == 0) {
								layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
								return false;
							}

							var projIds = '';

							checkStatus.data.forEach(function (item) {
								projIds += item.projId + ',';
							});

							layer.confirm('确定删除该条数据吗？', function (index) {
								$.post('/plbProj/delete', {projIds: projIds}, function (res) {
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
						case 'budgetControl': // 预算控制
							layer.msg('功能完善中');
							break;
						case 'submit': // 计划系统导入
							var deptId = $('#leftId').attr('deptId')
							var _this = $(this);
							if (!deptId) {
								layer.msg('请选择左侧项目');
								break;
							}
							layer.open({
								type: 1,
								title: '选择项目信息',
								area: ['100%', '100%'],
								maxmin: true,
								btn: ['确定导入', '取消导入'],
								btnAlign: 'c',
								content: ['<div class="container">',
									'<div class="wrapper">',
									'<div class="wrap_left" style="border-right: 1px solid #ccc;">' +
									'<div class="layui-form">' +
									'<div class="tree_module" style="top: 0;">' +
									'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
									'</div>' +
									'</div>' +
									'</div>',
									'<div class="wrap_right" style="padding-left: 10px;">' +
									'<div class="mtl_table_box" style="display: none;">' +
									'<table id="materialsTable" lay-filter="materialsTable"></table>' +
									'</div>' +
									'<div class="mtl_no_data" style="text-align: center;">' +
									'<div class="no_data_img" style="margin-top:12%;">' +
									'<img style="margin-top: 2%;" src="/img/noData.png">' +
									'</div>' +
									'<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧科目类型模板</p>' +
									'</div>' +
									'</div>',
									'</div></div>'].join(''),
								success: function () {
									// 获取左侧树
									function projectLeft() {
										$.get('/plcOrg/getTreeListByLoginer', function (res) {
											if (res.flag) {
												eleTree.render({
													elem: '#chooseMtlTree',
													data: res.object,
													highlightCurrent: true,
													showLine: true,
													request: {
														name: "contractorName", // 显示的内容
														key: "deptId", // 节点id
														children: 'orgList',
													}
												});
												orgIds = getTreeId(res.object);
												projectTable('', $('.layui-tab .layui-this', window.parent.document).attr('projectStatus'), orgIds)
												$('.mtl_no_data').hide();
												$('.mtl_table_box').show();
											}
										});
									}

									projectLeft()
									// 树节点点击事件
									eleTree.on("nodeClick(chooseMtlTree)", function (d) {
										//只有机构下能添加项目，部门下不能添加项目，开启权限可以添加项目
										if (d.data.currentData.projOrgId && d.data.currentData.isPermission == '1') {
											$('.mtl_no_data').hide();
											$('.mtl_table_box').show();
											var projectStatus = $('.layui-tab .layui-this', window.parent.document).attr('projectStatus')
											projectTable(d.data.currentData.projOrgId, projectStatus, orgIds)
											$('#leftId').attr('projOrgId', d.data.currentData.projOrgId)
											$('#leftId').attr('contractorName', d.data.currentData.contractorName)
											//判断是否可使用右侧按钮------只有在组织类型为总承包部（orgType为07）时，才可使用
											$('#isUse').val(d.data.currentData.orgType)
										}
									});

									//表格渲染
									function projectTable(projOrgId, projectStatus, orgIds) {
										tableIns = table.render({
											elem: '#materialsTable'
											, url: '/ProjectInfo/selectPro'
											, page: true //开启分页
											, limit: 50
											, height: $('.container').height() - 100
											, where: {
												projOrgId: projOrgId,
												projectStatus: projectStatus,
												_: new Date().getTime(),
												useFlag: true,
												orgIds: orgIds
											}
											// ,toolbar: '#toolbarDemo'
											// , defaultToolbar: ['filter']
											, cols: [[ //表头
												{type: 'checkbox'}
												// ,{field: 'orderId', title: '序号', }
												, {
													field: 'auditerStatus', title: '审批状态', width: 120, templet: function (d) {
														if (d.auditerStatus == 0) {
															return '待审批'
														} else if (d.auditerStatus == 1) {
															return '已批准'
														} else if (d.auditerStatus == 2) {
															return '未批准,请修改后重新提交'
														} else {
															return ''
														}
													}
												}
												, {field: 'projectNo', title: '项目编号', width: 150}
												, {field: 'projectName', title: '项目名称', width: 500, event: 'detail', style: 'cursor: pointer;color:blue'}
												, {field: 'projectAbbreviation', title: '项目简称', width: 200}
												// ,{field: 'projectCode', title: '项目编码',width:90 }
												, {field: 'projectPlace', title: '项目地点', width: 90}
												, {field: 'respectiveRegionName', title: '责任部门', width: 150}
												, {field: 'ownerUnitName', title: '业主单位', width: 90}
												// ,{field: 'ownerName', title: '业主联系人',width:100 }
												, {field: 'ownerPhone', title: '业主单位联系方式', width: 130}
												, {
													field: 'manageUnitName', title: '监理单位', width: 90, templet: function (d) {
														if (d.manageUnitList) {
															var manageUnitList = d.manageUnitList
															var manageUnitName = ''
															manageUnitList.forEach(function (item) {
																manageUnitName += item.dictName + ','
															})
															return manageUnitName
														} else {
															return ''
														}
													}
												}
												// ,{field: 'manageName', title: '监理联系人',width:100 }
												, {field: 'managePhone', title: '监理单位联系方式', width: 130}
												, {field: 'contractMoney', title: '合同总金额', width: 100}
												, {field: 'contractDuration', title: '计划工期', width: 100}
												, {
													field: 'statrtTime', title: '计划开始时间', width: 130, templet: function (d) {
														return format(d.statrtTime)
													}
												}
												, {
													field: 'endTime', title: '计划结束时间', width: 130, templet: function (d) {
														return format(d.endTime)
													}
												}
												, {field: 'projectManageName', title: '项目经理', width: 90}
												, {field: 'projectManagePhone', title: '经理联系电话', width: 130}
												// ,{field: 'projectChief', title: '项目总工',width:90}
												// ,{field: 'projectChiefPhone', title: '总工联系电话',width:130 }
												, {
													field: 'winningDate', title: '中标日期', width: 120, templet: function (d) {
														return format(d.winningDate)
													}
												}
												// ,{field: 'createUserName', title: '编制人',width:120 }
												/* ,{field: 'importantYn', title: '是否是公司重点',templet:function (d) {
                                                         if(d.importantYn=='0'){
                                                             return '否'
                                                         }else{
                                                             return '是'
                                                         }
                                                     }}
                                                 ,{field: 'contractMoney', title: '合同额', }
                                                 ,{field: 'ownerUnit', title: '业主单位', }
                                                 ,{field: 'manageUnit', title: '监理单位', }
                                                 ,{field: 'acceptStandard', title: '验收标准', }*/
												// ,{fixed: 'right',title: '操作',align:'center', toolbar: '#barDemo',width:260}
											]]
											, parseData: function (res) { //res 即为原始返回的数据
												return {
													"code": 0, //解析接口状态
													"count": res.count, //解析数据长度
													"data": res.data //解析数据列表
												};
											},
											done: function () {
												if ($('#isUse').val() != '07') {
													$('.noUse').css({
														'cursor': 'not-allowed',
														'background': '#C1C1C1'
													})
												}
											}
										});
									}
								},
								yes: function (index) {
									var checkStatus = table.checkStatus('materialsTable');
									var dutyDeptId = $('#leftId').attr('deptId')
									if (checkStatus.data.length > 0) {
										var mtlData = checkStatus.data;
										var projectIds = '';
										mtlData.forEach(function (item) {
											projectIds += item.projectId + ',';
										});
										$.post('/plbProj/importByPlanCheck', {projectIds: projectIds, dutyDeptId: dutyDeptId}, function (res) {
											layer.close(index)
											if (res.flag) {
												layer.msg('导入成功！', {icon: 1});
												tableObj.reload();
											} else {
												layer.msg('导入失败！', {icon: 2});
											}
										});
									} else {
										layer.msg('请选择一项！', {icon: 0});
									}
								}
							});
							break;
						case 'import': // 导入
							layer.msg('功能完善中');
							break;
						case 'export': // 导出
							$('.export_moudle').show();
							break;
					}
				});
				table.on('tool(tableObj)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					if (layEvent === 'detail') {
						$.get('/plbProj/queryByProjId', {projId: data.projId}, function (res) {
							if (res.flag) {
								addOrEdit(3, res.data);
							} else {
								layer.msg('获取信息失败！', {icon: 0});
							}
						});
					} else if (layEvent === 'edit') {
						// 获取项目信息
						$.get('/plbProj/queryByProjId', {projId: data.projId}, function (res) {
							if (res.flag) {
								addOrEdit(2, res.data);
							} else {
								layer.msg('获取信息失败！', {icon: 0});
							}
						});
					}
				});

                /**
                 * 加载表格方法
                 */
                function tableInit(deptId) {
					var searchObj = getSearchObj();
					searchObj.dutyDeptId = deptId;
					searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
					searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

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
                        url: '/plbProj/queryAll',
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

                    tableObj = table.render(option);
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
                        url = '/plbProj/insert';
                    } else if (type == 2) {
                        title = '编辑项目';
                        url = '/plbProj/update';
                    } else if (type == 3) {
						title = '查看详情';
						btnArr = ['确定'];
					}
					var projListsData = []
					var plbProjTargetWithBLOBListData = []
                    layer.open({
                        type: 1,
                        title: title,
                        area: ['100%', '100%'],
                        btn: btnArr,
                        btnAlign: 'c',
                        content: ['<div class="layer_wrap _disabled" style="padding: 10px 15px;">',
                            '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                            /* region 第一行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">排序号<span field="sortNo" class="field_required">*</span><a title="刷新排序号" class="refresh_sort_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="sortNo" readonly autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目编号<span field="projNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="projNo" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目名称<span field="projName" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="projName" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目简称<span field="projAbbreviation" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="projAbbreviation" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目类型<span field="projType" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<select name="projType"></select>' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '</div>',
                            /* endregion */
                            /* region 第二行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">合同金额<span field="contractMoney" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="contractMoney" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">预算收入目标<span field="budgetAllMoney" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="budgetAllMoney" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">合同开始时间<span field="contractStartDate" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="contractStartDate" id="contractStartDate" readonly autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">合同完成时间<span field="contractEndDate" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="contractEndDate" id="contractEndDate" readonly autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">合同工期<span field="contractConstructionDays" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="contractConstructionDays" readonly autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '</div>',
                            /* endregion */
                            /* region 第三行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">允许分解层级<span field="decomposeLevel" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
							'<select name="decomposeLevel"></select>' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">业主单位<span field="ownerUnit" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" id="ownerUnit" readonly name="ownerUnit" style="cursor: pointer;" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">业主联系人<span field="ownerName" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="ownerName" readonly autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">业主联系电话<span field="ownerPhone" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="ownerPhone" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">所在单位</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="affiliatedUnitName" id="affiliatedUnit" autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
                            '</div>',
                            /* endregion */
                            /* region 第四行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目经理<span field="projManage" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="projManage" readonly id="projManage" autocomplete="off" class="layui-input" style="cursor: pointer;">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目经理电话<span field="projManagePhone" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="projManagePhone" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">项目地点<span field="projPlace" class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="projPlace" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            // '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            // '<div class="layui-form-item">' +
                            // '<label class="layui-form-label form_label">经度</label>' +
                            // '<div class="layui-input-block form_block">' +
                            // '<input type="text" name="longitude" autocomplete="off" class="layui-input">' +
                            // '</div>' +
                            // '</div>' +
                            // '</div>',
                            // '<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
                            // '<div class="layui-form-item">' +
                            // '<label class="layui-form-label form_label">纬度</label>' +
                            // '<div class="layui-input-block form_block">' +
                            // '<input type="text" name="latitude" autocomplete="off" class="layui-input">' +
                            // '</div>' +
                            // '</div>' +
                            // '</div>',
                            '</div>',
                            /* endregion */
							/* region 附件 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs12" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">附件</label>' +
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
							'</div>' +
							'</div>' +
							/* endregion */
                            '</form>'+
							'<div class="layui-collapse">\n' +
							/* region 项目基础信息 */
							'  <div class="layui-colla-item">\n' +
							'    <h2 class="layui-colla-title">项目基础信息</h2>\n' +
							'    <div class="layui-colla-content layui-show project_basic_information">' +
							'		<form class="layui-form" id="baseForm2" lay-filter="baseForm2">' +
							/* region 第一行 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">总用地面积(㎡)</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="number"  name="areaCovered" style="cursor: pointer;" autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">总建筑面积(㎡)</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="number" name="builtupArea" style="cursor: pointer;" autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">单体建筑数量</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="buildingsNumber" autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">建筑结构</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="buildingStructure" autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">补充说明</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="remark"  autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'</div>',
							/* endregion */
							'		</form>' +
							'    </div>\n' +
							'  </div>\n' +
							'  <div class="layui-colla-item">\n' +
							'    <h2 class="layui-colla-title">项目详细信息</h2>\n' +
							'    <div class="layui-colla-content layui-show project_detailed_information">' +
							'		<table id="detailedTable" lay-filter="detailedTable"></table>' +
							'    </div>\n' +
							'  </div>\n' +
							'  <div class="layui-colla-item">\n' +
							'    <h2 class="layui-colla-title">项目目标</h2>\n' +
							'    <div class="layui-colla-content layui-show project_objectives">' +
							'		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
							'    </div>\n' +
							'  </div>\n' +
							'  </div>\n' +
                            '</div>'].join(''),
                        success: function () {
							// 选择项目经理
							$('#projManage').on('click', function() {
								user_id = 'projManage';
								$.popWindow('/common/selectUser?0');
							});
                            fileuploadFn('#fileupload', $('#fileContent'));

							$('select[name="decomposeLevel"]').html(dictionaryObj['DECOMPOSE_LEVEL']['str']);
                            $('select[name="projType"]').html(dictionaryObj['PROJ_TYPE']['str']);

							if (type == 2 || type == 3) {
								layForm.val("baseForm", data);
								layForm.val("baseForm2", data);
								$('#ownerUnit').val(data.ownerUnitName);
								$('#ownerUnit').attr('ownerUnit', data.ownerUnit);

								$('#projManage').val(data.projManageName);
								$('#projManage').attr('user_id', data.projManage);

								$('#fileContent').html(getFileEleStr(data.attachmentList, type == 2));

								projListsData = data.projLists
								plbProjTargetWithBLOBListData = data.plbProjTargetWithBLOBList

							} else if (type == 1) {
								// 获取排序号
								getSortNumber({sotrNumber: 'plbProj'}, function(res) {
									$('input[name="sortNo"]', $('#baseForm')).val(res.data);
								});
								$('.refresh_sort_btn').show().on('click', function() {
									getSortNumber({sotrNumber: 'plbProj'}, function(res) {
										$('input[name="sortNo"]', $('#baseForm')).val(res.data);
									});
								});
								// 获取自动编号
								getAutoNumber({autoNumber: 'plbProj'}, function(res) {
									$('input[name="projNo"]', $('#baseForm')).val(res);
								});
								$('.refresh_no_btn').show().on('click', function() {
									getAutoNumber({autoNumber: 'plbProj'}, function(res) {
										$('input[name="projNo"]', $('#baseForm')).val(res);
									});
								});
							}

                            // 初始化开始时间
                            var contractStartDateConfig = {
                                elem: '#contractStartDate',
                                done: function (value, date) {
                                    if ($('#contractEndDate').val()) {
                                        var planPeriod = !!value ? timeRange(value, $('#contractEndDate').val()) + '天' : '';
                                        $('input[name="contractConstructionDays"]').val(planPeriod);
                                    }
                                    if (contractEndDate.config.min) {
                                        // 修改开始时间最大选择日期
                                        contractEndDate.config.min = {
                                            year: date.year || 1900,
                                            month: date.month - 1 || 0,
                                            date: date.date || 1,
                                        }
                                    } else {
                                        contractEndDateConfig.min = value;
                                    }
                                },
                                value: data ? format(data.contractStartDate) : '',
                                trigger: 'click' //采用click弹出
                            }
                            if (data && data.contractEndDate) {
                                contractStartDateConfig.max = data.contractEndDate;
                            }
                            var contractStartDate = laydate.render(contractStartDateConfig);

                            // 初始化结束时间
                            var contractEndDateConfig = {
                                elem: '#contractEndDate',
                                done: function (value, date) {
                                    if ($('#contractStartDate').val()) {
                                        var planPeriod = !!value ? timeRange($('#contractStartDate').val(), value) + '天' : '';
                                        $('input[name="contractConstructionDays"]').val(planPeriod);
                                    }
                                    if (contractStartDate.config.max) {
                                        // 修改开始时间最大选择日期
                                        contractStartDate.config.max = {
                                            year: date.year || 2099,
                                            month: date.month - 1 || 11,
                                            date: date.date || 31,
                                        }
                                    } else {
                                        contractStartDateConfig.max = value;
                                    }
                                },
                                value: data ? format(data.contractEndDate) : '',
                                trigger: 'click' //采用click弹出
                            }
                            if (data && data.contractStartDate) {
                                contractEndDateConfig.min = data.contractStartDate;
                            }
                            var contractEndDate = laydate.render(contractEndDateConfig);

							var cols = [
								{type: 'numbers', title: '序号'},
                                {
                                    field: 'buildingNumber', title: '楼号', minWidth: 100, templet: function (d) {
                                        return '<input projId="' + (d.projId || '') + '" projListId="'+(d.projListId || '')+'" type="text" name="buildingNumber" class="layui-input" style="height: 100%;" value="' + (d.buildingNumber || '') + '">'
                                    }
                                },
                                {
                                    field: 'buildingHeight', title: '高度', minWidth: 100, templet: function (d) {
                                        return '<input type="text" name="buildingHeight" class="layui-input" style="height: 100%;" value="' + (d.buildingHeight || '') + '">'
                                    }
                                },
                                {
                                    field: 'layersNumber', title: '层数', minWidth: 80, templet: function (d) {
                                        return '<input type="text" name="layersNumber" class="layui-input" style="height: 100%;" value="' + (d.layersNumber || '') + '">'
                                    }
                                },
                                {
                                    field: 'builtupArea', title: '建筑面积', minWidth: 120, templet: function (d) {
                                        return '<input type="text" name="builtupArea" class="layui-input" style="height: 100%;" value="' + (d.builtupArea || '') + '">'
                                    }
                                },
                                {
                                    field: 'onGroundArea', title: '地上面积', minWidth: 120, templet: function (d) {
                                        return '<input type="text" name="onGroundArea" class="layui-input" style="height: 100%;" value="' + (d.onGroundArea || '') + '">'
                                    }
                                },
                                {
                                    field: 'undergroundArea', title: '地下面积', minWidth: 120, templet: function (d) {
                                        return '<input type="text" name="undergroundArea" class="layui-input" style="height: 100%;" value="' + (d.undergroundArea || '') + '">'
                                    }
                                },
                                {
                                    field: 'manufacturingCost', title: '造价', minWidth: 100, templet: function (d) {
                                        return '<input type="text" name="manufacturingCost" class="layui-input" style="height: 100%;" value="' + (d.manufacturingCost || '') + '">'
                                    }
                                },
								{
									field: 'memo', title: '备注', minWidth: 200, templet: function (d) {
										return '<input type="text" name="memo" class="layui-input" style="height: 100%;" value="' + (d.memo || '') + '">'
									}
								}
							]

							var cols2 = [
								{type: 'numbers', title: '序号'},
								{
									field: 'targetNature', title: '目标性质', minWidth: 150, templet: function (d) {
										return '<span class="targetNature" projId="' + (d.projId || '') + '" projTargetId="'+(d.projTargetId || '')+'">' + (d.targetNature || '') + '</span>'
										// return '<input projId="' + (d.projId || '') + '" projTargetId="'+(d.projTargetId || '')+'" type="text" name="targetNature" class="layui-input" style="height: 100%;" value="' + (d.targetNature || '') + '">'
									}
								},
								{
									field: 'targetContent', title: '主要内容', minWidth: 160, templet: function (d) {
										return '<input type="text" name="targetContent" class="layui-input" style="height: 100%;" value="' + (d.targetContent || '') + '">'
									}
								},
								{
									field: 'targetExplain', title: '目标说明', minWidth: 160, templet: function (d) {
										return '<input type="text" name="targetExplain" class="layui-input" style="height: 100%;" value="' + (d.targetExplain || '') + '">'
									}
								}
							]

							//查看详情
							if(type!=3){
								cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100})
								// cols2.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100})
							}
							table.render({
								elem: '#detailedTable',
								data: projListsData||[],
								toolbar: type==3?false:'#toolbarDemo',
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols],
							});

							table.render({
								elem: '#objectivesTable',
								data: plbProjTargetWithBLOBListData.length>0?plbProjTargetWithBLOBListData:[{targetNature:'质量目标'},{targetNature:'安全目标'},{targetNature:'进度目标'},{targetNature:'成本目标'},{targetNature:'优化目标'},{targetNature:'经营目标'}],
								// toolbar: type==3?false:'#toolbarDemo',
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols2],
							});


                            if (type == 3) {
                            	$('._disabled [name]').attr('disabled', true);
                            	$('.open_file').hide();
							}
							element.render();
							layForm.render();
                        },
                        yes: function (index) {
                        	if(type == 3){
								layer.close(index);
								return
							}

                            var loadIndex = layer.load();
                            //主表数据
                            var datas = $('#baseForm').serializeArray();
                            var obj = {}
                            datas.forEach(function (item) {
                                obj[item.name] = item.value;
                            });
							obj.ownerUnit = $('input[name="ownerUnit"]', $('#baseForm')).attr('ownerUnit') || '';
							obj.affiliatedUnit = $('input[name="affiliatedUnitName"]', $('#baseForm')).attr('affiliatedUnit') || '';
                            obj.projManage = ($('input[name="projManage"]', $('#baseForm')).attr('user_id') || '').replace(/,$/, '');

                            // 附件
                            var attachmentId = '';
                            var attachmentName = '';
                            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                attachmentName += $('#fileContent a').eq(i).attr('name');
                            }
                            obj.attachmentId = attachmentId;
                            obj.attachmentName = attachmentName;

							var datas2 = $('#baseForm2').serializeArray();
							datas2.forEach(function (item) {
								obj[item.name] = item.value;
							});

                            // 判断必填项
							var requiredFlag = false;
							$('.layer_wrap').find('.field_required').each(function(){
								var field = $(this).attr('field');
								if (!obj[field] && obj[field] != '0') {
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
                                obj.projId = data.projId
                            } else {
                                // 新建时保存部门id
                                obj.dutyDeptId = $('#leftId').attr('deptId');
                            }

                            obj.projLists = subTableData().detailedData
							obj.plbProjTargetWithBLOBList = subTableData().objectivesData

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

				// 项目详细信息-加行
				table.on('toolbar(detailedTable)', function (obj) {
					switch (obj.event) {
						case 'add':
							//遍历表格获取每行数据进行保存
							var dataArr = subTableData().detailedData;
							dataArr.push({});
							table.reload('detailedTable', {
								data: dataArr
							});
							break;
					}
				});
				// 项目详细信息-删行
				table.on('tool(detailedTable)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					var $tr = obj.tr;
					if (layEvent === 'del') {
						if (data.projListId) {
							$.get('/plbProj/deleteProjList', {ids: data.projListId}, function (res) {
								if (res.flag) {
									layer.msg('删除成功!', {icon: 1, time: 2000});
									obj.del();
									table.reload('detailedTable', {
										data: subTableData().detailedData
									});
								} else {
									layer.msg('删除失败!', {icon: 2, time: 2000});
								}
							});
						} else {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('detailedTable', {
								data: subTableData().detailedData
							});
						}
					}
				});

				// 项目详细信息-加行
				table.on('toolbar(objectivesTable)', function (obj) {
					switch (obj.event) {
						case 'add':
							//遍历表格获取每行数据进行保存
							var dataArr = subTableData().objectivesData;
							dataArr.push({});
							table.reload('objectivesTable', {
								data: dataArr
							});
							break;
					}
				});
				// 项目详细信息-删行
				table.on('tool(objectivesTable)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					var $tr = obj.tr;
					if (layEvent === 'del') {
						if (data.projTargetId) {
							$.get('/plbProj/deletProjTarget', {ids: data.projTargetId}, function (res) {
								if (res.flag) {
									layer.msg('删除成功!', {icon: 1, time: 2000});
									obj.del();
									table.reload('objectivesTable', {
										data: subTableData().objectivesData
									});
								} else {
									layer.msg('删除失败!', {icon: 2, time: 2000});
								}
							});
						} else {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('objectivesTable', {
								data: subTableData().objectivesData
							});
						}
					}
				})
				/**
				 * 获取子表数据数据
				 */
				//获取子表数据
				function subTableData() {
					//项目详细信息表
					//遍历表格获取每行数据
					var $trs = $('.project_detailed_information').find('.layui-table-main tr');
					var dataArr = [];
					$trs.each(function () {
						var dataObj = {
							projId: $(this).find('input[name="buildingNumber"]').attr('projId') || '',
							projListId: $(this).find('input[name="buildingNumber"]').attr('projListId') || '',
							buildingNumber: $(this).find('input[name="buildingNumber"]').val(),
							buildingHeight: $(this).find('input[name="buildingHeight"]').val(),
							layersNumber: $(this).find('input[name="layersNumber"]').val(),
							builtupArea: $(this).find('input[name="builtupArea"]').val(),
							onGroundArea: $(this).find('input[name="onGroundArea"]').val(),
							undergroundArea: $(this).find('input[name="undergroundArea"]').val(),
							manufacturingCost: $(this).find('input[name="manufacturingCost"]').val(),
							memo: $(this).find('input[name="memo"]').val()
						}
						dataArr.push(dataObj);
					});

					//项目目标表
					var $trs2 = $('.project_objectives').find('.layui-table-main tr');
					var dataArr2 = [];
					$trs2.each(function () {
						var dataObj = {
							projId: $(this).find('.targetNature').attr('projId') || '',
							projTargetId: $(this).find('.targetNature').attr('projTargetId') || '',
							targetNature: $(this).find('.targetNature').text(),
							targetContent: $(this).find('input[name="targetContent"]').val(),
							targetExplain: $(this).find('input[name="targetExplain"]').val()
						}
						dataArr2.push(dataObj);
					});

					return {
						detailedData: dataArr,
						objectivesData: dataArr2,
					}
				}


				//选择业主单位
				$(document).on('click', '#ownerUnit', function () {
					var $this = $(this);
					layer.open({
						type: 1,
						title: '选择业主单位',
						area: ['100%', '100%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="container" style="padding: 0;">',
							'<div class="wrapper">',
							'<div class="wrap_left">' +
							'<div class="layui-form">' +
							'<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
							'<div class="tree_module" style="top: 10px;">' +
							'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="wrap_right">' +
							'<div class="layui-form layui-row" id="customerQuery" style="margin-top: 10px;">' +
							'<div class="layui-col-xs2" style="margin-left: 15px;">'+
							'<input type="text" name="customerName" placeholder="客商单位名称/简称" autocomplete="off" class="layui-input">'+
							'</div>'+
							'<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">'+
							'<button type="button" class="layui-btn layui-btn-sm" id="searchCustomer">查询</button>'+
							'</div>'+
							'</div>'+
							'<div class="mtl_table_box">' +
							'<table id="materialsTable" lay-filter="materialsTable"></table>' +
							'</div>' +
							'</div>',
							'</div></div>'
						].join(''),
						success: function () {
							// 树节点点击事件
							eleTree.on("nodeClick(chooseMtlTree)", function (d) {
								var customerName = $('#customerQuery input[name="customerName"]').val();
								$('#searchCustomer').attr('typeNo', d.data.currentData.typeNo);
								loadMtlTable(d.data.currentData.typeNo, customerName);
							});

							loadMtlType();

							loadMtlTable();

							$('#searchCustomer').on('click', function () {
								var customerName = $('#customerQuery input[name="customerName"]').val();
								var typeNo = $(this).attr('typeNo') || '';
								loadMtlTable(typeNo, customerName);
							});

							function loadMtlType(typeNo) {
								typeNo = typeNo ? typeNo : '';
								// 获取左侧树
								$.get('/PlbCustomerType/treeList', function (res) {
									if (res.flag) {
										eleTree.render({
											elem: '#chooseMtlTree',
											data: res.data,
											highlightCurrent: true,
											showLine: true,
											defaultExpandAll: false,
											request: {
												name: "typeName",
												key: "typeNo",
												parentId: 'parentTypeId',
												isLeaf: "isLeaf",
												children: 'child',
											}
										});
									}
								});
							}

							function loadMtlTable(typeNo, customerName) {
								table.render({
									elem: '#materialsTable',
									url: '/PlbCustomer/getDataByCondition',
									where: {
										merchantType: typeNo || '',
										customerName: customerName || '',
										useFlag: true
									},
									page: {
										limit: 10,
										limits: [10]
									},
									toolbar: false,
									cols: [[ //表头
										{type: 'radio', title: '选择'},
										{field: 'customerNo', title: '客商编号'},
										{field: 'customerName', title: '客商单位名称'},
										{field: 'customerShortName', title: '客商单位简称'},
										{field: 'customerOrgCode', title: '组织机构代码'},
										{field: 'taxNumber', title: '税务登记号'},
										{field: 'accountNumber', title: '开户行账户'}
									]],
									parseData: function (res) {
										return {
											"code": 0,
											"data": res.data,
											"count": res.totleNum,
										}
									},
									request: {
										pageName: 'page',
										limitName: 'pageSize'
									},
								});
							}
						},
						yes: function (index) {
							var checkStatus = table.checkStatus('materialsTable');
							if (checkStatus.data.length > 0) {
								var mtlData = checkStatus.data[0];
								$this.attr("ownerUnit", mtlData.customerId);
								$this.val(mtlData.customerName);
								$('#baseForm input[name="ownerName"]').val(mtlData.contactPerson);
								$('#baseForm input[name="ownerPhone"]').val(mtlData.contactTelno);
								layer.close(index);
							} else {
								layer.msg('请选择一项！', {icon: 0});
							}
						}
					});
				})

                //所在单位
				$(document).on('click', '#affiliatedUnit', function () {
					layer.open({
						type: 1,
						title: '选择单位',
						area: ['70%', '80%'],
						maxmin: true,
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="container">',
							'<div class="wrapper">',
							'<div class="wrap_left" style="border-right: 1px solid #ccc;">' +
							'<div class="layui-form">' +
							'<div class="tree_module" style="top: 0;">' +
							'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="wrap_right" style="padding-left: 10px;">' +
							'<div class="mtl_table_box" style="display: none;">' +
							//查询
							'       <div class="layui-row inSearchContent">' +
							'             <div class="layui-col-xs4">\n' +
							'                  <input type="text" name="customerName" placeholder="收款人名称" autocomplete="off" class="layui-input">\n' +
							'             </div>\n' +
							'             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
							'                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
							'             </div>\n' +
							'       </div>'+
							'<table id="materialsTable" lay-filter="materialsTable"></table>' +
							'</div>' +
							'<div class="mtl_no_data" style="text-align: center;">' +
							'<div class="no_data_img" style="margin-top:12%;">' +
							'<img style="margin-top: 2%;" src="/img/noData.png">' +
							'</div>' +
							'<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
							'</div>' +
							'</div>',
							'</div></div>'].join(''),
						success: function () {
							// 获取左侧树
							$.get('/PlbCustomerType/treeList', function (res) {
								if (res.flag) {
									eleTree.render({
										elem: '#chooseMtlTree',
										data: res.data,
										highlightCurrent: true,
										showLine: true,
										defaultExpandAll: false,
										request: {
											name: 'typeName',
											children: "child",
										}
									});
								}
							});

							// 树节点点击事件
							eleTree.on("nodeClick(chooseMtlTree)", function (d) {
								$('.mtl_no_data').hide();
								$('.mtl_table_box').show();
								loadMtlTable(d.data.currentData.typeNo);
							});

							function loadMtlTable(merchantType) {
								materialsTable = table.render({
									elem: '#materialsTable',
									url: '/PlbCustomer/getDataByCondition',
									where: {
										merchantType: merchantType
									},
									page: true,
									response: {
										statusName: 'flag',
										statusCode: true,
										msgName: 'msg',
										countName: 'totleNum',
										dataName: 'data'
									},
									cols: [[
										{type: 'radio', title: '选择'},
										{field: 'customerNo', title: '客商编号', minWidth: 100},
										{field: 'customerName', title: '客商单位名称', minWidth: 150},
										{field: 'customerShortName', title: '客商单位简称', minWidth: 150},
										{field: 'customerOrgCode', title: '组织机构代码', minWidth: 150},
										{field: 'taxNumber', title: '税务登记号', minWidth: 150},
										{field: 'accountName', title: '开户行名称', minWidth: 150},
										{field: 'accountNumber', title: '开户行账户', minWidth: 150}
									]]
								});
							}
						},
						yes: function (index) {
							var checkStatus = table.checkStatus('materialsTable');
							if (checkStatus.data.length > 0) {
								var mtlData = checkStatus.data[0];
								$('#affiliatedUnit').val(mtlData.customerName)
								$('#affiliatedUnit').attr("affiliatedUnit",mtlData.customerId)
								layer.close(index);
							} else {
								layer.msg('请选择一项！', {icon: 0});
							}
						}
					});
				});

				//选择所在单位内侧查询
				$(document).on('click','.inSearchData',function () {
					var searchParams = {}
					var $seachData = $('.inSearchContent [name]')
					$seachData.each(function () {
						searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
					})
					materialsTable.reload({
						where: searchParams,
						page: {
							curr: 1 //重新从第 1 页开始
						}
					});
				});

                // 查询
				$('#searchBtn').on('click', function(){
					tableInit($('#leftId').attr('deptId') || '');
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
						projNo: $('input[name="planNo"]', $('.query_module')).val(),
						projectName: $('input[name="planName"]', $('.query_module')).val()
					}

					return searchObj
				}

				/*region 导出 */
				$(document).on('click', function () {
					$('.export_moudle').hide();
				});
				$(document).on('click', '.export_btn', function () {
					var type = $(this).attr('type');
					var fileName = '项目预算编制列表.xlsx';
					if (type == 1) {
						var checkStatus = table.checkStatus('tableObj');
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

            //计算工期
            function timeRange(beginTime, endTime) {
                var t1 = new Date(beginTime)
                var t2 = new Date(endTime)
                var time = t2.getTime() - t1.getTime()
                var days = parseInt(time / (1000 * 60 * 60 * 24)) + 1
                return days
            }
			function getTreeId(data) {
				var ids = ''
				if (data.length > 0) {
					data.forEach(function(item){
						if (item.isPermission == '1') {
							ids += item.projOrgId + ',';
						}
						if (item.orgList && item.orgList.length > 0) {
							ids += getTreeId(item.orgList);
						}
					});
				}
				return ids;
			}

			/**
			 * 选人控件完成回调
			 * @param userId
			 */
			function archives (userId) {
				userId = userId.replace(/,$/, '');
				$.get('/user/findUserByuserId', {userId: userId}, function (res) {
					if (res.flag) {
						$('#baseForm [name="projManagePhone"]').val(res.object.mobilNo);
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
