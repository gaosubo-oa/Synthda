<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/5/27
  Time: 11:18
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
    <title>客商管理详情</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20210803.1"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210527.1"></script>

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
            top: 130px;
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

        .not_necessary {
            display: none;
        }

        .field_required {
            display: inline-block;
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

        .layui-select-disabled .layui-disabled {
            color: #222 !important;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="layui-collapse">
        <form class="layui-form" lay-filter="baseForm" id="baseForm" style="padding: 0px 10px">
            <input type="hidden" name="merchantType" value=""/>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">基本信息</h2>
                <div class="layui-colla-content layui-show">
                    <div class="layui-row">
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">客商编号<span field="customerNo" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text"  readonly name="customerNo" autocomplete="off" class="layui-input"/>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">客商单位名称<span field="customerName" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="customerName" autocomplete="off" class="layui-input"/>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">客商单位简称<span field="customerShortName" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="customerShortName" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">客商类型<span field="supplierType" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <div id="supplierTypeTree" name="supplierType" class="xm-select-demo"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">客户角色<span field="accountRole" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <div id="accountRoleTree" name="accountRole" class="xm-select-demo"></div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">客商来源</label>
                                <div class="layui-input-block form_block">
                                    <%--                                            <select disabled name="customerSource"></select>--%>
                                    <div id="customerSelectTree" name="typeNo" class="xm-select-demo" style="width: 100%;"></div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">统一社会信用代码<span field="customerOrgCode" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="customerOrgCode" placeholder="若个人请录入本人身份证号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">所属集团<span field="customerOrgCode" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="supplierGroupName"  id="supplierGroup" readonly placeholder="请选择集团" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">是否为非合同管理客商<span field="contractCustomers" class="field_required ">*</span></label>
                                <div class="layui-input-block form_block" >
                                    <input type="radio" name="contractCustomers"  lay-filter="contractCustomers"   value="1" title="是">
                                    <input type="radio" name="contractCustomers"   lay-filter="contractCustomers2"value="0" title="否" checked>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="layui-row">
                        <div class="layui-col-xs12" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">资证材料<span field="attachmentId" class="field_required">*</span>（若个人请上传本人身份证扫描件！客商单位请上传营业执照、收款资料等扫描件！）</label>
                                <div class="layui-input-block form_block">
                                    <div class="file_module">
                                        <div id="fileContent" class="file_content"></div>
                                        <div class="file_upload_box">
                                            <a href="javascript:;" class="open_file">
                                                <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
                                                <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">
                                            </a>
                                            <div class="progress">
                                                <div class="bar"></div>
                                            </div>
                                            <div class="bar_text"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-colla-item"  id="contractCustomers">
                <h2 class="layui-colla-title">管理客商</h2>
                <div class="layui-colla-content layui-show" >

                    <div class="layui-row">
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">单位性质<span field="customerNature" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <select  name="customerNature"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">单位类型<span field="customerType" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <select  name="customerType"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">法定代表人<span field="legalPeron" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="legalPeron" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">注册资本（万元）<span field="regCapital" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="number" readonly name="regCapital" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">注册地址<span field="accountAddress" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="accountAddress" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">成立日期<span field="dateEstablishment" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" id="dateEstablishment" readonly name="dateEstablishment" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">营业期限<span field="termOfOperation" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="termOfOperation" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">企业经营状态<span field="managementForms" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="managementForms" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">单位电话<span field="accountTelno" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="accountTelno" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">单位营业地址<span field="businessAddress" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="businessAddress" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">等级状态</label>
                                <div class="layui-input-block form_block">
                                    <select  name="gradeStatus"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">联系人<span field="contactPerson" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="contactPerson" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs3" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">联系电话<span field="contactTelno" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" readonly name="contactTelno" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">经营范围<span field="businessScope" class="field_required not_necessary">*</span></label>
                                <div class="layui-input-block form_block">
                                    <textarea readonly name="businessScope" placeholder="请输入内容" class="layui-textarea"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs6" style="padding: 0 5px">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">备注</label>
                                <div class="layui-input-block form_block">
                                    <textarea readonly name="remarks" placeholder="请输入内容" class="layui-textarea"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">账号信息</h2>
                <div class="layui-colla-content layui-show" id="customerBankTableBox">
                    <table id="customerBankTable" lay-filter="customerBankTable"></table>
                </div>
            </div>
        </form>




    </div>
    <div class="footer" style="text-align:center">
        <button type="button" class="layui-btn layui-btn-normal" id="saveBtn">保存</button>
    </div>
</div>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>
<script>

    var runId = $.GetRequest()['runId'] || '';
    var flowId = $.GetRequest()['flowId'] || '';

    var type = $.GetRequest()['type'] || '';
    var loadIndex = layer.load()
    var disabled = $.GetRequest()['disabled'] || '';
    if(disabled == '0'){

        $('input:not([name="customerNo"])').removeAttr('readonly')
        $('textarea').removeAttr('readonly')

    }else{
        var customerId = $.GetRequest()['customerId'] || '';

        $('input').attr('disabled','true')
        $('select').attr('disabled','true')
        $(' #customerBankTable').attr('disabled','true')

        $('#add').css('display','none')
        $('#saveBtn').css('display','none')

    }
    // 获取数据字典数据
    var dictionaryObj = {
        CUSTOMER_SOURCE: {}, // 客商来源
        CUSTOMER_NATURE: {}, // 单位性质
        CUSTOMER_TYPE: {}, // 单位类别
        SUPPLIER_TYPE: {}, // 客商类型
        ACCOUNT_ROLE: {}, // 客商角色
        GRADE_STATUS: {} // 等级状态
    }
    var dictionaryStr = 'CUSTOMER_SOURCE,CUSTOMER_NATURE,CUSTOMER_TYPE,SUPPLIER_TYPE,ACCOUNT_ROLE,GRADE_STATUS';
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

        // 获取项目信息
        if (runId) {
            $.get('/PlbCustomer/queryByRunId', {runId: runId}, function (res) {
                if (res.flag) {
                    initPage(res.data);
                } else {
                    initPage();
                    layer.msg('获取信息失败!', {icon: 0});
                }

            });
        } else if (customerId) {
            $.get('/PlbCustomer/queryId', {customerId: customerId}, function (res) {
                if (res.flag) {
                    initPage(res.data);
                } else {
                    initPage();
                    layer.msg('获取信息失败!', {icon: 0});
                }
            });
        } else {
            layer.msg('获取信息失败！', {icon: 0});
            initPage();
        }
    });

    function initPage(data) {

        layer.close(loadIndex);
        layui.use(['eleTree','form', 'table', 'element', 'xmSelect','laydate'], function () {
            var table = layui.table,
                form = layui.form,
                element = layui.element,
                xmSelect = layui.xmSelect,
                laydate = layui.laydate,
                eleTree = layui.eleTree;

            var customerSelectTree = null;
            element.render();

            // $('select[name="customerSource"]').html(dictionaryObj['CUSTOMER_SOURCE']['str']);
            $('select[name="customerNature"]').html(dictionaryObj['CUSTOMER_NATURE']['str']);
            $('select[name="customerType"]').html(dictionaryObj['CUSTOMER_TYPE']['str']);
            $('select[name="gradeStatus"]').html(dictionaryObj['GRADE_STATUS']['str']);

            if (data) {

                if(disabled == '0'){
                    /*获取客商来源数据----start*/
                    customerSelectTree = xmSelect.render({
                        el: '#customerSelectTree',
                        content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                            '<input type="text" style="box-sizing: border-box;" class="layui-input" id="customerSelect">' +
                            '</div>' +
                            '<div style="padding-top: 30px;" id="customerTree" class="eleTree" lay-filter="customerTree"></div>',
                        name: 'typeNo',
                        // disabled: true,
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
                        $.get('/PlbCustomerType/treeList',{typeName:typeName},function (res) {
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
                    /*获取客商来源数据----end*/

                    /*region 客商类型 */
                    var supplierTypeData = []

                    $.each(dictionaryObj['SUPPLIER_TYPE']['object'], function (k, v) {
                        var obj = {
                            value: k,
                            name: v
                        }
                        supplierTypeData.push(obj)
                    })

                    var supplierTypeSelect = xmSelect.render({
                        el: '#supplierTypeTree',
                        name: 'supplierType',
                        toolbar: {
                            show: true,
                        },
                        // disabled: true,
                        filterable: true,
                        model: {
                            label: {
                                type: 'text',
                                text: {
                                    separator: '，',
                                },
                            }
                        },
                        data: supplierTypeData
                    });
                    /* endregion */

                    /* region 客户角色 */
                    var accountRoleData = []

                    $.each(dictionaryObj['ACCOUNT_ROLE']['object'], function (k, v) {
                        var obj = {
                            value: k,
                            name: v
                        }
                        accountRoleData.push(obj)
                    })

                    var accountRoleSelect = xmSelect.render({
                        el: '#accountRoleTree',
                        name: 'accountRole',
                        toolbar: {
                            show: true,
                        },
                        // disabled: true,
                        filterable: true,
                        model: {
                            label: {
                                type: 'text',
                                text: {
                                    separator: '，',
                                },
                            }
                        },
                        data: accountRoleData,
                        on: function(data) {
                            var flag = false;
                            //arr:  当前多选已选中的数据
                            var arr = data.arr
                            for (var i = 0; i < arr.length; i++) {
                                if (arr[i].value == '03') {
                                    flag = true
                                    break;
                                }
                            }
                            if (flag) {
                                $('.not_necessary').removeClass('field_required');
                            } else {
                                $('.not_necessary').addClass('field_required');
                            }
                        }
                    });
                    /* endregion */
                    fileuploadFn('#fileupload', $('#fileContent'));
                    form.on('radio(contractCustomers)', function(data){
                        $(' .not_necessarys').hide()
                        $('#contractCustomers').hide()
                    });
                    form.on('radio(contractCustomers2)', function(data){
                        $('#contractCustomers').show()
                        $(' .not_necessarys').show()
                    });
                    var plbCustomerBankList = []

                    laydate.render({
                        elem: '#dateEstablishment'
                    });
                    form.val("baseForm", data);
                    var customerId =data.customerId
                    if(data.contractCustomers==1){
                        $('#contractCustomers').hide()
                    }else if(data.contractCustomers==0){
                        $('#contractCustomers').show()
                    }
                    $('#dateEstablishment').val(format(data.dateEstablishment));

                    if (data.accountRole && data.accountRole.indexOf('03') > -1) {
                        $('.not_necessary').removeClass('field_required');
                    }

                    if (data.supplierType) {
                        var supplierTypeArr = data.supplierType.split(',');
                        supplierTypeSelect.setValue(supplierTypeArr);
                    }

                    if (data.accountRole) {
                        var accountRoleArr = data.accountRole.split(',');
                        accountRoleSelect.setValue(accountRoleArr);
                    }

                    $('#fileContent').html(getFileEleStr(data.attachments, false));

                    plbCustomerBankList = data.plbCustomerBankList || []
                    //回显客商来源
                    var obj = {
                        typeName: data.merchantTypeName,
                        typeNo: data.merchantType
                    }
                    customerSelectTree.setValue([obj]);
                    // 内部加行按钮
                    table.on('toolbar(customerBankTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':

                                // 遍历表格获取每行数据进行保存
                                var $trs = $('#customerBankTableBox').find('.layui-table-main tr');
                                var oldDataArr = []
                                $trs.each(function (i, v) {
                                    var oldDataObj = {
                                        bankId: $(v).find('[name="bankId"]').val(),
                                        accountType: $(v).find('[name="accountType"]').val(),
                                        collectionAccountName:$(v).find('[name="collectionAccountName"]').val(),
                                        bankOfDeposit: $(v).find('[name="bankOfDeposit"]').attr('number'),
                                        bankOfDepositName:$(v).find('[name="bankOfDeposit"]').val(),
                                        bankAccount: $(v).find('[name="bankAccount"]').val(),
                                        index: 'index_' + i
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                oldDataArr.push({
                                    index: 'index_' + $trs.length,
                                    accountType: 0
                                });
                                table.reload('customerBankTable', {
                                    data: oldDataArr
                                });
                                break;
                        }
                    });
                    // 内部删行操作
                    table.on('tool(customerBankTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;

                        if (layEvent === 'del') {
                            obj.del();
                            if (data.bankId) {
                                $.get('/PlbCustomer/delBank', {bankId: data.bankId}, function (res) {

                                });
                            }
                            //遍历表格获取每行数据进行保存
                            var $trs = $('#customerBankTableBox').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $trs.each(function (i, v) {
                                var oldDataObj = {
                                    bankId: $(v).find('[name="bankId"]').val(),
                                    accountType: $(v).find('[name="accountType"]').val(),
                                    collectionAccountName: $(v).find('[name="collectionAccountName"]').val(),
                                    bankOfDepositName: $(v).find('[name="bankOfDeposit"]').val(),
                                    bankOfDeposit: $(v).find('[name="bankOfDeposit"]').attr('number'),
                                    bankAccount: $(v).find('[name="bankAccount"]').val(),
                                    index: 'index_' + i
                                }
                                oldDataArr.push(oldDataObj);
                            });
                            table.reload('customerBankTable', {
                                data: oldDataArr
                            });
                        }
                    });

                    // 初始化客商账号列表
                    table.render({
                        elem: '#customerBankTable',
                        data: plbCustomerBankList,
                        toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'accountType', title: '账户类型<span style="color: #f00;font-size: 16px;">*</span>', width: 200, templet: function (d) {
                                    return '<div id="XM-' + (d.bankId || d.index) + '" ></div><input type="hidden" name="bankId" value="' + isShowNull(d.bankId) + '">';
                                }
                            },
                            {
                                field: 'collectionAccountName', title: '收款账号名<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="collectionAccountName" class="layui-input" value="'+ isShowNull(d.collectionAccountName ||$('#customerName').val())+'" />';
                                }
                            },
                            {
                                field: 'bankOfDepositName', title: '开户行(请填写至分支行)<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 200, templet: function (d) {
                                    return '<input type="text" onclick="popup(this)" readonly="readonly"  id="select" name="bankOfDeposit" class="layui-input" value="' + isShowNull(d.bankOfDepositName) + '" />';
                                }
                            },
                            {
                                field: 'bankAccount', title: '银行账号<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="bankAccount"   class="layui-input" value="' + isShowNull(d.bankAccount) + '" />';
                                }
                            },
                            {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                        ]],
                        done: function(res) {
                            $('#customerBankTableBox .layui-table-cell').each(function (i, v) {
                                v.style.height = 'auto';
                            });

                            //渲染多选
                            res.data.forEach(function (item, index) {
                                var el = item.bankId || ('index_' + index)
                                var xm = xmSelect.render({
                                    el: '#XM-' + el,
                                    radio: true,
                                    clickClose: true,
                                    model: {type: 'fixed'},
                                    name: 'accountType',
                                    data: [
                                        {name: '基本户', value: 0, selected: item.accountType != 1},
                                        {name: '其他户', value: 1, selected: item.accountType == 1}
                                    ]
                                })

                                item.__xm = xm;
                            })
                        }
                    });
                    /**
                     * 获取需要保存的数据
                     * @param saveType (1-保存,2-提交)
                     */
                    function getSaveData(saveType, customerId) {
                        var datas = $('#baseForm').serializeArray().concat($('#baseForms').serializeArray())
                        var dataObj = {}
                        datas.forEach(function (item) {
                            dataObj[item.name] = item.value;
                        });

                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent a').eq(i).attr('name');
                        }
                        dataObj.attachmentId = attachmentId;
                        dataObj.attachmentName = attachmentName;

                        var baseObj = JSON.parse(JSON.stringify(dataObj));

                        //遍历表格获取每行数据进行保存
                        var $trs = $('#customerBankTableBox').find('.layui-table-main tr');
                        var plbCustomerBankList = [];
                        var customerBankFlag = false;
                        if ($trs.length > 0) {
                            $trs.each(function (i, v) {
                                var bankId = $(v).find('[name="bankId"]').val();
                                var oldDataObj = {
                                    accountType: $(v).find('[name="accountType"]').val(),
                                    collectionAccountName: $(v).find('[name="collectionAccountName"]').val(),
                                    bankOfDepositName:$(v).find('[name="bankOfDeposit"]').val(),
                                    bankOfDeposit: $(v).find('[name="bankOfDeposit"]').attr('number'),
                                    bankAccount: $(v).find('[name="bankAccount"]').val()
                                }
                                if (bankId) {
                                    oldDataObj.bankId = bankId
                                }
                                plbCustomerBankList.push(oldDataObj);
                            });
                        }
                        dataObj.plbCustomerBankList = plbCustomerBankList;

                        // 编辑

                        if (saveType != 2) {
                            dataObj.customerId = customerId;
                        }

                        return {
                            dataObj: dataObj,
                            baseObj: baseObj
                        }
                    }
                    /**
                     * 保存的数据
                     */
                    $('#saveBtn').on('click', function() {
                        var loadIndex = layer.load();
                        var baseData = getSaveData(type, customerId).dataObj;
                        baseData.supplierGroup=$('input[name="supplierGroupName"]').attr('supplierGroup')
                        //客商来源
                        baseData.merchantType=customerSelectTree.getValue('valueStr');
                        if (!checkSubmit(baseData)){
                            layer.close(loadIndex)
                            return false
                        }
                        if (!checkSubmit(baseData)){
                            layer.close(loadIndex)
                            return false
                        }

                        $.ajax({
                            url: '/PlbCustomer/insertOrUpdate',
                            data: JSON.stringify(baseData),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            success: function (res) {
                                layer.close(loadIndex);
                                if (res.flag) {
                                    layer.msg('保存成功！', {icon: 1});

                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }

                            }
                        });
                        var newApprovalData = filterSubmitData(baseData);
                        newApprovalData.typeNo=data.merchantTypeName;
                        $.post('/plbContractInfo/updateFlowData',{flowId:flowId,runId:runId,customerId:customerId,approvalData:JSON.stringify(newApprovalData)},function(){

                        })
                    })
                    /**
                     * 提交审批校验数据
                     */
                    function checkSubmit(data) {
                        if (!data['customerNo']) {
                            layer.msg('客商编号不能为空', {icon: 0});
                            return false
                        }
                        if (!data['customerName']) {
                            layer.msg('客商单位名称不能为空', {icon: 0});
                            return false
                        }
                        if (!data['customerShortName']) {
                            layer.msg('客商单位简称不能为空', {icon: 0});
                            return false
                        }
                        if (!data['supplierType']) {
                            layer.msg('客商类型不能为空', {icon: 0});
                            return false
                        }
                        if (!data['accountRole']) {
                            layer.msg('客户角色不能为空', {icon: 0});
                            return false
                        }
                        if (!data['customerOrgCode']) {
                            layer.msg('统一社会信用代码不能为空', {icon: 0});
                            return false
                        }
                        // 如果客户角色不包含个人
                        if (data['accountRole'].indexOf('03') == -1) {
                            if(data.contractCustomers==0){
                                if (!data['customerType']) {
                                    layer.msg('单位类型不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['legalPeron']) {
                                    layer.msg('法定代表人不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['regCapital']) {
                                    layer.msg('注册资本不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['accountAddress']) {
                                    layer.msg('注册地址不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['dateEstablishment']) {
                                    layer.msg('成立日期不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['termOfOperation']) {
                                    layer.msg('营业期限不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['managementForms']) {
                                    layer.msg('企业经营状态不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['accountTelno']) {
                                    layer.msg('单位电话不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['businessAddress']) {
                                    layer.msg('单位营业地址不能为空', {icon: 0});
                                    return false
                                }
                                if (!data['businessScope']) {
                                    layer.msg('经营范围不能为空', {icon: 0});
                                    return false
                                }

                                if (!data['attachmentId']) {
                                    layer.msg('资证材料不能为空', {icon: 0});
                                    return false
                                }
                            }


                        }
                        if(data.contractCustomers==0){
                            if (!data['contactPerson']) {
                                layer.msg('联系人不能为空', {icon: 0});
                                return false
                            }
                            if (!data['contactTelno']) {
                                layer.msg('联系电话不能为空', {icon: 0});
                                return false
                            }
                        }



                        if (!data['plbCustomerBankList'] || data['plbCustomerBankList'].length == 0) {
                            layer.msg('请添加至少一条账号信息！', {icon: 0})
                            return false
                        } else {
                            var list = data['plbCustomerBankList']
                            for (var i = 0; i < list.length; i++) {
                                if (!list[i]['accountType'] && list[i]['accountType'] != '0') {
                                    layer.msg('账号信息列表第' + (i + 1) + '行，账户类型不能为空', {icon: 0})
                                    return false
                                }
                                if (!list[i]['collectionAccountName']) {
                                    layer.msg('账号信息列表第' + (i + 1) + '行，收款帐户号不能为空', {icon: 0});
                                    return false
                                }
                                if (!list[i]['bankOfDepositName']) {
                                    layer.msg('账号信息列表第' + (i + 1) + '行，开户行不能为空', {icon: 0});
                                    return false
                                }

                                if (!list[i]['bankAccount']) {
                                    layer.msg('账号信息列表第' + (i + 1) + '行，银行账号不能为空', {icon: 0});
                                    return false
                                }
                            }
                        }
                        return true
                    }

                }else{
                    /*获取客商来源数据----start*/
                    customerSelectTree = xmSelect.render({
                        el: '#customerSelectTree',
                        content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
                            '<input type="text" style="box-sizing: border-box;" class="layui-input" id="customerSelect">' +
                            '</div>' +
                            '<div style="padding-top: 30px;" id="customerTree" class="eleTree" lay-filter="customerTree"></div>',
                        name: 'typeNo',
                        disabled: true,
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
                        $.get('/PlbCustomerType/treeList',{typeName:typeName},function (res) {
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
                    /*获取客商来源数据----end*/

                    /*region 客商类型 */
                    var supplierTypeData = []

                    $.each(dictionaryObj['SUPPLIER_TYPE']['object'], function (k, v) {
                        var obj = {
                            value: k,
                            name: v
                        }
                        supplierTypeData.push(obj)
                    })

                    var supplierTypeSelect = xmSelect.render({
                        el: '#supplierTypeTree',
                        name: 'supplierType',
                        toolbar: {
                            show: true,
                        },
                        disabled: true,
                        filterable: true,
                        model: {
                            label: {
                                type: 'text',
                                text: {
                                    separator: '，',
                                },
                            }
                        },
                        data: supplierTypeData
                    });
                    /* endregion */

                    /* region 客户角色 */
                    var accountRoleData = []

                    $.each(dictionaryObj['ACCOUNT_ROLE']['object'], function (k, v) {
                        var obj = {
                            value: k,
                            name: v
                        }
                        accountRoleData.push(obj)
                    })

                    var accountRoleSelect = xmSelect.render({
                        el: '#accountRoleTree',
                        name: 'accountRole',
                        toolbar: {
                            show: true,
                        },
                        disabled: true,
                        filterable: true,
                        model: {
                            label: {
                                type: 'text',
                                text: {
                                    separator: '，',
                                },
                            }
                        },
                        data: accountRoleData,
                        on: function(data) {
                            var flag = false;
                            //arr:  当前多选已选中的数据
                            var arr = data.arr
                            for (var i = 0; i < arr.length; i++) {
                                if (arr[i].value == '03') {
                                    flag = true
                                    break;
                                }
                            }
                            if (flag) {
                                $('.not_necessary').removeClass('field_required');
                            } else {
                                $('.not_necessary').addClass('field_required');
                            }
                        }
                    });
                    /* endregion */
                    var plbCustomerBankList = []

                    form.val("baseForm", data);
                    if(data.contractCustomers==1){
                        $('#contractCustomers').hide()
                    }else if(data.contractCustomers==0){
                        $('#contractCustomers').show()
                    }
                    $('#dateEstablishment').val(format(data.dateEstablishment));

                    if (data.accountRole && data.accountRole.indexOf('03') > -1) {
                        $('.not_necessary').removeClass('field_required');
                    }

                    if (data.supplierType) {
                        var supplierTypeArr = data.supplierType.split(',');
                        supplierTypeSelect.setValue(supplierTypeArr);
                    }

                    if (data.accountRole) {
                        var accountRoleArr = data.accountRole.split(',');
                        accountRoleSelect.setValue(accountRoleArr);
                    }

                    $('#fileContent').html(getFileEleStr(data.attachments, false));

                    plbCustomerBankList = data.plbCustomerBankList || []
                    //回显客商来源
                    var obj = {
                        typeName: data.merchantTypeName,
                        typeNo: data.merchantType
                    }
                    customerSelectTree.setValue([obj]);
                    // 初始化客商账号列表
                    table.render({
                        elem: '#customerBankTable',
                        data: plbCustomerBankList,
                        toolbar: false,
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'accountType', title: '账户类型<span style="color: #f00;font-size: 16px;">*</span>', width: 200, templet: function (d) {
                                    var str = '';
                                    if (d.accountType == 1) {
                                        str = '基本户';
                                    } else {
                                        str = '其他户';
                                    }
                                    return str;
                                }
                            },
                            {
                                field: 'bankOfDepositName', title: '开户行(请填写至分支行)<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 200
                            },
                            {
                                field: 'bankAccount', title: '银行账号<span style="color: #f00;font-size: 16px;">*</span>', minWidth: 120
                            }
                        ]]
                    });
                }


            }

            form.render();
        });
    }
    function filterSubmitData(data) {
        var newData = JSON.parse(JSON.stringify(data))
        // 客商类型 数据字典
        if (newData['supplierType']) {
            var arr = newData['supplierType'].split(',')
            var newArr = []
            arr.forEach(function(item) {
                newArr.push(dictionaryObj['SUPPLIER_TYPE']['object'][item])
            })
            newData['supplierType'] = newArr.join(',')
        }
        // 客户角色 数据字典
        if (newData['accountRole']) {
            var arr = newData['accountRole'].split(',')
            var newArr = []
            arr.forEach(function(item) {
                newArr.push(dictionaryObj['ACCOUNT_ROLE']['object'][item])
            })
            newData['accountRole'] = newArr.join(',')
        }
        // 客商来源 数据字典
        if (newData['customerSource']) {
            newData['customerSource'] = dictionaryObj['CUSTOMER_SOURCE']['object'][newData['customerSource']] || ''
        }
        // 单位性质 数据字典
        if (newData['customerNature']) {
            newData['customerNature'] = dictionaryObj['CUSTOMER_NATURE']['object'][newData['customerNature']] || ''
        }
        // 单位类型 数据字典
        if (newData['customerType']) {
            newData['customerType'] = dictionaryObj['CUSTOMER_TYPE']['object'][newData['customerType']] || ''
        }
        // 等级状态 数据字典
        if (newData['gradeStatus']) {
            newData['gradeStatus'] = dictionaryObj['GRADE_STATUS']['object'][newData['gradeStatus']] || ''
        }
        return newData
    }

    var name;
    var number;
    window.ppp = function(bankName, bankNumber){
        name = bankName;
        number = bankNumber;

    }
    function popup (_this){
        layer.open({
            type: 2,
            title:'选择开户行',
            area: ['61%', '82%'],
            btn: ['确定', '返回'],
            content:'/plbBank/getBankDropDown'
            ,success: function(layero,index){
                layer.iframeAuto(index)
            }
            ,yes:function(index){
                $(_this).val(name);
                $(_this).attr('number', number);
                layer.close(index);
            }
        })
    }
</script>
<script type="text/javascript" src="/js/editIEprint/index.js?20210811.2"></script>
</body>
</html>

