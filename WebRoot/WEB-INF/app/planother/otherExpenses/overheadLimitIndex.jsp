<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/7/12
  Time: 9:41
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
    <title>间接费月额度</title>

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
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210604.1"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.2"></script>

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
            margin-left: 8%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">其他费用额度</h2>
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
                    <input type="text" name="itemNo" placeholder="立项编号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select name="itemType">
                        <option value="">请选择</option>
                    </select>
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select name="auditerStatus">
                        <option value="">请选择</option>
                        <option value="0">待审批</option>
                        <option value="1">批准</option>
                        <option value="2">未批准</option>
                    </select>
                </div>
                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm searchData" id="searchBtn">查询</button>
                    <button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>
                </div>
                <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>
            </div>
            <div style="position: relative">
                <div class="table_box" style="display: none">
                    <table id="mtlPlanTable" lay-filter="mtlPlanTable"></table>
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
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入</button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出</button>
    </div>
</script>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>
    var projectNamee;
    var _projectId;
    var materialDetailsTableData = [];
    var _dataa;


    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    //表格显示顺序
    var colShowObj = {
        documnetNum: {field: 'documnetNum', title: '单据号', sort: true, hide: false},
        projectName:{field: 'projectName', title: '项目名称', sort: true, hide: false},
        month: {field: 'month', title: '月度', sort: true, hide: false},
        monIndExp: {field: 'monIndExp', title: '本次其他费用总额度', sort: true, hide: false},
        currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
        auditerStatus:{field:'auditerStatus',title:"审批状态",templet: function (d) {
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
        }}
    }

    var TableUIObj = new TableUI('plb_manage_item');

    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {},
        MTL_VALUATION_UNIT:{},
        MANAGE_ITEM_TYPE:{}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,MTL_VALUATION_UNIT,MANAGE_ITEM_TYPE';
    $.ajaxSettings.async = false;
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
    var tableIns = null;
    function initPage() {
        $.ajaxSettings.async = true;
        layui.use(['form', 'table', 'element', 'soulTable', 'eleTree','xmSelect','laydate'], function () {
            var form = layui.form,
                table = layui.table,
                element = layui.element,
                soulTable = layui.soulTable,
                eleTree = layui.eleTree,
                xmSelect = layui.xmSelect
                laydate = layui.laydate;


            TableUIObj.init(colShowObj, function(){
                // $('.no_data').hide();
                // $('.table_box').show();
                // tableShow();
            });

            $('[name="itemType"]', $('.query_module')).append(dictionaryObj['MANAGE_ITEM_TYPE']['str']);

            form.render();

            // 初始化左侧项目
            projectLeft();

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
                    }
                });
            }

            // 树节点点击事件
            eleTree.on("nodeClick(leftTree)", function (d) {
                var currentData = d.data.currentData;
                _projectId = currentData.projId;
                projectNamee = currentData.projName;
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

            // 上方按钮显示
            table.on('toolbar(mtlPlanTable)', function (obj) {
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
                        if($('#leftId').attr('projId')){
                            if (checkStatus.data.length != 1) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }
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

                        var ids = ''
                        var isFlay = false;
                        checkStatus.data.forEach(function (v, i) {
                            ids += v.targetCostId + ','
                            if(v.auditerStatus&&v.auditerStatus!='0'){
                                isFlay = true
                            }
                        })
                        if(isFlay){
                            layer.msg('已提交不可删除！', {icon: 0});
                            return false
                        }
                        layer.confirm('确定删除该条数据吗？', function (index) {
                            $.post('/overheadLimit/del', {ids: ids}, function (res) {
                                if (res.code==='0'||res.code===0) {
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
                        layer.msg('功能完善中');
                        break;
                    case 'import':
                        layer.msg('功能完善中');
                        break;
                    case 'submit':
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
                                $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '45'}, function (res) {
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
                                    delete approvalData.detailList
                                    //delete approvalData.manageInfoList
                                    newWorkFlow(flowData.flowId, function (res) {
                                        var submitData = {
                                            targetCostId:approvalData.targetCostId,
                                            runId: res.flowRun.runId
                                            //auditerStatus:1
                                        }
                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                        $.ajax({
                                            url: '/overheadLimit/updateById',
                                            data: JSON.stringify(submitData),
                                            dataType: 'json',
                                            contentType: "application/json;charset=UTF-8",
                                            type: 'post',
                                            success: function (res) {
                                                layer.close(loadIndex);
                                                if (res.code===0||res.code==="0") {
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
            //行内操作
            table.on('tool(mtlPlanTable)', function (obj) {
                var checkStatus = obj.data;
                switch (obj.event) {
                    case 'detail':
                        if($('#leftId').attr('projId')){
                            if (!checkStatus) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }
                            //newOrEdit(4, checkStatus.data[0])

                            layer.open({
                                type: 2,
                                // skin: 'layui-layer-molv', //加上边框
                                area: ['100%', '100%'], //宽高
                                title: '查看详情',
                                maxmin: true,
                                btn: ['确定'],
                                btnAlign: 'c',
                                content:'/overheadLimit/overheadLimitView?type=4&targetCostId='+checkStatus.targetCostId,
                                success: function () {

                                },
                                yes: function (index, layero) {
                                    layer.close(index);
                                }
                            });

                        }else{
                            layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                            return false;
                        }

                        break;
                }
            });
            // 监听排序事件
            table.on('sort(mtlPlanTable)', function (obj) {
                var param = {
                    orderbyFields: obj.field,
                    orderbyUpdown: obj.type
                }

                TableUIObj.update(param, function () {
                    tableShow($('#leftId').attr('projId') || '');
                })
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



            // 渲染表格
            function tableShow(projId) {
                var searchObj = getSearchObj();
                searchObj.projectId = projId || '';
                searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
                searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                var cols = [{checkbox: true}].concat(TableUIObj.cols);

                cols.push({
                    fixed: 'right',
                    align: 'center',
                    toolbar: '#detailBarDemo',
                    title: '操作',
                    width: 100
                })

                var option = {
                    elem: '#mtlPlanTable',
                    url: '/overheadLimit/select',
                    toolbar: '#toolbarDemo',
                    cols: [cols],
                    defaultToolbar: ['filter'],
                    height: 'full-80',
                    page: {
                        limit: TableUIObj.onePageRecoeds,
                        limits: [10, 20, 30, 40, 50]
                    },
                    where: searchObj,
                    //     {
                    //     // projId: projId,
                    //     // orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    //     // orderbyUpdown: TableUIObj.orderbyUpdown
                    // },
                    request: {
                        limitName: 'pageSize'
                    },

                    done: function (res) {
                        //增加拖拽后回调函数
                        soulTable.render(this, function () {
                            TableUIObj.dragTable('mtlPlanTable');
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

                tableIns = table.render(option);
            }

            // 新建/编辑
            function newOrEdit(type, data) {
                var title = '';
                var content = '';
                var url = '';
                var projId = $('#leftId').attr('projId');
                $('#leftId').attr('_type',type)

                if (type == '0') {
                    title = '新建其他费用额度';
                    //content = '/plbOperateManage/addOperateProjectModule?type=0';
                    url = '/overheadLimit/insert';
                } else if (type == '1') {
                    title = '编辑其他费用额度';
                    //content = '/plbOperateManage/addOperateProjectModule?type=1&targetCostId='+data.targetCostId;
                    url = '/overheadLimit/updateById?targetCostId='+data.targetCostId;
                    if(data.auditerStatus&&data.auditerStatus != '0'){
                        layer.msg('该数据已提交！', {icon: 0, time: 2000});
                        return false;
                    }

                }else if (type == '4'){
                    title = '查看详情';
                    //content = '/plbOperateManage/addOperateProjectModule?type=4&targetCostId='+data.targetCostId;
                }

                layer.open({
                    type: 1,
                    title: title,
                    area: ['100%', '100%'],
                    btn: ['保存', '提交', '取消'],
                    btnAlign: 'c',
                    content:['<div class="layui-collapse">\n' +
                    <%--    /* region 立项项目基础信息 */--%>
                    '    <div class="layui-colla-item">\n' +
                    '        <h2 class="layui-colla-title">立项信息</h2>\n' +
                    '        <div class="layui-colla-content layui-show plan_base_info">\n' +
                    '            <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
                    <%--                /* region 第一行 */--%>
                    '                <div class="layui-row">\n' +
                    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="documnetNum" autocomplete="off" class="layui-input">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly id="projectName" name="projectName" autocomplete="off"  class="layui-input ">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    <%--                /* endregion */--%>
                    <%--                /* region 第二行 */--%>
                    '                <div class="layui-row">\n' +
                    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">月度<span field="month" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="month" id="month" autocomplete="off"  class="layui-input ">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">本次其他费用总额度<span field="monIndExp" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="monIndExp" autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    <%--                /* endregion */--%>
                    '            </form>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    <%--    /* endregion */--%>
                    <%--    /* region 间接费额度 */--%>
                    '    <div class="layui-colla-item">\n' +
                    '        <h2 class="layui-colla-title">其他费用额度</h2>\n' +
                    '        <div class="layui-colla-content mtl_info layui-show">\n' +
                    '            <div>\n' +
                    '                <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    <%--    /* endregion */--%>
                    '</div>'].join(''),
                    success: function () {
                        //项目名称
                        $('#projectName').val(projectNamee);
                        //月度
                        /*laydate.render({
                            elem: '#projectDate'
                            , trigger: 'click'
                            , type: 'month'
                            // , format: 'yyyy-MM-dd HH:mm:ss'
                            //,value: new Date()
                        });*/
                        //新增时计划编号显示
                        if (type === 0) {
                            materialDetailsTableData = [];
                            // 获取单据号
                            $.ajax({
                                url:'/planningManage/autoNumber?autoNumberType=targetCost',
                                dataType:'json',
                                type:'post',
                                async: false,
                                success:function(res){
                                    $('input[name="documnetNum"]').val(res.obj);
                                    $('input[name="month"]').val(res.object.month);
                                }
                            })
                            $(document).on('click', '.refresh_no_btn', function () {
                                $.ajax({
                                    url:'/planningManage/autoNumber?autoNumberType=targetCost',
                                    dataType:'json',
                                    type:'post',
                                    async: false,
                                    success:function(res){
                                        $('input[name="documnetNum"]').val(res.obj);
                                        $('input[name="month"]').val(res.object.month);
                                    }
                                })
                            })
                        }
                        //回显数据
                        if (type == 1 || type == 4) {
                            if(data!=undefined){
                                form.val("baseForm", data);
                                //项目名称
                                _projectId = data.projectId;
                                materialDetailsTableData = data.detailList;
                            }
                        }

                        form.render();

                        //间接费额度
                        var cols=[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'wbsId', title: 'WBS',minWidth:230, templet: function (d) {
                                    return '<input type="text" readonly name="wbsId" wbsId="'+d.wbsId+'" projBudgetId="'+(d.projBudgetId||"")+'"  targetCostDetailsId="'+(d.targetCostDetailsId||"")+'" targetCostId="'+d.targetCostId+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.wbsName || '') + '">'
                                }
                            },
                            {
                                field: 'rbsId', title: 'RBS',minWidth:240, templet: function (d) {
                                    return '<input type="text" readonly name="rbsId" cbsId="'+d.rbsId+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.rbsLongName || '') + '">'
                                }
                            },
                            {
                                field: 'cbsId', title: 'CBS',minWidth:200, templet: function (d) {
                                    return '<input type="text" readonly name="cbsId" cbsId="'+d.cbsId+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.cbsName || '') + '">'
                                }
                            },
                            {
                                field: 'manageTarAmount', title: '管理目标金额',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="manageTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarAmount || 0) + '">'
                                }
                            },
                            {
                                field: 'monQuata', title: '截止当前累计额度',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="monQuata" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.monQuata || 0) + '">'
                                }
                            },
                            {
                                field: 'surQuata', title: '管理目标剩余额度',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="surQuata" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.surQuata || 0) + '">'
                                }
                            },
                            {
                                field: 'monthQuata', title: '本次额度*',minWidth:120, templet: function (d) {
                                    return '<input type="number" name="monthQuata" class="layui-input" style="height: 100%;" value="' + (d.monthQuata || "") + '">'
                                }
                            },
                        ]
                        if(type!=4){
                            cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100,fixed:'right'})
                        }
                        table.render({
                            elem: '#materialDetailsTable',
                            data: materialDetailsTableData,
                            toolbar: '#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols],
                            done:function (obj) {
                                if(type==4){
                                    $('.addRow').hide()
                                }
                                if(obj != undefined&&obj.data != undefined){
                                    //
                                    materialDetailsTableData = obj.data;
                                }
                            }
                        });
                    },
                    yes: function (index) {
                        var loadIndex = layer.load();
                        //材料计划数据
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value;
                        });
                        obj.projectId=_projectId;
                        if (type == '1') {
                            obj.targetCostId=data.targetCostId;
                        }

                        // 判断必填项
                        /*var requiredFlag = false;
                        $('#baseForm').find('.field_required').each(function(){
                            var field = $(this).attr('field');
                            if (field && !obj[field] && obj[field] != '0') {
                                var fieldName = $(this).parent().text().replace('*', '');
                                layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                                requiredFlag = true;
                                return false;
                            }
                        });

                        if (requiredFlag) {
                            layer.close(loadIndex);
                            return false;
                        }*/

                        var requiredFlag = false;
                        var $tr = $('.mtl_info').find('.layui-table-main tr [name="monthQuata"]');
                        $tr.each(function (index,element) {
                            if(!$(element).val()){
                                layer.msg('本月额度不能为空！', {icon: 0, time: 2000});
                                requiredFlag = true;
                                return false;
                            }
                        });

                        //间接费额度
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var detailList = [];
                        $tr.each(function () {
                            var plbManageItemObj = {
                                wbsName: $(this).find('input[name="wbsId"]').val(),
                                wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                                cbsName: $(this).find('input[name="cbsId"]').val(),
                                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                                rbsName: $(this).find('input[name="rbsId"]').val(),
                                rbsId: $(this).find('input[name="rbsId"]').attr('rbsId'),
                                manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                                monQuata: $(this).find('input[name="monQuata"]').val(),
                                surQuata: $(this).find('input[name="surQuata"]').val(),
                                monthQuata: retainDecimal($(this).find('input[name="monthQuata"]').val(),2),
                            }
                            if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                                plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
                            }
                            if($(this).find('input[name="wbsId"]').attr('targetCostDetailsId')){
                                plbManageItemObj.targetCostDetailsId=$(this).find('input[name="wbsId"]').attr('targetCostDetailsId');
                            }
                            if(data!=undefined&&data.targetCostId!=undefined){
                                plbManageItemObj.targetCostId=data.targetCostId
                            }
                            //管理目标余额>=本次额度  可以提交
                            if(Number(plbManageItemObj.surQuata)<Number(plbManageItemObj.monthQuata)){
                                requiredFlag = true;
                                layer.msg('管理目标余额>=本次额度！', {icon: 0, time: 3000});
                            }

                            detailList.push(plbManageItemObj);
                        });
                        obj.detailList = detailList;

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
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload();
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        });
                    },
                    btn2: function (index) {
                        var loadIndex = layer.load();
                        //材料计划数据
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value;
                        });
                        obj.projectId=_projectId;
                        obj.projectId=_projectId;
                        if (type == '1') {
                            obj.targetCostId=data.targetCostId;
                        }

                        var requiredFlag = false;
                        var $tr = $('.mtl_info').find('.layui-table-main tr [name="monthQuata"]');
                        $tr.each(function (index,element) {
                            if(!$(element).val()){
                                layer.msg('本月额度不能为空！', {icon: 0, time: 2000});
                                requiredFlag = true;
                                return false;
                            }
                        });

                        //间接费额度
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var detailList = [];
                        $tr.each(function () {
                            var plbManageItemObj = {
                                wbsName: $(this).find('input[name="wbsId"]').val(),
                                wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                                cbsName: $(this).find('input[name="cbsId"]').val(),
                                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                                rbsName: $(this).find('input[name="rbsId"]').val(),
                                rbsId: $(this).find('input[name="rbsId"]').attr('rbsId'),
                                manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                                monQuata: $(this).find('input[name="monQuata"]').val(),
                                surQuata: $(this).find('input[name="surQuata"]').val(),
                                monthQuata: $(this).find('input[name="monthQuata"]').val(),
                            }
                            if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                                plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
                            }
                            if($(this).find('input[name="wbsId"]').attr('targetcostdetailsid')){
                                plbManageItemObj.targetcostdetailsid=$(this).find('input[name="wbsId"]').attr('targetcostdetailsid');
                            }

                            if(data!=undefined&&data.targetCostId!=undefined){
                                plbManageItemObj.targetCostId=data.targetCostId
                            }
                            //管理目标余额>=本次额度  可以提交
                            if(Number(plbManageItemObj.surQuata)<Number(plbManageItemObj.monthQuata)){
                                requiredFlag = true;
                                layer.msg('管理目标余额>=本次额度！', {icon: 0, time: 3000});
                            }
                            detailList.push(plbManageItemObj);
                        });
                        obj.detailList = detailList;

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
                                    layer.open({
                                        type: 1,
                                        title: '选择流程',
                                        area: ['70%', '80%'],
                                        btn: ['确定', '取消'],
                                        btnAlign: 'c',
                                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                        success: function () {
                                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '45'}, function (res) {
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
                                                delete approvalData.detailList
                                                //delete approvalData.manageInfoList
                                                newWorkFlow(flowData.flowId, function (res) {
                                                    debugger
                                                    var submitData = {
                                                        targetCostId:approvalData.targetCostId,
                                                        runId: res.flowRun.runId
                                                        //auditerStatus:1
                                                    }
                                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                    $.ajax({
                                                        url: '/overheadLimit/updateById',
                                                        data: JSON.stringify(submitData),
                                                        dataType: 'json',
                                                        contentType: "application/json;charset=UTF-8",
                                                        type: 'post',
                                                        success: function (res) {
                                                            layer.close(loadIndex);
                                                            if (res.code===0||res.code==="0") {
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

            // 间接费额度-选择
            table.on('toolbar(materialDetailsTable)', function (obj) {

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
                                            {field: 'monQuata', title: '截止当前累计额度',minWidth:170},
                                            {field: 'surQuata', title: '剩余额度',minWidth:170},
                                            //{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                            //{field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},
                                        ]],
                                        done:function(res){
                                            _dataa=res.data;
                                            if(materialDetailsTableData!=undefined&&materialDetailsTableData.length>0){
                                                for(var i = 0 ; i <_dataa.length;i++){
                                                    for(var n = 0 ; n < materialDetailsTableData.length; n++){
                                                        if(_dataa[i].projBudgetId == materialDetailsTableData[n].projBudgetId){
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
                                var checkStatus=[];
                                $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                    if($(item).find('.layui-form-checked').length>0){
                                        checkStatus.push(_dataa[index]);
                                    }
                                })
                                //var checkStatus = table.checkStatus('managementBudgetTable').data;

                                var oldDataArr = [];
                                if (checkStatus.length > 0) {
                                    for(var i=0;i<checkStatus.length;i++){
                                        var oldDataObj = {
                                            projBudgetId:checkStatus[i].projBudgetId,
                                            manageTarAmount:checkStatus[i].manageTarAmount,
                                            monQuata:checkStatus[i].monQuata,
                                            monthQuata:checkStatus[i].monthQuata,
                                            surQuata:checkStatus[i].surQuata
                                        }
                                        if(checkStatus[i].plbCbsTypeWithBLOBs!=undefined){
                                            if(checkStatus[i].plbCbsTypeWithBLOBs.cbsName!=undefined){
                                                oldDataObj.cbsName=checkStatus[i].plbCbsTypeWithBLOBs.cbsName;
                                            }
                                            if(checkStatus[i].plbCbsTypeWithBLOBs.cbsId!=undefined){
                                                oldDataObj.cbsId=checkStatus[i].plbCbsTypeWithBLOBs.cbsId;
                                            }
                                        }
                                        if(checkStatus[i].plbProjWbs!=undefined){
                                            if(checkStatus[i].plbProjWbs.wbsName!=undefined){
                                                oldDataObj.wbsName=checkStatus[i].plbProjWbs.wbsName;
                                            }
                                            if(checkStatus[i].plbProjWbs.wbsId!=undefined){
                                                oldDataObj.wbsId=checkStatus[i].plbProjWbs.wbsId;
                                            }
                                        }
                                        if(checkStatus[i].plbRbs!=undefined){
                                            if(checkStatus[i].plbRbs.rbsLongName!=undefined){
                                                oldDataObj.rbsLongName=checkStatus[i].plbRbs.rbsLongName;
                                            }
                                            if(checkStatus[i].plbRbs.wbsId!=undefined){
                                                oldDataObj.rbsId=checkStatus[i].plbRbs.rbsId;
                                            }
                                        }
                                        if(materialDetailsTableData){
                                            var _flag = true
                                            for(var j=0;j<materialDetailsTableData.length;j++){
                                                if(materialDetailsTableData[j].projBudgetId==checkStatus[i].projBudgetId){
                                                    _flag = false
                                                }
                                            }
                                            if(_flag){
                                                materialDetailsTableData.push(oldDataObj);
                                            }

                                        }else{
                                            materialDetailsTableData.push(oldDataObj);
                                        }

                                    }

                                    layer.close(index);

                                    table.reload('materialDetailsTable', {
                                        data: materialDetailsTableData
                                    });
                                } else {
                                    layer.msg('请选择一项！', {icon: 0});
                                }
                            }
                        });

                        break;
                }
            });
            // 间接费额度-删行操作
            table.on('tool(materialDetailsTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                if (layEvent === 'del') {
                    if(data.targetCostDetailsId){
                        $.ajax({
                            url: '/overheadLimit/delDetails?ids='+data.targetCostDetailsId,
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                //本月额度
                                var monIndExp=data.monthQuata;
                                var monIndExp_sum = $('input[name="monIndExp"]').val()
                                var monIndExp_sum=sub(monIndExp_sum,monIndExp)
                                $('input[name="monIndExp"]').val(retainDecimal(monIndExp_sum,3))
                                /*if (res.code==='0'||res.code===0) {
                                    layer.msg(res.msg, {icon: 1});
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }*/
                            }
                        });
                    }else{
                        //本月额度
                        var monIndExp=data.monthQuata;
                        var monIndExp_sum = $('input[name="monIndExp"]').val()
                        var monIndExp=sub(monIndExp_sum,monIndExp)
                        $('input[name="monIndExp"]').val(retainDecimal(monIndExp,3))
                    }

                    obj.del();

                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            projBudgetId:$(this).find('input[name="wbsId"]').attr('projBudgetId'),
                            targetCostId: $(this).find('input[name="wbsId"]').attr('targetCostId'),
                            targetCostDetailsId: $(this).find('input[name="wbsId"]').attr('targetCostDetailsId'),
                            wbsName: $(this).find('input[name="wbsId"]').val(),
                            wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                            cbsName: $(this).find('input[name="cbsId"]').val(),
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                            rbsName: $(this).find('input[name="rbsId"]').val(),
                            rbsLongName: $(this).find('input[name="rbsId"]').val(),
                            rbsId: $(this).find('input[name="rbsId"]').attr('rbsId'),
                            manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                            monQuata: $(this).find('input[name="monQuata"]').val(),
                            surQuata: $(this).find('input[name="surQuata"]').val(),
                            monthQuata: $(this).find('input[name="monthQuata"]').val(),
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });
                }
            });

            //监听本月额度
            $(document).on('input propertychange', 'input[name="monthQuata"]', function () {
                if($('#leftId').attr('_type')=='4'){
                    return false
                }

                var $tr = $('.mtl_info').find('.layui-table-main tr');
                if($(this).val() && $(this).parents('tr').find('[name="monthQuata"]').val()){

                    //本月额度
                    var monIndExp=0
                    var monIndExp_sum=0

                    $tr.each(function () {
                        monIndExp=$(this).find('input[name="monthQuata"]').val()
                        monIndExp_sum=accAdd(monIndExp_sum,monIndExp)
                    });
                    $('input[name="monIndExp"]').val(retainDecimal(monIndExp_sum,2))
                }
            });
            //数据列表点击审批状态查看流程功能
            $(document).on('click', '.preview_flow', function() {
                var flowId = $(this).attr('flowId'),
                    runId = $(this).attr('runId');
                if (flowId && runId) {
                    $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
                }
            });

            // 查询
            $('#searchBtn').on('click', function(){
                tableShow($('#leftId').attr('projId') || '');
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
                    projectId:$('#leftId').attr('projId')

                    /*itemNo: $('input[name="itemNo"]', $('.query_module')).val(),
                    itemType:$('input[name="itemType"]',$('.query_module')).val(),
                    auditerStatus:$('input[name="auditerStatus"]',$('.query_module')).val()*/
                }

                return searchObj
            }

        });
    }

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
