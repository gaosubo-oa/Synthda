<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 17:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>合同付款-新增页面</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js?20210817.1"></script>
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
        .layui-table-cell .layui-form-checkbox[lay-skin=primary]{
            top:5px
        }
        .layui-table-view .layui-form-radio{
            line-height:30px;
        }
        .footer {
            position: absolute;
            width: 99%;
            height: 60px;
            line-height: 60px;
            text-align: center;
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="usersId" class="layui-input">
    <input type="hidden" id="deptsId" class="layui-input">
    <div class="layui-collapse">
        <%--/* region 合同付款 */--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">单据编号</h2>
            <div class="layui-colla-content layui-show plan_base_info">
                <form class="layui-form" id="baseForm" lay-filter="formTest">
                    <%--/* region 第一行 */--%>
                    <div class="layui-row">
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">单据编号<span class="field_required">*</span><a title="刷新编号" id="shua" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="contractNo" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="单据编号">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">客商单位名称<span class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>
                                    <input type="text" name="customerName" autocomplete="off" readonly style="cursor: pointer;background: #e7e7e7" class="layui-input chooseCustomerName testNull" title="客商单位名称">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">合同名称</label>
                                <div class="layui-input-block form_block">
                                    <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>
                                    <input type="text" name="contractName" placeholder="查找合同" readonly autocomplete="off" class="layui-input chooseSubcontract" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <%--/* endregion */--%>
                <%--/* region 第二行 */--%>
                <form class="layui-form" id="baseForm1" lay-filter="formTest">
                    <div class="layui-row">
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">合同金额（元）</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="contractMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">累计已结算金额（元）</label>
                                <div class="layui-input-block form_block">
                                    <input type="number" name="accumulatedSettlatedAmount" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">累计已结算比例</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" id="cumulativeSettledRatio"  name="cumulativeSettledRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--/* endregion */--%>
                    <%--/* region 第二行 */--%>
                    <div class="layui-row">
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">累计已支付金额（元）</label>
                                <div class="layui-input-block form_block">
                                    <input type="number" name="accumulatedAmountPaid" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">累计已支付比例</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="cumulativePaidProportion" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">款项性质<span field="naturePayment" class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <select  name="naturePayment" lay-filter="naturePayment"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">发起类型<span class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <select id="initiationType" class="testNull" name="initiationType" lay-filter="initiationType" title="发起类型"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">本次支付金额<span class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="payMoney" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input testNull" title="本次支付金额">
                                </div>
                            </div>
                        </div>
                        <%--                    <div class="layui-col-x12" style="padding: 0 5px;">--%>
                        <%--                        <div class="layui-form-item">--%>
                        <%--                            <label class="layui-form-label form_label">付款事由<span class="field_required">*</span></label>--%>
                        <%--                            <div class="layui-input-block form_block">--%>
                        <%--                                <textarea name="paymentReason" style="background: #e7e7e7" class="layui-textarea testNull" title="付款事由"></textarea>--%>
                        <%--                            </div>--%>
                        <%--                        </div>--%>
                        <%--                    </div>--%>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">付款事由<span class="field_required">*</span></label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="paymentReason" autocomplete="off" class="layui-input testNull" title="付款事由">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row">
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">工程项目</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="enginProject" style="background: #e7e7e7" readonly  autocomplete="off" class="layui-input" title="工程项目">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">工程合同</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="enginContract" style="background: #e7e7e7" readonly  autocomplete="off" class="layui-input" title="工程合同">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">研发项目</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="developProject" style="background: #e7e7e7" readonly autocomplete="off" class="layui-input" title="研发项目">
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--/* endregion */--%>
                    <%--/* region 第二行 */--%>
                    <div class="layui-row">

                    </div>
                    <%--/* endregion */--%>
                    <%--/* region 第二行 */--%>
                    <div class="layui-row">
                        <div class="layui-col-xs12" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">合同付款条件</label>
                                <div class="layui-input-block form_block">
                                    <textarea name="paymentCondition" readonly style="background: #e7e7e7" class="layui-textarea"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;display: none">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">经办人</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="createUser" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;display: none">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">发起部门</label>
                                <div class="layui-input-block form_block">
                                    <input type="text" name="deptName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-xs4" style="padding: 0 5px;display: none">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">是否分摊</label>
                                <div class="layui-input-block form_block">
                                    <input type="radio" name="ifShare" value="1" title="是">
                                    <input type="radio" name="ifShare" value="0" title="否" checked>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--/* endregion */--%>
                    <%--/* region 第四行 */--%>
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
                    <%--/* endregion */--%>
                    <%--/* region 第五行 */--%>
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
                    <%--/* endregion */--%>
                    <%--/* region 第四行 */--%>
                    <div class="layui-row">
                        <div class="layui-col-xs12" style="padding: 0 5px;">
                            <div class="layui-form-item">
                                <label class="layui-form-label form_label">结算合同附件</label>
                                <div class="layui-input-block form_block">
                                    <div class="file_module">
                                        <div id="fileContent3" class="file_content"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--/* endregion */--%>
                    <%--/* region 第七行 */--%>
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
                                                <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">
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
                </form>
            </div>
        </div>

        <%--/* region 結算信息 */--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">结算信息</h2>
            <div class="layui-colla-content seti_info layui-show">
                <div>
                    <table id="infoTable" lay-filter="infoTable"></table>
                </div>
            </div>
        </div>
        <%--/* region 合同付款明细 */--%>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">付款明细</h2>
            <div class="layui-colla-content pym_info layui-show">
                <div>
                    <table id="paymentTable" lay-filter="paymentTable"></table>
                </div>
            </div>
        </div>
        <div class="footer">
            <button type="button" class="layui-btn layui-btn-normal" id="saveBtn">保存</button>
            <button type="button" class="layui-btn layui-btn-warm" id="submitBtn">提交</button>
            <button type="button" class="layui-btn layui-btn-primary" id="closeBtn">关闭</button>
            <%--<button type="button" class="layui-btn layui-btn-warm" id="reSubmitBtn" style="display: none;">提交</button>--%>
        </div>
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
    var type = $.GetRequest()['type'] || '';
    var deptId = $.GetRequest()['deptId'] || '';
    var contractId = $.GetRequest()['contractId'] || '';
    var xhr = null;
    var subpaymentId = ''
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name = $(this).attr('name')
        $('.query_module [name=' + name + ']').val($.cookie(name) || '')
    })

    $(document).on('click', '.userAdd', function () {
        // var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : ''
        // user_id = $(this).siblings('textarea').attr('id')
        // $.popWindow("/common/selectUser" + chooseNum);
        user_id = $(this).attr('id')
        $.popWindow("../../common/selectUser?0");
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
        PAYMENT_METHOD: {},
        RBS_TYPE: {},
        RBS_CATEGORY: {},
        CBS_LEVEL: {},
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,PAYMENT_METHOD,RBS_TYPE,RBS_CATEGORY,CBS_LEVEL';
    var abc={
        plbDictNos: dictionaryStr
    }
    var resdic=toAjaxTs('/plbDictonary/selectDictionaryByDictNos',abc);
    if (resdic.flag) {
        for (var dict in dictionaryObj) {
            dictionaryObj[dict] = {object: {}, str: ''}
            if (resdic.object[dict]) {
                resdic.object[dict].forEach(function (item) {
                    dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                    dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                });
            }
        }
    }
    var infoTableData;
    var dataAll = parent.dataAll;
    var urls = ''
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
        var collectionUserTable = null;
        var jsmaterialsTable = null;
        var layTable = layui.table;

        form.render();
        if (type == '0' || type == 0) {
            title = '新建合同付款';
            urls = '/plbContractInfo/insertContract';
        } else if (type == '1' || type == 1) {
            title = '编辑合同付款';
            urls = '/plbContractInfo/updatePlbMtlSubsettleup';
        } else if (type == 4 || type == '4') {
            title = '查看详情';
        }
        if(type == 0){
            // 获取自动编号
            getAutoNumber({autoNumber: 'plbContractPayment'}, function (res) {
                $('input[name="contractNo"]', $('#baseForm')).val(res);
            });
            $('.refresh_no_btn').show().on('click', function () {
                getAutoNumber({autoNumber: 'plbContractPayment'}, function (res) {
                    $('input[name="contractNo"]', $('#baseForm')).val(res);
                });
            });
            // 获取主键
            $.get('/plbDeptReimburse/getUUID', function (res) {
                subpaymentId = res;
                contractId = res;
            });
        }
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
            url:'/plbDictonary/selectDictionaryByNo',
            data:{plbDictNo:'TRAVEL_TYPE',plbDictNo1:'06'},
            async:false,
            success:function(res){
                var travelTypStr = '';
                res.data.forEach(function (item) {
                    travelTypStr += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                })
                $('select[name="naturePayment"]').html(travelTypStr);
                form.render()
            }
        });

        fileuploadFn('#fileupload', $('#fileContent'));
        // 获取当前登录人信息(经办人)
        getUserInfo('', function (res) {
            if (res.object) {
                $('[name="createUser"]', $('#baseForm')).attr('user_id', res.object.userId).val(res.object.userName);
                $('[name="createUser"]', $('#baseForm')).attr('deptId', res.object.deptId).attr('deptName', res.object.deptName);
                $('#usersId').attr('user_id', res.object.userId).val(res.object.userName);
                initKingDee(res.object.userId)
            }
        });
        var materialDetailsTableData = [];
        var paymentTableData = [];
        //回显数据
        if (type == 1 || type == 4 || type == '1' || type == '4') {
            $('#shua').hide()
            var a={
                contractId:contractId
            }
            var resd=toAjaxT('/plbContractInfo/getContractPaymentById',a);
            var data = resd.data;
            subpaymentId = data.plbContractPaymentWithBLOBs.subpaymentId
            materialDetailsTableData=data.plbContractSettleDataList
            paymentTableData=data.plbDeptSubpaymentPayments
            //回显是否分摊
            $('input[name="ifShare"]').each(function () {
                if ($(this).val() == data.ifShare) {
                    $(this).prop('checked', 'checked')
                    form.render()
                }
            })

            $("#deptsId").attr('deptName',data.deptId + ',|' + data.deptName + ',');
            form.val("formTest", data);
            $('#usersId').val(data.createUser + ',|' + data.createUserName + ',')
            infoTableData = data

            //工程项目
            if(data.plbProj == undefined){
                $("input[name='enginProject']").val('')
            }else{
                var projName = data.plbProj.projName
                $("input[name='enginProject']").val(projName)
                $("input[name='enginProject']").attr('projId',data.plbProj.projId)
            }
            //工程合同
            if(data.plbDeptSubcontract == undefined){
                $("input[name='enginContract']").val('')
            }else{
                var contractName = data.plbDeptSubcontract.contractName
                $("input[name='enginContract']").val(contractName)
                $("input[name='enginContract']").attr('subcontractId',data.plbDeptSubcontract.subcontractId)
            }
            //研发项目
            if(data.srmsPjProject == undefined){
                $("input[name='developProject']").val('')
            }else{
                var pjName = data.srmsPjProject.pjName
                $("input[name='developProject']").val(pjName)
                $("input[name='developProject']").attr('pjNumber',data.srmsPjProject.pjNumber)
            }
            //单据编号
            $("input[name='contractNo']").val(data.contractNo)
            // 客商单位id
            $('.plan_base_info input[name="customerName"]').attr('customerId', data.customerId || '');
            // 合同id
            $('.plan_base_info input[name="contractName"]').attr('subcontractId', data.subcontractId || '');
            //结算id
            $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId', data.subsettleupId || '');
            //累计已结算比例
            $('.plan_base_info input[name="cumulativeSettledRatio"]').val(data.plbContractPaymentWithBLOBs.cumulativeSettledRatio);
            //累计已支付比例
            $('.plan_base_info input[name="cumulativePaidProportion"]').val(data.plbContractPaymentWithBLOBs.cumulativePaidProportion);
            //款项性质
            $('.plan_base_info input[name="naturePayment"]').val(data.plbContractPaymentWithBLOBs.naturePayment);
            //付款事由
            $('.plan_base_info input[name="paymentReason"]').val(data.plbContractPaymentWithBLOBs.paymentReason);
            //合同付款条件
            $('.plan_base_info textarea[name="paymentCondition"]').text(data.plbContractPaymentWithBLOBs.paymentCondition);
            // //累计已结算比例
            // $('.plan_base_info input[name="cumulativeSettledRatio"]').val(numberFormat(data.plbContractPaymentWithBLOBs.cumulativeSettledRatio, 2));
            // //款项性质
            // $('.plan_base_info input[name="naturePayment"]').val(numberFormat(data.plbContractPaymentWithBLOBs.naturePayment, 2));
            // //付款事由
            // $('.plan_base_info input[name="paymentReason"]').val(numberFormat(data.plbContractPaymentWithBLOBs.paymentReason, 2));
            // //合同付款条件
            // $('.plan_base_info input[name="paymentCondition"]').val(numberFormat(data.plbContractPaymentWithBLOBs.paymentCondition, 2));
            //累计已结算金额
            $('.plan_base_info input[name="accumulatedSettlatedAmount"]').val(keepTwoDecimalFull(data.plbContractPaymentWithBLOBs.accumulatedSettlatedAmount));
            $('.plan_base_info input[name="accumulatedAmountPaid"]').val(keepTwoDecimalFull(data.plbContractPaymentWithBLOBs.accumulatedAmountPaid));
            $('.plan_base_info input[name="currentSettlementAmount"]').val(keepTwoDecimalFull(data.currentSettlementAmount));
            $('.plan_base_info input[name="payMoney"]').val(keepTwoDecimalFull(data.plbContractPaymentWithBLOBs.payMoney));

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
                        $('.plan_base_info input[name="contractMoney"]').val(res.object.contractMoney ? keepTwoDecimalFull(res.object.contractMoney) : '/');
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
            // if(data.contractId){
            //     var a={
            //         contractId:data.contractId
            //     }
            //     var resd=toAjaxT('/plbContractInfo/getContractPaymentById',a);
            //     if (resd.flag) {
            //         materialDetailsTableData = resd.data.plbContractSettleDataList
            //         // paymentTableData = resd.data.plbDeptSubpaymentPayments
            //         resd.data.plbDeptSubpaymentPayments.forEach(function (item,i) {
            //             var newobj = {}
            //             newobj = item
            //             var resds=toAjaxTs('/user/findUserByuserId',{userId:item.collectionUser});
            //             if (resds.object && resds.object.userExt){
            //                 newobj.collectionAccount = resds.object.userExt.bankCardNumber || '';
            //                 newobj.collectionBank = resds.object.userExt.bankDeposit || '';
            //                 newobj.collectionBankName = resds.object.userExt.bankDepositName || '';
            //                 newobj.collectionUserName = resds.object.userName || '';
            //             }
            //             paymentTableData.push(newobj)
            //         });
            //     }
            // }
            if (type == 4 || type == '4') {
                $('input').attr('disabled','true')
                $('textarea').attr('disabled','true')
                $('select').attr('disabled','true')
                $('button[lay-event="add"]').css('display','none')
                $('#saveBtn').css('display','none')
                $('#submitBtn').css('display','none')
                $('#reSubmitBtn').css('display','none')
                $('input[name="initiationType"]').css('display','none')
                $('.layui-layer-btn-c').hide()
                $('[name="customerName"]').attr('disabled', 'true')
                $('[name="paymentReason"]').attr('disabled', 'true')
                $('[name="naturePayment"]').attr('disabled', 'true')
                $('.file_upload_box').hide()
                $('.deImgs').hide()
                $('.chooseSettlement').hide()
            }

            if (data.relationImageUrl) {
                $('#baseForm').parent().append('<button class="layui-btn layui-btn-sm" id="preview">查看发票</button>');
                $('#preview').on('click', function () {
                    window.open(data.relationImageUrl + '&userId=' + data.createUser);
                });
            }

        }
        element.render();
        form.render();


        //结算信息
        var cols3 = [
            {type: 'numbers', title: '序号'},
            {
                field: 'settleId',
                title: '结算单号',
                minWidth: 120,
                templet: function (d) {
                    return '<input type="text" name="settleId" dataId="' + (d.dataId || '') + '"  settleId="' + (d.settleId || '') + '"  value="' + (isShowNulls(d.settleNo) || '') + '"  readonly autocomplete="off" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChooses') + '" style="height: 100%;" >'
                }
            },
            {
                field: 'rbsItemId',
                title: '往来科目<span style="color: #f00;font-size: 16px;">*</span>',
                minWidth: 120,
                templet: function (d) {
                    return '<input type="text" name="rbsItemId" cbsId="' + (d.cbsId || '') + '" rbsItemId="' + (d.rbsItemId || '') + '"   value="' + (isShowNulls(d.rbsItemName) || '') + '"  readonly autocomplete="off" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChoose') + ' testNull" style="height: 100%; cursor: pointer;" title="往来科目">'
                }
            },
            {
                field: 'expenseItem',
                title: '费用项目',
                minWidth: 120,
                templet: function (d) {
                    return '<input name="expenseItem" type="text" readonly class="layui-input expenseItem" expenseItem="' + isShowNull(d.expenseItem) + '" style="height: 100%;" value="'+(d.expenseItemName||'')+'">';
                }
            },
            {
                field: 'settleupMoney',
                title: '结算金额',
                minWidth: 150,
                templet: function (d) {
                    return '<input readonly name="settleupMoney" type="text" class="layui-input" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNulls(d.settleupMoney) + '">';
                }
            },
            {
                field: 'actualApplicationAmount',
                title: '核销金额',
                minWidth: 150,
                templet: function (d) {
                    return '<input readonly name="actualApplicationAmount" type="text" class="layui-input" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNulls(d.actualApplicationAmount) + '">';
                }
            },
            {
                field: 'paidAmount',
                title: '已支付金额',
                minWidth: 150,
                templet: function (d) {
                    return '<input readonly name="paidAmount" type="text" class="layui-input" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNulls(d.paidAmount) + '">';
                }
            },
            {
                field: 'paymentAmount',
                title: '本次支付金额',
                minWidth: 150,
                templet: function (d) {
                    return '<input name="paymentAmount" type="text" pointFlag="1" class="layui-input paymentAmount input_floatNum" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNulls(d.paymentAmount) + '">';
                }
            },
            {
                field: 'prepaidBalance',
                title: '未支付余额',
                minWidth: 150,
                templet: function (d) {
                    return '<input name="prepaidBalance"  readonly type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.prepaidBalance) + '">';
                }
            },
            {
                field: 'remark',
                title: '备注',
                minWidth: 150,
                templet: function (d) {
                    return '<input name="remark" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.remark) + '">';
                }
            }
        ]
        if (type != 4) {
            cols3.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
        }
        table.render({
            elem: '#infoTable',
            // elem: '#materialDetailsTable',
            data: materialDetailsTableData,
            toolbar: '#toolbarDemoIn',
            defaultToolbar: [''],
            limit: 1000,
            cols: [cols3],
            done: function () {
                if (type == 4) {
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
                    return '<input readonly type="text"  name="collectionBank" collectionBankNo="' + d.collectionBank + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.collectionBankName).replace(/,$/, '') + '">';
                }
            },
            {
                field: 'collectionMoney',
                title: '收款金额',
                minWidth: 150,
                templet: function (d) {

                    return '<input type="text" name="collectionMoney" pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.collectionMoney) + '">';
                }
            },
            {
                field: 'remarks', title: '备注', minWidth: 300, templet: function (d) {

                    return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remarks) + '">';
                }
            }
        ]
        if (type != 4) {
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
            }
        });

        // 付款明细内部加行按钮
        table.on('toolbar(paymentTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    var customerid = $('input[name="customerName"]').attr('customerid')
                    if(customerid != '' && customerid != undefined){
                        //遍历表格获取每行数据进行保存
                        var $tr = $('.pym_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
                                collectionUser: '',
                                customerId: '',
                                collectionAccount: $(this).find('input[name="collectionAccount"]').val(),
                                collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo'),
                                collectionBankName:$(this).find('input[name="collectionBank"]').val(),
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
                        var a={
                            customerId:customerid
                        }
                        var resd=toAjaxT('/PlbCustomer/queryId',a);
                        var newObj = {
                            customerName: $('input[name="customerName"]').val()||'',
                            customerId: customerid,
                            paymentType: '02',
                            collectionMoney:$('input[name="payMoney"]').val().replace(/,/g,'')||'0',
                        }
                        if (resd.data && resd.data.plbCustomerBankList) {
                            if(resd.data.plbCustomerBankList.length>1){
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
                                            data: resd.data.plbCustomerBankList,
                                            page: false,
                                            limit: 10000,
                                            cols: [[
                                                {type: 'radio', title: '选择'},
                                                {field:'accountType',title:'账号类型',templet:function(d){
                                                        if(d.accountType==0){
                                                            return  '<span name="accountType" customerId='+d.customerId+' customerName='+ d.customerName+'>基本户</span>'
                                                        }else{
                                                            return  '<span name="accountType" customerId='+d.customerId+' customerName='+ d.customerName+'>其他户</span>'
                                                        }
                                                    }
                                                },
                                                {field:'bankAccount',title:'银行账号'},
                                                {field:'bankOfDepositName',title:'开户行'},
                                                {field:'bankOfDeposit',title:'银行行号'}
                                            ]]
                                        });
                                    },
                                    yes: function (index) {
                                        var checkStatus = table.checkStatus('collectionBank');
                                        if (checkStatus.data.length > 0) {
                                            newObj.collectionAccount = checkStatus.data[0].bankAccount || '';
                                            newObj.collectionBank = checkStatus.data[0].bankOfDeposit || '';
                                            newObj.collectionBankName = checkStatus.data[0].bankOfDepositName || '';
                                            layer.close(index);
                                            oldDataArr.push(newObj);
                                            table.reload('paymentTable', {
                                                data: oldDataArr
                                            });
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                })
                            }else{
                                if(resd.data.plbCustomerBankList.length == 1){
                                    newObj.collectionAccount = resd.data.plbCustomerBankList[0].bankAccount || '';
                                    newObj.collectionBank = resd.data.plbCustomerBankList[0].bankOfDeposit || '';
                                    newObj.collectionBankName = resd.data.plbCustomerBankList[0].bankOfDepositName || '';
                                }else{
                                    newObj.collectionAccount = '';
                                    newObj.collectionBank = '';
                                    newObj.collectionBankName = '';
                                }
                                oldDataArr.push(newObj);
                                table.reload('paymentTable', {
                                    data: oldDataArr
                                });
                            }
                        }

                    }else{
                        layer.msg('请先选择客商');
                        return false
                    }
                    break;
            }
        });

        table.on('toolbar(infoTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.seti_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            dataId:$(this).find('input[name="settleId"]').attr('dataId'),
                            settleId: $(this).find('input[name="settleId"]').attr('settleId'),
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'),
                            cbsId: $(this).find('input[name="rbsItemId"]').attr('cbsId'),
                            settleNo: $(this).find('input[name="settleId"]').val(),
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(),
                            settleupMoney: $(this).find('input[name="settleupMoney"]').val(),
                            actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),
                            paidAmount: $(this).find('input[name="paidAmount"]').val(),
                            paymentAmount: $(this).find('input[name="paymentAmount"]').val(),
                            prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                            remark: $(this).find('input[name="remark"]').val(),//备注
                            expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                            expenseItemName: $(this).find('input[name="expenseItem"]').val(), // 费用项目
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    var addRowData = {};
                    oldDataArr.push(addRowData);
                    table.reload('infoTable', {
                        data: oldDataArr
                    });
                    break;
            }
        });

        window.ppp = function(a,d){
            $('.layui-table-click [name="collectionUser"]').val(a)
            $('.layui-table-click [name="collectionUser"]').attr('customerId',d.customerId)
            $('.layui-table-click [name="collectionAccount"]').val(d.bankAccount)
            $('.layui-table-click [name="collectionBank"]').val(d.bankOfDepositName)
            $('.layui-table-click [name="collectionBank"]').attr("collectionbankNo",d.bankOfDeposit);
        }

        // 付款明细内部删行操作
        table.on('tool(paymentTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if(type == 4){
                layEvent = ''
            }
            if (layEvent === 'del') {
                obj.del();
                if (data.subpaymentPaymentId) {
                    $.get('/plbContractInfo/delSubpaymentPayment', {subpaymentPaymentId: data.subpaymentPaymentId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
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
                                type: 2,
                                title: '选择收款人',
                                area: ['70%', '80%'],
                                btn:['确定'],
                                maxmin: true,
                                btnAlign: 'c',
                                content: ['/PlbCustomer/payee'].join(''),
                                yes: function (index,layero) {
                                    $(layero).find("iframe")[0].contentWindow.yesBtn();
                                }
                            });
                        });
                    }
                });
            }
        });

        // 结算信息内部删行操作
        table.on('tool(infoTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if(type == 4){
                layEvent = ''
            }
            if (layEvent === 'del') {
                obj.del();
                if (data.dataId) {
                    $.get('/plbContractInfo/delContractSettleData', {dataId: data.dataId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.seti_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        dataId:$(this).find('input[name="settleId"]').attr('dataId'),
                        settleId: $(this).find('input[name="settleId"]').attr('settleId'),
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'),
                        cbsId: $(this).find('input[name="rbsItemId"]').attr('cbsId'),
                        settleNo: $(this).find('input[name="settleId"]').val(),
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(),
                        settleupMoney: $(this).find('input[name="settleupMoney"]').val(),
                        actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),
                        paidAmount: $(this).find('input[name="paidAmount"]').val(),
                        paymentAmount: $(this).find('input[name="paymentAmount"]').val(),
                        prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                        remark: $(this).find('input[name="remark"]').val(),//备注
                        expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                        expenseItemName: $(this).find('input[name="expenseItem"]').val(), // 费用项目
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('infoTable', {
                    data: oldDataArr
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

        // 保存
        $(document).on('click', '#saveBtn', function (){
            //必填项提示
            // for (var i = 0; i < $('.testNull').length; i++) {
            //     if ($('.testNull').eq(i).val() == '') {
            //         layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
            //         return false
            //     }
            // }
            //本次支付金额不得大于
            // （1）合同余额：合同金额-累计已付款（不含本次）
            // （2）结算余额：累计结算（含本次）-累计已付款（不含本次）
            // （3）预算余额：年度预算-累计已付款（不含本次）
            var a = $("input[name='payMoney']").val().replace(/,/g,'');
            var e = $("input[name='paymentAmount']")

            var d = [];
            var sum = 0;
            var sums = 0;
            // var ppp;
            var f = $("input[name='collectionMoney']");
            for(var i=0;i<e.length;i++){
                d.push($("input[name='paymentAmount']").eq(i).val())
                sum += parseFloat($("input[name='paymentAmount']").eq(i).val())
            }
            for(var m=0;m<f.length;m++){
                d.push($("input[name='collectionMoney']").eq(m).val())
                sums += parseFloat($("input[name='collectionMoney']").eq(m).val().replace(',',''))
            }
            if(a != sum){
                layer.msg('结算信息本次支付总额与付款明细收款金额总额不一致', {icon: 0});
                return false
            }
            if(a != sums){
                layer.msg('结算信息本次支付总额与付款明细收款金额总额不一致', {icon: 0});
                return false
            }
            if(sum != sums){
                layer.msg('结算信息本次支付总额与付款明细收款金额总额不一致', {icon: 0});
                return false
            }


            var loadIndex = layer.load();
            //材料计划数据
            var datas = $('#baseForm').serializeArray();
            var datass = $('#baseForm1').serializeArray();
            var obj = {}
            var plbContractPaymentWithBLOBs  = {}
            datas.forEach(function (item) {
                obj[item.name] = item.value
            });
            datass.forEach(function (item) {
                plbContractPaymentWithBLOBs[item.name] = item.value
            });
            plbContractPaymentWithBLOBs.accumulatedAmountPaid = parseFloat(plbContractPaymentWithBLOBs.accumulatedAmountPaid)
            plbContractPaymentWithBLOBs.accumulatedSettlatedAmount = parseFloat(plbContractPaymentWithBLOBs.accumulatedSettlatedAmount)
            plbContractPaymentWithBLOBs.payMoney=plbContractPaymentWithBLOBs.payMoney.replace(/,/g,'');
            //合同id
            obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //客商单位名称id
            obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');

            if(obj.enginProject == undefined){
                obj.enginProject = ''
            }
            if(obj.enginContract == undefined){
                obj.enginContract = ''
            }
            if(obj.developProject == undefined){
                obj.developProject = ''
            }

            obj.contractMoney = obj.contractMoney == '/' ? '' : $('.plan_base_info input[name="contractMoney"]').val();
            plbContractPaymentWithBLOBs.contractMoney = plbContractPaymentWithBLOBs.contractMoney == '/' ? '' : $('.plan_base_info input[name="contractMoney"]').val();
            if(obj.contractMoney == '/'){
                obj.contractMoney = ''
            }
            if(plbContractPaymentWithBLOBs.contractMoney == '/'){
                plbContractPaymentWithBLOBs.contractMoney = ''
            }
            obj.initiationType = $("#initiationType").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value")
            obj['plbContractPaymentWithBLOBs'] = plbContractPaymentWithBLOBs;
            obj.enginProject = $("input[name='enginProject']").attr('projId')
            obj.enginContract = $("input[name='enginContract']").attr('subcontractId')
            obj.developProject = $("input[name='developProject']").attr('pjNumber')
            obj.naturePayment=$('[name="naturePayment"]').val();
            obj.attachmentNum=$('[name="attachmentNum"]').val();
            // 附件
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            obj.attachmentId = attachmentId;
            obj.attachmentName = attachmentName;
            obj.contractType = '02'
            //结算信息明细数据
            var $tr = $('.seti_info').find('.layui-table-main tr');
            var materialDetailsArr = [];
            var _flay = false
            $tr.each(function () {
                var materialDetailsObj = {
                    dataId:$(this).find('input[name="settleId"]').attr('dataId'),
                    settleId: $(this).find('input[name="settleId"]').attr('settleId'),
                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'),
                    cbsId: $(this).find('input[name="rbsItemId"]').attr('cbsId'),
                    settleNo: $(this).find('input[name="settleId"]').val(),
                    rbsItemName: $(this).find('input[name="rbsItemId"]').val(),
                    settleupMoney: $(this).find('input[name="settleupMoney"]').val(),
                    actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),
                    paidAmount: $(this).find('input[name="paidAmount"]').val(),
                    paymentAmount: $(this).find('input[name="paymentAmount"]').val(),
                    prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                    remark: $(this).find('input[name="remark"]').val(),//备注
                    expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                }
                //本次支付金额<=结算金额-核销金额-已支付金额
                if(subtr(materialDetailsObj.paymentAmount,subtr(subtr(materialDetailsObj.settleupMoney,materialDetailsObj.actualApplicationAmount),materialDetailsObj.paidAmount)) >0){
                    layer.msg('本次支付金额<=结算金额-核销金额-已支付金额', {icon: 0});
                    _flay = true
                    layer.close(loadIndex)
                    return
                }
                materialDetailsArr.push(materialDetailsObj);
            });
            obj.plbContractSettleDataList = materialDetailsArr;

            if(_flay){
                var loadIndex = layer.load();
                return
            }
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
                    collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                    collectionMoney: $(this).find('input[name="collectionMoney"]').val().replace(',',''),
                    remarks: $(this).find('input[name="remarks"]').val(),
                }
                if ($(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')) {
                    paymentObj.subpaymentPaymentId = $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId');
                }else{
                    paymentObj.subpaymentPaymentId = ''
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


            if (type == '0' || type == 0) {
                obj.contractId = contractId
            }
            if (type == '1' || type == 1) {
                obj.contractId = data.contractId
            }
            if (type == 1) {
                obj.subpaymentId = data.subpaymentId
                obj.plbContractPaymentWithBLOBs.subpaymentId = subpaymentId
                obj.contractInfoName=infoTableData.contractInfoName
            }
            if (subpaymentId) {
                obj.subpaymentId = subpaymentId
            }
            obj.deptId = parseInt(deptId);

            //经办人
            obj.createUser = $('#usersId').attr('user_id')
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
            $.ajax({
                url: urls,
                data: JSON.stringify(obj),
                dataType: 'json',
                type: 'post',
                async: false,
                contentType: "application/json;charset=UTF-8",
                success: function (res) {
                    layer.close(loadIndex);
                    if (res.flag) {
                        layer.msg('保存成功！', {icon: 1});
                        // layer.closeAll()
                        // tableIns.config.where._ = new Date().getTime();
                        // tableIns.reload();
                        if(type == 0 || type == "0"){
                            location.href = '/plbContractInfo/paymentAddandEdit?type=1&deptId='+ deptId + '&&contractId='+contractId
                        }else{
                            location.reload();
                        }
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                }
            });
        })
        // 提交
        $(document).on('click', '#submitBtn', function (){
            var collectionAccountArrr = [];
            $('input[name="collectionAccount"]').each(function () {
                if($(this).val() != ''){
                    collectionAccountArrr.push($(this).val())
                }
            });
            var collectionBankArrr = []
            $('input[name="collectionBank"]').each(function () {
                if($(this).val() != ''){
                    collectionBankArrr.push($(this).val())
                }
            });
            if((collectionAccountArrr.length == $('input[name="collectionAccount"]').length) && (collectionBankArrr.length == $('input[name="collectionBank"]').length)){
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

                var a = $("input[name='payMoney']").val().replace(/,/g,'');
                var e = $("input[name='paymentAmount']")

                var d = [];
                var sum = 0;
                var sums = 0;
                // var ppp;
                var f = $("input[name='collectionMoney']");
                for(var i=0;i<e.length;i++){
                    d.push($("input[name='paymentAmount']").eq(i).val())
                    sum += parseFloat($("input[name='paymentAmount']").eq(i).val())
                }
                for(var m=0;m<f.length;m++){
                    d.push($("input[name='collectionMoney']").eq(m).val())
                    sums += parseFloat($("input[name='collectionMoney']").eq(m).val().replace(',',''))
                }
                if(a != sum){
                    layer.msg('结算信息本次支付总额与付款明细收款金额总额不一致', {icon: 0});
                    return false
                }
                if(a != sums){
                    layer.msg('结算信息本次支付总额与付款明细收款金额总额不一致', {icon: 0});
                    return false
                }
                if(sum != sums){
                    layer.msg('结算信息本次支付总额与付款明细收款金额总额不一致', {icon: 0});
                    return false
                }


                //材料计划数据
                var datas = $('#baseForm').serializeArray();
                var datass = $('#baseForm1').serializeArray();
                var obj = {}
                var plbContractPaymentWithBLOBs  = {}
                datas.forEach(function (item) {
                    obj[item.name] = item.value
                });

                datass.forEach(function (item) {
                    plbContractPaymentWithBLOBs[item.name] = item.value
                });
                plbContractPaymentWithBLOBs.accumulatedAmountPaid = parseFloat(plbContractPaymentWithBLOBs.accumulatedAmountPaid)
                plbContractPaymentWithBLOBs.accumulatedSettlatedAmount = parseFloat(plbContractPaymentWithBLOBs.accumulatedSettlatedAmount)
                plbContractPaymentWithBLOBs.payMoney=plbContractPaymentWithBLOBs.payMoney.replace(/,/g,'');
                //合同id
                obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
                //客商单位名称id
                obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');

                //结算id
                // obj.subsettleupId = $('.plan_base_info input[name="currentSettlementAmount"]').attr('subsettleupId');
                if(obj.enginProject == undefined){
                    obj.enginProject = ''
                }
                if(obj.enginContract == undefined){
                    obj.enginContract = ''
                }
                if(obj.developProject == undefined){
                    obj.developProject = ''
                }

                obj.contractMoney = obj.contractMoney == '/' ? '' : $('.plan_base_info input[name="contractMoney"]').val();
                plbContractPaymentWithBLOBs.contractMoney = plbContractPaymentWithBLOBs.contractMoney == '/' ? '' : $('.plan_base_info input[name="contractMoney"]').val();
                if(obj.contractMoney == '/'){
                    obj.contractMoney = ''
                }
                if(plbContractPaymentWithBLOBs.contractMoney == '/'){
                    plbContractPaymentWithBLOBs.contractMoney = ''
                }
                obj.initiationType = $("#initiationType").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value")
                obj['plbContractPaymentWithBLOBs'] = plbContractPaymentWithBLOBs;
                obj.enginProject = $("input[name='enginProject']").attr('projId')
                obj.enginContract = $("input[name='enginContract']").attr('subcontractId')
                obj.developProject = $("input[name='developProject']").attr('pjNumber')
                obj.naturePayment=$('[name="naturePayment"]').val();
                obj.attachmentNum=$('[name="attachmentNum"]').val();
                // 附件
                var attachmentId = '';
                var attachmentName = '';
                for (var i = 0; i < $('#fileContent .dech').length; i++) {
                    attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                    attachmentName += $('#fileContent a').eq(i).attr('name');
                }
                obj.attachmentId = attachmentId;
                obj.attachmentName = attachmentName;
                obj.contractType = '02'

                //结算信息明细数据
                var $tr = $('.seti_info').find('.layui-table-main tr');
                var materialDetailsArr = [];
                var _flay = false
                $tr.each(function () {
                    var materialDetailsObj = {
                        dataId:$(this).find('input[name="settleId"]').attr('dataId'),
                        settleId: $(this).find('input[name="settleId"]').attr('settleId'),
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'),
                        cbsId: $(this).find('input[name="rbsItemId"]').attr('cbsId'),
                        settleNo: $(this).find('input[name="settleId"]').val(),
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(),
                        settleupMoney: $(this).find('input[name="settleupMoney"]').val(),
                        actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),
                        paidAmount: $(this).find('input[name="paidAmount"]').val(),
                        paymentAmount: $(this).find('input[name="paymentAmount"]').val(),
                        prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),
                        remark: $(this).find('input[name="remark"]').val(),//备注,
                        expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                    }
                    //本次支付金额<=结算金额-核销金额-已支付金额
                    if(subtr(materialDetailsObj.paymentAmount,subtr(subtr(materialDetailsObj.settleupMoney,materialDetailsObj.actualApplicationAmount),materialDetailsObj.paidAmount)) >0){
                        layer.msg('本次支付金额<=结算金额-核销金额-已支付金额', {icon: 0});
                        _flay = true
                        layer.close(loadIndex)
                        return
                    }

                    materialDetailsArr.push(materialDetailsObj);
                });
                obj.plbContractSettleDataList = materialDetailsArr;

                if(_flay){
                    layer.close(loadIndex)
                    return
                }
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
                        collectionBankName:$(this).find('input[name="collectionBank"]').val(),
                        collectionMoney: $(this).find('input[name="collectionMoney"]').val().replace(',',''),
                        remarks: $(this).find('input[name="remarks"]').val(),
                    }
                    if ($(this).find('input[name="paymentType"]').attr('subpaymentPaymentId')) {
                        paymentObj.subpaymentPaymentId = $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId');
                    }else{
                        paymentObj.subpaymentPaymentId = ''
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


                if (type == '0' || type == 0) {
                    obj.contractId = contractId
                }
                if (type == '1' || type == 1) {
                    obj.contractId = data.contractId
                }
                if (type == 1) {
                    obj.subpaymentId = data.subpaymentId
                    obj.contractInfoName=infoTableData.contractInfoName
                }
                if (subpaymentId) {
                    obj.subpaymentId = subpaymentId
                }
                obj.deptId = parseInt(deptId);

                //经办人
                obj.createUser = $('#usersId').attr('user_id')
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

                //判断本次支付金额和合同付款明细需一致
                var collectionMoney = 0
                $('[name="collectionMoney"]').each(function () {
                    collectionMoney = accAdd(collectionMoney, $(this).val())
                });
                var paymentAmounts = 0
                $('[name="paymentAmount"]').each(function () {
                    paymentAmounts = accAdd(paymentAmounts, $(this).val())
                });
                if (collectionMoney != paymentAmounts) {
                    layer.msg('结算中本次支付金额与收款金额不同！', {icon: 0});
                    return false;
                }else{
                    if(collectionMoney !=($('input[name="payMoney"]').val().replace(/,/g,''))){
                        layer.msg('本次支付金额与收款金额不同！', {icon: 0});
                        return false;
                    }
                }
                var loadIndex=layer.load();
                $.ajax({
                    url: urls,
                    data: JSON.stringify(obj),
                    dataType: 'json',
                    type: 'post',
                    async: false,
                    contentType: "application/json;charset=UTF-8",
                    success: function (res) {
                        layer.close(loadIndex);
                        if (res.flag) {
                            subpaymentId = res.object
                            if(type=='0'){
                                var deptNameArr=res.data.deptName.split('/');
                                var deptName=res.data.deptId + ',|' + deptNameArr[deptNameArr.length-1] + ',';
                            }
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '11'}, function (res) {
                                var flowDataArr = []
                                $.each(res.data.flowData, function (k, v) {
                                    flowDataArr.push({
                                        flowId: k,
                                        flowName: v
                                    });
                                });
                                if (type == '0' || type == 0) {
                                    obj.contractId = contractId
                                }
                                if (type == '1' || type == 1) {
                                    obj.contractId = data.contractId
                                }
                                obj.subpaymentId = subpaymentId
                                delete obj.plbContractSettleDataList
                                delete obj.plbDeptSubpaymentPayments
                                var approvalData = obj
                                approvalData.accumulatedAmountPaid=obj.plbContractPaymentWithBLOBs.accumulatedAmountPaid
                                approvalData.accumulatedSettlatedAmount= obj.plbContractPaymentWithBLOBs.accumulatedSettlatedAmount
                                approvalData.contractMoney= obj.plbContractPaymentWithBLOBs.contractMoney
                                approvalData.cumulativePaidProportion= obj.plbContractPaymentWithBLOBs.cumulativePaidProportion
                                approvalData.cumulativeSettledRatio= obj.plbContractPaymentWithBLOBs.cumulativeSettledRatio
                                approvalData.naturePayment= obj.plbContractPaymentWithBLOBs.naturePayment
                                approvalData.paymentCondition= obj.plbContractPaymentWithBLOBs.paymentCondition
                                approvalData.paymentReason= obj.plbContractPaymentWithBLOBs.paymentReason
                                approvalData.payMoney=obj.plbContractPaymentWithBLOBs.payMoney
                                delete approvalData.plbContractPaymentWithBLOBs
                                //经办人
                                if(type=='0'){
                                    approvalData.createUser = $('#usersId').attr('user_id') + ',|' +$('#usersId').val() + ',';
                                }else if(type=='1'){
                                    approvalData.createUser=$('#usersId').val()
                                }

                                approvalData.initiationType = $("#initiationType").next('.layui-form-select').find("dl dd.layui-this").html();
                                if(type == '0' || type == 0){
                                    approvalData.deptName =  deptName
                                }
                                if(type == '1' || type == 1){
                                    approvalData.deptId = $('#deptsId').attr("deptId")
                                    approvalData.deptName = $('#deptsId').attr("deptName")
                                }
                                //是否分摊
                                approvalData.ifShare = obj.ifShare == '1' ? '是' : '否';



                                //遍历付款明细表格获取每行数据
                                var $trs = $('.pym_info').find('.layui-table-main tr');
                                var paymentArr = [];
                                $tr2.each(function () {
                                    var paymentObj = {
                                        paymentType: $(this).find('input[name="paymentType"]').attr('paymentType'),//付款方式
                                        collectionAccount: $(this).find('input[name="collectionAccount"]').val(),//银行账户
                                        collectionBank: $(this).find('input[name="collectionBank"]').val(),//开户行
                                        collectionMoney: $(this).find('input[name="collectionMoney"]').val(),//收款金额
                                        remarks: $(this).find('input[name="remarks"]').val(),//备注
                                        subpaymentPaymentId : $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId'),
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
                                approvalData.plbDeptSubpaymentPayments = payDetails


                                if (flowDataArr.length == 1) {
                                    submitFlow(flowDataArr[0].flowId, approvalData);
                                } else {
                                    layer.open({
                                        type: 1,
                                        title: '选择流程',
                                        area: ['70%', '80%'],
                                        btn: ['确定', '取消'],
                                        btnAlign: 'c',
                                        cancel:function(){
                                            layer.close(loadIndex);
                                            location.href = '/plbContractInfo/paymentAddandEdit?type=1&deptId='+ deptId + '&&contractId='+contractId                                        },
                                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                        success: function () {
                                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '11'}, function (res) {
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
                                            var checkStatus = table.checkStatus('flowTable');
                                            if (checkStatus.data.length > 0) {
                                                var flowData = checkStatus.data[0];

                                                submitFlow(flowData.flowId, approvalData)

                                            } else {
                                                layer.msg('请选择一项！', {icon: 0});
                                            }
                                        },
                                        btn2: function(index){
                                            layer.close(loadIndex);
                                            location.href = '/plbContractInfo/paymentAddandEdit?type=1&deptId='+ deptId + '&&contractId='+contractId                                        }
                                    });
                                }
                            });

                        } else {
                            layer.msg(res.msg, {icon: 2});
                        }
                    }
                });
                return false
            }else {
                layer.open({
                    type: 1,
                    title: ['提示', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['600px', '250px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['关闭'],
                    scrollbar: false,
                    content: '<div>' +
                        '<h2 style="text-align: center;margin-top: 10px">收款账户不能为空</h2>' +
                        '<p style="margin-left: 10px;font-size: 16px">账号信息维护指南：</p>' +
                        '<p style="margin-left: 10px">个人：登录综合系统办公-依次点击右上角个人信息图标（右二）-设置-个人资料-账户信息</p>' +
                        '<p style="margin-left: 10px">客商：登录综合系统办公-左侧菜单依次选择-预算管理-往来单位-客商管理</p></div>'
                })
                return false
            }
        })
        // 关闭
        $(document).on('click', '#closeBtn', function (){
            parent.layer.closeAll()
            parent.layui.table.reload('tableDemo');
        })
        function submitFlow(flowId, approvalData) {
            var loadIndex = layer.load();
            newWorkFlow(flowId, function (res) {
                var submitData = {
                    contractId: approvalData.contractId,
                    runId: res.flowRun.runId,
                    auditerStatus: 1,
                    ifImage: false
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
                                // layer.closeAll();
                                layer.msg('提交成功!', {icon: 1});
                                parent.layer.closeAll()
                                parent.layui.table.reload('tableDemo');
                            });
                        } else {
                            // layer.closeAll();
                            layer.msg('提交成功!', {icon: 1});
                            parent.layer.closeAll()
                            parent.layui.table.reload('tableDemo');
                        }
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                });
            }, approvalData);
        }

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
                        if(xhr){
                            xhr.abort()
                        }
                        xhr = $.ajax({
                            url: '/PlbCustomer/getDataByCondition',
                            data:{
                                merchantType: typeNo,
                                useFlag: true
                            },
                            success:function(res){
                                // console.log(res.data)
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



                        // materialsTable = table.render({
                        //     elem: '#materialsTables',
                        //     url: '/PlbCustomer/getDataByCondition',
                        //     where: {
                        //         merchantType: typeNo,
                        //         useFlag: true
                        //     },
                        //     page: true, //开启分页
                        //     limit: 50,
                        //     cellMinWidth: 180,
                        //     height: 'full-300'
                        //     , toolbar: '#toolbar'
                        //     , defaultToolbar: ['']
                        //     ,
                        //     cols: [[ //表头
                        //         {type: 'radio'}
                        //         , {field: 'customerNo', title: '客商编号', width: 200}
                        //         , {field: 'customerName', title: '客商单位名称', width: 200}
                        //         , {field: 'customerShortName', title: '客商单位简称', width: 200}
                        //         , {field: 'customerOrgCode', title: '组织机构代码'}
                        //         , {field: 'taxNumber', title: '税务登记号'}
                        //         , {field: 'accountNumber', title: '开户行账户'}
                        //     ]], parseData: function (res) {
                        //         return {
                        //             "code": 0, //解析接口状态
                        //             "data": res.data,//解析数据列表
                        //             "count": res.totleNum, //解析数据长度
                        //         };
                        //     },
                        //     request: {
                        //         pageName: 'page' //页码的参数名称，默认：page
                        //         , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        //     },
                        // });
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
                data:searchParams,
                success:function(res){
                    layer.close(loading)
                    console.log(materialsTable)
                    materialsTable.reload({
                        data:res.data,
                    });
                }
            })
            // materialsTable.reload({
            //     where: searchParams,
            //     page: {
            //         curr: 1 //重新从第 1 页开始
            //     }
            // });
        });
        //结算单号查询
        $(document).on('click', '.inSearchDatas', function () {
            var searchParams = {}
            var $seachData = $('#js [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            searchParams.userId = $('[name="userId"]').attr('user_id')
            if(searchParams.userId!=undefined&&searchParams.userId!=''){
                searchParams.userId=searchParams.userId.replace(/,/, '')
            }
            jsmaterialsTable.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });
        // 点击选合同
        $(document).on('click', '.chooseSubcontract', function () {
            if(type != 4 || type != '4'){
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
                            var chooseData = checkStatus.data[0];

                            $('#baseForm [name="contractName"]').val(chooseData.contractName)
                            $('#baseForm [name="contractName"]').attr('subcontractId', chooseData.subcontractId)

                            //合同金额
                            $('#baseForm1 [name="contractMoney"]').val(chooseData.contractMoney ? keepTwoDecimalFull(chooseData.contractMoney) : '/')
                            //合同付款条件
                            $('#baseForm1 [name="paymentCondition"]').val(chooseData.paymentCondition || '')
                            //累计已结算金额
                            $('#baseForm1 [name="accumulatedSettlatedAmount"]').val(keepTwoDecimalFull(chooseData.accumulatedSettlatedAmount) || 0)
                            //累计已结算比例
                            $('#baseForm1 [name="cumulativeSettledRatio"]').val(chooseData.cumulativeSettledRatio || '0%')
                            //累计已支付金额
                            $('#baseForm1 [name="accumulatedAmountPaid"]').val(keepTwoDecimalFull(chooseData.accumulatedAmountPaid) || 0)
                            //累计已支付比例
                            $('#baseForm1 [name="cumulativePaidProportion"]').val(chooseData.cumulativePaidProportion || '0%')

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
            }
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

        //选择结算单号
        $(document).on('click', '.rbsItemIdChooses', function () {
            var _this = $(this);
            // var deptId = _this.parents('tr').find('[name="deptId"]').attr('deptId').replace(/,$/,'')
            // if(!deptId){
            //     layer.msg('请选择费用承担部门！', {icon: 0});
            //     return false;
            // }
            layer.open({
                type: 1,
                title: '选择结算信息',
                area: ['60%', '70%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div style="padding: 0px 10px">' +
                '<div class="query_module_in layui-form layui-row" id="js" style="padding:10px">\n' +
                '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                '                    <input type="text" name="contractNo" placeholder="单据编号" autocomplete="off" class="layui-input">\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                '                    <input type="text" name="customerName" placeholder="客商" autocomplete="off" class="layui-input">\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                '                    <input type="text" name="settleupMoney" placeholder="结算金额" autocomplete="off" class="layui-input">\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                '                    <input type="text" name="userId" id="user" placeholder="报销人" autocomplete="off" class="layui-input userAdd">\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                '                    <button type="button" id="contractNosearch" class="layui-btn layui-btn-sm inSearchDatas">查询</button>\n' +
                '                </div>\n' +
                '</div>' +
                '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                '</div>'].join(''),
                success: function () {

                    jsmaterialsTable = table.render({
                        elem: '#materialsTable',
                        url: '/plbContractInfo/getContractSettle?auditerStatus=2',
                        page: {
                            limit: 10,
                            limits: [10, 20, 30]
                        },
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {
                                field: 'contractNo', title: '单据编号', templet: function (d) {
                                    return d.contractNo || ''
                                }
                            },
                            {
                                field: 'customerName',width:300, title: '客商', templet: function (d) {
                                    return d.customerName || '';
                                }
                            },
                            {field: 'settleupMoney', title: '结算金额', templet: function (d) {
                                    return d.plbContractSettle.settleupMoney || '';
                                }},
                            {field: 'createUser', title: '报销人'},
                            {field: 'createTime', title: '原单据日期'}
                        ]],
                        request: {
                            pageName: 'page' //页码的参数名称，默认：page
                            , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        parseData: function (res) {
                            if(res.flag){
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data,//解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            }else{
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.obj,//解析数据列表
                                    "msg": '无数据'
                                    // "count": res.totleNum, //解析数据长度
                                };
                            }

                        }
                    });
                    //
                    // $(document).on('click', '.inSearchData', function () {
                    //     var rbsItemName = $('.query_module_in [name="contractNo"]').val()
                    //     // loadMtlTable(rbsItemName);
                    // });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        _this.parents('tr').find('input[name="paymentAmount"]').val('');
                        _this.parents('tr').find('input[name="prepaidBalance"]').val('');
                        var mtlData = checkStatus.data[0];
                        $.ajax({
                            url: '/plbContractInfo/selectBySettleData',
                            data: {
                                contractId:mtlData.contractId
                            },
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                if (res.flag) {
                                    layer.close(index);
                                    _this.val(res.data.settleNo);
                                    _this.attr('settleId', res.data.settleId);
                                    _this.parents('tr').find('input[name="settleupMoney"]').val(res.data.settleupMoney)
                                    _this.parents('tr').find('input[name="actualApplicationAmount"]').val(res.data.actualApplicationAmount)
                                    _this.parents('tr').find('input[name="paidAmount"]').val(res.data.paidAmount)
                                    // _this.parents('tr').find('input[name="rbsItemId"]').val(res.data.rbsItemName)
                                    // _this.parents('tr').find('input[name="rbsItemId"]').attr('rbsItemId', res.data.rbsItemId);
                                }
                            }
                        });
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
        $(document).on('click', '.rbsItemIdChoose', function () {
            var _this = $(this);
            // var deptId = _this.parents('tr').find('[name="deptId"]').attr('deptId').replace(/,$/,'')
            // if(!deptId){
            //     layer.msg('请选择费用承担部门！', {icon: 0});
            //     return false;
            // }
            layer.open({
                type: 1,
                title: '往来科目',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    // '<li id="asd" style="display: inline-block;margin-left: 20px;margin-top: 10px;">预算科目</li><li id="zxc" style="display: inline-block;margin-left: 20px">往来科目</li>',
                    // '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">'+
                    // '        <ul class="layui-tab-title">\n' +
                    // '            <li id="zxc" >往来科目</li>\n' +
                    // '        </ul>',
                    // '</div>'+
                    '<table id="budgetLimitTable" lay-filter="budgetLimitTable"></table>',
                    '</div>'].join(''),
                success: function () {
                    // 获取科目
                    layTable.render({
                        elem: '#budgetLimitTable',
                        url: '/plbRbsItem/selectAll',
                        where: {
                            budgetoccupy: 1
                        },
                        page: {
                            limit: 10,
                            limits: [10, 20, 30]
                        },
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
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {field: 'rbsItemNo', title: 'RBS编号'},
                            {
                                field: 'rbsItemName', title: 'RBS名称', templet: function (d) {
                                    return d.rbsItemName || '';
                                }
                            },
                            {field: 'cbsName', title: 'CBS'}
                        ]]
                    });
                },
                yes: function (index) {
                    var $tr=_this.parents('tr');
                    var checkStatus = layTable.checkStatus('budgetLimitTable');
                    if (checkStatus.data.length > 0) {
                        _this.val(checkStatus.data[0].rbsItemName);
                        _this.attr('rbsItemId', checkStatus.data[0].rbsItemId);
                        _this.attr('cbsId', checkStatus.data[0].cbsId);
                        var budgetProj = checkStatus.data[0].plbMtlLibraryList;
                        if(budgetProj != ''&& budgetProj !=undefined){
                            if(budgetProj.length == 1){
                                $tr.find('input[name="expenseItem"]').val(budgetProj[0].mtlName || '');
                                $tr.find('input[name="expenseItem"]').attr('expenseItem',budgetProj[0].mtlLibId);
                                layer.close(index);
                            }else{
                                layer.close(index);
                                layer.open({
                                    type: 1,
                                    title: '选择',
                                    area: ['70%', '80%'],
                                    maxmin: true,
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: ['<div class="container">',
                                        '<table id="materialsTable2" lay-filter="materialsTable2"></table>' +
                                        '</div>'].join(''),
                                    success: function () {
                                        layTable.render({
                                            elem: '#materialsTable2',
                                            url: '/plbMtlLibrary/queryRbsType',
                                            where: {
                                                useFlag: true
                                            },
                                            page: true, //开启分页
                                            limit: 10,
                                            cols: [[ //表头
                                                {type: 'radio'},
                                                {field: 'mtlNo', title: '材料编码', minWidth: 120, sort: true, hide: false},
                                                {field: 'mtlName', title: '材料名称', minWidth: 120, sort: true, hide: false},
                                                {field: 'mtlStandard', title: '材料规格', minWidth: 120, sort: true, hide: false},
                                            ]],
                                            parseData: function (res) {
                                                return {
                                                    "code": 0, //解析接口状态
                                                    "data": budgetProj,//解析数据列表
                                                    "count": budgetProj.length, //解析数据长度
                                                };
                                            },
                                            request: {
                                                pageName: 'page', //页码的参数名称，默认：page
                                                limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                            },
                                        });
                                    },
                                    yes: function (index) {
                                        var checkStatus = layTable.checkStatus('materialsTable2');
                                        if (checkStatus.data.length > 0) {
                                            var trData = checkStatus.data;
                                            var rbsName = trData[0].mtlName;
                                            var mtlLibId = trData[0].mtlLibId;
                                            $tr.find('input[name="expenseItem"]').val(rbsName || '');
                                            $tr.find('input[name="expenseItem"]').attr('expenseItem',mtlLibId);
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                            }
                        }
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
        //本次支付
        $(document).on('input propertychange', 'input[name="paymentAmount"]', function () {
            var _this = $(this).parents('tr');

            //结算金额
            var settleupMoney = Number($(_this).find('input[name="settleupMoney"]').val())||0
            //核销金额
            var actualApplicationAmount = Number($(_this).find('input[name="actualApplicationAmount"]').val())||0
            //已支付金额
            var paidAmount = Number($(_this).find('input[name="paidAmount"]').val())||0
            //本次支付金额
            var paymentAmount = Number($(this).val())||0
            var actAndpai=BigNumber(actualApplicationAmount).plus(paidAmount)
            var setAct=BigNumber(settleupMoney).minus(actAndpai);
            //本次支付金额小于等于(结算金额-核销金额-已支付金额)
            if(paymentAmount>setAct){
                paymentAmount=setAct
                $(this).val(paymentAmount)
            }
            //未支付余额
            var prepaidBalance = subtr(subtr(subtr(settleupMoney,actualApplicationAmount),paidAmount),paymentAmount)||0

            $(_this).find('input[name="prepaidBalance"]').val(prepaidBalance)
            //基本信息本次支付金额
            var e = $("input[name='paymentAmount']")
            var d = [];
            var sum=0;
            for(var i=0;i<e.length;i++){
                d.push($("input[name='paymentAmount']").eq(i).val())
                sum += parseFloat($("input[name='paymentAmount']").eq(i).val())
            }
            $("input[name='payMoney']").val(numberFormat(sum,2))
        });

        // // 收款金额
        // $(document).on('keyup', 'input[name="collectionMoney"]', function () {
        //     var _this = $(this);
        //     var collectionMoneyNum = 0;
        //     $('input[name="collectionMoney"]').each(function () {
        //         if($(this).val() == ''&&$(this).val() != undefined){
        //             var num = 0
        //         }else if($(this).val() != ''&&$(this).val() != undefined){
        //             var num = Number($(this).val())
        //         }
        //         collectionMoneyNum += num
        //     });
        //     $('input[name="payMoney"]').val(collectionMoneyNum);
        // })
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

        //监听累计已结算金额
        $(document).on('blur', '[name="accumulatedSettlatedAmount"]', function () {
            if ($(this).val() && $('[name="contractMoney"]').val()) {
                $('[name="cumulativeSettledRatio"]').val(keepTwoDecimalFull(($(this).val() / $('[name="contractMoney"]').val()) * 100) + '%')
            }
        });

        //监听累计已支付金额
        $(document).on('blur', '[name="accumulatedAmountPaid"]', function () {
            if ($(this).val() && $('[name="contractMoney"]').val()) {
                $('[name="cumulativePaidProportion"]').val(keepTwoDecimalFull(($(this).val() / $('[name="contractMoney"]').val()) * 100) + '%')
            }
        });

        //计算累计已结算比例
        $(document).on('input propertychange','input[name="accumulatedSettlatedAmount"]',function(){
            var contractFee=$('[name="contractMoney"]').val().replace(/,/g,'')||'0';
            var val=$(this).val();
            $('[name="cumulativeSettledRatio"]').val((numberFormat(val/contractFee,2)*100)+'%')
        })
        //点击查询
        $('.searchData').on('click',function () {
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
                    curr: 1
                    //重新从第 1 页开始
                }
            });
        });

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


    });
    //判断是否显示空
    function isShowNull(data) {
        if (!!data) {
            return data
        } else {
            return ''
        }
    }
    //判断是否显示空
    function isShowNulls(data) {
        if (data != undefined) {
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
                    $tr.find('input[name="collectionAccount"]').val(res.object.userExt.bankCardNumber || '');
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
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').attr('cbsId', '')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').val('')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').attr('cbsId', '')
        $('#' + dept_id).parents('tr').find('.totalAnnualBudget').text('')
        $('#' + dept_id).parents('tr').find('.totalAnnualBalance').text('')
    }
    //同步
    function toAjaxT(url,data) {
        var result;
        $.ajax({
            url:url,
            data:data,
            type: 'post',
            async:false,
            dataType: 'json',
            success: function (res){
                result=res;
            }
        });
        return result;
    }
    function toAjaxTs(url,data) {
        var result;
        $.ajax({
            url:url,
            data:data,
            type: 'get',
            async:false,
            dataType: 'json',
            success: function (res){
                result=res;
            }
        });
        return result;
    }
    //选择研发项目
    $(document).on('click','[name="developProject"]',function(){
        var $that=$(this);
        layui.layer.open({
            type: 2,
            title: '选择研发项目',
            area: ['80%', '80%'],
            maxmin: true,
            btnAlign: 'c',
            btn: ['确定'],
            content: ['/PlbCustomer/rojOrganization'].join(''),
            yes: function (index,layero) {
                var checkData=$(layero).find("iframe")[0].contentWindow.yesBtn();
                if(checkData !=undefined){
                    if(checkData.length>0){
                        $that.val(checkData[0].pjName);
                        $that.attr('pjNumber',checkData[0].pjNumber);
                        layer.close(index)
                    }else{
                        return
                    }
                }
            }
        });
    })
    // //选择工程合同
    $(document).on('click','[name="enginContract"]',function(){
        var $that=$(this);
        layui.layer.open({
            type: 2,
            title: '选择工程合同',
            area: ['80%', '80%'],
            maxmin: true,
            btnAlign: 'c',
            btn: ['确定'],
            content: ['/plbDeptSubcontract/newDeptContract'].join(''),
            yes: function (index,layero) {
                var checkData=$(layero).find("iframe")[0].contentWindow.yesBtn();
                if(checkData !=undefined){
                    if(checkData.length>0){
                        $that.val(checkData[0].contractName);
                        $that.attr('subcontractId',checkData[0].subcontractId);
                        layer.close(index)
                    }else{
                        return
                    }
                }
            }
        });
    })
    //选择工程项目
    $(document).on('click','[name="enginProject"]',function(){
        var $that=$(this);
        layui.layer.open({
            type: 2,
            title: '选择工程项目',
            area: ['80%', '80%'],
            maxmin: true,
            btnAlign: 'c',
            btn: ['确定'],
            content: ['/PlbCustomer/projectEngineering'].join(''),
            yes: function (index,layero) {
                var checkData=$(layero).find("iframe")[0].contentWindow.yesBtn();
                if(checkData !=undefined){
                    if(checkData.length>0){
                        $that.val(checkData[0].projName);
                        $that.attr('projId',checkData[0].projId);
                        layer.close(index)
                    }else{
                        return
                    }
                }
            }
        });
    })
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
</script>


<script type="text/javascript" src="/js/planbudget/kingDee.js?20210827.2"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>


</body>
</html>
