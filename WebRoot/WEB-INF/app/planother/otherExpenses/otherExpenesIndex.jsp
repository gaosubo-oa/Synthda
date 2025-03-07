<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/8/22
  Time: 10:44
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
        <title>其他费用报销</title>

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
        <script type="text/javascript" src="/js/common/fileupload.js?202108"></script>
        <script type="text/javascript" src="/js/planbudget/common.js?20210616.1"></script>
        <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.1"></script>

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

            .del_trip_btn {
                position: absolute;
                top: 10px;
                right: 20px;
                cursor: pointer;
                z-index: 1;
            }

            .refresh_no_btn {
                display: none;
                margin-left: 8%;
                color: #00c4ff !important;
                font-weight: 600;
                cursor: pointer;
            }

           /* .layui-select-disabled .layui-disabled {
                color: #222 !important;
            }*/

            .deptDel {
                position: absolute;
                top: 10px;
                right: 4px;
                color: #1E9FFF;
                cursor: pointer;
            }

            .deptDel:hover {
                color: #ff0000;
            }

            .con_left {
                float: left;
                height: 100%;
            }

            .con_right {
                float: left;
                height: 100%;
                padding-left: 10px;
                box-sizing: border-box;
            }


            .openFile input[type=file]{
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 18px;
                z-index: 99;
                opacity: 0;
            }
            #reimbursementDetailsModule td[data-field="attachmentName"] .layui-table-cell{
                height: auto;
                overflow:visible;
                text-overflow:inherit;
                white-space:normal;
                word-break: break-word;
            }
            .col-xs{
                width: 20%;
            }
            /*选中行样式*/
            .select_Tr {
                background: #009688 !important;
                color: #fff !important;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <input type="hidden" id="leftId" value="">
            <div class="wrapper">
                <div class="wrap_left" style="border-right: 1px solid #ccc;">
                    <%--<div class="list_module">
                        <ul class="list_ul"></ul>
                    </div>--%>

                    <h2 style="text-align: center;line-height: 35px;">其他费用报销</h2>
                    <div class="left_form">
                        <div class="search_icon">
                            <i class="layui-icon layui-icon-search"></i>
                        </div>
                        <input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input"/>
                    </div>
                    <div class="tree_module">
                        <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
                    </div>
                </div>
                <div class="wrap_right">
                    <div class="query_module layui-form layui-row" style="position: relative">
                        <div class="layui-col-xs2" style="margin-left: 15px;">
                            <input type="text" name="documnet_Num" placeholder="单据编号" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-col-xs2" style="margin-left: 15px;">
                            <input type="text" name="reiUser_Id" id="reiUser_Id" placeholder="报销人" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-col-xs2" style="margin-left: 15px;">
                            <select name="cost_Type" id="cost_Type" autocomplete="off" class="layui-input"></select>
                        </div>
                        <div class="layui-col-xs2" style="margin-left: 15px;">
                            <select name="auditerStatus" lay-verify="required">
                                <option value="">选择报销状态</option>
                                <option value="0">未提交</option>
                                <option value="1">报销中</option>
                                <option value="2">已报销</option>
                                <option value="3">已退回</option>
                            </select>
                        </div>
                        <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                            <button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
                            <%--<button type="button" class="layui-btn layui-btn-sm" id="">高级查询</button>--%>
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
                <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
                <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
                <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
                <button class="layui-btn layui-btn-sm" lay-event="dayin">打印模板</button>
            </div>
            <div style="position:absolute;top: 10px;right:60px;">
                <button class="layui-btn layui-btn-sm " lay-event="submit" style="margin-left:10px;">提交审批</button>
                <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
                    <img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入
                </button>
                <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
                    <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出
                </button>
            </div>
        </script>

        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
        </script>

        <script type="text/html" id="toolbar">
            <div class="layui-btn-container" style="height: 30px;">
                <button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
            </div>
        </script>

        <script type="text/html" id="toolbarDemoIn">
            <div class="layui-btn-container" style="height: 30px;">
                <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
            </div>
        </script>

        <script type="text/html" id="barDemo2">
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
        </script>

        <script type="text/html" id="internalBar">
            <a href="javascript:;" class="openFile" style="position:relative;" lay-event="butfile">
                <button type="button"  class="layui-btn layui-btn-xs" style="margin-right:10px;">
                    <i class="layui-icon" >&#xe67c;</i>附件上传
                </button>
                <input type="file" multiple id={{"fileupload"+d.LAY_INDEX}} data-url="/upload?module=costReiBud"  name="file">
            </a>
        </script>

        <script>
            var MYPROJECT = false;
            var _flay = false
            $.ajax({
                url: '/syspara/selectTheSysPara?paraName=MYPROJECT',
                dataType: 'json',
                type: 'post',
                success: function (res) {
                    if(res.object&&res.object[0]&&res.object[0].paraValue&&res.object[0].paraValue=='yongli'){
                        MYPROJECT = true;
                    }
                }
            });


            var tableObj = null;
            // 报销单明细数据
            var reiBudList = [];
            var _dataa;
            // 付款单明细数据
            var reiPayList = [];

            var tipIndex = null;
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text');
                tipIndex = layer.tips(tip, this);
            }, function () {
                layer.close(tipIndex);
            });

            // 表格显示顺序
            var colShowObj = {
                documnetNum: {field: 'documnetNum', title: '单据编号', sort: true, hide: false},
                projectName: {
                    field: 'projectName', title: '项目名称', sort: true, hide: false, templet: function (d) {
                        return (d.projectName || '');
                    }
                },
                reiDate: {
                    field: 'reiDate', title: '报销日期', sort: true, hide: false, templet: function (d) {
                        return format(d.reiDate);
                    }
                },
                reiUserId: {
                    field: 'reiUserId', title: '报销人', sort: true, hide: false, templet: function (d) {
                        return (d.reiUserName || '').replace(/,$/, '');
                    }
                },
                department: {
                    field: 'department', title: '所属部门', sort: true, hide: false, templet: function (d) {
                        return (d.departmentName || '').replace(/,$/, '');
                    }
                },
                costType: {
                    field: 'costType', title: '报销单类型', sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['COST_TYPE']['object'][d.costType] || '';
                    }
                },
                reiMon: {
                    field: 'reiMon', title: '报销金额', sort: true, hide: false, templet: function (d) {
                        return (d.reiMon || '');
                    }
                },
                currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
                auditerStatus: {
                    field: 'auditerStatus', title: '报销状态', sort: true, hide: false, templet: function (d) {
                        var str = '';
                        switch (d.auditerStatus) {
                            case '0':
                                str = '未提交';
                                break;
                            case '1':
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>报销中</span>';
                                break;
                            case '2':
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>已报销</span>';
                                break;
                            case '3':
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>已退回</span>';
                                break;
                        }
                        return str;
                    }
                }
            }

            var TableUIObj = new TableUI('plb_other_cost_reimbursement');

            var dictionaryObj = {
                PAYMENT_METHOD: {},
                REIMBURSEMENT_TYPE: {},
                TRAVEL_TYPE: {},
                COST_TYPE:{},
                CONTROL_TYPE:{},
                CBS_UNIT:{}
            }
            var dictionaryStr = 'PAYMENT_METHOD,REIMBURSEMENT_TYPE,TRAVEL_TYPE,COST_TYPE,CONTROL_TYPE,CBS_UNIT';
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

            var iframeLayerIndex = 0;

            function initPage() {
                layui.use(['form', 'table', 'soulTable','eleTree','xmSelect','laydate','element'], function () {
                    var table = layui.table,
                            soulTable = layui.soulTable,
                            form = layui.form,
                            eleTree = layui.eleTree,
                            xmSelect = layui.xmSelect,
                            laydate = layui.laydate,
                            element  = layui.element;


                    var materialsTable=null

                    //报销人
                    $('#reiUser_Id').on('click', function() {
                        user_id = 'reiUser_Id';
                        $.popWindow('/common/selectUser?0');
                    });
                    //报销单类型
                    var _optionStr = '<option value="">报销单类型</option>'
                    _optionStr += dictionaryObj.COST_TYPE.str
                    $('#cost_Type').append(_optionStr)
                    
                    form.render();

                    /*var listStr = '';
                    $.each(dictionaryObj['REIMBURSEMENT_TYPE']['object'], function (k, v) {
                        listStr += '<li class="list_item" type="' + k + '"><span>' + v + '</span></li>';
                    });
                    $('.list_ul').html(listStr);
                    $('.list_item').eq(0).addClass('active');
                    $('#leftId').val($('.list_item').eq(0).attr('type'));*/

                    projectLeft();

                    /**
                     * 左侧项目信息列表
                     * @param projectName 项目名称
                     */
                    function projectLeft(projectName) {
                        projectName = projectName ? projectName : '';
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

                            }
                        });
                    }


                    // 树节点点击事件
                    eleTree.on("nodeClick(leftTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.projId) {
                            $('#leftId').attr('projId', currentData.projId);
                            $('#leftId').attr('projName', currentData.projName);
                            TableUIObj.init(colShowObj, function () {
                                tableInit();
                            });
                            //tableInit(currentData.projId);
                            $('.no_data').hide();
                            $('.table_box').show();
                        }else{
                            $('.table_box').hide();
                            $('.no_data').show();
                        }
                    });



                    // 监听排序事件
                    table.on('sort(tableObj)', function (obj) {
                        var param = {
                            orderbyFields: obj.field,
                            orderbyUpdown: obj.type
                        }

                        TableUIObj.update(param, function () {
                            tableInit({
                                documnetNum: $('[name="documnetNum"]', $('.query_module')).val(),
                                auditerStatus: $('[name="auditerStatus"]', $('.query_module')).val()
                            });
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
                    // 监听列表头部按钮事件
                    table.on('toolbar(tableObj)', function (obj) {
                        var checkStatus = table.checkStatus(obj.config.id);
                        var dataTable=table.checkStatus(obj.config.id).data;
                        switch (obj.event) {
                            case 'add': // 新增
                                newOrEdit(1);
                                break;
                            case 'edit': // 编辑
                                if (checkStatus.data[0].auditerStatus != '0') {
                                    layer.msg('该数据已提交！', {icon: 0, time: 2000});
                                    return false;
                                }
                                newOrEdit(2,checkStatus.data[0]);
                                break;
                            case 'del': // 删除
                                if (checkStatus.data.length == 0) {
                                    layer.msg('请选择需要删除的数据！', {icon: 0, time: 2000});
                                    return false;
                                }

                                var reimburseIds = '';
                                var isFlay = false;

                                checkStatus.data.forEach(function (item) {

                                    reimburseIds += item.reiId + ',';

                                    if(item.auditerStatus&&item.auditerStatus!='0'){
                                        isFlay = true
                                    }
                                });
                                if(isFlay){
                                    layer.msg('已提交不可删除！', {icon: 0});
                                    return false
                                }

                                layer.confirm('确定删除该条数据吗？', function (index) {
                                    $.get('/otherExpenes/del', {ids: reimburseIds}, function (res) {
                                        layer.close(index)
                                        if (res.code=='0') {
                                            layer.msg('删除成功！', {icon: 1});
                                            reloadTableData();
                                        } else {
                                            layer.msg('删除失败！', {icon: 2});
                                        }
                                    });
                                });
                                break;
                            case 'dayin':
                                if (checkStatus.data.length != 1) {
                                    layer.msg('请选择一条需要打印的数据！', {icon: 0, time: 2000});
                                    return false;
                                }
                                if(checkStatus.data[0].auditerStatus != '0'){
                                    var index=layer.load();
                                    var runId=dataTable[0].runId;
                                    $.ajax({
                                        url:'/generateDocx/generateDocxByType?runId='+runId+'&type=otherTargetCost',
                                        success:function(res){
                                            if(res.flag){
                                                layer.close(index);
                                                if(res.obj.reportAttachmentList[0]==""||res.obj.reportAttachmentList==undefined){
                                                    layer.msg('查询失败请刷新重试！', {icon: 0, time: 2000});
                                                    return
                                                }else{
                                                    console.log(res.obj)
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
                            case 'submit': // 提交
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
                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '46'}, function (res) {
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

                                            approvalData.reiBudList.forEach(function(item){
                                                if(item.cbsName&&item.cbsName.indexOf('招待费')>0){
                                                    _flay = true
                                                }
                                            })

                                            delete approvalData.reiBudList
                                            delete approvalData.reiPayList
                                            if(MYPROJECT) {
                                                if (_flay) {
                                                    approvalData.businessFlag = '是';
                                                }else {
                                                    approvalData.businessFlag = '否'
                                                }
                                            }
                                            _flay = false
                                            newWorkFlow(flowData.flowId, function (res) {
                                                var submitData = {
                                                    reiId:approvalData.reiId,
                                                    runId: res.flowRun.runId
                                                    //auditerStatus:1
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.ajax({
                                                    url: '/otherExpenes/updateById',
                                                    data: JSON.stringify(submitData),
                                                    dataType: 'json',
                                                    contentType: "application/json;charset=UTF-8",
                                                    type: 'post',
                                                    success: function (res) {
                                                        layer.close(loadIndex);
                                                        if (res.code===0||res.code==="0") {
                                                            layer.close(index);
                                                            layer.msg('提交成功!', {icon: 1});
                                                            reloadTableData();
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
                            case 'import': // 导入
                                layer.msg('导入');
                                break;
                            case 'export': // 导出
                                layer.msg('导出');
                                break;
                        }
                    });
                    table.on('tool(tableObj)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        if (layEvent === 'detail') {
                            newOrEdit(3, data);
                        }
                    });

                    // 查询
                    $('#searchBtn').on('click', function () {
                        tableInit();
                    });

                    // 高级查询
                    $('#advancedQuery').on('click', function () {
                        layer.msg('功能完善中')
                    });

                    // 报销明细-选择
                    table.on('toolbar(reimbursementDetailsTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                var wbsSelectTree = null;
                                var cbsSelectTree = null;
                                var _this = $(this);
                                layer.open({
                                    type: 1,
                                    title: '管理目标选择',
                                    area: ['100%', '100%'],
                                    maxmin: true,
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div class="layui-form" id="objectives">' +
                                    //下拉选择
                                    '           <div class="layui-row" style="margin-top: 10px">' +
                                    '               <div class="layui-col-xs2">' +
                                    '                   <div class="layui-form-item">\n' +
                                    '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                                    '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                                    '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                                    '                       </div>\n' +
                                    '                   </div>' +
                                    '               </div>' +
                                    '               <div class="layui-col-xs2">' +
                                    '                   <div class="layui-form-item">\n' +
                                    '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                                    '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                                    '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                                    '                       </div>\n' +
                                    '                   </div>' +
                                    '               </div>' +
                                    '               <div class="layui-col-xs3">' +
                                    '                   <div class="layui-form-item">\n' +
                                    '                       <label class="layui-form-label">WBS</label>\n' +
                                    '                       <div class="layui-input-block">\n' +
                                    '<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                                    '                       </div>\n' +
                                    '                   </div>' +
                                    '               </div>' +
                                    '               <div class="layui-col-xs3">' +
                                    '                   <div class="layui-form-item">\n' +
                                    '                       <label class="layui-form-label">CBS</label>\n' +
                                    '                       <div class="layui-input-block">\n' +
                                    '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                                    '                       </div>\n' +
                                    '                   </div>' +
                                    '               </div>' +
                                    '               <div class="layui-col-xs2">' +
                                    '<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 0 0 10px;">搜索<i class="layui-icon layui-icon-search" style="margin: 0 0 0 3px;"></i></button>' +
                                    '               </div>' +
                                    '           </div>' +
                                    //表格数据
                                    '       <div style="padding: 10px">' +
                                    '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                                    '      </div>' +
                                    '</div>'].join(''),
                                    success: function () {
                                        // 获取WBS数据
                                        $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId')}, function (res) {
                                            wbsSelectTree = xmSelect.render({
                                                el: '#wbsSelectTree',
                                                content: '<div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                                                name: 'wbsName',
                                                prop: {
                                                    name: 'wbsName',
                                                    value: 'id'
                                                }
                                            });

                                            eleTree.render({
                                                elem: '#wbsTree',
                                                data: res.obj,
                                                highlightCurrent: true,
                                                showLine: true,
                                                defaultExpandAll: false,
                                                request: {
                                                    name: 'wbsName',
                                                    children: "child"
                                                }
                                            });

                                            // 树节点点击事件
                                            eleTree.on("nodeClick(wbsTree)", function (d) {
                                                var currentData = d.data.currentData;
                                                var obj = {
                                                    wbsName: currentData.wbsName,
                                                    id: currentData.id
                                                }
                                                wbsSelectTree.setValue([obj]);
                                            });
                                        });

                                        // 获取CBS数据
                                        $.get('/plbCbsType/getAllList', function (res) {
                                            cbsSelectTree = xmSelect.render({
                                                el: '#cbsSelectTree',
                                                content: '<div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                                name: 'cbsName',
                                                prop: {
                                                    name: 'cbsName',
                                                    value: 'cbsId'
                                                }
                                            });

                                            eleTree.render({
                                                elem: '#cbsTree',
                                                data: res.data,
                                                highlightCurrent: true,
                                                showLine: true,
                                                defaultExpandAll: false,
                                                request: {
                                                    name: 'cbsName',
                                                    children: "childList"
                                                }
                                            });

                                            // 树节点点击事件
                                            eleTree.on("nodeClick(cbsTree)", function (d) {
                                                var currentData = d.data.currentData;
                                                var obj = {
                                                    cbsName: currentData.cbsName,
                                                    cbsId: currentData.cbsId
                                                }
                                                cbsSelectTree.setValue([obj]);
                                            });
                                        });

                                        laodTable();

                                        $('.search_mtl').on('click', function(){
                                            var cbsId = cbsSelectTree.getValue('valueStr');
                                            var wbsId = wbsSelectTree.getValue('valueStr');
                                            var itemNo = $('[name="itemNo"]').val();
                                            var itemName =$('[name="itemName"]').val();

                                            laodTable(wbsId, cbsId,itemNo,itemName);
                                        });

                                        // 加载表格
                                        function laodTable(wbsId, cbsId,itemNo,itemName) {
                                            table.render({
                                                elem: '#managementBudgetTable',
                                                url: '/manageProject/getBudgetByProjId',
                                                where: {
                                                    projId: $('#leftId').attr('projId'),
                                                    wbsId: wbsId || '',
                                                    cbsId: cbsId || '',
                                                    itemNo: itemNo || '',
                                                    itemName: itemName || '',
                                                    rbsTyep:'other'
                                                },
                                                page: true,
                                                limit: 20,
                                                request: {
                                                    limitName: 'pageSize'
                                                },
                                                response: {
                                                    statusName: 'flag',
                                                    statusCode: true,
                                                    msgName: 'msg',
                                                    countName: 'count',
                                                    dataName: 'data'
                                                },
                                                cols: [[
                                                    {type: 'checkbox'},
                                                    {
                                                        field: 'wbsName', title: 'WBS',minWidth:100, templet: function(d) {
                                                            var str = '';
                                                            if (d.plbProjWbs) {
                                                                str = d.plbProjWbs.wbsName;
                                                            }
                                                            return str;
                                                        }
                                                    },
                                                    {
                                                        field: 'rbsName', title: 'RBS',minWidth:200, templet: function(d) {
                                                            var str = '';
                                                            if (d.plbRbs) {
                                                                str = d.plbRbs.rbsLongName;
                                                            }
                                                            return str;
                                                        }
                                                    },
                                                    {
                                                        field: 'cbsName', title: 'CBS',minWidth:100, templet: function (d) {
                                                            var str = '';
                                                            if (d.plbCbsTypeWithBLOBs) {
                                                                str = d.plbCbsTypeWithBLOBs.cbsName;
                                                            }
                                                            return str;
                                                        }
                                                    },
                                                    {
                                                        field: 'controlType', title: '控制类型', minWidth:120,templet: function (d) {
                                                            return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                                        }
                                                    },
                                                    {
                                                        field: 'rbsUnit', title: '单位',minWidth:120, templet: function (d) {
                                                            var str = '';
                                                            if (d.plbRbs) {
                                                                str = dictionaryObj['CBS_UNIT']['object'][d.plbRbs.rbsUnit] || '';
                                                            }
                                                            return str;
                                                        }
                                                    },
                                                    // {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                                    // {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                                    {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                                    // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                                    {field: 'monQuata', title: '截止当前额度',minWidth:170},
                                                    {field: 'realOutMoney', title: '截止当前已发生额度',minWidth:170},
                                                    //{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                                    //{field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},
                                                ]],
                                                done:function(res){
                                                    _dataa=res.data;
                                                    if(reiBudList!=undefined&&reiBudList.length>0){
                                                        for(var i = 0 ; i <_dataa.length;i++){
                                                            for(var n = 0 ; n < reiBudList.length; n++){
                                                                if(_dataa[i].projBudgetId == reiBudList[n].projBudgetId){
                                                                    $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                                    //form.render('checkbox');
                                                                }
                                                            }
                                                        }
                                                    }

                                                }
                                            });
                                        }
                                    },
                                    yes: function (index) {
                                        var dataArr = getReimbursementDetailsData(2).dataArr;

                                        var checkStatus=[];
                                        $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(indexx,item){
                                            if($(item).find('.layui-form-checked').length>0){
                                                checkStatus.push(_dataa[indexx]);
                                            }
                                        })
                                        //var checkStatus = table.checkStatus('managementBudgetTable').data;

                                        var oldDataArr = [];
                                        if (checkStatus.length > 0) {
                                            for(var i=0;i<checkStatus.length;i++){
                                                var oldDataObj = {
                                                    projBudgetId:checkStatus[i].projBudgetId,
                                                    wbsName:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsName:'',
                                                    wbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsId:'',
                                                    cbsName:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsName:'',
                                                    cbsId:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsId:'',
                                                    rbsName:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsLongName:'',
                                                    rbsId:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsId:'',
                                                    yearBudQuata:checkStatus[i].manageTarAmount,
                                                    monQuata:checkStatus[i].monQuata,
                                                    currMonQuata:checkStatus[i].currMonQuata,//动态值
                                                    monHappenQuata:checkStatus[i].realOutMoney,
                                                    currMonHappenQuata:checkStatus[i].currMonHappenQuata,//动态值
                                                    trnApplicationAmount:checkStatus[i].trnApplicationAmount
                                                }
                                                if(dataArr){
                                                    var _flag = true
                                                    for(var j=0;j<dataArr.length;j++){
                                                        if(dataArr[j].projBudgetId==checkStatus[i].projBudgetId){
                                                            _flag = false
                                                        }
                                                    }
                                                    if(_flag){
                                                        dataArr.push(oldDataObj);
                                                    }

                                                }else{
                                                    dataArr.push(oldDataObj);
                                                }

                                            }

                                            layer.close(index);

                                            table.reload('reimbursementDetailsTable', {
                                                data: dataArr
                                            });
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                                

                                break;
                        }
                    });
                    // 报销明细-行操作
                    table.on('tool(reimbursementDetailsTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            if (data.budgetId) {
                                $.get('/otherExpenes/delReiBud', {ids: data.budgetId}, function (res) {
                                    if (res.code=="0"||res.code==0) {
                                        layer.msg('删除成功!', {icon: 1, time: 2000});
                                        obj.del();
                                        var reimbursementData = getReimbursementDetailsData(2);
                                        $('[name="reiMon"]', $('#baseForm')).val(reimbursementData.amountTotal);
                                        table.reload('reimbursementDetailsTable', {
                                            data: reimbursementData.dataArr
                                        });
                                    } else {
                                        layer.msg('删除失败!', {icon: 2, time: 2000});
                                    }
                                });
                            } else {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                var reimbursementData = getReimbursementDetailsData(2);
                                $('[name="reiMon"]', $('#baseForm')).val(reimbursementData.amountTotal);
                                table.reload('reimbursementDetailsTable', {
                                    data: reimbursementData.dataArr
                                });
                            }
                        }else if (layEvent == 'butfile') {
                            var $tr = $tr.selector
                            fileuploadFn( $tr+' [id^=fileupload]', $( $tr+' [id^=fileAll]'));
                        }else if (layEvent == 'dateSelection') {
                            var $tr2 = $('#reimbursementDetailsModule').find($tr.selector).find('input[name="implementDate"]');
                            $tr2.each(function (index,element) {
                                laydate.render({
                                    elem: element
                                    , trigger: 'click'
                                    , format: 'yyyy-MM-dd'
                                    // , format: 'yyyy-MM-dd HH:mm:ss'
                                    ,value: new Date()
                                });
                            })
                        } /*else if (layEvent == 'choosePlanTask') {
                            var tabIndex = 0;
                            var planTaskIdR = '';
                            var planTaskNameR = '';
                            var planTaskIdL = '';
                            var planTaskNameL = '';
                            layer.open({
                                type: 1,
                                title: '添加关联关键任务',
                                area: ['80%', '80%'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="position: relative;height: 100%;margin: 0;">',
                                    '<ul class="layui-tab-title">',
                                    '<li class="layui-this">主项关键任务</li>',
                                    '<li>职能关键任务</li>',
                                    '</ul>',
                                    '<div class="layui-tab-content" style="position: absolute;top: 41px;left: 0;right: 0;bottom: 0;">',
                                    '<div class="layui-tab-item layui-show" style="height: 100%;">',
                                    '<div class="layui-row mainLeftQuery layui-form">',
                                    '<div class="layui-col-xs4">',
                                    '<div class="layui-form-item" style="margin: 0;">',
                                    '<label class="layui-form-label" style="padding: 9px 0px">责任部门:</label>',
                                    '<div class="layui-input-block" style="margin-left: 85px;">',
                                    '<input type="text" name="mainCenterDept" id="mainCenterDept" readonly class="layui-input" style="background:#e7e7e7; cursor: pointer" />',
                                    '<a class="deptDel"><i class="layui-icon layui-icon-close-fill"></i></a>',
                                    '</div>',
                                    '</div>',
                                    '</div>',
                                    '<button type="button" class="layui-btn layui-btn-sm queryTarget" style="margin-left: 5%;margin-top: 5px;">查询</button>',
                                    '</div>',
                                    '<div style="position: absolute;top: 53px;left: 0;right: 0;bottom: 0;"><div class="con_left">',
                                    '<div class="eleTree ele1" style="overflow-x: auto;height: 100%;" lay-filter="projectLeft"></div>',
                                    '</div>',
                                    '<div class="con_right layui-form"></div></div>',
                                    '</div>',
                                    '<div class="layui-tab-item" style="height: 100%;">',
                                    '<div class="layui-row mainRightQuery layui-form">',
                                    '<div class="layui-col-xs3">',
                                    '<div class="layui-form-item" style="margin: 0;">',
                                    '<label class="layui-form-label" style="padding: 9px 0px;width: 50px">年度:</label>',
                                    '<div class="layui-input-block" style="margin-left: 57px;">',
                                    '<select name="year">',
                                    '<option value="">请选择</option>',
                                    '</select>',
                                    '</div>',
                                    '</div>',
                                    '</div>',
                                    '<button type="button" class="layui-btn layui-btn-sm queryTarget" style="margin-left: 5%;margin-top: 5px;">查询</button>',
                                    '</div>',
                                    '<div class="wrapper"  style="position: absolute;top: 53px;left: 0;right: 0;bottom: 0;"><div class="wrap_left">',
                                    '<div class="eleTree ele1Z" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeftZ"></div>',
                                    '</div>',
                                    '<div class="wrap_right layui-form"></div></div>',
                                    '</div>',
                                    '</div>',
                                    '</div>'].join(''),
                                success: function () {
                                    form.render();

                                    element.on('tab(docDemoTabBrief)', function(data){
                                        tabIndex = data.index;
                                    });

                                    /!* region 主项关键任务 *!/
                                    projectLeft();

                                    // 主项计划-左侧树
                                    function projectLeft() {
                                        eleTree.render({
                                            elem: '.ele1',
                                            url: '/projectTarget/ProjectProAndBag?projOrgId=',
                                            highlightCurrent: true,
                                            showLine: true,
                                            accordion: true,
                                            request: {
                                                name: "name",
                                                key: "ids",
                                                children: "bags",
                                            },
                                            response: {
                                                statusName: 'code',
                                                statusCode: 0,
                                                dataName: "obj"
                                            }
                                        });
                                    }

                                    // 主项-左侧节点点击事件
                                    eleTree.on("nodeClick(projectLeft)", function (d) {
                                        var currentData = d.data.currentData;
                                        if (currentData.pbagId) {
                                            $('.mainLeftQuery .queryTarget').attr('projectId', currentData.projectId);
                                            $('.mainLeftQuery .queryTarget').attr('pbagId', '');
                                            rigthShow('', currentData.pbagId, '');
                                        } else {
                                            $('.mainLeftQuery .queryTarget').attr('projectId', currentData.projectId);
                                            $('.mainLeftQuery .queryTarget').attr('pbagId', '');
                                            rigthShow(currentData.projectId, '', '');
                                        }
                                    });

                                    // 主项-右侧
                                    function rigthShow(projectId, pbagId, deptId) {
                                        $.ajax({
                                            url: '/projectTarget/selectByProOrBagShow',
                                            dataType: 'json',
                                            type: 'get',
                                            data: {projectId: projectId, pbagId: pbagId, deptId: deptId, useFlag: false},
                                            success: function (res) {
                                                if (res.flag) {
                                                    var data = res.obj
                                                    var str = ''
                                                    for (var i = 0; i < data.length; i++) {
                                                        str += '<div class="layui-input-block" style="margin-left: 20px"><input lay-filter="leftTarget" type="radio" name="tgName" title="' + res.obj[i].tgName + '" value="' + res.obj[i].tgId + '" lay-skin="primary"></div>'
                                                    }
                                                    $('.con_right').html(str)
                                                    form.render()
                                                }
                                            }
                                        });
                                    }

                                    form.on('radio(leftTarget)', function(data){
                                        planTaskIdL = data.value;
                                        planTaskNameL = $(data.elem).attr('title');
                                    });

                                    // 主项-查询
                                    $('.mainLeftQuery .queryTarget').click(function () {
                                        var projectId = $(this).attr('projectId')
                                        var pbagId = $(this).attr('pbagId')
                                        if (!projectId || !pbagId) {
                                            layer.msg('请先选择左侧！', {icon: 0});
                                            return false;
                                        }
                                        if ($('#mainCenterDept').attr('deptId')) {
                                            var mainCenterDept = $('#mainCenterDept').attr('deptId').replace(/,$/, '')
                                        } else {
                                            var mainCenterDept = '';
                                        }
                                        rigthShow(projectId, pbagId, mainCenterDept);
                                    })

                                    $('#mainCenterDept').on('click', function () {
                                        dept_id = 'mainCenterDept';
                                        $.popWindow('/common/selectDept?0');
                                    });
                                    $('.deptDel').on('click', function () {
                                        $('#mainCenterDept').val('').attr('deptid', '').attr('deptname', '');
                                    });
                                    /!* endregion *!/

                                    /!* region 职能关键任务 *!/
                                    // 获取计划期间年度列表
                                    $.get('/planPeroidSetting/selectAllYear', function (res) {
                                        var allYear = '';
                                        if (res.object.length > 0) {
                                            res.object.forEach(function (item) {
                                                allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                                            });
                                        }
                                        $('.mainRightQuery [name="year"]').append(allYear);
                                        form.render('select');
                                        // 默认职能关键任务年度为当年
                                        $('.mainRightQuery select[name="year"] option').each(function () {
                                            var nowYear = new Date().getFullYear()
                                            if ($(this).text() == nowYear) {
                                                $('.mainRightQuery select[name="year"]').val($(this).val())
                                                form.render()
                                            }
                                        });
                                    });

                                    projectLeftZ()
                                    //职能-左侧
                                    function projectLeftZ() {
                                        eleTree.render({
                                            elem: '.ele1Z',
                                            url: '/plcOrg/getTreeListByLoginer?projOrgId=',
                                            highlightCurrent: true,
                                            showLine: true,
                                            accordion: true,
                                            request: {
                                                name: "contractorName",
                                                key: "deptId",
                                                children: "orgList",
                                            },
                                            response: {
                                                statusName: 'flag',
                                                statusCode: true,
                                                dataName: "object"
                                            },
                                            done: function () {
                                                /!*var con_right=$(window).width()-$('.con_leftZ').width()-200
                                                $('.con_rightZ').css('width',con_right)*!/
                                            }
                                        });
                                    }

                                    // 职能-左侧节点点击事件
                                    eleTree.on("nodeClick(projectLeftZ)", function (d) {
                                        if (d.data.currentData.deptParent != 0) {
                                            // var con_right = $(window).width() - $('.con_leftZ').width() - 200
                                            // $('.con_rightZ').css('width', con_right)
                                            $('.mainRightQuery .queryTarget').attr('projOrgId', d.data.currentData.projOrgId)
                                            rigthShowZ(d.data.currentData.projOrgId, '');
                                        }
                                    });

                                    // 职能-右侧
                                    function rigthShowZ(projOrgId, year) {
                                        $.ajax({
                                            url: '/projectTarget/targetByDept',
                                            dataType: 'json',
                                            type: 'get',
                                            data: {projOrgId: projOrgId, year: year, flag: 2, useFlag: false},
                                            success: function (res) {
                                                if (res.flag) {
                                                    var data = res.obj
                                                    var str = ''
                                                    for (var i = 0; i < data.length; i++) {
                                                        str += '<div class="layui-input-block" style="margin-left: 20px"><input lay-filter="rightTarget" type="radio" name="tgName" title="' + res.obj[i].tgName + '" value="' + res.obj[i].tgId + '" lay-skin="primary"></div>'
                                                    }
                                                    $('.wrap_right').html(str)
                                                    form.render()
                                                }
                                            }
                                        });
                                    }

                                    //职能-查询
                                    $('.mainRightQuery .queryTarget').click(function () {
                                        var projOrgId = $(this).attr('projOrgId')
                                        if (projOrgId == undefined) {
                                            layer.msg('请先选择左侧部门！', {icon: 0});
                                            return false
                                        }
                                        var year = $('.mainRightQuery select[name="year"]').val() || '';
                                        rigthShowZ(projOrgId, year);
                                    });

                                    form.on('radio(rightTarget)', function(data){
                                        planTaskIdR = data.value;
                                        planTaskNameR = $(data.elem).attr('title');
                                    });
                                    /!*endregion*!/
                                },
                                yes: function (index) {
                                    var planTaskId = tabIndex == 0 ? planTaskIdL : planTaskIdR;
                                    var planTaskName = tabIndex == 0 ? planTaskNameL : planTaskNameR;

                                    if (planTaskId != '') {
                                        $tr.find('.planTaskId').attr('planTaskId', planTaskId).text(planTaskName);
                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            })
                        }*/
                    });

                    // 付款明细-加行
                    table.on('toolbar(paymentDetailsTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                //遍历表格获取每行数据进行保存
                                var dataArr = getPaymentmentDetailsData(true).dataArr;
                                dataArr.push({
                                    /*colPeo: ($('#reiUserId').attr('user_id') || '').replace(/,$/, ''),
                                    colPeoName: $('#reiUserId').val()*/
                                });
                                table.reload('paymentDetailsTable', {
                                    data: dataArr
                                });
                                break;
                        }
                    });
                    // 付款明细-行操作
                    table.on('tool(paymentDetailsTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            if (data.payId) {
                                $.get('/otherExpenes/delReiPay', {ids: data.payId}, function (res) {
                                    if (res.flag) {
                                        layer.msg('删除成功!', {icon: 1, time: 2000});
                                        obj.del();
                                        table.reload('paymentDetailsTable', {
                                            data: getPaymentmentDetailsData(true).dataArr
                                        });
                                    } else {
                                        layer.msg('删除失败!', {icon: 2, time: 2000});
                                    }
                                });
                            } else {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                table.reload('paymentDetailsTable', {
                                    data: getPaymentmentDetailsData(true).dataArr
                                });
                            }
                        } else if (layEvent === 'choosePay') {
                            if (type == 3) {
                                return false;
                            }
                            layer.open({
                                type: 1,
                                title: '选择付款方式',
                                area: ['400px', '500px'],
                                maxmin: true,
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div class="container">',
                                    '<table id="paymentTable" lay-filter="paymentTable"></table>',
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
                                        elem: '#paymentTable',
                                        data: data,
                                        page: false,
                                        cols: [[
                                            {type: 'radio', title: '选择'},
                                            {field: 'value', title: '付款方式'}
                                        ]]
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = table.checkStatus('paymentTable');
                                    if (checkStatus.data.length > 0) {
                                        var payData = checkStatus.data[0];

                                        $tr.find('input[name="payMethod"]').val(payData.value);
                                        $tr.find('input[name="payMethod"]').attr('payMethod', payData.type);

                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        } else if (layEvent === 'chooseCollectionUser') {
                            if (type == 3) {
                                return false;
                            }
                            var userIndex = layer.open({
                                title: false,
                                area: ['300px', '200px'],
                                btn: false,
                                content: '<div>' +
                                    '<p style="margin-top: 23px;margin-bottom: 30px;text-align: center;"><button class="layui-btn layui-btn-normal" id="selectUser">组织机构内选择</button></p>' +
                                    '<p style="text-align: center;"><button class="layui-btn layui-btn-normal" id="selectCustomer">客商内选择</button></p>' +
                                    '</div>',
                                success: function () {
                                    $('#selectUser').on('click', function() {
                                        layer.close(userIndex);
                                        user_id = $tr.find('[name="colPeo"]').attr('id');
                                        $tr.find('[name="colPeo"]').attr('customerId', '').attr('userType', 1);
                                        $.popWindow('/common/selectUser?0');
                                    });

                                    $('#selectCustomer').on('click', function() {
                                        layer.close(userIndex);
                                        $tr.find('[name="colPeo"]').attr('user_id', '').attr('userType', 2);
                                        layer.open({
                                            type: 1,
                                            title: '选择收款人',
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
                                                '<div class="mtl_table_box" style="display: none;margin: auto 20px">' +
                                                //查询
                                                '       <div class="layui-row inSearchContent">' +
                                                '             <div class="layui-col-xs4">\n' +
                                                '                  <input type="text" name="customerName" placeholder="收款人名称" autocomplete="off" class="layui-input">\n' +
                                                '             </div>\n' +
                                                '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                                                '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                                                '             </div>\n' +
                                                '       </div>'+
                                                '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                                                '     <div id="downBox" style="margin-top: 20px;">\n' +
                                                '         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
                                                '      </div>' +
                                                '</div>' +
                                                '<div class="mtl_no_data" style="text-align: center;">' +
                                                '<div class="no_data_img" style="margin-top:12%;">' +
                                                '<img style="margin-top: 2%;" src="/img/noData.png">' +
                                                '</div>' +
                                                '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
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
                                                    $('.mtl_no_data').hide();
                                                    $('.mtl_table_box').show();
                                                    $('#downBox').hide()
                                                    loadMtlTable(d.data.currentData.typeNo);
                                                });

                                                function loadMtlTable(merchantType) {
                                                    materialsTable = table.render({
                                                        elem: '#materialsTable',
                                                        url: '/PlbCustomer/getDataByCondition',
                                                        where: {
                                                            merchantType: merchantType
                                                        },
                                                        page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                                            , limits: [5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                                                            , limit:5
                                                            , first: false //不显示首页
                                                            , last: false //不显示尾页
                                                        }, //开启分页
                                                        response: {
                                                            statusName: 'flag',
                                                            statusCode: true,
                                                            msgName: 'msg',
                                                            countName: 'totleNum',
                                                            dataName: 'data'
                                                        },
                                                        request: {
                                                            limitName: 'pageSize'
                                                        },
                                                        cols: [[
                                                            {type: 'radio', title: '选择'},
                                                            {field: 'customerNo', title: '客商编号', minWidth: 100},
                                                            {field: 'customerName', title: '客商单位名称', minWidth: 150},
                                                            {field: 'customerShortName', title: '客商单位简称', minWidth: 150},
                                                            {field: 'customerOrgCode', title: '组织机构代码', minWidth: 150},
                                                            /*{field: 'taxNumber', title: '税务登记号', minWidth: 150},
                                                            {field: 'accountName', title: '开户行名称', minWidth: 150},
                                                            {field: 'accountNumber', title: '开户行账户', minWidth: 150}*/
                                                        ]]
                                                    });
                                                }
                                            },
                                            yes: function (index) {
                                                var checkStatus = table.checkStatus('materialsTable');
                                                var checkStatus2 = table.checkStatus('tableDemoInDown');
                                                if (checkStatus.data.length > 0) {
                                                    var mtlData = checkStatus.data[0];
                                                    $tr.find('[name="colPeo"]').val(mtlData.customerName);
                                                    $tr.find('[name="colPeo"]').attr('colPeo', mtlData.customerId);
                                                    $tr.find('[name="colPeo"]').attr('userType', '2');
                                                    layer.close(index);
                                                }else {
                                                    layer.msg('请选择一项！', {icon: 0});
                                                }
                                                if (checkStatus2.data.length > 0) {
                                                    var mtlData = checkStatus2.data[0];
                                                    $tr.find('[name="bankAccount"]').val(mtlData.bankAccount);
                                                    $tr.find('[name="bankDeposit"]').val(mtlData.bankOfDeposit);
                                                    layer.close(index);
                                                }
                                            }
                                        });
                                    });
                                }
                            });
                        }
                    });
                    //监听行单击事件
                    table.on('row(materialsTable)', function (obj) {
                        // console.log(obj.data) //得到当前行数据
                        var data = obj.data
                        if($(obj.tr[0]).find('.layui-form-radioed').length>0){
                            $('#downBox').show()
                            /* obj.tr.addClass('select_Tr').siblings('tr').removeClass('select_Tr')*/
                            tableShowDown(data.plbCustomerBankList)
                        }

                    });
                    function tableShowDown(data) {
                        table.render({
                            elem: '#tableDemoInDown',
                            //url: '/PlbCustomer/getDataByCondition',
                            data:data,
                            page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                , limits: [5,10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                                , limit:5
                                , first: false //不显示首页
                                , last: false //不显示尾页
                            }, //开启分页
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data'
                            },
                            request: {
                                limitName: 'pageSize'
                            },
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'bankOfDeposit', title: '开户行名称', minWidth: 150},
                                {field: 'bankAccount', title: '开户行账户', minWidth: 150}
                            ]]
                        });
                    }

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
                     * 获取报销明细数据
                     * @param type (是否编辑)
                     * @returns {{dataArr: *[], amountTotal: number}}
                     */
                    function getReimbursementDetailsData(type) {

                        //遍历表格获取每行数据
                        var $trs = $('#reimbursementDetailsModule').find('.layui-table-main tr');
                        var dataArr = [];
                        $trs.each(function (index) {

                            var attachId = '';
                            var attachName = '';
                            var attachmentList = [];

                            if(type=='1'){//提交保存
                                for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                                    attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                                    attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                                }
                            }else if(type=='2'){//加行、删行、选择
                                for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                                    attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                                    attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                                    var _obj ={
                                        attUrl:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
                                        attachId:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
                                        attachName:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
                                        size:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('size'),
                                        aid:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')),
                                        ym:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring($('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('_'))
                                    }
                                    attachmentList.push(_obj)
                                }
                            }

                            var dataObj = {
                                budgetId: $(this).find('.wbsName').attr('budgetId') || '',
                                reiId: $(this).find('.wbsName').attr('reiId') || '',
                                projBudgetId: $(this).find('.wbsName').attr('projBudgetId') || '',
                                wbsId: $(this).find('.wbsName').attr('wbsId') || '',
                                wbsName: $(this).find('.wbsName').text(),
                                rbsId: $(this).find('.rbsName').attr('rbsId') || '',
                                rbsName: $(this).find('.rbsName').text(),
                                cbsId: $(this).find('.cbsName').attr('cbsId') || '',
                                cbsName: $(this).find('.cbsName').text(),
                                yearBudQuata: $(this).find('.yearBudQuata').text(),
                                monQuata: $(this).find('.monQuata').text(),
                                currMonQuata: $(this).find('.monQuata').attr('currMonQuata'),////动态值
                                //deptId: ($(this).find('input[name="deptId"]').attr('deptId') || '').replace(/,$/, ''),
                                monHappenQuata: $(this).find('.monHappenQuata').text(),
                                currMonHappenQuata: $(this).find('.monHappenQuata').attr('currMonHappenQuata'),//动态值
                                reiReason: $(this).find('input[name="reiReason"]').val(),
                                implementDate: $(this).find('input[name="implementDate"]').val(),
                                currentReimbursementAmount: retainDecimal($(this).find('input[name="currentReimbursementAmount"]').val(),2),
                                taxAmount: retainDecimal($(this).find('input[name="taxAmount"]').val(),2),
                                amountExcludingTax: retainDecimal($(this).find('input[name="amountExcludingTax"]').val(),2),
                                trnApplicationAmount: $(this).find('.trnApplicationAmount').text(),
                                attachmentId:attachId,
                                attachmentName:attachName
                            }
                            if(type=='2'){
                                dataObj.attachmentList = attachmentList;
                            }

                            dataArr.push(dataObj);
                        });

                        return {
                            dataArr: dataArr,
                        }
                    }

                    /**
                     * 获取付款明细数据
                     * @param isEdit
                     * @returns {{dataArr: *[], amountTotal: number}}
                     */
                    function getPaymentmentDetailsData(isEdit) {
                        var amountTotal = 0;
                        //遍历表格获取每行数据
                        var $trs = $('#paymentDetailsModule').find('.layui-table-main tr');
                        var dataArr = [];
                        $trs.each(function () {
                            /*var payId = $(this).find('input[name="payMethod"]').attr('payId') || '';*/

                            var dataObj = {
                                payId: $(this).find('input[name="payMethod"]').attr('payId') || '',
                                reiId: $(this).find('input[name="payMethod"]').attr('reiId') || '',
                                payMethod: $(this).find('input[name="payMethod"]').attr('payMethod') || '',
                                colPeoName:$(this).find('input[name="colPeo"]').val().replace(/,$/, '') || '',
                                userType: $(this).find('input[name="colPeo"]').attr('userType') || '',
                                bankAccount: $(this).find('input[name="bankAccount"]').val(),
                                bankDeposit: $(this).find('input[name="bankDeposit"]').val(),
                                colMon: retainDecimal($(this).find('input[name="colMon"]').val(),2),
                                remark: $(this).find('input[name="remark"]').val()
                            }
                            if($(this).find('input[name="colPeo"]').attr('userType')&&$(this).find('input[name="colPeo"]').attr('userType')=='1'){
                                dataObj.colPeo = $(this).find('input[name="colPeo"]').attr('user_id')?$(this).find('input[name="colPeo"]').attr('user_id').replace(/,$/, '') : $(this).find('input[name="colPeo"]').attr('colPeo').replace(/,$/, '')
                            }else if($(this).find('input[name="colPeo"]').attr('userType')&&$(this).find('input[name="colPeo"]').attr('userType')=='2'){
                                dataObj.colPeo = $(this).find('input[name="colPeo"]').attr('colPeo')?$(this).find('input[name="colPeo"]').attr('colPeo') : ''
                            }

                           /* var $user = $(this).find('input[name="colPeo"]');
                            var userType = $user.attr('userType');
                            if (userType == 2) {
                                dataObj.customerId = $user.attr('customerId') || '';
                            } else {
                                dataObj.colPeo = ($user.attr('user_id') || '').replace(/,$/, '');
                            }

                            if (isEdit) {
                                var userName = $(this).find('input[name="colPeo"]').val()
                                if (userType == 2) {
                                    dataObj.customerName = userName;
                                } else {
                                    dataObj.colPeoName = userName;
                                }
                            }

                            if (payId) {
                                dataObj.payId = payId;
                            }
                            amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.colMon));*/
                            dataArr.push(dataObj);
                        });

                        return {
                            dataArr: dataArr,
                            //amountTotal: amountTotal
                        }
                    }

                    /**
                     * 加载表格方法
                     * @param searchObj (查询参数)
                     */
                    function tableInit() {
                        var searchObj = getSearchObj();
                        searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
                        searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                        var cols = [{checkbox: true}].concat(TableUIObj.cols)

                        cols.push({
                            fixed: 'right',
                            align: 'center',
                            toolbar: '#barDemo',
                            title: '操作',
                            width: 140
                        })

                        var option = {
                            elem: '#tableObj',
                            url: '/otherExpenes/select',
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
                            /*request: {
                                limitName: 'pageSize'
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data'
                            },*/
                            done: function () {
                                //增加拖拽后回调函数
                                soulTable.render(this, function () {
                                    TableUIObj.dragTable('tableObj');
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

                        tableObj = table.render(option);
                    }

                    /**
                     * 新增-编辑-预览报销单
                     * @param type
                     * @param data
                     */
                    function newOrEdit(type, data) {
                        var title = '';
                        var costType = $('#leftId').val()
                        $('#leftId').attr('_type',type)

                        // 报销单明细数据
                         reiBudList = [];
                        // 付款单明细数据
                         reiPayList = [];

                        var disabledStr = '';

                        if (type == 1) {
                            title = '新增其他费用报销单';
                            url = '/otherExpenes/insert'
                        } else if (type == 2) {
                            title = '编辑其他费用报销单';
                            //disabledStr = 'disabled';
                            url = '/otherExpenes/updateById?reiId=' + data.reiId;
                        } else if (type == 3) {
                            title = '查看详情';
                            disabledStr = 'disabled';
                            //url += '&reimburseId=' + data.reimburseId + '&disabled=1';
                        }
                        iframeLayerIndex = layer.open({
                            type: 1,
                            title: title,
                            btn: type!='3'?['保存', '提交', '取消']:['确定'],
                            btnAlign: 'c',
                            area: ['100%', '100%'],
                            content: '<div class="container _disabled">\n' +
                                '<input type="hidden" id="leftId" value="">\n' +
                                '<input type="hidden" id="03" value="">\n' +
                                '<input type="hidden" id="04" value="">\n' +
                                '<div class="wrapper">\n' +
                                '<div class="layui-collapse">\n' +
                                '<div class="layui-colla-item">\n' +
                                '<h2 class="layui-colla-title">基本信息</h2>\n' +
                                '<div class="layui-colla-content layui-show">\n' +
                                '<form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
                                /* region 第一行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">单据编号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" readonly name="documnetNum" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">\n' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                           <input type="text" readonly id="projectName" name="projectName" autocomplete="off"  class="layui-input " style="background:#e7e7e7">\n' +
                                '                           <input type="hidden" name="reiId" autocomplete="off"  class="layui-input ">\n' +
                                '                       </div>\n' +
                                '                   </div>\n' +
                                '               </div>\n' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">报销日期<span field="reiDate" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" name="reiDate" autocomplete="off" class="layui-input" >' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">经手人<span field="handerId" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" name="handerId" ' + (disabledStr || 'id="handerId"') +' placeholder="选择经手人"  autocomplete="off" class="layui-input" >' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">报销人<span field="reiUserId" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" name="reiUserId" ' + (disabledStr || 'id="reiUserId"') +' placeholder="选择报销人"   autocomplete="off" class="layui-input" >' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '           </div>' +
                            /* endregion */
                            /* region 第二行 */
                                '           <div class="layui-row">' +

                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">所属部门<span field="department" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" readonly name="department" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                                /*'                       <select '+disabledStr+' name="department"></select>' +*/
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">报销金额<span field="reiMon" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" readonly name="reiMon" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">费用类型<span field="costType" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <select '+disabledStr+' name="costType" id="costType"></select>' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">备注</label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" ' + disabledStr + ' name="memo" autocomplete="off"  class="layui-input">' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">其他费用需求计划</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                               <input type="text" name="reiPlanName" readonly autocomplete="off" class="layui-input click_one" style="width: 60%; padding-right: 25px;color: blue;background:#e7e7e7;cursor: pointer;float: left">' +
                                '                               <a class="layui-btn chooseMtlPlanId" style="width: 30%; float:right;">选择</a>' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '           </div>' +
                            /* endregion */
                            /* region 第三行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;display: none">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">是否含招待费</label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" readonly name="businessFlag" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">是否超标<span class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="radio" ' + disabledStr + ' name="overStandard" lay-filter="overStandard" value="1" title="是">' +
                                '                       <input type="radio" ' + disabledStr + ' name="overStandard" lay-filter="overStandard" value="0" title="否" checked>' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +*/
                                /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item" style="display: none;">' +
                                '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off"  class="layui-input">' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +*/
                                /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">报销事由<span field="reiReason" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                /!*'                       <textarea '+disabledStr+' name="reiReason" placeholder="请输入内容" class="layui-textarea"></textarea>' +*!/
                                '                       <input type="text" ' + disabledStr + ' name="reiReason" autocomplete="off" class="layui-input">' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +*/
                                '           </div>'+
                            /* endregion */
                            /* region 第四行 */
                                /*'           <div class="layui-row">' +
                                '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">报销事由<span field="reiReason" class="field_required">*</span></label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <textarea '+disabledStr+' name="reiReason" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +
                                '           </div>' +*/
                            /* endregion */
                            /* region 第五行 */
                                '           <div class="layui-row">' +
                                /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">附件数量</label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                       <input type="text" '+disabledStr+' name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +*/
                               /* '               <div class="layui-col-xs8" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label form_label">附件</label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '                           <div class="file_module">' +
                                '                               <div id="fileContent" class="file_content"></div>' +
                                '                               <div class="file_upload_box">' +
                                '                                   <a href="javascript:;" class="open_file">' +
                                '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                                '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=costRei" name="file">' +
                                '                                   </a>' +
                                '                                   <div class="progress">' +
                                '                                       <div class="bar"></div>' +
                                '                                   </div>' +
                                '                                   <div class="bar_text"></div>' +
                                '                               </div>' +
                                '                           </div>' +
                                '                       </div>' +
                                '                   </div>' +
                                '               </div>' +*/
                                '           </div>' +
                            /* endregion */
                                '</form>\n' +
                                '</div>\n' +
                                '</div>\n' +
                                '<div class="layui-colla-item" id="reimbursementDetailsModule">\n' +
                                '<h2 class="layui-colla-title">报销明细</h2>\n' +
                                '<div class="layui-colla-content layui-show">\n' +
                                '<table id="reimbursementDetailsTable" lay-filter="reimbursementDetailsTable"></table>\n' +
                                '</div>\n' +
                                '</div>\n' +
                                '<div class="layui-colla-item" id="paymentDetailsModule">\n' +
                                '<h2 class="layui-colla-title">付款明细</h2>\n' +
                                '<div class="layui-colla-content layui-show">\n' +
                                '<table id="paymentDetailsTable" lay-filter="paymentDetailsTable"></table>\n' +
                                '</div>\n' +
                                '</div>\n' +
                                '</div>\n' +
                                '</div>\n' +
                                '</div>',
                            success: function () {
                                $("#projectName").val($('#leftId').attr('projName'))
                                //报销日期
                                laydate.render({
                                    elem: '[name="reiDate"]'
                                    ,format: 'yyyy-MM-dd'
                                    //,trigger: 'click' //采用click弹出
                                });

                                //经手人
                                $('#handerId').on('click', function() {
                                    user_id = 'handerId';
                                    $.popWindow('/common/selectUser?0');
                                });
                                //报销人
                                $('#reiUserId').on('click', function() {
                                    user_id = 'reiUserId';
                                    $.popWindow('/common/selectUser?0');
                                });

                                var optionStr = '<option value="">请选择</option>'
                                optionStr += dictionaryObj.COST_TYPE.str
                                $('#costType').append(optionStr)

                               /* //附件
                                fileuploadFn('#fileupload', $('#fileContent'));*/

                                if (type == 1) { // 新增

                                    var dateNow = format(new Date().getTime());
                                    $('input[name="reiDate"]', $('#baseForm')).val(dateNow);

                                    // 获取自动编号
                                    getAutoNumber({
                                        autoNumberType: 'otherCost',
                                    }, function (res) {
                                        $('input[name="documnetNum"]', $('#baseForm')).val(res.obj);
                                        $('input[name="reiDate"]', $('#baseForm')).val(res.object.createDate);
                                        $('input[name="reiUserId"]', $('#baseForm')).val(res.object.createUserName);
                                        $('input[name="reiUserId"]', $('#baseForm')).attr('reiUserId',res.object.createUser);
                                        $('input[name="department"]', $('#baseForm')).val(res.object.deptName);
                                        $('input[name="department"]', $('#baseForm')).attr('deptId',res.object.deptId)
                                    });
                                    $('.refresh_no_btn').show().on('click', function () {
                                        getAutoNumber({
                                            autoNumberType: 'otherCost',
                                        }, function (res) {
                                            $('input[name="documnetNum"]', $('#baseForm')).val(res.obj);
                                            $('input[name="reiDate"]', $('#baseForm')).val(res.object.createDate);
                                            $('input[name="reiUserId"]', $('#baseForm')).val(res.object.createUserName);
                                            $('input[name="reiUserId"]', $('#baseForm')).attr('reiUserId',res.object.createUser);
                                            $('input[name="department"]', $('#baseForm')).val(res.object.deptName);
                                            $('input[name="department"]', $('#baseForm')).attr('deptId',res.object.deptId)
                                        });
                                    });
                                } else if (type == 2 || type == 3) { // 编辑

                                    form.val('baseForm', data);

                                    // 报销日期
                                    $('input[name="reiDate"]', $('#baseForm')).val(format(data.reiDate));
                                    // 经手人
                                    $('input[name="handerId"]', $('#baseForm')).attr('user_id', data.handerId).val((data.handerName || '').replace(/,$/, ''));
                                    // 报销人
                                    $('input[name="reiUserId"]', $('#baseForm')).attr('reiUserId', data.reiUserId).val((data.reiUserName || '').replace(/,$/, ''));
                                    // 部门
                                    $('input[name="department"]', $('#baseForm')).attr('deptId', data.department).val((data.departmentName || '').replace(/,$/, ''));

                                    $('.click_one').attr('reiPlanId',data.reiPlanId).val(data.reiPlan?data.reiPlan.reiPlanName:'')



                                    //附件
                                   /* if (data.attachmentList && data.attachmentList.length > 0) {
                                        var fileArr = data.attachmentList;
                                        $('#fileContent').append(echoAttachment(fileArr));
                                    }*/


                                    // 发票
                                    // $('#fileContentFP').html(getFileEleStr(data.invoices, !(type == 3)))

                                    // 报销明细
                                    reiBudList = data.reiBudList || [];
                                    // 付款明细
                                    reiPayList = data.reiPayList || [];
                                }



                                var reimbursementDetailsTableCols = [
                                    {type: 'numbers', title: '序号'},
                                    /*{
                                        field: 'deptItemId',
                                        title: '预算科目',
                                        event: 'chooseItem',
                                        minWidth: 200,
                                        templet: function (d) {
                                            var str = d.plbDeptBudgetItem ? undefind_nullStr(d.plbDeptBudgetItem.itemName) : undefind_nullStr(d.itemName);
                                            return '<input name="deptItemId" listId="' + undefind_nullStr(d.listId) + '" deptItemId="' + undefind_nullStr(d.deptItemId) + '" type="text" readonly class="layui-input deptItemId" style="height: 100%; cursor: pointer;" value="' + str + '">';
                                        }
                                    },*/
                                    {
                                        field: 'wbsName', title: 'WBS',minWidth:200, templet: function(d) {
                                            return '<span class="wbsName" wbs="'+(d.wbsId||'')+'" budgetId="'+(d.budgetId||'')+'" reiId="'+(d.reiId||'')+'" projBudgetId="'+(d.projBudgetId||'')+'">'+ (d.wbsName || '') + '</span>';
                                        }
                                    },
                                    {
                                        field: 'rbsName', title: 'RBS',minWidth:200, templet: function (d) {
                                            return '<span class="rbsName" rbs="'+(d.rbsId||'')+'" >' + (d.rbsName || '') + '</span>';
                                        }
                                    },
                                    {
                                        field: 'cbsName', title: 'CBS',minWidth:200, templet: function (d) {
                                            return '<span class="cbsName" cbs="'+(d.cbsId||'')+'" >' + (d.cbsName || '') + '</span>';
                                        }
                                    },
                                    {
                                        field: 'yearBudQuata',
                                        title: '管理目标金额',
                                        minWidth: 150,
                                        templet: function (d) {
                                            return '<span class="yearBudQuata" >' + (d.yearBudQuata||0) + '</span>';
                                        }
                                    },
                                    {
                                        field: 'monQuata', title: '截止当前额度', minWidth: 150, templet: function (d) {
                                            return '<span class="monQuata" currMonQuata="'+(d.currMonQuata||'')+'" >' + (d.monQuata||0) + '</span>';
                                        }
                                    },
                                    {
                                        field: 'monHappenQuata', title: '截止当前已发生额度', minWidth: 180, templet: function (d) {
                                            return '<span class="monHappenQuata" currMonHappenQuata="'+(d.currMonHappenQuata||'')+'" >' + (d.monHappenQuata||0) + '</span>';
                                        }
                                    },
                                    /*{
                                        field: 'exaMon', title: '在途中审批金额', minWidth: 150, templet: function (d) {
                                            return '<span class="exaMon">' + (d.exaMon||0) + '</span>';
                                        }
                                    },*/

                                    /*{
                                        field: 'budgetBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
                                            return '<span class="budgetBalance">' + undefind_nullStr(d.budgetBalance) + '</span>';
                                        }
                                    },*/
                                    {
                                        field: 'trnApplicationAmount', title: '在途报销金额', minWidth: 140, templet: function (d) {
                                            return '<span class="trnApplicationAmount">' + (d.trnApplicationAmount || '0') + '</span>';

                                        }
                                    },
                                    {
                                        field: 'reiReason', title: '本次报销事由', minWidth: 300, templet: function (d) {
                                            return '<input name="reiReason" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.reiReason) + '">';
                                        }
                                    },
                                    {
                                        field: 'implementDate', title: '发生日期*', minWidth: 140, event: 'dateSelection', templet: function (d) {
                                            return '<input type="text"  name="implementDate" class="layui-input" style="height: 100%;" value="' + (d.implementDate || '') + '">'
                                        }
                                    },
                                    {
                                        field: 'currentReimbursementAmount',
                                        title: '本次报销金额*',
                                        minWidth: 150,
                                        templet: function (d) {
                                            return '<input name="currentReimbursementAmount" type="number"  class="layui-input <!--input_floatNum-->" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.currentReimbursementAmount) + '">';
                                        }
                                    },
                                    {
                                        field: 'taxAmount',
                                        title: '税额*',
                                        minWidth: 150,
                                        templet: function (d) {
                                            return '<input name="taxAmount" type="number"  class="layui-input <!--input_floatNum-->" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.taxAmount) + '">';
                                        }
                                    },
                                    {
                                        field: 'amountExcludingTax',
                                        title: '不含税金额*',
                                        minWidth: 150,
                                        templet: function (d) {
                                            return '<input name="amountExcludingTax" type="number"  class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.amountExcludingTax) + '">';
                                        }
                                    },
                                   /* {
                                        field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                                            return '<input readonly name="deptId" type="text" deptId="' + undefind_nullStr(d.deptId) + '" class="layui-input choose_dept" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + undefind_nullStr(d.deptName) + '">';
                                        }
                                    },*/
                                    /*{
                                        field: 'reiReason', title: '事项说明', minWidth: 300, templet: function (d) {
                                            return '<input name="reiReason" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.reiReason) + '">';
                                        }
                                    },*/
                                    /*{
                                        field: 'applyId', title: '关联申请单', minWidth: 150, templet: function (d) {
                                            return '<span class="applyId">' + undefind_nullStr(d.applyId) + '</span>';
                                        }
                                    },
                                    {
                                        field: 'planTaskId', title: '关联工作计划', event: 'choosePlanTask', style: 'cursor: pointer;', minWidth: 150, templet: function (d) {
                                            return '<span class="planTaskId" planTaskId="' + undefind_nullStr(d.planTaskId) + '">' + undefind_nullStr(d.planTaskName) + '</span>';
                                        }
                                    },*/
                                    {
                                        field: 'attachmentName',
                                        title: '发票内容*',
                                        align: 'center',
                                        minWidth: 200,
                                        templet: function (d) {
                                            var fileArr = d.attachmentList;
                                            return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
                                                '</div>'

                                        }
                                    },
                                    /*{title: '发票上传', align: 'center', toolbar: '#internalBar', minWidth: 200},*/
                                ]
                                if (type != '3') {
                                    reimbursementDetailsTableCols.push(
                                        {title: '发票上传*', align: 'center', toolbar: '#internalBar', minWidth: 200},
                                        {
                                        /*fixed: 'right',*/
                                        align: 'center',
                                        toolbar: '#barDemo2',
                                        title: '操作',
                                        minWidth: 100
                                    }
                                    );
                                }
                                // 初始化报销明细列表
                                table.render({
                                    elem: '#reimbursementDetailsTable',
                                    data: reiBudList,
                                    toolbar: (type == 3) ? false : '#toolbar',
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [reimbursementDetailsTableCols],
                                    done: function (obj) {

                                        reiBudList = obj.data;
                                        if (!(type == 3)) {
                                            $('#reimbursementDetailsModule').find('input[name="deptId"]').each(function (i, v) {
                                                $(this).attr('id', 'dept_' + i);
                                            });

                                            $('#reimbursementDetailsModule').find('input[name="reiUserId"]').each(function (i, v) {
                                                $(this).attr('id', 'user_' + i);
                                            });
                                        }
                                    }
                                });

                                var paymentDetailsTableCols = [
                                    {type: 'numbers', title: '序号'},
                                    {
                                        field: 'payMethod',
                                        title: '付款方式',
                                        event: 'choosePay',
                                        minWidth: 150,
                                        templet: function (d) {
                                            var str = dictionaryObj['PAYMENT_METHOD']['object'][d.payMethod] || '';
                                            return '<input type="text" name="payMethod" payId="' + undefind_nullStr(d.payId) + '" reiId="' + undefind_nullStr(d.reiId) + '" readonly payMethod="' + undefind_nullStr(d.payMethod) + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                                        }
                                    },
                                    {
                                        field: 'colPeo',
                                        title: '收款人*',
                                        minWidth: 150,
                                        event: 'chooseCollectionUser',
                                        templet: function (d) {
                                            var str = '';
                                            var attr = '';
                                            if (d.colPeo&&d.userType=='2') {
                                                str = undefind_nullStr(d.colPeoName);
                                                attr = 'colPeo="' + d.colPeo + '" userType="2"';
                                            } else if(d.colPeo&&d.userType=='1') {
                                                str = undefind_nullStr(d.colPeoName).replace(/,$/, '');
                                                attr = 'colPeo="' + d.colPeo  + '" userType="1"';
                                            }
                                            return '<input readonly name="colPeo" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                                        }
                                    },
                                    {
                                        field: 'bankAccount',
                                        title: '银行账号',
                                        minWidth: 150,
                                        templet: function (d) {
                                            return '<input type="text" name="bankAccount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.bankAccount) + '">';
                                        }
                                    },
                                    {
                                        field: 'bankDeposit',
                                        title: '开户行',
                                        minWidth: 150,
                                        templet: function (d) {
                                            /*return '<span class="bankDeposit">' + undefind_nullStr(d.bankDeposit) + '</span>';*/
                                            return '<input type="text" name="bankDeposit" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.bankDeposit) + '">';
                                        }
                                    },
                                    {
                                        field: 'colMon',
                                        title: '收款金额',
                                        minWidth: 150,
                                        templet: function (d) {
                                            return '<input type="number" name="colMon"  class="layui-input <!--input_floatNum-->" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.colMon) + '">';
                                        }
                                    },
                                    {
                                        field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                                            return '<input type="text" name="remark" class="layui-input" autocomplete="off" style="height: 100%;" value="' + undefind_nullStr(d.remark) + '">';
                                        }
                                    }
                                ]

                                if (type != '3') {
                                    paymentDetailsTableCols.push({
                                        /*fixed: 'right',*/
                                        align: 'center',
                                        toolbar: '#barDemo2',
                                        title: '操作',
                                        minWidth: 100
                                    });
                                }
                                // 初始化付款明细列表
                                table.render({
                                    elem: '#paymentDetailsTable',
                                    data: reiPayList,
                                    toolbar: (type == 3) ? false : '#toolbarDemoIn',
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [paymentDetailsTableCols],
                                    done: function () {
                                        $('#paymentDetailsModule').find('input[name="colPeo"]').each(function (i, v) {
                                            $(v).attr('id', 'colPeo' + i);
                                        });
                                    }
                                });

                                if (type == 3) {
                                    $('._disabled').find('input').attr('readonly', true);
                                    $('[name="reiDate"]').attr('disabled', 'disabled');
                                    $('.deImgs').hide();
                                    $('.chooseMtlPlanId').hide();

                                }

                                form.render();
                            },
                            yes: function (index, layero) {
                                if(type!='3'){
                                    var loadIndex = layer.load();
                                    //材料计划数据
                                    var datas = $('#baseForm').serializeArray();
                                    var obj = {}
                                    datas.forEach(function (item) {
                                        obj[item.name] = item.value;
                                    });
                                    obj.projectId=$('#leftId').attr('projId');
                                    obj.handerId = $('input[name="handerId"]', $('#baseForm')).attr('user_id')?$('input[name="handerId"]', $('#baseForm')).attr('user_id').replace(/,$/, ''):'';
                                    obj.reiUserId = $('input[name="reiUserId"]', $('#baseForm')).attr('user_id')?$('input[name="reiUserId"]', $('#baseForm')).attr('user_id').replace(/,$/, ''):$('input[name="reiUserId"]', $('#baseForm')).attr('reiUserId');
                                    obj.department = $('input[name="department"]', $('#baseForm')).attr('deptId');

                                    obj.reiPlanId = $('.click_one').attr('reiPlanId')

                                    // 合同附件
                                    /*var attachmentId = '';
                                    var attachmentName = '';
                                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                        attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                                    }

                                    obj.attachmentId = attachmentId;
                                    obj.attachmentName = attachmentName;*/

                                    // 报销明细
                                    obj.reiBudList=getReimbursementDetailsData(1).dataArr;
                                    // 付款明细
                                    obj.reiPayList = getPaymentmentDetailsData(true).dataArr;

                                    // 判断必填项
                                    var requiredFlag = false;
                                    $('#baseForm').find('.field_required').each(function(){
                                        var field = $(this).attr('field');
                                        if (field && !obj[field] && obj[field] != '0') {
                                            var fieldName = $(this).parent().text().replace('*', '');
                                            layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }
                                    });
                                    var $tr = $('#reimbursementDetailsModule').find('.layui-table-main tr');
                                    var __flag=false;
                                    $tr.each(function (index,element) {
                                        //RBS
                                        if($(element).find('.rbsName').text()&&$(element).find('.rbsName').text().indexOf('招待费')>0){
                                            _flay = true;
                                            __flag = true;
                                        }

                                        //发生日期
                                        if(!$(element).find('[name="implementDate"]').val()){
                                            layer.msg('发生日期不能为空！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }
                                        //本次报销金额
                                        if(!$(element).find('[name="currentReimbursementAmount"]').val()){
                                            layer.msg('本次报销金额不能为空！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }

                                        //税额
                                        if(!$(element).find('[name="taxAmount"]').val()){
                                            layer.msg('税额不能为空！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }

                                        //不含税金额
                                        if(!$(element).find('[name="amountExcludingTax"]').val()){
                                            layer.msg('不含税金额不能为空！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }

                                        //截止本月额度(动态值)
                                        var _monQuata = $(element).find('.monQuata').attr('currMonQuata')||0;
                                        //截止本月已发生额度(动态值)
                                        var monHappenQuata = $(element).find('.monHappenQuata').attr('currMonHappenQuata')||0;
                                        //本次报销金额
                                        var _currentReimbursementAmount = $(element).find('[name="currentReimbursementAmount"]').val()||0;
                                        //截至本月额度-截至本月已发生额>=本次报销金额才能提交
                                        if(sub(_monQuata,monHappenQuata)<_currentReimbursementAmount){
                                            layer.msg('本次报销金额加截止本月已发生额度大于截止本月额度！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }


                                        //发票内容
                                        if($(element).find('[id^="fileAll"] .dech').length=='0'){
                                            layer.msg('请上传发票！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }

                                    });
                                    if(!__flag){
                                        _flay = false;
                                    }
                                    if(MYPROJECT){
                                        if(_flay){
                                            obj.businessFlag='是'
                                        }else {
                                            obj.businessFlag='否'
                                        }
                                    }


                                    var $tr2 = $('#paymentDetailsModule').find('.layui-table-main tr');
                                    $tr2.each(function (index,element) {
                                        //收款人
                                        if(!$(element).find('[name="colPeo"]').val()){
                                            layer.msg('请填写收款人！', {icon: 0, time: 2000});
                                            requiredFlag = true;
                                            return false;
                                        }
                                    })

                                    if (requiredFlag) {
                                        layer.close(loadIndex);
                                        return false;
                                    }

                                    $.ajax({
                                        url: url,
                                        data: JSON.stringify(obj),
                                        dataType: 'json',
                                        contentType: "application/json;charset=UTF-8",
                                        type: 'post',
                                        success: function (res) {
                                            layer.close(loadIndex);
                                            if (res.code==='0'||res.code===0) {
                                                layer.msg('保存成功！', {icon: 1});
                                                layer.close(index);
                                                reloadTableData();
                                            } else {
                                                layer.msg(res.msg, {icon: 2});
                                            }
                                        }
                                    });
                                }else {
                                    layer.close(index);
                                }

                            },
                            btn2: function (index) {
                                var loadIndex = layer.load();
                                //材料计划数据
                                var datas = $('#baseForm').serializeArray();
                                var obj = {}
                                datas.forEach(function (item) {
                                    obj[item.name] = item.value;
                                });
                                obj.projectId=$('#leftId').attr('projId');
                                obj.handerId = $('input[name="handerId"]', $('#baseForm')).attr('user_id')?$('input[name="handerId"]', $('#baseForm')).attr('user_id').replace(/,$/, ''):'';
                                obj.reiUserId = $('input[name="reiUserId"]', $('#baseForm')).attr('user_id')?$('input[name="reiUserId"]', $('#baseForm')).attr('user_id').replace(/,$/, ''):$('input[name="reiUserId"]', $('#baseForm')).attr('reiUserId');
                                obj.department = $('input[name="department"]', $('#baseForm')).attr('deptId');

                                obj.reiPlanId = $('.click_one').attr('reiPlanId')

                                // 合同附件
                                /*var attachmentId = '';
                                var attachmentName = '';
                                for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                    attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                    attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                                }

                                obj.attachmentId = attachmentId;
                                obj.attachmentName = attachmentName;*/

                                // 报销明细
                                obj.reiBudList=getReimbursementDetailsData(1).dataArr;
                                // 付款明细
                                obj.reiPayList = getPaymentmentDetailsData(true).dataArr;

                                // 判断必填项
                                var requiredFlag = false;
                                $('#baseForm').find('.field_required').each(function(){
                                    var field = $(this).attr('field');
                                    if (field && !obj[field] && obj[field] != '0') {
                                        var fieldName = $(this).parent().text().replace('*', '');
                                        layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }
                                });


                                var $tr = $('#reimbursementDetailsModule').find('.layui-table-main tr');
                                var __flag=false;
                                $tr.each(function (index,element) {
                                    //RBS
                                    if($(element).find('.rbsName').text()&&$(element).find('.rbsName').text().indexOf('招待费')>0){
                                        _flay = true;
                                        __flag = true;
                                    }

                                    //发生日期
                                    if(!$(element).find('[name="implementDate"]').val()){
                                        layer.msg('发生日期不能为空！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }
                                    //本次报销金额
                                    if(!$(element).find('[name="currentReimbursementAmount"]').val()){
                                        layer.msg('本次报销金额不能为空！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }

                                    //税额
                                    if(!$(element).find('[name="taxAmount"]').val()){
                                        layer.msg('税额不能为空！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }

                                    //不含税金额
                                    if(!$(element).find('[name="amountExcludingTax"]').val()){
                                        layer.msg('不含税金额不能为空！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }

                                    //截止本月额度(动态值)
                                    var _monQuata = $(element).find('.monQuata').attr('currMonQuata')||0;
                                    //截止本月已发生额度(动态值)
                                    var monHappenQuata = $(element).find('.monHappenQuata').attr('currMonHappenQuata')||0;
                                    //本次报销金额
                                    var _currentReimbursementAmount = $(element).find('[name="currentReimbursementAmount"]').val()||0;
                                    //截至本月额度-截至本月已发生额>=本次报销金额才能提交
                                    if(sub(_monQuata,monHappenQuata)<_currentReimbursementAmount){
                                        layer.msg('本次报销金额加截止本月已发生额度大于截止本月额度！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }


                                    //发票内容
                                    if($(element).find('[id^="fileAll"] .dech').length=='0'){
                                        layer.msg('请上传发票！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }

                                });
                                if(!__flag){
                                    _flay = false;
                                }
                                if(MYPROJECT){
                                    if(_flay){
                                        obj.businessFlag='是'
                                    }else {
                                        obj.businessFlag='否'
                                    }
                                }

                                var $tr2 = $('#paymentDetailsModule').find('.layui-table-main tr');
                                $tr2.each(function (index,element) {
                                    //收款人
                                    if(!$(element).find('[name="colPeo"]').val()){
                                        layer.msg('请填写收款人！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }
                                })

                                if (requiredFlag) {
                                    layer.close(loadIndex);
                                    return false;
                                }

                                $.ajax({
                                    url: url,
                                    data: JSON.stringify(obj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success: function (res) {
                                        layer.close(loadIndex);
                                        if (res.code==='0'||res.code===0) {
                                            //layer.msg('保存成功！', {icon: 1});
                                            layer.open({
                                                type: 1,
                                                title: '选择流程',
                                                area: ['70%', '80%'],
                                                btn: ['确定', '取消'],
                                                btnAlign: 'c',
                                                content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                                success: function () {
                                                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '46'}, function (res) {
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
                                                        approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                                        approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                                        if(MYPROJECT) {
                                                            if (_flay) {
                                                                approvalData.businessFlag = '是';
                                                            }
                                                        }
                                                        delete approvalData.reiBudList
                                                        delete approvalData.reiPayList
                                                        newWorkFlow(flowData.flowId, function (res) {
                                                            var submitData = {
                                                                reiId:approvalData.reiId,
                                                                runId: res.flowRun.runId
                                                                //auditerStatus:1
                                                            }
                                                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                            $.ajax({
                                                                url: '/otherExpenes/updateById',
                                                                data: JSON.stringify(submitData),
                                                                dataType: 'json',
                                                                contentType: "application/json;charset=UTF-8",
                                                                type: 'post',
                                                                success: function (res) {
                                                                    layer.close(loadIndex);
                                                                    if (res.code===0||res.code==="0") {
                                                                        layer.close(index);
                                                                        layer.msg('提交成功!', {icon: 1});
                                                                        reloadTableData();
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
                                            layer.msg(res.msg, {icon: 2});
                                        }
                                    }
                                });
                            },
                            btn3: function (index) {
                                layer.close(index);
                            }
                        });
                    }

                    //监听本次报销金额
                    $(document).on('input propertychange', 'input[name="currentReimbursementAmount"]', function () {
                        if($('#leftId').attr('_type')=='3'){
                            return false
                        }

                        var $tr = $('#reimbursementDetailsModule').find('.layui-table-main tr [name="currentReimbursementAmount"]');
                        //计算报销金额
                        var reiMon = 0;
                        $tr.each(function (index,element) {
                            reiMon=accAdd(reiMon,($(element).val()||0));
                        });
                        $('[name="reiMon"]').val(retainDecimal(reiMon,2))
                    });


                    //选择其他费用需求计划
                    $(document).on('click','.chooseMtlPlanId',function () {
                        var projId = $('#leftId').attr('projId');
                        var cols=[
                            {type:'radio'},
                            {field: 'documnetNum', title: '单据号', minWidth:140,sort: true, hide: false},
                            {field: 'reiPlanName', title: '计划名称', minWidth:140, sort: true, hide: false},
                            {field: 'projectName', title: '所属项目',  minWidth:100,sort: true, hide: false},
                            {field: 'estimateAmountSum', title: '需求计划金额', minWidth:180, sort: true, hide: false},
                            {field: 'needDate', title: '需用日期',  minWidth:100,sort: true, hide: false, templet: function (d) {
                                    return format(d.needDate);
                                }},
                            {field: 'createDate', title: '编制时间',  minWidth:100,sort: true, hide: false, templet: function (d) {
                                    return format(d.createDate);
                                }
                            },
                            // {title: '操作', width: 100, align: 'center', toolbar: '#revisionBarDemo'}
                        ]
                        layer.open({
                            type: 1,
                            title: '选择其他费用需求计划',
                            btn: ['确定','取消'],
                            btnAlign: 'c',
                            area: ['90%', '80%'],
                            maxmin: true,
                            content: '<div class="wrap_right flow_Table2" style="margin: 10px;">\n' +
                                '<div style="position: relative">\n' +
                                '<div class="table_box">\n' +
                                '<table id="flowTable2" lay-filter="flowTable2"></table>\n' +
                                '</div>\n' +
                                '</div>\n' +
                                '</div>',
                            success: function () {

                                table.render({
                                    elem: '#flowTable2',
                                    url: '/otherCostReiPlan/select',
                                    cols: [cols],
                                    //height: 'full-220',
                                    page: {
                                        limits: [10, 20, 30, 40, 50]
                                    },
                                    where: {
                                        projectId:projId || '',
                                        delFlag: '0',
                                        isCostRei:'costRei'
                                    },
                                    autoSort: false,
                                    request: {
                                        limitName: 'pageSize'
                                    },
                                });
                            },
                            yes: function (index) {
                                var checkStatus = table.checkStatus('flowTable2');
                                if (checkStatus.data.length > 0) {
                                    $('.click_one').val(checkStatus.data[0].reiPlanName).attr('reiPlanId',checkStatus.data[0].reiPlanId)
                                    layer.close(index);
                                } else {
                                    layer.msg('请选择一项！', {icon: 0});
                                }
                            }
                        })
                    });

                    //选择查看详情
                    $(document).on('click','.click_one',function () {
                        if(!($('.click_one').attr('reiPlanId'))){
                            return false
                        }

                        var data=null

                        layer.open({
                            type: 1,
                            title: '查看详情',
                            area: ['100%', '100%'],
                            btn: ['确定'],
                            btnAlign: 'c',
                            content: ['<div class="layui-collapse">\n' ,
                                /* region 材料计划 */
                                '  <div class="layui-colla-item">\n' +
                                '    <h2 class="layui-colla-title">其他费用需求计划</h2>\n' +
                                '    <div class="layui-colla-content layui-show plan_base_info">' +
                                '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
                                /* region 第一行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="documnetNum" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" style="background:#e7e7e7;" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">需求计划名称<span field="reiPlanName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="reiPlanName" autocomplete="off" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">编制时间<span field="createDate" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="createDate" readonly id="createDate" autocomplete="off" class="layui-input" style="background:#e7e7e7;width: 53%;display: inline-block">\n' +
                                '                     <button type="button" class="layui-btn  layui-btn-sm chooseManagementBudget">选择管理目标</button>'+
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">WBS<span field="wbsName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="wbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +

                                '           </div>' ,
                                /* endregion */
                                /* region 第二行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">RBS<span field="rbsName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="rbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">CBS<span field="cbsName" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="cbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">控制方式<span field="controlType" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="controlType"  readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">单位</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="itemUnit" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">管理目标数量<span field="manageTarNum" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                                '                       <input type="text" name="manageTarNum" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '           </div>' ,
                                /* endregion */
                                /* region 第三行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">管理目标金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="manageTarAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs " style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">累计已发生报销金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="realOutMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs " style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">在途报销金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="trnAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs " style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">本次需求计划金额</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="estimateAmountSum"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">需用日期<span field="needDate" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="needDate" id="needDate" autocomplete="off" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' ,
                                '           </div>' ,
                                /* endregion */
                                /* region 第四行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs4 col-xs" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">备注</label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="memo" autocomplete="off" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>',
                                '           </div>',
                                /* endregion */
                                /* region 第五行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">附件</label>' +
                                '                       <div class="layui-input-block form_block">' +
                                '<div class="file_module">' +
                                '<div id="fileContent" class="file_content"></div>' +
                                '<div class="file_upload_box">' +
                                '<a href="javascript:;" class="open_file">' +
                                '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                                '<input type="file" multiple id="fileupload" data-url="/upload?module=costReiPlanList" name="file">' +
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
                                '           </div>' ,
                                /* endregion */
                                '       </form>' +
                                '    </div>\n' +
                                '  </div>\n' ,
                                /* endregion */
                                /* region 需求计划明细 */
                                '  <div class="layui-colla-item">\n' +
                                '    <h2 class="layui-colla-title">需求计划明细</h2>\n' +
                                '    <div class="layui-colla-content mtl_info layui-show">' +
                                '       <div>' +
                                '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                                '      </div>' +
                                '    </div>\n' +
                                '  </div>\n' ,
                                /* endregion */
                                '</div>'].join(''),
                            success: function () {
                                $.ajax({
                                    url: '/otherCostReiPlan/getById?kayId='+$('.click_one').attr('reiPlanId'),
                                    dataType: 'json',
                                    type: 'post',
                                    async:false,
                                    success: function (res) {
                                        if (res.code==='0'||res.code===0) {
                                            data = res.obj
                                        } else {
                                            layer.msg('获取数据失败!', {icon: 0});
                                        }
                                    }
                                });

                                //回显数据
                                if (data) {
                                    //回显项目名称
                                    getProjName('#projectName',data.projId)

                                    fileuploadFn('#fileupload', $('#fileContent'));

                                    var reiPlanListData = [];
                                    //回显数据

                                        form.val("formTest", data);

                                        $('.plan_base_info input[name="wbsName"]').attr('wbsId', data.wbsId || '');
                                        $('.plan_base_info input[name="rbsName"]').attr('rbsId', data.rbsId || '');
                                        $('.plan_base_info input[name="cbsName"]').attr('cbsId', data.cbsId || '');
                                        // 控制方式
                                        $('.plan_base_info input[name="controlType"]').val(dictionaryObj['CONTROL_TYPE']['object'][data.controlType] || '');
                                        $('.plan_base_info input[name="controlType"]').attr('controlType', data.controlType || '');
                                        // 单位
                                        $('.plan_base_info input[name="itemUnit"]').val(dictionaryObj['CBS_UNIT']['object'][data.itemUnit] || '');
                                        $('.plan_base_info input[name="itemUnit"]').attr('itemUnit', data.itemUnit || '');

                                        if (data.attachmentList && data.attachmentList.length > 0) {
                                            var fileArr = data.attachmentList;
                                            $('#fileContent').append(echoAttachment(fileArr));
                                        }

                                        reiPlanListData = data.reiPlanList;

                                        $('.plan_base_info input').attr('readonly', true);
                                        $('.plan_base_info .file_upload_box').hide()
                                        $('.plan_base_info .deImgs').hide()
                                        $('.plan_base_info .chooseManagementBudget').hide()


                                    element.render();
                                    form.render();

                                    var cols=[
                                        {type: 'numbers', title: '操作'},
                                        {
                                            field: 'planListName', title: '名称', templet: function (d) {
                                                return '<input type="text" name="planListName" reiPlanId="'+(d.reiPlanId || '')+'" reiPlanListId="'+(d.reiPlanListId || '')+'" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.planListName || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'departName', title: '单位', templet: function (d) {
                                                return '<input type="text" name="departName" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.departName || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'currNum', title: '本次数量', templet: function (d) {
                                                return '<input type="number" name="currNum"  class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.currNum || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'estimatePrice', title: '预计单价', templet: function (d) {
                                                return '<input type="number" name="estimatePrice" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimatePrice || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'estimateAmount', title: '预计金额', templet: function (d) {
                                                return '<input type="number" name="estimateAmount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimateAmount || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'usePosition', title: '使用部位', templet: function (d) {
                                                return '<input type="text" name="usePosition" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.usePosition || '') + '">'
                                            }
                                        },
                                    ]

                                    table.render({
                                        elem: '#materialDetailsTable',
                                        data: reiPlanListData,
                                        defaultToolbar: [''],
                                        limit: 1000,
                                        cols: [cols],
                                        done:function () {
                                            $('.mtl_info input').attr('readonly', true);
                                        }
                                    });

                                }

                            }
                        })
                    });
                });
            }

            $(document).on('click', '.list_item', function () {
                $(this).siblings().removeClass('active');
                $(this).addClass('active');
                var type = $(this).attr('type');
                $('#leftId').val(type);

                if (type == '01' || type == '02') {
                    colShowObj.travelType = {
                        field: 'travelType', title: '差旅类型', sort: true, hide: false, templet: function (d) {
                            return dictionaryObj['TRAVEL_TYPE']['object'][d.travelType] || '';
                        }
                    }
                } else {
                    if (colShowObj.travelType) {
                        delete colShowObj.travelType;
                    }
                }

                if (type == '04') {
                    colShowObj.department.title = '申请部门';
                    if (colShowObj.reiUserId) {
                        delete colShowObj.reiUserId;
                    }
                } else {
                    colShowObj.department.title = '所属部门';
                    colShowObj.reiUserId = {
                        field: 'reiUserId', title: '报销人', sort: true, hide: false, templet: function (d) {
                            return (d.reiUserName || '').replace(/,$/, '');
                        }
                    }
                }

                TableUIObj.reloadCols(colShowObj);

                $('#searchBtn').trigger('click');
            });
            //数据列表点击审批状态查看流程功能
            $(document).on('click', '.preview_flow', function() {
                var flowId = $(this).attr('flowId'),
                    runId = $(this).attr('runId');
                if (flowId && runId) {
                    $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
                }
            });

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

            /**
             * 获取自动编号接口
             * @param params (参数{autoNumber: 数据库表名, costType: 报销单类型})
             * @param callback (回调函数)
             */
            function getAutoNumber(params, callback) {
                $.get('/planningManage/autoNumber', params, function (res) {
                    callback(res);
                });
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
            /**
             * 重新加载表格数据
             */
            /**
             * 获取查询条件
             * @returns {{auditerStatus: (String), documnetNum: (String), costType: (String)}}
             */
            function getSearchObj() {
                var searchObj = {
                    projectId:$('#leftId').attr('projId'),
                    /*documnetNum: $('[name="documnet_Num"]').val(),
                    reiUserId: $('[name="reiUser_Id"]').attr('user_id')?$('[name="reiUser_Id"]').attr('user_id').replace(/,$/, ''):'',
                    costType: $('[name="cost_Type"]').val(),
                    auditerStatus: $('[name="auditerStatus"]').val()*/
                }
                if($('[name="documnet_Num"]').val()){
                    searchObj.documnetNum = $('[name="documnet_Num"]').val()
                }
                if($('[name="reiUser_Id"]').attr('user_id')){
                    searchObj.reiUserId = $('[name="reiUser_Id"]').attr('user_id').replace(/,$/, '')
                }
                if($('[name="cost_Type"]').val()){
                    searchObj.costType = $('[name="cost_Type"]').val()
                }
                if($('[name="auditerStatus"]').val()){
                    searchObj.auditerStatus = $('[name="auditerStatus"]').val()
                }

                return searchObj;
            }
            function reloadTableData() {
                tableObj.config.where._ = new Date().getTime();
                tableObj.reload({
                    page: {
                        curr: 1
                    },
                    where: getSearchObj()
                });
            }
            function openRold(){ //流程转交下一步后会调用此方法
                //刷新表格
                reloadTableData();
            }
            //判断undefined
            function undefind_nullStr(value) {
                if(value==undefined || value == "undefined"){
                    return ""
                }
                return value
            }
            function responsibleOver(dom) {
                if($('#'+dom).attr('dataid')){
                    var dataid = $('#'+dom).attr('dataid').replace(/,/g, '')
                    $.ajax({
                        url: '/hr/api/getPersonFileByUserId?uid='+dataid,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            //银行账号
                            $('#'+dom).parents('tr').find('[name="bankAccount"]').val(res.bankAccount1?res.bankAccount1:'')
                            //开户行
                            $('#'+dom).parents('tr').find('[name="bankDeposit"]').val(res.bank1?res.bank1:'')
                        }
                    });
                }
            }
        </script>
    </body>
</html>
