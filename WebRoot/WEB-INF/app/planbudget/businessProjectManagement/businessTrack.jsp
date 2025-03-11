<%--
  Created by IntelliJ IDEA.
  User: 陈晟
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
                height: 36px;
                line-height: 36px;
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

            .layui-table-view .layui-table td {
                cursor: pointer;
            }

            .layui-table-hover {
                background-color: #5FB878 !important;
                color: #fff;
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
                            <select name="auditerStatus">
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

        <script>
            var tipIndex = null;
            $('.icon_img').hover(function () {
                var tip = $(this).attr('text')
                tipIndex = layer.tips(tip, this)
            }, function () {
                layer.close(tipIndex)
            });

            //表格显示顺序
            var colShowObj = {
                itemNo: {field: 'itemNo', title: '立项编号', sort: true, hide: false},
                itemType: {
                    field: 'itemType', title: '立项类型', sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['MANAGE_ITEM_TYPE']['object'][d.itemType] || '';
                    }
                },
                itemContent: {
                    field: 'itemContent', title: '立项内容', sort: true, hide: false
                },
                itemAmount: {field: 'itemAmount', title: '立项金额', sort: true, hide: false},
                approvaler: {
                    field: 'approvaler', title: '审批人', sort: true, hide: false, templet: function (d) {
                        return d.approvalerName || '';
                    }
                },
                auditerStatus: {
                    field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
                        var str = '';
                        if (d.auditerStatus == '0') {
                            str = '<span style="color: orange;">待审批</span>';
                        } else if (d.auditerStatus == '1') {
                            str = '<span style="color: green;">批准</span>';
                        } else if (d.auditerStatus == '2') {
                            str = '<span style="color: red;">不批准</span>';
                        }
                        return str;
                    }
                },
                approvalTime: {
                    field: 'approvalTime', title: '审批时间', sort: true, hide: false, templet: function (d) {
                        return format(d.approvalTime);
                    }
                },
                createTime: {
                    field: 'createTime', title: '创建时间', sort: true, hide: false, templet: function (d) {
                        return format(d.createTime);
                    }
                }
            }

            var TableUIObj = new TableUI('plb_manage_item');

            var dictionaryObj = {
                MANAGE_ITEM_TYPE: {}
            }
            var dictionaryStr = 'MANAGE_ITEM_TYPE';
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

            function initPage() {
                layui.use(['form', 'table', 'element', 'soulTable', 'eleTree', 'flow'], function () {
                    var form = layui.form,
                        table = layui.table,
                        element = layui.element,
                        soulTable = layui.soulTable,
                        eleTree = layui.eleTree,
                        layFlow = layui.flow;

                    var tableIns = null;
                    TableUIObj.init(colShowObj, function(){
                        $('.no_data').hide();
                        $('.table_box').show();
                        tableShow();
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
                                    defaultExpandAll: true,
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

                    //触发行单击事件
                    table.on('row(mtlPlanTable)', function(obj){
                        showDetail(obj.data.itemId);
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

                    table.on('row(itemDetailsTable)', function(obj){
                        var listId = obj.data.listId;
                        var maxVal = 100;
                        layer.open({
                            type: 1,
                            title: '跟踪详情',
                            area: ['100%', '100%'],
                            btn: ['添加详情', '关闭'],
                            btnAlign: 'c',
                            content: '<div id="scrollBox" style="height: 100%;"></div>',
                            success: function(){
                                var loadIndex = layer.load();
                                getTrackData(listId, function (cumulativeProgress) {
                                    maxVal = 100 - cumulativeProgress;
                                    layer.close(loadIndex);
                                });
                            },
                            yes: function() {
                                layer.open({
                                    type: 1,
                                    title: '添加详情',
                                    area: ['70%', '70%'],
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div id="trackForm" class="layui-form" style="padding: 10px 80px 10px 10px;">',
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">进展状态</label>' +
                                        '<div class="layui-input-block">' +
                                        '<input type="radio" name="doStatus" value="1" title="正常" checked>' +
                                        '<input type="radio" name="doStatus" value="2" title="延迟">' +
                                        '<input type="radio" name="doStatus" value="3" title="完成">' +
                                        '<input type="radio" name="doStatus" value="4" title="暂停">' +
                                        '<input type="radio" name="doStatus" value="5" title="关闭">' +
                                        '</div>' +
                                        '</div>',
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">本次进展</label>' +
                                        '<div class="layui-input-block">' +
                                        '<input type="text" name="thisProgress" maxVal="' + maxVal + '" placeholder="请输入本次进展" autocomplete="off" class="layui-input input_num">' +
                                        '</div>' +
                                        '</div>',
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">进展描述</label>' +
                                        '<div class="layui-input-block">' +
                                        '<textarea name="progressDesc" placeholder="请输入进展描述" class="layui-textarea"></textarea>' +
                                        '</div>' +
                                        '</div>',
                                        '                   <div class="layui-form-item">' +
                                        '                       <label class="layui-form-label">成果附件</label>' +
                                        '                       <div class="layui-input-block">' +
                                        '                           <div class="file_module">' +
                                        '                               <div id="fileContent" class="file_content"></div>' +
                                        '                               <div class="file_upload_box">' +
                                        '                                   <a href="javascript:;" class="open_file">' +
                                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>选择文件</span>' +
                                        '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                                        '                                   </a>' +
                                        '                                   <div class="progress">' +
                                        '                                       <div class="bar"></div>' +
                                        '                                   </div>' +
                                        '                                   <div class="bar_text"></div>' +
                                        '                               </div>' +
                                        '                           </div>' +
                                        '                       </div>' +
                                        '                   </div>',
                                        '<div class="layui-form-item">' +
                                        '<label class="layui-form-label">异常原因</label>' +
                                        '<div class="layui-input-block">' +
                                        '<textarea name="unusualReason" placeholder="请输入异常原因" class="layui-textarea"></textarea>' +
                                        '</div>' +
                                        '</div>',
                                        '                   <div class="layui-form-item">' +
                                        '                       <label class="layui-form-label" style="width: 95px;padding-left: 0;">异常支撑材料</label>' +
                                        '                       <div class="layui-input-block">' +
                                        '                           <div class="file_module">' +
                                        '                               <div id="fileContentFP" class="file_content"></div>' +
                                        '                               <div class="file_upload_box">' +
                                        '                                   <a href="javascript:;" class="open_file">' +
                                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>选择文件</span>' +
                                        '                                   <input type="file" multiple id="fileuploadFP" data-url="/upload?module=planbudget" name="file">' +
                                        '                                   </a>' +
                                        '                                   <div class="progress">' +
                                        '                                       <div class="bar"></div>' +
                                        '                                   </div>' +
                                        '                                   <div class="bar_text"></div>' +
                                        '                               </div>' +
                                        '                           </div>' +
                                        '                       </div>' +
                                        '                   </div>',
                                        '</div>'].join(''),
                                    success: function () {
                                        form.render();

                                        fileuploadFn('#fileupload', $('#fileContent'));
                                        fileuploadFn('#fileuploadFP', $('#fileContentFP'));
                                    },
                                    yes: function(index) {
                                        var loadIndex = layer.load();

                                        var baseData = {
                                            projId: obj.data.projId,
                                            itemId: listId,
                                            doStatus: $('[name="doStatus"]:checked', $('#trackForm')).val(),
                                            thisProgress: $('[name="thisProgress"]', $('#trackForm')).val(),
                                            progressDesc: $('[name="progressDesc"]', $('#trackForm')).val(),
                                            unusualReason: $('[name="unusualReason"]', $('#trackForm')).val()
                                        }

                                        // 成果材料
                                        var attachmentId = '';
                                        var attachmentName = '';
                                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                            attachmentName += $('#fileContent a').eq(i).attr('name');
                                        }
                                        baseData.attachmentId = attachmentId;
                                        baseData.attachmentName = attachmentName;

                                        // 异常支撑材料
                                        var unusualAttachmentId = '';
                                        var unusualAttachmentName = '';
                                        for (var i = 0; i < $('#fileContentFP .dech').length; i++) {
                                            unusualAttachmentId += $('#fileContentFP .dech').eq(i).find('input').val();
                                            unusualAttachmentName += $('#fileContentFP a').eq(i).attr('name');
                                        }
                                        baseData.unusualAttachmentId = unusualAttachmentId;
                                        baseData.unusualAttachmentName = unusualAttachmentName;

                                        if (!baseData.thisProgress) {
                                            layer.close(loadIndex);
                                            layer.msg('请输入本次进展！', {icon: 0, time: 2000});
                                            return false;
                                        }

                                        if (!baseData.progressDesc) {
                                            layer.close(loadIndex);
                                            layer.msg('请输入进展描述！', {icon: 0, time: 2000});
                                            return false;
                                        }

                                        $.post('/PlbManageTrack/insert', baseData, function (res) {
                                            layer.close(loadIndex);
                                            if (res.flag) {
                                                layer.close(index);
                                                layer.msg('新增成功！', {icon: 1, time: 2000});
                                                getTrackData(listId);
                                            } else {
                                                layer.msg('新增失败！', {icon: 2, time: 2000});
                                            }
                                        });
                                    }
                                });
                            }
                        });

                        // 删除跟踪详情
                        $(document).on('click', '.del_btn', function(){
                            var $this = $(this);
                            layer.confirm('确定删除该条数据吗？', function (index) {
                                var trackId = $this.attr('trackId')
                                $.get('/PlbManageTrack/delete', {trackIds: trackId}, function(res) {
                                    layer.close(index);
                                    if (res.flag) {
                                        layer.msg('删除成功！', {icon: 1, time: 1500});
                                        getTrackData(listId);
                                    } else {
                                        layer.msg('删除失败！', {icon: 2, time: 1500});
                                    }
                                });
                            });
                        });
                    });

                    // 获取跟踪详情数据
                    function getTrackData(listId, fn) {
                        $('#scrollBox').html('<div id="scrollModule"><ul id="LAY_demo1" class="layui-timeline"></ul></div>');
                        var pageSize = 10;
                        layFlow.load({
                            elem: '#LAY_demo1', // 流加载容器
                            scrollElem: '#scrollModule', // 滚动条所在元素，一般不用填，此处只是演示需要。
                            done: function(page, next){ // 执行下一页的回调
                                $.get('/PlbManageTrack/queryByItemId', {listId: listId, page: page, pageSize: pageSize}, function(res) {
                                    var eleStr = '';

                                    res.data.forEach(function(item) {
                                        var doStatus = '';
                                        var progressStr = '';
                                        if (item.doStatus === '1') {
                                            doStatus = '<span class="layui-badge layui-bg-blue">正常</span>';
                                            progressStr = '<div class="layui-progress-bar layui-bg-blue" lay-percent="'+item.thisProgress+'%"></div>';
                                        } else if (item.doStatus === '2') {
                                            doStatus = '<span class="layui-badge layui-bg-orange">延迟</span>';
                                            progressStr = '<div class="layui-progress-bar layui-bg-orange" lay-percent="'+item.thisProgress+'%"></div>';
                                        } else if (item.doStatus === '3') {
                                            doStatus = '<span class="layui-badge layui-bg-green">完成</span>';
                                            progressStr = '<div class="layui-progress-bar layui-bg-green" lay-percent="'+item.thisProgress+'%"></div>';
                                        } else if (item.doStatus === '4') {
                                            doStatus = '<span class="layui-badge layui-bg-cyan">暂停</span>';
                                            progressStr = '<div class="layui-progress-bar layui-bg-cyan" lay-percent="'+item.thisProgress+'%"></div>';
                                        } else if (item.doStatus === '5') {
                                            doStatus = '<span class="layui-badge layui-bg-red">关闭</span>';
                                            progressStr = '<div class="layui-progress-bar layui-bg-red" lay-percent="'+item.thisProgress+'%"></div>';
                                        }

                                        var attachmentStr = '';
                                        if (item.attachments && item.attachments.length > 0) {
                                            var fileArr = item.attachments;
                                            var str = '';
                                            for (var i = 0; i < fileArr.length; i++) {
                                                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                                attachmentStr += '<a href="/download?' + encodeURI(deUrl) + '" style="display: block; text-decoration:none;">' + fileArr[i].attachName + '</a>';
                                            }
                                        }

                                        var str = '';
                                        if (item.unusualReason) {
                                            str += '<div class="label_item">' +
                                                '<div class="label_ttile"><span>异常原因：</span></div>' +
                                                '<div class="label_con"><span>' + item.unusualReason + '</span></div>' +
                                                '</div>';
                                        }

                                        if (item.unusualAttachments && item.unusualAttachments.length > 0) {
                                            var unusualStr = '';
                                            var fileArr = item.unusualAttachments;
                                            for (var i = 0; i < fileArr.length; i++) {
                                                var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                                var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                                unusualStr += '<a href="/download?' + encodeURI(deUrl) + '" style="display: block; text-decoration:none;">' + fileArr[i].attachName + '</a>';
                                            }

                                            str += '<div class="label_item">' +
                                                '<div class="label_ttile" style="float: left;"><span>异常材料：</span></div>' +
                                                '<div class="label_con">' + unusualStr + '</div>' +
                                                '</div>';
                                        }

                                        eleStr += '<li class="layui-timeline-item">' +
                                            '<i class="layui-icon layui-timeline-axis">&#xe63f;</i>' +
                                            '<div class="layui-timeline-content layui-text">' +
                                            '<h3 class="layui-timeline-title">' + new Date(item.ctreateTime).Format("yyyy年MM月dd日") + '<button type="button" trackId="'+item.trackId+'" class="layui-btn layui-btn-danger layui-btn-xs del_btn"><i class="layui-icon layui-icon-delete"></i></button></h3>' +
                                            '<div class="label_item">' +
                                            '<div class="label_ttile"><span>创建人：</span></div>' +
                                            '<div class="label_con"><span>' + (item.userName || '') + '</span></div>' +
                                            '</div>' +
                                            '<div class="label_item">' +
                                            '<div class="label_ttile"><span>本次进展：</span></div>' +
                                            '<div class="label_con">' +
                                            '<div class="layui-progress" lay-showPercent="yes">'+ progressStr+ '</div>'+
                                            '</div>' +
                                            '</div>' +
                                            '<div class="label_item">' +
                                            '<div class="label_ttile"><span>进展状态：</span></div>' +
                                            '<div class="label_con"><span>' + doStatus + '</span></div>' +
                                            '</div>' +
                                            '<div class="label_item">' +
                                            '<div class="label_ttile" style="float: left;"><span>进展描述：</span></div>' +
                                            '<div class="label_con"><pre>' + (item.progressDesc || '') + '</pre></div>' +
                                            '</div>' +
                                            '<div class="label_item">' +
                                            '<div class="label_ttile" style="float: left;"><span>成果附件：</span></div>' +
                                            '<div class="label_con">' + attachmentStr + '</div>' +
                                            '</div>' + str +
                                            '</div>' +
                                            '</li>';
                                    });

                                    var totalPage = Math.ceil(res.totleNum / pageSize);

                                    //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                                    next(eleStr, page < totalPage);

                                    if (fn) {
                                        var cumulativeProgress = 0;
                                        if (res.data.length > 0) {
                                            cumulativeProgress = res.data.cumulativeProgress;
                                        }
                                        fn(cumulativeProgress);
                                    }
                                });
                            }
                        });
                    }

                    // 渲染表格
                    function tableShow(projId) {
                        projId = projId || '';
                        var cols = [{type: 'numbers'}].concat(TableUIObj.cols);

                        var option = {
                            elem: '#mtlPlanTable',
                            url: '/PlbManageItem/queryAll',
                            toolbar: true,
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
                            request: {
                                limitName: 'pageSize'
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data'
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

                    /**
                     * 详情
                     * @param itemId
                     */
                    function showDetail(itemId) {
                        $.get('/PlbManageItem/queryByItemId', {itemId: itemId}, function(res) {
                            if (res.flag) {
                                var data = res.data;
                                layer.open({
                                    type: 1,
                                    title: '立项详情',
                                    area: ['100%', '100%'],
                                    btn: ['关闭'],
                                    btnAlign: 'c',
                                    content: ['<div class="layui-collapse">\n' ,
                                        /* region 立项项目基础信息 */
                                        '  <div class="layui-colla-item">\n' +
                                        '    <h2 class="layui-colla-title">立项信息</h2>\n' +
                                        '    <div class="layui-colla-content layui-show">' +
                                        '       <form class="layui-form" id="baseForm" lay-filter="baseForm">',
                                        /* region 第一行 */
                                        '           <div class="layui-row">' +
                                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                        '                   <div class="layui-form-item">\n' +
                                        '                       <label class="layui-form-label form_label">立项编号<span class="field_required">*</span></label>\n' +
                                        '                       <div class="layui-input-block form_block">\n' +
                                        '                       <input type="text" readonly name="itemNo" autocomplete="off" class="layui-input">\n' +
                                        '                       </div>\n' +
                                        '                   </div>' +
                                        '               </div>' +
                                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                        '                   <div class="layui-form-item">\n' +
                                        '                       <label class="layui-form-label form_label">立项类型<span class="field_required">*</span></label>\n' +
                                        '                       <div class="layui-input-block form_block">\n' +
                                        '                       <input type="text" readonly name="itemType" autocomplete="off" class="layui-input">\n' +
                                        '                       </div>\n' +
                                        '                   </div>' +
                                        '               </div>' +
                                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                        '                   <div class="layui-form-item">\n' +
                                        '                       <label class="layui-form-label form_label">立项金额<span class="field_required">*</span></label>\n' +
                                        '                       <div class="layui-input-block form_block">\n' +
                                        '                       <input type="text" readonly name="itemAmount" autocomplete="off" class="layui-input">\n' +
                                        '                       </div>\n' +
                                        '                   </div>' +
                                        '               </div>' +
                                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                        '                   <div class="layui-form-item">\n' +
                                        '                       <label class="layui-form-label form_label">审批人<span class="field_required">*</span></label>\n' +
                                        '                       <div class="layui-input-block form_block">\n' +
                                        '                       <input type="text" readonly id="approvaler" name="approvaler" autocomplete="off" class="layui-input">\n' +
                                        '                       </div>\n' +
                                        '                   </div>' +
                                        '               </div>' +
                                        '           </div>' ,
                                        /* endregion */
                                        /* region 第二行 */
                                        '           <div class="layui-row">' +
                                        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                                        '                   <div class="layui-form-item">\n' +
                                        '                       <label class="layui-form-label form_label">立项内容<span class="field_required">*</span></label>\n' +
                                        '                       <div class="layui-input-block form_block">\n' +
                                        '                       <textarea readonly name="itemContent" placeholder="请输入立项内容" class="layui-textarea"></textarea>\n' +
                                        '                       </div>\n' +
                                        '                   </div>' +
                                        '               </div>' +
                                        '           </div>' ,
                                        /* endregion */
                                        '       </form>' +
                                        '    </div>\n' +
                                        '  </div>\n' ,
                                        /* endregion */
                                        /* region 立项明细 */
                                        '  <div class="layui-colla-item">\n' +
                                        '    <h2 class="layui-colla-title">立项明细</h2>\n' +
                                        '    <div class="layui-colla-content layui-show">' +
                                        '       <div id="itemDetailsTableModule">' +
                                        '           <table id="itemDetailsTable" lay-filter="itemDetailsTable"></table>' +
                                        '      </div>' +
                                        '    </div>\n' +
                                        '  </div>\n' ,
                                        /* endregion */
                                        '</div>'].join(''),
                                    success: function () {
                                        element.render();

                                        form.render();

                                        form.val("baseForm", data);

                                        // 立项类型
                                        $('[name="itemType"]', $('#baseForm')).val(dictionaryObj['MANAGE_ITEM_TYPE'].object[data.itemType]);

                                        // 审批人
                                        $('#approvaler').val((data.approvalerName || '').replace(/,$/, ''));

                                        // 立项明细
                                        var plbManageItemListList = data.plbManageItemListList || [];

                                        table.render({
                                            elem: '#itemDetailsTable',
                                            data: plbManageItemListList,
                                            cols: [[
                                                {type: 'numbers'},
                                                {
                                                    field: 'budgetItemId', title: '经营预算科目', templet: function (d) {
                                                        return d.budgetItemName || '';
                                                    }
                                                },
                                                {field: 'manageTarNum', title: '管理目标数量'},
                                                {field: 'manageTarPrice', title: '管理目标单价'},
                                                {field: 'manageTarAmount', title: '管理目标金额'},
                                                {field: 'optTarNum', title: '优化目标数量'},
                                                {field: 'optTarPrice', title: '优化目标单价'},
                                                {field: 'optTarAmount', title: '优化目标金额'},
                                                {field: 'estimatedIncome', title: '预计收入'}
                                            ]]
                                        });
                                    },
                                    yes: function (index) {
                                        layer.close(index);
                                    }
                                });
                            } else {
                                layer.msg('获取数据失败！', {icon: 2, time: 2000});
                            }
                        });
                    }

                    //监听键盘事件，部门排序只能输入数字
                    $(document).on('keypress', '.input_num', function (e) {
                        var key = window.event ? e.keyCode : e.which;
                        if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                            return false;
                        }
                    });
                    // 监听输入内容
                    $(document).on('input propertychange', '.input_num', function () {
                        var value = parseInt($(this).val());

                        if (isNaN(value)) {
                            value = '';
                        } else {
                            var maxVal = $(this).attr('maxVal');
                            if (value > maxVal) {
                                value = maxVal
                            }
                        }

                        $(this).val(value);
                    });
                });
            }
        </script>
    </body>
</html>
