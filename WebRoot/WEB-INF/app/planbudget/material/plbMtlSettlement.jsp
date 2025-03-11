<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/1/25
  Time: 16:41
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
		<title>材料结算</title>

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
		<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>

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
			/*选中行样式*/
			.selectTr {
				background: #009688 !important;
				color: #fff !important;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId">
			<div class="wrapper">
				<div class="wrap_left">
					<h2>材料结算</h2>
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
							<input type="text" name="mtlSettleupNo" placeholder="结算单编号" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 10px;">
							<input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 10px;">
							<input type="text" name="customerName" placeholder="供应商单位名称" autocomplete="off" class="layui-input">
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
		        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
		        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
		        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
				<button class="layui-btn layui-btn-sm" lay-event="dayin">打印模板</button>
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

			var warehousingArr = [];



			var tipIndex = null;
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text');
                tipIndex = layer.tips(tip, this);
            }, function () {
                layer.close(tipIndex);
            });

            // 表格显示顺序
            var colShowObj = {
                mtlSettleupNo: {field: 'mtlSettleupNo', title: '结算单编号', sort: true, hide: false},
                customerName: {field: 'customerName', title: '供应商单位名称', sort: true, hide: false},
				projName:{field:'projName',title:'所属项目',sort:true,hide:false},
                contractName: {field: 'contractName', title: '合同名称', sort: true, hide: false},
                settlementDate: {
                    field: 'settlementDate', title: '结算日期', sort: true, hide: false, templet: function (d) {
                        return format(d.settlementDate);
                    }
                },
                settlementMoney: {
                    field: 'settlementMoney', title: '本次结算金额', sort: true, hide: false, templet: function (d) {
                        return numFormat(d.settlementMoney);
                    }
                },
				currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
				auditerStatus: {
					field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
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
	            remark: {field: 'remark', title: '备注', sort: true, hide: false}
            }

            var TableUIObj = new TableUI('plb_mtl_settleup');

			// 获取数据字典数据
			var dictionaryObj = {
				CONTRACT_TYPE: {},
				CBS_UNIT:{},
				TAX_RATE:{}
            }
            var dictionaryStr = 'CONTRACT_TYPE,CBS_UNIT,TAX_RATE';
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

			var tableObj = null;

			layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree'], function () {
			    var form = layui.form,
				    laydate = layui.laydate,
				    table = layui.table,
				    layElement = layui.element,
				    soulTable = layui.soulTable,
				    eleTree = layui.eleTree;

			    
				TableUIObj.init(colShowObj, function(){
					// $('.no_data').hide();
					// $('.table_box').show();
					// tableInit();
				});

			    form.render();

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
                        $('#leftId').attr('projId', currentData.projId);
	                    $('#leftId').attr('projName', currentData.projAbbreviation);
                        $('.no_data').hide();
                        $('.table_box').show();
                        tableInit(currentData.projId);
                    } else {
                        $('.table_box').hide();
                        $('.no_data').show();
                    }
                });

                // 监听排序事件
                table.on('sort(tableObj)', function (obj) {
                    var param = {
                        orderbyFields: obj.field,
                        orderbyUpdown: obj.type
                    }

                    TableUIObj.update(param, function () {
                        tableInit($('#leftId').attr('projId') || '');
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
                // 普通表格头部工具条事件监听
                table.on('toolbar(tableObj)', function (obj) {
                    var checkStatus = table.checkStatus(obj.config.id);
					var dataTable=table.checkStatus(obj.config.id).data;
                    switch (obj.event) {
                        case 'add':
                        	if (!$('#leftId').attr('projId')) {
                        		layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
                        		return false;
							}
                            newOrEdit(1);
                            break;
                        case 'edit':
                            if (checkStatus.data.length != 1) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }

							if (checkStatus.data[0].auditerStatus > 0) {
								layer.msg('该条数据已提交，不可编辑！', {icon: 0});
								return false;
							}

							if($('#leftId').attr('projId')){
								var loadIndex = layer.load();
								$.get('/plbMtlSettleup/getSettleupByRunId', {kayId:checkStatus.data[0].mtlSettleupId}, function (res) {
									layer.close(loadIndex);
									newOrEdit(2, res.obj);
								});
							}else{
								layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
								return false;
							}

                         /*   $.get('/plbMtlSettleup/getDataByCondition', {mtlSettleupId: checkStatus.data[0].mtlSettleupId}, function(res) {
                                if (res.flag){
                                    newOrEdit(2, res.data[0]);
                                } else {
                                    layer.msg('获取信息失败！', {icon: 0});
                                }
                            });*/
                            break;
                        case 'del':
                            if (checkStatus.data.length == 0) {
                                layer.msg('请选择需要删除的数据！', {icon: 0});
                                return false
                            }
                            var mtlSettleupIds = ''
							var isFlay = false;

							checkStatus.data.forEach(function (v, i) {
								mtlSettleupIds += v.mtlSettleupId + ','
								if(v.auditerStatus&&v.auditerStatus!='0'){
									isFlay = true
								}
							})
							if(isFlay){
								layer.msg('已提交不可删除！', {icon: 0});
								return false
							}

                            layer.confirm('确定删除该条数据吗？', function (index) {
                                $.post('/plbMtlSettleup/delPlbMtlSettleup', {mtlSettleupIds: mtlSettleupIds}, function (res) {
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
							if (checkStatus.data.length != 1) {
								layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
								return false;
							}
							if(checkStatus.data[0].auditerStatus&&checkStatus.data[0].auditerStatus != '0'){
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
									$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '21'}, function (res) {
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
									var checkStatus = table.checkStatus('flowTable');
									if (checkStatus.data.length > 0) {
										var flowData = checkStatus.data[0];
										var approvalData = table.checkStatus(obj.config.id).data[0]
										delete approvalData.plbMtlSettleupLists;
										approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
										approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
										newWorkFlow(flowData.flowId, function (res) {
											var submitData = {
												mtlSettleupId:approvalData.mtlSettleupId,
												runId: res.flowRun.runId
												//auditerStatus:1
											}
											$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

											$.ajax({
												url: '/plbMtlSettleup/updatePlbMtlSettleup',
												data: JSON.stringify(submitData),
												dataType: 'json',
												contentType: "application/json;charset=UTF-8",
												type: 'post',
												success: function (res) {
													layer.close(loadIndex);
													if (res.flag) {
														layer.close(index);
														layer.msg('提交成功!', {icon: 1});
														tableObj.config.where._ = new Date().getTime();
														tableObj.reload()
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
							break;
                        case 'export':
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
									url:'/generateDocx/generateDocxByType?runId='+runId+'&type=mtlSettleup',
									success:function(res){
										if(res.flag){
											layer.close(index);
											if(res.obj.reportAttachmentList==undefined||res.obj.reportAttachmentList.length<1||res.obj.reportAttachmentList[0]==""){
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
				table.on('tool(tableObj)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					if (layEvent === 'detail') {
						var loadIndex = layer.load();
						$.get('/plbMtlSettleup/getSettleupByRunId', {kayId:data.mtlSettleupId}, function (res) {
							layer.close(loadIndex);
							newOrEdit(4,data)
						});
						/*layer.open({
							type: 2,
							title: '材料结算详情',
							area: ['100%', '100%'],
							btn: ['确定'],
							btnAlign: 'c',
							content: '/plbMtlSettleup/getPlbMtlSettlement?type=2&mtlSettleupId=' + data.mtlSettleupId,
							yes: function (index) {
								layer.close(index);
							}
						});*/
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
						url: '/plbMtlSettleup/getDataByCondition',
						toolbar: '#toolbarHead',
						cols: [cols],
						defaultToolbar: ['filter'],
						height: 'full-80',
						page: {
							limit: TableUIObj.onePageRecoeds,
							limits: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
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

                    tableObj = table.render(option);
                }

                // 内部加行按钮
                table.on('toolbar(detailTable)', function (obj) {

                	var mtlStockInData = [];
                	var _dataa = [];

                    switch (obj.event) {
                        case 'add':
							var projId = $('#leftId').attr('projId');
							if (!projId) {
								var checkStatus = table.checkStatus('tableObj');
								projId = checkStatus.data[0].projId;
							}
							var customerId = $('#customerName').attr('customerId');
							if(!customerId){
								layer.msg("请选择合同")
								return false;
							}
							var mtlStockInTable = null;
							var mtlStockInListTable = null;
							layer.open({
								type: 1,
								title: '选择材料入库单',
								btn: ['确定', '取消'],
								btnAlign: 'c',
								area: ['80%', '80%'],
								content: ['<div class="layui-collapse">',
									'<div class="layui-colla-item"><h2 class="layui-colla-title">结算入库单</h2>',
									'<div class="layui-colla-content layui-show mtlStockIn-class">',
									'<table id="mtlStockInTable" lay-filter="mtlStockInTable"></table>',
									'</div>',
									'</div>',
									'<div class="layui-colla-item"><h2 class="layui-colla-title">结算入库单明细</h2>',
									'<div class="layui-colla-content layui-show mtl_class">',
									'<table id="mtlStockInListTable" lay-filter="mtlStockInListTable"></table>',
									'</div>',
									'</div>',
									'</div>'].join(''),
								success: function () {
									layElement.render();

									mtlStockInTable = table.render({
										elem: '#mtlStockInTable',
										url: '/plbMtlStockIn/getDataByCondition',
										where: {
											projId: projId,
											module:"mtlSettlement",
											customerId:customerId,
											mtlContractId:$('#contractName').attr('contractId')
										},
										page: {
											limit: 100,
											limits: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
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
											{field: 'mtlStockInNo', title: '入库单编号', align: 'center'},
											{field: 'warehouseName', title: '仓库名称', align: 'center'},
											{field: 'customerName', title: '供应商名称', align: 'center'},
											{field: 'mtlContractName', title: '合同名称', align: 'center'},
											{field: 'stockInTotal', title: '入库总数量', align: 'center'},
											{field: 'stockInAmount', title: '入库总金额', align: 'center'},
											{field: 'stockInDate', title: '入库日期', align: 'center'}
										]],
										done:function(res){
											mtlStockInData=res.data;
											if(warehousingArr!=undefined&&warehousingArr.length>0){
												var mtlStockInIdsArr=[]
												var mtlStockInIds = ''
												warehousingArr.forEach(function (v) {
													if(!mtlStockInIdsArr.includes(v.mtlStockInId)){
														mtlStockInIdsArr.push(v.mtlStockInId)
														mtlStockInIds+=v.mtlStockInId+','
													}
												})

												for(var i = 0 ; i <mtlStockInData.length;i++){
													for(var n = 0 ; n < warehousingArr.length; n++){
														if(mtlStockInData[i].mtlStockInId == mtlStockInIdsArr[n]){
															$('.mtlStockIn-class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').click();
															//$('.mtlStockIn-class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').prop('checked', 'checked');
															form.render('checkbox');
														}
													}
												}
												var _flag = true
												$('.mtlStockIn-class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
													if(!$(item).find('.layui-form-checked').length>0){
														_flag = false
													}
												})
												if(_flag){
													if(!$('.mtlStockIn-class .layui-table-header .layui-form-checked').length>0){
														$('.mtlStockIn-class .layui-table-header input[type="checkbox"]').click();
														form.render('checkbox');
													}
												}

												laodMtlStockInListTable(mtlStockInIds);
											}
										}
									});

									table.on('checkbox(mtlStockInTable)', function (obj) {
										//obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
										//var checkStatus = table.checkStatus('mtlStockInTable').data
										var _mtlStockInId = obj.data.mtlStockInId

										var _flag = true
										$('.mtlStockIn-class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
											if(!$(item).find('.layui-form-checked').length>0){
												_flag = false
											}
										})
										if(_flag){
											if(!$('.mtlStockIn-class .layui-table-header .layui-form-checked').length>0){
												$('.mtlStockIn-class .layui-table-header input[type="checkbox"]').click();
												form.render('checkbox');
											}

										}

										var checkStatus=[];
										$('.mtlStockIn-class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
											if($(item).find('.layui-form-checked').length>0){
												checkStatus.push(mtlStockInData[index]);
											}
										})
										var mtlStockInIds = ''
										checkStatus.forEach(function (v) {
											mtlStockInIds+=v.mtlStockInId+','
										})
										//mtlClass()
										laodMtlStockInListTable(mtlStockInIds,_mtlStockInId);

									});

									table.on('checkbox(mtlStockInListTable)', function (obj) {
										var _flag = true
										$('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
											if(!$(item).find('.layui-form-checked').length>0){
												_flag = false
											}
										})
										if(_flag){
											if(!$('.mtl_class .layui-table-header .layui-form-checked').length>0){
												$('.mtl_class .layui-table-header input[type="checkbox"]').click();
												form.render('checkbox');
											}

										}
									});

									function laodMtlStockInListTable(mtlStockInIds,_mtlStockInId) {
										mtlStockInListTable = table.render({
											elem: '#mtlStockInListTable',
											url: '/plbMtlStockIn/getChildList',
											where: {
												mtlStockInIds: mtlStockInIds,
												overMark:"overMark"
											},
											height: 'full-350',
											limit: 10000,
											// page: {
											// 	limit: 100,
											// 	limits: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
											// },
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
												{type: 'checkbox', title: '选择',LAY_CHECKED:true},
												{field: 'orderNo', title: '订单编号', align: 'center', minWidth: 100},
												{
													field: 'wbsName', title: 'WBS', minWidth: 160, templet: function (d) {
														return '<span wbsId="' + undefind_nullStr(d.wbsId) + '">' + undefind_nullStr(d.wbsName) + '</span>';
													}
												},
												{
													field: 'rbsName', title: 'RBS', minWidth: 160, templet: function (d) {
														return '<span rbsId="' + undefind_nullStr(d.rbsId) + '">' + undefind_nullStr(d.rbsName) + '</span>';
													}
												},
												{
													field: 'cbsName', title: 'CBS', minWidth: 160, templet: function (d) {
														return '<span  cbsId="' + undefind_nullStr(d.cbsId) + '">' + undefind_nullStr(d.cbsName) + '</span>';
													}
												},
												{field: 'mtlName', title: '材料名称', align: 'center', minWidth: 100},
												{field: 'mtlStandard', title: '材料规格', align: 'center', minWidth: 100},
												{field: 'mtlValuationUnit', title: '单位', align: 'center', minWidth: 100,templet:function(d){
													  return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || ''
													}
												},
												{field: 'stockInQuantity', title: '入库数量', align: 'center', minWidth: 100},
												{field: 'stockInPrice', title: '含税单价', align: 'center', minWidth: 100},
												{field: 'noTaxPeice', title: '不含税单价', align: 'center', minWidth: 100},
												{field: 'taxMoney', title: '含税总价', align: 'center', minWidth: 100},
												{field: 'noTaxMoney', title: '不含税总价', align: 'center', minWidth: 100}
											]],
											done:function(res){
												_dataa=res.data;
												if(warehousingArr!=undefined&&warehousingArr.length>0){
													for(var i = 0 ; i <_dataa.length;i++){
														var _flag = true
														if(_mtlStockInId&&_dataa[i].mtlStockInId == _mtlStockInId){
															_flag = false
														}else{
															for(var n = 0 ; n < warehousingArr.length; n++){
																if(_dataa[i].stockInListId == warehousingArr[n].stockInListId){
																	_flag = false
																	// $('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").prop('checked', 'checked');
																}
															}
														}
														if(_flag){
															$('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').click();
															form.render('checkbox');
														}
													}
													var _flagg = false
													$('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
														if(!$(item).find('.layui-form-checked').length>0){
															_flagg = true
														}
													})
													if(_flagg){
														$('.mtl_class .layui-table-header input[type="checkbox"]').click();
														form.render('checkbox');
													}
												}


												// if(warehousingArr!=undefined&&warehousingArr.length>0){
												// 	for(var i = 0 ; i <_dataa.length;i++){
												// 		for(var n = 0 ; n < warehousingArr.length; n++){
												// 			if(_dataa[i].stockInListId == warehousingArr[n].stockInListId){
												// 				// $('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").prop('checked', 'checked');
												// 				$('.mtl_class .layui-table tr[data-index=' + i + '] input[type="checkbox"]').prop('checked', 'checked');
												// 				form.render('checkbox');
												// 			}
												// 		}
												// 	}
												// }

											}
										});
									}
								},
								yes: function (index) {
									//var checkStatus = table.checkStatus('mtlStockInListTable').data;
									var checkStatus=[];
									$('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
										if($(item).find('.layui-form-checked').length>0){
											checkStatus.push(_dataa[index]);
										}
									})
									warehousingArr = checkStatus
									//var checkStatus = mtlClass();
									//var checkMtlStockInTable = table.checkStatus('mtlStockInTable');



									for(var i = 0 ; i <mtlStockInData.length;i++){
										for(var n = 0 ; n < checkStatus.length; n++){
											if(mtlStockInData[i].mtlStockInId == checkStatus[n].mtlStockInId){
												checkStatus[n].mtlStockInNo = mtlStockInData[i].mtlStockInNo||''
												checkStatus[n].stockInDate = mtlStockInData[i].stockInDate||''
											}
										}
									}

									if (checkStatus.length > 0) {
										var newDataArr = [];
										var settlementMoney = 0;
										checkStatus.forEach(function(item) {
											var newDataObj = {
												mtlStockInNo:item.mtlStockInNo||'',//入库单编号
												orderNo:item.orderNo||'',//订单编号
												stockInDate:item.stockInDate||'',//入库日期
												stockInListId: item.stockInListId,
												mtlStandard: item.mtlStandard, // 材料规格
												mtlStockInId: item.mtlStockInId, // 材料规格
												mtlValuationUnit: item.mtlValuationUnit, // 单位
												mtlName: item.mtlName, // 材料名称
												wbsId: item.wbsId, // WBS id
												wbsName: item.wbsName, // WBS名称
												rbsId: item.rbsId, // RBS id
												rbsName: item.rbsName, // RBS名称
												cbsId: item.cbsId, // CBS id
												cbsName: item.cbsName, // CBS名称
												stockInQuantity: retainDecimal(item.stockInQuantity,3), // 入库数量
												taxPrice: retainDecimal(item.stockInPrice,3), // 含税单价
												noTaxMoney: retainDecimal(item.noTaxMoney,2), // 不含税总价
												taxMoney: retainDecimal(item.taxMoney,2), // 含税总价
												noTaxPrice: retainDecimal(item.noTaxPeice,8), // 不含税单价
												taxRate: dictionaryObj['TAX_RATE']['object'][item.taxRate]  // 税率
											}

											if (BigNumber(newDataObj.stockInQuantity).lt(0)) {
												newDataObj.stockInQuantity = 0;
											}
											if (BigNumber(newDataObj.taxPrice).lt(0)) {
												newDataObj.taxPrice = 0;
											}
											if (BigNumber(newDataObj.noTaxMoney).lt(0)) {
												newDataObj.noTaxMoney = 0;
											}
											if (BigNumber(newDataObj.taxMoney).lt(0)) {
												newDataObj.taxMoney = 0;
											}
											if (BigNumber(newDataObj.noTaxPrice).lt(0)) {
												newDataObj.noTaxPrice = 0;
											}
											settlementMoney = BigNumber(settlementMoney).plus(checkFloatNum(newDataObj.taxMoney));
											newDataArr.push(newDataObj);
										});

										//遍历表格获取每行数据进行保存
										/*var $tr = $('#detailModule').find('.layui-table-main tr');
										var oldDataArr = []
										$tr.each(function () {
											var oldDataObj = {
												mtlStockInNo:$(this).find('.mtl_info_mtlStockInNo').text()||'',//入库单编号
												stockInDate:$(this).find('.mtl_info_stockInDate').text()||'',//入库日期
												settleupListId: $(this).find('.mtl_info_mtlName').attr('settleupListId') || '', // 结算明细id
												stockInListId: $(this).find('.mtl_info_mtlName').attr('stockInListId') || '',
												wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId') || '', // WBS id
												wbsName: $(this).find('.mtl_info_wbsName').text(), // WBS名称
												rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId') || '', // RBS id
												rbsName: $(this).find('.mtl_info_rbsName').text(), // RBS名称
												cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId') || '', // CBS id
												cbsName: $(this).find('.mtl_info_cbsName').text(), // CBS名称
												mtlName: $(this).find('.mtl_info_mtlName').text(), // 材料名称
												mtlStandard: $(this).find('.mtl_info_mtlStandard').text(), // 材料规格
												mtlValuationUnit: $(this).find('.mtl_info_mtlValuationUnit').attr('mtlValuationUnit'), // 单位
												stockInQuantity: $(this).find('.mtl_info_stockInQuantity').text(), // 入库数量
												taxPrice: $(this).find('.mtl_info_taxPrice').text(), // 含税单价
												noTaxMoney: $(this).find('.mtl_info_noTaxMoney').text(), // 不含税总价
												taxMoney: $(this).find('.mtl_info_taxMoney').text(), // 含税总价
												noTaxPrice: $(this).find('.noTaxPrice').val(), // 不含税单价
												taxRate: $(this).find('.taxRate').val() // 税率
											}
											settlementMoney = BigNumber(settlementMoney).plus(checkFloatNum(oldDataObj.taxMoney));
											oldDataArr.push(oldDataObj);
										});*/

										/*for(var i = 0 ; i <newDataArr.length;i++){
											var _flay = true
											for(var n = 0 ; n < oldDataArr.length; n++){
												if(newDataArr[i].stockInListId == oldDataArr[n].stockInListId){
													_flay = false
												}
											}
											if(_flay){
												oldDataArr.push(newDataArr[i])
											}
										}*/

										$('[name="settlementMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));
										$('[name="confirmMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));

										table.reload('detailTable', {
											data: newDataArr,
											height: newDataArr&&newDataArr.length>5?'full-350':false
										});

										layer.close(index);
									} else {
										layer.msg('请选择一项！', {icon: 0, time: 2000});
									}
								}
							});
                            break;
                    }

					// function mtlClass(){
					// 	$('.mtl_class .layui-table-body .laytable-cell-checkbox').each(function(index,item){
					// 		if($(item).find('.layui-form-checked').length>0){
					// 			if(warehousingArr!=undefined&&warehousingArr.length>0){
					// 				var _flag = true
					// 				for(var j=0;j<warehousingArr.length;j++){
					// 					if(_dataa[index].stockInListId == warehousingArr[j].stockInListId){
					// 						_flag = false
					// 					}
					// 				}
					// 				if(_flag){
					// 					warehousingArr.push(_dataa[index]);
					// 				}
					// 			}else {
					// 				warehousingArr.push(_dataa[index]);
					// 			}
					// 		}else {
					// 			for(var j=0;j<warehousingArr.length;j++){
					// 				if(_dataa[index].stockInListId == warehousingArr[j].stockInListId){
					// 					warehousingArr.splice(j,1);
					// 				}
					// 			}
					// 		}
					// 	})
					// 	return warehousingArr
					// }
                });


                // 内部删行操作
                table.on('tool(detailTable)', function (obj) {
                    var data = obj.data;
                    var layEvent = obj.event;
                    var $tr = obj.tr;

                    if (layEvent === 'del') {
                        obj.del();
                        if (data.settleupListId) {
                            $.get('/plbMtlSettleup/delPlbMtlSettleupList', {settleupListIds: data.settleupListId}, function (res) {

                            });
                        }
                        //遍历表格获取每行数据进行保存
                        var $trs = $('#detailModule').find('.layui-table-main tr');
                        var oldDataArr = [];
                        var settlementMoney = 0;
                        $trs.each(function () {
                            var oldDataObj = {
								mtlStockInNo:$(this).find('.mtl_info_mtlStockInNo').text()||'',//入库单编号
								orderNo:$(this).find('.mtl_info_orderNo').text()||'',//订单编号
								stockInDate:$(this).find('.mtl_info_stockInDate').text()||'',//入库日期
								settleupListId: $(this).find('.mtl_info_mtlName').attr('settleupListId') || '', // 结算明细id
								stockInListId: $(this).find('.mtl_info_mtlName').attr('stockInListId') || '',
								mtlStockInId: $(this).find('.mtl_info_mtlName').attr('mtlStockInId') || '',
								wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId') || '', // WBS id
								wbsName: $(this).find('.mtl_info_wbsName').text(), // WBS名称
								rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId') || '', // RBS id
								rbsName: $(this).find('.mtl_info_rbsName').text(), // RBS名称
								cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId') || '', // CBS id
								cbsName: $(this).find('.mtl_info_cbsName').text(), // CBS名称
								mtlName: $(this).find('.mtl_info_mtlName').text(), // 材料名称
								mtlStandard: $(this).find('.mtl_info_mtlStandard').text(), // 材料规格
								mtlValuationUnit: $(this).find('.mtl_info_mtlValuationUnit').attr('mtlValuationUnit'), // 单位
								stockInQuantity: $(this).find('.mtl_info_stockInQuantity').text(), // 入库数量
								taxPrice: $(this).find('.mtl_info_taxPrice').text(), // 含税单价
								noTaxMoney: $(this).find('.mtl_info_noTaxMoney').text(), // 不含税总价
								taxMoney: $(this).find('.mtl_info_taxMoney').text(), // 含税总价
								noTaxPrice: $(this).find('.noTaxPrice').val(), // 不含税单价
								taxRate: $(this).find('.taxRate').val() // 税率
                            }

							settlementMoney = BigNumber(settlementMoney).plus(checkFloatNum(oldDataObj.taxMoney));
                            oldDataArr.push(oldDataObj);
                        });
                        table.reload('detailTable', {
                            data: oldDataArr,
							height: oldDataArr&&oldDataArr.length>5?'full-350':false
                        });
                        $('[name="settlementMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));
						$('[name="confirmMoney"]', $('#baseForm')).val(retainDecimal(settlementMoney,2));
                    }
                });

                /**
                 * 新增、编辑方法
                 * @param type 类型(1-新增，2-编辑)
                 * @param data 编辑时的信息
                 */
                function newOrEdit(type, data) {
                    var title = '';
                    var url = '';
                    var mtlSettleupId = '';
                    var projId = $('#leftId').attr('projId');
					//$('#leftId').attr('_type',type);
                    if (type == 1) {
                        title = '新增材料结算单';
                        url = '/plbMtlSettleup/addPlbMtlSettleup';
						warehousingArr = []
                    } else if (type == 2) {
                        title = '修改材料付款单';
                        url = '/plbMtlSettleup/updatePlbMtlSettleup';
						mtlSettleupId = data.mtlSettleupId;
						projId = data.projId;
						warehousingArr = data.plbMtlSettleupLists
                    }else if(type == '4'){
						title = '查看详情'
					}

                    layer.open({
                        type: 1,
                        title: title,
                        area: ['100%', '100%'],
                        btn: type != '4'?['保存','提交审批', '取消']:['确定'],
                        btnAlign: 'c',
                        content: ['<div class="layer_wrap _disabled"><div class="layui-collapse">',
                            /* region 基本信息 */
                            '<div class="layui-colla-item"><h2 class="layui-colla-title">基本信息</h2>' +
                            '<div class="layui-colla-content layui-show order_base_info"><form id="baseForm" class="layui-form" lay-filter="baseForm">',
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">结算单编号<span field="mtlSettleupNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" readonly name="mtlSettleupNo" autocomplete="off" style="background: #e7e7e7"class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">项目名称<span field="projName" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="projName" id="projName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="项目名称">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>' +
							'<input type="text" readonly name="contractName" id="contractName" autocomplete="off" style="background: #e7e7e7;cursor: pointer;" placeholder="请选择合同" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">供应商单位名称<span field="customerId" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerName" id="customerName" autocomplete="off" placeholder="供应商" style="background: #e7e7e7;cursor: pointer;" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">合同金额<span field="contractMoney" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="contractMoney" id="contractMoney" autocomplete="off" placeholder="合同金额" style="background: #e7e7e7;cursor: pointer;" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
                            '</div>',
							'<div class="layui-row">' +
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">累计已结算金额</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="subsettleupMoney" readonly autocomplete="off"  style="background: #e7e7e7" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">本次结算金额</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="settlementMoney" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">复核金额</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="confirmMoney" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>'+
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">结算日期<span field="settlementDate" class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" id="settlementDate" name="settlementDate" readonly autocomplete="off" style="cursor: pointer;" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs6" style="padding: 0 5px;">' +
							'<div class="layui-form-item">\n' +
							'<label class="layui-form-label form_label">结算年</label>\n' +
							'<div class="layui-input-block form_block">\n' +
							'<input type="text" id="settlementYear" name="settlementYear" autocomplete="off" class="layui-input">\n' +
							'</div>\n' +
							'</div>' +
							'</div>',
							'</div>',
							'<div class="layui-row">' +
							'<div class="layui-col-xs6" style="padding: 0 5px;">' +
							'<div class="layui-form-item">\n' +
							'<label class="layui-form-label form_label">结算季</label>\n' +
							'<div class="layui-input-block form_block">\n' +
							' <select name="settlementQuarter"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>' +
							'</div>\n' +
							'</div>' +
							'</div>' ,
							'<div class="layui-col-xs6" style="padding: 0 5px;">' +
							'<div class="layui-form-item">\n' +
							'<label class="layui-form-label form_label">结算月</label>\n' +
							'<div class="layui-input-block form_block">\n' +
							'<select name="settlementMonth">' +
							'<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>' +
							'<option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>' +
							'<option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>' +
							'</select>' +
							'</div>\n' +
							'</div>' +
							'</div>' ,
							'<div class="layui-col-xs6" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">备注</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="remark" autocomplete="off" class="layui-input">' +
							'</div>' +
							'</div>' +
							'</div>',
							'</div>',
							/* endregion */
							'           <div class="layui-row">' +
							'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
							'                   <div class="layui-form-item">\n' +
							'                       <label class="layui-form-label form_label">附件</label>' +
							'                       <div class="layui-input-block form_block">' +
							'<div class="file_module">' +
							'<div id="fileContent" class="file_content"></div>' +
							'<div class="file_upload_box">' +
							'<a href="javascript:;" class="open_file">' +
							'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件<span style="color:red;">*</span></span>' +
							'<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
							'</a>' +
							'<div class="progress" id="progress">' +
							'<div class="bar"></div>\n' +
							'</div>' +
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
							'  </div>\n',
							/* endregion */
                            /* region 材料结算明细 */
                            '<div class="layui-colla-item"><h2 class="layui-colla-title">材料结算明细</h2>' +
                            '<div class="layui-colla-content layui-show mtl_info">' +
                            '<div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>' +
                            '</div>' +
                            '</div>',
                            /* endregion */
                            '</div></div>'].join(''),
                        success: function () {

							//回显项目名称
							getProjName('#projName',projId?projId:data.projId)
							fileuploadFn('#fileupload', $('#fileContent'));

							laydate.render({
								elem: '#settlementDate' //指定元素
								, trigger: 'click' //采用click弹出
								, value: data ? format(data.settlementDate) : '',
								done:function (value, date, endDate) {
									$('#settlementYear').val(date.year)
									if(date.month <4){
										$('[name="settlementQuarter"]').val('1')
									}else if(date.month <7){
										$('[name="settlementQuarter"]').val('2')
									}else if(date.month <10){
										$('[name="settlementQuarter"]').val('3')
									}else{
										$('[name="settlementQuarter"]').val('4')
									}
									$('[name="settlementMonth"]').val(date.month)
									form.render()
								}
							});

							//年选择器
							laydate.render({
								elem: '#settlementYear'
								,type: 'year'
								, trigger: 'click' //采用click弹出
								, value: data ? data.settlementYear : ''
							});

                            var detailsTableData = [];

                            // 编辑时显示数据
                            if (type == 2||type == 4) {
                                form.val("baseForm", data);

                                $('#contractName').val(data.contractName || '');
                                $('#contractName').attr('contractId', data.contractId || '');
                                $('#customerName').val(data.customerName || '');
                                $('#customerName').attr('customerId', data.customerId || '');


								//附件
								if (data.attachments && data.attachments.length > 0) {
									var fileArr = data.attachments;
									$('#fileContent').append(echoAttachment(fileArr));
								}

                                detailsTableData = data.plbMtlSettleupLists || [];
                            } else {
								// 获取自动编号
								getAutoNumber({autoNumber: 'plbMtlSettleup'}, function(res) {
									$('input[name="mtlSettleupNo"]', $('#baseForm')).val(res);
								});
								$('.refresh_no_btn').show().on('click', function() {
									getAutoNumber({autoNumber: 'plbMtlSettleup'}, function(res) {
										$('input[name="mtlSettleupNo"]', $('#baseForm')).val(res);
									});
								});
							}

                            var cols = [
								{type: 'numbers', title: '序号'},
								{
									field: 'mtlStockInNo', title: '入库单编号', minWidth: 166, templet: function (d) {
										return '<span class="mtl_info_mtlStockInNo">' + undefind_nullStr(d.mtlStockInNo) + '</span>';
									}
								},
								{
									field: 'orderNo', title: '订单编号', minWidth: 160, templet: function (d) {
										return '<span class="mtl_info_orderNo">' + undefind_nullStr(d.orderNo) + '</span>';
									}
								},
								{
									field: 'wbsName', title: 'WBS', minWidth: 160, templet: function (d) {
										return '<span class="mtl_info_wbsName" wbsId="' + undefind_nullStr(d.wbsId) + '">' + undefind_nullStr(d.wbsName) + '</span>';
									}
								},
								{
									field: 'rbsName', title: 'RBS', minWidth: 160, templet: function (d) {
										return '<span class="mtl_info_rbsName" rbsId="' + undefind_nullStr(d.rbsId) + '">' + undefind_nullStr(d.rbsName) + '</span>';
									}
								},
								{
									field: 'cbsName', title: 'CBS', minWidth: 160, templet: function (d) {
										return '<span class="mtl_info_cbsName" cbsId="' + undefind_nullStr(d.cbsId) + '">' + undefind_nullStr(d.cbsName) + '</span>';
									}
								},
								{
									field: 'mtlName', title: '材料名称', width: 200, templet: function (d) {
										return '<span class="mtl_info_mtlName" settleupListId="' + undefind_nullStr(d.settleupListId) + '" stockInListId="' + undefind_nullStr(d.stockInListId) + '" mtlStockInId="' + undefind_nullStr(d.mtlStockInId) + '">' + undefind_nullStr(d.mtlName) + '</span>';
									}
								},
								{
									field: 'mtlStandard', title: '材料规格', width: 200, templet: function (d) {
										return '<span class="mtl_info_mtlStandard">' + (d.mtlStandard || '') + '</span>';
									}
								},
								{
									field: 'mtlValuationUnit', title: '单位', width: 200, templet: function (d) {
										return '<span class="mtl_info_mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'">' + (dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '') + '</span>';
									}
								},
								{
									field: 'stockInQuantity', title: '入库数量', minWidth: 120, templet: function (d) {
										var str = '<input type="hidden" class="noTaxPrice" value="' + (d.noTaxPrice || 0) + '">';
										str += '<input type="hidden" class="taxRate" value="' + (d.taxRate || 0) + '">'
										return '<span class="mtl_info_stockInQuantity">' + (d.stockInQuantity || 0) + str + '</span>';
									}
								},
								{
									field: 'taxPrice', title: '含税单价', minWidth: 120, templet: function (d) {
										return '<span class="mtl_info_taxPrice">' + (d.taxPrice || 0) + '</span>';
									}
								},
								{
									field: 'noTaxPrice', title: '不含税单价', minWidth: 120, templet: function (d) {
										return '<span class="noTaxPrice">' + (d.noTaxPrice || 0) + '</span>';
									}
								},
								{
									field: 'taxMoney', title: '含税总价', minWidth: 120, templet: function (d) {
										return '<span class="mtl_info_taxMoney">' + (d.taxMoney || 0) + '</span>';
									}
								},
								{
									field: 'noTaxMoney', title: '不含税总价', minWidth: 120, templet: function (d) {
										return '<span class="mtl_info_noTaxMoney">' + (d.noTaxMoney || 0) + '</span>';
									}
								},
								{
									field: 'stockInDate', title: '入库日期', minWidth: 160, templet: function (d) {
										return '<span class="mtl_info_stockInDate">' + undefind_nullStr(d.stockInDate) + '</span>';
									}
								}
							]
							//查看详情
							if(type!=4){
								cols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
							}

							table.render({
								elem: '#detailTable',
								data: detailsTableData,
								height: detailsTableData&&detailsTableData.length>5?'full-350':false,
								toolbar: type==4?false:'#toolbarDemoIn',
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols],
								done:function (obj) {
									if(type==4){
										$('.addRow').hide()
									}
									warehousingArr = obj.data
								}
							});

							//查看详情
							if(type==4){
								$('._disabled').find('input,select').attr('disabled', 'disabled');
								$('.file_upload_box').hide()
								$('.deImgs').hide()
							}
                            layElement.render();
							form.render()

                            // 选择供应商
							// $('#customerName').on('click', function() {
							// 	var $this = $(this);
							// 	layer.open({
							// 		type: 1,
							// 		title: '选择供应商',
							// 		area: ['100%', '100%'],
							// 		btn: ['确定', '取消'],
							// 		btnAlign: 'c',
							// 		content: ['<div class="container">',
							// 			'<div class="wrapper">',
							// 			'<div class="wrap_left" style="border-right: 1px solid #ccc;">' +
							// 			'<div class="layui-form">' +
							// 			'<div class="tree_module" style="top: 0;">' +
							// 			'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
							// 			'</div>' +
							// 			'</div>' +
							// 			'</div>',
							// 			'<div class="wrap_right" style="padding-left: 10px;">' +
							// 			'<div class="mtl_table_box" style="display: none;">' +
							// 			'<div class="layui-form layui-row" id="customerQuery" style="margin-top: 10px;">' +
							// 			'<div class="layui-col-xs1">' +
							// 			'<h3 style="line-height: 38px;">供应商</h3>' +
							// 			'</div>' +
							// 			'<div class="layui-col-xs2">' +
							// 			'<input type="text" name="customerName" placeholder="供应商名称/简称" autocomplete="off" class="layui-input">' +
							// 			'</div>' +
							// 			'<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">' +
							// 			'<button type="button" class="layui-btn layui-btn-sm" id="searchCustomer">查询</button></div>' +
							// 			'</div>' +
							// 			'<table id="materialsTable" lay-filter="materialsTable"></table>' +
							// 			'<div class="layui-form layui-row" id="contractQuery" style="margin-top: 10px;">' +
							// 			'<div class="layui-col-xs1">' +
							// 			'<h3 style="line-height: 38px;">合同</h3>' +
							// 			'</div>' +
							// 			'<div class="layui-col-xs2">' +
							// 			'<input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">' +
							// 			'</div>' +
							// 			'<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">' +
							// 			'<button type="button" class="layui-btn layui-btn-sm" id="searchContract">查询</button></div>' +
							// 			'</div>' +
							// 			'<table id="contractsTable" lay-filter="contractsTable"></table>' +
							// 			'</div>' +
							// 			'<div class="mtl_no_data" style="text-align: center;">' +
							// 			'<div class="no_data_img" style="margin-top:12%;">' +
							// 			'<img style="margin-top: 2%;" src="/img/noData.png">' +
							// 			'</div>' +
							// 			'<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧客商类型</p>' +
							// 			'</div>' +
							// 			'</div>',
							// 			'</div></div>'].join(''),
							// 		success: function () {
							// 			// 获取左侧树
							// 			$.get('/PlbCustomerType/treeList', function (res) {
							// 				if (res.flag) {
							// 					eleTree.render({
							// 						elem: '#chooseMtlTree',
							// 						data: res.data,
							// 						highlightCurrent: true,
							// 						showLine: true,
							// 						defaultExpandAll: false,
							// 						request: {
							// 							name: 'typeName',
							// 							children: "child",
							// 						}
							// 					});
							// 				}
							// 			});
							//
							// 			// 树节点点击事件
							// 			eleTree.on("nodeClick(chooseMtlTree)", function (d) {
							// 				$('.mtl_no_data').hide();
							// 				$('.mtl_table_box').show();
							// 				loadMtlTable(d.data.currentData.typeNo);
							// 				$('input[name="customerName"]', $('#customerQuery ')).val('');
							// 				$('#searchCustomer').attr('typeNo', d.data.currentData.typeNo);
							// 			});
							//
							// 			$('#searchCustomer').on('click', function() {
							// 				var typeNo = $('#searchCustomer').attr('typeNo') || '';
							// 				var customerName = $('input[name="customerName"]', $('#customerQuery ')).val();
							// 				loadMtlTable(typeNo, customerName);
							// 			});
							//
							// 			function loadMtlTable(merchantType, customerName) {
							// 				table.render({
							// 					elem: '#materialsTable',
							// 					url: '/PlbCustomer/getDataByCondition',
							// 					where: {
							// 						merchantType: merchantType,
							// 						customerName: customerName || ''
							// 					},
							// 					page: true,
							// 					response: {
							// 						statusName: 'flag',
							// 						statusCode: true,
							// 						msgName: 'msg',
							// 						countName: 'totleNum',
							// 						dataName: 'data'
							// 					},
							// 					cols: [[
							// 						{type: 'radio', title: '选择'},
							// 						{field: 'customerNo', title: '客商编号'},
							// 						{field: 'customerName', title: '客商单位名称'},
							// 						{field: 'customerShortName', title: '客商单位简称'},
							// 						{field: 'customerOrgCode', title: '组织机构代码'},
							// 						{field: 'taxNumber', title: '税务登记号'},
							// 						{field: 'accountNumber', title: '开户行账户'}
							// 					]]
							// 				});
							//
							// 				laodContractsTable('');
							// 			}
							//
							// 			table.on('radio(materialsTable)', function (obj) {
							// 				laodContractsTable(obj.data.customerId);
							// 				$('input[name="contractName"]', $('#contractQuery ')).val('');
							// 				$('#searchContract').attr('customerId', obj.data.customerId);
							// 			});
							//
							// 			$('#searchContract').on('click', function() {
							// 				var customerId = $('#searchContract').attr('customerId') || '';
							// 				var contractName = $('input[name="contractName"]', $('#contractQuery ')).val();
							// 				laodContractsTable(customerId, contractName);
							// 			});
							//
							// 			function laodContractsTable(customerId, contractName) {
							// 				table.render({
							// 					elem: '#contractsTable',
							// 					url: '/plbMtlContract/getAllContractByCustomerId',
							// 					where: {
							// 						customerId: customerId,
							// 						projId: projId,
							// 						contractName: contractName || ''
							// 					},
							// 					page: {
							// 						limit: 10,
							// 						limits: [10]
							// 					},
							// 					request: {
							// 						limitName: 'pageSize'
							// 					},
							// 					response: {
							// 						statusName: 'flag',
							// 						statusCode: true,
							// 						msgName: 'msg',
							// 						countName: 'totleNum',
							// 						dataName: 'data'
							// 					},
							// 					cols: [[
							// 						{type: 'radio', title: '选择'},
							// 						{field: 'contractNo', title: '合同编号', align: 'center', minWdith: 100},
							// 						{
							// 							field: 'contractName', title: '合同名称', align: 'center', minWdith: 100
							// 						},
							// 						{field: 'contractType', title: '合同类型', align: 'center', minWdith: 100, templet: function (d) {
							// 								return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
							// 							}},
							// 						{field: 'projName', title: '所属项目', minWdith: 160, align: 'center'},
							// 						{field: 'signDate', title: '合同签订日期', minWdith: 160, align: 'center'}
							// 					]]
							// 				});
							// 			}
							//
							// 			form.render()
							// 		},
							// 		yes: function (index) {
							// 			var checkStatus = table.checkStatus('materialsTable');
							// 			if (checkStatus.data.length > 0) {
							// 				var mtlData = checkStatus.data[0];
							// 				$this.val(mtlData.customerName);
							// 				$this.attr('customerId', mtlData.customerId);
							//
							// 				var checkContractsData = table.checkStatus('contractsTable');
							//
							// 				if (checkContractsData.data.length > 0) {
							// 					var contractsData = checkContractsData.data[0];
							// 					$('#contractName').val(contractsData.contractName);
							// 					$('#contractName').attr('contractId', contractsData.mtlContractId);
							// 					$('input[name="subsettleupMoney"]', $('#baseForm')).val(contractsData.settleupMoney||0);
							// 				}
							//
							// 				layer.close(index);
							// 			} else {
							// 				layer.msg('请选择一项！', {icon: 0});
							// 			}
							// 		}
							// 	});
							// });

							// 选择合同
							$('#contractName').on('click', function () {
								layer.open({
									type: 1,
									title: '选择合同',
									area: ['80%', '80%'],
									btn: ['确定', '取消'],
									btnAlign: 'c',
									content: ['<div style="padding: 10px;">' +
									'<div class="layui-form">' +
									'<div class="layui-form-item" style="margin: 0;">' +
									'<div class="layui-inline">'+
									'<div class="layui-input-inline">'+
									'<input type="text" id="contractNo" placeholder="合同编号" autocomplete="off" class="layui-input">'+
									'</div>'+
									'</div>'+
									'<div class="layui-inline">'+
									'<div class="layui-input-inline">'+
									'<input type="text" id="searchContractName" placeholder="合同名称" autocomplete="off" class="layui-input">'+
									'</div>'+
									'</div>'+
									'<div class="layui-inline">'+
									'<div class="layui-input-inline">'+
									'<input type="text" id="searchCustomerName" placeholder="供应商" autocomplete="off" class="layui-input">'+
									'</div>'+
									'</div>'+
									'<div class="layui-inline">'+
									'<button type="button" class="layui-btn layui-btn-sm" id="search_mtl">查询</button>'+
									'</div>'+
									'</div>' +
									'</div>' +
									'<table id="contractTable" lay-filter="contractTable"></table>' +
									'</div>'].join(''),
									success: function () {
										var contractTable = table.render({
											elem: '#contractTable',
											url: '/plbMtlContract/selectAll',
											where: {
												projId: projId,
												auditerStatusFlag:"auditerStatusFlag",
												useFlag:true
												// customerId: $('#customerName').attr('customerId') || ''
											},
											page: {
												limit: 10,
												limits: [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
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
											]]
										});
										$('#search_mtl').on('click', function() {
											contractTable.reload({
												where: {
													contractNo: $('#contractNo').val(),
													customerName: $('#searchCustomerName').val(),
													contractName: $('#searchContractName').val(),
													projId: projId,
													auditerStatusFlag:"auditerStatusFlag",
												},
												page: {
													curr: 1
												}
											});
										});
									},
									yes: function (index) {
										var checkStatus = table.checkStatus('contractTable');

										if (checkStatus.data.length > 0) {
											var chooseData = checkStatus.data[0];

											$('#contractName').val(chooseData.contractName);
											$('#contractName').attr('contractId', chooseData.mtlContractId);
											$('input[name="subsettleupMoney"]', $('#baseForm')).val(retainDecimal(chooseData.settleupMoney,2)||0);

											$('#customerName').val(chooseData.customerName || '');
											$('#customerName').attr('customerId', chooseData.customerId || '');

											$('#contractMoney').val(retainDecimal(chooseData.contractMoney,2) || 0);

											layer.close(index);
										} else {
											layer.msg('请选择一项！', {icon: 0, time: 2000});
										}
									}
								});
							});
                        },
                        yes: function (index) {
							if(type!='4'){
								var loadIndex = layer.load();

								var baseData = getSaveData(type, false, loadIndex, mtlSettleupId, projId).dataObj;
								$.ajax({
									url: url,
									data: JSON.stringify(baseData),
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
							}else {
								layer.close(index);
							}
                        },
						btn2: function (index) {
							// 提交前先保存
							var loadIndex = layer.load();
							var baseData = getSaveData(type, false, loadIndex, mtlSettleupId, projId);

							$.ajax({
								url: url,
								data: JSON.stringify(baseData.dataObj),
								dataType: 'json',
								contentType: "application/json;charset=UTF-8",
								type: 'post',
								success: function (res) {
									var approvalData = res.data;
									delete approvalData.plbMtlSettleupLists;
									approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
									approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
									layer.close(loadIndex);
									if (res.flag) {
										layer.close(index);
										layer.open({
											type: 1,
											title: '选择流程',
											area: ['70%', '80%'],
											btn: ['确定', '取消'],
											btnAlign: 'c',
											content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
											success: function () {
												$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '21'}, function (res) {
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
											yes: function (_index) {
												var checkStatus = table.checkStatus('flowTable');
												if (checkStatus.data.length > 0) {
													var flowData = checkStatus.data[0];
													newWorkFlow(flowData.flowId, function (res) {
														var submitData = {
															mtlSettleupId:approvalData.mtlSettleupId,
															runId: res.flowRun.runId
															//auditerStatus:1
														}
														$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

														$.ajax({
															url: "/plbMtlSettleup/updatePlbMtlSettleup",
															data: JSON.stringify(submitData),
															dataType: 'json',
															contentType: "application/json;charset=UTF-8",
															type: 'post',
															success: function (res) {
																layer.close(loadIndex);
																if (res.flag) {
																	layer.closeAll();
																	layer.msg('提交成功!', {icon: 1});
																	tableObj.config.where._ = new Date().getTime();
																	tableObj.reload();
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
									} else {
										layer.msg('保存失败！', {icon: 2});
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
						mtlSettleupNo: $('input[name="mtlSettleupNo"]', $('.query_module')).val(),
						contractName: $('input[name="contractName"]', $('.query_module')).val(),
						customerName: $('input[name="customerName"]', $('.query_module')).val(),
						auditerStatus: $('input[name="auditerStatus"]', $('.query_module')).val()
					}

					return searchObj
				}

				/**
				 * 获取需要保存的数据
				 * @param saveType (1-新增, 2-编辑)
				 * @param isSubmit (是否提交)
				 * @param loadIndex
				 * @param melOrderId
				 * @param projId
				 * @returns {boolean|{dataObj: {}, baseObj: {}}}
				 */
				function getSaveData(saveType, isSubmit, loadIndex, mtlSettleupId, projId) {
					// 基本信息
					var datas = $('#baseForm').serializeArray();
					var dataObj = {}
					datas.forEach(function (item,) {
						dataObj[item.name] = item.value;
					});

					dataObj.mtlContractId = $('#contractName').attr('contractId') || '';
					//dataObj.contractName = $('#contractName').val();
					dataObj.customerId = $('#customerName').attr('customerId') || '';
					dataObj.customerName = $('#customerName').val();

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent a').eq(3*i).attr('name');
					}
					if(attachmentId==''){
						layer.close(loadIndex);
						layer.msg("请上传附件");
						return false;
					}
					dataObj.attachmentId = attachmentId;
					dataObj.attachmentName = attachmentName;

					if (!isSubmit) {
						// 判断必填项
						var requiredFlag = false;
						$('#baseForm').find('.field_required').each(function(){
							var field = $(this).attr('field');
							if (field && !dataObj[field] && dataObj[field] != '0') {
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
					}

					var baseObj = JSON.parse(JSON.stringify(dataObj));

					// 材料结算明细数据
					var $tr = $('#detailModule').find('.layui-table-main tr');
					var plbMtlSettleupLists = [];
					$tr.each(function () {
						var plbMtlSettleupObj = {
							mtlStockInNo:$(this).find('.mtl_info_mtlStockInNo').text()||'',//入库单编号
							orderNo:$(this).find('.mtl_info_orderNo').text()||'',//订单编号
							stockInDate:$(this).find('.mtl_info_stockInDate').text()||'',//入库日期
							stockInListId: $(this).find('.mtl_info_mtlName').attr('stockInListId') || '',
							wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId') || '', // WBS id
							rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId') || '', // RBS id
							cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId') || '', // CBS id
							mtlOrderLisId: $(this).find('.mtl_info_mtlOrderLisId').attr('mtlOrderLisId') || '',
							mtlName: $(this).find('.mtl_info_mtlName').text(), // 材料名称
							mtlStandard: $(this).find('.mtl_info_mtlStandard').text(), // 材料规格
							mtlValuationUnit: $(this).find('.mtl_info_mtlValuationUnit').attr('mtlValuationUnit'), // 单位
							stockInQuantity: $(this).find('.mtl_info_stockInQuantity').text(), // 入库数量
							taxPrice: $(this).find('.mtl_info_taxPrice').text(), // 含税单价
							noTaxMoney: $(this).find('.mtl_info_noTaxMoney').text(), // 不含税总价
							taxMoney: $(this).find('.mtl_info_taxMoney').text(), // 含税总价
							noTaxPrice: $(this).find('.noTaxPrice').val(), // 不含税单价
							taxRate: $(this).find('.taxRate').val() // 税率
						}
						if ($(this).find('.mtl_info_mtlName').attr('settleupListId')) {
							plbMtlSettleupObj.settleupListId = $(this).find('.mtl_info_mtlName').attr('settleupListId');
						}
						plbMtlSettleupLists.push(plbMtlSettleupObj);
					});
					dataObj.plbMtlSettleupLists = plbMtlSettleupLists;

					if (saveType == 2) {
						dataObj.mtlSettleupId = mtlSettleupId;
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
					var fileName = '材料结算列表.xlsx';
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

			/**
			 * 新建流程方法
			 * @param flowId
			 * @param approvalData
			 * @param cb
			 */
			function newWorkFlow(flowId, cb,approvalData) {
				$.ajax({
					url: '/workflow/work/workfastAdd',
					type: 'post',
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
				tableObj.config.where._ = new Date().getTime();
				tableObj.reload()
			}
			//判断undefined
			function undefind_nullStr(value) {
				if(value==undefined || value == "undefined"){
					return ""
				}
				return value
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
