<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>CBS设置</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210616.1"></script>

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
            top: 110px;
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

        .layui-select-disabled .layui-disabled {
            color: #222 !important;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId">
    <div class="wrapper">
        <div class="wrap_left">
            <h2>CBS设置</h2>
            <div class="left_form" style="margin: 10px 0; text-align: center;">
                <button type="button" class="layui-btn layui-btn-sm" id="addCbs">新建</button>
                <button type="button" class="layui-btn layui-btn-sm" id="editCbs">修改</button>
                <button type="button" class="layui-btn layui-btn-sm" id="delCbs">删除</button>
            </div>
            <p style="text-align: center;font-weight: bold;">CBS父级类型模板</p>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="cbsName" placeholder="CBS名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select name="cbsType">
                        <option value="">请选择</option>
                    </select>
                </div>
                <div class="layui-col-xs4" style="margin: 3px 0 0 10px;text-align: left;">
                    <button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
                    <button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>
                </div>
                <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>
            </div>
            <div style="position: relative">
                <table id="tableObj" lay-filter="tableObj"></table>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbarHead">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
            <img src="/img/planCheck/导出.png"style="width: 20px;height: 20px;margin-top: -4px;">导出
        </button>
        <div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>
    </div>
</script>

<script type="text/html" id="toolBar">
    <a class="layui-btn layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    var tipIndex = null
    $('.icon_img').on('hover',function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    // 表格显示顺序
    var colShowObj = {
        cbsNo: {field: 'cbsNo', title: 'CBS编码', sort: true, hide: false, minWidth: 120},
        cbsName: {field: 'cbsName', title: 'CBS名称', sort: true, hide: false, minWidth: 120},
        cbsType: {
            field: 'cbsType', title: 'CBS类型', sort: true, hide: false, minWidth: 120, templet: function (d) {
                return dictionaryObj['CBS_TYPE']['object'][d.cbsType] || '';
            }
        },
        cbsLevel: {
            field: 'cbsLevel', title: 'CBS级别', sort: true, hide: false, minWidth: 120, templet: function (d) {
                return dictionaryObj['CBS_LEVEL']['object'][d.cbsLevel] || '';
            }
        },
        cbsUnit: {
            field: 'cbsUnit', title: 'CBS单位', minWidth: 120, templet: function (d) {
                return dictionaryObj['CBS_UNIT']['object'][d.cbsUnit] || '';
            }
        },
        budgetTrait: {field: 'budgetTrait', title: '预算特征', minWidth: 120},
        cbsRemarks: {field: 'cbsRemarks', title: '备注', minWidth: 120}
    }

    var TableUIObj = new TableUI('plb_cbs_type');

    // 获取数据字典数据
    var dictionaryObj = {
        CBS_LEVEL: {},
        CBS_UNIT: {},
        CONTROL_MODE: {},
        CBS_TYPE: {},
        ITEM_LEVEL: {},
        ITEM_DIRECTION: {}
    }
    var dictionaryStr = 'CBS_LEVEL,CBS_UNIT,CONTROL_MODE,CBS_TYPE,ITEM_LEVEL,ITEM_DIRECTION';
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
        initPage()
    });

    function initPage() {
        layui.use(['eleTree', 'table', 'form', 'soulTable'], function () {
            var table = layui.table,
                form = layui.form,
                soulTable = layui.soulTable,
                eleTree = layui.eleTree;
            $('.query_module [name="cbsType"]').append(dictionaryObj['CBS_TYPE']['str']);
            form.render();

            // 左侧树
            var eleTreeLeft = eleTree.render({
                elem: '#leftTree',
                url: '/plbCbsType/getParentList',
                showCheckbox: false,
                showLine: true,
                request: {
                    name: "cbsName",
                    key: "cbsNo",
                    parentId: 'parentCbsNo',
                    isLeaf: "isLeaf",
                    children: 'childList'
                },
                response: {
                    statusName: "flag",
                    statusCode: true,
                    dataName: "data"
                },
                highlightCurrent: true
            });
            // 节点点击事件
            eleTree.on("nodeClick(leftTree)", function (d) {
                var cbsNo = d.data.currentData.cbsNo;
                $('#leftId').attr('cbsNo', cbsNo);
                $('#leftId').attr('cbsId', d.data.currentData.cbsId);
                tableInit(cbsNo);
            });

            // 删除树
            $('#delCbs').on('click',function () {
                var cbsId = $('#leftId').attr('cbsId');
                if (!cbsId) {
                    layer.msg('请选择需要删除的模板！', {icon: 0});
                    return false;
                }
                layer.confirm('确定删除该模板吗？', function (index) {
                    $.ajax({
                        url: '/plbCbsType/delParentList',
                        dataType: 'json',
                        type: 'post',
                        data: {
                            plbCbsTypeIds: cbsId
                        },
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('删除成功！', {icon: 1});
                                location.reload();
                            } else {
                                layer.msg('删除失败！', {icon: 2});
                            }
                        }
                    })
                });
            })
            //新建树
            $('#addCbs').on('click',function () {
                newTemplate(1);
            });
            // 编辑树
            $('#editCbs').on('click',function () {
                var cbsId = $('#leftId').attr('cbsId');
                $.get('/plbCbsType/findCbsTypeById', {cbsId: cbsId}, function (res) {
                    newTemplate(2, res.data);
                })
            });

            var tableIns = null
            TableUIObj.init(colShowObj, function () {
                tableInit();
            });

            // 监听排序事件
            table.on('sort(tableObj)', function (obj) {
                var param = {
                    orderbyFields: obj.field,
                    orderbyUpdown: obj.type
                }

                TableUIObj.update(param, function () {
                    tableInit($('#leftId').attr('cbsNo') || '');
                })
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
            table.on('toolbar(tableObj)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id);

                switch (obj.event) {
                    case 'add':
                        if (!$('#leftId').attr('cbsNo')) {
                            layer.msg('请选择左侧树!', {icon: 0});
                            return false;
                        }
                        addOrEdit(1)
                        break;
                    case 'del':
                        if (!checkStatus.data.length) {
                            layer.msg('请选择需要删除的数据！', {icon: 0});
                            return false
                        }
                        var plbCbsTypeIds = []
                        checkStatus.data.forEach(function (item) {
                            plbCbsTypeIds.push(item.cbsId)
                        })
                        layer.confirm('确定删除该条数据吗？', function (index) {
                            $.ajax({
                                url: '/plbCbsType/delParentList',
                                dataType: 'json',
                                type: 'post',
                                data: {plbCbsTypeIds: plbCbsTypeIds},
                                traditional: true,
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('删除成功！', {icon: 1});
                                        tableInit($('#leftId').attr('cbsNo') || '');
                                    } else {
                                        layer.msg('删除失败！', {icon: 2});
                                    }
                                    layer.close(index)
                                }
                            })
                        });
                        break;
                    case 'export':
                        $('.export_moudle').show();
                        break;
                }
            });
            table.on('tool(tableObj)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                if (layEvent === 'detail') {
                    $.get('/plbCbsType/findCbsTypeById', {cbsId: data.cbsId}, function (res) {
                        addOrEdit(3, res.data);
                    })
                } else if (layEvent === 'edit') {
                    $.get('/plbCbsType/findCbsTypeById', {cbsId: data.cbsId}, function (res) {
                        addOrEdit(2, res.data);
                    })
                }
            });

            function tableInit(cbsNo) {
                var searchObj = getSearchObj();
                searchObj.cbsNo = cbsNo || '';
                searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
                searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                var cols = [{checkbox: true}].concat(TableUIObj.cols);

                cols.push({
                    fixed: 'right',
                    align: 'center',
                    toolbar: '#toolBar',
                    title: '操作',
                    width: 140
                });

                var option = {
                    elem: '#tableObj',
                    url: '/plbCbsType/getCbsTypeList',
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
                        if(res.flag&&res.data&&res.data.length>0){
                            //增加拖拽后回调函数
                            soulTable.render(this, function () {
                                TableUIObj.dragTable('tableObj')
                            })

                            if (TableUIObj.onePageRecoeds != this.limit) {
                                TableUIObj.update({onePageRecoeds: this.limit})
                            }
                        }else{
                            // $('#leftTree').html('<div style="text-align: center">暂无数据</div>');
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
             * 新增、编辑左侧方法
             * @param type 类型(1-新增，2-编辑)
             * @param data 编辑时的信息
             */
            function newTemplate(type, data) {
                var title = '';
                var url = '';
                var parentCbsNo = '';
                if (type == 1) {
                    title = '新增CBS父级类型模板';
                    url = '/plbCbsType/insertParent';
                    parentCbsNo = $('#leftId').attr('cbsNo') || '';
                } else if (type == 2) {
                    title = '编辑CBS父级类型模板';
                    url = '/plbCbsType/updateParent';
                    parentCbsNo = data.parentCbsNo;
                }
                layer.open({
                    type: 1,
                    title: title,
                    area: ['520px', '450px'],
                    btn: ['保存', '取消'],
                    btnAlign: 'c',
                    content: ['<div style="padding: 20px;">' +
                    '<form class="layui-form" id="templateForm" lay-filter="templateForm">',
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label">CBS编号<span field="cbsNo" class="field_required">*</span></label>' +
                        '<div class="layui-input-block">' +
                        '<input type="text" name="cbsNo" autocomplete="off" readonly class="layui-input" style="background-color: #e7e7e7">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label">CBS名称<span field="cbsName" class="field_required">*</span></label>' +
                        '<div class="layui-input-block">' +
                        '<input type="type" name="cbsName" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label">CBS类型<span field="cbsNo" class="field_required">*</span></label>' +
                        '<div class="layui-input-block">' +
                        '<select name="cbsType">' +
                        '<option value="">请选择</option>' +
                        '</select>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label">所属上级<b style="color: red">*</b></label>' +
                        '<div class="layui-input-block">' +
                        '<input type="type" id="parentCbsNo" autocomplete="off" class="layui-input" readonly style="background:#e7e7e7;">' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label" style="padding: 0;width: 100px;">模板类型描述</label>' +
                        '<div class="layui-input-block">' +
                        '<textarea style="height: 60px" name="cbsRemarks" autocomplete="off" class="layui-textarea"></textarea>' +
                        '</select>' +
                        '</div>' +
                        '</div>',
                        '</form></div>'].join(''),
                    success: function () {
                        $('select[name="cbsType"]', $('#templateForm')).html(dictionaryObj['CBS_TYPE']['str']);

                        if (parentCbsNo) {
                            $.get('/plbCbsType/findCbsTypeByNo', {cbsNo: parentCbsNo}, function(res) {
                                $('#parentCbsNo').val(res.data.cbsName);
                                if (type == 1) {
                                    $('select[name="cbsType"]', $('#templateForm')).val(res.data.cbsType || '');
                                }
                            });
                        } else {
                            $('#parentCbsNo').val('已为一级');
                        }

                        if (type == 2) {
                            form.val("templateForm", data);
                        } else if (type == 1) {
                            // 获取自动编号
                            getAutoNumber({autoNumber: 'plbCbs', cbsNo: parentCbsNo}, function (res) {
                                $('input[name="cbsNo"]', $('#templateForm')).val(res);
                            });
                            $('.refresh_no_btn').show().on('click', function () {
                                getAutoNumber({autoNumber: 'plbCbs', cbsNo: parentCbsNo}, function (res) {
                                    $('input[name="cbsNo"]', $('#templateForm')).val(res);
                                });
                            });
                        }

                        form.render();
                    },
                    yes: function (index) {
                        var loadIndex = layer.load();

                        var datas = $('#templateForm').serializeArray();
                        var dataObj = {}
                        datas.forEach(function (item) {
                            dataObj[item.name] = item.value;
                        });

                        // 判断必填项
                        var requiredFlag = false;
                        $('#templateForm').find('.field_required').each(function () {
                            var field = $(this).attr('field');
                            if (field && !dataObj[field] && dataObj[field] != '0') {
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
                            dataObj.cbsId = data.cbsId
                        } else {
                            dataObj.parentCbsNo = parentCbsNo || '';
                            dataObj.isLastLevel = 0;
                        }

                        $.post(url, dataObj, function(res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                layer.close(index)
                                eleTreeLeft.reload();
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        })
                    }
                });
            }

            /**
             * 新增、编辑右侧方法
             * @param type 类型(1-新增，2-编辑, 3-查看详情)
             * @param data 编辑时的信息
             */
            function addOrEdit(type, data) {
                var title = '';
                var url = '';
                var btnArr = ['保存', '取消'];
                var parentCbsNo = $('#leftId').attr('cbsNo') || '';
                if (type == 1) {
                    title = '新增CBS'
                    url = '/plbCbsType/insertParent'
                } else if (type == 2) {
                    title = '编辑CBS';
                    url = '/plbCbsType/updateParent';
                    parentCbsNo = data.parentCbsNo;
                } else if (type == 3) {
                    title = 'CBS详情';
                    btnArr = [];
                }

                layer.open({
                    type: 1,
                    title: title,
                    area: ['100%', '100%'],
                    btn: btnArr,
                    btnAlign: 'c',
                    content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
                        '<form class="layui-form" id="baseForm" lay-filter="baseForm">',
                        /* region 第一行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">CBS编号<span field="cbsNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" readonly name="cbsNo" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">CBS名称<span field="cbsName" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="cbsName" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第二行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">CBS级别<span field="cbsLevel" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="cbsLevel"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">CBS单位<span field="cbsUnit" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="cbsUnit"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第三行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">预算特征<span field="budgetTrait" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="budgetTrait" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">方向<span field="itemDirection" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="itemDirection"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第四行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">CBS类型<span field="cbsType" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select name="cbsType"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第五行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">备注<span field="cbsRemarks" class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<textarea name="cbsRemarks" autocomplete="off" class="layui-textarea"></textarea>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        '</form>',
                        '</div>'].join(''),
                    success: function () {
                        $('select[name="cbsLevel"]', $('#baseForm')).html(dictionaryObj['CBS_LEVEL']['str']);
                        $('select[name="cbsUnit"]', $('#baseForm')).html(dictionaryObj['CBS_UNIT']['str']);
                        $('select[name="cbsType"]', $('#baseForm')).html(dictionaryObj['CBS_TYPE']['str']);
                        $('select[name="itemDirection"]', $('#baseForm')).html(dictionaryObj['ITEM_DIRECTION']['str']);

                        if (type == 2 || type == 3) {
                            form.val("baseForm", data);
                        } else if (type == 1) {
                            // 获取自动编号
                            getAutoNumber({autoNumber: 'plbCbs', cbsNo: parentCbsNo}, function (res) {
                                $('input[name="cbsNo"]', $('#baseForm')).val(res);
                            });
                            $('.refresh_no_btn').show().on('click', function () {
                                getAutoNumber({autoNumber: 'plbCbs', cbsNo: parentCbsNo}, function (res) {
                                    $('input[name="cbsNo"]', $('#baseForm')).val(res);
                                });
                            });
                        }

                        if (type == 3) {
                            $('#baseForm [name]').attr('disabled', true);
                        }
                        form.render();
                    },
                    yes: function (index) {
                        var loadIndex = layer.load();

                        var datas = $('#baseForm').serializeArray();
                        var dataObj = {}
                        datas.forEach(function (item) {
                            dataObj[item.name] = item.value;
                        });

                        // 判断必填项
                        var requiredFlag = false;
                        $('#baseForm').find('.field_required').each(function () {
                            var field = $(this).attr('field');
                            if (field && !dataObj[field] && dataObj[field] != '0') {
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
                            dataObj.cbsId = data.cbsId;
                        } else {
                            dataObj.parentCbsNo = parentCbsNo;
                        }

                        $.post(url, dataObj, function(res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                layer.close(index);
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload();
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        })
                    }
                });
            }

            /**
             * 获取查询条件
             * @returns {{planNo: (*), planName: (*)}}
             */
            function getSearchObj() {
                var searchObj = {
                    cbsName: $('input[name="cbsName"]', $('.query_module')).val(),
                    cbsType: $('select[name="cbsType"]', $('.query_module')).val()
                }

                return searchObj
            }

            // 查询
            $('#searchBtn').on('click', function () {
                tableInit($('#leftId').attr('cbsNo') || '');
            });

            /*region 导出 */
            $(document).on('click', function () {
                $('.export_moudle').hide();
            });
            $(document).on('click', '.export_btn', function () {
                var type = $(this).attr('type');
                var fileName = 'cbs列表.xlsx';
                if (type == 1) {
                    var checkStatus = table.checkStatus('tableObj');
                    if (checkStatus.data.length == 0) {
                        layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                        return false;
                    }
                    soulTable.export(tableIns, {
                        filename: fileName,
                        checked: true
                    });
                } else if (type == 2) {
                    soulTable.export(tableIns, {
                        filename: fileName,
                        curPage: true
                    });
                } else if (type == 3) {
                    soulTable.export(tableIns, {
                        filename: fileName
                    });
                }
            });
            /* endregion */
        })
    }
</script>
</body>
</html>

