<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title>合同付款</title>

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

        .invoices_module {
            position: relative;
            padding-right: 20px;
        }

        .invoices_box {
            overflow: hidden;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .choose_invoices {
            position: absolute;
            top: 0;
            right: 0;
            color: #00a1d6 !important;
            cursor: pointer;
        }

        .invoices_box:hover {
            color: #0A5FA2;
            cursor: pointer;
        }

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        /*.layui-table-cell .layui-form-checkbox[lay-skin="primary"]{*/
        /*    top: 50%;*/
        /*    transform: translateY(-50%);*/
        }
        .layui-table-view .layui-form-radio{
            line-height:30px;
        }
        .fixedtitle{
            background:url("/img/workflow/flowsetting/xiaojiqiao.png") no-repeat;
            width: 225px;
            height: 152px;
            position: fixed;
            bottom: 7px;
            left: 4px;
        }
        #xiaokuan {
            margin-top: 50px;
            float: left;
            line-height: 1.8;
        }
        .operationDiv{
            position: absolute;
            width: 150px;
            border: #ccc 1px solid;
            border-radius: 4px;
            background-color: #ffffff;
            z-index: 99;
        }
        .fujian{
            text-decoration: underline;
            color: blue;
        }
        .operation{
            display: block;
            /*width: 100%;*/
            margin-left: 0px !important;
            height: 28px;
            padding-left: 10px;
            background: #fff;
            line-height: 28px;
        }
        .operation:hover{
            background-color: #cae1f7;
            color: #000000;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <input type="hidden" id="deptId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">合同付款</h2>
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
            <div class="fixedtitle">
                <div id="xiaokuan">
                </div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="contractNo" placeholder="单据编号" autocomplete="off" class="layui-input">

                </div>
                <%--<div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="remark" placeholder="备注" autocomplete="off" class="layui-input">
                </div>--%>
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
                    <p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧项目</p>
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
    </div>
</script>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    var subpaymentId = ''
    //小技巧
    $('.fixedtitle').on('mouseover', '.divShow', function () {
        $(this).find('.operationDiv').show();
    })
    $('.fixedtitle').on('mouseout', '.divShow', function () {
        $(this).find('.operationDiv').hide();
    })
    // 预览
    $(document).on('click', '.yulan', function () {
        var url = $(this).attr('data-url');
        pdurl($.UrlGetRequest('?' + url), url);
    })
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name = $(this).attr('name')
        $('.query_module [name=' + name + ']').val($.cookie(name) || '')
    })

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
    // 选择部门
    $(document).on('click', '.choose_dept', function () {
        dept_id = $(this).attr('id');
        $.popWindow('/common/selectDept?0');
    });

    var tipIndex = null;
    $('.icon_img').on('hover',function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        CONTROL_MODE: {},
        CBS_UNIT: {},
        PAYMENT_METHOD: {},
        RBS_TYPE: {},
        RBS_CATEGORY: {},
        CBS_LEVEL: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,PAYMENT_METHOD,RBS_TYPE,RBS_CATEGORY,CBS_LEVEL';
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
    $.get('/plbDictonary/getTgTypeByEnclosure', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            //附件回显
            var strs1 = '';
            var data=res.data;
            // console.log(obj)
            for (var i = 0; i < data.length; i++) {
                var v = data[i];
                var attachName = v.attachName;
                var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                var attachmentUrl = v.attUrl;
                attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                strs1 += '<div class="divShow"><a class="fujian" href="javascript:;" style=" width: 20px;display: inline; ">' + data[i].attachName + '</a>' +
                    '<div class="operationDiv" style="display:none;">' + function () {
                        if (fileExtension == 'pdf' || fileExtension == 'PDF' || fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG' || fileExtension == 'txt' || fileExtension == 'TXT') { //判断是否需要查阅
                            return '<a id="pageTbody" class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="margin-left: 10px"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">查阅</a>'
                        } else {
                            return '<a id="pageTbody" class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="margin-left: 10px"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">查阅</a>'
                        }
                    }() +
                    '<a id="pageTbody" class="operation" style="margin-left: 10px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                    + '</div>' +
                    '</div>'
            }
            $('#xiaokuan').append(strs1);
        }
    });
    var dataAll;
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
        var collectionUserTable = null;
        var layTable = layui.table;


        form.render();
        tJian()
        var colShowObj = {
            contractNo: {field: 'contractNo', title: '单据编号', width: 150, sort: true, hide: false, templet: function (d) {
                    return d.contractNo || ''
                }},
            // applyPayMoney: {field: 'applyPayMoney', title: '本次付款申请金额', width: 170, sort: true, hide: false},
            // totalPayRatio: {field: 'totalPayRatio', title: '本次付款后累计付款比例', sort: true, hide: false},
            // conSpareMoney: {field: 'conSpareMoney', title: '合同余款', width: 120, sort: true, hide: false},
            createTime: {field: 'createTime', title: '报销日期', width: 150, sort: true, hide: false},
            createUser: {
                field: 'createUser', title: '经办人 ', minWidth: 120, sort: true, hide: false, templet: function (d) {
                    return d.createUser || ''
                }
            },
            payMoney: {
                field: 'payMoney', title: '付款金额 ', minWidth: 120, sort: true, hide: false, templet: function (d) {
                    return  d.plbContractPaymentWithBLOBs.payMoney || ''
                }
            },
            customerId: {field: 'customerId', title: '客商', width: 220, sort: true, hide: false, templet: function (d) {
                    return d.customerName || ''
                }},
            // payNode: {field: 'payNode', title: '付款节点', sort: true, hide: false},
            // payMoney: {field: 'payMoney', title: '报销金额', width: 150, sort: true, hide: false,templet: function (d) {
            //         return d.plbContractPaymentWithBLOBs.payMoney || ''
            //     }},
            auditerStatus: {
                field: 'auditerStatus', title: '报销状态', width: 150, sort: true, hide: false, templet: function (d) {
                    var str = '';
                    switch (d.auditerStatus) {
                        case '0':
                            str = '未提交';
                            break;
                        case '1':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow"  formUrl="' + (d.fromUrl || '') + '" style="color: orange;cursor: pointer;" ' + flowStr + '>审批中</span>';
                            break;
                        case '2':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow"  formUrl="' + (d.fromUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>批准</span>';
                            break;
                        case '3':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow"  formUrl="' + (d.fromUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>不批准</span>';
                            break;
                    }
                    return str;
                }
            },
            paymentReason: {field: 'paymentReason', title: '付款事由', width: 150, sort: true, hide: false,templet: function (d) {
                    return d.plbContractPaymentWithBLOBs.paymentReason || ''
                }}

        }

        var TableUIObj = new TableUI('plb_dept_subpayment');


        // 初始化左侧项目
        projectLeft();
        // 节点点击事件
        $(document).on('click', '.con_left ul li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var deptId = $(this).attr('deptId');
            tableShow(deptId);
            $('#leftId').attr('deptId', deptId);
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
                    var contractIds = ''
                    var flag = false
                    checkStatus.data.forEach(function (v, i) {
                        if (v.auditerStatus != '0') {
                            flag = true
                            return false
                        }
                        contractIds += v.contractId + ','
                    })
                    if (flag) {
                        layer.msg('所选数据已提交，不可删除！', {icon: 0, time: 2000});
                        return false;
                    }
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbContractInfo/delContractSettle', {contractIds: contractIds,contractType:'02'}, function (res) {
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
                case 'submit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
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
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '11'}, function (res) {
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
                                newWorkFlow(flowData.flowId, function (res) {
                                    var submitData = {
                                        subpaymentId: approvalData.subpaymentId,
                                        runId: res.flowRun.runId,
                                        auditerStatus: 1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    submitKingDee(approvalData.subpaymentId, approvalData.subpaymentNo, '', function (res) {
                                        // 保存发票影像
                                        $.get('/kingdeeInvoiceUtil/imgSys', {
                                            scanBillNo: approvalData.subpaymentNo,
                                            reimburseId: approvalData.subpaymentId
                                        }, function (res) {
                                            if (res.flag) {
                                                $.ajax({
                                                    url: '/plbDeptSubpayment/approvalSubpayment',
                                                    data: submitData,
                                                    dataType: 'json',
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
                                            } else {
                                                layer.close(loadIndex);
                                                layer.msg(res.msg, {icon: 2});
                                            }
                                        });
                                    });
                                }, approvalData);
                            } else {
                                layer.close(loadIndex);
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    break;
            }
        });
        table.on('tool(tableDemo)', function (obj) {
            contractIds = obj.data.contractId;
            var data = obj.data;
            dataAll = data
            var layEvent = obj.event;
            if (layEvent === 'detail') {
                $('#deptId').attr('deptId', data.deptId)
                newOrEdit(4, data)
            } else if (layEvent === 'edit') {
                if (data.auditerStatus != '0') {
                    layer.msg('该数据已提交，不可进行编辑！', {icon: 0, time: 2000});
                    return false;
                }
                $('#deptId').attr('deptId', data.deptId)
                newOrEdit(1, data)
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
        // 预算执行内部加行按钮
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            deptName: $(this).find('input[name="deptId"]').val(),
                            deptId: $(this).find('input[name="deptId"]').attr('deptId'),
                            totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                            totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                            applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                            amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                            remark: $(this).find('input[name="remark"]').val(),//备注
                            subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId')//主键id
                        }
                        var invoiceNos = '';
                        var invoiceNoStr = '';
                        $(this).find('.invoices_box span').each(function (i, v) {
                            invoiceNos += $(v).attr('fid') + ',';
                            invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
                        });
                        oldDataObj.invoiceNos = invoiceNos;
                        oldDataObj.invoiceNoStr = invoiceNoStr;
                        oldDataArr.push(oldDataObj);
                    });
                    var addRowData = {
                        deptId: $('[name="createUser"]', $('#baseForm')).attr('deptId'),// deptId
                        deptName: $('[name="createUser"]', $('#baseForm')).attr('deptName'),//deptName费用承担部门
                    };
                    oldDataArr.push(addRowData);
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });
        // 预算执行内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.subpaymentListId) {
                    $.get('/plbDeptSubpayment/delPlbMtlSubpaymentList', {subpaymentListIds: data.subpaymentListId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                        cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                        deptName: $(this).find('input[name="deptId"]').val(),
                        deptId: $(this).find('input[name="deptId"]').attr('deptId'),
                        totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                        totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                        applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                        amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                        taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                        remark: $(this).find('input[name="remark"]').val(),//备注
                        subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId')//主键id
                    }
                    var invoiceNos = '';
                    var invoiceNoStr = '';
                    $(this).find('.invoices_box span').each(function (i, v) {
                        invoiceNos += $(v).attr('fid') + ',';
                        invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
                    });
                    oldDataObj.invoiceNos = invoiceNos;
                    oldDataObj.invoiceNoStr = invoiceNoStr;
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });


        // 付款明细内部加行按钮
        table.on('toolbar(paymentTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    var customerid = $('input[name="customerName"]').attr('customerid')
                    if(customerid != '' && customerid != undefined){
                        //遍历表格获取每行数据进行保存
                        var $tr = $('.pym_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
                                collectionUser: '',
                                customerId: '',
                                collectionAccount: $(this).find('input[name="collectionAccount"]').val(),
                                collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                                collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                                collectionMoney: $(this).find('input[name="collectionMoney"]').val(),
                                remarks: $(this).find('input[name="remarks"]').val(),
                                subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')//主键id
                            }
                            //收款人
                            var userName = $(this).find('input[name="collectionUser"]').val()
                            var $user = $(this).find('input[name="collectionUser"]');
                            var userType = $user.attr('userType');
                            if (userType == 2) {
                                oldDataObj.customerName = userName;
                                oldDataObj.customerId = $user.attr('customerId') || '';
                            } else {
                                oldDataObj.collectionUserName = userName;
                                oldDataObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        var a={
                            customerId:customerid
                        }
                        var resd=toAjaxT('/PlbCustomer/queryId',a);
                        var newObj = {
                            customerName: $('input[name="customerName"]').val(),
                            customerId: customerid,
                            paymentType: '02'
                        }
                        if (resd.data && resd.data.plbCustomerBankList) {
                            if(resd.data.plbCustomerBankList.length>1){
                                layer.open({
                                    type: 1,
                                    title: '选择付款方式',
                                    area: ['400px', '500px'],
                                    maxmin: true,
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div class="container" style="padding: 0px 10px">',
                                        '<table id="collectionBank" lay-filter="collectionBank"></table>',
                                        '</div>'].join(''),
                                    success: function () {
                                        // 获取科目
                                        table.render({
                                            elem: '#collectionBank',
                                            data: resd.data.plbCustomerBankList,
                                            page: false,
                                            limit: 10000,
                                            cols: [[
                                                {type: 'radio', title: '选择'},
                                                {field: 'collectionAccount', title: '银行账户'},
                                                {field: 'collectionBankName', title: '开户行'}
                                            ]]
                                        });
                                    },
                                    yes: function (index) {
                                        var checkStatus = table.checkStatus('paymentTypeTable');
                                        if (checkStatus.data.length > 0) {
                                            newObj.collectionAccount = checkStatus.data[0].bankAccount || '';
                                            newObj.collectionBank = checkStatus.data[0].bankOfDeposit || '';
                                            newObj.collectionBankName = checkStatus.data[0].bankOfDepositName || '';
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                })
                            }else{
                                newObj.collectionAccount = resd.data.plbCustomerBankList[0].bankAccount || '';
                                newObj.collectionBank = resd.data.plbCustomerBankList[0].bankOfDeposit || '';
                                newObj.collectionBankName = resd.data.plbCustomerBankList[0].bankOfDepositName || '';
                            }
                        }
                        oldDataArr.push(newObj);
                        table.reload('paymentTable', {
                            data: oldDataArr
                        });
                    }else{
                        layer.msg('请先选择客商');
                        return false
                    }
                    break;
            }
        });

        table.on('toolbar(infoTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.seti_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            settleId: $(this).find('input[name="settleId"]').attr('settleId'),
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'),
                            settleNo: $(this).find('input[name="settleId"]').val(),
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(),
                            settleupMoney: $(this).find('input[name="settleupMoney"]').val(),
                            paidAmount: $(this).find('input[name="paidAmount"]').val(),
                            paymentAmount: $(this).find('input[name="paymentAmount"]').val(),
                            prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                            remark: $(this).find('input[name="remark"]').val()//备注
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    var addRowData = {};
                    oldDataArr.push(addRowData);
                    table.reload('infoTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });

        window.ppp = function(a,d){
            $('.layui-table-click [name="collectionUser"]').val(a)
            $('.layui-table-click [name="collectionUser"]').attr('customerId',d.customerId)
            $('.layui-table-click [name="collectionAccount"]').val(d.bankAccount)
            $('.layui-table-click [name="collectionBank"]').val(d.bankOfDepositName)
            $('.layui-table-click [name="collectionBank"]').attr("collectionbankNo",d.bankOfDeposit);
        }

        // 付款明细内部删行操作
        table.on('tool(paymentTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.subpaymentPaymentId) {
                    $.get('/plbContractInfo/delSubpaymentPayment', {subpaymentPaymentId: data.subpaymentPaymentId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.pym_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                        collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                        collectionBank: $(this).find('[data-field="collectionBank"] .layui-table-cell').text(),//开户行
                        collectionMoney: $(this).find('input[name="collectionMoney"]').val(),//收款金额
                        remarks: $(this).find('input[name="remarks"]').val(),//备注
                        subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')//主键id
                    }
                    //收款人
                    var userName = $(this).find('input[name="collectionUser"]').val()
                    var $user = $(this).find('input[name="collectionUser"]');
                    var userType = $user.attr('userType');
                    if (userType == 2) {
                        oldDataObj.customerName = userName;
                        oldDataObj.customerId = $user.attr('customerId') || '';
                    } else {
                        oldDataObj.collectionUserName = userName;
                        oldDataObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('paymentTable', {
                    data: oldDataArr
                });
            } else if (layEvent === 'choosePay') {
                layer.open({
                    type: 1,
                    title: '选择付款方式',
                    area: ['400px', '500px'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="container" style="padding: 0px 10px">',
                        '<table id="paymentTypeTable" lay-filter="paymentTypeTable"></table>',
                        '</div>'].join(''),
                    success: function () {
                        var data = []

                        $.each(dictionaryObj['PAYMENT_METHOD']['object'], function (k, o) {
                            var obj = {
                                type: k,
                                value: o
                            }
                            data.push(obj);
                        });

                        // 获取科目
                        table.render({
                            elem: '#paymentTypeTable',
                            data: data,
                            page: false,
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'value', title: '付款方式'}
                            ]]
                        });
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('paymentTypeTable');
                        if (checkStatus.data.length > 0) {
                            var payData = checkStatus.data[0];

                            $tr.find('input[name="paymentType"]').val(payData.value);
                            $tr.find('input[name="paymentType"]').attr('paymentType', payData.type);

                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                });
            } else if (layEvent === 'chooseCollectionUser') {
                var userIndex = layer.open({
                    title: false,
                    area: ['300px', '200px'],
                    btn: false,
                    content: '<div>' +
                        '<p style="margin-top: 23px;margin-bottom: 30px;text-align: center;"><button class="layui-btn layui-btn-normal" id="selectUser">组织机构内选择</button></p>' +
                        '<p style="text-align: center;"><button class="layui-btn layui-btn-normal" id="selectCustomer">客商内选择</button></p>' +
                        '</div>',
                    success: function () {
                        $('#selectUser').on('click', function () {
                            layer.close(userIndex);
                            user_id = $tr.find('[name="collectionUser"]').attr('id');
                            $tr.find('[name="collectionUser"]').attr('customerId', '').attr('userType', 1);
                            $.popWindow('/common/selectUser?0');
                        });

                        $('#selectCustomer').on('click', function () {
                            layer.close(userIndex);
                            $tr.find('[name="collectionUser"]').attr('user_id', '').attr('userType', 2);
                            layer.open({
                                type: 2,
                                title: '选择收款人',
                                area: ['70%', '80%'],
                                btn:['确定'],
                                maxmin: true,
                                btnAlign: 'c',
                                content: ['/PlbCustomer/payee'].join(''),
                                success: function () {
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
                                        merchantType = d.data.currentData.typeNo
                                        loadMtlTable(merchantType);
                                    });
                                    function loadMtlTable(merchantType) {
                                        var customerNo = $('[name="customerNo"]', $('#customerQueryForm')).val();
                                        var customerName = $('[name="customerName"]', $('#customerQueryForm')).val();
                                        layTable.render({
                                            elem: '#materialsTable',
                                            url: '/PlbCustomer/getDataByCondition',
                                            where: {
                                                merchantType: merchantType,
                                                customerNo: customerNo,
                                                customerName: customerName
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
                                    $('#customerQueryBtn').on('click', function () {
                                        loadMtlTable(merchantType)
                                    });
                                },
                                yes: function (index,layero) {
                                    $(layero).find("iframe")[0].contentWindow.yesBtn();
                                    //window[layero.find('iframe')[0]['name']];

                                    //document.getElementsByTagName('iframe')[0].contentWindow.yesBtn()
                                    // var checkStatus = layTable.checkStatus('materialsTable');
                                    // if (checkStatus.data.length > 0) {
                                    //     var mtlData = checkStatus.data[0];
                                    //     if(mtlData.plbCustomerBankList != undefined){
                                    //         if (mtlData.plbCustomerBankList.length > 0) {
                                    //             var selectBank = layer.open({
                                    //                 type: 1,
                                    //                 title: '选择银行账户',
                                    //                 shade: 0.3,
                                    //                 area: ['750px', '400px'],
                                    //                 content: '<table id="selectBank" lay-filter="selectBank">\n' +
                                    //                     '  <thead>\n' +
                                    //                     '    <tr>\n' +
                                    //                     '      <th lay-data="{type:\'radio\'}">选择</th>\n' +
                                    //                     '      <th lay-data="{field:\'accountType\', width:100}">账户类型</th>\n' +
                                    //                     '      <th lay-data="{field:\'bankAccount\', width:220}">银行账号</th>\n' +
                                    //                     '      <th lay-data="{field:\'bankOfDepositName\', width:220, sort:true}">开户行</th>\n' +
                                    //                     '      <th lay-data="{field:\'bankOfDeposit\', width:130, sort:true}">银行行号</th>\n' +
                                    //
                                    //                     '    </tr> \n' +
                                    //                     '  </thead>\n' +
                                    //                     function () {
                                    //                         var str = '';
                                    //                         for (var i = 0; i < mtlData.plbCustomerBankList.length; i++) {
                                    //                             str += '<tr>\n' +
                                    //                                 '      <td><input type="radio" name="selectBankName" value="' + i + '"></td>' +
                                    //                                 '      <td>' + function () {
                                    //                                     if (mtlData.plbCustomerBankList[i].accountType == 0) {
                                    //                                         return '基本户'
                                    //                                     } else {
                                    //                                         return '其他户'
                                    //                                     }
                                    //                                 }() + '</td>\n' +
                                    //                                 '      <td>' + mtlData.plbCustomerBankList[i].bankAccount + '</td>\n' +
                                    //                                 '      <td>' + mtlData.plbCustomerBankList[i].bankOfDepositName + '</td>\n' +
                                    //                                 '      <td>' + mtlData.plbCustomerBankList[i].bankOfDeposit + '</td>\n' +
                                    //                                 '    </tr>'
                                    //                         }
                                    //                         return str
                                    //                     }() +
                                    //                     '  <tbody>\n' +
                                    //                     '  </tbody>\n' +
                                    //                     '</table>',
                                    //                 btn: ['确定'],
                                    //                 success: function () {
                                    //                     //转换静态表格
                                    //                     layui.table.init('selectBank', {
                                    //                         limit: mtlData.plbCustomerBankList.length
                                    //                     });
                                    //                 },
                                    //                 yes: function () {
                                    //                     var selectBankData = layui.table.checkStatus('selectBank').data[0];
                                    //                     $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                    //                     $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                    //                     $tr.find('[name="collectionAccount"]').val(selectBankData.bankAccount);
                                    //                     $tr.find('[name="collectionBank"]').val(selectBankData.bankOfDepositName);
                                    //                     $tr.find('[name="collectionBank"]').attr('collectionBankNo', selectBankData.bankOfDeposit);
                                    //                     layer.closeAll();
                                    //                 }
                                    //             })
                                    //         } else {
                                    //             $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                    //             $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                    //             $tr.find('[name="collectionAccount"]').val('');
                                    //             $tr.find('[name="collectionBank"]').val('');
                                    //             $tr.find('[name="collectionBank"]').removeAttr('collectionBankNo');
                                    //             layer.close(index);
                                    //         }
                                    //     }else{
                                    //         $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                    //         $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                    //         $tr.find('[name="collectionAccount"]').val('');
                                    //         $tr.find('[name="collectionBank"]').val('');
                                    //         $tr.find('[name="collectionBank"]').removeAttr('collectionBankNo');
                                    //         layer.close(index);
                                    //     }
                                    //
                                    //
                                    // } else {
                                    //     layer.msg('请选择一项！', {icon: 0});
                                    // }
                                }
                            });
                        });
                    }
                });
            }
        });

        // 结算信息内部删行操作
        table.on('tool(infoTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.dataId) {
                    $.get('/plbContractInfo/delContractSettleData', {dataId: data.dataId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.seti_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        settleId: $(this).find('input[name="settleId"]').attr('settleId'),
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'),
                        settleNo: $(this).find('input[name="settleId"]').val(),
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(),
                        settleupMoney: $(this).find('input[name="settleupMoney"]').val(),
                        paidAmount: $(this).find('input[name="paidAmount"]').val(),
                        paymentAmount: $(this).find('input[name="paymentAmount"]').val(),
                        prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                        remark: $(this).find('input[name="remark"]').val()//备注
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('infoTable', {
                    data: oldDataArr
                });
            }
        });
        //选择收款人内侧查询
        $(document).on('click', '.inSearchCollectionUser', function () {
            var searchParams = {}
            var $seachData = $('.inSearchCollectionUserContent [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            collectionUserTable.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });
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
            cols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#detailBarDemo',
                title: '操作',
                width: 150
            })

            tableIns = table.render({
                elem: '#tableDemo',
                url: '/plbContractInfo/getContractPayment',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-80',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    deptId: deptId,
                    contractType:'02',
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
                parseData: function (res) { //res 即为原始返回的数据
                    if(res.flag == true){
                        return {
                            "code": 0, //解析接口状态
                            "data": res.data, //解析数据列表
                            "msg": res.msg, //解析数据列表
                            "count": res.totleNum //解析数据长度
                        };
                    }else{
                        return {
                            "code": 1, //解析接口状态
                            "msg": '无数据', //解析数据列表
                            "count": res.totleNum //解析数据长度
                        };
                    }
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
            var contractIds = '';
            var con = ''
            var deptId = $('#leftId').attr('deptId');
            if (type == '0') {
                title = '新建合同付款';
                url = '/plbContractInfo/insertContract';
                con = '/plbContractInfo/paymentAddandEdit?type='+ type+'&deptId='+ deptId
            } else if (type == '1') {
                contractIds = data.contractId
                title = '编辑合同付款';
                url = '/plbContractInfo/updatePlbMtlSubsettleup';
                con = '/plbContractInfo/paymentAddandEdit?type='+ type+'&deptId='+ deptId + '&contractId='+contractIds
            } else if (type == 4) {
                contractIds = data.contractId
                title = '查看详情'
                con = '/plbContractInfo/paymentAddandEdit?type='+ type+'&deptId='+ deptId + '&contractId='+contractIds
            }
            layer.open({
                type: 2,
                title: title,
                area: ['100%', '100%'],
                content: con,
                success: function () {

                },
                cancel:function(){
                    tableIns.reload();
                }
            });
        }

        function submitFlow(flowId, approvalData) {
            var loadIndex = layer.load();
            newWorkFlow(flowId, function (res) {
                var submitData = {
                    contractId: approvalData.contractId,
                    runId: res.flowRun.runId,
                    auditerStatus: 1,
                    ifImage: false
                }
                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                // 如果上传了发票
                if ($('.invoice_file').length > 0) {
                    submitData.ifImage = true;
                }
                // 更新状态
                $.post('/plbContractInfo/approvalContract', submitData, function (res) {
                    layer.close(loadIndex);
                    if (res.flag) {
                        if (submitData.ifImage) {
                            // 提交发票状态
                            submitKingDee(approvalData.subpaymentId, approvalData.subpaymentNo, '', function () {
                                layer.closeAll();
                                layer.msg('提交成功!', {icon: 1});
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload()
                            });
                        } else {
                            layer.closeAll();
                            layer.msg('提交成功!', {icon: 1});
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                        }
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                });
            }, approvalData);
        }

        //选择客商单位名称
        $(document).on('click', '.chooseCustomerName', function () {
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
                    '                  <input type="text" name="customerNo" placeholder="客商编号" autocomplete="off" class="layui-input">\n' +
                    '             </div>\n' +
                    '             <div class="layui-col-xs4" style="margin-left: 10px">\n' +
                    '                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                    '             </div>\n' +
                    '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                    '                   <button type="button" class="layui-btn layui-btn-sm inSearchDataCustomer">查询</button>\n' +
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
                    loadMtlTable()
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
                        typeNo = typeNo ? typeNo : '';
                        materialsTable = table.render({
                            elem: '#materialsTable',
                            url: '/PlbCustomer/getDataByCondition',
                            where: {
                                merchantType: typeNo,
                                useFlag: true
                            },
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
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
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

        //选择分包商内侧查询
        $(document).on('click', '.inSearchDataCustomer', function () {
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

        // 点击选合同
        $(document).on('click', '.chooseSubcontract', function () {
            if (!$('#baseForm [name="customerName"]').attr('customerId')) {
                layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                return false
            }
            layer.open({
                type: 1,
                title: '选择合同',
                area: ['70%', '60%'],
                btnAlign: 'c',
                btn: ['确定', '取消'],
                content: ['<div class="layui-form">' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {
                    table.render({
                        elem: '#mtlPlanIdTable',
                        url: '/plbDeptSubcontract/selectAll',
                        where: {
                            deptId: $('#leftId').attr('deptId'),
                            customerId: $('#baseForm [name="customerName"]').attr('customerId')
                        },
                        page: true,
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {field: 'contractName', title: '合同名称', width: 200,},
                            {
                                field: 'contractMoney', title: '合同金额', templet: function (d) {
                                    return d.contractMoney ? keepTwoDecimalFull(d.contractMoney) : '/'
                                }
                            },
                            {
                                field: 'contractPeriod', title: '合同工期',
                            },
                        ]],
                        parseData: function (res) { //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "count": res.totleNum, //解析数据长度
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                },
                yes: function (index) {


                    var checkStatus = table.checkStatus('mtlPlanIdTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];

                        $('#baseForm [name="contractName"]').val(chooseData.contractName)
                        $('#baseForm [name="contractName"]').attr('subcontractId', chooseData.subcontractId)

                        //合同金额
                        $('#baseForm1 [name="contractMoney"]').val(chooseData.contractMoney ? keepTwoDecimalFull(chooseData.contractMoney) : '/')
                        //合同付款条件
                        $('#baseForm1 [name="paymentCondition"]').val(chooseData.paymentCondition || '')
                        //累计已结算金额
                        $('#baseForm1 [name="accumulatedSettlatedAmount"]').val(keepTwoDecimalFull(chooseData.accumulatedSettlatedAmount) || 0)
                        //累计已结算比例
                        $('#baseForm1 [name="cumulativeSettledRatio"]').val(chooseData.cumulativeSettledRatio || '0%')
                        //累计已支付金额
                        $('#baseForm1 [name="accumulatedAmountPaid"]').val(keepTwoDecimalFull(chooseData.accumulatedAmountPaid) || 0)
                        //累计已支付比例
                        $('#baseForm1 [name="cumulativePaidProportion"]').val(chooseData.cumulativePaidProportion || '0%')

                        if(chooseData.subcontractId){
                            $.get('/plbDeptSubcontract/queryId',{subContractId:chooseData.subcontractId},function (res) {
                                if(res.flag){
                                    //比价附件
                                    $('#fileContent2').html(getFileEleStr(res.object.attachment2));
                                    //合同附件
                                    $('#fileContent1').html(getFileEleStr(res.object.attachment));
                                }
                            })
                        }


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });

        // 点击选结算合同
        $(document).on('click', '.chooseSettlement', function () {
            if (!$('.plan_base_info input[name="contractName"]').attr('subcontractId')) {
                layer.msg('请先选择合同！', {icon: 0, time: 2000});
                return false
            }
            layer.open({
                type: 1,
                title: '选择结算单',
                area: ['100%', '100%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-form">' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {

                    laodTable();

                    // 加载表格
                    function laodTable() {
                        table.render({
                            elem: '#managementBudgetTable',
                            url: '/plbDeptSubsettleup/getDataByCondition',
                            where: {
                                deptId: $('#leftId').attr('deptId'),
                                subcontractId: $('.plan_base_info input[name="contractName"]').attr('subcontractId'),
                                auditerStatus: 2//只有审批通过的合同可以选择
                            },
                            cellMinWidth: 120,
                            page: true,
                            limit: 20,
                            parseData: function (res) { //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data, //解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            },
                            request: {
                                limitName: 'pageSize' //每页数据量的参数名，默认：limit
                            },
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'customerName', title: '客商单位名称', width: 150,},
                                {field: 'contractName', title: '合同名称', width: 150,},
                                {
                                    field: 'settleupMoney', title: '本次结算金额', minWidth: 150, templet: function (d) {
                                        return keepTwoDecimalFull(d.settleupMoney) || ''
                                    }
                                },
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('managementBudgetTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];

                        //结算id
                        $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId', chooseData.subsettleupId);

                        // 本次结算金额
                        var settleupMoney = keepTwoDecimalFull(chooseData.settleupMoney) || '';
                        $('.plan_base_info input[name="currentSettlementAmount"]').val(settleupMoney);


                        if(chooseData.subsettleupId){
                            $.get('/plbDeptSubsettleup/queryId',{subsettleupId:chooseData.subsettleupId},function (res) {
                                if(res.flag){
                                    //结算合同附件
                                    $('#fileContent3').html(getFileEleStr(res.data.attachments));
                                }
                            })
                        }

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });

        //选择结算单号
        $(document).on('click', '.rbsItemIdChooses', function () {
            var _this = $(this);
            // var deptId = _this.parents('tr').find('[name="deptId"]').attr('deptId').replace(/,$/,'')
            // if(!deptId){
            //     layer.msg('请选择费用承担部门！', {icon: 0});
            //     return false;
            // }
            layer.open({
                type: 1,
                title: '选择结算单号',
                area: ['60%', '70%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div style="padding: 0px 10px">' +
                '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                '                <div class="layui-col-xs3" style="margin-left: 10px">\n' +
                '                    <input type="text" name="contractNo" placeholder="合同编号" autocomplete="off" class="layui-input">\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                '                    <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                '                </div>\n' +
                '</div>' +
                '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                '</div>'].join(''),
                success: function () {
                    table.render({
                        elem: '#materialsTable',
                        url: '/plbContractInfo/getContractSettle',
                        where: {
                            auditerStatus: 2
                        },
                        // data:[],
                        response: {
                            statusName: 'flag',
                            statusCode: true,
                            msgName: 'msg',
                            countName: 'totleNum',
                            dataName: 'data'
                        },
                        page: {
                            limit: 10,
                            limits: [10, 20, 30]
                        },
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {
                                field: 'contractNo', title: '单据编号', templet: function (d) {
                                    return d.contractNo || ''
                                }
                            },
                            {
                                field: 'customerName',width:300, title: '客商', templet: function (d) {
                                    return d.customerName || '';
                                }
                            },
                            {field: 'contractFee', title: '金额', templet: function (d) {
                                    return d.plbContractSettle.contractFee || '';
                                }},
                            {field: 'createUser', title: '报销人'},
                            {field: 'createTime', title: '原单据日期'}
                        ]]
                    });

                    $(document).on('click', '.inSearchData', function () {
                        var rbsItemName = $('.query_module_in [name="contractNo"]').val()
                        // loadMtlTable(rbsItemName);
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        $.ajax({
                            url: '/plbContractInfo/selectBySettleData',
                            data: {
                                contractId:mtlData.contractId
                            },
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                if (res.flag) {
                                    layer.close(index);
                                    _this.val(res.data.settleNo);
                                    _this.attr('settleId', res.data.settleId);
                                    _this.parents('tr').find('input[name="settleupMoney"]').val(res.data.settleupMoney)
                                    _this.parents('tr').find('input[name="paidAmount"]').val(res.data.paidAmount)
                                    _this.parents('tr').find('input[name="rbsItemId"]').val(res.data.rbsItemName)
                                    _this.parents('tr').find('input[name="rbsItemId"]').attr('rbsItemId', res.data.rbsItemId);
                                }
                            }
                        });
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
        $(document).on('click', '.rbsItemIdChoose', function () {
            var _this = $(this);
            // var deptId = _this.parents('tr').find('[name="deptId"]').attr('deptId').replace(/,$/,'')
            // if(!deptId){
            //     layer.msg('请选择费用承担部门！', {icon: 0});
            //     return false;
            // }
            layer.open({
                type: 1,
                title: '往来科目',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    // '<li id="asd" style="display: inline-block;margin-left: 20px;margin-top: 10px;">预算科目</li><li id="zxc" style="display: inline-block;margin-left: 20px">往来科目</li>',
                    // '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">'+
                    // '        <ul class="layui-tab-title">\n' +
                    // '            <li id="zxc" >往来科目</li>\n' +
                    // '        </ul>',
                    // '</div>'+
                    '<table id="budgetLimitTable" lay-filter="budgetLimitTable"></table>',
                    '</div>'].join(''),
                success: function () {
                    // 获取科目
                    layTable.render({
                        elem: '#budgetLimitTable',
                        url: '/plbRbsItem/selectAll',
                        where: {
                            budgetoccupy: 1
                        },
                        page: {
                            limit: 10,
                            limits: [10, 20, 30]
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
                            {type: 'radio', title: '选择'},
                            {field: 'rbsItemNo', title: 'RBS编号'},
                            {
                                field: 'rbsItemName', title: 'RBS名称', templet: function (d) {
                                    return d.rbsItemName || '';
                                }
                            },
                            {field: 'cbsName', title: 'CBS'}
                        ]]
                    });
                },
                yes: function (index) {
                    var checkStatus = layTable.checkStatus('budgetLimitTable');
                    if (checkStatus.data.length > 0) {
                        layer.close(index);
                        _this.val(checkStatus.data[0].rbsItemName);
                        _this.attr('settleId', checkStatus.data[0].rbsItemId);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
        //本次支付
        $(document).on('blur', '.paymentAmount', function () {
            var _this = $(this);
            if(_this.val() != ''){
                var paymentAmount = _this.val()
            }else{
                var paymentAmount = 0
            }
            if(_this.parents('tr').find('input[name="settleupMoney"]').val() != ''){
                var settleupMoney = _this.parents('tr').find('input[name="settleupMoney"]').val()
            }else{
                var settleupMoney = 0
            }
            if(_this.parents('tr').find('input[name="paidAmount"]').val() != ''){
                var paidAmount = _this.parents('tr').find('input[name="paidAmount"]').val()
            }else{
                var paidAmount = 0
            }
            var prepaidBalance = Number(settleupMoney) - Number(paidAmount) - Number(paymentAmount)
            _this.parents('tr').find('input[name="prepaidBalance"]').val(prepaidBalance)
        });
        $(document).on('click', '.cbsIdChoose', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择',
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
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img">' +
                    '<img style="margin-top: 12%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.cbsNo) {
                            $('.mtl_no_data').hide();
                            $('.mtl_table_box').show();
                            loadMtlTable(currentData.cbsNo);
                        } else {
                            $('.mtl_table_box').hide();
                            $('.mtl_no_data').show();
                        }
                    });

                    loadMtlType();

                    function loadMtlType() {
                        // 获取左侧树
                        $.get('/plbCbsType/getParentList', function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: true,
                                    request: {
                                        name: "cbsName", // 显示的内容
                                        key: "cbsNo", // 节点id
                                        parentId: 'parentCbsNo', // 节点父id
                                        isLeaf: "isLeaf",// 是否有子节点
                                        children: 'childList',
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(cbsNo) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbCbsType/getCbsTypeList',
                            where: {
                                cbsNo: cbsNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-300',
                            cellMinWidth: 100,
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'cbsNo', title: 'CBS编码', width: 200}
                                , {field: 'cbsName', title: 'CBS名称', width: 150}
                                , {
                                    field: 'cbsLevel', title: 'CBS级别', width: 150, templet: function (d) {
                                        return dictionaryObj['CBS_LEVEL']['object'][d.cbsLevel] || ''
                                    }
                                }
                                , {
                                    field: 'cbsUnit', title: 'CBS单位', width: 150, templet: function (d) {
                                        return dictionaryObj['CBS_UNIT']['object'][d.cbsUnit] || ''
                                    }
                                }
                                , {
                                    field: 'controlMode', title: '控制方式', templet: function (d) {
                                        return dictionaryObj['CONTROL_MODE']['object'][d.controlMode] || ''
                                    }
                                },

                            ]],
                            parseData: function (res) {
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data,//解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            },
                            request: {
                                pageName: 'page', //页码的参数名称，默认：page
                                limitName: 'pageSize' //每页数据量的参数名，默认：limit
                            },
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        _this.val(mtlData.cbsName);
                        _this.attr('cbsId', mtlData.cbsId);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });

        //监听本次申请金额
        $(document).on('blur', '.outMoneyItem', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var paymentAmount = 0
            $tr.each(function () {
                paymentAmount = accAdd(paymentAmount, $(this).find('input[name="applicationAmount"]').val())
            });
            //计算本次支付金额
            $('#baseForm [name="payMoney"]').val(keepTwoDecimalFull(paymentAmount))


            //计算不含税金额
            if ($(this).val() && $(this).parents('tr').find('[name="taxAmount"]').val()) {
                var amountExcludingTax = $(this).val() - $(this).parents('tr').find('[name="taxAmount"]').val()
                $(this).parents('tr').find('[name="amountExcludingTax"]').val(amountExcludingTax)
            }

        });

        //监听税额
        $(document).on('blur', '.taxAmountItem', function () {
            //计算不含税金额
            if ($(this).val() && $(this).parents('tr').find('[name="applicationAmount"]').val()) {
                var amountExcludingTax = $(this).parents('tr').find('[name="applicationAmount"]').val() - $(this).val()
                $(this).parents('tr').find('[name="amountExcludingTax"]').val(amountExcludingTax)
            }

        });

        //监听累计已结算金额
        $(document).on('blur', '[name="accumulatedSettlatedAmount"]', function () {
            if ($(this).val() && $('[name="contractMoney"]').val()) {
                $('[name="cumulativeSettledRatio"]').val(keepTwoDecimalFull(($(this).val() / $('[name="contractMoney"]').val()) * 100) + '%')
            }
        });

        //监听累计已支付金额
        $(document).on('blur', '[name="accumulatedAmountPaid"]', function () {
            if ($(this).val() && $('[name="contractMoney"]').val()) {
                $('[name="cumulativePaidProportion"]').val(keepTwoDecimalFull(($(this).val() / $('[name="contractMoney"]').val()) * 100) + '%')
            }
        });

        //点击查询
        $('.searchData').on('click',function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                // 将查询值保存至cookie中
                $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
            })
            tableIns.reload({
                where: searchParams,
                page: {
                    curr: 1
                    //重新从第 1 页开始
                }
            });
        });
        function tJian(){
            $("input[name='contractName']").val('')
            $("input[name='contractNo']").val('')
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

        /*用来得到精确的加法结果
            *说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
            *调用：accAdd(arg1,arg2)
            *返回值：arg1加上arg2的精确结果
        */
        function accAdd(arg1, arg2) {
            var r1, r2, m;
            try {
                r1 = arg1.toString().split(".")[1].length
            } catch (e) {
                r1 = 0
            }
            try {
                r2 = arg2.toString().split(".")[1].length
            } catch (e) {
                r2 = 0
            }
            m = Math.pow(10, Math.max(r1, r2))
            return (arg1 * m + arg2 * m) / m
        }


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

        //减法函数
        function subtr(arg1, arg2) {
            var r1, r2, m, n;
            try {
                r1 = arg1.toString().split(".")[1].length;
            } catch (e) {
                r1 = 0;
            }
            try {
                r2 = arg2.toString().split(".")[1].length;
            } catch (e) {
                r2 = 0;
            }
            m = Math.pow(10, Math.max(r1, r2));
            //last modify by deeka
            //动态控制精度长度
            n = (r1 >= r2) ? r1 : r2;
            return ((arg1 * m - arg2 * m) / m).toFixed(n);
        }


    });
    //判断是否显示空
    function isShowNull(data) {
        if (!!data) {
            return data
        } else {
            return ''
        }
    }
    //判断是否显示空
    function isShowNulls(data) {
        if (data != undefined) {
            return data
        } else {
            return ''
        }
    }

    /**
     * 选人完成回调
     * @param userId 用户id
     */
    function archives(userId) {
        if (userId) {
            getUserInfo(userId.replace(/,$/, ''), function (res) {
                if (res.object && res.object.userExt) {
                    $tr = $('#' + user_id).parents('tr');
                    $tr.find('input[name="collectionAccount"]').val(res.object.userExt.bankCardNumber || '');
                    $tr.find('.collectionBank').text(res.object.userExt.bankDeposit || '');
                }
            });
        }
    }

    /**
     * 根据用户id获取用户信息
     * @param userId
     * @param callback
     */
    function getUserInfo(userId, callback) {
        $.get('/user/findUserByuserId', {userId: userId}, function (res) {
            callback(res);
        });
    }

    //重选费用承担部门后，清空其余对应信息
    function importLeft() {
        $('#' + dept_id).parents('tr').find('[name="rbsItemId"]').val('')
        $('#' + dept_id).parents('tr').find('[name="rbsItemId"]').attr('rbsItemId', '')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').val('')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').attr('cbsId', '')
        $('#' + dept_id).parents('tr').find('.totalAnnualBudget').text('')
        $('#' + dept_id).parents('tr').find('.totalAnnualBalance').text('')
    }
    //同步
    function toAjaxT(url,data) {
        var result;
        $.ajax({
            url:url,
            data:data,
            type: 'post',
            async:false,
            dataType: 'json',
            success: function (res){
                result=res;
            }
        });
        return result;
    }
    function toAjaxTs(url,data) {
        var result;
        $.ajax({
            url:url,
            data:data,
            type: 'get',
            async:false,
            dataType: 'json',
            success: function (res){
                result=res;
            }
        });
        return result;
    }
</script>


<script type="text/javascript" src="/js/planbudget/kingDee.js?20210827.2"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>


</body>
</html>