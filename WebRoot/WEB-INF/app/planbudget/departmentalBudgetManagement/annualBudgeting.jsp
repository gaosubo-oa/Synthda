<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/19
  Time: 15:27
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
		<title>年度预算编制</title>

		<meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--	    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
	    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	    <script type="text/javascript" src="/js/base/base.js"></script>
	    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
	    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
	    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
	    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
        <script type="text/javascript" src="/js/common/fileupload.js"></script>
		<script type="text/javascript" src="/js/planbudget/common.js"></script>

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
			<input type="hidden" id="leftId" class="layui-input">
			<div class="wrapper">
				<div class="wrap_left">
					<h2 style="text-align: center;line-height: 35px;">年度预算编制</h2>
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
							<input type="text" name="planName" placeholder="部门名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
							<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
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
							<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧部门</p>
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
				<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="budgetControl">分解</button>
			</div>
			<div style="position:absolute;top: 10px;right:60px;">
				<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
					<img src="/img/planCheck/导入.png"style="width: 20px;height: 20px;margin-top: -4px;">导入
				</button>
				<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
					<img src="/img/planCheck/导出.png"style="width: 20px;height: 20px;margin-top: -4px;">导出
				</button>
			</div>
		</script>

		<script>
			var tipIndex = null
            $('.icon_img').on('hover',function () {
                var tip = $(this).attr('text');
                tipIndex = layer.tips(tip, this);
            }, function () {
                layer.close(tipIndex);
            });

			// 表格显示顺序
            var colShowObj = {
                budgetYear: {field: 'budgetYear', title: '预算年度', sort: true, hide: false},
                budgetItemId: {field: 'budgetItemId', title: '预算科目', sort: true, hide: false},
                budgetMoney: {field: 'budgetMoney', title: '预算金额', sort: true, hide: false},
                auditerStatus: {
                    field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
                        if (d.auditerStatus == '0') {
                            return '待审批';
                        } else if (d.auditerStatus == '1') {
                            return '批准';
                        } else if (d.auditerStatus == '2') {
                            return '不批准';
                        }
                    }
                },
                controlType: {
                    field: 'controlType', title: '控制方式', sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['CONTROL_MODE']['object'][d.controlType] || '';
                    }
                }
            }

            var TableUIObj = new TableUI('plb_dept_budget_year');
            TableUIObj.init(colShowObj);

            var dictionaryObj = {
                CONTROL_MODE: {}
            }
            var dictionaryStr = 'CONTROL_MODE';
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

            layui.use(['form', 'table', 'soulTable', 'eleTree'], function () {
                var layForm = layui.form,
                    layTable = layui.table,
	                eleTree = layui.eleTree,
                    soulTable = layui.soulTable;
                layForm.render();

                var tableObj = null;

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
                    $('.table_box').hide();
                    $('.tishi').show();
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
                    if (currentData.deptId) {
                        $('#leftId').attr('deptId', currentData.deptId);
                        $('#leftId').attr('deptName', currentData.deptName);
                        $('.no_data').hide();
                        $('.table_box').show();
                        tableInit(currentData.deptId);
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
                        tableInit($('#leftId').attr('deptId'));
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
                    switch (obj.event) {
                        case 'add': // 新增
                            addOrEdit(1);
                            break;
                        case 'edit': // 编辑
                            if (checkStatus.data.length != 1) {
                                layer.msg('请选择一条需要编辑的数据！', {icon: 0, time: 1500});
                                return false;
                            }
                            // 获取项目信息
	                        addOrEdit(2, checkStatus.data[0]);
                            // $.get('/plbProj/queryByProjId', {projId: checkStatus.data[0].projId}, function (res) {
                            //     if (res.flag) {
                            //         addOrEdit(2, res.data);
                            //     } else {
                            //         layer.msg('获取信息失败！', {icon: 0});
                            //     }
                            // });
                            break;
                        case 'del': // 删除
                            layer.msg('删除');
                            if (checkStatus.data.length == 0) {
                                layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
                                return false;
                            }

                            var budgetIds = '';

                            checkStatus.data.forEach(function (item) {
                                budgetIds += item.budgetId + ',';
                            });

                            layer.confirm('确定删除该条数据吗？', function (index) {
                                $.post('/plbDeptBudgetYear/deleteBudgetIds', {budgetIds: budgetIds}, function (res) {
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
                        case 'budgetControl': // 分解
                            layer.msg('分解');
                            break;
                        case 'import': // 导入
                            layer.msg('导入');
                            break;
                        case 'export': // 导出
                            layer.msg('导出');
                            break;
                    }
                });

                /**
                 * 加载表格方法
                 */
                function tableInit(deptId) {
                    var cols = [{checkbox: true}].concat(TableUIObj.cols)

                    var option = {
                        elem: '#tableObj',
                        url: '/plbDeptBudgetYear/getYearBudgetByDeptId',
                        toolbar: '#toolbarHead',
                        cols: [cols],
                        defaultToolbar: ['filter'],
                        height: 'full-80',
                        page: {
                            limit: TableUIObj.onePageRecoeds,
                            limits: [10, 20, 30, 40, 50]
                        },
                        where: {
                            deptId: deptId,
                            orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                            orderbyUpdown: TableUIObj.orderbyUpdown
                        },
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
                function addOrEdit(type, data) {
                    var title = '';
                    var url = '';
                    if (type == 1) {
                        title = '新增';
                        url = '/plbDeptBudgetYear/addDeptBudgetYear';
                    } else if (type == 2) {
                        title = '编辑';
                        url = '/plbDeptBudgetYear/updateDeptBudgetYear';
                    }

                    layer.open({
                        type: 1,
                        title: title,
                        area: ['70%', '90%'],
                        btn: ['保存', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
                            '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                            /* region 第一行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">预算科目<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="budgetItemId" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">预算年度<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<select name="budgetYear"></select>' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '</div>',
                            /* endregion */
                            /* region 第二行 */
                            '<div class="layui-row">' +
                            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">预算金额<span class="field_required">*</span></label>' +
                            '<div class="layui-input-block form_block">' +
                            '<input type="text" name="budgetMoney" autocomplete="off" class="layui-input">' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '<div class="layui-col-xs6" style="padding: 0 5px">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label form_label">控制方式</label>' +
                            '<div class="layui-input-block form_block">' +
                            '<select name="controlType"></select>' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                            '</div>',
                            /* endregion */
                            '</form>',
                            '</div>'].join(''),
                        success: function () {

                            $('select[name="controlType"]').html(dictionaryObj['CONTROL_MODE']['str']);

                            if (type == 2) {
                                layForm.val("baseForm", data);
                            }

                            layForm.render();
                        },
                        yes: function (index) {
                            var loadIndex = layer.load();
                            //材料计划数据
                            var datas = $('#baseForm').serializeArray();
                            var obj = {}
                            datas.forEach(function (item,) {
                                obj[item.name] = item.value
                            });

                            if (type == 2) {
                                obj.budgetId = data.budgetId
                            } else {
                                // 新建时保存部门id
                                obj.deptId = $('#leftId').attr('deptId') || '';
                            }

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
                                        layer.msg('保存失败！', {icon: 2});
                                    }
                                }
                            });
                        }
                    });
                }
            });

            //计算工期
            function timeRange(beginTime, endTime) {
                var t1 = new Date(beginTime)
                var t2 = new Date(endTime)
                var time = t2.getTime() - t1.getTime()
                var days = parseInt(time / (1000 * 60 * 60 * 24)) + 1
                return days
            }

            //删除附件
            $(document).on('click', '.deImgs', function () {
                var _this = this;
                var attUrl = $(this).parents('.dech').attr('deUrl');
                layer.confirm('确定删除该附件吗？', function (index) {
                    $.ajax({
                        type: 'get',
                        url: '/delete?' + attUrl,
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag == true) {
                                layer.msg('删除成功', {icon: 6, time: 1000});
                                $(_this).parent().remove();
                            } else {
                                layer.msg('删除失败', {icon: 2, time: 1000});
                            }
                        }
                    })
                });
            });
		</script>
	</body>
</html>
