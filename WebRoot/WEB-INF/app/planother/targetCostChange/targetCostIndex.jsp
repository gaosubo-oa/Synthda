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
    <title>新增成本目标调整</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js?20210604.1"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210830.1"></script>

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
            <h2 style="text-align: center;line-height: 35px;">成本目标调整</h2>
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
<script type="text/html" id="toolDemo">
    <button class="layui-btn layui-btn-xs" lay-event="details">查看详情</button>
</script>
<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script type="text/html" id="toolbarDemoIn2">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add2">选择</button>
    </div>
</script>

<script type="text/html" id="barDemo2">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del2">删行</a>
</script>

<script>
    var projectNamee;
    var _projectId;
    var manageProj_state;
    var manageProj_data;
    var materialDetailsTableData = [];
    var materialDetailsTableData2 = [];
    var _dataa;
    var _dataa2;

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
        documnetNum:{field: 'documnetNum', title: '单据号',minWidth:150, sort: false, hide: false},
        costChaName: {field: 'costChaName', title: '成本目标调整名称',minWidth:120, sort: false, hide: false},
        projectName: {field: 'projectName', title: '项目名称',minWidth:120, sort: false, hide: false},
        optTarType: {field: 'optTarType', title: '优化类型',minWidth:100, sort: false, hide: false, templet: function (d) {
            var str = ''
            if(dictionaryObj['OPT_TAR_TYPE']){
                str = '<span>'+dictionaryObj['OPT_TAR_TYPE']['object'][d.optTarType]+'</span>';
            }
                return str
            }},
        incChaTotal: {field: 'incChaTotal', title: '收入变更总额',minWidth:100, sort: false, hide: false},
        optChaTotal: {field: 'optChaTotal', title: '优化变更总额',minWidth:100, sort: false, hide: false},
        createTime: {
            field: 'createTime', title: '创建时间', sort: false,minWidth:100,hide: false
        },
        currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',minWidth:100, sort: false, hide: false},
        auditerStatus: {
            field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
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

    var TableUIObj = new TableUI('plb_manage_item');

    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {},
        MTL_VALUATION_UNIT:{},
        MANAGE_ITEM_TYPE:{},
        OPT_TAR_TYPE:{}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,MTL_VALUATION_UNIT,MANAGE_ITEM_TYPE,OPT_TAR_TYPE';
    $.ajaxSettings.async = false;
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
    var tableIns = null;
    function initPage() {
        $.ajaxSettings.async = true;
        layui.use(['form', 'table', 'element', 'soulTable', 'eleTree','xmSelect','laydate'], function () {
            var form = layui.form,
                table = layui.table,
                element = layui.element,
                soulTable = layui.soulTable,
                eleTree = layui.eleTree,
                xmSelect = layui.xmSelect,
            laydate = layui.laydate;


            TableUIObj.init(colShowObj, function(){
                // $('.no_data').hide();
                // $('.table_box').show();
                // tableShow();
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
                            defaultExpandAll: false,
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
                _projectId = currentData.projId;
                projectNamee = currentData.projName;
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
                        if($('#leftId').attr('projId')){
                            newOrEdit(0);
                        }else{
                            layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                            return false;
                        }
                        break;
                    case 'edit':
                        if($('#leftId').attr('projId')){
                            if (checkStatus.data.length != 1) {
                                layer.msg('请选择一项！', {icon: 0});
                                return false
                            }
                            if (checkStatus.data[0].auditerStatus > 0) {
                                layer.msg('该条数据已提交，不可编辑！', {icon: 0});
                                return false;
                            }
                            newOrEdit(1, checkStatus.data[0])
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
                        var ids = ''
                        var isFlay = false;

                        checkStatus.data.forEach(function (v, i) {
                            ids += v.tarCostCha + ','
                            if(v.auditerStatus&&v.auditerStatus!='0'){
                                isFlay = true
                            }
                        })
                        if(isFlay){
                            layer.msg('已提交不可删除！', {icon: 0});
                            return false
                        }
                        layer.confirm('确定删除该条数据吗？', function (index) {
                            $.post('/targetCost/del', {ids: ids}, function (res) {
                                if (res.code==='0'||res.code===0) {
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
                    case 'export':
                        layer.msg('导出');
                        break;
                    case 'submit':
                        if (checkStatus.data.length != 1) {
                            layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                            return false;
                        }
                        if (checkStatus.data[0].auditerStatus > 0) {
                            layer.msg('该条数据已提交', {icon: 0});
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
                                $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '54'}, function (res) {
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
                                    delete approvalData.detailList
                                    delete approvalData.manageInfoList
                                    newWorkFlow(flowData.flowId, function (res) {
                                        var submitData = {
                                            tarCostCha:approvalData.tarCostCha,
                                            runId: res.flowRun.runId
                                        }
                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                        $.ajax({
                                            url: '/targetCost/updateById',
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

          table.on('tool(mtlPlanTable)',function(obj){
              var data = obj.data;
              var layEvent = obj.event;
              if(layEvent=='details'){
                  newOrEdit('4',data);
              }
          })

            // 渲染表格
            function tableShow(projId) {
                var searchObj = getSearchObj();
                searchObj.projectId = projId || '';
                searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
                searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                var cols = [{checkbox: true}].concat(TableUIObj.cols);
                cols.push({
                    align: 'center',
                    toolbar: '#toolDemo',
                    title: '操作',
                    width: 120
                })
                var option = {
                    elem: '#mtlPlanTable',
                    url: '/targetCost/select?delFlag=0',
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
                    // request: {
                    //     limitName: 'pageSize'
                    // },

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
                var content = '';
                var url = '';
                var projId = $('#leftId').attr('projId');
                if (type == '0') {
                    title = '新建';
                    url = '/targetCost/insert';
                } else if (type == '1') {
                    title = '编辑';
                    url = '/targetCost/updateById';
                }else if (type == '4'){
                    title = '查看详情';
                }
                layer.open({
                    type: 1,
                    title: title,
                    area: ['100%', '100%'],
                    btn: ['保存', '提交', '取消'],
                    btnAlign: 'c',
                    content:['<div class="layui-collapse _disabled">\n' +
                    <%--    /* region 立项项目基础信息 */--%>
                    '    <div class="layui-colla-item">\n' +
                    '        <h2 class="layui-colla-title">立项信息</h2>\n' +
                    '        <div class="layui-colla-content layui-show plan_base_info">\n' +
                    '            <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
                    <%--                /* region 第一行 */--%>
                    '                <div class="layui-row">\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="documnetNum" autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" id="projectName" name="projectName" autocomplete="off"  class="layui-input ">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">成本目标调整名称<span field="costChaName" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" name="costChaName" autocomplete="off"  class="layui-input ">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    <%--                /* endregion */--%>
                    <%--                /* region 第二行 */--%>
                    '                <div class="layui-row">\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">优化目标类型<span field="optTarType" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <select name="optTarType" id="optTarType" lay-filter="test">\n' +
                    '                                </select>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">收入变更总额<span field="incChaTotal" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="incChaTotal" autocomplete="off" class="layui-input" style="background:#e7e7e7;" value="0">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">优化变更总额<span field="optChaTotal" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="optChaTotal" autocomplete="off"  class="layui-input" style="background:#e7e7e7;" value="0">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    <%--                /* endregion */--%>
                    <%--                /* region 第三行 */--%>
                    '                <div class="layui-row">\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">备注</label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input name="remarks"  class="layui-input">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">填报人<span field="createUser" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="createUser" autocomplete="off" class="layui-input" style="cursor: pointer;">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">填报时间<span field="createTime" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <input type="text" readonly name="createTime" autocomplete="off" class="layui-input" style="cursor: pointer;">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    <%--                /* endregion */--%>
                    <%--                /* region 第四行 */--%>
                    '                <div class="layui-row">\n' +
                    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">变更内容<span field="chaContent" class="field_required">*</span></label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <textarea name="chaContent" id="chaContent" placeholder="请输入变更内容" class="layui-textarea"></textarea>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    <%--                /* endregion */--%>
                    <%--                /* region 第五行 */--%>
                    '                <div class="layui-row">\n' +
                    '                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                        <div class="layui-form-item">\n' +
                    '                            <label class="layui-form-label form_label">附件</label>\n' +
                    '                            <div class="layui-input-block form_block">\n' +
                    '                                <div class="file_module">\n' +
                    '                                    <div id="fileContent" class="file_content"></div>\n' +
                    '                                    <div class="file_upload_box">\n' +
                    '                                        <a href="javascript:;" class="open_file">\n' +
                    '                                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>\n' +
                    '                                            <input type="file" multiple id="fileupload" data-url="/upload?module=targetCostChange" name="file">\n' +
                    '                                        </a>\n' +
                    '                                        <div class="progress" id="progress">\n' +
                    '                                            <div class="bar"></div>\n' +
                    '                                        </div>\n' +
                    '                                        <div class="bar_text"></div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    <%--                /* endregion */--%>
                    '            </form>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    <%--    /* endregion */--%>
                    <%--    /* region 立项明细 */--%>
                    '    <div class="layui-colla-item" id="materialDetailsTableModule">\n' +
                    '        <h2 class="layui-colla-title">立项明细</h2>\n' +
                    '        <div class="layui-colla-content mtl_info layui-show">\n' +
                    '            <div>\n' +
                    '                <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    <%--    /* endregion */--%>
                    <%--    /* region 变更单明细 */--%>
                    // '    <div class="layui-colla-item" >\n' +
                    // '        <h2 class="layui-colla-title">变更单明细</h2>\n' +
                    // '        <div class="layui-colla-content mtl_info2 layui-show">\n' +
                    // '            <div>\n' +
                    // '                <table id="materialDetailsTable2" lay-filter="materialDetailsTable2"></table>\n' +
                    // '            </div>\n' +
                    // '        </div>\n' +
                    // '    </div>\n' +
                    <%--    /* endregion */--%>
                    '</div>'].join(''),
                    success: function () {
                        //项目名称
                        $('#projectName').val(projectNamee);


                        //优化目标类型
                        var $select1 = $("#optTarType");
                        var optionStr = '<option value="">请选择</option>';
                        var _str=dictionaryObj.OPT_TAR_TYPE.str;
                        if(_str!=undefined){
                            optionStr += _str
                        }
                        $select1.html(optionStr);

                        //经营立项日期
                        laydate.render({
                            elem: '#projectDate'
                            , trigger: 'click'
                            , format: 'yyyy-MM-dd'
                            // , format: 'yyyy-MM-dd HH:mm:ss'
                            //,value: new Date()
                        });

                        //附件
                        fileuploadFn('#fileupload', $('#fileContent'));
                        //新增时计划编号显示
                        if (type === 0) {
                            materialDetailsTableData = [];
                            materialDetailsTableData2 = [];
                            // 获取单据号
                            $.ajax({
                                url:'/planningManage/autoNumber?autoNumberType=mbfymb',
                                dataType:'json',
                                type:'post',
                                async: false,
                                success:function(res){
                                    $('input[name="documnetNum"]').val(res.obj);
                                    $('input[name="createUser"]').val(res.object.createUserName);
                                    $('input[name="createTime"]').val(res.object.createTime);
                                }
                            })
                            $(document).on('click', '.refresh_no_btn', function () {
                                $.ajax({
                                    url:'/planningManage/autoNumber?autoNumberType=jylx',
                                    dataType:'json',
                                    type:'post',
                                    async: false,
                                    success:function(res){
                                        $('input[name="documnetNum"]').val(res.obj);
                                        $('input[name="createUser"]').val(res.object.createUserName);
                                        $('input[name="createTime"]').val(res.object.createTime);
                                    }
                                })
                            })
                        }
                        //回显数据
                        if (type == 1 || type == 4) {
                            if(data!=undefined){
                                form.val("baseForm", data);
                                //项目名称
                                _projectId = data.projectId;

                                $('#itemType').val(data ? data.itemName : '');

                                //$('#planDate').val(data ? format(data.planDate) : '')

                                if (data.attachmentList && data.attachmentList.length > 0) {
                                    var fileArr = data.attachmentList;
                                    $('#fileContent').append(echoAttachment(fileArr));
                                }

                                materialDetailsTableData = data.detailsList;
                                materialDetailsTableData2 = [];
                            }

                        }



                        //立项明细
                        var cols=[
                            {type: 'numbers', title: '序号'},
                            /*{
                                field: 'projBudgetId', title: '目标选择',minWidth:100, templet: function (d) {
                                    return '<p name="projBudgetId" style="text-align: center"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="font-size: 25px;cursor: pointer"></i></p>'
                                }
                            },*/
                            {
                                field: 'wbsId', title: 'WBS',minWidth:230, templet: function (d) {
                                    return '<input type="text" readonly name="wbsId" wbsId="'+(d.wbsId||'')+'" projBudgetId="'+(d.projBudgetId||"")+'"  manageProjInfoId="'+(d.manageProjInfoId||"")+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.wbsName || '') + '">'
                                }
                            },
                            {
                                field: 'rbsId', title: 'RBS',minWidth:200, templet: function (d) {
                                    return '<input type="text" readonly name="rbsId" rbsId="'+(d.rbsId||'')+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.rbsLongName || d.rbsName  ||'') + '">'
                                }
                            },
                            {
                                field: 'cbsId', title: 'CBS',minWidth:200, templet: function (d) {
                                    return '<input type="text" readonly name="cbsId" cbsId="'+(d.cbsId||'')+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.cbsName || '') + '">'
                                }
                            },
                            {
                                field: 'incomeTarNum', title: '收入目标数量',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="incomeTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarNum || '0') + '">'
                                }
                            },
                            {
                                field: 'incomeTarPrice', title: '收入目标单价',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="incomeTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarPrice || '0') + '">'
                                }
                            },
                            {
                                field: 'incomeTarAmount', title: '收入目标金额',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="incomeTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarAmount || '0') + '">'
                                }
                            },
                            {
                                field: 'optTarNum', title: '优化目标数量',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="optTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarNum || '0') + '">'
                                }
                            },
                            {
                                field: 'optTarPrice', title: '优化目标单价',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="optTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarPrice || '0') + '">'
                                }
                            },
                            {
                                field: 'optTarAmount', title: '优化目标金额',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="optTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarAmount || '0') + '">'
                                }
                            },
                            {
                                field: 'manageTarNum', title: '管理目标数量',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="manageTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarNum || '0') + '">'
                                }
                            },
                            {
                                field: 'manageTarPrice', title: '管理目标单价',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="manageTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarPrice || '0') + '">'
                                }
                            },
                            {
                                field: 'manageTarAmount', title: '管理目标金额',minWidth:120, templet: function (d) {
                                    return '<input type="number" readonly name="manageTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarAmount || '0') + '">'
                                }
                            },

                            {
                                field: 'icnTarNumCha', title: '收入目标数量变更',minWidth:150, templet: function (d) {
                                    return '<input type="number" name="icnTarNumCha" class="layui-input" style="height: 100%;" value="' + (d.icnTarNumCha || 0) + '" onkeyup="extractNumber(this,3,true)">'
                                }
                            },
                            {
                                field: 'icnTarMonCha', title: '收入目标金额变更',minWidth:150, templet: function (d) {
                                    return '<input type="number" name="icnTarMonCha" class="layui-input" style="height: 100%;" value="' + (d.icnTarMonCha || 0) + '" onkeyup="extractNumber(this,2,true)">'
                                }
                            },
                            {
                                field: 'optTarNumCha', title: '优化目标数量变更',minWidth:160, templet: function (d) {
                                    return '<input type="number" name="optTarNumCha" class="layui-input" style="height: 100%;" value="' + (d.optTarNumCha || '0') + '" onkeyup="extractNumber(this,3,true)">'
                                }
                            },
                            {
                                field: 'optTarMonCha', title: '优化目标金额变更',minWidth:160, templet: function (d) {
                                    return '<input type="number" name="optTarMonCha" class="layui-input" style="height: 100%;" value="' + (d.optTarMonCha || '0') + '" onkeyup="extractNumber(this,2,true)">'
                                }
                            },
                            {
                                field: 'adjIncomeTarNum', title: '调整后收入目标数量',minWidth:160, templet: function (d) {
                                    return '<input type="number" readonly name="adjIncomeTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarNum || '0') + '">'
                                }
                            },
                            {
                                field: 'adjIncomeTarPrice', title: '调整后收入目标单价',minWidth:160, templet: function (d) {
                                    return '<input type="number" readonly name="adjIncomeTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarPrice || '0') + '">'
                                }
                            },
                            {
                                field: 'adjIncomeTarAmount', title: '调整后收入目标金额',minWidth:160, templet: function (d) {
                                    return '<input type="number" readonly name="adjIncomeTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarAmount || '0') + '">'
                                }
                            },
                            {
                                field: 'adjManTarNum', title: '调整后管理目标数量',minWidth:160, templet: function (d) {
                                    return '<input type="number" readonly name="adjManTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarNum || '0') + '">'
                                }
                            },
                            {
                                field: 'adjManTarPrice', title: '调整后管理目标单价',minWidth:160, templet: function (d) {
                                    return '<input type="number" readonly name="adjManTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarPrice || '0') + '">'
                                }
                            },
                            {
                                field: 'adjManTarAmount', title: '调整后管理目标金额',minWidth:160, templet: function (d) {
                                    return '<input type="number" readonly name="adjManTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarAmount || '0') + '">'
                                }
                            }
                        ]
                        if(type!=4){
                            cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100,fixed:'right'})
                        }
                        var incChaTotal;
                        var optChaTotal;
                        table.render({
                            elem: '#materialDetailsTable',
                            data: materialDetailsTableData,
                            toolbar:type==4? false : '#toolbarDemoIn',
                            defaultToolbar: [''],
                            height: materialDetailsTableData&&materialDetailsTableData.length>5?'full-350':false,
                            limit: 1000,
                            cols: [cols],
                            done:function (obj) {
                                if(type==4){
                                    $('.addRow').hide()
                                }
                                if(obj != undefined&&obj.data != undefined){
                                    //
                                    materialDetailsTableData = obj.data;
                                }
                                $('[name="icnTarNumCha"]').blur(function(){
                                    calculation("adjIncomeTarNum,adjManTarNum,adjIncomeTarPrice,adjManTarPrice",$(this));
                                })
                                $('[name="icnTarMonCha"]').blur(function(){
                                    incChaTotal=0
                                    calculation("adjIncomeTarAmount,adjManTarAmount,adjIncomeTarPrice,adjManTarPrice",$(this));
                                    var $tr = $('#materialDetailsTableModule').find('.layui-table-main tr [name="icnTarMonCha"]');
                                    $tr.each(function (index,element) {
                                        incChaTotal=accAdd(incChaTotal,($(element).val()||0));
                                    });
                                    $("[name='incChaTotal']").val(retainDecimal(incChaTotal,3)||0);
                                })
                                $('[name="optTarNumCha"]').blur(function(){
                                    calculation("adjManTarNum,adjManTarPrice,adjManTarPrice",$(this));
                                })
                                $('[name="optTarMonCha"]').blur(function(){
                                    optChaTotal=0
                                    calculation("adjManTarAmount,adjManTarPrice,adjManTarPrice",$(this));
                                    var $tr = $('#materialDetailsTableModule').find('.layui-table-main tr [name="optTarMonCha"]');
                                    $tr.each(function (index,element) {
                                        optChaTotal=accAdd(optChaTotal,($(element).val()||0));
                                    });
                                    $("[name='optChaTotal']").val(retainDecimal(optChaTotal,3)||0);
                                })
                            }
                        });

                        //查看详情
                        if(type==4){
                            $('.layui-layer-btn-c').html("<button class=\"layui-btn layui-btn-sm cBtn \" style='font-size: 14px;width: 60px;height: 30px'>确定</button>")
                            $('._disabled [name]').attr('disabled','true')

                            $('.file_upload_box').hide()
                            $('.deImgs').hide()

                            $('.chooseManagementBudget').hide();
                            $('.cBtn').click(function(){
                                layer.closeAll();
                            })
                        }
                        form.render();

                        //变更单明细表
                        // var cols2=[
                        //     {type: 'numbers', title: '序号'},
                        //     {field: 'registerNo', title: '变更单编号',minWidth:180, templet: function (d) {
                        //             return '<input type="text" name="registerNo" readonly registerId="'+d.registerId+'" manageProjInfoId="'+(d.manageProjInfoId||"")+'" class="layui-input " style="height: 100%;" value="' + (d.registerNo || '') + '">'
                        //         }},
                        //     {field: 'registerName', title: '变更单名称',minWidth:120, templet: function (d) {
                        //             return '<input type="text" name="registerName" readonly class="layui-input " style="height: 100%;" value="' + (d.registerName || '') + '">'
                        //         }},
                        //     {
                        //         field: 'registerCategory', title: '变更单类别',minWidth:120, templet: function (d) {
                        //             return '<input type="text" name="registerCategoryName" readonly registerCategory="'+d.registerCategory+'" class="layui-input " style="height: 100%;" value="' + (d.registerCategoryName || '') + '">'
                        //         }
                        //     },
                        //     {
                        //         field: 'registerType', title: '变更单类型', minWidth:120,templet: function (d) {
                        //             return '<input type="text" name="registerTypeName" readonly registerType="'+d.registerType+'" class="layui-input " style="height: 100%;" value="' + (d.registerTypeName || '') + '">'
                        //         }
                        //     },
                        //     {field: 'constructionDrawingsNo', title: '施工图纸编号',minWidth:140, templet: function (d) {
                        //             return '<input type="text" name="constructionDrawingsNo" readonly class="layui-input " style="height: 100%;" value="' + (d.constructionDrawingsNo || '') + '">'
                        //         }},
                        //     {field: 'firstPartyOrderFlag', title: '甲方是否下达指令',minWidth:180, templet: function (d) {
                        //             if (d.firstPartyOrderFlag){
                        //                 if(d.firstPartyOrderFlag=='0'){
                        //                     return '<span firstPartyOrderFlag="' + (d.firstPartyOrderFlag || '') + '">是</span>'
                        //                 }else if(d.firstPartyOrderFlag=='1'){
                        //                     return '<span firstPartyOrderFlag="' + (d.firstPartyOrderFlag || '') + '">否</span>'
                        //                 }
                        //             }else {
                        //                 return ''
                        //             }
                        //         }
                        //     },
                        //     {field: 'registerDate', title: '变更日期',minWidth:160, templet: function (d) {
                        //             return '<input type="text" name="registerDate" readonly class="layui-input " style="height: 100%;" value="' + (d.registerDate || '') + '">'
                        //         }}
                        // ]
                        // if(type!=4){
                        //     cols2.push({align: 'center', toolbar: '#barDemo2', title: '操作', minWidth: 100,fixed:'right'})
                        // }
                        // table.render({
                        //     elem: '#materialDetailsTable2',
                        //     data: materialDetailsTableData2,
                        //     toolbar: '#toolbarDemoIn2',
                        //     defaultToolbar: [''],
                        //     limit: 1000,
                        //     cols: [cols2],
                        //     done:function (obj) {
                        //         if(type==4){
                        //             $('.addRow').hide()
                        //         }
                        //         if(obj != undefined&&obj.data != undefined){
                        //             //
                        //             materialDetailsTableData2 = obj.data;
                        //         }
                        //     }
                        // });
                    },
                    yes: function (index) {
                        var loadIndex = layer.load();
                        //材料计划数据
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value;
                        });
                        obj.projectId=_projectId;
                        if (type == '1') {
                            obj.manageProjId=data.manageProjId;
                        }

                        // 合同附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                        }
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;

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

                        //立项明细
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var manageInfoList = [];
                        $tr.each(function () {
                            var plbManageItemObj = {
                                wbsId:$(this).find("[name='wbsId']").attr("wbsId"),
                                manageProjInfoId:$(this).find("[name='wbsId']").attr("manageProjInfoId"),
                                wbsName:$(this).find("[name='wbsId']").val(),
                                cbsId:$(this).find("[name='cbsId']").attr("cbsId"),
                                cbsName:$(this).find("[name='cbsId']").val(),
                                rbsId:$(this).find("[name='rbsId']").attr("rbsId"),
                                rbsLongName:$(this).find("[name='rbsId']").val(),
                                incomeTarNum:$(this).find("[name='incomeTarNum']").val(),
                                incomeTarPrice:$(this).find("[name='incomeTarPrice']").val(),
                                incomeTarAmount:$(this).find("[name='incomeTarAmount']").val(),
                                optTarNum:$(this).find("[name='optTarNum']").val(),
                                optTarPrice:$(this).find("[name='optTarPrice']").val(),
                                optTarAmount:$(this).find("[name='optTarAmount']").val(),
                                manageTarNum:$(this).find("[name='manageTarNum']").val(),
                                manageTarPrice:$(this).find("[name='manageTarPrice']").val(),
                                manageTarAmount:$(this).find("[name='manageTarAmount']").val(),
                                icnTarNumCha:$(this).find("[name='icnTarNumCha']").val(),
                                icnTarMonCha:$(this).find("[name='icnTarMonCha']").val(),
                                optTarNumCha:$(this).find("[name='optTarNumCha']").val(),
                                optTarMonCha:$(this).find("[name='optTarMonCha']").val(),
                                adjIncomeTarNum:$(this).find("[name='adjIncomeTarNum']").val(),
                                adjIncomeTarPrice:$(this).find("[name='adjIncomeTarPrice']").val(),
                                adjIncomeTarAmount:$(this).find("[name='adjIncomeTarAmount']").val(),
                                adjManTarNum:$(this).find("[name='adjManTarNum']").val(),
                                adjManTarPrice:$(this).find("[name='adjManTarPrice']").val(),
                                adjManTarAmount:$(this).find("[name='adjManTarAmount']").val(),
                            }
                            if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                                plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
                            }
                            manageInfoList.push(plbManageItemObj);
                        });
                        if(data!=undefined&&data.tarCostCha!=undefined){
                            obj.tarCostCha=data.tarCostCha
                        }
                        obj.detailsList = manageInfoList;

                        $.ajax({
                            url: url,
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            success: function (res) {
                                layer.close(loadIndex);
                                if (res.code==='0'||res.code===0) {
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
                        var datas = $('#baseForm').serializeArray();
                        var obj = {}
                        datas.forEach(function (item) {
                            obj[item.name] = item.value;
                        });
                        obj.projectId= _projectId;

                        // 合同附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
                        }
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;

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
                        if(data!=undefined&&data.tarCostCha!=undefined){
                            obj.tarCostCha=data.tarCostCha
                        }
                        //立项明细
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var manageInfoList = [];
                        $tr.each(function () {
                            var plbManageItemObj = {
                                wbsId:$(this).find("[name='wbsId']").attr("wbsId")||'',
                                manageProjInfoId:$(this).find("[name='wbsId']").attr("manageProjInfoId"),
                                projBudgetId:$(this).find("[name='wbsId']").attr("projBudgetId")||'',
                                wbsName:$(this).find("[name='wbsId']").val()||'',
                                cbsId:$(this).find("[name='cbsId']").attr("cbsId")||'',
                                cbsName:$(this).find("[name='cbsId']").val()||'',
                                rbsLongName:$(this).find("[name='rbsId']").val()||'',
                                rbsId:$(this).find("[name='rbsId']").attr("rbsId")||'',
                                incomeTarNum:$(this).find("[name='incomeTarNum']").val()||'',
                                incomeTarPrice:$(this).find("[name='incomeTarPrice']").val()||'',
                                incomeTarAmount:$(this).find("[name='incomeTarAmount']").val()||'',
                                optTarNum:$(this).find("[name='optTarNum']").val()||'',
                                optTarPrice:$(this).find("[name='optTarPrice']").val()||'',
                                optTarAmount:$(this).find("[name='optTarAmount']").val()||'',
                                manageTarNum:$(this).find("[name='manageTarNum']").val()||'',
                                manageTarPrice:$(this).find("[name='manageTarPrice']").val()||'',
                                manageTarAmount:$(this).find("[name='manageTarAmount']").val()||'',
                                icnTarNumCha:$(this).find("[name='icnTarNumCha']").val()||'',
                                icnTarMonCha:$(this).find("[name='icnTarMonCha']").val()||'',
                                optTarNumCha:$(this).find("[name='optTarNumCha']").val()||'',
                                optTarMonCha:$(this).find("[name='optTarMonCha']").val()||'',
                                adjIncomeTarNum:$(this).find("[name='adjIncomeTarNum']").val()||'',
                                adjIncomeTarPrice:$(this).find("[name='adjIncomeTarPrice']").val()||'',
                                adjIncomeTarAmount:$(this).find("[name='adjIncomeTarAmount']").val()||'',
                                adjManTarNum:$(this).find("[name='adjManTarNum']").val()||'',
                                adjManTarPrice:$(this).find("[name='adjManTarPrice']").val()||'',
                                adjManTarAmount:$(this).find("[name='adjManTarAmount']").val()||'',
                            }
                            if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                                plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
                            }
                            manageInfoList.push(plbManageItemObj);
                        });
                        if(data!=undefined&&data.tarCostCha!=undefined){
                            obj.tarCostCha=data.tarCostCha
                        }
                        obj.detailsList = manageInfoList;
                        $.ajax({
                            url: url,
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            success: function (res) {
                                layer.close(index);
                                if (res.code==='0'||res.code===0) {
                                    layer.open({
                                        type: 1,
                                        title: '选择流程',
                                        area: ['70%', '80%'],
                                        btn: ['确定', '取消'],
                                        btnAlign: 'c',
                                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                        success: function () {
                                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '54'}, function (res) {
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
                                                var approvalData = res.object
                                                delete approvalData.detailList
                                                newWorkFlow(flowData.flowId, function (res) {
                                                    var submitData = {
                                                        tarCostCha:approvalData.tarCostCha,
                                                        runId: res.flowRun.runId
                                                    }
                                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                    $.ajax({
                                                        url: '/targetCost/updateById',
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
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        });
                    },
                    btn3: function (index) {
                        layer.close(index);
                    }
                });
            }

            // 立项明细-选择
            table.on('toolbar(materialDetailsTable)', function (obj) {
                var wbsSelectTree = null;
                var cbsSelectTree = null;
                var rbsSelectTree =null;
                switch (obj.event) {
                    case 'add':

                        var wbsSelectTree = null;
                        var cbsSelectTree = null;
                        var _this = $(this);
                        layer.open({
                            type: 1,
                            title: '管理目标选择',
                            area: ['80%', '80%'],
                            maxmin: true,
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layui-form" id="objectives">' +
                            //下拉选择
                            '           <div class="layui-row" style="margin-top: 10px">' +
                            // '               <div class="layui-col-xs2">' +
                            // '                   <div class="layui-form-item">\n' +
                            // '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                            // '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                            // '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                            // '                       </div>\n' +
                            // '                   </div>' +
                            // '               </div>' +
                            // '               <div class="layui-col-xs2">' +
                            // '                   <div class="layui-form-item">\n' +
                            // '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                            // '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                            // '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                            // '                       </div>\n' +
                            // '                   </div>' +
                            // '               </div>' +
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
                            '                       <label class="layui-form-label">RBS</label>\n' +
                            '                       <div class="layui-input-block">\n' +
                            '<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' ,
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
                                wbsSelectTree = xmSelect.render({
                                    el: '#wbsSelectTree',
                                    content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search wbsSearch" style="width: 80%;margin: 5px"><div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                                    name: 'wbsName',
                                    prop: {
                                        name: 'wbsName',
                                        value: 'id'
                                    }
                                });
                                wbsData()
                                // 树节点点击事件
                                eleTree.on("nodeClick(wbsTree)", function (d) {
                                    var currentData = d.data.currentData;
                                    var obj = {
                                        wbsName: currentData.wbsName,
                                        id: currentData.id
                                    }
                                    wbsSelectTree.setValue([obj]);
                                });

                                var searchTimerWBS = null
                                $('.wbsSearch').on('input propertychange', function () {
                                    clearTimeout(searchTimerWBS)
                                    searchTimerWBS = null
                                    var val = $(this).val()
                                    searchTimerWBS = setTimeout(function () {
                                        wbsData(val)
                                    }, 300)
                                });

                                function wbsData(wbsName){
                                    $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId'),wbsName:wbsName}, function (res) {
                                        eleTree.render({
                                            elem: '#wbsTree',
                                            data: res.obj,
                                            highlightCurrent: true,
                                            showLine: true,
                                            // defaultExpandAll: false,
                                            request: {
                                                name: 'wbsName',
                                                children: "child"
                                            }
                                        });
                                    });
                                }


                                // 获取CBS数据
                                cbsSelectTree = xmSelect.render({
                                    el: '#cbsSelectTree',
                                    content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search cbsSearch" style="width: 80%;margin: 5px"><div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                    name: 'cbsName',
                                    prop: {
                                        name: 'cbsName',
                                        value: 'cbsId'
                                    }
                                });
                                cbsData()
                                // 树节点点击事件
                                eleTree.on("nodeClick(cbsTree)", function (d) {
                                    var currentData = d.data.currentData;
                                    var obj = {
                                        cbsName: currentData.cbsName,
                                        cbsId: currentData.cbsId
                                    }
                                    cbsSelectTree.setValue([obj]);
                                });

                                var searchTimerCBS = null
                                $('.cbsSearch').on('input propertychange', function () {
                                    clearTimeout(searchTimerCBS)
                                    searchTimerCBS = null
                                    var val = $(this).val()
                                    searchTimerCBS = setTimeout(function () {
                                        cbsData(val)
                                    }, 300)
                                });

                                function cbsData(cbsName){
                                    $.get('/plbCbsType/getAllList',{cbsName:cbsName}, function (res) {
                                        eleTree.render({
                                            elem: '#cbsTree',
                                            data: res.data,
                                            highlightCurrent: true,
                                            showLine: true,
                                            // defaultExpandAll: false,
                                            request: {
                                                name: 'cbsName',
                                                children: "childList"
                                            }
                                        });
                                    });
                                }

                                //获取RBS数据
                                rbsSelectTree = xmSelect.render({
                                    el: '#rbsSelectTree',
                                    content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search rbsSearch" style="width: 80%;margin: 5px"><div id="rbsTree" class="eleTree" lay-filter="rbsTree"></div>',
                                    name: 'rbsName',
                                    prop: {
                                        name: 'rbsName',
                                        value: 'rbsId'
                                    }
                                });
                                rbsData();
                                // 树节点点击事件
                                eleTree.on("nodeClick(rbsTree)", function (d) {
                                    var currentData = d.data.currentData;
                                    var obj = {
                                        rbsName: currentData.rbsName,
                                        rbsId: currentData.rbsId
                                    }
                                    rbsSelectTree.setValue([obj]);
                                });
                                var searchTimerRBS = null
                                $('.rbsSearch').on('input propertychange', function () {
                                    clearTimeout(searchTimerRBS)
                                    searchTimerRBS = null
                                    var val = $(this).val()
                                    searchTimerRBS = setTimeout(function () {
                                        rbsData(val,'1')
                                    }, 300)
                                });
                                function rbsData(parentId,type){
                                    var obj = {};
                                    if(type == '1'){
                                        obj.rbsName=parentId?parentId:'';
                                    }else {
                                        obj.parentId=parentId?parentId:'1';
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
                                laodTable();

                                $('.search_mtl').on('click', function(){
                                    var cbsId = cbsSelectTree.getValue('valueStr');
                                    var wbsId = wbsSelectTree.getValue('valueStr');
                                    var rbsId = rbsSelectTree.getValue('valueStr');
                                    var itemNo = $('[name="itemNo"]').val();
                                    var itemName =$('[name="itemName"]').val();

                                    laodTable(wbsId, cbsId,rbsId,itemNo,itemName);
                                });

                                // 加载表格
                                function laodTable(wbsId, cbsId,rbsId,itemNo,itemName) {
                                    table.render({
                                        elem: '#managementBudgetTable',
                                        url: '/manageProject/getBudgetByProjId',
                                        where: {
                                            projId: $('#leftId').attr('projId'),
                                            wbsId: wbsId || '',
                                            cbsId: cbsId || '',
                                            rbsId: rbsId || '',
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
                                            countName: 'count',
                                            dataName: 'data'
                                        },
                                        cols: [[
                                            {type: 'checkbox'},
                                            {
                                                field: 'wbsName', title: 'WBS',minWidth:100, templet: function(d) {
                                                    var str = '';
                                                    if (d.plbProjWbs) {
                                                        str = d.plbProjWbs.wbsName;
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                field: 'rbsName', title: 'RBS',minWidth:200, templet: function(d) {
                                                    var str = '';
                                                    if (d.plbRbs) {
                                                        str = d.plbRbs.rbsLongName;
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                field: 'cbsName', title: 'CBS',minWidth:100, templet: function (d) {
                                                    var str = '';
                                                    if (d.plbCbsTypeWithBLOBs) {
                                                        str = d.plbCbsTypeWithBLOBs.cbsName;
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                field: 'controlType', title: '控制类型', minWidth:120,templet: function (d) {
                                                    return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                                }
                                            },
                                            {
                                                field: 'itemUnit', title: '单位',minWidth:120, templet: function (d) {
                                                    var str = '';
                                                    if (d.plbRbs) {
                                                        str = dictionaryObj['CBS_UNIT']['object'][d.itemUnit] || '';
                                                    }
                                                    return str;
                                                }
                                            },
                                            {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                            {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                            {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                            // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                            // {field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                            // {field: 'manageSurplusAmount', title: '管理目标数量余额',minWidth:150},
                                            // {field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},
                                        ]],
                                        done:function(res){
                                            _dataa=res.data;
                                            if(materialDetailsTableData!=undefined&&materialDetailsTableData.length>0){
                                                for(var i = 0 ; i <_dataa.length;i++){
                                                    for(var n = 0 ; n < materialDetailsTableData.length; n++){
                                                        if(_dataa[i].projBudgetId == materialDetailsTableData[n].projBudgetId){
                                                            $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                            //form.render('checkbox');
                                                        }
                                                    }
                                                }
                                            }

                                        }
                                    });
                                }
                            },
                            yes: function (index) {
                                var DataArr = [];
                                //遍历表格获取每行数据进行保存
                                var $tr = $('.mtl_info').find('.layui-table-main tr');
                                $tr.each(function () {
                                    var oldDataObj = {
                                        wbsId:$(this).find("[name='wbsId']").attr("wbsId")||'',
                                        manageProjInfoId:$(this).find("[name='wbsId']").attr("manageProjInfoId"),
                                        projBudgetId:$(this).find("[name='wbsId']").attr("projBudgetId")||'0',
                                        wbsName:$(this).find("[name='wbsId']").val()||'',
                                        cbsId:$(this).find("[name='cbsId']").attr("cbsId")||'',
                                        cbsName:$(this).find("[name='cbsId']").val()||'',
                                        rbsLongName:$(this).find("[name='rbsId']").val()||'',
                                        rbsId:$(this).find("[name='rbsId']").attr("rbsId")||'',
                                        incomeTarNum:$(this).find("[name='incomeTarNum']").val()||'0',
                                        incomeTarPrice:$(this).find("[name='incomeTarPrice']").val()||'0',
                                        incomeTarAmount:$(this).find("[name='incomeTarAmount']").val()||'0',
                                        optTarNum:$(this).find("[name='optTarNum']").val()||'0',
                                        optTarPrice:$(this).find("[name='optTarPrice']").val()||'0',
                                        optTarAmount:$(this).find("[name='optTarAmount']").val()||'0',
                                        manageTarNum:$(this).find("[name='manageTarNum']").val()||'0',
                                        manageTarPrice:$(this).find("[name='manageTarPrice']").val()||'0',
                                        manageTarAmount:$(this).find("[name='manageTarAmount']").val()||'0',
                                        icnTarNumCha:$(this).find("[name='icnTarNumCha']").val()||'0',
                                        icnTarMonCha:$(this).find("[name='icnTarMonCha']").val()||'0',
                                        optTarNumCha:$(this).find("[name='optTarNumCha']").val()||'0',
                                        optTarMonCha:$(this).find("[name='optTarMonCha']").val()||'0',
                                        adjIncomeTarNum:$(this).find("[name='adjIncomeTarNum']").val()||'0',
                                        adjIncomeTarPrice:$(this).find("[name='adjIncomeTarPrice']").val()||'0',
                                        adjIncomeTarAmount:$(this).find("[name='adjIncomeTarAmount']").val()||'0',
                                        adjManTarNum:$(this).find("[name='adjManTarNum']").val()||'0',
                                        adjManTarPrice:$(this).find("[name='adjManTarPrice']").val()||'0',
                                        adjManTarAmount:$(this).find("[name='adjManTarAmount']").val()||'0',
                                    }
                                    DataArr.push(oldDataObj);
                                });
                                var checkStatus=[];
                                $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                    if($(item).find('.layui-form-checked').length>0){
                                        checkStatus.push(_dataa[index]);
                                    }
                                })
                                if (checkStatus.length > 0) {
                                    for(var i=0;i<checkStatus.length;i++){
                                        var oldDataObj = {
                                            projBudgetId:checkStatus[i].projBudgetId||'',
                                            wbsName:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsName:'',
                                            wbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsId:'',
                                            cbsName:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsName:'',
                                            cbsId:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsId:'',
                                            rbsLongName:checkStatus[i].plbProjWbs?checkStatus[i].plbRbs.rbsLongName:'',
                                            rbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbRbs.rbsId:'',
                                            incomeTarNum:checkStatus[i].incomeTarNum||'0',
                                            incomeTarPrice:checkStatus[i].incomeTarPrice||'0',
                                            incomeTarAmount:checkStatus[i].incomeTarAmount||'0',
                                            optTarNum:checkStatus[i].optTarNum||'0',
                                            optTarPrice:checkStatus[i].optTarPrice||'0',
                                            optTarAmount:checkStatus[i].optTarAmount||'0',
                                            manageTarNum:checkStatus[i].manageTarNum||'0',
                                            manageTarPrice:checkStatus[i].manageTarPrice||'0',
                                            manageTarAmount:checkStatus[i].manageTarAmount||'0',

                                            adjIncomeTarNum:checkStatus[i].incomeTarNum||'0',
                                            adjIncomeTarAmount:checkStatus[i].incomeTarAmount||'0',
                                            adjManTarNum:checkStatus[i].manageTarNum||'0',
                                            adjManTarAmount:checkStatus[i].manageTarAmount||'0',
                                            adjIncomeTarPrice:retainDecimal(div(checkStatus[i].incomeTarAmount,(checkStatus[i].incomeTarNum||'1')),3)||'0',
                                            adjManTarPrice:retainDecimal(div(checkStatus[i].manageTarAmount,(checkStatus[i].manageTarNum||'1')),3)||'0',
                                        }
                                        if (DataArr){
                                            var _flag=true;
                                            for(var j=0;j<DataArr.length;j++){
                                                if(DataArr[j].projBudgetId==checkStatus[i].projBudgetId){
                                                    _flag = false
                                                }
                                            }
                                            if(_flag){
                                                DataArr.push(oldDataObj)
                                            }
                                        }else{
                                            DataArr.push(oldDataObj)
                                        }
                                    }


                                    layer.close(index);

                                    table.reload('materialDetailsTable', {
                                        data: DataArr,
                                        height: DataArr&&DataArr.length>5?'full-350':false
                                    });

                                } else {
                                    layer.msg('请选择一项！', {icon: 0});
                                }
                            }
                        });
                        break;
                }
            });
            // 立项明细-删行操作
            table.on('tool(materialDetailsTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr=obj.tr;
                if (layEvent === 'del') {
                    obj.del();
                    var incChaTotalVal=$('[name="incChaTotal"]').val();
                    var icnTarMonChaVal=$tr.find('[name="icnTarMonCha"]').val();
                    $('[name="incChaTotal"]').val(sub(incChaTotalVal,icnTarMonChaVal)|| 0);
                    var optChaTotalVal=$('[name="optChaTotal"]').val();
                    var optTarMonChaVal=$tr.find('[name="optTarMonCha"]').val();
                    $('[name="optChaTotal"]').val(sub(optChaTotalVal,optTarMonChaVal)|| 0);
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            projBudgetId:$(this).find('input[name="wbsId"]').attr('projBudgetId'),
                            manageProjInfoId:$(this).find('input[name="wbsId"]').attr('manageProjInfoId'),
                            manageProjId: $(this).find('input[name="wbsId"]').attr('manageProjId'),
                            wbsName: $(this).find('input[name="wbsId"]').val(),
                            wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                            cbsName: $(this).find('input[name="cbsId"]').val(),
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                            incomeTarNum: $(this).find('input[name="incomeTarNum"]').val(),
                            incomeTarPrice: $(this).find('input[name="incomeTarPrice"]').val(),
                            incomeTarAmount: $(this).find('input[name="incomeTarAmount"]').val(),
                            optTarNum: $(this).find('input[name="optTarNum"]').val(),
                            optTarPrice: $(this).find('input[name="optTarPrice"]').val(),
                            optTarAmount: $(this).find('input[name="optTarAmount"]').val(),
                            manageTarNum: $(this).find('input[name="manageTarNum"]').val(),
                            manageTarPrice: $(this).find('input[name="manageTarPrice"]').val(),
                            manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),

                            icnTarNumCha: $(this).find('input[name="icnTarNumCha"]').val(),
                            icnTarMonCha: $(this).find('input[name="icnTarMonCha"]').val(),
                            optTarNumCha: $(this).find('input[name="optTarNumCha"]').val(),

                            optTarMonCha: $(this).find('input[name="optTarMonCha"]').val(),
                            manTarOptAmount: $(this).find('input[name="manTarOptAmount"]').val(),

                            aftManTarNum: $(this).find('input[name="aftManTarNum"]').val(),
                            aftManTarPrice: $(this).find('input[name="aftManTarPrice"]').val(),
                            aftManTarAmount: $(this).find('input[name="aftManTarAmount"]').val(),
                            adjIncomeTarNum: $(this).find('input[name="adjIncomeTarNum"]').val(),
                            adjIncomeTarPrice: $(this).find('input[name="adjIncomeTarPrice"]').val(),
                            adjIncomeTarAmount: $(this).find('input[name="adjIncomeTarAmount"]').val(),
                            adjOptTarNum: $(this).find('input[name="adjOptTarNum"]').val(),
                            adjOptTarPrice: $(this).find('input[name="adjOptTarPrice"]').val(),
                            adjOptTarAmount: $(this).find('input[name="adjOptTarAmount"]').val(),
                            adjManTarNum: $(this).find('input[name="adjManTarNum"]').val(),
                            adjManTarPrice: $(this).find('input[name="adjManTarPrice"]').val(),
                            adjManTarAmount: $(this).find('input[name="adjManTarAmount"]').val(),
                        }
                        oldDataArr.push(oldDataObj);
                    });

                    if (data.manageProjInfoId) {
                        $.get('/targetCost/delDetail', {ids: data.manageProjInfoId}, function (res) {
                            if (res.code=='0') {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                table.reload('materialDetailsTable', {
                                    data: oldDataArr,
                                    height: oldDataArr&&oldDataArr.length>5?'full-350':false
                                });
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        table.reload('materialDetailsTable', {
                            data: oldDataArr,
                            height: oldDataArr&&oldDataArr.length>5?'full-350':false
                        });
                    }

                }

            });

            // 变更单明细-选择
            table.on('toolbar(materialDetailsTable2)', function (obj) {

                switch (obj.event) {
                    case 'add2':
                        layer.open({
                            type: 1,
                            // skin: 'layui-layer-molv', //加上边框
                            area: ['80%', '70%'], //宽高
                            title: '变更单选择',
                            maxmin: true,
                            btn: ['确定'],
                            btnAlign:'c',
                            content: '<div class="mbox" id="objectives2">\n' +
                                '    <div class="layui-card">\n' +
                                '        <div class="layui-card-body">\n' +
                                '            <div class="layui-rt">\n' +
                                '                <div class="layui-tab layui-tab-card" lay-filter="tabtoggle">\n' +
                                '                    <div class="layui-tab-content" style="height:100%;padding: 0 10px 10px 10px">\n' +
                                '                        <div id="firstBox" class="layui-tab-item layui-show">\n' +
                                '                            <table class="layui-table" lay-skin="line" id="Settlement3" lay-size="sm" lay-filter="SettlementFilter3"></table>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </div>\n' +
                                '        </div>\n' +
                                '    </div>\n' +
                                '</div>',
                            success: function () {

                                table.render({
                                    elem: '#Settlement3'
                                    , url: '/plbOperateManage/selectRegister?projectId='+_projectId//数据接口
                                    //, toolbar: "#toolbar"
                                    , defaultToolbar: []
                                    , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                        layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                        , limits: [15, 30, 45, 60, 75, 90, 105, 120]
                                        , first: '首页'
                                        , last: '尾页'
                                    }
                                    , limit: 15
                                    , cols: [[//表头
                                        {type: 'checkbox'},
                                        {type: 'numbers', minWidth: 60, title: '序号'},
                                        {field: 'projectName', title: '项目名称', sort: true, hide: false},
                                        {field: 'registerType', title: '变更类型', sort: true, hide: false},
                                        {field: 'registerCategory', title: '变更类别', sort: true, hide: false},
                                        {field: 'itemAmount', title: '分部分项工程', minWidth:140,sort: true, hide: false},
                                        {field: 'approvaler', title: '审批人', sort: true, hide: false, templet: function (d) {
                                                return d.approvalerName || '';
                                            }},
                                        {field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
                                                var str = '';
                                                if (d.auditerStatus == '1') {
                                                    str = '<span style="color: orange;">审批中</span>';
                                                } else if (d.auditerStatus == '2') {
                                                    str = '<span style="color: green;">批准</span>';
                                                } else if (d.auditerStatus == '3') {
                                                    str = '<span style="color: red;">不批准</span>';
                                                } else {
                                                    str = '未提交';
                                                }
                                                return str;
                                            }},
                                        {field: 'approvalTime', title: '审批时间', sort: true, hide: false, templet: function (d) {
                                                return format(d.approvalTime);
                                            }},
                                        {field: 'createTime', title: '创建时间', sort: true, hide: false}
                                        //{title: '操作', minWidth: 190, toolbar: '#barOperation'}
                                    ]],
                                    request: {
                                        pageName: 'page' //页码的参数名称，默认：page
                                        ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                    }
                                    , done: function (res) {
                                        _dataa2=res.data;
                                        if(materialDetailsTableData2!=undefined&&materialDetailsTableData2.length>0){
                                            for(var i = 0 ; i <_dataa2.length;i++){
                                                for(var n = 0 ; n < materialDetailsTableData2.length; n++){
                                                    if(_dataa2[i].registerId == materialDetailsTableData2[n].registerId){
                                                        $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                        //form.render('checkbox');
                                                    }
                                                }
                                            }
                                        }
                                    }
                                });

                                form.render();//重置表格


                            },
                            yes: function (index, layero) {
                                layer.close(index);
                                //var checkStatus = table.checkStatus('Settlement3').data;


                                var checkStatus=[];
                                $('#objectives2 .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                    if($(item).find('.layui-form-checked').length>0){
                                        checkStatus.push(_dataa2[index]);
                                    }
                                })
                                var oldDataArr = [];
                                if (checkStatus.length > 0) {
                                    for(var i=0;i<checkStatus.length;i++){
                                        var oldDataObj = {
                                            registerId:checkStatus[i].registerId,
                                            registerNo:checkStatus[i].registerNo,
                                            registerName:checkStatus[i].registerName,
                                            registerCategory:checkStatus[i].registerCategory,
                                            registerCategoryName:checkStatus[i].registerCategoryName,
                                            registerType:checkStatus[i].registerType,
                                            registerTypeName:checkStatus[i].registerTypeName,
                                            constructionDrawingsNo:checkStatus[i].constructionDrawingsNo,
                                            firstPartyOrderFlag:checkStatus[i].firstPartyOrderFlag,
                                            registerDate:checkStatus[i].registerDate,
                                        }
                                        if(materialDetailsTableData2){
                                            var _flag = true
                                            for(var j=0;j<materialDetailsTableData2.length;j++){
                                                if(materialDetailsTableData2[j].registerId==checkStatus[i].registerId){
                                                    _flag = false
                                                }
                                            }
                                            if(_flag){
                                                materialDetailsTableData2.push(oldDataObj);
                                            }

                                        }else{
                                            materialDetailsTableData2.push(oldDataObj);
                                        }
                                    }


                                    layer.close(index);

                                    table.reload('materialDetailsTable2', {
                                        data: materialDetailsTableData2
                                    });
                                } else {
                                    layer.msg('请选择一项！', {icon: 0});
                                }
                            }
                        });

                        break;
                }
            });
            // 变更单明细-删行操作
            table.on('tool(materialDetailsTable2)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                if (layEvent === 'del2') {
                    if(data.manageProjInfoId){
                        $.ajax({
                            url: '/targetCost/delReiBud?ids='+data.manageProjInfoId,
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                /*if (res.code==='0'||res.code===0) {
                                    layer.msg(res.msg, {icon: 1});
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }*/
                            }
                        });
                    }

                    obj.del();

                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info2').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            manageProjInfoId:$(this).find('input[name="registerNo"]').attr('manageProjInfoId'),
                            registerId:$(this).find('input[name="registerNo"]').attr('registerId'),
                            registerNo: $(this).find('input[name="registerNo"]').val(),
                            registerName: $(this).find('input[name="registerName"]').val(),
                            registerCategory: $(this).find('input[name="registerCategoryName"]').attr('registerCategory'),
                            registerType: $(this).find('input[name="registerTypeName"]').attr('registerType'),
                            constructionDrawingsNo: $(this).find('input[name="constructionDrawingsNo"]').val(),
                            firstPartyOrderFlag: $(this).find('span').attr('firstPartyOrderFlag'),
                            registerDate: $(this).find('input[name="registerDate"]').val(),
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    table.reload('materialDetailsTable2', {
                        data: oldDataArr
                    });
                }
            });


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
    //数据列表点击审批状态查看流程功能
    $(document).on('click', '.preview_flow', function() {
        var flowId = $(this).attr('flowId'),
            runId = $(this).attr('runId');
        if (flowId && runId) {
            $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
        }
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
    function extractNumber(obj, decimalPlaces, allowNegative) {
        var temp = obj.value;


        // avoid changing things if already formatted correctly
        var reg0Str = '[0-9]*';
        if (decimalPlaces > 0) {
            reg0Str += '\\.?[0-9]{0,' + decimalPlaces + '}';
        } else if (decimalPlaces < 0) {
            reg0Str += '\\.?[0-9]*';
        }
        reg0Str = allowNegative ? '^-?' + reg0Str : '^' + reg0Str;
        reg0Str = reg0Str + '$';
        var reg0 = new RegExp(reg0Str);
        if (reg0.test(temp)) return true;


        // first replace all non numbers
        var reg1Str = '[^0-9' + (decimalPlaces != 0 ? '.' : '') + (allowNegative ? '-' : '') + ']';
        var reg1 = new RegExp(reg1Str, 'g');
        temp = temp.replace(reg1, '');


        if (allowNegative) {
            // replace extra negative
            var hasNegative = temp.length > 0 && temp.charAt(0) == '-';
            var reg2 = /-/g;
            temp = temp.replace(reg2, '');
            if (hasNegative) temp = '-' + temp;
        }


        if (decimalPlaces != 0) {
            var reg3 = /\./g;
            var reg3Array = reg3.exec(temp);
            if (reg3Array != null) {
                // keep only first occurrence of .
                // and the number of places specified by decimalPlaces or the entire string if decimalPlaces < 0
                var reg3Right = temp.substring(reg3Array.index + reg3Array[0].length);
                reg3Right = reg3Right.replace(reg3, '');
                reg3Right = decimalPlaces > 0 ? reg3Right.substring(0, decimalPlaces) : reg3Right;
                temp = temp.substring(0, reg3Array.index) + '.' + reg3Right;
            }
        }


        obj.value = temp;
    }
    function calculation(str,_this){
        /*
        调整后收入目标数量=收入目标数量+收入目标数量变更 (保留3位小数)
        调整后收入目标单价=调整后收入目标金额/调整后收入目标数量 (保留3位小数)
        调整后收入目标金额=收入目标金额+收入目标金额变更 (保留2位小数)
        调整后管理目标数量=管理目标数量+收入目标数量变更-优化目标数量变更 (保留3位小数)
        调整后管理目标单价=调整后管理目标金额/调整后管理目标数量 (保留3位小数)
        调整后管理目标金额=管理目标金额+收入目标金额变更-优化目标金额变更 (保留2位小数)
         */
        var incomeTarNumVal=_this.parents('tr').find('[name="incomeTarNum"]').val();//收入目标数量
        var icnTarNumChaVal=_this.parents('tr').find('[name="icnTarNumCha"]').val();//收入目标数量调整
        var adjIncomeTarAmount=$('[name="adjIncomeTarAmount"]').val();//调整后收入目标金额
        var adjIncomeTarNum=$('[name="adjIncomeTarNum"]').val();//调整收入目标数量
        var incomeTarAmountVal=_this.parents('tr').find('[name="incomeTarAmount"]').val();//收入目标金额
        var icnTarMonChaVal=_this.parents('tr').find('[name="icnTarMonCha"]').val();//收入目标金额变更
        var manageTarNumVal=_this.parents('tr').find('[name="manageTarNum"]').val();//管理目标数量
        var optTarNumChaVal=_this.parents('tr').find('[name="optTarNumCha"]').val();//优化目标数量变更
        var adjManTarAmount=$('[name="adjManTarAmount"]').val();//调整后管理目标金额
        var adjManTarNum=$('[name="adjManTarNum"]').val();//调整后管理目标数量
        var manageTarAmountVal=_this.parents('tr').find('[name="manageTarAmount"]').val();//管理目标金额
        var optTarMonChaVal=_this.parents('tr').find('[name="optTarMonCha"]').val();//优化目标金额变更
        var arr=new Array();
        arr=str.split(',');
        for(var i=0;i<arr.length;i++){
            switch (arr[i]) {
                case 'adjIncomeTarNum':
                    //调整后收入目标数量
                    var  adjIncomeTarNumVal=accAdd(incomeTarNumVal,icnTarNumChaVal);
                    _this.parents('tr').find('[name="adjIncomeTarNum"]').val(retainDecimal(adjIncomeTarNumVal,3)||0);
                    continue;
                case 'adjIncomeTarAmount':
                    //调整后收入目标金额
                    var adjIncomeTarAmountVal=accAdd(incomeTarAmountVal,icnTarMonChaVal);
                    _this.parents('tr').find('[name="adjIncomeTarAmount"]').val(retainDecimal(adjIncomeTarAmountVal,2)|0);

                    continue;
                case 'adjManTarNum':
                    //调整后管理目标数量
                    var adjManTarNumVal=sub(accAdd(manageTarNumVal,icnTarNumChaVal),optTarNumChaVal);
                    _this.parents('tr').find('[name="adjManTarNum"]').val(retainDecimal(adjManTarNumVal,3)||0);
                    continue;
                case 'adjManTarAmount':
                    //调整后管理目标金额
                    var adjManTarAmountVal=sub(accAdd(manageTarAmountVal,icnTarMonChaVal),optTarMonChaVal);
                    _this.parents('tr').find('[name="adjManTarAmount"]').val(retainDecimal(adjManTarAmountVal,2)||0);
                    continue;
                case 'adjIncomeTarPrice':
                    //调整后收入目标单价
                        var adjIncomeTarNumVal=_this.parents('tr').find('[name="adjIncomeTarNum"]').val();
                        if(adjIncomeTarNumVal=="0"||adjIncomeTarNumVal==0){
                            adjIncomeTarNumVal=1
                        }
                        var adjIncomeTarPriceVal=div(_this.parents('tr').find('[name="adjIncomeTarAmount"]').val(),adjIncomeTarNumVal);
                        _this.parents('tr').find('[name="adjIncomeTarPrice"]').val(retainDecimal(adjIncomeTarPriceVal,3)||0);

                    continue;
                case 'adjManTarPrice':
                    //调整后管理目标单价
                    var adjManTarNumVal=_this.parents('tr').find('[name="adjManTarNum"]').val();
                    if(adjManTarNumVal==0||adjManTarNumVal=="0"){
                        adjManTarNumVal=1;
                    }
                    var adjManTarPriceVal=div(_this.parents('tr').find('[name="adjManTarAmount"]').val(),adjManTarNumVal);
                    _this.parents('tr').find('[name="adjManTarPrice"]').val(retainDecimal(adjManTarPriceVal,3)||0);
                    continue;
            }
        }
    }
    function openRold(){ //流程转交下一步后会调用此方法
        //刷新表格
        tableIns.reload();
    }
</script>
</body>
</html>
