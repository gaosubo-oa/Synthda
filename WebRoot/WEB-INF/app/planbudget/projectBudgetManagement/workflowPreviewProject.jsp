<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/5/12
  Time: 17:21
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
        <title>流程预览项目</title>

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
            var projId =  $.GetRequest()['projId'] || '';
            var approvalType =  $.GetRequest()['approvalType'] || '';
            var disabled = $.GetRequest()['disabled'] || '';

            // 表格显示顺序
            var colShowObj = {
                itemNo: {field: 'itemNo', title: '预算科目编号', minWidth: 120, hide: false},
                cbsId: {
                    field: 'cbsId', title: 'CBS', minWidth: 90, hide: false, templet: function (d) {
                        if (d.plbCbsTypeWithBLOBs && d.plbCbsTypeWithBLOBs.cbsName) {
                            return d.plbCbsTypeWithBLOBs.cbsName;
                        } else {
                            return '';
                        }
                    }
                },
                wbsId: {
                    field: 'wbsId', title: 'WBS', minWidth: 90, hide: false, templet: function (d) {
                        if (d.plbProjWbs && d.plbProjWbs.wbsName) {
                            return d.plbProjWbs.wbsName;
                        } else {
                            return '';
                        }
                    }
                },
                projName: {field: 'projName', title: '所属项目', minWidth: 100, hide: false,},
                budgetNo: {field: 'budgetNo', title: '预算编号', minWidth: 100, hide: false},
                budgetName: {field: 'budgetName', title: '预算名称', minWidth: 100,hide: false},
                approvalStatus: {
                    field: 'approvalStatus', title: '状态', minWidth: 100, hide: false, templet: function (d) {
                        var status = '';
                        if (approvalType == '03') { // 预算项目编制
                            status = d.approvalStatus;
                        } else if (approvalType == '05') { // 项目优化目标
                            status = d.approvalStatusOpt;
                        } else if (approvalType == '06') { // 项目经营目标
                            status = d.approvalStatusRun;
                        }
                        if (status == 0) {
                            return '未提交';
                        } else if (status == 1) {
                            return '<span style="color: orange">审批中</span>';
                        } else if (status == 2) {
                            return '<span style="color: green">批准</span>'
                        } else if (status == 3) {
                            return '<span style="color: red">不批准</span>';
                        } else {
                            return '';
                        }
                    }
                },
                budgetMoney: {
                    field: 'budgetMoney', title: '预算金额', minWidth: 100, hide: false, templet: function (d) {
                        return numFormat(d.budgetMoney);
                    }
                },
                createTime: {
                    field: 'createTime', title: '编制时间', minWidth: 100, hide: false, templet: function (d) {
                        return format(d.createTime);
                    }
                },
                createUser: {
                    field: 'createUser', title: '编制人', minWidth: 100, hide: false, templet: function (d) {
                        return d.createUserName || '';
                    }
                }
            }

            var TableUIObj = new TableUI('plb_proj_budget');

            layui.use(['form', 'laydate', 'table', 'soulTable', 'eleTree'], function () {
                var layForm = layui.form,
                    laydate = layui.laydate,
                    layTable = layui.table,
                    soulTable = layui.soulTable,
                    eleTree = layui.eleTree;

                layForm.render();

                var tableObj = null;

                TableUIObj.init(colShowObj, function() {
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

                layTable.on('row(tableObj)', function(obj){
                    var data = obj.data;
                    iframeLayerIndex = layer.open({
                        type: 2,
                        title: '查看详情',
                        area: ['100%', '100%'],
                        content: '/plbProj/projectBudgetDetail?disabled=1&budgetItemId=' + data.budgetItemId
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
                        url: '/plbProjBudget/getDataByCondition',
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
        </script>
    </body>
</html>
