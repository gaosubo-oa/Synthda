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
        <title>经营跟踪</title>

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
        <script type="text/javascript" src="/js/planbudget/common.js?20210413.1"></script>
        <script type="text/javascript" src="/js/email/fileupload.js"></script>
        <%--<script src="/js/technical/technical.js?20210723"></script>--%>
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

            .layui-table-view .layui-table td {
                cursor: pointer;
            }


            #scrollModule {
                width: 70%;
                height: 100%;
                margin: 0 auto;
                padding: 10px 0;
                overflow-y: auto;
                overflow-x: hidden;
                box-sizing: border-box;
            }

            .label_item {
                padding: 4px 0;
            }

            .label_ttile {
                display: inline-block;
                width: 100px;
                text-align: left;
            }

            .label_con {
                display: inline-block;
                width: 55%;
                min-width: 300px;
                text-align: left;
            }

            .del_btn {
                float: right;
                margin-right: 50%;
            }

            .mtl_info .layui-table-cell,.mtl_info .layui-table-box,.mtl_info .layui-table-body {
                overflow: visible;
            }
            /* 设置下拉框的高度与表格单元格的高度相同 */
            .mtl_info td .layui-form-select {
                margin-top: -10px;
                margin-left: -15px;
                margin-right: -15px;
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
            .mtl_info td[data-field="attachmentName"] .layui-table-cell{
                height: auto;
                overflow:visible;
                text-overflow:inherit;
                white-space:normal;
                word-break: break-word;
            }

            .layui-col-xs4{
                width: 20%;
            }
            .displayNone{
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <input type="hidden" id="leftId" class="layui-input">
            <div class="wrapper">
                <div class="wrap_left">
                    <h2 style="text-align: center;line-height: 35px;">经营跟踪</h2>
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
                            <select name="manageTrackStatus">
                                <option value="">请选择</option>
                                <option value="0">待审批</option>
                                <option value="1">批准</option>
                                <option value="2">未批准</option>
                            </select>
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

        <script type="text/html" id="detailBarDemo">
            <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
            <a class="layui-btn  layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
        </script>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="height: 30px;">
<%--                <button class="layui-btn layui-btn-sm" lay-event="add">新增</button>--%>
<%--                <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>--%>
                <button class="layui-btn layui-btn-sm" lay-event="update">进展更新</button>
                <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="closePlan">跟踪关闭</button>
            </div>
            <div style="position:absolute;top: 10px;right:60px;">
                <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
            </div>
        </script>
        <script type="text/html" id="delTarckTool">
            <button class="layui-btn layui-btn-xs" lay-event="add">加行</button>
        </script>
        <script type="text/html" id="toolbarDemoIn">
            {{#  if(!d.detailsStatus||d.detailsStatus=="0"){ }}
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
            {{#  } }}

        </script>
        <script type="text/html" id="delTarckTool2">
            <button class="layui-btn layui-btn-xs" lay-event="add2">加行</button>
        </script>
        <script type="text/html" id="toolbarDemoIn2">
            {{#  if(!d.detailsStatus||d.detailsStatus=="0"){ }}
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del2">删行</a>
            {{#  } }}

        </script>
        <script type="text/html" id="internalBar">
            {{#  if(!d.detailsStatus||d.detailsStatus=="0"){ }}
            <a href="javascript:;" class="openFile" style="position:relative;" lay-event="butfile">
                <button type="button"  class="layui-btn layui-btn-xs" style="margin-right:10px;">
                    <i class="layui-icon" >&#xe67c;</i>附件上传
                </button>
                <input type="file" multiple id={{"fileupload"+d.LAY_INDEX}} data-url="/upload?module=operateTarck"  name="file">
            </a>
            {{#  } }}

        </script>

        <script>
            var tipIndex = null;
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text')
                tipIndex = layer.tips(tip, this)
            }, function () {
                layer.close(tipIndex)
            });

            var projectId='';
            var detaListData=[];
            var tracListData=[];
            var idfile, index2;

            var detailsInitData1;

            //表格显示顺序
            var colShowObj = {
                checkbox:{type:'checkbox'},
                documentNum: {
                    field: 'documnetNum', title: '单据号', sort: true, hide: false,
                },
                projectName: {field: 'projectName', title: '项目名称', sort: true, hide: false},
                manageProjName: {
                    field: 'manageProjName', title: '经营立项名称', sort: true, hide: false
                },
                manageProjNum:{field:'manageProjNum',title:'经营立项编号',},
                progressUpdateDate: {
                    field: 'progressUpdateDate', title: '进展更新时间', sort: true, hide: false,
                },
                currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
                itemAmount: {field: 'manageTrackStatus', title: '经营跟踪状态', sort: true, hide: false,templet: function (d) {
                        if (d.manageTrackStatus == '0') {
                            return '<span>进展中</span>'
                        }else if (d.manageTrackStatus == '1') {
                            return '<span>已关闭</span>'
                        }else if (d.manageTrackStatus == '10') {
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            return '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
                        }else {
                            return ''
                        }
                    }}

            }
            var TableUIObj = new TableUI('plb_other_operate_track');

            var dictionaryObj = {
                MANAGE_ITEM_TYPE: {},
                OUR_PROGRESS:{},
                CONSTRUCTION_UNIT_PRO:{}
            }
            var dictionaryStr = 'MANAGE_ITEM_TYPE,OUR_PROGRESS,CONSTRUCTION_UNIT_PRO';
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
                layui.use(['form', 'table', 'element', 'soulTable', 'eleTree','upload', 'flow','laydate'], function () {
                    var form = layui.form,
                        table = layui.table,
                        element = layui.element,
                        soulTable = layui.soulTable,
                        eleTree = layui.eleTree,
                        upload=layui.upload,
                        layFlow = layui.flow,
                        laydate = layui.laydate;


                    TableUIObj.init(colShowObj, function () {
                        $('.no_data').show();
                        $('.table_box').hide();
                        tableShow();
                    });

                    $('[name="itemType"]', $('.query_module')).append(dictionaryObj['MANAGE_ITEM_TYPE']['str']);


                    $(document).on('mouseover','.divShow',function () {
                        $(this).find('.operationDiv').show();
                    })
                    $(document).on('mouseout','.divShow',function () {
                        $(this).find('.operationDiv').hide();
                    })

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
                        projectId=currentData.projId
                    });

                    // //触发行单击事件
                    // table.on('row(mtlPlanTable)', function (obj) {
                    //     showDetail(obj.data.itemId);
                    // });
                    // 监听排序事件
                    // table.on('sort(mtlPlanTable)', function (obj) {
                    //     var param = {
                    //         orderbyFields: obj.field,
                    //         orderbyUpdown: obj.type
                    //     }
                    //
                    //     TableUIObj.update(param, function () {
                    //         tableShow($('#leftId').attr('projId') || '');
                    //     })
                    // });
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

                    // 上方按钮显示
                    table.on('toolbar(mtlPlanTable)', function (obj) {

                        var checkStatus = table.checkStatus(obj.config.id);
                        console.log(checkStatus);
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
                                    if(!(checkStatus.data[0].manageTrackStatus=='0')){
                                        layer.msg('不可编辑', {icon: 2});
                                        return false;
                                    }
                                    newOrEdit(2, checkStatus.data[0])
                                }else{
                                    layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                                    return false;
                                }

                                break;
                            case 'update':
                                if($('#leftId').attr('projId')){
                                    if (checkStatus.data.length != 1) {
                                        layer.msg('请选择一项！', {icon: 0});
                                        return false
                                    }
                                    if(!(checkStatus.data[0].manageTrackStatus=='0')){
                                        layer.msg('不可进展更新', {icon: 2});
                                        return false;
                                    }
                                    newOrEdit(1, checkStatus.data[0])
                                }else{
                                    layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                                    return false;
                                }

                                break;
                            case 'closePlan':
                                if(checkStatus.length<1){
                                    layer.msg("请至少选择一条");
                                }else{
                                    var ids="";
                                    for(var i=0;i<checkStatus.data.length;i++){
                                        if(checkStatus.data[i].manageTrackStatus&&checkStatus.data[i].manageTrackStatus!='10'){
                                            ids+=checkStatus.data[i].manageTrackId+",";
                                        }else {
                                            layer.msg("审批中的不可关闭");
                                        }
                                    }
                                    if(!ids){
                                        return false
                                    }
                                    $.ajax({
                                        url:'/operateTarck/closeTarck?ids='+ids,
                                        type: 'post',
                                        dataType: 'json',
                                        success:function(res){
                                            layer.msg(res.msg);
                                            tableIns.reload();
                                        }
                                    });
                                }
                                break;
                            case 'submit':
                                if (checkStatus.data.length != 1) {
                                    layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                                    return false;
                                }
                                if(checkStatus.data[0].manageTrackStatus&&checkStatus.data[0].manageTrackStatus == '10'){
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
                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '44'}, function (res) {
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
                                            delete approvalData.tarckConfirmList
                                            newWorkFlow(flowData.flowId, function (res) {
                                                var submitData = {
                                                    manageTrackId:approvalData.manageTrackId,
                                                    runId: res.flowRun.runId,
                                                    //auditerStatus:1
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.ajax({
                                                    url: '/operateTarck/updateRegister',
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
                    //进展明细加行
                    table.on('toolbar(detTarckTable)',function(obj){
                        switch (obj.event) {
                            case 'add':
                                //遍历表格获取每行数据进行保存
                                var $tr = $('.mtl_info').find('.layui-table-main tr');
                                var oldDataArr = [];
                                $tr.each(function (index) {
                                    var attachId = '';
                                    var attachName = '';
                                    var attachmentList = [];
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
                                    var oldDataObj = {
                                        detailsStatus: $(this).find('input[name="tarckDetailsDate"]').attr('detailsStatus'),
                                        tarckDetailsDate: $(this).find('input[name="tarckDetailsDate"]').val(),
                                        ourProgress: $(this).find('select[name="ourProgress"]').val(),
                                        ourProgressExplain: $(this).find('input[name="ourProgressExplain"]').val(),
                                        constructionUnitPro: $(this).find('select[name="constructionUnitPro"]').val(),
                                        constructionUnitProExp: $(this).find('input[name="constructionUnitProExp"]').val(),
                                        memo: $(this).find('input[name="memo"]').val(),
                                        attachmentId:attachId,
                                        attachmentName:attachName,
                                        attachmentList:attachmentList
                                    }
                                    var manageTrackDetailedId = $(this).find('input[name="tarckDetailsDate"]').attr("manageTrackDetailedId");
                                    if(manageTrackDetailedId){
                                        oldDataObj.manageTrackDetailedId=manageTrackDetailedId;
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                var addRowData = {

                                };
                                oldDataArr.push(addRowData);
                                table.reload('detTarckTable', {
                                    data: oldDataArr
                                });
                                break;
                        }
                    })
                    table.on('tool(detTarckTable)',function(obj){
                        var data = obj.data;
                        var layEvent = obj.event;
                        var tr = obj.tr;
                        //进展明细删行
                        if (layEvent == 'del') {
                            if(data.manageTrackDetailedId){
                                $.ajax({
                                    url: '/operateTarckDetails/del?isTarck=tarck&ids='+data.manageTrackDetailedId,
                                    dataType: 'json',
                                    type: 'post',
                                    success: function (res) {
                                        /*if (res.code==='0'||res.code===0) {
                                            layer.msg(res.msg, {icon: 1});
                                        } else {
                                            layer.msg(res.msg, {icon: 2});
                                        }*/
                                    }
                                });
                            }

                            obj.del();


                        }else if (layEvent == 'dateSelection') {
                            var $tr = $('.mtl_info').find(tr.selector).find('input[name="tarckDetailsDate"]');
                            $tr.each(function (index,element) {
                                laydate.render({
                                    elem: element
                                    , trigger: 'click'
                                    , format: 'yyyy-MM-dd'
                                    // , format: 'yyyy-MM-dd HH:mm:ss'
                                   // ,value: new Date()
                                });
                            })
                        }else if (layEvent == 'butfile') {
                            var $tr = tr.selector
                            fileuploadFn( $tr+' [id^=fileupload]', $( $tr+' [id^=fileAll]'));
                        }
                    })
                    //甲方确认加行
                    table.on('toolbar(otherTrackTab)',function(obj){
                        switch (obj.event) {
                            case 'add2':
                                //遍历表格获取每行数据进行保存
                                var $tr = $('.other_info').find('.layui-table-main tr');
                                var oldDataArr = [];
                                $tr.each(function () {
                                    var oldDataObj = {
                                        detailsStatus: $(this).find('input[name="detailed"]').attr('detailsStatus'),
                                        detailed: $(this).find('input[name="detailed"]').val(),
                                        quantities: $(this).find('input[name="quantities"]').val(),
                                        unitPrice: $(this).find('input[name="unitPrice"]').val(),
                                        totalPrice: $(this).find('input[name="totalPrice"]').val()
                                    }
                                    var confirmId = $(this).find('input[name="detailed"]').attr("confirmId");
                                    if(confirmId){
                                        oldDataObj.confirmId=confirmId
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                var addRowData = {

                                };
                                oldDataArr.push(addRowData);
                                table.reload('otherTrackTab', {
                                    data: oldDataArr
                                });
                                break;
                        }
                    })
                    //甲方确认删行
                    table.on('tool(otherTrackTab)',function(obj){
                        var data = obj.data;
                        var layEvent = obj.event;
                        var tr = obj.tr;
                        if (layEvent == 'del2') {
                            var totalPrice = $(tr).find('[name="totalPrice"]').val();
                            if(totalPrice!=undefined&&totalPrice!=""){
                                $("#firstConfirmInf").val(sub($("#firstConfirmInf").val(),totalPrice));
                            }
                            if(data.confirmId){
                                $.ajax({
                                    url: '/operateTarckDetails/del?isTarck=confirm&ids='+data.confirmId,
                                    dataType: 'json',
                                    type: 'post',
                                    success: function (res) {
                                        /*if (res.code==='0'||res.code===0) {
                                            layer.msg(res.msg, {icon: 1});
                                        } else {
                                            layer.msg(res.msg, {icon: 2});
                                        }*/
                                    }
                                });
                            }

                            obj.del();
                        }
                    })
                    table.on('tool(mtlPlanTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        if (layEvent === 'detail') {
                            newOrEdit(4, data)
                        }else if (layEvent === 'del') {
                            if(data.manageProjStatus!='0'){
                                layer.msg('已提交不可删除！', {icon: 0});
                                return false
                            }
                            layer.confirm('确定删除该条数据吗？', function (index) {
                                $.post('/operateTarck/delTarck', {manageTrackId: data.manageTrackId}, function (res) {
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
                        }
                    });

                    // 渲染表格
                    function tableShow(projId) {
                        projId = projId || '';
                        var cols = [].concat(TableUIObj.cols);

                        cols.push({
                            fixed: 'right',
                            align: 'center',
                            toolbar: '#detailBarDemo',
                            title: '操作',
                            minWidth: 150
                        })

                        var option = {
                            elem: '#mtlPlanTable',
                            url: '/operateTarck/select?projectId='+projId+'',
                            toolbar: '#toolbarDemo',
                            defaultToolbar: ['filter'],
                            cols: [cols],
                            page: {
                                limit: 10,
                                limits: [10, 20, 30, 40, 50]
                            },

                        }
                        tableIns = table.render(option);
                    }

                    function newOrEdit(type, data) {
                        var title = '';
                        var url = '';
                        var projId = $('#leftId').attr('projId');
                        if (type == '0') {
                            title = '新增进展跟踪';
                            detaListData=[];
                            tracListData=[];
                            detailsInitData1=[];
                            url = '/operateTarck/insert';
                            layer.open({
                                type:1,
                                title:title,
                                area:['100%','100%'],
                                btn:['确定','提交','取消'],
                                btnAlign:'c',
                                content:'<div class="layui-collapse"> \n' +
                                    <%--    /* region 材料计划 */--%>
                                    '      <div class="layui-colla-item"> \n' +
                                    '            <div class="layui-colla-content layui-show plan_base_info"> \n' +
                                    '                   <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
                                    <%--                /* region 第一行 */--%>
                                    '                           <div class="layui-row"> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="documnetNum" id="documnetNum" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">经营立项名称<span field="manageProjName" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                         <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>' +
                                    '                                                       <input type="text" name="manageProjName" placeholder="请选择经营立项" style="cursor: pointer;background: #e7e7e7" id="manageProjName" readonly autocomplete="off" class="layui-input">\n' +
                                    '                                                       <input type="hidden" name="manageProjId"  id="manageProjId" readonly autocomplete="off" class="layui-input">\n' +
                                    '                                                    </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">经营立项编号<span field="manageProjNum" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block">\n' +
                                    '                                                       <input type="text" name="manageProjNum" id="manageProjNum" readonly autocomplete="off" class="layui-input " >\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                    </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">预计变更收入<span field="estimateChangeInf" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="estimateChangeInf" id="estimateChangeInf" readonly  autocomplete="off" class="layui-input" >\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    /*'                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">经营立项类型<span field="manageProjType" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block">\n' +
                                    '                                                       <input type="text" name="totalManagementTargetName" id="totalManagementTargetName"  readonly autocomplete="off" class="layui-input " >\n' +
                                    '                                                   </div> \n' +
                                    '                                           </div> \n' +
                                    '                                   </div> \n' +*/
                                    '                            </div> \n' +
                                    <%--                /* endregion */--%>
                                    <%--                /* region 第二行 */--%>
                                    // '                           <div class="layui-row"> \n' +
                                    //
                                    // '                           </div> \n' +
                                    <%--                /* endregion */--%>
                                    <%--                /* region 第三行 */--%>
                                    '                           <div class="layui-row"> \n' +

                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">甲方确认后收入<span field="firstConfirmInf" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="firstConfirmInf" id="firstConfirmInf" readonly autocomplete="off" class="layui-input">\n' +
                                    '                                                   </div> \n' +
                                    '                                           </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">填报人<span field="controlMode" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="createUserName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7" disabled>\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">填报时间</label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="createTime" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7" disabled>\n' +
                                    // '                                                       <button type="button" id="choBtn" class="layui-btn layui-btn-xs" style="position: absolute;right: -98px;top: 0;height: 37px;font-size: 12px">选择跟踪目标</button>\n' +
                                    '                                                   </div>\n' +
                                    '                                            </div> \n' +
                                    '                                    </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">备注</label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="demo" autocomplete="off" class="layui-input"  >\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                            </div> \n' +
                                    <%--                /* endregion */--%>
                                    <%--                /* region 第四行 */--%>
                                    '                           <div class="layui-row"> \n' +
                                    '                                   <div class="layui-col-xs6" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">项目立项内容<span field="manageProjCon" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <textarea name="manageProjCon" id="manageProjCon" placeholder="请输入立项内容" class="layui-textarea"></textarea> \n' +
                                    '                                                   </div> \n' +
                                    '                                           </div> \n' +
                                    '                                   </div> \n' +
                                    '                            </div> \n' +
                                    <%--                /* endregion */--%>
                                    '                       </form> \n' +
                                    '                </div> \n' +
                                    '          </div> \n' +
                                    <%--    /* endregion */--%>
                                    <%--    /* region 进展明细 */--%>
                                    '      <div class="layui-colla-item"> \n' +
                                    '            <h2 class="layui-colla-title">进展明细</h2> \n' +
                                    '            <div class="layui-colla-content mtl_info layui-show"> \n' +
                                    <%--            /* region 第五行 */--%>
                                    '                <div class="layui-row">\n' +
                                    '                      <table id="detTarckTable" lay-filter="detTarckTable" class="layui-table"></table>\n' +
                                    '                </div> \n' +
                                    '            </div> \n' +
                                    '       </div> \n' +
                                    <%--    /* endregion */--%>
                                    <%--    /* region*/--%>
                                    '      <div class="layui-colla-item"> \n' +
                                    '            <h2 class="layui-colla-title">甲方确认</h2>\n' +
                                    '            <div class="layui-colla-content other_info layui-show"> \n' +
                                    <%--            /* region 第八行 */--%>
                                    '                 <div class="layui-row"> \n' +
                                    '                    <table id="otherTrackTab" lay-filter="otherTrackTab" class="layui-table"></table>\n' +
                                    '                 </div>\n' +
                                    <%--            /* region*/--%>
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '    </div>',
                                success: function () {

                                    if(projId){
                                        //回显项目名称
                                        getProjName('#projectName',projId)
                                    }

                                    table.render({
                                        elem: '#detTarckTable',
                                        data: detaListData,
                                        toolbar: '#delTarckTool',
                                        cols: [[
                                            {type: 'numbers', title: '序号',},
                                            {
                                                field: 'tarckDetailsDate',
                                                title: '日期',
                                                sort: true,
                                                minWidth: 120,
                                                event: 'dateSelection',
                                                templet: function (d) {
                                                    return '<input type="text" manageTrackDetailedId="'+(d.manageTrackDetailedId||'')+'" name="tarckDetailsDate" class="layui-input" style="height: 100%;" value="' + (d.tarckDetailsDate || '') + '">'
                                                }
                                            },
                                            {field: 'ourProgress', title: '我方进展', minWidth: 100, templet: function (d) {
                                                    var optionStr = '<option value="">请选择</option>';
                                                    if(dictionaryObj.OUR_PROGRESS.object){
                                                        for (index in dictionaryObj.OUR_PROGRESS.object){
                                                            if(d.ourProgress!=undefined&&index==d.ourProgress){
                                                                optionStr += '<option value="'+index+'" selected>'+dictionaryObj.OUR_PROGRESS.object[index]+'</option>';
                                                            }else{
                                                                optionStr += '<option value="'+index+'" >'+dictionaryObj.OUR_PROGRESS.object[index]+'</option>';
                                                            }
                                                        }
                                                        return '<select name="ourProgress" class="layui-input" style="height: 100%;" value="' + (d.ourProgress || '') + '">'+optionStr+'</select>'
                                                    }else {
                                                        return '';
                                                    }
                                                }},
                                            {field: 'ourProgressExplain', title: '我方进展说明', minWidth: 120, templet: function (d) {
                                                    return '<input type="text" name="ourProgressExplain" class="layui-input tips" style="height: 100%;" value="' + (d.ourProgressExplain || '') + '">'
                                                }},
                                            {field: 'constructionUnitPro', title: '建设单位进展', minWidth: 100, templet: function (d) {
                                                    var optionStr = '<option value="">请选择</option>';
                                                    if(dictionaryObj.CONSTRUCTION_UNIT_PRO.object){
                                                        for (index in dictionaryObj.CONSTRUCTION_UNIT_PRO.object){
                                                            if(d.constructionUnitPro!=undefined&&index==d.constructionUnitPro){
                                                                optionStr += '<option value="'+index+'" selected>'+dictionaryObj.CONSTRUCTION_UNIT_PRO.object[index]+'</option>';
                                                            }else{
                                                                optionStr += '<option value="'+index+'" >'+dictionaryObj.CONSTRUCTION_UNIT_PRO.object[index]+'</option>';
                                                            }
                                                        }
                                                        return '<select name="constructionUnitPro" class="layui-input" style="height: 100%;" value="' + (d.constructionUnitPro || '') + '">'+optionStr+'</select>'
                                                    }else {
                                                        return '';
                                                    }
                                                }},
                                            {field: 'constructionUnitProExp', title: '建设单位进展说明', minWidth: 120, templet: function (d) {
                                                    return '<input type="text" name="constructionUnitProExp" class="layui-input tips" style="height: 100%;" value="' + (d.constructionUnitProExp || '') + '">'
                                                }},
                                            {field: 'memo', title: '备注', minWidth: 80, templet: function (d) {
                                                    return '<input type="text"  name="memo" class="layui-input tips" style="height: 100%;" value="' + (d.memo || '') + '">'
                                                }},
                                            {
                                                field: 'attachmentName',
                                                title: '附件内容',
                                                align: 'center',
                                                templet: function (d) {
                                                    var fileArr = d.attachmentList;
                                                    var str = '';
                                                    return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
                                                        '</div>'
                                                }
                                            },
                                            {title: '附件', align: 'center', toolbar: '#internalBar', minWidth: 100},
                                            {align: 'center', toolbar: '#toolbarDemoIn', title: '操作', minWidth: 100}
                                        ]],
                                        done: function (res) {
                                            $('.tips').on('mouseenter', function(){
                                                var content = $(this).val();
                                                if(!content){
                                                    return false
                                                }

                                                this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
                                                    time: -1
                                                    ,maxWidth: 280
                                                    ,tips: [3, '#3A3D49']
                                                });
                                            }).on('mouseleave', function(){
                                                layer.close(this.index);
                                            });
                                        }
                                    })
                                    table.render({
                                        elem: '#otherTrackTab',
                                        data: tracListData,
                                        toolbar: '#delTarckTool2',
                                        cols: [[
                                            {field: 'detailed', title: '明细', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="text" confirmId="'+(d.confirmId||'')+'" name="detailed" class="layui-input" style="height: 100%;" value="' + (d.detailed || '') + '">'
                                                }},
                                            {field: 'quantities', title: '工程量', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="number" name="quantities" class="layui-input" style="height: 100%;" value="' + (d.quantities || '') + '">'
                                                }},
                                            {field: 'unitPrice', title: '单价', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="number" name="unitPrice" class="layui-input" style="height: 100%;" value="' + (d.unitPrice || '') + '">'
                                                }},
                                            {field: 'totalPrice', title: '总价', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="number" readonly name="totalPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.totalPrice || '') + '">'
                                                }},
                                            {align: 'center', toolbar: '#toolbarDemoIn2', title: '操作', minWidth: 100,fixed:'right'}
                                        ]]
                                    })


                                    //新增时计划编号显示
                                    if (type == '0') {
                                        // 获取单据号
                                        $.ajax({
                                            url: '/planningManage/autoNumber?autoNumberType=jygz',
                                            dataType: 'json',
                                            type: 'post',
                                            async: false,
                                            success: function (res) {
                                                $('input[name="documnetNum"]').val(res.obj);
                                                $('input[name="createUserName"]').val(res.object.createUserName);
                                                $('input[name="createTime"]').val(res.object.createTime);
                                            }
                                        })
                                    }
                                    //回显数据
                                    if (type == '1' || type == '4') {
                                        if (data != undefined) {
                                            form.val("baseForm", data);
                                        }
                                    }
                                    form.render();
                                },
                                yes: function (index) {
                                    var loadIndex = layer.load();
                                    //主表数据
                                    var datas = $('#baseForm').serializeArray();
                                    var obj = {}
                                    datas.forEach(function (item) {
                                        obj[item.name] = item.value;
                                    });
                                    if(type===1&&data!=undefined){
                                        if(data.manageTrackId!=undefined){
                                            obj.manageTrackId = data.manageTrackId;
                                        }
                                    }
                                    obj.projectId =$('#leftId').attr('projId');
                                    obj.manageTrackStatus = 0;

                                    /* // 判断必填项
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

                                     if (requiredFlag) {
                                         layer.close(loadIndex);
                                         return false;
                                     }*/

                                    //进展明细
                                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                                    var detailList = [];
                                    $tr.each(function (index) {
                                        var attachId = '';
                                        var attachName = '';
                                        for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                                            attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                                            attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                                        }
                                        var plbManageItemObj = {
                                            tarckDetailsDate: $(this).find('input[name="tarckDetailsDate"]').val(),
                                            ourProgress: $(this).find('select[name="ourProgress"]').val(),
                                            ourProgressExplain: $(this).find('input[name="ourProgressExplain"]').val(),
                                            constructionUnitPro: $(this).find('select[name="constructionUnitPro"]').val(),
                                            constructionUnitProExp: $(this).find('input[name="constructionUnitProExp"]').val(),
                                            memo: $(this).find('input[name="memo"]').val(),
                                            attachmentId:attachId,
                                            attachmentName:attachName
                                        }
                                        var manageTrackDetailedId = $(this).find('input[name="tarckDetailsDate"]').attr("manageTrackDetailedId");
                                        if(manageTrackDetailedId){
                                            plbManageItemObj.manageTrackDetailedId=manageTrackDetailedId;
                                        }
                                        detailList.push(plbManageItemObj);
                                    });
                                    obj.detailList = detailList;
                                    //甲方确认
                                    var $tr = $('.other_info').find('.layui-table-main tr');
                                    var tarckConfirmList = [];
                                    $tr.each(function () {
                                        var plbManageItemObj = {
                                            detailed: $(this).find('input[name="detailed"]').val(),
                                            quantities: $(this).find('input[name="quantities"]').val(),
                                            unitPrice: $(this).find('input[name="unitPrice"]').val(),
                                            totalPrice: $(this).find('input[name="totalPrice"]').val(),
                                        }
                                        var confirmId = $(this).find('input[name="detailed"]').attr("confirmId");
                                        if(confirmId){
                                            plbManageItemObj.confirmId=confirmId
                                        }
                                        tarckConfirmList.push(plbManageItemObj);
                                    });
                                    obj.tarckConfirmList = tarckConfirmList;

                                    $.ajax({
                                        url: url,
                                        data:JSON.stringify(obj),
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
                                    //主表数据
                                    var datas = $('#baseForm').serializeArray();
                                    var obj = {}
                                    datas.forEach(function (item) {
                                        obj[item.name] = item.value;
                                    });
                                    if(type===1&&data!=undefined){
                                        if(data.manageTrackId!=undefined){
                                            obj.manageTrackId = data.manageTrackId;
                                        }
                                    }
                                    obj.projectId =$('#leftId').attr('projId');
                                    obj.manageTrackStatus = 0;

                                    /* // 判断必填项
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

                                     if (requiredFlag) {
                                         layer.close(loadIndex);
                                         return false;
                                     }*/

                                    //进展明细
                                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                                    var detailList = [];
                                    $tr.each(function (index) {
                                        var attachId = '';
                                        var attachName = '';
                                        for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                                            attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                                            attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                                        }
                                        var plbManageItemObj = {
                                            tarckDetailsDate: $(this).find('input[name="tarckDetailsDate"]').val(),
                                            ourProgress: $(this).find('select[name="ourProgress"]').val(),
                                            ourProgressExplain: $(this).find('input[name="ourProgressExplain"]').val(),
                                            constructionUnitPro: $(this).find('select[name="constructionUnitPro"]').val(),
                                            constructionUnitProExp: $(this).find('input[name="constructionUnitProExp"]').val(),
                                            memo: $(this).find('input[name="memo"]').val(),
                                            attachmentId:attachId,
                                            attachmentName:attachName
                                        }
                                        var manageTrackDetailedId = $(this).find('input[name="tarckDetailsDate"]').attr("manageTrackDetailedId");
                                        if(manageTrackDetailedId){
                                            plbManageItemObj.manageTrackDetailedId=manageTrackDetailedId;
                                        }
                                        detailList.push(plbManageItemObj);
                                    });
                                    obj.detailList = detailList;
                                    //甲方确认
                                    var $tr = $('.other_info').find('.layui-table-main tr');
                                    var tarckConfirmList = [];
                                    $tr.each(function () {
                                        var plbManageItemObj = {
                                            detailed: $(this).find('input[name="detailed"]').val(),
                                            quantities: $(this).find('input[name="quantities"]').val(),
                                            unitPrice: $(this).find('input[name="unitPrice"]').val(),
                                            totalPrice: $(this).find('input[name="totalPrice"]').val(),
                                        }
                                        var confirmId = $(this).find('input[name="detailed"]').attr("confirmId");
                                        if(confirmId){
                                            plbManageItemObj.confirmId=confirmId
                                        }
                                        tarckConfirmList.push(plbManageItemObj);
                                    });
                                    obj.tarckConfirmList = tarckConfirmList;

                                    $.ajax({
                                        url: url,
                                        data:JSON.stringify(obj),
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
                                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '44'}, function (res) {
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
                                                            delete approvalData.tarckConfirmList
                                                            newWorkFlow(flowData.flowId, function (res) {
                                                                var submitData = {
                                                                    manageTrackId:approvalData.manageTrackId,
                                                                    runId: res.flowRun.runId,
                                                                    //auditerStatus:1
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
                            })
                        } else if (type == '1'||type == '2') {

                            if(type == '1'){
                                title = '进展更新';
                            }else if (type == '2'){
                                title = '编辑';
                            }

                            detailsInitData1=data;
                            detaListData=data.detailList;
                            tracListData=data.tarckConfirmList;
                            url = '/operateTarck/updateRegister';
                            layer.open({
                                type:1,
                                title:title,
                                area:['100%','100%'],
                                btn:['确定','提交','取消'],
                                btnAlign:'c',
                                content:'<div class="layui-collapse"> \n' +
                                    <%--    /* region 材料计划 */--%>
                                    '      <div class="layui-colla-item"> \n' +
                                    '            <div class="layui-colla-content layui-show plan_base_info"> \n' +
                                    '                   <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
                                    <%--                /* region 第一行 */--%>
                                    '                           <div class="layui-row"> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="documnetNum" id="documnetNum" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">经营立项名称<span field="manageProjName" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                         <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>' +
                                    '                                                       <input type="text" name="manageProjName" placeholder="请选择经营立项" style="cursor: pointer;background: #e7e7e7" id="manageProjName" readonly autocomplete="off" class="layui-input">\n' +
                                    '                                                       <input type="hidden" name="manageProjId"  id="manageProjId" readonly autocomplete="off" class="layui-input">\n' +
                                    '                                                    </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">经营立项编号<span field="manageProjNum" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block">\n' +
                                    '                                                       <input type="text" name="manageProjNum" id="manageProjNum" readonly autocomplete="off" class="layui-input " >\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                    </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">预计变更收入<span field="estimateChangeInf" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="estimateChangeInf" id="estimateChangeInf" readonly  autocomplete="off" class="layui-input" >\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    /*'                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">经营立项类型<span field="manageProjType" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block">\n' +
                                    '                                                       <input type="text" name="totalManagementTargetName" id="totalManagementTargetName"  readonly autocomplete="off" class="layui-input " >\n' +
                                    '                                                   </div> \n' +
                                    '                                           </div> \n' +
                                    '                                   </div> \n' +*/
                                    '                            </div> \n' +
                                    <%--                /* endregion */--%>
                                    <%--                /* region 第二行 */--%>
                                    // '                           <div class="layui-row"> \n' +
                                    //
                                    // '                           </div> \n' +
                                    <%--                /* endregion */--%>
                                    <%--                /* region 第三行 */--%>
                                    '                           <div class="layui-row"> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">甲方确认后收入<span field="firstConfirmInf" class="field_required">*</span></label>\n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="firstConfirmInf" id="firstConfirmInf" readonly autocomplete="off" class="layui-input">\n' +
                                    '                                                   </div> \n' +
                                    '                                           </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">填报人<span field="controlMode" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="createUserName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7" disabled>\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">填报时间</label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="createTime" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7" disabled>\n' +
                                    // '                                                       <button type="button" id="choBtn" class="layui-btn layui-btn-xs" style="position: absolute;right: -98px;top: 0;height: 37px;font-size: 12px">选择跟踪目标</button>\n' +
                                    '                                                   </div>\n' +
                                    '                                            </div> \n' +
                                    '                                    </div> \n' +
                                    '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">备注</label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <input type="text" name="demo" readonly autocomplete="off" class="layui-input"  >\n' +
                                    '                                                   </div> \n' +
                                    '                                            </div> \n' +
                                    '                                   </div> \n' +
                                    '                            </div> \n' +
                                    <%--                /* endregion */--%>
                                    <%--                /* region 第四行 */--%>
                                    '                           <div class="layui-row"> \n' +
                                    '                                   <div class="layui-col-xs6" style="padding: 0 5px;"> \n' +
                                    '                                           <div class="layui-form-item"> \n' +
                                    '                                                   <label class="layui-form-label form_label">项目立项内容<span field="manageProjCon" class="field_required">*</span></label> \n' +
                                    '                                                   <div class="layui-input-block form_block"> \n' +
                                    '                                                       <textarea name="manageProjCon" id="manageProjCon" readonly placeholder="请输入立项内容" class="layui-textarea"></textarea> \n' +
                                    '                                                   </div> \n' +
                                    '                                           </div> \n' +
                                    '                                   </div> \n' +
                                    '                            </div> \n' +
                                    <%--                /* endregion */--%>
                                    '                       </form> \n' +
                                    '                </div> \n' +
                                    '          </div> \n' +
                                    <%--    /* endregion */--%>
                                    <%--    /* region 进展明细 */--%>
                                    '      <div class="layui-colla-item"> \n' +
                                    '            <h2 class="layui-colla-title">进展明细</h2> \n' +
                                    '            <div class="layui-colla-content mtl_info layui-show"> \n' +
                                    <%--            /* region 第五行 */--%>
                                    '                <div class="layui-row">\n' +
                                    '                      <table id="detTarckTable" lay-filter="detTarckTable" class="layui-table"></table>\n' +
                                    '                </div> \n' +
                                    '            </div> \n' +
                                    '       </div> \n' +
                                    <%--    /* endregion */--%>
                                    <%--    /* region*/--%>
                                    '      <div class="layui-colla-item"> \n' +
                                    '            <h2 class="layui-colla-title">甲方确认</h2>\n' +
                                    '            <div class="layui-colla-content other_info layui-show"> \n' +
                                    <%--            /* region 第八行 */--%>
                                    '                 <div class="layui-row"> \n' +
                                    '                    <table id="otherTrackTab" lay-filter="otherTrackTab" class="layui-table"></table>\n' +
                                    '                 </div>\n' +
                                    <%--            /* region*/--%>
                                    '            </div>\n' +
                                    '        </div>\n' +
                                    '    </div>',
                                success: function () {

                                    //回显项目名称
                                    getProjName('#projectName',projId?projId:data.projId)


                                    table.render({
                                        elem: '#detTarckTable',
                                        data: detaListData,
                                        toolbar: '#delTarckTool',
                                        cols: [[
                                            {type: 'numbers', title: '序号',},
                                            {
                                                field: 'tarckDetailsDate',
                                                title: '日期',
                                                sort: true,
                                                minWidth: 60,
                                                event: 'dateSelection',
                                                templet: function (d) {
                                                    return '<input type="text" manageTrackDetailedId="'+(d.manageTrackDetailedId||'')+'" detailsStatus="'+(d.detailsStatus||'')+'" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'disabled')+' name="tarckDetailsDate" class="layui-input" style="height: 100%;" value="' + (d.tarckDetailsDate || '') + '">'
                                                }
                                            },
                                            {field: 'ourProgress', title: '我方进展', minWidth: 100, templet: function (d) {
                                                    var optionStr = '<option value="">请选择</option>';
                                                    if(dictionaryObj.OUR_PROGRESS.object){
                                                        for (index in dictionaryObj.OUR_PROGRESS.object){
                                                            if(d.ourProgress!=undefined&&index==d.ourProgress){
                                                                optionStr += '<option value="'+index+'" selected>'+dictionaryObj.OUR_PROGRESS.object[index]+'</option>';
                                                            }else{
                                                                optionStr += '<option value="'+index+'" >'+dictionaryObj.OUR_PROGRESS.object[index]+'</option>';
                                                            }
                                                        }
                                                        return '<select name="ourProgress" class="layui-input" style="height: 100%;"  '+(!d.detailsStatus||d.detailsStatus=="0"?'':'disabled')+' value="' + (d.ourProgress || '') + '">'+optionStr+'</select>'
                                                    }else {
                                                        return '';
                                                    }
                                                }},
                                            {field: 'ourProgressExplain', title: '我方进展说明', minWidth: 120, templet: function (d) {
                                                    return '<input type="text" name="ourProgressExplain" class="layui-input tips" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.ourProgressExplain || '') + '">'
                                                }},
                                            {field: 'constructionUnitPro', title: '建设单位进展', minWidth: 100, templet: function (d) {
                                                    var optionStr = '<option value="">请选择</option>';
                                                    if(dictionaryObj.CONSTRUCTION_UNIT_PRO.object){
                                                        for (index in dictionaryObj.CONSTRUCTION_UNIT_PRO.object){
                                                            if(d.constructionUnitPro!=undefined&&index==d.constructionUnitPro){
                                                                optionStr += '<option value="'+index+'" selected>'+dictionaryObj.CONSTRUCTION_UNIT_PRO.object[index]+'</option>';
                                                            }else{
                                                                optionStr += '<option value="'+index+'" >'+dictionaryObj.CONSTRUCTION_UNIT_PRO.object[index]+'</option>';
                                                            }
                                                        }
                                                        return '<select name="constructionUnitPro" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'disabled')+' style="height: 100%;" value="' + (d.constructionUnitPro || '') + '">'+optionStr+'</select>'
                                                    }else {
                                                        return '';
                                                    }
                                                }},
                                            {field: 'constructionUnitProExp', title: '建设单位进展说明', minWidth: 120, templet: function (d) {
                                                    return '<input type="text" name="constructionUnitProExp" class="layui-input tips" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.constructionUnitProExp || '') + '">'
                                                }},
                                            {field: 'memo', title: '备注', minWidth: 100, templet: function (d) {
                                                    return '<input type="text"  name="memo" class="layui-input tips" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.memo || '') + '">'
                                                }},
                                            {
                                                field: 'attachmentName',
                                                title: '附件内容',
                                                align: 'center',
                                                templet: function (d) {
                                                    var fileArr = d.attachmentList;
                                                    return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
                                                        '</div>'
                                                }
                                            },
                                            {title: '附件', align: 'center', toolbar: '#internalBar', minWidth: 100},
                                            {align: 'center', toolbar: '#toolbarDemoIn', title: '操作', minWidth: 100}
                                        ]],
                                        done: function (res) {
                                            $('.tips').on('mouseenter', function(){
                                                var content = $(this).val();
                                                if(!content){
                                                    return false
                                                }

                                                this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
                                                    time: -1
                                                    ,maxWidth: 280
                                                    ,tips: [3, '#3A3D49']
                                                });
                                            }).on('mouseleave', function(){
                                                layer.close(this.index);
                                            });
                                        }
                                    })
                                    table.render({
                                        elem: '#otherTrackTab',
                                        data: tracListData,
                                        toolbar: '#delTarckTool2',
                                        cols: [[
                                            {field: 'detailed', title: '明细', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="text" confirmId="'+(d.confirmId||'')+'" detailsStatus="'+(d.detailsStatus||'')+'" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+'  name="detailed" class="layui-input" style="height: 100%;" value="' + (d.detailed || '') + '">'
                                                }},
                                            {field: 'quantities', title: '工程量', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="number" name="quantities" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.quantities || '') + '">'
                                                }},
                                            {field: 'unitPrice', title: '单价', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="number" name="unitPrice" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.unitPrice || '') + '">'
                                                }},
                                            {field: 'totalPrice', title: '总价', sort: true, minWidth: 100, templet: function (d) {
                                                    return '<input type="number" readonly name="totalPrice" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;background: #e7e7e7;" value="' + (d.totalPrice || '') + '">'
                                                }},
                                            {align: 'center', toolbar: '#toolbarDemoIn2', title: '操作', minWidth: 100,fixed:'right'}
                                        ]]
                                    })


                                    //新增时计划编号显示
                                    if (type == '0') {
                                        // 获取单据号
                                        $.ajax({
                                            url: '/planningManage/autoNumber?autoNumberType=jygz',
                                            dataType: 'json',
                                            type: 'post',
                                            async: false,
                                            success: function (res) {
                                                $('input[name="documnetNum"]').val(res.obj);
                                                $('input[name="createUserName"]').val(res.object.createUserName);
                                                $('input[name="createTime"]').val(res.object.createTime);
                                            }
                                        })
                                    }
                                    //回显数据
                                    if (type == '1' || type == '4') {
                                        if (data != undefined) {
                                            form.val("baseForm", data);
                                        }
                                    }
                                    form.render();
                                },
                                yes: function (index) {
                                    var loadIndex = layer.load();
                                    //主表数据
                                    var datas = $('#baseForm').serializeArray();
                                    var obj = {}
                                    datas.forEach(function (item) {
                                        obj[item.name] = item.value;
                                    });
                                    if(type===1&&data!=undefined){
                                        if(data.manageTrackId!=undefined){
                                            obj.manageTrackId = data.manageTrackId;
                                        }
                                    }
                                    obj.projectId =$('#leftId').attr('projId');
                                    obj.manageTrackStatus = 0;

                                    /* // 判断必填项
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

                                     if (requiredFlag) {
                                         layer.close(loadIndex);
                                         return false;
                                     }*/

                                    //进展明细
                                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                                    var detailList = [];
                                    $tr.each(function (index) {
                                        var attachId = '';
                                        var attachName = '';
                                        for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                                            attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                                            attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                                        }
                                        var plbManageItemObj = {
                                            tarckDetailsDate: $(this).find('input[name="tarckDetailsDate"]').val(),
                                            ourProgress: $(this).find('select[name="ourProgress"]').val(),
                                            ourProgressExplain: $(this).find('input[name="ourProgressExplain"]').val(),
                                            constructionUnitPro: $(this).find('select[name="constructionUnitPro"]').val(),
                                            constructionUnitProExp: $(this).find('input[name="constructionUnitProExp"]').val(),
                                            memo: $(this).find('input[name="memo"]').val(),
                                            attachmentId:attachId,
                                            attachmentName:attachName
                                        }
                                        var manageTrackDetailedId = $(this).find('input[name="tarckDetailsDate"]').attr("manageTrackDetailedId");
                                        if(manageTrackDetailedId){
                                            plbManageItemObj.manageTrackDetailedId=manageTrackDetailedId;
                                        }
                                        detailList.push(plbManageItemObj);
                                    });
                                    obj.detailList = detailList;
                                    //甲方确认
                                    var $tr = $('.other_info').find('.layui-table-main tr');
                                    var tarckConfirmList = [];
                                    $tr.each(function () {
                                        var plbManageItemObj = {
                                            detailed: $(this).find('input[name="detailed"]').val(),
                                            quantities: $(this).find('input[name="quantities"]').val(),
                                            unitPrice: $(this).find('input[name="unitPrice"]').val(),
                                            totalPrice: $(this).find('input[name="totalPrice"]').val(),
                                        }
                                        var confirmId = $(this).find('input[name="detailed"]').attr("confirmId");
                                        if(confirmId){
                                            plbManageItemObj.confirmId=confirmId
                                        }
                                        tarckConfirmList.push(plbManageItemObj);
                                    });
                                    obj.tarckConfirmList = tarckConfirmList;

                                    $.ajax({
                                        url: url,
                                        data:JSON.stringify(obj),
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
                                    //主表数据
                                    var datas = $('#baseForm').serializeArray();
                                    var obj = {}
                                    datas.forEach(function (item) {
                                        obj[item.name] = item.value;
                                    });
                                    if(type===1&&data!=undefined){
                                        if(data.manageTrackId!=undefined){
                                            obj.manageTrackId = data.manageTrackId;
                                        }
                                    }
                                    obj.projectId =$('#leftId').attr('projId');
                                    obj.manageTrackStatus = 0;

                                    /* // 判断必填项
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

                                     if (requiredFlag) {
                                         layer.close(loadIndex);
                                         return false;
                                     }*/

                                    //进展明细
                                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                                    var detailList = [];
                                    $tr.each(function (index) {
                                        var attachId = '';
                                        var attachName = '';
                                        for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                                            attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                                            attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                                        }
                                        var plbManageItemObj = {
                                            tarckDetailsDate: $(this).find('input[name="tarckDetailsDate"]').val(),
                                            ourProgress: $(this).find('select[name="ourProgress"]').val(),
                                            ourProgressExplain: $(this).find('input[name="ourProgressExplain"]').val(),
                                            constructionUnitPro: $(this).find('select[name="constructionUnitPro"]').val(),
                                            constructionUnitProExp: $(this).find('input[name="constructionUnitProExp"]').val(),
                                            memo: $(this).find('input[name="memo"]').val(),
                                            attachmentId:attachId,
                                            attachmentName:attachName
                                        }
                                        var manageTrackDetailedId = $(this).find('input[name="tarckDetailsDate"]').attr("manageTrackDetailedId");
                                        if(manageTrackDetailedId){
                                            plbManageItemObj.manageTrackDetailedId=manageTrackDetailedId;
                                        }
                                        detailList.push(plbManageItemObj);
                                    });
                                    obj.detailList = detailList;
                                    //甲方确认
                                    var $tr = $('.other_info').find('.layui-table-main tr');
                                    var tarckConfirmList = [];
                                    $tr.each(function () {
                                        var plbManageItemObj = {
                                            detailed: $(this).find('input[name="detailed"]').val(),
                                            quantities: $(this).find('input[name="quantities"]').val(),
                                            unitPrice: $(this).find('input[name="unitPrice"]').val(),
                                            totalPrice: $(this).find('input[name="totalPrice"]').val(),
                                        }
                                        var confirmId = $(this).find('input[name="detailed"]').attr("confirmId");
                                        if(confirmId){
                                            plbManageItemObj.confirmId=confirmId
                                        }
                                        tarckConfirmList.push(plbManageItemObj);
                                    });
                                    obj.tarckConfirmList = tarckConfirmList;

                                    $.ajax({
                                        url: url,
                                        data:JSON.stringify(obj),
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
                                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '44'}, function (res) {
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
                                                            delete approvalData.detailList
                                                            delete approvalData.tarckConfirmList
                                                            approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                                            approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                                            newWorkFlow(flowData.flowId, function (res) {
                                                                var submitData = {
                                                                    manageTrackId:approvalData.manageTrackId,
                                                                    runId: res.flowRun.runId,
                                                                    //auditerStatus:1
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
                                    tableIns.reload();
                                }
                            })
                        }else if (type == '4'){
                            detailsInitData1=data;
                            detaListData=data.detailList;
                            tracListData=data.tarckConfirmList;
                            title = '查看详情';
                            layer.open({
                                type:2,
                                title:title,
                                area:['100%','100%'],
                                btn:['确定','取消'],
                                btnAlign:'c',
                                content: '/plbOperateManage/addOperateTrack?type=4&manageTrackId='+data.manageTrackId,
                                success: function () {
                                },
                                yes: function (index) {
                                    layer.close(index);
                                }
                            })
                        }
                    }
                    $(document).on('click', '.refresh_no_btn', function () {
                        $.ajax({
                            url: '/planningManage/autoNumber?autoNumberType=jygz',
                            dataType: 'json',
                            type: 'post',
                            async: false,
                            success: function (res) {
                                $('input[name="documnetNum"]').val(res.obj);
                                $('input[name="createUserName"]').val(res.object.createUserName);
                                $('input[name="createTime"]').val(res.object.createTime);
                            }
                        })
                    })
                    // 经营立项名称选择
                    /*$(document).on('click','#manageProjName', function () {
                        layer.open({
                            type: 1,
                            skin: 'layui-layer-molv', //加上边框
                            area: ['80%', '70%'], //宽高
                            title: '选择经营立项',
                            maxmin: true,
                            btn: ['确定'],
                            btnAlign:'c',
                            content: '<div class="mbox">\n' +
                                '    <div class="layui-card">\n' +
                                '        <div class="layui-card-body">\n' +
                                '            <div class="layui-rt">\n' +
                                '                <div class="layui-tab layui-tab-card" lay-filter="tabtoggle">\n' +
                                '                    <div class="layui-tab-content" style="height:100%;padding: 0 10px 10px 10px">\n' +
                                '                        <div id="firstBox" class="layui-tab-item layui-show">\n' +
                                '                            <table class="layui-table" lay-skin="line" id="Settlement2" lay-size="sm" lay-filter="SettlementFilter2"></table>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </div>\n' +
                                '        </div>\n' +
                                '    </div>\n' +
                                '</div>',
                            success: function () {

                                table.render({
                                    elem: '#Settlement2'
                                    , url: '/manageProject/select?manageProjStatus=2&projectId='+$('#leftId').attr('projId')//数据接口
                                    //, toolbar: "#toolbar"
                                    , defaultToolbar: []
                                    , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                        layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                        , limits: [15, 30, 45, 60, 75, 90, 105, 120]
                                        , first: '首页'
                                        , last: '尾页'
                                    }
                                    , limit: 15
                                    , cols: [[//表头
                                        {type: 'radio'},
                                        {type: 'numbers', minWidth: 60, title: '序号'},
                                        {field: 'manageProjNo', title: '立项编号', sort: true, hide: false},
                                        {field:'manageProjName',title:'经营立项名称', sort: true, hide: false},
                                        {field: 'changeIncome', title: '预计变更收入', sort: true, hide: false},
                                        {field: 'implementationCost', title: '实施成本', sort: true, hide: false},
                                        {field: 'estimatedProfit', title: '预计利润', sort: true, hide: false},
                                        {field: 'manageProjContent', title: '立项内容', sort: true, hide: false},
                                        {field: 'projectDate', title: '经营立项日期', sort: true, hide: false},

                                        //{title: '操作', minWidth: 190, toolbar: '#barOperation'}
                                    ]]
                                    , done: function (res) {
                                        var data = res.data;
                                        if(detailsInitData1){
                                            for(var i = 0 ; i <data.length;i++){
                                                if(data[i].manageProjId == detailsInitData1.manageProjId){
                                                    $('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
                                                    // form.render('checkbox');
                                                }
                                            }
                                        }
                                    }
                                });

                                form.render();//重置表格


                            },
                            yes: function (index, layero) {
                                layer.close(index);
                                var datas = table.checkStatus('Settlement2').data[0];
                                detailsInitData1 = datas;
                                $('#manageProjName').val(datas ? datas.manageProjName : '');
                                $('#manageProjId').val(datas ? datas.manageProjId : '');
                                $('#manageProjNum').val(datas ? datas.manageProjNo : '');
                                $('#totalManagementTargetName').val(datas ? datas.manageProjTypeName : '');
                                $('#totalManagementTargetName').attr('manageProjType',datas ? datas.manageProjType : '');
                                $('#estimateChangeInf').val(datas ? datas.changeIncome : '');
                                $('#manageProjCon').val(datas ? datas.manageProjContent : '');

                            }
                        });
                    })*/
                })
            }

            //监听甲方确认单价
            $(document).on('blur', 'input[name="unitPrice"]', function () {
                var $tr = $('.other_info').find('.layui-table-main tr');
                var $tr2 = $('.other_info').find('.layui-table-main tr [name="totalPrice"]');
                //计算甲方确认总价
                if($(this).val() && $(this).parents('tr').find('[name="unitPrice"]').val()){
                    //总价
                    var totalPrice=0
                    //工程量
                    var quantities=$(this).parents('tr').find('input[name="quantities"]').val()
                    //单价
                    var unitPrice=$(this).parents('tr').find('input[name="unitPrice"]').val()
                    totalPrice=mul(quantities,unitPrice)
                    $(this).parents('tr').find('[name="totalPrice"]').val(retainDecimal(totalPrice,3))

                    //计算甲方确认后收入
                    var firstConfirmInf = 0;
                    $tr2.each(function (index,element) {
                        firstConfirmInf=accAdd(firstConfirmInf,$(element).val());
                    });
                    $('#firstConfirmInf').val(retainDecimal(firstConfirmInf,3))
                }
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
