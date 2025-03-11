<%--
  Created by IntelliJ IDEA.
  User: 吴祖明
  Date: 2021/5/8
  Time: 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>合同管理表单操作</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
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

        body .demo-class .layui-layer-btn1 {
            border-color: #FFB800;
            background-color: #FFB800;
            color: #fff;
        }

        .layui-table-view .layui-form-checkbox, .layui-table-view .layui-form-radio, .layui-table-view .layui-form-switch {
            position: absolute;
            top: 16px;
            left: 16px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="wrapper">
        <div class="content"></div>
        <div style="text-align: center;margin-top: 35px;">
            <button class="layui-btn layui-btn-normal" id="save">保存</button>
        </div>
    </div>
</div>

</body>
<script>
    var flowId = $.GetRequest()['flowId'] || '';
    var runId = $.GetRequest()['runId'] || '';
    var disabled = $.GetRequest()['disabled'] || '';
    var xhr = null;
    initBaseHtml()
    var dictionaryObj = {
        CONTRACT_TYPE: {},
        PAYMENT_METHOD: {},
        TAX_RATE: {},
        INVOICE_TYPE: {},
    }
    var dictionaryStr = 'CONTRACT_TYPE,PAYMENT_METHOD,TAX_RATE,INVOICE_TYPE';
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
        if (runId != null) {
            $.get('/plbDeptSubcontract/queryByRunId', {runId: runId}, function (res) {
                if (res.flag) {
                    initPage(res.object);
                } else {
                    layer.msg('获取信息失败！', {icon: 2});
                }
            });
        }
    });

    function initPage(contractInfo) {
        layui.use(['form', 'table', 'element', 'laydate', 'eleTree','xmSelect'], function () {
            var layTable = layui.table,
                element = layui.element,
                laydate = layui.laydate,
                layForm = layui.form,
                xmSelect = layui.xmSelect,
                table = layui.table,
                eleTree = layui.eleTree;
            var materialsTable = null

            $('.plan_base_info input[name="contractName"]').attr('subcontractId', contractInfo.subcontractId)

            if(contractInfo){
                customerSelectTree = xmSelect.render({
                    el: '#customerSelectTree',
                    content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                        '<input type="text" style="box-sizing: border-box;" class="layui-input" id="customerSelect">' +
                        '</div>' +
                        '<div style="padding-top: 30px;" id="customerTree" class="eleTree" lay-filter="customerTree"></div>',
                    name: 'contractType',
                    prop: {
                        name: 'typeName',
                        value: 'typeNo'
                    }
                });

                var customerSearchTimer = null;
                $('#customerSelect').on('input propertychange', function () {
                    clearTimeout(customerSearchTimer);
                    customerSearchTimer = null;
                    var val = $(this).val();
                    customerSearchTimer = setTimeout(function () {
                        initCustomerTree(val)
                    }, 300)
                });

                initCustomerTree();

                function initCustomerTree (typeName) {
                    var customerTreeData = []
                    $.get('/plbDeptSubcontract/treeList',function (res) {
                        customerTreeData = res.data;
                        eleTree.render({
                            elem: '#customerTree',
                            data: customerTreeData,
                            highlightCurrent: true,
                            showLine: true,
                            defaultExpandAll: false,
                            accordion: true,
                            request: {
                                name: 'typeName',
                                children: "child"
                            }
                        });
                    });
                }

                // 树节点点击事件
                eleTree.on("nodeClick(customerTree)", function (d) {
                    var currentData = d.data.currentData;
                    var obj = {
                        typeName: currentData.typeName,
                        typeNo: currentData.typeNo
                    }
                    customerSelectTree.setValue([obj]);
                });

            }
            element.render();

            //合同有效期
            laydate.render({
                elem: '[name="contractPeriod"]',
                range: '~',
                value: contractInfo ? contractInfo.contractPeriod : ''
            });

            //付款方式、合同类型、税率、发票类型
            $('[name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str'])
            // $('[name="contractType"]').html(dictionaryObj['CONTRACT_TYPE']['str'])
            $('[name="taxRate"]').append(dictionaryObj['TAX_RATE']['str'])
            $('[name="invoiceType"]').append(dictionaryObj['INVOICE_TYPE']['str'])


            fileuploadFn('#fileupload', $('#fileContent'));
            fileuploadFn('#fileupload2', $('#fileContent2'));

            layForm.val("formTest", contractInfo);
            var obj = {
                typeName:  contractInfo.contractTypeName,
                typeNo:  contractInfo.contractType
            }
            customerSelectTree.setValue([obj]);
            $('[name="contractA"]').val(contractInfo.contractAName || '')
            $('[name="contractA"]').attr('customerId', contractInfo.contractA || '')
            $('[name="customerId"]').val(contractInfo.customerName || '')
            $('[name="customerId"]').attr('customerId', contractInfo.customerId || '')
            //合同附件
            if (contractInfo.attachment && contractInfo.attachment.length > 0) {
                var fileArr = contractInfo.attachment;
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
            //比价附件
            if (contractInfo.attachment2 && contractInfo.attachment2.length > 0) {
                var fileArr = contractInfo.attachment2;
                var str = '';
                for (var i = 0; i < fileArr.length; i++) {
                    var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                    var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                    str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                }
                $('#fileContent2').append(str);
            }

            laydate.render({
                elem: '#signDate' //指定元素
                , trigger: 'click' //采用click弹出
                , value: contractInfo ? format(contractInfo.signDate) : ''
            });


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
                        // loadMtlTable();
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
                            var loading = layer.load(1)
                            if(xhr){
                                xhr.abort()
                            }
                            typeNo = typeNo ? typeNo : '';
                            xhr = $.ajax({
                                url: '/PlbCustomer/getDataByCondition',
                                data:{
                                    merchantType: typeNo,
                                    useFlag: true
                                },
                                success:function(res){
                                    layer.close(loading)
                                    materialsTable = table.render({
                                        elem: '#materialsTable',
                                        data:res.data,
                                        page: true, //开启分页
                                        limit: 50,
                                        cellMinWidth: 180,
                                        height: 'full-300'
                                        , toolbar: '#toolbar'
                                        , defaultToolbar: ['']
                                        ,
                                        cols: [[ //表头
                                            {type: 'radio'}
                                            , {field: 'customerNo', title: '客商编号', width: 200}
                                            , {field: 'customerName', title: '客商单位名称', width: 200}
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
                            })
                        }
                        // function loadMtlTable(typeNo) {
                        //     typeNo = typeNo ? typeNo : '';
                        //     materialsTable = layTable.render({
                        //         elem: '#materialsTable',
                        //         url: '/PlbCustomer/getDataByCondition',
                        //         where: {
                        //             merchantType: typeNo,
                        //             useFlag: true
                        //         },
                        //         page: true, //开启分页
                        //         limit: 50,
                        //         cellMinWidth: 180,
                        //         height: 'full-300'
                        //         , toolbar: '#toolbar'
                        //         , defaultToolbar: ['']
                        //         ,
                        //         cols: [[ //表头
                        //             {type: 'radio'}
                        //             , {field: 'customerNo', title: '客商编号', width: 200}
                        //             , {field: 'customerName', title: '客商单位名称', width: 200}
                        //             , {field: 'customerShortName', title: '客商单位简称', width: 200}
                        //             , {field: 'customerOrgCode', title: '组织机构代码'}
                        //             , {field: 'taxNumber', title: '税务登记号'}
                        //             , {field: 'accountNumber', title: '开户行账户'}
                        //         ]], parseData: function (res) {
                        //             return {
                        //                 "code": 0, //解析接口状态
                        //                 "data": res.data,//解析数据列表
                        //                 "count": res.totleNum, //解析数据长度
                        //             };
                        //         },
                        //         request: {
                        //             pageName: 'page' //页码的参数名称，默认：page
                        //             , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        //         },
                        //     });
                        // }
                    },
                    yes: function (index) {
                        var checkStatus = layTable.checkStatus('materialsTable');
                        if (checkStatus.data.length > 0) {
                            var mtlData = checkStatus.data[0];
                            if(mtlData.auditerStatus!='2'){
                                layer.msg('该客商未批准，请进行审批',{icon:0})
                                return
                            }
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
                var loading = layer.load(1)
                var searchParams = {}
                var $seachData = $('.inSearchContent [name]')
                $seachData.each(function () {
                    searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                })
                xhr = $.ajax({
                    url: '/PlbCustomer/getDataByCondition',
                    data:searchParams,
                    success:function(res){
                        layer.close(loading)
                        materialsTable.reload({
                            data:res.data,
                        });
                    }
                })
            });

            if (disabled == '1') {
                $('.wrapper [name]').each(function () {
                    $(this).attr('disabled', true)
                })
                layForm.render()
                $('.file_upload_box').hide()
                $('.deImgs').hide()
                $('#save').hide()
            }

        })
    }

    // 点击保存
    $('#save').on('click', function () {
        //必填项提示
        for (var i = 0; i < $('.testNull').length; i++) {
            if ($('.testNull').eq(i).val() == '') {
                layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                return false
            }
        }
        //提示输入框只能输入数字
        for (var a = 0; a < $('.chinese').length; a++) {
            if (isNaN($('.chinese').eq(a).val())) {
                layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                return false
            }
        }

        var loadIndex = layer.load();
        //合同数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });
        obj.contractA = $('[name="contractA"]').attr('customerId')
        obj.customerId = $('[name="customerId"]').attr('customerId')

        // 合同附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;

        // 比价附件
        var attachmentId2 = '';
        var attachmentName2 = '';
        for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
            attachmentId2 += $('#fileContent2 .dech').eq(i).find('input').val();
            attachmentName2 += $('#fileContent2 a').eq(i).attr('name');
        }
        obj.attachmentId2 = attachmentId2;
        obj.attachmentName2 = attachmentName2;


        obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId')

        $.ajax({
            url: '/plbDeptSubcontract/update',
            data: JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});

                    obj.contractA = $('[name="contractA"]').val()
                    obj.customerId = $('[name="customerId"]').val()
                    $.post('/plbDeptReimburse/updateFlowData', {
                        flowId: flowId,
                        runId: runId,
                        subcontractType: 1,// 合同管理1，合同结算2，合同付款3
                        subcontract: obj.subcontractId,
                        approvalData: JSON.stringify(obj)
                    }, function (res) {

                    });
                } else {
                    layer.msg('保存失败！', {icon: 2});
                }
            }
        });
    });


    function initBaseHtml() {
        var str = '';
        str = ['<div class="layui-collapse">\n',
            /* region 材料计划 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">合同</h2>\n' +
            '    <div class="layui-colla-content layui-show plan_base_info">' +
            '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
            /* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            /*'                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="subcontractNo" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="合同编号">\n' +
            '                       </div>\n' +
            '                   </div>' +*/
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同编号<span class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="subcontractNo" autocomplete="off" class="layui-input testNull" title="合同编号">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同名称<span class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="contractName" autocomplete="off" class="layui-input testNull" title="合同名称">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同金额(元)</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="contractMoney" autocomplete="off" class="layui-input  chinese" title="合同金额(元)">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">履约金比例</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="bondRatio" autocomplete="off" class="layui-input" title="履约金比例">\n' +
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
            '                       <input type="text" name="warrantyRatio" autocomplete="off" class="layui-input" title="质保金比例">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">甲方<span class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="contractA" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent testNull" title="甲方">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">乙方<span class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerId" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent testNull" title="乙方">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">发票类型</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                        <select name="invoiceType"></select>' +
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
            '                       <label class="layui-form-label form_label">合同类型</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '<div id="customerSelectTree" name="contractType"  class="xm-select-demo" style="width: 100%;"></div>' +
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
            '                       <label class="layui-form-label form_label">合同有效期</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="contractPeriod" readonly autocomplete="off" class="layui-input" title="合同有效期">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">预付款(元)</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="paymentPre" autocomplete="off" class="layui-input" title="预付款(元)">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">税率</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <select name="taxRate"><option value=""></option></select>' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第六行*/
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">不含税合同价(元)</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="contractMoneyNotax" autocomplete="off" class="layui-input chinese" title="不含税合同价(元)">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">押金比例</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="depositRatio"   autocomplete="off" class="layui-input chinese" title="押金比例">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">履约保证金(元)</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="bondCash" autocomplete="off" class="layui-input  chinese" title="履约保证金(元)">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '            </div>' +
            /* endregion */
            /* region 第六行*/
            '           <div class="layui-row">' +
            '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">\n' +
            '  <ul class="layui-tab-title">\n' +
            '    <li class="layui-this">合同内容</li>\n' +
            '    <li>付款条件</li>\n' +
            '  </ul>\n' +
            '  <div class="layui-tab-content">' +
            '       <div class="layui-tab-item layui-show"><textarea name="contractContent" placeholder="请输入内容" class="layui-textarea"></textarea></div>\n' +
            '       <div class="layui-tab-item"><textarea name="paymentCondition"  placeholder="请输入内容" class="layui-textarea"></textarea></div>' +
            '</div>\n' +
            '</div> ' +
            '            </div>' +
            /* endregion */
            /* region 第七行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">比价附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '<div class="file_module">' +
            '<div id="fileContent2" class="file_content"></div>' +
            '<div class="file_upload_box">' +
            '<a href="javascript:;" class="open_file">' +
            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
            '<input type="file" multiple id="fileupload2" data-url="/upload?module=planbudget" name="file">' +
            '</a>' +
            '<div class="progress">' +
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
            /* region 第八行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '<div class="file_module">' +
            '<div id="fileContent" class="file_content"></div>' +
            '<div class="file_upload_box">' +
            '<a href="javascript:;" class="open_file">' +
            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
            '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
            '</a>' +
            '<div class="progress">' +
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
            /* endregion */
            '</div>'].join('')
        $('.content').html(str);
    }

    //附件上传 方法
    var timer = null;

    function fileuploadFn(formId, element) {
        $(formId).fileupload({
            dataType: 'json',
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                element.siblings('.file_upload_box').find('.progress').find('.bar').css(
                    'width',
                    progress + '%'
                );
                element.siblings('.barText').html(progress + '%');
                if (progress >= 100) {  //判断滚动条到100%清除定时器
                    timer = setTimeout(function () {
                        element.siblings('.file_upload_box').find('.progress').find('.bar').css(
                            'width',
                            0 + '%'
                        );
                        element.siblings('.file_upload_box').find('.barText').html('');
                    }, 2000);

                }
            },
            done: function (e, data) {
                if (data.result.obj != '') {
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') { //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!', {}, function () {
                                layer.closeAll();
                            });
                        } else {
                            var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;

                            str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    element.append(str);
                } else {
                    layer.alert('添加附件大小不能为空!', {}, function (index) {
                        layer.close(index);
                    });
                }
            }
        });
    }
</script>
<script type="text/javascript" src="/js/editIEprint/index.js?20210811.2"></script>
</html>
