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
    <title>质量检查项</title>

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
            /*overflow: hidden;*/
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

        .project_detailed_information td[data-field="attachmentName"] .layui-table-cell{
            height: auto;
            overflow:visible;
            text-overflow:inherit;
            white-space:normal;
            word-break: break-word;
        }

        .project_detailed_information .dech a{
            display: block;
        }
        .project_detailed_information .dech a:nth-of-type(2){
            display: none;
        }
        .project_detailed_information .dech a:nth-of-type(3){
            display: none;
        }
        .project_detailed_information .dech:hover a{
            display: block;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">质量检查项</h2>
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
<%--                    <div class="layui-col-xs2" style="margin-left: 15px;">--%>
<%--                        <input type="text" name="securityTermName" placeholder="检查计划名称" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                <div class="layui-col-xs2" style="margin-left: 15px;">--%>
<%--                    <select name="auditerStatus">--%>
<%--                        <option value="">请选择审批状态</option>--%>
<%--                        <option value="0">未提交</option>--%>
<%--                        <option value="1">审批中</option>--%>
<%--                        <option value="2">批准</option>--%>
<%--                        <option value="3">不批准</option>--%>
<%--                    </select>--%>
<%--                </div>--%>
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
<%--        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>--%>
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
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
<%--        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>--%>
    </div>
</script>

<script type="text/html" id="barPlan">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
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
                    return '<span securityTermId="'+d.securityTermId+'">'+(d.documentNo||'')+'</span>'
                }},
            // projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
            securityKnowledgeName: {field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120,sort: true, hide: false},
            personLiableName: {field: 'personLiableName', title: '检查人', minWidth: 120,sort: true, hide: false},
            checkFrequency:{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
                    return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
                }},
            importance:{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
                    return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
                }},
            solutions:{field: 'solutions', title: '检查项描述', minWidth: 160}
            /*currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',minWidth: 130, sort: false, hide: false},
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
            }*/
        }

        // 获取数据字典数据
        var dictionaryObj = {
            CHECK_FREQUENCY:{},
            SCHEDULE_INPORTANCE:{}
        }
        var dictionaryStr = 'CHECK_FREQUENCY,SCHEDULE_INPORTANCE';
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
                    // if (checkStatus.data[0].auditerStatus!=0) {
                    //     layer.msg('已提交不可编辑！', {icon: 0});
                    //     return false
                    // }
                    // var auditerStatus = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="auditerStatus"]').attr('data-content')
                    // if (auditerStatus!=0) {
                    //     layer.msg('已提交不可编辑！', {icon: 0});
                    //     return false
                    // }
                    if($('#leftId').attr('projId')){
                        var securityTermId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span').attr('securityTermId')
                        var loadIndex = layer.load();
                        $.post('/qualityTerm/getById', {kayId: securityTermId}, function (res) {
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
                    var securityTermId = ''
                    var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
                    $trs.each(function(){
                        securityTermId += $(this).attr('securityTermId') + ','
                    })
                    // checkStatus.data.forEach(function (v, i) {
                    // 	securityTermId += v.securityTermId + ','
                    // })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/qualityTerm/del', {ids: securityTermId}, function (res) {
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
                /*case 'submit':
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
                                        securityTermId:approvalData.securityTermId,
                                        runId: res.flowRun.runId,
                                        //auditerStatus:1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/qualityTerm/updateById',
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
                    break;*/
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
            var securityTermId = $(obj.tr.selector).find('[data-field="documentNo"] span').attr('securityTermId')
            if(layEvent === 'detail'){
                var loadIndex = layer.load();
                $.post('/qualityTerm/getById', {kayId: securityTermId}, function (res) {
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
                title: '检查详细内容',
                minWidth: 150
            })

            tableIns = table.render({
                elem: '#tableDemo',
                url: '/qualityTerm/select',
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
                title = '新建质量检查项';
                url = '/qualityTerm/insert';
            } else if (type == '1') {
                title = '编辑质量检查项';
                url = '/qualityTerm/updateById';
            }else if(type == '4'){
                title = '查看详情'
            }


            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: type != '4'?['保存', '取消']:['确定'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse _disabled">\n' +
                /* region 方案内容 */
                '  <div class="layui-colla-item _one">\n' +
                '    <h2 class="layui-colla-title">方案内容</h2>\n' +
                '    <div class="layui-colla-content layui-show plan_base_info">' +
                '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
                /* region 第一行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs3 layui-col-xs20" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                       <input type="text" name="documentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                /*'               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +*/
                '               <div class="layui-col-xs3 layui-col-xs20" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">检查项名称<span field="securityKnowledgeName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                // '<input type="text"  name="securityKnowledgeName"  style="cursor: pointer;" placeholder="请选择检查项" readonly="" autocomplete="off" class="layui-input">' +
                // '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
                '                           <input type="text" name="securityKnowledgeName"  autocomplete="off" class="layui-input">' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs3 layui-col-xs20" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label form_label">检查人<span field="personLiableName" class="field_required">*</span></label>\n' +
                '                       <div class="layui-input-block form_block">\n' +
                '                           <input type="text" name="personLiableName" id="personLiableName"  autocomplete="off" class="layui-input">' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs3 layui-col-xs20" style="padding: 0 10px">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">检查频率<span field="checkFrequency" class="field_required">*</span></label>' +
                '                        <div class="layui-input-block form_block" name="checkFrequencyy" id="checkFrequencyy">' +
                //'                           <textarea style="width:100%;height 38px;resize: vertical;"  name="personLiableName" autocomplete="off" class="layui-input"></textarea>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs3 layui-col-xs20" style="padding: 0 10px">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">重要性<span field="importance" class="field_required">*</span></label>' +
                '                        <div class="layui-input-block form_block" name="importancey" id="importancey">' +
                //'                           <textarea style="width:100%;height 38px;resize: vertical;"  name="mainRisks" autocomplete="off" class="layui-input"></textarea>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '           </div>' ,
                    '<div class="layui-row">' +

                    '   <div class="layui-col-xs12" style="padding: 0 10px">' +
                    '       <div class="layui-form-item">' +
                    '           <label class="layui-form-label form_label">检查项描述<span field="solutions" class="field_required">*</span></label>' +
                    '            <div class="layui-input-block form_block">' +
                    '               <textarea style="width:100%;height:100px;resize: vertical;"  name="solutions" autocomplete="off" class="layui-input"></textarea>' +
                    '           </div>' +
                    '       </div>' +
                    '   </div>' +
                    '</div>' +
                    /*'           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">附件</label>' +
                    '                       <div class="layui-input-block form_block">' +
                    '<div class="file_module">' +
                    '<div id="fileAll" class="file_content"></div>' +
                    '<div class="file_upload_box">' +
                    '<a href="javascript:;" class="open_file">' +
                    '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                    '<input type="file" multiple id="fileupload" data-url="/upload?module=securityTerm" name="file">' +
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
                    '           </div>',*/
                    /* endregion */
                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n' +
                    /* endregion */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">检查详细内容</h2>\n' +
                    '    <div class="layui-colla-content layui-show project_detailed_information">' +
                    '		<table id="detailedTable" lay-filter="detailedTable"></table>' +
                    '    </div>\n' +
                    '  </div>\n' +
                    /* endregion */
                    '</div>'].join(''),
                success: function () {
                    // fileuploadFn('#fileupload', $('#fileAll'));
                    //回显项目名称
                    getProjName('#projectName',projectId?projectId:data.projectId)

                    var optionStr = '<option value="">请选择</option>';
                    if(dictionaryObj.CHECK_FREQUENCY.object){
                        for (index in dictionaryObj.CHECK_FREQUENCY.object){
                            if(data&&data.checkFrequency&&index===data.checkFrequency){
                                optionStr += '<option selected value="'+index+'" >'+dictionaryObj.CHECK_FREQUENCY.object[index]+'</option>';
                            }else{
                                optionStr += '<option value="'+index+'" >'+dictionaryObj.CHECK_FREQUENCY.object[index]+'</option>';
                            }
                        }
                        $("#checkFrequencyy").html('<select name="checkFrequency" class="layui-input" style="height: 100%;">'+optionStr+'</select>')
                    }
                    var optionStr2 = '<option value="">请选择</option>';
                    if(dictionaryObj.SCHEDULE_INPORTANCE.object){
                        for (index in dictionaryObj.SCHEDULE_INPORTANCE.object){
                            if(data&&data.importance&&index===data.importance){
                                optionStr2 += '<option selected value="'+index+'" >'+dictionaryObj.SCHEDULE_INPORTANCE.object[index]+'</option>';
                            }else{
                                optionStr2 += '<option value="'+index+'" >'+dictionaryObj.SCHEDULE_INPORTANCE.object[index]+'</option>';
                            }
                        }
                        $("#importancey").html('<select name="importance" class="layui-input" style="height: 100%;">'+optionStr2+'</select>')
                    }
                    //检查项
                    /*var el;
                    $("[name='securityKnowledgeName']").on("click",function (e) {
                        //debugger
                        e.stopPropagation();
                        if(!el){
                            el=eleTree.render({
                                elem: '.ele2',
                                url:'/workflow/qualityManager/getSecurityByType?parent=0',
                                expandOnClickNode: false,
                                highlightCurrent: true,
                                showLine:true,
                                showCheckbox: false,
                                checked: false,
                                lazy: true,
                                load: function(data,callback) {
                                    $.post('/workflow/qualityManager/getSecurityByType?parent='+data.id,function (res) {
                                        callback(res.data);//点击节点回调
                                    })
                                },
                                done: function(res){

                                }
                            });
                        }
                        $(".ele2").slideDown();
                    })
                    $(document).on("click",function() {
                        $(".ele2").slideUp();
                    })
                    //节点点击事件
                    eleTree.on("nodeClick(data2)",function(d) {
                        var parData1 = d.data.currentData;
                        // var str111="";
                        // console.log(parData1)
                        // $.ajax({
                        //     url:'/workflow/qualityManager/getKnowledgeById?knowleId='+parData1.securityKnowledgeId,
                        //     dataType:'json',
                        //     type:'post',
                        //     async: false,
                        //     success:function(res){
                        //         if(res.code===0||res.code==="0"){
                        //             var securityKnowledgeName = res.obj;
                        //             str111+=securityKnowledgeName+"，"
                        //         }
                        //     }
                        // })

                        $("[name='securityKnowledgeName']").val(parData1.securityKnowledgeName);
                        $("[name='securityKnowledgeName']").attr("securityKnowledgeId",parData1.id);
                    })*/

                    //回显数据
                    if (type == 1 || type == 4) {
                        form.val("formTest", data);
                        $("[name='personLiableName']").attr("user_id",data.personLiable||"");
                        //附件
                        // if (data.attachList && data.attachList.length > 0) {
                        //     var fileArr = data.attachList;
                        //     $('#fileAll').append(echoAttachment(fileArr));
                        // }
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumberType: 'qualityTerm'}, function(res) {
                            $('input[name="documentNo"]', $('#baseForm')).val(res.obj);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumberType: 'qualityTerm'}, function(res) {
                                $('input[name="documentNo"]', $('#baseForm')).val(res.obj);
                            });
                        });
                    }

                    //检查计划明细
                    var cols = [
                        {type: 'checkbox'},
                        // {type: 'numbers', title: '序号'},
                        {field: 'securityDanger', minWidth:150,title: '质量控制要点'},
                        {field: 'securityDangerMeasures', minWidth:150,title: '特征描述'},
                        {
                            field: 'attachmentName',
                            title: '特征图片',
                            align: 'center',
                            minWidth: 200,
                            templet: function (d) {
                                var fileArr = d.attachmentList;
                                return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
                                    '</div>'

                            }
                        },
                        {field: 'securityDangerGrade',minWidth:100, title: '重大问题',templet:function(d){
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
                    //查看详情
                    if(type!=4){
                        cols.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                    }
                    table.render({
                        elem: '#detailedTable',
                        data: data&&data.detailList||[],
                        toolbar: type==4?false:'#toolbarPlan',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done:function (res) {
                            $('.deImgs').hide();
                        }
                    });


                    //查看详情
                    if(type==4){
                        $('._disabled [name]').attr('disabled', 'disabled');
                        $('.refresh_no_btn').hide();
                        // $('.file_upload_box').hide()
                        // $('.deImgs').hide();

                        $('._one').hide()
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

                        // obj.securityKnowledgeId = $("[name='securityKnowledgeName']").attr("securityKnowledgeId")
                        obj.projectId = $('#leftId').attr('projId');
                        var personLiableName = $("[name='personLiableName']").val();
                        var personLiable = $("[name='personLiableName']").attr("user_id");
                        if(personLiableName&&validationEnd(personLiableName,",")){
                            personLiableName = personLiableName.substring(0,personLiableName.length-1);
                        }
                        if(personLiable&&validationEnd(personLiable,",")){
                            personLiable = personLiable.substring(0,personLiable.length-1);
                        }
                        obj.personLiableName = personLiableName;
                        obj.personLiable = personLiable;

                        if(type == '1'){
                            obj.securityTermId= data.securityTermId;
                        }

                        // 附件
                        // var attachmentId = '';
                        // var attachmentName = '';
                        // for (var i = 0; i < $('#fileAll .dech').length; i++) {
                        //     attachmentId += $('#fileAll .dech').eq(i).find('input').val();
                        //     attachmentName += $('#fileAll .dech').eq(i).find("a").eq(0).attr('name');
                        // }
                        // obj.attachmentId = attachmentId;
                        // obj.attachmentName = attachmentName;

                        obj.detailList = planningDetailsData(1).scheduleData;

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

                },
                /*btn2:function(){
                    if(data!=undefined&&data.auditerStatus != undefined&&data.auditerStatus != '0'){
                        layer.msg('该数据已提交！', {icon: 0, time: 2000});
                        return false;
                    }


                    var datas = $('#baseForm').serializeArray();
                    var obj = {}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });

                    obj.securityKnowledgeId = $("[name='securityKnowledgeName']").attr("securityKnowledgeId")
                    obj.projectId = $('#leftId').attr('projId');


                    if(type == '1'){
                        obj.securityTermId= data.securityTermId;
                    }

                    // 附件
                    // var attachmentId = '';
                    // var attachmentName = '';
                    // for (var i = 0; i < $('#fileAll .dech').length; i++) {
                    //     attachmentId += $('#fileAll .dech').eq(i).find('input').val();
                    //     attachmentName += $('#fileAll .dech').eq(i).find("a").eq(0).attr('name');
                    // }
                    // obj.attachmentId = attachmentId;
                    // obj.attachmentName = attachmentName;

                    obj.detailList = planningDetailsData(1).scheduleData;

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
                                            /!*delete approvalData.detailList
                                            delete approvalData.manageInfoList*!/
                                            approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                            approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                            newWorkFlow(flowData.flowId, function (res) {
                                                var submitData = {
                                                    securityTermId:approvalData.securityTermId,
                                                    runId: res.flowRun.runId,
                                                    //manageProjStatus:1
                                                }
                                                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                $.ajax({
                                                    url: '/qualityTerm/updateById',
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
                }*/
            });
        }

        // 检查详细内容
        table.on('toolbar(detailedTable)', function (obj) {
            var dataTable = table.checkStatus(obj.config.id).data;
            switch (obj.event) {
                case 'add':
                    layer.open({
                        type: 2,
                        title: '新增',
                        btn: ['确定','取消'],
                        btnAlign: 'c',
                        area: ['90%', '80%'],
                        maxmin: true,
                        content: '/workflow/qualityManager/toStandard?type=checkbox',
                        success: function () {

                        },
                        yes: function (index,layero) {
                            var childData  = $(layero).find("iframe")[0].contentWindow.getRepairDate4();
                            var dataArr = planningDetailsData(2).scheduleData

                           /* childData.forEach(function (item) {
                                if(dataArr){
                                    var _flag = true
                                    for(var j=0;j<dataArr.length;j++){
                                        if(dataArr[j].securityDangerId==item.securityDangerId){
                                            _flag = false
                                        }
                                    }
                                    if(_flag){
                                        dataArr.push(item)
                                    }
                                }else{
                                    dataArr.push(item)
                                }
                            })*/
                            var newArr = dataArr.concat(childData)

                             newArr.forEach(function(item,index){
                                 item.index=index
                            })

                            table.reload('detailedTable', {
                                data: newArr,
                                height: newArr&&newArr.length>5?'full-350':false
                            });
                            layer.close(index)
                        }
                    })
                    break;
                case 'edit':
                    if (dataTable.length != 1) {
                        layer.msg('请选择一项！', {icon: 0});
                        return false
                    }
                    var checkDate = dataTable[0]
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '90%'], //宽高
                        title: '编辑',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        btnAlign: 'c',
                        content: '<div class="layui-form">' +
                            // '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            // '<label class="layui-form-label">名称</label>' +
                            // '<div class="layui-input-block">' +
                            // '<input class="layui-input"  lay-verify="required" name="testName" id="testName">' +
                            // '</div>' +
                            // '</div>' +
                            // '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            // '<label class="layui-form-label"><span style="color: red">*</span>检查项</label>' +
                            // '<div class="layui-input-block">' +
                            // '<textarea type="text" id="pele" pid name="ttitle1" required="" style="cursor: pointer;min-height: 80px;" placeholder="请选择检查项"  autocomplete="off" class="layui-input"></textarea>' +
                            // // '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
                            // '</div>' +
                            // '</div>' +
                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            '<label class="layui-form-label"><span style="color: red">*</span>质量控制要点</label>' +
                            '<div class="layui-input-block">' +
                            '<textarea type="text" id="pele3" pid name="ttitle3" required="" style="cursor: pointer;min-height: 80px;"   autocomplete="off" class="layui-input"></textarea>' +
                            '</div>' +
                            '</div>' +
                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            '<label class="layui-form-label"><span style="color: red">*</span>特征描述</label>' +
                            '<div class="layui-input-block">' +
                            '<textarea type="text" id="securityDangerMeasures" name="securityDangerMeasures"  style="cursor: pointer;min-height: 80px;"  autocomplete="off" class="layui-input"></textarea>' +
                            '</div>' +
                            '</div>' +
                            '<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
                            '<label class="layui-form-label"><span style="color: red">*</span>重大问题</label>' +
                            '<div class="layui-input-block">' +
                            '<select name="securityDangerGrade" id="securityDangerGrade" class="layui-input"  lay-verify="required"></select>' +
                            '</div>' +
                            '</div>' +
                            '<div class="inbox">' +
                            '<label class="layui-form-label">特征图片</label>' +
                            '<div class="layui-input-block" style="margin-left: 130px;">' +
                            '<div class="file_module" style="margin-top: 8px;line-height: 36px;">' +
                            '<div id="fileAll" class="file_content"></div>' +
                            '<div class="file_upload_box">' +
                            '<a href="javascript:;" class="open_file">' +
                            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '<input type="file" multiple id="fileupload" data-url="/upload?module=qualityDanger" name="file">' +
                            '</a>' +
                            '<div class="progress" id="progress">' +
                            '<div class="bar"></div>\n' +
                            '</div>' +
                            '<div class="bar_text"></div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>',
                        success: function () {

                            fileuploadFn('#fileupload', $('#fileAll'));

                            //$("#testName").val(checkDate.detailsName)//名称
                            //$("#pele").attr("pid",checkDate.securityKnowledgeIds); //检查项
                            //$("#pele3").attr("securityDangerId",checkDate.securityDangerIds); //质量控制要点Id
                            // $("#pele").text(checkDate.securityKnowledgeName);
                            $("#pele3").text(checkDate.securityDanger);

                            var $select1 = $("select[name='securityDangerGrade']");
                            var optionStr = '<option value="">请选择</option>';
                            optionStr += '<option value="0"><span style="color:red">重大隐患</span></option>'
                            optionStr += '<option value="1">一般隐患</option>'
                            $select1.html(optionStr);

                            $("#securityDangerMeasures").val(checkDate.securityDangerMeasures)//特征描述
                            $("#securityDangerGrade").val(checkDate.securityDangerGrade)//重大问题

                            //附件
                            if (checkDate.attachmentList && checkDate.attachmentList.length > 0) {
                                var fileArr = checkDate.attachmentList;
                                $('#fileAll').append(echoAttachment(fileArr));
                            }

                            form.render();//初始化表单

                            $('.deImgs').hide();
                        },
                        yes: function (index, layero) {

                            //var detailsName = $("#testName").val()//名称

                            // var securityKnowledgeName = $("#pele").val(); //检查项

                            var securityDanger = $("#pele3").val(); //质量控制要点

                            var securityDangerMeasures = $("#securityDangerMeasures").val()//特征描述

                            var securityDangerGrade =  $("#securityDangerGrade").val()//重大问题

                            // 附件
                            var attachmentId = '';
                            var attachmentName = '';
                            var attachmentList = [];
                            for (var i = 0; i < $('#fileAll .dech').length; i++) {
                                attachmentId += $('#fileAll .dech').eq(i).find('input').val();
                                attachmentName += $('#fileAll .dech').eq(i).find("a").eq(0).attr('name');

                                var _obj ={
                                    attUrl:$('#fileAll .dech').eq(i).find('input').attr('deUrl'),
                                    attachId:$('#fileAll .dech').eq(i).find('input').attr('attachId'),
                                    attachName:$('#fileAll .dech').eq(i).find('input').attr('attachName'),
                                    size:$('#fileAll .dech').eq(i).find('input').attr('size'),
                                    aid:$('#fileAll .dech').eq(i).find('input').val().substring(0,$('#fileAll .dech .inHidden').val().indexOf('@')),
                                    ym:$('#fileAll .dech').eq(i).find('input').val().substring($('#fileAll .dech .inHidden').val().indexOf('@')+1,$('#fileAll .dech .inHidden').val().indexOf('_'))
                                }
                                attachmentList.push(_obj)
                            }


                            if(!securityDanger){
                                layer.msg("质量控制要点为必填");
                                return false;
                            }else if(!securityDangerMeasures){
                                layer.msg("特征描述为必填");
                                return false;
                            }else if(!securityDangerGrade){
                                layer.msg("重大问题为必填");
                                return false;
                            }else {

                                checkDate.securityDanger=securityDanger
                                checkDate.securityDangerMeasures=securityDangerMeasures
                                checkDate.securityDangerGrade=securityDangerGrade
                                checkDate.attachmentId=attachmentId
                                checkDate.attachmentName=attachmentName
                                checkDate.attachmentList=attachmentList

                                var dataArr = planningDetailsData(2).scheduleData
                                dataArr.forEach(function(item,index){
                                    if(item.index==checkDate.index){
                                        dataArr[index]=checkDate
                                    }
                                })
                                table.reload('detailedTable', {
                                    data: dataArr,
                                    height: dataArr&&dataArr.length>5?'full-350':false
                                });
                                layer.close(index)

                            }
                        }
                    });

                    break;

            }
        });

        //检查详细内容 删除
        table.on('tool(detailedTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                if (data.securityTermDetailId) {
                    $.get('/qualityTerm/delDetails', {ids: data.securityTermDetailId}, function (res) {
                        if (res.flag) {
                            layer.msg('删除成功!', {icon: 1, time: 2000});
                            obj.del();
                            table.reload('detailedTable', {
                                data: planningDetailsData(2).scheduleData,
                                // height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
                            });
                        } else {
                            layer.msg('删除失败!', {icon: 2, time: 2000});
                        }
                    });
                } else {
                    layer.msg('删除成功!', {icon: 1, time: 2000});
                    obj.del();
                    table.reload('detailedTable', {
                        data: planningDetailsData(2).scheduleData,
                        // height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
                    });
                }
            }
        })


        /**
         * 获取子表数据
         */
        function planningDetailsData(type) {
            //遍历表格获取每行数据
            //检查详细内容
            var $trs = $('.project_detailed_information').find('.layui-table-main tr');
            var dataArr = [];
            $trs.each(function (index) {
                var attachId = '';
                var attachName = '';
                var attachList = [];

                if(type=='1'){//提交保存
                    for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                        attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                        attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                    }
                }else if(type=='2'){//加行、删行、选择
                    for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                        attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                        attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                        var _obj ={
                            attUrl:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
                            attachId:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
                            attachName:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
                            size:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('size'),
                            aid:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')),
                            ym:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring($('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('_'))
                        }
                        attachList.push(_obj)
                    }
                }
                var dataObj = {
                    securityDanger: $(this).find('[data-field="securityDanger"] div').text()||'',
                    securityDangerMeasures: $(this).find('[data-field="securityDangerMeasures"] div').text()||'',
                    securityDangerGrade: $(this).find('[data-field="securityDangerGrade"] span').attr('securityDangerGrade')||'',
                    securityTermDetailId: $(this).find('[data-field="securityDangerGrade"] span').attr('securityTermDetailId')||'',
                    securityTermId: $(this).find('[data-field="securityDangerGrade"] span').attr('securityTermId')||'',
                    securityDangerId: $(this).find('[data-field="securityDangerGrade"] span').attr('securityDangerId')||'',
                    securityDangerTypeId: $(this).find('[data-field="securityDangerGrade"] span').attr('securityDangerTypeId')||'',
                    index: $(this).find('[data-field="securityDangerGrade"] span').attr('index')||'',
                    attachmentId:attachId,
                    attachmentName:attachName
                }
                if(type=='2'){
                    dataObj.attachmentList = attachList;
                }
                dataArr.push(dataObj);
            });


            return {
                scheduleData: dataArr
            }
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

    $(document).on('click', '#personLiableName', function () {
        user_id = "personLiableName";
        $.popWindow('/common/selectUser?');
    })
    //str：字符串    appoint：指定字符
    function  validationEnd (str, appoint) {
        str=str.toLowerCase();  //不区分大小写：全部转为小写后进行判断
        var start = str.length-appoint.length;  //相差长度=字符串长度-特定字符长度
        var char= str.substr(start,appoint.length);//将相差长度作为开始下标，特定字符长度为截取长度
        if(char== appoint){ //两者相同，则代表验证通过
            return true;
        }
        return false;
    }
</script>
</body>
</html>
