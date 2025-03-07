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
    <title>分包结算</title>

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
   <%-- <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planbudget/common.js"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210831"></script>

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
        .layui-col-xs4{
            width: 20%;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">分包结算</h2>
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
                    <input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">
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
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
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
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    var materialDetailsTableData = [];
    var writeOffTableData = [];
    var plbMtlSubcontractOuts = [];
    var _dataa = null;

    var tableIns = null;

    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name=$(this).attr('name')
        $('.query_module [name='+name+']').val($.cookie(name) || '')
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
        CONTRACT_TYPE: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,CONTRACT_TYPE';
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

    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;

        var materialsTable=null;

        form.render();
        //导出数据
        var exportData = '';
        //表格显示顺序
        var colShowObj = {
            subsettleup:{field:'subsettleup',title:'分包结算编号',hide:false,minWidth:100},
            projName:{field:'projName',title:'所属项目',hide:false,minWidth:100},
            customerName: {field: 'customerName', title: '分包商', hide: false,minWidth:100},

            contractName: {field: 'contractName', title: '合同名称',hide: false,minWidth:100},
            contractFee:{field:'contractFee',title:'合同金额',sort:true,hide:false,minWidth:100},
            settleupMoney: {field: 'settleupMoney', title: '本次结算金额', sort: true, hide: false,minWidth:100},
            settleupDate: {
                field: 'settleupDate', title: '结算日期', sort: true, hide: false, templet: function (d) {
                    return format(d.settleupDate);
                }
            },
            /*settleupYear: {field: 'settleupYear', title: '结算年', sort: true, hide: false,minWidth:100},
            settleupQuarter: {field: 'settleupQuarter', title: '结算季', sort: true, hide: false,minWidth:100},
            settleupMonth: {field: 'settleupMonth', title: '结算月', sort: true, hide: false,minWidth:100},*/
            currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
            auditerStatus: {
                field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
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
            },
        }

        var TableUIObj = new TableUI('plb_mtl_subsettleup');
        // TableUIObj.init(colShowObj);

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
                    if($('#leftId').attr('projId')){
                        newOrEdit(0)
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
                    if (checkStatus.data[0].auditerStatus!=0) {
                        layer.msg('已提交不可编辑！', {icon: 0});
                        return false
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
                    var subsettleupId = ''
                    var isFlay = false;
                    checkStatus.data.forEach(function (v, i) {
                        subsettleupId += v.subsettleupId + ','
                        if(v.auditerStatus&&v.auditerStatus!='0'){
                            isFlay = true
                        }
                    })

                    if(isFlay){
                        layer.msg('已提交不可删除！', {icon: 0});
                        return false
                    }

                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbMtlSubsettleup/delPlbMtlSubsettleup', {subSettleupIds: subsettleupId}, function (res) {
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
                    window.location.href = '/plbMtlPlan/outCurrentPageData?mtlPlanIds=' + exportData
                    break;
                case 'submit':
                    //submit(checkStatus)
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                        return false;
                    }
                    if(checkStatus.data[0].auditerStatus&&checkStatus.data[0].auditerStatus != '0'){
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
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '50'}, function (res) {
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
                                delete plbMtlSubsettleupListWithBLOBs;
                                delete plbMtlSubsettleupDetails;
                                approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                newWorkFlow(flowData.flowId, function (res) {
                                    var submitData = {
                                        subsettleupId:approvalData.subsettleupId,
                                        runId: res.flowRun.runId
                                        //auditerStatus:1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/plbMtlSubsettleup/updatePlbMtlSubsettleup',
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
                                },approvalData);
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
                tableShow($('#leftId').attr('projId'))
            })
        });
        // 内部加行按钮
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    // 判断分包合同
                    var subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';

                    if (!subcontractId) {
                        layer.msg('请选择分包合同', {icon: 0, time: 1500});
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择',
                        area: ['70%', '60%'],
                        btnAlign: 'c',
                        btn: ['确定', '取消'],
                        content: ['<div class="layui-form" id="objectives">' +
                        //表格数据
                        '       <div style="padding: 10px">' +
                        '           <table id="mtlPlanIdTable2" lay-filter="mtlPlanIdTable2"></table>' +
                        '      </div>' +
                        '</div>'].join(''),
                        success: function () {
                            if(plbMtlSubcontractOuts){
                                plbMtlSubcontractOuts.forEach(function(item){
                                    if(item.LAY_CHECKED){
                                        delete item.LAY_CHECKED
                                    }
                                })
                            }

                            table.render({
                                elem: '#mtlPlanIdTable2',
                                //data: $('.plan_base_info input[name="contractName"]').data('data'),
                                data:plbMtlSubcontractOuts,
                                limit: 1000,
                                cols: [[
                                    {type: 'checkbox', title: '选择'},
                                    {field: 'wbsName', title: 'WBS', width: 200,templet:function(d){
                                            return '<span class="subcontractOutId" subcontractOutId="' + (d.subcontractOutId || '') + '">' + d.wbsName + '</span>'
                                        }
                                    },
                                    {field:'rbsName',title:'RBS',width:200},
                                    {field: 'cbsName', title: 'CBS', width: 200,},
                                    {field: 'contractPrice', title: '合同金额',minWidth:100},
                                    {field:'contractOtherContent',title:'合同明细',minWidth:100},
                                    {
                                        field: 'settleupMoney', title: '累计结算金额',minWidth:100,templet: function (d) {
                                            return d.settleupMoney || 0
                                        }
                                    },
                                ]],
                                done:function(res){
                                    _dataa=res.data;
                                    if(materialDetailsTableData!=undefined&&materialDetailsTableData.length>0){
                                        for(var i = 0 ; i <_dataa.length;i++){
                                            for(var n = 0 ; n < materialDetailsTableData.length; n++){
                                                if(_dataa[i].subcontractOutId == materialDetailsTableData[n].subcontractOutId){
                                                    $('#objectives .layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                    //form.render('checkbox');
                                                }
                                            }
                                        }
                                    }
                                    var flag = true
                                    $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                        if($(item).find('.layui-form-checked').length==0){
                                            flag=false
                                        }
                                    })
                                    if(flag){
                                        $('#objectives .layui-table-header .layui-form-checkbox').click()
                                    }
                                }
                            });
                        },
                        yes: function (index) {

                            var checkStatus=[];
                            $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                if($(item).find('.layui-form-checked').length>0){
                                    checkStatus.push(_dataa[index]);
                                }
                            })

                            //checkStatus = table.checkStatus('mtlPlanIdTable2').data;


                            if (checkStatus.length > 0) {

                                for(var i=0;i<checkStatus.length;i++){
                                    var addRowData = {
                                        cbsName: checkStatus[i].cbsName,
                                        cbsId: checkStatus[i].cbsId,
                                        rbsName:checkStatus[i].rbsName,
                                        rbsId:checkStatus[i].rbsId,
                                        wbsName: checkStatus[i].wbsName,
                                        wbsId: checkStatus[i].wbsId,
                                        contractOtherContent:checkStatus[i].contractOtherContent,
                                        contractPrice: checkStatus[i].contractPrice,
                                        conSettleupMoney: checkStatus[i].settleupMoney || 0,
                                        trnSettleupMoney: checkStatus[i].trnSettleupMoney || 0,
                                        subcontractOutId:checkStatus[i].subcontractOutId
                                    }

                                    if(materialDetailsTableData){
                                        var _flag = true
                                        for(var j=0;j<materialDetailsTableData.length;j++){
                                            if(materialDetailsTableData[j].subcontractOutId==checkStatus[i].subcontractOutId){
                                                _flag = false
                                            }
                                        }
                                        if(_flag){
                                            materialDetailsTableData.push(addRowData);
                                        }

                                    }else{
                                        materialDetailsTableData.push(addRowData);
                                    }
                                }


                                table.reload('materialDetailsTable', {
                                    data: materialDetailsTableData
                                });


                                layer.close(index);


                                /*var chooseData = checkStatus.data[0];

                                //遍历表格获取每行数据进行保存
                                var $tr = $('.mtl_info').find('.layui-table-main tr');
                                var oldDataArr = [];
                                $tr.each(function () {
                                    var oldDataObj = {
                                        contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                                        conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                                        settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                                        remark: $(this).find('[name="remark"]').val(),
                                        // leasesettleupListId: $(this).find('[name="remark"]').attr('leasesettleupListId'),
                                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                                        cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                                        subsettleupLisId: $(this).find('[name="remark"]').attr('subsettleupLisId'),
                                        wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                                        wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                                        subcontractOutId:$(this).find('.subcontractOutId').attr('subcontractOutId')
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                var addRowData = {
                                    cbsName: chooseData.cbsName,
                                    cbsId: chooseData.cbsId,
                                    rbsName:chooseData.rbsName,
                                    wbsName: chooseData.wbsName,
                                    wbsId: chooseData.wbsId,
                                    contractOtherContent:chooseData.contractOtherContent,
                                    contractPrice: chooseData.contractPrice,
                                    conSettleupMoney: chooseData.settleupMoney || 0,
                                    subcontractOutId:chooseData.subcontractOutId,
                                };
                                oldDataArr.push(addRowData);
                                table.reload('materialDetailsTable', {
                                    data: oldDataArr
                                });

                                layer.close(index);*/
                            } else {
                                layer.msg('请选择一项！', {icon: 0, time: 2000});
                            }
                        }
                    });
                    break;
            }
        });
        // 内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data
            var layEvent = obj.event;
            if (layEvent === 'del') {
                obj.del();
                if (data.subsettleupLisId) {
                    $.get('/plbMtlSubsettleup/delPlbMtlSubsettleupList', {subSettleupLisIds: data.subsettleupLisId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        contractOtherContent: $(this).find('[data-field="contractOtherContent"] .layui-table-cell').text(),
                        contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                        conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                        trnSettleupMoney: $(this).find('[data-field="trnSettleupMoney"] .layui-table-cell').text(),
                        settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                        //remark: $(this).find('[name="remark"]').val(),
                        // leasesettleupListId: $(this).find('[name="remark"]').attr('leasesettleupListId'),
                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                        cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                        rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                        rbsId: $(this).find('[name="settleupMoney"]').attr('rbsId'),
                        wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                        wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                        subsettleupLisId: $(this).find('[name="settleupMoney"]').attr('subsettleupLisId'),
                        subsettleupId: $(this).find('[name="settleupMoney"]').attr('subsettleupId'),
                        subcontractOutId: $(this).find('[name="settleupMoney"]').attr('subcontractOutId')
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });

        table.on('toolbar(writeOffTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.contract_out').find('.layui-table-main tr');
                    var oldDataArr = [];

                    $tr.each(function () {
                        var oldDataObj = {
                            subsettleupId: $(this).find('input[name="quantities"]').attr('subsettleupId') || '',
                            subsettleupDetailsId: $(this).find('input[name="quantities"]').attr('subsettleupDetailsId') || '',
                            quantities: $(this).find('input[name="quantities"]').val(),
                            comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                            totalPrice: $(this).find('input[name="totalPrice"]').val(),
                            sumSettlementQuantities: $(this).find('input[name="sumSettlementQuantities"]').val(),
                            onwaySettlementQuantities: $(this).find('input[name="onwaySettlementQuantities"]').val(),
                            currentSettlementQuantities: $(this).find('input[name="currentSettlementQuantities"]').val()
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    oldDataArr.push({});
                    table.reload('writeOffTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });
        // 内部-合同清单-删行操作
        table.on('tool(writeOffTable)', function (obj) {

            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.subsettleupDetailsId) {
                    $.get('/plbMtlSubsettleup/deleteDetail', {ids: data.subsettleupDetailsId}, function () {
                    });
                }
                //遍历表格获取每行数据进行保存
                var $trs = $('.contract_out').find('.layui-table-main tr');
                var oldDataArr = [];
                $trs.each(function () {
                    var oldDataObj = {
                        subsettleupId: $(this).find('input[name="quantities"]').attr('subsettleupId') || '',
                        subsettleupDetailsId: $(this).find('input[name="quantities"]').attr('subsettleupDetailsId') || '',
                        quantities: $(this).find('input[name="quantities"]').val(),
                        comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                        totalPrice: $(this).find('input[name="totalPrice"]').val(),
                        sumSettlementQuantities: $(this).find('input[name="sumSettlementQuantities"]').val(),
                        onwaySettlementQuantities: $(this).find('input[name="onwaySettlementQuantities"]').val(),
                        currentSettlementQuantities: $(this).find('input[name="currentSettlementQuantities"]').val()
                    }
                    oldDataArr.push(oldDataObj);
                })
                table.reload('writeOffTable', {
                    data: oldDataArr
                });
            }
        });

        //查看单条数据
        table.on('tool(tableDemo)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if (layEvent === 'detail') { //查看
                newOrEdit(4, data)
                /*console.log(data)
                checkSettlement(data)*/
            }
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
                url: '/plbMtlSubsettleup/getDataByCondition',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-80',
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

                    res.data.forEach(function (v) {
                        exportData += v.mtlPlanId + ','
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
            if (type == '0') {
                title = '新建分包结算';
                url = '/plbMtlSubsettleup/updatePlbMtlSubsettleup';
            } else if (type == '1') {
                title = '编辑分包结算';
                url = '/plbMtlSubsettleup/updatePlbMtlSubsettleup';
            }else if(type == '4'){
                title = '查看详情';
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: type != '4'?['保存','提交审批', '取消']:['确定'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse disabledAll">\n',
                    /* region 分包结算 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">分包结算</h2>\n' +
                    '    <div class="layui-colla-content layui-show plan_base_info">' +
                    '       <form class="layui-form" id="baseForm" lay-filter="baseForm">',
                    /* region 第一行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">分包结算编号<span field="subsettleup" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="subsettleup" readonly autocomplete="off" class="layui-input chen" title="分包结算编号" style="background: #e7e7e7" title="合同编号">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">项目名称<span field="projName" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="projName" readonly title="项目名称" style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chen" title="项目名称">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                    '                       <input type="text" name="contractName" title="合同名称" placeholder="查找分包合同" readonly autocomplete="off" class="layui-input chooseManagementBudget chen" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">分包商</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="customerName" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input  chooseCustomerName" title="客商单位名称">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同金额</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="contractFee" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input" title="合同金额">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第二行 */
                    // '           <div class="layui-row">' +
                    // '           </div>',
                    /* endregion */
                    /* region 第三行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">累计已结算金额</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text"  name="subsettleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">在途结算金额</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="trnSettleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">本次结算金额<span field="settleupMoney" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="settleupMoney" title="本次结算金额" id="settleup_Money" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chen" title="本次结算金额">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算日期<span  field="settleupDate" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="settleupDate" readonly id="settleupDate"  title="结算日期" autocomplete="off" class="layui-input chen" title="结算日期">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">备注</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' +
                    /* endregion */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算年</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" id="settleupYear" name="settleupYear" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算季</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <select name="settleupQuarter"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算月</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <select name="settleupMonth">' +
                    '                               <option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>' +
                    '                               <option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>' +
                    '                               <option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>' +
                    '                           </select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' +
                    /* endregion */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算合同附件</label>' +
                    '                       <div class="layui-input-block form_block">' +
                    '<div class="file_module">' +
                    '<div id="fileContent" class="file_content"></div>' +
                    '<div class="file_upload_box">' +
                    '<a href="javascript:;" class="open_file">' +
                    '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
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
                    '           </div>',
                    /* endregion */
                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n',
                    /* endregion */
                    /* region 分包结算明细 */
                    '<div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">分包结算明细</h2>\n' +
                    '<div class="layui-colla-content layui-show">' +
                    '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
                    '<ul class="layui-tab-title">' +
                    '<li class="layui-this">结算明细</li>' +
                    '<li>结算清单</li>' +
                    '</ul>' +
                    '<div class="layui-tab-content">' +
                    '<div class="layui-tab-item layui-show mtl_info">' +
                    '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                    '</div>' +
                    '<div class="layui-tab-item contract_out">' +
                    '<div id="paymentSettlementModule">' +
                    '          <table id="writeOffTable" lay-filter="writeOffTable"></table>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>\n' +
                    /* endregion */
                    '</div>'].join(''),
                success: function () {
                    fileuploadFn('#fileupload', $('#fileContent'));
                    materialDetailsTableData = [];
                    writeOffTableData = [];
                    //回显数据
                    if (type == 1 || type == 4) {
                        form.val("baseForm", data)
                        //分包合同id
                        $('.plan_base_info input[name="contractName"]').attr('subcontractId',data.subcontractId || '');
                        //客商单位名称id
                        $('.plan_base_info input[name="customerName"]').attr('customerId',data.customerId || '');

                        //附件
                        if (data.attachments && data.attachments.length > 0) {
                            var fileArr = data.attachments;
                            $('#fileContent').append(echoAttachment(fileArr));
                        }

                        materialDetailsTableData = data.plbMtlSubsettleupListWithBLOBs;
                        writeOffTableData = data.plbMtlSubsettleupDetails;


                        $.get('/plbMtlSubcontract/queryId',{subContractId:data.subcontractId},function (res) {
                            $('.plan_base_info input[name="contractName"]').val(res.object.contractName);
                            plbMtlSubcontractOuts = res.object.plbMtlSubcontractOuts
                            //$('.plan_base_info input[name="contractName"]').data('data', res.object.plbMtlSubcontractOuts);
                        })

                    }else{
                        // 获取自动编号
                        $.ajax({
                            url:'/planningManage/autoNumber?autoNumberType=plbMtlSubsettleup',
                            success:function(res){
                                $('input[name="subsettleup"]', $('#baseForm')).val(res.obj);
                            }
                        })
                        $('.refresh_no_btn').show().on('click', function() {
                            $.ajax({
                                url:'/planningManage/autoNumber?autoNumberType=plbMtlSubsettleup',
                                success:function(res){
                                    $('input[name="subsettleup"]', $('#baseForm')).val(res.obj);
                                }
                            })
                        });
                        $.ajax({
                            //项目名称赋值
                            url:'/technicalManager/getProjInfoById?projectId='+projId,
                            success:function(res){
                                $("[name='projName']").val(res.obj.projName)
                            }
                        })
                    }

                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#settleupDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.settleupDate) : '',
                        done:function (value, date, endDate) {
                            $('#settleupYear').val(date.year)
                            if(date.month <4){
                                $('[name="settleupQuarter"]').val('1')
                            }else if(date.month <7){
                                $('[name="settleupQuarter"]').val('2')
                            }else if(date.month <10){
                                $('[name="settleupQuarter"]').val('3')
                            }else{
                                $('[name="settleupQuarter"]').val('4')
                            }
                            $('[name="settleupMonth"]').val(date.month)
                            form.render()
                        }
                    });

                    //年选择器
                    laydate.render({
                        elem: '#settleupYear'
                        ,type: 'year'
                        , trigger: 'click' //采用click弹出
                        , value: data ? data.settleupYear : ''
                    });
                    var cols=[
                        {type: 'numbers', title: '序号'},
                        {
                            field: 'wbsName', title: 'WBS', width: 200
                        },
                        {
                            field: 'rbsName', title: 'RBS', width: 200,
                        },
                        {
                            field: 'cbsName', title: 'CBS', width: 200,
                        },
                        {
                            field: 'contractOtherContent', title: '合同明细',minWidth:100
                        },
                        {
                            field: 'contractPrice', title: '合同金额',minWidth: 100
                        },
                        {
                            field: 'conSettleupMoney', title: '累计已结算金额', width: 200,
                        },
                        /*{
                            field: 'contractOtherContent1', title: '在途结算工程量',minWidth:100
                        },*/
                        {
                            field: 'trnSettleupMoney', title: '在途结算金额',minWidth:100
                        },
                        /*{
                            field: 'settleupMoney', title: '本次结算工程量',minWidth:100, templet: function (d) {
                                return '<input type="text" cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" subsettleupLisId="'+(d.subsettleupLisId || '')+'" name="settleupMoney" class="layui-input " style="height: 100%;" value="' + (d.settleupMoney || '') + '">'
                            }
                        },*/
                        {
                            field: 'settleupMoney', title: '本次结算金额', minWidth: 100, templet: function (d) {
                                return '<input type="number"  cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" rbsId="' + (d.rbsId || '') + '" subsettleupId="' +(d.subsettleupId || '')+'" subsettleupLisId="' +(d.subsettleupLisId || '')+'" subcontractOutId="' +(d.subcontractOutId || '')+'"  name="settleupMoney" title="本次结算金额" class="layui-input chen" style="height: 100%;"  value="' + (d.settleupMoney || '') + '">'
                            }
                        },
                        /*
                        {
                            field: 'conSettleupMoney', title: '累计结算金额',minWidth: 100
                        },
                        {
                            field: 'settleupMoney', title: '本次结算金额',minWidth:100, templet: function (d) {
                                return '<input type="text" cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" subsettleupLisId="'+(d.subsettleupLisId || '')+'" name="settleupMoney" class="layui-input " style="height: 100%;" value="' + (d.settleupMoney || '') + '">'
                            }
                        },
                        {
                            field: 'remark', title: '备注',minWidth:100, templet: function (d) {
                                return '<input type="text" name="remark" class="layui-input" style="height: 100%;" subsettleupLisId="'+(d.subsettleupLisId || '')+'" cbsId="'+(d.cbsId || '')+'" value="' + (d.remark || '') + '">'
                            }
                        },*/
                    ]

                    var cols2=[
                        {type: 'numbers', title: '序号'},
                        {
                            field: 'quantities', title: '工程量',minWidth:140,
                            templet: function (d) {
                                return '<input type="text"  subsettleupId="' +(d.subsettleupId || '')+'" subsettleupDetailsId="' +(d.subsettleupDetailsId || '')+'" name="quantities" class="layui-input " style="height: 100%;" value="' + (d.quantities || '')+ '">'
                            }
                        },
                        {
                            field: 'comprehensiveUnitPrice', title: '综合单价',minWidth:100,
                            templet: function (d) {
                                return '<input type="text"   name="comprehensiveUnitPrice" class="layui-input " style="height: 100%;" value="' + (d.comprehensiveUnitPrice || '')+ '">'
                            }
                        },
                        {
                            field: 'totalPrice', title: '总价',minWidth:100,
                            templet: function (d) {
                                return '<input type="text"   name="totalPrice" class="layui-input " style="height: 100%;" value="' + (d.totalPrice || '')+ '">'
                            }
                        },
                        {
                            field: 'sumSettlementQuantities', title: '累计已结算工程量',minWidth:140,
                            templet: function (d) {
                                return '<input type="text" name="sumSettlementQuantities" class="layui-input " style="height: 100%;" value="' + (d.sumSettlementQuantities || '')+ '">'
                            }
                        },
                        /*{
                            field: 'onwaySettlementQuantities', title: '在途结算工程量',minWidth:100,
                            templet: function (d) {
                                return '<input type="text"  name="onwaySettlementQuantities" class="layui-input " style="height: 100%;" value="' + (d.onwaySettlementQuantities || '')+ '">'
                            }
                        },*/
                        {
                            field: 'currentSettlementQuantities', title: '本次结算工程量',minWidth:100, templet: function (d) {
                                return '<input type="text" name="currentSettlementQuantities" class="layui-input " style="height: 100%;" value="' + (d.currentSettlementQuantities || '') + '">'
                            }
                        },
                        {
                            field: 'onwaySettlementQuantities', title: '本次结算金额',minWidth:100, templet: function (d) {
                                return '<input type="number" name="onwaySettlementQuantities" class="layui-input" style="height: 100%;" value="' + (d.onwaySettlementQuantities || '') + '">'
                            }
                        }
                    ]

                    if(type!=4){
                        cols.push({align: 'center', toolbar: '#barDemo', fixed:'right',title: '操作', width: 100});
                        cols2.push({align: 'center', toolbar: '#barDemo', fixed:'right',title: '操作', width: 100})
                    }
                    table.render({
                        elem: '#materialDetailsTable',
                        data: materialDetailsTableData,
                        toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done:function (obj) {
                            materialDetailsTableData = obj.data
                            if(type==4){
                                $('.addRow').hide()
                            }
                        }
                    });
                    table.render({
                        elem: '#writeOffTable',
                        data: writeOffTableData,
                        toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols2],
                        done:function () {
                            if(type==4){
                                $('.addRow').hide()
                            }
                        }
                    });

                    //查看详情
                    if(type==4){
                        //$('.layui-layer-btn-c').hide()
                        /*$('#baseForm [name="customerName"]').attr('disabled','true')
                        $('#settleupDate').attr('disabled','true')
                        $('#baseForm [name="contractFee"]').attr('disabled','true')
                        $('#baseForm [name="contractName"]').attr('disabled','true')
                        $('#baseForm [name="settleupMoney"]').attr('disabled','true')
                        $('#baseForm [name="remark"]').attr('disabled','true')
                        $('#settleupYear').attr('disabled','true')
                        $('#baseForm [name="settleupQuarter"]').attr('disabled','true')
                        $('#baseForm [name="settleupMonth"]').attr('disabled','true')*/
                        //$('#baseForm input').attr('disabled','true')
                        //$('.disabledAll').find('input').attr('disabled', 'disabled');
                        $('.disabledAll input').attr('disabled','true')
                        $('#baseForm select').attr('disabled','true')
                        $('.file_upload_box').hide()
                        $('.deImgs').hide()

                    }
                    form.render()
                },
                yes: function (index) {
                    if(type != '4'){
                        //必填项提示
                        for (var i = 0; i < $('.chen').length; i++) {
                            if ($('.chen').eq(i).val() == '') {
                                layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
                                return false
                            }
                        }
                        //材料计划数据
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value
                        });
                        //分包合同id
                        obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
                        //客商单位名称id
                        obj.customerId=$('.plan_base_info input[name="customerName"]').attr('customerId');

                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent a').eq(i).attr('name');
                        }
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;


                        var isFlag = false;
                        //主表控制逻辑
                        //合同金额-累计已结算-在途结算>=本次结算
                        //合同金额
                        var contractFee = $('#baseForm [name="contractFee"]').val()||0
                        //累计已结算
                        var subsettleupMoney = $('#baseForm [name="subsettleupMoney"]').val()||0
                        //在途结算
                        var trnSettleupMoney = $('#baseForm [name="trnSettleupMoney"]').val()||0
                        //本次结算
                        var settleupMoney = $('#baseForm [name="settleupMoney"]').val()||0

                        if(sub(sub(contractFee,trnSettleupMoney),subsettleupMoney)<settleupMoney){
                            layer.msg('合同金额(主表)-累计已结算(主表)-在途结算(主表)>=本次结算(主表)！', {icon: 0, time: 3000});
                            isFlag = true
                        }

                        //分包结算数据
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var materialDetailsArr = [];
                        $tr.each(function () {
                            var materialDetailsObj = {
                                contractOtherContent: $(this).find('[data-field="contractOtherContent"] .layui-table-cell').text(),
                                contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                                conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                                trnSettleupMoney: $(this).find('[data-field="trnSettleupMoney"] .layui-table-cell').text(),
                                settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                                cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                                cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                                rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                                rbsId: $(this).find('[name="settleupMoney"]').attr('rbsId'),
                                wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                                wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                            }
                            if ($(this).find('[name="settleupMoney"]').attr('subsettleupLisId')) {
                                materialDetailsObj.subsettleupLisId = $(this).find('[name="settleupMoney"]').attr('subsettleupLisId');
                            }
                            if ($(this).find('[name="settleupMoney"]').attr('subsettleupId')) {
                                materialDetailsObj.subsettleupId = $(this).find('[name="settleupMoney"]').attr('subsettleupId');
                            }
                            if ($(this).find('[name="settleupMoney"]').attr('subcontractOutId')) {
                                materialDetailsObj.subcontractOutId = $(this).find('[name="settleupMoney"]').attr('subcontractOutId');
                            }
                            //子表控制逻辑
                            if(sub(sub(materialDetailsObj.contractPrice,materialDetailsObj.conSettleupMoney),materialDetailsObj.trnSettleupMoney)<materialDetailsObj.settleupMoney){
                                layer.msg('合同金额(子表)-累计已结算(子表)-在途结算(子表)>=本次结算(子表)！', {icon: 0, time: 3000});
                                isFlag = true
                            }

                            materialDetailsArr.push(materialDetailsObj);
                        });
                        obj.plbMtlSubsettleupListWithBLOBs = materialDetailsArr;


                        if (isFlag){
                            return false
                        }

                        //结算清单
                        var $tr2 = $('.contract_out').find('.layui-table-main tr');
                        var oldDataArr = [];

                        $tr2.each(function () {
                            var oldDataObj = {
                                quantities: $(this).find('input[name="quantities"]').val(),
                                comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                                totalPrice: $(this).find('input[name="totalPrice"]').val(),
                                sumSettlementQuantities: $(this).find('input[name="sumSettlementQuantities"]').val(),
                                onwaySettlementQuantities: $(this).find('input[name="onwaySettlementQuantities"]').val(),
                                currentSettlementQuantities: $(this).find('input[name="currentSettlementQuantities"]').val()
                            }
                            if ($(this).find('input[name="quantities"]').attr('subsettleupId')) {
                                oldDataObj.subsettleupId = $(this).find('input[name="quantities"]').attr('subsettleupId');
                            }
                            if ($(this).find('input[name="quantities"]').attr('subsettleupDetailsId')) {
                                oldDataObj.subsettleupDetailsId = $(this).find('input[name="quantities"]').attr('subsettleupDetailsId');
                            }
                            oldDataArr.push(oldDataObj);
                        });

                        obj.plbMtlSubsettleupDetails = oldDataArr;

                        obj.projId = parseInt(projId);
                        if (type == 1) {
                            obj.subsettleupId = data.subsettleupId
                        }

                        var loadIndex = layer.load();
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
                    }else {
                        layer.close(index);
                    }
                },
                btn2: function (index, layero) {
                    //必填项提示
                    for (var i = 0; i < $('.chen').length; i++) {
                        if ($('.chen').eq(i).val() == '') {
                            layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
                            return false
                        }
                    }

                    //材料计划数据
                    var datas = $('#baseForm').serializeArray();
                    var obj = {}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });
                    //分包合同id
                    obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
                    //客商单位名称id
                    obj.customerId=$('.plan_base_info input[name="customerName"]').attr('customerId');

                    // 附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId = attachmentId;
                    obj.attachmentName = attachmentName;


                    var isFlag = false;
                    //主表控制逻辑
                    //合同金额-累计已结算-在途结算>=本次结算
                    //合同金额
                    var contractFee = $('#baseForm [name="contractFee"]').val()||0
                    //累计已结算
                    var subsettleupMoney = $('#baseForm [name="subsettleupMoney"]').val()||0
                    //在途结算
                    var trnSettleupMoney = $('#baseForm [name="trnSettleupMoney"]').val()||0
                    //本次结算
                    var settleupMoney = $('#baseForm [name="settleupMoney"]').val()||0

                    if(sub(sub(contractFee,trnSettleupMoney),subsettleupMoney)<settleupMoney){
                        layer.msg('合同金额(主表)-累计已结算(主表)-在途结算(主表)>=本次结算(主表)！', {icon: 0, time: 3000});
                        isFlag = true
                    }

                    //分包结算数据
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        var materialDetailsObj = {
                            contractOtherContent: $(this).find('[data-field="contractOtherContent"] .layui-table-cell').text(),
                            contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                            conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                            trnSettleupMoney: $(this).find('[data-field="trnSettleupMoney"] .layui-table-cell').text(),
                            settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                            cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                            cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                            rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                            rbsId: $(this).find('[name="settleupMoney"]').attr('rbsId'),
                            wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                            wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                        }
                        if ($(this).find('[name="settleupMoney"]').attr('subsettleupLisId')) {
                            materialDetailsObj.subsettleupLisId = $(this).find('[name="settleupMoney"]').attr('subsettleupLisId');
                        }
                        if ($(this).find('[name="settleupMoney"]').attr('subsettleupId')) {
                            materialDetailsObj.subsettleupId = $(this).find('[name="settleupMoney"]').attr('subsettleupId');
                        }
                        if ($(this).find('[name="settleupMoney"]').attr('subcontractOutId')) {
                            materialDetailsObj.subcontractOutId = $(this).find('[name="settleupMoney"]').attr('subcontractOutId');
                        }
                        //子表控制逻辑
                        if(sub(sub(materialDetailsObj.contractPrice,materialDetailsObj.conSettleupMoney),materialDetailsObj.trnSettleupMoney)<materialDetailsObj.settleupMoney){
                            layer.msg('合同金额(子表)-累计已结算(子表)-在途结算(子表)>=本次结算(子表)！', {icon: 0, time: 3000});
                            isFlag = true
                        }

                        materialDetailsArr.push(materialDetailsObj);
                    });
                    obj.plbMtlSubsettleupListWithBLOBs = materialDetailsArr;


                    if (isFlag){
                        return false
                    }

                    //结算清单
                    var $tr2 = $('.contract_out').find('.layui-table-main tr');
                    var oldDataArr = [];

                    $tr2.each(function () {
                        var oldDataObj = {
                            quantities: $(this).find('input[name="quantities"]').val(),
                            comprehensiveUnitPrice: $(this).find('input[name="comprehensiveUnitPrice"]').val(),
                            totalPrice: $(this).find('input[name="totalPrice"]').val(),
                            sumSettlementQuantities: $(this).find('input[name="sumSettlementQuantities"]').val(),
                            onwaySettlementQuantities: $(this).find('input[name="onwaySettlementQuantities"]').val(),
                            currentSettlementQuantities: $(this).find('input[name="currentSettlementQuantities"]').val()
                        }
                        if ($(this).find('input[name="quantities"]').attr('subsettleupId')) {
                            oldDataObj.subsettleupId = $(this).find('input[name="quantities"]').attr('subsettleupId');
                        }
                        if ($(this).find('input[name="quantities"]').attr('subsettleupDetailsId')) {
                            oldDataObj.subsettleupDetailsId = $(this).find('input[name="quantities"]').attr('subsettleupDetailsId');
                        }
                        oldDataArr.push(oldDataObj);
                    });

                    obj.plbMtlSubsettleupDetails = oldDataArr;

                    obj.projId = parseInt(projId);
                    if (type == 1) {
                        obj.subsettleupId = data.subsettleupId
                    }

                    var loadIndex = layer.load();
                    $.ajax({
                        url: url,
                        data: JSON.stringify(obj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.open({
                                    type: 1,
                                    title: '选择流程',
                                    area: ['70%', '80%'],
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                    success: function () {
                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '50'}, function (res) {
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
                                            var approvalData = res.object;
                                            delete plbMtlSubsettleupListWithBLOBs;
                                            delete plbMtlSubsettleupDetails;
                                            approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                            approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                            newWorkFlow(flowData.flowId, function (res) {
                                                var submitData = {
                                                    subsettleupId:approvalData.subsettleupId,
                                                    runId: res.flowRun.runId,
                                                    //manageProjStatus:1
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.ajax({
                                                    url: url,
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
                                            },approvalData);
                                        } else {
                                            layer.close(loadIndex);
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }
                    });
                },
                btn3: function (index, layero) {
                    layer.close(index);
                }
            });
        }

        //提交审核
        /*function submit(checkStatus) {
            if (checkStatus.data.length != 1) {
                layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                return false;
            }

            if (checkStatus.data[0].auditerStatus == '1') {
                layer.msg('所选数据正在审批中，无法再次提交审批！', {icon: 0, time: 2000});
                return false;
            }
            if (checkStatus.data[0].auditerStatus == '3' || checkStatus.data[0].auditerStatus == '2') {
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
                content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
                success: function () {
                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '30'}, function (res) {
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
                                subsettleupId: approvalData.subsettleupId,
                                runId: res.flowRun.runId,
                                //auditerStatus: 1
                            }
                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                            $.ajax({
                                url: '/plbMtlSubsettleup/updatePlbMtlSubsettleup',
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
        }*/

        // 点击选分包合同
        $(document).on('click', '.chooseManagementBudget', function () {
            // if(!$('#baseForm [name="customerName"]').attr('customerId')){
            //     layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
            //     return false
            // }
            var contractTableObj = null
            layer.open({
                type: 1,
                title: '选择分包合同',
                area: ['80%', '80%'],
                maxmin: true,
                btnAlign:'c',
                btn: ['确定', '取消'],
                content: ['<div class="layui-form" id="contractTableModule">' +
                '<div class="layui-row" style="margin-top: 10px;margin-left: 5px">' +
                '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractNo" type="text" autocomplete="off" placeholder="合同编号" class="layui-input" /></div>' +
                '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractName" type="text" autocomplete="off" placeholder="合同名称" class="layui-input" /></div>' +
                '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="customerName" type="text" autocomplete="off" placeholder="分包商" class="layui-input" /></div>' +
                '<div class="layui-col-xs3" style="padding-top: 3px;"><button class="layui-btn layui-btn-sm" id="searchContract">查询</button></div>' +
                '</div>' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {

                    contractTableObj = table.render({
                        elem: '#mtlPlanIdTable',
                        url: '/plbMtlSubcontract/selectAll',
                        where:{projId:$('#leftId').attr('projId'),approvalStatus:"2"},
                        page:true,
                        cols: [[
                            {type: 'radio'},
                            {field: 'subcontractNo', title: '合同编号', sort: true, hide: false},
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
                            {field: 'settleupMoney', title: '累计已结算金额',templet: function (d) {
                                    return d.settleupMoney || 0
                                }
                            }
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
                        var contractNo = $('#contractTableModule input[name="contractNo"]').val();
                        var contractName = $('#contractTableModule input[name="contractName"]').val();
                        var customerName=$('#contractTableModule input[name="customerName"]').val();
                        contractTableObj.reload({
                            where: {
                                contractNo: contractNo,
                                contractName: contractName,
                                customerName:customerName
                            }
                        });
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('mtlPlanIdTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];
                        $('#baseForm [name="contractName"]').val(chooseData.contractName)
                        $('#baseForm [name="contractName"]').attr('subcontractId',chooseData.subcontractId)
                        //$('#baseForm [name="contractName"]').data('data',chooseData.plbMtlSubcontractOuts)
                        plbMtlSubcontractOuts = chooseData.plbMtlSubcontractOuts
                        $('#baseForm [name="customerName"]').val(chooseData.customerName);
                        $('#baseForm [name="customerName"]').attr("customerId",chooseData.customerId);
                        //合同金额
                        $('#baseForm [name="contractFee"]').val(chooseData.contractMoney)

                        //累计已结算金额
                        $('#baseForm [name="subsettleupMoney"]').val(chooseData.settleupMoney || 0)

                        $('#baseForm [name="trnSettleupMoney"]').val(chooseData.trnSettleupMoney || 0)

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });

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

        /*//查看单条数据
        function checkSettlement(baseFormInfo) {
            layer.open({
                type: 1,
                title: '查看合同',
                area: ['70%', '80%'],
                btn: ['关闭'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse">\n',
                    /!* region 分包结算 *!/
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">分包结算</h2>\n' +
                    '    <div class="layui-colla-content layui-show plan_base_info">' +
                    '       <form class="layui-form" id="baseForm" lay-filter="baseForm">',
                    /!* region 第一行 *!/
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">客商单位名称<span class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="customerName" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input chen " title="客商单位名称">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算日期<span class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="settleupDate" readonly style="background:#e7e7e7;" id="settleupDate" autocomplete="off" class="layui-input chen" title="结算日期">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同金额<span class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="contractFee" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input chen chinese" title="合同金额">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /!* endregion *!/
                    /!* region 第二行 *!/
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同名称</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                    '                       <input type="text" name="contractName" readonly autocomplete="off" class="layui-input chooseManagementBudget" style="padding-right: 25px;background:#e7e7e7;">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">本次结算金额</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="settleupMoney" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input chinese" title="本次结算金额">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">备注</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="remark" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /!* endregion *!/
                    /!* region 第三行 *!/
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算年</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" id="settleupYear" readonly style="background:#e7e7e7;" name="settleupYear" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算季</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <select name="settleupQuarter" disabled><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算月</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <select name="settleupMonth" disabled>' +
                    '                               <option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>' +
                    '                               <option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>' +
                    '                               <option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>' +
                    '                           </select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' +
                    /!* endregion *!/
                    /!* region 第七行 *!/
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">结算合同附件</label>' +
                    '                       <div class="layui-input-block form_block">' +
                    '<div class="file_module">' +
                    '<div id="fileContent" class="file_content"></div>' +
                    '<div class="file_upload_box">' +
                    '<a href="javascript:;" class="open_file">' +
                    '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
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
                    '           </div>',
                    /!* endregion *!/
                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n',
                    /!* endregion *!/
                    /!* region 分包结算明细 *!/
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">分包结算明细</h2>\n' +
                    '    <div class="layui-colla-content mtl_info layui-show">' +
                    '       <div>' +
                    '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                    '      </div>' +
                    '    </div>\n' +
                    '  </div>\n',
                    /!* endregion *!/
                    '</div>'].join(''),
                success: function () {
                    element.render();
                    form.render();
                    var materialDetailsTableData = [];

                    materialDetailsTableData = baseFormInfo.plbMtlSubsettleupListWithBLOBs

                    form.val("baseForm", baseFormInfo);

                    table.render({
                        elem: '#materialDetailsTable',
                        data: materialDetailsTableData,
                        defaultToolbar: [''],
                        cols: [[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'wbsName', title: 'WBS_ID'
                            },
                            {
                                field: 'cbsName', title: 'CBS_ID'
                            },
                            {
                                field: 'contractPrice', title: '合同金额',
                            },
                            {
                                field: 'conSettleupMoney', title: '累计结算金额',
                            },
                            {
                                field: 'settleupMoney', title: '本次结算金额'
                            },
                            {
                                field: 'remark', title: '备注'
                            }
                        ]]
                    });
                }
            });
        }*/

        /**
         * 新建流程方法
         * @param flowId
         * @param approvalData
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

        // //选择客商单位名称
        // $(document).on('click', '.chooseCustomerName', function () {
        //     var _this = $(this);
        //     layer.open({
        //         type: 1,
        //         title: '选择分包商',
        //         area: ['70%', '80%'],
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
        //             '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
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
        //                 materialsTable = table.render({
        //                     elem: '#materialsTable',
        //                     url: '/PlbCustomer/getDataByCondition',
        //                     where: {
        //                         merchantType:typeNo,
        //                         useFlag: true
        //                     },
        //                     page: true, //开启分页
        //                     limit: 50,
        //                     height: 'full-180'
        //                     , toolbar: '#toolbar'
        //                     , defaultToolbar: ['']
        //                     ,
        //                     cols: [[ //表头
        //                         {type: 'radio'}
        //                         , {field: 'customerNo', title: '客商编号', sort: true, width: 200}
        //                         , {field: 'customerName', title: '客商单位名称',}
        //                         , {field: 'customerShortName', title: '客商单位简称',}
        //                         , {field: 'customerOrgCode', title: '组织机构代码'}
        //                         , {field: 'taxNumber', title: '税务登记号'}
        //                         , {field: 'accountNumber', title: '开户行账户'}
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
        //
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

        //监听本次结算金额
        $(document).on('input propertychange', '[name="settleupMoney"]', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var settleupMoneySum=0
            $tr.each(function () {
                settleupMoneySum=accAdd(settleupMoneySum,$(this).find('input[name="settleupMoney"]').val())
            });
            $('#baseForm #settleup_Money').val(settleupMoneySum)
        });

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
        tableIns.config.where._ = new Date().getTime();
        tableIns.reload();
    }
</script>
</body>
</html>