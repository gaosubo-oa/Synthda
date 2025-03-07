<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/7/16
  Time: 15:15
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
        <title>RBS项</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
        <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
        <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--        <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
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
                padding: 10px 0;
                box-sizing: border-box;
            }

            .wrapper {
                position: relative;
                width: 100%;
                height: 100%;
                padding: 0 8px;
                box-sizing: border-box;
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

            .refresh_no_btn,.refresh_sort_btn{
                display: none;
                margin-left: 8%;
                color: #00c4ff !important;
                font-weight: 600;
                cursor: pointer;
            }

            .layui-select-disabled .layui-disabled {
                color: #222 !important;
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
            <div class="wrapper">
                <div class="query_module layui-form layui-row" style="position: relative">
                    <div class="layui-col-xs2">
                        <input type="text" name="rbsNo" placeholder="RBS编号" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-col-xs2" style="margin-left: 15px;">
                        <input type="text" name="rbsName" placeholder="RBS名称" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-col-xs2" style="margin-left: 15px;">
                        <input type="text" name="cbsName" placeholder="CBS名称" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-col-xs2" style="margin-left: 15px;">
                        <select name="rbsType" lay-verify="required">
                            <option value="">选择RBS类型</option>
                        </select>
                    </div>
                    <div class="layui-col-xs2" style="margin: 3px 0 0 10px;text-align: left">
                        <button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
                        <button type="button" class="layui-btn layui-btn-sm" id="">高级查询</button>
                    </div>
                    <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                        <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                        <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                    </div>
                </div>
                <table id="tableObj" lay-filter="tableObj"></table>
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
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
        </script>

        <script>
            // 表格显示顺序
            var colShowObj = {
                rbsNo: {field: 'rbsNo', title: 'RBS编号', minWidth: 120, sort: true, hide: false},
                rbsType: {
                    field: 'rbsType', title: 'RBS类型', minWidth: 120, sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['RBS_TYPE']['object'][d.rbsType] || '';
                    }
                },
                rbsCategory: {
                    field: 'rbsCategory', title: 'RBS类别', minWidth: 120, sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['RBS_CATEGORY']['object'][d.rbsCategory] || '';
                    }
                },
                rbsName: {field: 'rbsName', title: 'RBS名称', minWidth: 120, sort: true, hide: false},
                cbsId: {
                    field: 'cbsId', title: 'CBS', minWidth: 120, sort: true, hide: false, templet: function (d) {
                        return d.cbsName || '';
                    }
                },
                remarks: {field: 'remarks', title: '说明', minWidth: 120, sort: true, hide: false}
            }

            var TableUIObj = new TableUI('plb_rbs');

            var dictionaryObj = {
                RBS_TYPE: {},
                RBS_CATEGORY: {}
            }
            var dictionaryStr = 'RBS_TYPE,RBS_CATEGORY';
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
                layui.use(['form', 'laydate', 'table', 'soulTable', 'xmSelect', 'eleTree'], function () {
                    var layForm = layui.form,
                        laydate = layui.laydate,
                        layTable = layui.table,
                        xmSelect = layui.xmSelect,
                        eleTree = layui.eleTree,
                        soulTable = layui.soulTable;

                    $('.query_module [name="rbsType"]').append(dictionaryObj['RBS_TYPE']['str']);

                    layForm.render();

                    var tableObj = null;

                    // 监听排序事件
                    layTable.on('sort(tableObj)', function (obj) {
                        var param = {
                            orderbyFields: obj.field,
                            orderbyUpdown: obj.type
                        }

                        TableUIObj.update(param, function () {
                            tableInit();
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
                    // 监听列表头部按钮事件
                    layTable.on('toolbar(tableObj)', function (obj) {
                        var checkStatus = layTable.checkStatus(obj.config.id);
                        switch (obj.event) {
                            case 'add': // 新增
                                addOrEdit(1);
                                break;
                            case 'del': // 删除
                                if (checkStatus.data.length == 0) {
                                    layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
                                    return false;
                                }

                                var rbsIds = '';

                                checkStatus.data.forEach(function (item) {
                                    rbsIds += item.rbsId + ',';
                                });

                                layer.confirm('确定删除该条数据吗？', function (index) {
                                    $.post('/plbRbs/delete', {rbsIds: rbsIds}, function (res) {
                                        layer.close(index)
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
                            case 'export': // 导出
                                $('.export_moudle').show();
                                break;
                        }
                    });
                    layTable.on('tool(tableObj)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        if (layEvent === 'detail') {
                            $.get('/plbRbs/selectByRbsId', {rbsId: data.rbsId}, function (res) {
                                addOrEdit(3, res.data);
                            });
                        } else if (layEvent === 'edit') {
                            // 获取rbs项信息
                            $.get('/plbRbs/selectByRbsId', {rbsId: data.rbsId}, function (res) {
                                addOrEdit(2, res.data);
                            });
                        }
                    });

                    TableUIObj.init(colShowObj, function () {
                        tableInit();
                    });

                    /**
                     * 加载表格方法
                     */
                    function tableInit() {
                        var searchObj = getSearchObj();
                        searchObj.useFlag = true;
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
                            url: '/plbRbs/selectAll',
                            toolbar: '#toolbarHead',
                            cols: [cols],
                            defaultToolbar: ['filter'],
                            height: 'full-70',
                            page: {
                                limit: TableUIObj.onePageRecoeds,
                                limits: [10, 20, 30, 40, 50]
                            },
                            where: searchObj,
                            autoSort: false,
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

                        tableObj = layTable.render(option);
                    }

                    /**
                     * 新增、编辑方法
                     * @param type 类型(1-新增，2-编辑, 3-查看详情)
                     * @param data 编辑时的信息
                     */
                    function addOrEdit(type, data) {
                        var title = '';
                        var url = '';
                        var btnArr = ['保存', '取消'];
                        if (type == 1) {
                            title = '新增项目';
                            url = '/plbRbs/insert';
                        } else if (type == 2) {
                            title = '编辑项目';
                            url = '/plbRbs/update';
                        } else if (type == 3) {
                            title = '查看详情';
                            btnArr = [];
                        }
                        var cbsSelectTree = null;
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
                                '<label class="layui-form-label form_label">RBS编号<span field="rbsNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" readonly name="rbsNo" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">RBS名称<span field="rbsName" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<input type="text" name="rbsName" autocomplete="off" class="layui-input">' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第二行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">RBS类型<span field="rbsType" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="rbsType"></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">RBS类别<span field="rbsCategory" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<select name="rbsCategory"></select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第三行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">CBS<span field="cbsId" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                /* region 第四行 */
                                '<div class="layui-row">' +
                                '<div class="layui-col-xs12" style="padding: 0 5px">' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label form_label">说明<span field="remarks" class="field_required">*</span></label>' +
                                '<div class="layui-input-block form_block">' +
                                '<textarea name="remarks" class="layui-textarea"></textarea>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                                '</div>',
                                /* endregion */
                                '</form>',
                                '</div>'].join(''),
                            success: function () {
                                $('select[name="rbsType"]').html(dictionaryObj['RBS_TYPE']['str']);
                                $('select[name="rbsCategory"]').html(dictionaryObj['RBS_CATEGORY']['str']);
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
                                        disabled: type == 3,
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

                                    function initCbsTree (cbsTreeData) {
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
                                        if (!currentData.childList || currentData.childList.length == 0) {
                                            var obj = {
                                                cbsName: currentData.cbsName,
                                                cbsId: currentData.cbsId
                                            }
                                            cbsSelectTree.setValue([obj]);
                                        }
                                    });

                                    if (type == 2 || type == 3) {
                                        var obj = {
                                            cbsName: data.cbsName,
                                            cbsId: data.cbsId
                                        }
                                        cbsSelectTree.setValue([obj]);
                                    }
                                });

                                if (type == 2 || type == 3) {
                                    layForm.val("baseForm", data);
                                } else if (type == 1) {
                                    // 获取自动编号
                                    getAutoNumber({autoNumber: 'plbRbs'}, function(res) {
                                        $('input[name="rbsNo"]', $('#baseForm')).val(res);
                                    });
                                    $('.refresh_no_btn').show().on('click', function() {
                                        getAutoNumber({autoNumber: 'plbRbs'}, function(res) {
                                            $('input[name="rbsNo"]', $('#baseForm')).val(res);
                                        });
                                    });
                                }

                                if (type == 3) {
                                    $('#baseForm [name]').attr('disabled', true);
                                }
                                layForm.render();
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
                                    dataObj.rbsId = data.rbsId
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
                                            tableObj.config.where._ = new Date().getTime();
                                            tableObj.reload();
                                        } else {
                                            layer.msg(res.msg, {icon: 2});
                                        }
                                    }
                                });
                            }
                        });
                    }

                    /**
                     * 获取查询条件
                     * @returns {{planNo: (*), planName: (*)}}
                     */
                    function getSearchObj() {
                        var searchObj = {
                            rbsNo: $('input[name="rbsNo"]', $('.query_module')).val(),
                            rbsName: $('input[name="rbsName"]', $('.query_module')).val(),
                            cbsName: $('input[name="cbsName"]', $('.query_module')).val(),
                            rbsType: $('select[name="rbsType"]', $('.query_module')).val()
                        }

                        return searchObj
                    }

                    // 查询
                    $('#searchBtn').on('click', function () {
                        tableInit();
                    });

                    /*region 导出 */
                    $(document).on('click', function () {
                        $('.export_moudle').hide();
                    });
                    $(document).on('click', '.export_btn', function () {
                        var type = $(this).attr('type');
                        var fileName = 'RBS项列表.xlsx';
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
        </script>
    </body>
</html>
