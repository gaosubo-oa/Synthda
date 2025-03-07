<%--
  Created by IntelliJ IDEA.
  User: 吴祖明
  Date: 2021/4/2
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
        <title>经营变更</title>

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
        <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>

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
                    <h2 style="text-align: center;line-height: 35px;">经营变更</h2>
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
                            <input type="text" name="itemNo" placeholder="项目名称" autocomplete="off" class="layui-input">
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

        <script>
            var user_id = '';

            var tipIndex = null;
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text')
                tipIndex = layer.tips(tip, this)
            }, function () {
                layer.close(tipIndex)
            });

            //表格显示顺序
            var colShowObj = {
                registerNo:{field:'registerNo',title:'单据号',minWidth:100},
                projectName: {field: 'projectName', title: '项目名称', sort: false, hide: false},
                registerName:{field:'registerName',title:'变更单名称'},
                registerCategory: {
                    field: 'registerCategoryName', title: '变更类别', sort: false, hide: false
                },
                registerType: {
                    field: 'registerTypeName', title: '变更类型', sort: false, hide: false
                },
                createUserName: {
                    field: 'createUserName', title: '创建人', sort: false, hide: false
                },
                createTime: {
                    field: 'createTime', title: '创建时间', sort: true, hide: false
                },
                currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
                auditerStatus: {
                    field: 'auditerStatus', title: '审批状态', sort: false, hide: false, templet: function (d) {
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

            var TableUIObj = new TableUI('plb_manage_item');

            var dictionaryObj = {
                MANAGE_ITEM_TYPE: {},
                OPERATE_REGISTER_CATEGORY:{},
                OPERATE_REGISTER_TYPE:{}
            }
            var dictionaryStr = 'MANAGE_ITEM_TYPE,OPERATE_REGISTER_CATEGORY,OPERATE_REGISTER_TYPE';
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
                layui.use(['form', 'table', 'element', 'soulTable', 'eleTree','laydate'], function () {
                    var form = layui.form,
                        table = layui.table,
                        element = layui.element,
                        soulTable = layui.soulTable,
                        eleTree = layui.eleTree,
                        laydate=layui.laydate;


                    TableUIObj.init(colShowObj, function(){
                        $('.no_data').show();
                        $('.table_box').show();
                        //tableShow();
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
                        var searchObj = getSearchObj();
                        searchObj.projId = projId || '';
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
                            url: '/plbOperateManage/selectRegister?projectId='+projId+'',
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

                    // 上方按钮显示
                    table.on('toolbar(mtlPlanTable)', function (obj) {
                        var checkStatus = table.checkStatus(obj.config.id);
                        var projectId=$("#leftId").attr('projId');
                        switch (obj.event) {
                            case 'add':
                                if (!projectId) {
                                    layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
                                    return false;
                                }
                                layer.open({
                                    type:2,
                                    title:'新增变更登记',
                                    area:['100%','100%'],
                                    btn:['保存','提交','取消'],
                                    btnAlign:'c',
                                    content:'/plbOperateManage/addOperateRegister?tableBtn=add&projectId='+projectId+'',
                                    yes:function(index,layero){
                                        var dataobj = $(layero).find("iframe")[0].contentWindow.getData();
                                        $.ajax({
                                            url:'/plbOperateManage/insertRegister',
                                            data:dataobj,
                                            type:'post',
                                            success:function(res){
                                                layer.msg(res.msg);
                                                layer.close(index);
                                                tableIns.reload();
                                            }
                                        })
                                    },
                                    btn2: function (index,layero) {
                                        var dataobj = $(layero).find("iframe")[0].contentWindow.getData();
                                        $.ajax({
                                            url:'/plbOperateManage/insertRegister',
                                            data:dataobj,
                                            type:'post',
                                            success:function(res){
                                                if(res.code=='0'){
                                                    layer.open({
                                                        type: 1,
                                                        title: '选择流程',
                                                        area: ['70%', '80%'],
                                                        btn: ['确定', '取消'],
                                                        btnAlign: 'c',
                                                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                                        success: function () {
                                                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '43'}, function (res) {
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
                                                                newWorkFlow(flowData.flowId, function (res) {
                                                                    var submitData = {
                                                                        registerId:approvalData.registerId,
                                                                        runId: res.flowRun.runId,
                                                                        //auditerStatus:1
                                                                    }
                                                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                                    $.ajax({
                                                                        url: '/plbOperateManage/insertRegister',
                                                                        //data: JSON.stringify(submitData),
                                                                        data:submitData,
                                                                        dataType: 'json',
                                                                        //contentType: "application/json;charset=UTF-8",
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
                                                }
                                            }
                                        })
                                    },
                                    btn3: function (index) {
                                        layer.close(index);
                                    }
                                })
                                break;
                            case 'edit':
                                if (checkStatus.data.length != 1) {
                                    layer.msg('请选择一项！', {icon: 0});
                                    return false
                                }
                                if(checkStatus.data[0].auditerStatus&&checkStatus.data[0].auditerStatus != '0'){
                                    layer.msg('该数据已提交！', {icon: 0, time: 2000});
                                    return false;
                                }
                                var registerId=checkStatus.data[0].registerId;
                                layer.open({
                                    type:2,
                                    title:'编辑变更登记',
                                    area:['100%','100%'],
                                    btn:['保存','提交','取消'],
                                    btnAlign:'c',
                                    content:'/plbOperateManage/addOperateRegister?tableBtn=edit&projectId='+projectId+'&registerId='+registerId+'',
                                    yes:function(index,layero){
                                        var dataobj = $(layero).find("iframe")[0].contentWindow.getData();
                                        $.ajax({
                                            url:'/plbOperateManage/updateRegister?registerId='+registerId+'',
                                            data:dataobj,
                                            type:'post',
                                            success:function(res){
                                                if(res.code=="0"||res.code==0){
                                                    layer.msg(res.msg);
                                                    layer.close(index);
                                                    tableIns.reload();
                                                }
                                            }
                                        })
                                    }
                                    ,btn2:function(index,layero){
                                        var dataobj = $(layero).find("iframe")[0].contentWindow.getData();
                                        $.ajax({
                                            url:'/plbOperateManage/updateRegister?registerId='+registerId+'',
                                            data:dataobj,
                                            type:'post',
                                            success:function(res){
                                                layer.open({
                                                    type: 1,
                                                    title: '选择流程',
                                                    area: ['70%', '80%'],
                                                    btn: ['确定', '取消'],
                                                    btnAlign: 'c',
                                                    content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                                    success: function () {
                                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '43'}, function (res) {
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
                                                            var approvalData = res.obj;
                                                            newWorkFlow(flowData.flowId, function (res) {
                                                                var submitData = {
                                                                    registerId:approvalData.registerId,
                                                                    runId: res.flowRun.runId,
                                                                    //auditerStatus:1
                                                                }
                                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                                $.ajax({
                                                                    url: '/plbOperateManage/updateRegister',
                                                                    //data: JSON.stringify(submitData),
                                                                    data:submitData,
                                                                    dataType: 'json',
                                                                    //contentType: "application/json;charset=UTF-8",
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
                                            }
                                        })
                                    }
                                })
                                break;
                            case 'del':
                                if (!checkStatus.data.length) {
                                    layer.msg('请至少选择一项！', {icon: 0});
                                    return false
                                }
                                var registerId = ''
                                var isFlay = false;
                                checkStatus.data.forEach(function (v, i) {
                                    registerId += v.registerId + ','
                                    if(v.auditerStatus&&v.auditerStatus!='0'){
                                        isFlay = true
                                    }
                                })
                                if(isFlay){
                                    layer.msg('已提交不可删除！', {icon: 0});
                                    return false
                                }

                                layer.confirm('确定删除该条数据吗？', function (index) {
                                    $.post('/plbOperateManage/delRegister', {ids: registerId}, function (res) {
                                        layer.msg(res.msg);
                                        layer.close(index);
                                        tableIns.config.where._ = new Date().getTime();
                                        tableIns.reload();
                                    })
                                });
                                break;
                            case 'export':
                                layer.msg('导出');
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
                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '43'}, function (res) {
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
                                            /*delete approvalData.detailList
                                            delete approvalData.manageInfoList*/
                                            newWorkFlow(flowData.flowId, function (res) {
                                                var submitData = {
                                                    registerId:approvalData.registerId,
                                                    runId: res.flowRun.runId,
                                                    //auditerStatus:1
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.ajax({
                                                    url: '/plbOperateManage/updateRegister',
                                                    //data: JSON.stringify(submitData),
                                                    data:submitData,
                                                    dataType: 'json',
                                                    //contentType: "application/json;charset=UTF-8",
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
                    //表格行点击事件
                    table.on('tool(mtlPlanTable)',function(obj){
                        var layEvent=obj.event;
                        var data=obj.data;
                        var projectId=data.projectId;
                        var registerId=data.registerId;
                        switch (layEvent) {
                              case 'detail':
                                  layer.open({
                                      type:2,
                                      title:'查看变更登记',
                                      area:['100%','100%'],
                                      btn:['确定'],
                                      btnAlign:'c',
                                      content:'/plbOperateManage/addOperateRegister?tableBtn=details&projectId='+projectId+'&registerId='+registerId+'',
                                      yes:function(index,layero){
                                          layer.close(index);
                                      }
                                  })
                                  break;
                        }
                    })
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
                            itemNo: $('input[name="itemNo"]', $('.query_module')).val(),
                            itemType:$('input[name="itemType"]',$('.query_module')).val(),
                            auditerStatus:$('input[name="auditerStatus"]',$('.query_module')).val()
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

            //数据列表点击审批状态查看流程功能
            $(document).on('click', '.preview_flow', function() {
                var flowId = $(this).attr('flowId'),
                    runId = $(this).attr('runId');
                if (flowId && runId) {
                    $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
                }
            });
            function openRold(){ //流程转交下一步后会调用此方法
                //刷新表格
                tableIns.config.where._ = new Date().getTime();
                tableIns.reload();
            }
        </script>
    </body>
</html>
