<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>预付款结算单</title>

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

        .layui-form-radio > i{
            line-height: 28px;!important;
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
            <h2 style="text-align: center;line-height: 35px;">预付款结算单</h2>
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
                <div class="layui-col-xs2" style="margin-left: 15px">
                    <input type="text" name="contractNo" placeholder="单据编号" autocomplete="off" class="layui-input" >
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
        <div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>
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
    var tableIns = null;
    var deptId
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
    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var materialsTable = null;
        var collectionUserTable = null;
        var layTable = layui.table;
        var contractId


        form.render();
        tJian()
        //表格显示顺序
        var colShowObj = {
            // subcontractId: {field: 'subcontractId', title: '合同编号', width: 220, sort: true, hide: false,templet(d){
            //     var contractNo = ''
            //         if(d.contractNo) contractNo = d.contractNo
            //     return contractNo
            //     }},

            contractNo: {field: 'contractNo', title: '合同编号', width: 220, sort: true, hide: false},
            createUser: {field: 'createUser', title: '经办人', width: 130, sort: true, hide: false},
            createTime: {field: 'createTime', title: '报销日期', width: 120, sort: true, hide: false},
            // customerId: {field: 'customerName', title: '客商单位名称', width: 240, sort: true, hide: false},
            advanceMoney: {field: 'contractFee', title: '预付金额', width: 110, sort: true, hide: false,templet:function(d){
                    var advanceMoney
                    if(!d.plbContractAdvance.advanceMoney){
                        advanceMoney = ''
                    }else{
                        advanceMoney = d.plbContractAdvance.advanceMoney
                    }
                    return advanceMoney
                }},
            customerId: {field: 'customerId', title: '客商单位名称', width: 240, sort: true, hide: false,templet:function(d){
                    var customerName = ''
                    if(d.customerName)  customerName = d.customerName
                    return customerName
                }},
            auditerStatus: {field: 'auditerStatus', title: '批准状态', width: 120, sort: true, hide: false,templet: function (d) {
                    var str
                    if(d.auditerStatus=='0'){
                        str = '<span>未提交<span>'
                    }else if(d.auditerStatus=='1'){
                        str = '<span  style="color:orange;cursor: pointer;" class="preview_flow" formUrl="' + (d.fromUrl || '') + '">报销中<span>'
                    }else if(d.auditerStatus=='2'){
                        str = '<span  style="color:green;cursor: pointer;" class="preview_flow" formUrl="' + (d.fromUrl || '') + '">已报销<span>'
                    }else if(d.auditerStatus=='3'){
                        str = '<span  style="color:red;cursor: pointer;" class="preview_flow" formUrl="' + (d.fromUrl || '') + '">已退回<span>'
                    }else if(d.auditerStatus=='4'){
                        str = '<span  style="color:red;cursor: pointer;" class="preview_flow" formUrl="' + (d.fromUrl || '') + '">退扫<span>'
                    }else if(d.auditerStatus=='5'){
                        str = '<span  style="color:red;cursor: pointer;" class="preview_flow" formUrl="' + (d.fromUrl || '') + '">驳回<span>'
                    }else if(d.auditerStatus=='6'){
                        str = '<span  style="color:green;cursor: pointer;" class="preview_flow" formUrl="' + (d.fromUrl || '') + '">已支付<span>'
                    }
                    return str;
                }},
            settlementDescription: {field: 'settlementDescription', title: '结算说明', width: 200, sort: true, hide: false,templet: function(d){
                    var settlementDescription
                    if(d.plbContractAdvance.settlementDescription){
                        settlementDescription = d.plbContractAdvance.settlementDescription
                    }else{
                        settlementDescription = ''
                    }
                    return settlementDescription
                }},
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
                        $.post('/plbContractInfo/delContractSettle', {contractIds: contractIds,contractType:'03'}, function (res) {
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

                                        contractID: contractID,
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
                                                    url: '/plbContractInfo/approvalContract',
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
                case 'export':
                    $('.export_moudle').show()
                    break;
            }
        });
        table.on('tool(tableDemo)', function (obj) {
            contractIds = obj.data.contractId;
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'detail') {
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
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsitemid'), // rbsId
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            deptName: $(this).find('input[name="deptId"]').val(),
                            deptId: $(this).find('input[name="deptId"]').attr('deptId'),
                            totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                            totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                            applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                            // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                            contractListId:$(this).find('input[name="deptId"]').attr('contractListId')
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
                    getUserInfo($.cookie('userId'), function (res) {
                        var addRowData = {
                            deptId: res.object.deptId,
                            deptName: res.object.deptName
                        };
                        oldDataArr.push(addRowData);
                        table.reload('materialDetailsTable', {
                            data: oldDataArr
                        });
                    })
                    // var addRowData = {
                    //     deptId: $('[name="createUser"]', $('#baseForm')).attr('deptId'),// deptId
                    //     deptName: $('[name="createUser"]', $('#baseForm')).attr('deptName'),//deptName费用承担部门
                    // };



                    /*var deptId = $('#leftId').attr('deptId') || $('#deptId').attr('deptId')
                    layer.open({
                        type: 1,
                        title: '选择RBS',
                        area: ['60%', '70%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div style="padding: 0px 10px">' +
                        '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                        '                <div class="layui-col-xs3">\n' +
                        '                    <input type="text" name="cbsName" placeholder="CBS名称" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs3" style="margin-left: 10px">\n' +
                        '                    <input type="text" name="rbsItemName" placeholder="RBS名称" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                        '                    <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                        '                </div>\n' +
                        '</div>' +
                        '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                        '</div>'].join(''),
                        success: function () {
                            loadMtlTable();

                            function loadMtlTable(cbsName, rbsItemName) {
                                table.render({
                                    elem: '#materialsTable',
                                    url: '/plbDeptBudgetItem/getBudgetItemDataByDeptId',
                                    where: {
                                        deptId: deptId,
                                        cbsName: cbsName,
                                        rbsItemName: rbsItemName
                                    },
                                    response: {
                                        statusName: 'flag',
                                        statusCode: true,
                                        msgName: 'msg',
                                        countName: 'totleNum',
                                        dataName: 'obj'
                                    },
                                    page: {
                                        limit: 10,
                                        limits: [10, 20, 30]
                                    },
                                    cols: [[
                                        {type: 'checkbox', title: '选择'},
                                        {
                                            field: 'rbsItemName', title: '预算科目名称', templet: function (d) {
                                                return d.rbsItemName || ''
                                            }
                                        },
                                        {
                                            field: 'cbsName', title: '会计科目名称', templet: function (d) {
                                                return d.plbCbsType ? d.plbCbsType.cbsName : '';
                                            }
                                        },
                                        {field: 'budgetMoney', title: '年度预算总额'},
                                        {field: 'budgetBalance', title: '年度预算余额'}
                                    ]]
                                });
                            }

                            $(document).on('click', '.inSearchData', function () {
                                var cbsName = $('.query_module_in [name="cbsName"]').val()
                                var rbsItemName = $('.query_module_in [name="rbsItemName"]').val()
                                loadMtlTable(cbsName, rbsItemName);
                            });
                        },
                        yes: function (index) {
                            var checkStatus = table.checkStatus('materialsTable');
                            if (checkStatus.data.length > 0) {
                                var trData = checkStatus.data;

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
                                /!*var addRowData = {};
                                oldDataArr.push(addRowData);*!/
                                //具体明细可多选
                                trData.forEach(function (item) {
                                    var addRowData = {
                                        rbsItemId: item.rbsItemId,//rbsId
                                        rbsItemName: item.rbsItemName || '',//rbs名称
                                        cbsId: item.cbsId,// cbsId
                                        cbsName: item.plbCbsType ? item.plbCbsType.cbsName : '',//cbs名称
                                        deptId: $('[name="createUser"]', $('#baseForm')).attr('deptId'),// deptId
                                        deptName: $('[name="createUser"]', $('#baseForm')).attr('deptName'),//deptName费用承担部门
                                        totalAnnualBudget: item.budgetMoney,// 年度预算总额
                                        totalAnnualBalance: item.budgetBalance,// 年度预算余额
                                    }
                                    oldDataArr.push(addRowData)
                                })
                                table.reload('materialDetailsTable', {
                                    data: oldDataArr
                                });

                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });*/
                    break;
            }
        });
        // 预算执行内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del()
                if(data.contractListId){
                    $.get('/plbContractInfo/delContractInfoList', {contractListId: data.contractListId}, function (res) {
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
                                // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                                taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                                subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                                contractListId:$(this).find('input[name="deptId"]').attr('contractListId')
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
                    });
                }else{
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
                            // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
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

            }
        });


        // 付款明细内部加行按钮
        table.on('toolbar(paymentTable)', function (obj) {
            switch (obj.event) {
                case 'add':
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

                    var $tr1 = $('.mtl_info').find('.layui-table-main tr');
                    var money = 0
                    $tr1.each(function () {
                        if ($(this).find('input[name="applicationAmount"]').val()) {
                            money += Number($(this).find('input[name="applicationAmount"]').val());
                        }
                    });
                    var addRowData = {};
                    addRowData.paymentType = '02'
                    addRowData.collectionMoney = money
                    oldDataArr.push(addRowData);
                    table.reload('paymentTable', {
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

                if (data.subpaymentPaymentId) {
                    $.get('/plbDeptSubpayment/delPlbMtlSubpaymentPayment', {subpaymentPaymentId: data.subpaymentPaymentId}, function (res) {
                        obj.del();
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
                    });
                }else{
                    obj.del();
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
                }
                //遍历表格获取每行数据进行保存

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
                width:150,
            })

            tableIns = table.render({
                elem: '#tableDemo',
                url: '/plbContractInfo/getContractAdvance',
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
                    contractType:'03',
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
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
            deptId = $('#leftId').attr('deptId')

            var title = '';
            var url = '/plbContractInfo/newAdvancePayment?type=' + type;
            if (type == 0) {
                title = '新增预付款结算单';
            } else if (type == 1) {
                title = '编辑预付款结算单';
                url += '&contractId=' + data.contractId;
            } else if (type == 4) {
                title = '查看预付款结算单';
                url += '&contractId=' + data.contractId;
            }

            iframeLayerIndex = layer.open({
                type: 2,
                title: title,
                area: ['100%', '100%'],
                content: url,
                cancel:function(){
                    tableIns.reload()

                }
            });



            // var advanceId

            // var deptId = $('#leftId').attr('deptId');
            // if (type == '0') {
            //     title = '新建预付款结算单';
            //     url = '/plbContractInfo/insertContract';
            // } else if (type == '1') {
            //     title = '编辑预付款结算单';
            //     url = '/plbContractInfo/updatePlbMtlSubsettleup';
            // } else if (type == 4) {
            //     title = '查看详情'
            // }
            // layer.open({
            //     type: 1,
            //     title: title,
            //     area: ['100%', '100%'],
            //     btn: ['保存', '提交', '取消'],
            //     btnAlign: 'c',
            //     content: ['<div class="layui-collapse">\n',
            //         /* region 合同付款 */
            //         '  <div class="layui-colla-item">\n' +
            //         '    <h2 class="layui-colla-title">单据编号</h2>\n' +
            //         '    <div class="layui-colla-content layui-show plan_base_info">' +
            //         '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
            //         /* region 第一行 */
            //         '           <div class="layui-row">' +
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">单据编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <input type="text" name="contractNo" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="单据编号">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">客商单位名称</label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <input type="text" name="customerName" autocomplete="off" readonly style="cursor: pointer;background: #e7e7e7" class="layui-input chooseCustomerName" title="客商单位名称">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">合同名称</label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
            //         '                       <input type="text" name="contractName" placeholder="查找合同" readonly autocomplete="off" class="layui-input ' + (type == 4 ? '' : 'chooseSubcontract') + '" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //
            //         '           </div>',
            //         /* endregion */
            //         /* region 第二行 */
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">合同编号</label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <input type="text" readonly name="deptContractNo"  autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //         '       </form>' +
            //         '       <form class="layui-form" id="baseForm1" lay-filter="formTest">',
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">合同金额（元）</label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <input type="text" name="contractFee" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">预付款结算金额</label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <input type="number"  name="advanceMoney" autocomplete="off" class="layui-input">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //         /* endregion */
            //         /* region 第二行 */
            //         '           <div class="layui-row">' +
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">结算期间</label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <input type="text" id="settlementPeriod" name="advancePeriod" readonly autocomplete="off" class="layui-input">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //         '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">结算说明</label>\n' +
            //         '                       <div class="layui-input-block form_block">\n' +
            //         '                       <input type="text" name="settlementDescription" autocomplete="off" class="layui-input">\n' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //         // '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         // '                   <div class="layui-form-item">\n' +
            //         // '                       <label class="layui-form-label form_label">本次结算金额（元）</label>\n' +
            //         // '                       <div class="layui-input-block form_block">\n' +
            //         // '                       <input type="number" name="currentSettlementAmount" readonly style="background: #e7e7e7;display: inline-block;width: 73%" autocomplete="off" class="layui-input">\n' +
            //         // '                     <button type="button" class="layui-btn  layui-btn-sm chooseSettlement">选择结算单</button>' +
            //         // '                       </div>\n' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         '           </div>',
            //         /* endregion */
            //         /* region 第二行 */
            //         // '           <div class="layui-row">' +
            //         // '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         // '                   <div class="layui-form-item">\n' +
            //         // '                       <label class="layui-form-label form_label">本次支付金额（元）</label>\n' +
            //         // '                       <div class="layui-input-block form_block">\n' +
            //         // '                       <input type="number" name="payMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            //         // '                       </div>\n' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         // '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         // '                   <div class="layui-form-item">\n' +
            //         // '                       <label class="layui-form-label form_label">付款事由</label>\n' +
            //         // '                       <div class="layui-input-block form_block">\n' +
            //         // '                       <input type="text" name="paymentReason" autocomplete="off" class="layui-input">\n' +
            //         // '                       </div>\n' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         // '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            //         // '                   <div class="layui-form-item">\n' +
            //         // '                       <label class="layui-form-label form_label">款项性质</label>\n' +
            //         // '                       <div class="layui-input-block form_block">\n' +
            //         // '                       <input type="text" name="naturePayment" autocomplete="off" class="layui-input">\n' +
            //         // '                       </div>\n' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         // '           </div>',
            //         /* endregion */
            //         /* region 第二行 */
            //         // '           <div class="layui-row">' +
            //         // '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            //         // '                   <div class="layui-form-item">\n' +
            //         // '                       <label class="layui-form-label form_label">合同付款条件</label>\n' +
            //         // '                       <div class="layui-input-block form_block">\n' +
            //         // '                       <textarea name="paymentCondition" readonly style="background: #e7e7e7" class="layui-textarea"></textarea>' +
            //         // '                       </div>\n' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         // '               <div class="layui-col-xs4" style="padding: 0 5px;display: none">' +
            //         // '                   <div class="layui-form-item">\n' +
            //         // '                       <label class="layui-form-label form_label">经办人</label>\n' +
            //         // '                       <div class="layui-input-block form_block">\n' +
            //         // '                       <input type="text" name="createUser" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            //         // '                       </div>\n' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         // '               <div class="layui-col-xs4" style="padding: 0 5px;display: none">' +
            //         // '                   <div class="layui-form-item">\n' +
            //         // '                       <label class="layui-form-label form_label">是否分摊</label>\n' +
            //         // '                       <div class="layui-input-block form_block">\n' +
            //         // ' 						<input type="radio" name="ifShare" value="1" title="是">' +
            //         // '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
            //         // '                       </div>\n' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         // '           </div>',
            //         /* endregion */
            //         /* region 第四行 */
            //         '           <div class="layui-row">' +
            //         '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">' +
            //         '                       <label class="layui-form-label form_label">比价附件</label>' +
            //         '                       <div class="layui-input-block form_block">' +
            //         '                           <div class="file_module">' +
            //         '                               <div id="fileContent2" class="file_content"></div>' +
            //         '                           </div>' +
            //         '                       </div>' +
            //         '                   </div>' +
            //         '               </div>' +
            //         '           </div>'+
            //         /* endregion */
            //         /* region 第五行 */
            //         '           <div class="layui-row">' +
            //         '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">' +
            //         '                       <label class="layui-form-label form_label">合同附件</label>' +
            //         '                       <div class="layui-input-block form_block">' +
            //         '                           <div class="file_module">' +
            //         '                               <div id="fileContent1" class="file_content"></div>' +
            //         '                           </div>' +
            //         '                       </div>' +
            //         '                   </div>' +
            //         '               </div>' +
            //         '           </div>'+
            //         /* endregion */
            //         /* region 第四行 */
            //         // '           <div class="layui-row">' +
            //         // '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            //         // '                   <div class="layui-form-item">' +
            //         // '                       <label class="layui-form-label form_label">结算合同附件</label>' +
            //         // '                       <div class="layui-input-block form_block">' +
            //         // '                           <div class="file_module">' +
            //         // '                               <div id="fileContent3" class="file_content"></div>' +
            //         // '                           </div>' +
            //         // '                       </div>' +
            //         // '                   </div>' +
            //         // '               </div>' +
            //         // '           </div>'+
            //         /* endregion */
            //         /* region 第七行 */
            //         '           <div class="layui-row">' +
            //         '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            //         '                   <div class="layui-form-item">\n' +
            //         '                       <label class="layui-form-label form_label">附件</label>' +
            //         '                       <div class="layui-input-block form_block">' +
            //         '<div class="file_module">' +
            //         '<div id="fileContent" class="file_content"></div>' +
            //         '<div class="file_upload_box">' +
            //         '<a href="javascript:;" class="open_file">' +
            //         '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
            //         '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
            //         '</a>' +
            //         '<div class="progress" id="progress">' +
            //         '<div class="bar"></div>\n' +
            //         '</div>' +
            //         '<div class="bar_text"></div>' +
            //         '</div>' +
            //         '</div>' +
            //         '                       </div>\n' +
            //         '                   </div>' +
            //         '               </div>' +
            //         '           </div>',
            //         /* endregion */
            //         '       </form>' +
            //         '    </div>\n' +
            //         '  </div>\n',
            //         /* endregion */
            //         /* region 预算执行明细 */
            //         '  <div class="layui-colla-item">\n' +
            //         '    <h2 class="layui-colla-title">预算执行明细</h2>\n' +
            //         '    <div class="layui-colla-content mtl_info layui-show">' +
            //         '       <div>' +
            //         '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
            //         '      </div>' +
            //         '    </div>\n' +
            //         '  </div>\n' +
            //         /* endregion */
            //         /* region 合同付款明细 */
            //         '  <div class="layui-colla-item">\n' +
            //         '    <h2 class="layui-colla-title">付款明细</h2>\n' +
            //         '    <div class="layui-colla-content pym_info layui-show">' +
            //         '       <div>' +
            //         '           <table id="paymentTable" lay-filter="paymentTable"></table>' +
            //         '      </div>' +
            //         '    </div>\n' +
            //         '  </div>\n' +
            //         /* endregion */
            //         '</div>'].join(''),
            //     success: function () {
            //         //编辑和查看
            //         if(type == 1 || type == 4){
            //             $.ajax({
            //                 url: '/plbContractInfo/getContractAdvanceById?contractId='+contractIds+'',
            //                 dataType: 'json',
            //                 type: 'post',
            //                 success: function (res) {
            //                     contractId = res.data.contractId
            //                     advanceId = res.data.plbContractAdvance.advanceId
            //                     $("input[name='contractFee']").val(res.data.plbContractSettle.contractFee)
            //                     $("input[name='advancePeriod']").val(res.data.plbContractAdvance.advancePeriod)
            //
            //                     $("input[name='deptContractNo']").val(res.data.plbContractAdvance.deptContractNo)
            //                     $("input[name='settlementDescription']").val(res.data.plbContractAdvance.settlementDescription)
            //
            //                     $("input[name='deptContractNo']").val(res.data.plbContractAdvance.deptContractNo)
            //                     $("input[name='settlementDescription']").val(res.data.plbContractAdvance.settlementDescription)
            //                     $("input[name='deptContractNo']").val(res.data.contractNo)
            //                     $("input[name='advanceMoney']").val(res.data.plbContractAdvance.advanceMoney)
            //                     materialDetailsTableData = res.data.plbContractInfoListWithBLOBsList || [];
            //                     paymentTableData = res.data.plbDeptSubpaymentPayments || [];
            //
            //                     //预算执行明细
            //                     var cols = [
            //                         // {type: 'numbers', title: '序号'},
            //                         {
            //                             field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
            //                                 return '<input readonly name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input ' + (type == '4' ? '' : 'choose_dept') + '" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.deptName) + '" contractListId="' + d.contractListId +'">';
            //                             }
            //                         },
            //                         {
            //                             field: 'rbsItemId', title: '预算科目名称', minWidth: 300, templet: function (d) {
            //                                 return '<input name="rbsItemId" readonly ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChoose') + '" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.rbsItemName) + '" rbsItemId="' + d.rbsItemId + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'cbsId',
            //                             title: '会计科目',
            //                             minWidth: 120,
            //                             templet: function (d) {
            //                                 return '<input type="text" name="cbsId" cbsId="' + (d.cbsId || '') + '"   value="' + (d.cbsName || '') + '"  readonly autocomplete="off" class="layui-input ' + (type == '4' ? '' : 'cbsIdChoose') + '" style="height: 100%; cursor: pointer;" >'
            //                             }
            //                         },
            //                         {
            //                             field: 'totalAnnualBudget',
            //                             title: '年度预算总额',
            //                             minWidth: 150,
            //                             templet: function (d) {
            //                                 return '<span class="totalAnnualBudget">' + isShowNull(d.totalAnnualBudget) + '</span>';
            //                             }
            //                         },
            //                         {
            //                             field: 'totalAnnualBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
            //                                 return '<span class="totalAnnualBalance">' + isShowNull(d.totalAnnualBalance) + '</span>';
            //                             }
            //                         },
            //                         {
            //                             field: 'applicationAmount',
            //                             title: '本次支付金额',
            //                             minWidth: 150,
            //                             templet: function (d) {
            //                                 return '<input name="applicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.applicationAmount) + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'taxAmount',
            //                             title: '事项说明',
            //                             minWidth: 150,
            //                             templet: function (d) {
            //                                 return '<input name="taxAmount"  ' + (type == 4 ? 'readonly' : '') + 'pointFlag="1" class="layui-input taxAmountItem KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'amountExcludingTax',
            //                             title: '关联申请单',
            //                             minWidth: 150,
            //                             // templet: function (d) {
            //                             //     return '<input name="amountExcludingTax"  readonly type="number"  class="layui-input input_floatNum KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + isShowNull(d.amountExcludingTax) + '">';
            //                             // }
            //                         },
            //
            //                         {
            //                             field: 'invoices',
            //                             title: '关联工作计划',
            //                             minWidth: 200,
            //                             templet: function (d) {
            //                                 var invoiceStr = '';
            //                                 if (d.invoiceList) {
            //                                     d.invoiceList.forEach(function (item, index) {
            //                                         var invoiceInfo = JSON.parse(item.invoiceInfo);
            //                                         invoiceStr += '<span class="invoice_file ' + invoiceInfo.serialNo + '" fid="' + invoiceInfo.serialNo + '">' + (invoiceInfo.invoiceNo || ('发票' + (index + 1))) + ',</span>';
            //                                     });
            //                                 } else if (d.invoiceNoStr) {
            //                                     var invoiceNoArr = d.invoiceNoStr.replace(/,$/, '').split(',');
            //                                     var fidArr = d.invoiceNos.replace(/,$/, '').split(',');
            //
            //                                     for (var i = 0; i < fidArr.length; i++) {
            //                                         invoiceStr += '<span class="invoice_file ' + fidArr[i] + '" fid="' + fidArr[i] + '">' + invoiceNoArr[i] + ',</span>';
            //                                     }
            //                                 }
            //                                 var str = '';
            //                                 if (type != '4') {
            //                                     str = '<a class="choose_invoices"><i class="layui-icon layui-icon-upload-circle"></i></a>'
            //                                 }
            //                                 return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div>' + str + '</div>';
            //                             }
            //                         }
            //                     ]
            //                     if (type != 4) {
            //                         cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
            //                     }
            //
            //                     table.render({
            //                         elem: '#materialDetailsTable',
            //                         data: materialDetailsTableData,
            //                         toolbar: '#toolbarDemoIn',
            //                         defaultToolbar: [''],
            //                         limit: 1000,
            //                         cols: [cols],
            //                         done: function () {
            //                             if (type == 4) {
            //                                 $('.addRow').hide()
            //                             }
            //                             $('input[name="deptId"]').each(function (i, v) {
            //                                 $(this).attr('id', 'dept_' + i);
            //                             });
            //                         }
            //                     });
            //
            //                     //合同付款明细
            //                     var cols2 = [
            //                         {type: 'numbers', title: '序号'},
            //                         {
            //                             field: 'paymentType',
            //                             title: '付款方式',
            //                             event: 'choosePay',
            //                             minWidth: 150,
            //                             templet: function (d) {
            //                                 var str = dictionaryObj['PAYMENT_METHOD']['object'][d.paymentType] || '';
            //
            //                                 return '<input type="text" name="paymentType" subpaymentPaymentId="' + (d.subpaymentPaymentId || '') + '" readonly paymentType="' + isShowNull(d.paymentType) + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'collectionUser',
            //                             title: '收款人',
            //                             minWidth: 150,
            //                             event: 'chooseCollectionUser',
            //                             templet: function (d) {
            //                                 var str = '';
            //                                 var attr = '';
            //                                 if (d.customerId) {
            //                                     str = isShowNull(d.customerName);
            //                                     attr = 'customerId="' + d.customerId + '" userType="2"';
            //                                 } else {
            //                                     str = isShowNull(d.collectionUserName).replace(/,$/, '');
            //                                     attr = 'user_id="' + (d.collectionUser || '') + '" userType="1"';
            //                                 }
            //
            //                                 return '<input readonly name="collectionUser" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'collectionAccount',
            //                             title: '银行账号',
            //                             minWidth: 150,
            //                             templet: function (d) {
            //
            //                                 return '<input type="text" name="collectionAccount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionAccount) + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'collectionBank',
            //                             title: '开户行',
            //                             minWidth: 150,
            //                             templet: function (d) {
            //                                 return '<input readonly type="text"  name="collectionBank" collectionBankNo="' + d.collectionBank + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.collectionBank).replace(/,$/, '') + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'collectionMoney',
            //                             title: '收款金额',
            //                             minWidth: 150,
            //                             templet: function (d) {
            //
            //                                 return '<input type="text" name="collectionMoney" pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionMoney) + '">';
            //                             }
            //                         },
            //                         {
            //                             field: 'remarks', title: '备注', minWidth: 300, templet: function (d) {
            //
            //                                 return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remarks) + '">';
            //                             }
            //                         }
            //                     ]
            //                     if (type != 4) {
            //                         cols2.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
            //                     }
            //
            //                     table.render({
            //                         elem: '#paymentTable',
            //                         data: paymentTableData,
            //                         toolbar: '#toolbarDemoIn',
            //                         defaultToolbar: [''],
            //                         limit: 1000,
            //                         cols: [cols2],
            //                         done: function () {
            //                             if (type == 4) {
            //                                 $('.addRow').hide()
            //                             }
            //                             $('input[name="collectionUser"]').each(function (i, v) {
            //                                 $(v).attr('id', 'collectionUser' + i);
            //                             });
            //                         }
            //                     });
            //                 }
            //             });
            //         }else{
            //             // 获取主键
            //             $.get('/plbDeptReimburse/getUUID', function (res) {
            //                 contractId = res;
            //             });
            //             $.get('/plbUtil/autoNumber?autoNumber=plbContractAdvance', function (res) {
            //                 $('input[name="contractNo"]').val(res)
            //             });
            //         }
            //         // 获取自动编号
            //
            //         $('.refresh_no_btn').show().on('click', function () {
            //             getAutoNumber({autoNumber: 'plbDeptSubpayment'}, function (res) {
            //                 $('input[name="contractNo"]', $('#baseForm')).val(res);
            //             });
            //         });
            //
            //
            //
            //         fileuploadFn('#fileupload', $('#fileContent'));
            //         // 获取当前登录人信息(经办人)
            //         getUserInfo('', function (res) {
            //             if (res.object) {
            //                 $('[name="createUser"]', $('#baseForm')).attr('user_id', res.object.userId).val(res.object.userName);
            //                 $('[name="createUser"]', $('#baseForm')).attr('deptId', res.object.deptId).attr('deptName', res.object.deptName);
            //                 initKingDee(res.object.userId)
            //             }
            //         });
            //         var materialDetailsTableData = [];
            //         var paymentTableData = [];
            //         //回显数据
            //         if (type == 1 || type == 4) {
            //             //回显是否分摊
            //             $('input[name="ifShare"]').each(function () {
            //                 if ($(this).val() == data.ifShare) {
            //                     $(this).prop('checked', 'checked')
            //                     form.render()
            //                 }
            //             })
            //
            //             subpaymentId = data.subpaymentId
            //             form.val("formTest", data);
            //             materialDetailsTableData = data.plbContractInfoListWithBLOBsList || [];
            //             paymentTableData = data.plbDeptSubpaymentPayments|| [];
            //             // 客商单位id
            //             $('.plan_base_info input[name="customerName"]').attr('customerId', data.customerId || '');
            //             // 合同id
            //             $('.plan_base_info input[name="contractName"]').attr('subcontractId', data.subcontractId || '');
            //             //结算id
            //             $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId', data.subsettleupId || '');
            //
            //             $('.plan_base_info input[name="contractMoney"]').val(data.contractMoney ? keepTwoDecimalFull(data.contractMoney) : '/');
            //             $('.plan_base_info input[name="deptContractNo"]').val(keepTwoDecimalFull(data.deptContractNo));
            //             $('.plan_base_info input[name="accumulatedAmountPaid"]').val(keepTwoDecimalFull(data.accumulatedAmountPaid));
            //             $('.plan_base_info input[name="currentSettlementAmount"]').val(keepTwoDecimalFull(data.currentSettlementAmount));
            //             $('.plan_base_info input[name="payMoney"]').val(keepTwoDecimalFull(data.payMoney));
            //
            //             if (data.attachments && data.attachments.length > 0) {
            //                 var fileArr = data.attachments;
            //                 var str = '';
            //                 for (var i = 0; i < fileArr.length; i++) {
            //                     var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
            //                     var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
            //                     var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
            //                     var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;
            //
            //                     str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
            //                 }
            //                 $('#fileContent').append(str);
            //             }
            //
            //             if(data.subcontractId){
            //                 $.get('/plbDeptSubcontract/queryId',{subContractId:data.subcontractId},function (res) {
            //                     if(res.flag){
            //                         //比价附件
            //                         $('#fileContent2').html(getFileEleStr(res.object.attachment2));
            //                         //合同附件
            //                         $('#fileContent1').html(getFileEleStr(res.object.attachment));
            //                     }
            //                 })
            //             }
            //             if(data.subsettleupId){
            //                 $.get('/plbDeptSubsettleup/queryId',{subsettleupId:data.subsettleupId},function (res) {
            //                     if(res.flag){
            //                         //结算合同附件
            //                         $('#fileContent3').html(getFileEleStr(res.data.attachments));
            //                     }
            //                 })
            //             }
            //
            //             if (type == 4) {
            //                 $('.layui-layer-btn-c').hide()
            //                 $('[name="customerName"]').attr('disabled', 'true')
            //                 $('[name="paymentReason"]').attr('disabled', 'true')
            //                 $('[name="naturePayment"]').attr('disabled', 'true')
            //                 $('.file_upload_box').hide()
            //                 $('.deImgs').hide()
            //                 $('.chooseSettlement').hide()
            //             }
            //
            //             if (data.relationImageUrl) {
            //                 $('#baseForm').parent().append('<button class="layui-btn layui-btn-sm" id="preview">查看发票</button>');
            //                 $('#preview').on('click', function () {
            //                     window.open(data.relationImageUrl + '&userId=' + data.createUser);
            //                 });
            //             }
            //
            //         } else {
            //             var cols = [
            //                 // {type: 'numbers', title: '序号'},
            //                 {
            //                     field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
            //                         return '<input readonly name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input ' + (type == '4' ? '' : 'choose_dept') + '" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.deptName) + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'rbsItemId', title: '预算科目名称', minWidth: 300, templet: function (d) {
            //                         return '<input name="rbsItemId" readonly ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChoose') + '" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.rbsItemName) + '" rbsItemId="' + d.rbsItemId + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'cbsId',
            //                     title: '会计科目',
            //                     minWidth: 120,
            //                     templet: function (d) {
            //                         return '<input type="text" name="cbsId" cbsId="' + (d.cbsId || '') + '"   value="' + (d.cbsName || '') + '"  readonly autocomplete="off" class="layui-input ' + (type == '4' ? '' : 'cbsIdChoose') + '" style="height: 100%; cursor: pointer;" >'
            //                     }
            //                 },
            //                 {
            //                     field: 'totalAnnualBudget',
            //                     title: '年度预算总额',
            //                     minWidth: 150,
            //                     templet: function (d) {
            //                         return '<span class="totalAnnualBudget">' + isShowNull(d.totalAnnualBudget) + '</span>';
            //                     }
            //                 },
            //                 {
            //                     field: 'totalAnnualBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
            //                         return '<span class="totalAnnualBalance">' + isShowNull(d.totalAnnualBalance) + '</span>';
            //                     }
            //                 },
            //                 {
            //                     field: 'applicationAmount',
            //                     title: '本次支付金额',
            //                     minWidth: 150,
            //                     templet: function (d) {
            //                         return '<input name="applicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.applicationAmount) + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'taxAmount',
            //                     title: '事项说明',
            //                     minWidth: 150,
            //                     templet: function (d) {
            //                         return '<input type="text" name="taxAmount"  ' + (type == 4 ? 'readonly' : '') + ' pointFlag="1" class="layui-input taxAmountItem KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'amountExcludingTax',
            //                     title: '关联申请单',
            //                     minWidth: 150,
            //                     // templet: function (d) {
            //                     //     return '<input name="amountExcludingTax"  readonly type="number"  class="layui-input input_floatNum KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + isShowNull(d.amountExcludingTax) + '">';
            //                     // }
            //                 },
            //
            //                 {
            //                     field: 'invoices',
            //                     title: '关联工作计划',
            //                     minWidth: 200,
            //                     templet: function (d) {
            //                         var invoiceStr = '';
            //                         if (d.invoiceList) {
            //                             d.invoiceList.forEach(function (item, index) {
            //                                 var invoiceInfo = JSON.parse(item.invoiceInfo);
            //                                 invoiceStr += '<span class="invoice_file ' + invoiceInfo.serialNo + '" fid="' + invoiceInfo.serialNo + '">' + (invoiceInfo.invoiceNo || ('发票' + (index + 1))) + ',</span>';
            //                             });
            //                         } else if (d.invoiceNoStr) {
            //                             var invoiceNoArr = d.invoiceNoStr.replace(/,$/, '').split(',');
            //                             var fidArr = d.invoiceNos.replace(/,$/, '').split(',');
            //
            //                             for (var i = 0; i < fidArr.length; i++) {
            //                                 invoiceStr += '<span class="invoice_file ' + fidArr[i] + '" fid="' + fidArr[i] + '">' + invoiceNoArr[i] + ',</span>';
            //                             }
            //                         }
            //                         var str = '';
            //                         if (type != '4') {
            //                             str = '<a class="choose_invoices"><i class="layui-icon layui-icon-upload-circle"></i></a>'
            //                         }
            //                         return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div>' + str + '</div>';
            //                     }
            //                 }
            //             ]
            //             if (type != 4) {
            //                 cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
            //             }
            //
            //             table.render({
            //                 elem: '#materialDetailsTable',
            //                 data: materialDetailsTableData,
            //                 toolbar: '#toolbarDemoIn',
            //                 defaultToolbar: [''],
            //                 limit: 1000,
            //                 cols: [cols],
            //                 done: function () {
            //                     if (type == 4) {
            //                         $('.addRow').hide()
            //                     }
            //                     $('input[name="deptId"]').each(function (i, v) {
            //                         $(this).attr('id', 'dept_' + i);
            //                     });
            //                 }
            //             });
            //
            //             //合同付款明细
            //             var cols2 = [
            //                 {type: 'numbers', title: '序号'},
            //                 {
            //                     field: 'paymentType',
            //                     title: '付款方式',
            //                     event: 'choosePay',
            //                     minWidth: 150,
            //                     templet: function (d) {
            //                         var str = dictionaryObj['PAYMENT_METHOD']['object'][d.paymentType] || '';
            //
            //                         return '<input type="text" name="paymentType" subpaymentPaymentId="' + (d.subpaymentPaymentId || '') + '" readonly paymentType="' + isShowNull(d.paymentType) + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'collectionUser',
            //                     title: '收款人',
            //                     minWidth: 150,
            //                     event: 'chooseCollectionUser',
            //                     templet: function (d) {
            //                         var str = '';
            //                         var attr = '';
            //                         if (d.customerId) {
            //                             str = isShowNull(d.customerName);
            //                             attr = 'customerId="' + d.customerId + '" userType="2"';
            //                         } else {
            //                             str = isShowNull(d.collectionUserName).replace(/,$/, '');
            //                             attr = 'user_id="' + (d.collectionUser || '') + '" userType="1"';
            //                         }
            //
            //                         return '<input readonly name="collectionUser" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'collectionAccount',
            //                     title: '银行账号',
            //                     minWidth: 150,
            //                     templet: function (d) {
            //
            //                         return '<input type="text" name="collectionAccount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionAccount) + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'collectionBank',
            //                     title: '开户行',
            //                     minWidth: 150,
            //                     templet: function (d) {
            //                         return '<input readonly type="text"  name="collectionBank" collectionBankNo="' + d.collectionBank + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.collectionBankName).replace(/,$/, '') + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'collectionMoney',
            //                     title: '收款金额',
            //                     minWidth: 150,
            //                     templet: function (d) {
            //
            //                         return '<input type="text" name="collectionMoney" pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionMoney) + '">';
            //                     }
            //                 },
            //                 {
            //                     field: 'remarks', title: '备注', minWidth: 300, templet: function (d) {
            //
            //                         return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remarks) + '">';
            //                     }
            //                 }
            //             ]
            //             if (type != 4) {
            //                 cols2.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
            //             }
            //
            //             table.render({
            //                 elem: '#paymentTable',
            //                 data: paymentTableData,
            //                 toolbar: '#toolbarDemoIn',
            //                 defaultToolbar: [''],
            //                 limit: 1000,
            //                 cols: [cols2],
            //                 done: function () {
            //                     if (type == 4) {
            //                         $('.addRow').hide()
            //                     }
            //                     $('input[name="collectionUser"]').each(function (i, v) {
            //                         $(v).attr('id', 'collectionUser' + i);
            //                     });
            //                 }
            //             });
            //         }
            //         element.render();
            //         form.render();
            //         //日期时间范围
            //         laydate.render({
            //             elem: '#settlementPeriod'
            //             , type: 'datetime'
            //             , range: true
            //         });
            //         //日期时间范围
            //         laydate.render({
            //             //结算期间
            //             elem: '#settlementPeriod',
            //             range: '~',
            //             format: 'yyyy-MM-dd',
            //             value: data ? data.settlementPeriod : ''
            //         });
            //
            //         //年选择器
            //         laydate.render({
            //             elem: '#settleupYear'
            //             , type: 'year'
            //             , trigger: 'click' //采用click弹出
            //             , value: data ? data.settleupYear : ''
            //         });
            //         //预算执行明细
            //
            //
            //
            //         //发票上传
            //         $(document).on('click', '.choose_invoices', function () {
            //             if (subpaymentId) {
            //                 var $this = $(this)
            //                 var $ele = $(this).prev();
            //                 var subpaymentNo = $('input[name="subpaymentNo"]', $('#baseForm')).val();
            //                 openPwyWeb(subpaymentId, subpaymentNo, '', $ele, function (data) {
            //                     var $tr = $this.parents('tr');
            //                     var taxAmount = 0; // 税额合计
            //                     var amount = 0; // 不含税金额合计
            //                     var totalAmount = 0; // 含税金额合计
            //                     data.forEach(function (item) {
            //                         taxAmount = BigNumber(item.taxAmount).plus(taxAmount);
            //                         amount = BigNumber(item.amount).plus(amount);
            //                         totalAmount = BigNumber(item.totalAmount).plus(totalAmount);
            //                     });
            //                     $tr.find('.KD_total_amount').val(totalAmount);
            //                     $tr.find('.KD_tax_amount').val(taxAmount);
            //                     $tr.find('.KD_amount').val(amount);
            //
            //
            //                     var $trs = $('.mtl_info').find('.layui-table-main tr');
            //                     var paymentAmount = 0
            //                     $trs.each(function () {
            //                         paymentAmount = accAdd(paymentAmount, $(this).find('input[name="applicationAmount"]').val())
            //                     });
            //                     //重新计算本次支付金额
            //                     $('#baseForm [name="payMoney"]').val(paymentAmount)
            //                 });
            //             }
            //         });
            //     },
            //     yes: function (index) {
            //         //必填项提示
            //         for (var i = 0; i < $('.testNull').length; i++) {
            //             if ($('.testNull').eq(i).val() == '') {
            //                 layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
            //                 return false
            //             }
            //         }
            //
            //         //本次支付金额不得大于
            //         // （1）合同余额：合同金额-累计已付款（不含本次）
            //         // （2）结算余额：累计结算（含本次）-累计已付款（不含本次）
            //         // （3）预算余额：年度预算-累计已付款（不含本次）
            //         var contractBalance = subtr($('[name="contractMoney"]').val(), $('[name="accumulatedAmountPaid"]').val())
            //         var settleBalance = subtr($('[name="accumulatedSettlatedAmount"]').val(), $('[name="accumulatedAmountPaid"]').val())
            //         var yearBudget = 0
            //         $('.mtl_info').find('.layui-table-main tr').each(function () {
            //             yearBudget = accAdd(yearBudget, $(this).find('.totalAnnualBalance').text())
            //         });
            //         var budgetBalance = subtr(yearBudget, $('[name="accumulatedAmountPaid"]').val())
            //         var thisPayMoney = $('[name="payMoney"]').val()
            //
            //         if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(contractBalance)) {
            //             layer.msg('本次支付金额不得大于合同余额：合同金额-累计已付款（不含本次）', {icon: 0});
            //             return false
            //         }
            //
            //         if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(settleBalance)) {
            //             layer.msg('本次支付金额不得大于结算余额：累计结算（含本次）-累计已付款（不含本次）', {icon: 0});
            //             return false
            //         }
            //
            //         if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(budgetBalance)) {
            //             layer.msg('本次支付金额不得大于预算余额：年度预算-累计已付款（不含本次）', {icon: 0});
            //             return false
            //         }
            //
            //
            //         var loadIndex = layer.load();
            //         //材料计划数据
            //         var datas = $('#baseForm').serializeArray();
            //         var datass = $('#baseForm1').serializeArray();
            //         var obj = {}
            //         obj.contractType = '03'
            //         var plbContractAdvance = {}
            //         datas.forEach(function (item) {
            //             obj[item.name] = item.value
            //         });
            //         datass.forEach(function (item) {
            //             plbContractAdvance[item.name] = item.value
            //         });
            //         //合同id
            //         obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //         //客商单位名称id
            //         obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');
            //
            //         //结算id
            //         obj.subsettleupId = $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId') || '';
            //
            //
            //         obj['plbContractAdvance'] = plbContractAdvance;
            //         obj.plbContractAdvance.advanceMoney = obj.plbContractAdvance.advanceMoney? Number(obj.plbContractAdvance.advanceMoney) : ''
            //         if(advanceId){
            //             obj.plbContractAdvance.advanceId = advanceId
            //         }
            //         // 附件
            //         var attachmentId = '';
            //         var attachmentName = '';
            //         for (var i = 0; i < $('#fileContent .dech').length; i++) {
            //             attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            //             attachmentName += $('#fileContent a').eq(i).attr('name');
            //         }
            //         obj.attachmentId = attachmentId;
            //         obj.attachmentName = attachmentName;
            //         obj.contractType = '03'
            //         obj.contractId = contractId
            //         //预算执行明细数据
            //         var $tr = $('.mtl_info').find('.layui-table-main tr');
            //         var materialDetailsArr = [];
            //         $tr.each(function () {
            //             var materialDetailsObj = {
            //                 rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
            //                 cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
            //                 deptId: $(this).find('input[name="deptId"]').attr('deptId').replace(',',''),
            //                 totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
            //                 totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
            //                 applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
            //                 // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
            //                 taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
            //                 contractInfoId:contractId
            //             }
            //             if ($(this).find('input[name="applicationAmount"]').attr('subpaymentListId')) {
            //                 materialDetailsObj.subpaymentListId = $(this).find('input[name="applicationAmount"]').attr('subpaymentListId');
            //             }
            //             if($(this).find('input[name="deptId"]').attr('contractListId') && $(this).find('input[name="deptId"]').attr('contractListId')!="undefined"){
            //                 materialDetailsObj.contractListId = $(this).find('input[name="deptId"]').attr('contractListId')
            //             }
            //             var invoiceNos = '';
            //             var invoiceNoStr = '';
            //             $(this).find('.invoices_box span').each(function (i, v) {
            //                 invoiceNos += $(v).attr('fid') + ',';
            //                 invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
            //             });
            //             materialDetailsObj.invoiceNos = invoiceNos;
            //             materialDetailsObj.invoiceNoStr = invoiceNoStr;
            //             materialDetailsArr.push(materialDetailsObj);
            //         });
            //         obj.plbContractInfoListWithBLOBsList = materialDetailsArr;
            //
            //         //付款明细数据
            //         var $tr2 = $('.pym_info').find('.layui-table-main tr');
            //         var paymentArr = [];
            //         $tr2.each(function () {
            //             var paymentObj = {
            //                 paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
            //                 collectionUser: '',
            //                 customerId: '',
            //                 collectionAccount: $(this).find('input[name="collectionAccount"]').val(),
            //                 collectionBank: $(this).find('input[name="collectionBank"]').val().replace(',',''),
            //                 collectionMoney: $(this).find('input[name="collectionMoney"]').val(),
            //                 remarks: $(this).find('input[name="remarks"]').val(),
            //                 contractId:contractId
            //             }
            //             if ($(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')) {
            //                 paymentObj.subpaymentPaymentId = $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId');
            //             }
            //             //收款人
            //             var userName = $(this).find('input[name="collectionUser"]').val()
            //             var $user = $(this).find('input[name="collectionUser"]');
            //             var userType = $user.attr('userType');
            //             if (userType == 2) {
            //                 paymentObj.customerName = userName;
            //                 paymentObj.customerId = $user.attr('customerId') || '';
            //             } else {
            //                 paymentObj.collectionUserName = userName;
            //                 paymentObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
            //             }
            //
            //             paymentArr.push(paymentObj);
            //         });
            //         obj.plbDeptSubpaymentPayments = paymentArr;
            //
            //         obj.deptId = parseInt(deptId);
            //
            //         //经办人
            //         // obj.createUser = $('[name="createUser"]', $('#baseForm')).attr('user_id')
            //         //是否分摊
            //         // obj.ifShare = $('input[name="ifShare"]:checked').val() || ''
            //         //判断是否分摊
            //         var flagDeptId = '';
            //         if ($('.choose_dept').length > 0) {
            //             $('.choose_dept').each(function () {
            //                 var id = $(this).attr('deptid') || '';
            //                 if (flagDeptId && id && id != flagDeptId) {
            //                     obj.ifShare = 1;
            //                     return false
            //                 }
            //                 flagDeptId = id;
            //             });
            //         }
            //
            //         $.ajax({
            //             url: url,
            //             data: JSON.stringify(obj),
            //             dataType: 'json',
            //             type: 'post',
            //             async: false,
            //             contentType: "application/json;charset=UTF-8",
            //             success: function (res) {
            //                 layer.close(loadIndex);
            //                 if (res.flag) {
            //                     layer.msg('保存成功！', {icon: 1});
            //                     layer.close(loadIndex);
            //                     tableIns.config.where._ = new Date().getTime();
            //                     layer.closeAll()
            //
            //                     tableIns.reload();
            //                 } else {
            //                     layer.msg(res.msg, {icon: 2});
            //                 }
            //             }
            //         });
            //     },
            //     btn2: function (index, layero) {
            //         if($('input[name="collectionAccount"]').val() == ''){
            //             layer.open({
            //                 type: 1,
            //                 title:['提示', 'background-color:#2b7fe0;color:#fff;'],
            //                 area: ['600px', '250px'],
            //                 shadeClose: true, //点击遮罩关闭
            //                 btn: ['关闭'],
            //                 scrollbar: false,
            //                 content:'<div>' +
            //                     '<h2 style="text-align: center;margin-top: 10px">收款账户不能为空</h2>' +
            //                     '<p style="margin-left: 10px;font-size: 16px">账号信息维护指南：</p>' +
            //                     '<p style="margin-left: 10px">个人：登录综合系统办公-依次点击右上角个人信息图标（右二）-设置-个人资料-账户信息</p>' +
            //                     '<p style="margin-left: 10px">客商：登录综合系统办公-左侧菜单依次选择-预算管理-往来单位-客商管理</p></div>'
            //             })
            //             return
            //         }else{
            //             for (var i = 0; i < $('.testNull').length; i++) {
            //                 if ($('.testNull').eq(i).val() == '') {
            //                     layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
            //                     return false
            //                 }
            //             }
            //
            //             //本次支付金额不得大于
            //             // （1）合同余额：合同金额-累计已付款（不含本次）
            //             // （2）结算余额：累计结算（含本次）-累计已付款（不含本次）
            //             // （3）预算余额：年度预算-累计已付款（不含本次）
            //             var contractBalance = subtr($('[name="contractMoney"]').val(), $('[name="accumulatedAmountPaid"]').val())
            //             var settleBalance = subtr($('[name="accumulatedSettlatedAmount"]').val(), $('[name="accumulatedAmountPaid"]').val())
            //             var yearBudget = 0
            //             $('.mtl_info').find('.layui-table-main tr').each(function () {
            //                 yearBudget = accAdd(yearBudget, $(this).find('.totalAnnualBalance').text())
            //             });
            //             var budgetBalance = subtr(yearBudget, $('[name="accumulatedAmountPaid"]').val())
            //             var thisPayMoney = $('[name="payMoney"]').val()
            //
            //             if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(contractBalance)) {
            //                 layer.msg('本次支付金额不得大于合同余额：合同金额-累计已付款（不含本次）', {icon: 0});
            //                 return false
            //             }
            //
            //             if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(settleBalance)) {
            //                 layer.msg('本次支付金额不得大于结算余额：累计结算（含本次）-累计已付款（不含本次）', {icon: 0});
            //                 return false
            //             }
            //
            //             if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(budgetBalance)) {
            //                 layer.msg('本次支付金额不得大于预算余额：年度预算-累计已付款（不含本次）', {icon: 0});
            //                 return false
            //             }
            //
            //
            //             var loadIndex = layer.load();
            //             //材料计划数据
            //             var datas = $('#baseForm').serializeArray();
            //             var datass = $('#baseForm1').serializeArray();
            //             var obj = {}
            //             obj.contractType = '03'
            //             var plbContractAdvance = {}
            //             datas.forEach(function (item) {
            //                 obj[item.name] = item.value
            //             });
            //             datass.forEach(function (item) {
            //                 plbContractAdvance[item.name] = item.value
            //             });
            //             //合同id
            //             obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //             //客商单位名称id
            //             obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');
            //
            //             //结算id
            //             obj.subsettleupId = $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId') || '';
            //
            //
            //             obj['plbContractAdvance'] = plbContractAdvance;
            //             obj.plbContractAdvance.advanceMoney = obj.plbContractAdvance.advanceMoney? Number(obj.plbContractAdvance.advanceMoney) : ''
            //             if(advanceId){
            //                 obj.plbContractAdvance.advanceId = advanceId
            //             }
            //             // 附件
            //             var attachmentId = '';
            //             var attachmentName = '';
            //             for (var i = 0; i < $('#fileContent .dech').length; i++) {
            //                 attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            //                 attachmentName += $('#fileContent a').eq(i).attr('name');
            //             }
            //             obj.attachmentId = attachmentId;
            //             obj.attachmentName = attachmentName;
            //             obj.contractType = '03'
            //             obj.contractId = contractId
            //             //预算执行明细数据
            //             var $tr = $('.mtl_info').find('.layui-table-main tr');
            //             var materialDetailsArr = [];
            //             $tr.each(function () {
            //                 var materialDetailsObj = {
            //                     rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
            //                     cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
            //                     deptId: $(this).find('input[name="deptId"]').attr('deptId').replace(',',''),
            //                     totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
            //                     totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
            //                     applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
            //                     // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
            //                     taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
            //                     contractInfoId:contractId
            //                 }
            //                 if ($(this).find('input[name="applicationAmount"]').attr('subpaymentListId')) {
            //                     materialDetailsObj.subpaymentListId = $(this).find('input[name="applicationAmount"]').attr('subpaymentListId');
            //                 }
            //                 if($(this).find('input[name="deptId"]').attr('contractListId') && $(this).find('input[name="deptId"]').attr('contractListId')!="undefined"){
            //                     materialDetailsObj.contractListId = $(this).find('input[name="deptId"]').attr('contractListId')
            //                 }
            //                 var invoiceNos = '';
            //                 var invoiceNoStr = '';
            //                 $(this).find('.invoices_box span').each(function (i, v) {
            //                     invoiceNos += $(v).attr('fid') + ',';
            //                     invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
            //                 });
            //                 materialDetailsObj.invoiceNos = invoiceNos;
            //                 materialDetailsObj.invoiceNoStr = invoiceNoStr;
            //                 materialDetailsArr.push(materialDetailsObj);
            //             });
            //             obj.plbContractInfoListWithBLOBsList = materialDetailsArr;
            //
            //             //付款明细数据
            //             var $tr2 = $('.pym_info').find('.layui-table-main tr');
            //             var paymentArr = [];
            //             $tr2.each(function () {
            //                 var paymentObj = {
            //                     paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
            //                     collectionUser: '',
            //                     customerId: '',
            //                     collectionAccount: $(this).find('input[name="collectionAccount"]').val(),
            //                     collectionBank: $(this).find('input[name="collectionBank"]').val().replace(',',''),
            //                     collectionMoney: $(this).find('input[name="collectionMoney"]').val(),
            //                     remarks: $(this).find('input[name="remarks"]').val(),
            //                     contractId:contractId
            //                 }
            //                 if ($(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')) {
            //                     paymentObj.subpaymentPaymentId = $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId');
            //                 }
            //                 //收款人
            //                 var userName = $(this).find('input[name="collectionUser"]').val()
            //                 var $user = $(this).find('input[name="collectionUser"]');
            //                 var userType = $user.attr('userType');
            //                 if (userType == 2) {
            //                     paymentObj.customerName = userName;
            //                     paymentObj.customerId = $user.attr('customerId') || '';
            //                 } else {
            //                     paymentObj.collectionUserName = userName;
            //                     paymentObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
            //                 }
            //
            //                 paymentArr.push(paymentObj);
            //             });
            //             obj.plbDeptSubpaymentPayments = paymentArr;
            //
            //             obj.deptId = parseInt(deptId);
            //
            //             //经办人
            //             // obj.createUser = $('[name="createUser"]', $('#baseForm')).attr('user_id')
            //             //是否分摊
            //             // obj.ifShare = $('input[name="ifShare"]:checked').val() || ''
            //             //判断是否分摊
            //             var flagDeptId = '';
            //             if ($('.choose_dept').length > 0) {
            //                 $('.choose_dept').each(function () {
            //                     var id = $(this).attr('deptid') || '';
            //                     if (flagDeptId && id && id != flagDeptId) {
            //                         obj.ifShare = 1;
            //                         return false
            //                     }
            //                     flagDeptId = id;
            //                 });
            //             }
            //
            //             $.ajax({
            //                 url: url,
            //                 data: JSON.stringify(obj),
            //                 dataType: 'json',
            //                 type: 'post',
            //                 async: false,
            //                 contentType: "application/json;charset=UTF-8",
            //                 success: function (res) {
            //                     layer.close(loadIndex);
            //                     if (res.flag) {
            //                         subpaymentId = res.object
            //                         $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '11'}, function (res) {
            //                             var flowDataArr = []
            //                             $.each(res.data.flowData, function (k, v) {
            //                                 flowDataArr.push({
            //                                     flowId: k,
            //                                     flowName: v
            //                                 });
            //                             });
            //                             obj.subpaymentId = subpaymentId
            //                             var approvalData = obj
            //                             //经办人
            //                             approvalData.createUser = $('[name="createUser"]', $('#baseForm')).val()
            //                             //是否分摊
            //                             approvalData.ifShare = obj.ifShare == '1' ? '是' : '否';
            //
            //                             //遍历表格获取每行数据
            //                             var $trs = $('.mtl_info').find('.layui-table-main tr');
            //                             var dataArr = [];
            //                             $trs.each(function () {
            //                                 var dataObj = {
            //                                     rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
            //                                     rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
            //                                     cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
            //                                     cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
            //                                     deptName: $(this).find('input[name="deptId"]').val(),
            //                                     deptId: $(this).find('input[name="deptId"]').attr('deptId'),
            //                                     totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
            //                                     totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
            //                                     applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
            //                                     // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
            //                                     taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
            //                                     remark: $(this).find('input[name="remark"]').val(),//备注
            //                                     subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId')//主键id
            //                                 }
            //                                 var str = '';
            //                                 str = dataObj.rbsItemName + '`' + dataObj.totalAnnualBudget + '`' + dataObj.totalAnnualBalance + '`' + dataObj.applicationAmount + '`' + dataObj.taxAmount + '`' + dataObj.amountExcludingTax + '`' + dataObj.deptName + '`' + dataObj.remark + '`';
            //                                 dataArr.push(str);
            //                             });
            //                             var budgetDetails = dataArr.join('\r\n');
            //                             budgetDetails += '|`````````';
            //
            //                             approvalData.budgetDetails = budgetDetails
            //
            //
            //                             //遍历付款明细表格获取每行数据
            //                             var $trs = $('.pym_info').find('.layui-table-main tr');
            //                             var paymentArr = [];
            //                             $tr2.each(function () {
            //                                 var paymentObj = {
            //                                     paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
            //                                     collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
            //                                     collectionBank: $(this).find('[data-field="collectionBank"] .layui-table-cell').text(),//开户行
            //                                     collectionMoney: $(this).find('input[name="collectionMoney"]').val(),//收款金额
            //                                     remarks: $(this).find('input[name="remarks"]').val(),//备注
            //                                     subpaymentPaymentId : $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId'),
            //
            //                                 }
            //                                 //收款人
            //                                 var userName = $(this).find('input[name="collectionUser"]').val()
            //                                 var $user = $(this).find('input[name="collectionUser"]');
            //                                 var userType = $user.attr('userType');
            //                                 if (userType == 2) {
            //                                     paymentObj.customerName = userName;
            //                                     paymentObj.customerId = $user.attr('customerId') || '';
            //                                 } else {
            //                                     paymentObj.collectionUserName = userName;
            //                                     paymentObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
            //                                 }
            //
            //                                 var str = '';
            //                                 str = dictionaryObj['PAYMENT_METHOD']['object'][paymentObj.paymentType] + '`' + (paymentObj.customerName || paymentObj.collectionUserName) + '`' + paymentObj.collectionAccount + '`' + paymentObj.collectionBank + '`' + paymentObj.collectionMoney + '`' + paymentObj.remarks + '`';
            //
            //                                 paymentArr.push(str);
            //                             });
            //                             var payDetails = paymentArr.join('\r\n');
            //                             payDetails += '|`````````';
            //
            //                             approvalData.payDetails = payDetails
            //
            //
            //                             if (flowDataArr.length == 1) {
            //                                 submitFlow(flowDataArr[0].flowId, approvalData);
            //                             } else {
            //                                 layer.open({
            //                                     type: 1,
            //                                     title: '选择流程',
            //                                     area: ['70%', '80%'],
            //                                     btn: ['确定', '取消'],
            //                                     btnAlign: 'c',
            //                                     content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
            //                                     success: function () {
            //                                         $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '11'}, function (res) {
            //                                             var flowData = []
            //                                             $.each(res.data.flowData, function (k, v) {
            //                                                 flowData.push({
            //                                                     flowId: k,
            //                                                     flowName: v
            //                                                 });
            //                                             });
            //                                             table.render({
            //                                                 elem: '#flowTable',
            //                                                 data: flowData,
            //                                                 cols: [[
            //                                                     {type: 'radio'},
            //                                                     {field: 'flowName', title: '流程名称'}
            //                                                 ]]
            //                                             })
            //                                         });
            //                                     },
            //                                     yes: function (index) {
            //                                         var checkStatus = table.checkStatus('flowTable');
            //                                         if (checkStatus.data.length > 0) {
            //                                             var flowData = checkStatus.data[0];
            //
            //                                             submitFlow(flowData.flowId, approvalData)
            //
            //                                         } else {
            //                                             layer.msg('请选择一项！', {icon: 0});
            //                                         }
            //                                     }
            //                                 });
            //                             }
            //                         });
            //
            //                     } else {
            //                         layer.msg(res.msg, {icon: 2});
            //                     }
            //                 }
            //             });
            //
            //
            //             return false
            //         }
            //     },
            //     btn3: function (index, layero) {
            //         tableIns.config.where._ = new Date().getTime();
            //         tableIns.reload();
            //     }
            // });
        }

        function submitFlow(flowId, approvalData) {
            var loadIndex = layer.load();
            newWorkFlow(flowId, function (res) {
                var submitData = {
                    contractId:  contractId,
                    runId: res.flowRun.runId,
                    auditerStatus: 1,
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
        //导出事件
        $(document).on('click',function () {
            $('.export_moudle').hide();
        })
        $(document).on('click', '.export_btn',function () {
            var type=$(this).attr('type')
            var fileName='预付款结算单.xlsx'

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
                var loading=layer.load(2)
                $.get('/plbContractInfo/getContractAdvance',function () {
                    soulTable.export(tableIns, {
                        filename: fileName
                    });
                    layer.close(loading)
                })
            }
        })

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

                        //清空选择合同
                        $('#baseForm [name="contractName"]').val('')
                        $('#baseForm [name="contractName"]').attr('subcontractId','')

                        //合同编号
                        $('#baseForm1 [name="deptContractNo"]').val('')
                        $('#baseForm [name="deptContractNo"]').val('')

                        //合同金额
                        $('#baseForm1 [name="contractFee"]').val('')

                        $('#fileContent2').html('');
                        //合同附件
                        $('#fileContent1').html('');

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
                        layer.close(index);
                        var chooseData = checkStatus.data[0];

                        $('#baseForm [name="contractName"]').val(chooseData.contractName)
                        $('#baseForm [name="contractName"]').attr('subcontractId', chooseData.subcontractId)
                        //合同编号
                        $('#baseForm1 [name="deptContractNo"]').val(chooseData.subcontractNo)
                        $('#baseForm [name="deptContractNo"]').val(chooseData.subcontractNo)

                        //合同金额
                        $('#baseForm1 [name="contractFee"]').val(chooseData.contractMoney ? keepTwoDecimalFull(chooseData.contractMoney) : '/')
                        //合同付款条件
                        $('#baseForm [name="paymentCondition"]').val(chooseData.paymentCondition || '')
                        //累计已结算金额
                        $('#baseForm [name="accumulatedSettlatedAmount"]').val(keepTwoDecimalFull(chooseData.accumulatedSettlatedAmount) || 0)
                        //累计已结算比例
                        $('#baseForm [name="cumulativeSettledRatio"]').val(chooseData.cumulativeSettledRatio || '0%')
                        //累计已支付金额
                        $('#baseForm [name="accumulatedAmountPaid"]').val(keepTwoDecimalFull(chooseData.accumulatedAmountPaid) || 0)
                        //累计已支付比例
                        $('#baseForm [name="cumulativePaidProportion"]').val(chooseData.cumulativePaidProportion || '0%')

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

        //选择预算科目名称
        $(document).on('click', '.rbsItemIdChoose', function () {
            var _this = $(this);
            var deptId = _this.parents('tr').find('[name="deptId"]').attr('deptId').replace(/,$/,'')
            if(!deptId){
                layer.msg('请选择费用承担部门！', {icon: 0});
                return false;
            }
            layer.open({
                type: 1,
                title: '选择预算科目名称',
                area: ['60%', '70%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div style="padding: 0px 10px">' +
                '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                '                <div class="layui-col-xs3" style="margin-left: 10px">\n' +
                '                    <input type="text" name="rbsItemName" placeholder="RBS名称" autocomplete="off" class="layui-input">\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                '                    <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                '                </div>\n' +
                '</div>' +
                '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                '</div>'].join(''),
                success: function () {
                    loadMtlTable();

                    function loadMtlTable(rbsItemName) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbDeptBudgetItem/getBudgetItemDataByDeptId',
                            where: {
                                deptId: deptId,
                                rbsItemName: rbsItemName
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'obj'
                            },
                            page: {
                                limit: 10,
                                limits: [10, 20, 30]
                            },
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {
                                    field: 'rbsItemName', title: '预算科目名称', templet: function (d) {
                                        return d.rbsItemName || ''
                                    }
                                },
                                {
                                    field: 'cbsName', title: '会计科目名称', templet: function (d) {
                                        return d.plbCbsType ? d.plbCbsType.cbsName : '';
                                    }
                                },
                                {field: 'budgetMoney', title: '年度预算总额'},
                                {field: 'budgetBalance', title: '年度预算余额'}
                            ]]
                        });
                    }

                    $(document).on('click', '.inSearchData', function () {
                        var rbsItemName = $('.query_module_in [name="rbsItemName"]').val()
                        loadMtlTable(rbsItemName);
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        //预算科目名称
                        _this.val(mtlData.rbsItemName);
                        _this.attr('rbsItemId', mtlData.rbsItemId);
                        //会计科目名称
                        _this.parents('tr').find('[name="cbsId"]').val(mtlData.plbCbsType ? mtlData.plbCbsType.cbsName : '')
                        _this.parents('tr').find('[name="cbsId"]').attr('cbsId', mtlData.cbsId)
                        //年度预算总额
                        _this.parents('tr').find('[data-field="totalAnnualBudget"] .totalAnnualBudget').text(mtlData.budgetMoney)
                        //年度预算余额
                        _this.parents('tr').find('[data-field="totalAnnualBalance"] .totalAnnualBalance').text(mtlData.budgetBalance)

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
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
            // if ($(this).val() && $(this).parents('tr').find('[name="taxAmount"]').val()) {
            //     var amountExcludingTax = $(this).val() - $(this).parents('tr').find('[name="taxAmount"]').val()
            //     $(this).parents('tr').find('[name="amountExcludingTax"]').val(amountExcludingTax)
            // }

        });

        //监听税额
        // $(document).on('blur', '.taxAmountItem', function () {
        //     //计算不含税金额
        //     if ($(this).val() && $(this).parents('tr').find('[name="applicationAmount"]').val()) {
        //         var amountExcludingTax = $(this).parents('tr').find('[name="applicationAmount"]').val() - $(this).val()
        //         $(this).parents('tr').find('[name="amountExcludingTax"]').val(amountExcludingTax)
        //     }
        //
        // });

        // //监听累计已结算金额
        // $(document).on('blur', '[name="accumulatedSettlatedAmount"]', function () {
        //     if ($(this).val() && $('[name="contractMoney"]').val()) {
        //         $('[name="cumulativeSettledRatio"]').val(keepTwoDecimalFull(($(this).val() / $('[name="contractMoney"]').val()) * 100) + '%')
        //     }
        // });

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


        // $(document).on('click', '.preview_flow', function () {
        //     /*var flowId = $(this).attr('flowId'),
        //         runId = $(this).attr('runId');
        //     if (flowId && runId) {
        //         $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
        //     }*/
        //     var formUrl = $(this).attr('formUrl')
        //     if (formUrl) {
        //         if (formUrl.split('')[0] == '/') {
        //             window.open(formUrl)
        //         } else {
        //             window.open('/' + formUrl)
        //         }
        //     }
        // });

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

        $(document).on('click', '.preview_flow', function() {
            var formUrl = $(this).attr('formUrl');
            if (formUrl) {
                $.popWindow(formUrl);
            }
        });

    });
    //判断是否显示空
    function isShowNull(data) {
        if (!!data) {
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
                    $tr.find('input[name="collectionBank"]').val(res.object.userExt.bankDepositName || '');
                    $tr.find('input[name="collectionBank"]').attr('collectionBankNo',res.object.userExt.bankCardNumber || '');
                    // $tr.find('.collectionBank').text(res.object.userExt.bankDeposit || '');

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
</script>


<script type="text/javascript" src="/js/planbudget/kingDee.js?20211022.3"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>


</body>
</html>
