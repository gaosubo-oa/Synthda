<%--
  Created by IntelliJ IDEA.
  User: 吴祖明
  Date: 2021/3/31
  Time: 9:21
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
    <title>客商管理</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20210811.1"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210527.1"></script>

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

        .not_necessary {
            display: none;
        }

        .field_required {
            display: inline-block;
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
            z-index: 999;
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

        .fixed {
            position: fixed !important;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="wrapper">
        <div class="wrap_left">
            <h2>客商管理</h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="客商名称" autocomplete="off" class="layui-input" />
                <div style="margin-bottom:10px; text-align: center;" hidden>
                    <button type="button" class="layui-btn layui-btn-sm edit_btn" edit="1" >新建</button>
                    <button type="button" class="layui-btn layui-btn-sm edit_btn" edit="2">修改</button>
                    <button type="button" class="layui-btn layui-btn-sm" id="delPlan">删除</button>
                </div>
            </div>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="customerNo" placeholder="客商编号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="customerName"  placeholder="客商单位名称/简称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select id="auditerStatus" name="auditerStatus">
                        <option value="">请选择状态</option>
                        <option value="0">未提交</option>
                        <option value="1">审批中</option>
                        <option value="2">批准</option>
                    </select>
                    <%--                            <input type="text" name="auditerStatus" placeholder="客商单位名称/简称" autocomplete="off" class="layui-input">--%>
                </div>
                <div class="layui-col-xs4" style="margin-top: 3px;text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>
                </div>
                <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>
            </div>
            <div style="position: relative">
                <div class="table_box">
                    <table id="questionTable" lay-filter="questionTable"></table>
                    <div id="laypages"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container" style="height: 30px;position:absolute;top: 10px;left:10px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="submit">提交审批</button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
            <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">
            导出
        </button>
        <div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>
    </div>
</script>

<script type="text/html" id="checkBar">
    <button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button>
    <button class="layui-btn layui-btn-xs" lay-event="preview">查看详情</button>
</script>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>
    // 当前选中树节点
    var currentNode = null
    var xhr = null;
    var leftTreeData = {}

    // 表格显示顺序
    var colShowObj = {
        customerNo: {field: 'customerNo', title: '客商编号', minWidth: 120, hide: false, sort: true},
        customerName: {field: 'customerName', title: '客商单位名称', minWidth: 160, hide: false, sort: true},
        customerShortName: {field: 'customerShortName', title: '客商单位简称', minWidth: 160, hide: false, sort: true},
        supplierGroupName: {field: 'supplierGroupName', title: '所属集团', minWidth: 160, hide: false, sort: true},
        auditerStatus: {
            field: 'auditerStatus', title: '状态', minWidth: 100, sort: true, hide: false, templet: function (d) {
                if (d.auditerStatus == '1') {
                    var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                    return '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: orange;cursor: pointer;" ' + flowStr + '>审批中</span>'
                } else if (d.auditerStatus == '2') {
                    var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                    return '<span  class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>批准</span>'
                } else if (d.auditerStatus == '3') {
                    var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                    return '<span  class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>不批准</span>'
                } else {
                    return '未提交'
                }
            }
        },
        revisionCount: {
            field: 'revisionCount',
            title: '变更次数',
            minWidth: 120,
            hide: false,
            sort: true,
            event: 'revisionCount',
            style: 'cursor: pointer; color: blue;'
        }
    }
    var TableUIObj = new TableUI('plb_customer');

    // 获取数据字典数据
    var dictionaryObj = {
        CUSTOMER_SOURCE: {}, // 客商来源
        CUSTOMER_NATURE: {}, // 单位性质
        CUSTOMER_TYPE: {}, // 单位类别
        SUPPLIER_TYPE: {}, // 客商类型
        ACCOUNT_ROLE: {}, // 客商角色
        GRADE_STATUS: {} // 等级状态
    }
    var dictionaryStr = 'CUSTOMER_SOURCE,CUSTOMER_NATURE,CUSTOMER_TYPE,SUPPLIER_TYPE,ACCOUNT_ROLE,GRADE_STATUS';
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

    layui.use(['eleTree', 'table', 'form', 'soulTable', 'element', 'xmSelect', 'laydate','treeTable','laypage'], function () {
        var table = layui.table,
            form = layui.form,
            eleTree = layui.eleTree,
            laypage = layui.laypage,
            treeTable = layui.treeTable,
            soulTable = layui.soulTable,
            element = layui.element,
            laydate = layui.laydate,
            xmSelect = layui.xmSelect;

        form.render();
        var typeNos;
        var questionTable = null;
        // //监听单选框选中
        // treeTable.on('radio(test)',function(data){
        //     console.log(data)
        // })

        TableUIObj.init(colShowObj, function(){
            tableInit();
        });

        projectLeft();

        /**
         * 左侧项目信息列表
         * @param typeName 名称
         */
        function projectLeft(typeName) {
            typeName = typeName ? typeName : '';
            var loadingIndex = layer.load();
            $.get('/PlbCustomerType/treeList', {typeName: typeName}, function (res) {
                layer.close(loadingIndex);
                leftTreeData = res.data;
                var leftTree = eleTree.render({
                    elem: '#leftTree',
                    data: res.data,
                    showLine: true,
                    highlightCurrent: true,
                    defaultExpandAll: true,
                    checkOnClickNode: true,
                    request: {
                        key: "typeId",
                        name: 'typeName',
                        children: "child",
                    }
                });
                $('.eleTree-node-content-label').each(function(){
                    var titleSpan=$(this).text();
                    $(this).attr('title',titleSpan);
                })
                if (currentNode) {
                    leftTree.setHighlightNode(currentNode.typeId);
                }
            });
        }
        /* region 修改左侧项目名称 */
        var searchTimer = null
        $('#search_project').on('input propertychange', function () {
            clearTimeout(searchTimer)
            searchTimer = null
            var val = $(this).val()
            searchTimer = setTimeout(function () {
                projectLeft(val);
            }, 300)
        })
        $('.search_icon').on('click', function () {
            projectLeft($('#search_project').val());
        });
        /* endregion */
        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            typeNos = d.data.currentData.typeNo;
            currentNode = d.data.currentData;
            tableInit();
            $('.eleTree-node-content-label').each(function(){
                var titleSpan=$(this).text();
                $(this).attr('title',titleSpan);
            })
        });

        // 监听排序事件
        treeTable.on('sort(questionTable)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableInit();
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

        treeTable.on('toolbar(questionTable)', function (obj) {
            var checkStatus = questionTable.checkStatus();
            switch (obj.event) {
                case 'add':
                    if (!currentNode) {
                        layer.msg('请选择左侧部门！', {icon: 0, time: 1500});
                        return false;
                    }
                    newOrEdit(1);
                    break;

                case 'del':
                    if (checkStatus.length == 0) {
                        layer.msg('请选择需要删除的数据！', {icon: 0});
                        return false;
                    }
                    var customerId = [];
                    checkStatus.forEach(function (v, i) {
                        if (!(checkStatus.auditerStatus > 0)) {
                            customerId.push(v.customerId);
                        }
                    });
                    layer.confirm('确定删除选中数据吗？', function (index) {
                        $.ajax({
                            url: '/PlbCustomer/delCustomer',
                            dataType: 'json',
                            type: 'post',
                            data: {customerId: customerId},
                            traditional: true,
                            success: function (res) {
                                layer.close(index);
                                if (res.flag) {
                                    layer.msg('删除成功！', {icon: 1});

                                    questionTable.reload();
                                } else {
                                    layer.msg('删除失败！', {icon: 2});
                                }
                            }
                        });
                    });
                    break;
                case 'submit': // 提交
                    if (checkStatus.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                        return false;
                    }
                    if (checkStatus.auditerStatus > 0) {
                        layer.msg('不能重复提交审批！', {icon: 0, time: 2000});
                        return false;
                    }
                    if (!checkSubmit(checkStatus[0])){
                        return false
                    }
                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '32'}, function (res) {
                        var flowDataArr = []
                        $.each(res.data.flowData, function (k, v) {
                            flowDataArr.push({
                                flowId: k,
                                flowName: v
                            });
                        });

                        if (flowDataArr.length == 1) {
                            var newApprovalData = filterSubmitData(checkStatus[0]);
                            newWorkFlow(flowDataArr[0].flowId, JSON.stringify(newApprovalData), function (res) {
                                // 报销单保存关联的runId
                                var submitData = {
                                    customerId: newApprovalData.customerId,
                                    runId: res.flowRun.runId,
                                    auditerStatus: 1
                                }
                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowDataArr[0].flowId + '&type=new&flowStep=1&prcsId=1&&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                $.ajax({
                                    url: '/PlbCustomer/insertOrUpdate',
                                    data: JSON.stringify(submitData),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success: function (res) {
                                        if (res.flag) {
                                            layer.closeAll();
                                            layer.msg('提交成功!', {icon: 1});
                                            questionTable.reload()
                                        } else {
                                            layer.msg('提交失败!', {icon: 2});
                                        }
                                    }
                                });
                            });
                        } else {
                            submitFlow(checkStatus[0]);
                        }
                    })
                    break;
                case 'export': // 导出
                    $('.export_moudle').show();
                    break;
            }
        });

        treeTable.on('tool(questionTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;

            if (layEvent === 'preview') { // 查看详情
                layer.open({
                    title: '客商详情',
                    type: 2,
                    area: ['100%', '100%'],
                    content: '/PlbCustomer/plbCustomerDetail?customerId=' + data.customerId
                });
            } else if (layEvent === 'revisionCount') { // 变更记录
                if (data.revisionCount == 0) {
                    layer.msg('该数据未变更！', {icon: 0, time: 2000});
                    return false;
                }
                checkHistory(data);
            } else if (layEvent === 'edit') { // 编辑
                if (data.auditerStatus > 0) {
                    layer.msg('所选数据已提交，不可编辑！', {icon: 0, time: 2000});
                    return false;
                }
                $.get('/PlbCustomer/queryId', {customerId: data.customerId}, function (res) {
                    if (res.flag) {
                        newOrEdit(2, res.data);
                    } else {
                        layer.msg('获取信息失败!', {icon: 0});
                    }
                });
            }
        });

        // 内部加行按钮
        table.on('toolbar(customerBankTable)', function (obj) {
            switch (obj.event) {
                case 'add':

                    // 遍历表格获取每行数据进行保存
                    var $trs = $('#customerBankTableBox').find('.layui-table-main tr');
                    var oldDataArr = []
                    $trs.each(function (i, v) {
                        var oldDataObj = {
                            bankId: $(v).find('[name="bankId"]').val(),
                            accountType: $(v).find('[name="accountType"]').val(),
                            collectionAccountName:$(v).find('[name="collectionAccountName"]').val(),
                            bankOfDeposit: $(v).find('[name="bankOfDeposit"]').attr('number'),
                            bankOfDepositName:$(v).find('[name="bankOfDeposit"]').val(),
                            bankAccount: $(v).find('[name="bankAccount"]').val(),
                            index: 'index_' + i
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    oldDataArr.push({
                        index: 'index_' + $trs.length,
                        accountType: 0
                    });
                    table.reload('customerBankTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });
        // 内部删行操作
        table.on('tool(customerBankTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;

            if (layEvent === 'del') {
                obj.del();
                if (data.bankId) {
                    $.get('/PlbCustomer/delBank', {bankId: data.bankId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $trs = $('#customerBankTableBox').find('.layui-table-main tr');
                var oldDataArr = [];
                $trs.each(function (i, v) {
                    var oldDataObj = {
                        bankId: $(v).find('[name="bankId"]').val(),
                        accountType: $(v).find('[name="accountType"]').val(),
                        collectionAccountName: $(v).find('[name="collectionAccountName"]').val(),
                        bankOfDepositName: $(v).find('[name="bankOfDeposit"]').val(),
                        bankOfDeposit: $(v).find('[name="bankOfDeposit"]').attr('number'),
                        bankAccount: $(v).find('[name="bankAccount"]').val(),
                        index: 'index_' + i
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('customerBankTable', {
                    data: oldDataArr
                });
            }
        });

        // 删除树
        $('#delPlan').on('click',function () {
            if (!currentNode) {
                layer.msg('请选择需要删除的节点!', {icon: 0});
                return false;
            }

            layer.confirm('确定删除该模板吗？', function (index) {
                $.post('/PlbCustomerType/delCustomer', {customerTypeIds: currentNode.typeId}, function(res) {
                    layer.close(index);
                    if (res.flag) {
                        layer.msg('删除成功！', {icon: 1});
                        currentNode = null;
                        projectLeft();
                        tableInit();
                    } else {
                        layer.msg('删除失败！', {icon: 2});
                    }
                });
            });
        });
        // 新建/编辑 树节点
        $('.edit_btn').on('click',function () {
            var type = $(this).attr('edit');
            var title = '';
            if (type == 1) {
                title = '新建模板';
            } else if (type == 2) {
                title = '修改模板';
                if (!currentNode) {
                    layer.msg('请选择需要编辑的节点!', {icon: 0});
                    return false;
                }
            }
            var typeId = currentNode ? currentNode.typeId : 0;
            var parentTypeId = null;
            layer.open({
                type: 1,
                title: title,
                area: ['60%', '70%'],
                btn: ['保存', '取消'],
                btnAlign: 'c',
                content: ['<div style="padding: 20px;" >' +
                '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label">类型编号<b style="color: red">*</b></label>' +
                    '<div class="layui-input-block">' +
                    '<input type="text" name="typeNo" lay-verify="title" autocomplete="off"  class="layui-input testNull" title="类型编号">' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label">类型名称<b style="color: red">*</b></label>' +
                    '<div class="layui-input-block">' +
                    '<input type="type" name="typeName" autocomplete="off" class="layui-input testNull" title="类型名称" >' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label">上级类型名称<b style="color: red">*</b></label>' +
                    '<div class="layui-input-block">' +
                    '<div id="parentTypeId" class="xm-select-demo"></div>' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label">类型描述</label>' +
                    '<div class="layui-input-block">' +
                    '<input type="type" name="typeDesc" autocomplete="off" class="layui-input"></input>' +
                    '</select>' +
                    '</div>' +
                    '</div>',
                    '</form></div>'].join(''),
                success: function () {
                    var treeData = deepClone(leftTreeData);
                    if (type == 2) {
                        filterTreeData(treeData, currentNode.typeId, 'typeId', 'child');
                    }

                    parentTypeId = xmSelect.render({
                        el: '#parentTypeId',
                        radio: true,
                        clickClose: true,
                        name: 'parentTypeId',
                        prop: {
                            name: 'typeName',
                            value: 'typeId',
                            children: 'child'
                        },
                        tree: {
                            show: true,
                            strict: false,
                            expandedKeys: [-1]
                        },
                        data: treeData
                    });

                    if (type == 2) {
                        form.val("baseForm", currentNode);

                        parentTypeId.setValue([currentNode.parentTypeId]);
                    } else {
                        parentTypeId.setValue([typeId]);
                    }
                },
                yes: function (index) {
                    var loadIndex = layer.load();

                    //必填项提示
                    var requireFlag = false
                    for (var i = 0; i < $('.testNull').length; i++) {
                        if ($('.testNull').eq(i).val() == '') {
                            layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                            requireFlag = true
                            return false
                        }
                    }

                    if (requireFlag) {
                        layer.close(loadIndex);
                        return false;
                    }

                    var obj = form.val("baseForm");

                    obj.parentTypeId = obj.parentTypeId || 0;

                    if (type == 2) {
                        obj.typeId = typeId;
                    }

                    $.post('/PlbCustomerType/insertOrUpdate', obj, function (res) {
                        layer.close(loadIndex);
                        if (res.flag) {
                            layer.msg('保存成功！', {icon: 1});
                            layer.close(index);
                            projectLeft();
                        } else {
                            layer.msg('保存失败！', {icon: 2});
                        }
                    });
                }
            });
        });

        function tableInit() {
            var searchObj = getSearchObj();
            searchObj.merchantType = currentNode ? currentNode.typeNo : '';
            searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
            searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;
            //分页
            $.ajax({
                url: '/PlbCustomer/getDataByCondition',//封装传递路径
                data: searchObj,//封装数据
                dataType: 'json',
                type: 'post',
                success: function (res) {
                    laypage.render({
                        elem: 'laypages'
                        ,count: res.totleNum
                        ,curr: location.hash.replace('#!fenye=', '') //获取起始页
                        ,hash: 'fenye'
                        ,layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
                        ,jump: function(obj){
                            searchObj.page=obj.curr
                            searchObj.pageSize=obj.limit
                            questionTable =treeTable.render(option);
                        }
                    });
                }
            });

            var option = {
                elem: '#questionTable',
                url: '/PlbCustomer/getDataByCondition',
                toolbar: '#toolbar',
                defaultToolbar: ['filter'],
                tree: {
                    iconIndex: 1,
                    idName: 'customerName',
                    childName:'plbCustomerWithBLOBsList',
                },
                cols: [[
                    {type:'checkbox'},
                    {field: 'customerNo', title: '客商编号', minWidth: 160, hide: false, sort: true},
                    {field: 'customerName', title: '客商单位名称', minWidth: 160, hide: false, sort: true},
                    {field: 'customerShortName', title: '客商单位简称', minWidth: 160, hide: false, sort: true},
                    {field: 'supplierGroup', title: '所属集团', minWidth: 120, hide: false, sort: true},
                    {
                        field: 'auditerStatus', title: '状态', minWidth: 100, sort: true, hide: false, templet: function (d) {
                            if (d.auditerStatus == '1') {
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                return '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: orange;cursor: pointer;" ' + flowStr + '>审批中</span>'
                            } else if (d.auditerStatus == '2') {
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                return '<span  class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>批准</span>'
                            } else if (d.auditerStatus == '3') {
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                return '<span  class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>不批准</span>'
                            } else {
                                return '未提交'
                            }
                        }
                    },
                    { field: 'revisionCount',  title: '变更次数', minWidth: 120, hide: false, sort: true,event: 'revisionCount',style: 'cursor: pointer; color: blue;',templet: function (d) {
                            if (!d.revisionCount){
                                return 0
                            }else{
                                return d.revisionCount
                            }
                        }},
                    {fixed: 'right',align: 'center', toolbar: '#checkBar', title: '操作', width: 140}
                ]],
                height: 'full-60',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: searchObj,
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": '0', //解析接口状态
                        "data": res.data ,//解析数据列表
                        "count": res.totleNum,
                    };
                },
                request: {
                    limitName: 'pageSize'
                },
                // response: {
                //     statusName: 'flag',
                //     statusCode: true,
                //     msgName: 'msg',
                //     countName: 'totleNum',
                //     dataName: 'data'
                // },
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

            questionTable =treeTable.render(option);


        }

        /**
         * 新增/编辑方法
         * @param type (1-新增，2-编辑)
         * @param data (编辑时的客商信息)
         */
        function newOrEdit(type, data) {
            var url = '/PlbCustomer/insertOrUpdate';
            var title = '';
            var customerId = '';
            var customerSelectTree = null;
            if (type == 1) {
                title = '新增客商';
            } else if (type == 2) {
                title = '编辑客商';
                customerId = data.customerId;
            }

            layer.open({
                id: 'newOrEditLayer',
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: ['保存', '提交', '取消'],
                btnAlign: 'c',
                scrollbar: false,
                content: ['<div class="layui-collapse" style="margin-bottom: 20px;">'+
                '<div class="layui-colla-item">'+
                '<h2 class="layui-colla-title">基本信息</h2>'+
                '<div class="layui-colla-content layui-show">' +
                '<form class="layui-form" lay-filter="baseForm" id="baseForm" style="padding: 0px 10px">',
                    '<input type="hidden" name="merchantType" value=""/>' +
                    /* region 第一行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">客商编号<span field="customerNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" readonly name="customerNo" autocomplete="off" class="layui-input"/>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">客商单位名称<span field="customerName" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="customerName" id="customerName"autocomplete="off" class="layui-input"/>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">客商单位简称<span field="customerShortName" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="customerShortName" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">客商类型<span field="supplierType" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <div id="supplierTypeTree" class="xm-select-demo"></div>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>' +
                    '</div>',
                    /* endregion */
                    /*region 第二行 */
                    '<div class="layui-row">',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">客户角色<span field="accountRole" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <div id="accountRoleTree" class="xm-select-demo"></div>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>' +
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">客商来源</label>' +
                    '       <div class="layui-input-block form_block">' +
                    // '           <select name="customerSource"></select>' +
                    '<div id="customerSelectTree"  class="xm-select-demo" style="width: 100%;"></div>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">统一社会信用代码<span field="customerOrgCode" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="customerOrgCode" placeholder="若个人请录入本人身份证号" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">所属集团<span field="customerOrgCode" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="supplierGroupName"  id="supplierGroup" readonly placeholder="请选择集团" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs12" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">是否为非合同管理客商<span field="contractCustomers" class="field_required ">*</span></label>' +
                    '       <div class="layui-input-block form_block" >' +
                    ' 			<input type="radio" name="contractCustomers"  lay-filter="contractCustomers" class="contractCustomers" value="1" title="是">'+
                    '           <input type="radio" name="contractCustomers" lay-filter="contractCustomers2" class="contractCustomers" value="0" title="否" checked>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /*region 第三行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs12" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label" style="display: inline-block;">资证材料<span field="attachmentId" class="field_required not_necessarys">*</span></label><span>（若个人请上传本人身份证扫描件！客商单位请上传营业执照、收款资料等扫描件！）</span>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <div class="file_module">' +
                    '               <div id="fileContent" class="file_content"></div>' +
                    '               <div class="file_upload_box">' +
                    '                   <a href="javascript:;" class="open_file">' +
                    '                       <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                    '                       <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                    '                   </a>' +
                    '                   <div class="progress">' +
                    '                       <div class="bar"></div>' +
                    '                   </div>' +
                    '                   <div class="bar_text"></div>' +
                    '               </div>' +
                    '           </div>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>' +
                    '</div>',
                    /* endregion */
                    '</form>'+
                    '</div>'+
                    '</div>'+

                    '<div class="layui-colla-item "  id="contractCustomers">'+
                    '<h2 class="layui-colla-title">管理客商</h2>'+
                    '<div class="layui-colla-content layui-show">' +
                    '<form class="layui-form" lay-filter="baseForm" id="baseForms" style="padding: 0px 10px">',
                    /*region 第四行 */
                    '<div class="layui-row">',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">单位性质<span field="customerNature" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <select name="customerNature"></select>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">单位类型<span field="customerType" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <select name="customerType"></select>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px"> ' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">法定代表人<span field="legalPeron" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="legalPeron" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">注册资本（万元）<span field="regCapital" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="number" name="regCapital" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /*region 第五行 */
                    '<div class="layui-row">',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">注册地址<span field="accountAddress" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="accountAddress" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">成立日期<span field="dateEstablishment" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" id="dateEstablishment" readonly name="dateEstablishment" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">营业期限<span field="termOfOperation" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="termOfOperation" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">企业经营状态<span field="managementForms" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="managementForms" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /*region 第六行 */
                    '<div class="layui-row">',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">单位电话<span field="accountTelno" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="accountTelno" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">单位营业地址<span field="businessAddress" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="businessAddress" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">等级状态</label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <select name="gradeStatus"></select>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px"> ' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">联系人<span field="contactPerson" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="contactPerson" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '<div class="layui-col-xs3" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">联系电话<span field="contactTelno" class="field_required">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <input type="text" name="contactTelno" autocomplete="off" class="layui-input">' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /*region 第七行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">经营范围<span field="businessScope" class="field_required not_necessary">*</span></label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <textarea name="businessScope" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                    '       </div>' +
                    '  </div>' +
                    '</div>',
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">备注</label>' +
                    '       <div class="layui-input-block form_block">' +
                    '           <textarea name="remarks" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>' +
                    '</div>',
                    /* endregion */
                    '</form>'+
                    '</div>'+
                    ' </div>'+
                    '<div class="layui-colla-item">'+
                    '<h2 class="layui-colla-title">账号信息</h2>'+
                    '<div class="layui-colla-content layui-show" id="customerBankTableBox">' +
                    '<table id="customerBankTable" lay-filter="customerBankTable"></table>'+
                    '</div>'+
                    ' </div>'+
                    '</div>'].join(''),
                success: function () {
                    fileuploadFn('#fileupload', $('#fileContent'));
                    form.on('radio(contractCustomers)', function(data){
                        $(' .not_necessarys').hide()
                        $('#contractCustomers').hide()
                    });
                    form.on('radio(contractCustomers2)', function(data){
                        $('#contractCustomers').show()
                        $(' .not_necessarys').show()
                    });
                    // $('select[name="customerSource"]').html(dictionaryObj['CUSTOMER_SOURCE']['str']);
                    $('select[name="customerNature"]').html(dictionaryObj['CUSTOMER_NATURE']['str']);
                    $('select[name="customerType"]').html(dictionaryObj['CUSTOMER_TYPE']['str']);
                    $('select[name="gradeStatus"]').html(dictionaryObj['GRADE_STATUS']['str']);

                    /*获取客商来源数据----start*/
                    customerSelectTree = xmSelect.render({
                        el: '#customerSelectTree',
                        content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                            '<input type="text" style="box-sizing: border-box;" class="layui-input" id="customerSelect">' +
                            '</div>' +
                            '<div style="padding-top: 30px;" id="customerTree" class="eleTree" lay-filter="customerTree"></div>',
                        name: 'typeNo',
                        prop: {
                            name: 'typeName',
                            value: 'typeNo'
                        }
                    });

                    var customerSearchTimer = null;
                    $('#customerSelect').on('input propertychange', function () {
                        clearTimeout(customerSearchTimer);
                        customerSearchTimer = null;
                        var val = $(this).val();
                        customerSearchTimer = setTimeout(function () {
                            initCustomerTree(val)
                        }, 300)
                    });

                    initCustomerTree();

                    function initCustomerTree (typeName) {
                        var customerTreeData = []
                        $.get('/PlbCustomerType/treeList',{typeName:typeName},function (res) {
                            customerTreeData = res.data;
                            eleTree.render({
                                elem: '#customerTree',
                                data: customerTreeData,
                                highlightCurrent: true,
                                showLine: true,
                                defaultExpandAll: false,
                                accordion: true,
                                request: {
                                    name: 'typeName',
                                    children: "child"
                                }
                            });
                        });
                    }

                    // 树节点点击事件
                    eleTree.on("nodeClick(customerTree)", function (d) {
                        typeNos = d.data.currentData.typeNo
                        if(typeNos != '' || typeNos != undefined){
                            $.ajax({
                                url: '/plbUtil/autoNumber?typeNo='+typeNos+'&autoNumber=plbCustomer',
                                async:false,
                                dataType: 'json',
                                type: 'post',
                                success: function (res) {
                                    $('input[name="customerNo"]', $('#baseForm')).val(res);
                                }
                            });
                        }

                        var currentData = d.data.currentData;
                        var obj = {
                            typeName: currentData.typeName,
                            typeNo: currentData.typeNo
                        }
                        customerSelectTree.setValue([obj]);
                    });
                    /*获取客商来源数据----end*/
                    element.render();
                    form.render();

                    /*region 客商类型 */
                    var supplierTypeData = []

                    $.each(dictionaryObj['SUPPLIER_TYPE']['object'], function (k, v) {
                        var obj = {
                            value: k,
                            name: v
                        }
                        supplierTypeData.push(obj)
                    })

                    var supplierTypeSelect = xmSelect.render({
                        el: '#supplierTypeTree',
                        name: 'supplierType',
                        toolbar: {
                            show: true,
                        },
                        filterable: true,
                        data: supplierTypeData
                    });
                    /* endregion */

                    /* region 客户角色 */
                    var accountRoleData = []

                    $.each(dictionaryObj['ACCOUNT_ROLE']['object'], function (k, v) {
                        var obj = {
                            value: k,
                            name: v
                        }
                        accountRoleData.push(obj)
                    })

                    var accountRoleSelect = xmSelect.render({
                        el: '#accountRoleTree',
                        name: 'accountRole',
                        toolbar: {
                            show: true,
                        },
                        filterable: true,
                        data: accountRoleData,
                        on: function(data) {
                            var flag = false;
                            //arr:  当前多选已选中的数据
                            var arr = data.arr
                            for (var i = 0; i < arr.length; i++) {
                                if (arr[i].value == '03') {
                                    flag = true
                                    break;
                                }
                            }
                            if (flag) {
                                $('.not_necessary').removeClass('field_required');
                            } else {
                                $('.not_necessary').addClass('field_required');
                            }
                        }
                    });
                    /* endregion */

                    var plbCustomerBankList = []

                    laydate.render({
                        elem: '#dateEstablishment'
                    });

                    if (type == 1) {
                        // 获取自动编号
                        // getAutoNumber({autoNumber: 'plbCustomer'}, function(res) {
                        //     $('input[name="customerNo"]', $('#baseForm')).val(res);
                        // });
                        // $('.refresh_no_btn').show().on('click', function() {
                        //     getAutoNumber({autoNumber: 'plbCustomer'}, function(res) {
                        //         $('input[name="customerNo"]', $('#baseForm')).val(res);
                        //     });
                        // });
                        $.ajax({
                            url: '/plbUtil/autoNumber?typeNo='+typeNos+'&autoNumber=plbCustomer',
                            async:false,
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                $('input[name="customerNo"]', $('#baseForm')).val(res);
                            }
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            $.ajax({
                                url: '/plbUtil/autoNumber?typeNo='+typeNos+'&autoNumber=plbCustomer',
                                async:false,
                                dataType: 'json',
                                type: 'post',
                                success: function (res) {
                                    $('input[name="customerNo"]', $('#baseForm')).val(res);
                                }
                            });
                        });
                        $('input[name="merchantType"]', $('#baseForm')).val(currentNode.typeNo);

                        //客商来源默认左侧
                        var obj = {
                            typeName: currentNode.typeName,
                            typeNo: currentNode.typeNo
                        }
                        customerSelectTree.setValue([obj]);
                    } else if (type == 2) {
                        form.val("baseForm", data);

                        if(data.contractCustomers==1){
                            $('#contractCustomers').hide()
                        }else if(data.contractCustomers==0){
                            $('#contractCustomers').show()
                        }

                        if (data.accountRole && data.accountRole.indexOf('03') > -1) {
                            $('.not_necessary').removeClass('field_required');
                        }

                        if (data.supplierType) {
                            var supplierTypeArr = data.supplierType.split(',');
                            supplierTypeSelect.setValue(supplierTypeArr);
                        }

                        if (data.accountRole) {
                            var accountRoleArr = data.accountRole.split(',');
                            accountRoleSelect.setValue(accountRoleArr);
                        }

                        $('#fileContent').html(getFileEleStr(data.attachments, true));

                        plbCustomerBankList = data.plbCustomerBankList || []

                        //回显客商来源
                        var obj = {
                            typeName: data.merchantTypeName,
                            typeNo: data.merchantType
                        }
                        customerSelectTree.setValue([obj]);
                    }

                    // 初始化客商账号列表
                    table.render({
                        elem: '#customerBankTable',
                        data: plbCustomerBankList,
                        toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'accountType', title: '账户类型<span style="color: #f00;font-size: 16px;">*</span>', width: 200, templet: function (d) {
                                    return '<div id="XM-' + (d.bankId || d.index) + '" ></div><input type="hidden" name="bankId" value="' + isShowNull(d.bankId) + '">';
                                }
                            },
                            {
                                field: 'collectionAccountName', title: '收款账号名<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="collectionAccountName" class="layui-input" value="'+ isShowNull(d.collectionAccountName ||$('#customerName').val())+'" />';
                                }
                            },
                            {
                                field: 'bankOfDepositName', title: '开户行(请填写至分支行)<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 200, templet: function (d) {
                                    return '<input type="text" onclick="popup(this)" readonly="readonly"  id="select" name="bankOfDeposit" class="layui-input" value="' + isShowNull(d.bankOfDepositName) + '" />';
                                }
                            },
                            {
                                field: 'bankAccount', title: '银行账号<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="bankAccount"   class="layui-input" value="' + isShowNull(d.bankAccount) + '" />';
                                }
                            },
                            {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                        ]],
                        done: function(res) {
                            $('#customerBankTableBox .layui-table-cell').each(function (i, v) {
                                v.style.height = 'auto';
                            });

                            //渲染多选
                            res.data.forEach(function (item, index) {
                                var el = item.bankId || ('index_' + index)
                                var xm = xmSelect.render({
                                    el: '#XM-' + el,
                                    radio: true,
                                    clickClose: true,
                                    model: {type: 'fixed'},
                                    name: 'accountType',
                                    data: [
                                        {name: '基本户', value: 0, selected: item.accountType != 1},
                                        {name: '其他户', value: 1, selected: item.accountType == 1}
                                    ]
                                })

                                item.__xm = xm;
                            })
                        }
                    });

                    //表格滚动时 重新计算位置
                    document.querySelector('#newOrEditLayer').addEventListener('scroll', function () {
                        xmSelect.get().forEach(function (item) {
                            if (item.options.model.type === 'fixed') {
                                item.calcPosition();
                            }
                        })
                    })
                },
                yes: function (index) {
                    var loadIndex = layer.load();

                    var baseData = getSaveData(type, customerId).dataObj;
                    baseData.supplierGroup=$('input[name="supplierGroupName"]').attr('supplierGroup')

                    //客商来源
                    baseData.merchantType=customerSelectTree.getValue('valueStr');
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
                                questionTable.reload();
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        }
                    });
                },
                btn2: function (index) {
                    // 提交前先保存
                    var loadIndex = layer.load();

                    var baseData = getSaveData(type, customerId);
                    baseData.supplierGroup=$('input[name="supplierGroupName"]').attr('supplierGroup')
                    //客商来源
                    baseData.merchantType=customerSelectTree.getValue('valueStr');
                    if (!checkSubmit(baseData.dataObj)){
                        layer.close(loadIndex)
                        return false
                    }

                    $.ajax({
                        url: url,
                        data: JSON.stringify(baseData.dataObj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                baseData.baseObj.customerId = res.object;
                                if(type==1){
                                    baseData.baseObj.typeNo= currentNode.typeName;
                                }else if(type==2){
                                    baseData.baseObj.typeNo=data.merchantTypeName;
                                }

                                $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '32'}, function (res) {
                                    var flowDataArr = []
                                    $.each(res.data.flowData, function (k, v) {
                                        flowDataArr.push({
                                            flowId: k,
                                            flowName: v
                                        });
                                    });

                                    if (flowDataArr.length == 1) {
                                        var newApprovalData = filterSubmitData(baseData.baseObj);
                                        newWorkFlow(flowDataArr[0].flowId, JSON.stringify(newApprovalData), function (res) {
                                            // 报销单保存关联的runId
                                            var submitData = {
                                                customerId: newApprovalData.customerId,
                                                runId: res.flowRun.runId,
                                                auditerStatus: 1
                                            }
                                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowDataArr[0].flowId + '&type=new&flowStep=1&prcsId=1&&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                            $.ajax({
                                                url: '/PlbCustomer/insertOrUpdate',
                                                data: JSON.stringify(submitData),
                                                dataType: 'json',
                                                contentType: "application/json;charset=UTF-8",
                                                type: 'post',
                                                success: function (res) {
                                                    if (res.flag) {
                                                        layer.closeAll();
                                                        layer.msg('提交成功!', {icon: 1});
                                                        questionTable.reload()
                                                    } else {
                                                        layer.msg('提交失败!', {icon: 2});
                                                    }
                                                }
                                            });
                                        });
                                    } else {
                                        submitFlow(baseData.baseObj);
                                    }
                                })

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
            tableInit();
        });

        /**
         * 获取查询条件
         * @returns {{planNo: (*), planName: (*)}}
         */
        function getSearchObj() {
            var val = $("#auditerStatus").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
            if(val != undefined){
                var auditerStatus = val;
            }else{
                var auditerStatus = "";
            }
            var searchObj = {
                customerNo: $('input[name="customerNo"]', $('.query_module')).val(),
                customerName: $('input[name="customerName"]', $('.query_module')).val(),
                auditerStatus:auditerStatus
            }

            return searchObj
        }

        /**
         * 获取需要保存的数据
         * @param saveType (1-保存,2-提交)
         */
        function getSaveData(saveType, customerId) {
            var datas = $('#baseForm').serializeArray().concat($('#baseForms').serializeArray())
            var dataObj = {}
            datas.forEach(function (item) {
                dataObj[item.name] = item.value;
            });

            // 附件
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            dataObj.attachmentId = attachmentId;
            dataObj.attachmentName = attachmentName;

            var baseObj = JSON.parse(JSON.stringify(dataObj));

            //遍历表格获取每行数据进行保存
            var $trs = $('#customerBankTableBox').find('.layui-table-main tr');
            var plbCustomerBankList = [];
            var customerBankFlag = false;
            if ($trs.length > 0) {
                $trs.each(function (i, v) {
                    var bankId = $(v).find('[name="bankId"]').val();
                    var oldDataObj = {
                        accountType: $(v).find('[name="accountType"]').val(),
                        collectionAccountName: $(v).find('[name="collectionAccountName"]').val(),
                        bankOfDepositName:$(v).find('[name="bankOfDeposit"]').val(),
                        bankOfDeposit: $(v).find('[name="bankOfDeposit"]').attr('number'),
                        bankAccount: $(v).find('[name="bankAccount"]').val()
                    }
                    if (bankId) {
                        oldDataObj.bankId = bankId
                    }
                    plbCustomerBankList.push(oldDataObj);
                });
            }
            dataObj.plbCustomerBankList = plbCustomerBankList;

            // 编辑
            if (saveType == 2) {
                dataObj.customerId = customerId;
            }

            return {
                dataObj: dataObj,
                baseObj: baseObj
            }
        }

        /**
         * 提交审批
         * @param approvalData
         */
        function submitFlow(approvalData) {

            layer.open({
                type: 1,
                title: '选择流程',
                area: ['70%', '80%'],
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
                success: function () {
                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '32'}, function (res) {
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
                        var newApprovalData = filterSubmitData(approvalData);
                        newWorkFlow(flowData.flowId, JSON.stringify(newApprovalData), function (res) {
                            // 报销单保存关联的runId
                            var submitData = {
                                customerId: approvalData.customerId,
                                runId: res.flowRun.runId,
                                auditerStatus: 1
                            }
                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                            $.ajax({
                                url: '/PlbCustomer/insertOrUpdate',
                                data: JSON.stringify(submitData),
                                dataType: 'json',
                                contentType: "application/json;charset=UTF-8",
                                type: 'post',
                                success: function (res) {
                                    if (res.flag) {
                                        layer.closeAll();
                                        layer.msg('提交成功!', {icon: 1});
                                        questionTable.reload()
                                    } else {
                                        layer.msg('提交失败!', {icon: 2});
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
        }

        //查看变更数据
        function checkHistory(data) {
            var list = []
            var reviseTargetId = data.customerId
            $.get('/PlbCustomer/queryHistoryVersionByRunId', {
                reviseTargetId: reviseTargetId,
                reviseType: '04'
            }, function (res) {
                for (var i = 0; i < res.data.length; i++) {
                    var fileStr = getFileEleStr(res.data.attachments, false);

                    var content = [
                        '<div class="layui-collapse">\n',
                        '  <div class="layui-colla-item">\n' +
                        '    <h2 class="layui-colla-title">' + res.data[i].version + '</h2>\n' +
                        '    <div class="layui-colla-content layui-show plan_base_info">' +
                        '<form class="layui-form" lay-filter="formContentTest' + i + '" style="padding: 0px 10px">',
                        /* region 第一行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">客商编号<span field="customerNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" readonly name="customerNo" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">客商单位名称<span field="customerName" class="field_required">*</span></label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="customerName" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">客商单位简称<span field="customerShortName" class="field_required">*</span></label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="customerShortName" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">客商类型<span field="merchantType" class="field_required">*</span></label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="merchantTypeName" readonly autocomplete="off" class="layui-input"></input>' +
                        '       </div>' +
                        '   </div>' +
                        '</div>' +
                        '</div>',
                        /* endregion */
                        /*region 第二行 */
                        '<div class="layui-row">',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">客商来源</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <select name="customerSource"></select>' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">组织机构代码</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="customerOrgCode" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">单位性质</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <select name="customerNature"></select>' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">单位类别</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <select name="customerType"></select>' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /*region 第三行 */
                        '<div class="layui-row">',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">税务登记号</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="taxNumber" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">开户行名称</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="accountName" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">开户行账户</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="number" name="accountNumber" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">账号单位地址</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="accountAddress" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /*region 第四行 */
                        '<div class="layui-row">',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">账号单位电话</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="accountTelno" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px"> ' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">法人代表</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="legalPeron" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">注册资金（万元）</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="number" name="regCapital" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '  </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">单位营业地址</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="businessAddress" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /*region 第五行 */
                        '<div class="layui-row">',
                        '<div class="layui-col-xs3" style="padding: 0 5px"> ' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">联系人</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="contactPerson" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '  </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">联系电话</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="contactTelno" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '  </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">营业范围</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="businessScope" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '  </div>' +
                        '</div>',
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">备注</label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <input type="text" name="remarks" autocomplete="off" class="layui-input">' +
                        '       </div>' +
                        '   </div>' +
                        '</div>' +
                        '</div>',
                        /* endregion */
                        /*region 第六行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs3" style="padding: 0 5px">' +
                        '   <div class="layui-form-item">' +
                        '       <label class="layui-form-label form_label">资证材料<span field="attachmentId" class="field_required"></span></label>' +
                        '       <div class="layui-input-block form_block">' +
                        '           <div class="file_module">' +
                        '               <div id="fileContent" class="file_content">' + fileStr + '</div>' +
                        '           </div>' +
                        '       </div>' +
                        '   </div>' +
                        '</div>' +
                        '</div>',
                        /* endregion */
                        '</form>',
                        '    </div>\n' +
                        '  </div>\n',
                        '</div>'
                    ].join('');

                    list += content
                }
                layer.open({
                    type: 1,
                    title: "查看历史数据",
                    area: ['100%', '100%'],
                    btn: ['关闭'],
                    btnAlign: 'c',
                    content: list,
                    success: function () {
                        element.render();

                        $('[name="customerSource"]').html(dictionaryObj['CUSTOMER_SOURCE']['str']);
                        $('[name="customerNature"]').html(dictionaryObj['CUSTOMER_NATURE']['str']);
                        $('[name="customerType"]').html(dictionaryObj['CUSTOMER_TYPE']['str']);

                        for (var i = 0; i < res.data.length; i++) {
                            form.val("formContentTest" + i, res.data[i]);
                        }

                        form.render();
                    }
                });
            });
        }

        /**
         * 提交审批校验数据
         */
        function checkSubmit(data) {
            if (!data['customerNo']) {
                layer.msg('客商编号不能为空', {icon: 0});
                return false
            }
            if (!data['customerName']) {
                layer.msg('客商单位名称不能为空', {icon: 0});
                return false
            }
            if (!data['customerShortName']) {
                layer.msg('客商单位简称不能为空', {icon: 0});
                return false
            }
            if (!data['supplierType']) {
                layer.msg('客商类型不能为空', {icon: 0});
                return false
            }
            if (!data['accountRole']) {
                layer.msg('客户角色不能为空', {icon: 0});
                return false
            }
            if (!data['customerOrgCode']) {
                layer.msg('统一社会信用代码不能为空', {icon: 0});
                return false
            }
            // 如果客户角色不包含个人
            if (data['accountRole'].indexOf('03') == -1) {
                if(data.contractCustomers==0){
                    if (!data['customerType']) {
                        layer.msg('单位类型不能为空', {icon: 0});
                        return false
                    }
                    if (!data['legalPeron']) {
                        layer.msg('法定代表人不能为空', {icon: 0});
                        return false
                    }
                    if (!data['regCapital']) {
                        layer.msg('注册资本不能为空', {icon: 0});
                        return false
                    }
                    if (!data['accountAddress']) {
                        layer.msg('注册地址不能为空', {icon: 0});
                        return false
                    }
                    if (!data['dateEstablishment']) {
                        layer.msg('成立日期不能为空', {icon: 0});
                        return false
                    }
                    if (!data['termOfOperation']) {
                        layer.msg('营业期限不能为空', {icon: 0});
                        return false
                    }
                    if (!data['managementForms']) {
                        layer.msg('企业经营状态不能为空', {icon: 0});
                        return false
                    }
                    if (!data['accountTelno']) {
                        layer.msg('单位电话不能为空', {icon: 0});
                        return false
                    }
                    if (!data['businessAddress']) {
                        layer.msg('单位营业地址不能为空', {icon: 0});
                        return false
                    }
                    if (!data['businessScope']) {
                        layer.msg('经营范围不能为空', {icon: 0});
                        return false
                    }

                    if (!data['attachmentId']) {
                        layer.msg('资证材料不能为空', {icon: 0});
                        return false
                    }
                }


            }
            if(data.contractCustomers==0){
                if (!data['contactPerson']) {
                    layer.msg('联系人不能为空', {icon: 0});
                    return false
                }
                if (!data['contactTelno']) {
                    layer.msg('联系电话不能为空', {icon: 0});
                    return false
                }
            }



            if (!data['plbCustomerBankList'] || data['plbCustomerBankList'].length == 0) {
                layer.msg('请添加至少一条账号信息！', {icon: 0})
                return false
            } else {
                var list = data['plbCustomerBankList']
                for (var i = 0; i < list.length; i++) {
                    if (!list[i]['accountType'] && list[i]['accountType'] != '0') {
                        layer.msg('账号信息列表第' + (i + 1) + '行，账户类型不能为空', {icon: 0})
                        return false
                    }
                    if (!list[i]['collectionAccountName']) {
                        layer.msg('账号信息列表第' + (i + 1) + '行，收款帐户号不能为空', {icon: 0});
                        return false
                    }
                    if (!list[i]['bankOfDepositName']) {
                        layer.msg('账号信息列表第' + (i + 1) + '行，开户行不能为空', {icon: 0});
                        return false
                    }

                    if (!list[i]['bankAccount']) {
                        layer.msg('账号信息列表第' + (i + 1) + '行，银行账号不能为空', {icon: 0});
                        return false
                    }
                }
            }
            return true
        }

        /**
         * 处理提交审批关联表单数据
         */
        function filterSubmitData(data) {
            var newData = JSON.parse(JSON.stringify(data))
            // 客商类型 数据字典
            if (newData['supplierType']) {
                var arr = newData['supplierType'].split(',')
                var newArr = []
                arr.forEach(function(item) {
                    newArr.push(dictionaryObj['SUPPLIER_TYPE']['object'][item])
                })
                newData['supplierType'] = newArr.join(',')
            }
            // 客户角色 数据字典
            if (newData['accountRole']) {
                var arr = newData['accountRole'].split(',')
                var newArr = []
                arr.forEach(function(item) {
                    newArr.push(dictionaryObj['ACCOUNT_ROLE']['object'][item])
                })
                newData['accountRole'] = newArr.join(',')
            }
            // 客商来源 数据字典
            if (newData['customerSource']) {
                newData['customerSource'] = dictionaryObj['CUSTOMER_SOURCE']['object'][newData['customerSource']] || ''
            }
            // 单位性质 数据字典
            if (newData['customerNature']) {
                newData['customerNature'] = dictionaryObj['CUSTOMER_NATURE']['object'][newData['customerNature']] || ''
            }
            // 单位类型 数据字典
            if (newData['customerType']) {
                newData['customerType'] = dictionaryObj['CUSTOMER_TYPE']['object'][newData['customerType']] || ''
            }
            // 等级状态 数据字典
            if (newData['gradeStatus']) {
                newData['gradeStatus'] = dictionaryObj['GRADE_STATUS']['object'][newData['gradeStatus']] || ''
            }
            return newData
        }

        /*region 导出 */
        $(document).on('click', function () {
            $('.export_moudle').hide();
        });
        $(document).on('click', '.export_btn', function () {
            var type = $(this).attr('type');
            var fileName = '客商列表.xlsx';
            if (type == 1) {
                var checkStatus = layTable.checkStatus('questionTable');
                if (checkStatus.data.length == 0) {
                    layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                    return false;
                }
                soulTable.export(questionTable, {
                    filename: fileName,
                    checked: true
                });
            } else if (type == 2) {
                soulTable.export(questionTable, {
                    filename: fileName,
                    curPage: true
                });
            } else if (type == 3) {
                var load = layer.load(2);
                $.get('/PlbCustomer/getDataByCondition',function () {
                    soulTable.export(questionTable, {
                        filename: fileName
                    });
                    layer.close(load)
                })

            }
        });
        /* endregion */
        $(document).on('click', '#supplierGroup', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择分包商',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
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
                    '<div class="mtl_table_box" style="display: none;">' +
                    //查询
                    '       <div class="layui-row inSearchContent">' +
                    '             <div class="layui-col-xs4">\n' +
                    '                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                    '             </div>\n' +
                    '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                    '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                    '             </div>\n' +
                    '       </div>' +
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img">' +
                    '<img style="margin-top: 12%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.typeId) {
                            $('.mtl_no_data').hide();
                            $('.mtl_table_box').show();
                            loadMtlTable(currentData.typeNo);
                        } else {
                            $('.mtl_table_box').hide();
                            $('.mtl_no_data').show();
                        }
                    });

                    loadMtlType();
                    // loadMtlTable()
                    function loadMtlType(typeId) {
                        // 获取左侧树
                        $.get('/PlbCustomerType/treeList', function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: true,
                                    request: {
                                        name: "typeName", // 显示的内容
                                        key: "typeId", // 节点id
                                        parentId: 'parentTypeId', // 节点父id
                                        isLeaf: "isLeaf",// 是否有子节点
                                        children: 'child',
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(typeId) {
                        var loading = layer.load(1)
                        if(xhr){
                            xhr.abort()
                        }
                        typeId = typeId ? typeId : '';
                        xhr = $.ajax({
                            url: '/PlbCustomer/getDataByCondition',
                            data:{
                                merchantType: typeId,
                                useFlag: true
                            },
                            success:function(res){
                                layer.close(loading)
                                materialsTable = table.render({
                                    elem: '#materialsTable',
                                    data:res.data,
                                    page: true, //开启分页
                                    limit: 50,
                                    cellMinWidth: 180,
                                    height: 'full-300'
                                    , toolbar: '#toolbar'
                                    , defaultToolbar: ['']
                                    ,
                                    cols: [[ //表头
                                        {type: 'radio', width: 50}
                                        , {field: 'customerNo', title: '客商编号', width: 200}
                                        , {field: 'customerName', title: '客商单位名称', width: 200}
                                        , {field: 'customerShortName', title: '客商单位简称', width: 200}
                                        , {field: 'customerOrgCode', title: '组织机构代码'}
                                        , {field: 'taxNumber', title: '税务登记号'}
                                        , {field: 'accountNumber', title: '开户行账户'}
                                    ]], parseData: function (res) {
                                        return {
                                            "code": 0, //解析接口状态
                                            "data": res.data,//解析数据列表
                                            "count": res.totleNum, //解析数据长度
                                        };
                                    },
                                    request: {
                                        pageName: 'page' //页码的参数名称，默认：page
                                        , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                    },
                                });
                            }
                        })
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        if(mtlData.auditerStatus!='2'){
                            layer.msg('该客商未批准，请进行审批',{icon:0})
                            return
                        }
                        _this.val(mtlData.customerName);
                        _this.attr('supplierGroup', mtlData.customerId);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
    });

    /**
     * 利用引用类型特性过滤树结构指定id节点及其子节点
     * @param data (树形数据)
     * @param filterId (过滤的ID)
     * @param idName
     * @returns {[]}
     */
    function filterTreeData(data, filterId, idName) {
        if (!!data && data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                if (filterId == data[i][idName]) {
                    data.splice(i, 1);
                    break;
                } else {
                    if (data[i].child && data[i].child.length > 0) {
                        filterTreeData(data[i].child, filterId, idName);
                    }
                }
            }
        }
    }

    $(document).on('click', '.preview_flow', function () {
        var formUrl = $(this).attr('formUrl')
        if (formUrl) {
            if (formUrl.split('')[0] == '/') {
                window.open(formUrl)
            } else {
                window.open('/' + formUrl)
            }
        }
    });

    /**
     * 新建流程方法
     * @param flowId
     * @param urlParameter
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
                isBudgetFlow: true,
                approvalData: approvalData,
                isTabApproval: true,
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
    var name;
    var number;
    window.ppp = function(bankName, bankNumber){
        // if(pankName!=''){
        //     alert(pankName)
        // }
        name = bankName;
        number = bankNumber;

    }
    // function adjustIframe(){
    //     var ifm = document.getElementById("iframe")
    //     ifm.height = document.documentElement.clientHeight
    //     ifm.width = document.documentElement.clientWidth
    // }
    function popup (_this){
        layer.open({
            type: 2,
            title:'选择开户行',
            area: ['85%', '82%'],
            btn: ['确定', '返回'],
            // content: '<iframe id="iframe"  src="/plbBank/getBankDropDown" style="margin-left: -2px;width: 100%;height: 100%"></iframe>'
            content:'/plbBank/getBankDropDown'
            ,success: function(layero,index){
                layer.iframeAuto(index)
            }
            ,yes:function(index){
                $(_this).val(name);
                $(_this).attr('number', number);
                layer.close(index);
                // alert( $('.layui-form-radioed').parents('tr').children('td[data-field="name"]').children('div').html())
                // console.log($('iframe')>$('.layui-table-click')>$('.layui-table-cell laytable-cell-1-0-1').val())
            }
        })
    }


</script>
</body>
</html>
