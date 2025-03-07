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
    <title>合同管理</title>

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
    <%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>

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

        /* region 左侧样式 */
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


        /* endregion */

        /* region 右侧样式 */
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

        /* endregion */

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

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }

        body .demo-class .layui-layer-btn1 {
            border-color: #FFB800;
            background-color: #FFB800;
            color: #fff;
        }
        .export_moudle{
            background-color: #ffff;
            width: 120px;
            position: absolute;
            right: 0;
            top:100%;
            text-align: left;
            padding: 10px;
            display:none;
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
            <h2 style="text-align: center;line-height: 35px;">部门合同管理</h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="部门名称" autocomplete="off"
                       class="layui-input"/>
            </div>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="contractMoney" placeholder="合同金额" autocomplete="off" class="layui-input">
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
                <div class="table_box">
                    <table id="tableDemo" lay-filter="tableDemo"></table>
                </div>
                <div class="no_data" style="text-align: center;display: none">
                    <div class="no_data_img" style="margin-top:12%;">
                        <img style="margin-top: 2%;" src="/img/noData.png">
                    </div>
                    <p style="text-align: center; font-size: 20px; font-weight: normal;">请选择部门</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <%--        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>--%>
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img
                src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img
                src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出
        </button>
        <%--        <i class="layui-icon layui-icon-upload-circle iconImg" lay-event="import"  style="margin-left: 10px;font-size: 20px" title="导入"></i>
                <i class="layui-icon layui-icon-export iconImg" lay-event="export" style="margin-left: 10px;font-size: 20px" title="导出"></i>--%>
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

<script type="text/html" id="checkBar">
    <a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="check">查看详情</a>
</script>

<script>
    var approvalData = '';
    var xhr = null;
    $(document).on('click', '.userAdd', function () {
        var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : ''
        user_id = $(this).siblings('textarea').attr('id')
        $.popWindow("/common/selectUser" + chooseNum);
    });
    //选人控件删除
    $(document).on('click', '.userDel', function () {
        var userId = $(this).siblings('textarea').attr('id')
        $('#' + userId).val('')
        $('#' + userId).attr('user_id', '')
    });

    var tipIndex = null;
    $('.icon_img').on('hover',function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        // CONTRACT_TYPE: {},
        PAYMENT_METHOD: {},
        TAX_RATE: {},
        INVOICE_TYPE: {},
    }
    // var dictionaryStr = 'CONTRACT_TYPE,PAYMENT_METHOD,TAX_RATE,INVOICE_TYPE';
    var dictionaryStr = 'PAYMENT_METHOD,TAX_RATE,INVOICE_TYPE';
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
    // $.get('/plbDeptSubcontract/treeList', function (res) {
    //     if (res.flag) {
    //         console.log(res)
    //     }
    // });
    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var tableIns = null;
        var materialsTable = null;

        form.render();
        //表格显示顺序
        var colShowObj = {
            contractName: {field: 'contractName', title: '合同名称', sort: true, hide: false},
            deptId: {
                field: 'deptId', title: '所属部门', sort: true, hide: false, templet: function (d) {
                    return d.deptName || ''
                }
            },
            contractType: {
                field: 'contractType', title: '合同类型', sort: true, hide: false, templet: function (d) {
                    // return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || ''
                    return d.contractTypeName || ''
                }
            },
            signDate: {
                field: 'signDate', title: '合同签订日期', sort: true, hide: false, templet: function (d) {
                    return format(d.signDate);
                }
            },
            revisionCount: {
                field: 'revisionCount',
                title: '变更次数',
                hide: false,
                event: 'revisionCount',
                style: 'cursor: pointer;color:blue'
            },
            // customerName: {field: 'customerName', title: '供应商单位', sort: true, hide: false},
            contractMoney: {field: 'contractMoney', title: '合同金额', sort: true, hide: false},
            contractPeriod: {field: 'contractPeriod', title: '合同工期', sort: true, hide: false},
            auditerStatus: {
                field: 'auditerStatus', title: '审批状态', templet: function (d) {
                    var str = '';
                    switch (d.auditerStatus) {
                        case '0':
                            str = '未提交';
                            break;
                        case '1':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: orange;cursor: pointer;" ' + flowStr + '>审批中</span>';
                            break;
                        case '2':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>批准</span>';
                            break;
                        case '3':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>不批准</span>';
                            break;
                    }
                    return str;
                }
            },
        }

        var TableUIObj = new TableUI('plb_dept_subcontract');


        // 初始化左侧项目
        projectLeft();
        // 节点点击事件
        $(document).on('click', '.con_left ul li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var projId = $(this).attr('projId');
            tableShow(projId);
            $('#leftId').attr('projId', projId);
        });
        // 上方按钮显示
        table.on('toolbar(tableDemo)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    if ($('#leftId').attr('deptId')) {
                        newOrEdit(0);
                    } else {
                        layer.msg('请选择左侧部门！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var subcontractId = ''
                    var flag = false
                    checkStatus.data.forEach(function (v, i) {
                        if (v.auditerStatus != '0') {
                            flag = true
                            return false
                        }
                        subcontractId += v.subcontractId + ','
                    })
                    if (flag) {
                        layer.msg('所选数据已提交，不可删除！', {icon: 0, time: 2000});
                        return false;
                    }
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbDeptSubcontract/delete', {subcontractIds: subcontractId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 0});
                            }
                            layer.close(index)
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                        })
                    });
                    break;
                case 'export':
                    $('.export_moudle').show()

                    break;
                case 'submit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                        return false;
                    }

                    if (checkStatus.data[0].auditerStatus == '1') {
                        layer.msg('所选数据正在审批中，不可重复提交！', {icon: 0, time: 2000});
                        return false;
                    }
                    if (checkStatus.data[0].auditerStatus == '2' || checkStatus.data[0].auditerStatus == '3') {
                        layer.msg('所选数据已审批，不可重复提交！', {icon: 0, time: 2000});
                        return false;
                    }
                    //var contractInfo = checkStatus.data[0];
                    approvalData = checkStatus.data[0]
                    layer.open({
                        type: 1,
                        title: '选择流程',
                        area: ['70%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                        success: function () {
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '09'}, function (res) {
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
                                //var urlParameter = 'type=3&customerType=' + customerInfo.customerType + '&customerId=' + customerInfo.customerId
                                newWorkFlow(flowData.flowId, function (res) {
                                    // 报销单保存关联的runId
                                    var submitData = {
                                        //customerId: customerInfo.customerId,
                                        subcontractId: approvalData.subcontractId,
                                        runId: res.flowRun.runId,
                                        auditerStatus: 1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/plbDeptSubcontract/update',
                                        data: JSON.stringify(submitData),
                                        dataType: 'json',
                                        contentType: "application/json;charset=UTF-8",
                                        type: 'post',
                                        success: function (res) {
                                            layer.close(loadIndex);
                                            if (res.flag) {
                                                layer.close(index);
                                                layer.msg('提交成功!', {icon: 1});
                                                tableIns.config.where._ = new Date().getTime();
                                                tableIns.reload()
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
                    break;
            }
        });
        // 监听排序事件
        table.on('sort(tableDemo)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow($('#leftId').attr('deptId'))
            })
        });
        //工具条事件
        table.on('tool(tableDemo)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if (layEvent === 'check') { //查看
                newOrEdit(2, data)
            } else if (layEvent === 'revisionCount') {//变更数据
                newOrEdit(3, data)
            } else if (layEvent === 'edit') {
                if (data.auditerStatus != '0') {
                    layer.msg('该数据已提交，不可进行编辑！', {icon: 0, time: 2000});
                    return false;
                }
                newOrEdit(1, data)
            }
        });
        $(document).on('click',function () {
            $('.export_moudle').hide();
        })
        $(document).on('click', '.export_btn',function () {
            var type=$(this).attr('type')
            var fileName='合同管理.xlsx'

            if(type==1){
                var checkStatus = table.checkStatus('tableDemo');
                if (checkStatus.data.length == 0) {
                    layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                    return false;
                }
                soulTable.export(tableIns, {
                    filename: fileName,
                    checked: true
                });
            }else if(type==2){
                soulTable.export(tableIns,{
                    filename:fileName,
                    curPage: true
                })
            } else if(type==3){
                var load=layer.load(2)
                $.get('/plbDeptSubcontract/selectAll',function () {
                    soulTable.export(tableIns, {
                        filename: fileName
                    });
                    layer.close(load)
                })
            }
        })

        // 监听筛选列
        form.on('checkbox()', function (data) {
            //判断监听的复选框是筛选列下的复选框
            if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
                setTimeout(function () {
                    var $parent = $(data.elem).parent().parent()
                    var arr = []
                    $parent.find('input[type="checkbox"]').each(function () {
                        var obj = {
                            showFields: $(this).attr('name'),
                            isShow: !$(this).prop('checked')
                        }
                        arr.push(obj)
                    })
                    var param = {showFields: JSON.stringify(arr)}
                    TableUIObj.update(param)
                }, 1000)
            }
        });

        var searchTimer = null
        $('#search_project').on('input propertychange', function () {
            clearTimeout(searchTimer)
            searchTimer = null
            var val = $(this).val()
            searchTimer = setTimeout(function () {
                projectLeft(val)
            }, 300)
        });
        $('.search_icon').on('click', function () {
            projectLeft($('#search_project').val())
        });

        //左侧项目信息列表
        function projectLeft(projectName) {
            projectName = projectName ? projectName : ''
            var loadingIndex = layer.load();

            $.get('/plbOrg/selectAll', function (res) {
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
                    TableUIObj.init(colShowObj, function () {
                        tableShow('')
                    });
                }
            });
        }

        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            var currentData = d.data.currentData;
            if (currentData.deptId) {
                $('#leftId').attr('deptId', currentData.deptId);
                $('.no_data').hide();
                $('.table_box').show();
                tableShow(currentData.deptId);
            } else {
                $('.table_box').hide();
                $('.no_data').show();
            }
            $('.eleTree-node-content-label').each(function(){
                var titleSpan=$(this).text();
                $(this).attr('title',titleSpan);
            })
        });

        // 渲染表格
        function tableShow(deptId) {
            var cols = [{checkbox: true, fixed: 'left'}].concat(TableUIObj.cols)
            cols.push({align: 'center', toolbar: '#checkBar', title: '操作', width: 150, fixed: 'right'})
            tableIns = table.render({
                elem: '#tableDemo',
                url: '/plbDeptSubcontract/selectAll',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-80',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                cellMinWidth: 150,
                where: {
                    deptId: deptId,
                    subcontractType:'01',
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                },
                request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },
                done: function (res) {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableDemo')
                    })


                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit})
                    }
                },
                initSort: {
                    field: TableUIObj.orderbyFields,
                    type: TableUIObj.orderbyUpdown
                }
            });
        }

        // 新建/编辑
        function newOrEdit(type, data) {
            var title = '';
            var url = '';
            var deptId = $('#leftId').attr('deptId');
            if (type == '0') {
                title = '新建合同';
                url = '/plbDeptSubcontract/insert';
            } else if (type == '1') {
                title = '编辑合同';
                url = '/plbDeptSubcontract/update';
            } else if (type == '2') {
                title = '查看合同';
            } else if (type == 3) {
                var revisionCount = data.revisionCount;
                var list = []
                var reviseTargetId = data.subcontractId
                if (revisionCount == 0) {
                    layer.msg('该数据未变更！', {icon: 0, time: 2000});
                    return false;
                }
                $.get('/plbDeptSubcontract/queryHistoryVersionByRunId', {
                    reviseTargetId: reviseTargetId,
                    subcontractType:'01',
                    reviseType: '06'
                }, function (res) {
                    for (var i = 0; i < res.data.length; i++) {
                        var content = ['<div class="layui-collapse">\n',
                            /* region 材料计划 */
                            '  <div class="layui-colla-item">\n' +
                            '    <h2 class="layui-colla-title">' + res.data[i].version + '</h2>\n' +
                            '    <div class="layui-colla-content layui-show plan_base_info">' +
                            '       <form class="layui-form" id="baseForm" lay-filter="formContentTest' + i + '">',
                            /* region 第一行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            /*'                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="subcontractNo" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull"  title="合同编号">\n' +
                            '                       </div>\n' +
                            '                   </div>' +*/
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="subcontractNo" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull" title="合同编号">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同名称<span class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="contractName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input testNull" title="合同名称">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同金额(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="contractMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="合同金额(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第二行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4 bondRatio" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">履约金比例</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="bondRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="履约金比例">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4 warrantyPeriod" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">质保期</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="warrantyPeriod" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="质保期">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4 warrantyRatio" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">质保金比例</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="warrantyRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="质保金比例">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第三行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">甲方<span class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="contractAName"  readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">乙方<span class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="customerName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">发票类型</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                        <select name="invoiceType" disabled></select>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>' +
                            /* endregion */
                            /* region 第四行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">付款方式</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                        <select name="paymentType" disabled></select>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '<div class="layui-col-xs4" style="padding: 0 5px">' +
                            '   <div class="layui-form-item">' +
                            '       <label class="layui-form-label form_label">合同类型</label>' +
                            '       <div class="layui-input-block form_block">' +
                            '<div id="customerSelectTree" name="contractType"  class="xm-select-demo" style="width: 100%;"></div>' +
                            '       </div>' +
                            '   </div>' +
                            '</div>',
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同签订日期</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" readonly style="background: #e7e7e7" name="signDate" id="signDate" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第五行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同工期</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="contractPeriod" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="合同工期">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">预付款(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="paymentPre" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="预付款(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">税率</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <select name="taxRate" disabled><option value=""></option></select>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            /* region 第六行*/
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">不含税合同价(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="contractMoneyNotax" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="不含税合同价(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4 depositRatio" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">押金比例</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="depositRatio" readonly style="background: #e7e7e7"   autocomplete="off" class="layui-input chinese" title="押金比例">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4 bondCash" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">履约保证金(元)</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="number" name="bondCash" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input  chinese" title="履约保证金(元)">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '            </div>' +
                            /* endregion */
                            /* region 第六行*/
                            '           <div class="layui-row">' +
                            '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">\n' +
                            '  <ul class="layui-tab-title">\n' +
                            '    <li class="layui-this">合同内容</li>\n' +
                            '    <li>付款条件</li>\n' +
                            '  </ul>\n' +
                            '  <div class="layui-tab-content">' +
                            '       <div class="layui-tab-item layui-show"><textarea name="contractContent" readonly style="background: #e7e7e7" placeholder="请输入内容" class="layui-textarea"></textarea></div>\n' +
                            '       <div class="layui-tab-item"><textarea name="paymentCondition" readonly style="background: #e7e7e7" placeholder="请输入内容" class="layui-textarea"></textarea></div>' +
                            '</div>\n' +
                            '</div> ' +
                            '            </div>' +
                            /* endregion */
                            /* region 第七行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">比价附件</label>' +
                            '                       <div class="layui-input-block form_block">' +
                            '<div class="file_module">' +
                            '<div id="fileContent2" class="file_content"></div>' +
                            '<div class="file_upload_box">' +
                            '<a href="javascript:;" class="open_file">' +
                            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '<input type="file" multiple id="fileupload2" data-url="/upload?module=planbudget" name="file">' +
                            '</a>' +
                            '<div class="progress">' +
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
                            /* region 第八行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">合同附件</label>' +
                            '                       <div class="layui-input-block form_block">' +
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
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>',
                            /* endregion */
                            '       </form>' +
                            '    </div>\n' +
                            '  </div>\n',
                            /* endregion */
                            /* region 合同明细 */
                            /* endregion */
                            '</div>'].join('')
                        $('#version').text(res.data[i].version)
                        list += content
                    }
                    layer.open({
                        type: 1,
                        title: "查看历史数据",
                        area: ['70%', '80%'],
                        btn: ['关闭'],
                        btnAlign: 'c',
                        content: list
                    })
                    $('[name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str'])
                    $('[name="contractType"]').html(dictionaryObj['CONTRACT_TYPE']['str'])
                    $('[name="taxRate"]').append(dictionaryObj['TAX_RATE']['str'])
                    $('[name="invoiceType"]').append(dictionaryObj['INVOICE_TYPE']['str'])
                    for (var i = 0; i < res.data.length; i++) {
                        form.val("formContentTest" + i, res.data[i]);
                    }
                    element.render();
                    form.render();
                    data.bondRatio ? '' : $('.bondRatio').hide()
                    data.warrantyPeriod ? '' : $('.warrantyPeriod').hide()
                    data.warrantyRatio ? '' : $('.warrantyRatio').hide()
                    data.bondCash ? '' : $('.bondCash').hide()
                    data.depositRatio ? '' : $('.depositRatio').hide()

                    $('.file_upload_box').hide()
                    $('.deImgs').hide()
                })
                return false
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: ['保存', '提交', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse">\n',
                    /* region 材料计划 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">合同</h2>\n' +
                    '    <div class="layui-colla-content layui-show plan_base_info">' +
                    '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
                    /* region 第一行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    /* '                   <div class="layui-form-item">\n' +
                     '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                     '                       <div class="layui-input-block form_block">\n' +
                     '                       <input type="text" name="subcontractNo" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="合同编号">\n' +
                     '                       </div>\n' +
                     '                   </div>' +*/
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="subcontractNo" autocomplete="off" class="layui-input testNull" title="合同编号">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同名称<span class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractName" autocomplete="off" class="layui-input testNull" title="合同名称">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同金额(元)</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="contractMoney" autocomplete="off" class="layui-input chinese" title="合同金额(元)">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第二行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">履约金比例</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="bondRatio" autocomplete="off" class="layui-input" title="履约金比例">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">质保期</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="warrantyPeriod" autocomplete="off" class="layui-input" title="质保期">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">质保金比例</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="warrantyRatio" autocomplete="off" class="layui-input" title="质保金比例">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第三行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">甲方<span class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractA" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent testNull" title="甲方">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">乙方<span class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="customerId" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent testNull" title="乙方">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">发票类型</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                        <select name="invoiceType"></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' +
                    /* endregion */
                    /* region 第四行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">付款方式</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                        <select name="paymentType"></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    // '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    // '                   <div class="layui-form-item">\n' +
                    // '                       <label class="layui-form-label form_label">合同类型</label>\n' +
                    // '                       <div class="layui-input-block form_block">\n' +
                    // '                        <select name="contractType"></select>' +
                    // '                       </div>\n' +
                    // '                   </div>' +
                    // '               </div>' +
                    '<div class="layui-col-xs4" style="padding: 0 5px">' +
                    '   <div class="layui-form-item">' +
                    '       <label class="layui-form-label form_label">合同类型</label>' +
                    '       <div class="layui-input-block form_block">' +
                    '<div id="customerSelectTree" name="contractType"  class="xm-select-demo" style="width: 100%;"></div>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>',
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同签订日期</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" readonly name="signDate" id="signDate" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第五行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同有效期</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractPeriod" readonly autocomplete="off" class="layui-input" title="合同有效期">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">预付款(元)</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="paymentPre" autocomplete="off" class="layui-input" title="预付款(元)">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">税率</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <select name="taxRate"><option value=""></option></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第六行*/
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">不含税合同价(元)</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="contractMoneyNotax" autocomplete="off" class="layui-input chinese" title="不含税合同价(元)">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">押金比例</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="depositRatio"   autocomplete="off" class="layui-input chinese" title="押金比例">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">履约保证金(元)</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="bondCash" autocomplete="off" class="layui-input  chinese" title="履约保证金(元)">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '            </div>' +
                    /* endregion */
                    /* region 第六行*/
                    '           <div class="layui-row">' +
                    '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">\n' +
                    '  <ul class="layui-tab-title">\n' +
                    '    <li class="layui-this">合同内容</li>\n' +
                    '    <li>付款条件</li>\n' +
                    '  </ul>\n' +
                    '  <div class="layui-tab-content">' +
                    '       <div class="layui-tab-item layui-show"><textarea name="contractContent" placeholder="请输入内容" class="layui-textarea"></textarea></div>\n' +
                    '       <div class="layui-tab-item"><textarea name="paymentCondition"  placeholder="请输入内容" class="layui-textarea"></textarea></div>' +
                    '</div>\n' +
                    '</div> ' +
                    '            </div>' +
                    /* endregion */
                    /* region 第七行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">比价附件</label>' +
                    '                       <div class="layui-input-block form_block">' +
                    '<div class="file_module">' +
                    '<div id="fileContent2" class="file_content"></div>' +
                    '<div class="file_upload_box">' +
                    '<a href="javascript:;" class="open_file">' +
                    '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                    '<input type="file" multiple id="fileupload2" data-url="/upload?module=planbudget" name="file">' +
                    '</a>' +
                    '<div class="progress">' +
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
                    /* region 第八行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同附件</label>' +
                    '                       <div class="layui-input-block form_block">' +
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
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n',
                    /* endregion */
                    /* region 合同明细 */
                    /* endregion */
                    '</div>'].join(''),
                success: function () {
                    /*获取合同类型数据----start*/
                    if(type == '2'){
                        customerSelectTree = xmSelect.render({
                            el: '#customerSelectTree',
                            content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                                '<input type="text" style="box-sizing: border-box;" class="layui-input" id="customerSelect">' +
                                '</div>' +
                                '<div style="padding-top: 30px;" id="customerTree" class="eleTree" lay-filter="customerTree"></div>',
                            name: 'contractType',
                            disabled:true,
                            prop: {
                                name: 'typeName',
                                value: 'typeNo'
                            }
                        });
                    }else{
                        customerSelectTree = xmSelect.render({
                            el: '#customerSelectTree',
                            content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                                '<input type="text" style="box-sizing: border-box;" class="layui-input" id="customerSelect">' +
                                '</div>' +
                                '<div style="padding-top: 30px;" id="customerTree" class="eleTree" lay-filter="customerTree"></div>',
                            name: 'contractType',
                            prop: {
                                name: 'typeName',
                                value: 'typeNo'
                            }
                        });
                    }

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
                        $.get('/plbDeptSubcontract/treeList',function (res) {
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
                        var currentData = d.data.currentData;
                        var obj = {
                            typeName: currentData.typeName,
                            typeNo: currentData.typeNo
                        }
                        customerSelectTree.setValue([obj]);
                    });
                    element.render();
                    form.render();
                    //合同有效期
                    laydate.render({
                        elem: '[name="contractPeriod"]',
                        trigger: 'click', //采用click弹出
                        range: '~',
                        value: data ? data.contractPeriod : ''
                    });

                    //付款方式、合同类型、税率、发票类型
                    $('[name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str'])
                    // $('[name="contractType"]').html(dictionaryObj['CONTRACT_TYPE']['str'])
                    $('[name="taxRate"]').append(dictionaryObj['TAX_RATE']['str'])
                    $('[name="invoiceType"]').append(dictionaryObj['INVOICE_TYPE']['str'])


                    fileuploadFn('#fileupload', $('#fileContent'));
                    fileuploadFn('#fileupload2', $('#fileContent2'));
                    //回显数据
                    if (type == 1 ) {
                        subcontractId = data.subcontractId
                        form.val("formTest", data);
                        //回显客商来源
                        var obj = {
                            typeName: data.contractTypeName,
                            typeNo: data.contractType
                        }
                        customerSelectTree.setValue([obj]);
                        $('[name="contractType"]').val(data.contractTypeName)
                        $('[name="contractA"]').val(data.contractAName || '')
                        $('[name="contractA"]').attr('customerId', data.contractA || '')
                        $('[name="customerId"]').val(data.customerName || '')
                        $('[name="customerId"]').attr('customerId', data.customerId || '')
                        //合同附件
                        if (data.attachment && data.attachment.length > 0) {
                            var fileArr = data.attachment;
                            var str = '';
                            for (var i = 0; i < fileArr.length; i++) {
                                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                            }
                            $('#fileContent').append(str);
                        }
                        //比价附件
                        if (data.attachment2 && data.attachment2.length > 0) {
                            var fileArr = data.attachment2;
                            var str = '';
                            for (var i = 0; i < fileArr.length; i++) {
                                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                            }
                            $('#fileContent2').append(str);
                        }
                    }else if(type == 2){
                        subcontractId = data.subcontractId
                        form.val("formTest", data);
                        //回显客商来源
                        var obj = {
                            typeName: data.contractTypeName,
                            typeNo: data.contractType
                        }
                        customerSelectTree.setValue([obj]);
                        $('[name="contractType"]').val(data.contractTypeName)
                        $('[name="contractA"]').val(data.contractAName || '')
                        $('[name="contractA"]').attr('customerId', data.contractA || '')
                        $('[name="customerId"]').val(data.customerName || '')
                        $('[name="customerId"]').attr('customerId', data.customerId || '')
                        //合同附件
                        if (data.attachment && data.attachment.length > 0) {
                            var fileArr = data.attachment;
                            var str = '';
                            for (var i = 0; i < fileArr.length; i++) {
                                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                            }
                            $('#fileContent').append(str);
                        }
                        //比价附件
                        if (data.attachment2 && data.attachment2.length > 0) {
                            var fileArr = data.attachment2;
                            var str = '';
                            for (var i = 0; i < fileArr.length; i++) {
                                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                            }
                            $('#fileContent2').append(str);
                        }


                        $('.layui-layer-btn-c').hide()
                        $('#baseForm [name]').each(function () {
                            $(this).attr('disabled', 'true')
                        })
                        $('.file_upload_box').hide()
                        $('.deImgs').hide()
                        form.render()

                    } else {
                        // 获取自动编号
                        /*getAutoNumber({autoNumber: 'plbDeptSubcontract'}, function (res) {
                            $('input[name="subcontractNo"]', $('#baseForm')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function () {
                            getAutoNumber({autoNumber: 'plbDeptSubcontract'}, function (res) {
                                $('input[name="subcontractNo"]', $('#baseForm')).val(res);
                            });
                        });*/

                        // 获取主键
                        $.get('/plbDeptReimburse/getUUID', function (res) {
                            subcontractId = res;
                        });
                    }

                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#signDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.signDate) : ''
                    });
                },
                yes: function (index) {
                    //必填项提示
                    // for (var i = 0; i < $('.testNull').length; i++) {
                    //     if ($('.testNull').eq(i).val() == '') {
                    //         layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                    //         return false
                    //     }
                    // }
                    //提示输入框只能输入数字
                    for (var a = 0; a < $('.chinese').length; a++) {
                        if (isNaN($('.chinese').eq(a).val())) {
                            layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                            return false
                        }
                    }

                    var loadIndex = layer.load();
                    //合同数据
                    var datas = $('#baseForm').serializeArray();
                    var obj = {subcontractType:'01'}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });

                    obj.contractA = $('[name="contractA"]').attr('customerId')
                    obj.customerId = $('[name="customerId"]').attr('customerId')
                    // obj.contractType = $('[name="contractType"]').attr('customerId')

                    // 合同附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId = attachmentId;
                    obj.attachmentName = attachmentName;

                    // 比价附件
                    var attachmentId2 = '';
                    var attachmentName2 = '';
                    for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
                        attachmentId2 += $('#fileContent2 .dech').eq(i).find('input').val();
                        attachmentName2 += $('#fileContent2 a').eq(i).attr('name');
                    }
                    obj.attachmentId2 = attachmentId2;
                    obj.attachmentName2 = attachmentName2;


                    if (type == 1) {
                        obj.subcontractId = data.subcontractId
                    } else {
                        obj.deptId = parseInt(deptId);
                    }
                    if (subcontractId) {
                        obj.subcontractId = subcontractId
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
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload();
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }
                    });
                },
                btn2: function (index, layero) {
                    //必填项提示
                    for (var i = 0; i < $('.testNull').length; i++) {
                        if ($('.testNull').eq(i).val() == '') {
                            layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                            return false
                        }
                    }
                    //提示输入框只能输入数字
                    for (var a = 0; a < $('.chinese').length; a++) {
                        if (isNaN($('.chinese').eq(a).val())) {
                            layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                            return false
                        }
                    }

                    var loadIndex = layer.load();
                    //合同数据
                    var datas = $('#baseForm').serializeArray();
                    var obj = {subcontractType:'01'}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });

                    obj.contractA = $('[name="contractA"]').attr('customerId')
                    obj.customerId = $('[name="customerId"]').attr('customerId')

                    // 合同附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId = attachmentId;
                    obj.attachmentName = attachmentName;

                    // 比价附件
                    var attachmentId2 = '';
                    var attachmentName2 = '';
                    for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
                        attachmentId2 += $('#fileContent2 .dech').eq(i).find('input').val();
                        attachmentName2 += $('#fileContent2 a').eq(i).attr('name');
                    }
                    obj.attachmentId2 = attachmentId2;
                    obj.attachmentName2 = attachmentName2;


                    if (type == 1) {
                        obj.subcontractId = data.subcontractId
                    } else {
                        obj.deptId = parseInt(deptId);
                    }

                    if (subcontractId) {
                        obj.subcontractId = subcontractId
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
                                $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '09'}, function (res) {
                                    var flowDataArr = []
                                    $.each(res.data.flowData, function (k, v) {
                                        flowDataArr.push({
                                            flowId: k,
                                            flowName: v
                                        });
                                    });
                                    obj.subcontractId = subcontractId
                                    obj.contractA = $('[name="contractA"]').val()
                                    obj.customerId = $('[name="customerId"]').val()

                                    if (flowDataArr.length == 1) {
                                        submitFlow(flowDataArr[0].flowId, obj);
                                    } else {
                                        layer.open({
                                            type: 1,
                                            title: '选择流程',
                                            area: ['70%', '80%'],
                                            btn: ['确定', '取消'],
                                            btnAlign: 'c',
                                            content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                            success: function () {
                                                table.render({
                                                    elem: '#flowTable',
                                                    data: flowDataArr,
                                                    cols: [[
                                                        {type: 'radio'},
                                                        {field: 'flowName', title: '流程名称'}
                                                    ]]
                                                })
                                            },
                                            yes: function (index) {
                                                var checkStatus = table.checkStatus('flowTable');
                                                if (checkStatus.data.length > 0) {
                                                    var flowData = checkStatus.data[0];

                                                    submitFlow(flowData.flowId, obj)

                                                } else {
                                                    layer.msg('请选择一项！', {icon: 0});
                                                }
                                            }
                                        });
                                    }
                                });
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }
                    });

                    return false
                }
            });

        }

        function submitFlow(flowId, approvalData) {
            var loadIndex = layer.load();
            newWorkFlow(flowId, function (res) {
                // 报销单保存关联的runId
                var submitData = {
                    subcontractId: approvalData.subcontractId,
                    runId: res.flowRun.runId,
                    auditerStatus: 1
                }
                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                $.ajax({
                    url: '/plbDeptSubcontract/updateRun',
                    data: JSON.stringify(submitData),
                    dataType: 'json',
                    contentType: "application/json;charset=UTF-8",
                    type: 'post',
                    success: function (res) {
                        layer.close(loadIndex);
                        if (res.flag) {
                            layer.msg('提交成功!', {icon: 1});
                            layer.closeAll()
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                        } else {
                            layer.msg(res.msg, {icon: 2});
                        }
                    }
                });
            }, approvalData);
        }


        $(document).on('click', '.chooseEquivalent', function () {
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
                        if (currentData.typeNo) {
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
                    function loadMtlType(typeNo) {
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
                                        key: "typeNo", // 节点id
                                        parentId: 'parentTypeId', // 节点父id
                                        isLeaf: "isLeaf",// 是否有子节点
                                        children: 'child',
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(typeNo) {
                        var loading = layer.load(1)
                        if(xhr){
                            xhr.abort()
                        }
                        typeNo = typeNo ? typeNo : '';
                        xhr = $.ajax({
                            url: '/PlbCustomer/getDataByCondition',
                            data:{
                                merchantType: typeNo,
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
                                        {type: 'radio'}
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
                        _this.attr('customerId', mtlData.customerId);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });

        //选择分包商内侧查询
        $(document).on('click', '.inSearchData', function () {
            var loading = layer.load(1)
            var searchParams = {}
            var $seachData = $('.inSearchContent [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            xhr = $.ajax({
                url: '/PlbCustomer/getDataByCondition',
                data:searchParams,
                success:function(res){
                    layer.close(loading)
                    materialsTable.reload({
                        data:res.data,
                    });
                }
            })
        });


        //点击查询
        $('.searchData').on('click',function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            tableIns.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        $(document).on('click', '.preview_flow', function () {
            /*var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId');
            if (flowId && runId) {
                $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
            }*/
            var formUrl = $(this).attr('formUrl')
            if (formUrl) {
                if (formUrl.split('')[0] == '/') {
                    window.open(formUrl)
                } else {
                    window.open('/' + formUrl)
                }
            }
        });
    });


    //附件上传 方法
    var timer = null;

    function fileuploadFn(formId, element) {
        $(formId).fileupload({
            dataType: 'json',
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                element.siblings('.file_upload_box').find('.progress').find('.bar').css(
                    'width',
                    progress + '%'
                );
                element.siblings('.barText').html(progress + '%');
                if (progress >= 100) {  //判断滚动条到100%清除定时器
                    timer = setTimeout(function () {
                        element.siblings('.file_upload_box').find('.progress').find('.bar').css(
                            'width',
                            0 + '%'
                        );
                        element.siblings('.file_upload_box').find('.barText').html('');
                    }, 2000);

                }
            },
            done: function (e, data) {
                if (data.result.obj != '') {
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') { //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!', {}, function () {
                                layer.closeAll();
                            });
                        } else {
                            var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;

                            str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    element.append(str);
                } else {
                    layer.alert('添加附件大小不能为空!', {}, function (index) {
                        layer.close(index);
                    });
                }
            }
        });
    }

    /**
     * 新建流程方法
     * @param flowId
     * @param urlParameter
     * @param cb
     */
    function newWorkFlow(flowId, cb, approvalData) {
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
                approvalData: JSON.stringify(approvalData),
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
</script>
</body>
</html>