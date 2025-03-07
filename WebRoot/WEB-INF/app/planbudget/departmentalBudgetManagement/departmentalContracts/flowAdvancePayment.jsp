<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>流程-预付款结算单</title>
    <meta name="renderer" content="ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edgechrome=1">
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

        html body {
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

        .layui-form-radio > i {
            line-height: 28px;
        !important;
        }

        .footer {
            /*position: absolute;*/
            /*left: 0;*/
            /*bottom: 0;*/
            width: 100%;
            height: 60px;
            line-height: 60px;
            text-align: center;
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class="layui-collapse">
    <%--    /* region 合同付款 */--%>
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">单据编号</h2>
        <div class="layui-colla-content layui-show plan_base_info">
            <form class="layui-form" id="baseForm" lay-filter="formTest">
                <%--                /* region 第一行 */--%>
                <div class="layui-row">
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">单据编号<span class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="contractNo" readonly autocomplete="off"
                                       class="layui-input testNull" style="background: #e7e7e7" title="单据编号">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">客商单位名称<span
                                    class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <i style="position: absolute;top: 8px;right: 5px;"
                                   class="layui-icon layui-icon-search"></i>
                                <input type="text" name="customerName" autocomplete="off" readonly
                                       style="cursor: pointer;background: #e7e7e7"
                                       class="layui-input chooseCustomerName" title="客商单位名称">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">合同名称</label>
                            <div class="layui-input-block form_block">
                                <i style="position: absolute;top: 8px;right: 5px;"
                                   class="layui-icon layui-icon-search"></i>
                                <input type="text" name="contractName" placeholder="查找合同" readonly autocomplete="off"
                                       class="layui-input"
                                       style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">
                            </div>
                        </div>
                    </div>

                </div>
                <%--                /* endregion */--%>
                <%--                /* region 第二行 */--%>
                <div class="layui-col-xs4" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">合同编号</label>
                        <div class="layui-input-block form_block">
                            <input type="text" readonly name="deptContractNo" autocomplete="off" class="layui-input"
                                   style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs4" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">合同金额（元）</label>
                        <div class="layui-input-block form_block">
                            <input type="text" name="contractFee" readonly style="background: #e7e7e7"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>

                <div class="layui-col-xs4" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">预付款结算金额</label>
                        <div class="layui-input-block form_block">
                            <input readonly name="advanceMoney" style="background: #e7e7e7" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                </div>
                <%--                /* endregion */--%>
                <%--                /* region 第二行 */--%>
                <div class="layui-row">
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">结算期间<span class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" id="settlementPeriod" name="advancePeriod" readonly
                                       autocomplete="off" class="layui-input testNull" title="结算期间">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">款项性质<span field="naturePayment"
                                                                                 class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <select name="naturePayment" lay-filter="naturePayment"></select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;display:none">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">经办人</label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="createUser" autocomplete="off" readonly class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;display:none">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">合同标题</label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="contractInfoName" autocomplete="off" readonly
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;display:none">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">发起部门</label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="deptName" autocomplete="off" readonly class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">发起类型<span class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <select name="initiationType" id="" lay-filter="mySelect" class="testNull" title="发起类型">
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs4" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">工程项目</label>
                        <div class="layui-input-block form_block">
                            <input type="text" name="enginProject" style="background: #e7e7e7" autocomplete="off" class="layui-input" title="工程项目" readonly>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs4" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">工程合同</label>
                        <div class="layui-input-block form_block">
                            <input type="text" name="enginContract" style="background: #e7e7e7" autocomplete="off" class="layui-input" title="工程合同" readonly>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs4" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">研发项目</label>
                        <div class="layui-input-block form_block">
                            <input type="text" name="developProject" style="background: #e7e7e7" autocomplete="off" class="layui-input" title="研发项目" readonly>
                        </div>
                    </div>
                </div>
                <%--                /* endregion */--%>
                <%--                /* region 第四行 */--%>
                <div class="layui-row">
                    <div class="layui-col-xs12" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">付款事由<span class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <textarea type="text" name="settlementDescription" autocomplete="off"
                                          class="layui-textarea chen" title="付款事由"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-col-xs12" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">比价附件</label>
                            <div class="layui-input-block form_block">
                                <div class="file_module">
                                    <div id="fileContent2" class="file_content"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--                /* endregion */--%>
                <%--                /* region 第五行 */--%>
                <div class="layui-row">
                    <div class="layui-col-xs12" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">合同附件</label>
                            <div class="layui-input-block form_block">
                                <div class="file_module">
                                    <div id="fileContent1" class="file_content"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <%--                /* endregion */--%>
        <%--                /* region 第四行 */--%>
        <%--                //            <div class="layui-row"> --%>
        <%--                    //                <div class="layui-col-xs12" style="padding: 0 5px;"> --%>
        <%--                        //                    <div class="layui-form-item"> --%>
        <%--                            //                        <label class="layui-form-label form_label">结算合同附件</label> --%>
        <%--                            //                        <div class="layui-input-block form_block"> --%>
        <%--                                //                            <div class="file_module"> --%>
        <%--                                    //                                <div id="fileContent3" class="file_content"></div> --%>
        <%--                                    //                            </div> --%>
        <%--                                //                        </div> --%>
        <%--                            //                    </div> --%>
        <%--                        //                </div> --%>
        <%--                    //            </div>--%>
        <%--                /* endregion */--%>
        <%--                /* region 第七行 */--%>
        <div class="layui-row">
            <div class="layui-col-xs4" style="padding: 0 5px;">
                <div class="layui-form-item">
                    <label class="layui-form-label form_label">附件数量</label>
                    <div class="layui-input-block form_block">
                        <input type="text" name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs8" style="padding: 0 5px;">
                <div class="layui-form-item">
                    <label class="layui-form-label form_label">附件</label>
                    <div class="layui-input-block form_block">
                        <div class="file_module">
                            <div id="fileContent" class="file_content"></div>
                            <div class="file_upload_box">
                                <a href="javascript:;" class="open_file">
                                    <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
                                    <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget"
                                           name="file">
                                </a>
                                <div class="progress" id="progress">
                                    <div class="bar"></div>
                                </div>
                                <div class="bar_text"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--                /* endregion */--%>


        <%--    /* region 预算执行明细 */--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">预算执行明细</h2>
            <div class="layui-colla-content mtl_info layui-show">
                <div>
                    <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>
                </div>
            </div>
        </div>
        <%--    /* endregion */--%>
        <%--    /* region 合同付款明细 */--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">付款明细</h2>
            <div class="layui-colla-content pym_info layui-show">
                <div>
                    <table id="paymentTable" lay-filter="paymentTable"></table>
                </div>
            </div>
        </div>
        <%--    /* endregion */--%>
        </form>
        <%--            <form class="layui-form" id="baseForm" lay-filter="formTest">--%>
        <%--             --%>
        <%--            </form>--%>
    </div>
</div>
<%--    /* endregion */--%>

</div>

<div class="footer">
    <button type="button" class="layui-btn layui-btn-normal" id="saveBtn">保存</button>
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
    var runId = $.GetRequest()['runId'] || '';
    var flowId = $.GetRequest()['flowId'] || '';
    var disabled = $.GetRequest()['disabled'] || '';
    var xhr = null;
    if (disabled == '0') {

    } else {
        $('input').attr('disabled', 'true')
        $('button[lay-event="add"]').css('display', 'none')
        $('#saveBtn').css('display', 'none')
        $('input[name="initiationType"]').css('display', 'none')
        $('select[name="naturePayment"]').attr('disabled', 'true')
        $('select[name="initiationType"]').attr('disabled', 'true')
        $('textarea[name="settlementDescription"]').attr('disabled', 'true')
    }

    var advanceId
    var data
    var deptId
    var contractId


    $('input[name="contractName"]').addClass('chooseSubcontract')

    //付款明细收款人 选完人回调
    window.ppp = function (a, d) {
        $('.layui-table-click [name="collectionUser"]').val(a)
        $('.layui-table-click [name="collectionUser"]').attr('customerId', d.customerId)
        $('.layui-table-click [name="collectionAccount"]').val(d.bankAccount)
        $('.layui-table-click [name="collectionBank"]').val(d.bankOfDepositName)
        $('.layui-table-click [name="collectionBank"]').attr("collectionBankNo", d.bankOfDeposit);
    }

    var dictionaryObj = {
        CONTROL_MODE: {},
        CBS_UNIT: {},
        PAYMENT_METHOD: {},
        RBS_TYPE: {},
        RBS_CATEGORY: {},
        CBS_LEVEL: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,PAYMENT_METHOD,RBS_TYPE,RBS_CATEGORY,CBS_LEVEL';
    $.ajax({
        url: '/plbDictonary/selectDictionaryByDictNos',
        data: {
            plbDictNos: dictionaryStr
        },
        async: false,
        success: function (res) {
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
        }
    })

    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;
        var tableIns = null;
        var materialsTable = null;
        var collectionUserTable = null;
        var layTable = layui.table;
        //发起类型
        $.ajax({
            url: '/plbDictonary/selectDictionaryByNo',
            data:{plbDictNo:'TRAVEL_TYPE',plbDictNo1:'07'},
            async:false,
            type: 'post',
            success: function (res) {
                var data = res.data
                var str='<option value="">请选择</option>';
                for(var i=0;i<data.length;i++){
                    str += '<option value="'+data[i].plbDictNo+'">'+data[i].dictName+'</option>'
                }
                $('select[name="initiationType"]').html(str)
                form.render()
            }
        });
        $.ajax({
            url: '/plbDictonary/selectDictionaryByNo',
            data: {plbDictNo: 'TRAVEL_TYPE', plbDictNo1: '06'},
            async: false,
            success: function (res) {
                var travelTypStr = '';
                res.data.forEach(function (item) {
                    travelTypStr += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                })
                $('select[name="naturePayment"]').html(travelTypStr);
                form.render()
            }
        });
        $.ajax({
            url: '/plbContractInfo/queryByRunId',
            data: {
                runId: runId
            },
            dataType: 'json',
            type: 'post',
            async: false,
            success: function (res) {

                //数据回显
                data = res.data
                contractId = res.data.contractId
                advanceId = res.data.plbContractAdvance.advanceId
                //deptId
                deptId = res.data.deptId
                //合同金额
                $("input[name='contractFee']").val(addSign(res.data.plbContractAdvance.contractFee))
                $("input[name='advancePeriod']").val(res.data.plbContractAdvance.advancePeriod)
                $("input[name='deptId']").val(res.data.deptId)


                //经办人
                $("input[name='createUser']").val(res.data.createUser)

                $("input[name='deptContractNo']").val(res.data.plbContractAdvance.deptContractNo)
                $("textarea[name='settlementDescription']").val(res.data.plbContractAdvance.settlementDescription)

                //预付款结算金额
                $("input[name='advanceMoney']").val(addSign(res.data.plbContractAdvance.advanceMoney))
                materialDetailsTableData = res.data.plbContractInfoListWithBLOBsList || [];
                paymentTableData = res.data.plbDeptSubpaymentPayments || [];

                form.val("formTest", data);
                //工程项目
                if (data.plbProj == undefined) {
                    $("input[name='enginProject']").val('')
                } else {
                    var projName = data.plbProj.projName
                    $("input[name='enginProject']").val(projName)
                    $("input[name='enginProject']").attr('projId', data.plbProj.projId)
                }
                //工程合同
                if (data.plbDeptSubcontract == undefined) {
                    $("input[name='enginContract']").val('')
                } else {
                    var contractName = data.plbDeptSubcontract.contractName
                    $("input[name='enginContract']").val(contractName)
                    $("input[name='enginContract']").attr('subcontractId', data.plbDeptSubcontract.subcontractId)
                }
                //研发项目
                if (data.srmsPjProject == undefined) {
                    $("input[name='developProject']").val('')
                } else {
                    var pjName = data.srmsPjProject.pjName
                    $("input[name='developProject']").val(pjName)
                    $("input[name='developProject']").attr('pjNumber', data.srmsPjProject.pjNumber)
                }
                // // 客商单位id
                $('.plan_base_info input[name="customerName"]').attr('customerId', data.customerId || '');
                // // 合同id
                $('.plan_base_info input[name="contractName"]').attr('subcontractId', data.subcontractId || '');
                // // //结算id
                // $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId', data.subsettleupId || '');
                //
                $('.plan_base_info input[name="contractMoney"]').val(data.contractMoney ? keepTwoDecimalFull(data.contractMoney) : '/');
                $('.plan_base_info input[name="deptContractNo"]').val(data.deptContractNo);
                // // $('.plan_base_info input[name="accumulatedAmountPaid"]').val(data.accumulatedAmountPaid);
                // // $('.plan_base_info input[name="currentSettlementAmount"]').val(data.currentSettlementAmount);
                // // $('.plan_base_info input[name="payMoney"]').val(data.payMoney);
                //
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

                if (data.subcontractId) {
                    $.get('/plbDeptSubcontract/queryId', {subContractId: data.subcontractId}, function (res) {
                        if (res.flag) {
                            //比价附件
                            $('#fileContent2').html(getFileEleStr(res.object.attachment2));
                            //合同附件
                            $('#fileContent1').html(getFileEleStr(res.object.attachment));
                        }
                    })
                }
                if (data.subsettleupId) {
                    $.get('/plbDeptSubsettleup/queryId', {subsettleupId: data.subsettleupId}, function (res) {
                        if (res.flag) {
                            //结算合同附件
                            $('#fileContent3').html(getFileEleStr(res.data.attachments));
                        }
                    })
                }

                if (data.relationImageUrl) {
                    $('#baseForm').parent().append('<button class="layui-btn layui-btn-sm" id="preview">查看发票</button>');
                    $('#preview').on('click', function () {
                        window.open(data.relationImageUrl + '&userId=' + data.createUser);
                    });
                }


                //预算执行明细
                var cols = [
                    // {type: 'numbers', title: '序号'},
                    {
                        field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                            return '<input readonly name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input ' + (type == '4' ? '' : 'choose_dept') + '" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.deptName) + '" contractListId="' + d.contractListId + '">';
                        }
                    },
                    {
                        field: 'rbsItemId', title: '预算科目名称', minWidth: 300, templet: function (d) {
                            return '<input name="rbsItemId" readonly ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChoose') + '" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.rbsItemName) + '" rbsItemId="' + d.rbsItemId + '">';
                        }
                    },
                    // {
                    //     field: 'cbsId',
                    //     title: '会计科目',
                    //     minWidth: 120,
                    //     templet: function (d) {
                    //         return '<input type="text" name="cbsId" cbsId="' + (d.cbsId || '') + '"   value="' + (d.cbsName || '') + '"  readonly autocomplete="off" class="layui-input ' + (type == '4' ? '' : 'cbsIdChoose') + '" style="height: 100%; cursor: pointer;" >'
                    //     }
                    // },
                    {
                        field: 'totalAnnualBudget',
                        title: '年度预算总额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<span class="totalAnnualBudget">' + isShowNull(addSign(d.totalAnnualBudget)) + '</span>';
                        }
                    },
                    {
                        field: 'totalAnnualBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
                            return '<span class="totalAnnualBalance">' + isShowNull(addSign(d.totalAnnualBalance)) + '</span>';
                        }
                    },
                    {
                        field: 'applicationAmount',
                        title: '本次支付金额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input name="applicationAmount" ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount ' + (type == '4' ? '' : 'applicationAmount') + '" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.applicationAmount) + '">';
                        }
                    },
                    {
                        field: 'actualApplicationAmount',
                        title: '本次执行预算金额',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input name="actualApplicationAmount" readonly  type="text" pointFlag="1"  class="layui-input input_floatNum KD_total_amount" autocomplete="off" style="height: 100%;;background-color: #e7e7e7" value="' + isShowNull(addSign(d.actualApplicationAmount)) + '">';
                        }
                    },
                    {
                        field: 'itemDesc',
                        title: '事项说明',
                        minWidth: 150,
                        templet: function (d) {
                            return '<input name="itemDesc"  ' + (type == 4 ? 'readonly' : '') + 'pointFlag="1" class="layui-input taxAmountItem KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.itemDesc) + '">';
                        }
                    },
                    // {
                    //     field: 'amountExcludingTax',
                    //     title: '关联申请单',
                    //     minWidth: 150,
                    //     // templet: function (d) {
                    //     //     return '<input name="amountExcludingTax"  readonly type="number"  class="layui-input input_floatNum KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + isShowNull(d.amountExcludingTax) + '">';
                    //     // }
                    // },

                    // {
                    //     field: 'invoices',
                    //     title: '关联工作计划',
                    //     minWidth: 200,
                    //     templet: function (d) {
                    //         var invoiceStr = '';
                    //         if (d.invoiceList) {
                    //             d.invoiceList.forEach(function (item, index) {
                    //                 var invoiceInfo = JSON.parse(item.invoiceInfo);
                    //                 invoiceStr += '<span class="invoice_file ' + invoiceInfo.serialNo + '" fid="' + invoiceInfo.serialNo + '">' + (invoiceInfo.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                    //             });
                    //         } else if (d.invoiceNoStr) {
                    //             var invoiceNoArr = d.invoiceNoStr.replace(/,$/, '').split(',');
                    //             var fidArr = d.invoiceNos.replace(/,$/, '').split(',');
                    //
                    //             for (var i = 0; i < fidArr.length; i++) {
                    //                 invoiceStr += '<span class="invoice_file ' + fidArr[i] + '" fid="' + fidArr[i] + '">' + invoiceNoArr[i] + ',</span>';
                    //             }
                    //         }
                    //         var str = '';
                    //         if (type != '4') {
                    //             str = '<a class="choose_invoices"><i class="layui-icon layui-icon-upload-circle"></i></a>'
                    //         }
                    //         return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div>' + str + '</div>';
                    //     }
                    // }
                ]
                // if (type != 4) {
                //     cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
                // }

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
                        if (type == 4) {
                            $('.addRow').hide()
                        }
                        $('input[name="deptId"]').each(function (i, v) {
                            $(this).attr('id', 'dept_' + i);
                        });

                        //权限
                        if (disabled == '0') {

                        } else {
                            $('input').attr('disabled', 'true')
                            $('button[lay-event="add"]').css('display', 'none')
                        }

                    }
                });

                //合同付款明细
                var cols2 = [
                    {type: 'numbers', title: '序号'},
                    {
                        field: 'paymentType',
                        title: '付款方式',
                        event: 'choosePay',
                        minWidth: 150,
                        templet: function (d) {
                            var str = dictionaryObj['PAYMENT_METHOD']['object'][d.paymentType] || '';
                            return '<input type="text" name="paymentType" subpaymentPaymentId="' + (d.subpaymentPaymentId || '') + '" readonly paymentType="' + isShowNull(d.paymentType) + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                        }
                    },
                    {
                        field: 'collectionUser',
                        title: '收款人',
                        minWidth: 150,
                        event: 'chooseCollectionUser',
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
                            return '<input type="text" name="collectionAccount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionAccount) + '">';
                        }
                    },
                    {
                        field: 'collectionBank',
                        title: '开户行',
                        minWidth: 150,
                        templet: function (d) {

                            return '<input readonly type="text"  name="collectionBank" collectionBankNo="' + d.collectionBank + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.collectionBankName) + '">';
                        }
                    },
                    {
                        field: 'collectionMoney',
                        title: '收款金额',
                        minWidth: 150,
                        templet: function (d) {

                            return '<input type="text" name="collectionMoney" pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionMoney) + '">';
                        }
                    },
                    {
                        field: 'remarks', title: '备注', minWidth: 300, templet: function (d) {

                            return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remarks) + '">';
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
                        if (type == 4) {
                            $('.addRow').hide()
                        }
                        $('input[name="collectionUser"]').each(function (i, v) {
                            $(v).attr('id', 'collectionUser' + i);
                        });


                        //权限
                        if (disabled == '0') {

                        } else {
                            $('input').attr('disabled', 'true')
                            $('button[lay-event="add"]').css('display', 'none')
                        }

                    }
                });
            }
        });


        // 获取当前登录人信息(经办人)
        getUserInfo('', function (res) {
            if (res.object) {
                $('[name="createUser"]', $('#baseForm')).attr('user_id', res.object.userId).val(res.object.userName);
                $('[name="createUser"]', $('#baseForm')).attr('deptId', res.object.deptId).attr('deptName', res.object.deptName);
                initKingDee(res.object.userId)
            }
        });
        var materialDetailsTableData = [];
        var paymentTableData = [];

        element.render();
        form.render();
        //日期时间范围
        laydate.render({
            //结算期间
            elem: '#settlementPeriod',
            type: 'date',
            range: '~',
            trigger: 'click',
            format: 'yyyy-MM-dd',
            value: data ? data.settlementPeriod : ''
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
                    '                  <input type="text" name="customerNo" placeholder="客商编号" autocomplete="off" class="layui-input">\n' +
                    '             </div>\n' +
                    '             <div class="layui-col-xs4" style="margin-left: 10px">\n' +
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

                    // loadMtlTable()
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
                        typeNo = typeNo ? typeNo : '';
                        if (xhr) {
                            xhr.abort()
                        }
                        xhr = $.ajax({
                            url: '/PlbCustomer/getDataByCondition',
                            data: {
                                merchantType: typeNo,
                                useFlag: true
                            },
                            success: function (res) {
                                layer.close(loading)
                                materialsTable = table.render({
                                    elem: '#materialsTable',
                                    data: res.data,
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
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        if(mtlData.auditerStatus!='2'){
                            layer.msg('该客商未批准，请进行审批',{icon:0})
                            return
                        }
                        _this.val(mtlData.customerName);
                        _this.attr('customerId', mtlData.customerId);

                        //清空选择合同
                        $('#baseForm [name="contractName"]').val('')
                        $('#baseForm [name="contractName"]').attr('subcontractId', '')

                        //合同编号
                        $('#baseForm [name="deptContractNo"]').val('')
                        $('#baseForm [name="deptContractNo"]').val('')

                        //合同金额
                        $('#baseForm [name="contractFee"]').val('')

                        $('#fileContent2').html('');
                        //合同附件
                        $('#fileContent1').html('');

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });

        //选择分包商内侧查询
        $(document).on('click', '.inSearchDataCustomer', function () {
            var loading = layer.load(1)
            var searchParams = {}
            var $seachData = $('.inSearchContent [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            xhr = $.ajax({
                url: '/PlbCustomer/getDataByCondition',
                data: searchParams,
                success: function (res) {
                    layer.close(loading)
                    materialsTable.reload({
                        data: res.data,
                    });
                }
            })
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
                            deptId: $('#leftId').attr('deptId'),
                            customerId: $('#baseForm [name="customerName"]').attr('customerId'),
                            subcontractType:'01'
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
                        layer.close(index);
                        var chooseData = checkStatus.data[0];

                        $('#baseForm [name="contractName"]').val(chooseData.contractName)
                        $('#baseForm [name="contractName"]').attr('subcontractId', chooseData.subcontractId)
                        //合同编号
                        $('#baseForm [name="deptContractNo"]').val(chooseData.subcontractNo)
                        $('#baseForm [name="deptContractNo"]').val(chooseData.subcontractNo)

                        //合同金额
                        $('#baseForm [name="contractFee"]').val(chooseData.contractMoney ? addSign(keepTwoDecimalFull(chooseData.contractMoney)) : '/')
                        //合同付款条件
                        $('#baseForm [name="paymentCondition"]').val(chooseData.paymentCondition || '')

                        if (chooseData.subcontractId) {
                            $.get('/plbDeptSubcontract/queryId', {subContractId: chooseData.subcontractId}, function (res) {
                                if (res.flag) {
                                    //比价附件
                                    $('#fileContent2').html(getFileEleStr(res.object.attachment2));
                                    //合同附件
                                    $('#fileContent1').html(getFileEleStr(res.object.attachment));

                                }
                            })
                        }
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


                        if (chooseData.subsettleupId) {
                            $.get('/plbDeptSubsettleup/queryId', {subsettleupId: chooseData.subsettleupId}, function (res) {
                                if (res.flag) {
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

        //发票上传
        $(document).on('click', '.choose_invoices', function () {
            if (subpaymentId) {
                var $this = $(this)
                var $ele = $(this).prev();
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

        // 节点点击事件
        $(document).on('click', '.con_left ul li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var deptId = $(this).attr('deptId');
            tableShow(deptId);
            $('#leftId').attr('deptId', deptId);
        });

        //选择预算科目名称
        $(document).on('click', '.rbsItemIdChoose', function () {
            var _this = $(this);
            var deptId = _this.parents('tr').find('[name="deptId"]').attr('deptId').replace(/,$/, '')
            if (!deptId) {
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
                    var date=new Date();
                    var dateYear=date.getFullYear()
                    loadMtlTable();

                    function loadMtlTable(rbsItemName) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbDeptBudgetItem/getBudgetItemDataByDeptId?year='+dateYear,
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
                        // //会计科目名称
                        // _this.parents('tr').find('[name="cbsId"]').val(mtlData.plbCbsType ? mtlData.plbCbsType.cbsName : '')
                        // _this.parents('tr').find('[name="cbsId"]').attr('cbsId', mtlData.cbsId)
                        //年度预算总额
                        _this.parents('tr').find('[data-field="totalAnnualBudget"] .totalAnnualBudget').text(addSign(mtlData.budgetMoney))
                        //年度预算余额
                        _this.parents('tr').find('[data-field="totalAnnualBalance"] .totalAnnualBalance').text(addSign(mtlData.budgetBalance))

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

        //监听本次申请金额
        $(document).on('blur', '.outMoneyItem', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var paymentAmount = 0
            $tr.each(function () {
                paymentAmount = accAdd(paymentAmount, $(this).find('input[name="applicationAmount"]').val())
            });
            //计算本次支付金额
            $('#baseForm [name="payMoney"]').val(keepTwoDecimalFull(paymentAmount))
        });

        //监听本次支付金额
        $(document).on('input propertychange', '.applicationAmount', function (e) {
            // var money = $(e.currentTarget).parent().parent().prev().find('span').text()
            // money = removeSign(money)
            // if (money == '') {
            //     $(e.currentTarget).val('');
            // } else {
            //     if (Number(money) >= Number($(e.currentTarget).val())) {
            //         // $('input[name="advanceMoney"]').val(Number($(e.currentTarget).val()))
            //     } else {
            //         $(e.currentTarget).val(Number(money))
            //
            //     }
            // }
            var all = 0
            $('#materialDetailsTable').next().find('input[name="applicationAmount"]').each(function () {
                if ($(this).val() == '') {

                } else {
                    all += Number($(this).val())
                }

            })
            $('input[name="advanceMoney"]').val(addSign(all.toFixed(2)))
        });

        $(document).on('input', '.applicationAmount', function () {
            $(this).parent().parent().parent().find('input[name="actualApplicationAmount"]').val(addSign($(this).val()))
        });

        //付款明细头部操作
        table.on('toolbar(paymentTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    var customerid = $('input[name="customerName"]').attr('customerid')
                    if (customerid != '' && customerid != undefined) {
                        //遍历表格获取每行数据进行保存
                        var $tr = $('.pym_info').find('.layui-table-main tr');
                        var customerId = $('input[name="customerName"]').attr('customerid')
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
                                collectionAccount: $(this).find('input[name="collectionAccount"]').val(),
                                collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                                collectionBankName: $(this).find('input[name="collectionBank"]').val(),
                                collectionMoney: $(this).find('input[name="collectionMoney"]').val(),
                                remarks: $(this).find('input[name="remarks"]').val(),
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

                        var result;

                        $.ajax({
                            url: '/PlbCustomer/queryId',
                            data: {
                                customerId: customerid
                            },
                            async: false,
                            success: function (res) {
                                result = res
                            }
                        })

                        var newObj = {
                            customerName: $('input[name="customerName"]').val(),
                            customerId: customerid,
                            paymentType: '02',
                            collectionMoney: removeSign($('input[name="advanceMoney"]').val())
                        }

                        if (result.data && result.data.plbCustomerBankList) {
                            if (result.data.plbCustomerBankList.length > 1) {
                                layer.open({
                                    type: 1,
                                    title: '选择付款方式',
                                    area: ['400px', '500px'],
                                    maxmin: true,
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div class="container" style="padding: 0px 10px">',
                                        '<table id="collectionBank" lay-filter="collectionBank"></table>',
                                        '</div>'].join(''),
                                    success: function () {
                                        // 获取科目
                                        table.render({
                                            elem: '#collectionBank',
                                            data: result.data.plbCustomerBankList,
                                            page: false,
                                            limit: 10000,
                                            cols: [[
                                                {type: 'radio', title: '选择'},
                                                {
                                                    field: 'accountType', title: '账号类型', templet: function (d) {
                                                        if (d.accountType == 0) {
                                                            return '<span name="accountType" customerId=' + d.customerId + ' customerName=' + d.customerName + '>基本户</span>'
                                                        } else {
                                                            return '<span name="accountType" customerId=' + d.customerId + ' customerName=' + d.customerName + '>其他户</span>'
                                                        }
                                                    }
                                                },
                                                {field: 'bankAccount', title: '银行账号'},
                                                {field: 'bankOfDepositName', title: '开户行'},
                                                {field: 'bankOfDeposit', title: '银行行号'}
                                            ]]
                                        });
                                    },
                                    yes: function (index) {
                                        var checkStatus = table.checkStatus('collectionBank');
                                        if (checkStatus.data.length > 0) {
                                            newObj.collectionAccount = checkStatus.data[0].bankAccount || '';
                                            newObj.collectionBank = checkStatus.data[0].bankOfDeposit || '';
                                            newObj.collectionBankName = checkStatus.data[0].bankOfDepositName || '';
                                            oldDataArr.push(newObj);
                                            table.reload('paymentTable', {
                                                data: oldDataArr
                                            });
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                })
                            } else {
                                if (result.data.plbCustomerBankList.length == 1) {
                                    newObj.collectionAccount = result.data.plbCustomerBankList[0].bankAccount || '';
                                    newObj.collectionBank = result.data.plbCustomerBankList[0].bankOfDeposit || '';
                                    newObj.collectionBankName = result.data.plbCustomerBankList[0].bankOfDepositName || '';
                                    oldDataArr.push(newObj);
                                    table.reload('paymentTable', {
                                        data: oldDataArr
                                    });
                                } else {
                                    newObj.collectionAccount = '';
                                    newObj.collectionBank = '';
                                    newObj.collectionBankName = '';
                                    oldDataArr.push(newObj);
                                    table.reload('paymentTable', {
                                        data: oldDataArr
                                    });
                                }
                            }
                        }


                    } else {
                        layer.msg('请先选择客商');
                        return false
                    }
                    break;
            }
        });

        // 付款明细内部删行操作
        table.on('tool(paymentTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                if (data.subpaymentPaymentId) {
                    $.get('/plbDeptSubpayment/delPlbMtlSubpaymentPayment', {subpaymentPaymentId: data.subpaymentPaymentId}, function (res) {
                        obj.del();
                        var $tr = $('.pym_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                                collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                                collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionbankno'),//开户行
                                collectionBankName: $(this).find('input[name="collectionBank"]').val(),
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
                    });
                } else {
                    obj.del();
                    var $tr = $('.pym_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                            collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                            collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionbankno'),//开户行
                            collectionBankName: $(this).find('input[name="collectionBank"]').val(),
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
                }
                //遍历表格获取每行数据进行保存

            } else if (layEvent === 'choosePay') {
                if (disabled == '1') return
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
                if (disabled == '1') return
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
                                type: 2,
                                title: '选择收款人',
                                area: ['70%', '80%'],
                                btn: ['确定'],
                                maxmin: true,
                                btnAlign: 'c',
                                content: ['/PlbCustomer/payee'].join(''),
                                yes: function (index, layero) {
                                    $(layero).find("iframe")[0].contentWindow.yesBtn();
                                }
                            });
                        });
                    }
                });
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
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsitemid'), // rbsId
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            deptName: $(this).find('input[name="deptId"]').val(),
                            deptId: $(this).find('input[name="deptId"]').attr('deptId'),
                            totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                            totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                            applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                            actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(), //本次执行预算金额
                            itemDesc: $(this).find('input[name="itemDesc"]').val(),//税额
                            contractListId: $(this).find('input[name="deptId"]').attr('contractListId')
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
                    getUserInfo($.cookie('userId'), function (res) {
                        var addRowData = {
                            deptId: res.object.deptId,
                            deptName: res.object.deptName,
                            actualApplicationAmount: '',
                            totalAnnualBudget: '',
                            totalAnnualBalance: '',
                            contractListId:''
                        };
                        oldDataArr.push(addRowData);
                        table.reload('materialDetailsTable', {
                            data: oldDataArr
                        });
                    })
                    break;
            }
        });
        // 预算执行内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                obj.del()
                if (data.contractListId) {
                    $.get('/plbContractInfo/delContractInfoList', {contractListId: data.contractListId}, function (res) {
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
                                // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                                actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(), //本次执行预算金额
                                itemDesc: $(this).find('input[name="itemDesc"]').val(),//税额
                                subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                                contractListId: $(this).find('input[name="deptId"]').attr('contractListId')
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
                        var all = 0
                        $('#materialDetailsTable').next().find('input[name="applicationAmount"]').each(function () {
                            if ($(this).val() == '') {

                            } else {
                                all += Number($(this).val())
                            }

                        })
                        $('input[name="advanceMoney"]').val(addSign(all.toFixed(2)))
                    });
                } else {
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
                            // amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(), //本次执行预算金额
                            itemDesc: $(this).find('input[name="itemDesc"]').val(),//税额
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
                    var all = 0
                    $('#materialDetailsTable').next().find('input[name="applicationAmount"]').each(function () {
                        if ($(this).val() == '') {

                        } else {
                            all += Number($(this).val())
                        }

                    })
                    $('input[name="advanceMoney"]').val(addSign(all.toFixed(2)))
                }

            }
        });

        //监听累计已支付金额
        $(document).on('blur', '[name="accumulatedAmountPaid"]', function () {
            if ($(this).val() && $('[name="contractMoney"]').val()) {
                $('[name="cumulativePaidProportion"]').val(keepTwoDecimalFull(($(this).val() / $('[name="contractMoney"]').val()) * 100) + '%')
            }
        });

        function submitFlow(flowId, approvalData) {
            var loadIndex = layer.load();
            newWorkFlow(flowId, function (res) {
                var submitData = {
                    contractId: contractId,
                    runId: res.flowRun.runId,
                    auditerStatus: 1,
                }
                $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                // 如果上传了发票
                if ($('.invoice_file').length > 0) {
                    submitData.ifImage = true;
                }
                // 更新状态
                $.post('/plbContractInfo/approvalContract', submitData, function (res) {
                    layer.close(loadIndex);
                    if (res.flag) {
                        if (submitData.ifImage) {
                            // 提交发票状态
                            submitKingDee(approvalData.subpaymentId, approvalData.subpaymentNo, '', function () {
                                layer.closeAll();
                                layer.msg('提交成功!', {icon: 1});
                                // tableIns.config.where._ = new Date().getTime();
                                // tableIns.reload()
                                location.reload();

                            });
                        } else {
                            layer.closeAll();
                            layer.msg('提交成功!', {icon: 1});
                            // tableIns.config.where._ = new Date().getTime();
                            // tableIns.reload()
                            location.reload();

                        }
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                });
            }, approvalData);
        }

        //保存按钮
        $('#saveBtn').on('click', function () {
            debugger
            //必填项提示
            for (var i = 0; i < $('.testNull').length; i++) {
                if ($('.testNull').eq(i).val() == '') {
                    layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                    return false
                }
            }

            //预算科目执行名称
            var rbsItemIdInput = $('input[name="rbsItemId"]')
            for (var i = 0; i < rbsItemIdInput.length; i++) {
                if ($('input[name="rbsItemId"]').eq(i).val() == '') {
                    layer.msg('预算科目执行名称为必选项', {icon: 0});
                    return false
                }
            }

            var getMoney = $("input[name='collectionMoney']");
            //收款金额总和
            var getMoneySum = 0;
            for (var i = 0; i < getMoney.length; i++) {
                if(getMoney.eq(i).val() != ''){
                    getMoneySum += parseFloat(getMoney.eq(i).val())
                }
            }
            if(getMoneySum == 0) getMoneySum=''
            if (getMoneySum != Number(removeSign($('input[name="advanceMoney"]').val()))) {
                layer.msg('收款金额总额与预付款结算金额不同！', {icon: 0});
                return false
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

            if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val() != '/' && Number(thisPayMoney) > Number(contractBalance)) {
                layer.msg('本次支付金额不得大于合同余额：合同金额-累计已付款（不含本次）', {icon: 0});
                return false
            }

            if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val() != '/' && Number(thisPayMoney) > Number(settleBalance)) {
                layer.msg('本次支付金额不得大于结算余额：累计结算（含本次）-累计已付款（不含本次）', {icon: 0});
                return false
            }

            if ($('[name="contractMoney"]').val() && $('[name="contractMoney"]').val() != '/' && Number(thisPayMoney) > Number(budgetBalance)) {
                layer.msg('本次支付金额不得大于预算余额：年度预算-累计已付款（不含本次）', {icon: 0});
                return false
            }

            var loadIndex = layer.load();
            //材料计划数据
            var datas = $('#baseForm').serializeArray();
            var datass = $('#baseForm').serializeArray();
            var obj = {}
            obj.contractType = '03'
            var plbContractAdvance = {}
            datas.forEach(function (item) {
                obj[item.name] = item.value
            });
            datass.forEach(function (item) {
                plbContractAdvance[item.name] = item.value
            });
            plbContractAdvance.contractFee = Number(removeSign(plbContractAdvance.contractFee))
            plbContractAdvance.advanceMoney = plbContractAdvance.advanceMoney ? Number(removeSign($('input[name="advanceMoney"]').val())) : ''
            obj['plbContractAdvance'] = plbContractAdvance;
            //合同id
            obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //客商单位名称id
            obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');

            //结算id
            obj.subsettleupId = $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId') || '';

            delete obj.deptId
            obj.deptId = data.deptId
            obj.initiationType = $('select[name="initiationType"]').val()

            if (advanceId) {
                obj.plbContractAdvance.advanceId = advanceId
            }
            // 附件
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            obj.attachmentId = attachmentId;
            obj.attachmentName = attachmentName;
            obj.contractType = '03'
            obj.contractId = contractId
            obj.enginProject = $("input[name='enginProject']").attr('projId')
            obj.enginContract = $("input[name='enginContract']").attr('subcontractId')
            obj.developProject = $("input[name='developProject']").attr('pjNumber')
            obj.naturePayment = $('[name="naturePayment"]').val();
            obj.attachmentNum = $('[name="attachmentNum"]').val();
            if (obj.enginProject == undefined) {
                obj.enginProject = ''
            }
            if (obj.enginContract == undefined) {
                obj.enginContract = ''
            }
            if (obj.developProject == undefined) {
                obj.developProject = ''
            }
            //预算执行明细数据
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var materialDetailsArr = [];
            $tr.each(function () {
                var materialDetailsObj = {
                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                    cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                    deptId: $(this).find('input[name="deptId"]').attr('deptId').replace(',', ''),
                    totalAnnualBudget: removeSign($(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text()),//年度预算总额
                    totalAnnualBalance: removeSign($(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text()),//年度预算余额
                    applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                    itemDesc: $(this).find('input[name="itemDesc"]').val(),//事项说明
                    contractInfoId: contractId,
                    actualApplicationAmount: removeSign($(this).find('input[name="actualApplicationAmount"]').val()) //本次预算执行金额
                }
                if ($(this).find('input[name="applicationAmount"]').attr('subpaymentListId')) {
                    materialDetailsObj.subpaymentListId = $(this).find('input[name="applicationAmount"]').attr('subpaymentListId');
                }
                if ($(this).find('input[name="deptId"]').attr('contractListId') && $(this).find('input[name="deptId"]').attr('contractListId') != "undefined") {
                    materialDetailsObj.contractListId = $(this).find('input[name="deptId"]').attr('contractListId')
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
            obj.plbContractInfoListWithBLOBsList = materialDetailsArr;

            //付款明细数据
            var $tr2 = $('.pym_info').find('.layui-table-main tr');
            var paymentArr = [];
            $tr2.each(function () {
                var paymentObj = {
                    paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
                    collectionUser: '',
                    customerId: '',
                    collectionAccount: $(this).find('input[name="collectionAccount"]').val(),
                    collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                    collectionMoney: $(this).find('input[name="collectionMoney"]').val(),
                    remarks: $(this).find('input[name="remarks"]').val(),
                    contractId: contractId
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
            obj.plbDeptSubpaymentPayments = paymentArr;

            obj.deptId = parseInt(deptId);

            $.ajax({
                url: '/plbContractInfo/updatePlbMtlSubsettleup',
                data: JSON.stringify(obj),
                dataType: 'json',
                type: 'post',
                async: false,
                contentType: "application/json;charset=UTF-8",
                success: function (res) {
                    $.ajax({
                        url: '/plbContractInfo/getContractAdvanceById?contractId=' + contractId,
                        dataType: 'json',
                        type: 'post',
                        async: false,
                        success: function (res){
                            var deptName
                            var contractInfoName = res.data.contractInfoName
                            var contractId = res.data.contractId
                            if (res.data) deptName = res.data.deptName
                            if (res.flag) {
                                subpaymentId = res.object
                                // obj.subpaymentId = subpaymentId
                                var approvalData = obj
                                if (deptName) {
                                    approvalData.deptName = deptName
                                } else {
                                    approvalData.deptName = $('input[name="deptName"]').val()
                                }
                                approvalData.contractInfoName = contractInfoName
                                approvalData.advanceId = approvalData.plbContractAdvance.advanceId
                                approvalData.advanceMoney = addSign(approvalData.plbContractAdvance.advanceMoney)
                                approvalData.advancePeriod = approvalData.plbContractAdvance.advancePeriod
                                approvalData.contractFee = addSign(approvalData.plbContractAdvance.contractFee)
                                approvalData.settlementDescription = approvalData.plbContractAdvance.settlementDescription
                                approvalData.contractName = $('input[name="contractName"]').val()
                                approvalData.createUser = $('input[name="createUser"]').val()


                                // approvalData.initiationType = $('select[name="initiationType"]').val()
                                approvalData.initiationType = $('select[name="initiationType"]').next().find('input').val()

                                delete approvalData.plbContractAdvance

                                //预算执行明细数据
                                var $tr = $('.mtl_info').find('.layui-table-main tr');
                                var materialDetailsArr = [];
                                $tr.each(function () {
                                    var materialDetailsObj = {
                                        rbsItemId: $(this).find('input[name="rbsItemId"]').val(), // 预算科目名称
                                        cbsId: $(this).find('.totalAnnualBudget').text(), // 年度预算总额
                                        deptId: $(this).find('.totalAnnualBalance').text(),  //年度预算余额
                                        totalAnnualBudget: addSign($(this).find('input[name="applicationAmount"]').val())?addSign($(this).find('input[name="applicationAmount"]').val()):'',//本次支付金额
                                        applicationAmount: $(this).find('input[name="deptId"]').val(),//费用承担部门
                                        itemDesc: $(this).find('input[name="itemDesc"]').val(),//事项说明
                                    }
                                    var str = '';
                                    str = materialDetailsObj.rbsItemId + '`' + materialDetailsObj.cbsId + '`' + materialDetailsObj.deptId + '`' + materialDetailsObj.totalAnnualBudget + '`' + materialDetailsObj.applicationAmount + '`' + materialDetailsObj.itemDesc + '`';
                                    materialDetailsArr.push(str);
                                });
                                materialDetailsArr = materialDetailsArr.join('\r\n');
                                materialDetailsArr += '|`````````';
                                approvalData.plbContractInfoListWithBLOBsList = materialDetailsArr;

                                //付款明细数据
                                var $tr2 = $('.pym_info').find('.layui-table-main tr');
                                var paymentArr = [];
                                $tr2.each(function () {
                                    var paymentObj = {
                                        paymentType: $(this).find('input[name="paymentType"]').val(),  //付款方式
                                        collectionUser: $(this).find('input[name="collectionUser"]').val(),   //收款人
                                        collectionAccount: $(this).find('input[name="collectionAccount"]').val(),  //银行账号
                                        collectionBank: $(this).find('input[name="collectionBank"]').val(),  //开户行
                                        collectionMoney: addSign($(this).find('input[name="collectionMoney"]').val())?addSign($(this).find('input[name="collectionMoney"]').val()):'',  //收款金额
                                        remarks: $(this).find('input[name="remarks"]').val()  //备注
                                    }

                                    var str = '';
                                    str = paymentObj.paymentType + '`' + paymentObj.collectionUser + '`' + paymentObj.collectionAccount + '`' + paymentObj.collectionBank + '`' + paymentObj.collectionMoney + '`' + paymentObj.remarks + '`';

                                    paymentArr.push(str);
                                });
                                paymentArr = paymentArr.join('\r\n');
                                paymentArr += '|`````````';

                                approvalData.plbDeptSubpaymentPayments = paymentArr;

                                $.post('/plbContractInfo/updateFlowData', {
                                    flowId: flowId,
                                    runId: runId,
                                    contractId: contractId,
                                    approvalData: JSON.stringify(approvalData)
                                }, function (res) {
                                    if (res.flag) {
                                        layer.msg('保存成功！', {icon: 1});
                                        layer.close(loadIndex);
                                        window.location.reload();

                                    } else {
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                })
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        }
                    })
                }
            });
        })
    })


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

    //删除千分符
    function removeSign(str) {
        while (str.indexOf(',') != -1) {
            str = str.replace(',', '')
        }
        return Number(str)
    };

    //添加千分符
    function addSign(str) {
        if (str == '') return '0.00'
        if(str == undefined) return '0.00'
        str = '' + str
        let thousandsReg = /(\d)(?=(\d{3})+$)/g;
        const numArr = str.split(".");
        numArr[0] = numArr[0].replace(thousandsReg, "$1,");
        if (numArr[1]) {
            if (numArr[1].length == 1) {
                numArr[1] = numArr[1] + '0'
            }
        } else {
            numArr[1] = '00'
        }
        return numArr.join(".")
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

    //选择研发项目
    $(document).on('click', '[name="developProject"]', function () {
        var $that = $(this);
        layui.layer.open({
            type: 2,
            title: '选择研发项目',
            area: ['80%', '80%'],
            maxmin: true,
            btnAlign: 'c',
            btn: ['确定'],
            content: ['/PlbCustomer/rojOrganization'].join(''),
            yes: function (index, layero) {
                var checkData = $(layero).find("iframe")[0].contentWindow.yesBtn();
                if (checkData != undefined) {
                    if (checkData.length > 0) {
                        $that.val(checkData[0].pjName);
                        $that.attr('pjNumber', checkData[0].pjNumber);
                        layer.close(index)
                    } else {
                        return
                    }
                }
            }
        });
    })
    //选择工程合同
    $(document).on('click', '[name="enginContract"]', function () {
        var $that = $(this);
        layui.layer.open({
            type: 2,
            title: '选择工程合同',
            area: ['80%', '80%'],
            maxmin: true,
            btnAlign: 'c',
            btn: ['确定'],
            content: ['/plbDeptSubcontract/newDeptContract'].join(''),
            yes: function (index, layero) {
                var checkData = $(layero).find("iframe")[0].contentWindow.yesBtn();
                if (checkData != undefined) {
                    if (checkData.length > 0) {
                        $that.val(checkData[0].contractName);
                        $that.attr('subcontractId', checkData[0].subcontractId);
                        layer.close(index)
                    } else {
                        return
                    }
                }
            }
        });
    })
    //选择工程项目
    $(document).on('click', '[name="enginProject"]', function () {
        var $that = $(this);
        layui.layer.open({
            type: 2,
            title: '选择工程项目',
            area: ['80%', '80%'],
            maxmin: true,
            btnAlign: 'c',
            btn: ['确定'],
            content: ['/PlbCustomer/projectEngineering'].join(''),
            yes: function (index, layero) {
                var checkData = $(layero).find("iframe")[0].contentWindow.yesBtn();
                if (checkData != undefined) {
                    if (checkData.length > 0) {
                        $that.val(checkData[0].projName);
                        $that.attr('projId', checkData[0].projId);
                        layer.close(index)
                    } else {
                        return
                    }
                }
            }
        });
    })
</script>

<script type="text/javascript" src="/js/planbudget/kingDee.js?20211025.4"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>
</body>
</html>
