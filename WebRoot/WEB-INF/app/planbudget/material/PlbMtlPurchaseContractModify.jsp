<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/5/19
  Time: 9:11
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
        <title>材料采购合同变更</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
        <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
        <script type="text/javascript" src="/js/base/base.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/global.js?20210604.1"></script>
        <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
        <script type="text/javascript" src="/js/common/fileupload.js"></script>
        <script type="text/javascript" src="/js/planbudget/common.js?20210604.1"></script>

        <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.11"></script>

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
        </style>
    </head>
    <body>
        <div class="container">
            <input type="hidden" id="leftId">
            <div class="wrapper">
                <div class="wrap_left">
                    <h2>材料采购合同变更</h2>
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
                            <input type="text" name="contractNo" placeholder="合同编号" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-col-xs2" style="margin-left: 15px;">
                            <input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-col-xs2" style="margin-left: 15px;">
                            <select name="auditerStatus">
                                <option value="">请选择</option>
                                <option value="0">未提交</option>
                                <option value="1">审批中</option>
                                <option value="2">批准</option>
                                <option value="3">不批准</option>
                            </select>
                        </div>
                        <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                            <button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
<%--                            <button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>--%>
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
                <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="revise">修编</button>
                <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="edit">编辑</button>
            </div>
            <div style="position:absolute;top: 10px;right:60px;">
                <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
                    <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">
                    导出
                </button>
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

        <script type="text/html" id="plbMtlContrastBar">
            <div class="layui-btn-container" style="height: 30px;">
                <button class="layui-btn layui-btn-sm" lay-event="choosePlbMtlContrast">选择供应商比价</button>
            </div>
        </script>

        <script type="text/html" id="toolBar">
            <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="detail">查看详情</a>
        </script>

        <script>
            var globalprojId = '';
            var dept_id = '';

            var tipIndex = null
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text');
                tipIndex = layer.tips(tip, this);
            }, function () {
                layer.close(tipIndex);
            });

            // 表格显示顺序
            var colShowObj = {
                contractNo: {field: 'contractNo', title: '合同编号', sort: true, hide: false},
                contractName: {field: 'contractName', title: '合同名称', sort: true, hide: false},
                projectName:{field:'projectName',title:'所属项目',sort:true,hide:false},
                contractType: {
                    field: 'contractType', title: '合同类型', sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
                    }
                },
                signDate: {
                    field: 'signDate', title: '合同签订日期', sort: true, hide: false, templet: function (d) {
                        return format(d.signDate);
                    }
                },
                customerId: {
                    field: 'customerId', title: '供应商单位', sort: true, hide: false, templet: function (d) {
                        return d.customerName || '';
                    }
                },
                contractMoney: {
                    field: 'contractMoney', title: '合同额', sort: true, hide: false, templet: function (d) {
                        return numFormat(d.contractMoney);
                    }
                },
                paymentType: {
                    field: 'paymentType', title: '付款方式', sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['PAYMENT_METHOD']['object'][d.contractType] || '';
                    }
                },
                effectiveDate: {
                    field: 'effectiveDate', title: '生效日期', sort: true, hide: false, templet: function (d) {
                        return format(d.effectiveDate);
                    }
                },
                attachmentName: {field: 'attachmentName', title: '附件', sort: true, hide: false},
                auditerStatus: {
                    field: 'auditerStatus', title: '合同状态', sort: true, hide: false, templet: function (d) {
                        var str = '';
                        if (d.auditerStatus == '1') {
                            str = '<span style="color: orange;">审批中</span>';
                        } else if (d.auditerStatus == '2') {
                            str = '<span style="color: green;">批准</span>';
                        } else if (d.auditerStatus == '3') {
                            str = '<span style="color: red;">不批准</span>';
                        } else {
                            str = '未提交';
                        }
                        return str;
                    }
                }
            }
            var TableUIObj = new TableUI('plb_mtl_contract');

            // 获取数据字典数据
            var dictionaryObj = {
                CONTRACT_TYPE: {},
                PAYMENT_METHOD: {},
                CBS_UNIT: {},
                CONTRACT_STATUS: {},
                COMPARE_TYPE: {},
                TAX_RATE: {},
                INVOICE_TYPE: {},
                CUSTOMER_NAME: {}
            }
            var dictionaryStr = 'CONTRACT_TYPE,PAYMENT_METHOD,CBS_UNIT,CONTRACT_STATUS,COMPARE_TYPE,TAX_RATE,INVOICE_TYPE,CUSTOMER_NAME';
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
                layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree'], function () {
                    var layForm = layui.form,
                        laydate = layui.laydate,
                        layTable = layui.table,
                        layElement = layui.element,
                        soulTable = layui.soulTable,
                        eleTree = layui.eleTree;

                    var tableObj = null;

                    TableUIObj.init(colShowObj, function() {
                        $('.no_data').hide();
                        $('.table_box').show();
                        tableInit();
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
                            $('#leftId').attr('projId', currentData.projId);
                            $('.no_data').hide();
                            $('.table_box').show();
                            tableInit(currentData.projId);
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

                    function tableInit(projId) {
                        var searchObj = getSearchObj();
                        searchObj.projId = projId || '';
                        searchObj.reviseType = 10;
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
                            url: '/plbMtlContract/getEditOldData',
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
                                dataName: 'obj'
                            },
                            done: function () {
                                //增加拖拽后回调函数
                                soulTable.render(this, function () {
                                    TableUIObj.dragTable('tableObj')
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

                    // 监听筛选列
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

                    // 上方按钮显示
                    layTable.on('toolbar(tableObj)', function (obj) {
                        var checkStatus = layTable.checkStatus(obj.config.id);
                        switch (obj.event) {
                            case 'edit':
                                if (checkStatus.data.length != 1) {
                                    layer.msg('请选择需要修改的数据！', {icon: 0});
                                    return false
                                }

                                if (checkStatus.data[0].auditerStatus > 0) {
                                    layer.msg('该合同已提交，不可编辑！', {icon: 0});
                                    return false;
                                }
                                $.get('/plbMtlContract/getEditOldData', {reviseId: checkStatus.data[0].reviseId}, function (res) {
                                    if (res.flag) {
                                        newOrEdit(2, res.object);
                                    } else {
                                        layer.msg('获取数据失败!', {icon: 0});
                                    }
                                });
                                break;
                            case 'revise':
                                layer.open({
                                    type: 1,
                                    title: '选择修编数据',
                                    area: ['80%', '70%'],
                                    btn: ['修编', '取消'],
                                    btnAlign: 'c',
                                    content: '<div><table id="reviseTable" lay-filter="reviseTable"></table></div>',
                                    success: function () {
                                        layTable.render({
                                            elem: '#reviseTable',
                                            url: '/plbMtlContract/selectAll',
                                            toolbar: false,
                                            cols: [[
                                                {type: 'radio'},
                                                {field: 'contractNo', title: '合同编号'},
                                                {field: 'contractName', title: '合同名称'},
                                                {field: 'projectName', title: '所属项目'},
                                                {
                                                    field: 'contractType', title: '合同类型', templet: function (d) {
                                                        return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
                                                    }
                                                },
                                                {
                                                    field: 'signDate', title: '合同签订日期', templet: function (d) {
                                                        return format(d.signDate);
                                                    }
                                                },
                                                {
                                                    field: 'customerId', title: '供应商单位', templet: function (d) {
                                                        return d.customerName || '';
                                                    }
                                                },
                                                {
                                                    field: 'contractMoney', title: '合同额', templet: function (d) {
                                                        return numFormat(d.contractMoney);
                                                    }
                                                },
                                                {
                                                    field: 'paymentType', title: '付款方式', templet: function (d) {
                                                        return dictionaryObj['PAYMENT_METHOD']['object'][d.contractType] || '';
                                                    }
                                                },
                                                {
                                                    field: 'effectiveDate', title: '生效日期', templet: function (d) {
                                                        return format(d.effectiveDate);
                                                    }
                                                }
                                            ]],
                                            where: {
                                                projId: $('#leftId').attr('projId') || '',
                                                changeFlag: 1,
                                                useFlag:true
                                            },
                                            page: true,
                                            request: {
                                                limitName: 'pageSize'
                                            },
                                            response: {
                                                statusName: 'flag',
                                                statusCode: true,
                                                msgName: 'msg',
                                                countName: 'totleNum',
                                                dataName: 'obj'
                                            }
                                        });
                                    },
                                    yes: function (index) {
                                        var checkStatus = layTable.checkStatus('reviseTable');
                                        if (checkStatus.data.length > 0) {
                                            $.get('/plbMtlContract/queryId', {mtlContractId:  checkStatus.data[0].mtlContractId}, function (res) {
                                                if (res.flag) {
                                                    layer.close(index);
                                                    newOrEdit(2, res.object);
                                                } else {
                                                    layer.msg('获取数据失败!', {icon: 0});
                                                }
                                            });
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                                break;
                            case 'export':
                                layer.msg('导出');
                                break;
                        }
                    });
                    layTable.on('tool(tableObj)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        if (layEvent === 'detail') {
                            layer.open({
                                type: 2,
                                title: '材料采购合同详情',
                                area: ['100%', '100%'],
                                content: '/plbMtlContract/mtlPurchaseContract?type=2&mtlContractId=' + data.mtlContractId
                            });
                        }
                    });

                    // 内部-购买清单-上方按钮显示
                    layTable.on('toolbar(contractDetailsTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                //遍历表格获取每行数据进行保存
                                var $trs = $('#contractDetailsModule').find('.layui-table-main tr');
                                var oldDataArr = []
                                $trs.each(function () {
                                    var oldDataObj = {
                                        contractListId: $(this).find('input[name="mtlLibId"]').attr('contractListId') || '',
                                        mtlLibId: $(this).find('input[name="mtlLibId"]').attr('mtlLibId') || '',
                                        mtlName: $(this).find('input[name="mtlLibId"]').val(),
                                        mtlStandard: $(this).find('.mtlStandard').text(),
                                        contractPrice: $(this).find('input[name="contractPrice"]').val(),
                                        taxRate: $(this).find('input[name="taxRate"]').val(),
                                        contractNumber: $(this).find('input[name="contractNumber"]').val(),
                                        totalAmount: $(this).find('.totalAmount').text(),
                                        totalIncludingTax: $(this).find('.totalIncludingTax').text(),
                                        contrastNo: $(this).find('input[name="contrastNo"]').val()
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                var obj = {
                                    taxRate: 0
                                }
                                // 发票类型
                                var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();
                                if (invoiceType == '01') {
                                    var taxRate = checkFloatNum(dictionaryObj['TAX_RATE']['object'][$('[name="taxRate"]', $('#baseForm')).val()] || '') * 100;
                                    obj.taxRate = taxRate;
                                }
                                oldDataArr.push(obj);
                                layTable.reload('contractDetailsTable', {
                                    data: oldDataArr
                                });
                                break;
                        }
                    });
                    // 内部-购买清单-删行操作
                    layTable.on('tool(contractDetailsTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            obj.del();
                            if (data.contractListId) {
                                $.get('/plbMtlContractList/delete', {contractListId: data.contractListId}, function (res) {});
                            }
                            //遍历表格获取每行数据进行保存
                            var $trs = $('#contractDetailsModule').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $trs.each(function () {
                                var oldDataObj = {
                                    contractListId: $(this).find('input[name="mtlLibId"]').attr('contractListId') || '',
                                    mtlLibId: $(this).find('input[name="mtlLibId"]').attr('mtlLibId') || '',
                                    mtlName: $(this).find('input[name="mtlLibId"]').val(),
                                    mtlStandard: $(this).find('.mtlStandard').text(),
                                    contractPrice: $(this).find('input[name="contractPrice"]').val(),
                                    taxRate: $(this).find('input[name="taxRate"]').val(),
                                    contractNumber: $(this).find('input[name="contractNumber"]').val(),
                                    totalAmount: $(this).find('.totalAmount').text(),
                                    totalIncludingTax: $(this).find('.totalIncludingTax').text(),
                                    contrastNo: $(this).find('input[name="contrastNo"]').val()
                                }
                                oldDataArr.push(oldDataObj);
                            })
                            layTable.reload('contractDetailsTable', {
                                data: oldDataArr
                            });
                        } else if (layEvent === 'chooseMtl') {
                            layer.open({
                                type: 1,
                                title: '选择材料',
                                area: ['70%', '80%'],
                                maxmin: true,
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div class="container">',
                                    '<div class="wrapper">',
                                    '<div class="wrap_left">' +
                                    '<div class="layui-form">' +
                                    '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
                                    '<div class="tree_module" style="top: 48px;">' +
                                    '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>',
                                    '<div class="wrap_right">' +
                                    '<div class="layui-form">' +
                                    '<div class="layui-form-item" style="margin: 0;">' +
                                    '<label class="layui-form-label">材料名称</label>' +
                                    '<div class="layui-input-block">' +
                                    '<input type="text" name="planMtlName" class="layui-input">' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="mtl_table_box" style="display: none;">' +
                                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                                    '</div>' +
                                    '<div class="mtl_no_data" style="text-align: center;">' +
                                    '<div class="no_data_img" style="margin-top:12%;">' +
                                    '<img style="margin-top: 2%;" src="/img/noData.png">' +
                                    '</div>' +
                                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧材料</p>' +
                                    '</div>' +
                                    '</div>',
                                    '</div></div>'].join(''),
                                success: function () {
                                    // 获取材料类型
                                    $.get('/plbDictonary/getTgTypeByDictNo?plbDictNo=MTL_TYPE', function (res) {
                                        var str = '<option value="">请选择<option>';
                                        if (res.flag && res.obj.length > 0) {
                                            res.obj.forEach(function (item) {
                                                str += '<option value="' + item.plbDictNo + '">' + item.dictName + '<option>';
                                            });
                                        }
                                        $('#mtlTypeTree').html(str);
                                        layForm.render();
                                    });

                                    layForm.on('select(mtlTypeTree)', function (data) {
                                        loadMtlType(data.value);
                                    });

                                    // 树节点点击事件
                                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                                        var currentData = d.data.currentData;
                                        if (currentData.mtlLibId) {
                                            $('.mtl_no_data').hide();
                                            $('.mtl_table_box').show();
                                            loadMtlTable(currentData.mtlLibId);
                                        } else {
                                            $('.mtl_table_box').hide();
                                            $('.mtl_no_data').show();
                                        }
                                    });

                                    loadMtlType();

                                    function loadMtlType(mtlType) {
                                        mtlType = mtlType ? mtlType : '';
                                        // 获取左侧树
                                        $.get('/plbMtlLibrary/queryAll', {mtlType: mtlType}, function (res) {
                                            if (res.flag) {
                                                eleTree.render({
                                                    elem: '#chooseMtlTree',
                                                    data: res.data,
                                                    highlightCurrent: true,
                                                    showLine: true,
                                                    defaultExpandAll: false,
                                                    request: {
                                                        name: 'mtlName',
                                                        children: "son",
                                                    }
                                                });
                                            }
                                        });
                                    }

                                    function loadMtlTable(mtlLibId) {
                                        layTable.render({
                                            elem: '#materialsTable',
                                            url: '/plbMtlLibrary/queryByParentId',
                                            where: {
                                                mtlLibId: mtlLibId
                                            },
                                            page: false,
                                            response: {
                                                statusName: 'flag',
                                                statusCode: true,
                                                msgName: 'msg',
                                                countName: 'totleNum',
                                                dataName: 'data'
                                            },
                                            cols: [[
                                                {type: 'radio', title: '选择'},
                                                {field: 'mtlNo', title: '材料编码'},
                                                {field: 'mtlName', title: '材料名称'},
                                                {
                                                    field: 'mtlStandard', title: '材料规格'
                                                },
                                                {
                                                    field: 'mtlValuationUnit', title: '计量单位', templet: function (d) {
                                                        return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '';
                                                    }
                                                },
                                                {field: 'mtlPriceUnit', title: '指导单价'}
                                            ]]
                                        });
                                    }
                                },
                                yes: function (index) {
                                    var checkStatus = layTable.checkStatus('materialsTable');
                                    if (checkStatus.data.length > 0) {
                                        var mtlData = checkStatus.data[0];

                                        $tr.find('.mtlLibId').val(mtlData.mtlName);
                                        $tr.find('.mtlLibId').attr('mtlLibId', mtlData.mtlLibId);
                                        $tr.find('.mtlStandard').text(mtlData.mtlStandard|| '');

                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        } else if (layEvent === 'chooseContrast') {
                            var projId = $('#leftId').attr('projId');

                            if (!projId) {
                                projId = globalprojId;
                            }

                            layer.open({
                                type: 1,
                                title: '选择供应商比价',
                                area: ['90%', '90%'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: '<div><div><table id="choosePlbMtlContrastTable" lay-filter="choosePlbMtlContrastTable"></table></div>' +
                                    '<div><h3>比价详情</h3><table id="plbMtlContrastListWithBLOBs" lay-filter="plbMtlContrastListWithBLOBs"></table></div></div>',
                                success: function () {
                                    layTable.render({
                                        elem: '#choosePlbMtlContrastTable',
                                        url: '/plbMtlContrast/selectAll',
                                        page: true,
                                        where: {
                                            projId: projId
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
                                            {field: 'contrastNo', title: '比价编号'},
                                            {field: 'priceComparison', title: '比价事项'},
                                            {
                                                field: 'compareTime', title: '比价时间', templet: function (d) {
                                                    return format(d.compareTime);
                                                }
                                            },
                                            {
                                                field: 'compareType', title: '比价方式', templet: function (d) {
                                                    return dictionaryObj['COMPARE_TYPE']['object'][d.compareType] || ''
                                                }
                                            },
                                            {field: 'remark', title: '备注'}
                                        ]]
                                    });

                                    layTable.on('radio(choosePlbMtlContrastTable)', function (obj) {
                                        var plbMtlContrastListWithBLOBs = obj.data.plbMtlContrastListWithBLOBs || [];
                                        layTable.render({
                                            elem: '#plbMtlContrastListWithBLOBs',
                                            data: plbMtlContrastListWithBLOBs,
                                            maxmin: true,
                                            limit: 1000,
                                            cols: [[
                                                {field: 'planMtlName', title: '材料名称', width: 150},
                                                {field: 'planMtlStandard', title: '材料规格', width: 100},
                                                {
                                                    field: 'customerName1',
                                                    title: '供应商1',
                                                    width: 150,
                                                    templet: function (d) {
                                                        return dictionaryObj['CUSTOMER_NAME']['object'][d.customerName1] || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerUnit1',
                                                    title: '供应商1单价',
                                                    width: 110,
                                                    templet: function (d) {
                                                        return (d.customerUnit1 || '')
                                                    }
                                                },
                                                {
                                                    field: 'customerName2',
                                                    title: '供应商2',
                                                    width: 150,
                                                    templet: function (d) {
                                                        return dictionaryObj['CUSTOMER_NAME']['object'][d.customerName2] || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerUnit2',
                                                    title: '供应商2单价',
                                                    width: 110,
                                                    templet: function (d) {
                                                        return d.customerUnit2 || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerName3',
                                                    title: '供应商3',
                                                    width: 150,
                                                    templet: function (d) {
                                                        return dictionaryObj['CUSTOMER_NAME']['object'][d.customerName3] || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerUnit3',
                                                    title: '供应商3单价',
                                                    width: 110,
                                                    templet: function (d) {
                                                        return d.customerUnit3 || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerName4',
                                                    title: '供应商4',
                                                    width: 150,
                                                    templet: function (d) {
                                                        return dictionaryObj['CUSTOMER_NAME']['object'][d.customerName4] || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerUnit4',
                                                    title: '供应商4单价',
                                                    width: 110,
                                                    templet: function (d) {
                                                        return d.customerUnit4 || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerName5',
                                                    title: '供应商5',
                                                    width: 150,
                                                    templet: function (d) {
                                                        return dictionaryObj['CUSTOMER_NAME']['object'][d.customerName5] || ''
                                                    }
                                                },
                                                {
                                                    field: 'customerUnit5',
                                                    title: '供应商5单价',
                                                    width: 110,
                                                    templet: function (d) {
                                                        return d.customerUnit5 || ''
                                                    }
                                                },
                                                {
                                                    field: 'chooseCustomer',
                                                    title: '选中供应商',
                                                    width: 150,
                                                    templet: function (d) {
                                                        return dictionaryObj['CUSTOMER_NAME']['object'][d.chooseCustomer] || ''
                                                    }
                                                },
                                                {
                                                    field: 'chooseUnit',
                                                    title: '选中供应商单价',
                                                    width: 110,
                                                    templet: function (d) {
                                                        return d.chooseUnit || ''
                                                    }
                                                }
                                            ]],
                                        });
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = layTable.checkStatus('choosePlbMtlContrastTable');

                                    if (checkStatus.data.length > 0) {
                                        $tr.find('[name="contrastNo"]').val(checkStatus.data[0].contrastNo);
                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        }
                    });

                    // 内部-付款结算-上方按钮显示
                    layTable.on('toolbar(paymentSettlementTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                //遍历表格获取每行数据进行保存
                                var $tr = $('.contract_out').find('.layui-table-main tr');
                                var oldDataArr = [];
                                $tr.each(function () {
                                    var oldDataObj = {
                                        mtlContractOutId: $(this).find('input[name="contractMoney"]').attr('mtlContractOutId') || '',
                                        contractMoney: $(this).find('input[name="contractMoney"]').val(),
                                        contractRatio: $(this).find('input[name="contractRatio"]').val(),
                                        paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
                                        termOfPayment: $(this).find('input[name="termOfPayment"]').val()
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                oldDataArr.push({});
                                layTable.reload('paymentSettlementTable', {
                                    data: oldDataArr
                                });
                                break;
                        }
                    });
                    // 内部-付款结算-删行操作
                    layTable.on('tool(paymentSettlementTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            obj.del();
                            if (data.mtlContractOutId) {
                                $.get('/plbMtlContractOut/delete', {mtlContractOutId: data.mtlContractOutId}, function () {});
                            }
                            //遍历表格获取每行数据进行保存
                            var $trs = $('.contract_out').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $trs.each(function () {
                                var oldDataObj = {
                                    mtlContractOutId: $(this).find('input[name="contractMoney"]').attr('mtlContractOutId') || '',
                                    contractMoney: $(this).find('input[name="contractMoney"]').val(),
                                    contractRatio: $(this).find('input[name="contractRatio"]').val(),
                                    paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
                                    termOfPayment: $(this).find('input[name="termOfPayment"]').val()
                                }
                                oldDataArr.push(oldDataObj);
                            })
                            layTable.reload('paymentSettlementTable', {
                                data: oldDataArr
                            });
                        }
                    });

                    function newOrEdit(type, data) {
                        var title = '';
                        var url = '';
                        var projId = $('#leftId').attr('projId');
                        var reviseId = '';
                        var mtlContractId = '';
                        if (type == 2) {
                            title = '修编材料采购合同';
                            url = '/plbMtlContract/updateRevision';
                            projId = globalprojId = data.projId;
                            reviseId = data.reviseId || '';
                            mtlContractId = data.mtlContractId;
                        }

                        layer.open({
                            type: 1,
                            title: title,
                            area: ['100%', '100%'],
                            btn: ['保存', '提交', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layer_wrap"><div class="layui-collapse">',
                                /* region 材料计划 */
                                '<div class="layui-colla-item"><h2 class="layui-colla-title">材料计划</h2>' +
                                '<div class="layui-colla-content layui-show base_info">',
                                '<form id="baseForm" class="layui-form" lay-filter="baseForm">',
                                /* region 第一行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同编号<span field="contractNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly name="contractNo" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="contractName" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同类型<span field="contractType" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="contractType"></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">含税合同金额<span field="contractMoney" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly name="contractMoney" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">履约金比例<span field="bondRatio" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="bondRatio" autocomplete="off" pointFlag="1" class="layui-input payment input_floatNum">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs10" style="padding: 0 5px; width: 80%;">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同内容<span field="contractContent" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<textarea name="contractContent" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">发票类型<span field="invoiceType" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="invoiceType" lay-filter="invoiceType"></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第二行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">甲方<span field="contractA" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="contractA" id="contractA" readonly autocomplete="off" style="cursor: pointer;" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">乙方<span field="customerId" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="customerId" id="customerId" readonly autocomplete="off" style="cursor: pointer;" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同签订日期<span field="signDate" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="signDate" readonly autocomplete="off" class="layui-input" style="cursor: pointer;" id="signDate">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同有效期<span field="contractPeriod" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="contractPeriod" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">税率</label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="taxRate" lay-filter="taxRate"></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第三行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">质保期<span field="warrantyPeriod" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="warrantyPeriod" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">质保金<span field="warrantyCash" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="warrantyCash" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">预付款<span field="paymentPre" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="paymentPre" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同付款方式<span field="paymentType" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="paymentType"></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs2 layui_col">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">不含税合同价<span field="contractMoneyNotax" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly name="contractMoneyNotax" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第四行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">比价附件</label>' +
                                '<div class="layui-input-block form_block">' +
                                '<div class="file_module">' +
                                '<div id="fileContentBJ" class="file_content"></div>' +
                                '<div class="file_upload_box">' +
                                '<a href="javascript:;" class="open_file">' +
                                '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                                '<input type="file" multiple id="fileuploadBJ" data-url="/upload?module=planbudget" name="file">' +
                                '</a>' +
                                '<div class="progress">' +
                                '<div class="bar"></div>\n' +
                                '</div>' +
                                '<div class="bar_text"></div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">合同附件<span field="attachmentId" class="field_required">*</span></label>' +
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
                                '</div>',
                                '<div class="layui-col-xs12" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">备注</label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="remark" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                '</form>',
                                '</div>' ,
                                '</div>',
                                /* endregion */
                                /* region 材料明细 */
                                '<div class="layui-colla-item"><h2 class="layui-colla-title">材料明细</h2>' +
                                '<div class="layui-colla-content layui-show">' +
                                '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
                                '<ul class="layui-tab-title">' +
                                '<li class="layui-this">购买清单</li>' +
                                '<li>付款结算</li>' +
                                '<li>其他约定</li>' +
                                '</ul>' +
                                '<div class="layui-tab-content">' +
                                '<div class="layui-tab-item layui-show contract_list">' +
                                '<div id="contractDetailsModule"><table id="contractDetailsTable" lay-filter="contractDetailsTable"></table></div>' +
                                '</div>' +
                                '<div class="layui-tab-item contract_out">' +
                                '<div id="paymentSettlementModule"><table id="paymentSettlementTable" lay-filter="paymentSettlementTable"></table></div>' +
                                '</div>' +
                                '<div class="layui-tab-item">' +
                                '<textarea name="contractOtherContent" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
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
                                '<input type="text" name="createTime" autocomplete="off" readonly class="layui-input" id="createTime">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs4" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">审批人<span style="margin: 0 20px;">流程定义某节点为审批节点</span>审批时间</label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="approvalerDate" autocomplete="off" readonly class="layui-input" id="approvalerDate">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs4" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">审核人<span style="margin: 0 20px;">流程定义某节点为审核节点</span>审核时间</label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="reviewerDate" autocomplete="off" readonly class="layui-input" id="reviewerDate">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                '</div>' +
                                '</div>',
                                /* endregion */
                                '</div></div>'].join(''),
                            success: function () {
                                // 比价附件
                                fileuploadFn('#fileuploadBJ', $('#fileContentBJ'));
                                // 合同附件
                                fileuploadFn('#fileupload', $('#fileContent'));

                                layElement.render();

                                $('.base_info [name="contractType"]').html(dictionaryObj['CONTRACT_TYPE']['str']);
                                $('.base_info [name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str']);
                                $('.base_info [name="taxRate"]').html(dictionaryObj['TAX_RATE']['str']);
                                $('.base_info [name="invoiceType"]').html(dictionaryObj['INVOICE_TYPE']['str']);

                                layForm.render();

                                var contractDetailsTableData = [];
                                var paymentSettlementTableData = [];

                                if (type == 2) {
                                    layForm.val("baseForm", data);

                                    // 比价附件
                                    if (data.attachmentBj && data.attachmentBj.length > 0) {
                                        var fileArr = data.attachmentBj;
                                        $('#fileContentBJ').append(echoAttachment(fileArr));
                                    }
                                    // 合同附件
                                    if (data.attachments && data.attachments.length > 0) {
                                        var fileArr = data.attachments;
                                        $('#fileContent').append(echoAttachment(fileArr));
                                    }
                                    // 购买清单列表数据
                                    contractDetailsTableData = data.plbMtlContractLists;
                                    //编制时间
                                    $('[name="createTime"]').val(data.createTime);
                                    //审核时间
                                    $('[name="approvalerDate"]').val(data.approvalerDate);
                                    // 审批时间
                                    $('[name="reviewerDate"]').val(data.reviewerDate);

                                    // 付款结算列表数据
                                    paymentSettlementTableData = data.plbMtlContractOuts;
                                    $('#contrastId').val(data.contrastId || '');
                                    // 其他约定
                                    $('[name="contractOtherContent"]').val(data.contractOtherContent);
                                    // 甲方
                                    $('#contractA').val((data.contractAName || '').replace(/,$/, ''));
                                    $('#contractA').attr('deptid', data.contractA);
                                    // 乙方
                                    $('#customerId').val(data.customerName || '');
                                    $('#customerId').attr('customerId', data.customerId || '');
                                } else if (type == 1) {
                                    // 获取自动编号
                                    getAutoNumber({autoNumber: 'plbMtlContract'}, function(res) {
                                        $('input[name="contractNo"]', $('#baseForm')).val(res);
                                    });
                                    $('.refresh_no_btn').show().on('click', function() {
                                        getAutoNumber({autoNumber: 'plbMtlContract'}, function(res) {
                                            $('input[name="contractNo"]', $('#baseForm')).val(res);
                                        });
                                    });
                                }

                                // 初始化购买清单列表
                                layTable.render({
                                    elem: '#contractDetailsTable',
                                    data: contractDetailsTableData,
                                    toolbar: '#toolbarDemoIn',
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [[
                                        {type: 'numbers', title: '序号'},
                                        {
                                            field: 'mtlName', title: '材料名称', width: 200, event: 'chooseMtl', templet: function (d) {
                                                return '<input type="text" contractListId="' + (d.contractListId || '') + '" mtlLibId="' + (d.mtlLibId || '') + '" readonly name="mtlLibId" class="layui-input mtlLibId" style="height: 100%;width: 90%" value="' + (d.mtlName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0px;right: 2px;font-size: 25px;cursor: pointer"></i>'
                                            }
                                        },
                                        {
                                            field: 'mtlStandard', title: '材料规格', templet: function (d) {
                                                return '<span class="mtlStandard">' + (d.mtlStandard || '') + '</span>';
                                            }
                                        },
                                        {
                                            field: 'contractPrice', title: '不含税单价', templet: function (d) {
                                                return '<input type="number" name="contractPrice" class="layui-input contractPrice" autocomplete="off" style="height: 100%;" value="' + (d.contractPrice || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'taxRate', title: '税率(%)', templet: function (d) {
                                                // 发票类型
                                                var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();
                                                var readonly = invoiceType != '01' ? 'readonly' : '';
                                                return '<input type="number" name="taxRate" ' + readonly + ' class="layui-input taxRate" autocomplete="off" style="height: 100%;" value="' + (d.taxRate || 0) + '">'
                                            }
                                        },
                                        {
                                            field: 'contractNumber', title: '数量', templet: function (d) {
                                                return '<input type="text" name="contractNumber" class="layui-input contractNumber"  autocomplete="off" style="height: 100%;" value="' + (d.contractNumber || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'totalAmount', title: '不含税合计', templet: function (d) {
                                                return '<span class="totalAmount">' + (d.totalAmount || '') + '</span>'
                                            }
                                        },
                                        {
                                            field: 'totalIncludingTax', title: '含税合计', templet: function (d) {
                                                return '<span class="totalIncludingTax">' + (d.totalIncludingTax || '') + '</span>'
                                            }
                                        },
                                        {
                                            field: 'contrastNo', title: '材料比价编号', event: 'chooseContrast', templet: function (d) {
                                                return '<input type="text" name="contrastNo" readonly class="layui-input" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + (d.contrastNo || '') + '">'
                                            }
                                        },
                                        {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                                    ]]
                                });

                                // 初始化付款结算列表
                                layTable.render({
                                    elem: '#paymentSettlementTable',
                                    data: paymentSettlementTableData,
                                    toolbar: '#toolbarDemoIn',
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [[
                                        {type: 'numbers', title: '序号'},
                                        {
                                            field: 'contractMoney', title: '约定付款金额', templet: function (d) {
                                                return '<input type="text" mtlContractOutId="' + (d.mtlContractOutId || '') + '" name="contractMoney" pointFlag="1" class="layui-input contractMoney input_floatNum" style="height: 100%;" value="' + (d.contractMoney || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'contractRatio', title: '约定付款比例', templet: function (d) {
                                                return '<input type="text" name="contractRatio" class="layui-input contractRatio" style="height: 100%" value="' + (d.contractRatio || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'paymentPeriod', title: '约定付款日期', templet: function (d) {
                                                return '<input type="text" name="paymentPeriod" readonly class="layui-input paymentPeriod" style="height: 100%;" value="' + (d.paymentPeriod || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'termOfPayment', title: '付款条件', templet: function (d) {
                                                return '<input type="text" name="termOfPayment" class="layui-input termOfPayment" style="height: 100%;" value="' + (d.termOfPayment || '') + '">'
                                            }
                                        },
                                        {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                                    ]],
                                    done: function(res) {
                                        var datas = res.data;
                                        $('.contract_out').find('.paymentPeriod').each(function(i, v){
                                            laydate.render({
                                                elem: v,
                                                trigger: 'click',
                                                value: datas[i].paymentPeriod || ''
                                            });
                                        });
                                    }
                                });

                                // 合同签订日期
                                laydate.render({
                                    elem: '#signDate',
                                    trigger: 'click'
                                });
                                // 编制时间
                                laydate.render({
                                    elem: '#createTime',
                                    trigger: 'click',
                                    format: 'yyyy-MM-dd HH:mm:ss'
                                });
                                // 审批时间
                                laydate.render({
                                    elem: '#approvalerDate',
                                    trigger: 'click',
                                    format: 'yyyy-MM-dd HH:mm:ss'
                                });
                                // 审核时间
                                laydate.render({
                                    elem: '#reviewerDate',
                                    trigger: 'click',
                                    format: 'yyyy-MM-dd HH:mm:ss'
                                });

                                // 选择甲方
                                $('#contractA').on('click', function () {
                                    dept_id = 'contractA';
                                    $.popWindow('/common/selectDept?0');
                                });
                                // 选择乙方
                                $('#customerId').on('click', function () {
                                    var _this = $(this);
                                    layer.open({
                                        type: 1,
                                        title: '选择乙方',
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
                                                var currentData = d.data.currentData;
                                                if (currentData.parentTypeId != 0) {
                                                    $('.mtl_no_data').hide();
                                                    $('.mtl_table_box').show();
                                                    loadMtlTable(currentData.typeNo);
                                                } else {
                                                    $('.mtl_table_box').hide();
                                                    $('.mtl_no_data').show();
                                                }
                                            });

                                            function loadMtlTable(merchantType) {
                                                layTable.render({
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
                                                        {field: 'customerNo', title: '客商编号'},
                                                        {field: 'customerName', title: '客商单位名称'},
                                                        {field: 'customerShortName', title: '客商单位简称'},
                                                        {field: 'customerOrgCode', title: '组织机构代码'},
                                                        {field: 'taxNumber', title: '税务登记号'},
                                                        {field: 'accountNumber', title: '开户行账户'}
                                                    ]]
                                                });
                                            }
                                        },
                                        yes: function (index) {
                                            var checkStatus = layTable.checkStatus('materialsTable');
                                            if (checkStatus.data.length > 0) {
                                                var mtlData = checkStatus.data[0];
                                                _this.val(mtlData.customerName);
                                                _this.attr('customerId', mtlData.customerId);
                                                layer.close(index);
                                            } else {
                                                layer.msg('请选择一项！', {icon: 0});
                                            }
                                        }
                                    });
                                });

                                if ($('[name="invoiceType"]', $('#baseForm')).val() == '01') {
                                    $('[name="contractMoneyNotax"]', $('#baseForm')).attr('readonly', false);
                                } else {
                                    $('[name="contractMoneyNotax"]', $('#baseForm')).attr('readonly', false);
                                }

                                // 选择发票类型
                                layForm.on('select(invoiceType)', function(data){
                                    if (data.value == '01') {
                                        // 税率
                                        var taxRate =  checkFloatNum(dictionaryObj['TAX_RATE']['object'][$('[name="taxRate"]', $('#baseForm')).val()] || '');

                                        var contractMoney = checkFloatNum($('[name="contractMoney"]', $('#baseForm')).val());

                                        var contractMoneyNotax = Math.ceil(((contractMoney * 100) / ((1 + taxRate) * 100)).toFixed(4) * 100) / 100;

                                        $('[name="contractMoneyNotax"]', $('#baseForm')).val(contractMoneyNotax).attr('readonly', false);

                                        // 重新计算购买清单数据
                                        var $tr = $('#contractDetailsModule').find('.layui-table-main tr');
                                        $tr.each(function () {
                                            var $this = $(this);
                                            // 不含税单价
                                            var contractPrice = checkFloatNum($this.find('.contractPrice').val());
                                            // 数量
                                            var count = parseInt($this.find('.contractNumber').val());
                                            if (isNaN(count)) {
                                                count = 0;
                                            }
                                            // 税率
                                            var taxRate = checkFloatNum($this.find('.taxRate').val()) / 100;
                                            // 不含税合计
                                            var totalAmount = count * contractPrice;
                                            $this.find('.totalAmount').text(totalAmount);
                                            // 含税合计
                                            var totalIncludingTax = Math.ceil((totalAmount * (1 + taxRate)).toFixed(4) * 100) / 100;
                                            $this.find('.totalIncludingTax').text(totalIncludingTax);
                                            // 税率可修改
                                            $this.find('.taxRate').attr('readonly', false);
                                        });
                                    } else {
                                        var contractMoney = checkFloatNum($('[name="contractMoney"]', $('#baseForm')).val());

                                        $('[name="contractMoneyNotax"]', $('#baseForm')).val(contractMoney).attr('readonly', true);

                                        // 重新计算购买清单数据
                                        var $tr = $('#contractDetailsModule').find('.layui-table-main tr');
                                        $tr.each(function () {
                                            var $this = $(this);
                                            // 不含税单价
                                            var contractPrice = checkFloatNum($this.find('.contractPrice').val());
                                            // 数量
                                            var count = parseInt($this.find('.contractNumber').val());
                                            if (isNaN(count)) {
                                                count = 0;
                                            }
                                            // 不含税合计
                                            var totalAmount = count * contractPrice;
                                            $this.find('.totalAmount').text(totalAmount);
                                            // 含税合计
                                            var totalIncludingTax = totalAmount;
                                            $this.find('.totalIncludingTax').text(totalIncludingTax);
                                            // 税率不可修改
                                            $this.find('.taxRate').attr('readonly', true);
                                        });
                                    }
                                });
                                // 选择税率
                                layForm.on('select(taxRate)', function(data){
                                    var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();

                                    if (invoiceType == '01') {
                                        // 税率
                                        var taxRate =  checkFloatNum(dictionaryObj['TAX_RATE']['object'][data.value] || '');

                                        var contractMoney = checkFloatNum($('[name="contractMoney"]', $('#baseForm')).val());

                                        var contractMoneyNotax = Math.ceil(((contractMoney * 100) / ((1 + taxRate) * 100)).toFixed(4) * 100) / 100;

                                        $('[name="contractMoneyNotax"]', $('#baseForm')).val(contractMoneyNotax);
                                    }
                                });
                            },
                            yes: function (index) {
                                var loadIndex = layer.load();

                                var baseData = getSaveData(type, false, loadIndex, mtlContractId, reviseId, projId).dataObj;

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
                            },
                            btn2: function (index) {
                                // 提交前先保存
                                var loadIndex = layer.load();

                                var baseData = getSaveData(type, true, loadIndex, mtlContractId, reviseId, projId);

                                $.ajax({
                                    url: url,
                                    data: JSON.stringify(baseData.dataObj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success: function (res) {
                                        layer.close(loadIndex);
                                        if (res.flag) {
                                            if (!reviseId) {
                                                reviseId = res.object;
                                            }
                                            layer.open({
                                                type: 1,
                                                title: '选择流程',
                                                area: ['70%', '80%'],
                                                btn: ['确定', '取消'],
                                                btnAlign: 'c',
                                                content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
                                                success: function () {
                                                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '18'}, function (res) {
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

                                                        newWorkFlow(flowData.flowId, JSON.stringify(baseData.baseObj), function (res) {
                                                            // 报销单保存关联的runId
                                                            var submitData = {
                                                                reviseId: reviseId,
                                                                runId: res.flowRun.runId,
                                                                auditerStatus: '1'
                                                            }
                                                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                            $.ajax({
                                                                url: '/plbMtlContract/update',
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
                            contractNo: $('input[name="contractNo"]', $('.query_module')).val(),
                            contractName: $('input[name="contractName"]', $('.query_module')).val(),
                            auditerStatus: $('input[name="auditerStatus"]', $('.query_module')).val()
                        }

                        return searchObj
                    }

                    /**
                     * 获取需要保存的数据
                     * @param saveType (1-新增, 2-编辑)
                     * @param isSubmit (是否提交)
                     * @param loadIndex
                     * @param reviseId
                     */
                    function getSaveData(saveType, isSubmit, loadIndex, mtlContractId, reviseId, projId) {
                        //材料计划数据
                        var datas = $('#baseForm').serializeArray();
                        var dataObj = {}
                        datas.forEach(function (item) {
                            dataObj[item.name] = item.value;
                        });

                        // 甲方
                        dataObj.contractA = ($('#contractA').attr('deptid') || '').replace(/,$/, '');
                        // 乙方
                        dataObj.customerId = $('#customerId').attr('customerId') || '';

                        // 比价附件
                        var attachmentIdBj = '';
                        var attachmentNameBj = '';
                        for (var i = 0; i < $('#fileContentBJ .dech').length; i++) {
                            attachmentIdBj += $('#fileContentBJ .dech').eq(i).find('input').val();
                            attachmentNameBj += $('#fileContentBJ a').eq(i).attr('name');
                        }
                        dataObj.attachmentIdBj = attachmentIdBj;
                        dataObj.attachmentNameBj = attachmentNameBj;

                        // 合同附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent a').eq(i).attr('name');
                        }
                        dataObj.attachmentId = attachmentId;
                        dataObj.attachmentName = attachmentName;

                        if (isSubmit) {
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

                        // 购买清单数据
                        var $tr1 = $('#contractDetailsModule').find('.layui-table-main tr');
                        var plbMtlContractLists = [];
                        $tr1.each(function () {
                            var plbMtlContractObj = {
                                mtlLibId: $(this).find('input[name="mtlLibId"]').attr('mtlLibId') || '',
                                contractPrice: $(this).find('input[name="contractPrice"]').val(),
                                taxRate: $(this).find('input[name="taxRate"]').val(),
                                contractNumber: $(this).find('input[name="contractNumber"]').val(),
                                totalAmount: $(this).find('.totalAmount').text(),
                                totalIncludingTax: $(this).find('.totalIncludingTax').text(),
                                contrastNo: $(this).find('input[name="contrastNo"]').val()
                            }
                            if ($(this).find('input[name="mtlLibId"]').attr('contractListId')) {
                                plbMtlContractObj.contractListId = $(this).find('input[name="mtlLibId"]').attr('contractListId');
                            }
                            plbMtlContractLists.push(plbMtlContractObj);
                        });
                        dataObj.plbMtlContractLists = plbMtlContractLists;

                        // 付款结算数据
                        var $tr2 = $('#paymentSettlementModule').find('.layui-table-main tr');
                        var plbMtlContractOuts = [];
                        $tr2.each(function () {
                            var plbMtlContractObj = {
                                contractMoney: $(this).find('input[name="contractMoney"]').val(),
                                contractRatio: $(this).find('input[name="contractRatio"]').val(),
                                paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
                                termOfPayment: $(this).find('input[name="termOfPayment"]').val()
                            }
                            if ($(this).find('input[name="contractMoney"]').attr('mtlContractOutId')) {
                                plbMtlContractObj.mtlContractOutId = $(this).find('input[name="contractMoney"]').attr('mtlContractOutId');
                            }
                            plbMtlContractOuts.push(plbMtlContractObj);
                        });
                        dataObj.plbMtlContractOuts = plbMtlContractOuts;

                        // 其他约定
                        dataObj.contractOtherContent = $('[name="contractOtherContent"]').val();

                        //编制时间
                        dataObj.createTime = $('[name="createTime"]').val();

                        //审批时间
                        dataObj.approvalerDate = $('[name="approvalerDate"]').val();

                        //审核时间
                        dataObj.reviewerDate = $('[name="reviewerDate"]').val();

                        if (reviseId) {
                            dataObj.reviseId = reviseId;
                        }
                        dataObj.mtlContractId = mtlContractId;
                        dataObj.projId = projId;

                        return {
                            dataObj: dataObj,
                            baseObj: baseObj
                        }
                    }
                });
            }

            // 监听含税合同金额只输入数字
            $(document).on('keypress', '.input_float_num', function (e) {
                var key = window.event ? e.keyCode : e.which;
                if (!((key > 95 && key < 106) || key == 46 || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            });
            // 监听含税合同金额*内容
            $(document).on('input propertychange', '.input_float_num', function (event) {
                var value = checkFloatNum($(this).val());

                $(this).val(value);

                var contractMoneyNotax = value;

                var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();

                if (invoiceType == '01') { // 增值税专用发票
                    // 税率
                    var taxRate = checkFloatNum(dictionaryObj['TAX_RATE']['object'][$('[name="taxRate"]', $('#baseForm')).val()] || '');

                    contractMoneyNotax = Math.ceil(((value * 100) / ((1 + taxRate) * 100)).toFixed(4) * 100) / 100;
                }

                $('[name="contractMoneyNotax"]', $('#baseForm')).val(contractMoneyNotax);
            });

            //监听履约金比例只能输入数字
            $(document).on('keypress', '.payment', function (e) {
                var key = window.event ? e.keyCode : e.which;
                if (!((key > 95 && key < 106) || key == 46 || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            });

            // 监听不含税单价只输入数字
            $(document).on('keypress', '.contractPrice', function (e) {
                var key = window.event ? e.keyCode : e.which;
                if (!((key > 95 && key < 106) || key == 46 || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            });
            // 监听不含税单价输入内容
            $(document).on('input propertychange', '.contractPrice', function (event) {
                // 不含税单价
                var contractPrice = checkFloatNum($(this).val());
                $(this).val(contractPrice);
                var $tr = $(this).parents('tr');
                // 发票类型
                var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();
                // 数量
                var count = parseInt($tr.find('.contractNumber').val());
                if (isNaN(count)) {
                    count = 0;
                }
                // 不含税合计
                var totalAmount = contractPrice * count;
                $tr.find('.totalAmount').text(totalAmount);
                // 含税合计
                var totalIncludingTax = totalAmount;
                if (invoiceType == '01') { // 增值税专用发票
                    // 税率
                    var taxRate = checkFloatNum($tr.find('.taxRate').val()) / 100;
                    // 含税合计
                    totalIncludingTax = Math.ceil((totalAmount * (1 + taxRate)).toFixed(4) * 100) / 100;
                }
                $tr.find('.totalIncludingTax').text(totalIncludingTax);
            });

            // 监听税率只输入数字
            $(document).on('keypress', '.taxRate', function (e) {
                var key = window.event ? e.keyCode : e.which;
                if (!((key > 95 && key < 106) || key == 46 || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            });
            // 监听税率输入内容
            $(document).on('input propertychange', '.taxRate', function (event) {
                // 税率
                var taxRate = checkFloatNum($(this).val());
                $(this).val(taxRate);
                // 发票类型
                var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();
                if (invoiceType == '01') { // 增值税专用发票
                    var $tr = $(this).parents('tr');
                    // 不含税合计
                    var totalAmount = checkFloatNum($tr.find('.totalAmount').text());
                    taxRate = taxRate / 100;
                    // 含税合计
                    var totalIncludingTax = Math.ceil((totalAmount * (1 + taxRate)).toFixed(4) * 100) / 100;
                    $tr.find('.totalIncludingTax').text(totalIncludingTax);
                }
            });

            // 监听数量只输入数字
            $(document).on('keypress', '.contractNumber', function (e) {
                var key = window.event ? e.keyCode : e.which;
                if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            });
            // 监听数量输入内容
            $(document).on('input propertychange', '.contractNumber', function (event) {
                // 数量
                var count = parseInt($(this).val());
                if (isNaN(count)) {
                    count = 0;
                }
                $(this).val(count);
                var $tr = $(this).parents('tr');
                // 不含税单价
                var contractPrice = checkFloatNum($tr.find('.contractPrice').val());
                // 不含税合计
                var totalAmount = count * contractPrice;
                $tr.find('.totalAmount').text(totalAmount);
                // 含税合计
                var totalIncludingTax = totalAmount;
                // 发票类型
                var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();
                if (invoiceType == '01') { // 增值税专用发票
                    // 税率
                    var taxRate = checkFloatNum($tr.find('.taxRate').val()) / 100;
                    totalIncludingTax = Math.ceil((totalAmount * (1 + taxRate)).toFixed(4) * 100) / 100;
                }
                $tr.find('.totalIncludingTax').text(totalIncludingTax);
            });

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
