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
    <title>部门预算执行</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
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
    <script src="../js/jquery/jquery.cookie.js"></script>

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
            position: relative;
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

        .td_title {
            width: 200px;
            background: #F2F2F2;
        }
        .exports{
            position: relative;
            z-index: 1000;
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

        /*.export_moudle > p:hover {*/
        /*cursor: pointer;*/
        /*color: #1E9FFF;*/
        /*}*/
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">预算执行查看</h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off"
                       class="layui-input"/>
            </div>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title">
                    <li colsType="0" class="layui-this">单据执行列表</li>
                    <li  colsType="1">年度执行列表</li>
                    <li colsType="2">科目执行列表</li>

                </ul>
                <div class="layui-tab-content">
                    <div class="query_module layui-form layui-row" style="position: relative">
                        <div id="threeQuery" style="display: none">
                            <div class="layui-col-xs2">
                                <input type="text" name="reimburseNo"  placeholder="单据编号/流水号"
                                       autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-col-xs2" style="margin-left: 15px;">
                                <input type="text" name="reimburseTotal"
                                       placeholder="报销金额" autocomplete="off"
                                       class="layui-input ">
                            </div>
                            <div class="layui-col-xs2" style="margin-left: 15px">
                                <input type="text" name="createUser" id="user" readonly style="background: #e7e7e7" placeholder="经办人" autocomplete="off"
                                       class="layui-input  userAdd">
                            </div>
                            <div class="layui-col-xs2" style="margin-left: 15px">
                                <input type="=text" name="reimburseUser" id="reimburseUser" readonly style="background: #e7e7e7" placeholder="报销人" class="layui-input userAdd" autocomplete="off">
                            </div>
                        </div>
                        <div id="oneQuery">
                            <div class="layui-col-xs2">
                                <input type="text" name="tgName" placeholder="关键任务名称" autocomplete="off"
                                       class="layui-input">
                            </div>
                            <div class="layui-col-xs2" style="margin-left: 15px;">
                                <input type="text" name="oneDptName" id="oneDpt" readonly style="background: #e7e7e7"
                                       placeholder="费用承担部门" autocomplete="off" class="layui-input  deptAdd">
                            </div>
                        </div>
                        <div id="twoQuery" style="display: none">
                            <div class="layui-col-xs2">
                                <input type="text" name="itemName" placeholder="预算科目名称" autocomplete="off"
                                       class="layui-input">
                            </div>
                            <div class="layui-col-xs2" style="margin-left: 15px;">
                                <input type="text" name="twoDeptName" id="twoDept" readonly style="background: #e7e7e7"
                                       placeholder="费用承担部门" autocomplete="off" class="layui-input deptAdd">
                            </div>
                        </div>

                        <%--<div id="threeQuery" style="display: none">
                            <div class="layui-col-xs2">
                                <input type="text" name="createTime" id="createTime" placeholder="提请报销时间"
                                       autocomplete="off" class="layui-input">
                            </div>
                            <div class="layui-col-xs2" style="margin-left: 15px;">
                                <input type="text" name="reimburseBelongDeptName" id="reimburseBelongDept" readonly
                                       style="background: #e7e7e7" placeholder="费用承担部门" autocomplete="off"
                                       class="layui-input deptAdd">
                            </div>
                        </div>--%>
                        <div  style="margin-top: 3px;text-align:right;margin-right:100px;" >
                            <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
                            <button type="button" class="layui-btn layui-btn-sm">高级查询</button>
                            <button class="layui-btn layui-btn-sm chongzhi"  type="reset">重置</button>
                            <button class="layui-btn layui-btn-sm exports"  style="margin-left:10px;">
                                <div class="export">导出</div>
                                <div class="export_moudle">
                                    <p class="export_btn" type="1">导出所选数据</p>
                                    <p class="export_btn" type="2">导出当前页数据</p>
                                    <p class="export_btn" type="3">导出全部数据</p>
                                </div>
                            </button>


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
                        <div class="no_data" style="text-align: center;display: none">
                            <div class="no_data_img" style="margin-top:12%;">
                                <img style="margin-top: 2%;" src="/img/noData.png">
                            </div>
                            <p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧部门</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>


    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name = $(this).attr('name')
        $('.query_module [name=' + name + ']').val($.cookie(name) || '')
    })
    $('#oneDpt').attr('deptId', $.cookie('oneDpt') || '')
    $('#twoDept').attr('deptId', $.cookie('twoDept') || '')
    $('#reimburseBelongDept').attr('deptId', $.cookie('reimburseBelongDept') || '')

    var tipIndex = null
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text');
        tipIndex = layer.tips(tip, this);
    }, function () {
        layer.close(tipIndex);
    });

    //选部门控件添加
    $(document).on('click', '.deptAdd', function () {
        dept_id =  $(this).attr('id')
        $.popWindow("../../common/selectDept?0");

    });
    //选人
    $(document).on('click', '.userAdd', function () {
        user_id = $(this).attr('id')
        $.popWindow("../../common/selectUser?0");

    });
    //        点击重置
    $('.chongzhi').click(function(){
        $('input[name="createUser"]').val('');
        $('input[name="createUser"]').attr("user_id", "");
        $('input[name="reimburseUser"]').val('');
        $('input[name="reimburseUser"]').attr("user_id", "");

        $('input[name="reimburseNo"]').val('');
        $('input[name="reimburseTotal"]').val('');
        $('input[name="tgName"]').val('');
        $('input[name="oneDptName"]').val('');
        $('input[name="itemName"]').val('');
        $('input[name="twoDeptName"]').val('');
        $('input[name="twoDeptName"]').attr("deptId", "");

        $('input[name="oneDptName"]').attr("deptId", "");
    })


    // 关键任务执行列表-表格显示顺序
    var colShowObj = {
        tgNo: {field: 'tgNo', title: '关键任务编号', sort: true, hide: false},
        tgName: {field: 'tgName', title: '关键任务名称', sort: true, hide: false},
        budgetMoney: {field: 'budgetMoney', title: '预算总额', sort: true, hide: false},
        settleupMoney: {
            field: 'settleupMoney', title: '已支付金额', sort: true, hide: false, templet: function (d) {
                return d.settleupMoney || 0
            }
        },

        approvedPaid: {field: 'approvedPaid', title: '已审批金额', sort: true, hide: false},
        approving: {field: 'approving', title: '审批中额度', sort: true, hide: false},
        payedMoney: {field: 'payedMoney', title: '可用额度', sort: true, hide: false},
        deptName: {field: 'deptName', title: '费用承担部门', sort: true, hide: false},

    }
    // 预算科目执行列表-表格显示顺序
    var colShowObj1 = {
        rbsItemName: {field: 'rbsItemName', title: '预算科目名称', sort: true, hide: false},
        cbsName: {field: 'cbsName', title: '会计科目名称', sort: true, hide: false},
        deptName: {field: 'deptName', title: '所属部门', sort: true, hide: false},
        deptId: {field: 'deptId', title: '费用承担部门', sort: true, hide: false,templet: function (d) {
                return (d.deptName || '').replace(/,/, '');
            }},
        budgetMoney: {field: 'budgetMoney', title: '预算总额', sort: true, hide: false},
        controlType: {
            field: 'controlType', title: '控制方式', sort: true, hide: false, templet: function (d) {
                return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
            }
        },
        settleupMoney: {
            field: 'settleupMoney', title: '已支付金额', sort: true, hide: false, templet: function (d) {
                return d.settleupMoney || 0
            }
        },

        approving: {field: 'approving', title: '审批中额度', sort: true, hide: false},
        approvedPaid: {field: 'approvedPaid', title: '已批额度', sort: true, hide: false},
        payedMoney: {field: 'payedMoney', title: '可用额度', sort: true, hide: false},
    }
    // 预算执行列表-表格显示顺序
    var colShowObj2 = {
        reimburseNo: {field: 'reimburseNo', title: '单据编号', align: 'center', width: 180, sort: true, hide: false},
        reimburseDate: {
            field: 'reimburseDate', title: '报销日期', width: 110, sort: true, hide: false, templet: function (d) {
                return format(d.reimburseDate);
            }
        },
        reimburseUser: {
            field: 'reimburseUser', title: '报销人', width: 100, sort: true, hide: false, templet: function (d) {
                return (d.reimburseUserName || '').replace(/,$/, '');
            }
        },
        createUser: {
            field: 'createUser', title: '经办人', width: 100, sort: true, hide: false, templet: function (d) {
                return (d.createUserName || '').replace(/,/, '');
            }
        },
        reimburseBelongDept: {
            field: 'reimburseBelongDept', title: '所属部门', width: 150, sort: true, hide: false, templet: function (d) {
                return (d.reimburseBelongDeptName || '').replace(/,$/, '');
            }
        },
        reimburseDesc: {
            field: 'reimburseDesc', title: '报销事由', sort: true, hide: false, templet: function (d) {
                return (d.reimburseDesc || '');
            }
        },
        reimburseTotal: {
            field: 'reimburseTotal', title: '报销金额(元)', width: 125, sort: true, hide: false, templet: function (d) {
                return (d.reimburseTotal || '');
            }
        },
        runId: {
            field: 'runId', title: '流水号', width: 88, sort: true, align: 'center', hide: false, templet: function (d) {
                return (d.runId || '');
            }
        },
        reimburseStatus: {
            field: 'reimburseStatus',
            title: '报销状态',
            align: 'center',
            width: 110,
            sort: true,
            hide: false,
            templet: function (d) {
                var str = '';
                switch (d.reimburseStatus) {
                    case '0':
                        str = '未提交';
                        break;
                    case '1':
                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                        str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: orange;cursor: pointer;text-decoration:underline;" ' + flowStr + '>报销中</span>';
                        break;
                    case '2':
                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                        str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;text-decoration:underline;" ' + flowStr + '>已批准</span>';
                        break;
                    case '3':
                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                        str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;text-decoration:underline;" ' + flowStr + '>已退回</span>';
                        break;
                    case '4':
                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                        str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;text-decoration:underline;" ' + flowStr + '>影像驳回</span>';
                        break;
                    case '5':
                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                        str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;text-decoration:underline;" ' + flowStr + '>单据驳回</span>';
                        break;
                    case '6':
                        var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                        str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>已支付</span>';
                        break;
                }
                return str;
            }
        }
    }
    var TableUIObj = new TableUI('plb_dept_budget');

    $(document).on('click', '.preview_flow', function() {
        var flowId = $(this).attr('flowId'),
            runId = $(this).attr('runId'),
            formUrl = $(this).attr('formUrl');
        if (formUrl) {
            $.popWindow(formUrl);
        }
    });
    var dictionaryObj = {
        CONTROL_TYPE: {},
        BUDGET_YEAR: {},
        REIMBURSEMENT_TYPE: {},
    }
    var dictionaryStr = 'CONTROL_TYPE,BUDGET_YEAR,REIMBURSEMENT_TYPE';
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

    layui.use(['form', 'table', 'soulTable', 'eleTree', 'element', 'laydate'], function () {
        var layForm = layui.form,
            layTable = layui.table,
            eleTree = layui.eleTree,
            soulTable = layui.soulTable,
            element = layui.element,
            laydate = layui.laydate;
        layForm.render();

        /* laydate.render({
             elem: '#createTime',
             trigger: 'click' //采用click弹出
         });*/

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
            //清除userId一开始的存储值
            $('input[name="createUser"]').val('');
            $('input[name="reimburseUser"]').val('')
            $('input[name="oneDptName"]').val('');
            $('input[name="twoDeptName"]').val('')
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
                    $('.eleTree-node-content-label').each(function(){
                        var titleSpan=$(this).text();
                        $(this).attr('title',titleSpan);
                    })
                    /* TableUIObj.init(colShowObj2, function () {
                         tableInit(0, '')
                     });*/
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
                tableInit($('.layui-tab .layui-this').attr('colsType'), currentData.deptId);
            } else {
                $('.table_box').hide();
                $('.no_data').show();
            }
            $('.eleTree-node-content-label').each(function(){
                var titleSpan=$(this).text();
                $(this).attr('title',titleSpan);
            })
        });

        layTable.on('tool(tableObj)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'detail') {
                if ($('.layui-tab .layui-this').attr('colsType') == '1') {
                    $.get('/plbDeptBudget/queryId', {deptBudgetId: data.deptBudgetId}, function (res) {
                        addOrEdit(4, res.object)
                    })
                } else if ($('.layui-tab .layui-this').attr('colsType') == '2') {
                    layer.open({
                        type: 1,
                        title: '查看详情',
                        area: ['70%', '60%'],
                        content: ['<div style="margin: 10px"><table class="layui-table" style="margin: 10px 5px;width: 99%">\n' +
                        '  <colgroup>\n' +
                        '    <col width="150">\n' +
                        '    <col >\n' +
                        '    <col width="150">\n' +
                        '    <col >\n' +
                        '  </colgroup>' +
                        '  <tbody>\n' +
                        '<tr><td class="td_title">预算科目名称</td><td>' + isShowNull(data.rbsItemName) + '</td><td class="td_title">会计科目名称</td><td>' + isShowNull(data.cbsName) + '</td></tr>\n' +
                        '<tr><td class="td_title">预算金额</td><td>' + (data.budgetMoney || 0) + '</td><td class="td_title">控制方式</td><td>' + (dictionaryObj['CONTROL_TYPE']['object'][data.controlType] || '') + '</td></tr>\n' +
                        '<tr><td class="td_title">已支付金额</td><td>' + (data.settleupMoney || 0) + '</td><td class="td_title">已审批金额</td><td>' + (data.approvedPaid || 0) + '</td></tr>\n' +
                        '<tr><td class="td_title">剩余预算额度</td><td colspan="3">' + (data.payedMoney || 0) + '</td></tr>\n' +
                        '  </tbody>\n' +
                        '</table></div>'].join(''),
                    })
                } else if ($('.layui-tab .layui-this').attr('colsType') == '0') {
                    newOrEdit(3, data);
                }
            }
        });

        // 监听排序事件
        layTable.on('sort(tableObj)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableInit($('.layui-tab .layui-this').attr('colsType'), $('#leftId').attr('deptId'));
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

        /*region 导出 */

        $(document).on('click','.export',function () {
            if( $('.export_moudle').is(':visible')){
                $('.export_moudle').hide();
            }else {
                $('.export_moudle').show();
            }
        });
        $(document).on('click','.export_btn',function () {
            $('.export_moudle').hide();
        });
        $(document).on('click', '.export_btn', function () {

            var colsType=$('.layui-tab .layui-this').attr('colsType')
            var type = $(this).attr('type');
            if (type == 1) {
                var checkStatus = layTable.checkStatus('tableObj');
                if (checkStatus.data.length == 0) {
                    layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                    return false;
                }else if(colsType==0){
                    soulTable.export(tableObj, {
                        filename: '单据执行列表.xlsx',
                        checked: true
                    });
                }else if(colsType==1){
                    soulTable.export(tableObj, {
                        filename: '年度执行列表.xlsx',
                        checked: true
                    });
                }else if(colsType==2){
                    soulTable.export(tableObj, {
                        filename: '科目执行列表.xlsx',
                        checked: true
                    });
                }

            } else if (type == 2) {
                if(colsType==0){
                    soulTable.export(tableObj, {
                        filename: '单据执行列表.xlsx',
                        curPage: true
                    });
                }else if(colsType==1){
                    soulTable.export(tableObj, {
                        filename: '年度执行列表.xlsx',
                        curPage: true
                    });
                }else if(colsType==2){
                    soulTable.export(tableObj, {
                        filename: '科目执行列表.xlsx',
                        curPage: true
                    });
                }
            } else if (type == 3) {
                var load=layer.load(2)
                $.get('/plbDeptBudget/deptPlc',function () {
                    if(colsType==0){
                        soulTable.export(tableObj, {
                            filename: '单据执行列表.xlsx'
                        });
                    }else if(colsType==1){
                        soulTable.export(tableObj, {
                            filename: '年度执行列表.xlsx'
                        });
                    }else if(colsType==2){
                        soulTable.export(tableObj, {
                            filename: '科目执行列表.xlsx'
                        });
                    }
                    layer.close(load)
                })

            }

        });
        /* endregion */
        /**
         * 加载表格方法
         */
        function tableInit(colsType, deptId) {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)

            cols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#detailBarDemo',
                title: '操作',
                width: 100
            })

            var option = {
                elem: '#tableObj',
                toolbar: '#toolbarHead',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-165',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
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
                    dataName: 'obj'
                },
                done: function () {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableObj');
                    });

                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit});
                    }
                    layer.close()
                }
            }

            if (colsType == 1) {
                option.url = '/plbDeptBudget/deptPlc'
//                option.where.deptId = $('#oneDpt').attr('deptId') || deptId
                option.where.deptId = $('[name="oneDptName"]').attr('deptId').replace(/,/, '')
                option.where.tgName=$('[name="tgName"]').val()
            } else if (colsType == 2) {
                option.url = '/plbDeptBudget/deptBudgetItem'
//                option.where.deptId = $('#twoDept').attr('deptId') || deptId
                option.where.deptId = $('[name="twoDeptName"]').attr('deptId').replace(/,/, '')
                option.where.rbsItemName=$('[name="itemName"]').val()
            } else if (colsType == 0) {
                option.url = '/plbDeptBudget/deptReimburse'
                option.where.reimburseNo = $('[name="reimburseNo"]').val()
                option.where.reimburseTotal = $('[name="reimburseTotal"]').val()
                option.where.createUser = $('[name="createUser"]').val()
                option.where.reimburseUser=$('[name="reimburseUser"]').val()
                option.where.reimburseBelongDept = deptId
                // option.where.reimburseBelongDept=$('#reimburseBelongDept').attr('deptId') || deptId
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
         * 新增/编辑方法
         * @param type (1-新增，2-编辑,3-修编,4查看)
         * @param data (编辑时的预算信息)
         */
        function addOrEdit(type, data) {
            var title = '';
            var url = '';
            var deptId = $('#leftId').attr('deptId');
            if (type == 1) {
                title = '新增预算'
                url = '/plbDeptBudget/insert'
            } else if (type == 2) {
                title = '编辑预算'
                url = '/plbDeptBudget/update'
            }
            else if (type == 3) {
                title = '编辑预算'
                url = '/plbDeptBudget/updateRevision'
            }else if (type == 4) {
                title = '查看详情'
            }

            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: ['保存', '取消'],
                btnAlign: 'c',
                content: ['<div class="layer_wrap"><div class="layui-collapse">',
                    /* region 预算 */
                    '<div class="layui-colla-item"><h2 class="layui-colla-title">预算</h2>' +
                    '<div class="layui-colla-content layui-show layui-form order_base_info" lay-filter="formTest">',
                    /* region 第一行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">部门预算编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="tgNo" autocomplete="off" readonly style="background: #e7e7e7" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">部门预算名称<span class="field_required">*</span></label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="tgName" autocomplete="off"  class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /* region 第二行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">预算金额</label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="budgetMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">预算年度</label>' +
                    '<div class="layui-input-block form_block">' +
                    '<select id="budgetYear" name="budgetYear"></select>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    '</div>' +
                    '</div>',
                    /* endregion */
                    /* region 预算明细 */
                    '<div class="layui-colla-item"><h2 class="layui-colla-title">预算明细</h2>' +
                    '<div class="layui-colla-content layui-show mtl_info">' +
                    '<div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>' +
                    '</div>' +
                    '</div>',
                    /* endregion */
                    '</div></div>'].join(''),
                success: function () {
                    //预算年度
                    $('#budgetYear').html(dictionaryObj['BUDGET_YEAR']['str'])
                    layForm.render()

                    var materialDetailsTableData = [];

                    // 编辑时显示数据
                    if (type == 2 ||type == 3 ||type==4) {
                        layForm.val("formTest", data);
                        materialDetailsTableData = data.plbDeptBudgetListWithBLOBs || [];

                        if(type==4){
                            $('.layui-layer-btn-c').hide()
                            $('.order_base_info [name="tgName"]').attr('disabled','true')
                            $('.order_base_info [name="budgetYear"]').attr('disabled','true')
                            layForm.render()
                        }
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbDeptBudget'}, function(res) {
                            $('input[name="tgNo"]', $('.order_base_info')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbDeptBudget'}, function(res) {
                                $('input[name="tgNo"]', $('.order_base_info')).val(res);
                            });
                        });
                    }


                    renderDetailTable();

                    element.render();

                    // 初始化预算明细列表
                    function renderDetailTable() {
                        var cols=[
                            {type: 'numbers', title: '序号',},
                            {
                                field: 'rbsItemId',
                                title: '预算科目名称',
                                minWidth: 120,
                                templet: function (d) {
                                    return '<input type="text" name="rbsItemId"  rbsItemId="'+(d.rbsItemId || '')+'"  value="'+(d.rbsItemName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%;" >'
                                }
                            },
                            {
                                field: 'cbsId',
                                title: '会计科目名称',
                                minWidth: 120,
                                templet: function (d) {
                                    return '<input type="text" name="cbsId" cbsId="'+(d.cbsId || '')+'"   value="'+(d.cbsName || '')+'"  readonly autocomplete="off" class="layui-input '+(type == '4' ? '' :'cbsIdChoose')+'" style="height: 100%; cursor: pointer;" >'
                                }
                            },
                            {
                                field: 'budgetMoney', title: '预算金额', minWidth: 120, templet: function (d) {
                                    return '<input type="number" name="budgetMoney" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input budgetMoneyItem" style="height: 100%" value="' + (d.budgetMoney || '') + '">'
                                }
                            },
                            // {
                            //     field: 'rbsUnit', title: '单位', minWidth: 80, templet: function (d) {
                            //         return '<span rbsUnit="'+(d.rbsUnit || '')+'">'+(dictionaryObj['RBS_UNIT']['object'][d.rbsUnit] || '')+'</span>'
                            //     }
                            // },
                            {
                                field: 'controlType',
                                title: '控制方式',
                                minWidth: 120,
                                event: type==4 ? '' : 'chooseControlType',
                                templet: function (d) {
                                    return '<input type="text" name="controlType" controlType="'+(d.controlType || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" value="'+(dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '')+'" >'
                                }
                            },
                            {
                                field: 'createStandard', title: '编制标准', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="createStandard" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createStandard || '') + '">'
                                }
                            },
                            {
                                field: 'createRemark', title: '编制说明', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="createRemark" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createRemark || '') + '">'
                                }
                            },
                            {
                                field: 'remark', title: '备注', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="remark" '+(type==4 ? 'readonly' : '')+' deptBudgetListId="'+(d.deptBudgetListId || '')+'" autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.remark || '') + '">'
                                }
                            },
                        ]
                        if(type!=4){
                            cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                        }
                        layTable.render({
                            elem: '#detailTable',
                            data: materialDetailsTableData,
                            toolbar: '#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols],
                            done:function () {
                                if(type==4){
                                    $('.addRow').hide()
                                }
                            }
                        });
                    }
                },
                yes: function (index) {
                    var loadIndex = layer.load();
                    // 材料订单数据
                    var obj = {
                        tgNo: $('.order_base_info input[name="tgNo"]').val(),
                        tgName: $('.order_base_info input[name="tgName"]').val(),
                        budgetMoney: $('.order_base_info input[name="budgetMoney"]').val(),
                        budgetYear: $('#budgetYear').val(),
                    }

                    // 材料明细数据
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        var materialDetailsObj = {
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            budgetMoney: $(this).find('input[name="budgetMoney"]').val(), // 预算金额
                            controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                            createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                            createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                            remark: $(this).find('input[name="remark"]').val(), // 备注
                            deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                        }
                        if ($(this).find('.remark').attr('deptBudgetListId')) {
                            materialDetailsObj.deptBudgetListId = $(this).find('.remark').attr('deptBudgetListId');
                        }
                        materialDetailsArr.push(materialDetailsObj);
                    });
                    obj.plbDeptBudgetListWithBLOBs = materialDetailsArr;



                    if (type == 2  || type == 3) {
                        obj.deptBudgetId = data.deptBudgetId
                    }else if(type == 1){
                        obj.deptId = parseInt(deptId);
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
                },
            });
        }

        function newOrEdit(type, data) {
            var title = '';
            var reimburseType = data.reimburseType

            var url = '/plbDeptBudget/editClaimForm?type=' + type + '&reimburseType=' + reimburseType;
            if (type == 1) {
                title = '新增' + dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType];
            } else if (type == 2) {
                title = '编辑' + dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType] + '-' + data.reimburseNo;
                url += '&reimburseId=' + data.reimburseId;
            } else if (type == 3) {
                title = dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType] + '-' + data.reimburseNo;
                url += '&reimburseId=' + data.reimburseId + '&disabled=1';
            }
            iframeLayerIndex = layer.open({
                type: 2,
                title: title,
                area: ['100%', '100%'],
                content: url,
            });
        }

        var deptId = $('#leftId').attr('deptId') || ''
        $('#oneQuery').hide()
        $('#twoQuery').hide()
        $('#threeQuery').show()
        TableUIObj = new TableUI('plb_dept_reimburse');
        TableUIObj.init(colShowObj2, function () {
            tableInit(0, deptId)
        });

        //切换tab页签
        element.on('tab(docDemoTabBrief)', function (data) {

            var deptId = $('#leftId').attr('deptId') || ''
            if (data.index == '1') {
                $('#oneQuery').show()
                $('#twoQuery').hide()
                $('#threeQuery').hide()
                TableUIObj = new TableUI('plb_dept_budget');
                TableUIObj.init(colShowObj, function () {
                    tableInit(1, deptId)
                });
            } else if (data.index == '2') {
                $('#oneQuery').hide()
                $('#twoQuery').show()
                $('#threeQuery').hide()
                TableUIObj = new TableUI('plb_dept_budget_item');
                TableUIObj.init(colShowObj1, function () {
                    tableInit(2, deptId)
                });
            } else if (data.index == '0') {
                $('#oneQuery').hide()
                $('#twoQuery').hide()
                $('#threeQuery').show()
                TableUIObj = new TableUI('plb_dept_reimburse');
                TableUIObj.init(colShowObj2, function () {
                    tableInit(0, deptId)
                });
            }
        });

        //点击查询
        $('.searchData').click(function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                // 将查询值保存至cookie中
                $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
            })
            $.cookie('oneQuery', $('#oneQuery').attr('deptId'), {expires: 5, path: "/",});
            $.cookie('twoQuery', $('#twoQuery').attr('deptId'), {expires: 5, path: "/",});
            $.cookie('threeQuery', $('#threeQuery').attr('deptId'), {expires: 5, path: "/",});
            $.cookie('reimburseBelongDept', $('#reimburseBelongDept').attr('deptId'), {expires: 5, path: "/",});

            if ($('#oneQuery').css('display') == 'block') {
                searchParams.tgName = $('[name="tgName"]').val()
                searchParams.deptId = $('[name="oneDptName"]').attr('deptId').replace(/,/, '')
            } else if ($('#twoQuery').css('display') == 'block') {
                searchParams.rbsItemName = $('[name="itemName"]').val()
                searchParams.deptId = $('[name="twoDeptName"]').attr('deptId').replace(/,/, '')
            } else if ($('#threeQuery').css('display') == 'block') {
                searchParams.reimburseNo = $('[name="reimburseNo"]').val()
                searchParams.reimburseTotal = $('[name="reimburseTotal"]').val()
                searchParams.createUser = $('[name="createUser"]').attr('user_id')
                searchParams.reimburseUser=$('[name="reimburseUser"]').attr('user_id')
                searchParams.reimburseBelongDept = $('#reimburseBelongDept').attr('deptId')
            }
            tableObj.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        //判断是否显示空
        function isShowNull(data) {
            if (data) {
                return data
            } else {
                return ''
            }
        }
    });
</script>
</body>
</html>