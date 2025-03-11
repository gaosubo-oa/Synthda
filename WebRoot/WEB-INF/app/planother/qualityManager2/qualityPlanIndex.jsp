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
    <title>质量检查计划</title>
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
            overflow: hidden;
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
        .layui-col-xs3{
            width: 25%;
        }
        .layui-anim{
            width: 100%;
        }
    </style>

</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">质量检查计划</h2>
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
                            <div class="layui-col-xs3" style="width: 37%" >
                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">
                                    <label class="layui-form-label" style="width: 25%;">项目名称</label>
                                    <div class="layui-input-inline" style="width: 55%;">
                                        <select id="aqProjName" name="aqProjName"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-xs3" style="margin-left: 5px" >
                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">
                                    <label class="layui-form-label" style="width: 25%;">检查类型</label>
                                    <div class="layui-input-inline" style="width: 55%;">
                                        <select id="aqTestType" lay-verify="required" name="aqTestType"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-xs3"  style="margin-left: 22px">
                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">
                                    <label class="layui-form-label" style="width: 25%;">被检查单位</label>
                                    <div class="layui-input-inline" style="width: 55%;">
                                        <input type="text" id="testDept" lay-verify="required" name="testDept" placeholder="请选择" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 0px;position: absolute;">
                                    </div>
                                </div>
                            </div>
                            <%--                            <div class="layui-col-xs3" style="width: 42%;">--%>
                            <%--                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">--%>
                            <%--                                    <label class="layui-form-label" style="width: 25%;">检查组长</label>--%>
                            <%--                                    <div class="layui-input-inline" style="width: 55%;">--%>
                            <%--                                        <input type="text" id="testLeader" name="testLeader" placeholder="请选择" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 0px;position: absolute;">--%>
                            <%--                                    </div>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>
                            <div class="layui-col-xs2" style="width: 10%;">
                                <div class="layui-form-item" style="margin: 14px 14px;">
                                    <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                                        <a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;margin-top: -4px;">搜索</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div style="position: relative">
                <div class="table_box"  >
                    <table id="demoTreeTb" lay-filter="demoTreeTb" class="layui-hide"></table>
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

        <button class="layui-btn layui-btn-sm add" lay-event="add" style="margin-left:10px;">新增</button>

        <button class="layui-btn layui-btn-sm edit" lay-event="edit" style="margin-left:10px;">编辑</button>

        <button class="layui-btn layui-btn-sm layui-btn-danger del" lay-event="del" style="margin-left:10px;">删除</button>

        <%--        <div style="position:absolute;top: 10px;right: 12%;">--%>
        <%--            <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>--%>
        <%--            <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入</button>--%>
        <%--            <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出</button>--%>
        <%--            &lt;%&ndash;        <i class="layui-icon layui-icon-upload-circle iconImg" lay-event="import"  style="margin-left: 10px;font-size: 20px" title="导入"></i>--%>
        <%--                    <i class="layui-icon layui-icon-export iconImg" lay-event="export" style="margin-left: 10px;font-size: 20px" title="导出"></i>&ndash;%&gt;--%>
        <%--        </div>--%>
    </div>
</script>
<script type="text/html" id="deToolbar">
    <button type="button" class="layui-btn layui-btn-sm add" lay-event="initialization" style="margin-left:10px;">初始化</button>
    <button type="button" class="layui-btn layui-btn-sm add" lay-event="add" style="margin-left:10px;">新增</button>
    <button type="button" class="layui-btn layui-btn-sm edit" lay-event="edit" style="margin-left:10px;">编辑</button>
    <button type="button" class="layui-btn layui-btn-sm layui-btn-danger del" lay-event="del" style="margin-left:10px;">删除</button>
</script>
<script>
    var securityInfoDate;
    var projectIdd;
    var  projectNamee;
    var insTb
    var colorChange_up='';
    var colorChange_down='';
    $('.con_left ul').height($(window).height()-180)
    // $('.con_right').height($(window).height()-180)

    var embodimentUrlType = getUrlParam("embodimentUrlType");
    var paninnId = getUrlParam("planingId");
    // var toolbar;
    // var colsType;
    // if(embodimentUrlType=='addImplement'){
    //     toolbar = ''
    //     colsType = 'radio'
    // }else {
    //     toolbar = '#toolbarDemo'
    //     colsType = 'checkbox'
    // }

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

        //渲染检查类型
        var $select1 = $("#aqTestType");
        var optionStr = '<option value="">请选择</option>';
        $.ajax({ //查询文档等级
            url: '/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
            type: 'get',
            dataType: 'json',
            async:false,
            success: function (res) {
                var data1=res.data
                if(data1!=undefined&&data1.length>0){
                    for(var i=0;i<data1.length;i++){
                        optionStr += '<option value="' + data1[i].dictNo + '">' + data1[i].dictName + '</option>'
                    }
                }
            }
        })
        $select1.html(optionStr);
        //渲染项目名称
        var $select2 = $("#aqProjName");
        var optionStr2 = '<option value="">请选择</option>';
        $.ajax({ //查询文档等级
            url: '/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
            type: 'get',
            dataType: 'json',
            async:false,
            success: function (res) {
                var data2=res.data
                if(data2!=undefined&&data2.length>0){
                    for(var i=0;i<data2.length;i++){
                        optionStr2 += '<option value="' + data2[i].projectId + '">' + data2[i].projectName + '</option>'
                    }
                }
            }
        })
        $select2.html(optionStr2);
        //选部门控件添加
        $(document).on('click', '#testDept', function () {
            dept_id = "testDept";
            $.popWindow("/common/selectDept?0");
        });
        $(document).on('click', '#testLeader', function () {
            user_id = "testLeader";
            $.popWindow("/projectTarget/selectOwnDeptUser?0");
        })
        form.render();

        //头工具栏事件

        $('#searchCust').click(function () {
            var serchObjUrl = "/planningManage/selectPlanning?";
            //var searchtext = $("#securityRegionName").attr("pid3");
            var searchtext1 = $("#planingNo").val();
            var searchtext2 = $('#planingType').next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
            var searchtext3 = $("#planingName").val();
            if(searchtext1!=""&&searchtext1!=undefined){
                serchObjUrl+="&planingNo="+searchtext1;
            }
            if(searchtext2!=""&&searchtext2!=undefined){
                serchObjUrl+="&planingType="+searchtext2;
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
            colorChange_up=false
            colorChange_down=false
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

            insTb = table.render({
                elem: '#demoTreeTb',
                url: '/plcProjectItem/itemByDeptId?projOrgId=' + projectId+'&_='+new Date().getTime(),
                toolbar: '#toolbarDemo',
                // tree: {
                //     iconIndex: 1,           // 折叠图标显示在第几列
                //     idName: 'planItemId',
                //     childName: "items"
                // },
                cols: [[
                    {type: 'checkbox'},
                    {
                        field: 'taskNo', title: '子任务编号',width:150
                    },
                    {field: 'examineStatus', title: '状态', width: 80,templet: function (d) {
                            if(d.examineStatus==1){
                                return  '<span class="examineStatus" examineStatus="'+d.examineStatus+'">正在审批中</span>'
                            }else if(d.examineStatus==2){
                                return   '<span class="examineStatus" examineStatus="'+d.examineStatus+'">同意</span>'
                            }else if(d.examineStatus==3){
                                return   '<span class="examineStatus" examineStatus="'+d.examineStatus+'">退回</span>'
                            }else if(d.examineStatus==4){
                                return   '<span class="examineStatus" examineStatus="'+d.examineStatus+'">已上报</span>'
                            }else{
                                return  '<span class="examineStatus">未提交</span>'
                            }
                        }},
                    {
                        field: 'taskName', title: '子任务名称', width: 200,style:"color:blue;cursor: pointer",templet: function (d) {
                            return  '<span class="taskDetail" planItemId="'+d.planItemId+'" parentPlanItemId="'+d.parentPlanItemId+'">'+d.taskName+'</span>'
                        }
                    },
                    {field: 'tgId', title: '关联关键任务', width: 150,templet: function (d) {
                            var tgIds=''
                            if(d.tgIds){
                                d.tgIds.forEach(function (item) {
                                    tgIds+=item.tgName+','
                                })
                                return tgIds.replace(/,$/, '')
                            }else{
                                return  ''
                            }
                        }},
                    {
                        field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
                            return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                        }
                    },
                    {
                        field: 'taskType', title: '任务来源', width: 100, templet: function (d) {
                            return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
                        }
                    },
                    /* {field: 'planStage', title: '计划阶段',templet: function(d){
                             return  dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                         }},
                   {field: 'designQuantity', title: '设计量'},
                   {field: 'itemQuantity', title: '工程量'},
                   {field: 'itemQuantityNuit', title: '单位',templet: function (d) {
                           return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || ''
                       }},*/
                    {field: 'dutyUserName', title: '负责人'},
                    {field: 'mainCenterDeptName', title: '责任部门',width: 120},
                    {field: 'assistCompanyDeptsName', title: '协助部门',width: 120},
                    {field: 'planContinuedDate', title: '计划工期',width: 80},
                    {
                        field: 'planStartDate', title: '计划开始时间', width: 120, templet: function (d) {
                            return format(d.planStartDate)
                        }
                    },
                    {
                        field: 'planEndDate', title: '计划结束时间', width: 120, templet: function (d) {
                            return format(d.planEndDate)
                        }
                    },
                    {
                        field: 'resultStandard', title: '完成标准', width: 130,
                    },
                    {field: 'preTask', title: '前置子任务', width: 150,templet: function (d) {
                            var preTasks=''
                            if(d.preTasks){
                                d.preTasks.forEach(function (item) {
                                    preTasks+=item.workItemName+','
                                })
                                return preTasks.replace(/,$/, '').split(',')
                            }else{
                                return  ''
                            }
                        }},
                    {field: 'riskPoint', title: '风险点', width: 120},
                    {field: 'difficultPoint', title: '难度点', width: 120},
                    {field: 'hardDegree', title: '难度系数', width: 120},
                    {
                        field: 'planType', title: '任务类型', width: 100, templet: function (d) {
                            return dictionaryObj['TG_TYPE']['object'][d.planType] || ''
                        }
                    },
                    {
                        field: 'taskDesc', title: '子任务描述', width: 120,
                    }
                ]],
                // height: 'full-150',
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj //解析数据列表
                    };
                },
                done: function (res) {
                    // console.log(res)
                    // $('th[data-type="checkbox"] .ew-tree-table-cell').remove()
                    $('.ew-tree-table-tool-item').eq(1).hide()
                    $('.ew-tree-table-tool-item').eq(2).hide()
                    // $('.ew-tree-table-box').height($(window).height()-200)

                    //增加负责人的排序
                    $('thead th').eq(7).find('.ew-tree-table-cell-content').html('<span style="cursor: move;">负责人</span><span class="layui-table-sort layui-inline"><i class="layui-edge layui-table-sort-asc sort" title="升序"></i><i class="layui-edge layui-table-sort-desc sort" title="降序"></i></span>')
                   // 给选中高亮
                    if(colorChange_up){
                        $('.layui-table-sort-asc').css('border-bottom-color','#666')
                    }else if(colorChange_down){
                        $('.layui-table-sort-desc').css('border-top-color','#666')
                    }
                }
            });

        }

        table.on('toolbar(demoTreeTb)', function (obj) {
            var checkStatus = table.checkStatus("demoTreeTb").data;
            securityInfoDate = checkStatus[0];
            var event = obj.event;
            if (event === 'add') { //新增
                layer.open({
                    type:1,
                    title:'新增',
                    area:['80%','80%'],
                    btn:['确定','取消'],
                    btnALign:'c',
                    content:'<form class="layui-form">' +
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs3" style="width: 42%">' +
                        '<div class="layui-form-item" style="margin: 10px -30px 10px;">'+
                        ' <label class="layui-form-label" style="width: 25%;">项目名称</label>'+
                        '<div class="layui-input-inline" style="width: 55%;">'+
                        '<select id="aqProjName1" name="aqProjName1"></select>'+
                        '</div>'+
                        '</div>'+
                        '</div>'+
                        '                            <div class="layui-col-xs3" style="width: 42%">\n' +
                        '                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">\n' +
                        '                                    <label class="layui-form-label" style="width: 25%;">检查类型</label>\n' +
                        '                                    <div class="layui-input-inline" style="width: 55%;">\n' +
                        '                                        <select id="aqTestType1" lay-verify="required" name="aqTestType1"></select>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                            </div>\n' +
                        '                            <div class="layui-col-xs3" style="width: 42%;">\n' +
                        '                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">\n' +
                        '                                    <label class="layui-form-label" style="width: 25%;">被检查单位</label>\n' +
                        '                                    <div class="layui-input-inline" style="width: 55%;">\n' +
                        '                                        <input type="text" id="testDept" lay-verify="required" name="testDept" placeholder="请选择" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 0px;position: absolute;">\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                            </div>\n' +
                        '                            <div class="layui-col-xs3" style="width: 42%;">\n' +
                        '                                <div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">\n' +
                        '                                    <label class="layui-form-label" style="width: 25%;">检查组长</label>\n' +
                        '                                    <div class="layui-input-inline" style="width: 55%;">\n' +
                        '                                        <input type="text" id="testLeader" name="testLeader" placeholder="请选择" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 0px;position: absolute;">\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                            </div>\n' +
                        '<div class="layui-col-xs3" style="width: 100%">' +
                        '<table id="deTable" lay-filter="deTable" class="layui-table"></table>'+
                        '</div>'+
                        '</div>'+
                        '</form>'
                    ,success:function(){
                        //渲染检查类型
                        var $select1 = $("#aqTestType1");
                        var optionStr = '<option value="">请选择</option>';
                        $.ajax({ //查询文档等级
                            url: '/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
                            type: 'get',
                            dataType: 'json',
                            async:false,
                            success: function (res) {
                                var data1=res.data
                                if(data1!=undefined&&data1.length>0){
                                    for(var i=0;i<data1.length;i++){
                                        optionStr += '<option value="' + data1[i].dictNo + '">' + data1[i].dictName + '</option>'
                                    }
                                }
                            }
                        })
                        $select1.html(optionStr);
                        //渲染项目名称
                        var $select2 = $("#aqProjName1");
                        var optionStr2 = '<option value="">请选择</option>';
                        $.ajax({ //查询文档等级
                            url: '/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
                            type: 'get',
                            dataType: 'json',
                            async:false,
                            success: function (res) {
                                var data=res.data
                                if(data!=undefined&&data.length>0){
                                    for(var i=0;i<data.length;i++){
                                        optionStr2 += '<option value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
                                    }
                                }
                            }
                        })
                        $select2.html(optionStr2);
                        form.render()
                        table.render({
                            elem:'#deTable',
                            url:'',
                            data:[],
                            toolbar:'#deToolbar',
                            cols: [[
                                {type: 'checkbox'}
                                ,{field:'detailsName',title:'名称'}
                                ,{field: 'securityDangerName', title: '检查内容'}
                                ,{field: 'securityRegionName', title: '检查区域',templet:function(d){
                                        var htm =
                                            '<input type="text" placeholder="请选择" dataIdd="'+d.templteDetailsId+'" index="'+(d.LAY_INDEX-1)+'"  id="region'+d.LAY_INDEX+'" idname="region'+d.LAY_INDEX+'" pid name="tTtitle3" style="cursor: pointer;height: 38px !important;" autocomplete="off" class="layui-input" value='+isShowNull2(d.securityRegionName)+'>' +
                                            '<div class="eleTree eleb3 region'+d.LAY_INDEX+'" lay-filter="dataN" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>';
                                        return htm;
                                    }}
                                ,{title: '操作', align: 'center', width:80}
                            ]]
                        })
                        table.on('toolbar(deTable)',function(obj){
                            var layEvent=obj.event;
                            switch (layEvent) {
                                case 'initialization':
                                    break;
                                case 'add':
                                    layer.open({
                                        type: 1,
                                        skin: 'layui-layer-molv', //加上边框
                                        area: ['80%', '80%'], //宽高
                                        title: '新增',
                                        maxmin: true,
                                        btn: ['提交', '取消'],
                                        content: '<div class="layui-form">' +
                                            // '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                                            // '<label class="layui-form-label">检查人</label>' +
                                            // '<div class="layui-input-block">' +
                                            // '<input class="layui-input"  lay-verify="required" name="testUser" id="testUser">' +
                                            // '</div>' +
                                            // '</div>' +
                                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                                            '<label class="layui-form-label">名称</label>' +
                                            '<div class="layui-input-block">' +
                                            '<input class="layui-input"  lay-verify="required" name="testName" id="testName">' +
                                            '</div>' +
                                            '</div>' +
                                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                                            '<label class="layui-form-label"><span style="color: red">*</span>检查项</label>' +
                                            '<div class="layui-input-block">' +
                                            '<textarea type="text" id="pele" pid name="ttitle1" required="" style="cursor: pointer;min-height: 96px;" placeholder="请选择检查项" readonly="" autocomplete="off" class="layui-input"></textarea>' +
                                            '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
                                            '</div>' +
                                            '</div>' +
                                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                                            '<label class="layui-form-label"><span style="color: red">*</span>检查内容</label>' +
                                            '<div class="layui-input-block">' +
                                            '<textarea type="text" id="pele3" pid name="ttitle3" required="" style="cursor: pointer;min-height: 96px;" placeholder="请选择检查内容" readonly="" autocomplete="off" class="layui-input"></textarea>' +
                                            '</div>' +
                                            '</div>' +
                                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                                            '<label class="layui-form-label"><span style="color: red">*</span>检查区域</label>' +
                                            '<div class="layui-input-block">' +
                                            '<input type="text" placeholder="请选择"  id="regionX" pid name="tTtitle4" style="cursor: pointer;height: 38px !important;" autocomplete="off" class="layui-input">' +
                                            '<div class="eleTree eleb4 region" lay-filter="dataX" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>'+
                                            '</div>' +
                                            '</div>' +
                                            '</div>',
                                        success: function () {

                                            Array.prototype.remove = function(val) {
                                                var index = this.indexOf(val);
                                                if (index > -1) {
                                                    this.splice(index, 1);
                                                }
                                            };
                                            var el;
                                            $("[name='ttitle1']").on("click",function (e) {
                                                e.stopPropagation();
                                                if(!el){
                                                    el=eleTree.render({
                                                        elem: '.ele2',
                                                        url:'/workflow/secirityManager/getSecurityByType?parent=0',
                                                        expandOnClickNode: false,
                                                        highlightCurrent: true,
                                                        showLine:true,
                                                        showCheckbox: false,
                                                        checked: false,
                                                        lazy: true,
                                                        load: function(data,callback) {
                                                            $.post('/workflow/secirityManager/getSecurityByType?parent='+data.id,function (res) {
                                                                callback(res.data);//点击节点回调
                                                            })
                                                        },
                                                        done: function(res){
                                                            if(res.data.length == 0){
                                                                $(".ele2").html('<div style="text-align: center">暂无数据</div>');
                                                            }
                                                        }
                                                    });
                                                }
                                                $(".ele2").slideDown();
                                            })
                                            $(document).on("click",function() {
                                                $(".ele2").slideUp();
                                            })
                                            //节点点击事件
                                            eleTree.on("nodeClick(data2)",function(d) {
                                                var parData1 = d.data.currentData;
                                                var str111="";
                                                console.log(parData1)
                                                $.ajax({
                                                    url:'/workflow/secirityManager/getKnowledgeById?knowleId='+parData1.securityKnowledgeId,
                                                    dataType:'json',
                                                    type:'post',
                                                    async: false,
                                                    success:function(res){
                                                        if(res.code===0||res.code==="0"){
                                                            var securityKnowledgeName = res.obj;
                                                            str111+=securityKnowledgeName+"，"
                                                        }
                                                    }
                                                })

                                                $("[name='ttitle1']").val(str111);
                                                $("#pele").attr("pid",parData1.id);
                                            })

                                            var ell;
                                            $("[name='ttitle3']").on("click",function (e) {
                                                var standTypeId =  $("#pele").attr("pid");
                                                if(standTypeId==undefined||standTypeId==""){
                                                    layer.msg("请先选择检查项")
                                                    return false;
                                                }else{
                                                    layer.open({
                                                        type: 2,
                                                        skin: 'layui-layer-molv', //加上边框
                                                        area: ['90%', '90%'], //宽高
                                                        title: '隐患项',
                                                        maxmin: true,
                                                        btn: ['提交', '取消'],
                                                        content: '/workflow/secirityManager/toSecirityStandard?type=checkTemplte&knowTypeIds='+standTypeId,
                                                        success: function () {

                                                        },
                                                        yes: function (index, layero){
                                                            var experience = window["layui-layer-iframe" + index].getRepairDate();
                                                            //debugger
                                                            if(experience!=undefined&&experience!=null){
                                                                var securityDangers ="";
                                                                var securityDangerIds ="";
                                                                for(var i = 0; i < experience.length; i++){
                                                                    securityDangers+=experience[i].securityDanger+"，";
                                                                    securityDangerIds+=experience[i].securityDangerId+",";
                                                                }
                                                                $("#pele3").text(securityDangers);
                                                                $("#pele3").attr("securityDangerId",securityDangerIds);
                                                                /*if(experience.securityDangerGrade!=undefined){
                                                                    $("#pele3").attr("dangerGrade",experience.securityDangerGrade);
                                                                    if(experience.securityDangerGrade===0||experience.securityDangerGrade==="0"){
                                                                        $("#dangerGrade").val("重大隐患");
                                                                    }else{
                                                                        $("#dangerGrade").val("一般隐患");
                                                                    }
                                                                }*/
                                                                //$("#securityDanger").val(experience.securityDanger);
                                                                //$("#securityDangerMeasures").val(experience.securityDangerMeasures);
                                                                layer.close(index)
                                                            }
                                                        }
                                                    })
                                                }
                                            })

                                            $(document).on("click","[name='tTtitle4']",function (e) {
                                                e.stopPropagation();
                                                var projectId = $("#aqProjName").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value")
                                                if(projectId == null|| projectId == undefined){
                                                    layer.msg('请先选择项目名称')
                                                }else{
                                                    eleTree.render({
                                                        elem: '.eleb4',
                                                        url:'/workflow/secirityManager/getRegionByProject?projectId='+projectId,
                                                        expandOnClickNode: false,
                                                        highlightCurrent: true,
                                                        showLine:true,
                                                        showCheckbox: false,
                                                        checked: false,
                                                        lazy: false,
                                                        done: function(res){
                                                            if(res.data.length == 0){
                                                                $(".eleb4").html('<div style="text-align: center">暂无数据</div>');
                                                            }
                                                        }
                                                    });
                                                }

                                                $(".eleb4").slideDown();
                                            })
                                            $(document).on("click",function() {
                                                $(".eleb4").slideUp();
                                            })

                                            // 节点点击事件
                                            eleTree.on("nodeClick(dataX)",function(d) {
                                                var parData = d.data.currentData;
                                                var str111="";
                                                $.ajax({
                                                    url:'/workflow/secirityManager/getRegionById?regionId='+parData.regionId,
                                                    dataType:'json',
                                                    type:'post',
                                                    async: false,
                                                    success:function(res){
                                                        if(res.code===0||res.code==="0"){
                                                            var regionName = res.obj;
                                                            str111+=regionName+"，" //name
                                                        }
                                                    }
                                                })
                                                $("#regionX").val(str111)
                                                $("#regionX").attr("pid",parData.id)
                                            });

                                            form.render();//初始化表单
                                        },
                                        yes: function (index, layero) {
                                            //var idName = $(this).attr("idname")

                                            var detailsName = $("#testName").val()//名称

                                            var securityKnowledgeIds = $("#pele").attr("pid"); //检查项
                                            var securityKnowledgeName = $("#pele").val();
                                            var securityDangerIds = $("#pele3").attr("securityDangerId"); //检查内容Id
                                            var securityDangerName = $("#pele3").val();
                                            var securityRegionName =$('#regionX').val();//检查区域
                                            var securityRegionIds =$('#regionX').attr("pid");
                                            if(securityDangerIds==undefined||securityDangerIds==""){
                                                layer.msg("请选择检查内容");
                                                return false;
                                            }else if(securityKnowledgeIds==undefined||securityKnowledgeIds==""){
                                                layer.msg("请选择检查项");
                                                return false;
                                            }else {
                                                if(securityDangerIds.substring(securityDangerIds.length-1,securityDangerIds.length)==","){
                                                    securityDangerIds = securityDangerIds.substring(0,securityDangerIds.length-1);
                                                }
                                                if(securityDangerName.substring(securityDangerName.length-1,securityDangerName.length)==","){
                                                    securityDangerName = securityDangerName.substring(0,securityDangerName.length-1);
                                                }
                                                if(securityKnowledgeIds.substring(securityKnowledgeIds.length-1,securityKnowledgeIds.length)==","){
                                                    securityKnowledgeIds = securityKnowledgeIds.substring(0,securityKnowledgeIds.length-1);
                                                }
                                                if(securityKnowledgeName.substring(securityKnowledgeName.length-1,securityKnowledgeName.length)==","){
                                                    securityKnowledgeName = securityKnowledgeName.substring(0,securityKnowledgeName.length-1);
                                                }
                                                var details = {
                                                    detailsName:detailsName,
                                                    securityKnowledgeIds:securityKnowledgeIds,
                                                    securityKnowledgeName:securityKnowledgeName,
                                                    securityDangerIds:securityDangerIds,
                                                    securityDangerName:securityDangerName,
                                                    securityRegionIds:securityRegionIds,
                                                    securityRegionName:securityRegionName
                                                }



                                                detailsInitData.push(details);
                                                detailsInit.reload({
                                                    url:'',data:detailsInitData
                                                    ,done:function(d){
                                                        layer.close(index)
                                                    }
                                                });
                                                // $.ajax({
                                                //     url:'/secirityManager/insertchecklistDetails',
                                                //     dataType:'json',
                                                //     type:'post',
                                                //     data:details,
                                                //     success:function(res){
                                                //         if(res.code===0||res.code==="0"){
                                                //             layer.msg(res.msg,{icon:1});
                                                //             detailsInit.reload()
                                                //             layer.close(index)
                                                //         }else{
                                                //             layer.msg(res.msg,{icon:0});
                                                //         }
                                                //     }
                                                // })
                                            }
                                        }
                                    });
                                    break;
                                case 'updit':
                                    break;
                                case 'del':
                                    break;
                            }
                        })
                    }
                })
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
                            url: '/planningManage/delPlanning?ids=' + ids,
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
                } else {
                    layer.open({
                        type: 2,
                        //skin: 'layui-layer-molv', //加上边框
                        area: ['100%', '100%'], //宽高
                        title: '编辑',
                        maxmin: true,
                        btn: ['保存', '取消'],
                        content: '/planningManage/addImplementationPlanning?urlType=edit&projectId=' + projectIdd,
                        success: function () {

                        },
                        yes: function (index, layero) {
                            var childData = $(layero).find("iframe")[0].contentWindow.getDate();
                            $.ajax({
                                url: '/planningManage/updatePlanning?planingId=' + securityInfoDate.planingId,
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
                            layer.close(index);
                        }
                    });
                }
            }else if (event == 'export') {//导出
                window.location = '/planningManage/export'
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
                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '39'}, function (res) {
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
                                    auditerStatus:1
                                }
                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                $.ajax({
                                    url: '/planningManage/updatePlanning',
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
</script>
</body>
</html>

