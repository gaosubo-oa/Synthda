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
    <title>材料需求计划变更</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>

    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.11"></script>

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
            margin-left: 2%;
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
            <h2 style="text-align: center;line-height: 35px;">材料需求计划变更</h2>
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
                    <input type="text" name="planNo" placeholder="计划单编号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="planName" placeholder="计划名称" autocomplete="off" class="layui-input">
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
                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
<%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
                </div>
                <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>
            </div>
            <div style="position: relative">
                <div class="table_box" style="display: none">
                    <table id="tableDemo" lay-filter="tableDemo"></table>
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
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="revision">变更</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="submit">提交审批</button>
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


<%--修编中编辑--%>
<script type="text/html" id="revisionBarDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="edit">编辑</a>
</script>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name=$(this).attr('name')
        $('.query_module [name='+name+']').val($.cookie(name) || '')
    })

    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT';
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
        //导出数据
        var exportData = '';
        //表格显示顺序
        var colShowObj = {
            planNo: {field: 'planNo', title: '计划单编号', sort: true, hide: false},
            planName: {field: 'planName', title: '计划名称', sort: true, hide: false},
            projectName:{field:'projName',title:'所属项目',sort:true,hide:false},
            currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
            auditerStatus: {
                field: 'auditerStatus',
                title: '审批状态',
                sort: true,
                hide: false,
                templet: function (d) {
                    if (d.auditerStatus == '0') {
                        return '未提交';
                    } else if (d.auditerStatus == '1') {
                        return '<span style="color: orange">审批中</span>';
                    } else if (d.auditerStatus == '2') {
                        return '<span style="color: green">批准</span>'
                    }else if (d.auditerStatus == '3'){
                        return '<span style="color: red">不批准</span>'
                    }else{
                        return ''
                    }
                }
            },
            createTime: {
                field: 'createTime', title: '编制时间', sort: true, hide: false, templet: function (d) {
                    return format(d.createTime);
                }
            },
            createUser: {field: 'createUser', title: '编制人', sort: true, hide: false},
            projName: {field: 'projName', title: '项目名称', sort: true, hide: false},
        }

        var TableUIObj = new TableUI('plb_mtl_plan');


        // 初始化左侧项目
        projectLeft();
        // 节点点击事件
        $(document).on('click', '.con_left ul li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var projId = $(this).attr('projId');
            tableShow(projId);
            $('#leftId').attr('projId', projId);
        });
        // 上方按钮显示
        table.on('toolbar(tableDemo)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
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
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一项！', {icon: 0});
                        return false
                    }
                    newOrEdit(1, checkStatus.data[0])
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var mtlPlanId = ''
                    checkStatus.data.forEach(function (v, i) {
                        mtlPlanId += v.mtlPlanId + ','
                    })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbMtlPlan/delMtlPlan', {mtlPlanIds: mtlPlanId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 0});
                            }
                            layer.close(index)
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                        })
                    });
                    break;
                case 'closePlan':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var mtlPlanId = ''
                    checkStatus.data.forEach(function (v, i) {
                        mtlPlanId += v.mtlPlanId + ','
                    })
                    layer.confirm('确定关闭该条计划吗？', function (index) {
                        $.post('/plbMtlPlan/updatePlanStatus', {mtlPlanIds: mtlPlanId, planStatus: 1}, function (res) {
                            if (res.flag) {
                                layer.msg('关闭成功！', {icon: 1});
                            } else {
                                layer.msg('关闭失败！', {icon: 0});
                            }
                            layer.close(index)
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                        })
                    });
                    break;
                case 'submit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
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
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '16'}, function (res) {
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
                                newWorkFlow(flowData.flowId, function (res) {
                                    var submitData = {
                                        reviseId:approvalData.reviseId,
                                        runId: res.flowRun.runId,
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/PlbBudgetRevision/update',
                                        data: JSON.stringify(submitData),
                                        dataType: 'json',
                                        type: 'post',
                                        contentType: "application/json;charset=UTF-8",
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
                                },approvalData);
                            } else {
                                layer.close(loadIndex);
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    break;
                case 'export':
                    window.location.href = '/plbMtlPlan/outCurrentPageData?mtlPlanIds=' + exportData
                    break;
                case 'revision'://修编
                    if ($('#leftId').attr('projId')) {
                        revision()
                    } else {
                        layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
            }
        });
        table.on('tool(tableDemo)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if(layEvent === 'detail'){
                newOrEdit(4,data)
            }
        });
        // 监听排序事件
        table.on('sort(tableDemo)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow($('#leftId').attr('projId'))
            })
        });
        // 内部加行按钮
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    // 判断控制方式
                    var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';

                    if (!controlMode) {
                        layer.msg('请选择管理目标', {icon: 0, time: 1500});
                        return false;
                    }
                    var valuationUnit = '';
                    if (controlMode == '01') {
                        valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';
                    }

                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            planMtlName: $(this).find('input[name="planMtlName"]').val(),
                            planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                            valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                            directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                            estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                            thisAmount: $(this).find('input[name="thisAmount"]').val(),
                            usePlace: $(this).find('input[name="usePlace"]').val(),
                            mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId')
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    var addRowData = {
                        valuationUnit: valuationUnit
                    };
                    oldDataArr.push(addRowData);
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });
        // 内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'del') {
                obj.del();
                if (data.mtlPlanListId) {
                    $.get('/plbMtlPlanList/deleteByMtlPlanListIds', {mtlPlanListIds: data.mtlPlanListId}, function(res){

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        planMtlName: $(this).find('input[name="planMtlName"]').val(),
                        planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                        valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                        directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                        estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                        thisAmount: $(this).find('input[name="thisAmount"]').val(),
                        usePlace: $(this).find('input[name="usePlace"]').val(),
                        mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId'),
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
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
                    TableUIObj.init(colShowObj,function () {
                        // tableShow()
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
            var cols = [{checkbox: true}].concat(TableUIObj.cols)

            cols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#detailBarDemo',
                title: '操作',
                width: 100
            })

            tableIns = table.render({
                elem: '#tableDemo',
                url: '/plbMtlPlan/getEdit',
                toolbar: '#toolbarDemo',
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
                autoSort: false,
                parseData: function (res) { //res 即为原始返回的数据
                    var data;
                    var dataList = [];
                    for (var i = 0; i < res.data.length; i++) {
                        data = JSON.parse(res.data[i].reviseData)
                        data["approvalStatus"] = res.data[i].approvalStatus
                        data["reviseId"] = res.data[i].reviseId
                        dataList.push(data)
                    }
                    return {
                        "data": dataList,
                        "code": 0, //解析接口状态
                        "count": res.totleNum,
                        "msg": res.msg, //解析提示文本
                    }
                },
                request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },
                done: function (res) {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableDemo')
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

        // 新建/编辑
        function newOrEdit(type, data) {
            var title = '';
            var url = '';
            var projId = $('#leftId').attr('projId');
            if (type == '0') {
                title = '新建材料需求计划';
                url = '/plbMtlPlan/addMtlPlan';
            } else if (type == '1') {
                title = '编辑材料需求计划';
                url = '/plbMtlPlan/updateMtlPlan';
            }else if (type == '3') { //修编
                title = '编辑材料需求计划';
                url = '/plbMtlPlan/revision';
            }else if(type == '4'){
                title = '查看详情'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: ['保存', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse">\n' ,
                    /* region 材料计划 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">材料计划</h2>\n' +
                    '    <div class="layui-colla-content layui-show plan_base_info">' +
                    '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
                    /* region 第一行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">计划单编号<span field="planNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="planNo" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">计划名称<span field="planName" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="planName" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">计划时间<span field="planDate" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="planDate" readonly id="planDate" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
                    /* endregion */
                    /* region 第二行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">管理目标数量<span field="budgetItemId" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                    '                       <input type="text" name="totalManagementTarget" readonly autocomplete="off" class="layui-input " style="padding-right: 25px;background:#e7e7e7;display: inline-block;width: 73%">\n' +
                    '<button type="button" class="layui-btn  layui-btn-sm chooseManagementBudget">选择管理目标</button>'+
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">WBS<span field="wbsId" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="wbsId" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">CBS<span field="cbsId" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="cbsId" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
                    /* endregion */
                    /* region 第三行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">控制方式<span field="controlMode" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="controlMode" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">计量单位</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="valuationUnit" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">管理目标总价</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" readonly name="mgeTargetPrice" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
                    /* endregion */
                    /* region 第四行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">累计已提需求计划量</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" readonly name="addupNeedAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">在途需求计划量</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" readonly name="onwayAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">需用日期<span field="useDate" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="useDate" readonly id="useDate" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    /*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">累计调动数量</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" readonly name="moveAmount"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +*/
                    '           </div>' ,
                    /* endregion */
                    /* region 第五行 */
                    /* '           <div class="layui-row">' +
                     '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                     '                   <div class="layui-form-item">\n' +
                     '                       <label class="layui-form-label form_label">管理目标总价</label>\n' +
                     '                       <div class="layui-input-block form_block">\n' +
                     '                       <input type="text" readonly name="mgeTargetPrice" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                     '                       </div>\n' +
                     '                   </div>' +
                     '               </div>' +
                     /!*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                     '                   <div class="layui-form-item">\n' +
                     '                       <label class="layui-form-label form_label">累计入库发生金额</label>\n' +
                     '                       <div class="layui-input-block form_block">\n' +
                     '                       <input type="text" readonly name="addupInStoreMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                     '                       </div>\n' +
                     '                   </div>' +
                     '               </div>' +*!/
                     /!*'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                     '                   <div class="layui-form-item">\n' +
                     '                       <label class="layui-form-label form_label">累计调动金额</label>\n' +
                     '                       <div class="layui-input-block form_block">\n' +
                     '                       <input type="text" readonly name="addupMoveMoney"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                     '                       </div>\n' +
                     '                   </div>' +
                     '               </div>' +*!/
                     '           </div>' ,*/
                    /* endregion */
                    /* region 第六行*/
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">剩余可提需求计划金额</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" readonly name="surplusMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">需求计划量<span field="planAmount" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="planAmount" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">需求计划金额</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="planMoney" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
                    /* endregion */
                    /* region 第七行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">备注</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
                    /* endregion */
                    /* region 第八行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">附件</label>' +
                    '                       <div class="layui-input-block form_block">' +
                    '<div class="file_module">' +
                    '<div id="fileContent" class="file_content"></div>' +
                    '<div class="file_upload_box">' +
                    '<a href="javascript:;" class="open_file">' +
                    '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                    '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                    '</a>' +
                    '<div class="progress" id="progress">' +
                    '<div class="bar"></div>\n' +
                    '</div>' +
                    '<div class="bar_text"></div>' +
                    '</div>' +
                    '</div>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
                    /* endregion */
                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n' ,
                    /* endregion */
                    /* region 材料明细 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">材料明细</h2>\n' +
                    '    <div class="layui-colla-content mtl_info layui-show">' +
                    '       <div>' +
                    '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                    '      </div>' +
                    '    </div>\n' +
                    '  </div>\n' ,
                    /* endregion */
                    /* region 其他 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">其他</h2>\n' +
                    '    <div class="layui-colla-content other_info layui-show">' ,
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">编制人<span style="margin: 0 10px;">流程定义某节点为编制节点</span>编制时间</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="createTime" id="createTime" readonly autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                     <label class="layui-form-label form_label">审核人<span style="margin: 0 10px;">流程定义某节点为审核节点</span>审核时间</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="approvalDate" id="approvalDate" readonly autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">审批人<span style="margin: 0 10px;">流程定义某节点为审批节点</span>审批时间</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="auditerDate" id="auditerDate" readonly autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' +
                    '   </div>' ,
                    /* endregion */
                    '  </div>\n' +
                    '</div>'].join(''),
                success: function () {
                    fileuploadFn('#fileupload', $('#fileContent'));
                    //新增时计划编号显示
                    if (type == 0) {
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbMtlPlan'}, function(res) {
                            $('input[name="planNo"]', $('#baseForm')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbMtlPlan'}, function(res) {
                                $('input[name="planNo"]', $('#baseForm')).val(res);
                            });
                        });

                        //默认当前时间
                        var year = new Date().getFullYear();
                        var month = new Date().getMonth()+1;
                        var day = new Date().getDate();
                        if (month < 10) {
                            month = "0" + month;
                        }
                        if (day < 10) {
                            day = "0" + day;
                        }
                        var today = year+"-" + month + "-" + day;
                        //计划时间默认填报时间，即当日
                        $('#planDate').val(today)
                    }
                    var materialDetailsTableData = [];
                    //回显数据
                    if (type == 1 ||type == 3 || type == 4) {
                        form.val("formTest", data);

                        $('#planDate').val(data ? format(data.planDate) : '')

                        $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId', data.budgetItemId || '');

                        $('.plan_base_info input[name="wbsId"]').val(data.wbsName || '');
                        $('.plan_base_info input[name="wbsId"]').attr('wbsId', data.wbsId || '');
                        $('.plan_base_info input[name="cbsId"]').val(data.cbsName || '');
                        $('.plan_base_info input[name="cbsId"]').attr('cbsId', data.cbsId || '');
                        // 控制类型
                        $('.plan_base_info input[name="controlMode"]').val(dictionaryObj['CONTROL_TYPE']['object'][data.controlMode] || '');
                        $('.plan_base_info input[name="controlMode"]').attr('controlMode', data.controlMode || '');
                        // 计量单位
                        $('.plan_base_info input[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][data.valuationUnit] || '');
                        $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit', data.valuationUnit || '');

                        if (data.attachmentList && data.attachmentList.length > 0) {
                            var fileArr = data.attachmentList;
                            $('#fileContent').append(echoAttachment(fileArr));
                        }

                        materialDetailsTableData = data.listWithBLOBs;

                        //查看详情
                        if(type==4){
                            $('.layui-layer-btn-c').hide()
                            $('#baseForm [name="planName"]').attr('disabled','true')
                            $('#useDate').attr('disabled','true')
                            $('#baseForm [name="remark"]').attr('disabled','true')
                            $('.file_upload_box').hide()
                            $('.deImgs').hide()
                            $('#createTime').attr('disabled','true')
                            $('#approvalDate').attr('disabled','true')
                            $('#auditerDate').attr('disabled','true')
                            $('.chooseManagementBudget').hide()
                        }
                    }

                    element.render();
                    form.render();
                    /*laydate.render({
                        elem: '#planDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.planDate) : ''
                    });*/
                    laydate.render({
                        elem: '#useDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.useDate) : ''
                    });
                    laydate.render({
                        elem: '#createTime' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.createTime) : ''
                    });
                    laydate.render({
                        elem: '#approvalDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.approvalDate) : ''
                    });
                    laydate.render({
                        elem: '#auditerDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.auditerDate) : ''
                    });

                    var cols=[
                        {type: 'numbers', title: '操作'},
                        {
                            field: 'planMtlName', title: '材料名称', width: 200, templet: function (d) {
                                return '<input mtlPlanListId="' + (d.mtlPlanListId || '') + '" mtlLibId="'+(d.mtlLibId || '')+'" readonly type="text" name="planMtlName" class="layui-input" style="width: 90%;height: 100%;" value="' + (d.planMtlName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
                            }
                        },
                        {
                            field: 'planMtlStandard', title: '材料规格', templet: function (d) {
                                return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;" value="' + (d.planMtlStandard || '') + '">'
                            }
                        },
                        {
                            field: 'valuationUnit', title: '计量单位',
                            templet: function (d) {
                                return '<input type="text" valuationUnit="'+d.valuationUnit+'" name="valuationUnit" readonly class="layui-input '+(type==4 ?  '' : 'chooseMtlUnit')+'" style="height: 100%;cursor: pointer;" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                            }
                        },
                        {
                            field: 'directUnitPrice', title: '指导单价',
                        },
                        {
                            field: 'estiUnitPrice', title: '预计单价', templet: function (d) {
                                return '<input type="text" name="estiUnitPrice" '+(type==4 ? 'readonly' : '')+' class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estiUnitPrice || '') + '">'
                            }
                        },
                        {
                            field: 'thisAmount', title: '本次数量', templet: function (d) {
                                return '<input type="text" name="thisAmount" '+(type==4 ? 'readonly' : '')+' class="layui-input thisAmountItem" autocomplete="off" style="height: 100%;" value="' + (d.thisAmount || '') + '">'
                            }
                        },
                        {
                            field: 'usePlace', title: '使用部位', templet: function (d) {
                                return '<input type="text" name="usePlace" '+(type==4 ? 'readonly' : '')+' class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.usePlace || '') + '">'
                            }
                        },
                    ]
                    if(type!=4){
                        cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                    }
                    table.render({
                        elem: '#materialDetailsTable',
                        data: materialDetailsTableData,
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
                },
                yes: function (index) {
                    //需求计划金额不得大于剩余可提需求计划金额
                    if(Number($('#baseForm [name="planMoney"]').val()) > Number($('#baseForm [name="surplusMoney"]').val())){
                        layer.msg('需求计划金额不得大于剩余可提需求计划金额!', {icon: 0, time: 2000});
                        return  false
                    }

                    var loadIndex = layer.load();
                    //材料计划数据
                    var datas = $('#baseForm').serializeArray();
                    var obj = {}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });
                    obj.wbsId = $('.plan_base_info input[name="wbsId"]').attr('wbsId') || '';
                    obj.cbsId = $('.plan_base_info input[name="cbsId"]').attr('cbsId') || '';
                    // 控制类型
                    obj.controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';
                    // 计量单位
                    obj.valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';

                    obj.budgetItemId = $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId') || '';
                    // 附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId = attachmentId;
                    obj.attachmentName = attachmentName;
                    //材料明细数据
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        var materialDetailsObj = {
                            planMtlName: $(this).find('input[name="planMtlName"]').val(),
                            planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                            valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                            directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                            estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                            thisAmount: $(this).find('input[name="thisAmount"]').val(),
                            usePlace: $(this).find('input[name="usePlace"]').val(),
                            mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId'),
                            mtlLibId:$(this).find('[name="planMtlName"]').attr('mtlLibId'), //材料资源库id
                        }
                        if ($(this).find('input[name="planMtlName"]').attr('mtlPlanListId')) {
                            materialDetailsObj.mtlPlanListId = $(this).find('input[name="planMtlName"]').attr('mtlPlanListId');
                        }
                        materialDetailsArr.push(materialDetailsObj);
                    });
                    obj.listWithBLOBS = materialDetailsArr;
                    //其他数据
                    obj.createTime = $('#createTime').val();
                    obj.approvalDate = $('#approvalDate').val();
                    obj.auditerDate = $('#auditerDate').val();



                    // 判断必填项
                    var requiredFlag = false;
                    $('#baseForm').find('.field_required').each(function(){
                        var field = $(this).attr('field');
                        if (!obj[field]) {
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

                    if (type == 1 ||type == 3) {
                        obj.mtlPlanId = data.mtlPlanId
                    }
                    obj.projId = parseInt(projId);

                    $.ajax({
                        url: url,
                        data: JSON.stringify(obj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.msg(res.msg, {icon: 1});
                                layer.closeAll();
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload();
                            } else {
                                layer.msg(res.msg || '保存失败!', {icon: 2});
                            }
                        }
                    });
                },
                btn2: function (index, layero) {

                }
            });
        }

        // 点击选管理预算
        $(document).on('click', '.chooseManagementBudget', function () {
            var wbsSelectTree = null;
            var cbsSelectTree = null;

            layer.open({
                type: 1,
                title: '管理目标选择',
                area: ['100%', '100%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-form">' +
                //下拉选择
                '           <div class="layui-row" style="margin-top: 10px">' +
                '               <div class="layui-col-xs2">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs2">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs3">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">WBS</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs3">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">CBS</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs2">' +
                '<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 0 0 10px;">搜索<i class="layui-icon layui-icon-search" style="margin: 0 0 0 3px;"></i></button>' +
                '               </div>' +
                '           </div>' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {
                    // 获取WBS数据
                    $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId')}, function (res) {
                        wbsSelectTree = xmSelect.render({
                            el: '#wbsSelectTree',
                            content: '<div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                            name: 'wbsName',
                            prop: {
                                name: 'wbsName',
                                value: 'id'
                            }
                        });

                        eleTree.render({
                            elem: '#wbsTree',
                            data: res.obj,
                            highlightCurrent: true,
                            showLine: true,
                            defaultExpandAll: false,
                            request: {
                                name: 'wbsName',
                                children: "child"
                            }
                        });

                        // 树节点点击事件
                        eleTree.on("nodeClick(wbsTree)", function (d) {
                            var currentData = d.data.currentData;
                            var obj = {
                                wbsName: currentData.wbsName,
                                id: currentData.id
                            }
                            wbsSelectTree.setValue([obj]);
                        });
                    });

                    // 获取CBS数据
                    $.get('/plbCbsType/getAllList', function (res) {
                        cbsSelectTree = xmSelect.render({
                            el: '#cbsSelectTree',
                            content: '<div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                            name: 'cbsName',
                            prop: {
                                name: 'cbsName',
                                value: 'cbsId'
                            }
                        });

                        eleTree.render({
                            elem: '#cbsTree',
                            data: res.data,
                            highlightCurrent: true,
                            showLine: true,
                            defaultExpandAll: false,
                            request: {
                                name: 'cbsName',
                                children: "childList"
                            }
                        });

                        // 树节点点击事件
                        eleTree.on("nodeClick(cbsTree)", function (d) {
                            var currentData = d.data.currentData;
                            var obj = {
                                cbsName: currentData.cbsName,
                                cbsId: currentData.cbsId
                            }
                            cbsSelectTree.setValue([obj]);
                        });
                    });

                    laodTable();

                    $('.search_mtl').on('click', function(){
                        var cbsId = cbsSelectTree.getValue('valueStr');
                        var wbsId = wbsSelectTree.getValue('valueStr');
                        var itemNo = $('[name="itemNo"]').val();
                        var itemName =$('[name="itemName"]').val();

                        laodTable(wbsId, cbsId,itemNo,itemName);
                    });

                    // 加载表格
                    function laodTable(wbsId, cbsId,itemNo,itemName) {
                        table.render({
                            elem: '#managementBudgetTable',
                            url: '/manageProject/getBudgetByProjId',
                            where: {
                                projId: $('#leftId').attr('projId'),
                                rbsTyep:'mtl',
                                wbsId: wbsId || '',
                                cbsId: cbsId || '',
                                itemNo: itemNo || '',
                                itemName: itemName || '',
                            },
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
                                {type: 'radio', title: '选择'},
                                {
                                    field: 'wbsName', title: 'WBS',width:100, templet: function(d) {
                                        var str = '';
                                        if (d.plbProjWbs) {
                                            str = d.plbProjWbs.wbsName;
                                        }
                                        return str;
                                    }
                                },
                                {
                                    field: 'cbsName', title: 'CBS',width:100, templet: function (d) {
                                        var str = '';
                                        if (d.plbCbsTypeWithBLOBs) {
                                            str = d.plbCbsTypeWithBLOBs.cbsName;
                                        }
                                        return str;
                                    }
                                },
                                {field: 'manageTarPrice', title: '管理目标单价',width:120},
                                {field: 'manageTarNum', title: '管理目标数量',width:120},
                                {field: 'manageTarAmount', title: '管理目标总价',width:120},
                                {field: 'addupNeedAmount', title: '累计已提需求计划量',width:170},
                                {field: 'addupNeedMoney', title: '累计已提需求计划金额',width:170},
                                {field: 'manageSurplusAmount', title: '管理目标数量余额',width:150},
                                {field: 'manageSurplusMoney', title: '管理目标金额余额',width:150},
                                {
                                    field: 'controlType', title: '控制类型', width:120,templet: function (d) {
                                        return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                    }
                                },
                                {
                                    field: 'cbsUnit', title: '计量单位',width:120, templet: function (d) {
                                        var str = '';
                                        if (d.plbCbsTypeWithBLOBs) {
                                            str = dictionaryObj['CBS_UNIT']['object'][d.plbCbsTypeWithBLOBs.cbsUnit] || '';
                                        }
                                        return str;
                                    }
                                }
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('managementBudgetTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];

                        $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId', chooseData.budgetItemId);

                        $('.plan_base_info input[name="wbsId"]').val(chooseData.plbProjWbs ? chooseData.plbProjWbs.wbsName : '');
                        $('.plan_base_info input[name="wbsId"]').attr('wbsId', chooseData.plbProjWbs ? chooseData.plbProjWbs.wbsId : '');
                        $('.plan_base_info input[name="cbsId"]').val(chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsName : '');
                        $('.plan_base_info input[name="cbsId"]').attr('cbsId', chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsId : '');
                        $('.plan_base_info input[name="controlMode"]').val(dictionaryObj['CONTROL_TYPE']['object'][chooseData.controlType] || '');
                        $('.plan_base_info input[name="controlMode"]').attr('controlMode', chooseData.controlType);

                        var valuationUnit = chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsUnit : '';
                        //管理目标数量
                        var totalManagementTarget = chooseData.manageTarNum ? chooseData.manageTarNum : '';
                        var addupNeedAmount = chooseData.addupNeedAmount || 0;
                        //在途需求计划量初始值默认为0
                        var onwayAmount = chooseData.onwayAmount || 0;
                        var moveAmount = '';
                        var mgeTargetPrice = chooseData.manageTarAmount || '';
                        var addupInStoreMoney = '';
                        var addupMoveMoney = '';
                        //剩余可提需求计划金额
                        var surplusMoney =chooseData.surplusMoney ||  '';

                        /*if (chooseData.controlType == '01') {
                            // 数量控制
                            totalManagementTarget = chooseData.totalManagementTarget;
                            valuationUnit = chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsUnit : '';
                            addupNeedAmount = chooseData.plannedDemand;
                            onwayAmount = chooseData.plannedVolume ? chooseData.plannedVolume : 0;
                            moveAmount = chooseData.numberTransfers;
                            // 同时修改材料明细的计量单位
                            $('.mtl_info input[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][valuationUnit] || '');
                            $('.mtl_info input[name="valuationUnit"]').attr('valuationUnit', valuationUnit);
                        } else if (chooseData.controlType == '02') {
                            // 金额控制
                            mgeTargetPrice = chooseData.adjustmentObjectivesSum;
                            addupInStoreMoney = chooseData.adjustmentObjectivesSum;
                            addupMoveMoney = chooseData.numberTransfers
                        }*/

                        // 数量控制-计量单位
                        $('.plan_base_info input[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][valuationUnit] || '');
                        $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit', valuationUnit);
                        // 数量控制-管理目标选择
                        $('.plan_base_info input[name="totalManagementTarget"]').val(totalManagementTarget);
                        // 数量控制-累计已提需求计划量
                        $('.plan_base_info input[name="addupNeedAmount"]').val(addupNeedAmount);
                        // 数量控制-在途需求计划量
                        $('.plan_base_info input[name="onwayAmount"]').val(onwayAmount);
                        // 数量控制-累计调动数量
                        // $('.plan_base_info input[name="moveAmount"]').val(moveAmount);

                        // 金额控制-管理目标总价
                        $('.plan_base_info input[name="mgeTargetPrice"]').val(mgeTargetPrice);
                        // 金额控制-累计入库发生金额
                        // $('.plan_base_info input[name="addupInStoreMoney"]').val(addupInStoreMoney);
                        // 金额控制-累计调动金额
                        // $('.plan_base_info input[name="addupMoveMoney"]').val(addupMoveMoney);
                        // 金额控制-剩余可提需求计划金额
                        $('.plan_base_info input[name="surplusMoney"]').val(surplusMoney);

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });
        // 点击选择材料明细
        $(document).on('click', '.chooseMaterials', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择材料',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    '<div class="wrapper">',
                    '<div class="wrap_left">' +
                    '<div class="layui-form">' +
                    '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
                    '<div class="tree_module" style="top: 48px;">' +
                    '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="wrap_right">' +
                    '<div class="layui-form">' +
                    '<div class="layui-form-item" style="margin: 0;">' +
                    '<label class="layui-form-label">材料名称</label>' +
                    '<div class="layui-input-block">' +
                    '<input type="text" name="planMtlName" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="mtl_table_box" style="display: none;">' +
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img" style="margin-top:12%;">' +
                    '<img style="margin-top: 2%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧材料</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    // 获取材料类型
                    $.get('/plbDictonary/getTgTypeByDictNo?plbDictNo=MTL_TYPE', function (res) {
                        var str = '<option value="">请选择<option>';
                        if (res.flag && res.obj.length > 0) {
                            res.obj.forEach(function (item) {
                                str += '<option value="' + item.plbDictNo + '">' + item.dictName + '<option>';
                            });
                        }
                        $('#mtlTypeTree').html(str);
                        form.render();
                    });

                    form.on('select(mtlTypeTree)', function (data) {
                        loadMtlType(data.value);
                    });

                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.mtlLibId) {
                            $('.mtl_no_data').hide();
                            $('.mtl_table_box').show();
                            loadMtlTable(currentData.mtlLibId);
                        } else {
                            $('.mtl_table_box').hide();
                            $('.mtl_no_data').show();
                        }
                    });

                    loadMtlType();

                    function loadMtlType(mtlType) {
                        mtlType = mtlType ? mtlType : '';
                        // 获取左侧树
                        $.get('/plbMtlLibrary/queryAll', {mtlType: mtlType}, function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    request: {
                                        name: 'mtlName',
                                        children: "son",
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(mtlLibId) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbMtlLibrary/queryByParentId',
                            where: {
                                mtlLibId: mtlLibId
                            },
                            page: false,
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data'
                            },
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'mtlNo', title: '材料编码'},
                                {field: 'mtlName', title: '材料名称'},
                                {field: 'mtlStandard', title: '材料规格'},
                                {
                                    field: 'mtlValuationUnit', title: '计量单位', templet: function (d) {
                                        return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '';
                                    }
                                },
                                {field: 'mtlPriceUnit', title: '指导单价'}
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];

                        _this.parents('tr').find('[name="planMtlName"]').val(mtlData.mtlName);
                        _this.parents('tr').find('[name="planMtlStandard"]').val(mtlData.mtlStandard);
                        _this.parents('tr').find('[data-field="directUnitPrice"] .layui-table-cell').text(mtlData.mtlPriceUnit);

                        //材料资源库id
                        _this.parents('tr').find('[name="planMtlName"]').attr('mtlLibId',mtlData.mtlLibId);

                        // 判断控制方式是否为数量
                        var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';
                        if (controlMode != '01') {
                            _this.parents('tr').find('[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][mtlData.mtlValuationUnit] || '');
                            _this.parents('tr').find('[name="valuationUnit"]').attr('valuationUnit', mtlData.mtlValuationUnit);
                        }
                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
        // 点击选择计量单位
        $(document).on('click', '.chooseMtlUnit', function(){
            var $this = $(this);
            var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';

            if (controlMode != '01') {
                layer.open({
                    type: 1,
                    title: '选择计量单位',
                    area: ['400px', '400px'],
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: '<div style="padding: 10px"><table id="chooseMtlUnit" lay-filter="chooseMtlUnit"></table></div>',
                    success: function () {
                        var dataArr = []
                        $.each(dictionaryObj['CBS_UNIT']['object'], function (k, o) {
                            var obj = {
                                mtlValuationUnit: k,
                                mtlValuationUnitStr: o
                            }
                            dataArr.push(obj);
                        });
                        table.render({
                            elem: '#chooseMtlUnit',
                            data: dataArr,
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'mtlValuationUnitStr', title: '计量单位'}
                            ]]
                        });
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('chooseMtlUnit');
                        if (checkStatus.data.length > 0) {
                            $this.val(checkStatus.data[0].mtlValuationUnitStr);
                            $this.attr('valuationunit', checkStatus.data[0].mtlValuationUnit);
                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                });
            }
        });

        //点击查询
        $('.searchData').click(function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                // 将查询值保存至cookie中
                $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
            })
            tableIns.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
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

        //修编
        function revision() {
            var projId = $('#leftId').attr('projId');
            var cols=[
                {field: 'planNo', title: '计划单编号',},
                {field: 'planName', title: '计划名称', },
                {field:'projName',title:'所属项目',},
                {
                    field: 'auditerStatus',
                    title: '审批状态',
                    templet: function (d) {
                        if (d.auditerStatus == '0') {
                            return '未提交';
                        } else if (d.auditerStatus == '1') {
                            return '<span style="color: orange">审批中</span>';
                        } else if (d.auditerStatus == '2') {
                            return '<span style="color: green">批准</span>'
                        }else if (d.auditerStatus == '3'){
                            return '<span style="color: red">不批准</span>'
                        }else{
                            return ''
                        }
                    }
                },
                {
                    field: 'createTime', title: '编制时间',templet: function (d) {
                        return format(d.createTime);
                    }
                },
                {field: 'createUser', title: '编制人',},
                {title: '操作', width: 100, align: 'center', toolbar: '#revisionBarDemo'}
            ]
            layer.open({
                type: 1,
                title: '修编',
                area: ['90%', '80%'],
                maxmin: true,
                content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                success: function () {
                    table.render({
                        elem: '#flowTable',
                        url: '/plbMtlPlan/queryMtlPlan',
                        cols: [cols],
                        height: 'full-220',
                        page: {
                            limits: [10, 20, 30, 40, 50]
                        },
                        where: {
                            projId: projId,
                        },
                        autoSort: false,
                        parseData: function (res) { //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj, //解析数据列表
                                "count": res.totleNum, //解析数据长度
                            };
                        },
                        request: {
                            limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        }
                    });
                },
            })
        }

        //工具条事件
        table.on('tool(flowTable)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if (layEvent === 'edit') { //修编
                newOrEdit(3, data)
            }
        });

        //监听本次数量
        $(document).on('blur', '.thisAmountItem', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var thisAmount=0
            $tr.each(function () {
                thisAmount=accAdd(thisAmount,$(this).find('input[name="thisAmount"]').val())
            });
            $('#baseForm [name="planAmount"] ').val(thisAmount)
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
    });
</script>
</body>
</html>
