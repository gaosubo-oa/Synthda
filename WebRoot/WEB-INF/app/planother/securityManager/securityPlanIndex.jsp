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
    <title>安全检查计划</title>

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
    <%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>

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

        /*选中行样式*/
        .selectTr {
            background: #009688 !important;
            color: #fff !important;
        }

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .layui-col-xs20{
        	width: 20%;
        }
        .layui-col-xs40{
            width: 40%;
        }

        .project_detailed_information, .project_detailed_information .layui-table-cell,.project_detailed_information .layui-table-box,.project_detailed_information .layui-table-body {
            overflow: visible;
        }
        /* 设置下拉框的高度与表格单元格的高度相同 */
        .project_detailed_information td .layui-form-select {
            margin-top: -10px;
            margin-left: -15px;
            margin-right: -15px;
        }

        .layui-layer-content{
            overflow-x: hidden !important;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">安全检查计划</h2>
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
                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">
                </div>
                    <div class="layui-col-xs2" style="margin-left: 15px;">
                        <input type="text" name="securityPlanName" placeholder="检查计划名称" autocomplete="off" class="layui-input">
                    </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select name="auditerStatus">
                        <option value="">请选择审批状态</option>
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
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
        <%--<div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>--%>
    </div>
</script>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script type="text/html" id="toolbarPlan">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="toolbarPlan2">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="choice">选择</button>
    </div>
</script>

<script type="text/html" id="barPlan">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>

    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var objectivesTableData = []

    var tableIns = null;
    layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var eleTree = layui.eleTree;
        var layer = layui.layer;
        var soulTable = layui.soulTable;


        form.render();
        //表格显示顺序
        var colShowObj = {
            documentNo: {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false,templet: function (d) {
                    return '<span securityPlanId="'+d.securityPlanId+'">'+(d.documentNo||'')+'</span>'
                }},
            projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
            securityPlanName: {field: 'securityPlanName', title: '检查计划名称', minWidth: 120,sort: true, hide: false},
            planMemo: {field: 'planMemo', title: '计划描述', minWidth: 120,sort: true, hide: false},
            securityPlanBeginDate: {field: 'securityPlanBeginDate', title: '计划检查开始日期', minWidth: 120,sort: true, hide: false},
            securityPlanEndDate: {field: 'securityPlanEndDate', title: '计划检查结束日期', minWidth: 120,sort: true, hide: false},
            currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',minWidth: 130, sort: false, hide: false},
            auditerStatus: {
                field: 'auditerStatus',
                title: '审核状态',
                minWidth: 120,
                sort: true,
                hide: false,
                templet: function (d) {
                    var str = '';
                    switch (d.auditerStatus) {
                        case '0':
                            str = '未提交';
                            break;
                        case '1':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
                            break;
                        case '2':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
                            break;
                        case '3':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
                            break;
                    }
                    return str;
                }
            }
        }

        // 获取数据字典数据
        var dictionaryObj = {
            CHECK_FREQUENCY:{},
            INSPECTION_LEVEL:{},
            SECURITY_CHECK_TYPE:{}
        }
        var dictionaryStr = 'CHECK_FREQUENCY,INSPECTION_LEVEL,SECURITY_CHECK_TYPE';
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

        var TableUIObj = new TableUI('plb_security_plan');


        // 初始化左侧项目
        projectLeft();
        // 上方按钮显示
        table.on('toolbar(tableDemo)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var dataTable=table.checkStatus(obj.config.id).data;
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
                    if (checkStatus.data[0].auditerStatus!=0) {
                        layer.msg('已提交不可编辑！', {icon: 0});
                        return false
                    }
                    var auditerStatus = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="auditerStatus"]').attr('data-content')
                    if (auditerStatus!=0) {
                        layer.msg('已提交不可编辑！', {icon: 0});
                        return false
                    }
                    if($('#leftId').attr('projId')){
                        var securityPlanId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span').attr('securityPlanId')
                        var loadIndex = layer.load();
                        $.post('/securityPlan/getById', {kayId: securityPlanId}, function (res) {
                            newOrEdit(1,res.obj)
                            layer.close(loadIndex);
                        })
                    }else{
                        layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var securityPlanId = ''
                    var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
                    $trs.each(function(){
                        securityPlanId += $(this).attr('securityPlanId') + ','
                    })
                    // checkStatus.data.forEach(function (v, i) {
                    // 	securityPlanId += v.securityPlanId + ','
                    // })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/securityPlan/del', {ids: securityPlanId}, function (res) {
                            if (res.code=='0') {
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
                case 'submit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                        return false;
                    }
                    if(checkStatus.data[0].auditerStatus != '0'){
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
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '72'}, function (res) {
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
                                newWorkFlow(flowData.flowId, function (res) {
                                    var submitData = {
                                        securityPlanId:approvalData.securityPlanId,
                                        runId: res.flowRun.runId,
                                        //auditerStatus:1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/securityPlan/updateById',
                                        data: JSON.stringify(submitData),
                                        dataType: 'json',
                                        contentType: "application/json;charset=UTF-8",
                                        type: 'post',
                                        success: function (res) {
                                            layer.close(loadIndex);
                                            if (res.code=='0') {
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
                case 'import'://导入
                    layer.msg("功能正在开发中");
                    break;
                case 'export'://导出
                    layer.msg("功能正在开发中");
                    break;
            }
        });
        table.on('tool(tableDemo)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var securityPlanId = $(obj.tr.selector).find('[data-field="documentNo"] span').attr('securityPlanId')
            if(layEvent === 'detail'){
                var loadIndex = layer.load();
                $.post('/securityPlan/getById', {kayId: securityPlanId}, function (res) {
                    newOrEdit(4,res.obj)
                    layer.close(loadIndex);
                })
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
                        // tableShow('')
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
                url: '/securityPlan/select',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                // height: 'full-80',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    projId: projId,
                    projectId: projId,
                    delFlag: '0'
                    //orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    //orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
                // parseData: function (res) { //res 即为原始返回的数据
                //     return {
                //         "code": 0, //解析接口状态
                //         "data": res.data, //解析数据列表
                //         "count": res.totleNum, //解析数据长度
                //     };
                // },
                /*request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },*/
                done: function (res) {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableDemo')
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
            var projectId = $('#leftId').attr('projId');
            if (type == '0') {
                title = '新建安全检查计划';
                url = '/securityPlan/insert';
            } else if (type == '1') {
                title = '编辑安全检查计划';
                url = '/securityPlan/updateById';
            }else if(type == '4'){
                title = '查看详情'
            }


            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: type != '4'?['保存','提交审批', '取消']:['确定'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse _disabled">\n' +
                /* region 方案内容 */
                '  <div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title">方案内容</h2>\n' +
                '    <div class="layui-colla-content layui-show plan_base_info">' +
                '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
                /* region 第一行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="documentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">检查计划名称<span field="securityPlanName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                           <input type="text" name="securityPlanName"  autocomplete="off" class="layui-input">' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs2 layui-col-xs40" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">计划描述<span field="planMemo" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                           <input type="text" name="planMemo"  autocomplete="off" class="layui-input">' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' ,
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">检查计划级别<span field="securityPlanLevel" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <select id="securityPlanLevel" name="securityPlanLevel" ></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">检查计划类型<span field="securityPlanType" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <select id="securityPlanType" name="securityPlanType" ></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">计划检查开始日期<span field="securityPlanBeginDate" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="securityPlanBeginDate"  id="securityPlanBeginDate" autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">计划检查结束日期<span field="securityPlanEndDate" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="securityPlanEndDate"  id="securityPlanEndDate" autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
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
                    '<input type="file" multiple id="fileupload" data-url="/upload?module=securityPlan" name="file">' +
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
                    '           </div>',
                    /* endregion */
                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n' +
                    /* endregion */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">检查计划明细</h2>\n' +
                    '    <div class="layui-colla-content layui-show project_detailed_information">' +
                    '		<table id="detailedTable" lay-filter="detailedTable"></table>' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">管理策划要求</h2>\n' +
                    '    <div class="layui-colla-content layui-show project_objectives">' +
                    '		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
                    '    </div>\n' +
                    '  </div>\n' +
                    /* endregion */
                    '</div>'].join(''),
                success: function () {
                    fileuploadFn('#fileupload', $('#fileContent'));
                    //回显项目名称
                    getProjName('#projectName',projectId?projectId:data.projectId)

                    //渲染检查计划级别
                    var str = '<option value="">请选择</option>'
                    if(dictionaryObj&&dictionaryObj['INSPECTION_LEVEL']&&dictionaryObj['INSPECTION_LEVEL']['str']){
                        str += dictionaryObj['INSPECTION_LEVEL']['str']
                    }
                    $('#securityPlanLevel').html(str)
                    //渲染检查计划类型
                    var str = '<option value="">请选择</option>'
                    if(dictionaryObj&&dictionaryObj['SECURITY_CHECK_TYPE']&&dictionaryObj['SECURITY_CHECK_TYPE']['str']){
                        str += dictionaryObj['SECURITY_CHECK_TYPE']['str']
                    }
                    $('#securityPlanType').html(str)

                    //计划检查开始日期
                    laydate.render({
                        elem: '#securityPlanBeginDate'
                        , trigger: 'click'//呼出事件改成click
                        , format: 'yyyy-MM-dd'
                    });
                    //计划检查结束日期
                    laydate.render({
                        elem: '#securityPlanEndDate'
                        , trigger: 'click'//呼出事件改成click
                        , format: 'yyyy-MM-dd'
                    });

                    //回显数据
                    if (type == 1 || type == 4) {
                        form.val("formTest", data);

                        //附件
                        if (data.attachList && data.attachList.length > 0) {
                            var fileArr = data.attachList;
                            $('#fileContent').append(echoAttachment(fileArr));
                        }
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumberType: 'securityPlan'}, function(res) {
                            $('input[name="documentNo"]', $('#baseForm')).val(res.obj);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumberType: 'securityPlan'}, function(res) {
                                $('input[name="documentNo"]', $('#baseForm')).val(res.obj);
                            });
                        });
                    }

                    //检查计划明细
                    var cols = [
                        {type: 'numbers', title: '序号'},
                        {
                            field: 'securityKnowledgeName2', title: '检查项名称', minWidth: 160, templet: function (d) {
                                return '<input type="text" name="securityKnowledgeName2" readonly class="layui-input tips" style="height: 100%;background: #e7e7e7;" value="' + (d.securityKnowledgeName || '') + '">'
                            }
                        },
                        /*{
                            field: 'mainDifficulties', title: '主要难点', minWidth: 160, templet: function (d) {
                                return '<input type="text" name="mainDifficulties" class="layui-input" style="height: 100%;" value="' + (d.mainDifficulties || '') + '">'
                            }
                        },
                        {
                            field: 'mainRisk', title: '主要风险', minWidth: 160, templet: function (d) {
                                return '<input type="text" name="mainRisk" class="layui-input" style="height: 100%;" value="' + (d.mainRisk || '') + '">'
                            }
                        },
                        {
                            field: 'riskSolutions', title: '风险解决措施', minWidth: 160, templet: function (d) {
                                return '<input type="text" name="riskSolutions" class="layui-input" style="height: 100%;" value="' + (d.riskSolutions || '') + '">'
                            }
                        },*/
                        {
                            field: 'personLiableName', title: '责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
                                return '<input type="text" name="personLiableName" id="personLiable_Name'+d.LAY_INDEX+'" user_id="'+(d.personLiable||'')+'" class="layui-input" style="height: 100%;" value="' + (d.personLiableName || '') + '">'
                            }
                        },
                        {field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
                                var optionStr = '<option value="">请选择</option>';
                                if(dictionaryObj.CHECK_FREQUENCY.object){
                                    for (index in dictionaryObj.CHECK_FREQUENCY.object){
                                        if(d.checkFrequency!=undefined&&index==d.checkFrequency){
                                            optionStr += '<option value="'+index+'" selected>'+dictionaryObj.CHECK_FREQUENCY.object[index]+'</option>';
                                        }else{
                                            optionStr += '<option value="'+index+'" >'+dictionaryObj.CHECK_FREQUENCY.object[index]+'</option>';
                                        }
                                    }
                                    return '<select name="checkFrequency" class="layui-input" style="height: 100%;"  value="' + (d.checkFrequency || '') + '">'+optionStr+'</select>'
                                }else {
                                    return '';
                                }
                            }
                        },
                        {
                            field: 'solutions', title: '检查项描述', minWidth: 160, templet: function (d) {
                                return '<input type="text" name="solutions" readonly class="layui-input tips" style="height: 100%;background: #e7e7e7;" value="' + (d.solutions || '') + '">'
                            }
                        },
                        {
                            field: 'securityKnowledgeName', title: '检查详细内容', minWidth: 150, templet: function (d) {
                                return '<input securityPlanId="' + (d.securityPlanId || '') + '" securityPlanDetailsId="'+(d.securityPlanDetailsId || '')+'" securityTermId="'+(d.securityTermId || '')+'" type="text" name="securityKnowledgeName" class="layui-input chooseMaterials tips" style="height: 100%;color: blue;background: #e7e7e7;cursor: pointer" readonly value="' + (d.securityKnowledgeName || '') + '">'
                            }
                        }
                    ]
                    //管理策划要求
                    var cols2 = [
                        {type: 'numbers', title: '序号'},
                        {field: 'mainRisks', title: '主要重难点及风险',minWidth: 150, templet: function (d) {
                        return '<span class="mainRisks" securityPlanId="'+(d.securityPlanId || '')+'" securityPlanInfoId="'+(d.securityPlanInfoId || '')+'" planingSecurityId="'+(d.planingSecurityId || '')+'"> '+(d.mainRisks || '')+'</span>'
                    }},
                        {field: 'contentDesc', title: '内容描述',minWidth: 150},
                        {field: 'solutions', title: '解决措施',minWidth: 150},
                        {field: 'projectUserName', title: '项目责任人',minWidth: 150},
                        {field: 'companyUserName', title: '公司责任人',minWidth: 150}
                    ]
                    //查看详情
                    if(type!=4){
                        cols.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                        cols2.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                    }
                    table.render({
                        elem: '#detailedTable',
                        data: data&&data.details||[],
                        toolbar: type==4?false:'#toolbarPlan2',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done:function(res){
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
                    });

                    table.render({
                        elem: '#objectivesTable',
                        data: data&&data.infoWithBLOBsList||[],
                        toolbar: type==4?false:'#toolbarPlan2',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols2],
                        done:function(res){
                            objectivesTableData = res.data
                        }
                    });

                    //查看详情
                    if(type==4){
                        $('._disabled [name]').attr('disabled', 'disabled');
                        $('.refresh_no_btn').hide();
                        $('.file_upload_box').hide()
                        $('.deImgs').hide();
                        $('.chooseMaterials').attr('disabled', false);
                    }

                    element.render();
                    form.render();
                },
                yes: function (index) {
                    if(type!='4'){
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value
                        });

                        obj.projectId = $('#leftId').attr('projId');


                        if(type == '1'){
                            obj.securityPlanId= data.securityPlanId;
                        }

                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                        }
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;

                        obj.details = planningDetailsData().scheduleData;
                        obj.infoWithBLOBsList = planningDetailsData().qualityData;

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
                            return false;
                        }
                        var loadIndex = layer.load();

                        $.ajax({
                            url: url,
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            success: function (res) {
                                layer.close(loadIndex);
                                if (res.code=='0') {
                                    layer.msg('保存成功！', {icon: 1});
                                    layer.close(index);
                                    tableIns.config.where._ = new Date().getTime();
                                    tableIns.reload();
                                } else {
                                    layer.msg(res.msg, {icon: 7});
                                }
                            }
                        });
                    }else {
                        layer.close(index);
                    }

                },btn2:function(){
                    if(data!=undefined&&data.auditerStatus != undefined&&data.auditerStatus != '0'){
                        layer.msg('该数据已提交！', {icon: 0, time: 2000});
                        return false;
                    }


                    var datas = $('#baseForm').serializeArray();
                    var obj = {}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });

                    obj.projectId = $('#leftId').attr('projId');


                    if(type == '1'){
                        obj.securityPlanId= data.securityPlanId;
                    }

                    // 附件
                    var attachmentId = '';
                    var attachmentName = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                    }
                    obj.attachmentId = attachmentId;
                    obj.attachmentName = attachmentName;

                    obj.details = planningDetailsData().scheduleData;
                    obj.infoWithBLOBsList = planningDetailsData().qualityData;

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
                        return false;
                    }

                    var loadIndex = layer.load();

                    $.ajax({
                        url:url,
                        data: JSON.stringify(obj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.code=='0') {
                                layer.open({
                                    type: 1,
                                    title: '选择流程',
                                    area: ['70%', '80%'],
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                    success: function () {
                                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '72'}, function (res) {
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
                                            /*delete approvalData.detailList
                                            delete approvalData.manageInfoList*/
                                            approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                            approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                            newWorkFlow(flowData.flowId, function (res) {
                                                var submitData = {
                                                    securityPlanId:approvalData.securityPlanId,
                                                    runId: res.flowRun.runId,
                                                    //manageProjStatus:1
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.ajax({
                                                    url: '/securityPlan/updateById',
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
                                layer.msg(res.msg || '保存失败!', {icon: 2});
                            }
                        }
                    });
                }
            });
        }

        // 检查计划明细-加行
        table.on('toolbar(detailedTable)', function (obj) {
            switch (obj.event) {
                case 'choice':
                    layer.open({
                        type: 1,
                        title: '选择检查项',
                        area: ['80%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" style="padding:0px 10px">' +
                        '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                        '                <div class="layui-col-xs2">\n' +
                        '                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                        '                    <button type="button" class="layui-btn layui-btn-sm InSearch_Data">查询</button>\n' +
                        '                </div>\n' +
                        '</div>' +
                        '<div>' +
                        '     <table id="table_DemoIn" lay-filter="table_DemoIn"></table>\n' +
                        '</div>' +
                        '</div>'].join(''),
                        success: function () {
                            var table_DemoIn=table.render({
                                elem: '#table_DemoIn',
                                url: '/securityTerm/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
                                cols: [[
                                    {type: 'checkbox'},
                                    {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
                                    {field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120,sort: true, hide: false},
                                    {field: 'personLiableName', title: '检查人', minWidth: 120,sort: true, hide: false},
                                    {field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
                                            return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
                                        }},
                                    {field: 'solutions', title: '检查项描述', minWidth: 160}
                                    /*{field: 'mainDifficulties', title: '主要隐患', minWidth: 120,sort: true, hide: false},
                                    {field: 'mainRisks', title: '主要风险', minWidth: 120,sort: true, hide: false},
                                    {field: 'solutions', title: '风险解决措施', minWidth: 120,sort: true, hide: false}*/
                                ]],
                                // height: 'full-430',
                                page: true
                            });
                            $('.InSearch_Data').click(function(){
                                var documentNo=$('[name="documentNo"]').val();
                                table_DemoIn.reload({
                                    where:{
                                        documentNo:documentNo
                                    }
                                })
                            })
                        },
                        yes: function (index) {

                            var checkStatus = table.checkStatus('table_DemoIn'); //获取选中行状态
                            var datas = checkStatus.data;  //获取选中行数据

                            //判断是否选择数据
                            if (datas.length == 0) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }

                            //遍历表格获取每行数据进行保存
                            var dataArr = planningDetailsData().scheduleData;

                            // datas.forEach(function (item) {
                            //     item.mainRisk = item.mainRisks
                            //     item.riskSolutions = item.solutions
                            // })
                            dataArr = dataArr.concat(datas)

                            table.reload('detailedTable', {
                                data: dataArr,
                                height: dataArr&&dataArr.length>5?'full-350':false
                            });
                            layer.close(index)
                        },
                    })

            }
        });
        //检查详细内容
        $(document).on('click', '.chooseMaterials', function () {
            var loadIndex = layer.load();
            $.post('/securityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
                new_Edit(res.obj)
                layer.close(loadIndex);
            })
        })
        // 检查计划明细-删行
        table.on('tool(detailedTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                if (data.securityPlanDetailsId) {
                    $.get('/securityPlan/del', {ids: data.securityPlanDetailsId,type:"planDetails"}, function (res) {
                        if (res.code == '0') {
                            layer.msg('删除成功!', {icon: 1, time: 2000});
                            obj.del();
                            table.reload('detailedTable', {
                                data: planningDetailsData().scheduleData
                            });
                        } else {
                            layer.msg('删除失败!', {icon: 2, time: 2000});
                        }
                    });
                } else {
                    layer.msg('删除成功!', {icon: 1, time: 2000});
                    obj.del();
                    table.reload('detailedTable', {
                        data: planningDetailsData().scheduleData
                    });
                }
            }else if (layEvent == 'chooseCollectionUser') {
                if(!$tr.find('[name="personLiableName"]').attr('disabled')){
                    user_id = $tr.find('[name="personLiableName"]').attr('id');
                    $.popWindow('/common/selectUser?0');
                }
            }
        })


        // 管理策划要求-选择
        table.on('toolbar(objectivesTable)', function (obj) {
            switch (obj.event) {
                case 'choice':
                    layer.open({
                        type: 1,
                        title: '选择管理策划',
                        area: ['80%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" style="padding:0px 10px">' +
                        '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                        '                <div class="layui-col-xs2">\n' +
                        '                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                        '                    <input type="text" name="managePlanningName" id="" placeholder="策划名称" autocomplete="off" class="layui-input">\n' +
                        '                </div>\n' +
                        '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                        '                    <button type="button" class="layui-btn layui-btn-sm InSearchData">查询</button>\n' +
                        '                </div>\n' +
                        '</div>' +
                        '<div>' +
                        '     <table id="tableDemoIn" lay-filter="tableDemoIn"></table>\n' +
                        '     <div id="downBox">\n' +
                        '         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
                        '      </div>' +
                        '</div>' +
                        '</div>'].join(''),
                        success: function () {
                            var tableDemoIn=table.render({
                                elem: '#tableDemoIn',
                                url: '/managePlanning/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
                                cols: [[
                                    {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
                                    {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
                                    {field: 'managePlanningName', title: '策划名称', minWidth: 120,sort: true, hide: false},
                                    {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
                                    {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
                                    {field: 'managePlanningExplain', title: '策划说明',minWidth: 120, sort: true, hide: false}
                                ]],
                                // height: 'full-430',
                                page: true
                            });
                            $('.InSearchData').click(function(){
                                var documentNo=$('[name="documentNo"]').val();
                                var managePlanningName=$('[name="managePlanningName"]').val();
                                tableDemoIn.reload({
                                    where:{
                                        documentNo:documentNo,
                                        managePlanningName:managePlanningName
                                    }
                                })
                            })
                        },
                        yes: function (index) {

                            var checkStatus = table.checkStatus('tableDemoInDown'); //获取选中行状态
                            var datas = checkStatus.data;  //获取选中行数据

                            //判断是否选择数据
                            if (datas.length == 0) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }

                            //遍历表格获取每行数据进行保存
                            var dataArr = planningDetailsData().qualityData;

                            datas.forEach(function (item) {
                                if(dataArr){
                                    var _flag = true
                                    for(var j=0;j<dataArr.length;j++){
                                        if(dataArr[j].planingSecurityId==item.planingSecurityId){
                                            _flag = false
                                        }
                                    }
                                    if(_flag){
                                        dataArr.push(item)
                                    }
                                }else{
                                    dataArr.push(item)
                                }
                            })
                            table.reload('objectivesTable', {
                                data: dataArr,
                                height: dataArr&&dataArr.length>5?'full-350':false
                            });
                            layer.close(index)
                        },
                    })
                    break;
            }
        });
        //监听行单击事件
        table.on('row(tableDemoIn)', function (obj) {
            // console.log(obj.data) //得到当前行数据
            var data = obj.data
            $('#downBox').show()
            obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
            tableShowDown(data.securityWithBLOBsList)
        });

        //技术策划明细表格
        function tableShowDown(data) {
            table.render({
                elem: '#tableDemoInDown',
                data: data,
                cellMinWidth:150,
                cols: [[
                    {type: 'checkbox'},
                    {field: 'mainRisks', title: '主要重难点及风险',minWidth: 150},
                    {field: 'contentDesc', title: '内容描述',minWidth: 150},
                    {field: 'solutions', title: '解决措施',minWidth: 150},
                    {field: 'projectUserName', title: '项目责任人',minWidth: 150},
                    {field: 'companyUserName', title: '公司责任人',minWidth: 150}
                ]],
                // height: 'full-430',
                page: true,
                done:function(res){
                    var oldDataArr = planningDetailsData().qualityData;
                    var _dataa=res.data;
                    if(oldDataArr!=undefined&&oldDataArr.length>0){
                        for(var i = 0 ; i <_dataa.length;i++){
                            for(var n = 0 ; n < oldDataArr.length; n++){
                                if(_dataa[i].planingSecurityId == oldDataArr[n].planingSecurityId){
                                    $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                    //form.render('checkbox');
                                }
                            }
                        }
                    }

                }
            });
        }
        // 管理策划要求-删行
        table.on('tool(objectivesTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                if (data.securityPlanInfoId) {
                    $.get('/securityPlan/del', {ids: data.securityPlanInfoId,type:"planInfo"}, function (res) {
                        if (res.code == '0') {
                            layer.msg('删除成功!', {icon: 1, time: 2000});
                            obj.del();
                            table.reload('objectivesTable', {
                                data: planningDetailsData().qualityData
                            });
                        } else {
                            layer.msg('删除失败!', {icon: 2, time: 2000});
                        }
                    });
                } else {
                    layer.msg('删除成功!', {icon: 1, time: 2000});
                    obj.del();
                    table.reload('objectivesTable', {
                        data: planningDetailsData().qualityData
                    });
                }
            }
        })

        /**
         * 获取子表数据
         */
        function planningDetailsData() {
            //遍历表格获取每行数据
            //检查计划明细
            var $trs = $('.project_detailed_information').find('.layui-table-main tr');
            var dataArr = [];
            $trs.each(function () {
                var schDom=$(this).find('input[name="personLiableName"]');
                var scheduleUser = $(schDom).attr('user_id')||''
                if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
                    scheduleUser=scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
                }
                var dataObj = {
                    securityPlanId: $(this).find('input[name="securityKnowledgeName"]').attr('securityPlanId') || '',
                    securityPlanDetailsId: $(this).find('input[name="securityKnowledgeName"]').attr('securityPlanDetailsId') || '',
                    securityTermId: $(this).find('input[name="securityKnowledgeName"]').attr('securityTermId') || '',
                    securityKnowledgeName: $(this).find('input[name="securityKnowledgeName"]').val(),
                    // inspectionContent: $(this).find('input[name="inspectionContent"]').val(),
                    // mainDifficulties: $(this).find('input[name="mainDifficulties"]').val(),
                    // mainRisk: $(this).find('input[name="mainRisk"]').val(),
                    // riskSolutions: $(this).find('input[name="riskSolutions"]').val(),
                    personLiableName: $(this).find('input[name="personLiableName"]').val(),
                    personLiable: scheduleUser,
                    checkFrequency: $(this).find('[name="checkFrequency"]').val(),
                    solutions: $(this).find('[name="solutions"]').val(),
                }
                dataArr.push(dataObj);
            });

            //管理策划要求
            var $trs2 = $('.project_objectives').find('.layui-table-main tr');
            var dataArr2 = [];
            $trs2.each(function () {
                var dataObj = {
                    securityPlanId: $(this).find('.mainRisks').attr('securityPlanId') || '',
                    securityPlanInfoId: $(this).find('.mainRisks').attr('securityPlanInfoId') || '',
                    planingSecurityId: $(this).find('.mainRisks').attr('planingSecurityId') || '',
                    mainRisks: $(this).find('.mainRisks').text(),
                    contentDesc: $(this).find('[data-field="contentDesc"]').text(),
                    solutions:  $(this).find('[data-field="solutions"]').text(),
                    projectUserName:  $(this).find('[data-field="projectUserName"]').text(),
                    companyUserName:  $(this).find('[data-field="companyUserName"]').text()
                }
                dataArr2.push(dataObj);
            });

            return {
                scheduleData: dataArr,
                qualityData: dataArr2
            }
        }

        function new_Edit(data) {
            var projectId = $('#leftId').attr('projId');
            layer.open({
                type: 1,
                title: '检查详细内容',
                area: ['90%', '90%'],
                btn: ['确定'],
                btnAlign: 'c',
                content: '<div style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
                success: function () {

                    //检查计划明细
                    var cols = [
                        // {type: 'radio'},
                        {type: 'numbers', title: '序号'},
                        {field: 'securityDanger', minWidth:150,title: '检查内容'},
                        {field: 'securityDangerMeasures', minWidth:150,title: '整改措施'},
                        {field: 'securityDangerGrade',minWidth:100, title: '隐患级别',templet:function(d){
                                if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
                                    if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
                                        return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
                                    }else{
                                        return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
                                    }
                                }else{
                                    return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
                                }
                            }
                        }
                    ]

                    table.render({
                        elem: '#detailed_Table',
                        data: data&&data.detailList||[],
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done:function(res){
                            $('.layui-table-body [data-field="securityDanger"] div,.layui-table-body [data-field="securityDangerMeasures"] div').on('mouseenter', function(){
                                var content = $(this).text();
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
                    });

                    form.render();
                },
                yes: function (index) {
                    layer.close(index);
                }
            });
        }


        //点击查询
        $('.searchData').click(function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                // 将查询值保存至cookie中
                // $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
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


        //数据列表点击审批状态查看流程功能
        $(document).on('click', '.preview_flow', function() {
            var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId');
            if (flowId && runId) {
                $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
            }
        });

    });

    /**
     * 获取自动编号接口
     * @param params (参数{autoNumber: 数据库表名, costType: 报销单类型})
     * @param callback (回调函数)
     */
    function getAutoNumber(params, callback) {
        $.get('/planningManage/autoNumber', params, function (res) {
            callback(res);
        });
    }


    function openRold(){ //流程转交下一步后会调用此方法
        //刷新表格
        tableIns.config.where._ = new Date().getTime();
        tableIns.reload();
    }
</script>
</body>
</html>
