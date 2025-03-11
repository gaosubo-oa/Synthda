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
        <title>其他费用需求计划</title>

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
        <script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>
        <script src="../js/jquery/jquery.cookie.js"></script>
        <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108311508"></script>

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
            .layui-col-xs4{
                width:20%
            }
            .back{
                background-color: #F2F2F2;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <input type="hidden" id="leftId" class="layui-input">
            <div class="wrapper">
                <div class="wrap_left">
                    <h2 style="text-align: center;line-height: 35px;">其他费用需求计划</h2>
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
                            <input type="text" name="documnetNum" placeholder="单据号" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-col-xs2" style="margin-left: 15px;">
                            <input type="text" name="reiPlanName" placeholder="需求计划名称" autocomplete="off" class="layui-input">
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
                            <button type="button" class="layui-btn layui-btn-sm">高级查询</button>
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
                <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入</button>
                <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出</button>
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
                CBS_UNIT: {},
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
            var tableIns = null;
            //var openTreeArr=[9,8,1];
            layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
                var laydate = layui.laydate;
                var form = layui.form;
                var table = layui.table;
                var element = layui.element;
                var soulTable = layui.soulTable;
                var eleTree = layui.eleTree;
                var xmSelect = layui.xmSelect;

                form.render();
                //导出数据
                var exportData = '';
                //表格显示顺序
                var colShowObj = {
                    documnetNum: {field: 'documnetNum', title: '单据号', minWidth:140,sort: true, hide: false},
                    reiPlanName: {field: 'reiPlanName', title: '计划名称', minWidth:140, sort: true, hide: false},
                    projectName: {field: 'projectName', title: '所属项目',  minWidth:100,sort: true, hide: false},
                    estimateAmountSum: {field: 'estimateAmountSum', title: '需求计划金额', minWidth:180, sort: true, hide: false},
                    needDate: {
                        field: 'needDate', title: '需用日期',  minWidth:100,sort: true, hide: false, templet: function (d) {
                            return format(d.needDate);
                        }
                    },
                    createDate: {
                        field: 'createDate', title: '编制时间',  minWidth:100,sort: true, hide: false, templet: function (d) {
                            return format(d.createDate);
                        }
                    },
                    currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',  minWidth:120,sort: false, hide: false},
                    auditerStatus:{field:'auditerStatus',title:"审批状态", minWidth:100, sort: true, hide: false,templet: function (d) {
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
                            if (checkStatus.data[0].auditerStatus != 0) {
                                layer.msg('该订单已提交，不可编辑！', {icon: 0});
                                return false;
                            }
                            newOrEdit(1, checkStatus.data[0])
                            break;
                        case 'del':
                            if (!checkStatus.data.length) {
                                layer.msg('请至少选择一项！', {icon: 0});
                                return false
                            }
                            var reiPlanId = ''
                            var isFlay = false;

                            checkStatus.data.forEach(function (v, i) {
                                reiPlanId += v.reiPlanId + ','
                                if(v.auditerStatus&&v.auditerStatus!='0'){
                                    isFlay = true
                                }
                            })
                            if(isFlay){
                                layer.msg('已提交不可删除！', {icon: 0});
                                return false
                            }


                            layer.confirm('确定删除该条数据吗？', function (index) {
                                $.post('/otherCostReiPlan/del', {ids: reiPlanId}, function (res) {
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
                                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '61'}, function (res) {
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
                                        delete approvalData.reiPlanList;
                                        approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                        approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                        newWorkFlow(flowData.flowId, function (res) {
                                            var submitData = {
                                                reiPlanId:approvalData.reiPlanId,
                                                runId: res.flowRun.runId,
                                                //auditerStatus:1
                                            }
                                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                            $.ajax({
                                                url: '/otherCostReiPlan/updateById',
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
                    if(layEvent === 'detail'){
                        newOrEdit(4,data)
                        // layer.open({
                        //     type: 2,
                        //     title:'查看详情',
                        //     area: ['100%', '100%'],
                        //     btn: ['确定'],
                        //     btnAlign: 'c',
                        //     content: '/plbMtlPlan/plbMtlPlanView?type=4&&mtlSettleupId='+data.reiPlanId,
                        //     success: function () {
                        //
                        //     },
                        //     yes: function (index) {
                        //         layer.close(index);
                        //     },
                        //
                        // });
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
                            //遍历表格获取每行数据进行保存
                            var oldDataArr = materialDetailsData();

                            var addRowData = {
                                //valuationUnit: valuationUnit
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
                        if (data.reiPlanListId) {
                            $.get('/otherCostReiPlan/delReiBud', {ids: data.reiPlanListId}, function(res){

                            });
                        }
                        //遍历表格获取每行数据进行保存
                        var oldDataArr = materialDetailsData();

                        table.reload('materialDetailsTable', {
                            data: oldDataArr
                        });

                        //本次需求计划金额
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var estimateAmountSum=0
                        $tr.each(function () {
                            estimateAmountSum=accAdd(estimateAmountSum,$(this).find('input[name="estimateAmount"]').val())
                        });
                        $('#baseForm [name="estimateAmountSum"] ').val(retainDecimal(estimateAmountSum,2)||0)
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
                        url: '/otherCostReiPlan/select',
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
                            projectId: projId,
                            delFlag: '0',
                            orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                            orderbyUpdown: TableUIObj.orderbyUpdown
                        },
                        autoSort: false,
                        // parseData: function (res) { //res 即为原始返回的数据
                        //     return {
                        //         "code": 0, //解析接口状态
                        //         "msg": res.msg, //解析提示文本
                        //         "data": res.obj, //解析数据列表
                        //         "count": res.totleNum, //解析数据长度
                        //     };
                        // },
                        request: {
                            limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                    done: function (res) {
                            //增加拖拽后回调函数
                            soulTable.render(this, function () {
                                TableUIObj.dragTable('tableDemo')
                            })

                            res.data.forEach(function (v) {
                                exportData += v.reiPlanId + ','
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
                    $('#leftId').attr('_type',type);
                    if (type == '0') {
                        title = '新建其他费用需求计划';
                        url = '/otherCostReiPlan/insert';
                    } else if (type == '1') {
                        title = '编辑其他费用需求计划';
                        url = '/otherCostReiPlan/updateById';
                    }else if(type == '4'){
                        title = '查看详情'
                    }


                    layer.open({
                        type: 1,
                        title: title,
                        area: ['100%', '100%'],
                        btn: type != '4'?['保存','提交审批', '取消']:['确定'],
                        btnAlign: 'c',
                        content: ['<div class="layui-collapse">\n' ,
                            /* region 材料计划 */
                            '  <div class="layui-colla-item">\n' +
                            '    <h2 class="layui-colla-title">其他费用需求计划</h2>\n' +
                            '    <div class="layui-colla-content layui-show plan_base_info">' +
                            '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
                            /* region 第一行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="documnetNum" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" style="background:#e7e7e7;" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">需求计划名称<span field="reiPlanName" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="reiPlanName" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">编制时间<span field="createDate" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="createDate" readonly id="createDate" autocomplete="off" class="layui-input" style="background:#e7e7e7;width: 53%;display: inline-block">\n' +
                            '                     <button type="button" class="layui-btn  layui-btn-sm chooseManagementBudget">选择管理目标</button>'+
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">WBS<span field="wbsName" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="wbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +

                            '           </div>' ,
                            /* endregion */
                            /* region 第二行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">RBS<span field="rbsName" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="rbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">CBS<span field="cbsName" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="cbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">控制方式<span field="controlType" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="controlType"  readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">单位</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="itemUnit" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">管理目标数量<span field="manageTarNum" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                            '                       <input type="text" name="manageTarNum" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '           </div>' ,
                            /* endregion */
                            /* region 第三行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">管理目标金额</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" readonly name="manageTarAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4 " style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">累计已发生报销金额</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" readonly name="realOutMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4 " style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">在途报销金额</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" readonly name="trnAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4 " style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">本次需求计划金额</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" readonly name="estimateAmountSum"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">需用日期<span field="needDate" class="field_required">*</span></label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="needDate" id="needDate" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>' ,
                            '           </div>' ,
                            /* endregion */
                            /* region 第四行 */
                            '           <div class="layui-row">' +
                            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label form_label">备注</label>\n' +
                            '                       <div class="layui-input-block form_block">\n' +
                            '                       <input type="text" name="memo" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '               </div>',
                            '           </div>',
                            /* endregion */
                            /* region 第五行 */
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
                            '<input type="file" multiple id="fileupload" data-url="/upload?module=costReiPlanList" name="file">' +
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
                            /* region 需求计划明细 */
                            '  <div class="layui-colla-item">\n' +
                            '    <h2 class="layui-colla-title">需求计划明细</h2>\n' +
                            '    <div class="layui-colla-content mtl_info layui-show">' +
                            '       <div>' +
                            '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                            '      </div>' +
                            '    </div>\n' +
                            '  </div>\n' ,
                            /* endregion */
                            '</div>'].join(''),
                        success: function () {
                            //回显项目名称
                            getProjName('#projectName',(projId?projId:data.projId))

                            fileuploadFn('#fileupload', $('#fileContent'));
                            //新增时计划编号显示
                            if (type == 0) {
                                // 获取自动编号
                                getAutoNumber({autoNumberType: 'otherCostReiPlan'}, function(res) {
                                    $('input[name="documnetNum"]', $('#baseForm')).val(res.obj);
                                    $('#createDate').val(res.object.createDate)
                                });
                                $('.refresh_no_btn').show().on('click', function() {
                                    getAutoNumber({autoNumberType: 'otherCostReiPlan'}, function(res) {
                                        $('input[name="documnetNum"]', $('#baseForm')).val(res.obj);
                                        $('#createDate').val(res.object.createDate)
                                    });
                                });

                                //默认当前时间
                                // var year = new Date().getFullYear();
                                // var month = new Date().getMonth()+1;
                                // var day = new Date().getDate();
                                // if (month < 10) {
                                //     month = "0" + month;
                                // }
                                // if (day < 10) {
                                //     day = "0" + day;
                                // }
                                // var today = year+"-" + month + "-" + day;
                                // //需求计划时间默认填报时间，即当日
                                // $('#createDate').val(today)


                            }
                            if(type != 4){
                                laydate.render({
                                    elem: '#needDate' //指定元素
                                    , trigger: 'click' //采用click弹出
                                    // , value: data ? format(data.needDate) : ''
                                });
                            }

                            var reiPlanListData = [];
                            //回显数据
                            if (type == 1 || type == 4) {

                                form.val("formTest", data);

                                $('.plan_base_info input[name="wbsName"]').attr('wbsId', data.wbsId || '');
                                $('.plan_base_info input[name="rbsName"]').attr('rbsId', data.rbsId || '');
                                $('.plan_base_info input[name="cbsName"]').attr('cbsId', data.cbsId || '');
                                // 控制方式
                                $('.plan_base_info input[name="controlType"]').val(dictionaryObj['CONTROL_TYPE']['object'][data.controlType] || '');
                                $('.plan_base_info input[name="controlType"]').attr('controlType', data.controlType || '');
                                // 单位
                                $('.plan_base_info input[name="itemUnit"]').val(dictionaryObj['CBS_UNIT']['object'][data.itemUnit] || '');
                                $('.plan_base_info input[name="itemUnit"]').attr('itemUnit', data.itemUnit || '');

                                if (data.attachmentList && data.attachmentList.length > 0) {
                                    var fileArr = data.attachmentList;
                                    $('#fileContent').append(echoAttachment(fileArr));
                                }

                                reiPlanListData = data.reiPlanList;

                                //查看详情
                                if(type==4){
                                    $('.plan_base_info input').attr('readonly', true);
                                    $('.file_upload_box').hide()
                                    $('.deImgs').hide()
                                    $('.chooseManagementBudget').hide()
                                }
                            }

                            element.render();
                            form.render();

                            var cols=[
                                {type: 'numbers', title: '操作'},
                                {
                                    field: 'planListName', title: '名称', templet: function (d) {
                                        return '<input type="text" name="planListName" reiPlanId="'+(d.reiPlanId || '')+'" reiPlanListId="'+(d.reiPlanListId || '')+'" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.planListName || '') + '">'
                                    }
                                },
                                {
                                    field: 'departName', title: '单位', templet: function (d) {
                                        return '<input type="text" name="departName" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.departName || '') + '">'
                                    }
                                },
                                {
                                    field: 'currNum', title: '本次数量', templet: function (d) {
                                        return '<input type="number" name="currNum"  class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.currNum || '') + '">'
                                    }
                                },
                                {
                                    field: 'estimatePrice', title: '预计单价', templet: function (d) {
                                        return '<input type="number" name="estimatePrice" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimatePrice || '') + '">'
                                    }
                                },
                                {
                                    field: 'estimateAmount', title: '预计金额', templet: function (d) {
                                        return '<input type="number" name="estimateAmount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimateAmount || '') + '">'
                                    }
                                },
                                {
                                    field: 'usePosition', title: '使用部位', templet: function (d) {
                                        return '<input type="text" name="usePosition" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.usePosition || '') + '">'
                                    }
                                },
                            ]
                            if(type!=4){
                                cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                            }
                            table.render({
                                elem: '#materialDetailsTable',
                                data: reiPlanListData,
                                toolbar: '#toolbarDemoIn',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols],
                                done:function () {
                                    if(type==4){
                                        $('.addRow').hide()
                                        $('.mtl_info input').attr('readonly', true);
                                    }
                                }
                            });
                        },
                        yes: function (index) {
                            if(type!='4'){
                                var loadIndex = layer.load();
                                //材料计划数据
                                var datas = $('#baseForm').serializeArray();
                                var obj = {}
                                datas.forEach(function (item) {
                                    obj[item.name] = item.value
                                });
                                obj.wbsId = $('.plan_base_info input[name="wbsName"]').attr('wbsId') || '';
                                obj.rbsId = $('.plan_base_info input[name="rbsName"]').attr('rbsId') || '';
                                obj.cbsId = $('.plan_base_info input[name="cbsName"]').attr('cbsId') || '';
                                // 控制方式
                                obj.controlType = $('.plan_base_info input[name="controlType"]').attr('controlType') || '';
                                // 单位
                                obj.itemUnit = $('.plan_base_info input[name="itemUnit"]').attr('itemUnit') || '';

                                obj.projBudgetId = $('.plan_base_info .chooseManagementBudget').attr('projBudgetId') || '';
                                // 附件
                                var attachmentId = '';
                                var attachmentName = '';
                                for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                    attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                    attachmentName += $('#fileContent a').eq(i).attr('name');
                                }
                                obj.attachmentId = attachmentId;
                                obj.attachmentName = attachmentName;
                                //需求计划明细
                                obj.reiPlanList = materialDetailsData();

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

                                if(accAdd(accAdd(obj.realOutMoney,obj.trnAmount),obj.estimateAmountSum)>obj.manageTarAmount){
                                    layer.msg('累计已发生报销金额+在途报销金额+本次需求计划金额<=管理目标金额', {icon: 0, time: 3000});
                                    requiredFlag = true;
                                }

                                if (requiredFlag) {
                                    layer.close(loadIndex);
                                    return false;
                                }

                                if (type == 1) {
                                    obj.reiPlanId = data.reiPlanId
                                }else{
                                    obj.projectId = parseInt(projId);
                                }

                                $.ajax({
                                    url: url,
                                    data: JSON.stringify(obj),
                                    dataType: 'json',
                                    contentType: "application/json;charset=UTF-8",
                                    type: 'post',
                                    success: function (res) {
                                        layer.close(loadIndex);
                                        if (res.code=='0') {
                                            layer.msg(res.msg, {icon: 1});
                                            layer.close(index);
                                            tableIns.config.where._ = new Date().getTime();
                                            tableIns.reload();
                                        } else {
                                            layer.msg(res.msg || '保存失败!', {icon: 2});
                                        }
                                    }
                                });
                            }else {
                                layer.close(index);
                            }

                        },
                        btn2: function (index, layero) {

                            var loadIndex = layer.load();
                            //材料计划数据
                            var datas = $('#baseForm').serializeArray();
                            var obj = {}
                            datas.forEach(function (item) {
                                obj[item.name] = item.value
                            });
                            obj.wbsId = $('.plan_base_info input[name="wbsName"]').attr('wbsId') || '';
                            obj.rbsId = $('.plan_base_info input[name="rbsName"]').attr('rbsId') || '';
                            obj.cbsId = $('.plan_base_info input[name="cbsName"]').attr('cbsId') || '';
                            // 控制方式
                            obj.controlType = $('.plan_base_info input[name="controlType"]').attr('controlType') || '';
                            // 单位
                            obj.itemUnit = $('.plan_base_info input[name="itemUnit"]').attr('itemUnit') || '';

                            obj.projBudgetId = $('.plan_base_info .chooseManagementBudget').attr('projBudgetId') || '';
                            // 附件
                            var attachmentId = '';
                            var attachmentName = '';
                            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                attachmentName += $('#fileContent a').eq(i).attr('name');
                            }
                            obj.attachmentId = attachmentId;
                            obj.attachmentName = attachmentName;
                            //需求计划明细
                            obj.reiPlanList = materialDetailsData();

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

                            if(accAdd(accAdd(obj.realOutMoney,obj.trnAmount),obj.estimateAmountSum)>obj.manageTarAmount){
                                layer.msg('累计已发生报销金额+在途报销金额+本次需求计划金额<=管理目标金额', {icon: 0, time: 3000});
                                requiredFlag = true;
                            }


                            if (requiredFlag) {
                                layer.close(loadIndex);
                                return false;
                            }

                            if (type == 1) {
                                obj.reiPlanId = data.reiPlanId
                            }else{
                                obj.projectId = parseInt(projId);
                            }

                            $.ajax({
                                url: url,
                                data: JSON.stringify(obj),
                                dataType: 'json',
                                contentType: "application/json;charset=UTF-8",
                                type: 'post',
                                success: function (res) {
                                    layer.close(loadIndex);
                                    if (res.code=='0') {
                                        layer.msg(res.msg, {icon: 1});
                                        //layer.close(index);
                                        tableIns.config.where._ = new Date().getTime();
                                        tableIns.reload();

                                        layer.open({
                                            type: 1,
                                            title: '选择流程',
                                            area: ['70%', '80%'],
                                            btn: ['确定', '取消'],
                                            btnAlign: 'c',
                                            content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                            success: function () {
                                                $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '61'}, function (res) {
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
                                                    //var approvalData = table.checkStatus(obj.config.id).data[0]
                                                    var approvalData = res.object;
                                                    delete approvalData.reiPlanList;
                                                    approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                                    approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                                    newWorkFlow(flowData.flowId, function (res) {
                                                        var submitData = {
                                                            reiPlanId:approvalData.reiPlanId,
                                                            runId: res.flowRun.runId,
                                                            //auditerStatus:1,
                                                            budgetItemId:approvalData.budgetItemId
                                                        }
                                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                                        $.ajax({
                                                            url: '/otherCostReiPlan/updateById',
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
                                    } else {
                                        layer.msg(res.msg || '保存失败!', {icon: 2});
                                    }
                                }
                            });

                        },
                        btn3: function (index, layero) {

                        }
                    });
                }

                function materialDetailsData(){
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        var materialDetailsObj = {
                            planListName: $(this).find('input[name="planListName"]').val()||'',
                            departName: $(this).find('input[name="departName"]').val()||'',
                            currNum: retainDecimal($(this).find('input[name="currNum"]').val(),3)||'',
                            estimatePrice: retainDecimal($(this).find('input[name="estimatePrice"]').val(),3)||'',
                            estimateAmount: retainDecimal($(this).find('input[name="estimateAmount"]').val(),2)||'',
                            usePosition: $(this).find('input[name="usePosition"]').val()
                        }
                        if ($(this).find('input[name="planListName"]').attr('reiPlanId')) {
                            materialDetailsObj.reiPlanId = $(this).find('input[name="planListName"]').attr('reiPlanId');
                        }
                        if ($(this).find('input[name="planListName"]').attr('reiPlanListId')) {
                            materialDetailsObj.reiPlanListId = $(this).find('input[name="planListName"]').attr('reiPlanListId');
                        }
                        materialDetailsArr.push(materialDetailsObj);
                    });
                    return materialDetailsArr
                }

                $(document).on('click', '.chooseManagementBudget', function() {

                    var wbsSelectTree = null;
                    var cbsSelectTree = null;
                    var _this = $(this);
                    layer.open({
                        type: 1,
                        title: '管理目标选择',
                        area: ['100%', '100%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" id="objectives">' +
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
                                        wbsId: wbsId || '',
                                        cbsId: cbsId || '',
                                        itemNo: itemNo || '',
                                        itemName: itemName || '',
                                        rbsTyep:'other'
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
                                        {type: 'radio'},
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
                                            field: 'rbsUnit', title: '单位',minWidth:120, templet: function (d) {
                                                var str = '';
                                                if (d.plbRbs) {
                                                    str = dictionaryObj['CBS_UNIT']['object'][d.plbRbs.rbsUnit] || '';
                                                }
                                                return str;
                                            }
                                        },
                                        // {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                        // {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                        {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                        // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                        {field: 'monQuata', title: '截止当前额度',minWidth:170},
                                        {field: 'realOutMoney', title: '截止当前已发生额度',minWidth:170},
                                        //{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                        //{field: 'manageestimateAmountSum', title: '管理目标金额余额',minWidth:150},
                                    ]],
                                    done:function(res){
                                        var _dataa=res.data;
                                        var _projBudgetId = $(_this).attr('projBudgetId')
                                        if(_projBudgetId){
                                            for(var i = 0 ; i <_dataa.length;i++){
                                                if(_dataa[i].projBudgetId == _projBudgetId){
                                                    $('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
                                                    //form.render('checkbox');
                                                }
                                            }
                                        }

                                    }
                                });
                            }
                        },
                        yes: function (index) {
                            var checkStatus = table.checkStatus('managementBudgetTable').data[0];
                            if (checkStatus) {
                                $(_this).attr('projBudgetId',checkStatus.projBudgetId)
                                $('[name="wbsName"]').val(checkStatus.plbProjWbs?checkStatus.plbProjWbs.wbsName:'')
                                $('[name="wbsName"]').attr('wbsId',checkStatus.plbProjWbs?checkStatus.plbProjWbs.wbsId:'')
                                $('[name="cbsName"]').val(checkStatus.plbCbsTypeWithBLOBs?checkStatus.plbCbsTypeWithBLOBs.cbsName:'')
                                $('[name="cbsName"]').attr('cbsId',checkStatus.plbCbsTypeWithBLOBs?checkStatus.plbCbsTypeWithBLOBs.cbsId:'')
                                $('[name="rbsName"]').val(checkStatus.plbRbs?checkStatus.plbRbs.rbsLongName:'')
                                $('[name="rbsName"]').attr('rbsId',checkStatus.plbRbs?checkStatus.plbRbs.rbsId:'')
                                $('[name="controlType"]').val(dictionaryObj['CONTROL_TYPE']['object'][checkStatus.controlType] || '')
                                $('[name="controlType"]').attr('controlType',checkStatus.controlType||'')
                                $('[name="itemUnit"]').val(checkStatus.plbRbs?dictionaryObj['CBS_UNIT']['object'][checkStatus.plbRbs.rbsUnit]:'')
                                $('[name="itemUnit"]').attr('itemUnit',checkStatus.plbRbs?checkStatus.plbRbs.rbsUnit:'')
                                $('[name="manageTarNum"]').val(retainDecimal(checkStatus.manageTarNum,3)||'0')
                                $('[name="manageTarAmount"]').val(retainDecimal(checkStatus.manageTarAmount,2)||'0')
                                $('[name="realOutMoney"]').val(retainDecimal(checkStatus.realOutMoney,2)||'0')
                                $('[name="trnAmount"]').val(retainDecimal(checkStatus.trnApplicationAmount,2)||'0')


                                layer.close(index);

                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });

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

                //监听本次数量
                $(document).on('input propertychange', 'input[name="estimateAmount"]', function () {
                    if($('#leftId').attr('_type')=='4'){
                        return false
                    }

                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var estimateAmountSum=0
                    $tr.each(function () {
                        estimateAmountSum=accAdd(estimateAmountSum,$(this).find('input[name="estimateAmount"]').val())
                    });
                    $('#baseForm [name="estimateAmountSum"] ').val(retainDecimal(estimateAmountSum,2)||0)
                });



                //数据列表点击审批状态查看流程功能
                $(document).on('click', '.preview_flow', function() {
                    var flowId = $(this).attr('flowId'),
                        runId = $(this).attr('runId');
                    if (flowId && runId) {
                        $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
                    }
                });

            });

            function openRold(){ //流程转交下一步后会调用此方法
                //刷新表格
                tableIns.reload({
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                });
            }

            function getAutoNumber(params, callback) {
                $.get('/planningManage/autoNumber', params, function (res) {
                    callback(res);
                });
            }

        </script>
    </body>
</html>
