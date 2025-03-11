<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/6
  Time: 10:27
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
    <title>RBS资源库</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20210527.1"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210527.1"></script>

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

        .refresh_no_btn {
            display: none;
            margin-left: 8%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }

        .export_moudle {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            width: 120px;
            padding: 10px;
            background-color: #fff;
            text-align: left;
            color: #222;
            box-shadow: 0 0px 1px 0px rgb(0 0 0 / 50%);
            opacity: 1 !important;
        }

        .export_moudle > p:hover {
            cursor: pointer;
            color: #1E9FFF;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId">
    <div class="wrapper">
        <div class="wrap_left">
            <h2>RBS资源库</h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="RBS名称" autocomplete="off"
                       class="layui-input"/>
            </div>
            <div class="layui-btn-container" style="height: 30px; text-align: center;">
                <input type="hidden" id="wbsId">
                <button type="button" class="layui-btn layui-btn-sm layui-btn-normal plan" edit="1">新建</button>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-warm plan" edit="2">编辑</button>
                <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" id="delPlan">删除</button>
            </div>
            <div class="tree_module" style="top: 130px">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="mtlNo" placeholder="材料编码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="mtlName" placeholder="材料名称" autocomplete="off" class="layui-input">
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
                <div class="layui-col-xs4" style="margin: 3px 0 0 10px;text-align: left;">
                    <button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>
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
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbarHead">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal noUse" lay-event="add">新建</button>
        <button class="layui-btn layui-btn-sm layui-btn-warm noUse" lay-event="edit">编辑</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger noUse" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm noUse" lay-event="submit" style="margin-left:10px;">提交审批</button>
        <button class="layui-btn layui-btn-sm noUse" lay-event="import" style="margin-left:10px;">
            <img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">
            导入
        </button>
        <button class="layui-btn layui-btn-sm noUse" lay-event="export" style="margin-left:10px;">
            <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">
            导出
        </button>
        <div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>
    </div>
</script>

<script>
    // 当前选中树节点
    var currentNode = null;

    var leftTreeData = null;

    var tipIndex = null;
    $('.icon_img').on('hover',function () {
        var tip = $(this).attr('text');
        tipIndex = layer.tips(tip, this);
    }, function () {
        layer.close(tipIndex);
    });

    // 表格显示顺序
    var colShowObj = {
        mtlNo: {field: 'mtlNo', title: '材料编码', minWidth: 120, sort: true, hide: false},
        mtlName: {field: 'mtlName', title: '材料名称', minWidth: 120, sort: true, hide: false},
        mtlStandard: {
            field: 'mtlStandard', title: '材料规格', minWidth: 120, sort: true, hide: false
        },
        mtlValuationUnit:{field: 'mtlValuationUnit', title: '单位', width: 100,templet: function(d){
            return '<span valuationUnit="'+(d.mtlValuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '')+'</span>';
        }},
        auditerStatus: {
            field: 'auditerStatus', title: '审批状态', minWidth: 120, sort: true, hide: false, templet: function (d) {
                if (d.auditerStatus == '1') {
                    return '<span style="color: orange">审批中</span>'
                } else if (d.auditerStatus == '2') {
                    return '<span style="color: green">批准</span>'
                } else if (d.auditerStatus == '3') {
                    return '<span style="color: red">不批准</span>'
                } else {
                    return '未提交'
                }
            }
        },
        mtlDesc: {field: 'mtlDesc', title: '备注', minWidth: 120, sort: true, hide: false}
    }
    var TableUIObj = new TableUI('plb_mtl_library');

    // 获取数据字典数据
    var dictionaryObj = {
        MTL_QUALITY: {},
        MTL_TYPE: {},
        MTL_MEASURE_METHOD: {},
        MTL_VALUATION_UNIT: {},
        RBS_TYPE: {},
        RBS_CATEGORY: {},
        CBS_UNIT: {},
        CONTROL_MODE: {}
    }
    var dictionaryStr = 'MTL_QUALITY,MTL_TYPE,MTL_MEASURE_METHOD,MTL_VALUATION_UNIT,RBS_TYPE,RBS_CATEGORY,CONTROL_MODE,CBS_UNIT';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    if(dict=="CONTROL_MODE"||dict=="CBS_UNIT"){
                        dictionaryObj[dict]['str'] += '<option value="">请选择</option>';
                    }
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
        layui.use(['form', 'table', 'soulTable', 'eleTree', 'xmSelect'], function () {
            var layForm = layui.form,
                layTable = layui.table,
                xmSelect = layui.xmSelect,
                soulTable = layui.soulTable,
                eleTree = layui.eleTree;

            var tableObj = null;
            TableUIObj.init(colShowObj, function () {
                tableInit();
            });

            layForm.render();

            /* region 修改左侧项目名称 */
            var searchTimer = null
            $('#search_project').on('input propertychange', function () {
                clearTimeout(searchTimer)
                searchTimer = null
                var val = $(this).val()
                searchTimer = setTimeout(function () {
                    projectLeft(val)
                }, 300)
            })
            $('.search_icon').on('click', function () {
                projectLeft($('#search_project').val())
            })
            /* endregion */

            projectLeft();

            /**
             * 左侧材料信息列表
             * @param mtlName 材料名称
             */
            function projectLeft(rbsName) {
                rbsName = rbsName ? rbsName : ''
                var leftTree = eleTree.render({
                    elem: '#leftTree',
                    url: '/plbRbs/selectAll?parentId=0&_=' + new Date().getTime() + '&rbsName=' + rbsName,
                    highlightCurrent: true,
                    showLine: true,
                    defaultExpandAll: true,
                    lazy: true,
                    request: {
                        key: 'rbsId',
                        name: 'rbsName',
                        children: "childList",
                    },
                    response: {
                        statusName: 'flag',
                        statusCode: true,
                        dataName: "data"
                    },
                    load: function (data, callback) {
                        $.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
                            callback(res.data);//点击节点回调
                        })
                    }
                });
            }

            // 树节点点击事件
            eleTree.on("nodeClick(leftTree)", function (d) {
                currentNode = d.data.currentData;
                tableInit({rbsId: currentNode.rbsId});
            });

            // 删除树
            $('#delPlan').on('click',function () {
                if (!currentNode) {
                    layer.msg('请选择需要删除的节点!', {icon: 0});
                    return false;
                }
                if (currentNode.parentId===0) {
                    layer.msg('一级节点不可删除!', {icon: 0});
                    return false;
                }

                layer.confirm('确定删除该节点吗？', function (index) {
                    $.post('/plbRbs/delete', {rbsIds: currentNode.rbsId}, function (res) {
                        layer.close(index);
                        if (res.flag) {
                            layer.msg('删除成功！', {icon: 1});
                            location.reload();
                        } else {
                            layer.msg('删除失败！', {icon: 2});
                        }
                    });
                });
            });

            $('.plan').on('click',function () {
                var type = $(this).attr('edit');
                var title = '';
                var url = '';
                if (type == 1) {
                    title = '新增项目';
                    url = '/plbRbs/insert';
                } else if (type == 2) {
                    title = '编辑项目';
                    url = '/plbRbs/update';
                }
                if (type == 1 && !currentNode) {
                    layer.msg('请选择左侧一项进行新建！', {icon: 0, time: 2000});
                    return false;
                }
                if (type == 2 && !currentNode) {
                    layer.msg('请选择左侧一项进行编辑！', {icon: 0, time: 2000});
                    return false;
                }
                var cbsSelectTree = null;
                //var parentLevelTree = null;
                var rbsSelectTree = null;
                layer.open({
                    type: 1,
                    title: title,
                    area: ['100%', '100%'],
                    btn: ['保存', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
                        '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                        /* region 第一行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">RBS编号<span field="rbsNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" readonly name="rbsNo" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px" id="parent">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">所属上级<span field="parentId" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="hidden" id="parentId" name="parentId" autocomplete="off" class="layui-input">' +
                        /*'<div id="parentId" class="xm-select-demo"></div>'+*/
                        '<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第二行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">RBS名称<span field="rbsName" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="rbsName" id="rbsName" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">CBS</label>' +//<span field="cbsId" class="field_required">*</span>
                        '<div class="layui-input-block form_block">' +
                        '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第三行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">控制方式<!--<span field="controlMode" class="field_required">*</span>--></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="controlMode" id="controlMode"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">RBS单位</label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="rbsUnit"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第四行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">说明</label>' +//<span field="remarks" class="field_required">*</span>
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="remarks" id="remarks" autocomplete="off" class="layui-input">' +
                        /*'<textarea name="remarks" class="layui-textarea"></textarea>' +*/
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        '</form>',
                        '</div>'].join(''),
                    success: function () {
                        /*if (type == 2) {

                        } else */if (type == 1) {
                            // 获取自动编号
                            getAutoNumber({autoNumber: 'plbRbs'}, function (res) {
                                $('input[name="rbsNo"]', $('#baseForm')).val(res);
                            });
                            $('.refresh_no_btn').show().on('click', function () {
                                getAutoNumber({autoNumber: 'plbRbs'}, function (res) {
                                    $('input[name="rbsNo"]', $('#baseForm')).val(res);
                                });
                            });

                            layForm.render('select');
                        }

                        if(type == 2&&currentNode.parentId===0){ //一级节点不可编辑
                            $("#rbsName").attr("readonly","readonly");
                            //$("#parent").hide();
                            //$("#parentId").attr("disabled","disabled");
                            layForm.render()
                        }
                        $('select[name="rbsUnit"]').append(dictionaryObj['CBS_UNIT']['str']);
                        $('select[name="controlMode"]').append(dictionaryObj['CONTROL_MODE']['str']);



                        // 获取CBS数据
                        /*$.get('/plbCbsType/getAllList', function (res) {
                            var cbsTreeData = res.data;

                            cbsSelectTree = xmSelect.render({
                                el: '#cbsSelectTree',
                                iconfont: {
                                    parent: 'hidden' // 父节点隐藏图标
                                },
                                radio: true,
                                filterable: true,
                                clickClose: true,
                                name: 'cbsId',
                                disabled: type == 3,
                                tree: {
                                    show: true,
                                    strict: false,
                                    expandedKeys: [-1],
                                },
                                prop: {
                                    name: 'cbsName',
                                    value: 'cbsId',
                                    children: "childList"
                                },
                                data: cbsTreeData
                            });
                            if (type == 2) {
                                cbsSelectTree.setValue([currentNode.cbsId]);
                            }
                        });
                        var filterId = '';
                        var currentParentId = '';
                        if (type == 2) {
                            filterId = currentNode.rbsId;
                            currentParentId = currentNode.parentId;
                        }*/

                        var cbsTreeData = []

                        // 获取CBS数据
                        $.get('/plbCbsType/getAllList', function (res) {
                            cbsTreeData = res.data;

                            cbsSelectTree = xmSelect.render({
                                el: '#cbsSelectTree',
                                content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                                    '<input type="text" style="box-sizing: border-box;" class="layui-input" id="cbsSelect">' +
                                    '</div>' +
                                    '<div style="padding-top: 30px;" id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                name: 'cbsId',
                                //disabled: type == 3,
                                prop: {
                                    name: 'cbsName',
                                    value: 'cbsId'
                                }
                            });

                            var cbsSearchTimer = null;
                            $('#cbsSelect').on('input propertychange', function () {
                                clearTimeout(cbsSearchTimer);
                                cbsSearchTimer = null;
                                var val = $(this).val();
                                cbsSearchTimer = setTimeout(function () {
                                    var cbsTreeList = deepClone(cbsTreeData);
                                    filterCbsTree(cbsTreeList, val)
                                    initCbsTree(cbsTreeList)
                                }, 300);
                            });

                            initCbsTree(cbsTreeData);

                            function initCbsTree(cbsTreeData) {
                                eleTree.render({
                                    elem: '#cbsTree',
                                    data: cbsTreeData,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    accordion: true,
                                    request: {
                                        name: 'cbsName',
                                        children: "childList"
                                    }
                                });
                            }

                            // 树节点点击事件
                            eleTree.on("nodeClick(cbsTree)", function (d) {
                                var currentData = d.data.currentData;
                                //if (!currentData.childList || currentData.childList.length == 0) {
                                    var obj = {
                                        cbsName: currentData.cbsName,
                                        cbsId: currentData.cbsId
                                    }
                                    cbsSelectTree.setValue([obj]);

                                    layForm.render('select');
                                //}
                            });

                            if(type==1&&currentNode&&currentNode.controlMode=='01'){
                                var cbsObj = {
                                    cbsName: currentNode.cbsName||'',
                                    cbsId: currentNode.cbsId
                                }
                                cbsSelectTree.setValue([cbsObj]);

                                layForm.render('select');
                            }
                            if(type==2&&currentNode){
                                var cbsObj = {
                                    cbsName: currentNode.cbsName||'',
                                    cbsId: currentNode.cbsId
                                }
                                cbsSelectTree.setValue([cbsObj]);

                                layForm.render('select');
                            }
                        })
                        /*RBS开始*/
                        rbsSelectTree = xmSelect.render({
                            el: '#rbsSelectTree',
                            content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                                '<input type="text" style="box-sizing: border-box;" class="layui-input" id="rbsSelect">' +
                                '</div>' +
                                '<div style="padding-top: 30px;" id="rbsTree" class="eleTree" lay-filter="rbsTree"></div>',
                            name: 'rbsId',
                            disabled: type == 2&&currentNode.parentId==0,
                            prop: {
                                name: 'rbsName',
                                value: 'rbsId'
                            }
                        });

                        rbsTree()


                        var rbsSearchTimer = null;
                        $('#rbsSelect').on('input propertychange', function () {
                            clearTimeout(rbsSearchTimer);
                            rbsSearchTimer = null;
                            var val = $(this).val();
                            rbsSearchTimer = setTimeout(function () {
                                rbsTree(val,'1')
                            }, 300);
                        });

                        function rbsTree(parentId,type){
                            var obj = {};
                            if(type == '1'){
                                obj.rbsName=parentId?parentId:'';
                            }else {
                                obj.parentId=parentId?parentId:'0';
                            }
                            // 获取RBS数据
                            $.get('/plbRbs/selectAll',obj, function (res) {
                                var rbsTreeData = res.data || [];

                                eleTree.render({
                                    elem: '#rbsTree',
                                    data: rbsTreeData,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    accordion: true,
                                    lazy: true,
                                    request: {
                                        name: 'rbsName',
                                        children: "childList"
                                    },
                                    load: function (data, callback) {
                                        $.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
                                            callback(res.data);//点击节点回调
                                        })
                                    }
                                });

                            });
                        }


                        // 树节点点击事件
                        eleTree.on("nodeClick(rbsTree)", function (d) {
                            var currentData = d.data.currentData;
                            $('#parentId').val(currentData.rbsId);
                            //$('#rbsSelectTree').attr('_cbsId',currentData.rbsId)

                            //if (!currentData.childList || currentData.childList.length == 0) {
                                var obj = {
                                    rbsName: currentData.rbsName,
                                    rbsId: currentData.rbsId
                                }
                                rbsSelectTree.setValue([obj]);

                                layForm.render('select');
                            //}
                        });


                        /*RBS结束*/


                          if (type == 1) {
                            $('#parentId').val(currentNode.rbsId);

                              rbsSelectTree.setValue([{rbsId: currentNode.rbsId, rbsName: currentNode.rbsName || ''}])
                            if (currentNode.controlMode=='01') {
                                //$('select[name="rbsUnit"]', $('#baseForm')).val(currentNode.rbsUnit).attr('disabled', true);
                                $('[name="controlMode"]').val(currentNode.controlMode).attr('disabled','disabled');
                                $('[name="rbsUnit"]').val(currentNode.rbsUnit).attr('disabled','disabled');
                                layForm.render();
                            }

                            layForm.render('select');
                        }else if (type == 2) {
                            layForm.val("baseForm", currentNode);
                            if (currentNode) {
                                rbsSelectTree.setValue([{rbsId: currentNode.parentId, rbsName: currentNode.parentName || ''}])
                                $('[name="controlMode"]').val(currentNode.controlMode)
                                $('[name="rbsUnit"]').val(currentNode.rbsUnit)
                                if(currentNode&&currentNode.parentControlMode=='01'&&currentNode.parentId!=0){
                                    $('[name="controlMode"]').attr('disabled','disabled');
                                    $('[name="rbsUnit"]').attr('disabled','disabled');
                                    layForm.render('select');
                                }else{
                                    $('[name="controlMode"]').removeAttr('disabled','disabled');
                                    $('[name="rbsUnit"]').removeAttr('disabled','disabled');
                                    layForm.render('select');
                                }
                                layForm.render('select');
                            }
                            layForm.render();
                        }

                        /*getParentTree('0', filterId, currentParentId, function(data) {
                            parentLevelTree = xmSelect.render({
                                el: '#parentId',
                                iconfont: {
                                    parent: 'hidden' // 父节点隐藏图标
                                },
                                radio: true,
                                filterable: true,
                                clickClose: true,
                                name: 'parentId',
                                prop: {
                                    name: 'rbsName',
                                    value: 'rbsId',
                                    children: "childList"
                                },
                                tree: {
                                    show: true,
                                    strict: false,
                                    expandedKeys: [-1],
                                    lazy: true,
                                    load: function(item, cb){
                                        getParentTree(item.rbsId, filterId, currentParentId, function(data) {
                                            cb(data);
                                        });
                                    }
                                },
                                data: data,
                                on: function (data) {
                                    var arr = data.arr;

                                    if (arr.length > 0) {
                                        var node = arr[0];
                                        if (node.rbsUnit) {
                                            $('select[name="rbsUnit"]', $('#baseForm')).val(node.rbsUnit).attr('disabled', true);
                                        }
                                    } else {
                                        $('select[name="rbsUnit"]', $('#baseForm')).attr('disabled', false);
                                    }
                                    layForm.render();
                                }
                            });

                            if (/!*type == 2 && *!/currentNode&&currentNode.parentId > 0) {
                                parentLevelTree.setValue([{rbsId: currentNode.parentId, rbsName: currentNode.parentName || ''}])
                                if (type == 1 && currentNode.parentId > 0) {
                                    cbsSelectTree.setValue([currentNode.cbsId]);
                                    $('#controlMode').val(currentNode.controlMode);
                                    layForm.render();
                                }
                            }
                        });

                        function getParentTree (parentId, filterId, currentParentId, callback) {
                            parentId = parentId || '';
                            currentParentId = currentParentId || '';
                            $.get('/plbRbs/selectAll', {parentId: parentId}, function (res) {
                                var newData = []
                                res.data.forEach(function(item) {
                                    if (item.rbsId != filterId) {
                                        if (item.rbsId == currentParentId) {
                                            item.selected = true
                                        }
                                        if (!item.isLeaf) {
                                            item.childList = []
                                        }
                                        newData.push(item);
                                    }
                                });
                                if (callback) {
                                    callback(newData);
                                }
                            });
                        }*/



                        layForm.render();
                    },
                    yes: function (index) {
                        var loadIndex = layer.load();

                        var datas = $('#baseForm').serializeArray();
                        var dataObj = {}
                        datas.forEach(function (item) {
                            dataObj[item.name] = item.value;
                        });

                        dataObj.controlMode = $('[name="controlMode"]').val()


                        dataObj.rbsUnit = $('select[name="rbsUnit"]').val()
                        //dataObj.parentId = $() || 0
                        // 判断必填项
                        var requiredFlag = false;
                        $('#baseForm').find('.field_required').each(function () {
                            var field = $(this).attr('field');
                            if(field=="parentId"){
                                if(type != 2) { //一级节点不可编辑
                                    if(dataObj.parentId===0){
                                        layer.msg('请选择所属上级！', {icon: 0, time: 2000});
                                        requiredFlag = true;
                                        return false;
                                    }
                                }
                            }else if(field && !dataObj[field] && dataObj[field] != '0'){
                                var fieldName = $(this).parent().text().replace('*', '');
                                layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
                                requiredFlag = true;
                                return false;
                            }
                        });
                        if (requiredFlag) {
                            layer.close(loadIndex);
                            return false;
                        }

                        if(type == 1){
                            delete dataObj.rbsId;
                        }

                        if (type == 2) {
                            dataObj.rbsId = currentNode.rbsId
                        }

                        $.ajax({
                            url: url,
                            data: JSON.stringify(dataObj),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            success: function (res) {
                                layer.close(loadIndex);
                                if (res.flag) {
                                    layer.msg('保存成功！', {icon: 1});
                                    layer.close(index);
                                    projectLeft();
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        });
                    }
                });

            });

            // 监听排序事件
            layTable.on('sort(tableObj)', function (obj) {
                var param = {
                    orderbyFields: obj.field,
                    orderbyUpdown: obj.type
                }

                TableUIObj.update(param, function () {
                    tableInit({rbsId: currentNode.rbsId});
                });
            });
            // 监听筛选列
            var checkboxTimer = null;
            layForm.on('checkbox()', function (data) {
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
            // 普通表格头部工具条事件监听
            layTable.on('toolbar(tableObj)', function (obj) {
                var checkStatus = layTable.checkStatus(obj.config.id);
                switch (obj.event) {
                    case 'add':
                        if (!currentNode) {
                            layer.msg('请选择左侧节点！', {icon: 0});
                            return false;
                        }
                        newOrEdit(1);
                        break;
                    case 'edit':
                        if (checkStatus.data.length != 1) {
                            layer.msg('请选择一项！', {icon: 0});
                            return false;
                        }

                        $.get('/plbMtlLibrary/queryById', {mtlLibId: checkStatus.data[0].mtlLibId}, function (res) {
                            if (res.flag) {
                                newOrEdit(2, res.data);
                            } else {
                                layer.msg('信息获取失败！', {icon: 0});
                            }
                        });
                        break;
                    case 'del':
                        if (checkStatus.data.length == 0) {
                            layer.msg('请选择需要删除的数据！', {icon: 0});
                            return false
                        }
                        var mtlLibIds = ''
                        checkStatus.data.forEach(function (v) {
                            mtlLibIds += v.mtlLibId + ',';
                        });
                        layer.confirm('确定删除该条数据吗？', function (index) {
                            $.post('/plbMtlLibrary/delete', {mtlLibIds: mtlLibIds}, function (res) {
                                layer.close(index);
                                if (res.flag) {
                                    layer.msg('删除成功！', {icon: 1});
                                    tableObj.config.where._ = new Date().getTime();
                                    tableObj.reload();
                                } else {
                                    layer.msg('删除失败！', {icon: 2});
                                }
                            });
                        });
                        break;
                    case 'export':
                        $('.export_moudle').show();
                        break;
                }
            });

            /**
             * 加载表格方法
             */
            function tableInit(params) {
                var searchObj = getSearchObj();
                searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
                searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                var cols = [{checkbox: true}].concat(TableUIObj.cols);

                params = params || {}

                var where = $.extend({}, searchObj, params);

                var option = {
                    elem: '#tableObj',
                    url: '/plbMtlLibrary/queryByParentId',
                    toolbar: '#toolbarHead',
                    cols: [cols],
                    defaultToolbar: ['filter'],
                    height: 'full-80',
                    page: {
                        limit: TableUIObj.onePageRecoeds,
                        limits: [10, 20, 30, 40, 50]
                    },
                    where: where,
                    autoSort: false,
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
                    done: function () {
                        //增加拖拽后回调函数
                        soulTable.render(this, function () {
                            TableUIObj.dragTable('tableObj')
                        });

                        if (TableUIObj.onePageRecoeds != this.limit) {
                            TableUIObj.update({onePageRecoeds: this.limit});
                        }
                        var _rbsId = currentNode?currentNode.rbsId:''
                        $.ajax({
                            url: '/plbMtlLibrary/canCreate?rbsId='+_rbsId,
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                if(!res.flag){
                                    $('.noUse').css({
                                        'cursor': 'not-allowed',
                                        'background': '#C1C1C1'
                                    }).attr("disabled","disabled");
                                }
                            }
                        });
                    }
                }

                if (TableUIObj.orderbyFields) {
                    option.initSort = {
                        field: TableUIObj.orderbyFields,
                        type: TableUIObj.orderbyUpdown
                    }
                }

                tableObj = layTable.render(option);
            }

            /**
             * 新增、编辑方法
             * @param type 类型(1-新增，2-编辑)
             * @param data 编辑时的信息
             */
            function newOrEdit(type, data) {
                var title = '';
                var url = '';
                if (type == 1) {
                    title = '新建';
                    url = '/plbMtlLibrary/add';
                } else if (type == 2) {
                    title = '编辑';
                    url = '/plbMtlLibrary/update';
                }

                layer.open({
                    type: 1,
                    title: title,
                    area: ['80%', '90%'],
                    btn: ['保存', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
                        '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                        /* region 第一行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">材料编号<!--<span field="mtlNo" class="field_required">*</span>--><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" readonly name="mtlNo" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">材料名称<span field="mtlName" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="mtlName" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第三行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">材料规格<span field="mtlStandard" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="mtlStandard" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">材料材质<!--<span field="mtlQuality" class="field_required">*</span>--></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="mtlQuality"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第四行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">计量方式</label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="mtlMeasureMethod"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">单位<span field="mtlValuationUnit" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="mtlValuationUnit"><option value=""></option></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第五行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">指导价格<!--<span field="mtlPriceUnit" class="field_required">*</span>--></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="mtlPriceUnit" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第六行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">备注</label>' +
                        '<div class="layui-input-block form_block">' +
                        '<textarea name="mtlDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        '</form>',
                        '</div>'].join(''),
                    success: function () {
                        $('select[name="mtlQuality"]').html(dictionaryObj['MTL_QUALITY']['str']);
                        $('select[name="mtlMeasureMethod"]').html(dictionaryObj['MTL_MEASURE_METHOD']['str']);
                        $('select[name="mtlValuationUnit"]').append(dictionaryObj['CBS_UNIT']['str']);

                        layForm.render();

                        if (type == 2) {
                            layForm.val("baseForm", data);
                            if (data.mtlValuationUnit) {
                                $('select[name="mtlValuationUnit"]').attr('disabled', true);
                            }
                        } else {
                            // 获取自动编号
                            getAutoNumber({autoNumber: 'plbMtlLibrary'}, function (res) {
                                $('input[name="mtlNo"]', $('#baseForm')).val(res);
                            });
                            $('.refresh_no_btn').show().on('click', function () {
                                getAutoNumber({autoNumber: 'plbMtlLibrary'}, function (res) {
                                    $('input[name="mtlNo"]', $('#baseForm')).val(res);
                                });
                            });
                            //继承父节点属性
                            if(currentNode.controlMode&&currentNode.controlMode=='01'){
                                $('select[name="mtlValuationUnit"]').val(currentNode.rbsUnit?currentNode.rbsUnit:'').attr('disabled', true)
                            }
                        }
                        layForm.render()
                    },
                    yes: function (index) {
                        var loadIndex = layer.load();
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value;
                        });

                        obj.mtlValuationUnit=$('select[name="mtlValuationUnit"]').val()

                        // 判断必填项
                        var requiredFlag = false;
                        $('#baseForm').find('.field_required').each(function () {
                            var field = $(this).attr('field');
                            if (field && !obj[field] && obj[field] != '0') {
                                var fieldName = $(this).parent().text().replace('*', '');
                                layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
                                requiredFlag = true;
                                return false;
                            }
                        });

                        if (requiredFlag) {
                            layer.close(loadIndex);
                            return false;
                        }

                        if (type == 2) {
                            obj.mtlLibId = data.mtlLibId;
                        } else {
                            obj.rbsId = currentNode ? currentNode.rbsId : 0;
                        }

                        $.post(url, obj, function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1, time: 2000});
                                layer.close(index);
                                tableInit({rbsId: currentNode.rbsId});
                            } else {
                                layer.msg(res.msg, {icon: 2, time: 2000});
                            }
                        });
                    }
                });
            }

            // 查询
            $('#searchBtn').on('click', function () {
                tableInit({rbsId: currentNode.rbsId});
            });

            /**
             * 获取查询条件
             * @returns {{planNo: (*), planName: (*)}}
             */
            function getSearchObj() {
                var searchObj = {
                    mtlNo: $('input[name="mtlNo"]', $('.query_module')).val(),
                    mtlName: $('input[name="mtlName"]', $('.query_module')).val(),
                    auditerStatus: $('input[name="auditerStatus"]', $('.query_module')).val()
                }

                return searchObj
            }

            /*region 导出 */
            $(document).on('click', function () {
                $('.export_moudle').hide();
            });
            $(document).on('click', '.export_btn', function () {
                var type = $(this).attr('type');
                var fileName = '资源库列表.xlsx';
                if (type == 1) {
                    var checkStatus = layTable.checkStatus('tableObj');
                    if (checkStatus.data.length == 0) {
                        layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                        return false;
                    }
                    soulTable.export(tableObj, {
                        filename: fileName,
                        checked: true
                    });
                } else if (type == 2) {
                    soulTable.export(tableObj, {
                        filename: fileName,
                        curPage: true
                    });
                } else if (type == 3) {
                    soulTable.export(tableObj, {
                        filename: fileName
                    });
                }
            });
            /* endregion */
        });
    }

    /**
     * 利用引用类型特性过滤树结构指定id节点及其子节点
     * @param data (树形数据)
     * @param filterId (过滤的ID)
     * @param idStr (主键id)
     * @param children
     * @returns {[]}
     */
    function filterTreeData(data, filterId, idStr, children) {
        if (!!data && data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                if (filterId != data[i][idStr]) {
                    if (data[i][children] && data[i][children].length > 0) {
                        filterTreeData(data[i][children], filterId, idStr, children);
                    }
                } else {
                    data.splice(i, 1);
                    break;
                }
            }
        }
    }

    function filterCbsTree (data, cbsName, parentArr, parentIndex) {
        if (!!data && data.length > 0) {
            for(var i = 0; i < data.length; i++) {
                if (data[i].cbsName.indexOf(cbsName) == -1) {
                    if (data[i].childList && data[i].childList.length > 0) {
                        i = filterCbsTree(data[i].childList, cbsName, data, i);
                    } else {
                        data.splice(i, 1);
                        i--;
                    }
                }
            }

            if (data.length == 0 && parentArr && parentArr.length > 0 && (parentArr.length == parentIndex || parentArr.length > parentIndex)) {
                parentArr.splice(parentIndex, 1);
                return parentIndex - 1;
            } else {
                return parentIndex || 0;
            }
        }
    }
</script>
</body>
</html>
