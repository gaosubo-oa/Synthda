<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/8/27
  Time: 11:35
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

		<title>关键任务考核</title>
		<meta charset="UTF-8">
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">

		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/eleTree.css">
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/treeTable.css">

		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>

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

			.item {
				font-size: 22px;
				margin-left: 10px;
				color: #494d59;
				margin-top: 2px
			}

			.query .layui-form-item {
				height: 35px;
				margin: 0;
				clear: none;
			}

			.query_item {
				float: left;
			}

			.query .layui-form-label {
				width: 80px;
				height: 35px;
				padding: 0 10px;
				line-height: 35px;
				box-sizing: border-box;
			}

			.query .layui-input-block {
				margin-left: 80px;
			}

			.query .layui-input-block input {
				height: 35px;
			}

			.sty {
				margin: 2px 0px 0px 52px;
			}

			.layui-table, .layui-table-view {
				margin: 0 0;
			}

			#leftHeight {
				height: 350px;
			}

			#questionTree li {
				border-bottom: 1px solid #ddd;
				line-height: 20px;
				padding: 5px 0 5px 10px;
				cursor: pointer;
				border-radius: 3px;
			}

			.select {
				background: #c7e1ff;
			}

			.planBtom {
				height: 1px;
				border: 0;
				clear: both;
			}

			.ew-tree-table-tool-right {
				display: none;
			}

			.distri {
				float: right;
			}

			.layui-icon-close {
				display: none;
			}

			.tree_table .ew-tree-table {
				margin: 0;
			}

			.divShow {
				position: relative;
			}

			.operationDiv {
				display: none;
				position: absolute;
				top: -40px;
				left: 5px;
				border-radius: 5px;
				background: #fff;
				box-shadow: 0 0 3px 1px rgba(0, 0, 0, .3);
			}

			.divShow:hover .operationDiv {
				display: block;
			}

			.td_title {
				background: #F2F2F2;
				width: 150px;
			}

			.layui-table-view .layui-table {
				width: 100%;
			}

		</style>

		<script type="text/javascript">
            var funcUrl = location.pathname;
            var authorityObject = null;
            if (funcUrl) {
                $.ajax({
                    type: 'GET',
                    url: '/plcPriv/findPermissions',
                    data: {
                        funcUrl: funcUrl
                    },
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        if (res.flag) {
                            if (res.object && res.object.length > 0) {
                                authorityObject = {}
                                res.object.forEach(function (item) {
                                    authorityObject[item] = item;
                                });
                            }
                        }
                    },
                    error: function () {

                    }
                });
            }
		</script>

	</head>
	<body>

		<div class="layui-fluid" style="height: 100%;">
			<input type="hidden" id="status" value="3">
			<div class="layui-row" style="height: 100%;">
				<div class="layui-tab layui-tab-brief" lay-filter="docDemo" style="position: relative;height: 100%;">
					<ul class="layui-tab-title target_tabs">
						<li class="layui-this" opttype="3">待考核<span class="tobeassesNum" style="color: red"></span></li>
						<li opttype="4">已考核</li>
					</ul>
					<div class="layui-tab-content" style="padding: 0px;position: absolute;top: 41px;right: 0;bottom: 0;left:0;">
						<div class="layui-tab-item layui-show" style="height: 100%;">
							<form class="layui-form clearfix query" style="padding: 5px 0;">
								<%--筛选查询--%>
								<div class="layui-row" style="padding: 5px 0;">
									<div class="layui-form-item layui-col-xs3">
										<label class="layui-form-label" style="width: 75px;padding: 0;line-height: 17.5px;">关键任务/子任务名称</label>
										<div class="layui-input-block">
											<input type="text" name="tgName" placeholder="关键任务/子任务名称" autocomplete="off" class="layui-input">
										</div>
									</div>
								<%--	<div class="layui-form-item layui-col-xs3">
										<label class="layui-form-label">项目名称</label>
										<div class="layui-input-block">
											<select name="belongtoProj" lay-verify="required">
												<option value="">请选择</option>
											</select>
										</div>
									</div>--%>
									<div class="layui-form-item layui-col-xs3">
										<label class="layui-form-label">所属单位</label>
										<div class="layui-input-block">
											<input type="text" name="belongtoDept" id="belongtoDept" placeholder="请选择" readonly
											       style="background-color: #e7e7e7;cursor: pointer;" class="layui-input">
										</div>
									</div>

									<div class="authority_search layui-col-xs3" style="display: none;">
										<button type="button" class="layui-btn layui-btn-sm more_query" isshow="0" style="margin-left: 40px">
											<i class="layui-icon layui-icon-down" style="margin: 0;"></i>
										</button>
										<button type="button" class="layui-btn layui-btn-sm search">查询</button>
										<button type="reset" class="layui-btn layui-btn-sm sty clear">重置</button>
									</div>
								</div>
								<div class="layui-row hide_query" style="display: none;padding: 5px 0;">
									<div class="layui-form-item layui-col-xs3">
										<label class="layui-form-label">计划类型</label>
										<div class="layui-input-block">
											<select name="planType">
												<option value="">请选择</option>
												<option value="1">主项计划</option>
												<option value="2">职能计划</option>
												<option value="3">计划子任务</option>
											</select>
										</div>
									</div>
									<div class="layui-form-item layui-col-xs3">
										<label class="layui-form-label">状态</label>
										<div class="layui-input-block">
											<select name="taskStatus">
												<option value="">请选择</option>
												<option value="0">未开始</option>
												<option value="1">进行中</option>
												<option value="2">将到期</option>
												<option value="4">已延期</option>
												<option value="5">完成</option>
												<option value="6">延期完成</option>
												<option value="7">暂停</option>
												<option value="8">关闭</option>
											</select>
										</div>
									</div>
									<div class="layui-form-item layui-col-xs3">
										<label class="layui-form-label">年度</label>
										<div class="layui-input-block">
											<select name="planYear" lay-filter="planYear">
												<option value="">请选择</option>
											</select>
										</div>
									</div>
									<div class="layui-form-item layui-col-xs3">
										<label class="layui-form-label">月度</label>
										<div class="layui-input-block">
											<select name="planMonth">
												<option value="">请选择</option>
											</select>
										</div>
									</div>
								</div>
							</form>
							<div class="table_list">
								<table id="tableList" lay-filter="tableList"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 已考核、未考核头部工具条 -->
		<script type="text/html" id="assessmentBar">
			<div style="position:absolute;right: 1%">
				{{# if(authorityObject && authorityObject['10']){ }}
				<a class="layui-btn layui-btn-sm distri" id="return" lay-event="return" style="margin-left: 15px;">退回</a>
				<a class="layui-btn layui-btn-sm distri" id="assessmentOver" lay-event="assessment" style="margin-left: 15px;">完成</a>
				{{# } }}
				<a class="layui-btn layui-btn-sm distri saveDistribute" lay-event="saveDistribute" style="margin-left: 15px;">保存</a>
				<a class="layui-btn layui-btn-sm" lay-event="export" >导出</a>
			</div>
		</script>

		<script type="text/javascript">
            /*整体保存的list*/
            var saveALLDataList = []

            resizeSize();

            var assessmentLock = false

            window.onresize = resizeSize;

            initAuthority();

            var dept_id = '';

            var dictionaryObj = {
                UNIT: {},
                CONTROL_LEVEL: {},
                TG_TYPE: {},
                PLAN_SYCLE: {},
                PLAN_PHASE: {},
                targetData: {},
                CGCL_TYPE: {}
            }
            var dictionaryStr = 'UNIT,CONTROL_LEVEL,TG_TYPE,PLAN_SYCLE,PLAN_PHASE,targetData,CGCL_TYPE';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                            });
                        }
                    }
                }
                // init();
            });

            var responsible = null;

            layui.use(['table', 'layer', 'form', 'element', 'treeTable'], function () {
                var table = layui.table,
                    form = layui.form,
                    layer = layui.layer,
                    element = layui.element;

                form.render();

                var tableList = null;

                // 选择所属单位
                $('#belongtoDept').on('click', function () {
                    dept_id = 'belongtoDept';
                    $.popWindow('/common/selectDept?0');
                });

                // 获取计划期间年度列表
                $.get('/planPeroidSetting/selectAllYear', function (res) {
                    var allYear = '';
                    if (res.object.length > 0) {
                        res.object.forEach(function (item) {
                            allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                        });
                    }
                    $('.query [name="planYear"]').append(allYear);
                    form.render('select');
                });

                // 获取月度
                form.on('select(planYear)', function (data) {
                    if (data.value) {
                        getPlanMonth(data.value, function (monthStr) {
                            $('.query [name="planMonth"]').html(monthStr);
                            form.render('select');
                        });
                    } else {
                        $('.query [name="planMonth"]').html('<option value="">请选择</option>');
                        form.render('select');
                    }
                });

                // 更多查询
	            $('.more_query').click(function(){
	                var isShow = $(this).attr('isshow');
	                if (isShow == 0) {
	                    $(this).children().removeClass('layui-icon-down').addClass('layui-icon-up');
	                    $('.hide_query').show();
	                    $(this).attr('isshow', 1);
	                } else {
	                    $(this).children().removeClass('layui-icon-up').addClass('layui-icon-down');
	                    $('.hide_query').hide();
	                    $(this).attr('isshow', 0);
	                }
	            });

                // 查询
                $('.search').click(function () {
                    var status = $('#status').val();

                    var searchObj = {
                        status: status
                    }

                    $('.query').find('[name]').each(function () {
                        var key = $(this).attr('name');
                        var value = $(this).val();

                        searchObj[key] = value;
                    });

                    searchObj.belongtoDept = ($('#belongtoDept').attr('deptid') || '').replace(/,$/, '');

                    assessmentTable(status, searchObj);
                });

                // 重置
                $('.clear').click(function () {
                    var status = $('.target_tabs').children('.layui-this').attr('opttype');

                    // 清空所属单位
                    $('#belongtoDept').val('');
                    $('#belongtoDept').attr('deptid', '');
                    $('#belongtoDept').attr('deptname', '');

                    // 重置月份
                    $('.query [name="planMonth"]').html('<option value="">请选择</option>');

                    form.render('select');

                    assessmentTable(status);
                });

                // 切换tabs
                element.on('tab(docDemo)', function (elem) {
                    if (saveALLDataList.length > 0) {
                        layer.confirm('确定保存吗？', function (index) {
                            saveTaskOrTarget(saveALLDataList, function (res) {
                                saveALLDataList = []
                                layer.close(index);
                                if (res.flag) {
                                    layer.msg('保存成功', {icon: 1, time: 1000});
                                } else {
                                    layer.msg('保存失败', {icon: 2, time: 1000});
                                }
                                $('.clear').trigger('click');
                            });
                        }, function () {
                            saveALLDataList = [];

                            $('.clear').trigger('click');

                            if (elem.index == 0) {
                                $('#status').val(3);
                            } else if (elem.index == 1) {
                                $('#status').val(4);
                            }
                        });
                    } else {

                        $('.clear').trigger('click');

                        if (elem.index == 0) {
                            $('#status').val(3);
                        } else if (elem.index == 1) {
                            $('#status').val(4);
                        }
                    }
                });

                // 普通表格头部工具条事件监听
                table.on('toolbar(tableList)', function (obj) {
                    var checkStatus = table.checkStatus(obj.config.id);
                    var layuiEvent = obj.event;
                    if (layuiEvent != 'saveDistribute' && checkStatus.data.length == 0) {
                        layer.msg('最少选中一项关键任务!', {icon: 0, time: 1000});
                        return false;
                    }
					if (obj.event=='return' && checkStatus.data.length != 1) {
						layer.msg('请选中一项子任务!', {icon: 0, time: 1000});
						return false;
					}
                    var ids = '';

                    for (var i = 0; i < checkStatus.data.length; i++) {
                        if (checkStatus.data[i].socoreId) {
                            ids += checkStatus.data[i].socoreId + ',';
                        } else {
                            ids += checkStatus.data[i].tgId + ',';
                        }
                    }

                    switch (layuiEvent) {
                        case 'assessment':
                            if (!assessmentLock) {
                                layer.confirm('选中数据完成考核？', function (index) {
                                    assessmentLock = true
                                    var data = {socoreIds: ids, apprivalStatus: 1}

                                    updateTaskOrTarget(data, function (res) {
                                        assessmentLock = false
                                        if (res.flag) {
                                            layer.msg('保存成功', {icon: 1, time: 1000});
                                            tableList.config.where._ = new Date().getTime();
                                            tableList.reload();
                                        } else {
                                            layer.msg('保存失败', {icon: 2, time: 1000});
                                        }
                                    });
                                });
                            }
                            break;
                        case 'saveDistribute':
                            if (saveALLDataList.length == 0) {
                                layer.msg('暂无修改后保存的内容！', {icon: 0, time: 1000});
                                return false
                            }
                            layer.confirm('确定保存吗？', function (index) {
                                saveTaskOrTarget(saveALLDataList, function (res) {
                                    saveALLDataList = []
                                    layer.close(index);
                                    if (res.flag) {
                                        layer.msg('保存成功', {icon: 1, time: 1000});
                                        tableList.config.where._ = new Date().getTime();
                                        tableList.reload();
                                    } else {
                                        layer.msg('保存失败', {icon: 2, time: 1000});
                                    }
                                });
                            });
                            break;
                        case 'export':
                            if (checkStatus.data.length == 0) {
	                            layer.msg('请选择需要导出的数据！', {icon: 0, time: 1000});
                                return false;
	                        }

                            // 使用post导出
                            $.dynamicSubmit('/PlcAssessScore/outAssessScore', {
                                "data": JSON.stringify(checkStatus.data)
                            });
                            break;
						case 'return':
							layer.confirm('确定要退回选中数据？', function (index) {
								$.post('/projectTarget/returnTgOrPlanItemId',{tgId:checkStatus.data[0].tgId || '',planItemId:checkStatus.data[0].planItemId || '',userId:checkStatus.data[0].dutyUser || '',belongDept:checkStatus.data[0].belongDept || ''},function (res) {
									if (res.flag) {
										layer.msg('退回成功', {icon: 1, time: 1000});
										tableList.config.where._ = new Date().getTime();
										tableList.reload();
									} else {
										layer.msg('退回失败', {icon: 2, time: 1000});
									}
								})
							});
							break;
                    }
                });

                // 监听未考核、已考核完成度单元格编辑
                $(document).on('blur', '.change_progress', function () {

                    var value = $(this).val().trim();

                    var socoreId = $(this).attr('socoreId');

                    if (!value) {
                        return false;
                    }

                    var hardDegree = $(this).attr('hardDegree');
                    var qualityScore = $(this).attr('qualityScore');

                    var data = {
                        hardDegree: hardDegree,
                        qualityScore: qualityScore,
                        taskPrecess: value,
                        socoreId: socoreId
                    }

                    var index = -1;
                    for (var i = 0; i < saveALLDataList.length; i++) {
                        if (saveALLDataList[i].socoreId == data.socoreId) {
                            index = i;
                            break;
                        }
                    }
                    if (index >= 0) {
                        saveALLDataList[index].taskPrecess = data.taskPrecess;
                    } else {
                        saveALLDataList.push({
                            socoreId: data.socoreId,
                            taskPrecess: data.taskPrecess,
                            hardDegree: data.hardDegree,
                            qualityScore: data.qualityScore
                        });
                    }
                });

                // 监听未考核、已考核质量得分单元格编辑
                $(document).on('blur', '.change_score', function () {

                    var value = $(this).val().trim();

                    var socoreId = $(this).attr('socoreId');

                    if (!value) {
                        return false;
                    }

                    var hardDegree = $(this).attr('hardDegree');
                    var taskPrecess = $(this).attr('taskPrecess');

                    var data = {
                        hardDegree: hardDegree,
                        qualityScore: value,
                        taskPrecess: taskPrecess,
                        socoreId: socoreId
                    }

                    var index = -1;
                    for (var i = 0; i < saveALLDataList.length; i++) {
                        if (saveALLDataList[i].socoreId == data.socoreId) {
                            index = i;
                            break;
                        }
                    }
                    if (index >= 0) {
                        saveALLDataList[index].qualityScore = data.qualityScore
                    } else {
                        saveALLDataList.push({
                            socoreId: data.socoreId,
                            qualityScore: data.qualityScore,
                            hardDegree: data.hardDegree,
                            taskPrecess: data.taskPrecess
                        });
                    }
                });

                // 监听未考核、已考核审核意见单元格编辑
                $(document).on('blur', '.change_comment', function () {

                    var value = $(this).val().trim();

                    var socoreId = $(this).attr('socoreId');

                    var index = -1;
                    for (var i = 0; i < saveALLDataList.length; i++) {
                        if (saveALLDataList[i].socoreId == socoreId) {
                            index = i;
                            break;
                        }
                    }
                    if (index >= 0) {
                        saveALLDataList[index].apprivalComment = value;
                    } else {
                        saveALLDataList.push({socoreId: socoreId, apprivalComment: value});
                    }

                });

                assessmentTable(3);

                /**
                 * 未考核、已考核列表加载方法
                 * @param status (3-未考核，4-已考核)
                 * @param searchObj (查询条件对象)
                 */
                function assessmentTable(status, searchObj) {

                    var url = '';
                    var paramsData = {}
                    if (status == 3) {
                        url = '/PlcAssessScore/findScoreDataByLoginUser';
                        paramsData.status = status;
                    } else if (status == 4) {
                        url = '/PlcAssessScore/findAssessmentData';
                        paramsData.apprivalStatus = 1;
                    }
                    paramsData.flag = 1;
                    if (searchObj) {
                        paramsData = $.extend({}, paramsData, searchObj);
                    }
                    paramsData._ = new Date().getTime();
                    tableList = table.render({
                        elem: '#tableList',
                        url: url,
                        page: true,
                        limit: 50,
                        height: 'full-160',
                        width: '100%',
                        toolbar: '#assessmentBar',
                        defaultToolbar: [''],
                        where: paramsData,
                        cols: [[
                            {type: 'checkbox', minWidth: 60}
                            , {
                                field: 'tgName', title: '关键任务名称', minWidth: 450, align: 'left', templet: function (d) {
                                    if (d.tgName) {
                                        return '<span tgId="' + d.tgId + '" class="target_detail" style="color: blue;cursor: pointer">【关键任务】' + d.tgName + '</span>'
                                    } else if (d.taskName) {
                                        return '<span planItemId="' + d.planItemId + '" class="task_detail" style="color: blue;cursor: pointer">【子任务】' + d.taskName + '</span>'
                                    } else {
                                        return ''
                                    }
                                }
                            }
							, {
								field: 'tgType', title: '关键任务类型', width: 100, templet: function (d) {
									return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
								}
							}
                            , {
                                field: 'dutyUserName', title: '责任人', minWidth: 130, align: 'left', templet: function (d) {
                                    if (d.dutyUserName == '' || d.dutyUserName == undefined) {
                                        return '';
                                    } else {
                                        return d.dutyUserName || '';
                                    }
                                }
                            }
                            , {
                                field: 'hardDegree', title: '难度系数', minWidth: 120, align: 'left', templet: function (d) {
                                    if (d.hardDegree == '' || d.hardDegree == undefined) {
                                        return '';
                                    } else {
                                        return d.hardDegree || '';
                                    }
                                }
                            }
                            , {
                                field: 'taskPrecess',
                                title: '完成度(%)',
                                minWidth: 120,
                                align: 'left',
                                templet: function (d) {
                                    if (authorityObject && authorityObject['10']) {
                                        return '<input type="text" style="height: 100%" class="layui-input number_input change_progress" socoreId="' + d.socoreId + '" ids="' + d.tgId + '" hardDegree="' + d.hardDegree + '" qualityScore="' + (d.qualityScore || 0) + '" taskType="1" value="' + (d.taskPrecess || 0) + '">';
                                    } else {
                                        return '<span class="change_progress" socoreId="' + d.socoreId + '">' + (d.taskPrecess || '') + '</span>';
                                    }
                                }
                            }
                            , {
                                field: 'qualityScore',
                                title: '质量得分',
                                minWidth: 120,
                                align: 'left',
                                templet: function (d) {
                                    if (authorityObject && authorityObject['10']) {
                                        return '<input type="text" style="height: 100%" class="layui-input number_input change_score" socoreId="' + d.socoreId + '" ids="' + d.tgId + '" hardDegree="' + d.hardDegree + '" taskPrecess="' + d.taskPrecess + '" taskType="1" value="' + (d.qualityScore || 100) + '">';
                                    } else {
                                        return d.qualityScore || '100';
                                    }
                                }
                            }
                            , {
                                field: 'apprivalComment',
                                title: '审核意见',
                                minWidth: 160,
                                align: 'left',
                                templet: function (d) {
                                    if (authorityObject && authorityObject['10']) {
                                        return '<input type="text" style="height: 100%" class="layui-input change_comment" socoreId="' + d.socoreId + '" ids="' + d.tgId + '" taskType="1" value="' + (d.apprivalComment || '') + '">';
                                    } else {
                                        return d.apprivalComment || '';
                                    }
                                }
                            }
                            , {
                                field: 'endScore', title: '单项得分', minWidth: 120, align: 'left',
                            }
                            , {
                                field: 'taskStatus', title: '完成状态', minWidth: 120, align: 'left', templet: function (d) {
                                    var str = '';
                                    if (d.taskStatus == 0) {
                                        str = '未开始';
                                    } else if (d.taskStatus == 1) {
                                        str = '进行中';
                                    } else if (d.taskStatus == 2) {
                                        str = '将到期';
                                    } else if (d.taskStatus == 4) {
                                        str = '已延期';
                                    } else if (d.taskStatus == 5) {
                                        str = '完成';
                                    } else if (d.taskStatus == 6) {
                                        str = '延期完成';
                                    } else if (d.taskStatus == 7) {
                                        str = '暂停';
                                    } else if (d.taskStatus == 8) {
                                        str = '关闭';
                                    }
                                    return str;
                                }
                            }
                            , {
                                field: 'submitTime', title: '提交时间', minWidth: 120, align: 'left', templet: function (d) {
                                    if (d.submitTime == '' || d.submitTime == undefined) {
                                        return '';
                                    } else {
                                        return format(d.submitTime) || '';
                                    }
                                }
                            }
                        ]],
                        parseData: function (res) {
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj,//解析数据列表
                                "count": res.totleNum, //解析数据长度
                            }
                        },
                        request: {
                            pageName: 'page', //页码的参数名称，默认：page
                            limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done: function (res) {
                            if (status == 3) {
                                $('.tobeassesNum').text('(' + (res.count || 0) + ')');
                            }
							if($('.layui-this').attr('opttype')=='4'){
								$('#assessmentOver').hide()
								$('#return').hide()
							}else{
								$('#assessmentOver').show()
								$('#return').show()
							}
                        }
                    });
                }

                //查看关键任务和填报详情
                $(document).on('click', '.target_detail', function () {
                    var tgId = $(this).attr('tgId');
                    $.ajax({
                        url: '/ProjectDaily/selectProjectDailyByItemId',
                        dataType: 'json',
                        type: 'get',
                        data: {tgId: tgId},
                        success: function (res) {
                            var data = res.data;
                            var targetData = res.object;

                            layer.open({
                                type: 1,
                                title: '关键任务和填报详情',
                                area: ['70%', '90%'],
                                maxmin: true,
                                min: function () {
                                    $('.layui-layer-shade').hide()
                                },
                                content: '<div id="target_detail" style="margin:10px"></div>',
                                success: function () {
                                    var dayReport = '';

                                    if (!!targetData) {
                                        var str = ''
                                        if (targetData.deptOrProject == 0) {
                                            str = '<tr>' +
	                                        '<td class="td_title">区域责任人</td>' +
											'<td colspan="1">' + isShowNull(targetData.mainAreaUserName).replace(/,$/, '') + '</td>' +
											'<td class="td_title">区域责任部门</td>' +
											'<td colspan="3">' + isShowNull(targetData.mainAreaDeptName).replace(/,$/, '') + '</td>' +
											'</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">区域实际开始时间</td>' +
                                            '<td colspan="1">' + format(targetData.areaStartDate) + '</td>' +
                                            '<td class="td_title">区域实际结束时间</td>' +
                                            '<td colspan="3">' + format(targetData.areaEndDate) + '</td>' +
	                                        '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">区域需提交的成果材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments5 && targetData.attachments5.length > 0) {
                                                    var str = '';

                                                    targetData.attachments5.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">区域异常原因</td>' +
                                            '<td colspan="5">' + isShowNull(targetData.areaUnusualRes) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">区域异常原因材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments7 && targetData.attachments7.length > 0) {
                                                    var str = '';

                                                    targetData.attachments7.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
											'<tr>' +
	                                        '<td class="td_title">总承包部责任人</td>' +
											'<td colspan="1">' + isShowNull(targetData.mainProjectUserName).replace(/,$/, '') + '</td>' +
											'<td class="td_title">总承包部责任部门</td>' +
											'<td colspan="3">' + isShowNull(targetData.mainProjectDeptName).replace(/,$/, '') + '</td>' +
											'</tr>' +
											'<tr>' +
                                            '<td class="td_title">总承包部实际开始时间</td>' +
                                            '<td colspan="1">' + format(targetData.projectStartDate) + '</td>' +
                                            '<td class="td_title">总承包部实际结束时间</td>' +
                                            '<td colspan="3">' + format(targetData.projectEndDate) + '</td>' +
	                                        '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">总承包部需提交的成果材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments6 && targetData.attachments6.length > 0) {
                                                    var str = '';

                                                    targetData.attachments6.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">总承包部异常原因</td>' +
                                            '<td colspan="5">' + isShowNull(targetData.projectUnusualStuff) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">总承包部异常原因材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments8 && targetData.attachments8.length > 0) {
                                                    var str = '';

                                                    targetData.attachments8.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>'
                                        }

                                        dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">关键任务详情</h3><table class="layui-table"><tbody>' +
                                            '<tr>' +
                                            '<td class="td_title">关键任务编号</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.tgNo) + '</td>' +
                                            '<td class="td_title">关键任务名称</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.tgName) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">关注等级</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['CONTROL_LEVEL']['object'][targetData.controlLevel])+ '</td>' +
                                            '<td class="td_title">周期类型</td>' +
                                            '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][targetData.planSycle]) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">关键任务类型</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['TG_TYPE']['object'][targetData.tgType]) + '</td>' +
                                            '<td class="td_title">计划阶段</td>' +
                                            '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_PHASE']['object'][targetData.planStage]) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">设计量</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.designQuantity) + '</td>' +
                                            '<td class="td_title">工程量</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.itemQuantity) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">单位</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['UNIT']['object'][targetData.itemQuantityNuit]) + '</td>' +
                                            '<td class="td_title">完成标准</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.resultStandard) + '</td>' +
                                            '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">计划开始时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.planStartDate) {
                                                    return format(targetData.planStartDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">计划结束时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.planEndDate) {
                                                    return format(targetData.planEndDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">计划工期</td>' +
                                            '<td>' + isShowNull(targetData.planContinuedDate) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'负责人</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.dutyUserName).replace(/,$/, '') + '</td>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'责任部门</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.mainCenterDeptName).replace(/,$/, '') + '</td>' +
                                            '</tr>' +
                                            '<td class="td_title">实际开始时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.realStartDate) {
                                                    return format(targetData.realStartDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">实际结束时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.realEndDate) {
                                                    return format(targetData.realEndDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">实际工期</td>' +
                                            '<td>' + isShowNull(targetData.realContinuedDate) + '</td>' +
                                            '</tr>' +
	                                        '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'需提交的成果材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments2 && targetData.attachments2.length > 0) {
                                                    var str = '';

                                                    targetData.attachments2.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'异常原因</td>' +
                                            '<td colspan="5">' + isShowNull(targetData.unusualRes) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">'+(targetData.deptOrProject==0 ?  '中心' : '')+'异常原因材料</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                if (!!targetData.attachments3 && targetData.attachments3.length > 0) {
                                                    var str = '';

                                                    targetData.attachments3.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>' + str +
                                            '<tr>' +
                                            '<td class="td_title">难度系数</td>' +
                                            '<td>' + isShowNull(targetData.hardDegree) + '</td>' +
                                            '<td class="td_title">风险点</td>' +
                                            '<td>' + isShowNull(targetData.riskPoint) + '</td>' +
                                            '<td class="td_title">难度点</td>' +
                                            '<td>' + isShowNull(targetData.difficultPoint) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">成果标准模板</td>' +
                                            '<td colspan="5">' +
                                            function () {
                                                var resultDictName = '';
                                                if (!!targetData.resultDict) {
                                                    var resultDictList = targetData.resultDict.split(',');

                                                    resultDictList.forEach(function (item) {
                                                        resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                                    });
                                                }
                                                return resultDictName.replace(/,$/, '');
                                            }() +
                                            '</td>' +
                                            '</tr>' +
												'<tr>' +
												'<td class="td_title">编制依据附件</td>' +
												'<td colspan="5">' +
												function () {
													if (!!targetData.attachments4 && targetData.attachments4.length > 0) {
														var str = '';

														targetData.attachments4.forEach(function (item) {
															var attachName = item.attachName;
															var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
															var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
															var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
															var attachmentUrl = item.attUrl;
															attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

															fileExtension = fileExtension.toLowerCase();

															str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
																	'<div class="operationDiv" style="top: -50px;">' + function () {
																		if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		} else {
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		}
																	}() +
																	'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
																	+ '</div>' +
																	'</div>'
														});

														return str;
													} else {
														return '';
													}
												}() +
												'</td>' +
												'</tr>' +
                                            '</tbody></table>';
                                    }

                                    if (!!data) {
                                        dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">关键任务填报信息</h3>';
                                        for (var i = 0; i < data.length; i++) {
                                            dayReport += '<table class="layui-table" style="margin-bottom: 5px">\n' +
                                                '  <tbody>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">每日填报人</td>\n' +
                                                '      <td>' + isShowNull(data[i].ctreateUserName) + '</td>\n' +
                                                '      <td class="td_title">时间</td>\n' +
                                                '      <td>' + isShowNull(data[i].ctreateTime) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">增加协作人</td>\n' +
                                                '      <td>' + isShowNull(data[i].assistUserName) + '</td>\n' +
                                                '      <td class="td_title">当日完成量</td>\n' +
                                                '      <td>' + function () {
                                                    if (data[i].assistUserName || data[i].transfer) {
                                                        return '—'
                                                    } else {
                                                        return data[i].tadayProgress + '%'
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">转办</td>\n' +
                                                '      <td colspan="3">' + isShowNull(data[i].transfer) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">进展日志</td>\n' +
                                                '      <td colspan="3">' + isShowNull(data[i].tadayDesc) + '</td>\n' +
                                                '    </tr>\n' +
                                                '  </tbody>\n' +
                                                '</table>';
                                        }
                                    }

                                    $('#target_detail').html(dayReport);
                                }
                            });
                        }
                    });
                });
            });

            /**
             * 获取年度对应月度信息
             * @param year (所属年)
             * @param fn (回调函数)
             */
            function getPlanMonth(year, fn) {
                $.get('/planPeroidSetting/showAllSet', {periodYear: year}, function (res) {
                    var str = '<option value="">请选择</option>';
                    if (res.object.length > 0) {
                        res.object.forEach(function (item) {
                            str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>';
                        });
                    }
                    if (fn) {
                        fn(str);
                    }
                });
            }

            /**
             * 将毫秒数转为yyyy-MM-dd格式时间
             * @param t (时间戳)
             * @returns {string}
             */
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            /**
             * 编辑单元格保存方法
             * @param data (请求参数对象)
             * @param fn (回调函数)
             */
            function updateTaskOrTarget(data, fn) {
                $.post('/PlcAssessScore/updateStatus', data, function (res) {
                    if (fn) {
                        fn(res);
                    }
                });
            }

            /**
             * 整体保存方法
             * @param data (请求参数对象)
             * @param fn (回调函数)
             */
            function saveTaskOrTarget(data, fn) {
                $.ajax({
                    url: '/PlcAssessScore/updateList',
                    data: JSON.stringify(data),
                    contentType: "application/json;charset=UTF-8",
                    dataType: 'json',
                    type: 'post',
                    success: function (res) {
                        if (fn) {
                            fn(res);
                        }
                    }
                });
            }

            //监听键盘事件，只能输入数字
            $(document).on('keypress', '.number_input', function (e) {
                var key = window.event ? e.keyCode : e.which;

                if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            });
            // 监听输入内容
            $(document).on('input propertychange', '.number_input', function (event) {
                var value = parseInt($(this).val());
                // 判断是否为难度系数
                var eleClass = $(this).hasClass('hard_degree');
                if (isNaN(value)) {
                    $(this).val('');
                } else {
                    // 难度系数最大值为10
                    if (eleClass) {
                        value = value > 10 ? 10 : value;
                    } else { // 进度、质量得分最大值为100
                        value = value > 100 ? 100 : value;
                    }
                    $(this).val(value);
                }
            });

            // 初始化页面操作权限
            function initAuthority() {
                // 是否设置页面权限
                if (authorityObject) {
                    // 检查查询权限
                    if (authorityObject['09']) {
                        $('.authority_search').show();
                    }
                }
            }

            // 附件查阅
            $(document).on('click', '.yulan', function () {
                var url = $(this).attr('data-url');
                pdurl($.UrlGetRequest('?' + url), url);
            });

            //判断是否显示空
            function isShowNull(data) {
                if (!!data) {
                    return data;
                } else {
                    return '';
                }
            }

            function resizeSize() {
                var height = $(window).height();
                $('#leftHeight').height(height - 170);

                // 重置查询区域布局
                var queryWidth = $('.query ').width();
                $('.query_item').width((queryWidth - 20) / 7);
            }

            // 文件批量下载
            $.dynamicSubmit = function (url, datas, fn) {
                var form = $('#dynamicForm');
                if (form.length <= 0) {
                    form = $("<form>");
                    form.attr('id', 'dynamicForm');
                    form.attr('style', 'display:none');
                    form.attr('target', '');
                    form.attr('method', 'post');
                    $('body').append(form);
                }
                form = $('#dynamicForm');
                form.attr('action', url);
                form.empty();
                if (datas && typeof (datas) == 'object') {
                    for (var item in datas) {
                        var $_input = $('<input>');
                        $_input.attr('type', 'hidden');
                        $_input.attr('name', item);
                        $_input.val(datas[item]);
                        $_input.appendTo(form);
                    }
                }
                form.submit();
                if (fn) {
                    fn();
                }
            };

		</script>
	</body>
</html>
