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
    <title>合同付款表单操作</title>

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
            position: absolute;
            top: 0;
            left: 0;
            bottom: 60px;
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            overflow: auto;
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

        .invoices_module {
            position: relative;
            padding-right: 20px;
        }

        .invoices_box {
            overflow: hidden;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .choose_invoices {
            position: absolute;
            top: 0;
            right: 0;
            color: #00a1d6 !important;
            cursor: pointer;
        }

        .invoices_box:hover {
            color: #0A5FA2;
            cursor: pointer;
        }

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .footer {
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            height: 60px;
            line-height: 60px;
            text-align: center;
            background-color: #fff;
        }
    </style>
</head>
<body>
<div style="height: 0px;">
    <object id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0"
            viewastext></object>
</div>
<div class="container">
    <div class="wrapper">

    </div>
    <div class="footer">
        <button type="button" class="layui-btn layui-btn-normal" id="save">保存</button>
        <button type="button" class="layui-btn layui-btn-warm" id="reSubmitBtn" style="display: none;">提交</button>
    </div>
</div>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>
    var flowId = $.GetRequest()['flowId'] || '';
    var runId = $.GetRequest()['runId'] || '';
    var prcsId = $.GetRequest()['prcsId'] || '';
    var disabled = $.GetRequest()['disabled'] || '';
    var reimburseStatus = '';
    var subpaymentId = '';
    var dictionaryObj = {
        CONTROL_MODE: {},
        CBS_UNIT: {},
        PAYMENT_METHOD: {},
        RBS_TYPE: {},
        RBS_CATEGORY: {},
        CBS_LEVEL: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,PAYMENT_METHOD,RBS_TYPE,RBS_CATEGORY,CBS_LEVEL';
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

    layui.use(['form', 'laydate', 'element', 'table', 'eleTree'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var element = layui.element;
        var table = layui.table;
        var eleTree = layui.eleTree;
        var materialsTable = null
        var collectionUserTable = null

        var str = ['<div class="layui-collapse">\n',
            /* region 合同付款 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">单据编号</h2>\n' +
            '    <div class="layui-colla-content layui-show plan_base_info">' +
            '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
            /* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">单据编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="subpaymentNo" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="单据编号">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">客商单位名称</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerName" autocomplete="off" readonly style="cursor: pointer;background: #e7e7e7" class="layui-input chooseCustomerName" title="客商单位名称">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同名称</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
            '                       <input type="text" name="contractName" placeholder="查找合同" readonly autocomplete="off" class="layui-input ' + (type == 4 ? '' : 'chooseSubcontract') + '" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +

            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同金额（元）</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="contractMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">累计已结算金额（元）</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="accumulatedSettlatedAmount" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">累计已结算比例</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="cumulativeSettledRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">累计已支付金额（元）</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="accumulatedAmountPaid" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">累计已支付比例</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="cumulativePaidProportion" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">本次结算金额（元）</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="currentSettlementAmount" readonly style="background: #e7e7e7;display: inline-block;width: 73%" autocomplete="off" class="layui-input">\n' +
            '                     <button type="button" class="layui-btn  layui-btn-sm chooseSettlement">选择结算单</button>' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">本次支付金额（元）</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="payMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">付款事由</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="paymentReason" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">款项性质</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="naturePayment" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同付款条件</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <textarea name="paymentCondition" readonly style="background: #e7e7e7" class="layui-textarea"></textarea>' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;display: none">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">经办人</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="createUser" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;display: none">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">是否分摊</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            ' 						<input type="radio" name="ifShare" value="1" title="是">' +
            '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;display: none">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">预算执行明细</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="budgetDetails" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;display: none">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">付款明细</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="payDetails" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">比价附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent2" class="file_content"></div>' +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>'+
            /* endregion */
            /* region 第五行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">合同附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent1" class="file_content"></div>' +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>'+
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">结算合同附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent3" class="file_content"></div>' +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>'+
            /* endregion */
            /* region 第七行 */
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
            '           </div>',
            /* endregion */
            '       </form>' +
            '    </div>\n' +
            '  </div>\n',
            /* endregion */
            /* region 预算执行明细 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">预算执行明细</h2>\n' +
            '    <div class="layui-colla-content mtl_info layui-show">' +
            '       <div>' +
            '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
            '      </div>' +
            '    </div>\n' +
            '  </div>\n' +
            /* endregion */
            /* region 合同付款明细 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">付款明细</h2>\n' +
            '    <div class="layui-colla-content pym_info layui-show">' +
            '       <div>' +
            '           <table id="paymentTable" lay-filter="paymentTable"></table>' +
            '      </div>' +
            '    </div>\n' +
            '  </div>\n' +
            /* endregion */
            '</div>'].join('');
        $('.wrapper').html(str)
        element.render();
        fileuploadFn('#fileupload', $('#fileContent'));

        //回显数据
        $.get('/plbDeptSubpayment/queryByRunId', {runId: runId}, function (res) {
            if (res.flag) {
                var data = res.data
                form.val("formTest", data);
                if (data.relationImageUrl) {
                    $('#baseForm').parent().append('<button class="layui-btn layui-btn-sm" id="preview">查看发票</button>');
                    $('#preview').on('click', function () {
                        window.open(data.relationImageUrl + '&userId=' + data.createUser);
                    });
                }
                reimburseStatus = data.reimburseStatus
                if (data.reimburseStatus == '4') {
                    $('#reSubmitBtn').show();
                }
                // 获取当前登录人信息(经办人)
                getUserInfo('', function (res) {
                    if (res.object) {
                        $('[name="createUser"]', $('#baseForm')).attr('user_id', res.object.userId).val(res.object.userName);
                        $('[name="createUser"]', $('#baseForm')).attr('deptId', res.object.deptId).attr('deptName', res.object.deptName);
                    }
                });

                //回显是否分摊
                $('input[name="ifShare"]').each(function () {
                    if ($(this).val() == data.ifShare) {
                        $(this).prop('checked', 'checked')
                        form.render()
                    }
                })
                var materialDetailsTableData = data.plbDeptSubpaymentListWithBLOBs || [];
                var paymentTableData = data.plbDeptSubpaymentPaymentWithBLOBs || [];
                // 客商单位id
                $('.plan_base_info input[name="customerName"]').attr('customerId', data.customerId || '');
                // 合同id
                $('.plan_base_info input[name="contractName"]').attr('subcontractId', data.subcontractId || '');
                //结算id
                $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId', data.subsettleupId || '');
                //部门id
                $('.plan_base_info input[name="contractName"]').attr('deptId', data.deptId || '');
                //主键id
                $('.plan_base_info input[name="contractName"]').attr('subpaymentId', data.subpaymentId || '');
                subpaymentId = data.subpaymentId


                $('.plan_base_info input[name="contractMoney"]').val(data.contractMoney ? keepTwoDecimalFull(data.contractMoney) : '/');
                $('.plan_base_info input[name="accumulatedSettlatedAmount"]').val(keepTwoDecimalFull(data.accumulatedSettlatedAmount));
                $('.plan_base_info input[name="accumulatedAmountPaid"]').val(keepTwoDecimalFull(data.accumulatedAmountPaid));
                $('.plan_base_info input[name="currentSettlementAmount"]').val(keepTwoDecimalFull(data.currentSettlementAmount));
                $('.plan_base_info input[name="payMoney"]').val(keepTwoDecimalFull(data.payMoney));

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


                if(data.subcontractId){
                    $.get('/plbDeptSubcontract/queryId',{subContractId:data.subcontractId},function (res) {
                        if(res.flag){
                            //比价附件
                            $('#fileContent2').html(getFileEleStr(res.object.attachment2));
                            //合同附件
                            $('#fileContent1').html(getFileEleStr(res.object.attachment));
                        }
                    })
                }
                if(data.subsettleupId){
                    $.get('/plbDeptSubsettleup/queryId',{subsettleupId:data.subsettleupId},function (res) {
                        if(res.flag){
                            //结算合同附件
                            $('#fileContent3').html(getFileEleStr(res.data.attachments));
                        }
                    })
                }

                //预算执行明细
                var cols = [
                    {type: 'numbers', title: '序号'},
                    {
                        field: 'rbsItemId',
                        title: '预算科目名称',
                        minWidth: 120,
                        templet: function (d) {
                            return '<input type="text" name="rbsItemId"  rbsItemId="' + (d.rbsItemId || '') + '"  value="' + (d.rbsItemName || '') + '"  readonly autocomplete="off" class="layui-input ' + (disabled == '1' ? '' : 'rbsItemIdChoose') + '" style="height: 100%;cursor: pointer;" >'
                        }
                    },
                    {
                        field: 'cbsId',
                        title: '会计科目名称',
                        minWidth: 120,
                        templet: function (d) {
                            return '<input type="text" name="cbsId" cbsId="' + (d.cbsId || '') + '"   value="' + (d.cbsName || '') + '"  readonly autocomplete="off" class="layui-input ' + (disabled == '1' ? '' : 'cbsIdChoose') + '" style="height: 100%; cursor: pointer;" >'
                        }
                    },
                    {
                        field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                            return '<input readonly name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input ' + (disabled == '1' ? '' : 'choose_dept') + '" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.deptName) + '">';
                        }
                    },
                    {
                        field: 'totalAnnualBudget',
                        title: '年度预算总额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<span class="totalAnnualBudget">' + isShowNull(d.totalAnnualBudget) + '</span>';
                        }
                    },
                    {
                        field: 'totalAnnualBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
                            return '<span class="totalAnnualBalance">' + isShowNull(d.totalAnnualBalance) + '</span>';
                        }
                    },
                    {
                        field: 'applicationAmount',
                        title: '本次申请金额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input name="applicationAmount"  ' + (disabled == '1' ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text"  pointFlag="1"  class="layui-input input_floatNum outMoneyItem  KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.applicationAmount) + '">';
                        }
                    },
                    {
                        field: 'taxAmount',
                        title: '税额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input name="taxAmount"  ' + (disabled == '1' ? 'readonly' : '') + ' type="number"  pointFlag="1" class="layui-input input_floatNum taxAmountItem  KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
                        }
                    },
                    {
                        field: 'amountExcludingTax',
                        title: '不含税金额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input name="amountExcludingTax"  readonly type="number"  class="layui-input input_floatNum  KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + isShowNull(d.amountExcludingTax) + '">';
                        }
                    },
                    {
                        field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                            return '<input name="remark"  ' + (disabled == '1' ? 'readonly' : '') + ' type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                        }
                    },
                    {
                        field: 'invoices',
                        title: '发票上传',
                        minWidth: 200,
                        templet: function (d) {
                            var invoiceStr = '';
                            if (d.invoiceList) {
                                d.invoiceList.forEach(function (item, index) {
                                    var invoiceInfo = JSON.parse(item.invoiceInfo);
                                    invoiceStr += '<span class="invoice_file ' + invoiceInfo.serialNo + '" fid="' + invoiceInfo.serialNo + '">' + (invoiceInfo.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                                });
                            } else if (d.invoiceNoStr) {
                                var invoiceNoArr = d.invoiceNoStr.replace(/,$/, '').split(',');
                                var fidArr = d.invoiceNos.replace(/,$/, '').split(',');

                                for (var i = 0; i < fidArr.length; i++) {
                                    invoiceStr += '<span class="invoice_file ' + fidArr[i] + '" fid="' + fidArr[i] + '">' + invoiceNoArr[i] + ',</span>';
                                }
                            }
                            var str = '';
                            if (disabled != '1') {
                                str = '<a class="choose_invoices"><i class="layui-icon layui-icon-upload-circle"></i></a>'
                            }
                            return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div>' + str + '</div>';
                        }
                    }
                ]
                if (disabled == '0') {
                    cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
                }

                table.render({
                    elem: '#materialDetailsTable',
                    data: materialDetailsTableData,
                    toolbar: '#toolbarDemoIn',
                    defaultToolbar: [''],
                    limit: 1000,
                    cols: [cols],
                    done: function () {
                        if (disabled == '1') {
                            $('.addRow').hide()
                        }
                        $('input[name="deptId"]').each(function (i, v) {
                            $(this).attr('id', 'dept_' + i);
                        });
                    }
                });

                //合同付款明细
                var cols2 = [
                    {type: 'numbers', title: '序号'},
                    {
                        field: 'paymentType',
                        title: '付款方式',
                        event: disabled == '1' ? '' : 'choosePay',
                        minWidth: 150,
                        templet: function (d) {
                            var str = dictionaryObj['PAYMENT_METHOD']['object'][d.paymentType] || '';
                            return '<input type="text" name="paymentType" readonly paymentType="' + (d.paymentType || '') + '" subpaymentPaymentId="' + (d.subpaymentPaymentId || '') + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                        }
                    },
                    {
                        field: 'collectionUser',
                        title: '收款人',
                        minWidth: 150,
                        event: disabled == '1' ? '' : 'chooseCollectionUser',
                        templet: function (d) {
                            var str = '';
                            var attr = '';
                            if (d.customerId) {
                                str = isShowNull(d.customerName);
                                attr = 'customerId="' + d.customerId + '" userType="2"';
                            } else {
                                str = isShowNull(d.collectionUserName).replace(/,$/, '');
                                attr = 'user_id="' + (d.collectionUser || '') + '" userType="1"';
                            }
                            return '<input readonly name="collectionUser" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                        }
                    },
                    {
                        field: 'collectionAccount',
                        title: '银行账号',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input type="text"  ' + (disabled == '1' ? 'readonly' : '') + ' name="collectionAccount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionAccount) + '">';
                        }
                    },
                    {
                        field: 'collectionBank',
                        title: '开户行',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input readonly type="text"  name="collectionBank" collectionBankNo="' + d.collectionBank + '" class="layui-input collectionBank" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.collectionBankName).replace(/,$/, '') + '">';
                            //return '<span class="collectionBank">' + isShowNull(d.collectionBank) + '</span>';
                        }
                    },
                    {
                        field: 'collectionMoney',
                        title: '收款金额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input type="text"  ' + (disabled == '1' ? 'readonly' : '') + ' name="collectionMoney" pointFlag="1"  class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionMoney) + '">';
                        }
                    },
                    {
                        field: 'remarks', title: '备注', minWidth: 300, templet: function (d) {
                            return '<input type="text"  ' + (disabled == '1' ? 'readonly' : '') + ' name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remarks) + '">';
                        }
                    }
                ]
                if (disabled == '0') {
                    cols2.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
                }

                table.render({
                    elem: '#paymentTable',
                    data: paymentTableData,
                    toolbar: '#toolbarDemoIn',
                    defaultToolbar: [''],
                    limit: 1000,
                    cols: [cols2],
                    done: function () {
                        if (disabled == '1') {
                            $('.addRow').hide()
                            $('.file_upload_box').hide()
                            $('.deImgs').hide()
                            $('[name="paymentReason"]').attr('disabled', true)
                            $('[name="naturePayment"]').attr('disabled', true)
                            $('#save').hide()
                            $('#reSubmitBtn').hide()
                            $('.chooseSettlement').hide()
                        }
                        $('input[name="collectionUser"]').each(function (i, v) {
                            $(v).attr('id', 'collectionUser' + i);
                        });
                    }
                });
            } else {
                layer.msg('获取信息失败！', {icon: 2});
            }
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
                    var addRowData = {
                        deptId: $('[name="createUser"]', $('#baseForm')).attr('deptId'),// deptId
                        deptName: $('[name="createUser"]', $('#baseForm')).attr('deptName'),//deptName费用承担部门
                    };
                    oldDataArr.push(addRowData);
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });


                    /* layer.open({
                         type: 1,
                         title: '选择RBS',
                         area: ['60%', '70%'],
                         maxmin: true,
                         btn: ['确定', '取消'],
                         btnAlign: 'c',
                         content: ['<div style="padding: 0px 10px">' +
                         '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                         '                <div class="layui-col-xs3">\n' +
                         '                    <input type="text" name="cbsName" placeholder="CBS名称" autocomplete="off" class="layui-input">\n' +
                         '                </div>\n' +
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

                             function loadMtlTable(cbsName, rbsItemName) {
                                 table.render({
                                     elem: '#materialsTable',
                                     url: '/plbDeptBudgetItem/getBudgetItemDataByDeptId',
                                     where: {
                                         deptId: $('.plan_base_info input[name="contractName"]').attr('deptId'),
                                         cbsName: cbsName,
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
                                         {type: 'checkbox', title: '选择'},
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
                                 var cbsName = $('.query_module_in [name="cbsName"]').val()
                                 var rbsItemName = $('.query_module_in [name="rbsItemName"]').val()
                                 loadMtlTable(cbsName, rbsItemName);
                             });
                         },
                         yes: function (index) {
                             var checkStatus = table.checkStatus('materialsTable');
                             if (checkStatus.data.length > 0) {
                                 var trData = checkStatus.data;

                                 //遍历表格获取每行数据进行保存
                                 var $tr = $('.mtl_info').find('.layui-table-main tr');
                                 var oldDataArr = [];
                                 $tr.each(function () {
                                     var oldDataObj = {
                                         rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
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
                                 /!*var addRowData = {};
                                 oldDataArr.push(addRowData);*!/
                                 //具体明细可多选
                                 trData.forEach(function (item) {
                                     var addRowData = {
                                         rbsItemId: item.rbsItemId,//rbsId
                                         rbsItemName: item.rbsItemName || '',//rbs名称
                                         cbsId: item.cbsId,// cbsId
                                         cbsName: item.plbCbsType ? item.plbCbsType.cbsName : '',//cbs名称
                                         deptId: $('[name="createUser"]', $('#baseForm')).attr('deptId'),// deptId
                                         deptName: $('[name="createUser"]', $('#baseForm')).attr('deptName'),//deptName费用承担部门
                                         totalAnnualBudget: item.budgetMoney,// 年度预算总额
                                         totalAnnualBalance: item.budgetBalance,// 年度预算余额
                                     }
                                     oldDataArr.push(addRowData)
                                 })
                                 table.reload('materialDetailsTable', {
                                     data: oldDataArr
                                 });

                                 layer.close(index);
                             } else {
                                 layer.msg('请选择一项！', {icon: 0});
                             }
                         }
                     });*/
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
                if (data.subpaymentListId) {
                    $.get('/plbDeptSubpayment/delPlbMtlSubpaymentList', {subpaymentListIds: data.subpaymentListId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
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
                            paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                            collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                            collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                            collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                            collectionMoney: $(this).find('input[name="collectionMoney"]').val(),//收款金额
                            remarks: $(this).find('input[name="remarks"]').val(),//备注
                            subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')//主键id
                        }
                        //收款人
                        var userName = $(this).find('input[name="collectionUser"]').val()
                        var $user = $(this).find('input[name="collectionUser"]');
                        var userType = $user.attr('userType');
                        if (userType == 2) {
                            oldDataObj.customerName = userName;
                            oldDataObj.customerId = $user.attr('customerId') || '';
                        } else {
                            oldDataObj.collectionUserName = userName;
                            oldDataObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
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
        // 付款明细内部删行操作
        table.on('tool(paymentTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del();
                if (data.subpaymentPaymentId) {
                    $.get('/plbDeptSubpayment/delPlbMtlSubpaymentPayment', {subpaymentPaymentIds: data.subpaymentPaymentId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.pym_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                        collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                        collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                        collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                        collectionMoney: $(this).find('input[name="collectionMoney"]').val(),//收款金额
                        remarks: $(this).find('input[name="remarks"]').val(),//备注
                        subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')//主键id
                    }
                    //收款人
                    var userName = $(this).find('input[name="collectionUser"]').val()
                    var $user = $(this).find('input[name="collectionUser"]');
                    var userType = $user.attr('userType');
                    if (userType == 2) {
                        oldDataObj.customerName = userName;
                        oldDataObj.customerId = $user.attr('customerId') || '';
                    } else {
                        oldDataObj.collectionUserName = userName;
                        oldDataObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('paymentTable', {
                    data: oldDataArr
                });
            } else if (layEvent === 'choosePay') {
                layer.open({
                    type: 1,
                    title: '选择付款方式',
                    area: ['400px', '500px'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="container" style="padding: 0px 10px">',
                        '<table id="paymentTypeTable" lay-filter="paymentTypeTable"></table>',
                        '</div>'].join(''),
                    success: function () {
                        var data = []

                        $.each(dictionaryObj['PAYMENT_METHOD']['object'], function (k, o) {
                            var obj = {
                                type: k,
                                value: o
                            }
                            data.push(obj);
                        });

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
                        var checkStatus = table.checkStatus('paymentTypeTable');
                        if (checkStatus.data.length > 0) {
                            var payData = checkStatus.data[0];

                            $tr.find('input[name="paymentType"]').val(payData.value);
                            $tr.find('input[name="paymentType"]').attr('paymentType', payData.type);

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
                            user_id = $tr.find('[name="collectionUser"]').attr('id');
                            $tr.find('[name="collectionUser"]').attr('customerId', '').attr('userType', 1);
                            $.popWindow('/common/selectUser?0');
                        });

                        $('#selectCustomer').on('click', function () {
                            layer.close(userIndex);
                            $tr.find('[name="collectionUser"]').attr('user_id', '').attr('userType', 2);
                            layer.open({
                                type: 1,
                                title: '选择收款人',
                                area: ['70%', '80%'],
                                maxmin: true,
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: ['<div class="container">',
                                    '<div class="wrapper">',
                                    '<div class="wrap_left" style="border-right: 1px solid #ccc;">' +
                                    '<div class="layui-form">' +
                                    '<div class="tree_module" style="top: 0;">' +
                                    '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>',
                                    '<div class="wrap_right" style="padding-left: 10px;">' +
                                    '<div class="mtl_table_box" style="display: none;">' +
                                    //查询
                                    '       <div class="layui-row inSearchCollectionUserContent">' +
                                    '             <div class="layui-col-xs4">\n' +
                                    '                  <input type="text" name="customerNo" placeholder="客商编号" autocomplete="off" class="layui-input">\n' +
                                    '             </div>\n' +
                                    '             <div class="layui-col-xs4" style="margin-left: 10px">\n' +
                                    '                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                                    '             </div>\n' +
                                    '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                                    '                   <button type="button" class="layui-btn layui-btn-sm inSearchCollectionUser">查询</button>\n' +
                                    '             </div>\n' +
                                    '       </div>' +
                                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                                    '</div>' +
                                    '<div class="mtl_no_data" style="text-align: center;">' +
                                    '<div class="no_data_img" style="margin-top:12%;">' +
                                    '<img style="margin-top: 2%;" src="/img/noData.png">' +
                                    '</div>' +
                                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
                                    '</div>' +
                                    '</div>',
                                    '</div></div>'].join(''),
                                success: function () {
                                    $('.tree_module').height($(window).height() - 300)
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
                                        loadMtlTable(d.data.currentData.typeNo);
                                    });
                                    loadMtlTable()

                                    function loadMtlTable(merchantType) {
                                        merchantType = merchantType ? merchantType : '';
                                        collectionUserTable = table.render({
                                            elem: '#materialsTable',
                                            url: '/PlbCustomer/getDataByCondition',
                                            where: {
                                                merchantType: merchantType
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
                                },
                                yes: function (index) {
                                    var checkStatus = table.checkStatus('materialsTable');
                                    if (checkStatus.data.length > 0) {
                                        var mtlData = checkStatus.data[0];
                                        if(mtlData.plbCustomerBankList != undefined){
                                            if (mtlData.plbCustomerBankList.length > 0) {
                                                var selectBank=layer.open({
                                                    type: 1,
                                                    title: '选择银行账户',
                                                    shade: 0.3,
                                                    area: ['650px', '400px'],
                                                    content: '<table id="selectBank" lay-filter="selectBank"></table>',
                                                    btn: ['确定'],
                                                    btnAlign:'c',
                                                    success: function () {
                                                        table.render({
                                                            elem:'#selectBank',
                                                            data:mtlData.plbCustomerBankList,
                                                            page:true,
                                                            cols:[[
                                                                {type:'radio'},
                                                                {field:'accountType',title:'账号类型',templet:function(d){
                                                                        if(d.accountType==0){
                                                                            return  '<span name="accountType" customerId='+d.customerId+' customerName='+mtlData.customerName+'>基本户</span>'
                                                                        }else{
                                                                            return  '<span name="accountType" customerId='+d.customerId+' customerName='+mtlData.customerName+'>其他户</span>'
                                                                        }
                                                                    }
                                                                },
                                                                {field:'bankAccount',title:'银行账号'},
                                                                {field:'bankOfDepositName',title:'开户行'},
                                                                {field:'bankOfDeposit',title:'银行行号'}
                                                            ]]
                                                        })
                                                    },
                                                    yes: function () {
                                                        var selectBankData = layui.table.checkStatus('selectBank').data[0];
                                                        if(selectBankData!=undefined){
                                                            $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                                            $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                                            $tr.find('[name="collectionAccount"]').val(selectBankData.bankAccount);
                                                            $tr.find('.collectionBank').attr('collectionBankNo',selectBankData.bankOfDeposit);
                                                            $tr.find('.collectionBank').val(selectBankData.bankOfDepositName)
                                                            layer.close(selectBank);
                                                            layer.close(index);
                                                        }else{
                                                            layer.msg('请选择一项！',{icon:0});
                                                        }

                                                    }
                                                })
                                                // var selectBank = layer.open({
                                                //     type: 1,
                                                //     title: '选择银行账户',
                                                //     shade: 0.3,
                                                //     area: ['650px', '400px'],
                                                //     content: '<table id="selectBank" lay-filter="selectBank">\n' +
                                                //         '  <thead>\n' +
                                                //         '    <tr>\n' +
                                                //         '      <th lay-data="{type:\'radio\'}">选择</th>\n' +
                                                //         '      <th lay-data="{field:\'accountType\', width:100}">账户类型</th>\n' +
                                                //         '      <th lay-data="{field:\'bankOfDepositName\', width:150, sort:true}">开户行</th>\n' +
                                                //         '      <th lay-data="{field:\'bankOfDeposit\', width:150, sort:true}">银行行号</th>\n' +
                                                //         '      <th lay-data="{field:\'bankAccount\', width:346}">银行账号</th>\n' +
                                                //         '    </tr> \n' +
                                                //         '  </thead>\n' +
                                                //         function () {
                                                //             var str = '';
                                                //             for (var i = 0; i < mtlData.plbCustomerBankList.length; i++) {
                                                //                 str += '<tr>\n' +
                                                //                     '      <td><input type="radio" name="selectBankName" value="' + i + '"></td>' +
                                                //                     '      <td>' + function () {
                                                //                         if (mtlData.plbCustomerBankList[i].accountType == 0) {
                                                //                             return '基本户'
                                                //                         } else {
                                                //                             return '其他户'
                                                //                         }
                                                //                     }() + '</td>\n' +
                                                //                     '      <td>' + mtlData.plbCustomerBankList[i].bankOfDeposit + '</td>\n' +
                                                //                     '      <td>' + mtlData.plbCustomerBankList[i].bankOfDepositName + '</td>\n'+
                                                //                     '      <td>' + mtlData.plbCustomerBankList[i].bankAccount + '</td>\n' +
                                                //                     '    </tr>'
                                                //             }
                                                //             return str
                                                //         }() +
                                                //         '  <tbody>\n' +
                                                //         '  </tbody>\n' +
                                                //         '</table>',
                                                //     btn: ['确定'],
                                                //     success: function () {
                                                //         //转换静态表格
                                                //         layui.table.init('selectBank', {
                                                //             limit: mtlData.plbCustomerBankList.length
                                                //         });
                                                //     },
                                                //     yes: function () {
                                                //         var selectBankData = layui.table.checkStatus('selectBank').data[0];
                                                //         $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                                //         $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                                //         $tr.find('[name="collectionAccount"]').val(selectBankData.bankAccount);
                                                //         $tr.find('.collectionBank').attr('collectionBank',selectBankData.bankOfDeposit);
                                                //         $tr.find('.collectionBank').val(selectBankData.bankOfDepositName)
                                                //         layer.close(selectBank);
                                                //         layer.close(index);
                                                //     }
                                                // })
                                            } else {
                                                $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                                $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                                $tr.find('[name="collectionAccount"]').val('');
                                                // $tr.find('.collectionBank').text('');
                                                $tr.find('.collectionBank').val('');
                                                layer.close(index);
                                            }
                                        }else{
                                            $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                            $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                            $tr.find('[name="collectionAccount"]').val('');
                                            // $tr.find('.collectionBank').text('');
                                            $tr.find('.collectionBank').val('');
                                            layer.close(index);
                                        }

                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        });
                    }
                });
            }
        });

        //选择收款人内侧查询
        $(document).on('click', '.inSearchCollectionUser', function () {
            var searchParams = {}
            var $seachData = $('.inSearchCollectionUserContent [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            collectionUserTable.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        //选择客商单位名称
        $(document).on('click', '.chooseCustomerName', function () {
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
                    '                   <button type="button" class="layui-btn layui-btn-sm inSearchDataCustomer">查询</button>\n' +
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
                    $('.tree_module').height($(window).height() - 300)
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
        $(document).on('click', '.inSearchDataCustomer', function () {
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
        $(document).on('click', '.chooseSubcontract', function () {
            if (!$('#baseForm [name="customerName"]').attr('customerId')) {
                layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                return false
            }
            layer.open({
                type: 1,
                title: '选择合同',
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
                        url: '/plbDeptSubcontract/selectAll',
                        where: {
                            deptId: $('.plan_base_info input[name="contractName"]').attr('deptId'),
                            customerId: $('#baseForm [name="customerName"]').attr('customerId')
                        },
                        page: true,
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {field: 'contractName', title: '合同名称', width: 200,},
                            {
                                field: 'contractMoney', title: '合同金额', templet: function (d) {
                                    return d.contractMoney ? keepTwoDecimalFull(d.contractMoney) : '/'
                                }
                            },
                            {
                                field: 'contractPeriod', title: '合同工期',
                            },
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
                        $('#baseForm [name="contractMoney"]').val(chooseData.contractMoney ? keepTwoDecimalFull(chooseData.contractMoney) : '/')
                        //合同付款条件
                        $('#baseForm [name="paymentCondition"]').val(chooseData.paymentCondition || '')
                        //累计已结算金额
                        $('#baseForm [name="accumulatedSettlatedAmount"]').val(keepTwoDecimalFull(chooseData.accumulatedSettlatedAmount) || 0)
                        //累计已结算比例
                        $('#baseForm [name="cumulativeSettledRatio"]').val(chooseData.cumulativeSettledRatio || '0%')
                        //累计已支付金额
                        $('#baseForm [name="accumulatedAmountPaid"]').val(keepTwoDecimalFull(chooseData.accumulatedAmountPaid) || 0)
                        //累计已支付比例
                        $('#baseForm [name="cumulativePaidProportion"]').val(chooseData.cumulativePaidProportion || '0%')

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

        // 点击选结算合同
        $(document).on('click', '.chooseSettlement', function () {
            if (!$('.plan_base_info input[name="contractName"]').attr('subcontractId')) {
                layer.msg('请先选择合同！', {icon: 0, time: 2000});
                return false
            }
            layer.open({
                type: 1,
                title: '选择结算单',
                area: ['100%', '100%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="layui-form">' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {

                    laodTable();

                    // 加载表格
                    function laodTable() {
                        table.render({
                            elem: '#managementBudgetTable',
                            url: '/plbDeptSubsettleup/getDataByCondition',
                            where: {
                                deptId: $('#leftId').attr('deptId'),
                                subcontractId: $('.plan_base_info input[name="contractName"]').attr('subcontractId'),
                                auditerStatus: 2//只有审批通过的合同可以选择
                            },
                            cellMinWidth: 120,
                            page: true,
                            limit: 20,
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
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'customerName', title: '客商单位名称', width: 150,},
                                {field: 'contractName', title: '合同名称', width: 150,},
                                {
                                    field: 'settleupMoney', title: '本次结算金额', minWidth: 150, templet: function (d) {
                                        return keepTwoDecimalFull(d.settleupMoney) || ''
                                    }
                                },
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('managementBudgetTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];

                        //结算id
                        $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId', chooseData.subsettleupId);

                        // 本次结算金额
                        var settleupMoney = keepTwoDecimalFull(chooseData.settleupMoney) || '';
                        $('.plan_base_info input[name="currentSettlementAmount"]').val(settleupMoney);


                        if(chooseData.subsettleupId){
                            $.get('/plbDeptSubsettleup/queryId',{subsettleupId:chooseData.subsettleupId},function (res) {
                                if(res.flag){
                                    //结算合同附件
                                    $('#fileContent3').html(getFileEleStr(res.data.attachments));
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

        //监听本次申请金额
        $(document).on('blur', '.outMoneyItem', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var paymentAmount = 0
            $tr.each(function () {
                paymentAmount = accAdd(paymentAmount, $(this).find('input[name="applicationAmount"]').val())
            });
            //计算本次支付金额
            $('#baseForm [name="payMoney"]').val(keepTwoDecimalFull(paymentAmount))

            //计算不含税金额
            if ($(this).val() && $(this).parents('tr').find('[name="taxAmount"]').val()) {
                var amountExcludingTax = $(this).val() - $(this).parents('tr').find('[name="taxAmount"]').val()
                $(this).parents('tr').find('[name="amountExcludingTax"]').val(amountExcludingTax)
            }

        });

        //监听税额
        $(document).on('blur', '.taxAmountItem', function () {
            //计算不含税金额
            if ($(this).val() && $(this).parents('tr').find('[name="applicationAmount"]').val()) {
                var amountExcludingTax = $(this).parents('tr').find('[name="applicationAmount"]').val() - $(this).val()
                $(this).parents('tr').find('[name="amountExcludingTax"]').val(amountExcludingTax)
            }

        });

        //发票上传
        $(document).on('click', '.choose_invoices', function () {
            var $this = $(this)
            var $ele = $(this).prev();
            var subpaymentId = $('.plan_base_info input[name="contractName"]').attr('subpaymentId');
            var subpaymentNo = $('input[name="subpaymentNo"]', $('#baseForm')).val();
            openPwyWeb(subpaymentId, subpaymentNo, '', $ele, function (data) {
                var $tr = $this.parents('tr');
                var taxAmount = 0; // 税额合计
                var amount = 0; // 不含税金额合计
                var totalAmount = 0; // 含税金额合计
                data.forEach(function (item) {
                    taxAmount = BigNumber(item.taxAmount).plus(taxAmount);
                    amount = BigNumber(item.amount).plus(amount);
                    totalAmount = BigNumber(item.totalAmount).plus(totalAmount);
                });
                $tr.find('.KD_total_amount').val(totalAmount);
                $tr.find('.KD_tax_amount').val(taxAmount);
                $tr.find('.KD_amount').val(amount);


                var $trs = $('.mtl_info').find('.layui-table-main tr');
                var paymentAmount = 0
                $trs.each(function () {
                    paymentAmount = accAdd(paymentAmount, $(this).find('input[name="applicationAmount"]').val())
                });
                //重新计算本次支付金额
                $('#baseForm [name="payMoney"]').val(paymentAmount)
            });
        });

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

        //保存
        $(document).on('click', '#save', function () {
            var obj = allData()
            if(!obj){
                return false
            }
            var loadIndex = layer.load();
            $.ajax({
                url: '/plbDeptSubpayment/updatePlbMtlSubpayment',
                data: JSON.stringify(obj),
                dataType: 'json',
                type: 'post',
                contentType: "application/json;charset=UTF-8",
                success: function (res) {
                    layer.close(loadIndex);
                    if (res.flag) {
                        layer.msg('保存成功！', {icon: 1});


                        var approvalData = obj
                        //经办人
                        approvalData.createUser = $('[name="createUser"]', $('#baseForm')).val()
                        //是否分摊
                        approvalData.ifShare = obj.ifShare == '1' ? '是' : '否';

                        //遍历表格获取每行数据
                        var $trs = $('.mtl_info').find('.layui-table-main tr');
                        var dataArr = [];
                        $trs.each(function () {
                            var dataObj = {
                                rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
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
                            var str = '';
                            str = dataObj.rbsItemName + '`' + dataObj.totalAnnualBudget + '`' + dataObj.totalAnnualBalance + '`' + dataObj.applicationAmount + '`' + dataObj.taxAmount + '`' + dataObj.amountExcludingTax + '`' + dataObj.deptName + '`' + dataObj.remark + '`';
                            dataArr.push(str);
                        });
                        var budgetDetails = dataArr.join('\r\n');
                        budgetDetails += '|`````````';

                        approvalData.budgetDetails = budgetDetails


                        //遍历付款明细表格获取每行数据
                        var $trs = $('.pym_info').find('.layui-table-main tr');
                        var paymentArr = [];
                        $trs.each(function () {
                            var paymentObj = {
                                paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                                collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                                collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                                collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                                collectionMoney: $(this).find('input[name="collectionMoney"]').val(),//收款金额
                                remarks: $(this).find('input[name="remarks"]').val(),//备注
                            }
                            //收款人
                            var userName = $(this).find('input[name="collectionUser"]').val()
                            var $user = $(this).find('input[name="collectionUser"]');
                            var userType = $user.attr('userType');
                            if (userType == 2) {
                                paymentObj.customerName = userName;
                                paymentObj.customerId = $user.attr('customerId') || '';
                            } else {
                                paymentObj.collectionUserName = userName;
                                paymentObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
                            }

                            var str = '';
                            str = dictionaryObj['PAYMENT_METHOD']['object'][paymentObj.paymentType] + '`' + (paymentObj.customerName || paymentObj.collectionUserName) + '`' + paymentObj.collectionAccount + '`' + paymentObj.collectionBank + '`' + paymentObj.collectionMoney + '`' + paymentObj.remarks + '`';

                            paymentArr.push(str);
                        });
                        var payDetails = paymentArr.join('\r\n');
                        payDetails += '|`````````';

                        approvalData.payDetails = payDetails

                        $.post('/plbDeptReimburse/updateFlowData', {
                            flowId: flowId,
                            runId: runId,
                            subcontractType: 3,// 合同管理1，合同结算2，合同付款3
                            subcontract: obj.subpaymentId,
                            approvalData: JSON.stringify(approvalData)
                        }, function (res) {
                            // 如果上传了发票
                            if ($('.invoice_file').length > 0) {
                                layer.confirm('是否提交发票？', function (index) {
                                    // 提交发票状态
                                    submitKingDee(obj.subpaymentId, obj.subpaymentNo, '', function () {
                                        layer.msg('提交成功!', {icon: 1, time: 1500}, function() {

                                        });
                                    });
                                }, function () {

                                });
                            } else {

                            }
                        });
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                }
            });
        })

        // 流程办理提交
        $('#reSubmitBtn').on('click', function () {
            var loadIndex = layer.load();
            // 影像驳回
            if (reimburseStatus == '4') {
                var dataObj = allData()
                if (!dataObj) {
                    return false;
                }
                var subpaymentId = $('.plan_base_info input[name="contractName"]').attr('subpaymentId')
                // 保存附件，重新生成发票影像
                $.post('/plbDeptReimburse/updateReimburseAttachment', {
                    reimburseId: subpaymentId,
                    attachmentId: dataObj.attachmentId,
                    attachmentName: dataObj.attachmentName,
                    attachmentNum: dataObj.attachmentNum
                }, function (res) {
                    layer.close(loadIndex);
                    if (res.flag) {
                        layer.confirm('是否提交新影像？', function (index) {
                            var loadIndex = layer.load();
                            $.get('/kingdeeUtil/submitImge', {id: prcsId, runId: runId}, function (res) {
                                if (res.flag) {
                                    layer.msg('提交成功!', {icon: 1, time: 1500}, function () {
                                        layer.close(index);
                                    })
                                } else {
                                    layer.msg('提交失败!', {icon: 2, time: 1500});
                                    layer.close(loadIndex);
                                }
                            });
                        }, function () {
                            location.reload();
                        });
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                });
            }
        });

        function allData() {
            //必填项提示
            for (var i = 0; i < $('.testNull').length; i++) {
                if ($('.testNull').eq(i).val() == '') {
                    layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                    return false
                }
            }

            //本次支付金额不得大于
            // （1）合同余额：合同金额-累计已付款（不含本次）
            // （2）结算余额：累计结算（含本次）-累计已付款（不含本次）
            // （3）预算余额：年度预算-累计已付款（不含本次）
            var contractBalance = subtr($('[name="contractMoney"]').val(), $('[name="accumulatedAmountPaid"]').val())
            var settleBalance = subtr($('[name="accumulatedSettlatedAmount"]').val(), $('[name="accumulatedAmountPaid"]').val())
            var yearBudget = 0
            $('.mtl_info').find('.layui-table-main tr').each(function () {
                yearBudget = accAdd(yearBudget, $(this).find('.totalAnnualBalance').text())
            });
            var budgetBalance = subtr(yearBudget, $('[name="accumulatedAmountPaid"]').val())
            var thisPayMoney = $('[name="payMoney"]').val()

            if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(contractBalance)) {
                layer.msg('本次支付金额不得大于合同余额：合同金额-累计已付款（不含本次）', {icon: 0});
                return false
            }

            if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(settleBalance)) {
                layer.msg('本次支付金额不得大于结算余额：累计结算（含本次）-累计已付款（不含本次）', {icon: 0});
                return false
            }

            if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val()!='/' && Number(thisPayMoney) > Number(budgetBalance)) {
                layer.msg('本次支付金额不得大于预算余额：年度预算-累计已付款（不含本次）', {icon: 0});
                return false
            }


            //材料计划数据
            var datas = $('#baseForm').serializeArray();
            var obj = {}
            datas.forEach(function (item) {
                obj[item.name] = item.value
            });

            //合同id
            obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //客商单位名称id
            obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');

            //结算id
            obj.subsettleupId = $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId');

            obj.contractMoney = obj.contractMoney == '/' ? '' : $('.plan_base_info input[name="contractMoney"]').val();

            // 附件
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            obj.attachmentId = attachmentId;
            obj.attachmentName = attachmentName;

            //预算执行明细数据
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var materialDetailsArr = [];
            $tr.each(function () {
                var materialDetailsObj = {
                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                    cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                    deptId: $(this).find('input[name="deptId"]').attr('deptId'),
                    totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                    totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                    applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                    amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                    taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                    remark: $(this).find('input[name="remark"]').val(),//备注
                }
                if ($(this).find('input[name="applicationAmount"]').attr('subpaymentListId')) {
                    materialDetailsObj.subpaymentListId = $(this).find('input[name="applicationAmount"]').attr('subpaymentListId');
                }
                var invoiceNos = '';
                var invoiceNoStr = '';
                $(this).find('.invoices_box span').each(function (i, v) {
                    invoiceNos += $(v).attr('fid') + ',';
                    invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
                });
                materialDetailsObj.invoiceNos = invoiceNos;
                materialDetailsObj.invoiceNoStr = invoiceNoStr;
                materialDetailsArr.push(materialDetailsObj);
            });
            obj.plbDeptSubpaymentListWithBLOBs = materialDetailsArr;

            //付款明细数据
            var $tr2 = $('.pym_info').find('.layui-table-main tr');
            var paymentArr = [];
            $tr2.each(function () {
                var paymentObj = {
                    paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                    collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                    // collectionBank: $(this).find('[data-field="collectionBank"] .layui-table-cell').text(),//开户行
                    collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                    collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                    collectionMoney: $(this).find('input[name="collectionMoney"]').val(),//收款金额
                    remarks: $(this).find('input[name="remarks"]').val(),//备注
                }
                if ($(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')) {
                    paymentObj.subpaymentPaymentId = $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId');
                }
                //收款人
                var userName = $(this).find('input[name="collectionUser"]').val()
                var $user = $(this).find('input[name="collectionUser"]');
                var userType = $user.attr('userType');
                if (userType == 2) {
                    paymentObj.customerName = userName;
                    paymentObj.customerId = $user.attr('customerId') || '';
                } else {
                    paymentObj.collectionUserName = userName;
                    paymentObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
                }

                paymentArr.push(paymentObj);
            });
            obj.plbDeptSubpaymentPaymentWithBLOBs = paymentArr;


            var subpaymentId = $('.plan_base_info input[name="contractName"]').attr('subpaymentId')
            obj.subpaymentId = subpaymentId
            var deptId = $('.plan_base_info input[name="contractName"]').attr('deptId')
            obj.deptId = parseInt(deptId);

            //经办人
            obj.createUser = $('[name="createUser"]', $('#baseForm')).attr('user_id')
            //是否分摊
            obj.ifShare = $('input[name="ifShare"]:checked').val()
            //判断是否分摊
            var flagDeptId = '';
            if ($('.choose_dept').length > 0) {
                $('.choose_dept').each(function () {
                    var id = $(this).attr('deptid') || '';
                    if (flagDeptId && id && id != flagDeptId) {
                        obj.ifShare = 1;
                        return false
                    }
                    flagDeptId = id;
                });
            }

            return obj
        }


        /*用来得到精确的加法结果
            *说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
            *调用：accAdd(arg1,arg2)
            *返回值：arg1加上arg2的精确结果
        */
        function accAdd(arg1, arg2) {
            var r1, r2, m;
            try {
                r1 = arg1.toString().split(".")[1].length
            } catch (e) {
                r1 = 0
            }
            try {
                r2 = arg2.toString().split(".")[1].length
            } catch (e) {
                r2 = 0
            }
            m = Math.pow(10, Math.max(r1, r2))
            return (arg1 * m + arg2 * m) / m
        }

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


    });

    /**
     * 选人完成回调
     * @param userId 用户id
     */
    function archives(userId) {
        if (userId) {
            getUserInfo(userId.replace(/,$/, ''), function (res) {
                if (res.object && res.object.userExt) {
                    $tr = $('#' + user_id).parents('tr');
                    $tr.find('input[name="collectionAccount"]').val(res.object.userExt.bankCardNumber || '');
                    // $tr.find('.collectionBank').text(res.object.userExt.bankDeposit || '');
                    $tr.find('.collectionBank').attr('collectionBankNo',res.object.userExt.bankDeposit || '');
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
            initKingDee(res.object.userId)
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

<script type="text/javascript" src="/js/planbudget/kingDee.js?20210827.1"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>
<script type="text/javascript" src="/js/editIEprint/index.js?20210811.2"></script>
</body>
</html>