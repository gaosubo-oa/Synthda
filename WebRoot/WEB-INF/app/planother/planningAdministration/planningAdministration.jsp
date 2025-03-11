<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-08
  Time: 11:03
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
    <title>管理策划列表界面</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>

    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

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
            overflow-y: scroll;
            overflow-x: hidden;
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

        .refresh_no_btn, .refresh_sort_btn {
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
            <h2 style="text-align: center;line-height: 35px;">管理策划</h2>
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
                <%--表格上方搜索栏--%>
                <form class="layui-form" action="" style="height: 40px">
                    <div class="demoTable" style="height: 40px" >
                        <div class="layui-row">
                            <div class="layui-col-xs3">
                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">
                                    <label class="layui-form-label" style="width: 25%;">单据号</label>
                                    <div class="layui-input-inline" style="width: 45%;">
                                        <input class="layui-input" id="planingNo"  autocomplete="off"  name="planingNo" placeholder="" style="height: 38px;margin-left: 6px;position: absolute;">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-xs4">
                                <div class="layui-form-item" style="/*width: 30%;*/margin: 10px -30px 10px;">
                                    <label class="layui-form-label" style="width: 35%;">管理策划名称</label>
                                    <div class="layui-input-inline" style="width: 40%;">
                                        <input class="layui-input" id="planingName"  autocomplete="off"  name="planingName" placeholder="" style="height: 38px;margin-left: 6px;position: absolute;">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-xs2">
                                <div class="layui-form-item" style="/*width: 5%;*/margin: 10px 0;">
                                    <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                                        <a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;">搜索</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div style="position: relative;top: -18px">
                <div class="table_box"  >
                    <table id="demoTreeTb" lay-filter="demoTreeTb" class="layui-table"></table>
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
        <button class="layui-btn layui-btn-sm add" lay-event="add" >新增</button>
        <button class="layui-btn layui-btn-sm edit" lay-event="edit" >编辑</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger del" lay-event="del" >删除</button>
        <div style="position:absolute;top: 10px;right: 12%;">
            <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
            <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入</button>
            <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出</button>
        </div>
    </div>
</script>
<script type="text/html" id="details">
    <button class="layui-btn layui-btn-sm" lay-event="details">查看详情</button>
</script>
<script>
    var securityInfoDate;
    var projectIdd;
    var  projectNamee;
    var insTb
    $('.con_left ul').height($(window).height()-180)
    var embodimentUrlType = getUrlParam("embodimentUrlType");
    var paninnId = getUrlParam("planingId");
    var toolbar;
    var colsType;
    if(embodimentUrlType=='addImplement'){
        toolbar = ''
        colsType = 'radio'
    }else {
        toolbar = '#toolbarDemo'
        colsType = 'checkbox'
    }

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }

    layui.use(['treeTable','form','laydate','upload', 'element', 'layer','eleTree','table'], function () {
        var treeTable = layui.treeTable;
        var laydate = layui.laydate;
        var upload = layui.upload;
        var eleTree = layui.eleTree;
        var form = layui.form;
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;


        //头工具栏事件

        $('#searchCust').click(function () {
            var serchObjUrl = "/planningAdministration/selectPlanning?";
            //var searchtext = $("#securityRegionName").attr("pid3");
            var searchtext1 = $("#planingNo").val();
            var searchtext3 = $("#planingName").val();
            if(searchtext1!=""&&searchtext1!=undefined){
                serchObjUrl+="&planingNo="+searchtext1;
            }
            if(searchtext3!=""&&searchtext3!=undefined){
                serchObjUrl+="&planingName="+searchtext3;
            }

            table.reload("demoTreeTb",{
                url: serchObjUrl
            });
        })

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
                $('#leftId').attr('decomposeLevel', currentData.decomposeLevel);
                tableInit(currentData.projId);
                projectIdd = currentData.projId;
                projectNamee = currentData.projName;
                $('.no_data').hide();
                $('.table_box').show();
            }else{
                $('.table_box').hide();
                $('.no_data').show();
            }
        });

        // 渲染数据表格
        function tableInit(projectId) {
            insTb=table.render({
                elem: '#demoTreeTb',
                url: '/planningAdministration/selectPlanning?projectId=' + projectId,
                toolbar: '#toolbarDemo',
                cols: [[
                    {type:'checkbox'}
                    ,{field: 'planingNo', title: '单据号',minWidth:150}
                    , {field: 'projectName', title: '项目名称',minWidth:120}
                    // , {field: 'projectTypeName', title: '项目类型',minWidth:100}
                    , {field: 'planingName', title: '管理策划名称',minWidth:120}
                    , {field: 'userName', title: '填报人',minWidth:100}
                    , {field: 'createTime', title: '填报时间',minWidth:100}
                    , {field:'currFlowUserName',title:'当前处理人',minWidth:120}
                    , {field:'auditerStatus',title:"审批状态",templet: function (d) {
                            var str = '';
                            if (d.auditerStatus == '1') {
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
                            } else if (d.auditerStatus == '2') {
                                var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                                str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
                            } else if (d.auditerStatus == '3') {
                                str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
                            } else {
                                str = '未提交';
                            }
                            return str;
                        }}
                    , {field: 'planingDesc', title: '备注',align:'center',minWidth:100}
                    ,{title:'操作',align:'center',toolbar:'#details',minWidth:150}
                ]]
                ,limit: 10
                , page: true

            })
        }
        //数据列表点击审批状态查看流程功能
        $(document).on('click', '.preview_flow', function() {
            var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId');
            if (flowId && runId) {
                $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
            }
        });

        table.on('toolbar(demoTreeTb)', function (obj) {
            var checkStatus = table.checkStatus("demoTreeTb").data;
            securityInfoDate = checkStatus[0];
            var event = obj.event;
            if (event === 'add') { //新增
                layer.open({
                    type: 2,
                    //skin: 'layui-layer-molv', //加上边框
                    area: ['100%', '100%'], //宽高
                    title: '新增管理策划',
                    maxmin: true,
                    btn: ['保存','提交', '取消'],
                    btnAlign:'c',
                    content: '/planningAdministration/addPlanningAdministration?urlType=add&projectId=' + projectIdd,
                    yes: function (index, layero) {
                        var childData = $(layero).find("iframe")[0].contentWindow.getData();
                        $.ajax({
                            url: '/planningAdministration/insertPlanning',
                            dataType: 'json',
                            type: 'post',
                            data: childData,
                            success: function (res) {
                                if (res.code === 0 || res.code === "0") {
                                    layer.msg(res.msg, {icon: 1});
                                    insTb.reload()
                                    layer.close(index)
                                } else {
                                    layer.msg(res.msg, {icon: 0});
                                }
                            }
                        })
                    }, btn2: function (index, layero) {
                        layer.close(index)
                        var childData = $(layero).find("iframe")[0].contentWindow.getData();
                        $.ajax({
                            url: '/planningAdministration/insertPlanning',
                            dataType: 'json',
                            type: 'post',
                            data: childData,
                            success: function (res) {
                                if (res.code === 0 || res.code === "0") {
                                    layer.open({
                                        type: 1,
                                        title: '选择流程',
                                        area: ['70%', '80%'],
                                        btn: ['确定', '取消'],
                                        btnAlign: 'c',
                                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                        success: function () {
                                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '56'}, function (res) {
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
                                            var checkStatusFlow = table.checkStatus('flowTable');
                                            if (checkStatusFlow.data.length > 0) {
                                                var flowData = checkStatusFlow.data[0];
                                                var approvalData = res.obj
                                                newWorkFlow(flowData.flowId, function (res) {
                                                    var submitData = {
                                                        planingId:approvalData.planingId,
                                                        runId: res.flowRun.runId,
                                                    }
                                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                    $.ajax({
                                                        url: '/planningAdministration/updatePlanning',
                                                        data: submitData,
                                                        dataType: 'json',
                                                        type: 'post',
                                                        success: function (res) {
                                                            layer.close(loadIndex);
                                                            if (res.code===0||res.code==="0") {
                                                                layer.close(index);
                                                                layer.msg('提交成功!', {icon: 1});
                                                                insTb.config.where._ = new Date().getTime();
                                                                insTb.reload()
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
                                    // layer.msg(res.msg, {icon: 1});
                                    // insTb.reload()
                                    // layer.close(index)
                                } else {
                                    layer.msg(res.msg, {icon: 0});
                                }
                            }
                        })
                    }
                });
            } else if (event == 'del') { //删除
                if (checkStatus.length < 1) {
                    layer.msg("请至少选择一条");
                } else {
                    layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title: '提示'}, function (index) {
                        var ids = "";
                        for (var i = 0; i < checkStatus.length; i++) {
                            ids += checkStatus[i].planingId + ",";
                        }
                        $.ajax({
                            url: '/planningAdministration/delPlanning?ids=' + ids,
                            type: 'post',
                            dataType: 'json',
                            success: function (res) {
                                layer.msg(res.msg);
                                insTb.reload();
                            }
                        });
                        layer.close(index);
                    });
                }
            } else if (event === 'edit') { //编辑
                if (checkStatus.length != 1) {
                    layer.msg("请选择一条");
                }else if(securityInfoDate.auditerStatus!="0"){
                    layer.msg('该数据已提交,不可编辑', {icon: 0, time: 2000});
                    return false;
                }else {
                    layer.open({
                        type: 2,
                        //skin: 'layui-layer-molv', //加上边框
                        area: ['100%', '100%'], //宽高
                        title: '编辑',
                        maxmin: true,
                        btnAlign:'c',
                        btn: ['保存','提交','取消'],
                        content: '/planningAdministration/addPlanningAdministration?urlType=edit&planingId=' + securityInfoDate.planingId+'&projectId=' + projectIdd,
                        success: function () {

                        },
                        yes: function (index, layero) {
                            var childData = $(layero).find("iframe")[0].contentWindow.getData();
                            $.ajax({
                                url: '/planningAdministration/updatePlanning?planingId=' + securityInfoDate.planingId,
                                dataType: 'json',
                                type: 'post',
                                data: childData,
                                success: function (res) {
                                    if (res.code === 0 || res.code === "0") {
                                        //layer.msg("更新成功",{icon:1});
                                        layer.msg(res.msg, {icon: 1});
                                        insTb.reload()
                                        layer.close(index)
                                    } else {
                                        //layer.msg("更新成功",{icon:1});
                                        layer.msg(res.msg, {icon: 0});
                                    }
                                }
                            })
                        }, btn2: function (index, layero) {
                            var childData = $(layero).find("iframe")[0].contentWindow.getData();
                            $.ajax({
                                url: '/planningAdministration/updatePlanning?planingId=' + securityInfoDate.planingId,
                                dataType: 'json',
                                type: 'post',
                                data: childData,
                                success: function (res) {
                                    if (res.code === 0 || res.code === "0") {
                                        layer.close(index)
                                        layer.open({
                                            type: 1,
                                            title: '选择流程',
                                            area: ['70%', '80%'],
                                            btn: ['确定', '取消'],
                                            btnAlign: 'c',
                                            content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                            success: function () {
                                                $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '56'}, function (res) {
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
                                                var checkStatusFlow = table.checkStatus('flowTable');
                                                if (checkStatusFlow.data.length > 0) {
                                                    var flowData = checkStatusFlow.data[0];
                                                    var approvalData = checkStatus[0]
                                                    newWorkFlow(flowData.flowId, function (res) {
                                                        var submitData = {
                                                            planingId:approvalData.planingId,
                                                            runId: res.flowRun.runId,
                                                        }
                                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                        $.ajax({
                                                            url: '/planningAdministration/updatePlanning',
                                                            data: submitData,
                                                            dataType: 'json',
                                                            type: 'post',
                                                            success: function (res) {
                                                                layer.close(loadIndex);
                                                                if (res.code===0||res.code==="0") {
                                                                    layer.close(index);
                                                                    layer.msg('提交成功!', {icon: 1});
                                                                    insTb.config.where._ = new Date().getTime();
                                                                    insTb.reload()
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
                                        //layer.msg("更新成功",{icon:1});
                                        layer.msg(res.msg, {icon: 0});
                                    }
                                }
                            })
                        }
                    });
                }
            }else if (event == 'export') {//导出
                window.location = '/planningAdministration/export'
            }else if (event == 'submit') {//提交审批
                if (checkStatus.length != 1) {
                    layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                    return false;
                }
                if(checkStatus[0].auditerStatus != '0'){
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
                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '56'}, function (res) {
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
                        var checkStatusFlow = table.checkStatus('flowTable');
                        if (checkStatusFlow.data.length > 0) {
                            var flowData = checkStatusFlow.data[0];
                            var approvalData = checkStatus[0]
                            newWorkFlow(flowData.flowId, function (res) {
                                var submitData = {
                                    planingId:approvalData.planingId,
                                    runId: res.flowRun.runId,
                                }
                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                $.ajax({
                                    url: '/planningAdministration/updatePlanning',
                                    data: submitData,
                                    dataType: 'json',
                                    type: 'post',
                                    success: function (res) {
                                        layer.close(loadIndex);
                                        if (res.code===0||res.code==="0") {
                                            layer.close(index);
                                            layer.msg('提交成功!', {icon: 1});
                                            insTb.config.where._ = new Date().getTime();
                                            insTb.reload()
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
            }
        });
        table.on('tool(demoTreeTb)',function(obj){
            var data=obj.data;
            var layEvent=obj.event;
            if(layEvent=="details"){
                layer.open({
                    type: 2,
                    //skin: 'layui-layer-molv', //加上边框
                    area: ['100%', '100%'], //宽高
                    title: '查看详情',
                    maxmin: true,
                    btnAlign:'c',
                    btn: ['确定'],
                    content: '/planningAdministration/addPlanningAdministration?urlType=details&planingId=' + data.planingId+'&projectId=' + projectIdd,
                    yes: function (index, layero) {
                        layer.close(index);
                    }
                });
            }
        })

    })

    function getDate1(){
        var checkStatus = layui.table.checkStatus("demoTreeTb").data;
        if(checkStatus.length!=1||paninnId==undefined){
            layui.layer.msg("请至少选择一条")
        }else{
            var obj = {};
            obj.planingId  = checkStatus[0].planingId;
            obj.planingName = checkStatus[0].planingName;
        }
        return obj;
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

    function getDatta(){
        var datas = layui.table.checkStatus('reportTable').data;
        if(datas&&datas.length>0){
            return datas[0];
        }else{
            layui.layer.msg("请选择一条技术方案")
        }
        // var checkStatus=[];
        // $('#objectives .layui-table-body .laytable-cell-radio').each(function(indexNum,item){
        // 	if($(item).find('.layui-form-radioed').length>0){
        // 		checkStatus.push(tableData[indexNum]);
        // 	}
        // })
        return null;
    }
    function openRold(){ //流程转交下一步后会调用此方法
        //刷新表格
        insTb.reload();
    }
</script>
</body>
</html>

