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
        <title>经营立项</title>

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
                    <h2 style="text-align: center;line-height: 35px;">经营立项</h2>
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

        <script type="text/html" id="toolbarDemoIn">
            <div class="layui-btn-container" style="height: 30px;">
                <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
            </div>
        </script>

        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
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
                layui.use(['form', 'table', 'element', 'soulTable', 'eleTree'], function () {
                    var form = layui.form,
                        table = layui.table,
                        element = layui.element,
                        soulTable = layui.soulTable,
                        eleTree = layui.eleTree;

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

                    // 上方按钮显示
                    table.on('toolbar(mtlPlanTable)', function (obj) {
                        var checkStatus = table.checkStatus(obj.config.id);
                        switch (obj.event) {
                            case 'add':
                                if (!$('#leftId').attr('projId')) {
                                    layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
                                    return false;
                                }
                                newOrEdit(1);
                                break;
                            case 'edit':
                                if (checkStatus.data.length != 1) {
                                    layer.msg('请选择一项！', {icon: 0});
                                    return false
                                }

                                $.get('/PlbManageItem/queryByItemId', {itemId: checkStatus.data[0].itemId}, function(res) {
                                    if (res.flag) {
                                        newOrEdit(2, res.data);
                                    } else {
                                        layer.msg('获取数据失败！', {icon: 2, time: 2000});
                                    }
                                });
                                break;
                            case 'del':
                                if (!checkStatus.data.length) {
                                    layer.msg('请至少选择一项！', {icon: 0});
                                    return false
                                }
                                var itemIds = ''
                                checkStatus.data.forEach(function (v, i) {
                                    itemIds += v.itemId + ','
                                })
                                layer.confirm('确定删除该条数据吗？', function (index) {
                                    $.post('/PlbManageItem/delete', {itemIds: itemIds}, function (res) {
                                        if (res.flag) {
                                            layer.msg('删除成功！', {icon: 1});
                                        } else {
                                            layer.msg('删除失败！', {icon: 0});
                                        }
                                        layer.close(index);
                                        tableIns.config.where._ = new Date().getTime();
                                        tableIns.reload();
                                    })
                                });
                                break;
                            case 'export':
                                layer.msg('导出');
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

                    // 立项明细-加行
                    table.on('toolbar(itemDetailsTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                //遍历表格获取每行数据进行保存
                                var $trs = $('#itemDetailsTableModule').find('.layui-table-main tr');
                                var oldDataArr = []
                                $trs.each(function () {
                                    var oldDataObj = {
                                        listId: $(this).find('input[name="budgetItemId"]').attr('listId') || '',
                                        budgetItemId: $(this).find('input[name="budgetItemId"]').attr('budgetItemId') || '',
                                        budgetItemName: $(this).find('input[name="budgetItemId"]').val(),
                                        manageTarNum: $(this).find('input[name="manageTarNum"]').val(),
                                        manageTarPrice: $(this).find('input[name="manageTarPrice"]').val(),
                                        manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                                        optTarNum: $(this).find('input[name="optTarNum"]').val(),
                                        optTarPrice: $(this).find('input[name="optTarPrice"]').val(),
                                        optTarAmount: $(this).find('input[name="optTarAmount"]').val(),
                                        estimatedIncome: $(this).find('input[name="estimatedIncome"]').val()
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                oldDataArr.push({});
                                table.reload('itemDetailsTable', {
                                    data: oldDataArr
                                });
                                break;
                        }
                    });
                    // 立项明细-行操作
                    table.on('tool(itemDetailsTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            obj.del();
                            if (data.listId) {
                                $.get('/PlbManageItem/delete', {itemListIds: data.listId}, function(res){

                                });
                            }
                            //遍历表格获取每行数据进行保存
                            var $trs = $('#itemDetailsTableModule').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $trs.each(function () {
                                var oldDataObj = {
                                    listId: $(this).find('input[name="budgetItemId"]').attr('listId') || '',
                                    budgetItemId: $(this).find('input[name="budgetItemId"]').attr('budgetItemId') || '',
                                    budgetItemName: $(this).find('input[name="budgetItemId"]').val(),
                                    manageTarNum: $(this).find('input[name="manageTarNum"]').val(),
                                    manageTarPrice: $(this).find('input[name="manageTarPrice"]').val(),
                                    manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                                    optTarNum: $(this).find('input[name="optTarNum"]').val(),
                                    optTarPrice: $(this).find('input[name="optTarPrice"]').val(),
                                    optTarAmount: $(this).find('input[name="optTarAmount"]').val(),
                                    estimatedIncome: $(this).find('input[name="estimatedIncome"]').val()
                                }
                                oldDataArr.push(oldDataObj);
                            })
                            table.reload('itemDetailsTable', {
                                data: oldDataArr
                            });
                        } else if (layEvent === 'chooseBudgetItem') {
                            layer.open({
                                type: 1,
                                title: '选择预算科目',
                                area: ['70%', '80%'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: '<div><table id="managementBudgetTable" lay-filter="managementBudgetTable"></table></div>',
                                success: function () {
                                    table.render({
                                        elem: '#managementBudgetTable',
                                        url: '/plbProjBudget/queryAll',
                                        page: {
                                            limit: 10,
                                            limits: [10, 20, 30, 40, 50]
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
                                        cols: [[
                                            {type: 'radio', title: '选择'},
                                            {field: 'budgetItemName', title: '科目名称'},
                                            {field: 'manageTarNum', title: '管理目标数量'},
                                            {field: 'manageTarPrice', title: '管理目标单价'},
                                            {field: 'manageTarAmount', title: '管理目标金额'},
                                            {field: 'optTarNum', title: '优化目标数量'},
                                            {field: 'optTarPrice', title: '优化目标单价'},
                                            {field: 'optTarAmount', title: '优化目标金额'},
                                        ]]
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = table.checkStatus('managementBudgetTable');

                                    if (checkStatus.data.length > 0) {
                                        var chooseData = checkStatus.data[0];

                                        $tr.find('input[name="budgetItemId"]').attr('budgetItemId', chooseData.budgetItemId);
                                        $tr.find('input[name="budgetItemId"]').val(chooseData.budgetItemName);
                                        $tr.find('input[name="manageTarNum"]').val(chooseData.manageTarNum || '');
                                        $tr.find('input[name="manageTarPrice"]').val(chooseData.manageTarPrice || '');
                                        $tr.find('input[name="manageTarAmount"]').val(chooseData.manageTarAmount || '');
                                        $tr.find('input[name="optTarNum"]').val(chooseData.optTarNum || '');
                                        $tr.find('input[name="optTarPrice"]').val(chooseData.optTarPrice || '');
                                        $tr.find('input[name="optTarAmount"]').val(chooseData.optTarAmount || '');

                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                                    }
                                }
                            });
                        }
                    });

                    // 渲染表格
                    function tableShow(projId) {
                        var searchObj = getSearchObj();
                        searchObj.projId = projId || '';
                        searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
                        searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                        var cols = [{checkbox: true}].concat(TableUIObj.cols);

                        var option = {
                            elem: '#mtlPlanTable',
                            url: '/PlbManageItem/queryAll',
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

                    // 新建/编辑
                    function newOrEdit(type, data) {
                        var title = '';
                        var url = '';
                        var projId = $('#leftId').attr('projId');
                        if (type === 1) {
                            title = '新建经营立项';
                            url = '/PlbManageItem/insert';
                        } else if (type === 2) {
                            title = '编辑经营立项';
                            url = '/PlbManageItem/update';
                            projId = data.projId;
                        }
                        layer.open({
                            type: 1,
                            title: title,
                            area: ['100%', '100%'],
                            btn: ['保存', '提交', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layui-collapse">\n' ,
                                /* region 立项项目基础信息 */
                                '  <div class="layui-colla-item">\n' +
                                '    <h2 class="layui-colla-title">立项信息</h2>\n' +
                                '    <div class="layui-colla-content layui-show plan_base_info">' +
                                '       <form class="layui-form" id="baseForm" lay-filter="baseForm">',
                                /* region 第一行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">立项编号<span field="itemNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly name="itemNo" autocomplete="off" class="layui-input">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">立项类型<span field="itemType" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <select name="itemType"><option value="">请选择</option></select>\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">立项金额<span field="itemAmount" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" name="itemAmount" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">审批人<span field="approvaler" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <input type="text" readonly id="approvaler" name="approvaler" autocomplete="off" class="layui-input" style="cursor: pointer;">\n' +
                                '                       </div>\n' +
                                '                   </div>' +
                                '               </div>' +
                                '           </div>' ,
                                /* endregion */
                                /* region 第二行 */
                                '           <div class="layui-row">' +
                                '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                                '                   <div class="layui-form-item">\n' +
                                '                       <label class="layui-form-label form_label">立项内容<span field="itemContent" class="field_required">*</span></label>\n' +
                                '                       <div class="layui-input-block form_block">\n' +
                                '                       <textarea name="itemContent" placeholder="请输入立项内容" class="layui-textarea"></textarea>\n' +
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
                                '    <div class="layui-colla-content mtl_info layui-show">' +
                                '       <div id="itemDetailsTableModule">' +
                                '           <table id="itemDetailsTable" lay-filter="itemDetailsTable"></table>' +
                                '      </div>' +
                                '    </div>\n' +
                                '  </div>\n' ,
                                /* endregion */
                                '</div>'].join(''),
                            success: function () {
                                $('[name="itemType"]', $('#baseForm')).append(dictionaryObj['MANAGE_ITEM_TYPE']['str']);

                                element.render();

                                form.render();

                                var plbManageItemListList = [];

                                if (type === 2) {
                                    form.val("baseForm", data);

                                    // 审批人
                                    $('#approvaler').attr('user_id', data.approvaler).val((data.approvalerName || '').replace(/,$/, ''));

                                    // 立项明细
                                    plbManageItemListList = data.plbManageItemListList || [];
                                } else {
                                    // 获取自动编号
                                    getAutoNumber({autoNumber: 'plbManageItem'}, function(res) {
                                        $('input[name="itemNo"]', $('#baseForm')).val(res);
                                    });
                                    $('.refresh_no_btn').show().on('click', function() {
                                        getAutoNumber({autoNumber: 'plbManageItem'}, function(res) {
                                            $('input[name="itemNo"]', $('#baseForm')).val(res);
                                        });
                                    });
                                }

                                table.render({
                                    elem: '#itemDetailsTable',
                                    data: plbManageItemListList,
                                    toolbar: '#toolbarDemoIn',
                                    defaultToolbar: [''],
                                    limit: 1000,
                                    cols: [[
                                        {type: 'numbers'},
                                        {
                                            field: 'budgetItemId', title: '经营预算科目', event: 'chooseBudgetItem', templet: function (d) {
                                                return '<input listId="' + (d.listId || '') + '" budgetItemId="' + (d.budgetItemId || '') + '" readonly type="text" name="budgetItemId" class="layui-input" style="height: 100%; cursor: pointer;" value="' + (d.budgetItemName || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'manageTarNum', title: '管理目标数量', templet: function (d) {
                                                return '<input type="text" name="manageTarNum" pointFlag="1" class="layui-input input_floatNum" style="height: 100%;" value="' + (d.manageTarNum || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'manageTarPrice', title: '管理目标单价', templet: function (d) {
                                                return '<input type="text" name="manageTarPrice" pointFlag="1" class="layui-input input_floatNum" style="height: 100%;" value="' + (d.manageTarPrice || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'manageTarAmount', title: '管理目标金额', templet: function (d) {
                                                return '<input type="text" name="manageTarAmount" pointFlag="1" class="layui-input input_floatNum" style="height: 100%;" value="' + (d.manageTarAmount || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'optTarNum', title: '优化目标数量', templet: function (d) {
                                                return '<input type="text" name="optTarNum" pointFlag="1" class="layui-input input_floatNum" style="height: 100%;" value="' + (d.optTarNum || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'optTarPrice', title: '优化目标单价', templet: function (d) {
                                                return '<input type="text" name="optTarPrice" pointFlag="1" class="layui-input input_floatNum" style="height: 100%;" value="' + (d.optTarPrice || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'optTarAmount', title: '优化目标金额', templet: function (d) {
                                                return '<input type="text" name="optTarAmount" pointFlag="1" class="layui-input input_floatNum" style="height: 100%;" value="' + (d.optTarAmount || '') + '">'
                                            }
                                        },
                                        {
                                            field: 'estimatedIncome', title: '预计收入', templet: function (d) {
                                                return '<input type="text" name="estimatedIncome" pointFlag="1" class="layui-input input_floatNum" style="height: 100%;" value="' + (d.estimatedIncome || '') + '">'
                                            }
                                        },
                                        {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                                    ]]
                                });

                                // 选择审批人
                                $('#approvaler').on('click', function() {
                                    user_id = 'approvaler';
                                    $.popWindow('/common/selectUser?0');
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

                                // 审批人
                                obj.approvaler = ($('#approvaler').attr('user_id') || '').replace(/,$/, '');

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

                                if (requiredFlag) {
                                    layer.close(loadIndex);
                                    return false;
                                }

                                //材料明细数据
                                var $trs = $('#itemDetailsTableModule').find('.layui-table-main tr');
                                var plbManageItemListList = [];
                                $trs.each(function () {
                                    var plbManageItemObj = {
                                        budgetItemId: $(this).find('input[name="budgetItemId"]').attr('budgetItemId') || '',
                                        manageTarNum: $(this).find('input[name="manageTarNum"]').val(),
                                        manageTarPrice: $(this).find('input[name="manageTarPrice"]').val(),
                                        manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                                        optTarNum: $(this).find('input[name="optTarNum"]').val(),
                                        optTarPrice: $(this).find('input[name="optTarPrice"]').val(),
                                        optTarAmount: $(this).find('input[name="optTarAmount"]').val(),
                                        estimatedIncome: $(this).find('input[name="estimatedIncome"]').val()
                                    }
                                    if ($(this).find('input[name="budgetItemId"]').attr('listId')) {
                                        plbManageItemObj.listId = $(this).find('input[name="budgetItemId"]').attr('listId');
                                    }
                                    plbManageItemListList.push(plbManageItemObj);
                                });
                                obj.plbManageItemListList = plbManageItemListList;

                                if (type === 2) {
                                    obj.itemId = data.itemId
                                } else {
                                    obj.projId = projId;
                                }

                                $.ajax({
                                    url: url,
                                    data: JSON.stringify(obj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success: function (res) {
                                        layer.close(loadIndex);
                                        if (res.flag) {
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
                                layer.msg('提交');
                                return false;
                            }
                        });
                    }
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
        </script>
    </body>
</html>
