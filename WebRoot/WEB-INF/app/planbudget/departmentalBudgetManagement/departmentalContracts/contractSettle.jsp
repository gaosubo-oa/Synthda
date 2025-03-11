<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<head>
    <title>合同结算</title>

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

        .layui-table-view .layui-form-radio>i{
            margin-top: 14px;
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
        .footer{
            text-align: center;
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
    <script type="text/javascript" src="/js/planbudget/kingDee.js?20210827.2"></script>
    <script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
    <script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">合同结算</h2>
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
            <div class="fixedtitle">
                <div id="xiaokuan">
                </div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input" >
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px">
                    <input type="text" name="contractNo" placeholder="单据编号" autocomplete="off" class="layui-input" >
                </div>
                <%--<div class="layui-col-xs2" style="margin-left: 15px;">
                    <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select>
                        <option value="">请选择</option>
                    </select>
                </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select name="auditerStatus">
                        <option value="">请选择</option>
                        <option value="0">待审批</option>
                        <option value="1">批准</option>
                        <option value="2">不批准</option>
                    </select>
                </div>--%>
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
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <%--        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>--%>
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;"><img
                src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img
                src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出
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

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    var deptId
    //小技巧
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
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name = $(this).attr('name')
        $('.query_module [name=' + name + ']').val($.cookie(name) || '')
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
    // 选择部门
    $(document).on('click', '.choose_dept', function () {
        dept_id = $(this).attr('id');
        $.popWindow('/common/selectDept?0');
    });
    var tipIndex = null;
    $('.icon_img').on('hover',function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        CONTROL_MODE: {},
        CBS_UNIT: {},
        CONTRACT_TYPE: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,CONTRACT_TYPE';
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
    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var tableIns = null;
        var materialsTable = null;
        var addRowData2 = {}

        form.render();
        tJian()
        //导出数据
//        var exportData = '';
        $(document).on('click',function () {
            $('.export_moudle').hide();
        })
        $(document).on('click', '.export_btn',function () {
            var type=$(this).attr('type')
            var fileName='合同结算.xlsx'
            console.log(checkStatus)
            if(type==1){
                var checkStatus = table.checkStatus('tableDemo');
                if (checkStatus.data.length == 0) {
                    layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
                    return false;
                }

                soulTable.export(tableIns, {
                    filename: fileName,
                    checked: true
                });
            }else if(type==2){
                soulTable.export(tableIns,{
                    filename:fileName,
                    curPage: true
                })
            } else if(type==3){
                var load=layer.load(2)
                $.get('/plbContractInfo/getContractSettle',function () {
                    soulTable.export(tableIns, {
                        filename: fileName
                    });
                    layer.close(load)
                })
            }
        })

        var contractIds;
        var isAdvance;
        var contractIdss;
        var asd=[];
        //表格显示顺序
        var colShowObj = {
            contractNo: {field: 'contractNo', title: '单据编号', width: 300, sort: true, hide: false,templet: function (d) {
                    return (d.contractNo || '');
                }},
            createUser: {
                field: 'createUser', title: '经办人', width: 150, sort: true, hide: false, templet: function (d) {
                    return d.createUser || ''
                }
            },
            createTime: {
                field: 'createTime', title: '报销日期', width: 120, sort: true, hide: false, templet: function (d) {
                    return (d.createTime || '');
                }
            },
            settleupMoney: {
                field: 'settleupMoney', title: '报销金额', width: 150, sort: true, hide: false, templet: function (d) {
                    return d.settleupMoney || 0
                }
            },
            customerId: {field: 'customerId', title: '客商单位名称', width: 300, sort: true, hide: false, templet: function (d) {
                    return (d.customerName || '')
                }},
            auditerStatus: {
                field: 'auditerStatus', title: '审批状态', width: 150, sort: true, hide: false, templet: function (d) {
                    var str = '';
                    switch (d.auditerStatus) {
                        case '0':
                            str = '未提交';
                            break;
                        case '1':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.fromUrl || '') + '" style="color: orange;cursor: pointer;" ' + flowStr + '>报销中</span>';
                            break;
                        case '2':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.fromUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>已报销</span>';
                            break;
                        case '3':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.fromUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>已退回</span>';
                            break;
                        case '4':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.fromUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>退扫</span>';
                            break;
                        case '5':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.fromUrl || '') + '" style="color: red;cursor: pointer;" ' + flowStr + '>驳回</span>';
                            break;
                        case '6':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" formUrl="' + (d.fromUrl || '') + '" style="color: green;cursor: pointer;" ' + flowStr + '>已支付</span>';
                            break;
                    }
                    return str;
                }
            },
            settlementDescription: {field: 'settlementDescription', title: '报销事由', width: 300, sort: true, hide: false, templet: function (d) {
                    return d.plbContractSettle.settlementDescription || ''
                }},
            contractId: {field: 'contractId', title: 'id', width: 150, sort: true, hide: true},


            // settleupYear: {field: 'settleupYear', title: '结算年', width: 100, sort: true, hide: false,templet: function (d) {
            //         return (d.plbContractSettle.settleupYear || '');
            //     }},
            // settleupQuarter: {field: 'settleupQuarter', title: '结算季', width: 100, sort: true, hide: false,templet: function (d) {
            //         return (d.plbContractSettle.settleupQuarter || '');
            //     }},
            // settleupMonth: {field: 'settleupMonth', title: '结算月', width: 100, sort: true, hide: false,templet: function (d) {
            //         return (d.plbContractSettle.settleupMonth || '');
            //     }},

        }

        var TableUIObj = new TableUI('plb_mtl_subsettleup');
        // TableUIObj.init(colShowObj);

        // 初始化左侧项目
        projectLeft();
        // 节点点击事件
        $(document).on('click', '.con_left ul li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var deptId = $(this).attr('deptId');
            tableShow(deptId);
            $('#leftId').attr('deptId', deptId);
        });
        // 上方按钮显示
        table.on('toolbar(tableDemo)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    if ($('#leftId').attr('deptId')) {
                        newOrEdit(0);
                    } else {
                        layer.msg('请选择左侧部门！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var contractIds = ''
                    var flag = false
                    checkStatus.data.forEach(function (v, i) {
                        if (v.auditerStatus != '0') {
                            flag = true
                            return false
                        }
                        contractIds += v.contractId + ','
                    })
                    if (flag) {
                        layer.msg('所选数据已提交，不可删除！', {icon: 0, time: 2000});
                        return false;
                    }
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/plbContractInfo/delContractSettle', {contractIds: contractIds,contractType:'01'}, function (res) {
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
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '12'}, function (res) {
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
                                        subsettleupId: approvalData.subsettleupId,
                                        runId: res.flowRun.runId,
                                        auditerStatus: 1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&contractType=01&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/plbDeptSubsettleup/approvalSubsettleup',
                                        data: submitData,
                                        dataType: 'json',
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
                                }, approvalData);
                            } else {
                                layer.close(loadIndex);
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    break;
                case 'export': // 导出
                    if( $('.export_moudle').is(":visible")){
                        $('.export_moudle').hide()
                    }else {
                        $('.export_moudle').show()
                    }
                    break;
            }
        });
        table.on('tool(tableDemo)', function (obj) {
            contractIds = obj.data.contractId;
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'detail') {
                newOrEdit(4, data)
            } else if (layEvent === 'edit') {
                if (data.auditerStatus != '0') {
                    layer.msg('该数据已提交，不可进行编辑！', {icon: 0, time: 2000});
                    return false;
                }
                newOrEdit(1, data)

            }
        });
        // 监听排序事件
        table.on('sort(tableDemo)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow($('#leftId').attr('deptId'))
            })
        });

        // 预算执行内部加行按钮
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            contractListId: $(this).find('input[name="deptId"]').attr('contractListId'), // 主键
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            deptName: $(this).find('input[name="deptId"]').val(),
                            deptId: $(this).find('input[name="deptId"]').attr('deptId'),
                            totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                            totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                            applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                            amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                            remark: $(this).find('input[name="remark"]').val(),//备注
                            subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId')//主键id
                        }
                        var invoiceNos = '';
                        var invoiceNoStr = '';
                        $(this).find('.invoices_box span').each(function (i, v) {
                            invoiceNos += $(v).attr('fid') + ',';
                            invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
                        });
                        oldDataObj.invoiceNos = invoiceNos;
                        oldDataObj.invoiceNoStr = invoiceNoStr;
                        oldDataArr.push(oldDataObj);
                    });
                    // var addRowData = {
                    //     deptId: $('[name="createUser"]', $('#baseForm')).attr('deptId'),// deptId
                    //     deptName: $('[name="createUser"]', $('#baseForm')).attr('deptName'),//deptName费用承担部门
                    // };
                    oldDataArr.push(addRowData2);
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });
                    break;


            }
        });
        // 预算执行内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.contractListId) {
                    $.get('/plbContractInfo/delContractInfoList', {contractListId: data.contractListId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                        contractListId: $(this).find('input[name="deptId"]').attr('contractListId'), // 主键
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                        cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                        deptName: $(this).find('input[name="deptId"]').val(),
                        deptId: $(this).find('input[name="deptId"]').attr('deptId'),
                        totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                        totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                        applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                        amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                        taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                        remark: $(this).find('input[name="remark"]').val(),//备注
                        subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId')//主键id
                    }
                    var invoiceNos = '';
                    var invoiceNoStr = '';
                    $(this).find('.invoices_box span').each(function (i, v) {
                        invoiceNos += $(v).attr('fid') + ',';
                        invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
                    });
                    oldDataObj.invoiceNos = invoiceNos;
                    oldDataObj.invoiceNoStr = invoiceNoStr;
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });
        // 付款明细内部加行按钮
        table.on('toolbar(paymentTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.pym_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            // paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
                            advanceId: $(this).find('input[name="paymentType"]').attr('advanceId'), // advanceId
                            chargemoneyId: $(this).find('input[name="paymentType"]').attr('chargemoneyId'), // 主键
                            prepaidAmount: '',
                            customerId: '',
                            deductedAmount: $(this).find('input[name="deductedAmount"]').val(),
                            collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                            collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                            advanceNo: $(this).find('input[name="paymentType"]').val(),
                            prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                            prepaidAmount: $(this).find('input[name="prepaidAmount"]').val(),
                            amountDeducted: $(this).find('input[name="amountDeducted"]').val(),
                            amountDeductedAfter: $(this).find('input[name="amountDeductedAfter"]').val(),
                            remark: $(this).find('input[name="remarks"]').val(),
                            subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')//主键id
                        }
                        //收款人
                        var userName = $(this).find('input[name="prepaidAmount"]').val()
                        var $user = $(this).find('input[name="prepaidAmount"]');
                        var userType = $user.attr('userType');
                        if (userType == 2) {
                            oldDataObj.customerName = userName;
                            oldDataObj.customerId = $user.attr('customerId') || '';
                        } else {
                            oldDataObj.collectionUserName = userName;
                            oldDataObj.prepaidAmount = ($user.attr('user_id') || '').replace(/,$/, '');
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    var addRowData = {};
                    oldDataArr.push(addRowData);
                    table.reload('paymentTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });

        window.ppp = function(a,d){
            $('.layui-table-click [name="prepaidAmount"]').val(a)
            $('.layui-table-click [name="prepaidAmount"]').attr('customerId',d.customerId)
            $('.layui-table-click [name="deductedAmount"]').val(d.bankAccount)
            $('.layui-table-click [name="collectionBank"]').val(d.bankOfDepositName)
            $('.layui-table-click [name="collectionBank"]').attr("collectionbankNo",d.bankOfDeposit);
        }

        // 付款明细内部删行操作
        table.on('tool(paymentTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.chargemoneyId) {
                    $.get('/plbContractInfo/delContractChargemoney', {chargemoneyId: data.chargemoneyId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.pym_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        // paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                        // deductedAmount: $(this).find('input[name="deductedAmount"]').val(),//银行账户
                        // collectionBank: $(this).find('[data-field="collectionBank"] .layui-table-cell').text(),//开户行
                        // prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),//收款金额
                        // remarks: $(this).find('input[name="remarks"]').val(),//备注
                        // subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')//主键id
                        // paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
                        advanceId: $(this).find('input[name="paymentType"]').attr('advanceId'), // advanceId
                        chargemoneyId: $(this).find('input[name="paymentType"]').attr('chargemoneyId'), // 主键
                        prepaidAmount: '',
                        customerId: '',
                        deductedAmount: $(this).find('input[name="deductedAmount"]').val(),
                        collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                        collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                        advanceNo: $(this).find('input[name="paymentType"]').val(),
                        prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                        prepaidAmount: $(this).find('input[name="prepaidAmount"]').val(),
                        amountDeducted: $(this).find('input[name="amountDeducted"]').val(),
                        amountDeductedAfter: $(this).find('input[name="amountDeductedAfter"]').val(),
                        remark: $(this).find('input[name="remarks"]').val(),
                        subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')//主键id
                    }
                    //收款人
                    var userName = $(this).find('input[name="prepaidAmount"]').val()
                    var $user = $(this).find('input[name="prepaidAmount"]');
                    var userType = $user.attr('userType');
                    if (userType == 2) {
                        oldDataObj.customerName = userName;
                        oldDataObj.customerId = $user.attr('customerId') || '';
                    } else {
                        oldDataObj.collectionUserName = userName;
                        oldDataObj.prepaidAmount = ($user.attr('user_id') || '').replace(/,$/, '');
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('paymentTable', {
                    data: oldDataArr
                });
            } else if (layEvent === 'choosePay') {
                layer.open({
                    type: 1,
                    title: '选择预付单据',
                    area: ['80%', '80%'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    // content: ['<div class="container" style="padding: 0px 10px">',
                    //     '<table id="paymentTypeTable" lay-filter="paymentTypeTable"></table>',
                    //     '</div>'].join(''),
                    content: ['<div class="container">',
                        '<table id="reimburseNoTable" lay-filter="reimburseNoTable"></table>',
                        '</div>'].join(''),
                    success: function () {
                        var data = []

                        // $.each(dictionaryObj['PAYMENT_METHOD']['object'], function (k, o) {
                        //     var obj = {
                        //         type: k,
                        //         value: o
                        //     }
                        //     data.push(obj);
                        // });
                        // });
                        var tableData=[]
                        $.ajax({
                            url:"/plbContractInfo/getContractAdvance?auditerStatus=2",
                            async:false,
                            success:function(res){
                                if(res.data!=undefined){
                                    tableData=res.data
                                }
                            }
                        })
                        table.render({
                            elem:'#reimburseNoTable',
                            page:true,
                            countName: 'totleNum',
                            data:tableData,
                            page: {
                                limit: 10,
                                limits: [10, 20, 30]
                            },
                            cols:[[
                                {type:'radio'},
                                {field: 'customerId', title: '单据编号', width: 300, sort: true, hide: false, templet: function (d) {
                                        return d.contractNo || ''
                                    }},
                                {field: 'customerId', title: '客商单位名称', width: 300, sort: true, hide: false, templet: function (d) {
                                        return d.customerName || ''
                                    }},
                                {field: 'contractName', title: '合同名称', width: 300, sort: true, hide: false},
                                {field: 'advanceMoney', title: '合同金额', width: 300, sort: true, hide: false,templet: function (d) {
                                        return d.plbContractAdvance.advanceMoney || ''
                                    }},
                                {field: 'prepaidAmount', title: '预付金额', width: 300, sort: true, hide: false},
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
                        })
                        // 获取科目
                        table.render({
                            elem: '#paymentTypeTable',
                            data: data,
                            page: false,
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'value', title: '付款方式'}
                            ]]
                        });
                    },
                    yes: function (index) {
                        table.on('tool(reimburseNoTable)', function (obj) {
                            // console.log(obj)
                        })
                        var checkStatus = table.checkStatus('reimburseNoTable');
                        if (checkStatus.data.length > 0) {
                            var payData = checkStatus.data[0];
                            $.ajax({
                                url: '/plbContractInfo/selectByChargemoney?contractId='+payData.contractId+'',
                                // data:{
                                //     // contractId:payData.contractId
                                //     contractId:112
                                // },
                                dataType: 'json',
                                type: 'post',
                                success: function (res) {
                                    // var plbContractInfoWithBLOBs = res.data.plbContractInfoWithBLOBs;
                                    // if(plbContractInfoWithBLOBs.plbDeptSubpaymentPayments[0].customerName != undefined){
                                    //     $('.chooseCustomerName').val(plbContractInfoWithBLOBs.plbDeptSubpaymentPayments[0].customerName)
                                    // }
                                    // if(plbContractInfoWithBLOBs.contractName != undefined){
                                    //     $('.chooseManagementBudget').val(plbContractInfoWithBLOBs.contractName)
                                    // }
                                    // if(plbContractInfoWithBLOBs.deptContractNo != undefined){
                                    //     $('input[name="deptContractNo"]').val(plbContractInfoWithBLOBs.deptContractNo)
                                    // }
                                    // if(plbContractInfoWithBLOBs.plbContractSettle.contractFee != undefined){
                                    //     $('input[name="contractFee"]').val(plbContractInfoWithBLOBs.plbContractSettle.contractFee)
                                    // }
                                    $tr.find('input[name="paymentType"]').val(res.data.advanceNo);
                                    $tr.find('input[name="prepaidAmount"]').val(res.data.prepaidAmount);
                                    $tr.find('input[name="paymentType"]').attr('advanceId',res.data.advanceId), // advanceId
                                        $tr.find('input[name="deductedAmount"]').val(res.data.deductedAmount);
                                    $tr.find('input[name="amountDeductedAfter"]').val(res.data.amountDeductedAfter);
                                    var b = res.data.prepaidAmount-res.data.deductedAmount
                                    $tr.find('input[name="prepaidBalance"]').val(b);
                                    var a = $tr.find('input[name="amountDeducted"]').val()
                                    var amountDeductedAfter = BigNumber(b).minus(a); // 不含税金额 (调整后金额 - 税额)


                                    $(document).on('click',"#kou",function(){
                                        var a = $tr.find('input[name="amountDeducted"]').val()
                                        if(a != ''){
                                            if(a>b){
                                                layer.msg('本次扣除金额不可大于预付余额')
                                                $tr.find('input[name="amountDeducted"]').val('')
                                            }else {
                                                $tr.find('input[name="amountDeductedAfter"]').val(b-a)
                                            }
                                        }
                                    });
                                }
                            });


                            // $tr.find('input[name="paymentType"]').attr('paymentType', payData.type);

                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                });
            } else if (layEvent === 'chooseCollectionUser') {
                var userIndex = layer.open({
                    title: false,
                    area: ['300px', '200px'],
                    btn: false,
                    content: '<div>' +
                        '<p style="margin-top: 23px;margin-bottom: 30px;text-align: center;"><button class="layui-btn layui-btn-normal" id="selectUser">组织机构内选择</button></p>' +
                        '<p style="text-align: center;"><button class="layui-btn layui-btn-normal" id="selectCustomer">客商内选择</button></p>' +
                        '</div>',
                    success: function () {
                        $('#selectUser').on('click', function () {
                            layer.close(userIndex);
                            user_id = $tr.find('[name="prepaidAmount"]').attr('id');
                            $tr.find('[name="prepaidAmount"]').attr('customerId', '').attr('userType', 1);
                            $.popWindow('/common/selectUser?0');
                        });

                        $('#selectCustomer').on('click', function () {
                            layer.close(userIndex);
                            $tr.find('[name="prepaidAmount"]').attr('user_id', '').attr('userType', 2);
                            layer.open({
                                type: 2,
                                title: '选择收款人',
                                area: ['70%', '80%'],
                                btn:['确定'],
                                maxmin: true,
                                btnAlign: 'c',
                                content: ['/PlbCustomer/payee'].join(''),
                                success: function () {
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
                                                    name: 'typeName',
                                                    children: "child",
                                                }
                                            });
                                        }
                                    });

                                    // 树节点点击事件
                                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                                        $('.mtl_no_data').hide();
                                        $('.mtl_table_box').show();
                                        merchantType = d.data.currentData.typeNo
                                        loadMtlTable(merchantType);
                                    });
                                    function loadMtlTable(merchantType) {
                                        var customerNo = $('[name="customerNo"]', $('#customerQueryForm')).val();
                                        var customerName = $('[name="customerName"]', $('#customerQueryForm')).val();
                                        layTable.render({
                                            elem: '#materialsTable',
                                            url: '/PlbCustomer/getDataByCondition',
                                            where: {
                                                merchantType: merchantType,
                                                customerNo: customerNo,
                                                customerName: customerName
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
                                                {type: 'radio', title: '选择'},
                                                {field: 'customerNo', title: '客商编号', minWidth: 100},
                                                {field: 'customerName', title: '客商单位名称', minWidth: 150},
                                                {field: 'customerShortName', title: '客商单位简称', minWidth: 150},
                                                {field: 'customerOrgCode', title: '组织机构代码', minWidth: 150},
                                                {field: 'taxNumber', title: '税务登记号', minWidth: 150},
                                                {field: 'accountName', title: '开户行名称', minWidth: 150},
                                                {field: 'accountNumber', title: '开户行账户', minWidth: 150}
                                            ]]
                                        });
                                    }
                                    $('#customerQueryBtn').on('click', function () {
                                        loadMtlTable(merchantType)
                                    });
                                },
                                yes: function (index,layero) {
                                    $(layero).find("iframe")[0].contentWindow.yesBtn();
                                }
                            });
                        });
                    }
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
                    TableUIObj.init(colShowObj, function () {
                        tableShow('')
                    });
                }
            });
        }

        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            var currentData = d.data.currentData;
            if (currentData.deptId) {
                $('#leftId').attr('deptId', currentData.deptId);
                $('.no_data').hide();
                $('.table_box').show();
                tableShow(currentData.deptId);
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
        function tableShow(deptId) {
            var cols = [{checkbox: true, fixed: 'left'}].concat(TableUIObj.cols)
            cols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#detailBarDemo',
                title: '操作',
                width: 150
            })
            tableIns = table.render({
                elem: '#tableDemo',
                url: '/plbContractInfo/getContractSettle',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-80',
                page: {
                    limit: TableUIObj.onePageRecoeds,
                    limits: [10, 20, 30, 40, 50]
                },
                where: {
                    deptId: deptId,
                    contractType:'01',
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
                    delete this.where.contractName
                    delete this.where.contractNo
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
            var url = '/plbContractInfo/addGetPlbContractSettle?type=' + type;
            deptId = $('#leftId').attr('deptId');
            // parent.qqq(deptId)
            if (type == '0') {
                title = '新建合同结算';
                // url = '/plbContractInfo/insertContract';
            } else if (type == '1') {
                title = '编辑合同结算';
                // url = '/plbContractInfo/updatePlbMtlSubsettleup';
                url += '&contractId=' + data.contractId + '&settlementPeriod=' + data.settlementPeriod + '&subpaymentId=' +data.subpaymentId;
            } else if (type == 4) {
                title = '查看详情'
                url += '&contractId=' + data.contractId + '&settleupYear=' + data.settleupYear + '&subpaymentId=' + data.subpaymentId;
            }

            iframeLayerIndex = layer.open({
                type: 2,
                title: title,
                area: ['100%', '100%'],
                content: url,
                // end: function () {
                //     if (type != 3) {
                //         reloadTableData();
                //     }
                // }
            });
            // layer.open({
            //     type: 2,
            //     title: title,
            //     area: ['100%', '100%'],
            //     btn: ['保存', '提交', '取消'],
            //     btnAlign: 'c',
            //     content: url,
            //     success: function () {
            //         var shu;
            //         var materialDetailsTableData = [];
            //         var paymentTableData = [];
            //
            //         fileuploadFn('#fileupload', $('#fileContent'));
            //         // 获取当前登录人信息(经办人)
            //         getUserInfo($.cookie('userId'), function (res) {
            //             if (res.object) {
            //                 addRowData2 = {
            //                     deptId: res.object.deptId,
            //                     deptName: res.object.deptName
            //                 };
            //             }
            //         });
            //         getUserInfo('', function (res) {
            //             if (res.object) {
            //                 $('[name="createUser"]', $('#baseForm')).attr('user_id', res.object.userId).val(res.object.userName);
            //                 $('[name="createUser"]', $('#baseForm')).attr('deptId', res.object.deptId).attr('deptName', res.object.deptName);
            //                 initKingDee(res.object.userId)
            //             }
            //         });
            //         // 获取自动编号
            //         getAutoNumber({autoNumber: 'plbContractSettle'}, function (res) {
            //             $('input[name="contractNo"]', $('#baseForm')).val(res);
            //         });
            //         $('.refresh_no_btn').show().on('click', function () {
            //             getAutoNumber({autoNumber: 'plbContractSettle'}, function (res) {
            //                 $('input[name="contractNo"]', $('#baseForm')).val(res);
            //             });
            //         });
            //
            //         // 获取主键
            //         $.get('/plbDeptReimburse/getUUID', function (res) {
            //             subpaymentId = res;
            //             contractIdss = res;
            //         });
            //         $('#yu').hide()
            //         if(type == 1 || type == 4){
            //             $.ajax({
            //                 url: '/plbContractInfo/getContractSettleById?contractId='+contractIds+'',
            //                 dataType: 'json',
            //                 type: 'post',
            //                 async:false,
            //                 success: function (res) {
            //                     // var zi = res.data.plbContractInfoListWithBLOBsList
            //                     // for(var c=0;c<zi.length;c++ ){
            //                     //     asd = res.data.plbContractInfoListWithBLOBsList[c].contractListId
            //                     // }
            //
            //                     // if(res.data.isAdvance == '0'){
            //                     //     // $("[name='isAdvance']").get(0).checked = true
            //                     //     $("[name='isAdvance']").get(0).attr("checked",true);
            //                     // }else{
            //                     //     $("[name='isAdvance']").get(1).attr("checked",true);
            //                     // }
            //                     materialDetailsTableData = res.data.plbContractInfoListWithBLOBsList
            //                     paymentTableData = res.data.plbContractChargemoniesList
            //                     $("input[name='contractFee']").val(res.data.plbContractAdvance.contractFee)
            //                     $("input[name='cumulativeSettledRatio']").val(res.data.plbContractInfoListWithBLOBsList.cumulativeSettledRatio)
            //                     $("input[name='settleupYear']").val(res.data.plbContractSettle.settleupYear)
            //                     $("textarea[name='settlementDescription']").val(res.data.plbContractSettle.settlementDescription)
            //                     // $("input[name='settleupQuarter']").val(res.data.plbContractSettle.settleupQuarter)
            //                     // $("input[name='settleupMonth']").val(res.data.plbContractSettle.settleupMonth)
            //                     if(res.data.plbContractSettle.settleupQuarter != ''){
            //                         $("#settleupQuarter option[value="+res.data.plbContractSettle.settleupQuarter+"]").prop("selected",true);
            //                     }
            //                     if(res.data.plbContractSettle.settleupMonth != ''){
            //                         $("#settleupMonth option[value="+res.data.plbContractSettle.settleupMonth+"]").prop("selected",true);
            //                     }
            //                 }
            //             });
            //         }
            //         form.on('radio(isAdvance)', function(data){
            //             isAdvance = data.value
            //             // console.log(data.value); //被点击的 radio 的 value 值
            //             if(data.value == '1'){
            //                 $('#yu').hide()
            //                 $('#y1u').hide()
            //             }
            //             if(data.value == '0'){
            //                 $('#yu').show()
            //                 $('#y1u').show()
            //             }
            //         });
            //
            //
            //         fileuploadFn('#fileupload', $('#fileContent'));
            //         //回显数据
            //         if (type == 1 || type == 4) {
            //
            //
            //             subsettleupId = data.subsettleupId
            //             form.val("baseForm", data)
            //             // materialDetailsTableData = shu;
            //             // materialDetailsTableData = data.plbContractInfoListWithBLOBsList || [];
            //             // paymentTableData = data.plbDeptSubpaymentPaymentWithBLOBs || [];
            //             $("#settlementPeriod").val(data.settlementPeriod ? data.settlementPeriod : '');
            //             $("#settlementDescription").val(data.plbContractSettle.settlementDescription ? data.plbContractSettle.settlementDescription : '');
            //             // $("#cumulativeSettledRatio").val(data.cumulativeSettledRatio ? data.cumulativeSettledRatio : '/');
            //             //合同金额
            //             // $('.plan_base_info input[name="contractFee"]').val(data.contractFee ? numberFormat(data.contractFee, 2) : '/');
            //             //累计已结算金额
            //             $('.plan_base_info input[name="deptSettleupMoney"]').val(numberFormat(data.deptSettleupMoney, 2) || 0.00);
            //             //本次结算金额
            //             $('.plan_base_info input[name="settleupMoney"]').val(numberFormat(data.plbContractSettle.settleupMoney, 2));
            //             //合同编号
            //             $('.plan_base_info input[name="deptContractNo"]').val(data.deptContractNo);
            //             //结算日期
            //             $('.plan_base_info input[name="settleupDate"]').val(numberFormat(data.plbContractSettle.settleupDate, 2));
            //
            //             //结算期间
            //             $('.plan_base_info input[name="settlementPeriod"]').val(data.plbContractSettle.settlementPeriod);
            //             //结算年
            //             $('.plan_base_info input[name="settleupYear"]').val(numberFormat(data.plbContractSettle.settleupYear, 2));
            //             //结算说明
            //             // $('.plan_base_info textarea[name="settlementDescription"]').val(numberFormat(data.plbContractSettle.settlementDescription, 2));
            //             //合同id
            //             $('.plan_base_info input[name="contractName"]').attr('subcontractId', data.subcontractId || '');
            //             //客商id
            //             $('.plan_base_info input[name="customerName"]').attr('customerId', data.customerId || '');
            //             if (data.attachments && data.attachments.length > 0) {
            //
            //                 var fileArr = data.attachments;
            //                 var str = '';
            //                 for (var i = 0; i < fileArr.length; i++) {
            //                     var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
            //                     var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
            //                     var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
            //                     var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;
            //
            //                     str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
            //                 }
            //                 $('#fileContent').append(str);
            //             }
            //
            //             if(data.subcontractId){
            //                 $.get('/plbDeptSubcontract/queryId',{subContractId:data.subcontractId},function (res) {
            //                     if(res.flag){
            //                         //比价附件
            //                         $('#fileContent2').html(getFileEleStr(res.object.attachment2));
            //                         //合同附件
            //                         $('#fileContent1').html(getFileEleStr(res.object.attachment));
            //                     }
            //                 })
            //             }
            //
            //
            //
            //             if (type == 4) {
            //                 $('.layui-layer-btn-c').hide()
            //                 $('[name="customerName"]').attr('disabled', 'true')
            //                 $('[name="settleupDate"]').attr('disabled', 'true')
            //                 $('[name="contractName"]').attr('disabled', 'true')
            //                 $('[name="settleupMoney"]').attr('disabled', 'true')
            //                 $('[name="remark"]').attr('disabled', 'true')
            //                 $('[name="settleupYear"]').attr('disabled', 'true')
            //                 $('[name="settleupQuarter"]').attr('disabled', 'true')
            //                 $('[name="settleupMonth"]').attr('disabled', 'true')
            //                 $('[name="settlementPeriod"]').attr('disabled', 'true')
            //                 $('[name="settlementDescription"]').attr('disabled', 'true')
            //                 $('.file_upload_box').hide()
            //                 $('.deImgs').hide()
            //                 form.render()
            //             }
            //         } else {
            //
            //         }
            //
            //         element.render();
            //         form.render();
            //         //预算执行明细
            //         var cols = [
            //             {
            //                 field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
            //                     return '<input readonly contractListId="'+(d.contractListId || '')+'" name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input ' + (type == '4' ? '' : 'choose_dept') + '" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + (isShowNull(d.deptName) || '') + '">';
            //                 }
            //             },
            //             {
            //                 field: 'rbsItemId', title: '预算科目名称', minWidth: 100, templet: function (d) {
            //                     return '<input contractId="'+(d.contractId || '')+'" name="rbsItemId" rbsItemId="'+(d.rbsItemId || '')+'"   ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChoose') + '" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.rbsItemName) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'cbsId',
            //                 title: '会计科目名称',
            //                 minWidth: 120,
            //                 templet: function (d) {
            //                     return '<input type="text" name="cbsId" cbsId="' + (d.cbsId || '') + '"   value="' + (d.cbsName || '') + '"  readonly autocomplete="off" class="layui-input ' + (type == '4' ? '' : 'cbsIdChoose') + '" style="height: 100%; cursor: pointer;" >'
            //                 }
            //             },
            //
            //             {
            //                 field: 'totalAnnualBudget',
            //                 title: '年度预算总额',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //                     return '<span class="totalAnnualBudget">' + isShowNull(d.totalAnnualBudget) + '</span>';
            //                 }
            //             },
            //             {
            //                 field: 'totalAnnualBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
            //                     return '<span class="totalAnnualBalance">' + isShowNull(d.totalAnnualBalance) + '</span>';
            //                 }
            //             },
            //             {
            //                 field: 'applicationAmount',
            //                 title: '本次结算金额',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //                     return '<input id="applicationAmount" name="applicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.applicationAmount) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'actualApplicationAmount',
            //                 title: '本次预算执行金额',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //                     return '<input id="actualApplicationAmount" style="background: #e7e7e7""  readonly name="actualApplicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.actualApplicationAmount) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'applicationAmount',
            //                 title: '其中质保金',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //                     return '<input name="applicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.applicationAmount) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'taxAmount',
            //                 title: '税额',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //                     return '<input id="taxAmount" name="taxAmount"  ' + (type == 4 ? 'readonly' : '') + ' type="number" pointFlag="1" class="layui-input input_floatNum taxAmountItem KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'amountExcludingTax',
            //                 title: '不含税金额',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //                     return '<input id="amountExcludingTax" name="amountExcludingTax"  readonly type="number"  class="layui-input input_floatNum KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + isShowNull(d.amountExcludingTax) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
            //                     return '<input name="remark"  ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'invoices',
            //                 title: '发票上传',
            //                 minWidth: 200,
            //                 templet: function (d) {
            //                     var invoiceStr = '';
            //                     if (d.invoiceList) {
            //                         d.invoiceList.forEach(function (item, index) {
            //                             var invoiceInfo = JSON.parse(item.invoiceInfo);
            //                             invoiceStr += '<span class="invoice_file ' + invoiceInfo.serialNo + '" fid="' + invoiceInfo.serialNo + '">' + (invoiceInfo.invoiceNo || ('发票' + (index + 1))) + ',</span>';
            //                         });
            //                     } else if (d.invoiceNoStr) {
            //                         var invoiceNoArr = d.invoiceNoStr.replace(/,$/, '').split(',');
            //                         var fidArr = d.invoiceNos.replace(/,$/, '').split(',');
            //
            //                         for (var i = 0; i < fidArr.length; i++) {
            //                             invoiceStr += '<span class="invoice_file ' + fidArr[i] + '" fid="' + fidArr[i] + '">' + invoiceNoArr[i] + ',</span>';
            //                         }
            //                     }
            //                     var str = '';
            //                     if (type != '4') {
            //                         str = '<a class="choose_invoices"><i class="layui-icon layui-icon-upload-circle"></i></a>'
            //                     }
            //                     return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div>' + str + '</div>';
            //                 }
            //             }
            //         ]
            //         if (type != 4) {
            //             cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
            //         }
            //         table.render({
            //             elem: '#materialDetailsTable',
            //             data: materialDetailsTableData,
            //             toolbar: '#toolbarDemoIn',
            //             defaultToolbar: [''],
            //             limit: 1000,
            //             cols: [cols],
            //             done: function () {
            //                 if (type == 4) {
            //                     $('.addRow').hide()
            //                 }
            //                 $('input[name="deptId"]').each(function (i, v) {
            //                     $(this).attr('id', 'dept_' + i);
            //                 });
            //             }
            //         });
            //         laydate.render({
            //             elem: '#settleupDate' //指定元素
            //             , trigger: 'click' //采用click弹出
            //             , value: data ? format(data.settleupDate) : '',
            //             done: function (value, date, endDate) {
            //                 $('#settleupYear').val(date.year)
            //                 if (date.month < 4) {
            //                     $('[name="settleupQuarter"]').val('1')
            //                 } else if (date.month < 7) {
            //                     $('[name="settleupQuarter"]').val('2')
            //                 } else if (date.month < 10) {
            //                     $('[name="settleupQuarter"]').val('3')
            //                 } else {
            //                     $('[name="settleupQuarter"]').val('4')
            //                 }
            //                 $('[name="settleupMonth"]').val(date.month)
            //                 form.render()
            //             }
            //         });
            //         //日期时间范围
            //         laydate.render({
            //             elem: '#settlementPeriod'
            //             , type: 'datetime'
            //             , range: '~'
            //         });
            //         //日期时间范围
            //         laydate.render({
            //             //结算期间
            //             elem: '#settlementPeriod',
            //             range: '~',
            //             format: 'yyyy-MM-dd',
            //             value: data ? data.settlementPeriod : ''
            //         });
            //
            //         //年选择器
            //         laydate.render({
            //             elem: '#settleupYear'
            //             , type: 'year'
            //             , trigger: 'click' //采用click弹出
            //             , value: data ? data.settleupYear : ''
            //         });
            //
            //         var materialDetailsTableData = [];
            //
            //
            //
            //         //合同付款明细
            //         var cols2 = [
            //             {
            //                 field: 'paymentType',
            //                 title: '预付单据编号',
            //                 event: 'choosePay',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //
            //                     return '<input chargemoneyId='+d.chargemoneyId+' value="' + isShowNull(d.advanceNo) + '" advanceId="' + (d.advanceId || '') + '" type="text" name="paymentType" subpaymentPaymentId="' + (d.subpaymentPaymentId || '') + '" readonly paymentType="' + isShowNull(d.paymentType) + '" class="layui-input" style="height: 100%; cursor: pointer;">';
            //                 }
            //             },
            //             {
            //                 field: 'prepaidAmount',
            //                 title: '预付金额',
            //                 minWidth: 150,
            //                 event: 'chooseCollectionUser1',
            //                 templet: function (d) {
            //                     var str = '';
            //                     var attr = '';
            //                     if (d.prepaidAmount) {
            //                         str = isShowNull(d.prepaidAmount);
            //                         attr = 'prepaidAmount="' + d.prepaidAmount + '" userType="2"';
            //                     } else {
            //                         str = isShowNull(d.collectionUserName).replace(/,$/, '');
            //                         attr = 'user_id="' + (d.prepaidAmount || '') + '" userType="1"';
            //                     }
            //
            //                     return '<input readonly name="prepaidAmount" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
            //                 }
            //             },
            //             {
            //                 field: 'deductedAmount',
            //                 title: '已扣除金额',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //
            //                     return '<input readonly type="text" name="deductedAmount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + function(){
            //                        if(d.deductedAmount == undefined){
            //                            return ''
            //                        } else{
            //                            return d.deductedAmount
            //                         }
            //                     }() + '">';
            //                 }
            //             },
            //             {
            //                 field: 'prepaidBalance',
            //                 title: '预付余额',
            //                 minWidth: 150,
            //                 templet: function (d) {
            //
            //                     return '<input id="prepaidBalance" type="text" name="prepaidBalance" pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.prepaidBalance) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'amountDeducted', title: '本次扣除金额', minWidth: 300, templet: function (d) {
            //
            //                     return '<input lay-filter="amountDeducted" type="text" id="amountDeducted" name="amountDeducted" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountDeducted) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'amountDeductedAfter', title: '扣除后余额', minWidth: 300, templet: function (d) {
            //
            //                     return '<input id="kou" type="text" name="amountDeductedAfter" class="layui-input amountExcludingTax" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountDeductedAfter) + '">';
            //                 }
            //             },
            //             {
            //                 field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
            //
            //                     return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
            //                 }
            //             }
            //         ]
            //         if (type != 4) {
            //             cols2.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
            //         }
            //
            //         table.render({
            //             elem: '#paymentTable',
            //             data: paymentTableData,
            //             toolbar: '#toolbarDemoIn',
            //             defaultToolbar: [''],
            //             limit: 1000,
            //             cols: [cols2],
            //             done: function () {
            //                 if (type == 4) {
            //                     $('.addRow').hide()
            //                 }
            //                 $('input[name="prepaidAmount"]').each(function (i, v) {
            //                     $(v).attr('id', 'prepaidAmount' + i);
            //                 });
            //             }
            //         });
            //         // $(document).on('click', '#applicationAmount', function () {
            //         //     console.log(123123)
            //         // }
            //         $(document).on('keyup', '#taxAmount', function () {
            //             var a =$('#applicationAmount').val()
            //             var b =$('#taxAmount').val()
            //             var c =a-b
            //             $('#amountExcludingTax').val(c);
            //         })
            //         $(document).on('keyup', '#applicationAmount', function () {
            //             var a =$('#applicationAmount').val()
            //             var b =$('#taxAmount').val()
            //             var c =a-b
            //             var e = $("input[name='amountDeducted']")
            //             var d = [];
            //             var sum = 0;
            //             var ppp;
            //             var f;
            //             if($("input[name='amountDeducted']").val() == ''){
            //                 sum = $("input[name='applicationAmount']").val()
            //                 $('#actualApplicationAmount').val(sum)
            //             }else{
            //                 for(var i=0;i<e.length;i++){
            //                     // d = $("input[name='amountDeducted']").eq(i).val()
            //                     // console.log(d)
            //                     // ppp = d.push(",")
            //                     d.push($("input[name='amountDeducted']").eq(i).val())
            //                     sum += parseInt($("input[name='amountDeducted']").eq(i).val())
            //                 }
            //                 $('#actualApplicationAmount').val(a-sum)
            //             }
            //
            //
            //
            //             $('#amountExcludingTax').val(c);
            //         })
            //         $(document).on('keyup', '#amountDeducted', function () {
            //             var a =$('#prepaidBalance').val()
            //             var b =$('#amountDeducted').val()
            //             if(b>a){
            //                 layer.msg('本次结算金额不可大于预算余额')
            //             }else{
            //                 var c =a-b
            //                 $('#kou').val(c);
            //             }
            //
            //         })
            //         //发票上传
            //         $(document).on('click', '.choose_invoices', function () {
            //             if (subpaymentId) {
            //                 var $this = $(this)
            //                 var $ele = $(this).prev();
            //                 var contractNo = $('input[name="contractNo"]', $('#baseForm')).val();
            //                 openPwyWeb(subpaymentId, contractNo, '', $ele, function (data) {
            //                     var $tr = $this.parents('tr');
            //                     var taxAmount = 0; // 税额合计
            //                     var amount = 0; // 不含税金额合计
            //                     var totalAmount = 0; // 含税金额合计
            //                     data.forEach(function (item) {
            //                         taxAmount = BigNumber(item.taxAmount).plus(taxAmount);
            //                         amount = BigNumber(item.amount).plus(amount);
            //                         totalAmount = BigNumber(item.totalAmount).plus(totalAmount);
            //                     });
            //                     $tr.find('.KD_total_amount').val(totalAmount);
            //                     $tr.find('.KD_tax_amount').val(taxAmount);
            //                     $tr.find('.KD_amount').val(amount);
            //
            //
            //                     var $trs = $('.mtl_info').find('.layui-table-main tr');
            //                     var paymentAmount = 0
            //                     $trs.each(function () {
            //                         paymentAmount = accAdd(paymentAmount, $(this).find('input[name="applicationAmount"]').val())
            //                     });
            //                     //重新计算本次支付金额
            //                     $('#baseForm [name="payMoney"]').val(paymentAmount)
            //                 });
            //             }
            //         });
            //     },
            //     yes: function (index) {
            //         //必填项提示
            //         for (var i = 0; i < $('.chen').length; i++) {
            //             if ($('.chen').eq(i).val() == '') {
            //                 layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
            //                 return false
            //             }
            //         }
            //         //提示输入框只能输入数字
            //         for (var a = 0; a < $('.chinese').length; a++) {
            //             if (isNaN($('.chinese').eq(a).val())) {
            //                 layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
            //                 return false
            //             }
            //         }
            //
            //         //判断本次结算金额不得大于合同金额-累计结算金额
            //         var subtrMoney = subtr($('[name="contractFee"]').val(), $('[name="deptSettleupMoney"]').val())
            //         if (($('[name="contractFee"]').val() != '/' && $('[name="contractFee"]').val()) && Number($('[name="settleupMoney"]').val()) > Number(subtrMoney)) {
            //             layer.msg('本次结算金额不得大于合同金额-累计结算金额', {icon: 0});
            //             return false
            //         }
            //
            //         var loadIndex = layer.load();
            //         //材料计划数据
            //         var datas = $('#baseForm').serializeArray();
            //         var datass = $('#baseForm1').serializeArray();
            //         var obj = {}
            //         var plbContractSettle = {}
            //         datas.forEach(function (item) {
            //             obj[item.name] = item.value
            //         });
            //         datass.forEach(function (item) {
            //             plbContractSettle[item.name] = item.value
            //         });
            //         var settleupMoneysss = plbContractSettle.settleupMoney.split('')
            //         for(var a=0;a<settleupMoneysss.length;a++){
            //             if (settleupMoneysss[a] == '.'){
            //                 var settleupMoneys = plbContractSettle.settleupMoney.slice('' ,-3)
            //                 var settleupMoneyss = settleupMoneys.replace(/,/g, "")
            //                 plbContractSettle.settleupMoney = settleupMoneyss
            //             }else{
            //                 plbContractSettle.settleupMoney = plbContractSettle.settleupMoney
            //             }
            //         }
            //
            //         //合同金额
            //         plbContractSettle.contractFee = $('[name="contractFee"]').val() == '/' ? '' : delcommafy($('[name="contractFee"]').val());
            //
            //         plbContractSettle.cumulativeSettledRatio = $('[name="cumulativeSettledRatio"]').val() == '/' ? '' : delcommafy($('[name="cumulativeSettledRatio"]').val());
            //         //累计已结算金额
            //         obj.deptSettleupMoney = delcommafy($('[name="deptSettleupMoney"]').val());
            //         // //本次结算金额
            //         // obj.settleupMoney = delcommafy($('[name="settleupMoney"]').val());
            //         //合同id
            //         obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //         //客商单位名称id
            //         obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');
            //         obj.isAdvance = isAdvance
            //         obj['plbContractSettle'] = plbContractSettle;
            //         // 附件
            //         var attachmentId = '';
            //         var attachmentName = '';
            //         for (var i = 0; i < $('#fileContent .dech').length; i++) {
            //             attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            //             attachmentName += $('#fileContent a').eq(i).attr('name');
            //         }
            //         obj.attachmentId = attachmentId;
            //         obj.attachmentName = attachmentName;
            //         obj.contractType = '01'
            //         obj.deptId = parseInt(deptId);
            //         //预算执行明细数据
            //         var $tr = $('.mtl_info').find('.layui-table-main tr');
            //         var materialDetailsArr = [];
            //         var materialDetailsArrs = [];
            //         $tr.each(function () {
            //             var materialDetailsObj = {
            //                 rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
            //                 cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
            //                 deptId: $(this).find('input[name="deptId"]').attr('deptId'),
            //                 contractListId: $(this).find('input[name="deptId"]').attr('contractlistid'),//主键
            //                 totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
            //                 totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
            //                 applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
            //                 actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),//本次预算执行金额
            //                 amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
            //                 taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
            //                 remark: $(this).find('input[name="remark"]').val(),//备注
            //             }
            //             if ($(this).find('input[name="applicationAmount"]').attr('subpaymentListId')) {
            //                 materialDetailsObj.subpaymentListId = $(this).find('input[name="applicationAmount"]').attr('subpaymentListId');
            //             }
            //             var invoiceNos = '';
            //             var invoiceNoStr = '';
            //             $(this).find('.invoices_box span').each(function (i, v) {
            //                 invoiceNos += $(v).attr('fid') + ',';
            //                 invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
            //             });
            //             materialDetailsObj.invoiceNos = invoiceNos;
            //             materialDetailsObj.invoiceNoStr = invoiceNoStr;
            //             materialDetailsArr.push(materialDetailsObj);
            //         });
            //         $tr.each(function () {
            //             var materialDetailsObjs = {
            //                 // rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
            //                 // cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
            //                 // deptId: $(this).find('input[name="deptId"]').attr('deptId'),
            //                 // totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
            //                 // totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
            //
            //
            //                 paymentType: $('input[name="paymentType"]').val(),//预付单据编号
            //                 chargemoneyid: $(this).find('input[name="paymentType"]').attr('chargemoneyid'),//主键
            //                 prepaidAmount: $('input[name="prepaidAmount"]').val(),//预付金额
            //                 deductedAmount: $('input[name="deductedAmount"]').val(),//以扣除金额
            //                 prepaidBalance: $('input[name="prepaidBalance"]').val(),//预付月
            //                 amountDeductedAfter: $('input[name="amountDeductedAfter"]').val(),//扣除后月
            //                 amountDeducted: $('input[name="amountDeducted"]').val(),//本次扣除金额
            //                 advanceid:$('input[name="paymentType"]').attr('advanceid'),
            //                 remark: $('input[name="remarks"]').val(),//备注
            //             }
            //             // var invoiceNos = '';
            //             // var invoiceNoStr = '';
            //             // $(this).find('.invoices_box span').each(function (i, v) {
            //             //     invoiceNos += $(v).attr('fid') + ',';
            //             //     invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
            //             // });
            //             // materialDetailsObj.invoiceNos = invoiceNos;
            //             // materialDetailsObj.invoiceNoStr = invoiceNoStr;
            //             materialDetailsArrs.push(materialDetailsObjs);
            //         });
            //         obj.plbContractInfoListWithBLOBsList = materialDetailsArr;
            //         obj.plbContractChargemoniesList = materialDetailsArrs
            //
            //         // if(obj.contractFee == '/'){
            //         //     obj.contractFee = ''
            //         // }else{
            //         //     obj.contractFee = obj.contractFee
            //         // }
            //         // if(obj.cumulativeSettledRatio == '/'){
            //         //     obj.cumulativeSettledRatio = ''
            //         // }else{
            //         //     obj.cumulativeSettledRatio = obj.cumulativeSettledRatio
            //         // }
            //         // var zxc = obj.plbContractInfoListWithBLOBsList
            //         // for(var b=0;b<zxc.length;b++){
            //         //     // var asd = obj.plbContractInfoListWithBLOBsList[b].contractListId
            //         //     if(asd != '' && asd != undefined){
            //         //         obj.plbContractInfoListWithBLOBsList[b].contractListId = asd[b]
            //         //     }else{
            //         //
            //         //     }
            //         // }
            //         if(type == 0){
            //             obj.contractId = contractIdss
            //         }
            //         if (type == 1) {
            //             obj.contractId = data.contractId
            //             obj.plbContractInfoListWithBLOBsList.subsettleupId = data.plbContractSettle.subsettleupId
            //
            //         }
            //         $.ajax({
            //             url: url,
            //             data: JSON.stringify(obj),
            //             dataType: 'json',
            //             contentType: "application/json;charset=UTF-8",
            //             type: 'post',
            //             success: function (res) {
            //                 layer.close(loadIndex);
            //                 if (res.flag) {
            //                     layer.msg('保存成功！', {icon: 1});
            //                     layer.close(index);
            //                     tableIns.config.where._ = new Date().getTime();
            //                     tableIns.reload();
            //                 } else {
            //                     layer.msg(res.msg, {icon: 2});
            //                 }
            //             }
            //         });
            //     },
            //     btn2: function (index, layero) {
            //         //必填项提示
            //         for (var i = 0; i < $('.chen').length; i++) {
            //             if ($('.chen').eq(i).val() == '') {
            //                 layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
            //                 return false
            //             }
            //         }
            //         //提示输入框只能输入数字
            //         for (var a = 0; a < $('.chinese').length; a++) {
            //             if (isNaN($('.chinese').eq(a).val())) {
            //                 layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
            //                 return false
            //             }
            //         }
            //
            //         //判断本次结算金额不得大于合同金额-累计结算金额
            //         var subtrMoney = subtr($('[name="contractFee"]').val(), $('[name="deptSettleupMoney"]').val())
            //         if (($('[name="contractFee"]').val() != '/' && $('[name="contractFee"]').val()) && Number($('[name="settleupMoney"]').val()) > Number(subtrMoney)) {
            //             layer.msg('本次结算金额不得大于合同金额-累计结算金额', {icon: 0});
            //             return false
            //         }
            //
            //         var loadIndex = layer.load();
            //         //材料计划数据
            //         var datas = $('#baseForm').serializeArray();
            //         var obj = {}
            //         datas.forEach(function (item) {
            //             obj[item.name] = item.value
            //         });
            //         //合同金额
            //         obj.contractFee = $('[name="contractFee"]').val() == '/' ? '' : delcommafy($('[name="contractFee"]').val());
            //         //累计已结算金额
            //         obj.deptSettleupMoney = delcommafy($('[name="deptSettleupMoney"]').val());
            //         //本次结算金额
            //         obj.settleupMoney = delcommafy($('[name="settleupMoney"]').val());
            //         //合同id
            //         obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //         //客商单位名称id
            //         obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');
            //
            //         // 附件
            //         var attachmentId = '';
            //         var attachmentName = '';
            //         for (var i = 0; i < $('#fileContent .dech').length; i++) {
            //             attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            //             attachmentName += $('#fileContent a').eq(i).attr('name');
            //         }
            //         obj.attachmentId = attachmentId;
            //         obj.attachmentName = attachmentName;
            //
            //         obj.deptId = parseInt(deptId);
            //         if (type == 1) {
            //             obj.subsettleupId = data.subsettleupId
            //         }
            //
            //         if (subsettleupId) {
            //             obj.subsettleupId = subsettleupId
            //         }
            //
            //         $.ajax({
            //             url: url,
            //             data: JSON.stringify(obj),
            //             dataType: 'json',
            //             contentType: "application/json;charset=UTF-8",
            //             type: 'post',
            //             success: function (res) {
            //                 layer.close(loadIndex);
            //                 if (res.flag) {
            //                     $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '12'}, function (res) {
            //                         var flowDataArr = []
            //                         $.each(res.data.flowData, function (k, v) {
            //                             flowDataArr.push({
            //                                 flowId: k,
            //                                 flowName: v
            //                             });
            //                         });
            //
            //                         //合同金额
            //                         obj.contractFee = numberFormat(obj.contractFee, 2)
            //                         //累计已结算金额
            //                         obj.deptSettleupMoney = numberFormat(obj.deptSettleupMoney, 2)
            //                         //本次结算金额
            //                         obj.settleupMoney = numberFormat(obj.settleupMoney, 2)
            //
            //                         if (flowDataArr.length == 1) {
            //                             submitFlow(flowDataArr[0].flowId, obj);
            //                         } else {
            //                             layer.open({
            //                                 type: 1,
            //                                 title: '选择流程',
            //                                 area: ['70%', '80%'],
            //                                 btn: ['确定', '取消'],
            //                                 btnAlign: 'c',
            //                                 content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
            //                                 success: function () {
            //                                     table.render({
            //                                         elem: '#flowTable',
            //                                         data: flowDataArr,
            //                                         cols: [[
            //                                             {type: 'radio'},
            //                                             {field: 'flowName', title: '流程名称'}
            //                                         ]]
            //                                     })
            //                                 },
            //                                 yes: function (index) {
            //                                     var checkStatus = table.checkStatus('flowTable');
            //                                     if (checkStatus.data.length > 0) {
            //                                         var flowData = checkStatus.data[0];
            //
            //                                         submitFlow(flowData.flowId, obj)
            //
            //                                     } else {
            //                                         layer.msg('请选择一项！', {icon: 0});
            //                                     }
            //                                 }
            //                             });
            //                         }
            //                     });
            //                 } else {
            //                     layer.msg(res.msg, {icon: 2});
            //                 }
            //             }
            //         });
            //
            //         return false
            //     }
            // });
        }

        function submitFlow(flowId, approvalData) {
            var loadIndex = layer.load();
            newWorkFlow(flowId, function (res) {
                var submitData = {
                    subsettleupId: approvalData.subsettleupId,
                    runId: res.flowRun.runId,
                    contractId:contractIds,
                    auditerStatus: 1
                }
                $.popWindow("/workflow/work/workform?contractType=1&opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                $.ajax({
                    url: '/plbContractInfo/approvalContract',
                    data: submitData,
                    dataType: 'json',
                    type: 'post',
                    success: function (res) {
                        layer.close(loadIndex);
                        if (res.flag) {
                            layer.closeAll();
                            layer.msg('提交成功!', {icon: 1});
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                        } else {
                            layer.msg(res.msg, {icon: 2});
                        }
                    }
                });
            }, approvalData);
        }
        //选择预算科目名称
        $(document).on('click', '.rbsItemIdChoose', function () {
            var _this = $(this);
            var deptId = _this.parents('tr').find('[name="deptId"]').attr('deptId').replace(/,$/,'')
            if(!deptId){
                layer.msg('请选择费用承担部门！', {icon: 0});
                return false;
            }
            layer.open({
                type: 1,
                title: '选择预算科目名称',
                area: ['60%', '70%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div style="padding: 0px 10px">' +
                '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                '                <div class="layui-col-xs3" style="margin-left: 10px">\n' +
                '                    <input type="text" name="rbsItemName" placeholder="RBS名称" autocomplete="off" class="layui-input">\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                '                    <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                '                </div>\n' +
                '</div>' +
                '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                '</div>'].join(''),
                success: function () {
                    loadMtlTable();

                    function loadMtlTable(rbsItemName) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbDeptBudgetItem/getBudgetItemDataByDeptId',
                            where: {
                                deptId: deptId,
                                rbsItemName: rbsItemName
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'obj'
                            },
                            page: {
                                limit: 10,
                                limits: [10, 20, 30]
                            },
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {
                                    field: 'rbsItemName', title: '预算科目名称', templet: function (d) {
                                        return d.rbsItemName || ''
                                    }
                                },
                                {
                                    field: 'cbsName', title: '会计科目名称', templet: function (d) {
                                        return d.plbCbsType ? d.plbCbsType.cbsName : '';
                                    }
                                },
                                {field: 'budgetMoney', title: '年度预算总额'},
                                {field: 'budgetBalance', title: '年度预算余额'}
                            ]]
                        });
                    }

                    $(document).on('click', '.inSearchData', function () {
                        var rbsItemName = $('.query_module_in [name="rbsItemName"]').val()
                        loadMtlTable(rbsItemName);
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        //预算科目名称
                        _this.val(mtlData.rbsItemName);
                        _this.attr('rbsItemId', mtlData.rbsItemId);
                        //会计科目名称
                        _this.parents('tr').find('[name="cbsId"]').val(mtlData.plbCbsType ? mtlData.plbCbsType.cbsName : '')
                        _this.parents('tr').find('[name="cbsId"]').attr('cbsId', mtlData.cbsId)
                        //年度预算总额
                        _this.parents('tr').find('[data-field="totalAnnualBudget"] .totalAnnualBudget').text(mtlData.budgetMoney)
                        //年度预算余额
                        _this.parents('tr').find('[data-field="totalAnnualBalance"] .totalAnnualBalance').text(mtlData.budgetBalance)

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });

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
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbCbsType/getCbsTypeList',
                            where: {
                                cbsNo: cbsNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-300',
                            cellMinWidth: 100,
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'cbsNo', title: 'CBS编码', width: 200}
                                , {field: 'cbsName', title: 'CBS名称', width: 150}
                                , {
                                    field: 'cbsLevel', title: 'CBS级别', width: 150, templet: function (d) {
                                        return dictionaryObj['CBS_LEVEL']['object'][d.cbsLevel] || ''
                                    }
                                }
                                , {
                                    field: 'cbsUnit', title: 'CBS单位', width: 150, templet: function (d) {
                                        return dictionaryObj['CBS_UNIT']['object'][d.cbsUnit] || ''
                                    }
                                }
                                , {
                                    field: 'controlMode', title: '控制方式', templet: function (d) {
                                        return dictionaryObj['CONTROL_MODE']['object'][d.controlMode] || ''
                                    }
                                },

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
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        _this.val(mtlData.cbsName);
                        _this.attr('cbsId', mtlData.cbsId);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
        //选择客商单位名称
        $(document).on('click', '.chooseCustomerName', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择分包商',
                area: ['70%', '90%'],
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
                    //查询
                    '       <div class="layui-row inSearchContent">' +
                    '             <div class="layui-col-xs4">\n' +
                    '                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                    '             </div>\n' +
                    '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                    '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                    '             </div>\n' +
                    '       </div>' +
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
                    loadMtlTable()
                    function loadMtlType(typeNo) {
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
                        typeNo = typeNo ? typeNo : '';
                        materialsTable = table.render({
                            elem: '#materialsTable',
                            url: '/PlbCustomer/getDataByCondition',
                            where: {
                                merchantType: typeNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            cellMinWidth: 180,
                            height: 'full-300'
                            , toolbar: '#toolbar'
                            , defaultToolbar: [''],
                            cellMinWidth: 150,
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'customerNo', title: '客商编号', width: 200}
                                , {field: 'customerId', title: '客商单位名称', width: 200}
                                , {field: 'customerShortName', title: '客商单位简称', width: 200}
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
                        _this.attr('customerId', mtlData.customerId);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });

        //选择分包商内侧查询
        $(document).on('click', '.inSearchData', function () {
            var searchParams = {}
            var $seachData = $('.inSearchContent [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            materialsTable.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        // 点击选合同
        $(document).on('click', '.chooseManagementBudget', function () {
            if (!$('#baseForm [name="customerName"]').attr('customerId')) {
                layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                return false
            }
            layer.open({
                type: 1,
                title: '选择合同',
                area: ['70%', '60%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-form">' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {
                    table.render({
                        elem: '#mtlPlanIdTable',
                        url: '/plbDeptSubcontract/selectAll',
                        where: {
                            deptId: $('#leftId').attr('deptId'),
                            customerId: $('#baseForm [name="customerName"]').attr('customerId'),
                            auditerStatus: 2//只有审批通过的合同可以选择
                        },
                        page: true,
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {field: 'contractName', title: '合同名称', width: 200,},
                            {
                                field: 'contractType', title: '合同类型', templet: function (d) {
                                    return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || ''
                                }
                            },
                            {
                                field: 'contractPeriod', title: '合同工期',
                            },
                            {field: 'contractMoney', title: '合同金额',},
                            {field: 'deptContractNo', title: '合同编号',},
                        ]],
                        parseData: function (res) { //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "count": res.totleNum, //解析数据长度
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('mtlPlanIdTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];
                        $('#baseForm [name="contractName"]').val(chooseData.contractName)
                        $('#baseForm [name="contractName"]').attr('subcontractId', chooseData.subcontractId)

                        //合同金额
                        $('#baseForm1 [name="contractFee"]').val(chooseData.contractMoney || '/')
                        //累计结算金额
                        $('#baseForm1 [name="deptSettleupMoney"]').val(chooseData.accumulatedSettlatedAmount || 0)
                        //累计结算比例

                        $('#cumulativeSettledRatio').val(chooseData.cumulativeSettledRatio || '/')
                        //合同编号
                        $('#baseForm [name="deptContractNo"]').val(chooseData.subcontractNo)

                        if(chooseData.subcontractId){
                            $.get('/plbDeptSubcontract/queryId',{subContractId:chooseData.subcontractId},function (res) {
                                if(res.flag){
                                    //比价附件
                                    $('#fileContent2').html(getFileEleStr(res.object.attachment2));
                                    //合同附件
                                    $('#fileContent1').html(getFileEleStr(res.object.attachment));
                                }
                            })
                        }

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        });

        //点击查询
        $('.searchData').on('click',function () {
            var searchParams = {}
            searchParams.contractType = '01'
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
        function tJian(){
            $("input[name='contractName']").val('')
            $("input[name='contractNo']").val('')
        }
        /**
         * 新建流程方法
         * @param flowId
         * @param urlParameter
         * @param cb
         */
        function newWorkFlow(flowId, cb, approvalData) {
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

        $(document).on('click', '.preview_flow', function () {
            /*var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId');
            if (flowId && runId) {
                $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
            }*/
            var formUrl = $(this).attr('formUrl')
            if (formUrl) {
                if (formUrl.split('')[0] == '/') {
                    window.open(formUrl)
                } else {
                    window.open('/' + formUrl)
                }
            }
        });

        //减法函数
        function subtr(arg1, arg2) {
            var r1, r2, m, n;
            try {
                r1 = arg1.toString().split(".")[1].length;
            } catch (e) {
                r1 = 0;
            }
            try {
                r2 = arg2.toString().split(".")[1].length;
            } catch (e) {
                r2 = 0;
            }
            m = Math.pow(10, Math.max(r1, r2));
            //last modify by deeka
            //动态控制精度长度
            n = (r1 >= r2) ? r1 : r2;
            return ((arg1 * m - arg2 * m) / m).toFixed(n);
        }

        /*
        * 参数说明：
        * number：要格式化的数字
        * decimals：保留几位小数
        * dec_point：小数点符号
        * thousands_sep：千分位符号
        * roundtag:舍入参数，默认 'ceil' 向上取,'floor'向下取,'round' 四舍五入
        * */
        function numberFormat(number, decimals, decPoint, thousandsSep, roundtag) {

            number = (number + '').replace(/[^0-9+-Ee.]/g, '')
            roundtag = roundtag || 'ceil' // 'ceil','floor','round'
            var n = !isFinite(+number) ? 0 : +number
            var prec = !isFinite(+decimals) ? 0 : Math.abs(decimals)
            var sep = (typeof thousandsSep === 'undefined') ? ',' : thousandsSep
            var dec = (typeof decPoint === 'undefined') ? '.' : decPoint
            var s = ''
            var toFixedFix = function (n, prec) {
                var k = Math.pow(10, prec)

                return '' + parseFloat(Math[roundtag](parseFloat((n * k).toFixed(prec * 2))).toFixed(prec * 2)) / k
            }
            s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.')
            var re = /(-?\d+)(\d{3})/
            while (re.test(s[0])) {
                s[0] = s[0].replace(re, '$1' + sep + '$2')
            }

            if ((s[1] || '').length < prec) {
                s[1] = s[1] || ''
                s[1] += new Array(prec - s[1].length + 1).join('0')
            }
            return s.join(dec)
        }

        //去除千分位
        function delcommafy(num) {
            if ((num + "").trim() == "") {
                return "";
            }
            num = num.replace(/,/gi, '');
            return num;
        }
        // function check(radio){
        //     console.log(radio)
        // }

    });
    //判断是否显示空
    function isShowNull(data) {
        if (!!data) {
            return data
        } else {
            return ''
        }
    }
    /**
     * 选人完成回调
     * @param userId 用户id
     */
    function archives(userId) {
        if (userId) {
            getUserInfo(userId.replace(/,$/, ''), function (res) {
                if (res.object && res.object.userExt) {
                    $tr = $('#' + user_id).parents('tr');
                    $tr.find('input[name="deductedAmount"]').val(res.object.userExt.bankCardNumber || '');
                    $tr.find('.collectionBank').text(res.object.userExt.bankDeposit || '');
                }
            });
        }
    }
    /**
     * 根据用户id获取用户信息
     * @param userId
     * @param callback
     */
    function getUserInfo(userId, callback) {
        $.get('/user/findUserByuserId', {userId: userId}, function (res) {
            callback(res);
        });
    }
    //重选费用承担部门后，清空其余对应信息
    function importLeft() {
        $('#' + dept_id).parents('tr').find('[name="rbsItemId"]').val('')
        $('#' + dept_id).parents('tr').find('[name="rbsItemId"]').attr('rbsItemId', '')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').val('')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').attr('cbsId', '')
        $('#' + dept_id).parents('tr').find('.totalAnnualBudget').text('')
        $('#' + dept_id).parents('tr').find('.totalAnnualBalance').text('')
    }
</script>

</body>
</html>