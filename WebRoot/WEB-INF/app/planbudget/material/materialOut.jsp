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
    <title>材料出库</title>

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
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>

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
            <h2 style="text-align: center;line-height: 35px;">材料出库</h2>
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
                    <input type="text" name="mtlStockOutNo" placeholder="出库单编号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="stockOutDate" placeholder="出库日期"  readonly autocomplete="off" class="layui-input">
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
    </div>

    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
    </div>
</script>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">选择出库材料</button>
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
        TAX_RATE:{},
        MATERIALOUT_TYPE:{}
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,TAX_RATE,MATERIALOUT_TYPE';
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

    //仓库显示
    var warehouseStr = ''
    var warehouseObj = {}
    $.get('/plbWarehouse/selectAll', {useFlag: false}, function (res) {
        var data = res.obj
        if (res.flag) {
            data.forEach(function (item, index) {
                warehouseStr += '<option value=' + item.warehouseId + '>' + item.warehouseName + '</option>'
                warehouseObj[item.warehouseId] = item.warehouseName;
            })
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

        laydate.render({
            elem: '.query_module [name="stockOutDate"]' //指定元素
            , trigger: 'click' //采用click弹出
        });

        form.render();
        //表格显示顺序
        var colShowObj = {
            mtlStockOutNo: {field: 'mtlStockOutNo', title: '出库单编号', sort: true, hide: false},
            projName:{field:'projName',title:'所属项目',sort:true,hide:false},
            /*warehouseId: {
                field: 'warehouseId', title: '仓库', sort: true, hide: false, templet: function (d) {
                    return warehouseObj[d.warehouseId] || ''
                }
            },*/
            stockOutReceiver: {field: 'stockOutReceiver', title: '领料人', sort: true, hide: false},
            stockOutDate: {
                field: 'stockOutDate', title: '出库日期', sort: true, hide: false, templet: function (d) {
                    return format(d.stockOutDate);
                }
            },
            stockOutQuantity: {field: 'stockOutQuantity', title: '出库数量', sort: true, hide: false},
            outMoney: {field: 'outMoney', title: '出库金额', sort: true, hide: false},
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
            },
            remark: {field: 'remark', title: '出库备注', sort: true, hide: false},
        }

        var TableUIObj = new TableUI('plb_mtl_stock_out');


        // 初始化左侧项目
        projectLeft();
        // 上方按钮显示
        table.on('toolbar(tableDemo)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
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
                    newOrEdit(1, checkStatus.data[0])
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var mtlStockOutId = ''
                    var isFlay = false;

                    checkStatus.data.forEach(function (v, i) {
                        mtlStockOutId += v.mtlStockOutId + ','
                        if(v.auditerStatus&&v.auditerStatus!='0'){
                            isFlay = true
                        }
                    })
                    if(isFlay){
                        layer.msg('已提交不可删除！', {icon: 0});
                        return false
                    }
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbMtlStockOut/delete', {mtlStockOutIds: mtlStockOutId}, function (res) {
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
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '38'}, function (res) {
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
                                        mtlStockOutId:approvalData.mtlStockOutId,
                                        runId: res.flowRun.runId,
                                        //auditerStatus:1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/plbMtlStockOut/updateStockOut',
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
                    var warehouseId=$("select[name='warehouseId']").val();
                    if(warehouseId==""||warehouseId==undefined){
                        layer.msg('请选择出库仓库！', {icon: 0});
                        return false
                    }
                    layer.open({
                        type: 1,
                        title: '选择出库材料',
                        area: ['80%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" style="padding:0px 10px">' +
                        '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                        '                <div class="layui-col-xs2">\n' +
                        '                    <input type="text" name="mtlStockInNo" placeholder="入库单编号" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                        '                    <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                        '                    <input type="text" name="mtlContractName" placeholder="合同名称" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                        '                    <input type="text" id="stockInDateStr" name="stockInDateStr" placeholder="入库日期" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
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
                            laydate.render({
                                elem:'#stockInDateStr',
                                trigger:'click'
                            })
                            var tableDemoIn=table.render({
                                elem: '#tableDemoIn',
                                url: '/plbMtlStockIn/getDataByConditionPlus?warehouseId='+warehouseId+'&showStockInSum=showStockInSum&auditerStatus=2&projId='+$('#leftId').attr('projId'),
                                cols: [[
                                    {field: 'mtlStockInNo', title: '入库单编号',minWidth:100},
                                    // {field: 'warehouseName', title: '仓库名称',},
                                    {field: 'customerName', title: '客商单位名称',},
                                    {field: 'mtlContractName', title: '合同名称',minWidth:100},
                                    {
                                        field: 'stockInDate', title: '入库日期',minWidth:100,templet: function (d) {
                                            return format(d.stockInDate);
                                        }
                                    },
                                    {field: 'stockInTotal', title: '入库总数量',minWidth:80},
                                    {field: 'sumDeliveryQuantity', title: '已出库总数量',minWidth:100,templet:function(d){
                                            return d.sumDeliveryQuantity || 0
                                        }
                                    },
                                    {field: 'onWayOutAmount', title: '在途中出库数量',minWidth: 150,templet: function (d) {
                                            return d.onWayOutAmount || 0
                                        }},
                                    {field: 'outInTotal', title: '累计调拨数量',minWidth: 150,templet: function (d) {
                                            return d.outInTotal || 0
                                        }},
                                    {field: 'onWayOutInAmount', title: '在途中调拨数量',minWidth: 150,templet: function (d) {
                                            return d.onWayOutInAmount || 0
                                        }},
                                    {field: 'stockInDate', title: '入库日期',minWidth: 110}
                                ]],
                                // height: 'full-430',
                                page: true,
                                // where: {
                                //     projId: $('#leftId').attr('projId'),
                                //     auditerStatus:"2"
                                // },
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
                                done:function(){
                                    delete this.where.mtlStockInNo;
                                    delete this.where.mtlContractName;
                                    delete this.where.customerName;
                                    delete this.where.stockInDateStr;
                                }
                            });
                            $('.InSearchData').click(function(){
                                var mtlStockInNo=$('[name="mtlStockInNo"]').val();
                                var mtlContractName=$('[name="mtlContractName"]').val();
                                var customerName=$('[name="customerName"]').val();
                                var stockInDateStr=$('[name="stockInDateStr"]').val();
                                tableDemoIn.reload({
                                    where:{
                                        mtlStockInNo:mtlStockInNo,
                                        mtlContractName:mtlContractName,
                                        customerName:customerName,
                                        stockInDateStr:stockInDateStr,
                                    }
                                })
                            })
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
                                    mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell').text(),
                                    mtlStockInNo: $(this).find('[data-field="mtlStockInNo"] .layui-table-cell').text(),
                                    taxPeice: $(this).find('[data-field="taxPeice"] .layui-table-cell').text(),
                                    noTaxPeice: $(this).find('[data-field="noTaxPeice"] .layui-table-cell').text(),
                                    taxRate: $(this).find('[data-field="taxRate"] .layui-table-cell').text(),
                                    stockOutQuantity: $(this).find('input[name="stockOutQuantity"]').val(),
                                    taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                                    noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                                    usePlace: $(this).find('input[name="usePlace"]').val(),
                                    stockInListId: $(this).find('input[name="stockOutQuantity"]').attr('stockInListId'),
                                    stockInQuantity: $(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),//入库数量
                                    issuedQuantity: $(this).find('[data-field="issuedQuantity"] .layui-table-cell').text(),//已出库数量
                                    wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                                    wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                                    rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                                    rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                                    cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                                    cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                                    valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),//单位
                                    onWayOutAmount: $(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text(),//在途中出库数量
                                    outInTotal: $(this).find('[data-field="outInTotal"] .layui-table-cell').text(),//累计调拨数量
                                    onWayOutInAmount: $(this).find('[data-field="onWayOutInAmount"] .layui-table-cell').text(),//在途中调拨数量
                                    stockInDate: $(this).find('[data-field="stockInDate"] .layui-table-cell').text()//入库日期
                                }
                                if ($(this).find('input[name="stockOutQuantity"]').attr('stockOutListId')) {
                                    oldDataObj.stockOutListId = $(this).find('input[name="stockOutQuantity"]').attr('stockOutListId');
                                }
                                oldDataArr.push(oldDataObj);
                            });
                            /*var addRowData = {
                                mtlName: data[0].mtlName,
                                mtlStandard: data[0].mtlStandard,
                                mtlStockInNo: data[0].mtlStockInNo,
                                taxPeice: data[0].stockInPrice,
                                noTaxPeice: data[0].noTaxPeice,
                                taxRate: data[0].taxRate,
                                taxMoney: data[0].taxMoney,
                                noTaxMoney: data[0].noTaxMoney,
                                stockInListId: data[0].stockInListId,
                            };
                            oldDataArr.push(addRowData);*/
                            //具体明细可多选
                            data.forEach(function (item) {
                                var addRowData={
                                    mtlName: item.mtlName,
                                    mtlStandard: item.mtlStandard,
                                    mtlStockInNo: item.mtlStockInNo,
                                    taxPeice:retainDecimal(item.taxPeice,3),
                                    noTaxPeice: retainDecimal(item.noTaxPeice,8),
                                    /*taxMoney:retainDecimal(item.taxMoney,2),
                                    noTaxMoney: retainDecimal(item.noTaxMoney,2),*/
                                    taxRate: dictionaryObj['TAX_RATE']['object'][item.taxRate] || '',
                                    stockInListId: item.stockInListId,
                                    stockInQuantity: retainDecimal(item.stockInQuantity,3) || 0, //本次入库数量
                                    issuedQuantity: retainDecimal(item.sumDeliveryQuantity,3) || 0, //已出库数量
                                    usePlace: item.usePlace, //需用部位
                                    wbsName: item.wbsName,
                                    wbsId: item.wbsId,
                                    rbsName: item.rbsName,
                                    rbsId: item.rbsId,
                                    cbsName: item.cbsName,
                                    controlType:item.controlType,
                                    cbsId: item.cbsId,
                                    valuationUnit: item.mtlValuationUnit,//单位
                                    onWayOutAmount: retainDecimal(item.onWayOutAmount,3) || 0,//在途中出库数量
                                    outInTotal: retainDecimal(item.outInTotal,3) || 0,//累计调拨数量
                                    onWayOutInAmount: retainDecimal(item.onWayOutInAmount,3) || 0,//在途中调拨数量
                                    stockInDate: item.stockInDate//入库日期
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
                if (data.stockOutListId) {
                    $.get('/plbMtlStockOutList/delete', {stockOutListId: data.stockOutListId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                        mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell').text(),
                        mtlStockInNo: $(this).find('[data-field="mtlStockInNo"] .layui-table-cell').text(),
                        taxPeice: $(this).find('[data-field="taxPeice"] .layui-table-cell').text(),
                        noTaxPeice: $(this).find('[data-field="noTaxPeice"] .layui-table-cell').text(),
                        taxRate: $(this).find('[data-field="taxRate"] .layui-table-cell').text(),
                        stockOutQuantity: $(this).find('input[name="stockOutQuantity"]').val(),
                        taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                        noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                        usePlace: $(this).find('input[name="usePlace"]').val(),
                        stockInListId: $(this).find('input[name="stockOutQuantity"]').attr('stockInListId'),
                        stockInQuantity: $(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),//入库数量
                        issuedQuantity: $(this).find('[data-field="issuedQuantity"] .layui-table-cell').text(),//已出库数量
                        wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                        wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                        rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                        rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                        cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                        valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),//单位
                        onWayOutAmount: $(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text(),//在途中出库数量
                        outInTotal: $(this).find('[data-field="outInTotal"] .layui-table-cell').text(),//累计调拨数量
                        onWayOutInAmount: $(this).find('[data-field="onWayOutInAmount"] .layui-table-cell').text(),//在途中调拨数量
                        stockInDate: $(this).find('[data-field="stockInDate"] .layui-table-cell').text()//入库日期

                    }
                    if ($(this).find('input[name="stockOutQuantity"]').attr('stockOutListId')) {
                        oldDataObj.stockOutListId = $(this).find('input[name="stockOutQuantity"]').attr('stockOutListId');
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });
        //监听行单击事件
        table.on('row(tableDemoIn)', function (obj) {
            // console.log(obj.data) //得到当前行数据
            var data = obj.data
            $('#downBox').show()
            obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
            obj.tr.attr('mtlContractId', data.mtlContractId)
            tableShowDown(data.mtlStockInId)
        });

        //出库明细表格
        function tableShowDown(mtlStockInId) {
            table.render({
                elem: '#tableDemoInDown',
                url: '/plbMtlStockIn/getChildList',
                cellMinWidth:150,
                cols: [[
                    {type: 'checkbox'},
                    {field: 'mtlStockInNo', title: '入库单编号',},
                    {field: 'wbsName', title: 'WBS',},
                    {field: 'rbsName', title: 'RBS',},
                    {field: 'cbsName', title: 'CBS',},
                    {field: 'mtlName', title: '材料名称',},
                    {field: 'mtlStandard', title: '材料规格',},
                    {field:'valuationUnit',title:'单位',minWidth:70,templet:function(d){
                            return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || ''
                        }},
                    {field: 'stockInQuantity', title: '本次入库数量',},
                    {field: 'sumSurplusQuantity', title: '剩余库存量',},
                    {field: 'onWayOutAmount', title: '在途中出库数量',minWidth: 150,templet: function (d) {
                            return d.onWayOutAmount || 0
                        }},
                    {field: 'outInTotal', title: '累计调拨数量',minWidth: 150,templet: function (d) {
                            return d.outInTotal || 0
                        }},
                    {field: 'onWayOutInAmount', title: '在途中调拨数量',minWidth: 150,templet: function (d) {
                            return d.onWayOutInAmount || 0
                        }},
                    {field: 'sumDeliveryQuantity', title: '已出库数量',},
                    {field: 'taxPeice', title: '含税单价',},
                    {field: 'noTaxPeice', title: '不含税单价',},
                    {
                        field: 'taxRate', title: '税率', minWidth: 100, templet: function (d) {
                            return dictionaryObj['TAX_RATE']['object'][d.taxRate] || ''; //税率
                        }
                    },
                    {field: 'stockInDate', title: '入库日期',minWidth: 110}
                ]],
                // height: 'full-430',
                page: true,
                where: {
                    mtlStockInId: mtlStockInId,
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
                url: '/plbMtlStockOut/selectAll',
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
                    orderbyUpdown: TableUIObj.orderbyUpdown,
                    useFlag:true
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
            var projId = $('#leftId').attr('projId');
            $('#leftId').attr('_type',type);
            if (type == '0') {
                title = '新建材料出库';
                url = '/plbMtlStockOut/insertPlus';
            } else if (type == '1') {
                title = '编辑材料出库';
                url = '/plbMtlStockOut/update';
            }else if(type == '4'){
                title = '查看详情'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: type != '4'?['保存','提交审批', '取消']:['确定'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse">\n' +
                /* region 材料计划 */
                '  <div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title">基本信息</h2>\n' +
                '    <div class="layui-colla-content layui-show plan_base_info">' +
                '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
                /* region 第一行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">出库单编号<span field="mtlStockOutNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="mtlStockOutNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
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
                '                       <label class="layui-form-label form_label">出库仓库<span field="warehouseId" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <select name="warehouseId"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">领料人<span field="stockOutReceiver" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="stockOutReceiver" autocomplete="off" class="layui-input">' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">出库日期<span field="stockOutDate" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="stockOutDate" readonly id="stockOutDate" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                /* endregion */
                /* region 第二行 */
                // '           <div class="layui-row">' +
                //
                //
                // '           </div>' +
                /* endregion */
                /* region 第三行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">出库数量<span field="stockOutQuantity" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="number" name="stockOutQuantity" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">出库金额</label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="number" name="outMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
                '                        <div class="layui-form-item">\n' +
                '                            <label class="layui-form-label form_label">出库类型<span field="materialOutType" class="field_required">*</span></label>\n' +
                '                            <div class="layui-input-block form_block">\n' +
                '                                <select name="materialOutType" id="materialOutType" lay-filter="test">\n' +
                '                                </select>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
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
                '           </div>',
                    /* endregion */

                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n' +
                    /* endregion */
                    /* region 出库明细 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">出库明细</h2>\n' +
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
                    //出库类型
                    $('[name="materialOutType"]').append(dictionaryObj['MATERIALOUT_TYPE']['str']);
                    form.render();
                    var materialDetailsTableData = [];
                    //回显数据
                    if (type == 1 || type == 4) {
                        form.val("formTest", data);

                        //附件
                        if (data.attachments && data.attachments.length > 0) {
                            var fileArr = data.attachments;
                            $('#fileContent').append(echoAttachment(fileArr));
                        }

                        materialDetailsTableData = data.plbMtlStockOutListWithBLOBs;

                        //查看详情
                        if(type==4){
                            //$('.layui-layer-btn-c').hide()
                            $('[name="stockOutReceiver"]').attr('disabled','true')
                            $('#stockOutDate').attr('disabled','true')
                            $('[name="remark"]').attr('disabled','true')
                            $('.deImgs').hide()
                            $('.file_upload_box').hide();
                        }
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbMtlStockOut'}, function(res) {
                            $('input[name="mtlStockOutNo"]', $('#baseForm')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbMtlStockOut'}, function(res) {
                                $('input[name="mtlStockOutNo"]', $('#baseForm')).val(res);
                            });
                        });
                    }
                    $.get('/plbWarehouse/selectAll', {useFlag: false,projId:projId}, function (res) {
                        var obj=res.obj
                        if (res.flag) {
                            // var warehouseStr='<option value=""></option>'
                            var warehouseStr='';
                            obj.forEach(function (item,index) {
                                warehouseStr+='<option value=' + item.warehouseId + '>' + item.warehouseName + '</option>'
                            })
                            $('select[name="warehouseId"]').html(warehouseStr)
                            form.render()
                            //回显仓库下拉框
                            if(type==4){
                                $('select[name="warehouseId"]').val(data.warehouseId);
                                $('select[name="warehouseId"]').attr("disabled",true);
                                form.render()
                            }
                        }
                    });
                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#stockOutDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.stockOutDate) : ''
                    });

                    var cols=[
                        {field: 'mtlStockInNo', title: '入库单编号',width: 150},
                        {field: 'wbsName', title: 'WBS', width: 200,templet: function (d) {
                                return '<span wbsId="'+(d.wbsId || '')+'">'+(d.wbsName || '')+'</span>'
                            }},
                        {field: 'rbsName', title: 'RBS', width: 200,templet: function (d) {
                                return '<span rbsId="'+(d.rbsId || '')+'">'+(d.rbsName || '')+'</span>'
                            }},
                        {field: 'cbsName', title: 'CBS', width: 150,templet: function (d) {
                                return '<span cbsId="'+(d.cbsId || '')+'">'+(d.cbsName || '')+'</span>'
                            }},
                        {field: 'mtlName', title: '材料名称', width: 150,},
                        {field: 'mtlStandard', title: '材料规格',width: 150},
                        // {field: 'valuationUnit', title: '单位',width: 150},
                        {
                            field: 'valuationUnit', title: '单位', width: 90, templet: function (d) {
                                // if(d.controlType!=undefined&&d.controlType=="01"){
                                //     return '<input type="text" name="valuationUnit" mtlValuationUnit="'+(d.valuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                                // }else{
                                //     return '<input type="text" name="valuationUnit" mtlValuationUnit="'+(d.valuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '') + '">'
                                // }
                                return '<input type="text" name="valuationUnit" valuationUnit="'+(d.valuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                            }
                        },
                        {field: 'stockInQuantity', title: '入库数量',width: 150},
                        {field: 'issuedQuantity', title: '已出库数量',width: 150},
                        {field: 'onWayOutAmount', title: '在途中出库数量',width: 150},
                        // {field: 'outInTotal', title: '累计调拨数量',width: 150},
                        // {field: 'onWayOutInAmount', title: '在途中调拨数量',width: 150},
                        {
                            field: 'stockOutQuantity', title: '本次出库数量*', width: 200,templet: function (d) {
                                return '<input type="number" name="stockOutQuantity" '+(type==4 ? 'readonly' : '')+' stockOutListId="'+(d.stockOutListId || '')+'" stockInListId="'+(d.stockInListId || '')+'" class="layui-input stockOutQuantityItem" style="height: 100%;" value="' + (d.stockOutQuantity ? retainDecimal(d.stockOutQuantity,3) : '') + '">'
                            }
                        },
                        {field: 'taxPeice', title: '含税单价',width: 150},
                        {field: 'noTaxPeice', title: '不含税单价',width: 150},
                        {field: 'taxRate', title: '税率',width: 80},
                        {
                            field: 'taxMoney', title: '含税总价',width: 150,templet: function (d) {
                                return '<input type="text" name="taxMoney" readonly autocomplete="off" class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.taxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'noTaxMoney', title: '不含税总价',width: 150, templet: function (d) {
                                return '<input type="text" name="noTaxMoney" readonly autocomplete="off" class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.noTaxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'usePlace', title: '需用部位',width: 150, templet: function (d) {
                                return '<input type="text" name="usePlace" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%;" value="' + (d.usePlace || '') + '">'
                            }
                        },
                        {field: 'stockInDate', title: '入库日期',minWidth: 110}
                    ]

                    if(type!=4){
                        cols.push({align: 'center', toolbar: '#barDemo',fixed:'right',title: '操作', width: 100})
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
                            }
                        }
                    });
                },
                yes: function (index) {
                    if(type!=4){
                        var lock=false
                        //基本信息数据
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value
                        });

                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent a').eq(i).attr('name');
                        }
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;

                        //出库明细数据
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var materialDetailsArr = [];
                        $tr.each(function () {
                            if($(this).find('input[name="stockOutQuantity"]').val() == ''){
                                layer.msg('请填写本次出库数量！', {icon: 0});
                                lock=true
                                return false
                            }
                            //入库数量-已出库数量-在途中出库数量-本次出库数量>=0,否则无法提交
                            var sum=sub(sub(sub($(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),$(this).find('[data-field="issuedQuantity"] .layui-table-cell').text()),$(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text()),$(this).find('input[name="stockOutQuantity"]').val())
                            if(sum < 0){
                                layer.msg('需入库数量-已出库数量-在途中出库数量-本次出库数量>=0,否则无法提交！', {icon: 0});
                                lock=true
                                return false
                            }


                            var materialDetailsObj = {
                                mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                                mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell').text(),
                                mtlStockInNo: $(this).find('[data-field="mtlStockInNo"] .layui-table-cell').text(),
                                taxPeice: $(this).find('[data-field="taxPeice"] .layui-table-cell').text(),
                                noTaxPeice: $(this).find('[data-field="noTaxPeice"] .layui-table-cell').text(),
                                taxRate: $(this).find('[data-field="taxRate"] .layui-table-cell').text(),
                                stockOutQuantity: retainDecimal($(this).find('input[name="stockOutQuantity"]').val(),3),
                                taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                                noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                                usePlace: $(this).find('input[name="usePlace"]').val(),
                                stockInListId: $(this).find('input[name="stockOutQuantity"]').attr('stockInListId'),
                                stockInQuantity: $(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),//入库数量
                                issuedQuantity: $(this).find('[data-field="issuedQuantity"] .layui-table-cell').text(),//已出库数量
                                wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                                wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                                rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                                rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                                cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                                cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                                valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),// $(this).find('[data-field="valuationUnit"] .layui-table-cell').text(),//单位
                                onWayOutAmount: $(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text(),//在途中出库数量
                                outInTotal: $(this).find('[data-field="outInTotal"] .layui-table-cell').text(),//累计调拨数量
                                onWayOutInAmount: $(this).find('[data-field="onWayOutInAmount"] .layui-table-cell').text(),//在途中调拨数量
                                stockInDate: $(this).find('[data-field="stockInDate"] .layui-table-cell').text()//入库日期
                            }
                            if ($(this).find('input[name="stockOutQuantity"]').attr('stockOutListId')) {
                                materialDetailsObj.stockOutListId = $(this).find('input[name="stockOutQuantity"]').attr('stockOutListId');
                            }
                            materialDetailsArr.push(materialDetailsObj);
                        });
                        obj.plbMtlStockOutlistWithBLOBS = materialDetailsArr;

                        if(lock){
                            return false
                        }


                        var loadIndex = layer.load();
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
                            layer.close(loadIndex);
                            return false;
                        }

                        if (type == 1) {
                            obj.mtlStockOutId = data.mtlStockOutId
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
                                    layer.msg('保存失败！', {icon: 2});
                                }
                            }
                        });
                    }else {
                        layer.close(index);
                    }
                },btn2:function(){
                    if(data!=undefined&&data.auditerStatus != undefined&&data.auditerStatus != '0'){
                        layer.msg('该数据已提交！', {icon: 0, time: 2000});
                        return false;
                    }
                    var lock=false
                    //基本信息数据
                    var datas = $('#baseForm').serializeArray();
                    var obj = {}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });

                    // 附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId = attachmentId;
                    obj.attachmentName = attachmentName;
                    //出库明细数据
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        if($(this).find('input[name="stockOutQuantity"]').val() == ''){
                            layer.msg('请填写本次出库数量！', {icon: 0});
                            lock=true
                            return false
                        }
                        //入库数量-已出库数量-在途中出库数量-本次出库数量>=0,否则无法提交
                        var sum=sub(sub(sub($(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),$(this).find('[data-field="issuedQuantity"] .layui-table-cell').text()),$(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text()),$(this).find('input[name="stockOutQuantity"]').val())
                        if(sum < 0){
                            layer.msg('需入库数量-已出库数量-在途中出库数量-本次出库数量>=0,否则无法提交！', {icon: 0});
                            lock=true
                            return false
                        }


                        var materialDetailsObj = {
                            mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                            mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell').text(),
                            mtlStockInNo: $(this).find('[data-field="mtlStockInNo"] .layui-table-cell').text(),
                            taxPeice: $(this).find('[data-field="taxPeice"] .layui-table-cell').text(),
                            noTaxPeice: $(this).find('[data-field="noTaxPeice"] .layui-table-cell').text(),
                            taxRate: $(this).find('[data-field="taxRate"] .layui-table-cell').text(),
                            stockOutQuantity: $(this).find('input[name="stockOutQuantity"]').val(),
                            taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                            noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                            usePlace: $(this).find('input[name="usePlace"]').val(),
                            stockInListId: $(this).find('input[name="stockOutQuantity"]').attr('stockInListId'),
                            stockInQuantity: $(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),//入库数量
                            issuedQuantity: $(this).find('[data-field="issuedQuantity"] .layui-table-cell').text(),//已出库数量
                            wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                            wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                            rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                            rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                            cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                            cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                            valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),//$(this).find('[data-field="valuationUnit"] .layui-table-cell').text(),//单位
                            onWayOutAmount: $(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text(),//在途中出库数量
                            outInTotal: $(this).find('[data-field="outInTotal"] .layui-table-cell').text(),//累计调拨数量
                            onWayOutInAmount: $(this).find('[data-field="onWayOutInAmount"] .layui-table-cell').text(),//在途中调拨数量
                            stockInDate: $(this).find('[data-field="stockInDate"] .layui-table-cell').text()//入库日期
                        }
                        if ($(this).find('input[name="stockOutQuantity"]').attr('stockOutListId')) {
                            materialDetailsObj.stockOutListId = $(this).find('input[name="stockOutQuantity"]').attr('stockOutListId');
                        }
                        materialDetailsArr.push(materialDetailsObj);
                    });
                    obj.plbMtlStockOutlistWithBLOBS = materialDetailsArr;

                    if(lock){
                        return false
                    }


                    var loadIndex = layer.load();
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
                        layer.close(loadIndex);
                        return false;
                    }

                    if (type == 1) {
                        obj.mtlStockOutId = data.mtlStockOutId
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
                                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '38'}, function (res) {
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
                                                mtlStockOutId:subata.mtlStockOutId,
                                                runId: res.flowRun.runId,
                                                //auditerStatus:1
                                            }
                                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                            $.ajax({
                                                url: '/plbMtlStockOut/updateStockOut',
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
                        }
                    });
                }
            });
        }

        //监听本次出库数量
        $(document).on('input propertychange', '.stockOutQuantityItem', function () {
            if($('#leftId').attr('_type')=='4'){
                return false
            }

            //出库数量不能大于入库数量
            if(Number($(this).val()) > Number($(this).parents('tr').find('td[data-field="stockInQuantity"]').text())){
                $(this).val('')
                layer.msg('出库数量不能大于入库数量！', {icon: 0, time: 1500});
                return false
            }

            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var stockOutQuantity=0
            var taxPeice=0
            $tr.each(function () {
                stockOutQuantity=accAdd(stockOutQuantity,$(this).find('input[name="stockOutQuantity"]').val())

                //var p1=($(this).find('input[name="stockOutQuantity"]').val() || 0) * ($(this).find('td[data-field="taxPeice"]').text() || 0)
                var p1=mul(($(this).find('input[name="stockOutQuantity"]').val() || 0) , ($(this).find('td[data-field="taxPeice"]').text()))     || 0;
                taxPeice=accAdd(taxPeice,p1)
            });
            $('#baseForm [name="stockOutQuantity"] ').val(retainDecimal(stockOutQuantity,3))
            $('#baseForm [name="outMoney"] ').val(retainDecimal(taxPeice,2))

            //计算含税总价和不含税总价
            if($(this).val() && $(this).parents('tr').find('td[data-field="taxPeice"]').text()){
                var taxMoney=mul(($(this).val() || 0) , ($(this).parents('tr').find('td[data-field="taxPeice"]').text() || 0))
                $(this).parents('tr').find('input[name="taxMoney"]').val(retainDecimal(taxMoney,3))
            }
            if($(this).val() && $(this).parents('tr').find('td[data-field="noTaxPeice"]').text()){
                var noTaxMoney=mul(($(this).val() || 0) , ($(this).parents('tr').find('td[data-field="noTaxPeice"]').text() || 0))
                $(this).parents('tr').find('input[name="noTaxMoney"]').val(retainDecimal(noTaxMoney,2))
            }
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
</script>
</body>
</html>