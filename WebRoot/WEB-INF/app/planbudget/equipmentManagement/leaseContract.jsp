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
    <title>租赁合同</title>

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
            <h2 style="text-align: center;line-height: 35px;">租赁合同</h2>
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
                    <input type="text" name="mtlLeasecontractNo" placeholder="合同编号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
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
                    <table id="tableDemo" lay-filter="tableDemo"></table>
                </div>
                <div class="no_data" style="text-align: center;display: none">
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
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img
                src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img
                src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出
        </button>
        <%--        <i class="layui-icon layui-icon-upload-circle iconImg" lay-event="import"  style="margin-left: 10px;font-size: 20px" title="导入"></i>
                <i class="layui-icon layui-icon-export iconImg" lay-event="export" style="margin-left: 10px;font-size: 20px" title="导出"></i>--%>
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

    $(document).on('click', '.userAdd', function () {
        var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : ''
        user_id = $(this).siblings('textarea').attr('id')
        $.popWindow("/common/selectUser" + chooseNum);
    });
    //选人控件删除
    $(document).on('click', '.userDel', function () {
        var userId = $(this).siblings('textarea').attr('id')
        $('#' + userId).val('')
        $('#' + userId).attr('user_id', '')
    });

    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        PAYMENT_METHOD: {},
    }
    var dictionaryStr = 'PAYMENT_METHOD';
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
            mtlLeasecontractNo: {field: 'mtlLeasecontractNo', title: '合同编号', sort: true, hide: false},
            contractName: {field: 'contractName', title: '合同名称', sort: true, hide: false},
            projName: {field: 'projName', title: '所属项目', sort: true, hide: false},
            contractType: {field: 'contractType', title: '合同种类', sort: true, hide: false},
            signDate: {
                field: 'signDate', title: '合同签订日期', sort: true, hide: false, templet: function (d) {
                    return format(d.signDate);
                }
            },
            contractPeriod: {field: 'contractPeriod', title: '合同工期', sort: true, hide: false},
        }

        var TableUIObj = new TableUI('plb_mtl_leasecontract');


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
                    var mtlLeasecontractId = ''
                    checkStatus.data.forEach(function (v, i) {
                        mtlLeasecontractId += v.mtlLeasecontractId + ','
                    })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbMtlleasecontract/delete', {mtlLeasecontractIds: mtlLeasecontractId}, function (res) {
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
                case 'export':
                    // window.location.href = '/plbMtlPlan/outCurrentPageData?mtlPlanIds=' + exportData
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
                    layer.open({
                        type: 1,
                        title: '选择',
                        area: ['70%', '60%'],
                        btnAlign: 'c',
                        btn: ['确定', '取消'],
                        content: ['<div class="layui-form">' +
                        //表格数据
                        '       <div style="padding: 10px">' +
                        '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                        '      </div>' +
                        '</div>'].join(''),
                        success: function () {
                            table.render({
                                elem: '#mtlPlanIdTable',
                                url: '/plbProjBudget/queryAll',
                                where:{projId:$('#leftId').attr('projId'),cbsType:'05'},
                                page:true,
                                cols: [[
                                    {type: 'checkbox', title: '选择'},
                                    {field: 'budgetName', title: '预算名称', width: 200,},
                                    {field: 'cbsName', title: 'CBS',},
                                    {
                                        field: 'manageTarAmount', title: '管理目标金额',
                                    },
                                    {
                                        field: 'accumulatedSignedContractAmount', title: '累计已签合同金额',templet: function (d) {
                                            return  d.accumulatedSignedContractAmount || 0
                                        }
                                    },
                                ]],
                                parseData: function(res){ //res 即为原始返回的数据
                                    return {
                                        "code": 0, //解析接口状态
                                        "count": res.totleNum, //解析数据长度
                                        "data": res.data //解析数据列表
                                    };
                                }
                            });
                        },
                        yes: function (index) {
                            var checkStatus = table.checkStatus('mtlPlanIdTable')
                            if (checkStatus.data.length > 0) {
                                var chooseData = checkStatus.data;

                                //遍历表格获取每行数据进行保存
                                var $tr = $('.contract_list').find('.layui-table-main tr');
                                var oldDataArr = [];
                                $tr.each(function () {
                                    var oldDataObj = {
                                        cbsId: $(this).find('[name="contractPrice"]').attr('cbsId'),
                                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                                        managementTargetPrice: $(this).find('[data-field="managementTargetPrice"] .layui-table-cell').text(),
                                        accumulatedSignedContractAmount: $(this).find('[data-field="accumulatedSignedContractAmount"] .layui-table-cell').text(),
                                        contractPrice: $(this).find('[name="contractPrice"]').val(),
                                        mtlLeasecontractOutId: $(this).find('[name="contractPrice"]').attr('mtlLeasecontractOutId'),

                                        projBudgetId: $(this).find('[name="contractPrice"]').attr('projBudgetId'),//项目预算编制id

                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                /*var addRowData = {
                                    cbsId: chooseData.cbsId,
                                    cbsName: chooseData.cbsName,
                                    managementTargetPrice: chooseData.manageTarAmount,
                                    projBudgetId: chooseData.projBudgetId,
                                };
                                oldDataArr.push(addRowData);*/
                                //具体明细可多选
                                chooseData.forEach(function (item) {
                                    var addRowData={
                                        cbsId: item.cbsId,
                                        cbsName: item.cbsName,
                                        managementTargetPrice: item.manageTarAmount,
                                        projBudgetId: item.projBudgetId,
                                        accumulatedSignedContractAmount: item.accumulatedSignedContractAmount || 0,
                                    }
                                    oldDataArr.push(addRowData)
                                })
                                table.reload('materialDetailsTable', {
                                    data: oldDataArr
                                });


                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0, time: 2000});
                            }
                        }
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
                if (data.mtlLeasecontractOutId) {
                    $.get('/plbMtlleasecontractOut/delete', {mtlLeasecontractOutIds: data.mtlLeasecontractOutId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.contract_list').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        cbsId: $(this).find('[name="contractPrice"]').attr('cbsId'),
                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                        managementTargetPrice: $(this).find('[data-field="managementTargetPrice"] .layui-table-cell').text(),
                        accumulatedSignedContractAmount: $(this).find('[data-field="accumulatedSignedContractAmount"] .layui-table-cell').text(),
                        contractPrice: $(this).find('[name="contractPrice"]').val(),
                        mtlLeasecontractOutId: $(this).find('[name="contractPrice"]').attr('mtlLeasecontractOutId'),

                        projBudgetId: $(this).find('[name="contractPrice"]').attr('projBudgetId'),//项目预算编制id
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });
        // 内部-付款结算-上方按钮显示
        table.on('toolbar(paymentSettlementTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.contract_out').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            mtlLeasecontractPayId: $(this).find('input[name="contractMoney"]').attr('mtlLeasecontractPayId') || '',
                            contractMoney: $(this).find('input[name="contractMoney"]').val(),
                            contractRatio: $(this).find('input[name="contractRatio"]').val(),
                            paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
                            termOfPayment: $(this).find('input[name="termOfPayment"]').val()
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    oldDataArr.push({});
                    table.reload('paymentSettlementTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });
        // 内部-付款结算-删行操作
        table.on('tool(paymentSettlementTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.mtlLeasecontractPayId) {
                    $.get('/plbMtlleasecontract/deleteListId', {mtlLeasecontractPayId: data.mtlLeasecontractPayId}, function () {
                    });
                }
                //遍历表格获取每行数据进行保存
                var $trs = $('.contract_out').find('.layui-table-main tr');
                var oldDataArr = [];
                $trs.each(function () {
                    var oldDataObj = {
                        mtlLeasecontractPayId: $(this).find('input[name="contractMoney"]').attr('mtlLeasecontractPayId') || '',
                        contractMoney: $(this).find('input[name="contractMoney"]').val(),
                        contractRatio: $(this).find('input[name="contractRatio"]').val(),
                        paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
                        termOfPayment: $(this).find('input[name="termOfPayment"]').val()
                    }
                    oldDataArr.push(oldDataObj);
                })
                table.reload('paymentSettlementTable', {
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
                        defaultExpandAll: true,
                        request: {
                            name: 'name',
                            children: "plbProjList",
                        }
                    });
                    TableUIObj.init(colShowObj,function () {
                        tableShow('')
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
                url: '/plbMtlleasecontract/selectAll',
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
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
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
                title = '新建租赁合同';
                url = '/plbMtlleasecontract/insert';
            } else if (type == '1') {
                title = '编辑租赁合同';
                url = '/plbMtlleasecontract/update';
            }else if(type == '4'){
                title = '查看详情'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: ['保存', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-collapse">\n',
                    /* region 材料计划 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">租赁合同</h2>\n' +
                    '    <div class="layui-colla-content layui-show plan_base_info">' +
                    '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
                    /* region 第一行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同编号<span field="mtlLeasecontractNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="mtlLeasecontractNo" readonly autocomplete="off" class="layui-input" style="background: #e7e7e7" title="合同编号">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractName" autocomplete="off" class="layui-input chen" title="合同名称">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同金额(元)<span field="contractFee" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="contractFee" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input" title="合同金额(元)">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第二行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">履约保证金</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="bondCash" autocomplete="off" class="layui-input" title="履约保证金">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">质保期</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="warrantyPeriod" autocomplete="off" class="layui-input" title="质保期">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">质保金比例</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="bondRatio" autocomplete="off" class="layui-input" title="质保金比例">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第三行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">甲方</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractA" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">乙方</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractB" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同内容</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractContent" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' +
                    /* endregion */
                    /* region 第四行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">付款方式</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                        <select name="paymentType"></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同种类</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                        <select name="contractType"><option value="正常">正常</option><option value="虚拟">虚拟</option></select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同签订日期</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" readonly name="signDate" id="signDate" autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第五行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">合同工期</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="contractPeriod" autocomplete="off" class="layui-input" title="合同工期">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">预付款</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="paymentPre" autocomplete="off" class="layui-input" title="预付款">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">税率</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <select name="taxRate" lay-filter="taxRate">' +
                    '                           <option value=""></option><option value="0">0</option><option value="1">1</option>' +
                    '                           <option value="3">3</option><option value="6">6</option><option value="9">9</option>' +
                    '                           <option value="10">10</option><option value="13">13</option>' +
                    '                           </select>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    /* region 第六行*/
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">不含税合同价</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="contractMoneyNotax" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="不含税合同价">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    /* endregion */
                    /* region 第七行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">比价附件</label>' +
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
                    '           </div>',
                    /* endregion */
                    '       </form>' +
                    '    </div>\n' +
                    '  </div>\n',
                    /* endregion */
                    /* region 合同明细 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">明细</h2>\n' +
                    '    <div class="layui-colla-content mtl_info layui-show">' +
                    '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
                    '<ul class="layui-tab-title">' +
                    '<li class="layui-this">合同明细</li>' +
                    '<li>付款结算</li>' +
                    '<li>其他约定</li>' +
                    '</ul>' +
                    '<div class="layui-tab-content">' +
                    '<div class="layui-tab-item layui-show contract_list">' +
                    '<div id="contractDetailsModule"><table id="materialDetailsTable" lay-filter="materialDetailsTable"></table></div>' +
                    '</div>' +
                    '<div class="layui-tab-item contract_out">' +
                    '<div id="paymentSettlementModule"><table id="paymentSettlementTable" lay-filter="paymentSettlementTable"></table></div>' +
                    '</div>' +
                    '<div class="layui-tab-item">' +
                    '<textarea name="contractOtherContent" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    /*'       <div>' +
                    '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                    '      </div>' +*/
                    '    </div>\n' +
                    '  </div>\n',
                    /* endregion */
                    '</div>'].join(''),
                success: function () {
                    fileuploadFn('#fileupload', $('#fileContent'));
                    $('[name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str'])

                    form.on('select(taxRate)', function(data){
                        // console.log(data.value); //得到被选中的值
                        if(data.value && $('#baseForm [name="contractFee"]').val()){
                            var taxRate=data.value * 0.01
                            var contractFee=$('#baseForm [name="contractFee"]').val()
                            $('#baseForm [name="contractMoneyNotax"]').val(keepTwoDecimalFull(contractFee / (1+taxRate)))
                        }
                    });

                    var materialDetailsTableData = [];
                    var paymentSettlementTableData = [];
                    //回显数据
                    if (type == 1 || type == 4) {
                        form.val("formTest", data);

                        $('[name="contractA"]').val(data.contractAName || '')
                        $('[name="contractA"]').attr('customerId',data.contractA || '')
                        $('[name="contractB"]').val(data.contractBName || '')
                        $('[name="contractB"]').attr('customerId',data.contractB || '')

                        if (data.attachments && data.attachments.length > 0) {
                            var fileArr = data.attachments;
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

                        materialDetailsTableData = data.plbMtlLeasecontractOutList || [];
                        // 付款结算列表数据
                        paymentSettlementTableData = data.plbMtlLeasecontractPayList || [];
                        // 其他约定
                        $('[name="contractOtherContent"]').val(data.contractOtherContent);

                        //查看详情
                        if(type==4){
                            $('.layui-layer-btn-c').hide()
                            $('#baseForm [name="contractName"]').attr('disabled','true')
                            $('#baseForm [name="bondCash"]').attr('disabled','true')
                            $('#baseForm [name="warrantyPeriod"]').attr('disabled','true')
                            $('#baseForm [name="bondRatio"]').attr('disabled','true')
                            $('#baseForm [name="contractA"]').attr('disabled','true')
                            $('#baseForm [name="contractB"]').attr('disabled','true')
                            $('#baseForm [name="contractContent"]').attr('disabled','true')
                            $('#baseForm [name="paymentType"]').attr('disabled','true')
                            $('#baseForm [name="contractType"]').attr('disabled','true')
                            $('#signDate').attr('disabled','true')
                            $('#baseForm [name="contractPeriod"]').attr('disabled','true')
                            $('#baseForm [name="paymentPre"]').attr('disabled','true')
                            $('#baseForm [name="taxRate"]').attr('disabled','true')
                            $('[name="contractOtherContent"]').attr('disabled','true')
                            $('.file_upload_box').hide()
                            $('.deImgs').hide()

                        }
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbMtlLeasecontract'}, function(res) {
                            $('input[name="mtlLeasecontractNo"]', $('#baseForm')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbMtlLeasecontract'}, function(res) {
                                $('input[name="mtlLeasecontractNo"]', $('#baseForm')).val(res);
                            });
                        });
                    }

                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#signDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.signDate) : ''
                    });

                    var cols=[
                        {type: 'numbers', title: '操作'},
                        {
                            field: 'cbsName', title: 'CBS', width: 200,
                        },
                        {
                            field: 'managementTargetPrice', title: '管理目标金额',
                        },
                        {
                            field: 'accumulatedSignedContractAmount', title: '累计已签合同金额',
                        },
                        {
                            field: 'contractPrice', title: '本次合同价',
                            templet: function (d) {
                                return '<input type="text" '+(type==4 ? 'readonly' : '')+' mtlLeasecontractOutId="' + (d.mtlLeasecontractOutId || '')+ '" cbsId="'+(d.cbsId || '')+'" projBudgetId="'+(d.projBudgetId || '')+'" name="contractPrice" class="layui-input contractPriceItem" style="height: 100%;" value="' + (d.contractPrice || '')+ '">'
                            }
                        },
                    ]
                    var colsPaymentSettlement=[
                        {type: 'numbers', title: '序号'},
                        {
                            field: 'contractMoney', title: '约定付款金额', templet: function (d) {
                                return '<input type="number" '+(type==4 ? 'readonly' : '')+' mtlLeasecontractPayId="' + (d.mtlLeasecontractPayId || '') + '" name="contractMoney" class="layui-input contractMoney" style="height: 100%;" value="' + (d.contractMoney || '') + '">'
                            }
                        },
                        {
                            field: 'contractRatio', title: '约定付款比例', templet: function (d) {
                                return '<input type="number" '+(type==4 ? 'readonly' : '')+' name="contractRatio" class="layui-input contractRatio" style="height: 100%" value="' + (d.contractRatio || '') + '">'
                            }
                        },
                        {
                            field: 'paymentPeriod', title: '约定付款日期', templet: function (d) {
                                return '<input type="text" name="paymentPeriod" '+(type==4 ? 'disabled' : 'readonly')+' class="layui-input paymentPeriod" style="height: 100%;" value="' + (d.paymentPeriod || '') + '">'
                            }
                        },
                        {
                            field: 'termOfPayment', title: '付款条件', templet: function (d) {
                                return '<input type="text" '+(type==4 ? 'readonly' : '')+' name="termOfPayment" class="layui-input termOfPayment" style="height: 100%;" value="' + (d.termOfPayment || '') + '">'
                            }
                        },
                    ]
                    if(type!=4){
                        cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                        colsPaymentSettlement.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
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
                    table.render({
                        elem: '#paymentSettlementTable',
                        data: paymentSettlementTableData,
                        toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [colsPaymentSettlement],
                        done:function (res) {
                            if(type==4){
                                $('.addRow').hide()
                            }
                            var datas = res.data;
                            $('.contract_out').find('.paymentPeriod').each(function (i, v) {
                                laydate.render({
                                    elem: v,
                                    trigger: 'click',
                                    value: datas[i].paymentPeriod || ''
                                });
                            });
                        }
                    });
                },
                yes: function (index) {
                    var loadIndex = layer.load();
                    //材料计划数据
                    var datas = $('#baseForm').serializeArray();
                    var obj = {}
                    datas.forEach(function (item) {
                        obj[item.name] = item.value
                    });
                    //甲方id
                    obj.contractA=$('[name="contractA"]').attr('customerId')
                    //乙方id
                    obj.contractB=$('[name="contractB"]').attr('customerId')
                    // 附件
                    var attachmentIdBj = '';
                    var attachmentNameBj = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentIdBj += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentNameBj += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentIdBj = attachmentIdBj;
                    obj.attachmentNameBj = attachmentNameBj;
                    //合同明细数据
                    var $tr = $('.contract_list').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        var materialDetailsObj = {
                            cbsId: $(this).find('[name="contractPrice"]').attr('cbsId'),
                            cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                            managementTargetPrice: $(this).find('[data-field="managementTargetPrice"] .layui-table-cell').text(),
                            accumulatedSignedContractAmount: $(this).find('[data-field="accumulatedSignedContractAmount"] .layui-table-cell').text(),
                            contractPrice: $(this).find('[name="contractPrice"]').val(),

                            projBudgetId: $(this).find('[name="contractPrice"]').attr('projBudgetId'),//项目预算编制id
                        }
                        if ($(this).find('input[name="contractPrice"]').attr('mtlLeasecontractOutId')) {
                            materialDetailsObj.mtlLeasecontractOutId = $(this).find('input[name="contractPrice"]').attr('mtlLeasecontractOutId');
                        }
                        materialDetailsArr.push(materialDetailsObj);
                    });
                    obj.plbMtlLeasecontractOutList = materialDetailsArr;

                    // 付款结算数据
                    var $tr2 = $('#paymentSettlementModule').find('.layui-table-main tr');
                    var plbMtlContractOuts = [];
                    $tr2.each(function () {
                        var plbMtlContractObj = {
                            contractMoney: $(this).find('input[name="contractMoney"]').val(),
                            contractRatio: $(this).find('input[name="contractRatio"]').val(),
                            paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
                            termOfPayment: $(this).find('input[name="termOfPayment"]').val()
                        }
                        if ($(this).find('input[name="contractMoney"]').attr('mtlLeasecontractPayId')) {
                            plbMtlContractObj.mtlLeasecontractPayId = $(this).find('input[name="contractMoney"]').attr('mtlLeasecontractPayId');
                        }
                        plbMtlContractOuts.push(plbMtlContractObj);
                    });
                    obj.plbMtlLeasecontractPayList = plbMtlContractOuts;

                    // 其他约定
                    obj.contractOtherContent = $('[name="contractOtherContent"]').val();

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

                    if (type == 1) {
                        obj.mtlLeasecontractId = data.mtlLeasecontractId
                    }else{
                        obj.projId = parseInt(projId);
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
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }
                    });
                },
            });
        }

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

        //监听甲方、乙方选择
        $(document).on('click', '.chooseEquivalent', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择分包商',
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
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.typeNo) {
                            $('.mtl_no_data').hide();
                            $('.mtl_table_box').show();
                            loadMtlTable(currentData.typeNo);
                        } else {
                            $('.mtl_table_box').hide();
                            $('.mtl_no_data').show();
                        }
                    });

                    loadMtlType();

                    function loadMtlType(typeNo) {
                        typeNo = typeNo ? typeNo : '';
                        // 获取左侧树
                        $.get('/PlbCustomerType/treeList', function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: true,
                                    request: {
                                        name: "typeName", // 显示的内容
                                        key: "typeNo", // 节点id
                                        parentId: 'parentTypeId', // 节点父id
                                        isLeaf: "isLeaf",// 是否有子节点
                                        children: 'child',
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(typeNo) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/PlbCustomer/getDataByCondition',
                            where: {
                                merchantType:typeNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-180'
                            , toolbar: '#toolbar'
                            , defaultToolbar: ['']
                            ,
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'customerNo', title: '客商编号', sort: true, width: 200}
                                , {field: 'customerName', title: '客商单位名称',}
                                , {field: 'customerShortName', title: '客商单位简称',}
                                , {field: 'customerOrgCode', title: '组织机构代码'}
                                , {field: 'taxNumber', title: '税务登记号'}
                                , {field: 'accountNumber', title: '开户行账户'}
                            ]], parseData: function (res) {
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data,//解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            },
                            request: {
                                pageName: 'page' //页码的参数名称，默认：page
                                , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                            },
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        _this.val(mtlData.customerName);
                        _this.attr('customerId',mtlData.customerId);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });

        //监听本次合同价之和赋值给合同金额
        $(document).on('blur', '.contractPriceItem', function () {
            var $tr = $('.contract_list').find('.layui-table-main tr');
            var contractFee=0
            $tr.each(function () {
                contractFee=accAdd(contractFee,$(this).find('input[name="contractPrice"]').val())
            });
            $('#baseForm [name="contractFee"] ').val(contractFee)

            //不含税合同价为合同金额/（1+税率）
            if($('[name="taxRate"]').val() && $('#baseForm [name="contractFee"]').val()){
                var taxRate=$('[name="taxRate"]').val() * 0.01
                var contractFeeItem=$('#baseForm [name="contractFee"]').val()
                $('#baseForm [name="contractMoneyNotax"]').val(keepTwoDecimalFull(contractFeeItem / (1+taxRate)))
            }
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