<%--
  Created by IntelliJ IDEA.
  User: 吴祖明
  Date: 2021/5/12
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>客商变更</title>

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
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>

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
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }

        body .demo-class .layui-layer-btn1 {
            border-color: #FFB800;
            background-color: #FFB800;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">客商变更</h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off"
                       class="layui-input"/>
            </div>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="contractMoney" placeholder="合同金额" autocomplete="off" class="layui-input">
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
                <div class="table_box">
                    <table id="tableObj" lay-filter="tableObj"></table>
                </div>
                <div class="no_data" style="text-align: center;display: none">
                    <div class="no_data_img" style="margin-top:12%;">
                        <img style="margin-top: 2%;" src="/img/noData.png">
                    </div>
                    <p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧部门</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbarHead">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="revision">变更</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <%--        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="viewBudgetReport">查看预算报表</button>--%>
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="submit">提交审批</button>
        <%--<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
            <img src="/img/planCheck/导入.png"style="width: 20px;height: 20px;margin-top: -4px;">导入
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
            <img src="/img/planCheck/导出.png"style="width: 20px;height: 20px;margin-top: -4px;">导出
        </button>--%>
    </div>
</script>

<%--修编中编辑--%>
<script type="text/html" id="revisionBarDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="edit">编辑</a>
</script>
<script type="text/html" id="checkBar">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="check">查看</a>
</script>


<script>
    var closeRevision;
    var selectCustomer;
    var approvalData = '';
    var dictionaryObj = {
        MERCHANT_TYPE: {},
        CUSTOMER_SOURCE: {},
        CUSTOMER_NATURE: {},
        CUSTOMER_TYPE: {}
    }
    var dictionaryStr = 'MERCHANT_TYPE,CUSTOMER_SOURCE,CUSTOMER_NATURE,CUSTOMER_TYPE';
    var mainAreaDept = '<option value="">请选择</option>'
    var mainProjectDept = '<option value="">请选择</option>'
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
    });

    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var tableIns = null;

        form.render();

        var exportData = '';
        var colShowObj = {
            customerNo: {field: 'customerNo', title: '客商编号', sort: true}
            , customerName: {field: 'customerName', title: '客商单位名称'}
            , customerShortName: {field: 'customerShortName', title: '客商单位简称'}
            , customerOrgCode: {field: 'customerOrgCode', title: '组织机构代码'}
            , taxNumber: {field: 'taxNumber', title: '税务登记号'}
            , accountNumber: {field: 'accountNumber', title: '开户行账户'}
            , auditerStatus: {
                field: 'auditerStatus', title: '状态', sort: true, hide: false, templet: function (d) {
                    if (d.auditerStatus == 0) {
                        return '未提交';
                    } else if (d.auditerStatus == 1) {
                        return '审批中';
                    } else if (d.auditerStatus == 2) {
                        return '批准';
                    } else if (d.auditerStatus == 3) {
                        return '不批准';
                    } else {
                        return '';
                    }
                }
            }
        }
        var TableUIObj = new TableUI('plb_customer_change');
        TableUIObj.init(colShowObj);

        // 初始化左侧项目
        projectLeft();
        // 节点点击事件
        $(document).on('click', '.con_left ul li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var typeId = $(this).attr('typeId');
            var selectCustomer = d.data.currentData;
            tableShow(typeId);
            $('#leftId').attr('typeId', typeId);
        });

        // 上方按钮显示
        table.on('toolbar(tableObj)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                //提交审核
                case 'submit':
                    submit(checkStatus)
                    break;
                case 'revision'://修编
                    if ($('#leftId').attr('typeId')) {
                        revision()
                    } else {
                        layer.msg('请选择左侧部门！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'edit'://编辑
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一项！', {icon: 0});
                        return false
                    }
                    if (checkStatus.data[0].approvalStatus == '1') {
                        layer.msg('所选数据正在审批中，不可编辑！', {icon: 0, time: 2000});
                        return false;
                    }
                    if (checkStatus.data[0].approvalStatus == '2' || checkStatus.data[0].approvalStatus == '3') {
                        layer.msg('所选数据已审批，不可编辑！', {icon: 0, time: 2000});
                        return false;
                    }
                    changeEdit(2, checkStatus.data[0])
                    break;
            }
        });
        // 监听排序事件
        table.on('sort(tableObj)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow($('#leftId').attr('typeId'))
            })
        });

        //工具条事件
        table.on('tool(flowTable)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if (layEvent === 'edit') { //编辑
                changeEdit(1, data)
            }
        });

        //工具条事件
        table.on('tool(tableObj)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if (layEvent === 'check') { //查看数据
                checkBarData(data)
            }
        });

        //左侧项目信息列表
        function projectLeft(projectName) {
            projectName = projectName ? projectName : ''
            var loadingIndex = layer.load();

            $.get('/PlbCustomerType/treeList', function (res) {
                layer.close(loadingIndex);
                if (res.flag) {
                    eleTree.render({
                        elem: '#leftTree',
                        url: '/PlbCustomerType/treeList',
                        showCheckbox: false,
                        showLine: true,
                        request: { // 修改数据为组件需要的数据
                            name: "typeName", // 显示的内容
                            key: "typeId", // 节点id
                            parentId: 'parentTypeId', // 节点父id
                            isLeaf: "isLeaf",// 是否有子节点
                            children: 'child',
                        },
                        response: { // 修改响应数据为组件需要的数据
                            statusName: "flag",
                            statusCode: true,
                            dataName: "data"
                        }
                        , highlightCurrent: true,
                    });
                    $('.eleTree-node-content-label').each(function(){
                        var titleSpan=$(this).text();
                        $(this).attr('title',titleSpan);
                    })
                    TableUIObj.init(colShowObj, function () {
                        tableShow('')
                    });
                }
            });
        }

        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            var currentData = d.data.currentData;
            selectCustomer = d.data.currentData;
            if (currentData.typeId) {
                $('#leftId').attr('typeId', currentData.typeId);
                $('#leftId').attr('typeNo', currentData.typeNo);
                $('.no_data').hide();
                $('.table_box').show();
                tableShow(currentData.typeId);
            } else {
                $('.table_box').hide();
                $('.no_data').show();
            }
            $('.eleTree-node-content-label').each(function(){
                var titleSpan=$(this).text();
                $(this).attr('title',titleSpan);
            })
        });

        // 渲染表格
        function tableShow(typeId) {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)
            cols = cols.concat({align: 'center', toolbar: '#checkBar', title: '操作', width: 80})
            tableIns = table.render({
                elem: '#tableObj',
                url: '/PlbCustomer/getEdit',
                toolbar: '#toolbarHead',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-80',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    merchantType: typeId,
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
                parseData: function (res) { //res 即为原始返回的数据
                    var data;
                    var dataList = [];
                    for (var i = 0; i < res.data.length; i++) {
                        //reviseId = res.data[i].reviseId
                        data = res.data[i].data
                        data["auditerStatus"] = res.data[i].approvalStatus
                        data["reviseId"] = res.data[i].reviseId
                        dataList.push(data)
                    }
                    return {
                        "code": 0, //解析接口状态
                        "data": dataList, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                },
                request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },
                done: function (res) {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableObj')
                    })

                    res.data.forEach(function (v) {
                        exportData += v.mtlPlanId + ','
                    })

                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit})
                    }
                },
                initSort: {
                    field: TableUIObj.orderbyFields,
                    type: TableUIObj.orderbyUpdown
                }
            });
        }

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

        //更变
        function revision() {
            var typeId = $('#leftId').attr('typeId');
            var typeNo = $('#leftId').attr('typeNo');
            var operation = {title: '操作', width: 100, align: 'center', toolbar: '#revisionBarDemo'}
            // var cols = [{checkbox: true}].concat(TableUIObj.cols)
            var cols = TableUIObj.cols.concat([operation])
            closeRevision = layer.open({
                type: 1,
                title: '修编',
                area: ['70%', '80%'],
                btnAlign: 'c',
                maxmin: true,
                content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
                success: function () {
                    table.render({
                        elem: '#flowTable',
                        url: '/PlbCustomer/getDataByCondition',
                        toolbar: '#toolbarDemo',
                        cols: [cols],
                        defaultToolbar: ['filter'],
                        height: 'full-150',
                        page: {
                            limit: TableUIObj.onePageRecoeds,
                            limits: [10, 20, 30, 40, 50]
                        },
                        where: {
                            merchantType: typeNo,
                            orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                            orderbyUpdown: TableUIObj.orderbyUpdown
                        },
                        autoSort: false,
                        parseData: function (res) { //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "data": res.data, //解析数据列表
                                "count": res.totleNum, //解析数据长度
                            };
                        },
                        request: {
                            limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done: function (res) {
                            //增加拖拽后回调函数
                            soulTable.render(this, function () {
                                TableUIObj.dragTable('toolbarDemo')
                            })

                            res.data.forEach(function (v) {
                                exportData += v.mtlPlanId + ','
                            })

                            if (TableUIObj.onePageRecoeds != this.limit) {
                                TableUIObj.update({onePageRecoeds: this.limit})
                            }
                        },
                        initSort: {
                            field: TableUIObj.orderbyFields,
                            type: TableUIObj.orderbyUpdown
                        }
                    });
                },
            })
        }

        //查看数据
        function checkBarData(data) {
            var customerId = data.customerId;
            layer.open({
                type: 1,
                title: '查看合同',
                area: ['70%', '80%'],
                btn: ['关闭'],
                btnAlign: 'c',
                content: ['<form action="" class="layui-form"  lay-filter="editTab" id="editTab" style="padding: 0px 10px"><div class="layui-table editTab" style="margin: 8px 0px;">\n' +
                //第一行
                '<div class="layui-row"> ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">客商编号<span style="color: #ff0000; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerNo" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '   </div>' +
                '</div>\n' +
                '</div>\n' +
                '<div class="layui-col-xs3">' +
                '<div class="layui-form-item">' +
                '    <label class="layui-form-label">客商单位名称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerName" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div>' +
                '</div>' +
                '</div>' +
                '<div class="layui-col-xs3">' +
                '<div class="layui-form-item">' +
                '    <label class="layui-form-label">客商单位简称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerShortName" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div>' +
                '</div>' +
                '</div>' +
                '<div class="layui-col-xs3">' +
                '<div class="layui-form-item">' +
                '    <label class="layui-form-label">客商类型<span style="color: red; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="merchantType" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong"></input>\n' +
                '  </div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                //第二行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">客商来源</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <select name="customerSource" id="customerSource" lay-verify="required" disabled autocomplete="off" class="layui-input jinyong"></select>\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">组织机构代码</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerOrgCode" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">单位性质</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <select name="customerNature" id="customerNature" lay-verify="required" disabled autocomplete="off" class="layui-input jinyong"></select>\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">单位类别</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <select name="customerType" id="customerType" lay-verify="required" disabled autocomplete="off" class="layui-input jinyong"></select>\n' +
                '  </div></div></div>' +
                '</div>' +


                //第三行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">税务登记号</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="taxNumber" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">开户行名称</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="accountName" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">开户行账户</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="number" name="accountNumber" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">账号单位地址</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="accountAddress" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '</div>' +

                //第四行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">账号单位电话</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="accountTelno" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">法人代表</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="legalPeron" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">注册资金（万元）</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="number" name="regCapital" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">单位营业地址</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="businessAddress" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '</div>' +


                //第五行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">联系人</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="contactPerson" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">联系电话</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="contactTelno" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +

                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">营业范围</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="businessScope" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">备注</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="remarks" lay-verify="required" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '</div>' +


                //第六行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">资证材料<span field="attachmentId" class="field_required"></span></label>' +
                '<div class="layui-input-block form_block">' +
                '<div class="file_module">' +
                '<div id="fileContent" class="file_content"></div>' +
                '<div class="file_upload_box">' +
                '<a href="javascript:;" class="open_file">' +
                '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                '</a>' +
                '<div class="progress">' +
                '<div class="bar"></div>\n' +
                '</div>' +
                '<div class="bar_text"></div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</form>'].join(''),
                success: function () {
                    $('[name="customerSource"]').html(dictionaryObj['CUSTOMER_SOURCE']['str'])
                    $('[name="customerNature"]').html(dictionaryObj['CUSTOMER_NATURE']['str'])
                    $('[name="customerType"]').html(dictionaryObj['CUSTOMER_TYPE']['str'])
                    fileuploadFn('#fileupload', $('#fileContent'));
                    //回显数据
                    form.val("editTab", data);
                    $('form input[name="merchantType"]').val(data.merchantTypeName)
                    $('form input[name="merchantType"]').attr('typeId', data.merchantType)
                    //合同附件
                    if (data.attachment && data.attachment.length > 0) {
                        var fileArr = data.attachment;
                        var str = '';
                        for (var i = 0; i < fileArr.length; i++) {
                            var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                            str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                        }
                        $('#fileContent').append(str);
                    }
                    element.render();
                    form.render();
                    // $('form input[name="merchantType"]').val(selectCustomer.typeName)

                },
            });
        }

        //修编合同
        function changeEdit(type, data) {
            var customerId = data.customerId;
            layer.open({
                type: 1,
                title: '修编合同',
                skin: 'demo-class',
                area: ['100%', '100%'],
                btn: ['保存', '提交', '取消'],
                btnAlign: 'c',
                content: ['<form action="" class="layui-form"  lay-filter="editTab" id="editTab" style="padding: 0px 10px"><div class="layui-table editTab" style="margin: 8px 0px;">\n' +
                //第一行
                '<div class="layui-row"> ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">客商编号<span style="color: #ff0000; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerNo" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '   </div>' +
                '</div>\n' +
                '</div>\n' +
                '<div class="layui-col-xs3">' +
                '<div class="layui-form-item">' +
                '    <label class="layui-form-label">客商单位名称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerName" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div>' +
                '</div>' +
                '</div>' +
                '<div class="layui-col-xs3">' +
                '<div class="layui-form-item">' +
                '    <label class="layui-form-label">客商单位简称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerShortName" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div>' +
                '</div>' +
                '</div>' +
                '<div class="layui-col-xs3">' +
                '<div class="layui-form-item">' +
                '    <label class="layui-form-label">客商类型<span style="color: red; font-size: 20px;">*</span></label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="merchantType" readonly style="background:#e7e7e7;" lay-verify="required" autocomplete="off" class="layui-input jinyong"></input>\n' +
                '  </div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                //第二行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">客商来源</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <select name="customerSource" id="customerSource" lay-verify="required" autocomplete="off" class="layui-input jinyong"></select>\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">组织机构代码</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="customerOrgCode" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">单位性质</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <select name="customerNature" id="customerNature" lay-verify="required" autocomplete="off" class="layui-input jinyong"></select>\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">单位类别</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <select name="customerType" id="customerType" lay-verify="required" autocomplete="off" class="layui-input jinyong"></select>\n' +
                '  </div></div></div>' +
                '</div>' +


                //第三行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">税务登记号</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="taxNumber" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">开户行名称</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="accountName" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">开户行账户</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="number" name="accountNumber" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">账号单位地址</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="accountAddress" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '</div>' +

                //第四行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">账号单位电话</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="accountTelno" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">法人代表</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="legalPeron" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">注册资金（万元）</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="number" name="regCapital" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">单位营业地址</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="businessAddress" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '</div>' +


                //第五行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">联系人</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="contactPerson" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">联系电话</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="contactTelno" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +

                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">营业范围</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="businessScope" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '<div class="layui-col-xs3"> ' +
                '<div class="layui-form-item" >\n' +
                '    <label class="layui-form-label">备注</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="remarks" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                '  </div></div></div>' +
                '</div>' +


                //第六行

                '<div class="layui-row" > ' +
                '<div class="layui-col-xs3" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">资证材料<span field="attachmentId" class="field_required"></span></label>' +
                '<div class="layui-input-block form_block">' +
                '<div class="file_module">' +
                '<div id="fileContent" class="file_content"></div>' +
                '<div class="file_upload_box">' +
                '<a href="javascript:;" class="open_file">' +
                '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                '</a>' +
                '<div class="progress">' +
                '<div class="bar"></div>\n' +
                '</div>' +
                '<div class="bar_text"></div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</form>'].join(''),
                success: function () {
                    $('[name="customerSource"]').html(dictionaryObj['CUSTOMER_SOURCE']['str'])
                    $('[name="customerNature"]').html(dictionaryObj['CUSTOMER_NATURE']['str'])
                    $('[name="customerType"]').html(dictionaryObj['CUSTOMER_TYPE']['str'])
                    fileuploadFn('#fileupload', $('#fileContent'));
                    //回显数据
                    form.val("editTab", data);
                    $('form input[name="merchantType"]').val(data.merchantTypeName)
                    $('form input[name="merchantType"]').attr('typeId', data.merchantType)
                    //合同附件
                    if (data.attachment && data.attachment.length > 0) {
                        var fileArr = data.attachment;
                        var str = '';
                        for (var i = 0; i < fileArr.length; i++) {
                            var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                            str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                        }
                        $('#fileContent').append(str);
                    }

                    element.render();
                    form.render();
                    // $('form input[name="merchantType"]').val(selectCustomer.typeName)

                },
                yes: function (index) {
                    // 附件
                    var attachmentId = '';
                    var attachmentName = '';
                    var url = ''
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    var dataObj = {
                        customerId: customerId,
                        customerNo: $('#editTab input[name="customerNo"]').val(),
                        customerName: $('#editTab input[name="customerName"]').val(),
                        customerShortName: $('#editTab input[name="customerShortName"]').val(),
                        merchantType: $('#editTab input[name="merchantType"]').attr('typeId'),

                        customerOrgCode: $('#editTab input[name="customerOrgCode"]').val(),

                        customerNature: $('#editTab select[name="customerNature"]').val(),
                        customerSource: $('#editTab select[name="customerSource"]').val(),
                        customerType: $('#editTab select[name="customerType"]').val(),

                        taxNumber: $('#editTab input[name="taxNumber"]').val(),
                        accountName: $('#editTab input[name="accountName"]').val(),
                        accountNumber: $('#editTab input[name="accountNumber"]').val(),
                        accountAddress: $('#editTab input[name="accountAddress"]').val(),
                        accountTelno: $('#editTab input[name="accountTelno"]').val(),
                        legalPeron: $('#editTab input[name="legalPeron"]').val(),
                        regCapital: $('#editTab input[name="regCapital"]').val(),
                        regCapital: $('#editTab input[name="regCapital"]').val(),
                        regCapital: $('#editTab input[name="regCapital"]').val(),
                        businessAddress: $('#editTab input[name="businessAddress"]').val(),
                        contactPerson: $('#editTab input[name="contactPerson"]').val(),
                        contactTelno: $('#editTab input[name="contactTelno"]').val(),
                        //纸质材料
                        // attachmentId: attachmentId,
                        // attachmentName: attachmentName,
                        businessScope: $('#editTab input[name="businessScope"]').val(),
                        remarks: $('#editTab input[name="remarks"]').val(),

                    }
                    if (type == 1) {
                        var reviseList = dataObj
                        url = "/PlbCustomer/revision"
                    } else if (type == 2) {
                        var reviseList = {}
                        url = '/PlbBudgetRevision/update'
                        reviseList.reviseId = data.reviseId
                        reviseList.reviseData = dataObj
                    }
                    $.ajax({
                        url: url,
                        type: "post",
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(reviseList),
                        success: function (res) {
                            if (res.flag) {
                                $.layerMsg({content: "保存成功", icon: 1}, function () {
                                    // window.location.reload();
                                    layer.close(index)
                                    layer.close(closeRevision)
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload()
                                })
                            }
                        }
                    })
                    // //必填项提示
                    // for (var i = 0; i < $('.testNull').length; i++) {
                    //     if ($('.testNull').eq(i).val() == '') {
                    //         layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                    //         return false
                    //     }
                    // }
                    // //提示输入框只能输入数字
                    // for (var a = 0; a < $('.chinese').length; a++) {
                    //     if (isNaN($('.chinese').eq(a).val())) {
                    //         layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                    //         return false
                    //     }
                    // }
                    //
                    // var loadIndex = layer.load();
                    // //分包合同数据
                    // var datas = $('#baseForm').serializeArray();
                    // var obj = {}
                    // datas.forEach(function (item) {
                    //     obj[item.name] = item.value
                    // });
                    //
                    // // 合同附件
                    // var attachmentId = '';
                    // var attachmentName = '';
                    // for (var i = 0; i < $('#fileContent .dech').length; i++) {
                    //     attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                    //     attachmentName += $('#fileContent a').eq(i).attr('name');
                    // }
                    // obj.attachmentId = attachmentId;
                    // obj.attachmentName = attachmentName;
                    //
                    // // 比价附件
                    // var attachmentId2 = '';
                    // var attachmentName2 = '';
                    // for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
                    //     attachmentId2 += $('#fileContent2 .dech').eq(i).find('input').val();
                    //     attachmentName2 += $('#fileContent2 a').eq(i).attr('name');
                    // }
                    // obj.attachmentId2 = attachmentId2;
                    // obj.attachmentName2 = attachmentName2;
                    // //合同明细数据
                    // var $tr = $('.mtl_info').find('.layui-table-main tr');
                    // var materialDetailsArr = [];
                    // $tr.each(function () {
                    //     var materialDetailsObj = {
                    //         cbsId: $(this).find('[name="contractPrice"]').attr('cbsId'),
                    //         cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                    //         manageTargetPrice: $(this).find('[data-field="manageTargetPrice"] .layui-table-cell').text(),
                    //         contractPrice: $(this).find('[name="contractPrice"]').val(),
                    //         subcontractOutId: $(this).find('[name="contractPrice"]').attr('subcontractOutId'),
                    //     }
                    //     if ($(this).find('input[name="contractPrice"]').attr('subcontractOutId')) {
                    //         materialDetailsObj.subcontractOutId = $(this).find('input[name="contractPrice"]').attr('subcontractOutId');
                    //     }
                    //     materialDetailsArr.push(materialDetailsObj);
                    // });
                    // obj.plbMtlSubcontractOuts = materialDetailsArr;
                    // obj.deptId = $('#leftId').attr('deptId');
                    //
                    // if (type == 1) {
                    //     obj.subcontractId = data.subcontractId
                    // }
                    // // else
                    // //     {
                    // //     obj.deptId = parseInt(deptId);
                    // // }
                    // $.ajax({
                    //     url: '/plbDeptSubcontract/revision',
                    //     data: JSON.stringify(obj),
                    //     dataType: 'json',
                    //     contentType: "application/json;charset=UTF-8",
                    //     type: 'post',
                    //     success: function (res) {
                    //         layer.close(loadIndex);
                    //         if (res.flag) {
                    //             layer.msg('保存成功！', {icon: 1});
                    //             layer.close(index);
                    //             layer.close(closeRevision)
                    //             tableObj.config.where._ = new Date().getTime();
                    //             tableObj.reload();
                    //         } else {
                    //             layer.msg('保存失败！', {icon: 2});
                    //         }
                    //     }
                    // });
                },
                btn2: function (Index) {
                    // 附件
                    var attachmentId = '';
                    var attachmentName = '';
                    var url = ''
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    var arrData = {
                        customerId: customerId,
                        customerNo: $('#editTab input[name="customerNo"]').val(),
                        customerName: $('#editTab input[name="customerName"]').val(),
                        customerShortName: $('#editTab input[name="customerShortName"]').val(),
                        merchantType: $('#editTab input[name="merchantType"]').attr('typeId'),

                        customerOrgCode: $('#editTab input[name="customerOrgCode"]').val(),

                        customerNature: $('#editTab select[name="customerNature"]').val(),
                        customerSource: $('#editTab select[name="customerSource"]').val(),
                        customerType: $('#editTab select[name="customerType"]').val(),

                        taxNumber: $('#editTab input[name="taxNumber"]').val(),
                        accountName: $('#editTab input[name="accountName"]').val(),
                        accountNumber: $('#editTab input[name="accountNumber"]').val(),
                        accountAddress: $('#editTab input[name="accountAddress"]').val(),
                        accountTelno: $('#editTab input[name="accountTelno"]').val(),
                        legalPeron: $('#editTab input[name="legalPeron"]').val(),
                        regCapital: $('#editTab input[name="regCapital"]').val(),
                        regCapital: $('#editTab input[name="regCapital"]').val(),
                        regCapital: $('#editTab input[name="regCapital"]').val(),
                        businessAddress: $('#editTab input[name="businessAddress"]').val(),
                        contactPerson: $('#editTab input[name="contactPerson"]').val(),
                        contactTelno: $('#editTab input[name="contactTelno"]').val(),
                        //纸质材料
                        // attachmentId: attachmentId,
                        // attachmentName: attachmentName,
                        businessScope: $('#editTab input[name="businessScope"]').val(),
                        remarks: $('#editTab input[name="remarks"]').val(),

                    };
                    approvalData = arrData;
                    if (type == 1) {
                        var reviseList = arrData
                        url = "/PlbCustomer/revision"
                    } else if (type == 2) {
                        var reviseList = {}
                        url = '/PlbBudgetRevision/update'
                        reviseList.reviseId = data.reviseId
                        reviseList.reviseData = arrData
                    }
                    layer.open({
                        type: 1,
                        title: '选择流程',
                        area: ['70%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div><table id="flowTable1" lay-filter="flowTable1"></table></div>',
                        success: function () {
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '33'}, function (res) {
                                var flowData = []
                                $.each(res.data.flowData, function (k, v) {
                                    flowData.push({
                                        flowId: k,
                                        flowName: v
                                    });
                                });
                                table.render({
                                    elem: '#flowTable1',
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
                            var checkStatus = table.checkStatus('flowTable1');
                            var revisionUpdate = {};
                            if (checkStatus.data.length > 0) {
                                var flowData = checkStatus.data[0];
                                newWorkFlow(flowData.flowId, function (res) {
                                    // 报销单保存关联的runId
                                    // obj.runId = res.flowRun.runId,
                                    // obj.approvalStatus = 0
                                    arrData.runId = res.flowRun.runId
                                    // arrData.

                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                                    $.ajax({
                                        url: url,
                                        data: JSON.stringify(reviseList),
                                        dataType: 'json',
                                        contentType: "application/json;charset=UTF-8",
                                        type: 'post',
                                        success: function (res) {
                                            // layer.close(loadIndex);
                                            revisionUpdate.reviseId = res.data
                                            revisionUpdate.runId = arrData.runId
                                            revisionUpdate.approvalStatus = 1
                                            $.ajax({
                                                url: '/PlbBudgetRevision/update',
                                                data: JSON.stringify(revisionUpdate),
                                                dataType: 'json',
                                                contentType: "application/json;charset=UTF-8",
                                                type: 'post',
                                                success: function (res) {
                                                    if (res.flag) {
                                                        layer.msg('保存成功！', {icon: 1});
                                                        layer.close(loadIndex);
                                                        layer.close(index);
                                                        layer.close(Index);
                                                        layer.close(closeRevision)
                                                        tableIns.config.where._ = new Date().getTime();
                                                        tableIns.reload();
                                                    } else {
                                                        layer.msg('保存失败！', {icon: 2});
                                                    }
                                                }
                                            })

                                        }
                                    });
                                });
                            } else {
                                layer.close(loadIndex);
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    return false;
                }
            });
        }

        //提交审批
        function submit(checkStatus) {
            if (checkStatus.data.length != 1) {
                layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                return false;
            }

            // if (checkStatus.data[0].approvalStatus == '0') {
            //     layer.msg('所选数据正在审批中，不可编辑！', {icon: 0, time: 2000});
            //     return false;
            // }
            // if (checkStatus.data[0].approvalStatus == '1' || checkStatus.data[0].approvalStatus == '2') {
            //     layer.msg('所选数据已审批，不可重复提交！', {icon: 0, time: 2000});
            //     return false;
            // }
            //var contractInfo = checkStatus.data[0];
            approvalData = checkStatus.data[0]
            layer.open({
                type: 1,
                title: '选择流程',
                area: ['70%', '80%'],
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
                success: function () {
                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '33'}, function (res) {
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
                        //var urlParameter = 'type=3&customerType=' + customerInfo.customerType + '&customerId=' + customerInfo.customerId
                        newWorkFlow(flowData.flowId, function (res) {
                            // 报销单保存关联的runId
                            var submitData = {
                                //customerId: customerInfo.customerId,
                                reviseId: approvalData.reviseId,
                                runId: res.flowRun.runId,
                                approvalStatus: 1
                            }
                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                            $.ajax({
                                url: '/PlbBudgetRevision/update',
                                data: JSON.stringify(submitData),
                                dataType: 'json',
                                contentType: "application/json;charset=UTF-8",
                                type: 'post',
                                success: function (res) {
                                    layer.close(loadIndex);
                                    if (res.flag) {
                                        layer.close(index);
                                        layer.msg('提交成功!', {icon: 1});
                                        tableIns.config.where._ = new Date().getTime();
                                        tableIns.reload()
                                    } else {
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                }
                            });
                        });
                    } else {
                        layer.close(loadIndex);
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        }

        /**
         * 新建流程方法
         * @param flowId
         * @param urlParameter
         * @param cb
         */
        function newWorkFlow(flowId, cb) {
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
                    approvalData: JSON.stringify(approvalData),
                    isTabApproval: true,
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


    })


</script>