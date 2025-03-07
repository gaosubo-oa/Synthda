<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/3/22
  Time: 10:44
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
        <title>部门预算执行申请</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

<%--        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
        <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--        <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
        <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
        <script type="text/javascript" src="/js/base/base.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
        <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
        <script type="text/javascript" src="/js/planbudget/common.js?20210616.1"></script>


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
                padding: 10px 0;
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

            .list_item {
                position: relative;
                height: 32px;
                line-height: 32px;
                padding: 0 20px;
                cursor: pointer;
            }

            .list_item.active {
                background-color: #d6f3ff;
            }

            .list_item.active:before {
                position: absolute;
                top: 0;
                left: 0;
                content: "";
                height: 100%;
                width: 5px;
                background-color: #3f73c4;
            }

            .list_item:hover {
                background-color: #d6f3ff;
            }

            .list_item:hover:before {
                position: absolute;
                top: 0;
                left: 0;
                content: "";
                height: 100%;
                width: 5px;
                background-color: #3f73c4;
            }

            .wrap_right {
                position: relative;
                height: 100%;
                margin-left: 230px;
                padding-left: 10px;
                box-sizing: border-box;
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

            .export_moudle {
                display: none;
                position: absolute;
                top: 100%;
                right: 0;
                width: 120px;
                padding: 10px;
                background-color: #fff;
                text-align: left;
                color: #222;
                box-shadow: 0 0px 1px 0px rgb(0 0 0 / 50%);
                opacity: 1 !important;
            }

            .export_moudle > p:hover {
                cursor: pointer;
                color: #1E9FFF;
            }
            .fixedtitle{
                background:url("/img/workflow/flowsetting/xiaojiqiao.png") no-repeat;
                width: 225px;
                height: 152px;
                position: fixed;
                bottom: 7px;
                left: 4px;
            }
            #xiaokuan {

                margin-top: 50px;
                float: left;
                line-height: 1.8;

            }
            .operationDiv{
                position: absolute;
                width: 150px;
                border: #ccc 1px solid;
                border-radius: 4px;
                background-color: #ffffff;
                z-index: 99;
            }
            .fujian{
                text-decoration: underline;
                color: blue;
            }
            .operation{
                display: block;
                /*width: 100%;*/
                margin-left: 0px !important;
                height: 28px;
                padding-left: 10px;
                background: #fff;
                line-height: 28px;
            }
            .operation:hover{
                background-color: #cae1f7;
                color: #000000;
            }

        </style>
    </head>
    <body>
    <div class="container">
        <input type="hidden" id="leftId" value="">
        <div class="wrapper">
            <div class="wrap_left" style="border-right: 1px solid #ccc;">
                <div class="list_module">
                    <ul class="list_ul"></ul>
                </div>
                <div class="fixedtitle">
                    <div id="xiaokuan">

                    </div>
                </div>
            </div>
            <div class="wrap_right">
                <div class="query_module layui-form layui-row" style="position: relative">
                    <div class="layui-col-xs2">
                        <input type="text" name="reimburseNo" placeholder="单据编号" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-col-xs2" style="margin-left: 15px;">
                        <select name="reimburseStatus" lay-verify="required">
                            <option value="">选择报销状态</option>
                            <option value="0">未提交</option>
                            <option value="1">报销中</option>
                            <option value="2">已报销</option>
                            <option value="3">已退回</option>
                            <option value="4">退扫</option>
                        </select>
                    </div>
                    <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                        <button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
                        <button type="button" class="layui-btn layui-btn-sm" id="">高级查询</button>
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
                </div>
            </div>
        </div>
    </div>

    <script type="text/html" id="toolbarHead">
        <div class="layui-btn-container" style="height: 30px;">
            <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
            <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
            <%--                <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="submit">提交</button>--%>
        </div>
        <div style="position:absolute;top: 10px;right:60px;">
            <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
                <img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
                <img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出
            </button>
            <div class="export_moudle">
                <p class="export_btn" type="1">导出所选数据</p>
                <p class="export_btn" type="2">导出当前页数据</p>
                <p class="export_btn" type="3">导出全部数据</p>
            </div>
        </div>
    </script>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
    </script>

    <script>
        var tipIndex = null;
        $('.icon_img').on('hover',function () {
            var tip = $(this).attr('text');
            tipIndex = layer.tips(tip, this);
        }, function () {
            layer.close(tipIndex);
        });
        $('.fixedtitle').on('mouseover', '.divShow', function () {
            $(this).find('.operationDiv').show();
        })
        $('.fixedtitle').on('mouseout', '.divShow', function () {
            $(this).find('.operationDiv').hide();
        })
        // 预览
        $(document).on('click', '.yulan', function () {
            var url = $(this).attr('data-url');
            pdurl($.UrlGetRequest('?' + url), url);
        })



        // 表格显示顺序
        var colShowObj = {
            reimburseNo: {field: 'reimburseNo', title: '单据编号', minWidth: 180, sort: true, hide: false},
            reimburseDate: {
                field: 'reimburseDate', title: '报销日期', minWidth: 80, sort: true, hide: false, templet: function (d) {
                    return format(d.reimburseDate);
                }
            },
            reimburseUser: {
                field: 'reimburseUser', title: '报销人', minWidth: 50, sort: true, hide: false, templet: function (d) {
                    return (d.reimburseUserName || '').replace(/,$/, '');
                }
            },
            reimburseBelongDept: {
                field: 'reimburseBelongDept', title: '所属部门', minWidth: 120, sort: true, hide: false, templet: function (d) {
                    return (d.reimburseBelongDeptName || '').replace(/,$/, '');
                }
            },
            reimburseDesc: {
                field: 'reimburseDesc', title: '报销事由', minWidth: 250, sort: true, hide: false, templet: function (d) {
                    return (d.reimburseDesc || '');
                }
            },
            reimburseTotal: {
                field: 'reimburseTotal', title: '报销金额(元)', minWidth: 100, sort: true, hide: false, templet: function (d) {
                    return (d.reimburseTotal || '');
                }
            },
            travelType: {
                field: 'travelType', title: '差旅类型', minWidth: 100, sort: true, hide: false, templet: function (d) {
                    return dictionaryObj['TRAVEL_TYPE']['object'][d.travelType] || '';
                }
            },
            reimburseStatus: {
                field: 'reimburseStatus', title: '报销状态', minWidth: 50, sort: true, hide: false, templet: function (d) {
                    var str = '';
                    switch (d.reimburseStatus) {
                        case '0':
                            str = '未提交';
                            break;
                        case '1':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: orange;cursor: pointer;" ' + flowStr + '>报销中</span>';
                            break;
                        case '2':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>已批准</span>';
                            break;
                        case '3':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>已退回</span>';
                            break;
                        case '4':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>影像驳回</span>';
                            break;
                        case '5':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>单据驳回</span>';
                            break;
                        case '6':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.formUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>已支付</span>';
                            break;
                    }
                    return str;
                }
            }
        }

        var TableUIObj = new TableUI('plb_dept_reimburse');

        var dictionaryObj = {
            REIMBURSEMENT_TYPE: {},
            TRAVEL_TYPE: {}
        }
        var dictionaryStr = 'REIMBURSEMENT_TYPE,TRAVEL_TYPE';
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
        $.get('/plbDictonary/getTgTypeByEnclosure', {plbDictNos: dictionaryStr}, function (res) {
            if (res.flag) {
                //附件回显
                var strs1 = '';
                var data=res.data;
                // console.log(obj)
                for (var i = 0; i < data.length; i++) {
                    var v = data[i];
                    var attachName = v.attachName;
                    var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                    var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    var attachmentUrl = v.attUrl;
                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                    strs1 += '<div class="divShow"><a class="fujian" href="javascript:;" style=" width: 20px;display: inline; ">' + data[i].attachName + '</a>' +
                        '<div class="operationDiv" style="display:none;">' + function () {
                            if (fileExtension == 'pdf' || fileExtension == 'PDF' || fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG' || fileExtension == 'txt' || fileExtension == 'TXT') { //判断是否需要查阅
                                return '<a id="pageTbody" class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="margin-left: 10px"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">查阅</a>'
                            } else {
                                return '<a id="pageTbody" class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="margin-left: 10px"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">查阅</a>'
                            }
                        }() +
                        '<a id="pageTbody" class="operation" style="margin-left: 10px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                        + '</div>' +
                        '</div>'
                }
                $('#xiaokuan').append(strs1);
            }
        });
        var iframeLayerIndex = 0;

        function initPage() {
            layui.use(['form', 'table', 'soulTable'], function () {
                var layTable = layui.table,
                    soulTable = layui.soulTable,
                    layForm = layui.form
                layForm.render();

                var listStr = '';
                $.each(dictionaryObj['REIMBURSEMENT_TYPE']['object'], function (k, v) {
                    listStr += '<li class="list_item" type="' + k + '"><span>' + v + '</span></li>';
                });
                $('.list_ul').html(listStr);
                $('.list_item').eq(0).addClass('active');
                $('#leftId').val($('.list_item').eq(0).attr('type'));

                var tableObj = null;

                TableUIObj.init(colShowObj, function () {
                    tableInit();
                });

                // 监听排序事件
                layTable.on('sort(tableObj)', function (obj) {
                    var param = {
                        orderbyFields: obj.field,
                        orderbyUpdown: obj.type
                    }

                    TableUIObj.update(param, function () {
                        tableInit({
                            reimburseNo: $('[name="reimburseNo"]', $('.query_module')).val(),
                            reimburseStatus: $('[name="reimburseStatus"]', $('.query_module')).val()
                        });
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
                            newOrEdit(1);
                            break;
                        case 'del': // 删除
                            if (checkStatus.data.length == 0) {
                                layer.msg('请选择需要删除的数据！', {icon: 0, time: 2000});
                                return false;
                            }

                            var reimburseIds = '';

                            checkStatus.data.forEach(function (item) {
                                // 只能删除未提交的数据
                                if (item.reimburseStatus == '0') {
                                    reimburseIds += item.reimburseId + ',';
                                }
                            });

                            layer.confirm('确定删除该条数据吗？', function (index) {
                                $.get('/plbDeptReimburse/deleteDeptReimburseByReimburseId', {reimburseIds: reimburseIds}, function (res) {
                                    layer.close(index)
                                    if (res.flag) {
                                        layer.msg('删除成功！', {icon: 1});
                                        reloadTableData();
                                    } else {
                                        layer.msg('删除失败！', {icon: 2});
                                    }
                                });
                            });
                            break;
                        case 'submit': // 提交
                            if (checkStatus.data.length != 1) {
                                layer.msg('请选择一条需要编辑的数据！', {icon: 0, time: 2000});
                                return false;
                            }

                            if (checkStatus.data[0].reimburseStatus != '0') {
                                layer.msg('不可重复提交！', {icon: 0, time: 2000});
                                return false;
                            }
                            var reimburseInfo = checkStatus.data[0];
                            layer.open({
                                type: 1,
                                title: '选择流程',
                                area: ['70%', '80%'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
                                success: function () {
                                    var plbDictNo = '';
                                    switch ($('#leftId').val()) {
                                        case '01': // 差旅报销单
                                            plbDictNo = '02';
                                            break;
                                        case '02': // 休假报销单
                                            plbDictNo = '03';
                                            break;
                                        case '03': // 个人费用报销单
                                            plbDictNo = '04';
                                            break;
                                        case '04': // 限额费用报销单
                                            plbDictNo = '07';
                                            break;
                                        case '05': // 对公费用报销单
                                            plbDictNo = '08';
                                            break;
                                        case '06': // 资金支付审批单
                                            // plbDictNo = '04';
                                            break;
                                        default:
                                            break;
                                    }
                                    $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: plbDictNo}, function (res) {
                                        var flowData = []
                                        $.each(res.data.flowData, function (k, v) {
                                            flowData.push({
                                                flowId: k,
                                                flowName: v
                                            });
                                        });
                                        layTable.render({
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
                                    var checkStatus = layTable.checkStatus('flowTable');
                                    if (checkStatus.data.length > 0) {
                                        var flowData = checkStatus.data[0];

                                        reimburseInfo.createUser = reimburseInfo.createUserName
                                        reimburseInfo.reimburseUser = reimburseInfo.reimburseUserName

                                        newWorkFlow(flowData.flowId, JSON.stringify(reimburseInfo), function (res) {
                                            // 报销单保存关联的runId
                                            var submitData = {
                                                reimburseId: reimburseInfo.reimburseId,
                                                runId: res.flowRun.runId,
                                                reimburseStatus: '1'
                                            }
                                            $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                            $.ajax({
                                                url: '/plbDeptReimburse/updateDataByReimburseId',
                                                data: JSON.stringify(submitData),
                                                dataType: 'json',
                                                contentType: "application/json;charset=UTF-8",
                                                type: 'post',
                                                success: function (res) {
                                                    layer.close(loadIndex);
                                                    if (res.flag) {
                                                        layer.close(index);
                                                        layer.msg('提交成功!', {icon: 1});
                                                        reloadTableData();
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
                            break;
                        case 'import': // 导入
                            layer.msg('导入');
                            break;
                        case 'export': // 导出
                            $('.export_moudle').show();
                            break;
                    }
                });
                layTable.on('tool(tableObj)', function (obj) {
                    var data = obj.data;
                    var layEvent = obj.event;
                    if (layEvent === 'detail') {
                        newOrEdit(3, data);
                    } else if (layEvent === 'edit') {
                        if (data.reimburseStatus != '0') {
                            layer.msg('所选数据正在审批中，不可编辑！', {icon: 0, time: 2000});
                            return false;
                        }

                        newOrEdit(2, data);
                    }
                });

                // 查询
                $('#searchBtn').on('click', function () {
                    tableInit();
                });

                // 高级查询
                $('#advancedQuery').on('click', function () {
                    layer.msg('功能完善中')
                });

                /**
                 * 加载表格方法
                 * @param searchObj (查询参数)
                 */
                function tableInit() {
                    var searchObj = getSearchObj();
                    searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
                    searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

                    var cols = [{checkbox: true}].concat(TableUIObj.cols)

                    cols.push({
                        fixed: 'right',
                        align: 'center',
                        toolbar: '#barDemo',
                        title: '操作',
                        width: 140
                    })

                    var option = {
                        elem: '#tableObj',
                        url: '/plbDeptReimburse/getDataByReimburseType',
                        toolbar: '#toolbarHead',
                        cols: [cols],
                        defaultToolbar: ['filter'],
                        height: 'full-80',
                        page: {
                            limit: TableUIObj.onePageRecoeds,
                            limits: [10, 20, 30, 40, 50]
                        },
                        where: searchObj,
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

                /**
                 * 新增-编辑-预览报销单
                 * @param type
                 * @param data
                 */
                function newOrEdit(type, data) {
                    var title = '';
                    var reimburseType = $('#leftId').val()

                    var url = '/plbDeptBudget/editClaimForm?type=' + type + '&reimburseType=' + reimburseType;
                    if (type == 1) {
                        title = '新增' + dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType];
                    } else if (type == 2) {
                        title = '编辑' + dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType] + '-' + data.reimburseNo;
                        url += '&reimburseId=' + data.reimburseId;
                    } else if (type == 3) {
                        title = dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType] + '-' + data.reimburseNo;
                        url += '&reimburseId=' + data.reimburseId + '&disabled=1';
                    }
                    iframeLayerIndex = layer.open({
                        type: 2,
                        title: title,
                        area: ['100%', '100%'],
                        content: url,
                        end: function () {
                            if (type != 3) {
                                reloadTableData();
                            }
                        }
                    });
                }

                /**
                 * 获取查询条件
                 * @returns {{reimburseStatus: (String), reimburseNo: (String), reimburseType: (String)}}
                 */
                function getSearchObj() {
                    var searchObj = {
                        reimburseType: $('#leftId').val(),
                        reimburseNo: $('[name="reimburseNo"]', $('.query_module')).val(),
                        reimburseStatus: $('[name="reimburseStatus"]', $('.query_module')).val()
                    }

                    return searchObj;
                }

                /**
                 * 重新加载表格数据
                 */
                function reloadTableData() {
                    tableObj.config.where._ = new Date().getTime();
                    tableObj.reload({
                        page: {
                            curr: 1
                        },
                        where: getSearchObj()
                    });
                }

                /*region 导出 */
                $(document).on('click', function () {
                    $('.export_moudle').hide();
                });
                $(document).on('click', '.export_btn', function () {
                    var type = $(this).attr('type');

                    var reimburseType = $('#leftId').val();

                    var fileName = (dictionaryObj['REIMBURSEMENT_TYPE']['object'][reimburseType] || '报销单') + '列表.xlsx';

                    if (type == 1) {
                        var checkStatus = layTable.checkStatus('tableObj');
                        if (checkStatus.data.length == 0) {
                            layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                            return false;
                        }
                        soulTable.export(tableObj, {
                            filename: fileName,
                            checked: true
                        });
                    } else if (type == 2) {
                        soulTable.export(tableObj, {
                            filename: fileName,
                            curPage: true
                        });
                    } else if (type == 3) {
                        var load=layer.load(2)
                        $.get('/plbDeptReimburse/getDataByReimburseType',function () {
                            soulTable.export(tableObj, {
                                filename: fileName
                            });
                            layer.close(load)
                        })

                    }
                });
                /* endregion */
            });
        }

        $(document).on('click', '.list_item', function () {
            $(this).siblings().removeClass('active');
            $(this).addClass('active');
            var type = $(this).attr('type');
            $('#leftId').val(type);

            if (type == '01' || type == '02') {
                colShowObj.travelType = {
                    field: 'travelType', title: '差旅类型', sort: true, hide: false, templet: function (d) {
                        return dictionaryObj['TRAVEL_TYPE']['object'][d.travelType] || '';
                    }
                }
            } else {
                if (colShowObj.travelType) {
                    delete colShowObj.travelType;
                }
            }

            if (type == '04') {
                colShowObj.reimburseBelongDept.title = '申请部门';
                if (colShowObj.reimburseUser) {
                    delete colShowObj.reimburseUser;
                }
            } else {
                colShowObj.reimburseBelongDept.title = '所属部门';
                colShowObj.reimburseUser = {
                    field: 'reimburseUser', title: '报销人', sort: true, hide: false, templet: function (d) {
                        return (d.reimburseUserName || '').replace(/,$/, '');
                    }
                }
            }

            TableUIObj.reloadCols(colShowObj);

            $('#searchBtn').trigger('click');
        });

        $(document).on('click', '.preview_flow', function() {
            var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId'),
                formUrl = $(this).attr('formUrl');
            if (formUrl) {
                $.popWindow(formUrl);
            }
        });

        /**
         * 新建流程方法
         * @param flowId
         * @param approvalData
         * @param cb
         */
        function newWorkFlow(flowId, approvalData, cb) {
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
                    isBudgetFlow: true, // 是否为预算审批流
                    //urlParameter: urlParameter, // 封装所有参数 (内嵌页面)
                    //approvalType: '01', // 预算关联审批页面【数据字典配置】(内嵌页面)
                    approvalData: approvalData, // (tab页面)
                    isTabApproval: true // 是否为tab方式打开
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
    </script>
    </body>
</html>