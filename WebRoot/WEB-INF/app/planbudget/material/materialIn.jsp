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
    <title>材料入库</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
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
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?20220210907"></script>

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

        /*选中行样式*/
        .selectTr {
            background: #009688 !important;
            color: #fff !important;
        }

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .layui-col-xs6{
            width: 20%;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">材料入库</h2>
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
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="mtlStockInNo" placeholder="入库单编号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="stockInDate" placeholder="入库日期"  readonly autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="mtlContractName" placeholder="合同名称"  autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="customerName" placeholder="供应商名称"  autocomplete="off" class="layui-input">
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
                <div class="layui-col-xs1" style="margin-top: 3px;text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
<%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
                </div>
                <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>
            </div>
            <div style="position: relative">
                <div class="table_box" style="display: none">
                    <table id="tableDemo" lay-filter="tableDemo"></table>
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

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
        <button class="layui-btn layui-btn-sm" lay-event="dayin">打印模板</button>
    </div>

    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
    </div>
</script>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">选择入库材料</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name=$(this).attr('name')
        $('.query_module [name='+name+']').val($.cookie(name) || '')
    })
    var orgFlag = isOrg("yongli");
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
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        CONTROL_MODE: {},
        CBS_UNIT: {},
        TAX_RATE: {},
        CONTRACT_TYPE: {},
        CONTROL_RULES:{},
        MATERIALIN_TYPE:{}

    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,TAX_RATE,CONTRACT_TYPE,CONTROL_RULES,MATERIALIN_TYPE';
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

    var controlRules = 0;
    $.get('/plbDictonary/getDictionaryByNo', {dictNo: "01",parentNo:"CONTROL_RULES"}, function (res) {
        if (res.flag) {
            controlRules = res.data.controlRules
        }
    });


    var tableIns = null;
    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect', 'layer'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var layer = layui.layer;
        var materialsTable=null

        laydate.render({
            elem: '.query_module [name="stockInDate"]' //指定元素
            , trigger: 'click' //采用click弹出
        });

        form.render();
        //表格显示顺序
        var colShowObj = {
            mtlStockInNo: {field: 'mtlStockInNo', title: '入库单编号', sort: true, hide: false},
            projName:{field:'projName',title:'所属项目',sort:true,hide:false},
            warehouseName: {field: 'warehouseName', title: '仓库', sort: true, hide: false,},
            mtlContractName: {field: 'mtlContractName', title: '合同名称', sort: true, hide: false,},
            customerName: {field: 'customerName', title: '客商单位名称', sort: true, hide: false},
            stockInDate: {
                field: 'stockInDate', title: '入库日期', sort: true, hide: false, templet: function (d) {
                    return format(d.stockInDate);
                }
            },
            stockInAmount: {field: 'stockInAmount', title: '本次入库总金额', sort: true, hide: false},
            stockInTotal: {field: 'stockInTotal', title: '本次入库总数量', sort: true, hide: false},
            currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
            auditerStatus: {
                field: 'auditerStatus',
                title: '审核状态',
                minWidth: 110,
                sort: true,
                hide: false,
                templet: function (d) {
                    var str = '';
                    switch (d.auditerStatus) {
                        case '0':
                            str = '未提交';
                            break;
                        case '1':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
                            break;
                        case '2':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
                            break;
                        case '3':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
                            break;
                    }
                    return str;
                }
            }
        }

        var TableUIObj = new TableUI('plb_mtl_stock_in');


        // 初始化左侧项目
        projectLeft();
        // 上方按钮显示
        table.on('toolbar(tableDemo)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var checkStatusData=table.checkStatus(obj.config.id).data;
            switch (obj.event) {
                case 'add':
                    if($('#leftId').attr('projId')){
                        newOrEdit(0);
                    }else{
                        layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'edit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一项！', {icon: 0});
                        return false
                    }
                    if (checkStatus.data[0].auditerStatus != 0) {
                        layer.msg('该订单已提交，不可编辑！', {icon: 0});
                        return false;
                    }
                    if($('#leftId').attr('projId')){
                        newOrEdit(1, checkStatus.data[0])
                    }else{
                        layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var mtlStockInId = ''
                    var isFlay = false;

                    checkStatus.data.forEach(function (v, i) {
                        mtlStockInId += v.mtlStockInId
                        if(v.auditerStatus&&v.auditerStatus!='0'){
                            isFlay = true
                        }
                    })
                    if(isFlay){
                        layer.msg('已提交不可删除！', {icon: 0});
                        return false
                    }

                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbMtlStockIn/delPlbMtlStockIn', {mtlStockInIds: mtlStockInId}, function (res) {
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
                    if(checkStatus.data[0].auditerStatus != '0'){
                        layer.msg('该数据已提交！', {icon: 0, time: 2000});
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
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '37'}, function (res) {
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
                                approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                newWorkFlow(flowData.flowId, function (res) {
                                    var submitData = {
                                        mtlStockInId:approvalData.mtlStockInId,
                                        runId: res.flowRun.runId,
                                        //auditerStatus:1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/plbMtlStockIn/updateStockIn',
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
                                },approvalData);
                            } else {
                                layer.close(loadIndex);
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    break;
                    case 'dayin':
                        if (checkStatus.data.length != 1) {
                            layer.msg('请选择一条需要打印的数据！', {icon: 0, time: 2000});
                            return false;
                        }
                        if(checkStatus.data[0].auditerStatus != 0){
                            var index=layer.load();
                            var runId=checkStatusData[0].runId;
                            $.ajax({
                                url:'/generateDocx/generateDocxByType?runId='+runId+'&type=mtlStockIn',
                                success:function(res){
                                    if(res.flag){
                                        layer.close(index);
                                        if(res.obj.reportAttachmentList==undefined||res.obj.reportAttachmentList.length<1||res.obj.reportAttachmentList[0]==""){
                                            layer.msg('查询失败请刷新重试！', {icon: 0, time: 2000});
                                            return
                                        }else{
                                            var atturl=res.obj.reportAttachmentList[0].attUrl;
                                            pdurlss(atturl)
                                        }
                                    }else{
                                        layer.close(index);
                                    }

                                }
                            })
                        }else{
                            layer.msg('未提交审批不可打印！', {icon: 0, time: 2000});
                        }
                        break;
            }
        });
        table.on('tool(tableDemo)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if(layEvent === 'detail'){
                newOrEdit(4,data)
            }
        });
        // 监听排序事件
        table.on('sort(tableDemo)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow($('#leftId').attr('projId'))
            })
        });
        // 内部加行按钮
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    // if(!$('#baseForm [name="customerName"]').attr('customerId')){
                    //     layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                    //     return false
                    // }
                    if(!$('#baseForm [name="mtlContractName"]').attr('mtlcontractid')){
                        layer.msg('请先选择合同！', {icon: 0, time: 2000});
                        return false
                    }
                    layer.open({
                        type: 1,
                        title: '选择入库材料',
                        area: ['80%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" style="padding:0px 10px">' +
                        '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                        '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                        '                    <input type="text" name="orderNo" placeholder="订单编号" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                        '                    <input type="text" name="orderNo" placeholder="客商单位" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-left: 10px;">\n' +
                        '                    <input type="text" name="orderNo" placeholder="合同名称" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-top: 3px;padding-left: 10px">\n' +
                        '                    <button type="button" class="layui-btn layui-btn-sm InSearchData">查询</button>\n' +
                        '                </div>\n' +
                        '</div>' +
                        '<div>' +
                        '     <table id="tableDemoIn" lay-filter="tableDemoIn"></table>\n' +
                        '     <div id="downBox">\n' +
                        '         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
                        '      </div>' +
                        '</div>' +
                        '</div>'].join(''),
                        success: function () {
                            table.render({
                                elem: '#tableDemoIn',
                                url: '/plbMtlOrder/queryPlbMtlOrderPlus',
                                cols: [[
                                    {field: 'orderNo', title: '订单编号',},
                                    {field: 'mtlContractName', title: '材料采购合同',},
                                    {field: 'customerName', title: '客商单位名称',},
                                    {field: 'thisPurchaseNum', title: '本次采购订单量合计',},
                                    {field: 'stockIn', title: '已入库数量',},
                                    {field: 'createTime', title: '采购订单日期',templet: function (d) {
                                            return format(d.createTime);
                                        }},
                                ]],
                                // height: 'full-430',
                                page: true,
                                where: {
                                    projId: $('#leftId').attr('projId'),
                                    customerId: $('#baseForm [name="customerName"]').attr('customerId'),
                                    auditerStatusFlag:"true",
                                    mtlContractId:$('#baseForm [name="mtlContractName"]').attr('mtlcontractid'),
                                    isStockIn:"stockIn"
                                },
                                parseData: function (res) { //res 即为原始返回的数据
                                    return {
                                        "code": 0, //解析接口状态
                                        "data": res.object, //解析数据列表
                                        "count": res.totleNum, //解析数据长度
                                    };
                                },
                                request: {
                                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                },
                            });
                        },
                        yes: function (index) {

                            var checkStatus = table.checkStatus('tableDemoInDown'); //获取选中行状态
                            var data = checkStatus.data;  //获取选中行数据

                            //判断是否选择数据
                            if (data.length == 0) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }

                            //遍历表格获取每行数据进行保存
                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $tr.each(function () {
                                var oldDataObj = {
                                    mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                                    mtlLibId: $(this).find('input[name="stockInQuantity"]').attr('mtlLibId'),
                                    mtlOrderLisId: $(this).find('input[name="stockInQuantity"]').attr('mtlOrderLisId'),
                                    mtlContractId: $(this).find('input[name="stockInQuantity"]').attr('mtlContractId'),
                                    mtlUnit: $(this).find('input[name="stockInQuantity"]').attr('mtlUnit'),
                                    mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell span').text(), //材料规格
                                    mtlValuationUnit:$(this).find('input[name="mtlValuationUnit"]').attr('mtlValuationUnit'), //单位
                                    stockInQuantity: $(this).find('input[name="stockInQuantity"]').val(),
                                    taxPeice: $(this).find('input[name="taxPeice"]').val(),
                                    noTaxPeice: $(this).find('input[name="noTaxPeice"]').val(),
                                    taxRate: $(this).find('input[name="taxRate"]').attr('taxRate'),//税率
                                    taxes: $(this).find('input[name="taxes"]').val(),//.attr('taxes'),//税金
                                    checkState: $(this).find('input[name="checkState"]').val(),
                                    remark: $(this).find('input[name="remark"]').val(),
                                    controlType: $(this).find('input[name="controlType"]').attr('controlType'),
                                    purchaseOrderQuantity: $(this).find('input[name="purchaseOrderQuantity"]').val(),//采购订单数量
                                    stockInSum: $(this).find('input[name="stockInSum"]').val(),//已入库数量
                                    quantityTransit: $(this).find('input[name="quantityTransit"]').val(),//在途入库数量
                                    taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                                    noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                                    wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                                    wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                                    rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                                    rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                                    cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                                    cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                                }
                                if ($(this).find('input[name="stockInQuantity"]').attr('stockInListId')) {
                                    oldDataObj.stockInListId = $(this).find('input[name="stockInQuantity"]').attr('stockInListId');
                                }
                                oldDataArr.push(oldDataObj);
                            });
                            //具体明细可多选
                            data.forEach(function (item) {
                                var addRowData={
                                    mtlName: item.planMtlName,
                                    mtlLibId: item.mtlLibId,
                                    mtlOrderLisId: item.mtlOrderLisId,
                                    mtlStandard: item.planMtlStandard,
                                    mtlContractId: $('.selectTr').attr('mtlContractId'),
                                    mtlUnit: item.mtlUnit,
                                    controlType: item.controlType,
                                    taxRate: item.taxRate,
                                    wbsName: item.wbsName,
                                    wbsId: item.wbsId,
                                    rbsName: item.rbsName,
                                    rbsId: item.rbsId,
                                    cbsName: item.cbsName,
                                    cbsId: item.cbsId,
                                    purchaseOrderQuantity: retainDecimal(item.purchaseQuantity,3) || 0,//采购订单数量
                                    stockInSum: retainDecimal(item.stockIn,3) || 0,//已入库数量
                                    // taxPeice: retainDecimal(item.estimatedPrice,3) || 0,//预计单价->含税单价
                                    mtlValuationUnit: item.mtlUnit,//单位
                                    quantityTransit:retainDecimal(item.quantityTransit,3)||0//在途入库数量
                                }
                                oldDataArr.push(addRowData)
                            })
                            table.reload('materialDetailsTable', {
                                data: oldDataArr
                            });
                            layer.close(index)
                        },
                    })
                    break;
            }
        });
        // 内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'del') {
                obj.del();
                if (data.stockInListId) {
                    $.get('/plbMtlStockIn/delChildData', {stockInListIds: data.stockInListId}, function (res) {

                    });
                }
                //重新计算
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var stockInQuantity=0
                var taxPeice=0
                $tr.each(function () {
                    stockInQuantity=accAdd(stockInQuantity,$(this).find('input[name="stockInQuantity"]').val())

                    /*var p1=($(this).find('input[name="stockInQuantity"]').val() || 0) * ($(this).find('input[name="taxPeice"]').val() || 0)*/
                    var p1=mul(($(this).find('input[name="stockInQuantity"]').val() || 0) , ($(this).find('input[name="taxPeice"]').val() || 0))
                    taxPeice=accAdd(taxPeice,p1)
                });
                //计算入库总数量
                $('#baseForm [name="stockInTotal"] ').val(retainDecimal(stockInQuantity,3))
                //计算入库总金额
                $('#baseForm [name="stockInAmount"] ').val(retainDecimal(taxPeice,2))

                //计算含税总价和不含税总价
                if($(this).val() && $(this).parents('tr').find('[name="taxPeice"]').val()){
                    // $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="taxPeice"]').val(),2))
                    $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="taxPeice"]').val()),2))
                }
                if($(this).val() && $(this).parents('tr').find('[name="noTaxPeice"]').val()){
                    // $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="noTaxPeice"]').val(),2))
                    $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="noTaxPeice"]').val()),2))
                }

                //计算税金
                // var taxes=$(this).parents('tr').find('[name="taxMoney"]').val() - $(this).parents('tr').find('[name="noTaxMoney"]').val()
                var taxes=sub($(this).parents('tr').find('[name="taxMoney"]').val() , $(this).parents('tr').find('[name="noTaxMoney"]').val())
                $(this).parents('tr').find('[name="taxes"]').val(retainDecimal(taxes,2))

            }
        });
        //监听行单击事件
        table.on('row(tableDemoIn)', function (obj) {
            // console.log(obj.data) //得到当前行数据
            var data = obj.data
            $('#downBox').show()
            obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
            obj.tr.attr('mtlContractId',data.mtlContractId)
            tableShowDown(data.melOrderId)
        });

        //订单明细表格
        function tableShowDown(melOrderId) {
            table.render({
                elem: '#tableDemoInDown',
                url: '/plbMtlOrder/getListDataByIdMelOrderId',
                cellMinWidth:150,
                cols: [[
                    {type: 'checkbox'},
                    {field: 'wbsName', title: 'WBS',},
                    {field: 'rbsName', title: 'RBS',width:200},
                    {field: 'cbsName', title: 'CBS',width:200},
                    {field: 'planMtlName', title: '材料名称',},
                    {field: 'planMtlStandard', title: '材料规格'},
                    {field: 'cbsUnit', title: '单位',templet: function (d) {
                        // if(d.controlType!=undefined&&d.controlType=="01"){
                        //     return dictionaryObj['CBS_UNIT']['object'][d.mtlUnit] || ''
                        // }else{
                        //     return dictionaryObj['MTL_VALUATION_UNIT']['object'][d.mtlUnit] || ''
                        // }
                            return dictionaryObj['CBS_UNIT']['object'][d.mtlUnit] || ''
                       }
                    },
                   /* {field: 'taxRate', title: '税率',templet: function (d) {
                            return dictionaryObj['TAX_RATE']['object'][d.taxRate] || ''
                        }},
                    // {field: 'mtlTotal', title: '材料库存量',},
                    {field: 'directUnitPrice', title: '材料指导价',},*/
                    {field: 'purchaseQuantity', title: '本次采购订单量',},
                    {field: 'stockIn', title: '已入库数量',},
                    {field: 'createTime', title: '采购订单日期',templet: function (d) {
                            return format(d.createTime);
                        }},
                 /*   {
                        field: 'stockInStatus', title: '入库状态', templet: function (d) {
                            if (d.stockInStatus == 0) {
                                return '未完成入库'
                            } else if (d.stockInStatus == 1) {
                                return '已完成入库'
                            } else {
                                return ''
                            }
                        }
                    }*/
                ]],
                // height: 'full-430',
                page: true,
                where: {
                    melOrderId: melOrderId,
                    isStockIn:"stockIn"
                },
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
            });
        }

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
                    });
                    TableUIObj.init(colShowObj,function () {
                        // tableShow('')
                    });
                }
            });
        }

        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            var currentData = d.data.currentData;
            if (currentData.projId) {
                $('#leftId').attr('projId', currentData.projId);
                $('.no_data').hide();
                $('.table_box').show();
                tableShow(currentData.projId);
            } else {
                $('.table_box').hide();
                $('.no_data').show();
            }
        });

        // 渲染表格
        function tableShow(projId) {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)

            cols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#detailBarDemo',
                title: '操作',
                width: 100
            })

            tableIns = table.render({
                elem: '#tableDemo',
                url: '/plbMtlStockIn/getDataByCondition',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                // height: 'full-80',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    projId: projId,
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
            var title = '';
            var url = '';
            var projId = $('#leftId').attr('projId');
            $('#leftId').attr('_type',type);
            if (type == '0') {
                title = '新建材料入库';
                url = '/plbMtlStockIn/addPlbMtlStockIn';
            } else if (type == '1') {
                title = '编辑材料入库';
                url = '/plbMtlStockIn/updatePlbMtlStockIn';
            }else if(type == '4'){
                title = '查看详情'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: type != '4'?['保存','提交审批', '取消']:['确定'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse disabledAll">\n' +
                /* region 材料计划 */
                '  <div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title">基本信息</h2>\n' +
                '    <div class="layui-colla-content layui-show plan_base_info">' +
                '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
                /* region 第一行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">入库单编号<a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="mtlStockInNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input" style="cursor: pointer;background: #e7e7e7">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">仓库<span field="warehouseId" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <select name="warehouseId"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">合同<span field="mtlContractName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                '                       <input type="text" name="mtlContractName" placeholder="请选择合同" readonly autocomplete="off" class="layui-input chooseManagementBudget" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
                '                       </div>\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">客商单位名称<span field="customerName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="customerName" readonly autocomplete="off" placeholder="供应商" class="layui-input chooseCustomerName" style="cursor: pointer;background: #e7e7e7">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                /* endregion */
                /* region 第二行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">本次入库总金额</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="number" name="stockInAmount" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">本次入库总数量</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="number" name="stockInTotal" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">业务日期<span field="businessDate" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="businessDate" readonly id="businessDate" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">入库日期<span field="stockInDate" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="stockInDate" readonly id="stockInDate" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">入库类型<span field="materialInType" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                           <select name="materialInType" id="materialInType" lay-filter="test">\n' +
                '                           </select>\n' +
                '                       </div>\n' +
                '                   </div>\n' +
                '               </div>\n' +
                '           </div>' +
                /* endregion */
                /* region 第三行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">备注</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="demo"  autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                /* endregion */
                /* region 第四行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                //'                       <label class="layui-form-label form_label">附件</label>' +
                '                       <div class="layui-input-block form_block">' +
                '<div class="file_module">' +
                '<div id="fileContent" class="file_content"></div>' +
                '<div class="file_upload_box">' +
                '<a href="javascript:;" class="open_file">' +
                '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件'+function (){if(orgFlag){return "<span field=\"attachmentId\" class=\"field_required\">*</span>"}else{return ""}}()+'</span>' +
                '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                '</a>' +
                '<div class="progress" id="progress">' +
                '<div class="bar"></div>\n' +
                '</div>' +
                '<div class="bar_text"></div>' +
                '</div>' +
                '</div>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                /* endregion */
                '       </form>' +
                '    </div>\n' +
                '  </div>\n' +
                /* endregion */
                /* region 材料明细 */
                '  <div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title">入库明细</h2>\n' +
                '    <div class="layui-colla-content mtl_info layui-show">' +
                '       <div>' +
                '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                '      </div>' +
                '    </div>\n' +
                '  </div>\n' +
                /* endregion */
                '</div>'].join(''),
                success: function () {
                    //回显项目名称
                    getProjName('#projectName',projId?projId:data.projId)
                    fileuploadFn('#fileupload', $('#fileContent'));

                    //入库类型
                    $('[name="materialInType"]').append(dictionaryObj['MATERIALIN_TYPE']['str']);
                    form.render();
                    var materialDetailsTableData = [];
                    //回显数据
                    if (type == 1 || type == 4) {
                        form.val("formTest", data);
                        $('[name="customerName"]').attr('customerId',data.customerId)
                        //合同id
                        $('#baseForm input[name="mtlContractName"]').attr('mtlContractId',data.mtlContractId || '');

                        //附件
                        if (data.attachments && data.attachments.length > 0) {
                            var fileArr = data.attachments;
                            $('#fileContent').append(echoAttachment(fileArr));
                        }

                        materialDetailsTableData = data.plbMtlStockInLists;

                        //查看详情
                        if(type==4){
                            //$('.layui-layer-btn-c').hide()
                            $('[name="warehouseId"]').attr('disabled','true')
                            $('[name="customerName"]').attr('disabled','true')
                            $('#stockInDate').attr('disabled','true')
                            $('[name="mtlContractName"]').attr('disabled',true);
                            $('.deImgs').hide();
                            $('.file_upload_box').hide();
                            $('[name="materialInType"]').attr('disabled',true);
                            $('[name="demo"]').attr('disabled',true);
                        }
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbMtlStockIn'}, function(res) {
                            $('input[name="mtlStockInNo"]', $('#baseForm')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbMtlStockIn'}, function(res) {
                                $('input[name="mtlStockInNo"]', $('#baseForm')).val(res);
                            });
                        });
                    }

                    $.get('/plbWarehouse/selectAll', {useFlag: false,projId:projId}, function (res) {
                        var obj=res.obj
                        if (res.flag) {
                            var warehouseStr='<option value=""></option>'
                            obj.forEach(function (item,index) {
                                warehouseStr+='<option value=' + item.warehouseId + '>' + item.warehouseName + '</option>'
                            })
                            $('select[name="warehouseId"]').html(warehouseStr)
                            form.render()
                            //回显仓库下拉框
                            if(type == 1||type==4){
                                $('select[name="warehouseId"]').val(data.warehouseId)
                                form.render()
                            }
                        }
                    });

                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#businessDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.businessDate) : ""
                    });
                    laydate.render({
                        elem: '#stockInDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.stockInDate) : ''
                    });
                    var cols=[
                        {field: 'wbsName', title: 'WBS', width: 170,templet: function (d) {
                                return '<span wbsId="'+(d.wbsId || '')+'">'+(d.wbsName || '')+'</span>'
                            }},
                        {field: 'rbsName', title: 'RBS', width: 200,templet: function (d) {
                                return '<span rbsId="'+(d.rbsId || '')+'">'+(d.rbsName || '')+'</span>'
                            }},
                        {field: 'cbsName', title: 'CBS', width: 200,templet: function (d) {
                                return '<span cbsId="'+(d.cbsId || '')+'">'+(d.cbsName || '')+'</span>'
                            }},
                        {field: 'mtlName', title: '材料名称', width: 200,},
                        {field: 'mtlStandard', title: '材料规格', width: 100,templet: function (d) {
                                return '<span>'+(d.mtlStandard || '')+'</span>'
                            }},
                        {
                            field: 'mtlValuationUnit', title: '计量单位', width: 90, templet: function (d) {
                                // if(d.controlType!=undefined&&d.controlType=="01"){
                                //     return '<input type="text" name="mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '') + '">'
                                // }else{
                                //     return '<input type="text" name="mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.mtlValuationUnit] || '') + '">'
                                // }
                                return '<input type="text" name="mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '') + '">'
                            }
                        },
                        // {field: 'controlType', title: '控制方式', width: 100,templet: function (d) {
                        //         return '<input type="text" name="controlType" controlType="'+(d.controlType || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CONTROL_MODE']['object'][d.controlType] || '') + '">'
                        //     }},
                        {
                            field: 'purchaseOrderQuantity', title: '采购订单数量', width: 150, templet: function (d) {
                                return '<input type="number" name="purchaseOrderQuantity" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.purchaseOrderQuantity || '0') + '">'
                            }
                        },
                        {
                            field: 'stockInSum', title: '已入库数量', width: 150, templet: function (d) {
                                return '<input type="number" name="stockInSum" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.stockInSum || '0') + '">'
                            }
                        },
                        {
                            field: 'quantityTransit', title: '在途入库数量', width: 150, templet: function (d) {
                                return '<input type="number" name="quantityTransit" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.quantityTransit || '0') + '">'
                            }
                        },
                        {
                            field: 'stockInQuantity', title: '本次入库数量*', width: 150,
                            templet: function (d) {
                                return '<input type="number" name="stockInQuantity" '+(type==4 ? 'readonly' : '')+' mtlLibId="' + (d.mtlLibId || '') + '" mtlOrderLisId="'+(d.mtlOrderLisId || '')+'"  mtlContractId="'+(d.mtlContractId || '')+'" mtlUnit="'+(d.mtlUnit || '')+'" stockInListId="' + (d.stockInListId || '') + '"  class="layui-input stockInQuantityItem" style="height: 100%;" value="' + (d.stockInQuantity ? retainDecimal(d.stockInQuantity,3) : '') + '">'
                            }
                        },
                        {
                            field: 'taxPeice', title: '含税单价*', width: 150, templet: function (d) {
                                return '<input type="number" name="taxPeice" '+(type==4 ? 'readonly' : '')+'  class="layui-input taxPeiceItem" style="height: 100%;" value="' + (d.taxPeice ? retainDecimal(d.taxPeice,3) : '') + '">'
                            }
                        },
                        {field:'isAllStockIn',align:'center',title:'是否全部入库',width:130,templet:function(d){
                                if(d.isAllStockIn==1||d.isAllStockIn=="1"){
                                    return ' <div class="layui-form-item">\n' +
                                        '    <div class="layui-input-block" style="margin: 0">\n' +
                                        '      <input type="checkbox" name="close" isOpen="1" lay-skin="switch" lay-text="是|否">\n' +
                                        '    </div>\n' +
                                        '  </div>'
                                }else{
                                    return ' <div class="layui-form-item">\n' +
                                        '    <div class="layui-input-block" style="margin: 0">\n' +
                                        '      <input type="checkbox" name="close" isOpen="0"  checked="" lay-skin="switch" lay-text="是|否">\n' +
                                        '    </div>\n' +
                                        '  </div>'
                                }
                            }
                        },
                        {
                            field: 'noTaxPeice', title: '不含税单价', width: 150, templet: function (d) {
                                return '<input type="number" name="noTaxPeice" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.noTaxPeice || '') + '">'
                            }
                        },
                        {
                            field: 'taxMoney', title: '含税总价', width: 150, templet: function (d) {
                                return '<input type="number" name="taxMoney" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.taxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'noTaxMoney', title: '不含税总价', width: 150, templet: function (d) {
                                return '<input type="number" name="noTaxMoney" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.noTaxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'taxRate', title: '税率', width: 100, templet: function (d) {
                                return '<input type="number" name="taxRate" taxRate="'+(d.taxRate || '')+'" readonly class="layui-input taxRateItem" style="height: 100%;background: #e7e7e7" value="' +(dictionaryObj['TAX_RATE']['object'][d.taxRate] || '')+ '">' //
                            }
                        },
                        {
                            field: 'taxes', title: '税金', width: 150, templet: function (d) {
                                return '<input type="number" name="taxes" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.taxes || '') + '">'
                            }
                        },
                        {
                            field: 'checkState', title: '质量验收情况', width: 150, templet: function (d) {
                                return '<input type="text" name="checkState" '+(type==4 ? 'readonly' : '')+' class="layui-input" style="height: 100%;" value="' + (d.checkState || '') + '">'
                            }
                        },
                        {
                            field: 'remark', title: '备注', width: 150, templet: function (d) {
                                return '<input type="text" name="remark" '+(type==4 ? 'readonly' : '')+' class="layui-input" style="height: 100%;" value="' + (d.remark || '') + '">'
                            }
                        },
                    ]
                    if(type!=4){
                        cols.push(
                            {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                            )
                    }

                    table.render({
                        elem: '#materialDetailsTable',
                        data: materialDetailsTableData,
                        toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done:function () {
                            if(type==4){
                                $('.addRow').hide()
                                $("input[name='close']").attr("disabled",true);
                            }
                            form.on('switch',function(data){
                                var switchChecked=data.elem.checked
                                if(switchChecked){
                                    $(data.elem).attr("isOpen",'0');
                                }else{
                                    $(data.elem).attr("isOpen",'1');
                                }
                            })
                        }
                    });
                },
                yes: function (index) {
                    if(type!='4'){
                        var lock=false
                        //材料计划数据
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value
                        });
                        // obj.warehouseId=parseInt($('#baseForm [name="warehouseId"]').val())
                        //客商单位名称的id
                        obj.customerId=$('#baseForm [name="customerName"]').attr('customerId')
                        //合同id
                        obj.mtlContractId = $('#baseForm input[name="mtlContractName"]').attr('mtlContractId') || '';

                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent a').eq(i).attr('name');
                        }
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;

                        // 判断必填项
                        var requiredFlag = false;
                        $('#baseForm').find('.field_required').each(function(){
                            var field = $(this).attr('field');
                            if (!obj[field]) {
                                var fieldName = $(this).parent().text().replace('*', '');
                                layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                                requiredFlag = true;
                                return false;
                            }
                        });
                        if (requiredFlag) {
                            return false;
                        }
                        //入库明细数据
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var materialDetailsArr = [];
                        $tr.each(function () {
                            if($(this).find('input[name="stockInQuantity"]').val() == ''){
                                layer.msg('请填写本次入库数量！', {icon: 0});
                                lock=true
                                return false
                            }
                            if($(this).find('input[name="taxPeice"]').val() == ''){
                                layer.msg('请填写含税单价！', {icon: 0});
                                lock=true
                                return false
                            }

                            var sum=($(this).find('input[name="purchaseOrderQuantity"]').val())*(1+controlRules/100);
                            if(sum < accAdd(accAdd(Number($(this).find('input[name="stockInQuantity"]').val()),Number($(this).find('input[name="quantityTransit"]').val())),Number($(this).find('input[name="stockInSum"]').val()))){
                                layer.msg('本次入库数量大于采购订单数量，无法提交！', {icon: 0});
                                lock=true
                                return false
                            }

                            var materialDetailsObj = {
                                mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                                mtlLibId: $(this).find('input[name="stockInQuantity"]').attr('mtlLibId'),
                                mtlOrderLisId: $(this).find('input[name="stockInQuantity"]').attr('mtlOrderLisId'),
                                mtlContractId: $(this).find('input[name="stockInQuantity"]').attr('mtlContractId'),
                                mtlUnit: $(this).find('input[name="stockInQuantity"]').attr('mtlUnit'),
                                mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell span').text(), //材料规格
                                mtlValuationUnit:$(this).find('input[name="mtlValuationUnit"]').attr('mtlValuationUnit'), //单位
                                controlType:$(this).find('input[name="controlType"]').attr('controlType'), //单位
                                stockInQuantity: $(this).find('input[name="stockInQuantity"]').val(),
                                taxPeice: $(this).find('input[name="taxPeice"]').val(),
                                noTaxPeice: $(this).find('input[name="noTaxPeice"]').val(),
                                taxRate: $(this).find('input[name="taxRate"]').attr('taxRate'),//税率
                                taxes: $(this).find('input[name="taxes"]').val(),//attr('taxes'),//税金
                                checkState: $(this).find('input[name="checkState"]').val(),
                                remark: $(this).find('input[name="remark"]').val(),
                                purchaseOrderQuantity: $(this).find('input[name="purchaseOrderQuantity"]').val(),//采购订单数量
                                stockInSum: $(this).find('input[name="stockInSum"]').val(),//已入库数量
                                quantityTransit: $(this).find('input[name="quantityTransit"]').val(),//在途入库数量
                                taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                                noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                                wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                                wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                                rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                                rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                                cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                                cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                                stockInPrice:$(this).find('input[name="taxPeice"]').val(),
                                isAllStockIn: $(this).find('input[name="close"]').attr("isOpen")      //是否全部入库
                            }
                            if ($(this).find('input[name="stockInQuantity"]').attr('stockInListId')) {
                                materialDetailsObj.stockInListId = $(this).find('input[name="stockInQuantity"]').attr('stockInListId');
                            }
                            materialDetailsArr.push(materialDetailsObj);
                        });
                        obj.plbMtlStockInLists = materialDetailsArr;

                        if(lock){
                            return false
                        }

                        var loadIndex = layer.load();



                        if (type == 1) {
                            obj.mtlStockInId = data.mtlStockInId
                        }else{
                            obj.projId = parseInt(projId);
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
                                    layer.msg(res.msg, {icon: 7});
                                }
                            }
                        });
                    }else {
                        layer.close(index);
                    }

                }
                ,btn2:function(btnIndex){
                    if(data!=undefined&&data.auditerStatus != undefined&&data.auditerStatus != '0'){
                        layer.msg('该数据已提交！', {icon: 0, time: 2000});
                        return false;
                    }
                    var lock=false
                    //材料计划数据
                    var datas = $('#baseForm').serializeArray();
                    var obj = {}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });
                    // obj.warehouseId=parseInt($('#baseForm [name="warehouseId"]').val())
                    //客商单位名称的id
                    obj.customerId=$('#baseForm [name="customerName"]').attr('customerId')
                    //合同id
                    obj.mtlContractId = $('#baseForm input[name="mtlContractName"]').attr('mtlContractId') || '';

                    // 附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId = attachmentId;
                    obj.attachmentName = attachmentName;

                    // 判断必填项
                    var requiredFlag = false;
                    $('#baseForm').find('.field_required').each(function(){
                        var field = $(this).attr('field');
                        if (!obj[field]) {
                            var fieldName = $(this).parent().text().replace('*', '');
                            layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                            requiredFlag = true;
                            return false;
                        }
                    });
                    if (requiredFlag) {
                        return false;
                    }

                    //入库明细数据
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        if($(this).find('input[name="stockInQuantity"]').val() == ''){
                            layer.msg('请填写本次入库数量！', {icon: 0});
                            lock=true
                            return false
                        }

                        if($(this).find('input[name="taxPeice"]').val() == ''){
                            layer.msg('请填写含税单价！', {icon: 0});
                            lock=true
                            return false
                        }
                        var sum=($(this).find('input[name="purchaseOrderQuantity"]').val())*(1+controlRules/100);
                        if(sum < accAdd(accAdd(Number($(this).find('input[name="stockInQuantity"]').val()),Number($(this).find('input[name="quantityTransit"]').val())),Number($(this).find('input[name="stockInSum"]').val()))){
                            layer.msg('本次入库数量大于采购订单数量，无法提交！', {icon: 0});
                            lock=true
                            return false
                        }

                        var materialDetailsObj = {
                            mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                            mtlLibId: $(this).find('input[name="stockInQuantity"]').attr('mtlLibId'),
                            mtlOrderLisId: $(this).find('input[name="stockInQuantity"]').attr('mtlOrderLisId'),
                            mtlContractId: $(this).find('input[name="stockInQuantity"]').attr('mtlContractId'),
                            mtlUnit: $(this).find('input[name="stockInQuantity"]').attr('mtlUnit'),
                            mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell span').text(), //材料规格
                            mtlValuationUnit:$(this).find('input[name="mtlValuationUnit"]').attr('mtlValuationUnit'), //单位
                            controlType:$(this).find('input[name="controlType"]').attr('controlType'), //单位
                            stockInQuantity: $(this).find('input[name="stockInQuantity"]').val(),
                            taxPeice: $(this).find('input[name="taxPeice"]').val(),
                            noTaxPeice: $(this).find('input[name="noTaxPeice"]').val(),
                            taxRate: $(this).find('input[name="taxRate"]').attr('taxRate'),//税率
                            taxes: $(this).find('input[name="taxes"]').val(),//attr('taxes'),//税金
                            checkState: $(this).find('input[name="checkState"]').val(),
                            remark: $(this).find('input[name="remark"]').val(),
                            purchaseOrderQuantity: $(this).find('input[name="purchaseOrderQuantity"]').val(),//采购订单数量
                            stockInSum: $(this).find('input[name="stockInSum"]').val(),//已入库数量
                            quantityTransit: $(this).find('input[name="quantityTransit"]').val(),//在途入库数量
                            taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                            noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                            wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                            wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                            rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                            rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                            cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                            cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                            stockInPrice:$(this).find('input[name="taxPeice"]').val(),
                            isAllStockIn: $(this).find('input[name="close"]').attr("isOpen")     //是否全部入库
                        }
                        if ($(this).find('input[name="stockInQuantity"]').attr('stockInListId')) {
                            materialDetailsObj.stockInListId = $(this).find('input[name="stockInQuantity"]').attr('stockInListId');
                        }
                        materialDetailsArr.push(materialDetailsObj);
                    });
                    obj.plbMtlStockInLists = materialDetailsArr;

                    if(lock){
                        return false
                    }
                    var loadIndex = layer.load();

                    if (type == 1) {
                        obj.mtlStockInId = data.mtlStockInId
                    }else{
                        obj.projId = parseInt(projId);
                    }
                    $.ajax({
                        url: url,
                        data: JSON.stringify(obj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        async:false,
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.close(btnIndex)
                                var subata = res.object;
                                subata.projectName=subata.projName==undefined?subata.subata:subata.projName;
                                subata.projectName=subata.projectName==undefined?subata.projName:subata.projectName;
                                layer.open({
                                    type: 1,
                                    title: '选择流程',
                                    area: ['70%', '80%'],
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                    success: function () {
                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '37'}, function (res) {
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
                                            newWorkFlow(flowData.flowId, function (res) {
                                                var submitData = {
                                                    mtlStockInId:subata.mtlStockInId,
                                                    runId: res.flowRun.runId,
                                                    //auditerStatus:1
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.ajax({
                                                    url: '/plbMtlStockIn/updateStockIn',
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
                                            },subata);
                                        } else {
                                            layer.close(loadIndex);
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                            } else {
                                layer.msg(res.msg || '保存失败!', {icon: 2});
                                return false;
                            }
                        }
                    });
                    return false;
                }
            });
        }

        // 点击选合同
        $(document).on('click', '.chooseManagementBudget', function () {
            // if(!$('#baseForm [name="customerName"]').attr('customerId')){
            //     layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
            //     return false
            // }
            layer.open({
                type: 1,
                title: '选择合同',
                area: ['80%', '80%'],
                maxmin: true,
                btnAlign:'c',
                btn: ['确定', '取消'],
                content: ['<div id="contractTableModule" class="layui-form">' +
                '<div class="layui-row" style="margin-top: 10px;margin-left: 5px">' +
                '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractNo" type="text" autocomplete="off" placeholder="合同编号" class="layui-input" /></div>' +
                '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractName" type="text" autocomplete="off" placeholder="合同名称" class="layui-input" /></div>' +
                '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="customerName" type="text" autocomplete="off" placeholder="供应商" class="layui-input" /></div>' +
                '<div class="layui-col-xs3" style="padding-top: 3px;"><button class="layui-btn layui-btn-sm" id="searchContract">查询</button></div>' +
                '</div>' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {
                    var contractTableObj = table.render({
                        elem: '#mtlPlanIdTable',
                        url: '/plbMtlContract/selectAll',
                        where:{projId:$('#leftId').attr('projId'),auditerStatusFlag:"true",useFlag:true},
                        page:true,
                        cols: [[
                            {type: 'radio'},
                            {field: 'contractNo', title: '合同编号', sort: true, hide: false},
                            {field: 'contractName', title: '合同名称', sort: true, hide: false},
                            {field:'contractAName',title:'甲方',sort:false,hide:false},
                            {field:'customerName',title:'乙方',sort:false,hide:false},
                            {field:'contractMoney',title:'合同金额',sort:false,hide:false},
                            {
                                field: 'contractType', title: '合同类型', sort: true, hide: false, templet: function (d) {
                                    return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
                                }
                            },
                            {
                                field: 'signDate', title: '合同签订日期', sort: true, hide: false, templet: function (d) {
                                    return format(d.signDate);
                                }
                            },
                        ]],
                        parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "count": res.totleNum, //解析数据长度
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                    $('#searchContract').on('click', function () {
                        var contractNo = $('input[name="contractNo"]', $('#contractTableModule')).val();
                        var contractName = $('input[name="contractName"]', $('#contractTableModule')).val();
                        var customerName=$('input[name="customerName"]',$('#contractTableModule')).val();
                        contractTableObj.reload({
                            where: {
                                contractNo: contractNo,
                                contractName: contractName,
                                customerName:customerName,
                                projId:$('#leftId').attr('projId'),
                                auditerStatusFlag:"true"
                            }
                        });
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('mtlPlanIdTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];
                        $('#baseForm [name="mtlContractName"]').val(chooseData.contractName)
                        $('#baseForm [name="mtlContractName"]').attr('mtlContractId',chooseData.mtlContractId)
                        $('#baseForm [name="customerName"]').val(chooseData.customerName);
                        $('#baseForm [name="customerName"]').attr("customerId",chooseData.customerId);
                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });

        //监听本次入库数量
        $(document).on('input propertychange', '.stockInQuantityItem', function () {
            if($('#leftId').attr('_type')=='4'){
                return false
            }

            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var stockInQuantity=0
            var taxPeice=0
            $tr.each(function () {
                stockInQuantity=accAdd(stockInQuantity,$(this).find('input[name="stockInQuantity"]').val())

                /*var p1=($(this).find('input[name="stockInQuantity"]').val() || 0) * ($(this).find('input[name="taxPeice"]').val() || 0)*/
                var p1=mul(($(this).find('input[name="stockInQuantity"]').val() || 0) , ($(this).find('input[name="taxPeice"]').val() || 0))
                taxPeice=accAdd(taxPeice,p1)
            });
            //计算入库总数量
            $('#baseForm [name="stockInTotal"] ').val(retainDecimal(stockInQuantity,3))
            //计算入库总金额
            $('#baseForm [name="stockInAmount"] ').val(retainDecimal(taxPeice,2))

            //计算含税总价和不含税总价
            if($(this).val() && $(this).parents('tr').find('[name="taxPeice"]').val()){
                // $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="taxPeice"]').val(),2))
                $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="taxPeice"]').val()),2))
            }
            if($(this).val() && $(this).parents('tr').find('[name="noTaxPeice"]').val()){
                // $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="noTaxPeice"]').val(),2))
                $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="noTaxPeice"]').val()),2))
            }

            //计算税金
            // var taxes=$(this).parents('tr').find('[name="taxMoney"]').val() - $(this).parents('tr').find('[name="noTaxMoney"]').val()
            var taxes=sub($(this).parents('tr').find('[name="taxMoney"]').val() , $(this).parents('tr').find('[name="noTaxMoney"]').val())
            $(this).parents('tr').find('[name="taxes"]').val(retainDecimal(taxes,2))
        });

        //监听含税单价
        $(document).on('input propertychange', '.taxPeiceItem', function () {
            if($('#leftId').attr('_type')=='4'){
                return false
            }
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var taxPeice=0
            $tr.each(function () {
                // var p1=($(this).find('input[name="stockInQuantity"]').val() || 0) * ($(this).find('input[name="taxPeice"]').val() || 0)
                var p1=mul(($(this).find('input[name="stockInQuantity"]').val() || 0) , ($(this).find('input[name="taxPeice"]').val() || 0))
                taxPeice=accAdd(taxPeice,p1)
            });
            $('#baseForm [name="stockInAmount"] ').val(retainDecimal(taxPeice,2))

            //计算不含税单价
            if($(this).val() && $(this).parents('tr').find('[name="taxRate"]').val()){
                var taxPeiceItem=$(this).val()
                var taxRateItem=$(this).parents('tr').find('[name="taxRate"]').val() * 0.01
                // $(this).parents('tr').find('[name="noTaxPeice"]').val(retainDecimal(taxPeiceItem / (1+taxRateItem),8))
                $(this).parents('tr').find('[name="noTaxPeice"]').val(retainDecimal(div(taxPeiceItem,accAdd(1,taxRateItem)),8))
            }

            //计算含税总价和不含税总价
            if($(this).val() && $(this).parents('tr').find('[name="stockInQuantity"]').val()){
                // $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="stockInQuantity"]').val(),2))
                $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="stockInQuantity"]').val(),2)))
            }
            if($(this).parents('tr').find('[name="noTaxPeice"]').val() && $(this).parents('tr').find('[name="stockInQuantity"]').val()){
                // $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal($(this).parents('tr').find('[name="noTaxPeice"]').val() * $(this).parents('tr').find('[name="stockInQuantity"]').val(),2))
                $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal(mul($(this).parents('tr').find('[name="noTaxPeice"]').val() , $(this).parents('tr').find('[name="stockInQuantity"]').val()),2))
            }

            //计算税金
            // var taxes=$(this).parents('tr').find('[name="taxMoney"]').val() - $(this).parents('tr').find('[name="noTaxMoney"]').val()
            var taxes=sub($(this).parents('tr').find('[name="taxMoney"]').val() , $(this).parents('tr').find('[name="noTaxMoney"]').val())
            $(this).parents('tr').find('[name="taxes"]').val(retainDecimal(taxes,2))

        });
        //监听税率
        /*$(document).on('blur', '.taxRateItem', function () {
            //计算不含税单价
            if($(this).val() && $(this).parents('tr').find('[name="taxPeice"]').val()){
                var taxRateItem=$(this).val() * 0.01
                var taxPeiceItem=$(this).parents('tr').find('[name="taxPeice"]').val()
                $(this).parents('tr').find('[name="noTaxPeice"]').val(retainDecimal(taxPeiceItem / (1+taxRateItem)))
            }

        });*/

        //点击查询
        $('.searchData').click(function () {
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
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        /*用来得到精确的加法结果
            *说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
            *调用：accAdd(arg1,arg2)
            *返回值：arg1加上arg2的精确结果
        */
        /*function accAdd(arg1,arg2){
            var r1,r2,m;
            try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
            try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
            m=Math.pow(10,Math.max(r1,r2))
            return (arg1*m+arg2*m)/m
        }*/

        //监听客商单位名称选择
        // $(document).on('click', '.chooseCustomerName', function () {
        //     var _this = $(this);
        //     layer.open({
        //         type: 1,
        //         title: '选择供应商',
        //         area: ['80%', '80%'],
        //         maxmin: true,
        //         btn: ['确定', '取消'],
        //         btnAlign: 'c',
        //         content: ['<div class="container">',
        //             '<div class="wrapper">',
        //             '<div class="wrap_left">' +
        //             '<div class="layui-form">' +
        //             '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
        //             '<div class="tree_module" style="top: 10px;">' +
        //             '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
        //             '</div>' +
        //             '</div>' +
        //             '</div>',
        //             '<div class="wrap_right">' +
        //             '<div class="mtl_table_box" style="display: none;">' +
        //             //查询
        //             '       <div class="layui-row inSearchContent">' +
        //             '             <div class="layui-col-xs4">\n' +
        //             '                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
        //             '             </div>\n' +
        //             '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
        //             '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
        //             '             </div>\n' +
        //             '       </div>'+
        //             '<table id="materialsTable" lay-filter="materialsTable"></table>' +
        //             '</div>' +
        //             '<div class="mtl_no_data" style="text-align: center;">' +
        //             '<div class="no_data_img">' +
        //             '<img style="margin-top: 12%;" src="/img/noData.png">' +
        //             '</div>' +
        //             '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择供应商</p>' +
        //             '</div>' +
        //             '</div>',
        //             '</div></div>'].join(''),
        //         success: function () {
        //             // 树节点点击事件
        //             eleTree.on("nodeClick(chooseMtlTree)", function (d) {
        //                 var currentData = d.data.currentData;
        //                 if (currentData.typeNo) {
        //                     $('.mtl_no_data').hide();
        //                     $('.mtl_table_box').show();
        //                     loadMtlTable(currentData.typeNo);
        //                 } else {
        //                     $('.mtl_table_box').hide();
        //                     $('.mtl_no_data').show();
        //                 }
        //             });
        //
        //             loadMtlType();
        //
        //             function loadMtlType(typeNo) {
        //                 typeNo = typeNo ? typeNo : '';
        //                 // 获取左侧树
        //                 $.get('/PlbCustomerType/treeList', function (res) {
        //                     if (res.flag) {
        //                         eleTree.render({
        //                             elem: '#chooseMtlTree',
        //                             data: res.data,
        //                             highlightCurrent: true,
        //                             showLine: true,
        //                             defaultExpandAll: false,
        //                             request: {
        //                                 name: "typeName", // 显示的内容
        //                                 key: "typeNo", // 节点id
        //                                 parentId: 'parentTypeId', // 节点父id
        //                                 isLeaf: "isLeaf",// 是否有子节点
        //                                 children: 'child',
        //                             }
        //                         });
        //                     }
        //                 });
        //             }
        //
        //             function loadMtlTable(typeNo) {
        //                 materialsTable=table.render({
        //                     elem: '#materialsTable',
        //                     url: '/PlbCustomer/getDataByCondition',
        //                     where: {
        //                         merchantType:typeNo,
        //                         useFlag: true
        //                     },
        //                     page: true, //开启分页
        //                     limit: 50,
        //                     // height: 'full-180',
        //                     cols: [[ //表头
        //                         {type: 'radio'}
        //                         , {field: 'customerNo', title: '客商编号', width: 200}
        //                         , {field: 'customerName', title: '客商单位名称',width: 200}
        //                         , {field: 'customerShortName', title: '客商单位简称',width: 200}
        //                         , {field: 'customerOrgCode', title: '组织机构代码',width: 200}
        //                         , {field: 'taxNumber', title: '税务登记号',width: 200}
        //                         , {field: 'accountNumber', title: '开户行账户',minWidth: 200}
        //                     ]], parseData: function (res) {
        //                         return {
        //                             "code": 0, //解析接口状态
        //                             "data": res.data,//解析数据列表
        //                             "count": res.totleNum, //解析数据长度
        //                         };
        //                     },
        //                     request: {
        //                         pageName: 'page' //页码的参数名称，默认：page
        //                         , limitName: 'pageSize' //每页数据量的参数名，默认：limit
        //                     },
        //                 });
        //             }
        //         },
        //         yes: function (index) {
        //             var checkStatus = table.checkStatus('materialsTable');
        //             if (checkStatus.data.length > 0) {
        //                 var mtlData = checkStatus.data[0];
        //                 _this.val(mtlData.customerName);
        //                 _this.attr('customerId',mtlData.customerId);
        //                 //修改供应商改变清空合同
        //                 $('#baseForm [name="mtlContractName"]').val("")
        //                 $('#baseForm [name="mtlContractName"]').attr('mtlContractId','')
        //
        //                 layer.close(index);
        //             } else {
        //                 layer.msg('请选择一项！', {icon: 0});
        //             }
        //         }
        //     });
        // });

        //选择分包商内侧查询
        $(document).on('click','.inSearchData',function () {
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

        /**
         * 新建流程方法
         * @param flowId
         * @param urlParameter
         * @param cb
         */
        function newWorkFlow(flowId, cb,approvalData) {
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
                    approvalData:JSON.stringify(approvalData),
                    isTabApproval:true,
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

        //数据列表点击审批状态查看流程功能
        $(document).on('click', '.preview_flow', function() {
            var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId');
            if (flowId && runId) {
                $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
            }
        });

    });
    function openRold(){ //流程转交下一步后会调用此方法
        //刷新表格
        tableIns.reload({
            page: {
                curr: 1 //重新从第 1 页开始
            }
        });
    }
    //打印模板
    function pdurlss(that,workNum) { //附件预览点击调取
        var attrUrl=that.split('&FILESIZE')[0];
        var url = attrUrl;
        if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1&&attrUrl.indexOf('isOld=1') == -1){
            var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                url = atturl1 + atturl2;
            }else{
                url = atturl1;
            }
        }
        var type = UrlGetRequest('?'+attrUrl)||'docx';
        type = type.toLowerCase();
        if(type == 'pdf'){
            //$.popWindow('/common/pdfPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
            $.popWindow("/common/PDFBrowser?"+url,PreviewPage,'0','0','1200px','600px');
        }else if(type == 'png' || type == 'jpg' ||  type == 'txt'){
            $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
        }else if(type == 'doc'||type == 'docx'||type == 'xls'||type == 'xlsx'||type == 'ppt'||type == 'pptx'){
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        documentPreviewOpen = res.object[0].paraValue;
                        if(documentPreviewOpen == 1){
                            $.ajax({
                                type:'get',
                                url:'/sysTasks/getOfficePreviewSetting',
                                dataType:'json',
                                success:function (res) {
                                    if(res.flag){
                                        var strOfficeApps = res.object.previewUrl;//在线预览服务地址

                                        $.ajax({
                                            url:'/onlyOfficeCode',
                                            dataType: 'json',
                                            type: 'post',
                                            success:function(res){
                                                if(res.flag){
                                                    var code = res.obj;
                                                    $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
                                                }
                                            }
                                        })
                                    }
                                }
                            })
                        }else if(documentPreviewOpen == 2){
                            if(type == 'xls'||type == 'xlsx'){
                                $.popWindow('/common/excelPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                            }else if(type == 'ppt'||type == 'pptx'){
                                $.popWindow('/common/pptPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                            }else{
                                $.popWindow('/common/officereader?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                            }
                        }else if(documentPreviewOpen == 3){
                            $.popWindow("/wps/info?"+ url +"&permission=read",'','0','0','1200px','600px');
                        }else if(documentPreviewOpen == 4){
                            $.popWindow("/common/onlyoffice?"+ url +"&edit=false",'','0','0','1200px','600px');
                        }
                    }
                }
            })
        } else{
            $.ajax({
                type:'get',
                url:'/sysTasks/getOfficePreviewSetting',
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        var strOfficeApps = res.object.previewUrl;//在线预览服务地址
                        if(strOfficeApps == ''){
                            strOfficeApps = 'https://owa-box.vips100.com';
                        }

                        $.ajax({
                            url:'/onlyOfficeCode',
                            dataType: 'json',
                            type: 'post',
                            success:function(res){
                                if(res.flag){
                                    var code = res.obj;
                                    $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
                                }
                            }
                        })


                    }
                }
            })
        }
    }
</script>
</body>
</html>
