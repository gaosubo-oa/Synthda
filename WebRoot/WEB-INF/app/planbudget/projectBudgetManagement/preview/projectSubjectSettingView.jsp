<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/7/1
  Time: 17:01
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
        <title>项目预算科目</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
        <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
        <script type="text/javascript" src="/js/base/base.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
        <script type="text/javascript" src="/js/common/fileupload.js"></script>
        <script type="text/javascript" src="/js/planbudget/common.js?20210413.1"></script>

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
                top: 0px;
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

            .layui-table-hover {
                background-color: #5FB878 !important;
                color: #fff;
            }
            .layui-table-view .layui-table td {
                cursor: pointer;
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
                    <div class="tree_module">
                        <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
                    </div>
                </div>
                <div class="wrap_right">
                    <div style="position: relative">
                        <div class="table_box">
                            <table id="tableObj" lay-filter="tableObj"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            var projId = $.GetRequest()['projId'] || '';
            var disabled = $.GetRequest()['disabled'] || '';

            // 表格显示顺序
            var colShowObj = {
                itemNo: {field: 'itemNo', minWidth: 130, title: '预算科目编号', sort: true, hide: false},
                itemName: {field: 'itemName', minWidth: 130, title: '预算科目名称', sort: true, hide: false},
                projName: {field: 'projName', minWidth: 130, title: '所属项目', sort: true, hide: false},
                rbsId: {
                    field: 'rbsId', minWidth: 90, title: 'RBS', hide: false, templet: function (d) {
                        if (d.plbRbs) {
                            return d.plbRbs.rbsName || '';
                        } else {
                            return '';
                        }
                    }
                },
                wbsId: {
                    field: 'wbsId', minWidth: 90, title: 'WBS', hide: false, templet: function (d) {
                        if (d.plbProjWbs) {
                            return d.plbProjWbs.wbsName || '';
                        } else {
                            return '';
                        }
                    }
                },
                cbsId: {
                    field: 'cbsId', minWidth: 90, title: 'CBS', hide: false, templet: function (d) {
                        if (d.plbCbsTypeWithBLOBs) {
                            return d.plbCbsTypeWithBLOBs.cbsName || '';
                        } else {
                            return '';
                        }
                    }
                },
                controlType: {
                    field: 'controlType', minWidth: 110, title: '控制类型', sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                    }
                },
                beginTime: {
                    field: 'beginTime', minWidth: 130, title: '编制开始时间', sort: true, hide: false, templet: function (d) {
                        return format(d.beginTime);
                    }
                },
                endTime: {
                    field: 'endTime', minWidth: 130, title: '编制结束时间', sort: true, hide: false, templet: function (d) {
                        return format(d.endTime);
                    }
                },
                approvalStatus: {
                    field: 'approvalStatus', minWidth: 100, title: '状态', sort: true, hide: false, templet: function (d) {
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
                createTime: {
                    field: 'createTime', minWidth: 110, title: '编制时间', sort: true, hide: false, templet: function (d) {
                        return format(d.createTime);
                    }
                },
                createUser: {
                    field: 'createUser', minWidth: 110, title: '编制人', sort: true, hide: false, templet: function (d) {
                        return d.createUserName || '';
                    }
                }
            }

            var TableUIObj = new TableUI('plb_budget_item');

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
                initPage();
            });

            function initPage() {
                layui.use(['form', 'table', 'soulTable', 'eleTree', 'xmSelect'], function () {
                    var layForm = layui.form,
                        layTable = layui.table,
                        soulTable = layui.soulTable,
                        eleTree = layui.eleTree,
                        xmSelect = layui.xmSelect;

                    layForm.render();

                    var tableObj = null;

                    TableUIObj.init(colShowObj, function () {
                        $('.table_box').show();
                        tableInit();
                    });

                    projectLeft();

                    /**
                     * 左侧项目信息列表
                     * @param deptName 项目名称
                     */
                    function projectLeft(projectName) {
                        projectName = projectName ? projectName : '';
                        var loadingIndex = layer.load();
                        $.get('/plbProjBudget/getFlowFormData', {projId: projId}, function (res) {
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
                            $('#leftId').attr('wbsId', currentData.wbsId);
                            tableInit(currentData.wbsId);
                        } else {
                            tableInit();
                        }
                    });

                    layTable.on('row(tableObj)', function (obj) {
                        var data = obj.data;
                        layer.open({
                            type: 1,
                            title: '查看详情',
                            area: ['100%', '100%'],
                            content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
                                '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                                /* region 第一行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">预算科目编号<span field="itemNo" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly name="itemNo" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">预算科目名称<span field="itemName" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="itemName" readonly autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第二行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">WBS<span class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly id="wbsId" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">CBS<span field="cbsId" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第三行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">控制类型<span field="controlType" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="controlType" disabled></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">单位<span field="itemUnit" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="itemUnit" disabled></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第四行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">编制开始时间<span field="beginTime" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly id="planStartDate" name="beginTime" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">编制结束时间<span field="endTime" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly id="planEndDate" name="endTime" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第五行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">责任人<span field="dutyUser" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="dutyUser" id="dutyUser" readonly autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">关联工作计划</label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly name="planIds" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第六行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs12" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">科目说明<span field="itemRemark" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<textarea readonly name="itemRemark" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                '</form>',
                                '<div id="contorlTableBox"><table id="contorlTable" lay-filter="contorlTable"></table></div>',
                                '</div>'].join(''),
                            success: function () {
                                $('select[name="itemType"]').html(dictionaryObj['ITEM_TYPE']['str']);
                                $('select[name="controlType"]').html(dictionaryObj['CONTROL_TYPE']['str']);
                                $('select[name="itemUnit"]').html(dictionaryObj['CBS_UNIT']['str']);

                                var cbsTreeData = []

                                // 获取CBS数据
                                $.get('/plbCbsType/getAllList', function (res) {
                                    cbsTreeData = res.data;
                                    var cbsSelectTree = xmSelect.render({
                                        el: '#cbsSelectTree',
                                        content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                                            '<input type="text" style="box-sizing: border-box;" class="layui-input" id="cbsSelect">' +
                                            '</div>' +
                                            '<div style="padding-top: 30px;" id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                        name: 'cbsId',
                                        disabled: true,
                                        prop: {
                                            name: 'cbsName',
                                            value: 'cbsId'
                                        }
                                    });

                                    layForm.val("baseForm", data);

                                    $('#dutyUser').val(data.dutyUserName);
                                    $('#dutyUser').attr('user_id', data.dutyUser);

                                    if (data.plbProjWbs) {
                                        $('#wbsId').val(data.plbProjWbs.wbsName);
                                    }

                                    var obj = {
                                        cbsName: data.plbCbsTypeWithBLOBs.cbsName,
                                        cbsId: data.plbCbsTypeWithBLOBs.cbsId
                                    }
                                    cbsSelectTree.setValue([obj]);

                                    layForm.render();
                                });

                                var plbBudgetControl = []

                                if (data.plbBudgetControl && data.plbBudgetControl.length > 0) {
                                    plbBudgetControl = data.plbBudgetControl
                                }

                                layTable.render({
                                    elem: '#contorlTable',
                                    data: plbBudgetControl,
                                    toolbar: false,
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [[
                                        {
                                            field: 'controlType',
                                            title: '控制类型',
                                            width: 200,
                                            templet: function (d) {
                                                var value = ''
                                                if (d.controlType == '0') {
                                                    value = '比例控制'
                                                } else if (d.controlType == '1') {
                                                    value = '数值控制'
                                                }
                                                return value;
                                            }
                                        },
                                        {
                                            field: 'configurationUp', title: '最小值', minWidth: 100
                                        },
                                        {
                                            field: 'controlRule',
                                            title: '控制规则',
                                            minWidth: 100
                                        },
                                        {
                                            field: 'configurationDown', title: '最大值', minWidth: 100
                                        },
                                        {
                                            field: 'isRemind',
                                            title: '是否提醒',
                                            minWidth: 100,
                                            templet: function (d) {
                                                var value = ''
                                                if (d.isRemind == '0') {
                                                    value = '否';
                                                } else if (d.isRemind == '1') {
                                                    value = '是'
                                                } else if (d.isRemind == '2') {
                                                    value = '禁止编制'
                                                }
                                                return value;
                                            }
                                        },
                                        {
                                            field: 'remind', title: '超出控制提醒内容', minWidth: 200
                                        }
                                    ]]
                                });
                            }
                        });
                    });

                    /**
                     * 加载表格方法
                     */
                    function tableInit(wbsId) {
                        wbsId = wbsId || '';
                        var where = {
                            orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                            orderbyUpdown: TableUIObj.orderbyUpdown
                        }

                        if (wbsId) {
                            where.wbsId = wbsId;
                        } else {
                            where.projId = projId;
                        }

                        var cols = TableUIObj.cols;

                        var option = {
                            elem: '#tableObj',
                            url: '/plbBudgetItem/getDataByCondition',
                            toolbar: true,
                            defaultToolbar: ['filter'],
                            cols: [cols],
                            height: 'full-80',
                            page: {
                                limit: TableUIObj.onePageRecoeds,
                                limits: [10, 20, 30, 40, 50]
                            },
                            where: where,
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
                            }
                        }

                        tableObj = layTable.render(option);
                    }
                });
            }
        </script>
    </body>
</html>
