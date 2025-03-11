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
    <title>部门预算编制</title>
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

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .export_moudle{
            background-color: #ffff;
            width: 120px;
            position: absolute;
            right: 0;
            top:100%;
            text-align: left;
            padding: 10px;
            display:none;
        }
        .export_moudle > p:hover {
            cursor: pointer;
            color: #1E9FFF;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">部门预算编制</h2>
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
                <div class="layui-col-xs2">
                    <input type="text" name="tgNo" placeholder="部门预算编号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="tgName" placeholder="部门预算名称" autocomplete="off" class="layui-input">
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
                <div class="table_box" >
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
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="viewBudgetReport">查看预算报表</button>
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="submit">提交审批</button>
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
            <img src="/img/planCheck/导入.png"style="width: 20px;height: 20px;margin-top: -4px;">导入
        </button>
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

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>
<script type="text/html" id="subjectBarDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="detail">查看明细</a>
</script>
<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name=$(this).attr('name')
        $('.query_module [name='+name+']').val($.cookie(name) || '')
    })

    var tipIndex = null
    $('.icon_img').on('hover',function () {
        var tip = $(this).attr('text');
        tipIndex = layer.tips(tip, this);
    }, function () {
        layer.close(tipIndex);
    });

    // 表格显示顺序
    var colShowObj = {
        tgNo: {field: 'tgNo', title: '部门预算编号', sort: true, hide: false},
        deptName: {field: 'deptName', title: '所属部门', sort: true, hide: false},
        tgName: {field: 'tgName', title: '部门预算名称', sort: true, hide: false},
        budgetMoney: {field: 'budgetMoney', title: '预算金额', sort: true, hide: false},
        budgetYear: {field: 'budgetYear', title: '预算年度', sort: true, hide: false,},
        approvalStatus: {
            field: 'approvalStatus',title: '审批状态', width:250,sort: true, hide: false, templet: function (d) {
                if (d.approvalStatus == '1') {
                    var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                    return '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: orange;cursor: pointer;" ' + flowStr + '>审批中</span>'
                } else if (d.approvalStatus == '2') {
                    var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                    return '<span  class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>批准</span>'
                } else if (d.approvalStatus == '3') {
                    var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                    return '<span  class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>不批准</span>'
                } else {
                    return '未提交'
                }
            }
        },
        revisionCount: {
            field: 'revisionCount',
            title: '变更次数',
            minWidth: 120,
            hide: false,
            sort: true,
            event: 'revisionCount',
            style: 'cursor: pointer; color: blue;'
        }
    }

    var TableUIObj = new TableUI('plb_dept_budget');

    var dictionaryObj = {
        CONTROL_TYPE: {},
        BUDGET_YEAR: {},
        RBS_TYPE: {},
        RBS_CATEGORY: {},
        CBS_LEVEL: {},
        CBS_UNIT: {},
        CONTROL_MODE: {},
        RBS_UNIT: {},
    }
    var dictionaryStr = 'CONTROL_TYPE,BUDGET_YEAR,RBS_TYPE,RBS_CATEGORY,CBS_LEVEL,CBS_UNIT,CONTROL_MODE,RBS_UNIT';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        if(dict=='BUDGET_YEAR'){
                            dictionaryObj[dict]['str'] += '<option value=' + item.dictName + '>' + item.dictName + '</option>';
                        }else{
                            dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                        }
                    });
                }
            }
        }
    });

    layui.use(['form', 'table', 'soulTable', 'eleTree','element','laydate'], function () {
        var layForm = layui.form,
            layTable = layui.table,
            eleTree = layui.eleTree,
            soulTable = layui.soulTable,
            layElement = layui.element,
            laydate = layui.laydate;
        layForm.render();

        var tableObj = null;


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
        // 监听列表头部按钮事件
        layTable.on('toolbar(tableObj)', function (obj) {
            var checkStatus = layTable.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add': // 新增
                    if($('#leftId').attr('deptId')){
                        addOrEdit(1);
                    }else{
                        layer.msg('请选择左侧部门！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'del': // 删除
                    if (checkStatus.data.length == 0) {
                        layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
                        return false;
                    }
                    var deptBudgetIds = '';
                    var flag = false;
                    var checkData= checkStatus.data;

                    for(var i=0;i<checkData.length;i++){
                        deptBudgetIds += checkData[i].deptBudgetId + ',';
                        if(checkData[i].approvalStatus!='0'){
                            flag=true
                            break
                        }
                    }

                    if(flag){
                        layer.msg('有数据已提交，不可进行删除！', {icon: 0, time: 1500});
                        return false;
                    }

                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbDeptBudget/delete', {deptBudgetIds: deptBudgetIds,deptType:'01'}, function (res) {
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
                case 'import': // 导入
                    layer.msg('导入');
                    break;
                case 'export': // 导出
                    if( $('.export_moudle').is(":visible")){
                        $('.export_moudle').hide()
                    }else {
                        $('.export_moudle').show()
                    }
                    break;
                case 'viewBudgetReport':
                    viewBudgetReport()
                    break;
                case 'submit'://提交审批

                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                        return false;
                    }
                    var deptBudgetIds = checkStatus.data[0]
                    if (checkStatus.data[0].approvalStatus == '1') {
                        layer.msg('所选数据正在审批中，不可重复提交！', {icon: 0, time: 2000});
                        return false;
                    }
                    if (checkStatus.data[0].approvalStatus == '2' || checkStatus.data[0].approvalStatus == '3') {
                        layer.msg('所选数据已审批，不可重复提交！', {icon: 0, time: 2000});
                        return false;
                    }
                    submit(deptBudgetIds)
                // if($('#leftId').attr('deptId')){
                //     submit()
                // }else{
                //     layer.msg('请选择左侧部门！', {icon: 0, time: 1500});
                //     return false;
                // }
                // break;
            }
        });

        layTable.on('tool(tableObj)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if(layEvent === 'detail'){
                var loadIndex=layer.load();
                $.get('/plbDeptBudget/queryId',{deptBudgetId:data.deptBudgetId,deptType:'01'},function (res) {
                    layer.close(loadIndex);
                    addOrEdit(4,res.object)
                })

            }else if(layEvent === 'edit'){
                var loadIndex=layer.load();
                $.get('/plbDeptBudget/queryId',{deptBudgetId:data.deptBudgetId,deptType:'01'},function (res) {
                    layer.close(loadIndex);
                    if(res.object.approvalStatus == '0'){
                        addOrEdit(2, res.object);
                    }else{
                        layer.msg('该数据已提交，不可进行编辑！', {icon: 0, time: 1500});
                        return false;
                    }
                })
            }else if (layEvent === 'revisionCount') { // 变更记录
                if (data.revisionCount == 0) {
                    layer.msg('该数据未变更！', {icon: 0, time: 2000});
                    return false;
                }
                checkHistory(data);
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
                width: 150
            })
            var orderbyFields = upperFieldMatch(TableUIObj.orderbyFields)
            if (orderbyFields == 'REVISION_COUNT'){
                orderbyFields = ''
            }
            var option = {
                elem: '#tableObj',
                url: '/plbDeptBudget/selectAll?deptType=01',
                toolbar: '#toolbarHead',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-80',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    deptId: deptId,
                    orderbyFields: orderbyFields,
                    orderbyUpdown: TableUIObj.orderbyUpdown,
                    tgNo:$('.query_module [name="tgNo"]').val(),
                    tgName:$('.query_module [name="tgName"]').val(),
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
                    dataName: 'obj'
                },
                done: function () {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableObj');
                    });

                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit});
                    }
                    $('th[data-field="revisionCount"] span').eq(1).hide()
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

//导出
        $(document).on('click',function () {
            $('.export_moudle').hide();
        })
        $(document).on('click', '.export_btn',function () {
            var type=$(this).attr('type')
            var fileName='部门预算编制.xlsx'
            console.log(checkStatus)
            if(type==1){
                var checkStatus = layTable.checkStatus('tableObj');
                if (checkStatus.data.length == 0) {
                    layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                    return false;
                }
                soulTable.export(tableObj, {
                    filename: fileName,
                    checked: true
                });
            }else if(type==2){
                soulTable.export(tableObj,{
                    filename:fileName,
                    curPage: true
                })
            } else if(type==3){
                var load=layer.load(2)
                $.get('/plbDeptBudget/selectAll?deptType=01',function () {
                    soulTable.export(tableObj, {
                        filename: fileName
                    });
                    layer.close(load)
                })
            }
        })

        /**
         * 新增/编辑方法
         * @param type (1-新增，2-编辑,3-修编,4查看)
         * @param data (编辑时的预算信息)
         */
        function addOrEdit(type, data) {
            var title = '';
            var url = '';
            var deptId = $('#leftId').attr('deptId');
            var deptBudgetIdBack='';
            if (type == 1) {
                title = '新增预算'
                url = '/plbDeptBudget/insert'
            } else if (type == 2) {
                title = '编辑预算'
                url = '/plbDeptBudget/update'
            }
            else if (type == 3) {
                title = '编辑预算'
                url = '/plbDeptBudget/updateRevision'
            }else if (type == 4) {
                title = '查看详情'
            }

            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: ['保存', '取消'],
                btnAlign: 'c',
                content: ['<div class="layer_wrap"><div class="layui-collapse">',
                    /* region 预算 */
                    '<div class="layui-colla-item"><h2 class="layui-colla-title">预算</h2>' +
                    '<div class="layui-colla-content layui-show layui-form order_base_info" lay-filter="formTest">',
                    /* region 第一行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">部门预算编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="tgNo" autocomplete="off" readonly style="background: #e7e7e7" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">部门预算名称<span class="field_required">*</span></label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="tgName" autocomplete="off"  class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /* region 第二行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">预算金额</label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="budgetMoney" id="budgetMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">预算年度</label>' +
                    '<div class="layui-input-block form_block">' +
                    '<select id="budgetYear" name="budgetYear"></select>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /* region 第三行 */
                    '     <div class="layui-row">' +
                    '         <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">\n' +
                    '               <ul class="layui-tab-title">\n' +
                    '                   <li  class="layui-this">科目表</li>\n' +
                    '                   <li style="display: none">工作计划</li>\n' +
                    '                   <li >直接编制</li>\n' +
                    '               </ul>\n' +
                    '               <div class="layui-tab-content" >\n' +
                    '                    <div class="layui-tab-item layui-show mtl_infoSub">' +
                    '                          <div id="subjectModule">' +
                    '                               <table id="subjectTable" lay-filter="subjectTable"></table>' +
                    '                          </div>' +
                    '                    </div>\n' +
                    '                    <div class="layui-tab-item content"></div>\n' +
                    '                    <div class="layui-tab-item mtl_info">' +
                    '                          <div id="detailModule">' +
                    '                               <table id="detailTable" lay-filter="detailTable"></table>' +
                    '                          </div>' +
                    '                    </div>\n' +
                    '                </div>' +
                    '          </div> '+
                    '     </div>',
                    /* endregion */
                    '</div>' +
                    '</div>',
                    /* endregion */
                    /* region 预算明细 */
                    // '<div class="layui-colla-item">' +
                    // '<h2 class="layui-colla-title">预算明细</h2>' +
                    // '<div class="layui-colla-content layui-show mtl_info">' +
                    // '<div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>' +
                    // '</div>' +
                    // '</div>',
                    /* endregion */
                    '</div></div>'].join(''),
                success: function () {
                    //预算年度
                    $('#budgetYear').html(dictionaryObj['BUDGET_YEAR']['str'])
                    layForm.render()

                    var subjectTableData = [];
                    var materialDetailsTableData=[]

                    // 编辑时显示数据
                    if (type == 2 ||type == 3 ||type==4) {
                        layForm.val("formTest", data);
                        subjectTableData = data.plbDeptBudgetListWithBLOBs || [];
                        subjectTable(data.deptBudgetId);
                        if(type==4){
                            $('.layui-layer-btn-c').hide()
                            $('.order_base_info [name="tgName"]').attr('disabled','true')
                            $('.order_base_info [name="budgetYear"]').attr('disabled','true')
                            layForm.render()
                        }
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbDeptBudget'}, function(res) {
                            $('input[name="tgNo"]', $('.order_base_info')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbDeptBudget'}, function(res) {
                                $('input[name="tgNo"]', $('.order_base_info')).val(res);
                            });
                        });
                    }

                    layElement.on('tab(docDemoTabBrief)',function(tabData){

                        switch (tabData.index) {
                            case 0:
                                var index=layer.load()
                                var plbDeptBudgetWithBLOBs={}
                                // 材料明细数据
                                var $tr = $('.mtl_info').find('.layui-table-main tr');
                                var materialDetailsArr = [];
                                $tr.each(function () {
                                    var materialDetailsObj = {
                                        taskId: $(this).find('input[name="rbsItemId"]').attr('taskId'),
                                        deptBudgetId:$(this).find('input[name="rbsItemId"]').attr('deptBudgetId'),
                                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                        currentAmount: $(this).find('input[name="currentAmount"]').val(), // 预算金额
                                        controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                                        createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                                        createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                                        remark: $(this).find('input[name="remark"]').val(), // 备注
                                        pltId: $(this).find('input[name="remark"]').attr('pltId'), // 预算明细主键
                                        budgetType:'02',
                                        deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                                    }
                                    materialDetailsArr.push(materialDetailsObj);
                                });
                                plbDeptBudgetWithBLOBs.pltBudgetList = materialDetailsArr;
                                $.ajax({
                                    url: '/plbDeptBudget/insertOrUpdateBudget',
                                    data: JSON.stringify(plbDeptBudgetWithBLOBs),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success:function(res){
                                        layer.close(index)
                                        if(res.flag){
                                            if(deptBudgetIdBack){
                                                $.get('/plbDeptBudget/queryId',{deptBudgetId:deptBudgetIdBack},function (res) {
                                                    layForm.val("formTest", res.object);
                                                    subjectTableData = res.object.plbDeptBudgetListWithBLOBs || [];
                                                    subjectTable()
                                                })
                                            }
                                        }
                                    }
                                })
                                break;
                            case 1:
                                var index=layer.load()
                                var obj = {
                                    tgNo: $('.order_base_info input[name="tgNo"]').val(),
                                    tgName: $('.order_base_info input[name="tgName"]').val(),
                                    budgetMoney: $('.order_base_info input[name="budgetMoney"]').val(),
                                    budgetYear: $('#budgetYear').val(),
                                    deptType:'01'
                                }
                                var $tr = $('.mtl_infoSub').find('.layui-table-main tr');
                                var subjectTableDataArr = [];
                                $tr.each(function () {
                                    var subjectTableDataObj = {
                                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                        budgetMoney: $(this).find('.budgetMoney').text(), // 预算金额
                                        deptBudgetListId: $(this).find('input[name="rbsItemId"]').attr('deptBudgetListId'), // 预算明细主键
                                    }
                                    if ($(this).find('.remark').attr('deptBudgetListId')) {
                                        subjectTableDataObj.deptBudgetListId = $(this).find('.remark').attr('deptBudgetListId');
                                    }
                                    subjectTableDataArr.push(subjectTableDataObj);
                                });
                                obj.plbDeptBudgetListWithBLOBs = subjectTableDataArr;
                                if (type == 2  || type == 3) {
                                    obj.deptBudgetId = data.deptBudgetId
                                }else if(type == 1){
                                    obj.deptId = parseInt(deptId);
                                    obj.deptBudgetId = deptBudgetIdBack
                                }
                                $.ajax({
                                    url: url,
                                    data: JSON.stringify(obj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success:function(res){
                                        url = '/plbDeptBudget/update'
                                        subjectTableData = res.data.plbDeptBudgetListWithBLOBs || [];
                                        var backData=res.data
                                        deptBudgetIdBack=backData.deptBudgetId
                                        if(res.flag){
                                            var plbDeptBudgetWithBLOBs={}
                                            // 材料明细数据
                                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                                            var materialDetailsArr = [];
                                            $tr.each(function () {
                                                var materialDetailsObj = {
                                                    taskId: $(this).find('input[name="rbsItemId"]').attr('taskId'),
                                                    deptBudgetId:$(this).find('input[name="rbsItemId"]').attr('deptBudgetId'),
                                                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                                    currentAmount: $(this).find('input[name="currentAmount"]').val(), // 预算金额
                                                    controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                                                    createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                                                    createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                                                    remark: $(this).find('input[name="remark"]').val(), // 备注
                                                    pltId: $(this).find('input[name="remark"]').attr('pltId'), // 预算明细主键
                                                    budgetType:'02',
                                                    deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                                                }
                                                materialDetailsArr.push(materialDetailsObj);
                                            });
                                            plbDeptBudgetWithBLOBs.pltBudgetList = materialDetailsArr;
                                            $.ajax({
                                                url: '/plbDeptBudget/insertOrUpdateBudget',
                                                data: JSON.stringify(plbDeptBudgetWithBLOBs),
                                                dataType: 'json',
                                                contentType: "application/json;charset=UTF-8",
                                                type: 'post',
                                                success:function(res){
                                                    layer.close(index)
                                                    if(res.flag){
                                                        var pltDate=$('[name="budgetYear"]').val();
                                                        var iframeSrc='/pltTaskInfo/pltDetailList?deptId='+deptId+'&pltDate'+pltDate+'&pltType=02'
                                                        var innerHtml='<iframe style="width: 100%;height: 500px" src="'+iframeSrc+'"></iframe>'
                                                        $('.content').html(innerHtml)
                                                        subjectTable()
                                                        renderDetailTable(deptBudgetIdBack)
                                                    }
                                                }
                                            })
                                        }
                                    }
                                })
                                break;
                            case 2:
                                var index=layer.load()
                                var obj = {
                                    tgNo: $('.order_base_info input[name="tgNo"]').val(),
                                    tgName: $('.order_base_info input[name="tgName"]').val(),
                                    budgetMoney: $('.order_base_info input[name="budgetMoney"]').val(),
                                    budgetYear: $('#budgetYear').val(),
                                    deptType:'01'
                                }

                                // 材料明细数据
                                var $tr = $('.mtl_infoSub').find('.layui-table-main tr');
                                var subjectTableDataArr = [];
                                $tr.each(function () {
                                    var subjectTableDataObj = {
                                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                        budgetMoney: $(this).find('.budgetMoney').text(), // 预算金额
                                        deptBudgetListId: $(this).find('input[name="rbsItemId"]').attr('deptBudgetListId'), // 预算明细主键
                                    }
                                    if ($(this).find('.remark').attr('deptBudgetListId')) {
                                        subjectTableDataObj.deptBudgetListId = $(this).find('.remark').attr('deptBudgetListId');
                                    }
                                    subjectTableDataArr.push(subjectTableDataObj);
                                });
                                obj.plbDeptBudgetListWithBLOBs = subjectTableDataArr;
                                if (type == 2  || type == 3||type == 4) {
                                    obj.deptBudgetId = data.deptBudgetId
                                }else if(type == 1){
                                    obj.deptId = parseInt(deptId);
                                    obj.deptBudgetId = deptBudgetIdBack
                                }
                                $.ajax({
                                    url: url,
                                    data: JSON.stringify(obj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success:function(res){
                                        layer.close(index)
                                        url = '/plbDeptBudget/update'
                                        subjectTableData = res.data.plbDeptBudgetListWithBLOBs || [];
                                        var backData=res.data
                                        deptBudgetIdBack=backData.deptBudgetId
                                        if(res.flag){
                                            subjectTable()
                                            renderDetailTable(deptBudgetIdBack)
                                        }
                                    }
                                })
                                break;
                        }
                    })
                    subjectTable();
                    layElement.render();
                    //初始化科目表
                    function subjectTable(){
                        var cols=[
                            {type: 'numbers', title: '序号',},
                            {
                                field: 'rbsItemId',
                                title: '预算科目名称',
                                minWidth: 120,
                                templet: function (d) {
                                    return '<input type="text" name="rbsItemId" deptBudgetListId="'+(d.deptBudgetListId || '')+'"  rbsItemId="'+(d.rbsItemId || '')+'"  value="'+(d.rbsItemName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%;" >'
                                }
                            },
                            {
                                field: 'budgetMoney', title: '本年预算金额', minWidth: 120, templet: function (d) {
                                    return '<span class="budgetMoney">'+isShowNull(d.budgetMoney)+'</span>'
                                }
                            },
                        ]
                        if(type!=4){
                            cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                        }
                        layTable.render({
                            elem: '#subjectTable',
                            data: subjectTableData,
                            defaultToolbar: [''],
                            toolbar:'#toolbarDemoIn',
                            limit: 1000,
                            cols: [cols],
                            done:function () {
                                if(type==4){
                                    $('.addRow').hide()
                                }
                            }
                        });
                    }
                    // 初始化预算明细列表
                    function renderDetailTable(deptBudgetId) {
                        $.ajax({
                            url: '/plbDeptBudget/getDataByTaskId?taskId='+deptBudgetId,
                            async:false,
                            type:'post',
                            success:function(res){
                                materialDetailsTableData=res.data
                                materialDetailsTableData.forEach(function(item){
                                    item.rbsItemId=item.plbDeptBudgetList.rbsItemId
                                    item.rbsItemName=item.plbDeptBudgetList.rbsItemName
                                })
                            }
                        })
                        var cols=[
                            {type: 'numbers', title: '序号',},
                            {
                                field: 'rbsItemId',
                                title: '预算科目名称',
                                minWidth: 120,
                                templet: function (d) {
                                    return '<input type="text" name="rbsItemId" taskId="'+(d.taskId||'')+'" deptBudgetListId="'+(d.deptBudgetListId || '')+'"  rbsItemId="'+(d.rbsItemId || '')+'"  value="'+(d.rbsItemName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%;" >'
                                }
                            },
                            {
                                field: 'currentAmount', title: '预算金额', minWidth: 120, templet: function (d) {
                                    return '<input type="number" name="currentAmount" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input currentAmountItem" style="height: 100%" value="' + (d.currentAmount || '') + '">'
                                }
                            },
                            {
                                field: 'createStandard', title: '编制标准', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="createStandard" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createStandard || '') + '">'
                                }
                            },
                            {
                                field: 'createRemark', title: '编制说明', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="createRemark" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createRemark || '') + '">'
                                }
                            },
                            {
                                field: 'remark', title: '备注', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="remark" '+(type==4 ? 'readonly' : '')+' pltId="'+(d.pltId || '')+'" deptBudgetListId="'+(d.deptBudgetListId || '')+'"  autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.remark || '') + '">'
                                }
                            },
                        ]
                        if(type!=4){
                            cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                        }
                        layTable.render({
                            elem: '#detailTable',
                            data:materialDetailsTableData,
                            toolbar: '#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols],
                            done:function () {
                                if(type==4){
                                    $('.addRow').hide()
                                }
                            }
                        });
                    }
                    layTable.on('toolbar(subjectTable)',function(obj){
                        var layEvent=obj.event
                        if(layEvent=='add'){
                            layer.open({
                                type: 1,
                                title: '选择RBS',
                                area: ['60%', '70%'],
                                maxmin: true,
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div style="padding: 0px 10px">'+
                                '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                                '                <div class="layui-col-xs3">\n' +
                                '                    <input type="text" name="cbsName" placeholder="会计科目名称" autocomplete="off" class="layui-input">\n' +
                                '                </div>\n' +
                                '                <div class="layui-col-xs3" style="margin-left: 10px">\n' +
                                '                    <input type="text" name="rbsItemName" placeholder="预算科目名称" autocomplete="off" class="layui-input">\n' +
                                '                </div>\n' +
                                '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                                '                    <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                                '                </div>\n' +
                                '</div>' +
                                '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                                '</div>'].join(''),
                                success: function () {
                                    loadMtlTable();

                                    function loadMtlTable(cbsName,rbsItemName) {
                                        layTable.render({
                                            elem: '#materialsTable',
                                            url: '/plbRbsItem/selectAll',
                                            where: {
                                                rbsTypeId: '01',
                                                useFlag:true,
                                                cbsName:cbsName,
                                                rbsItemName:rbsItemName,
                                                budgetoccupy:'0',
                                                versionNumber:'1'
                                            },
                                            page: true,
                                            response: {
                                                statusName: 'flag',
                                                statusCode: true,
                                                msgName: 'msg',
                                                countName: 'totleNum',
                                                dataName: 'data'
                                            },
                                            cols: [[
                                                {type: 'checkbox', title: '选择'},
                                                // {
                                                //     field: 'rbsItemType', title: 'RBS类型', templet: function (d) {
                                                //         return dictionaryObj['RBS_TYPE']['object'][d.rbsItemType] || '';
                                                //     }
                                                // },
                                                // {
                                                //     field: 'rbsItemCategory', title: 'RBS类别', templet: function (d) {
                                                //         return dictionaryObj['RBS_CATEGORY']['object'][d.rbsItemCategory] || '';
                                                //     }
                                                // },
                                                // {
                                                //     field: 'rbsUnit', title: '单位', templet: function (d) {
                                                //         return dictionaryObj['RBS_UNIT']['object'][d.rbsUnit] || '';
                                                //     }
                                                // },
                                                //{field: 'cbsName', title: '会计科目名称'},
                                                {field: 'rbsItemName', title: '预算科目名称'},
                                                //{field:'rbsTypeName',title:'科目类型',},
                                            ]]
                                        });
                                    }

                                    $(document).on('click','.inSearchData',function () {
                                        var cbsName=$('.query_module_in [name="cbsName"]').val()
                                        var rbsItemName=$('.query_module_in [name="rbsItemName"]').val()
                                        loadMtlTable(cbsName,rbsItemName);
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = layTable.checkStatus('materialsTable');
                                    if (checkStatus.data.length > 0) {
                                        var trData = checkStatus.data;

                                        //遍历表格获取每行数据进行保存
                                        var $tr = $('.mtl_infoSub').find('.layui-table-main tr');
                                        var oldDataArr = []
                                        $tr.each(function () {
                                            var oldDataObj = {
                                                rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                                rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                                                budgetMoney: $(this).find('input[name="budgetMoney"]').val(), // 预算金额
                                                deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                                            }
                                            oldDataArr.push(oldDataObj);
                                        });
                                        /*var addRowData = {};
                                         oldDataArr.push(addRowData);*/
                                        //具体明细可多选
                                        trData.forEach(function (item) {
                                            var addRowData={
                                                rbsItemId: item.rbsItemId,//rbsId
                                                rbsItemName: item.rbsItemName,//rbs名称
                                            }
                                            oldDataArr.push(addRowData)
                                        })
                                        layTable.reload('subjectTable', {
                                            data: oldDataArr
                                        });

                                        layer.close(index);


                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        }
                    })
                    layTable.on('tool(subjectTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            obj.del();
                            if (data.deptBudgetListId) {
                                $.get('/plbDeptBudget/deleteListId', {deptBudgetListId: data.deptBudgetListId,deptType:'01'}, function (res) {
                                    if(res.flag){
                                        $.get('/plbDeptBudget/queryId',{deptBudgetId:deptBudgetIdBack},function (res) {
                                            layForm.val("formTest", res.object);
                                        })
                                    }

                                });
                            }
                            //遍历表格获取每行数据进行保存
                            var $tr = $('.mtl_infoSub').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $tr.each(function () {
                                var oldDataObj = {
                                    rbsItemName:$(this).find('input[name="rbsItemId"]').val(),
                                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                    budgetMoney: $(this).find('.budgetMoney').text(), // 预算金额
                                    deptBudgetListId: $(this).find('input[name="rbsItemId"]').attr('deptBudgetListId'), // 预算明细主键
                                }
                                oldDataArr.push(oldDataObj);
                            });
                            layTable.reload('subjectTable', {
                                data: oldDataArr
                            });
                        }
                    });
                    // 内部加行按钮
                    layTable.on('toolbar(detailTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                layer.open({
                                    type: 1,
                                    title: '选择科目',
                                    area: ['60%', '70%'],
                                    maxmin: true,
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div style="padding: 0px 10px">'+
                                    '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                                    '                <div class="layui-col-xs3">\n' +
                                    '                    <input type="text" name="cbsName" placeholder="会计科目名称" autocomplete="off" class="layui-input">\n' +
                                    '                </div>\n' +
                                    '                <div class="layui-col-xs3" style="margin-left: 10px">\n' +
                                    '                    <input type="text" name="rbsItemName" placeholder="预算科目名称" autocomplete="off" class="layui-input">\n' +
                                    '                </div>\n' +
                                    '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                                    '                    <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                                    '                </div>\n' +
                                    '</div>' +
                                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                                    '</div>'].join(''),
                                    success: function () {
                                        loadMtlTable();

                                        function loadMtlTable(cbsName,rbsItemName) {
                                            layTable.render({
                                                elem: '#materialsTable',
                                                url: '/plbDeptBudget/getDeptBudgetList?deptBudgetId='+deptBudgetIdBack,
                                                where: {
                                                    rbsTypeId: '01',
                                                    useFlag:true,
                                                    cbsName:cbsName,
                                                    rbsItemName:rbsItemName,
                                                    budgetoccupy:'0',
                                                    versionNumber:'1'
                                                },
                                                page: true,
                                                parseData: function (res) {
                                                    return {
                                                        "code": 0, //解析接口状态
                                                        "data": res.obj,//解析数据列表
                                                        "count":res.totleNum, //解析数据长度
                                                    };
                                                },
                                                cols: [[
                                                    {type: 'checkbox', title: '选择'},
                                                    {field: 'rbsItemName', title: '预算科目名称'},
                                                ]]
                                            });
                                        }

                                        $(document).on('click','.inSearchData',function () {
                                            var cbsName=$('.query_module_in [name="cbsName"]').val()
                                            var rbsItemName=$('.query_module_in [name="rbsItemName"]').val()
                                            loadMtlTable(cbsName,rbsItemName);
                                        });
                                    },
                                    yes: function (index) {
                                        var checkStatus = layTable.checkStatus('materialsTable');
                                        if (checkStatus.data.length > 0) {
                                            var trData = checkStatus.data;

                                            //遍历表格获取每行数据进行保存
                                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                                            var oldDataArr = []
                                            $tr.each(function () {
                                                var oldDataObj = {
                                                    taskId: $(this).find('input[name="rbsItemId"]').attr('taskId'),
                                                    deptBudgetId:$(this).find('input[name="rbsItemId"]').attr('deptBudgetId'),
                                                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                                    rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId
                                                    currentAmount: $(this).find('input[name="currentAmount"]').val(), // 预算金额
                                                    controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                                                    createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                                                    createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                                                    remark: $(this).find('input[name="remark"]').val(), // 备注
                                                    pltId: $(this).find('input[name="remark"]').attr('pltId'), // 预算明细主键
                                                    budgetType:'02',
                                                    deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                                                }
                                                oldDataArr.push(oldDataObj);
                                            });
                                            //具体明细可多选
                                            trData.forEach(function (item) {
                                                var addRowData={
                                                    rbsItemId: item.rbsItemId,//rbsId
                                                    rbsItemName: item.rbsItemName,//rbs名称
                                                    rbsUnit: item.rbsUnit,//单位
                                                    deptBudgetListId:item.deptBudgetListId,
                                                    taskId:deptBudgetIdBack
                                                }
                                                oldDataArr.push(addRowData)
                                            })
                                            layTable.reload('detailTable', {
                                                data: oldDataArr
                                            });
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                                break;
                        }
                    });
                    // 内部删行操作
                    layTable.on('tool(detailTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;
                        if (layEvent === 'del') {
                            obj.del();
                            if (data.pltId) {
                                $.get('/pltTaskInfo/delPltBudget', {pltId: data.pltId,deptType:'01'}, function (res) {
                                    $.get('/plbDeptBudget/queryId',{deptBudgetId:deptBudgetIdBack},function (res) {
                                        layForm.val("formTest", res.object);
                                        subjectTableData = res.object.plbDeptBudgetListWithBLOBs || [];
                                        subjectTable()
                                    })
                                });
                            }
                            //遍历表格获取每行数据进行保存
                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $tr.each(function () {
                                var oldDataObj = {
                                    taskId: $(this).find('input[name="rbsItemId"]').attr('taskId'),
                                    deptBudgetId:$(this).find('input[name="rbsItemId"]').attr('deptBudgetId'),
                                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                    rbsItemName: $(this).find('input[name="rbsItemId"]').val(),
                                    currentAmount: $(this).find('input[name="currentAmount"]').val(), // 预算金额
                                    controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                                    createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                                    createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                                    remark: $(this).find('input[name="remark"]').val(), // 备注
                                    pltId: $(this).find('input[name="remark"]').attr('pltId'), // 预算明细主键
                                    budgetType:'02',
                                    deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                                }
                                oldDataArr.push(oldDataObj);
                            });
                            layTable.reload('detailTable', {
                                data: oldDataArr
                            });
                        }
                    });
                },
                yes: function (index) {
                    var loadIndex = layer.load();
                    // 材料订单数据
                    var obj = {
                        tgNo: $('.order_base_info input[name="tgNo"]').val(),
                        tgName: $('.order_base_info input[name="tgName"]').val(),
                        budgetMoney: $('.order_base_info input[name="budgetMoney"]').val(),
                        budgetYear: $('#budgetYear').val(),
                        deptType:'01'
                    }

                    // 材料明细数据
                    var $tr = $('.mtl_infoSub').find('.layui-table-main tr');
                    var subjectTableDataArr = [];
                    $tr.each(function () {
                        var subjectTableDataObj = {
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            budgetMoney: $(this).find('input[name="budgetMoney"]').val(), // 预算金额
                            deptBudgetListId: $(this).find('input[name="rbsItemId"]').attr('deptBudgetListId'), // 预算明细主键
                            deptBudgetId:deptBudgetIdBack
                        }
                        if ($(this).find('.remark').attr('deptBudgetListId')) {
                            subjectTableDataObj.deptBudgetListId = $(this).find('.remark').attr('deptBudgetListId');
                        }
                        subjectTableDataArr.push(subjectTableDataObj);
                    });
                    obj.plbDeptBudgetListWithBLOBs = subjectTableDataArr;
                    if (type == 2  || type == 3) {
                        obj.deptBudgetId = data.deptBudgetId
                    }else if(type == 1){
                        obj.deptId = parseInt(deptId);
                        obj.deptBudgetId = deptBudgetIdBack
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
                                tableObj.config.where._ = new Date().getTime();
                                tableObj.reload();
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }
                    });
                },
            });
        }

        /**
         * 生成预算报表方法
         */
        function viewBudgetReport() {
            layer.open({
                type: 1,
                title: '预算报表',
                area: ['100%', '100%'],
                maxmin: true,
                content: [//表格数据
                    '       <div style="padding: 0px 8px">' +
                    '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                    '      </div>'].join(''),
                success: function () {
                    layTable.render({
                        elem: '#managementBudgetTable',
                        url: '/plbDeptBudget/deptBudgetItem?deptType=01',
                        where: {
                            deptId: $('#leftId').attr('deptId'),
                        },
                        page: true,
                        request: {
                            limitName: 'pageSize'
                        },
                        response: {
                            statusName: 'flag',
                            statusCode: true,
                            msgName: 'msg',
                            countName: 'totleNum',
                            dataName: 'obj'
                        },
                        cols: [[
                            {field: 'cbsNo', title: '核算科目编号',},
                            {field: 'cbsName', title: '核算科目名称',},
                            {field: 'rbsItemNo', title: '预算科目编号',},
                            {field: 'rbsItemName', title: '预算科目名称',},
                        ]]
                    });
                },
            });
        }

        //点击预算科目名称显示关联的预算相关信息
        $(document).on('click','.relationDetail',function () {
            var cbsId=$(this).attr('cbsId')
            layer.open({
                type: 1,
                title: '预算',
                area: ['80%', '70%'],
                maxmin: true,
                content: [//表格数据
                    '       <div style="padding: 0px 8px">' +
                    '           <table id="relationDetail" lay-filter="relationDetail"></table>' +
                    '      </div>'].join(''),
                success: function () {
                    layTable.render({
                        elem: '#relationDetail',
                        url: '/plbDeptBudget/getTGbyBudgetItemId?deptType=01',
                        where: {
                            cbsId:cbsId,
                        },
                        page: true,
                        request: {
                            limitName: 'pageSize'
                        },
                        response: {
                            statusName: 'flag',
                            statusCode: true,
                            msgName: 'msg',
                            countName: 'totleNum',
                            dataName: 'obj'
                        },
                        cols: [[
                            {field: 'tgNo', title: '部门预算编号',},
                            {field: 'tgName', title: '部门预算名称',},
                            {field: 'budgetMoney', title: '预算金额'},
                            {field: 'remark', title: '备注'},
                        ]]
                    });
                },
            });
        })

        //提交审批
        function submit(deptBudgetIds){
            layer.open({
                type: 1,
                title: '选择预算年度',
                area: ['30%', '30%'],
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: [//预算年度
                    '       <div class="layui-form">' +
                    '           <div class="layui-form-item" style="margin: 20px 10px">' +
                    '               <label class="layui-form-label" style="width: auto">预算年度</label>' +
                    '               <div class="layui-input-block" style="margin-left:88px">' +
                    '                   <select id="submitBudgetYear" name="submitBudgetYear"></select>' +
                    '               </div>' +
                    '           </div>' +
                    '      </div>'].join(''),
                success: function () {
                    $('#submitBudgetYear').html(dictionaryObj['BUDGET_YEAR']['str'])
                    layForm.render()
                },
                yes:function (index) {
                    $.get('/plbDeptBudget/selectSubmit',{budgetYear:$('#submitBudgetYear').val(),deptId:$('#leftId').attr('deptId'),submitFlag:1},function (res) {
                        if(res.flag){
                            var data=res.obj
                            var flowDataArr=[]
                            var flowData;
                            $.ajax({
                                url:'/plbFlowSetting/getOwnFlowData',
                                data:{plbDictNo:'01'},
                                async:false,
                                success:function(res){
                                    if(res.data && res.data.flowData){
                                        flowData=res.data.flowData
                                        $.each(flowData, function (k, v) {
                                            flowDataArr.push({
                                                flowId: k,
                                                flowName: v
                                            });
                                        });
                                    }
                                }
                            })
                            if(flowDataArr.length===1){
                                var urlParameter ='budgetYear='+$('#submitBudgetYear').val()+'&deptId='+$('#leftId').attr('deptId')
                               var approvalData= JSON.stringify(deptBudgetIds)
                                // var relationIds=''
                                // data.forEach(function (item,index) {
                                //     relationIds+=item.deptBudgetId+','
                                // })
                                newWorkFlow(flowDataArr[0].flowId, urlParameter,approvalData, function (res) {
                                    var submitData = {
                                        deptId:$('#leftId').attr('deptId'),
                                        runId: res.flowRun.runId,
                                        dataYear: $('#submitBudgetYear').val()
                                        // relationIds: relationIds,
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowDataArr[0].flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.get('/plbDeptBudget/updateApprovalStatus',{deptBudgetIds:deptBudgetIds.deptBudgetId,approvalStatus:1,runId:res.flowRun.runId,deptType:'01'},function (res) {
                                        tableObj.reload();
                                    })
                                    $.ajax({
                                        url: '/plbDeptBudget/approval',
                                        data: submitData,
                                        dataType: 'json',
                                        type: 'post',
                                        success: function (res) {
                                            layer.closeAll();
                                            if (res.flag) {
                                                layer.closeAll();
                                                layer.msg('提交成功!', {icon: 1});
                                                tableObj.config.where._ = new Date().getTime();
                                                tableObj.reload();
                                            } else {
                                                layer.msg(res.msg, {icon: 2});
                                            }
                                        }
                                    });
                                });
                                layer.close(index);
                                // newWorkFlow(flowDataArr[0].flowId,urlParameter);
                            }else{
                                layer.open({
                                    type: 1,
                                    title: '提交审批',
                                    area: ['80%', '70%'],
                                    btn: ['提交', '取消'],
                                    btnAlign: 'c',
                                    content: [//表格数据
                                        '       <div style="padding: 0px 8px">' +
                                        '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                                        '           <h2>请选择流程</h2>' +
                                        '           <div id="flowSelect" class="layui-form"></div>'+
                                        '      </div>'].join(''),
                                    success: function () {
                                        layTable.render({
                                            elem: '#managementBudgetTable',
                                            data:data,
                                            cols: [[
                                                {field: 'tgNo', title: '部门预算编号',},
                                                {field: 'tgName', title: '部门预算名称', },
                                                {field: 'budgetMoney', title: '预算金额',},
                                                {field: 'budgetYear', title: '预算年度',},
                                                {field: 'approvalStatus', title: '审批状态',templet: function (d) {
                                                        if (d.approvalStatus == '0') {
                                                            return '未提交';
                                                        } else if (d.approvalStatus == '1') {
                                                            return '审批中';
                                                        } else if (d.approvalStatus == '2') {
                                                            return '批准';
                                                        }else if (d.approvalStatus == '3'){
                                                            return '不批准'
                                                        }else{
                                                            return ''
                                                        }
                                                    }
                                                },
                                            ]]
                                        });
                                        //选择流程
                                        var str=''
                                        for(var i in flowData){
                                            str+='<div  class="flowSelectRadio"><input type="radio" name="flow" value="'+i+'" title="'+flowData[i]+'"></div>'
                                        }
                                        $('#flowSelect').html(str)
                                        layForm.render()
                                        // $.get('/plbFlowSetting/getDataByCondition',{plbDictNo:'01'},function (res) {
                                        //     if(res.data && res.data.flowData){
                                        //         var flowData=res.data.flowData
                                        //         var str=''
                                        //         for(var i in flowData){
                                        //             str+='<div  class="flowSelectRadio"><input type="radio" name="flow" value="'+i+'" title="'+flowData[i]+'"></div>'
                                        //         }
                                        //         $('#flowSelect').html(str)
                                        //         layForm.render()
                                        //     }
                                        // })
                                    },
                                    yes:function (index) {
                                        var $trs = $('#managementBudgetTable').next().find('.layui-table-body tr')
                                        if($trs.length == 0){
                                            layer.msg('当前无数据可提交审批！', {icon: 0});
                                            return false
                                        }

                                        var loadIndex = layer.load();
                                        var flag=false
                                        var flowId=''
                                        $('.flowSelectRadio [name="flow"]').each(function () {
                                            if($(this).prop('checked')){
                                                flag=true
                                                flowId=$(this).val()
                                                return false
                                            }
                                        })
                                        if (flag) {
                                            var urlParameter ='budgetYear='+$('#submitBudgetYear').val()+'&deptId='+$('#leftId').attr('deptId')
                                            // var relationIds=''
                                            // data.forEach(function (item,index) {
                                            //     relationIds+=item.deptBudgetId+','
                                            // })
                                            var approvalData= JSON.stringify(deptBudgetIds)
                                            newWorkFlow(flowId, urlParameter, approvalData,function (res) {
                                                var submitData = {
                                                    deptId:$('#leftId').attr('deptId'),
                                                    runId: res.flowRun.runId,
                                                    dataYear: $('#submitBudgetYear').val()
                                                    // relationIds: relationIds,
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.get('/plbDeptBudget/updateApprovalStatus',{deptBudgetIds:deptBudgetIds.deptBudgetId,approvalStatus:1,runId:res.flowRun.runId,deptType:'01'},function (res) {

                                                })
                                                $.ajax({
                                                    url: '/plbDeptBudget/approval',
                                                    data: submitData,
                                                    dataType: 'json',
                                                    type: 'post',
                                                    success: function (res) {
                                                        layer.close(loadIndex);
                                                        if (res.flag) {
                                                            layer.closeAll();
                                                            layer.msg('提交成功!', {icon: 1});
                                                            layer.close(index);
                                                            tableObj.config.where._ = new Date().getTime();
                                                            tableObj.reload();
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

                        }

                    })
                }
            });
        }


        //监听预算金额
        // $(document).on('blur', '.currentAmountItem', function () {
        //     var $tr = $('.mtl_info').find('.layui-table-main tr');
        //     var currentAmount=0
        //     $tr.each(function () {
        //         currentAmount=accAdd(currentAmount,$(this).find('input[name="currentAmount"]').val())
        //     });
        //     $('#budgetMoney').val(currentAmount)
        // });

        //点击查询
        $('.searchData').on('click',function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                // 将查询值保存至cookie中
                $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
            })
            tableObj.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        /*用来得到精确的加法结果
         *说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
         *调用：accAdd(arg1,arg2)
         *返回值：arg1加上arg2的精确结果
         */
        function accAdd(arg1,arg2){
            var r1,r2,m;
            try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
            try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
            m=Math.pow(10,Math.max(r1,r2))
            return (arg1*m+arg2*m)/m
        }

        /**
         * 新建流程方法
         * @param flowId
         * @param urlParameter
         * @param cb
         */
        function newWorkFlow(flowId, urlParameter,approvalData, cb) {
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
                    isTabApproval: false,
                    urlParameter: urlParameter,
                    approvalData:approvalData,


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

        $(document).on('click', '.cbsIdChoose', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    '<div class="wrapper">',
                    '<div class="wrap_left">' +
                    '<div class="layui-form">' +
                    '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
                    '<div class="tree_module" style="top: 10px;">' +
                    '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="wrap_right">' +
                    '<div class="mtl_table_box" style="display: none;">' +
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img">' +
                    '<img style="margin-top: 12%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.cbsNo) {
                            $('.mtl_no_data').hide();
                            $('.mtl_table_box').show();
                            loadMtlTable(currentData.cbsNo);
                        } else {
                            $('.mtl_table_box').hide();
                            $('.mtl_no_data').show();
                        }
                    });

                    loadMtlType();

                    function loadMtlType() {
                        // 获取左侧树
                        $.get('/plbCbsType/getParentList', function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: true,
                                    request: {
                                        name: "cbsName", // 显示的内容
                                        key: "cbsNo", // 节点id
                                        parentId: 'parentCbsNo', // 节点父id
                                        isLeaf: "isLeaf",// 是否有子节点
                                        children: 'childList',
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(cbsNo) {
                        layTable.render({
                            elem: '#materialsTable',
                            url: '/plbCbsType/getCbsTypeList',
                            where: {
                                cbsNo:cbsNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-300',
                            cellMinWidth:100,
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'cbsNo', title: 'CBS编码', width: 200}
                                , {field: 'cbsName', title: 'CBS名称',  width: 150}
                                , {field: 'cbsLevel', title: 'CBS级别', width: 150,templet:function (d) {
                                        return dictionaryObj['CBS_LEVEL']['object'][d.cbsLevel] || ''
                                    }}
                                , {field: 'cbsUnit', title: 'CBS单位', width: 150,templet:function (d) { return dictionaryObj['CBS_UNIT']['object'][d.cbsUnit] || '' }}
                                , {field: 'controlMode', title: '控制方式',templet:function (d) { return dictionaryObj['CONTROL_MODE']['object'][d.controlMode] || '' }},

                            ]],
                            parseData: function (res) {
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data,//解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            },
                            request: {
                                pageName: 'page', //页码的参数名称，默认：page
                                limitName: 'pageSize' //每页数据量的参数名，默认：limit
                            },
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = layTable.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        //部门预算编制中,每一个部门下，同一年份，一个科目只允许编制一次
                        /*var deptId=$('#leftId').attr('deptId')
                         var budgetYear=$('#budgetYear').val()
                         var cbsIds=mtlData.cbsId
                         $.get('/plbDeptBudget/checkCbs',{deptId:deptId,budgetYear:budgetYear,cbsIds:cbsIds},function (res) {
                         if(res.object > 0){
                         layer.msg('每一个部门下，同一年份，一个科目只允许编制一次！', {icon: 0, time: 2000});
                         }else{
                         _this.val(mtlData.cbsName);
                         _this.attr('cbsId',mtlData.cbsId);
                         layer.close(index);
                         }
                         })*/

                        _this.val(mtlData.cbsName);
                        _this.attr('cbsId',mtlData.cbsId);
                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });

        $(document).on('click', '.preview_flow', function() {
            var formUrl = $(this).attr('formUrl');
            if (formUrl) {
                $.popWindow(formUrl);
            }
        });

        //查看变更数据
        function checkHistory(data) {
            var list = []
            var formData=[]
            var deptBudgetId = data.deptBudgetId
            $.get('/plbDeptBudget/getVersionHistory', {
                deptBudgetId: deptBudgetId,
                deptType:'01',
            }, function (res) {
                formData=res.data
                for (var i = 0; i < res.data.length; i++) {
                    var fileStr = getFileEleStr(res.data.attachments, false);
                    var content = [
                        '<div class="layui-collapse">\n',
                        '  <div class="layui-colla-item">\n' +
                        '    <h2 class="layui-colla-title">' + res.data[i].version + '</h2>\n' +
                        '    <div class="layui-colla-content layui-show plan_base_info">' +
                        '<form class="layui-form" lay-filter="formContentTest' + i + '" style="padding: 0px 10px">',
                        /* region 第一行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">部门预算编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="tgNo" autocomplete="off" readonly style="background: #e7e7e7" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">部门预算名称<span class="field_required">*</span></label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="tgName" autocomplete="off"  class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '</div>',
                        /* endregion */
                        /* region 第二行 */
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">预算金额</label>' +
                        '<div class="layui-input-block form_block">' +
                        '<input type="text" name="budgetMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="layui-col-xs6" style="padding: 0 5px">' +
                        '<div class="layui-form-item">' +
                        '<label class="layui-form-label form_label">预算年度</label>' +
                        '<div class="layui-input-block form_block">' +
                        '<select  name="budgetYear"></select>' +
                        '</div>' +
                        '</div>' +
                        '</div>'+
                        '</div>',
                        /* endregion */
                        // '</div>' +
                        // '</div>',
                        /* endregion */
                        /* region 预算明细 */
                        '<div class="layui-collapse">'+
                        '<div class="layui-colla-item">' +
                        '<h2 class="layui-colla-title">预算明细</h2>' +
                        '<div class="layui-colla-content layui-show mtl_info">' +
                        '<div id="detailModule"><table id="detailTable' + i + '" lay-filter="detailTable' + i + '"></table>' +
                        '</div>' +
                        '</div>'+
                        '</div>'+
                        '</div>',
                        /* endregion */
                        '</form>',
                        '    </div>\n' +
                        '  </div>\n',
                        '</div>'
                    ].join('');

                    list += content
                }
                layer.open({
                    type: 1,
                    title: "查看历史数据",
                    area: ['100%', '100%'],
                    btn: ['关闭'],
                    btnAlign: 'c',
                    content: list,
                    success: function () {
                        $('[name="budgetYear"]').html(dictionaryObj['BUDGET_YEAR']['str'])
                        for(var j=0;j<formData.length;j++){
                            layForm.val('formContentTest'+j,formData[j])
                            layTable.render({
                                elem:'#detailTable'+j,
                                data:formData[j].plbDeptBudgetListWithBLOBs,
                                cols:[[
                                    {type: 'numbers', title: '序号',},
                                    {
                                        field: 'rbsItemId',
                                        title: '预算科目名称',
                                        minWidth: 120,
                                        templet: function (d) {
                                            return '<input type="text" name="rbsItemId"  rbsItemId="'+(d.rbsItemId || '')+'"  value="'+(d.rbsItemName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%;" >'
                                        }
                                    },
                                    {
                                        field: 'cbsId',
                                        title: '会计科目名称',
                                        minWidth: 120,
                                        templet: function (d) {
                                            return '<input type="text" name="cbsId" cbsId="'+(d.cbsId || '')+'"   value="'+(d.cbsName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" >'
                                        }
                                    },
                                    {
                                        field: 'budgetMoney', title: '预算金额', minWidth: 120, templet: function (d) {
                                            return '<input type="number" name="budgetMoney"  autocomplete="off" class="layui-input budgetMoneyItem" style="height: 100%" value="' + (d.budgetMoney || '') + '">'
                                        }
                                    },
                                    {
                                        field: 'controlType',
                                        title: '控制方式',
                                        minWidth: 120,
                                        event: type==4 ? '' : 'chooseControlType',
                                        templet: function (d) {
                                            return '<input type="text" name="controlType" controlType="'+(d.controlType || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" value="'+(dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '')+'" >'
                                        }
                                    },
                                    {
                                        field: 'createStandard', title: '编制标准', minWidth: 120, templet: function (d) {
                                            return '<input type="text" name="createStandard"  autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createStandard || '') + '">'
                                        }
                                    },
                                    {
                                        field: 'createRemark', title: '编制说明', minWidth: 120, templet: function (d) {
                                            return '<input type="text" name="createRemark"  autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createRemark || '') + '">'
                                        }
                                    },
                                    {
                                        field: 'remark', title: '备注', minWidth: 120, templet: function (d) {
                                            return '<input type="text" name="remark"  deptBudgetListId="'+(d.deptBudgetListId || '')+'" autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.remark || '') + '">'
                                        }
                                    },
                                ]]
                            })
                        }
                        layElement.render();
                        layForm.render();
                    }
                });
            });
        }
    });
</script>
</body>
</html>