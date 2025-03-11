<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>部门预算报表</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>

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

        .td_title {
            width: 200px;
            background: #F2F2F2;
        }
    </style>

    <style>
        #projectIdsSelect .xm-body  {
            min-width: 300px !important;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">部门预算报表</h2>
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
                <%--<div class="layui-col-xs2">
                    <div class="layui-form-item">
                        <label class="layui-form-label">单位名称:</label>
                        <div class="layui-input-block">
                            <input type="text" name="itemName"  placeholder="单位名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>--%>
                <div class="layui-col-xs3">
                    <div class="layui-form-item">
                        <label class="layui-form-label">年度:</label>
                        <div class="layui-input-block">
                            <select name="year" lay-filter="year">
                                <option value="">请选择</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item">
                        <label class="layui-form-label">月度:</label>
                        <div class="layui-input-block">
                            <select name="month">
                                <option value="">请选择</option>
                            </select>
                        </div>
                    </div>
                </div>
                <%--<div class="layui-col-xs2">
                    <div class="layui-form-item">
                        <label class="layui-form-label">预算科目:</label>
                        <div class="layui-input-block">
                            <div id="projectIdsSelect" class="xm-select-demo"></div>
                        </div>
                    </div>
                </div>--%>
                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
                </div>
            </div>
            <div style="position: relative">
                <div class="table_box" >
                    <table id="tableObj" lay-filter="tableObj"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>

    //选部门控件添加
    $(document).on('click', '.deptAdd', function () {
        dept_id = $(this).attr('id');
        $.popWindow("/common/selectDept?0");
    });
    $(document).on('click', '.userAdd', function () {
        user_id = $(this).attr('id')
        $.popWindow("/common/selectUser?0");
    });

    // 表格显示顺序
    var colShowObj = {
        // itemName: {field: 'itemName', title: '单位名称', sort: true, hide: false},
        cbsNameFirst: {field: 'cbsNameFirst', title: '一级科目', sort: true, hide: false,},
        cbsNameSecond: {field: 'cbsNameSecond', title: '二级科目', sort: true, hide: false,},
        cbsNameThird: {field: 'cbsNameThird', title: '三级科目', sort: true, hide: false,},
        countBudgetItem: {field: 'countBudgetItem', title: '初始预算金额', sort: true, hide: false,templet: function (d) {
                return d.countBudgetItem || 0
            }},
        amountMonth: {field: 'amountMonth', title: '本月支出金额', sort: true, hide: false,templet: function (d) {
                return d.amountMonth || 0
            }},
        amountYear: {field: 'amountYear', title: '累计支出金额', sort: true, hide: false,templet: function (d) {
                return d.amountYear || 0
            }},
        cumulativePaidProportion: {field: 'cumulativePaidProportion', title: '累计支出百分比', sort: true, hide: false},
    }
    var TableUIObj = new TableUI('plb_dept_budget_item');


    var dictionaryObj = {
        CONTROL_TYPE: {},
        BUDGET_YEAR: {},
        REIMBURSEMENT_TYPE: {},
        ITEM_LEVEL: {},
    }
    var dictionaryStr = 'CONTROL_TYPE,BUDGET_YEAR,REIMBURSEMENT_TYPE,ITEM_LEVEL';
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

    layui.use(['form', 'table', 'soulTable', 'eleTree','element','laydate','xmSelect'], function () {
        var layForm = layui.form,
            layTable = layui.table,
            eleTree = layui.eleTree,
            soulTable = layui.soulTable,
            element = layui.element,
            laydate = layui.laydate;
        xmSelect = layui.xmSelect;
        layForm.render();

        // 获取计划期间年度列表
        $.get('/plbPlanPeroidSetting/selectAllYear', function (res) {
            var allYear = '';
            if (res.object.length > 0) {
                res.object.forEach(function (item) {
                    allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>';
                });
            }
            $('.query_module [name="year"]').append(allYear);
            $('.query_module [name="year"]').val(new Date().getFullYear())

            var nowYearNo =$('.query_module [name="year"]').val()
            getPlanMonth(nowYearNo, function (monthStr) {
                $('.query_module [name="month"]').html(monthStr);
                layForm.render('select');
            });
            layForm.render('select');
        });

        // 获取月度
        layForm.on('select(year)', function (data) {
            if (data.value) {
                getPlanMonth(data.value, function (monthStr) {
                    $('.query_module [name="month"]').html(monthStr);
                    layForm.render('select');
                });
            } else {
                $('.query_module [name="month"]').html('<option value="">请选择</option>');
                layForm.render('select');
            }
        });

        var tableObj = null;
        /*var projectIdsSelect = null

        $.get('/plbDeptBudgetItem/getParentList',function (res) {
            if (res.flag) {
                projectIdsSelect = xmSelect.render({
                    el: '#projectIdsSelect',
                    toolbar: {
                        show: true,
                    },
                    name: 'budgetItemIds',
                    filterable: true,
                    data: res.data,
                    tree: {
                        show: true,
                        showFolderIcon: true,
                        showLine: true,
                        indent: 20,
                        expandedKeys: [-3],
                    },
                    prop: {
                        name: 'itemName',
                        value: 'deptItemId',
                        children: 'child'
                    },
                    model: {
                        label: {
                            block: {
                                template: function (item, sels) {
                                    return '<span style="max-width: 70px; overflow: hidden;" title="' + item.itemName + '">' + item.itemName + '</span>';
                                }
                            }
                        }
                    }
                });
            }
        });*/


        /* region 修改左侧项目名称 */
        var searchTimer = null;
        $('#search_project').on('input propertychange', function () {
            clearTimeout(searchTimer);
            searchTimer = null;
            var val = $(this).val();
            searchTimer = setTimeout(function () {
                projectLeft(val);
            }, 300);
        });
        $('.search_icon').on('click', function () {
            projectLeft($('#search_project').val());
        });
        /* endregion */

        projectLeft();

        /**
         * 左侧项目信息列表
         * @param deptName 项目名称
         */
        function projectLeft(deptName) {
            deptName = deptName ? deptName : '';
            var loadingIndex = layer.load();
            $.get('/plbOrg/selectAll', {deptName: deptName}, function (res) {
                layer.close(loadingIndex);
                if (res.flag) {
                    eleTree.render({
                        elem: '#leftTree',
                        data: res.obj,
                        highlightCurrent: true,
                        showLine: true,
                        defaultExpandAll: false,
                        request: {
                            name: 'deptName',
                            children: "orgList",
                        }
                    });
                    $('.eleTree-node-content-label').each(function(){
                        var titleSpan=$(this).text();
                        $(this).attr('title',titleSpan);
                    })
                    TableUIObj.init(colShowObj,function () {
                        tableInit('')
                    });
                }
            });
        }

        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            var currentData = d.data.currentData;
            if (currentData.deptId) {
                $('#leftId').attr('deptId', currentData.deptId);
                $('#leftId').attr('deptName', currentData.deptName);
                $('.no_data').hide();
                $('.table_box').show();
                tableInit(currentData.deptId);
            } else {
                $('.table_box').hide();
                $('.no_data').show();
            }
            $('.eleTree-node-content-label').each(function(){
                var titleSpan=$(this).text();
                $(this).attr('title',titleSpan);
            })
        });

        layTable.on('tool(tableObj)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if(layEvent === 'detail'){
                var deptItemId=data.deptItemId
                var deptId=$('#leftId').attr('deptId');
                layer.open({
                    type: 1,
                    title: '详情',
                    area: ['100%', '100%'],
                    maxmin: true,
                    content: ['<div class="layui-form">' +
                    //下拉选择
                    '           <div class="layui-row" style="margin-top: 10px">' +
                    '<div class="layui-col-xs3">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">经办人:</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="text" name="createUser" id="createUser" placeholder="经办人" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input userAdd">\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="layui-col-xs3">\n' +
                    '                <div class="layui-form-item">\n' +
                    '                    <label class="layui-form-label">报销人:</label>\n' +
                    '                    <div class="layui-input-block">\n' +
                    '                        <input type="text" name="reimburseUser" id="reimburseUser" placeholder="报销人" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input userAdd">\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>'+
                    '               <div class="layui-col-xs3">' +
                    '<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 0 0 10px;">搜索<i class="layui-icon layui-icon-search" style="margin: 0 0 0 3px;"></i></button>' +
                    '               </div>' +
                    '           </div>' +
                    //表格数据
                    '       <div style="padding: 10px">' +
                    '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                    '      </div>' +
                    '</div>'].join(''),
                    success: function () {

                        laodTable(deptItemId, deptId);

                        $('.search_mtl').on('click', function(){
                            laodTable(deptItemId, deptId);
                        });

                        // 加载表格
                        function laodTable(deptItemId, deptId) {
                            layTable.render({
                                elem: '#managementBudgetTable',
                                url: '/plbDeptBudget/deptBudgetByListId',
                                where: {
                                    deptItemId: deptItemId,
                                    deptId: deptId,
                                },
                                cellMinWidth:120,
                                page: true,
                                limit: 20,
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
                                    {field: 'reimburseNo', title: '单据编号',width:120},
                                    {field: 'createUserName', title: '经办人',width:120,templet: function (d) {
                                            return d.createUserName ? d.createUserName.replace(/,$/,'') : ''
                                        }},
                                    {field: 'reimburseUserName', title: '报销人',width:120,templet: function (d) {
                                            return d.reimburseUserName ? d.reimburseUserName.replace(/,$/,'') : ''
                                        }},
                                    {field: 'createTime', title: '编制时间',width:170},
                                    {field: 'reimburseTotal', title: '付款金额',cellMinWidth:170,templet: function (d) {
                                            return d.reimburseTotal || 0
                                        }},
                                ]]
                            });
                        }
                    },
                });
            }
        });

        // 监听排序事件
        layTable.on('sort(tableObj)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableInit($('#leftId').attr('deptId'));
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

        /**
         * 加载表格方法
         */
        function tableInit(deptId) {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)

            cols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#detailBarDemo',
                title: '操作',
                width: 100
            })

            var option = {
                elem: '#tableObj',
                url:'/plbDeptBudget/deptBudgetReportForm',
                cols: [cols],
                toolbar: '#toolbarHead',
                defaultToolbar: ['filter'],
                height: 'full-165',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    orderbyUpdown: TableUIObj.orderbyUpdown,
                    deptId:deptId
                },
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

        //点击查询
        $('.searchData').on('click',function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            /*var projectArr = projectIdsSelect.getValue()
            var budgetItemIds = ''
            projectArr.forEach(function (item, index) {
                budgetItemIds += item.deptItemId + ','
            })
            searchParams.budgetItemIds=budgetItemIds*/

            tableObj.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        //判断是否显示空
        function isShowNull(data) {
            if(data){
                return data
            }else{
                return ''
            }
        }

        /***
         * 获取计划期间月度
         * @param planYear (月度对应年份)
         * @param cb (回调函数)
         */
        function getPlanMonth(planYear, fn) {
            $.get('/plbPlanPeroidSetting/showAllSet', {periodYear: planYear}, function (res) {
                var str = '<option value="">请选择</option>';
                if (res.object.length > 0) {
                    res.object.forEach(function (item) {
                        str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>'
                    });
                }
                if (fn) {
                    fn(str);
                }
            });
        }
    });
</script>
</body>
</html>
