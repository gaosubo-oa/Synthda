<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>新建合同结算</title>
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
<div class="layui-collapse">
    <input type="hidden" id="deptsId" class="layui-input">
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">合同结算</h2>
        <div class="layui-colla-content layui-show plan_base_info">
            <form class="layui-form" id="baseForm" lay-filter="baseForm">
                <div class="layui-row">
                    <div class="layui-col-xs3" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">单据编号<span class="field_required">*</span><a title="刷新编号" id="shua" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="contractNo" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="单据编号">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs3" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">客商单位名称<span class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>
                                <input type="text" name="customerName" autocomplete="off" readonly style="cursor: pointer;background: #e7e7e7" class="layui-input chen chooseCustomerName" title="客商单位名称">
                            </div>
                        </div>
                    </div>


                    <div class="layui-col-xs3" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">合同名称<span class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>
                                <input type="text" name="contractName" placeholder="查找合同" readonly autocomplete="off" class="layui-input chen chooseManagementBudget" title="合同名称" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">
                            </div>
                        </div>

                    </div>
                    <div class="layui-col-xs3" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">合同编号</label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="deptContractNo" placeholder="" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">
                            </div>
                        </div>

                    </div>
                </div>
            </form>
            <form class="layui-form" id="baseForm1" lay-filter="baseForm1">
                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">合同金额（元）</label>
                        <div class="layui-input-block form_block">
                            <input type="text" name="contractFee" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input" title="合同金额（元）">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">累计已结算金额（元）</label>
                        <div class="layui-input-block form_block">
                            <input type="text"  name="deptSettleupMoney"  autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">累计已结算比例</label>
                        <div class="layui-input-block form_block">
                            <input type="text" id="cumulativeSettledRatio"  name="cumulativeSettledRatio" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">发起类型<span class="field_required">*</span></label>
                        <div class="layui-input-block form_block">
                            <%--                                   <input type="text" id="initiationType" readonly name="initiationType" autocomplete="off" class="layui-input">--%>
                            <select class="chen" id="initiationType" name="initiationType" title="发起类型"></select>
                        </div>
                    </div>
                </div>

                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">本次结算金额（元）<span class="field_required">*</span></label>
                        <div class="layui-input-block form_block">
                            <input type="text" name="settleupMoney" style="background: #e7e7e7" readonly autocomplete="off" class="layui-input chen  input_floatNum " title="本次结算金额（元）">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">结算期间<span class="field_required">*</span></label>
                        <div class="layui-input-block form_block">
                            <input type="text" id="settlementPeriod" name="settlementPeriod" readonly autocomplete="off" class="layui-input chen" title="结算期间">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">款项性质<span field="naturePayment" class="field_required">*</span></label>
                        <div class="layui-input-block form_block">
                            <select  name="naturePayment" lay-filter="naturePayment"></select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3" style="padding: 0 5px;">
                    <div class="layui-form-item">
                        <label class="layui-form-label form_label">是否扣除预付款</label>
                        <div class="layui-input-block form_block" id="radioBox">
                            <input type="radio" class="isAdvance"  name="isAdvance" onclick="check(this.value)" lay-filter="isAdvance" value="0" title="否" checked>
                            <input type="radio" class="isAdvance" name="isAdvance" onclick="check(this.value)" lay-filter="isAdvance" value="1" title="是">

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
                <div class="layui-row">
                    <div class="layui-col-xs3" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">工程项目</label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="enginProject" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="工程项目">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs3" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">工程合同</label>
                            <div class="layui-input-block form_block">
                                <input type="text" readonly name="enginContract" style="background: #e7e7e7" autocomplete="off" class="layui-input enginContract" title="工程合同">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs3" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">研发项目</label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="developProject" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="研发项目">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs3" style="padding: 0 5px;display: none">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">累计已支付金额</label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="payedMoney" readonly autocomplete="off" class="layui-input" title="累计已支付金额">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-col-xs12" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">结算说明</label>
                            <div class="layui-input-block form_block">
                                <textarea type="text" name="settlementDescription" autocomplete="off" style="min-height: 100px" class="layui-input"></textarea>
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
                            <label class="layui-form-label form_label">结算合同附件</label>
                            <div class="layui-input-block form_block">
                                <div class="file_module">
                                    <div id="fileContent" class="file_content"></div>
                                    <div class="file_upload_box">
                                        <a href="javascript:;" class="open_file">
                                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span><input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">
                                        </a>
                                        <div class="progress" id="progress">
                                            <div class="bar"></div>\n
                                        </div>
                                        <div class="bar_text"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="y1u" style="display: none">
                    <h2 class="layui-colla-title">预付款核销明细</h2>
                    <div class="layui-colla-content pym_info layui-show">
                        <div>
                            <table id="paymentTable" lay-filter="paymentTable"></table>
                        </div>
                    </div>
                </div>
                <h2 class="layui-colla-title">预算执行明细</h2>
                <div class="layui-colla-content mtl_info layui-show" id="materialDetailsTableModule">
                    <div>
                        <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>
                    </div>
                </div>


            </form>
        </div>
    </div>
</div>
<div class="footer" style="text-align:center">
    <button type="button" class="layui-btn layui-btn-normal" id="saveBtn">保存</button>
    <button type="button" class="layui-btn layui-btn-warm" id="submitBtn">提交</button>
    <button type="button" class="layui-btn layui-btn-primary" id="closeBtn">关闭</button>
    <button type="button" class="layui-btn layui-btn-warm" id="reSubmitBtn" style="display: none;">提交</button>
</div>
<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button type="button" class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>
<script type="text/html" id="toolbarDemoIns">
    <div class="layui-btn-container" style="height: 30px;">
        <button type="button" class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
        <button type="button" class="layui-btn layui-btn-sm addRow" lay-event="adds">添加发票</button>
        <button type="button" class="layui-btn layui-btn-sm " lay-event="merge">合并</button>
        <button type="button" class="layui-btn layui-btn-sm" lay-event="viewInvoice">查看发票</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>


<script>
    var type = $.GetRequest()['type'] || '';
    var runId = $.GetRequest()['runId'] || '';
    var contractId = $.GetRequest()['contractId'] || '';
    var settlementPeriod = $.GetRequest()['settlementPeriod'] || '';
    // var settleupYear = $.GetRequest()['settleupYear'] || '';
    // var subpaymentId = $.GetRequest()['subpaymentId'] || '';
    var deptIds = window.parent.deptId
    var advanceId
    var data
    var subpaymentId
    var xhr = null;
    //付款明细活跃的行
    var avtiveTd;
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name = $(this).attr('name')
        $('.query_module [name=' + name + ']').val($.cookie(name) || '')
    })

    var tipIndex = null;
    $('.icon_img').on('hover',function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });


    var title = '';
    var url;

    if (type == '0') {
        title = '新建合同结算';
        url = '/plbContractInfo/insertContract';
    } else if (type == '1') {
        title = '编辑合同结算';
        url = '/plbContractInfo/updatePlbMtlSubsettleup';
    } else if (type == 4) {
        title = '查看详情'
    }


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

    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var layTable = layui.table;
        var xmSelect = layui.xmSelect;
        var tableIns = null;
        var materialsTable = null;
        var addRowData2 = {}

        form.render();
        //导出数据
        var exportData = '';
        var contractIds;
        var isAdvance = 0;
        var contractIdss;
        var asd=[];
        var ree;

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
                            expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                            expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            deptName: $(this).find('input[name="deptName"]').val(),
                            deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                            totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                            totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                            applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                            guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
                            amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                            remark: $(this).find('input[name="remark"]').val(),//备注
                            subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                            actualApplicationAmount:$(this).find('input[name="actualApplicationAmount"]').val()//本次预算执行金额
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
                        expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                        expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                        contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                        cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                        deptName: $(this).find('input[name="deptName"]').val(),
                        deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                        totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                        totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                        applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                        guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
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
                            subpaymentPaymentId: $(this).find('input[name="paymentType"]').attr('subpaymentPaymentId'),//主键id
                            actualApplicationAmount:$(this).find('input[name="actualApplicationAmount"]').val()//本次预算执行金额
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

        // 付款明细内部删行操作
        table.on('tool(paymentTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if(data.chargemoneyId == undefined){
                data.chargemoneyId = ''
            }
            if(type == 4){
                layEvent = ''
            }
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
                    ,done:function(obj){
                        var dataArr = getPlbLongdistanceCostss().dataArr;
                        table.reload('materialDetailsTable', {
                            data: dataArr
                            ,done:function(res){
                                for(var i=0;i<res.data.length;i++){
                                    var n = getysNum(res.data[i].applicationAmount,i,'0')
                                    $('input[name="actualApplicationAmount"]').eq(i).val(n)
                                }
                            }
                        });
                    }
                });
            } else if (layEvent === 'choosePay') {
                layer.open({
                    type: 1,
                    title: '选择预付单据',
                    area: ['80%', '80%'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="container">',
                        '                        <div class="query_module layui-form layui-row" style="position: relative">\n' +
                        '                    <div class="layui-col-xs2">\n' +
                        '                    <input type="text" id="contractNos" name="contractNo" placeholder="单据编号" autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-left: 20px">\n' +
                        '                    <input type="text" id="customerName" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-left: 20px">\n' +
                        '                    <input type="text" id="advanceMoney" name="advanceMoney" placeholder="预付金额" autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-left: 20px">\n' +
                        '                    <input type="text" id="createUser" name="createUser" placeholder="经办人" autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                        '                    <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>\n' +
                        '                    </div>\n' +
                        '                    </div>\n' +
                        '<table id="reimburseNoTable" lay-filter="reimburseNoTable"></table>',
                        '</div>'].join(''),
                    success: function () {
                        var data = []
                        var tableData=[]
                        $.ajax({
                            url:"/plbContractInfo/getContractAdvance",
                            async:false,
                            success:function(res){
                                if(res.data!=undefined){
                                    tableData=res.data
                                }
                            }
                        })


                        table.render({
                            elem:'#reimburseNoTable',
                            countName: 'totleNum',
                            // url:"/plbContractInfo/getContractAdvance?auditerStatus=2",
                            data:tableData,
                            page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']//自定义分页布局
                                ,limits:[5,10,15]
                                ,first: false //不显示首页
                                ,last: false //不显示尾页
                            },
                            cols:[[
                                {type:'radio'},
                                {field: 'customerId', title: '单据编号', width: 300, sort: true, hide: false, templet: function (d) {
                                        return d.contractNo || ''
                                    }},
                                {field: 'createTime', title: '单据日期', width: 300, sort: true, hide: false, templet: function (d) {
                                        return d.createTime || ''
                                    }},
                                {field: 'customerId', title: '客商单位名称', minWidth: 300, sort: true, hide: false, templet: function (d) {
                                        return d.customerName || ''
                                    }},
                                {field: 'contractName', title: '合同名称', width: 300, sort: true, hide: false},

                                {field: 'prepaidAmount', title: '预付金额', width: 300, sort: true, hide: false},
                                {field: 'createUser', title: '经办人', width: 300, sort: true, hide: false,templet: function (d) {
                                        return d.createUser || ''
                                    }},
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
                                dataType: 'json',
                                type: 'post',
                                success: function (res) {
                                    $tr.find('input[name="paymentType"]').val(res.data.advanceNo);
                                    $tr.find('input[name="prepaidAmount"]').val(res.data.prepaidAmount);
                                    $tr.find('input[name="paymentType"]').attr('advanceId',res.data.advanceId), // advanceId
                                        $tr.find('input[name="deductedAmount"]').val(res.data.deductedAmount);
                                    $tr.find('input[name="amountDeductedAfter"]').val(res.data.amountDeductedAfter);
                                    if(res.data.prepaidAmount == undefined){
                                        res.data.prepaidAmount = 0
                                    }

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
                                yes: function (index,layero) {
                                    $(layero).find("iframe")[0].contentWindow.yesBtn();
                                }
                            });
                        });
                    }
                });
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
                            expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                            expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            deptName: $(this).find('input[name="deptName"]').val(),
                            deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                            totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                            totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                            applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                            guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
                            amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                            remark: $(this).find('input[name="remark"]').val(),//备注
                            subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                            actualApplicationAmount:$(this).find('input[name="actualApplicationAmount"]').val()//本次预算执行金额
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
                            deptName: res.object.deptName
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
                var sum = 0;
                $('[name="applicationAmount"]').each(function(){
                    sum+=Number($(this).val());
                })
                var applicationAmount=$tr.find('[name="applicationAmount"]').val()||'0'
                $('[name="settleupMoney"]').val(BigNumber(keepTwoDecimalFull(sum,2)).minus(applicationAmount))
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
                        expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                        expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                        contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                        cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                        deptName: $(this).find('input[name="deptName"]').val(),
                        deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                        totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                        totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                        applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                        guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
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

        // 付款明细内部删行操作
        table.on('tool(paymentTable)', function (obj) {

            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if(data.chargemoneyId == undefined || data.chargemoneyId == "undefined"){
                data.chargemoneyId = ''
            }
            if(type == 4){
                layEvent = ''
            }
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
                    ,done:function(obj){
                        var dataArr = getPlbLongdistanceCostss().dataArr;
                        table.reload('materialDetailsTable', {
                            data: dataArr
                            ,done:function(res){
                                for(var i=0;i<res.data.length;i++){
                                    var n = getysNum(res.data[i].applicationAmount,i,'0')
                                    $('input[name="actualApplicationAmount"]').eq(i).val(n)
                                }
                            }
                        });
                    }
                });
            } else if (layEvent === 'choosePay') {
                layer.open({
                    type: 1,
                    title: '选择预付单据',
                    area: ['80%', '80%'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="container">',
                        '                        <div class="query_module layui-form layui-row" style="position: relative">\n' +
                        '                    <div class="layui-col-xs2" style="margin-left: 20px">\n' +
                        '                    <input type="text" id="contractNos" name="contractNo" placeholder="单据编号" autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-left: 20px">\n' +
                        '                    <input type="text" id="customerName" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-left: 20px">\n' +
                        '                    <input type="text" id="advanceMoney" name="advanceMoney" placeholder="预付金额" autocomplete="off" class="layui-input">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-left: 20px">\n' +
                        '                    <input type="text" id="createUser" name="createUser" placeholder="经办人"  id="user" autocomplete="off"  class="layui-input  userAdd">\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-col-xs2" style="margin-top: 3px;text-align: center;margin-left: -60px">\n' +
                        '                    <button type="button" id="contractNosearch" class="layui-btn layui-btn-sm searchData">查询</button>\n' +
                        '                    </div>\n' +
                        '                    </div>\n' +
                        '<table id="reimburseNoTable" lay-filter="reimburseNoTable"></table>',
                        '</div>'].join(''),

                    success: function () {
                        var contractNoValue = '';
                        var  customerNameValue='';
                        var advanceMoneyValue='';
                        var createUserValue='';
                        $(document).on('click','#contractNosearch',function(){
                            contractNoValue = $('#contractNos').val()
                            customerNameValue = $('#customerName').val()
                            advanceMoneyValue = $('#advanceMoney').val()
                            createUserValue = $('#createUser').attr('user_id').replace(/,/g, '')
                            pan()
                        })
                        pan()
                        var data = []
                        var tableData=[]
                        var url;
                        function pan(){
                            if(contractNoValue != ''||customerNameValue !=''||advanceMoneyValue !=''||createUserValue !=''){
                                url = '/plbContractInfo/getContractChargemoney?auditerStatus=2&customerName='+customerNameValue+'&contractNo='+contractNoValue+'&advanceMoney='+advanceMoneyValue+'&userId='+createUserValue+''
                                contractNosearch()
                            } else{
                                url = "/plbContractInfo/getContractChargemoney?auditerStatus=2"
                                contractNosearch()
                            }
                        }


                        function contractNosearch(){
                            table.render({
                                elem:'#reimburseNoTable',
                                url:url,
                                page: {
                                    limit: 10,
                                    limits: [10, 20, 30]
                                },
                                cols:[[
                                    {type:'radio'},
                                    {field: 'customerId', title: '单据编号', width: 300, sort: true, hide: false, templet: function (d) {
                                            return d.contractNo || ''
                                        }},
                                    {field: 'createTime', title: '单据日期', width: 150, sort: true, hide: false, templet: function (d) {
                                            return d.createTime || ''
                                        }},
                                    {field: 'customerId', title: '客商单位名称', minWidth: 300, sort: true, hide: false, templet: function (d) {
                                            return d.customerName || ''
                                        }},
                                    {field: 'contractName', title: '合同名称', width: 150, sort: true, hide: false},

                                    {field: 'advanceMoney', title: '预付金额', width: 300, sort: true, hide: false,templet: function (d) {
                                            return d.plbContractAdvance.advanceMoney || ''
                                        }},
                                    {field: 'createUser', title: '经办人', width: 300, sort: true, hide: false,templet: function (d) {
                                            return d.createUser || ''
                                        }},
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
                        }

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
                            console.log(obj)
                        })
                        var checkStatus = table.checkStatus('reimburseNoTable');
                        if (checkStatus.data.length > 0) {
                            var payData = checkStatus.data[0];
                            $tr.find('input[name="paymentType"]').val(payData.plbContractChargemonies.advanceNo);
                            $tr.find('input[name="prepaidAmount"]').val(payData.plbContractChargemonies.prepaidAmount);
                            $tr.find('input[name="paymentType"]').attr('advanceId',payData.plbContractChargemonies.advanceId), // advanceId
                                $tr.find('input[name="deductedAmount"]').val(payData.plbContractChargemonies.deductedAmount);
                            $tr.find('input[name="amountDeductedAfter"]').val(payData.plbContractChargemonies.amountDeductedAfter);
                            if(payData.plbContractChargemonies.prepaidAmount == undefined){
                                payData.plbContractChargemonies.prepaidAmount = 0
                            }
                            var b = payData.plbContractChargemonies.prepaidAmount-payData.plbContractChargemonies.deductedAmount
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
        form.on('radio(isAdvance)', function(data){
            isAdvance = data.value
            if(data.value == '0'){
                $('#yu').hide()
                $('#y1u').hide()
                var dataArr = getPlbLongdistanceCostss().dataArr;
                table.reload('materialDetailsTable', {
                    data: dataArr
                    ,done:function(res){
                        for(var i=0;i<res.data.length;i++){
                            var n = getysNum(res.data[i].applicationAmount,i,'0')
                            $('input[name="actualApplicationAmount"]').eq(i).val(n)
                        }
                    }
                });
            }
            if(data.value == '1'){
                $('#yu').show()
                $('#y1u').show()
                var dataArr = getPlbLongdistanceCostss().dataArr;
                table.reload('materialDetailsTable', {
                    data: dataArr
                    ,done:function(res){
                        for(var i=0;i<res.data.length;i++){
                            var n = getysNum(res.data[i].applicationAmount,i,'0')
                            $('input[name="actualApplicationAmount"]').eq(i).val(n)
                        }
                    }
                });
            }
        });
        $(document).on('keyup', 'input[name="taxAmount"]', function () {
            var _this = $(this);
            var a =_this.parents("tr").find('input[name="applicationAmount"]').val()
            var b =_this.val()
            var c =Number(a)-Number(b)
            if(c>=0){
                _this.parents("tr").find('input[name="amountExcludingTax"]').val(c.toFixed(2));
            }else {
                _this.parents("tr").find('input[name="amountExcludingTax"]').val(0);
            }
        })
        $(document).on('keyup', '[name="applicationAmount"]', function () {
            var sum = 0;
            $('[name="applicationAmount"]').each(function(){
                sum+=Number($(this).val());
            })
            $("input[name='settleupMoney']").val(numberFormat(sum,2))
        })
        $(document).on('input propertychange', 'input[name="applicationAmount"]', function () {
            var $tr=$(this).parents('tr');
            var value=$(this).val();
            // var totalAnnualBalance=checkFloatNum($tr.find('.totalAnnualBalance').text());
            // if(BigNumber(totalAnnualBalance).lt(0)){
            //     value=0
            //     $(this).val(value)
            // }else if(BigNumber(totalAnnualBalance).lt(value)){
            //     value=totalAnnualBalance
            //     $(this).val(value);
            //     layer.msg('本次结算金额不能大于年度预算余额',{icon: 0})
            // }
            $tr.find('[name="actualApplicationAmount"]').val(value);
            var taxVal=$tr.find('[name="taxAmount"]').val()||'0'
            var minusNum=BigNumber(value).minus(taxVal);
            if(minusNum>0){
                $tr.find('[name="amountExcludingTax"]').val(minusNum)
            }else{
                $tr.find('[name="amountExcludingTax"]').val('0')
            }

        })
        $(document).on('keyup', 'input[name="amountDeducted"]', function () {
            var _this = $(this);
            var a =_this.parents("tr").find('input[name="prepaidBalance"]').val()
            var b =_this.val()
            if(parseInt(b)>parseInt(a)){
                layer.msg('本次扣除金额≤预付余额', {icon: 0});
                _this.val(_this.parents("tr").find('input[name="prepaidBalance"]').val())
                _this.parents("tr").find('.kou').val('0');
            }else{
                var c =a-b
                _this.parents("tr").find('.kou').val(c);
            }
        })
        $(document).on('blur', 'input[name="amountDeducted"]', function () {
            suan()
        })
        $(document).on('blur', 'input[name="applicationAmount"]', function () {
            var $tr=$(this).parents("tr");
            var isAdvance=$('[name="isAdvance"]:checked').val();
            if(isAdvance==0){
                $tr.find('[name="actualApplicationAmount"]').val($(this).val());
            }else{
                suan()
            }
        })
        //计算累计已结算比例
        $(document).on('input propertychange','input[name="deptSettleupMoney"]',function(){
            var contractFee=$('[name="contractFee"]').val().replace(/,/g,'')||'0';
            var val=$(this).val();
            $('[name="cumulativeSettledRatio"]').val((numberFormat(val/contractFee,2)*100)+'%')
        })
        function suan(){
            var dataArr = getPlbLongdistanceCostss().dataArr;
            table.reload('materialDetailsTable', {
                data: dataArr
                ,done:function(res){
                    for(var i=0;i<res.data.length;i++){
                        var n = getysNum(res.data[i].applicationAmount,i,'0')
                        $('input[name="actualApplicationAmount"]').eq(i).val(n)
                    }
                }
            });
        }
        if(type == 0){
            // 获取自动编号
            getAutoNumber({autoNumber: 'plbContractSettle'}, function (res) {
                $('input[name="contractNo"]', $('#baseForm')).val(res);
            });
        }
        if(type == 1 || type == 4) {
            $.ajax({
                url: '/plbContractInfo/getContractSettleById?contractId=' + contractId + '',
                dataType: 'json',
                type: 'post',
                async: false,
                success: function (res) {
                    subpaymentId = res.data.contractId
                    ree = res.data
                    if(ree.plbContractChargemoniesList != ''){
                        $('#y1u').show()
                        isAdvance = 1
                    }
                    if(ree.initiationType != '' || ree.initiationType != undefined){
                        $("#initiationType option[value = "+ree.initiationType+"]").prop("selected",true)
                    }

                    materialDetailsTableData = res.data.plbContractInfoListWithBLOBsList
                    paymentTableData = res.data.plbContractChargemoniesList
                    $("input[name='contractFee']").val(res.data.plbContractAdvance.contractFee)
                    $("input[name='cumulativeSettledRatio']").val(res.data.plbContractInfoListWithBLOBsList.cumulativeSettledRatio)
                    $("input[name='settleupYear']").val(res.data.plbContractSettle.settleupYear)
                    $("textarea[name='settlementDescription']").val(res.data.plbContractSettle.settlementDescription)

                    if (res.data.plbContractSettle.settleupQuarter != '') {
                        $("#settleupQuarter option[value=" + res.data.plbContractSettle.settleupQuarter + "]").prop("selected", true);
                    }
                    if (res.data.plbContractSettle.settleupMonth != '') {
                        $("#settleupMonth option[value=" + res.data.plbContractSettle.settleupMonth + "]").prop("selected", true);
                    }
                    //预算执行明细
                    var cols = [
                        {type:'checkBox'},
                        {
                            field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                                return '<input readonly id="'+d.LAY_TABLE_INDEX+'" contractListId="'+(d.contractListId || '')+'" name="deptName" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input ' + (type == '4' ? '' : 'choose_dept') + '" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + (isShowNull(d.deptName) || '') + '">';
                            }
                        },
                        {
                            field: 'rbsItemId', title: '预算科目名称', minWidth: 100, templet: function (d) {
                                return '<input contractId="'+(d.contractId || '')+'" name="rbsItemId" readonly rbsItemId="'+(d.rbsItemId || '')+'"   ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChoose') + '" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.rbsItemName) + '">';
                            }
                        },
                        {
                            field: 'expenseItem',
                            title: '费用项目',
                            minWidth: 200,
                            templet: function (d) {
                                return '<input name="expenseItem" type="text" readonly class="layui-input expenseItem" style="height: 100%;" expenseItem="' + isShowNull(d.expenseItem) + '" value="'+(d.expenseItemName||'')+'">';
                            }
                        },
                        // {
                        //     field: 'cbsId',
                        //     title: '会计科目名称',
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
                            title: '本次结算金额',
                            minWidth: 150,
                            templet: function (d) {
                                return '<input id="applicationAmount" name="applicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.applicationAmount) + '">';
                            }
                        },
                        {
                            field: 'actualApplicationAmount',
                            title: '本次预算执行金额',
                            minWidth: 150,
                            templet: function (d) {
                                return '<input id="actualApplicationAmount" name="actualApplicationAmount"   subpaymentListId="' + (d.subpaymentListId || '') + '"  readonly type="number"  class="layui-input input_floatNum KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + d.actualApplicationAmount + '">';
                                // return '<input id="actualApplicationAmount" name="actualApplicationAmount" readonly style="background: #e7e7e7;height: 100%"    subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input KD_total_amount" autocomplete="off" value="' + isShowNull(d.actualApplicationAmount) + '">';
                            }
                        },
                        {
                            field: 'guaranteeFund',
                            title: '其中质保金',
                            minWidth: 150,
                            templet: function (d) {
                                return '<input name="guaranteeFund"  ' + (type == 4 ? 'readonly' : '') + ' guaranteeFund="' + (d.guaranteeFund || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.guaranteeFund) + '">';
                            }
                        },
                        {
                            field: 'taxAmount',
                            title: '税额',
                            minWidth: 150,
                            templet: function (d) {
                                return '<input id="taxAmount" name="taxAmount"  ' + (type == 4 ? 'readonly' : '') + ' type="number" pointFlag="1" class="layui-input input_floatNum taxAmountItem KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.taxAmount) + '">';
                            }
                        },
                        {
                            field: 'amountExcludingTax',
                            title: '不含税金额',
                            minWidth: 150,
                            templet: function (d) {
                                return '<input id="amountExcludingTax" name="amountExcludingTax"  readonly type="number"  class="layui-input input_floatNum KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + isShowNulls(d.amountExcludingTax) + '">';
                            }
                        },
                        {
                            field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                                return '<input name="remark"  ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                            }
                        },
                        {
                            field: 'invoices',
                            title: '发票',
                            minWidth: 200,
                            templet: function (d) {
                                var invoiceStr = '';
                                if (d.invoiceNosList) {
                                    d.invoiceNosList.forEach(function (item, index) {
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
                                if (type != '4') {
                                    // str = '<a class="choose_invoices"><i class="layui-icon layui-icon-upload-circle"></i></a>'
                                }
                                return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div>' + str + '</div>';
                            }
                        }
                    ]
                    if (type != 4) {
                        cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
                    }
                    table.render({
                        elem: '#materialDetailsTable',
                        data: materialDetailsTableData,
                        toolbar: '#toolbarDemoIns',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done: function () {
                            if (type == 4) {
                                $('.addRow').hide()
                            }
                            $('input[name="deptName"]').each(function (i, v) {
                                $(this).attr('id', 'dept_' + i);
                            });
                        }
                    });
                    laydate.render({
                        elem: '#settleupDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.settleupDate) : '',
                        done: function (value, date, endDate) {
                            $('#settleupYear').val(date.year)
                            if (date.month < 4) {
                                $('[name="settleupQuarter"]').val('1')
                            } else if (date.month < 7) {
                                $('[name="settleupQuarter"]').val('2')
                            } else if (date.month < 10) {
                                $('[name="settleupQuarter"]').val('3')
                            } else {
                                $('[name="settleupQuarter"]').val('4')
                            }
                            $('[name="settleupMonth"]').val(date.month)
                            form.render()
                        }
                    });
                    //日期时间范围
                    laydate.render({
                        elem: '#settlementPeriod'
                        , type: 'date'
                        ,trigger: 'click'
                        , range: '~'
                    });
                    //日期时间范围
                    laydate.render({
                        //结算期间
                        elem: '#settlementPeriod',
                        range: '~',
                        trigger: 'click',
                        format: 'yyyy-MM-dd',
                        value: data ? data.settlementPeriod : ''
                    });

                    //年选择器
                    laydate.render({
                        elem: '#settleupYear'
                        , type: 'year'
                        , trigger: 'click' //采用click弹出
                        , value: data ? data.settleupYear : ''
                    });

                    //合同付款明细
                    var cols2 = [
                        {
                            field: 'paymentType',
                            title: '预付单据编号',
                            event: 'choosePay',
                            minWidth: 150,
                            templet: function (d) {

                                return '<input chargemoneyId='+d.chargemoneyId+' value="' + isShowNull(d.advanceNo) + '" advanceId="' + (d.advanceId || '') + '" type="text" name="paymentType" subpaymentPaymentId="' + (d.subpaymentPaymentId || '') + '" readonly paymentType="' + isShowNull(d.paymentType) + '" class="layui-input" style="height: 100%; cursor: pointer;">';
                            }
                        },
                        {
                            field: 'prepaidAmount',
                            title: '预付金额',
                            minWidth: 150,
                            event: 'chooseCollectionUser1',
                            templet: function (d) {
                                var str = '';
                                var attr = '';
                                if (d.prepaidAmount) {
                                    str = isShowNull(d.prepaidAmount);
                                    attr = 'prepaidAmount="' + d.prepaidAmount + '" userType="2"';
                                } else {
                                    str = isShowNull(d.collectionUserName).replace(/,$/, '');
                                    attr = 'user_id="' + (d.prepaidAmount || '') + '" userType="1"';
                                }

                                return '<input readonly name="prepaidAmount" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                            }
                        },
                        {
                            field: 'deductedAmount',
                            title: '已扣除金额',
                            minWidth: 150,
                            templet: function (d) {

                                return '<input readonly type="text" name="deductedAmount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + function(){
                                    if(d.deductedAmount == undefined){
                                        return ''
                                    } else{
                                        return d.deductedAmount
                                    }
                                }() + '">';
                            }
                        },
                        {
                            field: 'prepaidBalance',
                            title: '预付余额',
                            minWidth: 150,
                            templet: function (d) {

                                return '<input id="prepaidBalance" type="text" name="prepaidBalance" pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.prepaidBalance) + '">';
                            }
                        },
                        {
                            field: 'amountDeducted', title: '本次扣除金额', minWidth: 300, templet: function (d) {

                                return '<input lay-filter="amountDeducted" type="text" id="amountDeducted" name="amountDeducted" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountDeducted) + '">';
                            }
                        },
                        {
                            field: 'amountDeductedAfter', title: '扣除后余额', minWidth: 300, templet: function (d) {

                                return '<input id="kou" type="text" name="amountDeductedAfter" class="layui-input amountExcludingTax kou" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountDeductedAfter) + '">';
                            }
                        },
                        {
                            field: 'remark', title: '备注', minWidth: 300, templet: function (d) {

                                return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
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
                            $('input[name="prepaidAmount"]').each(function (i, v) {
                                $(v).attr('id', 'prepaidAmount' + i);
                            });
                        }
                    });
                }
            })
        }else{
            // 获取主键
            $.get('/plbDeptReimburse/getUUID', function (res) {
                subpaymentId = res;
                contractId = res;
            });
            $.get('/plbUtil/autoNumber?autoNumber=plbContractSettle', function (res) {
                $('input[name="contractNo"]').val(res)
            });
        }

        $('.refresh_no_btn').show().on('click', function () {
            getAutoNumber({autoNumber: 'plbContractSettle'}, function (res) {
                $('input[name="contractNo"]', $('#baseForm')).val(res);
            });
        });
        fileuploadFn('#fileupload', $('#fileContent'));
        // // 获取当前登录人信息(经办人)
        // getUserInfo($.cookie('userId'), function (res) {
        //     if (res.object) {
        //         addRowData2 = {
        //             deptId: res.object.deptId,
        //             deptName: res.object.deptName
        //         };
        //     }
        // });
        getUserInfo('', function (res) {
            if (res.object) {
                $('[name="createUser"]', $('#baseForm1')).attr('user_id', res.object.userId).val(res.object.userName);
                // $('[name="createUser"]', $('#baseForm1')).attr('deptId', res.object.deptId).attr('deptName', res.object.deptName);
                $("#deptsId").attr('deptId', res.object.deptId).attr('deptName', res.object.deptName)
                initKingDee(res.object.userId)
            }
        });
        var materialDetailsTableData = [];
        var paymentTableData = [];
        if(type == ''){
            $.get('/plbContractInfo/queryByRunId', {runId: runId}, function (res) {
                if (res.flag) {
                    var data = res.data
                    form.val("baseForm", data);
                    form.val('baseForm1',data)
                    laydate.render({
                        elem: '#settleupDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.settleupDate) : ''
                    });

                    //年选择器
                    laydate.render({
                        elem: '#settleupYear'
                        , type: 'year'
                        , trigger: 'click' //采用click弹出
                        , value: data ? data.settleupYear : ''
                    });
                    //合同金额
                    $("#settlementPeriod").val(data.settlementPeriod ? data.settlementPeriod : '');
                    //合同金额
                    $("input[name='contractFee']").val(data.plbContractSettle.contractFee ? data.plbContractSettle.contractFee : '');
                    $("#settlementDescription").val(data.settlementDescription ? data.settlementDescription : '');
                    $("#cumulativeSettledRatio").val(data.plbContractSettle.cumulativeSettledRatio ? data.plbContractSettle.cumulativeSettledRatio : '/');
                    // $('.plan_base_info input[name="contractFee"]').val(data.contractFee ? numberFormat(data.contractFee, 2) : '/');
                    //累计已结算金额
                    $('.plan_base_info input[name="deptSettleupMoney"]').val(data.plbContractSettle.deptSettleupMoney);
                    //本次结算金额
                    $('.plan_base_info input[name="settleupMoney"]').val(numberFormat(data.settleupMoney, 2));
                    // 合同id
                    $('.plan_base_info input[name="contractName"]').attr('subcontractId', data.subcontractId || '');
                    $('.plan_base_info input[name="contractName"]').attr('deptId', data.deptId || '');
                    $('.plan_base_info input[name="contractName"]').attr('subsettleupId', data.subsettleupId || '');

                    //客商id
                    $('.plan_base_info input[name="customerName"]').attr('customerId', data.customerId || '');

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
                } else {
                    layer.msg('获取信息失败！', {icon: 2});
                }
            });
        }
        //回显数据
        if (type == 1 || type == 4) {
            $("#shua").hide()
            isAdvance = ree.plbContractSettle.isAdvance
            if(isAdvance != '' || isAdvance != undefined){
                $(":radio[name='isAdvance'][value="+isAdvance+"]").attr("checked","true");
            }

            // subsettleupId = data.subsettleupId
            form.val("baseForm", ree)
            form.val('baseForm1',ree)
            var deptName=ree.deptId + ',|' + ree.deptName + ',';
            $('[name="createUser"]').attr('deptName',deptName);
            $('[name="createUser"]').val(ree.createUserName);
            //工程项目
            if(ree.plbProj == undefined){
                $("input[name='enginProject']").val('')
            }else{
                var projName = ree.plbProj.projName
                $("input[name='enginProject']").val(projName)
                $("input[name='enginProject']").attr('projId',ree.plbProj.projId)
            }
            //工程合同
            if(ree.plbDeptSubcontract == undefined){
                $("input[name='enginContract']").val('')
            }else{
                var contractName = ree.plbDeptSubcontract.contractName
                $("input[name='enginContract']").val(contractName)
                $("input[name='enginContract']").attr('subcontractId',ree.plbDeptSubcontract.subcontractId)
            }
            //研发项目
            if(ree.srmsPjProject == undefined){
                $("input[name='developProject']").val('')
            }else{
                var pjName = ree.srmsPjProject.pjName
                $("input[name='developProject']").val(pjName)
                $("input[name='developProject']").attr('pjNumber',ree.srmsPjProject.pjNumber)
            }
            $("#settlementPeriod").val(ree.plbContractSettle.settlementPeriod ? ree.plbContractSettle.settlementPeriod : '');
            $("#settlementDescription").val(ree.plbContractSettle.settlementDescription ? ree.plbContractSettle.settlementDescription : '');
            //累计已支付金额
            $('.plan_base_info input[name="payedMoney"]').val(numberFormat(ree.plbContractSettle.payedMoney, 2) || 0.00);
            //累计已结算金额
            $('.plan_base_info input[name="deptSettleupMoney"]').val(numberFormat(ree.plbContractSettle.deptSettleupMoney, 2) || 0.00);
            //客商单位名称
            $("input[name='customerName']").val(ree.customerName ? ree.customerName: '');
            // 单据编号
            $("input[name='contractNo']").val(ree.contractNo);

            //合同名称
            $("input[name='contractName']").val(ree.contractName ? ree.contractName: '');
            //累计已结算比例
            $("input[name='cumulativeSettledRatio']").val(ree.plbContractPaymentWithBLOBs.cumulativeSettledRatio ? ree.plbContractPaymentWithBLOBs.cumulativeSettledRatio: '');
            //本次结算金额
            $('.plan_base_info input[name="settleupMoney"]').val(numberFormat(ree.plbContractSettle.settleupMoney, 2));
            //合同编号
            $('.plan_base_info input[name="deptContractNo"]').val(ree.deptContractNo);
            //结算日期
            $('.plan_base_info input[name="settleupDate"]').val(numberFormat(ree.plbContractSettle.settleupDate, 2));

            // //结算期间
            // $('.plan_base_info input[name="settlementPeriod"]').val(ree.plbContractSettle.settlementPeriod);
            //结算年
            $('.plan_base_info input[name="settleupYear"]').val(numberFormat(ree.plbContractSettle.settleupYear, 2));
            //结算说明
            // $('.plan_base_info textarea[name="settlementDescription"]').val(numberFormat(data.plbContractSettle.settlementDescription, 2));
            //合同id
            $('.plan_base_info input[name="contractName"]').attr('subcontractId', ree.subcontractId || '');
            //客商id
            $('.plan_base_info input[name="customerName"]').attr('customerId', ree.customerId || '');
            if (ree.attachments && ree.attachments.length > 0) {

                var fileArr = ree.attachments;
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

            if(ree.subcontractId){
                $.get('/plbDeptSubcontract/queryId',{subContractId:ree.subcontractId},function (res) {
                    if(res.flag){
                        //比价附件
                        $('#fileContent2').html(getFileEleStr(res.object.attachment2));
                        //合同附件
                        $('#fileContent1').html(getFileEleStr(res.object.attachment));
                    }
                })
            }



            if (type == 4) {
                $('input').attr('disabled','true')
                $('select').attr('disabled','true')
                $('button[lay-event="add"]').css('display','none')
                $('#saveBtn').css('display','none')
                $('#submitBtn').css('display','none')
                $('#reSubmitBtn').css('display','none')
                $('input[name="initiationType"]').css('display','none')
                $('.layui-layer-btn-c').hide()
                $('[name="customerName"]').attr('disabled', 'true')
                $('[name="settleupDate"]').attr('disabled', 'true')
                $('[name="contractName"]').attr('disabled', 'true')
                $('[name="settleupMoney"]').attr('disabled', 'true')
                $('[name="remark"]').attr('disabled', 'true')
                $('[name="settleupYear"]').attr('disabled', 'true')
                $('[name="settleupQuarter"]').attr('disabled', 'true')
                $('[name="settleupMonth"]').attr('disabled', 'true')
                $('[name="settlementPeriod"]').attr('disabled', 'true')
                $('[name="settlementDescription"]').attr('disabled', 'true')
                $('.file_upload_box').hide()
                $('.deImgs').hide()
                form.render()
            }
        } else {
            //预算执行明细1111
            var cols = [
                {type:'checkbox'},
                {
                    field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                        return '<input readonly id="'+d.LAY_TABLE_INDEX+'" contractListId="'+(d.contractListId || '')+'" name="deptName" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input ' + (type == '4' ? '' : 'choose_dept') + '" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + (isShowNull(d.deptName) || '') + '">';
                    }
                },
                {
                    field: 'rbsItemId', title: '预算科目名称', minWidth: 100, templet: function (d) {
                        return '<input contractId="'+(d.contractId || '')+'" name="rbsItemId" readonly rbsItemId="'+(d.rbsItemId || '')+'"   ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input ' + (type == '4' ? '' : 'rbsItemIdChoose') + '" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.rbsItemName) + '">';
                    }
                },
                {
                    field: 'expenseItem',
                    title: '费用项目',
                    minWidth: 200,
                    templet: function (d) {
                        return '<input name="expenseItem" type="text" readonly class="layui-input expenseItem" style="height: 100%;" expenseItem="' + isShowNull(d.expenseItem) + '" value="'+(d.expenseItemName||'')+'">';
                    }
                },
                // {
                //     field: 'cbsId',
                //     title: '会计科目名称',
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
                    title: '本次结算金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input id="applicationAmount" name="applicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.applicationAmount) + '">';
                    }
                },
                {
                    field: 'actualApplicationAmount',
                    title: '本次预算执行金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input id="actualApplicationAmount"  readonly name="actualApplicationAmount"  ' + (type == 4 ? 'readonly' : '') + ' subpaymentListId="' + (d.subpaymentListId || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%; background: #e7e7e7 " value="' + isShowNulls(d.actualApplicationAmount) + '">';
                    }
                },
                {
                    field: 'guaranteeFund',
                    title: '其中质保金',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input name="guaranteeFund"  ' + (type == 4 ? 'readonly' : '') + ' guaranteeFund="' + (d.guaranteeFund || '') + '" type="text" pointFlag="1"  class="layui-input input_floatNum outMoneyItem KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.guaranteeFund) + '">';
                    }
                },
                {
                    field: 'taxAmount',
                    title: '税额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input id="taxAmount" name="taxAmount"  ' + (type == 4 ? 'readonly' : '') + ' type="number" pointFlag="1" class="layui-input input_floatNum taxAmountItem KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNulls(d.taxAmount) + '">';
                    }
                },
                {
                    field: 'amountExcludingTax',
                    title: '不含税金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<input id="amountExcludingTax" name="amountExcludingTax"  readonly type="number"  class="layui-input input_floatNum KD_amount" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + isShowNulls(d.amountExcludingTax) + '">';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                        return '<input name="remark"  ' + (type == 4 ? 'readonly' : '') + ' type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                    }
                },
                {
                    field: 'invoices',
                    title: '发票',
                    minWidth: 200,
                    templet: function (d) {
                        var invoiceStr = '';
                        if (d.invoiceNosList) {
                            d.invoiceNosList.forEach(function (item, index) {
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
                        if (type != '4') {
                            // str = '<a class="choose_invoices"><i class="layui-icon layui-icon-upload-circle"></i></a>'
                        }
                        return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div>' + str + '</div>';
                    }
                }
            ]
            if (type != 4) {
                cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100, fixed: 'right'})
            }
            table.render({
                elem: '#materialDetailsTable',
                data: materialDetailsTableData,
                toolbar: '#toolbarDemoIns',
                defaultToolbar: [''],
                limit: 1000,
                cols: [cols],
                done: function () {
                    if (type == 4) {
                        $('.addRow').hide()
                    }
                    $('input[name="deptName"]').each(function (i, v) {
                        $(this).attr('id', 'dept_' + i);
                    });
                }
            });





            //合同付款明细
            var cols2 = [
                {
                    field: 'paymentType',
                    title: '预付单据编号',
                    event: 'choosePay',
                    minWidth: 150,
                    templet: function (d) {

                        return '<input chargemoneyId='+d.chargemoneyId+' value="' + isShowNull(d.advanceNo) + '" advanceId="' + (d.advanceId || '') + '" type="text" name="paymentType" subpaymentPaymentId="' + (d.subpaymentPaymentId || '') + '" readonly paymentType="' + isShowNull(d.paymentType) + '" class="layui-input" style="height: 100%; cursor: pointer;">';
                    }
                },
                {
                    field: 'prepaidAmount',
                    title: '预付金额',
                    minWidth: 150,
                    event: 'chooseCollectionUser1',
                    templet: function (d) {
                        var str = '';
                        var attr = '';
                        if (d.prepaidAmount) {
                            str = isShowNull(d.prepaidAmount);
                            attr = 'prepaidAmount="' + d.prepaidAmount + '" userType="2"';
                        } else {
                            str = isShowNull(d.collectionUserName).replace(/,$/, '');
                            attr = 'user_id="' + (d.prepaidAmount || '') + '" userType="1"';
                        }

                        return '<input readonly name="prepaidAmount" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'deductedAmount',
                    title: '已扣除金额',
                    minWidth: 150,
                    templet: function (d) {

                        return '<input readonly type="text" name="deductedAmount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + function(){
                            if(d.deductedAmount == undefined){
                                return ''
                            } else{
                                return d.deductedAmount
                            }
                        }() + '">';
                    }
                },
                {
                    field: 'prepaidBalance',
                    title: '预付余额',
                    minWidth: 150,
                    templet: function (d) {

                        return '<input id="prepaidBalance" type="text" readonly name="prepaidBalance" pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.prepaidBalance) + '">';
                    }
                },
                {
                    field: 'amountDeducted', title: '本次扣除金额', minWidth: 300, templet: function (d) {

                        return '<input lay-filter="amountDeducted" type="text" id="amountDeducted" name="amountDeducted" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountDeducted) + '">';
                    }
                },
                {
                    field: 'amountDeductedAfter', title: '扣除后余额', minWidth: 300, templet: function (d) {

                        return '<input id="kou" type="text" readonly name="amountDeductedAfter" class="layui-input amountExcludingTax kou" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountDeductedAfter) + '">';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {

                        return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
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
                    $('input[name="prepaidAmount"]').each(function (i, v) {
                        $(v).attr('id', 'prepaidAmount' + i);
                    });
                }
            });
        }
        element.render();
        form.render();
        laydate.render({
            elem: '#settleupDate' //指定元素
            , trigger: 'click' //采用click弹出
            , value: data ? format(data.settleupDate) : '',
            done: function (value, date, endDate) {
                $('#settleupYear').val(date.year)
                if (date.month < 4) {
                    $('[name="settleupQuarter"]').val('1')
                } else if (date.month < 7) {
                    $('[name="settleupQuarter"]').val('2')
                } else if (date.month < 10) {
                    $('[name="settleupQuarter"]').val('3')
                } else {
                    $('[name="settleupQuarter"]').val('4')
                }
                $('[name="settleupMonth"]').val(date.month)
                form.render()
            }
        });
        //日期时间范围
        laydate.render({
            elem: '#settlementPeriod'
            , type: 'date'
            ,trigger: 'click'
            , range: '~'
        });
        //日期时间范围
        laydate.render({
            //结算期间
            elem: '#settlementPeriod',
            range: '~',
            trigger: 'click',
            format: 'yyyy-MM-dd',
            value: data ? data.settlementPeriod : ''
        });

        //年选择器
        laydate.render({
            elem: '#settleupYear'
            , type: 'year'
            , trigger: 'click' //采用click弹出
            , value: data ? data.settleupYear : ''
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
                            auditerStatus: 2,//只有审批通过的合同可以选择
                            subcontractType:'01'
                        },
                        page: true,
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {field: 'contractName', title: '合同名称', width: 200,},
                            {field: 'contractTypeName', title: '合同类型'},
                            {field: 'contractPeriod', title: '合同工期',},
                            {field: 'contractMoney', title: '合同金额',},
                            {field: 'subcontractNo', title: '合同编号',},
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
                        $('#baseForm1 [name="contractFee"]').val(numberFormat(chooseData.contractMoney,2) || '/')
                        //累计支付金额
                        $('#baseForm1 [name="payedMoney"]').val(chooseData.accumulatedAmountPaid || 0)
                        //累计已结算金额
                        $('#baseForm1 [name="deptSettleupMoney"]').val(numberFormat(chooseData.accumulatedSettlatedAmount,2) || 0)
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
        //发票上传
        $(document).on('click', '.choose_invoices', function () {
            if (subpaymentId) {
                var $this = $(this)
                var $ele = $(this).prev();
                var contractNo = $('input[name="contractNo"]', $('#baseForm')).val();
                openPwyWeb(subpaymentId, contractNo, '', $ele, function (data) {
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
        // 节点点击事件
        $(document).on('click', '.con_left ul li', function () {
            $(this).addClass('select').siblings().removeClass('select');
            var deptId = $(this).attr('deptId');
            tableShow(deptId);
            $('#leftId').attr('deptId', deptId);
        });
        table.on('row(materialDetailsTable)', function(obj){
            avtiveTd = $(this)
        });
        //选择预算科目名称
        $(document).on('click', '.rbsItemIdChoose', function () {
            var _this = $(this);
            var deptId = _this.parents('tr').find('[name="deptName"]').attr('deptId').replace(/,$/,'')
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
                    var date=new Date();
                    var dateYear=date.getFullYear();
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
                        var budgetProj = checkStatus.data[0].plbMtlLibraryList;
                        if(budgetProj != undefined){
                            if(budgetProj.length == 1){
                                avtiveTd.find('input[name="expenseItem"]').val(budgetProj[0].mtlName || '');
                                avtiveTd.find('input[name="expenseItem"]').attr('expenseItem',budgetProj[0].mtlLibId);
                            }else{
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
                                            console.log(avtiveTd.find('input[name="expenseItem"]'))

                                            avtiveTd.find('input[name="expenseItem"]').val(rbsName || '');
                                            avtiveTd.find('input[name="expenseItem"]').attr('expenseItem',mtlLibId);
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                            }
                        }
                        //预算科目名称
                        _this.val(mtlData.rbsItemName);
                        _this.attr('rbsItemId', mtlData.rbsItemId);
                        // //会计科目名称
                        // _this.parents('tr').find('[name="cbsId"]').val(mtlData.plbCbsType ? mtlData.plbCbsType.cbsName : '')
                        // _this.parents('tr').find('[name="cbsId"]').attr('cbsId', mtlData.cbsId)
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


        var TableUIObj = new TableUI('plb_mtl_subsettleup');
        // TableUIObj.init(colShowObj);

        // 初始化左侧项目
        projectLeft();

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
                            expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                            expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            deptName: $(this).find('input[name="deptName"]').val(),
                            deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                            totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                            totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                            applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                            guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
                            amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                            taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                            remark: $(this).find('input[name="remark"]').val(),//备注
                            subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                            actualApplicationAmount:$(this).find('input[name="actualApplicationAmount"]').val()//本次预算执行金额
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
                            deptName: res.object.deptName
                        };
                        oldDataArr.push(addRowData);
                        table.reload('materialDetailsTable', {
                            data: oldDataArr
                        });
                    })
                    break;
                case 'adds':
                    var reimburseNo = $('input[name="contractNo"]', $('#baseForm')).val();
                    openPwyWeb(subpaymentId, reimburseNo, '', null, function (data) {
                        var dataArr = getPlbLongdistanceCosts().dataArr;
                        var rideStandardStr = $('#03').val();
                        if (data.length > 0) {
                            data.forEach(function (item,i) {
                                var amountExcludingTax = BigNumber(item.totalAmount).minus(item.taxAmount);
                                var taxRate = 0;
                                if (item.items && item.items.length > 0) {
                                    taxRate = item.items[0].taxRate;
                                } else {
                                    taxRate = item.taxRate || 0;
                                }
                                dataArr.push({
                                    deptId: $('#deptsId').attr('deptId'),
                                    deptName: $('#deptsId').attr('deptName'),
                                    // rideStandard: rideStandardStr,
                                    useDate: item.invoiceDate || '', // 发生日期
                                    // leavePlace: leavePlace, // 出发地
                                    // destination: destination, // 目的地
                                    actualApplicationAmount:'',
                                    applicationAmount: item.totalAmount,  // 含税金额合计
                                    taxAmount: item.taxAmount,  // 税额合计
                                    amountExcludingTax: amountExcludingTax, // 不含税金额合计
                                    invoiceNos: item.serialNo, // 发票流水号
                                    invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                    taxRate: taxRate, // 税率
                                    afterChangeAmount: item.totalAmount // 会计调整后金额
                                });

                            });
                            table.reload('materialDetailsTable', {
                                data: dataArr
                                ,done:function(res){
                                    var e = $("input[name='applicationAmount']").length
                                    var sum = 0;
                                    if(e == 1){
                                        for(var i=0;i<res.data.length;i++){
                                            var n = getysNum(res.data[i].applicationAmount,i,'0')
                                            $('input[name="actualApplicationAmount"]').eq(i).val(n)
                                            $('input[name="settleupMoney"]').val(n)
                                        }
                                    }else{
                                        for(var i=0;i<res.data.length;i++){
                                            var n = getysNum(res.data[i].applicationAmount,i,'0')
                                            $('input[name="actualApplicationAmount"]').eq(i).val(n)
                                        }
                                        for(var i=0;i<e;i++){
                                            sum += Number($("input[name='applicationAmount']").eq(i).val())
                                            $('input[name="settleupMoney"]').val(sum)
                                        }
                                    }


                                }
                            });

                            // getTripDetailTotal();
                        }
                    });
                    break;
                case 'merge':
                    var checkStatus=layTable.checkStatus('materialDetailsTable');

                    //判断是否可以合并
                    var flagDeptId = '';
                    var flagRbsItemId = '';
                    //遍历已勾选的数据，判断是否可以合并
                    var $trs = $('#materialDetailsTableModule').find('tbody .layui-form-checked').parents('tr');
                    //合并已选数据
                    var mergeData = {
                        expenseItem: $trs.eq(0).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                        expenseItemName: $trs.eq(0).find('input[name="expenseItem"]').val(),
                        rbsItemId: $trs.eq(0).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                        contractListId: $trs.eq(0).find('input[name="deptName"]').attr('contractListId'), // 主键
                        rbsItemName: $trs.eq(0).find('input[name="rbsItemId"]').val(), // rbsId名称
                        cbsId: $trs.eq(0).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                        cbsName: $trs.eq(0).find('input[name="cbsId"]').val(), // cbsId名称
                        deptName: $trs.eq(0).find('input[name="deptName"]').val(),
                        deptId: $trs.eq(0).find('input[name="deptName"]').attr('deptId'),
                        totalAnnualBudget: $trs.eq(0).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                        totalAnnualBalance: $trs.eq(0).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                        applicationAmount: $trs.eq(0).find('input[name="applicationAmount"]').val(),//本次申请金额
                        guaranteeFund: $trs.eq(0).find('input[name="guaranteeFund"]').val(),//质保金
                        amountExcludingTax: $trs.eq(0).find('input[name="amountExcludingTax"]').val(),//不含税金额
                        taxAmount: $trs.eq(0).find('input[name="taxAmount"]').val(),//税额
                        remark: $trs.eq(0).find('input[name="remark"]').val(),//备注
                        subpaymentListId: $trs.eq(0).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                        actualApplicationAmount:$trs.eq(0).find('input[name="actualApplicationAmount"]').val()//本次预算执行金额
                    }
                    var applicationAmount='0' //本次结算金额
                    var actualApplicationAmount='0'  //本次预算执行金额
                    var guaranteeFund='0' //质保金
                    var taxAmount='0' //税额
                    var amountExcludingTax='0' //不含税金额
                    //发票信息
                    var invoiceNos = '';
                    var invoiceNoStr = '';
                    var listIds = ''
                    $trs.each(function () {
                        applicationAmount=BigNumber(applicationAmount).plus(checkFloatNum($(this).find('[name="applicationAmount"]').val())).toNumber();
                        actualApplicationAmount=BigNumber(actualApplicationAmount).plus(checkFloatNum($(this).find('[name="actualApplicationAmount"]').val())).toNumber();
                        guaranteeFund=BigNumber(guaranteeFund).plus(checkFloatNum($(this).find('[name="guaranteeFund"]').val())).toNumber();
                        taxAmount=BigNumber(taxAmount).plus(checkFloatNum($(this).find('[name="taxAmount"]').val())).toNumber();
                        amountExcludingTax=BigNumber(amountExcludingTax).plus(checkFloatNum($(this).find('[name="amountExcludingTax"]').val())).toNumber();
                        //判断是否有发票
                        if ($(this).find('.invoices_box span').length > 0) {
                            invoiceNos += $(this).find('.invoices_box span').attr('fid') + ','
                            invoiceNoStr += $(this).find('.invoices_box span').text().replace(/,$/, '') + ','
                        }
                        if ($(this).find('[name="deptName"]').attr('contractListId')) {
                            listIds += $(this).find('[name="deptName"]').attr('contractListId') + ','
                        }

                        // $(this).remove()
                    });
                    mergeData.applicationAmount=applicationAmount
                    mergeData.actualApplicationAmount=actualApplicationAmount
                    mergeData.guaranteeFund=guaranteeFund
                    mergeData.taxAmount=taxAmount
                    mergeData.amountExcludingTax=amountExcludingTax

                    //合并后的发票信息
                    mergeData.invoiceNos = invoiceNos;
                    mergeData.invoiceNoStr = invoiceNoStr;
                    if (listIds) {
                        $.get('/plbContractInfo/delContractInfoList', {contractListId: listIds}, function (res) {

                        });
                    }
                    //获取剩余未选择的数据
                    var $trsAll = $('#materialDetailsTableModule').find('.layui-table-main tr');
                    var newdataArr = [];
                    //向新数组放合并后的数据
                    newdataArr.push(mergeData)
                    //向新数组放未选择的数据
                    $trsAll.each(function () {
                        if (!$(this).find('[name="layTableCheckbox"]').prop('checked')) {
                            var uncheckedData = {
                                expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                                expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                                rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                                rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                                cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                                deptName: $(this).find('input[name="deptName"]').val(),
                                deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                                totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                                totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                                applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                                guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
                                amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                                taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                                remark: $(this).find('input[name="remark"]').val(),//备注
                                subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                                actualApplicationAmount:$(this).find('input[name="actualApplicationAmount"]').val()//本次预算执行金额
                            }
                            //发票信息
                            var invoiceNos = '';
                            var invoiceNoStr = '';
                            $(this).find('.invoices_box span').each(function (i, v) {
                                invoiceNos += $(v).attr('fid') + ',';
                                invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
                            });
                            uncheckedData.invoiceNos = invoiceNos;
                            uncheckedData.invoiceNoStr = invoiceNoStr;

                            if ($(this).find('[name="deptItemId"]').attr('listid')) {
                                uncheckedData.listId = $(this).find('[name="deptItemId"]').attr('listid')
                            }

                            newdataArr.push(uncheckedData);
                        }
                    });
                    layTable.reload('materialDetailsTable', {
                        data: newdataArr
                    });
                    break
                case 'viewInvoice':
                    layer.open({
                        type:2,
                        title:'查看发票',
                        area:['90%','90%'],
                        content:'/plbDeptReimburse/viewInvoice?reimburseId='+contractId+'&type=02'
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
                var sum = 0;
                $('[name="applicationAmount"]').each(function(){
                    sum+=Number($(this).val());
                })
                var applicationAmount=$tr.find('[name="applicationAmount"]').val()||'0'
                $('[name="settleupMoney"]').val(BigNumber(keepTwoDecimalFull(sum,2)).minus(applicationAmount))
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
                        expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                        expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                        rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                        contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                        rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                        cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                        deptName: $(this).find('input[name="deptName"]').val(),
                        deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                        totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                        totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                        applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                        guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
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
                    ,done:function(res){
                        for(var i=0;i<res.data.length;i++){
                            var n = getysNum(res.data[i].applicationAmount,i,'0')
                            $('input[name="actualApplicationAmount"]').eq(i).val(n)
                        }
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
        });

        // 渲染表格
        function tableShow(deptId) {
            deptids = deptId
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


        function submitFlow(flowId, approvalData) {
            var loadIndex = layer.load();
            newWorkFlow(flowId, function (res) {
                var submitData = {
                    // subsettleupId: approvalData.subsettleupId,
                    runId: res.flowRun.runId,
                    contractId:contractId,
                    auditerStatus: 1
                }
                $.popWindow("/workflow/work/workform?contractType=1&opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                contractId=Number(contractId)
                if ($('.invoice_file').length > 0) {
                    submitKingDee(contractId,approvalData.contractNo, '', function () {
                        $.post('/plbContractInfo/approvalContract',submitData,function(res){
                            if(res.flag){
                                layer.msg('提交成功',{icon:1,time:1500},function(){
                                    parent.layui.table.reload('tableDemo',{
                                        page: {
                                            curr: 1
                                        }
                                    });
                                    parent.layer.close(parent.iframeLayerIndex);
                                })
                            }else{
                                layer.msg(res.msg, {icon: 2});
                            }
                        })
                    });
                }else{
                    $.post('/plbContractInfo/approvalContract',submitData,function(res){
                        if(res.flag){
                            layer.msg('提交成功',{icon:1,time:1500},function(){
                                parent.layui.table.reload('tableDemo',{
                                    page: {
                                        curr: 1
                                    }
                                });
                                parent.layer.close(parent.iframeLayerIndex);
                            })
                        }else{
                            layer.msg(res.msg, {icon: 2});
                        }
                    })
                }
                // $.post('/plbContractInfo/approvalContract',submitData,function(res){
                //     layer.close(loadIndex);
                //     if (res.flag) {
                //         if ($('.invoice_file').length > 0) {
                //             // 提交发票状态
                //             submitKingDee(contractId,approvalData.contractNo, '', function () {
                //                 layer.msg('提交成功!', {icon: 1,time:1500},function(){
                //                     parent.layui.table.reload('tableDemo',{
                //                         page: {
                //                             curr: 1
                //                         }
                //                     });
                //                     parent.layer.close(parent.iframeLayerIndex);
                //                 });
                //
                //             });
                //         }else{
                //             layer.msg('提交成功!', {icon: 1,time:1500},function(){
                //                 parent.layui.table.reload('tableDemo',{
                //                     page: {
                //                         curr: 1
                //                     }
                //                 });
                //                 parent.layer.close(parent.iframeLayerIndex);
                //             });
                //         }
                //     }else{
                //         layer.msg(res.msg, {icon: 2});
                //         parent.layui.table.reload('tableDemo');
                //     }
                // })
            }, approvalData);
        }


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
        //提交按钮
        $('#submitBtn').on('click',function(){
            var _flag=true
            //必填项提示
            for (var i = 0; i < $('.chen').length; i++) {
                if ($('.chen').eq(i).val() == '') {
                    layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
                    _flag=false
                    return
                }
            }
            //判断本次扣除金额不能大于本次结算金额
            var settleupMoneyNum=$('[name="settleupMoney"]').val().replace(/,/g,'');
            var amountDeducted=0;
            $('[name="amountDeducted"]').each(function(){
                amountDeducted+=Number($(this).val());
            })
            if(BigNumber(settleupMoneyNum).lt(amountDeducted)){
                layer.msg('本次扣除金额不能大于本次结算金额',{icon:0})
                return false
            }

            //判断本次结算金额不得大于合同金额-累计结算金额
            var subtrMoney = subtr($('[name="contractFee"]').val(), $('[name="deptSettleupMoney"]').val())
            if (($('[name="contractFee"]').val() != '/' && $('[name="contractFee"]').val()) && Number($('[name="settleupMoney"]').val()) > Number(subtrMoney)) {
                layer.msg('本次结算金额不得大于合同金额-累计结算金额', {icon: 0});
                return false
            }
            var loadIndex = layer.load();
            //材料计划数据
            var datas = $('#baseForm').serializeArray();
            var datass = $('#baseForm1').serializeArray();
            var obj = {}
            var plbContractSettle = {}
            datas.forEach(function (item) {
                obj[item.name] = item.value
            });
            datass.forEach(function (item) {
                plbContractSettle[item.name] = item.value
            });
            var sum = 0;
            $('[name="applicationAmount"]').each(function(){
                sum+=Number($(this).val());
            })
            var settleupMoney=keepTwoDecimalFull(sum,2)
            plbContractSettle.settleupMoney=settleupMoney

            //提示输入框只能输入数字
            for (var a = 0; a < $('.chinese').length; a++) {
                if (isNaN($('.chinese').eq(a).val())) {
                    layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                    return false
                }
            }
            //发起部门&发起人&报（文本）&客商单位名称&结算款（文本）&金额（取本次结算金额）


            //合同金额
            plbContractSettle.contractFee = $('[name="contractFee"]').val() == '/' ? '' : delcommafy($('[name="contractFee"]').val());
            plbContractSettle.cumulativeSettledRatio = $('[name="cumulativeSettledRatio"]').val() == '/' ? '' : delcommafy($('[name="cumulativeSettledRatio"]').val());
            delete plbContractSettle.cbsId
            delete plbContractSettle.rbsItemId
            delete plbContractSettle.deptId
            //累计已结算金额
            // obj.deptSettleupMoney = delcommafy($('[name="deptSettleupMoney"]').val());
            obj.deptId = deptIds
            obj.enginProject = $("input[name='enginProject']").attr('projId')
            obj.enginContract = $("input[name='enginContract']").attr('subcontractId')
            obj.developProject = $("input[name='developProject']").attr('pjNumber')
            obj.naturePayment=$('[name="naturePayment"]').val();
            obj.attachmentNum=$('[name="attachmentNum"]').val();
            plbContractSettle.payedMoney = parseFloat($("input[name='payedMoney']").val().replace(/,/g,''))
            plbContractSettle.deptSettleupMoney = parseFloat($("input[name='deptSettleupMoney']").val().replace(/,/g,''))



            if(obj.enginProject == undefined){
                obj.enginProject = ''
            }
            if(obj.enginContract == undefined){
                obj.enginContract = ''
            }
            if(obj.developProject == undefined){
                obj.developProject = ''
            }
            //合同id
            obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //客商单位名称id
            obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');
            obj.isAdvance = isAdvance
            // obj.initiationType = $("#initiationType").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value")
            obj.initiationType = $('select[name="initiationType"]').val()

            obj['plbContractSettle'] = plbContractSettle;
            // 附件
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            obj.attachmentId = attachmentId;
            obj.attachmentName = attachmentName;
            obj.contractType = '01'
            obj.deptId = deptIds;
            //预算执行明细数据
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var materialDetailsArr = [];
            var materialDetailsArrs = [];
            $tr.each(function () {
                var materialDetailsObj = {
                    expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                    expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                    cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                    deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                    contractListId: $(this).find('input[name="deptName"]').attr('contractlistid'),//主键
                    totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                    totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                    applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                    actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),//本次预算执行金额
                    amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                    guaranteeFund:$(this).find('input[name="guaranteeFund"]').val(),//质保金
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
            var $tr2 = $('.pym_info').find('.layui-table-main tr');
            $tr2.each(function () {
                var materialDetailsObjs = {
                    paymentType: $('input[name="paymentType"]').val(),//预付单据编号
                    chargemoneyid: $(this).find('input[name="paymentType"]').attr('chargemoneyid'),//主键
                    prepaidAmount: $(this).find('input[name="prepaidAmount"]').val(),//预付金额
                    deductedAmount: $(this).find('input[name="deductedAmount"]').val(),//以扣除金额
                    prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),//预付月
                    amountDeductedAfter: $(this).find('input[name="amountDeductedAfter"]').val(),//扣除后月
                    amountDeducted: $(this).find('input[name="amountDeducted"]').val(),//本次扣除金额
                    advanceid:$(this).find('input[name="paymentType"]').attr('advanceid'),
                    remark: $(this).find('input[name="remarks"]').val(),//备注
                }
                if(materialDetailsObjs.chargemoneyid == 'undefined'){
                    materialDetailsObjs.chargemoneyid = ''
                }
                materialDetailsArrs.push(materialDetailsObjs);
            });
            obj.plbContractInfoListWithBLOBsList = materialDetailsArr;
            obj.plbContractChargemoniesList = materialDetailsArrs;
            for(var i=0;i<obj.plbContractInfoListWithBLOBsList.length;i++){
                if(obj.plbContractInfoListWithBLOBsList[i].rbsItemId==''||obj.plbContractInfoListWithBLOBsList[i].rbsItemId==undefined){
                    layer.msg('请选择预算科目名称',{icon:0})
                    _flag=false
                    layer.close(loadIndex)
                    return
                }
            }
            if(type == 0){
                obj.contractId = contractId
            }
            if (type == 1) {
                obj.contractId = ree.contractId
                obj.plbContractInfoListWithBLOBsList.subsettleupId = ree.plbContractSettle.subsettleupId
                obj.plbContractSettle.subsettleupId = ree.plbContractSettle.subsettleupId
                obj.contractInfoName=ree.contractInfoName
            }
            if(_flag){
                $.ajax({
                    url: url,
                    data: JSON.stringify(obj),
                    dataType: 'json',
                    contentType: "application/json;charset=UTF-8",
                    type: 'post',
                    success: function (res) {
                        var deptName
                        if(res.data) deptName =  res.data.deptId + ',|' + res.data.deptName + ',';
                        layer.close(loadIndex);
                        if (res.flag) {
                            subpaymentId = res.object
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '12'}, function (res) {
                                var flowDataArr = []
                                $.each(res.data.flowData, function (k, v) {
                                    flowDataArr.push({
                                        flowId: k,
                                        flowName: v
                                    });
                                });
                                obj.subpaymentId = subpaymentId
                                var approvalData = obj
                                // //合同金额
                                // obj.contractFee = numberFormat(obj.contractFee, 2)
                                // //累计已结算金额
                                // obj.deptSettleupMoney = numberFormat(obj.deptSettleupMoney, 2)
                                // //本次结算金额
                                // obj.settleupMoney = numberFormat(obj.settleupMoney, 2)
                                if(deptName){
                                    approvalData.deptName =deptName
                                }else{
                                    approvalData.deptName = $('input[name="createUser"]').attr('deptName')
                                }

                                approvalData.deptSettleupMoney=numberFormat(approvalData.plbContractSettle.deptSettleupMoney,2)
                                approvalData.settleupMoney = approvalData.plbContractSettle.settleupMoney.replace(/,/g,'')
                                approvalData.advanceMoney = approvalData.plbContractSettle.advanceMoney
                                approvalData.advancePeriod = approvalData.plbContractSettle.advancePeriod
                                approvalData.contractFee = numberFormat(approvalData.plbContractSettle.contractFee,2)
                                approvalData.settlementDescription = approvalData.plbContractSettle.settlementDescription
                                approvalData.contractName = $('input[name="contractName"]').val()
                                approvalData.payedMoney = $('input[name="payedMoney"]').val()
                                approvalData.createUser = $('input[name="createUser"]').val()
                                approvalData.initiationType = $('select[name="initiationType"]').next().find('input').val()
                                //预算执行明细数据
                                var $tr = $('.mtl_info').find('.layui-table-main tr');
                                var materialDetailsArr = [];
                                $tr.each(function () {
                                    var materialDetailsObj = {
                                        expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                                        expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                                        rbsItemId: $(this).find('input[name="rbsItemId"]').val(), // rbsId
                                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                                        deptId: $(this).find('input[name="deptName"]').val(),
                                        contractListId: $(this).find('input[name="deptName"]').attr('contractlistid'),//主键
                                        totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                                        totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                                        applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                                        actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),//本次预算执行金额
                                        guaranteeFund:$(this).find('input[name="guaranteeFund"]').val(),//质保金
                                        amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                                        taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                                        remark: $(this).find('input[name="remark"]').val(),//备注
                                    }
                                    var str = '';
                                    str = materialDetailsObj.rbsItemId +  '`' + numberFormat(materialDetailsObj.totalAnnualBudget,2) + '`' + numberFormat(materialDetailsObj.totalAnnualBalance,2) + '`' + numberFormat(materialDetailsObj.applicationAmount,2) + '`' + materialDetailsObj.guaranteeFund + '`' + materialDetailsObj.deptId + '`' + materialDetailsObj.remark + '`' + numberFormat(materialDetailsObj.actualApplicationAmount,2) + '`' + materialDetailsObj.amountExcludingTax + '`' + materialDetailsObj.taxAmount + '`'  + materialDetailsObj.cbsId + '`'  + materialDetailsObj.contractListId + '`';
                                    materialDetailsArr.push(str);
                                });
                                materialDetailsArr = materialDetailsArr.join('\r\n');
                                materialDetailsArr += '|`````````';
                                approvalData.plbContractInfoListWithBLOBsList = materialDetailsArr;
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
                                            location.href = '/plbContractInfo/addGetPlbContractSettle?type=1&contractId=' + contractId
                                        },
                                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                                        success: function () {
                                            table.render({
                                                elem: '#flowTable',
                                                data: flowDataArr,
                                                cols: [[
                                                    {type: 'radio'},
                                                    {field: 'flowName', title: '流程名称'}
                                                ]]
                                            })
                                        },
                                        yes: function (index) {
                                            var checkStatus = table.checkStatus('flowTable');
                                            if (checkStatus.data.length > 0) {
                                                var flowData = checkStatus.data[0];

                                                submitFlow(flowData.flowId, approvalData)
                                                // parent.layer.close(parent.iframeLayerIndex);
                                            } else {
                                                layer.msg('请选择一项！', {icon: 0});
                                            }
                                        },
                                        btn2: function(index){
                                            layer.close(loadIndex);
                                            location.href = '/plbContractInfo/addGetPlbContractSettle?type=1&contractId=' + contractId
                                        }
                                    });
                                }
                            });
                        } else {
                            layer.msg(res.msg, {icon: 2});
                        }
                    }
                });
            }


            return false
        })

        //保存按钮
        $('#saveBtn').on('click', function(){
            //必填项提示
            // for (var i = 0; i < $('.chen').length; i++) {
            //     if ($('.chen').eq(i).val() == '') {
            //         layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
            //         return false
            //     }
            // }
            //判断本次扣除金额不能大于本次结算金额
            var settleupMoneyNum=$('[name="settleupMoney"]').val().replace(/,/g,'');
            var amountDeducted=0;
            $('[name="amountDeducted"]').each(function(){
                amountDeducted+=Number($(this).val());
            })
            if(BigNumber(settleupMoneyNum).lt(amountDeducted)){
                layer.msg('本次扣除金额不能大于本次结算金额',{icon:0})
                return false
            }
            //判断本次结算金额不得大于合同金额-累计结算金额
            var subtrMoney = subtr($('[name="contractFee"]').val(), $('[name="deptSettleupMoney"]').val())
            if (($('[name="contractFee"]').val() != '/' && $('[name="contractFee"]').val()) && Number($('[name="settleupMoney"]').val().replace(/,/g,'')) > Number(subtrMoney)) {
                layer.msg('本次结算金额不得大于合同金额-累计结算金额', {icon: 0});
                return false
            }
            var loadIndex = layer.load();
            //材料计划数据
            var datas = $('#baseForm').serializeArray();
            var datass = $('#baseForm1').serializeArray();
            var obj = {}
            var plbContractSettle = {}
            datas.forEach(function (item) {
                obj[item.name] = item.value
            });
            datass.forEach(function (item) {
                plbContractSettle[item.name] = item.value
            });

            plbContractSettle.deptSettleupMoney = parseFloat($("input[name='deptSettleupMoney']").val().replace(/,/g,''))
            plbContractSettle.payedMoney = parseFloat($("input[name='payedMoney']").val().replace(/,/g,''))
            var sum = 0;
            $('[name="applicationAmount"]').each(function(){
                sum+=Number($(this).val());
            })
            var settleupMoney=keepTwoDecimalFull(sum,2)
            plbContractSettle.settleupMoney=settleupMoney
            //提示输入框只能输入数字
            for (var a = 0; a < $('.chinese').length; a++) {
                if (isNaN($('.chinese').eq(a).val())) {
                    layer.msg($('.chinese').eq(a).attr('title') + '中只能填写数字', {icon: 0});
                    return false
                }
            }
            //合同金额
            plbContractSettle.contractFee = $('[name="contractFee"]').val() == '/' ? '' : delcommafy($('[name="contractFee"]').val());
            plbContractSettle.cumulativeSettledRatio = $('[name="cumulativeSettledRatio"]').val() == '/' ? '' : delcommafy($('[name="cumulativeSettledRatio"]').val());
            delete plbContractSettle.cbsId
            delete plbContractSettle.rbsItemId
            delete plbContractSettle.deptId
            //累计已结算金额
            obj.deptSettleupMoney = delcommafy($('[name="deptSettleupMoney"]').val());
            // //本次结算金额
            // obj.settleupMoney = delcommafy($('[name="settleupMoney"]').val());
            obj.deptId = deptIds
            obj.enginProject = $("input[name='enginProject']").attr('projId')
            obj.enginContract = $("input[name='enginContract']").attr('subcontractId')
            obj.developProject = $("input[name='developProject']").attr('pjNumber')
            obj.naturePayment=$('[name="naturePayment"]').val();
            obj.attachmentNum=$('[name="attachmentNum"]').val();
            obj.payedMoney = $("input[name='payedMoney']").val()
            obj.deptSettleupMoney = $("input[name='deptSettleupMoney']").val()

            if(obj.enginProject == undefined){
                obj.enginProject = ''
            }
            if(obj.enginContract == undefined){
                obj.enginContract = ''
            }
            if(obj.developProject == undefined){
                obj.developProject = ''
            }
            //合同id
            obj.subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';
            //客商单位名称id
            obj.customerId = $('.plan_base_info input[name="customerName"]').attr('customerId');
            obj.isAdvance = isAdvance
            obj.initiationType = $("#initiationType").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value")
            obj['plbContractSettle'] = plbContractSettle;
            // 附件
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            obj.attachmentId = attachmentId;
            obj.attachmentName = attachmentName;
            obj.contractType = '01'
            obj.deptId = deptIds;
            //预算执行明细数据
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var materialDetailsArr = [];
            var materialDetailsArrs = [];
            $tr.each(function () {
                var materialDetailsObj = {
                    expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                    expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                    rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                    cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                    deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                    contractListId: $(this).find('input[name="deptName"]').attr('contractlistid'),//主键
                    totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                    totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                    applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                    actualApplicationAmount: $(this).find('input[name="actualApplicationAmount"]').val(),//本次预算执行金额
                    amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                    guaranteeFund:$(this).find('input[name="guaranteeFund"]').val(),//质保金
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
            var $tr2 = $('.pym_info').find('.layui-table-main tr');
            $tr2.each(function () {
                var materialDetailsObjs = {
                    paymentType: $('input[name="paymentType"]').val(),//预付单据编号
                    chargemoneyid: $(this).find('input[name="paymentType"]').attr('chargemoneyid'),//主键
                    prepaidAmount: $(this).find('input[name="prepaidAmount"]').val(),//预付金额
                    deductedAmount: $(this).find('input[name="deductedAmount"]').val(),//以扣除金额
                    prepaidBalance: $(this).find('input[name="prepaidBalance"]').val(),//预付月
                    amountDeductedAfter: $(this).find('input[name="amountDeductedAfter"]').val(),//扣除后月
                    amountDeducted: $(this).find('input[name="amountDeducted"]').val(),//本次扣除金额
                    advanceid:$(this).find('input[name="paymentType"]').attr('advanceid'),
                    remark: $(this).find('input[name="remarks"]').val(),//备注
                }
                if(materialDetailsObjs.chargemoneyid == 'undefined'){
                    materialDetailsObjs.chargemoneyid = ''
                }
                materialDetailsArrs.push(materialDetailsObjs);
            });
            obj.plbContractInfoListWithBLOBsList = materialDetailsArr;
            obj.plbContractChargemoniesList = materialDetailsArrs

            if(type == 0){
                obj.contractId = contractId
            }
            if (type == 1) {
                obj.contractId = ree.contractId
                obj.plbContractInfoListWithBLOBsList.subsettleupId = ree.plbContractSettle.subsettleupId
                obj.plbContractSettle.subsettleupId = ree.plbContractSettle.subsettleupId
                obj.contractInfoName=ree.contractInfoName
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
                        layer.close(loadIndex);
                        location.href = '/plbContractInfo/addGetPlbContractSettle?type=1&contractId=' + contractId
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                }
            });
        })

        // 点击关闭
        $('#closeBtn').on('click', function () {
            parent.layer.close(parent.iframeLayerIndex);
            parent.layui.table.reload('tableDemo');
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

    });
    /**
     * 获取预算执行明细数据
     * @returns {{dataArr: *[], amountTotal: number, taxAmountTotal: number}}
     */
    function getPlbLongdistanceCosts() {
        var amountTotal = 0; // 含税总额
        var taxAmountTotal = 0; // 税额总额
        var adjustAmountTotal = 0; // 会计调整金额总额
        // 遍历表格获取每行数据
        var $trs = $('.mtl_info').find('.layui-table-main tr');
        var oldDataArr = [];
        $trs.each(function () {
            var oldDataObj = {
                expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                deptName: $(this).find('input[name="deptName"]').val(),
                deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
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

            // amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.amount)).toNumber();
            // taxAmountTotal = BigNumber(taxAmountTotal).plus(checkFloatNum(dataObj.taxAmount)).toNumber();
            // adjustAmountTotal = BigNumber(adjustAmountTotal).plus(checkFloatNum(dataObj.adjustAmount)).toNumber();
            oldDataArr.push(oldDataObj);
        });
        return {
            dataArr: oldDataArr
            // amountTotal: amountTotal,
            // taxAmountTotal: taxAmountTotal,
            // adjustAmountTotal: adjustAmountTotal
        }
    }
    function getPlbLongdistanceCostss() {
        var amountTotal = 0; // 含税总额
        var taxAmountTotal = 0; // 税额总额
        var adjustAmountTotal = 0; // 会计调整金额总额
        // 遍历表格获取每行数据
        var $trs = $('.mtl_info').find('.layui-table-main tr');
        var oldDataArr = [];
        $trs.each(function () {
            var oldDataObj = {
                expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
                expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                contractListId: $(this).find('input[name="deptName"]').attr('contractListId'), // 主键
                rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                deptName: $(this).find('input[name="deptName"]').val(),
                deptId: $(this).find('input[name="deptName"]').attr('deptId'),
                totalAnnualBudget: $(this).find('[data-field="totalAnnualBudget"] .layui-table-cell').text(),//年度预算总额
                totalAnnualBalance: $(this).find('[data-field="totalAnnualBalance"] .layui-table-cell').text(),//年度预算余额
                applicationAmount: $(this).find('input[name="applicationAmount"]').val(),//本次申请金额
                guaranteeFund: $(this).find('input[name="guaranteeFund"]').val(),//质保金
                amountExcludingTax: $(this).find('input[name="amountExcludingTax"]').val(),//不含税金额
                taxAmount: $(this).find('input[name="taxAmount"]').val(),//税额
                remark: $(this).find('input[name="remark"]').val(),//备注
                subpaymentListId: $(this).find('input[name="applicationAmount"]').attr('subpaymentListId'),//主键id
                actualApplicationAmount:$(this).find('input[name="actualApplicationAmount"]').val()//本次预算执行金额
            }
            var invoiceNos = '';
            var invoiceNoStr = '';
            $(this).find('.invoices_box span').each(function (i, v) {
                invoiceNos += $(v).attr('fid') + ',';
                invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
            });
            oldDataObj.invoiceNos = invoiceNos;
            oldDataObj.invoiceNoStr = invoiceNoStr;

            // amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.amount)).toNumber();
            // taxAmountTotal = BigNumber(taxAmountTotal).plus(checkFloatNum(dataObj.taxAmount)).toNumber();
            // adjustAmountTotal = BigNumber(adjustAmountTotal).plus(checkFloatNum(dataObj.adjustAmount)).toNumber();
            oldDataArr.push(oldDataObj);
        });
        return {
            dataArr: oldDataArr
            // amountTotal: amountTotal,
            // taxAmountTotal: taxAmountTotal,
            // adjustAmountTotal: adjustAmountTotal
        }
    }
    // 获取预算执行金额
    function getysNum(data,len,alldata) {
        var amountDeductedArrr = 0;
        var $chk = $("#radioBox").find(".layui-form-radioed div").html();
        if($chk == "是"){
            $('input[name="amountDeducted"]').each(function () {
                if($(this).val() == ''&&$(this).val() != undefined){
                    var num = 0
                }else if($(this).val() != ''&&$(this).val() != undefined){
                    var num = Number($(this).val())
                }
                amountDeductedArrr += num
            });
        }else if($chk == "否"){
            amountDeductedArrr = 0
        }
        var applicationAmountArrr = [];
        if(alldata == '0'){
            $('input[name="applicationAmount"]').each(function (i,item) {
                (function (i) {
                    if(i < (Number(len))){
                        if($(item).val() == ''&&$(item).val() != undefined){
                            applicationAmountArrr.push(0)
                        }else if($(item).val() != ''&&$(item).val() != undefined){
                            // var num1 = Number($(this).val())
                            applicationAmountArrr.push(Number($(item).val()))
                        }
                    }
                })(i)
            });
        }else{
            for(var i=0;i<alldata.length;i++){
                (function (i) {
                    if(i < (Number(len)+1)){
                        if(alldata[i].totalAmount == ''&&alldata[i].totalAmount != undefined){
                            applicationAmountArrr.push(0)
                        }else if(alldata[i].totalAmount != ''&&alldata[i].totalAmount != undefined){
                            // var num1 = Number($(this).val())
                            applicationAmountArrr.push(Number(alldata[i].totalAmount))
                        }
                    }
                })(i)
            }
        }
        var applicationAmountArrrs = 0
        for(var i=0;i<applicationAmountArrr.length;i++){
            applicationAmountArrrs += applicationAmountArrr[i]
        }
        var a = Number(data)
        var actualApplicationAmount = amountDeductedArrr - applicationAmountArrrs;
        if(a>actualApplicationAmount){
            if(actualApplicationAmount<=0){
                var actualApplicationAmountnum = a
            }else{
                var actualApplicationAmountnum = a - actualApplicationAmount;
            }
        }else{
            var actualApplicationAmountnum = 0
        }
        return Math.floor(actualApplicationAmountnum * 100) / 100
    }
    //判断是否显示空
    function isShowNull(data) {
        if (!!data) {
            return data
        } else {
            return ''
        }
    }
    function isShowNulls(data) {
        if (!!data) {
            return data
        } else {
            return '0'
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
    var contractNames;
    window.ppp = function(contractName){
        // if(pankName!=''){
        //     alert(pankName)
        // }
        contractNames = contractName;

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
    //选择工程合同
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

    //重选费用承担部门后，清空其余对应信息
    function importLeft() {
        $('#' + dept_id).parents('tr').find('[name="rbsItemId"]').val('')
        $('#' + dept_id).parents('tr').find('[name="rbsItemId"]').attr('rbsItemId', '')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').val('')
        $('#' + dept_id).parents('tr').find('[name="cbsId"]').attr('cbsId', '')
        $('#' + dept_id).parents('tr').find('.totalAnnualBudget').text('')
        $('#' + dept_id).parents('tr').find('.totalAnnualBalance').text('')
    }
    /**
     * 保留小数点后n位
     * @param num (数字)
     * @param n (小数点后几位，默认两位)
     */
    function keepTwoDecimalFull(num, n) {
        var result = parseFloat(num);
        if (isNaN(result)) {
            alert('传递参数错误，请检查！');
            return false;
        }
        if (isNaN(n) || !n || n <= 0) {
            n = 2;
        }
        var count = Math.pow(10, n);
        result = Math.round(num * count) / count;
        var s_x = result.toString();
        var pos_decimal = s_x.indexOf('.');
        if (pos_decimal < 0) {
            pos_decimal = s_x.length;
            s_x += '.';
        }
        while (s_x.length <= pos_decimal + n) {
            s_x += '0';
        }
        return s_x;
    }
</script>
<script type="text/javascript" src="/js/planbudget/kingDee.js?20211130.10"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>
</body>
</html>