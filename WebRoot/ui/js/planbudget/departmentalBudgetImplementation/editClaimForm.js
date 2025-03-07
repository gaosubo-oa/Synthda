var type = $.GetRequest()['type'] || '';
var reimburseType = $.GetRequest()['reimburseType'] || '';
var reimburseId = $.GetRequest()['reimburseId'] || '';
var disabled = $.GetRequest()['disabled'] || '';
var runId = $.GetRequest()['runId'] || '';
var flowId = $.GetRequest()['flowId'] || '';
var prcsId = $.GetRequest()['prcsId'] || '';
var isPreview = $.GetRequest()['isPreview'] || '';

//付款明细活跃的行
var avtiveTd

var reimburseStatus = '';

var layuiForm = null;

if (isPreview == '1') {
    // 调整定位，否则打印会有问题
    $('.wrapper').css('position', 'relative');
    $('.footer').hide();
}


var url = '';

if (reimburseType == '01' || reimburseType == '03'||reimburseType=='04') {
    $('[name="contractMoney"]').parent().parent().find('span').removeClass('field_required');
    $('[name="contractName"]').parent().parent().find('span').removeClass('field_required');
    $('[name="contractNo"]').parent().parent().find('span').removeClass('field_required');
    $('[name="merchantsUnitName"]').parent().parent().find('span').removeClass('field_required');
    $('[name="paymentMoney"]').parent().parent().find('span').removeClass('field_required');
    $('[name="naturePayment"]').parent().parent().find('span').removeClass('field_required');
    $('[name="occupationBudget"]').parent().parent().find('span').removeClass('field_required');

}
//资金支付审批单
if(reimburseType == '05'){
    $('#contractModule').show();
}
// 只有差旅报销单有行程明细
if(reimburseType == '01'){
    $('#tripDetailsModule').show();
}


var dictionaryObj = {
    PAYMENT_METHOD: {},
    REIMBURSEMENT_TYPE: {},
    TRAVEL_TYPE: {},
    INVOICE_TYPE: {},
    RIDE_STANDARD: {},
    CITY_COST_TYPE: {},
    SUBSIDY_TYPE: {},
    BILL_TYPE: {}
}
var dictionaryStr = 'PAYMENT_METHOD,REIMBURSEMENT_TYPE,TRAVEL_TYPE,INVOICE_TYPE,RIDE_STANDARD,CITY_COST_TYPE,SUBSIDY_TYPE,BILL_TYPE';
$.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
    if (res.flag) {
        for (var dict in dictionaryObj) {
            dictionaryObj[dict] = {object: {}, str: '', remarks: {}}
            if (res.object[dict]) {
                res.object[dict].forEach(function (item) {
                    dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                    dictionaryObj[dict]['remarks'][item.plbDictNo] = item.remarks;
                    dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                });
            }
        }
    }
    if (type != 1) {
        var loadIndex = layer.load();
        // 获取项目信息
        if (runId) {
            $.get('/plbDeptReimburse/getDataByRunId', {runId: runId}, function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    reimburseId = res.data.reimburseId;
                    initPage(res.data);
                } else {
                    initBaseHtml();
                    layer.msg('获取信息失败！', {icon: 2});
                }
            })
        } else {
            $.get('/plbDeptReimburse/getDataByReimburseId', {reimburseId: reimburseId}, function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    initPage(res.data);
                } else {
                    initBaseHtml();
                    layer.msg('获取信息失败！', {icon: 2});
                }
            });
        }
    } else {
        // 获取主键
        $.get('/plbDeptReimburse/getUUID', function (res) {
            reimburseId = res;
            initPage();
        });
    }
});

function initPage(reimburseInfo) {
    reimburseInfo = reimburseInfo || {}
    reimburseStatus = reimburseInfo.reimburseStatus;

    //退扫状态下显示保存按钮
    if (type == 3) {
        if (disabled != '1' || reimburseStatus == '4') {
            //保存
            $('#submitBtn').hide();
            $('#closeBtn').hide();
        } else {
            $('#saveBtn').hide();
            $('#submitBtn').hide();
            $('#closeBtn').hide();
            $('#reSubmitBtn').hide();
        }
    }
    if (isPreview == '1') {
        $('title').text('报销单-' + (reimburseInfo.reimburseNo || ''))
    }

    initBaseHtml();

    layui.use(['form', 'table', 'element', 'laydate', 'eleTree'], function () {
        var layTable = layui.table,
            element = layui.element,
            laydate = layui.laydate,
            layForm = layuiForm = layui.form,
            eleTree = layui.eleTree,
            table = layui.table;

        if(reimburseType != '05'){
            if (reimburseInfo.relationImageUrl) {
                $('#reimbursementWriteModule').before('<button class="layui-btn layui-btn-sm" style="margin-left: 17px;margin-bottom: 18px" id="preview">查看影像</button>');
                // if(reimburseInfo.invoiceImage=='0'){
                //     layer.msg('发票无法生成影像，请联系管理员',{icon:0,time:1000});
                // }
                $('#preview').on('click', function () {
                    window.open(reimburseInfo.relationImageUrl + '&userId=' + reimburseInfo.createUser);
                    return false;
                });
            }
        }
        if(runId){
            $('#reimbursementWriteModule').before('<button class="layui-btn layui-btn-sm" style="margin-left: 17px;margin-bottom: 18px" id="viewInvoice">查看发票</button>');
            $('#viewInvoice').on('click', function () {
                layer.open({
                    type:2,
                    title:'查看发票',
                    area:['90%','90%'],
                    content:'/plbDeptReimburse/viewInvoice?reimburseId='+reimburseId+'&type=01'
                })
            });
        }


        element.render();

        var layDateObj = {
            longDistanceTable: [],
            cityCostTable: [],
            stayCostTable: [],
            otherCostTable: [],
            subsidyTable: []
        }

        // 报销明细-加行
        layTable.on('toolbar(reimbursementDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    var dataArr = getReimbursementDetailsData(true).dataArr;
                    dataArr.push(getNewObj())
                    layTable.reload('reimbursementDetailsTable', {
                        data: dataArr
                    });
                    break;
                case 'addInovice':
                    var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                    var baseObj = getNewObj();
                    openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data) {
                        var dataObj = getReimbursementDetailsData(true);
                        var applicationAmountTotal = dataObj.amountTotal;
                        if (data.length > 0) {
                            data.forEach(function (item) {
                                var taxRate = 0;
                                if (item.items && item.items.length > 0) {
                                    taxRate = item.items[0].taxRate;
                                } else {
                                    taxRate = item.taxRate || 0;
                                }
                                var amountExcludingTax = BigNumber(item.totalAmount).minus(item.taxAmount);
                                var newObj = deepClone(baseObj);
                                newObj.reimbursementAmount = item.totalAmount;  // 差旅/个人-报销金额
                                newObj.taxAmount = item.taxAmount;  // 税额
                                newObj.amountExcludingTax = amountExcludingTax; // 不含税金额
                                newObj.invoiceNos = item.serialNo; // 发票流水号
                                newObj.invoiceNoStr = item.invoiceNo || '发票'; // 发票号码
                                newObj.taxRate = taxRate; // 税率
                                if(reimburseType=='04'){
                                    newObj.applicationAmount=item.totalAmount; //限额费用-报销金额
                                }else if(reimburseType=='03'){
                                    newObj.applicationAmount=item.totalAmount;//个人费用报销-本次执行金额
                                }
                                dataObj.dataArr.push(newObj);
                                applicationAmountTotal = BigNumber(item.totalAmount).plus(applicationAmountTotal);
                            });

                            layTable.reload('reimbursementDetailsTable', {
                                data: dataObj.dataArr
                            });

                            $('input[name="reimburseTotal"]', $('#baseForm')).val(applicationAmountTotal);
                        }
                    });
                    break;
                case 'merge':
                    var checkStatus = layTable.checkStatus('reimbursementDetailsTable');

                    var checkStatusData = checkStatus.data
                    var whetherChargeMoney=$('[name="whetherChargeMoney"]:checked').val();//是否冲账
                    // if (checkStatusData.length < 2) {
                    //     layer.msg('请至少选两项进行合并！', {icon: 0});
                    //     return false
                    // }

                    //判断是否可以合并
                    var ifMerge = true
                    var ifRbsItemId = true
                    var flagDeptId = '';
                    var flagRbsItemId = '';
                    //遍历已勾选的数据，判断是否可以合并
                    var $trs = $('#reimbursementDetailsModule').find('tbody .layui-form-checked').parents('tr');
                    $trs.each(function () {
                        var deptId = $(this).find('[name="deptId"]').attr('deptId') //费用承担部门
                        var rbsItemId = $(this).find('[name="deptItemId"]').attr('rbsItemId') //预算科目
                        var taxAmount = $(this).find('[name="taxAmount"]').val()//税额
                        if (taxAmount) {
                            ifMerge = false;
                            return false
                        }
                        if (!rbsItemId) {
                            ifRbsItemId = false;
                            return false
                        }
                        if ((flagDeptId && deptId && deptId != flagDeptId) || (flagRbsItemId && rbsItemId && rbsItemId != flagRbsItemId)) {
                            ifMerge = false;
                            return false
                        }
                        flagDeptId = deptId;
                        flagRbsItemId = rbsItemId;
                    });
                    // if (!ifMerge) {
                    //     layer.msg('费用承担部门和预算科目必须相同且税额为空才可以合并！', {icon: 0});
                    //     return false
                    // }
                    // if (!ifRbsItemId) {
                    //     layer.msg('请选择预算科目后进行合并！', {icon: 0});
                    //     return false
                    // }

                    //合并已选数据
                    var mergeData = {
                        expenseItem: $trs.eq(0).find('input[name="expenseItem"]').attr('expenseItem' || ''), // 费用项目
                        expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                        rbsItemId: $trs.eq(0).find('input[name="deptItemId"]').attr('rbsItemId') || '',
                        rbsId: $trs.eq(0).find('input[name="deptItemId"]').attr('rbsId') || '',
                        cbsId: $trs.eq(0).find('input[name="deptItemId"]').attr('cbsId') || '',
                        taxAmount: $trs.eq(0).find('input[name="taxAmount"]').val(),
                        deptId: ($trs.eq(0).find('input[name="deptId"]').attr('deptId') || '').replace(/,$/, ''),
                        itemDesc: $trs.eq(0).find('input[name="itemDesc"]').val(),
                        vehicleFile: $trs.eq(0).find('input[name="vehicleFile"]').val(),
                        planTaskId: $trs.eq(0).find('.planTaskId').attr('planTaskId'),
                        taxRate: $trs.eq(0).find('input[name="taxAmount"]').attr('taxRate') || 0,
                        itemName: $trs.eq(0).find('input[name="deptItemId"]').val(),
                        budgetMoney: $trs.eq(0).find('.budgetMoney').text(),
                        budgetBalance: $trs.eq(0).find('.budgetBalance').text(),
                        deptName: $trs.eq(0).find('input[name="deptId"]').val(),
                        planTaskName: $trs.eq(0).find('.planTaskId').text(),
                    }
                    if (reimburseType == '04') {
                        mergeData.reimburseUser = ($trs.eq(0).find('input[name="reimburseUser"]').attr('user_id') || '').replace(/,$/, '');
                        mergeData.reimburseBelongDept = ($trs.eq(0).find('input[name="reimburseBelongDept"]').attr('dept_id') || '').replace(/,$/, '');
                        mergeData.reimburseUserName = $trs.eq(0).find('input[name="reimburseUser"]').val();
                        mergeData.reimburseBelongDeptName = $trs.eq(0).find('input[name="reimburseBelongDept"]').val();
                    }
                    var reimbursementAmount = 0//报销金额
                    var applicationAmount=0//本次执行金额
                    var amountExcludingTax = 0//不含税金额
                    //发票信息
                    var invoiceNos = '';
                    var invoiceNoStr = '';
                    var listIds = ''
                    $trs.each(function () {
                        if(whetherChargeMoney=='1'){
                            reimbursementAmount = BigNumber(applicationAmount).plus(checkFloatNum($(this).find('[name="reimbursementAmount"]').val())).toNumber();
                            applicationAmount = BigNumber(applicationAmount).plus(checkFloatNum($(this).find('[name="applicationAmount"]').val())).toNumber();
                            amountExcludingTax = BigNumber(amountExcludingTax).plus(checkFloatNum($(this).find('.amountExcludingTax').text())).toNumber();
                        }else if(whetherChargeMoney=='0'){
                            reimbursementAmount = BigNumber(applicationAmount).plus(checkFloatNum($(this).find('[name="reimbursementAmount"]').val())).toNumber();
                            applicationAmount = BigNumber(applicationAmount).plus(checkFloatNum($(this).find('.applicationAmount').text())).toNumber();
                            amountExcludingTax = BigNumber(amountExcludingTax).plus(checkFloatNum($(this).find('.amountExcludingTax').text())).toNumber();
                        }else{
                            applicationAmount = BigNumber(applicationAmount).plus(checkFloatNum($(this).find('[name="applicationAmount"]').val())).toNumber();//限额报销单-报销金额
                            amountExcludingTax = BigNumber(amountExcludingTax).plus(checkFloatNum($(this).find('.amountExcludingTax').text())).toNumber();
                        }

                        //判断是否有发票
                        if ($(this).find('.invoices_box span').length > 0) {
                            invoiceNos += $(this).find('.invoices_box span').attr('fid') + ','
                            invoiceNoStr += $(this).find('.invoices_box span').text().replace(/,$/, '') + ','
                        }
                        if ($(this).find('[name="deptItemId"]').attr('listid')) {
                            listIds += $(this).find('[name="deptItemId"]').attr('listid') + ','
                        }

                        // $(this).remove()
                    });
                    mergeData.reimbursementAmount = reimbursementAmount //合并后的报销金额
                    mergeData.applicationAmount=applicationAmount //合并后的本次执行金额
                    mergeData.amountExcludingTax = amountExcludingTax //合并后的不含税金额
                    //合并后的发票信息
                    mergeData.invoiceNos = invoiceNos;
                    mergeData.invoiceNoStr = invoiceNoStr;

                    // 删除合并已选数据
                    if (listIds) {
                        $.get('/plbDeptReimburse/deleteDeptReimburseListByListId', {listId: listIds}, function (res) {

                        })
                    }

                    //获取剩余未选择的数据
                    var $trsAll = $('#reimbursementDetailsModule').find('.layui-table-main tr');
                    var newdataArr = [];
                    //向新数组放合并后的数据
                    newdataArr.push(mergeData)
                    //向新数组放未选择的数据
                    $trsAll.each(function () {
                        if (!$(this).find('[name="layTableCheckbox"]').prop('checked')) {
                            var uncheckedData = {
                                expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem' || ''), // 费用项目
                                expenseItemName: $(this).find('input[name="expenseItem"]').val(),
                                rbsItemId: $(this).find('input[name="deptItemId"]').attr('rbsItemId') || '',
                                rbsId: $(this).find('input[name="deptItemId"]').attr('rbsId') || '',
                                cbsId: $(this).find('input[name="deptItemId"]').attr('cbsId') || '',
                                taxAmount: $(this).find('input[name="taxAmount"]').val(),
                                deptId: ($(this).find('input[name="deptId"]').attr('deptId') || '').replace(/,$/, ''),
                                itemDesc: $(this).find('input[name="itemDesc"]').val(),
                                vehicleFile: $(this).find('input[name="vehicleFile"]').val(),
                                planTaskId: $(this).find('.planTaskId').attr('planTaskId'),
                                taxRate: $(this).find('input[name="taxAmount"]').attr('taxRate') || 0,
                                itemName: $(this).find('input[name="deptItemId"]').val(),
                                budgetMoney: $(this).find('.budgetMoney').text(),
                                budgetBalance: $(this).find('.budgetBalance').text(),
                                deptName: $(this).find('input[name="deptId"]').val(),
                                planTaskName: $(this).find('.planTaskId').text(),
                                amountExcludingTax: $(this).find('.amountExcludingTax').text(),//不含税金额
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
                            if(reimburseType =='03'){
                                if(whetherChargeMoney=='1'){
                                    uncheckedData.applicationAmount=$(this).find('input[name="applicationAmount"]').val() //本次执行金额
                                    uncheckedData.reimbursementAmount=$(this).find('input[name="reimbursementAmount"]').val() //本次报销金额
                                }else if(whetherChargeMoney=='0'){
                                    uncheckedData.applicationAmount=$(this).find('.applicationAmount').text() //本次执行金额
                                    uncheckedData.reimbursementAmount=$(this).find('input[name="reimbursementAmount"]').val() //本次报销金额
                                }
                            }
                            if (reimburseType == '04') {
                                uncheckedData.reimburseUser = ($(this).find('input[name="reimburseUser"]').attr('user_id') || '').replace(/,$/, '');
                                uncheckedData.reimburseBelongDept = ($(this).find('input[name="reimburseBelongDept"]').attr('dept_id') || '').replace(/,$/, '');
                                uncheckedData.reimburseUserName = $(this).find('input[name="reimburseUser"]').val();
                                uncheckedData.reimburseBelongDeptName = $(this).find('input[name="reimburseBelongDept"]').val();
                                uncheckedData.applicationAmount=$(this).find('input[name="applicationAmount"]').val() // 报销金额
                            }

                            if ($(this).find('[name="deptItemId"]').attr('listid')) {
                                uncheckedData.listId = $(this).find('[name="deptItemId"]').attr('listid')
                            }

                            newdataArr.push(uncheckedData);
                        }
                    });

                    layTable.reload('reimbursementDetailsTable', {
                        data: newdataArr
                    });
                    break;
                case 'viewInvoice':
                    layer.open({
                        type:2,
                        title:'查看发票',
                        area:['90%','90%'],
                        content:'/plbDeptReimburse/viewInvoice?reimburseId='+reimburseId+'&type=01'
                    })
                    break;
            }

            function getNewObj() {
                var newObj = {}
                var deptId = '';
                var deptName = '';
                if (reimburseType == '04') {
                    deptId = $('[name="reimburseBelongDept"]', $('#baseForm')).val();
                    deptName = $('[name="reimburseBelongDept"]', $('#baseForm')).next().find('input').val();
                    var nameArr = deptName.split(/\//);
                    deptName = nameArr[nameArr.length - 1];
                    newObj.reimburseBelongDept = deptId;
                    newObj.reimburseBelongDeptName = deptName;
                    newObj.reimburseUser = $('[name="createUser"]', $('#baseForm')).attr('user_id') || '';
                    newObj.reimburseUserName = $('[name="createUser"]', $('#baseForm')).val();
                } else {
                    deptId = $('[name="reimburseBelongDept"]', $('#baseForm')).val();
                    deptName = $('[name="reimburseBelongDept"]', $('#baseForm')).next().find('input').val();
                    var nameArr = deptName.split(/\//);
                    deptName = nameArr[nameArr.length - 1];
                }
                newObj.deptId = deptId;
                newObj.deptName = deptName;
                return newObj
            }
        });
        // 预算执行-行操作
        layTable.on('tool(reimbursementDetailsTable)', function (obj) {
            var data = obj.data;
            var data2 = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                if (data.listId) {
                    if(runId){
                        deleteInvoice(reimburseType,reimburseInfo);
                    }
                    $.get('/plbDeptReimburse/deleteDeptReimburseListByListId', {listId: data.listId}, function (res) {
                        if (res.flag) {
                            layer.msg('删除成功!', {icon: 1, time: 2000});
                            obj.del();
                            var reimbursementData = getReimbursementDetailsData(true);
                            layTable.reload('reimbursementDetailsTable', {
                                data: reimbursementData.dataArr
                            });
                            if(reimburseType=='01'||reimburseType=='03'){
                                $('[name="reimburseTotal"]', $('#baseForm')).val(reimbursementData.amountTotal);
                            }else if(reimburseType=='05'){
                                var appNum=0
                                $('[name="applicationAmount"]').each(function(){
                                    appNum=Number($(this).val());
                                })
                                $('[name="reimburseTotal"]', $('#baseForm')).val(appNum);
                                $('[name="paymentMoney"]', $('#baseForm')).val(appNum);
                                $('#paymentMoneyStr').val(number_chinese(appNum));
                            }else{
                                var appNum=0
                                $('[name="applicationAmount"]').each(function(){
                                    appNum=Number($(this).val());
                                })
                                $('[name="reimburseTotal"]', $('#baseForm')).val(appNum);
                            }
                            var paymentmentDetailsData = getPaymentmentDetailsData(false);
                            if(paymentmentDetailsData.dataArr!=undefined&&paymentmentDetailsData.dataArr!=''){
                                paymentmentDetailsData.dataArr[0].collectionMoney=(paymentmentDetailsData.dataArr[0].collectionMoney)-(data.applicationAmount);
                                layTable.reload('paymentDetailsTable', {
                                    data: paymentmentDetailsData.dataArr
                                });
                            }
                        } else {
                            layer.msg('删除失败!', {icon: 2, time: 2000});
                        }
                    });
                } else {
                    var appNum=0;
                    if(reimburseType=='01'||reimburseType=='03'){
                        appNum=$tr.find('.applicationAmount').text();
                    }else{
                        appNum=$tr.find('[name="applicationAmount"]').val();
                    }
                    var paymentmentDetailsData = getPaymentmentDetailsData(true);
                    if(paymentmentDetailsData.dataArr!=undefined&&paymentmentDetailsData.dataArr!=''){
                        paymentmentDetailsData.dataArr[0].collectionMoney=(paymentmentDetailsData.dataArr[0].collectionMoney)-(appNum);
                        layTable.reload('paymentDetailsTable', {
                            data: paymentmentDetailsData.dataArr
                        });
                    }
                    layer.msg('删除成功!', {icon: 1, time: 2000});
                    obj.del();
                    var reimbursementData = getReimbursementDetailsData(true);
                    layTable.reload('reimbursementDetailsTable', {
                        data: reimbursementData.dataArr
                    });
                    if(reimburseType=='01'||reimburseType=='03'){
                        $('[name="reimburseTotal"]', $('#baseForm')).val(reimbursementData.amountTotal);
                    }else if(reimburseType=='05'){
                        var appNum=0
                        $('[name="applicationAmount"]').each(function(){
                            appNum=Number($(this).val());
                        })
                        $('[name="reimburseTotal"]', $('#baseForm')).val(appNum);
                        $('[name="paymentMoney"]', $('#baseForm')).val(appNum);
                        $('#paymentMoneyStr').val(number_chinese(appNum));
                    }else{
                        var appNum=0
                        $('[name="applicationAmount"]').each(function(){
                            appNum=Number($(this).val());
                        })
                        $('[name="reimburseTotal"]', $('#baseForm')).val(appNum);
                    }
                }
            } else if (layEvent === 'chooseItem') {
                if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                    return false;
                }
                var applicationAmountData;
                if(reimburseType=='04'||reimburseType=='05'){
                     applicationAmountData=$tr.find('.applicationAmount').val();
                }else{
                    applicationAmountData=$tr.find('.reimbursementAmount').val();
                }

                var deptId = ($tr.find('input[name="deptId"]').attr('deptid') || '').replace(/,$/, '');
                if (!deptId) {
                    layer.msg('请选择费用承担部门！', {icon: 0});
                    return false;
                }
                chooseItem(deptId, 2, applicationAmountData,function (itemArr) {
                    var itemData = itemArr;
                    if(reimburseType=='03'){
                        var reimbursementWriteData = getReimbursementWriteData(false);
                        if(reimbursementWriteData.dataArr!=undefined&&reimbursementWriteData.dataArr!=''){
                            for(var i=0;i<reimbursementWriteData.dataArr.length;i++){
                                if(itemData.expenseItem==reimbursementWriteData.dataArr[i].expenseItem){
                                    var reiBur=$tr.find('[name="reimbursementAmount"]').val();
                                    if(reiBur!=''&&reiBur!='0'){
                                        $tr.find('.applicationAmount').text(BigNumber(reiBur).minus(reimbursementWriteData.dataArr[i].nhPrepaymentAmount))
                                    }
                                }
                            }
                        }
                    }
                    $tr.find('.deptItemId').val(itemData.rbsItemName || '');
                    // var natVal=$('[name="naturePayment"]').val()
                    // if(natVal!=undefined&&natVal!='010'){
                    //     $tr.find('.deptItemId').attr('cbsId', itemData.cbsId);
                    // }else{
                    //     $tr.find('.deptItemId').attr('cbsId', itemData.plbCbsType.cbsId);
                    // }
                    $tr.find('.deptItemId').attr('rbsItemId', itemData.rbsItemId);
                    $tr.find('.budgetMoney').text(itemData.budgetMoney);
                    $tr.find('.budgetBalance').text(itemData.budgetBalance);
                });
            } else if (layEvent === 'chooseReimburseBelongDept') {
                if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                    return false;
                }
                var userId = ($tr.find('input[name="reimburseUser"]').attr('user_id') || '').replace(/,$/, '');
                if (userId) {
                    layer.open({
                        type: 1,
                        title: '选择所属部门',
                        area: ['30%', '50%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div><table id="reimburseDeptTable" lay-filter="reimburseDeptTable"></table></div>',
                        success: function () {
                            // 获取用户所有所属部门
                            var deptData = []
                            $.get('/plbDeptReimburse/getOwnDept', {userId: userId}, function (res) {
                                if (res.flag) {
                                    $.each(res.data.depts, function (k, o) {
                                        var obj = {
                                            deptId: k,
                                            deptName: o
                                        }
                                        deptData.push(obj);
                                    });
                                }
                                layTable.render({
                                    elem: '#reimburseDeptTable',
                                    data: deptData,
                                    cols: [[
                                        {type: 'radio'},
                                        {field: 'deptName', title: '所属部门', sort: true}
                                    ]]
                                });
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('reimburseDeptTable');
                            if (checkStatus.data.length > 0) {
                                var deptData = checkStatus.data[0];

                                $tr.find('input[name="reimburseBelongDept"]').attr('dept_id', deptData.deptId);
                                $tr.find('input[name="reimburseBelongDept"]').val(deptData.deptName);

                                $tr.find('input[name="deptId"]').attr('deptId', deptData.deptId);
                                var nameArr = deptData.deptName.split(/\//);
                                $tr.find('input[name="deptId"]').val(nameArr[nameArr.length - 1]);

                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                } else {
                    layer.msg('请选择报销人！', {icon: 0, time: 1500});
                }
            } else if (layEvent == 'choosePlanTask') {
                if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                    return false;
                }
                var tabIndex = 0;
                var planTaskIdR = '';
                var planTaskNameR = '';
                var planTaskIdL = '';
                var planTaskNameL = '';
                layer.open({
                    type: 1,
                    title: '添加关联关键任务',
                    area: ['80%', '80%'],
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="position: relative;height: 100%;margin: 0;">',
                        '<ul class="layui-tab-title">',
                        '<li class="layui-this">主项关键任务</li>',
                        '<li>职能关键任务</li>',
                        '</ul>',
                        '<div class="layui-tab-content" style="position: absolute;top: 41px;left: 0;right: 0;bottom: 0;">',
                        '<div class="layui-tab-item layui-show" style="height: 100%;">',
                        '<div class="layui-row mainLeftQuery layui-form">',
                        '<div class="layui-col-xs4">',
                        '<div class="layui-form-item" style="margin: 0;">',
                        '<label class="layui-form-label" style="padding: 9px 0px">责任部门:</label>',
                        '<div class="layui-input-block" style="margin-left: 85px;">',
                        '<input type="text" name="mainCenterDept" id="mainCenterDept" readonly class="layui-input" style="background:#e7e7e7; cursor: pointer" />',
                        '<a class="deptDel"><i class="layui-icon layui-icon-close-fill"></i></a>',
                        '</div>',
                        '</div>',
                        '</div>',
                        '<button type="button" class="layui-btn layui-btn-sm queryTarget" style="margin-left: 5%;margin-top: 5px;">查询</button>',
                        '</div>',
                        '<div style="position: absolute;top: 53px;left: 0;right: 0;bottom: 0;"><div class="con_left">',
                        '<div class="eleTree ele1" style="overflow-x: auto;height: 100%;" lay-filter="projectLeft"></div>',
                        '</div>',
                        '<div class="con_right layui-form"></div></div>',
                        '</div>',
                        '<div class="layui-tab-item" style="height: 100%;">',
                        '<div class="layui-row mainRightQuery layui-form">',
                        '<div class="layui-col-xs3">',
                        '<div class="layui-form-item" style="margin: 0;">',
                        '<label class="layui-form-label" style="padding: 9px 0px;width: 50px">年度:</label>',
                        '<div class="layui-input-block" style="margin-left: 57px;">',
                        '<select name="year">',
                        '<option value="">请选择</option>',
                        '</select>',
                        '</div>',
                        '</div>',
                        '</div>',
                        '<button type="button" class="layui-btn layui-btn-sm queryTarget" style="margin-left: 5%;margin-top: 5px;">查询</button>',
                        '</div>',
                        '<div class="wrapper"  style="position: absolute;top: 53px;left: 0;right: 0;bottom: 0;"><div class="wrap_left">',
                        '<div class="eleTree ele1Z" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeftZ"></div>',
                        '</div>',
                        '<div class="wrap_right layui-form"></div></div>',
                        '</div>',
                        '</div>',
                        '</div>'].join(''),
                    success: function () {
                        layForm.render();

                        element.on('tab(docDemoTabBrief)', function (data) {
                            tabIndex = data.index;
                        });

                        /* region 主项关键任务 */
                        projectLeft();

                        // 主项计划-左侧树
                        function projectLeft() {
                            eleTree.render({
                                elem: '.ele1',
                                url: '/projectTarget/ProjectProAndBag?projOrgId=',
                                highlightCurrent: true,
                                showLine: true,
                                accordion: true,
                                request: {
                                    name: "name",
                                    key: "ids",
                                    children: "bags",
                                },
                                response: {
                                    statusName: 'code',
                                    statusCode: 0,
                                    dataName: "obj"
                                }
                            });
                        }

                        // 主项-左侧节点点击事件
                        eleTree.on("nodeClick(projectLeft)", function (d) {
                            var currentData = d.data.currentData;
                            if (currentData.pbagId) {
                                $('.mainLeftQuery .queryTarget').attr('projectId', currentData.projectId);
                                $('.mainLeftQuery .queryTarget').attr('pbagId', '');
                                rigthShow('', currentData.pbagId, '');
                            } else {
                                $('.mainLeftQuery .queryTarget').attr('projectId', currentData.projectId);
                                $('.mainLeftQuery .queryTarget').attr('pbagId', '');
                                rigthShow(currentData.projectId, '', '');
                            }
                        });

                        // 主项-右侧
                        function rigthShow(projectId, pbagId, deptId) {
                            $.ajax({
                                url: '/projectTarget/selectByProOrBagShow',
                                dataType: 'json',
                                type: 'get',
                                data: {projectId: projectId, pbagId: pbagId, deptId: deptId, useFlag: false},
                                success: function (res) {
                                    if (res.flag) {
                                        var data = res.obj
                                        var str = ''
                                        for (var i = 0; i < data.length; i++) {
                                            str += '<div class="layui-input-block" style="margin-left: 20px"><input lay-filter="leftTarget" type="radio" name="tgName" title="' + res.obj[i].tgName + '" value="' + res.obj[i].tgId + '" lay-skin="primary"></div>'
                                        }
                                        $('.con_right').html(str)
                                        layForm.render()
                                    }
                                }
                            });
                        }

                        layForm.on('radio(leftTarget)', function (data) {
                            planTaskIdL = data.value;
                            planTaskNameL = $(data.elem).attr('title');
                        });

                        // 主项-查询
                        $('.mainLeftQuery .queryTarget').click(function () {
                            var projectId = $(this).attr('projectId')
                            var pbagId = $(this).attr('pbagId')
                            if (!projectId || !pbagId) {
                                layer.msg('请先选择左侧！', {icon: 0});
                                return false;
                            }
                            if ($('#mainCenterDept').attr('deptId')) {
                                var mainCenterDept = $('#mainCenterDept').attr('deptId').replace(/,$/, '')
                            } else {
                                var mainCenterDept = '';
                            }
                            rigthShow(projectId, pbagId, mainCenterDept);
                        })

                        $('#mainCenterDept').on('click', function () {
                            dept_id = 'mainCenterDept';
                            $.popWindow('/common/selectDept?0');
                        });
                        $('.deptDel').on('click', function () {
                            $('#mainCenterDept').val('').attr('deptid', '').attr('deptname', '');
                        });
                        /* endregion */

                        /* region 职能关键任务 */
                        // 获取计划期间年度列表
                        $.get('/planPeroidSetting/selectAllYear', function (res) {
                            var allYear = '';
                            if (res.object.length > 0) {
                                res.object.forEach(function (item) {
                                    allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                                });
                            }
                            $('.mainRightQuery [name="year"]').append(allYear);
                            layForm.render('select');
                            // 默认职能关键任务年度为当年
                            $('.mainRightQuery select[name="year"] option').each(function () {
                                var nowYear = new Date().getFullYear()
                                if ($(this).text() == nowYear) {
                                    $('.mainRightQuery select[name="year"]').val($(this).val())
                                    layForm.render()
                                }
                            });
                        });

                        projectLeftZ()

                        //职能-左侧
                        function projectLeftZ() {
                            eleTree.render({
                                elem: '.ele1Z',
                                url: '/plcOrg/getTreeListByLoginer?projOrgId=',
                                highlightCurrent: true,
                                showLine: true,
                                accordion: true,
                                request: {
                                    name: "contractorName",
                                    key: "deptId",
                                    children: "orgList",
                                },
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    dataName: "object"
                                },
                                done: function () {
                                    /*var con_right=$(window).width()-$('.con_leftZ').width()-200
                                                $('.con_rightZ').css('width',con_right)*/
                                }
                            });
                        }

                        // 职能-左侧节点点击事件
                        eleTree.on("nodeClick(projectLeftZ)", function (d) {
                            if (d.data.currentData.deptParent != 0) {
                                // var con_right = $(window).width() - $('.con_leftZ').width() - 200
                                // $('.con_rightZ').css('width', con_right)
                                $('.mainRightQuery .queryTarget').attr('projOrgId', d.data.currentData.projOrgId)
                                rigthShowZ(d.data.currentData.projOrgId, '');
                            }
                        });

                        // 职能-右侧
                        function rigthShowZ(projOrgId, year) {
                            $.ajax({
                                url: '/projectTarget/targetByDept',
                                dataType: 'json',
                                type: 'get',
                                data: {projOrgId: projOrgId, year: year, flag: 2, useFlag: false},
                                success: function (res) {
                                    if (res.flag) {
                                        var data = res.obj
                                        var str = ''
                                        for (var i = 0; i < data.length; i++) {
                                            str += '<div class="layui-input-block" style="margin-left: 20px"><input lay-filter="rightTarget" type="radio" name="tgName" title="' + res.obj[i].tgName + '" value="' + res.obj[i].tgId + '" lay-skin="primary"></div>'
                                        }
                                        $('.wrap_right').html(str)
                                        layForm.render()
                                    }
                                }
                            });
                        }

                        //职能-查询
                        $('.mainRightQuery .queryTarget').click(function () {
                            var projOrgId = $(this).attr('projOrgId')
                            if (projOrgId == undefined) {
                                layer.msg('请先选择左侧部门！', {icon: 0});
                                return false
                            }
                            var year = $('.mainRightQuery select[name="year"]').val() || '';
                            rigthShowZ(projOrgId, year);
                        });

                        layForm.on('radio(rightTarget)', function (data) {
                            planTaskIdR = data.value;
                            planTaskNameR = $(data.elem).attr('title');
                        });
                        /*endregion*/
                    },
                    yes: function (index) {
                        var planTaskId = tabIndex == 0 ? planTaskIdL : planTaskIdR;
                        var planTaskName = tabIndex == 0 ? planTaskNameL : planTaskNameR;

                        if (planTaskId != '') {
                            $tr.find('.planTaskId').attr('planTaskId', planTaskId).text(planTaskName);
                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                })
            }else if(layEvent == 'addReceipts'){
                var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                var baseObj = getNewObj();
                openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data) {
                    var dataObj = getReimbursementDetailsData(true);
                    var applicationAmountTotal = dataObj.amountTotal;
                    var invoices = '';
                    var serialNo = '';
                    if (data.length > 0) {
                        data.forEach(function (item) {
                            var newObj = deepClone(baseObj);
                            newObj.invoiceNoStr = item.invoiceNo || '发票'; // 发票号码
                            dataObj.dataArr.push(newObj);
                            applicationAmountTotal = BigNumber(item.totalAmount).plus(applicationAmountTotal);
                            invoices += '<span class="invoice_file ' + item.invoiceNo + '" fid="' + item.serialNo + '">' + (item.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                            serialNo += item.serialNo + ',';
                        });
                        $tr.find('.invoices_box').html('');
                        $tr.find('.invoices_box').append(invoices);
                        // 保存修改后发票数据
                        $.ajax({
                            url: '/plbDeptReimburse/updateInvoiceData',
                            data: {
                                invoiceNos: serialNo,
                                tableType: 1,
                                tableId: data2.listId,
                            },
                            dataType: 'json',
                            // contentType: "application/json;charset=UTF-8",
                            type: 'get',
                            success: function (res) {

                            }
                        });

                        // $('input[name="reimburseTotal"]', $('#baseForm')).val(applicationAmountTotal);
                    }
                });
            }
            function getNewObj() {
                var newObj = {}
                var deptId = '';
                var deptName = '';

                if (reimburseType == '04') {
                    deptId = $('[name="reimburseBelongDept"]', $('#baseForm')).val();
                    deptName = $('[name="reimburseBelongDept"]', $('#baseForm')).next().find('input').val();
                    var nameArr = deptName.split(/\//);
                    deptName = nameArr[nameArr.length - 1];
                    newObj.reimburseBelongDept = deptId;
                    newObj.reimburseBelongDeptName = deptName;
                    newObj.reimburseUser = $('[name="createUser"]', $('#baseForm')).attr('user_id') || '';
                    newObj.reimburseUserName = $('[name="createUser"]', $('#baseForm')).val();
                } else {
                    deptId = $('[name="reimburseBelongDept"]', $('#baseForm')).val();
                    deptName = $('[name="reimburseBelongDept"]', $('#baseForm')).next().find('input').val();
                    var nameArr = deptName.split(/\//);
                    deptName = nameArr[nameArr.length - 1];
                }
                newObj.deptId = deptId;
                newObj.deptName = deptName;

                return newObj
            }
        });

        // 预算核销-加行
        layTable.on('toolbar(reimbursementWriteTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    var writeData = getReimbursementWriteData(true);
                    writeData.dataArr.push(getWriteNewObj())
                    layTable.reload('reimbursementWriteTable', {
                        data: writeData.dataArr
                    });
                    break;
            }

            function getWriteNewObj() {
                var newObj = {}
                newObj={
                    reimburseId:reimburseId,
                }
                return newObj
            }
        });
        // 预付核销-行操作
        layTable.on('tool(reimbursementWriteTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            var writeExpenseItem=$tr.find('[name="reimburseNo"]').attr('expenseItem');
            if (layEvent === 'del') {
                if (data.chargemoneyId) {
                    $.get('/plbDeptReimburse/deleteChargemoney', {chargemoneyId: data.chargemoneyId}, function (res) {
                        if (res.flag) {
                            layer.msg('删除成功!', {icon: 1, time: 2000});
                            obj.del();
                            var reimbursementWriteData = getReimbursementWriteData(true);
                            layTable.reload('reimbursementWriteTable', {
                                data: reimbursementWriteData.dataArr
                            });
                            var  reimbursementDetailsData= getReimbursementDetailsData(true);
                            if(reimbursementDetailsData.dataArr!=undefined&&reimbursementDetailsData.dataArr.length!=''){
                                for(var i=0;i<reimbursementDetailsData.dataArr.length;i++){
                                    if(writeExpenseItem==reimbursementDetailsData.dataArr[i].expenseItem){
                                        reimbursementDetailsData.dataArr[i].applicationAmount=BigNumber(reimbursementDetailsData.dataArr[i].applicationAmount).plus(data.nhPrepaymentAmount);
                                    }
                                }
                                layTable.reload('reimbursementDetailsTable', {
                                    data: reimbursementDetailsData.dataArr
                                });
                            }
                        } else {
                            layer.msg('删除失败!', {icon: 2, time: 2000});
                        }
                    });
                } else {
                    var nhNum=$tr.find('[name="nhPrepaymentAmount"]').val();
                    var  reimbursementDetailsData= getReimbursementDetailsData(true);
                    if(reimbursementDetailsData.dataArr!=undefined&&reimbursementDetailsData.dataArr.length!=''){
                        for(var i=0;i<reimbursementDetailsData.dataArr.length;i++){
                            if(writeExpenseItem==reimbursementDetailsData.dataArr[i].expenseItem){
                                reimbursementDetailsData.dataArr[i].applicationAmount=BigNumber(reimbursementDetailsData.dataArr[i].applicationAmount).plus(nhNum);
                            }
                        }
                        layTable.reload('reimbursementDetailsTable', {
                            data: reimbursementDetailsData.dataArr
                        });
                    }
                    obj.del();
                    layer.msg('删除成功!', {icon: 1, time: 2000});
                    var reimbursementWriteData = getReimbursementWriteData(true);
                    layTable.reload('reimbursementWriteTable', {
                        data: reimbursementWriteData.dataArr
                    });
                }
            } else if (layEvent === 'chooseItem') {
                if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                    return false;
                }
                layer.open({
                    type:1,
                    title:'选择预付单据',
                    area:['80%','80%'],
                    btn:['确定','取消'],
                    btnAlign:'c',
                    content: ['<div class="container">',
                        '<table id="reimburseNoTable" lay-filter="reimburseNoTable"></table>',
                        '</div>'].join(''),
                    success:function(){
                        var tableData=[]
                        $.ajax({
                            url:"/plbDeptReimburse/getBudgetList",
                            async:false,
                            success:function(res){
                                if(res.data!=undefined){
                                    tableData=res.data
                                }
                            }
                        })
                        layTable.render({
                            elem:'#reimburseNoTable',
                            page:true,
                            data:tableData,
                            cols:[[
                                {type:'radio'},
                                {field:'reimburseNo',title:'单据编号',minWidth:120},
                                {field:'reimburseDate',title:'报销日期',minWidth: 80},
                                {field: 'reimburseUser',title:'报销人',minWidth:80},
                                {field:'rbsItemName',title:'预算科目',minWidth: 100},
                                {field: 'expenseItem', title: '费用项目', minWidth: 100,},
                                {field:'reimburseName',title:'所属部门',minWidth:100},
                                {field:'reimburseDesc',title:'报销是由',minWidth:100},
                                {field:'reimburseTotal',title:'报销金额(元)',minWidth:80},

                            ]]
                        })
                    },
                    yes:function(index){
                        var checkStatusData = layTable.checkStatus('reimburseNoTable').data;
                        if(checkStatusData.length>0){
                            $tr.find('input[name="merchantsUnitName"]').attr('contractId',(checkStatusData[0].plbDeptContract[0].contractId )||'');
                            $tr.find('input[name="merchantsUnitName"]').val((checkStatusData[0].plbDeptContract[0].merchantsUnitName )||'');
                            $tr.find('input[name="reimburseNo"]').val((checkStatusData[0].reimburseNo )||'');
                            $tr.find('input[name="reimburseNo"]').attr('expenseItem',(checkStatusData[0].expenseItem)||'');
                            $tr.find('input[name="reimburseNo"]').attr('capitalReimburseId',(checkStatusData[0].plbDeptContract[0].reimburseId)||'');
                            $tr.find('input[name="reimburseNo"]').attr('rbsItemId',(checkStatusData[0].rbsItemId)||'');
                            $tr.find('input[name="budgetAmount"]').val((checkStatusData[0].plbDeptReimburseLists[0].thorApplicationAmount));
                            $tr.find('input[name="rebateAmount"]').val(checkStatusData[0].plbDeptReimburseLists[0].rebateAmount );
                            $tr.find('input[name="hxPrepaymentAmount"]').val((checkStatusData[0].plbDeptReimburseLists[0].thorApplicationAmount-checkStatusData[0].plbDeptReimburseLists[0].rebateAmount));
                           layer.close(index)
                        }else{
                            layer.msg('请选择一条数据',{icon: 0})
                        }

                    }
                })
            }
        });

        // 付款明细-加行
        layTable.on('toolbar(paymentDetailsTable)', function (obj) {
            var $tr = obj.tr;
            switch (obj.event) {
                case 'add':
                    var whetherChargeMoneyVal=$('[name="whetherChargeMoney"]:checked',$('#baseForm')).val();
                    //遍历表格获取每行数据进行保存
                    var dataArr = getPaymentmentDetailsData(true).dataArr;
                    var reimburseTotal = $('[name="reimburseTotal"]', $('#baseForm')).val();
                    var userId = ($('#reimburseUser').attr('user_id') || '').replace(/,$/, '');
                    if (userId) {
                        var collectionMoneyVal=0
                        if(whetherChargeMoneyVal == 1){
                            var reimbursementDetailsData = getReimbursementDetailsData(false);
                            var appTotal=0;//预算执行本次执行金额
                            for(var i=0;i<reimbursementDetailsData.dataArr.length;i++){
                                appTotal=BigNumber(appTotal).plus(reimbursementDetailsData.dataArr[i].applicationAmount)
                                //appTotal+=Number(reimbursementDetailsData.dataArr[i].applicationAmount);
                            }
                            collectionMoneyVal=appTotal
                            if(dataArr.length>=1){
                                collectionMoneyVal=0
                            }
                        }else{
                            collectionMoneyVal=reimburseTotal
                        }
                        getUserInfo(userId, function (res) {
                            var newObj = {
                                collectionUser: userId,
                                collectionUserName: $('#reimburseUser').val(),
                                collectionMoney: collectionMoneyVal,
                                paymentType: '02'
                            }
                            if (res.object && res.object.userExt) {
                                newObj.collectionAccount = res.object.userExt.bankCardNumber || '';
                                newObj.collectionBank = res.object.userExt.bankDeposit || '';
                                newObj.collectionBankName = res.object.userExt.bankDepositName || '';
                            }
                            dataArr.push(newObj);
                            layTable.reload('paymentDetailsTable', {
                                data: dataArr
                            });
                        });
                    } else {
                        dataArr.push(
                            {
                                collectionMoney: reimburseTotal,
                                paymentType: '02'
                            }
                        );
                        var dataArrNum=dataArr.length
                        if(reimburseType == '05'){
                            if(dataArrNum>1){
                                dataArr[dataArrNum-1].collectionMoney='0';
                                dataArr[dataArrNum-1].customerName=$('[name="merchantsUnitName"]').val()||'';
                                dataArr[dataArrNum-1].customerId=$('[name="merchantsUnitName"]').attr('customerid');
                                dataArr[dataArrNum-1].collectionAccount=$('[name="merchantsUnitName"]').attr('collectionaccount');
                                dataArr[dataArrNum-1].collectionBankName=$('[name="merchantsUnitName"]').attr('collectionbank');
                                dataArr[dataArrNum-1].collectionBank=$('[name="merchantsUnitName"]').attr('collectionbankNo');
                            }else{
                                dataArr[0].collectionMoney=$('[name="paymentMoney"]').val()||'';
                                dataArr[0].customerName=$('[name="merchantsUnitName"]').val()||'';
                                dataArr[0].customerId=$('[name="merchantsUnitName"]').attr('customerid');
                                dataArr[0].collectionAccount=$('[name="merchantsUnitName"]').attr('collectionaccount');
                                dataArr[0].collectionBankName=$('[name="merchantsUnitName"]').attr('collectionbank');
                                dataArr[0].collectionBank=$('[name="merchantsUnitName"]').attr('collectionbankNo');
                            }
                        }else{
                            if(dataArrNum>1){
                                if((dataArr[dataArrNum-2].customerId)==undefined||(dataArr[dataArrNum-2].customerId)==''){
                                    dataArr[dataArrNum-1].collectionUserName=dataArr[dataArrNum-2].collectionUserName;
                                    dataArr[dataArrNum-1].collectionUser=dataArr[dataArrNum-2].collectionUser;
                                }else{
                                    dataArr[dataArrNum-1].customerName=dataArr[dataArrNum-2].customerName;
                                    dataArr[dataArrNum-1].customerId=dataArr[dataArrNum-2].customerId;
                                }
                                dataArr[dataArrNum-1].collectionAccount=dataArr[dataArrNum-2].collectionAccount;
                                dataArr[dataArrNum-1].collectionBankName=dataArr[dataArrNum-2].collectionBankName;
                                dataArr[dataArrNum-1].collectionBank=dataArr[dataArrNum-2].collectionBank;
                            }
                        }
                        layTable.reload('paymentDetailsTable', {
                            data: dataArr
                        });
                    }
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

        // 付款明细-行操作
        layTable.on('tool(paymentDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            var $tr = obj.tr;
            if (layEvent === 'del') {
                if (data.paymentId) {
                    $.get('/plbDeptReimburse/deleteDeptPaymentByPaymentId', {paymentId: data.paymentId}, function (res) {
                        if (res.flag) {
                            layer.msg('删除成功!', {icon: 1, time: 2000});
                            obj.del();
                            layTable.reload('paymentDetailsTable', {
                                data: getPaymentmentDetailsData(true).dataArr
                            });
                        } else {
                            layer.msg('删除失败!', {icon: 2, time: 2000});
                        }
                    });
                } else {
                    layer.msg('删除成功!', {icon: 1, time: 2000});
                    obj.del();
                    layTable.reload('paymentDetailsTable', {
                        data: getPaymentmentDetailsData(true).dataArr
                    });
                }
            } else if (layEvent === 'choosePay') {
                if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                    return false;
                }
                layer.open({
                    type: 1,
                    title: '选择付款方式',
                    area: ['40%', '70%'],
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="container">',
                        '<table id="paymentTable" lay-filter="paymentTable"></table>',
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
                        layTable.render({
                            elem: '#paymentTable',
                            data: data,
                            page: false,
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'value', title: '付款方式'}
                            ]]
                        });
                    },
                    yes: function (index) {
                        var checkStatus = layTable.checkStatus('paymentTable');
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
                if ((type == 3 && disabled == '1') || reimburseStatus == '4'|| reimburseType == '05') {
                    return false;
                }
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
                            var merchantType = '';
                            layer.open({
                                type: 2,
                                title: '选择收款人',
                                area: ['80%', '80%'],
                                maxmin: true,
                                btnAlign: 'c',
                                btn: ['确定'],
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
                                    //window[layero.find('iframe')[0]['name']];

                                    //document.getElementsByTagName('iframe')[0].contentWindow.yesBtn()
                                    // var checkStatus = layTable.checkStatus('materialsTable');
                                    // if (checkStatus.data.length > 0) {
                                    //     var mtlData = checkStatus.data[0];
                                    //     if(mtlData.plbCustomerBankList != undefined){
                                    //         if (mtlData.plbCustomerBankList.length > 0) {
                                    //             var selectBank = layer.open({
                                    //                 type: 1,
                                    //                 title: '选择银行账户',
                                    //                 shade: 0.3,
                                    //                 area: ['750px', '400px'],
                                    //                 content: '<table id="selectBank" lay-filter="selectBank">\n' +
                                    //                     '  <thead>\n' +
                                    //                     '    <tr>\n' +
                                    //                     '      <th lay-data="{type:\'radio\'}">选择</th>\n' +
                                    //                     '      <th lay-data="{field:\'accountType\', width:100}">账户类型</th>\n' +
                                    //                     '      <th lay-data="{field:\'bankAccount\', width:220}">银行账号</th>\n' +
                                    //                     '      <th lay-data="{field:\'bankOfDepositName\', width:220, sort:true}">开户行</th>\n' +
                                    //                     '      <th lay-data="{field:\'bankOfDeposit\', width:130, sort:true}">银行行号</th>\n' +
                                    //
                                    //                     '    </tr> \n' +
                                    //                     '  </thead>\n' +
                                    //                     function () {
                                    //                         var str = '';
                                    //                         for (var i = 0; i < mtlData.plbCustomerBankList.length; i++) {
                                    //                             str += '<tr>\n' +
                                    //                                 '      <td><input type="radio" name="selectBankName" value="' + i + '"></td>' +
                                    //                                 '      <td>' + function () {
                                    //                                     if (mtlData.plbCustomerBankList[i].accountType == 0) {
                                    //                                         return '基本户'
                                    //                                     } else {
                                    //                                         return '其他户'
                                    //                                     }
                                    //                                 }() + '</td>\n' +
                                    //                                 '      <td>' + mtlData.plbCustomerBankList[i].bankAccount + '</td>\n' +
                                    //                                 '      <td>' + mtlData.plbCustomerBankList[i].bankOfDepositName + '</td>\n' +
                                    //                                 '      <td>' + mtlData.plbCustomerBankList[i].bankOfDeposit + '</td>\n' +
                                    //                                 '    </tr>'
                                    //                         }
                                    //                         return str
                                    //                     }() +
                                    //                     '  <tbody>\n' +
                                    //                     '  </tbody>\n' +
                                    //                     '</table>',
                                    //                 btn: ['确定'],
                                    //                 success: function () {
                                    //                     //转换静态表格
                                    //                     layui.table.init('selectBank', {
                                    //                         limit: mtlData.plbCustomerBankList.length
                                    //                     });
                                    //                 },
                                    //                 yes: function () {
                                    //                     var selectBankData = layui.table.checkStatus('selectBank').data[0];
                                    //                     $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                    //                     $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                    //                     $tr.find('[name="collectionAccount"]').val(selectBankData.bankAccount);
                                    //                     $tr.find('[name="collectionBank"]').val(selectBankData.bankOfDepositName);
                                    //                     $tr.find('[name="collectionBank"]').attr('collectionBankNo', selectBankData.bankOfDeposit);
                                    //                     layer.closeAll();
                                    //                 }
                                    //             })
                                    //         } else {
                                    //             $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                    //             $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                    //             $tr.find('[name="collectionAccount"]').val('');
                                    //             $tr.find('[name="collectionBank"]').val('');
                                    //             $tr.find('[name="collectionBank"]').removeAttr('collectionBankNo');
                                    //             layer.close(index);
                                    //         }
                                    //     }else{
                                    //         $tr.find('[name="collectionUser"]').val(mtlData.customerName);
                                    //         $tr.find('[name="collectionUser"]').attr('customerId', mtlData.customerId);
                                    //         $tr.find('[name="collectionAccount"]').val('');
                                    //         $tr.find('[name="collectionBank"]').val('');
                                    //         $tr.find('[name="collectionBank"]').removeAttr('collectionBankNo');
                                    //         layer.close(index);
                                    //     }
                                    //
                                    //
                                    // } else {
                                    //     layer.msg('请选择一项！', {icon: 0});
                                    // }
                                }
                            });
                        });
                    }
                });
            }
        });

        if (reimburseType == '01' || reimburseType == '02') {
            // 长途交通费-加行
            layTable.on('toolbar(longDistanceTable)', function (obj) {
                switch (obj.event) {
                    case 'add':

                            var $tr = $('#longDistanceTableModule').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $tr.each(function () {
                                var oldDataObj = {
                                    leavePlace: $(this).find('input[name="leavePlace"]').val(),
                                }
                                oldDataArr.push(oldDataObj);
                            });
                            var addRowData = {};
                            oldDataArr.push(addRowData);
                            layTable.reload('longDistanceTable', {
                                data: oldDataArr
                            });

                        break;
                    case 'addInovice':
                        var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                        openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data) {
                            var dataArr = getPlbLongdistanceCosts().dataArr;
                            var rideStandardStr = $('#03').val();
                            if (data.length > 0) {
                                data.forEach(function (item) {
                                    var leavePlace = '';
                                    var destination = '';
                                    // 如果是飞机票则出发地和到达地
                                    if (item.invoiceType == '10') {
                                        leavePlace = item.placeOfDeparture || ''
                                        destination = item.destination || ''
                                    } else {
                                        if (item.trip && item.trip.indexOf('-') > -1) {
                                            var tripArr = item.trip.replace(/\s/g, '').split('-')
                                            leavePlace = tripArr[0];
                                            destination = tripArr[1];
                                        }
                                    }
                                    var amountExcludingTax = BigNumber(item.totalAmount).minus(item.taxAmount);
                                    var taxRate = 0;
                                    if (item.items && item.items.length > 0) {
                                        taxRate = item.items[0].taxRate;
                                    } else {
                                        taxRate = item.taxRate || 0;
                                    }
                                    dataArr.push({
                                        rideStandard: rideStandardStr,
                                        useDate: item.invoiceDate || '', // 发生日期
                                        leavePlace: leavePlace, // 出发地
                                        destination: destination, // 目的地
                                        amount: item.totalAmount,  // 含税金额合计
                                        taxAmount: item.taxAmount,  // 税额合计
                                        amountExcludingTax: amountExcludingTax, // 不含税金额合计
                                        invoiceNos: item.serialNo, // 发票流水号
                                        invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                        taxRate: taxRate, // 税率
                                        afterChangeAmount: item.totalAmount // 会计调整后金额
                                    });
                                });

                                layTable.reload('longDistanceTable', {
                                    data: dataArr
                                });

                                getTripDetailTotal();
                            }
                        });
                        break;
                }
            });
            // 长途交通费-行操作
            layTable.on('tool(longDistanceTable)', function (obj) {
                var data = obj.data;
                var data2 = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.costId) {
                        $.get('/plbDeptReimburse/deletePlbLongdistanceCostByCostId', {costId: data.costId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                layTable.reload('longDistanceTable', {
                                    data: getPlbLongdistanceCosts().dataArr
                                });
                                // 重新汇总
                                getTripDetailTotal();
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        layTable.reload('longDistanceTable', {
                            data: getPlbLongdistanceCosts().dataArr
                        });
                        // 重新汇总
                        getTripDetailTotal();
                    }
                } else if (layEvent === 'chooseVehicle') {
                    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择乘坐工具',
                        area: ['40%', '70%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="container">',
                            '<table id="vehicleTable" lay-filter="vehicleTable"></table>',
                            '</div>'].join(''),
                        success: function () {
                            var data = []

                            $.each(dictionaryObj['RIDE_STANDARD']['object'], function (k, o) {
                                var obj = {
                                    type: k,
                                    value: o
                                }
                                data.push(obj);
                            });

                            // 获取科目
                            layTable.render({
                                elem: '#vehicleTable',
                                data: data,
                                page: false,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'value', title: '类型'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('vehicleTable');
                            if (checkStatus.data.length > 0) {
                                var ridestandard = checkFloatNum($('#03').val());
                                var vehicleData = checkStatus.data[0];
                                var type = checkFloatNum(vehicleData.type)
                                if (type < ridestandard) {
                                    layer.confirm('您选择的交通工具超出当前岗级标准，是否选择超标？', function (index) {
                                        $tr.find('input[name="vehicle"]').val(vehicleData.value);
                                        $tr.find('input[name="vehicle"]').attr('vehicle', vehicleData.type);
                                        // layForm.val('baseForm', {
                                        // 	"overStandard": 1
                                        // });
                                        // $('input[name="overStandardReason"]', $('#baseForm')).parents('.layui-form-item').show();
                                        layer.close(index);
                                    })
                                } else {
                                    $tr.find('input[name="vehicle"]').val(vehicleData.value);
                                    $tr.find('input[name="vehicle"]').attr('vehicle', vehicleData.type);

                                    // var vehicleFlag = false;
                                    // $('#longDistanceTableModule input[name="vehicle"]').each(function() {
                                    // 	var vehicle = checkFloatNum($(this).attr('vehicle') || '');
                                    // 	if (vehicle != 0 && vehicle < ridestandard) {
                                    // 		vehicleFlag = true;
                                    // 		return false;
                                    // 	}
                                    // });
                                    // if (!vehicleFlag) {
                                    // 	layForm.val('baseForm', {
                                    // 		"overStandard": 0
                                    // 	});
                                    // 	$('input[name="overStandardReason"]', $('#baseForm')).parents('.layui-form-item').hide();
                                    // }
                                }
                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                }else if(layEvent =='chooseRideStandard'){
                    // layer.open({
                    //     type: 1,
                    //     title: '选择乘坐标准',
                    //     area: ['40%', '70%'],
                    //     maxmin: true,
                    //     btn: ['确定', '取消'],
                    //     btnAlign: 'c',
                    //     content: ['<div class="container">',
                    //         '<table id="vehicleTable" lay-filter="vehicleTable"></table>',
                    //         '</div>'].join(''),
                    //     success: function () {
                    //         var data = []
                    //
                    //         $.each(dictionaryObj['RIDE_STANDARD']['object'], function (k, o) {
                    //             var obj = {
                    //                 type: k,
                    //                 value: o
                    //             }
                    //             data.push(obj);
                    //         });
                    //
                    //         // 获取科目
                    //         layTable.render({
                    //             elem: '#vehicleTable',
                    //             data: data,
                    //             page: false,
                    //             cols: [[
                    //                 {type: 'radio', title: '选择'},
                    //                 {field: 'value', title: '类型'}
                    //             ]]
                    //         });
                    //     },
                    //     yes: function (index) {
                    //         var checkStatus = layTable.checkStatus('vehicleTable');
                    //         if (checkStatus.data.length > 0) {
                    //             var ridestandard = checkFloatNum($('#03').val());
                    //             var vehicleData = checkStatus.data[0];
                    //             var type = checkFloatNum(vehicleData.type)
                    //             $tr.find('input[name="rideStandard"]').val(vehicleData.value);
                    //             $tr.find('input[name="rideStandard"]').attr('ridestandard', vehicleData.type);
                    //             layer.close(index);
                    //         } else {
                    //             layer.msg('请选择一项！', {icon: 0});
                    //         }
                    //     }
                    // });
                }else if(layEvent === 'addReceipts'){
                    var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                    openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data) {
                        var dataArr = getPlbLongdistanceCosts().dataArr;
                        var invoices = '';
                        var serialNo = '';
                        if (data.length > 0) {
                            data.forEach(function (item) {
                                dataArr.push({
                                    invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                });
                                invoices += '<span class="invoice_file ' + item.invoiceNo + '" fid="' + item.serialNo + '">' + (item.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                                serialNo += item.serialNo + ',';
                            });
                            $tr.find('.invoices_box').html('');
                            $tr.find('.invoices_box').append(invoices);
                            // 保存修改后发票数据
                            $.ajax({
                                url: '/plbDeptReimburse/updateInvoiceData',
                                data: {
                                    invoiceNos: serialNo,
                                    tableType: 2,
                                    tableId: data2.costId,
                                },
                                dataType: 'json',
                                type: 'get',
                                success: function (res) {

                                }
                            });
                        }
                    });
                }
            });

            // 市内交通费-加行
            layTable.on('toolbar(cityCostTable)', function (obj) {
                switch (obj.event) {
                    case 'add':

                        var $tr = $('#cityCostTableModule').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                taxAmount: $(this).find('input[name="taxAmount"]').val(),
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        var addRowData = {};
                        oldDataArr.push(addRowData);
                        layTable.reload('cityCostTable', {
                            data: oldDataArr
                        });

                        break
                    case 'addInovice':
                        var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                        openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data) {
                            var dataArr = getPlbCityCosts().dataArr;

                            if (data.length > 0) {
                                data.forEach(function (item) {
                                    var amountExcludingTax = BigNumber(item.totalAmount).minus(item.taxAmount);
                                    var taxRate = 0;
                                    if (item.items && item.items.length > 0) {
                                        taxRate = item.items[0].taxRate;
                                    } else {
                                        taxRate = item.taxRate || 0;
                                    }
                                    dataArr.push({
                                        amount: item.totalAmount,  // 含税金额合计
                                        taxAmount: item.taxAmount,  // 税额合计
                                        amountExcludingTax: amountExcludingTax, // 不含税金额合计
                                        invoiceNos: item.serialNo, // 发票流水号
                                        invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                        taxRate: taxRate, // 税率
                                        afterChangeAmount: item.totalAmount // 会计调整后金额
                                    });
                                });

                                layTable.reload('cityCostTable', {
                                    data: dataArr
                                });

                                getTripDetailTotal();
                            }
                        });
                        break;
                }
            });
            // 市内交通费-行操作
            layTable.on('tool(cityCostTable)', function (obj) {
                var data = obj.data;
                var data2 = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.cityCostId) {
                        $.get('/plbDeptReimburse/deletePlbCityCostByCityCostId', {cityCostId: data.cityCostId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                layTable.reload('cityCostTable', {
                                    data: getPlbCityCosts().dataArr
                                });
                                // 重新汇总
                                getTripDetailTotal();
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        layTable.reload('cityCostTable', {
                            data: getPlbCityCosts().dataArr
                        });
                        // 重新汇总
                        getTripDetailTotal();
                    }
                } else if (layEvent === 'chooseCityCostType') {
                    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择市内交通费类型',
                        area: ['40%', '70%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="container">',
                            '<table id="cityCostTypeTable" lay-filter="cityCostTypeTable"></table>',
                            '</div>'].join(''),
                        success: function () {
                            var data = []

                            $.each(dictionaryObj['CITY_COST_TYPE']['object'], function (k, o) {
                                var obj = {
                                    type: k,
                                    value: o
                                }
                                data.push(obj);
                            });

                            // 获取科目
                            layTable.render({
                                elem: '#cityCostTypeTable',
                                data: data,
                                page: false,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'value', title: '类型'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('cityCostTypeTable');
                            if (checkStatus.data.length > 0) {
                                var cityCostTypeData = checkStatus.data[0];

                                $tr.find('input[name="cityCostType"]').val(cityCostTypeData.value);
                                $tr.find('input[name="cityCostType"]').attr('cityCostType', cityCostTypeData.type);

                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                } else if (layEvent === 'chooseInvoiceType') {
                    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择票据类型',
                        area: ['40%', '70%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="container">',
                            '<table id="invoiceTypeTable" lay-filter="invoiceTypeTable"></table>',
                            '</div>'].join(''),
                        success: function () {
                            var data = []

                            $.each(dictionaryObj['BILL_TYPE']['object'], function (k, o) {
                                var obj = {
                                    type: k,
                                    value: o
                                }
                                data.push(obj);
                            });

                            // 获取科目
                            layTable.render({
                                elem: '#invoiceTypeTable',
                                data: data,
                                page: false,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'value', title: '类型'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('invoiceTypeTable');
                            if (checkStatus.data.length > 0) {
                                var invoiceTypeData = checkStatus.data[0];
                                $tr.find('input[name="invoiceType"]').val(invoiceTypeData.value);
                                $tr.find('input[name="invoiceType"]').attr('invoiceType', invoiceTypeData.type);
                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                }else if(layEvent === 'addReceipts'){
                    var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                    openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data) {
                        var dataArr = getPlbCityCosts().dataArr;
                        var invoices = '';
                        var serialNo = '';
                        if (data.length > 0) {
                            data.forEach(function (item) {
                                dataArr.push({
                                    invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                });
                                invoices += '<span class="invoice_file ' + item.invoiceNo + '" fid="' + item.serialNo + '">' + (item.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                                serialNo += item.serialNo + ',';
                            });
                            $tr.find('.invoices_box').html('');
                            $tr.find('.invoices_box').append(invoices);
                            // 保存修改后发票数据
                            $.ajax({
                                url: '/plbDeptReimburse/updateInvoiceData',
                                data: {
                                    invoiceNos: serialNo,
                                    tableType: 3,
                                    tableId: data2.cityCostId,
                                },
                                dataType: 'json',
                                type: 'get',
                                success: function (res) {

                                }
                            });
                        }
                    });
                }
            });

            // 住宿费-加行
            layTable.on('toolbar(stayCostTable)', function (obj) {
                switch (obj.event) {
                    case 'add':

                        var $tr = $('#stayCostTableModule').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                stayStandard: $(this).find('input[name="stayStandard"]').val(),
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        var addRowData = {};
                        oldDataArr.push(addRowData);
                        layTable.reload('stayCostTable', {
                            data: oldDataArr
                        });

                        break
                    case 'addInovice':
                        var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                        openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data, fIds) {
                            var dataArr = getPlbStayCosts().dataArr;
                            var stayStandardStr = $('#04').val(); // 住宿标准
                            if (data.length > 0) {
                                data.forEach(function (item) {
                                    var amountExcludingTax = BigNumber(item.totalAmount).minus(item.taxAmount);
                                    var invoiceType = ''; // 发票类型
                                    if (item.invoiceType == '1' || item.invoiceType == '3') { // 普票
                                        invoiceType = '01';
                                    } else if (item.invoiceType == '2' || item.invoiceType == '4') { // 专票
                                        invoiceType = '01';
                                    } else if (item.invoiceType == '5') { // 普通纸质卷票
                                        invoiceType = '03';
                                    } else { // 其他
                                        invoiceType = '04';
                                    }
                                    var taxRate = 0;
                                    if (item.items && item.items.length > 0) {
                                        taxRate = item.items[0].taxRate;
                                    } else {
                                        taxRate = item.taxRate || 0;
                                    }
                                    dataArr.push({
                                        stayStandard: stayStandardStr,
                                        invoiceType: invoiceType,
                                        amountIncludingTax: item.totalAmount,  // 含税金额合计
                                        taxAmount: item.taxAmount,  // 税额合计
                                        amountExcludingTax: amountExcludingTax, // 不含税金额合计
                                        invoiceNos: item.serialNo, // 发票流水号
                                        invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                        taxRate: taxRate, // 税率
                                        afterChangeAmount: item.totalAmount // 会计调整后金额
                                    });
                                });

                                layTable.reload('stayCostTable', {
                                    data: dataArr
                                });

                                getTripDetailTotal();
                            }
                        });
                        break;
                }
            });
            // 住宿费-行操作
            layTable.on('tool(stayCostTable)', function (obj) {
                var data = obj.data;
                var data2 = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.stayCostId) {
                        $.get('/plbDeptReimburse/deletePlbStayCostByStayCostId', {stayCostId: data.stayCostId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                layTable.reload('stayCostTable', {
                                    data: getPlbStayCosts().dataArr
                                });
                                // 重新汇总
                                getTripDetailTotal();
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        layTable.reload('stayCostTable', {
                            data: getPlbStayCosts().dataArr
                        });
                        // 重新汇总
                        getTripDetailTotal();
                    }
                } else if (layEvent === 'chooseInvoiceType') {
                    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择发票类型',
                        area: ['40%', '70%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="container">',
                            '<table id="invoiceTypeTable" lay-filter="invoiceTypeTable"></table>',
                            '</div>'].join(''),
                        success: function () {
                            var data = []

                            $.each(dictionaryObj['INVOICE_TYPE']['object'], function (k, o) {
                                var obj = {
                                    type: k,
                                    value: o
                                }
                                data.push(obj);
                            });

                            // 获取科目
                            layTable.render({
                                elem: '#invoiceTypeTable',
                                data: data,
                                page: false,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'value', title: '类型'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('invoiceTypeTable');
                            if (checkStatus.data.length > 0) {
                                var invoiceTypeData = checkStatus.data[0];
                                $tr.find('input[name="invoiceType"]').val(invoiceTypeData.value);
                                $tr.find('input[name="invoiceType"]').attr('invoiceType', invoiceTypeData.type);
                                if (invoiceTypeData.type == '01') { // 专用发票
                                    $tr.find('input[name="taxAmount"]').attr('readonly', false);
                                } else {
                                    $tr.find('input[name="taxAmount"]').attr('readonly', true).val(0);
                                    var afterChangeAmount = $tr.find('input[name="afterChangeAmount"]').val(); // 会计调整后金额
                                    $tr.find('.amountExcludingTax').text(afterChangeAmount);
                                    // 重新汇总
                                    getTripDetailTotal();
                                }
                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                }else if(layEvent === 'addReceipts'){
                    var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                    openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data, fIds) {
                        var dataArr = getPlbStayCosts().dataArr;
                        var invoices = '';
                        var serialNo = '';
                        if (data.length > 0) {
                            data.forEach(function (item) {
                                dataArr.push({
                                    invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                });
                                invoices += '<span class="invoice_file ' + item.invoiceNo + '" fid="' + item.serialNo + '">' + (item.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                                serialNo += item.serialNo + ',';
                            });
                            $tr.find('.invoices_box').html('');
                            $tr.find('.invoices_box').append(invoices);
                            // 保存修改后发票数据
                            $.ajax({
                                url: '/plbDeptReimburse/updateInvoiceData',
                                data: {
                                    invoiceNos: serialNo,
                                    tableType: 4,
                                    tableId: data2.stayCostId,
                                },
                                dataType: 'json',
                                type: 'get',
                                success: function (res) {

                                }
                            });
                        }
                    });
                }
            });

            // 其他费用-加行
            layTable.on('toolbar(otherCostTable)', function (obj) {
                switch (obj.event) {
                    case 'add':

                        var $tr = $('#otherCostTableModule').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                amountIncludingTax: $(this).find('input[name="amountIncludingTax"]').val(),
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        var addRowData = {};
                        oldDataArr.push(addRowData);
                        layTable.reload('otherCostTable', {
                            data: oldDataArr
                        });

                        break
                    case 'addInovice':
                        var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                        openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data, fIds) {
                            // 遍历表格获取每行数据进行保存
                            var dataArr = getPlbOtherCosts().dataArr;
                            if (data.length > 0) {
                                data.forEach(function (item) {
                                    var taxRate = 0;
                                    if (item.items && item.items.length > 0) {
                                        taxRate = item.items[0].taxRate;
                                    } else {
                                        taxRate = item.taxRate || 0;
                                    }
                                    var amountExcludingTax = BigNumber(item.totalAmount).minus(item.taxAmount);
                                    var invoiceType = '';
                                    if (item.invoiceType == '1' || item.invoiceType == '3') { // 普票
                                        invoiceType = '01';
                                    } else if (item.invoiceType == '2' || item.invoiceType == '4') { // 专票
                                        invoiceType = '01';
                                    } else if (item.invoiceType == '5') { // 普通纸质卷票
                                        invoiceType = '03';
                                    } else { // 其他
                                        invoiceType = '04';
                                    }
                                    dataArr.push({
                                        invoiceType: invoiceType, // 发票类型
                                        amountIncludingTax: item.totalAmount,  // 含税金额合计
                                        taxAmount: item.taxAmount,  // 税额合计
                                        amountExcludingTax: amountExcludingTax, // 不含税金额合计
                                        invoiceNos: item.serialNo, // 发票流水号
                                        invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                        taxRate: taxRate, // 税率
                                        afterChangeAmount: item.totalAmount // 会计调整后金额
                                    });
                                });

                                layTable.reload('otherCostTable', {
                                    data: dataArr
                                });

                                getTripDetailTotal();
                            }
                        });
                        break;
                }
            });
            // 其他费用-行操作
            layTable.on('tool(otherCostTable)', function (obj) {
                var data = obj.data;
                var data2 = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.otherCostId) {
                        $.get('/plbDeptReimburse/deleteOtherCostByOtherCostId', {otherCostId: data.otherCostId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                layTable.reload('otherCostTable', {
                                    data: getPlbOtherCosts().dataArr
                                });
                                // 重新汇总
                                getTripDetailTotal();
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        layTable.reload('otherCostTable', {
                            data: getPlbOtherCosts().dataArr
                        });
                        // 重新汇总
                        getTripDetailTotal();
                    }
                } else if (layEvent === 'chooseInvoiceType') {
                    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择票据类型',
                        area: ['40%', '70%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="container">',
                            '<table id="invoiceTypeTable" lay-filter="invoiceTypeTable"></table>',
                            '</div>'].join(''),
                        success: function () {
                            var data = []

                            $.each(dictionaryObj['INVOICE_TYPE']['object'], function (k, o) {
                                var obj = {
                                    type: k,
                                    value: o
                                }
                                data.push(obj);
                            });

                            // 获取科目
                            layTable.render({
                                elem: '#invoiceTypeTable',
                                data: data,
                                page: false,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'value', title: '类型'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('invoiceTypeTable');
                            if (checkStatus.data.length > 0) {
                                var invoiceTypeData = checkStatus.data[0];
                                $tr.find('input[name="invoiceType"]').val(invoiceTypeData.value);
                                $tr.find('input[name="invoiceType"]').attr('invoiceType', invoiceTypeData.type);
                                if (invoiceTypeData.type == '01') { // 专用发票
                                    $tr.find('input[name="taxAmount"]').attr('readonly', false);
                                } else {
                                    $tr.find('input[name="taxAmount"]').attr('readonly', true).val(0);
                                    var afterChangeAmount = $tr.find('input[name="afterChangeAmount"]').val(); // 会计调整后金额
                                    $tr.find('.amountExcludingTax').text(afterChangeAmount);
                                    // 重新汇总
                                    getTripDetailTotal();
                                }
                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                }else if(layEvent === 'addReceipts'){
                    var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
                    openPwyWeb(reimburseId, reimburseNo, reimburseType, null, function (data, fIds) {
                        // 遍历表格获取每行数据进行保存
                        var dataArr = getPlbOtherCosts().dataArr;
                        var invoices = '';
                        var serialNo = '';
                        if (data.length > 0) {
                            data.forEach(function (item) {
                                dataArr.push({
                                    invoiceNoStr: item.invoiceNo || '发票', // 发票号码
                                });
                                invoices += '<span class="invoice_file ' + item.invoiceNo + '" fid="' + item.serialNo + '">' + (item.invoiceNo || ('发票' + (index + 1))) + ',</span>';
                                serialNo += item.serialNo + ',';
                            });
                            $tr.find('.invoices_box').html('');
                            $tr.find('.invoices_box').append(invoices);
                            // 保存修改后发票数据
                            $.ajax({
                                url: '/plbDeptReimburse/updateInvoiceData',
                                data: {
                                    invoiceNos: serialNo,
                                    tableType: 5,
                                    tableId: data2.otherCostId,
                                },
                                dataType: 'json',
                                type: 'get',
                                success: function (res) {

                                }
                            });
                        }
                        // getTripDetailTotal();
                    });
                }
            });

            // 补助费用-加行
            layTable.on('toolbar(subsidyTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        //遍历表格获取每行数据进行保存
                        var dataArr = getPlbSubsidyLists().dataArr;
                        dataArr.push({});
                        layTable.reload('subsidyTable', {
                            data: dataArr
                        });
                        break;
                }
            });
            // 补助费用-行操作
            layTable.on('tool(subsidyTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.listId) {
                        $.get('/plbDeptReimburse/deleteSubsidyListByListId', {listId: data.listId}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                layTable.reload('subsidyTable', {
                                    data: getPlbSubsidyLists().dataArr
                                });
                                // 重新汇总
                                getTripDetailTotal();
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        layTable.reload('subsidyTable', {
                            data: getPlbSubsidyLists().dataArr
                        });
                        // 重新汇总
                        getTripDetailTotal();
                    }
                } else if (layEvent === 'chooseSubsidyType') {
                    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择补助类型',
                        area: ['40%', '70%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="container">',
                            '<table id="subsidyTypeTable" lay-filter="subsidyTypeTable"></table>',
                            '</div>'].join(''),
                        success: function () {
                            var data = []

                            $.each(dictionaryObj['SUBSIDY_TYPE']['object'], function (k, o) {
                                var obj = {
                                    type: k,
                                    value: o
                                }
                                data.push(obj);
                            });

                            // 获取科目
                            layTable.render({
                                elem: '#subsidyTypeTable',
                                data: data,
                                page: false,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'value', title: '类型'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('subsidyTypeTable');
                            if (checkStatus.data.length > 0) {
                                var subsidyTypeData = checkStatus.data[0];

                                $tr.find('input[name="subsidyType"]').val(subsidyTypeData.value);
                                $tr.find('input[name="subsidyType"]').attr('subsidyType', subsidyTypeData.type);
                                var subsidyStandard = dictionaryObj['SUBSIDY_TYPE']['remarks'][subsidyTypeData.type] || '';
                                $tr.find('.subsidyStandard').text(subsidyStandard);

                                // 计算补助金额
                                recountSubsidy($tr);
                                // 重新汇总
                                getTripDetailTotal();
                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                }
            });

            // 初始化开始时间
            var startLaydateConfig = {
                elem: '#startDate',
                done: function (value, date) {
                    if (endLaydate.config.min) {
                        // 修改开始时间最大选择日期
                        endLaydate.config.min = {
                            year: date.year || 1900,
                            month: date.month - 1 || 0,
                            date: date.date || 1,
                        }
                    } else {
                        endLaydateConfig.min = value;
                    }

                    $.each(layDateObj, function (k, o) {
                        o.forEach(function (item) {
                            if (item.config.min) {
                                item.config.min = {
                                    year: date.year || 2099,
                                    month: date.month - 1 || 11,
                                    date: date.date || 31,
                                }
                            } else {
                                item.config.min = value;
                            }
                            var $elem = $(item.config.elem[0]);
                            var dateStr = $elem.val();
                            dateStr = dateStr.replace(/\s/g, '');
                            if (dateStr) {
                                var time = new Date(value).getTime();

                                if (k == 'stayCostTable' || k == 'subsidyTable') {
                                    var startDateStr = dateStr.split('|')[0];
                                    var endDateStr = dateStr.split('|')[1];
                                    var startDateTime = new Date(startDateStr).getTime();
                                    if (time > startDateTime) {
                                        $elem.val(value + ' | ' + endDateStr);
                                    }
                                } else {
                                    var startDateTime = new Date(dateStr).getTime();
                                    if (time > startDateTime) {
                                        $elem.val(value);
                                    }
                                }
                            }
                        });
                    });
                },
                trigger: 'click'
            }
            if (reimburseInfo && reimburseInfo.endDate) {
                startLaydateConfig.max = reimburseInfo.endDate;
            }
            var startLaydate = laydate.render(startLaydateConfig);

            // 初始化结束时间
            var endLaydateConfig = {
                elem: '#endDate',
                done: function (value, date) {
                    if (startLaydate.config.max) {
                        // 修改开始时间最大选择日期
                        startLaydate.config.max = {
                            year: date.year || 2099,
                            month: date.month - 1 || 11,
                            date: date.date || 31,
                        }
                    } else {
                        startLaydateConfig.max = value;
                    }

                    $.each(layDateObj, function (k, o) {
                        o.forEach(function (item) {
                            if (item.config.max) {
                                item.config.max = {
                                    year: date.year || 2099,
                                    month: date.month - 1 || 11,
                                    date: date.date || 31,
                                }
                            } else {
                                item.config.max = value;
                            }
                            var $elem = $(item.config.elem[0]);
                            var dateStr = $elem.val();
                            dateStr = dateStr.replace(/\s/g, '');
                            if (dateStr) {
                                var time = new Date(value).getTime();

                                if (k == 'stayCostTable' || k == 'subsidyTable') {
                                    var startDateStr = dateStr.split('|')[0];
                                    var endDateStr = dateStr.split('|')[1];
                                    var endDateTime = new Date(endDateStr).getTime();
                                    if (time < endDateTime) {
                                        $elem.val(startDateStr + ' | ' + value);
                                    }
                                } else {
                                    var endDateTime = new Date(dateStr).getTime();
                                    if (time < endDateTime) {
                                        $elem.val(value);
                                    }
                                }
                            }
                        });
                    });
                },
                trigger: 'click'
            }
            if (reimburseInfo && reimburseInfo.startDate) {
                endLaydateConfig.min = reimburseInfo.startDate;
            }
            var endLaydate = laydate.render(endLaydateConfig);
        }

        $.ajax({
            url:'/plbDictonary/selectDictionaryByNo',
            data:{plbDictNo:'TRAVEL_TYPE',plbDictNo1:reimburseType},
            async:false,
            success:function(res){
                var travelTypStr = '';
                res.data.forEach(function (item) {
                    travelTypStr += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                })
                if(reimburseType == '05'){
                    $('[name="naturePayment"]', $('#baseForm')).html(travelTypStr);
                }else{
                    $('[name="travelType"]', $('#baseForm')).html(travelTypStr);
                }

                layForm.render();
                if (type == 2 || type == 3) {
                    layForm.val('baseForm', {
                        "travelType": reimburseInfo.travelType || ''
                    });
                }
            }
        });
        $.ajax({
            url:'/plbDictonary/selectDictionaryByNo',
            data:{plbDictNo:'TRAVEL_TYPE',plbDictNo1:'07'},
            async:false,
            success:function(res){
                var launchTypStr = '<option value="">请选择</option>';
                res.data.forEach(function (item) {
                    launchTypStr += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                })
                $('[name="launchType"]', $('#baseForm')).html(launchTypStr);

                layForm.render();
                if (type == 2 || type == 3) {
                    layForm.val('baseForm', {
                        "launchType": reimburseInfo.launchType || ''
                    });
                }
            }
        });

        if (!(type == 3 && disabled == '1') || reimburseStatus == '4') {
            // 附件上传
            fileuploadFn('#fileupload', $('#fileContent'));

            if (reimburseStatus != '4') {
                // 选择报销人
                $('#reimburseUser').on('click', function () {
                    layer.open({
                        type: 1,
                        title: '选择报销人',
                        area: ['60%', '70%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div><table id="reimburseUserTable" lay-filter="reimburseUserTable"></table></div>',
                        success: function () {
                            layTable.render({
                                elem: '#reimburseUserTable',
                                url: '/PlbUserAuthorized/getAuthorizedUser',
                                page: {
                                    limit: 10,
                                    limits: [10, 20, 30, 40, 50]
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
                                    {type: 'radio'},
                                    {field: 'userName', title: '报销人', sort: true},
                                    {field: 'deptName', title: '所属部门', sort: true},
                                    {
                                        field: 'beginTime',
                                        title: '开始时间',
                                        sort: true,
                                        templet: function (d) {
                                            return format(d.beginTime);
                                        }
                                    },
                                    {
                                        field: 'endTime',
                                        title: '结束时间',
                                        sort: true,
                                        templet: function (d) {
                                            return format(d.endTime);
                                        }
                                    },
                                    {field: '', ttile: '备注'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = layTable.checkStatus('reimburseUserTable');
                            if (checkStatus.data.length > 0) {
                                var userData = checkStatus.data[0];

                                $('#reimburseUser').attr('user_id', userData.userId);
                                $('#reimburseUser').val(userData.userName);

                                // 获取用户所有所属部门
                                $.get('/plbDeptReimburse/getOwnDept', {userId: userData.userId}, function (res) {
                                    var str = '';
                                    if (res.flag) {
                                        $.each(res.data.depts, function (k, o) {
                                            str += '<option value="' + k + '">' + o + '</option>';
                                        });
                                    }
                                    $('[name="reimburseBelongDept"]', $('#baseForm')).html(str);
                                    layForm.render('select');
                                });

                                if (reimburseType == '01' || reimburseType == '02') {
                                    $.get('/plbDeptBudgetLimit/queryByUserLevel', {
                                        costTypes: '03,04', // 03-乘车标准，04-住宿标准
                                        userId: userData.userId,
                                    }, function (res) {
                                        if (res.flag) {
                                            if (res.data.length > 0) {
                                                var rideStandard = '';
                                                var rideStandardName = '';
                                                var data = res.data;
                                                for (var i = 0; i < data.length; i++) {
                                                    if (data[i].costType === '03') { // 乘车标准
                                                        var oldType = checkFloatNum(rideStandard);
                                                        var newType = checkFloatNum(data[i].rideStandard)
                                                        if (rideStandard && oldType < newType) {
                                                            continue;
                                                        }
                                                        rideStandard = data[i].rideStandard;
                                                        rideStandardName = dictionaryObj['RIDE_STANDARD']['object'][data[i].rideStandard];
                                                    } else if (data[i].costType === '04') { // 住宿标准
                                                        $('#04').val(data[i].limitMoney);
                                                        $('.stayStandard', $('#stayCostTableModule')).text(data[i].limitMoney);
                                                    }
                                                }
                                                $('#03').val(rideStandard).attr('rideStandard', rideStandardName);
                                                $('.rideStandard', $('#longDistanceTableModule')).attr('rideStandard', rideStandard).val(rideStandardName.replace(/\/$/, ''));
                                            }
                                        } else {
                                            layer.msg(res.msg, {icon: 2});
                                        }
                                    });
                                }

                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                });
            }
        }

        // 报销单明细数据
        var reimbursementDetailsData = [];
        //预算核销明细
        var reimbursementWriteData=[];
        // 长途交通费明细数据
        var plbLongdistanceCosts = [];
        // 市内交通费明细数据
        var plbCityCosts = [];
        // 住宿费明细数据
        var plbStayCosts = [];
        // 其他费用明细数据
        var plbOtherCosts = [];
        // 补助费用明细数据
        var plbSubsidyLists = [];
        // 付款单明细数据
        var paymentmentDetailsData = [];

        if (type == 1) { // 新增

            var year=new Date().getFullYear();
            // 限额报销单新增接口不同
            url = reimburseType == '04' ? '/plbDeptReimburse/quotaReimburseAdd?year='+year : '/plbDeptReimburse/add?year='+year;

            var dateNow = format(new Date().getTime());
            $('input[name="reimburseDate"]', $('#baseForm')).val(dateNow);

            // 获取自动编号
            getAutoNumber({
                autoNumber: 'plbDeptReimburse',
                reimburseType: reimburseType
            }, function (res) {
                $('input[name="reimburseNo"]', $('#baseForm')).val(res);
            });
            $('.refresh_no_btn').show().on('click', function () {
                getAutoNumber({
                    autoNumber: 'plbDeptReimburse',
                    reimburseType: reimburseType
                }, function (res) {
                    $('input[name="reimburseNo"]', $('#baseForm')).val(res);
                });
            });

            // 获取当前登录人信息(经办人)
            getUserInfo('', function (res) {
                if (res.object) {
                    $('[name="createUser"]', $('#baseForm')).attr('user_id', res.object.userId).val(res.object.userName);
                    $('input[name="reimburseUser"]', $('#baseForm')).attr('user_id', res.object.userId).val(res.object.userName);
                    initKingDee(res.object.userId)
                    // 获取用户所有所属部门
                    $.get('/plbDeptReimburse/getOwnDept', {userId: res.object.userId}, function (res) {
                        var str = '';
                        if (res.flag) {
                            $.each(res.data.depts, function (k, o) {
                                str += '<option value="' + k + '">' + o + '</option>';
                            });
                        }
                        $('[name="reimburseBelongDept"]', $('#baseForm')).html(str);
                        layForm.render('select');
                    });


                    if (reimburseType == '01' || reimburseType == '02') {
                        // 显示补贴标准
                        $.get('/plbDeptBudgetLimit/queryByUserLevel', {
                            costTypes: '03,04', // 01-乘车标准，04-住宿标准
                            userId: res.object.userId,
                        }, function (res) {
                            if (res.flag) {
                                if (res.data.length > 0) {
                                    var rideStandard = '';
                                    var rideStandardName = '';
                                    var data = res.data;
                                    for (var i = 0; i < data.length; i++) {
                                        if (data[i].costType === '03') { // 乘车标准
                                            var oldType = checkFloatNum(rideStandard);
                                            var newType = checkFloatNum(data[i].rideStandard)
                                            if (rideStandard && oldType < newType) {
                                                continue;
                                            }
                                            rideStandard = data[i].rideStandard;
                                            rideStandardName = dictionaryObj['RIDE_STANDARD']['object'][data[i].rideStandard];
                                        } else if (data[i].costType === '04') { // 住宿标准
                                            $('#04').val(data[i].limitMoney);
                                        }
                                    }
                                    $('#03').val(rideStandard).attr('rideStandard', rideStandardName.replace(/\/$/, ''));
                                }
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        });
                    }
                }
            });
        } else if (type == 2 || type == 3) { // 编辑
            var year=new Date().getFullYear();
            url = '/plbDeptReimburse/updateDataByReimburseId?year='+year;

            reimburseInfo.startDate = format(reimburseInfo.startDate);
            reimburseInfo.endDate = format(reimburseInfo.endDate);
            initKingDee(reimburseInfo.reimburseUser);
            var reiUseId='';
            if(reimburseInfo.reimburseUser == ''){
                reiUseId=reimburseInfo.createUser
            }else{
                reiUseId=reimburseInfo.reimburseUser.replace(/,$/, '')
            }
            $.get('/plbDeptReimburse/getOwnDept', {userId:reiUseId}, function (res) {
                var str = '<option value="">选择部门</option>';
                if (res.flag) {
                    $.each(res.data.depts, function (k, o) {
                        str += '<option value="' + k + '">' + o + '</option>';
                    });
                }
                $('[name="reimburseBelongDept"]', $('#baseForm')).html(str).val(reimburseInfo.reimburseBelongDept);
                layForm.render('select');
            });
            layForm.val('baseForm', reimburseInfo);
            //工程项目回显数据
            if(reimburseInfo.plbProj!=''&&reimburseInfo.plbProj!=undefined){
                $('[name="enginProject"]').val(reimburseInfo.plbProj.projName);
                $('[name="enginProject"]').attr('projId',reimburseInfo.plbProj.projId);
            }
            //工程合同回显数据
            if(reimburseInfo.plbDeptSubcontract!=''&&reimburseInfo.plbDeptSubcontract!=undefined){
                $('[name="enginContract"]').val(reimburseInfo.plbDeptSubcontract.contractName);
                $('[name="enginContract"]').attr('subcontractId',reimburseInfo.plbDeptSubcontract.subcontractId);
            }
            //研发项目回显数据
            if(reimburseInfo.srmsPjProject!=''&&reimburseInfo.srmsPjProject!=undefined){
                $('[name="developProject"]').val(reimburseInfo.srmsPjProject.pjName);
                $('[name="developProject"]').attr('pjNumber',reimburseInfo.srmsPjProject.pjNumber);
            }
            //合同信息回显数据
            if(reimburseType=='05'){
                if(reimburseInfo.whetherContract=='1'){
                    layForm.val('baseForm',reimburseInfo.plbDeptContract[0]);
                    $('[name="contractNo"]').attr('contractId',reimburseInfo.plbDeptContract[0].contractId);
                    $('#paymentMoneyStr').val(number_chinese(reimburseInfo.plbDeptContract[0].paymentMoney))||'';
                    layForm.render();
                }else{
                    $('input[name="whetherContract"][value="0"]').prop("checked","checked");
                    layForm.val('baseForm',reimburseInfo.plbDeptContract[0]);
                    $('[name="contractNo"]').attr('contractId',reimburseInfo.plbDeptContract[0].contractId);
                    $('#paymentMoneyStr').val(number_chinese(reimburseInfo.plbDeptContract[0].paymentMoney))||'';
                    $('[name="contractMoney"]').parent().parent().find('span').removeClass('field_required');
                    $('[name="contractMoney"]').attr('disabled','disabled').val('').css('background','#e7e7e7');
                    $('[name="contractName"]').parent().parent().find('span').removeClass('field_required');
                    $('[name="contractName"]').attr('disabled','disabled').val('').css('background','#e7e7e7');
                    $('[name="contractNo"]').parent().parent().find('span').removeClass('field_required');
                    $('[name="contractNo"]').attr('disabled','disabled').val('').css('background','#e7e7e7');
                    layForm.render();
                }
            }
            if(reimburseType=='05'&&type==3&&disabled==1){
                $('[name="naturePayment"]').attr('disabled',true);
                layForm.render();
            }

            // 是否原币
            if (reimburseInfo.multiCurrency == 1) {
                $('[name="reimburseTotalOriginal"]', $('#baseForm')).parents('.layui-form-item').show();
            }
            // 是否超标
            if (reimburseInfo.overStandard == 1) {
                $('[name="overStandardReason"]', $('#baseForm')).parents('.layui-form-item').show();
            }
            //是否冲账
            if(reimburseInfo.whetherChargeMoney == 1){
                $('[name="whetherChargeMoney"]').attr('disabled','disabled');
                $('#reimbursementWriteModule').show();
                layForm.render();
            }

            // if (reimburseType != '04') {
            //
            // } else {
            //     $('[name="reimburseBelongDept"]', $('#baseForm')).attr('deptid', reimburseInfo.reimburseBelongDept || '').val(reimburseInfo.reimburseBelongDeptName || '');
            // }

            if (reimburseType == '01' || reimburseType == '02') {
                // 显示补贴标准
                $.get('/plbDeptBudgetLimit/queryByUserLevel', {
                    costTypes: '03,04', // 03-乘车标准，04-住宿标准
                    userId: reimburseInfo.reimburseUser.replace(/,$/, ''),
                }, function (res) {
                    if (res.flag) {
                        if (res.data.length > 0) {
                            var rideStandard = '';
                            var rideStandardName = '';
                            var data = res.data;
                            for (var i = 0; i < data.length; i++) {
                                if (data[i].costType === '03') { // 乘车标准
                                    var oldType = checkFloatNum(rideStandard);
                                    var newType = checkFloatNum(data[i].rideStandard)
                                    if (rideStandard && oldType < newType) {
                                        continue;
                                    }
                                    rideStandard = data[i].rideStandard;
                                    rideStandardName = dictionaryObj['RIDE_STANDARD']['object'][data[i].rideStandard];
                                } else if (data[i].costType === '04') { // 住宿标准
                                    $('#04').val(data[i].limitMoney);
                                }
                            }
                            $('#03').val(rideStandard).attr('rideStandard', rideStandardName.replace(/\/$/, ''));
                        }
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                });
            }

            // 报销日期
            $('input[name="reimburseDate"]', $('#baseForm')).val(format(reimburseInfo.reimburseDate));
            // 经办人
            $('input[name="createUser"]', $('#baseForm')).attr('user_id', reimburseInfo.createUser).val((reimburseInfo.createUserName || '').replace(/,$/, ''));
            // 报销人
            $('input[name="reimburseUser"]', $('#baseForm')).attr('user_id', reimburseInfo.reimburseUser).val((reimburseInfo.reimburseUserName || '').replace(/,$/, ''));
            // 附件
            $('#fileContent').html(getFileEleStr(reimburseInfo.attachments, !(type == 3 && disabled == '1') || reimburseStatus == '4'));
            // 发票
            // $('#fileContentFP').html(getFileEleStr(reimburseInfo.invoices, !(type == 3 && disabled == '1')))

            // 报销明细
            reimbursementDetailsData = reimburseInfo.plbDeptReimburseLists || [];
            //预算核销
            reimbursementWriteData=reimburseInfo.chargemoneyList || [];
            // 长途交通费明细数据
            plbLongdistanceCosts = reimburseInfo.plbLongdistanceCosts || [];
            // 市内交通费明细数据
            plbCityCosts = reimburseInfo.plbCityCosts || [];
            // 住宿费明细数据
            plbStayCosts = reimburseInfo.plbStayCosts || [];
            // 其他费用明细数据
            plbOtherCosts = reimburseInfo.plbOtherCosts || [];
            // 补助费用明细数据
            plbSubsidyLists = reimburseInfo.plbSubsidyLists || [];
            // 付款明细
            paymentmentDetailsData = reimburseInfo.plbDeptPayments || [];
        }

        var reimbursementDetailsTableCols = [
            {type: isPreview == '1' ? 'numbers' : 'checkbox', title: '序号'},
            {
                field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                    if (isPreview == '1') {
                        return isShowNull(d.deptName)
                    }
                    return '<input readonly name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input choose_dept" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.deptName) + '">';
                }
            },
            {
                field: 'deptItemId',
                title: '预算科目',
                event: 'chooseItem',
                minWidth: 200,
                templet: function (d) {
                    var str = isShowNull(d.rbsItemName) || isShowNull(d.itemName);
                    if (isPreview == '1') {
                        return str
                    }
                    return '<input name="deptItemId" listId="' + isShowNull(d.listId) + '" cbsId="' + isShowNull(d.cbsId) + '" rbsItemId="' + isShowNull(d.rbsItemId) + '" type="text" readonly class="layui-input deptItemId" style="height: 100%; cursor: pointer;" value="' + str + '">';
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
            {
                field: 'budgetMoney',
                title: '年度预算总额',
                minWidth: 150,
                templet: function (d) {
                    return '<span class="budgetMoney">' + (d.budgetMoney||'0') + '</span>';
                }
            },
            {
                field: 'budgetBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
                    return '<span class="budgetBalance">' + (d.budgetBalance||'0') + '</span>';
                }
            },
            {
                field: 'applicationAmount',
                title: '本次执行金额',
                event:'applicationAmount',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return (d.applicationAmount||'0')
                    }
                    var whetherChargeMoney=$('[name="whetherChargeMoney"]:checked').val()
                    if(whetherChargeMoney=='1'){
                        return '<input  name="applicationAmount" class="layui-input applicationAmount" style="height: 100%" value="'+(d.applicationAmount||'0')+'" floatType="RD_applicationAmountThis" handleCallback="afterFloatChange" autocomplete="off">';
                    }else{
                        return '<span class="applicationAmount">' + (d.applicationAmount||'0') + '</span>';
                    }
                }
            },
            {
                field: 'reimbursementAmount',
                title: '报销金额',
                event:'reimbursementAmount',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return (d.reimbursementAmount||'0')
                    }
                    return '<input name="reimbursementAmount"  type="text" floatType="RD_reimbursementAmount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_total_amount reimbursementAmount" autocomplete="off" style="height: 100%;" value="' + (d.reimbursementAmount||'0') + '">';
                }
            },
            {
                field: 'taxAmount',
                title: '税额',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return (d.taxAmount||'0')
                    }
                    return '<input name="taxAmount" taxRate="' + isShowNull(d.taxRate) + '" type="text" floatType="RD_taxAmount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + (d.taxAmount||'0') + '">';
                }
            },
            {
                field: 'amountExcludingTax',
                title: '不含税金额',
                minWidth: 150,
                templet: function (d) {
                    return '<span class="amountExcludingTax KD_amount"">' + (d.amountExcludingTax||'0') + '</span>';
                }
            },
            {
                field: 'vehicleFile', title: '车辆管理', minWidth: 300, templet: function (d) {
                    if (isPreview == '1') {
                        return isShowNull(d.vehicleFile)
                    }
                    return '<input name="vehicleFile" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.vehicleFile) + '">';
                }
            },
            {
                field: 'itemDesc', title: '事项说明', minWidth: 300, templet: function (d) {
                    if (isPreview == '1') {
                        return isShowNull(d.itemDesc)
                    }
                    return '<input name="itemDesc" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.itemDesc) + '">';
                }
            },
            {
                field: 'planTaskId', title: '关联工作计划', hide: isPreview == '1', event: 'choosePlanTask', style: 'cursor: pointer;', minWidth: 150, templet: function (d) {
                    return '<span class="planTaskId" planTaskId="' + isShowNull(d.planTaskId) + '">' + isShowNull(d.planTaskName) + '</span>';
                }
            }
        ]
        var reimbursementWriteTableCols = [
            {type: isPreview == '1' ? 'numbers' : 'checkbox', title: '序号'},
            {
                field: 'merchantsUnitName', title: '预付客商', minWidth: 150, templet: function (d) {
                    if (isPreview == '1') {
                        return isShowNull(d.merchantsUnitName)
                    }
                    return '<input readonly name="merchantsUnitName" chargemoneyId="' + isShowNull(d.chargemoneyId) + '" type="text" contractId="' + isShowNull(d.contractId) + '" class="layui-input" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.merchantsUnitName) + '">';
                }
            },
            {
                field: 'reimburseNo',
                title: '预付单据编号',
                event: 'chooseItem',
                minWidth: 200,
                templet: function (d) {
                    var str = isShowNull(d.reimburseNo) || isShowNull(d.reimburseNo);
                    if (isPreview == '1') {
                        return str
                    }
                    return '<input name="reimburseNo" rbsItemId="'+isShowNull(d.rbsItemId)+'" expenseItem="'+isShowNull(d.expenseItem)+'"   capitalReimburseId="' + isShowNull(d.capitalReimburseId) + '" reimburseId="' + isShowNull(reimburseId) + '" type="text" readonly class="layui-input deptItemId" style="height: 100%; cursor: pointer;" value="' + str + '">';
                }
            },
            {
                field: 'budgetAmount',
                title: '预付金额',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return (d.budgetAmount||'0')
                    }
                    return '<input name="budgetAmount" class="layui-input" type="text" readonly style="height: 100%;width: 100px" value="'+(d.budgetAmount||'0')+'">'
                }
            },
            {
                field: 'rebateAmount', title: '已冲账金额', minWidth: 150, templet: function (d) {
                    return '<input readonly type="text" name="rebateAmount" class="rebateAmount layui-input"  value="' + (d.rebateAmount ||'0') + '" style="height: 100%;" >';
                }
            },
            {
                field: 'totalReimbursement',
                title: '本次报销金额',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return (d.totalReimbursement||'0')
                    }
                    return '<input id="totalReimbursement" name="totalReimbursement" type="text" pointFlag="1" floatType="RD_totalReimbursement" handleCallback="afterFloatChange"  class="layui-input input_floatNum KD_total_amount" autocomplete="off" style="height: 100%;" value="' + (d.totalReimbursement || '0') + '">';                }
            },
            {
                field: 'nhPrepaymentAmount',
                title: '本次冲账金额',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return (d.nhPrepaymentAmount||'0')
                    }
                    return '<input id="nhPrepaymentAmount" name="nhPrepaymentAmount" pointFlag="1" floatType="RD_nhPrepaymentAmount" handleCallback="afterFloatChange" taxRate="' + isShowNull(d.taxRate) + '" type="text"  class="layui-input input_floatNum KD_tax_amount" autocomplete="off" style="height: 100%;" value="' +(d.nhPrepaymentAmount ||'0') + '">';
                }
            },
            {
                field: 'hxPrepaymentAmount',
                title: '冲账后预付款金额',
                minWidth: 150,
                templet: function (d) {
                    return '<input readonly id="hxPrepaymentAmount" name="hxPrepaymentAmount" class=" layui-input"  value="' + (d.hxPrepaymentAmount||'0') + '"  style="height: 100%;" >';
                }
            },
            {
                field: 'memo', title: '备注', minWidth: 300, templet: function (d) {
                    if (isPreview == '1') {
                        return isShowNull(d.memo)
                    }
                    return '<input name="memo" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.memo) + '">';
                }
            },

        ]
        if(reimburseType !='03'){
            $('input[name="vehicleFile"]').hide()
        }
        if (reimburseType == '04') {
            reimbursementDetailsTableCols = [
                {type: isPreview == '1' ? 'numbers' : 'checkbox', title: '选择'},
                {
                    field: 'reimburseUser',
                    title: '报销人',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.reimburseUserName).replace(/,$/, '')
                        }
                        return '<input name="reimburseUser" id="" readonly user_id="' + (d.reimburseUser || '') + '" type="text" class="layui-input choose_user" autocomplete="off" style="height: 100%;cursor: pointer;" value="' + isShowNull(d.reimburseUserName).replace(/,$/, '') + '">';
                    }
                },
                {
                    field: 'reimburseBelongDept',
                    title: '所属部门',
                    event: 'chooseReimburseBelongDept',
                    minWidth: 200,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.reimburseBelongDeptName).replace(/,$/, '')
                        }
                        return '<input name="reimburseBelongDept" readonly dept_id="' + (d.reimburseBelongDept || '') + '" type="text" class="layui-input" autocomplete="off" style="height: 100%;cursor: pointer;" value="' + isShowNull(d.reimburseBelongDeptName).replace(/,$/, '') + '">';
                    }
                },
                {
                    field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.deptName)
                        }
                        return '<input readonly name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input choose_dept" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.deptName) + '">';
                    }
                },
                {
                    field: 'deptItemId',
                    title: '预算科目',
                    event: 'chooseItem',
                    minWidth: 200,
                    templet: function (d) {
                        var str = isShowNull(d.rbsItemName) || isShowNull(d.itemName);
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input name="deptItemId" listId="' + isShowNull(d.listId) + '" cbsId="' + isShowNull(d.cbsId) + '" rbsItemId="' + isShowNull(d.rbsItemId) + '" type="text" readonly class="layui-input deptItemId" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'expenseItem',
                    title: '费用项目',
                    minWidth: 200,
                    templet: function (d) {
                        return '<input name="expenseItem" type="text" readonly class="layui-input expenseItem" expenseItem="' + isShowNull(d.expenseItem) + '" style="height: 100%;" value="'+(d.expenseItemName||'')+'">';
                    }
                },
                {
                    field: 'budgetMoney', title: '年度预算总额', minWidth: 150, templet: function (d) {
                        return '<span class="budgetMoney">' + (d.budgetMoney||'0') + '</span>';
                    }
                },
                {
                    field: 'budgetBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
                        return '<span class="budgetBalance">' + (d.budgetBalance||'0') + '</span>';
                    }
                },
                {
                    field: 'applicationAmount', title: '报销金额', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return (d.applicationAmount||'0')
                        }
                        return '<input name="applicationAmount" type="text" floatType="RD_applicationAmount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_total_amount applicationAmount" autocomplete="off" style="height: 100%;" value="' + (d.applicationAmount||'0') + '">';
                    }
                },
                {
                    field: 'taxAmount',
                    title: '税额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return (d.taxAmount||'0')
                        }
                        return '<input name="taxAmount" taxRate="' + isShowNull(d.taxRate) + '" type="text" floatType="RD_taxAmount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + (d.taxAmount||'0') + '">';
                    }
                },
                {
                    field: 'amountExcludingTax',
                    title: '不含税金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="amountExcludingTax KD_amount">' + (d.amountExcludingTax||'0') + '</span>';
                    }
                },
                {
                    field: 'itemDesc', title: '事项说明', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.itemDesc)
                        }
                        return '<input name="itemDesc" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.itemDesc) + '">';
                    }
                },
                {
                    field: 'planTaskId', title: '关联工作计划', hide: isPreview == '1', event: 'choosePlanTask', minWidth: 150, style: 'cursor: pointer;', templet: function (d) {
                        return '<span class="planTaskId" planTaskId="' + isShowNull(d.planTaskId) + '">' + isShowNull(d.planTaskName) + '</span>';
                    }
                }
            ]
        }

        if(reimburseType == '05'){
             reimbursementDetailsTableCols = [
                {type: isPreview == '1' ? 'numbers' : 'checkbox', title: '序号'},
                {
                    field: 'deptId', title: '费用承担部门', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.deptName)
                        }
                        return '<input readonly name="deptId" type="text" deptId="' + isShowNull(d.deptId) + '" class="layui-input choose_dept" autocomplete="off" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.deptName) + '">';
                    }
                },
                {
                    field: 'deptItemId',
                    title: '预算科目',
                    event: 'chooseItem',
                    minWidth: 200,
                    templet: function (d) {
                        var str = isShowNull(d.rbsItemName) || isShowNull(d.itemName);
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input name="deptItemId" listId="' + isShowNull(d.listId) + '" cbsId="' + isShowNull(d.cbsId) + '" rbsItemId="' + isShowNull(d.rbsItemId) + '" type="text" readonly class="layui-input deptItemId" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                 {
                     field: 'expenseItem',
                     title: '费用项目',
                     minWidth: 200,
                     templet: function (d) {
                         return '<input name="expenseItem" type="text" readonly class="layui-input expenseItem" expenseItem="' + isShowNull(d.expenseItem) + '" style="height: 100%;" value="'+(d.expenseItemName||'')+'">';
                     }
                 },
                {
                    field: 'budgetMoney',
                    title: '年度预算总额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="budgetMoney">' + (d.budgetMoney||'0') + '</span>';
                    }
                },
                {
                    field: 'budgetBalance', title: '年度预算余额', minWidth: 150, templet: function (d) {
                        return '<span class="budgetBalance">' + (d.budgetBalance||'0') + '</span>';
                    }
                },
                {
                    field: 'applicationAmount',
                    title: '本次支付金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return (d.applicationAmount||'0')
                        }
                        return '<input name="applicationAmount" type="text" floatType="RD_paymentAmount" handleCallback="afterFloatChange" pointFlag="1"  class="layui-input input_floatNum KD_total_amount applicationAmount" autocomplete="off" style="height: 100%;" value="' + (d.applicationAmount||'0') + '">';
                    }
                },
                {
                    field: 'itemDesc', title: '事项说明', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.itemDesc)
                        }
                        return '<input name="itemDesc" type="text" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.itemDesc) + '">';
                    }
                },
                {
                    field: 'planTaskId', title: '关联工作计划', hide: isPreview == '1', event: 'choosePlanTask', style: 'cursor: pointer;', minWidth: 150, templet: function (d) {
                        return '<span class="planTaskId" planTaskId="' + isShowNull(d.planTaskId) + '">' + isShowNull(d.planTaskName) + '</span>';
                    }
                }
            ]
        }
        if (reimburseType != '01' && reimburseType != '02' && reimburseType != '05') {
            reimbursementDetailsTableCols.push({
                field: 'invoices',
                title: '发票',
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
                    return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div></div>';
                }
            });
        }

        if (!(type == 3 && disabled == '1') && reimburseStatus != '4') {
            reimbursementDetailsTableCols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#barDemo',
                title: '操作',
                width: 100
            });
            reimbursementWriteTableCols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#barDemo',
                title: '操作',
                width: 100
            });
        }
        if (type == 3 && reimburseStatus == '4') {
            if(reimburseType == '03' || reimburseType == '04'){
                reimbursementDetailsTableCols.push({
                    fixed: 'right',
                    align: 'center',
                    toolbar: '#addReceipt',
                    title: '操作',
                    width: 100
                });
            }

        }

        // 初始化报销明细列表
        layTable.render({
            elem: '#reimbursementDetailsTable',
            data: reimbursementDetailsData,
            toolbar: (type == 3 && disabled == '1') || reimburseStatus == '4' ? false : reimburseType == '01' || reimburseType == '02' || reimburseType == '05' ? '#toolbarDemoIn' : '#toolbarIn',
            defaultToolbar: [''],
            limit: 1000,
            cols: [reimbursementDetailsTableCols],
            done: function (res) {
                if (!(type == 3 && disabled == '1')) {
                    $('#reimbursementDetailsModule').find('input[name="deptId"]').each(function (i, v) {
                        $(this).attr('id', 'dept_' + i);
                    });

                    $('#reimbursementDetailsModule').find('input[name="reimburseUser"]').each(function (i, v) {
                        $(this).attr('id', 'user_' + i);
                    });
                }
            }
        });

        //初始化预算核销明细
        layTable.render({
            elem: '#reimbursementWriteTable',
            data: reimbursementWriteData,
            toolbar: type == 3 && disabled == '1' ? false : '#toolbarDemoIn',
            defaultToolbar: [''],
            limit: 1000,
            cols: [reimbursementWriteTableCols],
            done: function () {
                if (!(type == 3 && disabled == '1')) {
                    $('#reimbursementDetailsModule').find('input[name="deptId"]').each(function (i, v) {
                        $(this).attr('id', 'dept_' + i);
                    });

                    $('#reimbursementDetailsModule').find('input[name="reimburseUser"]').each(function (i, v) {
                        $(this).attr('id', 'user_' + i);
                    });
                }
            }
        });

        if (reimburseType == '01' || reimburseType == '02') {
            var longDistanceTableCols = [
                {type: 'numbers', title: '序号'},
                {
                    field: 'vehicle',
                    title: '乘坐工具',
                    minWidth: 150,
                    event: 'chooseVehicle',
                    templet: function (d) {
                        var str = dictionaryObj['RIDE_STANDARD']['object'][d.vehicle] || '';
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input type="text" name="vehicle" costId="' + isShowNull(d.costId) + '" readonly vehicle="' + isShowNull(d.vehicle) + '" class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'rideStandard',
                    title: '乘坐标准',
                    minWidth: 150,
                    event: 'chooseRideStandard',
                    templet: function (d) {
                        var rideStandardName = '';
                        if (d.rideStandard) {
                            var rideStandards = d.rideStandard.replace(/,$/, '').split(',');
                            rideStandards.forEach(function (item) {
                                var name = dictionaryObj['RIDE_STANDARD']['object'][item];
                                rideStandardName += name ? name + '/' : '';
                            })
                        }
                        return '<input style="height: 100%;" name="rideStandard"  readonly rideStandard="' + (d.rideStandard || '') + '" class="rideStandard Required layui-input" value="' + rideStandardName.replace(/\/$/, '') + '">';

                      //  return '<span type="text" rideStandard="' + (d.rideStandard || '') + '" class="rideStandard">' + rideStandardName.replace(/\/$/, '') + '</span>';
                    }
                },
                {
                    field: 'useDate', title: '发生日期', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return format(d.useDate)
                        }
                        return '<input type="text" name="useDate" readonly class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + format(d.useDate) + '">';
                    }
                },
                {
                    field: 'leavePlace', title: '出发地', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.leavePlace)
                        }
                        return '<input type="text" name="leavePlace" class="layui-input Required" style="height: 100%;" value="' + isShowNull(d.leavePlace) + '">';
                    }
                },
                {
                    field: 'destination', title: '目的地', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.destination)
                        }
                        return '<input type="text" name="destination" class="layui-input Required" style="height: 100%;" value="' + isShowNull(d.destination) + '">';
                    }
                },
                {
                    field: 'amount', title: '报销金额', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="amount">' + isShowNull(d.amount) + '</span>'
                        }
                        return '<input type="text" name="amount" floatType="LD_amount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amount) + '">';
                    }
                },
                {
                    field: 'taxAmount', title: '税额', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="taxAmount">' + isShowNull(d.taxAmount) + '</span>'
                        }
                        return '<input type="text" name="taxAmount" taxRate="' + isShowNull(d.taxRate) + '" floatType="LD_taxAmount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
                    }
                },
                {
                    field: 'amountExcludingTax', title: '不含税金额', minWidth: 150, templet: function (d) {
                        return '<span class="amountExcludingTax KD_amount">' + isShowNull(d.amountExcludingTax) + '</span>';
                    }
                },
                {
                    field: 'adjustAmount',
                    title: '会计调整金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="adjustAmount">' + isShowNull(d.adjustAmount) + '</span>'
                        }
                        return '<input type="text" name="adjustAmount" floatType="LD_adjustAmount" handleCallback="afterFloatChange" minusFlag="1" pointFlag="1" class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.adjustAmount) + '">';
                    }
                },
                {
                    field: 'afterChangeAmount',
                    title: '会计调整后金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="afterChangeAmount">' + isShowNull(d.afterChangeAmount) + '</span>';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.remark)
                        }
                        return '<input type="text" name="remark" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                    }
                },
                {
                    field: 'invoices',
                    title: '发票',
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
                        return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div></div>';
                    }
                }
            ]
            var cityCostTableCols = [
                {type: 'numbers', title: '序号'},
                {
                    field: 'cityCostType',
                    title: '市内交通费类型',
                    minWidth: 150,
                    event: 'chooseCityCostType',
                    templet: function (d) {
                        var str = dictionaryObj['CITY_COST_TYPE']['object'][d.cityCostType] || '';
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input type="text" name="cityCostType" cityCostId="' + isShowNull(d.cityCostId) + '" readonly cityCostType="' + isShowNull(d.cityCostType) + '" class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'invoiceType',
                    title: '单据类型',
                    minWidth: 150,
                    event: 'chooseInvoiceType',
                    templet: function (d) {
                        var str = dictionaryObj['BILL_TYPE']['object'][d.invoiceType] || '';
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input type="text" name="invoiceType" readonly invoiceType="' + isShowNull(d.invoiceType) + '" class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'useDate', title: '发生日期', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return format(d.useDate)
                        }
                        return '<input type="text" name="useDate" readonly class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + format(d.useDate) + '">';
                    }
                },
                {
                    field: 'amount', title: '报销金额', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="amount">' + isShowNull(d.amount) + '</span>'
                        }
                        return '<input type="text" name="amount" floatType="CC_amount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_total_amount Required" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amount) + '">';
                    }
                },
                {
                    field: 'taxAmount', title: '税额', minWidth: 150, templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="taxAmount">' + isShowNull(d.taxAmount) + '</span>'
                        }
                        return '<input type="text" floatType="CC_taxAmount" handleCallback="afterFloatChange" taxRate="' + isShowNull(d.taxRate) + '" name="taxAmount" pointFlag="1" class="layui-input input_floatNum KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
                    }
                },
                {
                    field: 'amountExcludingTax', title: '不含税金额', minWidth: 150, templet: function (d) {
                        return '<span class="amountExcludingTax KD_amount">' + isShowNull(d.amountExcludingTax) + '</span>';
                    }
                },
                {
                    field: 'adjustAmount',
                    title: '会计调整金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="adjustAmount">' + isShowNull(d.adjustAmount) + '</span>'
                        }
                        return '<input type="text" name="adjustAmount" floatType="CC_adjustAmount" handleCallback="afterFloatChange" minusFlag="1" pointFlag="1" class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.adjustAmount) + '">';
                    }
                },
                {
                    field: 'afterChangeAmount',
                    title: '会计调整后金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="afterChangeAmount">' + isShowNull(d.afterChangeAmount) + '</span>';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.remark)
                        }
                        return '<input type="text" name="remark" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                    }
                },
                {
                    field: 'invoices',
                    title: '发票',
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
                        return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div></div>';
                    }
                }
            ]
            var stayCostTableCols = [
                {type: 'numbers', title: '序号'},
                {
                    field: 'stayPlace',
                    title: '住宿地点',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.stayPlace)
                        }
                        return '<input type="text" name="stayPlace" stayCostId="' + isShowNull(d.stayCostId) + '" class="layui-input Required" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.stayPlace) + '">';
                    }
                },
                {
                    field: 'stayDate', title: '住宿日期', minWidth: 300, templet: function (d) {
                        var stayDate = '';
                        if (d.startDate && d.endDate) {
                            stayDate = format(d.startDate) + ' | ' + format(d.endDate);
                        }
                        if (isPreview == '1') {
                            return stayDate
                        }
                        return '<input type="text" name="stayDate" readonly class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + stayDate + '">';
                    }
                },
                {
                    field: 'stayDays', title: '住宿天数', minWidth: 150, templet: function (d) {
                        return '<span class="stayDays">' + isShowNull(d.stayDays) + '</span>';
                    }
                },
                {
                    field: 'stayStandard', title: '住宿标准', minWidth: 150, templet: function (d) {
                        return '<span class="stayStandard ">' + isShowNull(d.stayStandard) + '</span>';
                    }
                },
                {
                    field: 'invoiceType',
                    title: '发票类型',
                    minWidth: 150,
                    event: 'chooseInvoiceType',
                    templet: function (d) {
                        var str = dictionaryObj['INVOICE_TYPE']['object'][d.invoiceType] || '';
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input type="text" name="invoiceType" readonly invoiceType="' + isShowNull(d.invoiceType) + '" class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'amountIncludingTax',
                    title: '报销金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="amountIncludingTax">' + isShowNull(d.amountIncludingTax) + '</span>'
                        }
                        return '<input type="text" name="amountIncludingTax" floatType="SC_amountIncludingTax" pointFlag="1" handleCallback="afterFloatChange" class="layui-input input_floatNum KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountIncludingTax) + '">';
                    }
                },
                {
                    field: 'taxAmount', title: '税额', minWidth: 150, templet: function (d) {
                        var readonly = d.invoiceType == '01' ? '' : 'readonly';
                        if (isPreview == '1') {
                            return '<span class="taxAmount">' + isShowNull(d.taxAmount) + '</span>'
                        }
                        return '<input type="text" ' + readonly + ' taxRate="' + isShowNull(d.taxRate) + '" name="taxAmount" floatType="SC_taxAmount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
                    }
                },
                {
                    field: 'amountExcludingTax',
                    title: '不含税金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="amountExcludingTax KD_amount">' + isShowNull(d.amountExcludingTax) + '</span>';
                    }
                },
                {
                    field: 'adjustAmount',
                    title: '会计调整金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="adjustAmount">' + isShowNull(d.adjustAmount) + '</span>'
                        }
                        return '<input type="text" name="adjustAmount" floatType="SC_adjustAmount" handleCallback="afterFloatChange" minusFlag="1" pointFlag="1" class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.adjustAmount) + '">';
                    }
                },
                {
                    field: 'afterChangeAmount',
                    title: '会计调整后金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="afterChangeAmount">' + isShowNull(d.afterChangeAmount) + '</span>';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.remark)
                        }
                        return '<input type="text" name="remark" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                    }
                },
                {
                    field: 'invoices',
                    title: '发票',
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
                        return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div></div>';
                    }
                }
            ]
            var otherCostTableCols = [
                {type: 'numbers', title: '序号'},
                {
                    field: 'useDate',
                    title: '费用发生日期',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return format(d.useDate)
                        }
                        return '<input type="text" name="useDate" otherCostId="' + isShowNull(d.otherCostId) + '" readonly class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + format(d.useDate) + '">';
                    }
                },
                {
                    field: 'stayDesc', title: '费用描述', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.stayDesc)
                        }
                        return '<input type="text" name="stayDesc" class="layui-input Required" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.stayDesc) + '">';
                    }
                },
                {
                    field: 'invoiceType',
                    title: '发票类型',
                    minWidth: 150,
                    event: 'chooseInvoiceType',
                    templet: function (d) {
                        var str = dictionaryObj['INVOICE_TYPE']['object'][d.invoiceType] || '';
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input type="text" name="invoiceType" readonly invoiceType="' + isShowNull(d.invoiceType) + '" class="layui-input Required" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'amountIncludingTax',
                    title: '报销金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="amountIncludingTax">' + isShowNull(d.amountIncludingTax) + '</span>'
                        }
                        return '<input type="text" name="amountIncludingTax" floatType="OC_amountIncludingTax" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_total_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.amountIncludingTax) + '">';
                    }
                },
                {
                    field: 'taxAmount', title: '税额', minWidth: 150, templet: function (d) {
                        var readonly = d.invoiceType == '01' ? '' : 'readonly';
                        if (isPreview == '1') {
                            return '<span class="taxAmount">' + isShowNull(d.taxAmount) + '</span>'
                        }
                        return '<input type="text" ' + readonly + ' taxRate="' + isShowNull(d.taxRate) + '" name="taxAmount" floatType="OC_taxAmount" handleCallback="afterFloatChange" pointFlag="1" class="layui-input input_floatNum KD_tax_amount" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.taxAmount) + '">';
                    }
                },
                {
                    field: 'amountExcludingTax',
                    title: '不含税金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="amountExcludingTax KD_amount">' + isShowNull(d.amountExcludingTax) + '</span>';
                    }
                },
                {
                    field: 'adjustAmount',
                    title: '会计调整金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="adjustAmount">' + isShowNull(d.adjustAmount) + '</span>'
                        }
                        return '<input type="text" name="adjustAmount" floatType="OC_adjustAmount" handleCallback="afterFloatChange" minusFlag="1" pointFlag="1" class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.adjustAmount) + '">';
                    }
                },
                {
                    field: 'afterChangeAmount',
                    title: '会计调整后金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="afterChangeAmount">' + isShowNull(d.afterChangeAmount) + '</span>';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.remark)
                        }
                        return '<input type="text" name="remark" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                    }
                },
                {
                    field: 'invoices',
                    title: '发票',
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
                        return '<div class="invoices_module"><div class="invoices_box">' + invoiceStr + '</div></div>';
                    }
                }
            ]
            var subsidyTableCols = [
                {type: 'numbers', title: '序号'},
                {
                    field: 'subsidyType',
                    title: '补助类型',
                    minWidth: 150,
                    event: 'chooseSubsidyType',
                    templet: function (d) {
                        var str = dictionaryObj['SUBSIDY_TYPE']['object'][d.subsidyType] || '';
                        if (isPreview == '1') {
                            return str
                        }
                        return '<input type="text" name="subsidyType" listId="' + isShowNull(d.listId) + '" readonly subsidyType="' + isShowNull(d.subsidyType) + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                    }
                },
                {
                    field: 'subsidyDate', title: '补助日期', minWidth: 300, templet: function (d) {
                        var subsidyDate = '';
                        if (d.startDate && d.endDate) {
                            subsidyDate = format(d.startDate) + ' | ' + format(d.endDate);
                        }
                        if (isPreview == '1') {
                            return subsidyDate
                        }
                        return '<input type="text" name="subsidyDate" readonly class="layui-input" style="height: 100%; cursor: pointer;" value="' + subsidyDate + '">';
                    }
                },
                {
                    field: 'subsidyDays', title: '补助天数', minWidth: 150, templet: function (d) {
                        return '<span class="subsidyDays">' + isShowNull(d.subsidyDays) + '</span>';
                    }
                },
                {
                    field: 'subsidyStandard',
                    title: '补助标准',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="subsidyStandard">' + isShowNull(d.subsidyStandard) + '</span>';
                    }
                },
                {
                    field: 'subsidyAmount',
                    title: '补助金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="subsidyAmount">' + isShowNull(d.subsidyAmount) + '</span>';
                    }
                },
                {
                    field: 'adjustAmount',
                    title: '会计调整金额',
                    minWidth: 150,
                    templet: function (d) {
                        if (isPreview == '1') {
                            return '<span class="adjustAmount">' + isShowNull(d.adjustAmount) + '</span>'
                        }
                        return '<input type="text" name="adjustAmount" floatType="S_adjustAmount" handleCallback="afterFloatChange" minusFlag="1" pointFlag="1" class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.adjustAmount) + '">';
                    }
                },
                {
                    field: 'afterChangeAmount',
                    title: '会计调整后金额',
                    minWidth: 150,
                    templet: function (d) {
                        return '<span class="afterChangeAmount">' + isShowNull(d.afterChangeAmount) + '</span>';
                    }
                },
                {
                    field: 'remark', title: '备注', minWidth: 300, templet: function (d) {
                        if (isPreview == '1') {
                            return isShowNull(d.remark)
                        }
                        return '<input type="text" name="remark" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remark) + '">';
                    }
                }
            ]
            if (!(type == 3 && disabled == '1') && reimburseStatus != '4') {
                longDistanceTableCols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100});
                cityCostTableCols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100});
                stayCostTableCols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100});
                otherCostTableCols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100});
                subsidyTableCols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100});
            }
            if (type == 3 && reimburseStatus == '4') {
                longDistanceTableCols.push({fixed: 'right', align: 'center', toolbar: '#addReceipt', title: '操作', width: 100});
                cityCostTableCols.push({fixed: 'right', align: 'center', toolbar: '#addReceipt', title: '操作', width: 100});
                stayCostTableCols.push({fixed: 'right', align: 'center', toolbar: '#addReceipt', title: '操作', width: 100});
                otherCostTableCols.push({fixed: 'right', align: 'center', toolbar: '#addReceipt', title: '操作', width: 100});
            }
            // 初始化长途交通费明细列表
            layTable.render({
                elem: '#longDistanceTable',
                data: plbLongdistanceCosts,
                toolbar: (type == 3 && disabled == '1') || reimburseStatus == '4' ? false : '#tripDetailToolbar',
                defaultToolbar: [''],
                limit: 1000,
                cols: [longDistanceTableCols],
                done: function () {
                    if (!(type == 3 && disabled == '1')) {
                        var layDateArr = []
                        $('#longDistanceTableModule').find('input[name="useDate"]').each(function (i, v) {
                            var config = {
                                elem: v,
                                trigger: 'click'
                            }
                            if ($('#startDate').val()) {
                                config.min = $('#startDate').val();
                            }
                            if ($('#endDate').val()) {
                                config.max = $('#endDate').val();
                            }
                            var dateObj = laydate.render(config);
                            layDateArr.push(dateObj);
                        });
                        layDateObj.longDistanceTable = layDateArr;
                    }
                }
            });

            // 初始化市内交通费明细列表
            layTable.render({
                elem: '#cityCostTable',
                data: plbCityCosts,
                toolbar: (type == 3 && disabled == '1') || reimburseStatus == '4' ? false : '#tripDetailToolbar',
                defaultToolbar: [''],
                limit: 1000,
                cols: [cityCostTableCols],
                done: function () {
                    if (!(type == 3 && disabled == '1')) {
                        var layDateArr = []
                        $('#cityCostTableModule').find('input[name="useDate"]').each(function (i, v) {
                            var config = {
                                elem: v,
                                trigger: 'click'
                            }
                            if ($('#startDate').val()) {
                                config.min = $('#startDate').val();
                            }
                            if ($('#endDate').val()) {
                                config.max = $('#endDate').val();
                            }
                            var dateObj = laydate.render(config);
                            layDateArr.push(dateObj);
                        });
                        layDateObj.cityCostTable = layDateArr;
                    }
                }
            });

            // 初始化住宿费明细列表
            layTable.render({
                elem: '#stayCostTable',
                data: plbStayCosts,
                toolbar: (type == 3 && disabled == '1') || reimburseStatus == '4' ? false : '#tripDetailToolbar',
                defaultToolbar: [''],
                limit: 1000,
                cols: [stayCostTableCols],
                done: function () {
                    if (!(type == 3 && disabled == '1')) {
                        var layDateArr = []
                        $('#stayCostTableModule').find('input[name="stayDate"]').each(function (i, v) {
                            var config = {
                                elem: v,
                                trigger: 'click',
                                range: '|',
                                done: function (value) {
                                    // 获取当前元素
                                    var elem = this.elem[0];
                                    var $parent = $(elem).parents('tr');
                                    value = value.replace(/\s/g, '');
                                    var stayDays = 0;

                                    if (value) {
                                        var startDateStr = value.split('|')[0];
                                        var endDateStr = value.split('|')[1];

                                        stayDays = getDays(startDateStr, endDateStr) - 1;
                                    }
                                    // 修改住宿天数
                                    $parent.find('.stayDays').text(stayDays);
                                }
                            }
                            if ($('#startDate').val()) {
                                config.min = $('#startDate').val();
                            }
                            if ($('#endDate').val()) {
                                config.max = $('#endDate').val();
                            }
                            var dateObj = laydate.render(config);
                            layDateArr.push(dateObj);
                        });
                        layDateObj.stayCostTable = layDateArr;
                    }
                }
            });

            // 初始化其他费用明细列表
            layTable.render({
                elem: '#otherCostTable',
                data: plbOtherCosts,
                toolbar: (type == 3 && disabled == '1') || reimburseStatus == '4' ? false : '#tripDetailToolbar',
                defaultToolbar: [''],
                limit: 1000,
                cols: [otherCostTableCols],
                done: function () {
                    if (!(type == 3 && disabled == '1')) {
                        var layDateArr = []
                        $('#otherCostTableModule').find('input[name="useDate"]').each(function (i, v) {
                            var config = {
                                elem: v,
                                trigger: 'click'
                            }
                            if ($('#startDate').val()) {
                                config.min = $('#startDate').val();
                            }
                            if ($('#endDate').val()) {
                                config.max = $('#endDate').val();
                            }
                            var dateObj = laydate.render(config);
                            layDateArr.push(dateObj);
                        });
                        layDateObj.otherCostTable = layDateArr;
                    }
                }
            });

            // 初始化补助费用明细列表
            layTable.render({
                elem: '#subsidyTable',
                data: plbSubsidyLists,
                toolbar: (type == 3 && disabled == '1') || reimburseStatus == '4' ? false : '#toolbarDemoIn',
                defaultToolbar: [''],
                limit: 1000,
                cols: [subsidyTableCols],
                done: function () {
                    if (!(type == 3 && disabled == '1')) {
                        var layDateArr = []
                        $('#subsidyTableModule').find('input[name="subsidyDate"]').each(function (i, v) {
                            var config = {
                                elem: v,
                                trigger: 'click',
                                range: '|',
                                done: function (value) {
                                    // 获取当前元素
                                    var elem = this.elem[0];
                                    var $parent = $(elem).parents('tr');
                                    value = value.replace(/\s/g, '');
                                    var subsidyDays = 0;
                                    if (value) {
                                        var startDate = value.split('|')[0];
                                        var endDate = value.split('|')[1];
                                        subsidyDays = getDays(startDate, endDate);
                                    }
                                    // 修改住宿天数
                                    $parent.find('.subsidyDays').text(subsidyDays);
                                    recountSubsidy($parent);
                                    // 重新汇总
                                    getTripDetailTotal();
                                }
                            }
                            if ($('#startDate').val()) {
                                config.min = $('#startDate').val();
                            }
                            if ($('#endDate').val()) {
                                config.max = $('#endDate').val();
                            }
                            var dateObj = laydate.render(config);
                            layDateArr.push(dateObj);
                        });
                        layDateObj.subsidyTable = layDateArr;
                    }
                }
            });

            if (type != 1) {
                getTripDetailTotal();
            }
        }

        var paymentDetailsTableCols = [
            {type: 'numbers', title: '序号'},
            {
                field: 'paymentType',
                title: '付款方式',
                event: 'choosePay',
                minWidth: 150,
                templet: function (d) {
                    var str = dictionaryObj['PAYMENT_METHOD']['object'][d.paymentType] || '';
                    if (isPreview == '1') {
                        return str
                    }
                    return '<input type="text" name="paymentType" paymentId="' + isShowNull(d.paymentId) + '" readonly paymentType="' + isShowNull(d.paymentType) + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
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
                    if (isPreview == '1') {
                        return str
                    }
                    return '<input readonly name="collectionUser" ' + attr + ' type="text" class="layui-input" style="height: 100%; cursor: pointer;" value="' + str + '">';
                }
            },
            {
                field: 'collectionAccount',
                title: '银行账号',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return isShowNull(d.collectionAccount)
                    }
                    return '<input type="text" name="collectionAccount"  class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.collectionAccount) + '">';
                }
            },
            {
                field: 'collectionBank',
                title: '开户行',
                minWidth: 150,
                templet: function (d) {
                    return '<input type="text"  name="collectionBank" collectionBankNo="' + d.collectionBank + '" class="layui-input" style="height: 100%; cursor: pointer;" value="' + isShowNull(d.collectionBankName).replace(/,$/, '') + '">';
                }
            },
            {
                field: 'collectionMoney',
                title: '收款金额',
                minWidth: 150,
                templet: function (d) {
                    if (isPreview == '1') {
                        return (d.collectionMoney||'0')
                    }
                    var str='';
                    if( reimburseType == '05'){
                        str='readonly'
                    }
                    return '<input type="text" name="collectionMoney"  '+str+' pointFlag="1" class="layui-input input_floatNum KD_collection_money" autocomplete="off" style="height: 100%;" value="' + (d.collectionMoney||'0') + '">';
                }
            },
            {
                field: 'remarks', title: '备注', minWidth: 300, templet: function (d) {
                    if (isPreview == '1') {
                        return isShowNull(d.remarks)
                    }
                    return '<input type="text" name="remarks" class="layui-input" autocomplete="off" style="height: 100%;" value="' + isShowNull(d.remarks) + '">';
                }
            }
        ]
        if (!(type == 3 && disabled == '1') && reimburseStatus != '4') {
            paymentDetailsTableCols.push({
                fixed: 'right',
                align: 'center',
                toolbar: '#barDemo',
                title: '操作',
                width: 100
            });
        }
        // 初始化付款明细列表
        layTable.render({
            elem: '#paymentDetailsTable',
            data: paymentmentDetailsData,
            toolbar: (type == 3 && disabled == '1') || reimburseStatus == '4' ? false : '#toolbarDemoIn',
            defaultToolbar: [''],
            limit: 1000,
            cols: [paymentDetailsTableCols],
            done: function () {
                $('#paymentDetailsModule').find('input[name="collectionUser"]').each(function (i, v) {
                    $(v).attr('id', 'collectionUser' + i);
                });
            }
        });

        if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
            $('.wrapper').find('input').attr('disabled', 'disabled');
            if (plbLongdistanceCosts.length == 0) {
                $('#longDistanceTableModule').parents('.layui-card').hide();
            }
            if (plbCityCosts.length == 0) {
                $('#cityCostTableModule').parents('.layui-card').hide();
            }
            if (plbStayCosts.length == 0) {
                $('#stayCostTableModule').parents('.layui-card').hide();
            }
            if (plbOtherCosts.length == 0) {
                $('#otherCostTableModule').parents('.layui-card').hide();
            }
            if (plbSubsidyLists.length == 0) {
                $('#subsidyTableModule').parents('.layui-card').hide();
            }

            if (reimburseStatus == '4') {
                $('#fileupload').attr('disabled', false);
                $('[name="attachmentNum"]', $('#baseForm')).attr('disabled', false);
            }
        }

        layForm.render();

        layForm.on('radio(multiCurrency)', function (data) {
            if (data.value == 0) {
                $('[name="reimburseTotalOriginal"]', $('#baseForm')).parents('.layui-form-item').hide();
            } else {
                $('[name="reimburseTotalOriginal"]', $('#baseForm')).parents('.layui-form-item').show();
            }
        });

        layForm.on('radio(overStandard)', function (data) {
            if (data.value == 0) {
                $('[name="overStandardReason"]', $('#baseForm')).parents('.layui-form-item').hide();
            } else {
                $('[name="overStandardReason"]', $('#baseForm')).parents('.layui-form-item').show();
            }
        });
        layForm.on('radio(whetherContract)',function(data){
            if (data.value == 0) {
                $('[name="contractMoney"]').parent().parent().find('span').removeClass('field_required');
                $('[name="contractMoney"]').attr('disabled','disabled').val('').css('background','#e7e7e7');
                $('[name="contractName"]').parent().parent().find('span').removeClass('field_required');
                $('[name="contractName"]').attr('disabled','disabled').val('').css('background','#e7e7e7');
                $('[name="contractNo"]').parent().parent().find('span').removeClass('field_required');
                $('[name="contractNo"]').attr('disabled','disabled').val('').css('background','#e7e7e7');
            } else {
                $('[name="contractMoney"]').parent().parent().find('span').addClass('field_required');
                $('[name="contractMoney"]').attr('disabled',false).css('background','#FFFFFF');
                $('[name="contractName"]').parent().parent().find('span').addClass('field_required');
                $('[name="contractName"]').attr('disabled',false).css('background','#FFFFFF');
                $('[name="contractNo"]').parent().parent().find('span').addClass('field_required');
                $('[name="contractNo"]').attr('disabled',false).css('background','#FFFFFF');
            }

        });
        layForm.on('select(naturePayment)',function(data){
            if(data.value == '10'){
                $('input[name="occupationBudget"]').eq(0).click();
                $('input[name="whetherBudget"]').eq(0).click();
                layForm.render();
            }else{
                $('input[name="occupationBudget"]').eq(1).click();
                $('input[name="whetherBudget"]').eq(1).click();
                layForm.render();
            }
        })
        layForm.on('radio(whetherChargeMoney)',function(data){
         if(data.value == '1'){
             $('#reimbursementWriteModule').show();
         }else{
             $('#reimbursementWriteModule').hide();
         }
         layTable.reload('reimbursementDetailsTable',{
             data:[]
         })
         layTable.reload('reimbursementWriteTable',{
             data:[]
         })
          $('[name="reimburseTotal"]').val('0');
        })


        // 点击保存
        $('#saveBtn').on('click', function () {
            if(runId) {
                var _flag = false
                $('input[name="collectionAccount"]').each(function (j, item) {
                    if (item.value == "" || item.value == undefined) {
                        _flag = true
                        return
                    }
                })
                $('input[name="collectionBank"]').each(function (j, item) {
                    if (item.value == "" || item.value == undefined) {
                        _flag = true
                        return
                    }
                })
                if(_flag){
                    layer.open({
                        type: 1,
                        title:['提示', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['600px', '250px'],
                        shadeClose: true, //点击遮罩关闭
                        btn: ['关闭'],
                        scrollbar: false,
                        content:'<div>' +
                            '<h2 style="text-align: center;margin-top: 10px">收款账户不能为空</h2>' +
                            '<p style="margin-left: 10px;font-size: 16px">账号信息维护指南：</p>' +
                            '<p style="margin-left: 10px">个人：登录综合系统办公-依次点击右上角个人信息图标（右二）-设置-个人资料-账户信息</p>' +
                            '<p style="margin-left: 10px">客商：登录综合系统办公-左侧菜单依次选择-预算管理-往来单位-客商管理</p></div>'
                    })
                    return
                }
            }
            var loadIndex = layer.load();
            var dataObj = getSaveData(1, loadIndex);

            if (!dataObj) {
                layer.close(loadIndex)
                return false

            }

            updateReimburse(url, JSON.stringify(dataObj.dataObj), function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1, time: 2000});
                    if (type == 1) {
                        location.href = '/plbDeptBudget/editClaimForm?type=2&reimburseType=' + reimburseType + '&reimburseId=' + reimburseId;
                    } else if (type == 3) {
                        var baseObjs;
                        $.ajax({
                            url: '/plbDeptReimburse/getDataByReimburseId?reimburseId=' + reimburseId,
                            async: false,
                            success: function (res) {
                                baseObjs = res.data
                            }
                        })
                        var submitData = getSubmitData(baseObjs);
                        // 如果上传了发票
                        if ($('.invoice_file').length > 0) {
                            // 提交发票状态
                            submitKingDee(reimburseId, dataObj.dataObj.reimburseNo, reimburseType, function () {
                                $.post('/plbDeptReimburse/updateFlowData', {
                                    flowId: flowId,
                                    runId: runId,
                                    reimburseId: reimburseId,
                                    approvalData: JSON.stringify(submitData)
                                }, function (res) {
                                    location.reload();
                                });
                            });
                        } else {
                            $.post('/plbDeptReimburse/updateFlowData', {
                                flowId: flowId,
                                runId: runId,
                                reimburseId: reimburseId,
                                approvalData: JSON.stringify(submitData)
                            }, function (res) {
                                location.reload();
                            });
                        }

                    } else {
                        location.reload();
                    }
                } else {
                    layer.msg(res.msg, {icon: 2});
                }
            });
        });

        // 点击提交
        $('#submitBtn').on('click', function () {
            var requiredFlag=false
            $('.Required').each(function () {
                var dataVal=$(this).val()
                if(dataVal==""){
                    var dataKey=$(this).parent().parent().attr('data-key')
                    var text=$('.laytable-cell-'+dataKey).find('span').text()
                    layer.msg('请填写'+text, {icon: 0, time: 2000});
                    requiredFlag=true
                    return false
                }
            })
            if(requiredFlag){
                return false
            }
            var _flag=false
            $('input[name="collectionAccount"]').each(function(j,item){
                if(item.value==""||item.value==undefined){
                    _flag=true
                    return
                }
            })
            $('input[name="collectionBank"]').each(function(j,item){
                if(item.value==""||item.value==undefined){
                    _flag=true
                    return
                }
            })
            if(_flag){
                layer.open({
                    type: 1,
                    title:['提示', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['600px', '250px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['关闭'],
                    scrollbar: false,
                    content:'<div>' +
                        '<h2 style="text-align: center;margin-top: 10px">收款账户不能为空</h2>' +
                        '<p style="margin-left: 10px;font-size: 16px">账号信息维护指南：</p>' +
                        '<p style="margin-left: 10px">个人：登录综合系统办公-依次点击右上角个人信息图标（右二）-设置-个人资料-账户信息</p>' +
                        '<p style="margin-left: 10px">客商：登录综合系统办公-左侧菜单依次选择-预算管理-往来单位-客商管理</p></div>'
                })
                return
            }else{
                var loadIndex = layer.load();

                var dataObj = getSaveData(2, loadIndex);

                if (!dataObj) {
                    layer.close(loadIndex)
                    return false;
                }
                // 提交前先保存
                updateReimburse(url, JSON.stringify(dataObj.dataObj), function (res) {
                    layer.close(loadIndex);
                    if (res.flag) {
                        var plbDictNo = '';
                        switch (reimburseType) {
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
                            // case '05': // 对公费用报销单
                            //     plbDictNo = '08';
                            //     break;
                            case '05': // 资金支付审批单
                                 plbDictNo = '40';
                                break;
                            default:
                                break;
                        }
                        $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: plbDictNo}, function (res) {
                            var flowDataArr = []
                            $.each(res.data.flowData, function (k, v) {
                                flowDataArr.push({
                                    flowId: k,
                                    flowName: v
                                });
                            });
                            if (flowDataArr.length == 1) {
                                submitFlow(flowDataArr[0].flowId, reimburseId);
                            } else {
                                layer.open({
                                    type: 1,
                                    title: '选择流程',
                                    area: ['70%', '80%'],
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
                                    success: function () {
                                        layTable.render({
                                            elem: '#flowTable',
                                            data: flowDataArr,
                                            cols: [[
                                                {type: 'radio'},
                                                {field: 'flowName', title: '流程名称'}
                                            ]]
                                        })
                                    },
                                    yes: function (index) {
                                        var checkStatus = layTable.checkStatus('flowTable');
                                        if (checkStatus.data.length > 0) {
                                            var flowData = checkStatus.data[0];
                                            submitFlow(flowData.flowId, reimburseId)
                                        } else {
                                            layer.close(loadIndex);
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    },
                                    end: function () {
                                        if (type == 1) {
                                            location.href = '/plbDeptBudget/editClaimForm?type=2&reimburseType=' + reimburseType + '&reimburseId=' + reimburseId;
                                        } else {
                                            location.reload();
                                        }
                                    }
                                });
                            }
                        });
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                })

                function submitFlow(flowId, reimburseId) {
                    var loadIndex = layer.load();
                    var baseObjs;
                    $.ajax({
                        url: '/plbDeptReimburse/getDataByReimburseId?reimburseId=' + reimburseId,
                        async: false,
                        success: function (res) {
                            baseObjs = res.data
                        }
                    })
                    var submitData = getSubmitData(baseObjs);
                    delete submitData.plbCityCosts;
                    delete submitData.plbDeptContract;
                    delete submitData.plbDeptPayments;
                    delete submitData.plbDeptReimburseLists;
                    delete submitData.plbLongdistanceCosts;
                    delete submitData.plbOtherCosts;
                    delete submitData.plbStayCosts;
                    delete submitData.chargemoneyList;
                    delete submitData.plbProj;
                    delete submitData.srmsPjProject;
                    delete submitData.plbDeptSubcontract;
                    // if ($('.invoice_file').length > 0) {
                    //     submitKingDee(reimburseId, dataObj.baseObj.reimburseNo, reimburseType, function () {
                    //         newWorkFlow(flowId, JSON.stringify(submitData), function (res) {
                    //             // 报销单保存关联的runId
                    //             var changeData = {
                    //                 reimburseId: reimburseId,
                    //                 runId: res.flowRun.runId,
                    //                 reimburseStatus: '1',
                    //                 //ifImage: false
                    //             }
                    //             $.post('/plbDeptReimburse/changeApprovlStatus', changeData, function (res) {
                    //                 layer.close(loadIndex);
                    //                 if (res.flag) {
                    //                     $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + changeData.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                    //                     parent.layer.close(parent.iframeLayerIndex);
                    //                 } else {
                    //                     layer.msg(res.msg, {icon: 2});
                    //                 }
                    //             });
                    //         })
                    //     })
                    // }else{
                    //     newWorkFlow(flowId, JSON.stringify(submitData), function (res) {
                    //         // 报销单保存关联的runId
                    //         var changeData = {
                    //             reimburseId: reimburseId,
                    //             runId: res.flowRun.runId,
                    //             reimburseStatus: '1',
                    //             //ifImage: false
                    //         }
                    //         $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                    //
                    //         $.post('/plbDeptReimburse/changeApprovlStatus', changeData, function (res) {
                    //             layer.close(loadIndex);
                    //             if (res.flag) {
                    //                 parent.layer.close(parent.iframeLayerIndex);
                    //             } else {
                    //                 layer.msg(res.msg, {icon: 2});
                    //             }
                    //         });
                    //     })
                    // }
                    newWorkFlow(flowId, JSON.stringify(submitData), function (res) {
                        // 报销单保存关联的runId
                        var changeData = {
                            reimburseId: reimburseId,
                            runId: res.flowRun.runId,
                            reimburseStatus: '1',
                            ifImage: false
                        }
                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                        //如果上传了发票
                        if ($('.invoice_file').length > 0) {
                            changeData.ifImage = true;
                                // 提交发票状态
                                submitKingDee(reimburseId, dataObj.baseObj.reimburseNo, reimburseType, function () {
                                    // 更新报销单状态
                                    $.post('/plbDeptReimburse/changeApprovlStatus', changeData, function (res) {
                                        layer.close(loadIndex);
                                        if (res.flag) {
                                            parent.layer.close(parent.iframeLayerIndex);
                                        } else {
                                            layer.msg(res.msg, {icon: 2});
                                        }
                                    });
                                });
                        }else{
                            $.post('/plbDeptReimburse/changeApprovlStatus', changeData, function (res) {
                                layer.close(loadIndex);
                                if (res.flag) {
                                    parent.layer.close(parent.iframeLayerIndex);
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }
                            });
                        }
                        // if ($('.invoice_file').length > 0) {
                        //     changeData.ifImage = true;
                        // }
                        // //更新报销单状态
                        // $.post('/plbDeptReimburse/changeApprovlStatus', changeData, function (res) {
                        //     layer.close(loadIndex);
                        //     if (res.flag) {
                        //         if (changeData.ifImage) {
                        //             // 提交发票状态
                        //             submitKingDee(reimburseId, dataObj.baseObj.reimburseNo, reimburseType, function () {
                        //                 parent.layer.close(parent.iframeLayerIndex);
                        //             });
                        //         } else {
                        //             parent.layer.close(parent.iframeLayerIndex);
                        //         }
                        //     } else {
                        //         layer.msg(res.msg, {icon: 2});
                        //     }
                        // });
                    });
                }
            }

        });

        // 点击关闭
        $('#closeBtn').on('click', function () {
            parent.layer.close(parent.iframeLayerIndex);
        });

        // 流程办理提交
        $('#reSubmitBtn').on('click', function () {
            var loadIndex = layer.load();
            // 影像驳回
            if (reimburseStatus == '4') {
                var dataObj = getSaveData(1, loadIndex).dataObj;
                if (!dataObj) {
                    return false;
                }
                // 保存附件，重新生成发票影像
                $.post('/plbDeptReimburse/updateReimburseAttachment', {
                    reimburseId: reimburseId,
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
                                        parent.close();
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

        /**
         * 获取需要保存的数据
         * @param saveType (1-保存, 2-提交)
         * @param loadIndex
         */
        function getSaveData(saveType, loadIndex) {
            var dataObj = {}
            // 基本信息
            var baseForm = $('#baseForm').serializeArray();
            baseForm.forEach(function (item) {
                dataObj[item.name] = item.value;
            });
            if (type == 3) {
                dataObj = layForm.val("baseForm");
            }
            var startDate=new Date(dataObj.startDate);
            var endDate=new Date(dataObj.endDate);
            // 经办人
            dataObj.createUser = ($('[name="createUser"]', $('#baseForm')).attr('user_id') || '').replace(/,$/, '');
            // 报销人
            dataObj.reimburseUser = ($('[name="reimburseUser"]', $('#baseForm')).attr('user_id') || '').replace(/,$/, '');
            //研发项目
            dataObj.developProject=$('[name="developProject"]', $('#baseForm')).attr('pjNumber') || '';
            //工程项目
            dataObj.enginProject=$('[name="enginProject"]', $('#baseForm')).attr('projId') || '';
            //工程合同
            dataObj.enginContract=$('[name="enginContract"]', $('#baseForm')).attr('subcontractId') || '';
            // 报销单类型
            dataObj.reimburseType = reimburseType;
            var flagDeptId = '';
            if ($('.choose_dept').length > 0) {
                $('.choose_dept').each(function () {
                    var id = $(this).attr('deptid') || '';
                    if (flagDeptId && id && id != flagDeptId) {
                        dataObj.ifShare = 1;
                        return false
                    }
                    flagDeptId = id;
                });
            }

            // 附件editClaimForm
            var attachmentId = '';
            var attachmentName = '';
            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                attachmentName += $('#fileContent a').eq(i).attr('name');
            }
            dataObj.attachmentId = attachmentId;
            dataObj.attachmentName = attachmentName;

            // 发票
            var invoiceId = '';
            var invoiceName = '';
            for (var i = 0; i < $('#fileContentFP .dech').length; i++) {
                invoiceId += $('#fileContentFP .dech').eq(i).find('input').val();
                invoiceName += $('#fileContentFP a').eq(i).attr('name');
            }
            dataObj.invoiceId = invoiceId;
            dataObj.invoiceName = invoiceName;

            if (saveType == 2 || type == 3) {
                // 判断必填项
                var requiredFlag = false;
                $('#baseForm').find('.field_required').each(function () {
                    var field = $(this).attr('field');
                    if (field && !dataObj[field] && dataObj[field] != '0') {
                        var fieldName = $(this).parent().text().replace('*', '');
                        layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
                        requiredFlag = true;
                        return false;
                    }
                });

                if (requiredFlag) {
                    layer.close(loadIndex);
                    return false;
                }
            }
            if(reimburseType == "05"){
                var plbDeptContract={
                    contractMoney:dataObj.contractMoney,
                    contractName:dataObj.contractName,
                    contractNo:dataObj.contractNo,
                    naturePayment:dataObj.naturePayment,
                    merchantsUnitName:dataObj.merchantsUnitName,
                    paymentMoney:dataObj.paymentMoney
                }
                plbDeptContract.occupationBudget=$('[name="occupationBudget"]:checked').val();
                plbDeptContract.contractId=$('[name="contractNo"]').attr('contractId');
                dataObj.plbDeptContract=plbDeptContract;
            }else{
                dataObj.overStandard = $('[name="overStandard"]:checked', $('#baseForm')).val();
            }
            var baseObj = JSON.parse(JSON.stringify(dataObj));

            // 报销明细
            var reimbursementDetailsData = getReimbursementDetailsData(false);
            dataObj.plbDeptReimburseLists = reimbursementDetailsData.dataArr;

            //判断预算科目是否为空
            if(reimbursementDetailsData.dataArr !=''&&reimbursementDetailsData.dataArr!=undefined){
                for(var i=0;i<reimbursementDetailsData.dataArr.length;i++){
                    if(reimbursementDetailsData.dataArr[i].rbsItemId==''){
                        layer.msg('预算执行预算科目不能为空',{icon:0});
                        return false
                    }
                }
            }

            //预算核销
            if(reimburseType =='01'|| reimburseType=='03'){
                var whetherChargeMoneyVal=$('[name="whetherChargeMoney"]:checked',$('#baseForm')).val();
                if(whetherChargeMoneyVal == '1'){
                    //获取预付核销表表格
                    var reimbursementWriteData = getReimbursementWriteData(false);
                   dataObj.ChargemoneyList = reimbursementWriteData.dataArr;
                }else{
                    dataObj.ChargemoneyList = [];
                }
            }

            // 差旅报销单和休假报销单进行处理
            if (reimburseType == '01' || reimburseType == '02') {
                // 长途交通费明细
                var plbLongdistanceCostData = getPlbLongdistanceCosts();
                dataObj.plbLongdistanceCosts = plbLongdistanceCostData.dataArr;



                // 市内交通费明细
                var plbCityCostData = getPlbCityCosts();
                dataObj.plbCityCosts = plbCityCostData.dataArr;


                // 住宿费明细
                var plbStayCostData = getPlbStayCosts();
                dataObj.plbStayCosts = plbStayCostData.dataArr;
                if(plbStayCostData.dataArr.length>0){
                    for(var i=0;i<plbStayCostData.dataArr.length;i++){
                        var stayStartDate=new Date(plbStayCostData.dataArr[i].startDate);
                        if(stayStartDate>endDate){
                            layer.msg('住宿费日期错误,请重新选择',{icon:0});
                            return false
                        }
                    }
                }


                // 其他费用明细
                var plbOtherCostData = getPlbOtherCosts();
                dataObj.plbOtherCosts = plbOtherCostData.dataArr;

                // 补助明细
                var plbSubsidyData = getPlbSubsidyLists();
                dataObj.plbSubsidyLists = plbSubsidyData.dataArr;
                if(plbSubsidyData.dataArr.length>0){
                    var baseDayNum=(endDate-startDate)/86400000;
                    for(var i=0;i<plbSubsidyData.dataArr.length;i++){
                        var subStartDate=new Date(plbSubsidyData.dataArr[i].startDate||'0');
                        var subEndDate=new Date(plbSubsidyData.dataArr[i].endDate||'0');
                        if((subEndDate-subStartDate)/86400000>=0){
                            subDayNum=(subEndDate-subStartDate)/86400000
                        }else{
                            subDayNum=-1
                        }
                        //var subDayNum=(subEndDate-subStartDate)/86400000||'-1';
                        if(subDayNum==undefined||subDayNum<0||subDayNum>baseDayNum){
                            layer.msg('补助日期错误,请重新选择',{icon:0});
                            return false
                        }
                    }
                }

                if (saveType == 2 || type == 3) {
                    // 行程明细总额
                    var tripDetailTotal = checkFloatNum($('#amountIncludingTaxTotal').val());

                    // 判断报销明细总额 与 行程明细总额是否相等
                    if (!BigNumber(reimbursementDetailsData.amountTotal).eq(tripDetailTotal)) {
                        layer.close(loadIndex);
                        layer.msg('报销明细总额与行程明细总额不同！', {icon: 0});
                        return false;
                    }
                }
            }

            // 付款明细
            var paymentmentDetailsData = getPaymentmentDetailsData(false);
            dataObj.plbDeptPayments = paymentmentDetailsData.dataArr;

            if (saveType == 2 || type == 3) {

                if(reimburseType =='01'|| reimburseType =='03'){
                    var whetherChargeMoneyVal=$('[name="whetherChargeMoney"]:checked',$('#baseForm')).val();
                    if(whetherChargeMoneyVal==1){
                        var amountTotalRei=getReimbursementDetailsData(false).amountTotal
                        var amountTotalNhp=getReimbursementWriteData().amountTotal
                        var minusNum=BigNumber(amountTotalRei).minus(amountTotalNhp);
                        var payTotal=paymentmentDetailsData.amountTotal;//付款明细收款金额总额
                        var appTotal=0;//预算执行本次执行金额
                        for(var i=0;i<reimbursementDetailsData.dataArr.length;i++){
                            //appTotal+=Number(reimbursementDetailsData.dataArr[i].applicationAmount);
                            appTotal=Number(BigNumber(appTotal).plus(reimbursementDetailsData.dataArr[i].applicationAmount));
                        }
                        //判断预算执行本次执行金额总额是否等于(预算执行报销金额总额-预付核销本次冲账金额总额)
                        if(minusNum != appTotal){
                            layer.msg('预算执行本次执行金额总额与(预算执行报销金额总额减预付核销本次冲账金额总额)的值不同',{icon:0});
                            return false;
                        }



                        // 判断付款明细总额是否大于预算执行本次执行总额
                        if(payTotal != appTotal){
                            layer.msg('付款明细收款金额总额与预算执行本次执行总额不同',{icon:0});
                            return false;
                        }

                    }else{
                        // 判断付款明细总额是否大于报销明细总额
                        if (!BigNumber(reimbursementDetailsData.amountTotal).eq(paymentmentDetailsData.amountTotal)) {
                            layer.close(loadIndex);
                            layer.msg('付款明细收款金额总额与预算执行报销金额总额不同！', {icon: 0});
                            return false;
                        }
                    }
                }else if(reimburseType=='04'){
                    // 判断付款明细总额是否大于报销明细总额
                    var appNum=0;
                    $('[name="applicationAmount"]').each(function(){
                        //appNum+=Number($(this).val());
                        appNum=Number(BigNumber(appNum).plus($(this).val()));
                    })
                    if(appNum!=(paymentmentDetailsData.amountTotal)){
                        layer.close(loadIndex);
                        layer.msg('付款明细收款金额总额与预算执行报销金额总额不同！', {icon: 0});
                        return false;
                    }
                }
            }

            if (type != 1) { // 编辑
                dataObj.reimburseId = reimburseInfo.reimburseId;
            } else {
                dataObj.reimburseId = reimburseId;
            }

            return {
                dataObj: dataObj,
                baseObj: baseObj
            }
        }

        table.on('row(reimbursementDetailsTable)', function(obj){
            avtiveTd = $(this)
        });

        /**
         * 选择科目
         * @param deptId 费用承担部门id
         * @param type 1-多选，2-单选
         */
        function chooseItem(deptId, type,applicationAmountData, callback) {
            var okBtn = type == 2 ? '选择发票' : '确定'
            var budgetoccupy = 0;
            layer.open({
                type: 1,
                title: '',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">'+
                    '        <ul class="layui-tab-title" id="itemUl">\n' +
                    // '            <li id="asd" style="display: none">预算科目</li>\n' +
                    // '            <li id="zxc" style="display: none" >往来科目&nbsp&nbsp<span style="color: red">(非预付业务请选择往来科目)</span></li>\n' +
                    '        </ul>',
                    '</div>'+
                    '<table id="budgetLimitTable" lay-filter="budgetLimitTable"></table>',
                    '</div>'].join(''),
                success: function () {
                    var date=new Date();
                    var dateYear=date.getFullYear();
                    var naturePaymentVal=$('[name="naturePayment"]').val();
                    if(naturePaymentVal=='10'){
                        $('#itemUl').prepend(' <li id="asd" class="layui-this">预算科目</li>')
                        layTable.render({
                            elem: '#budgetLimitTable',
                            url: '/plbDeptBudgetItem/getBudgetItemDataByDeptId?budgetoccupy=0&versionNumber=1&year='+dateYear,
                            where: {
                                deptId: deptId
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
                                dataName: 'obj'
                            },
                            cols: [[
                                {type: type == 1 ? 'checkbox' : 'radio', title: '选择'},
                                {
                                    field: 'rbsItemName', title: '预算科目名称', templet: function (d) {
                                        return d.rbsItemName || '';
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
                    }else if(naturePaymentVal ==null||naturePaymentVal==undefined || naturePaymentVal==''){
                        $('#itemUl').prepend(' <li id="asd" class="layui-this">预算科目</li>')
                        layTable.render({
                            elem: '#budgetLimitTable',
                            url: '/plbDeptBudgetItem/getBudgetItemDataByDeptId?budgetoccupy=0&versionNumber=1&year='+dateYear,
                            where: {
                                deptId: deptId
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
                                dataName: 'obj'
                            },
                            cols: [[
                                {type: type == 1 ? 'checkbox' : 'radio', title: '选择'},
                                {
                                    field: 'rbsItemName', title: '预算科目名称', templet: function (d) {
                                        return d.rbsItemName || '';
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
                    }else{
                        $('#itemUl').prepend('  <li id="zxc" class="layui-this">往来科目&nbsp&nbsp<span style="color: red">(非预付业务请选择往来科目)</span></li>')
                        layTable.render({
                            elem: '#budgetLimitTable',
                            url: '/plbRbsItem/selectAll?budgetoccupy=1&versionNumber=1&year='+dateYear,
                            where: {
                                deptId: deptId
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
                                {type: type == 1 ? 'checkbox' : 'radio', title: '选择'},
                                {
                                    field: 'rbsItemNo', title: 'RBS编号', templet: function (d) {
                                        return d.rbsItemNo || '';
                                    }
                                },
                                {
                                    field: 'rbsItemName', title: 'RBS名称', templet: function (d) {
                                        return  d.rbsItemName ;
                                    }
                                },
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = layTable.checkStatus('budgetLimitTable');
                    if (checkStatus.data.length > 0) {
                        var checkData=checkStatus.data[0]
                        var budgetProj = checkStatus.data[0].plbMtlLibraryList;
                        if(budgetProj != ''&& budgetProj !=undefined){
                            if(budgetProj.length == 1){
                                avtiveTd.find('input[name="expenseItem"]').val(budgetProj[0].mtlName || '');
                                avtiveTd.find('input[name="expenseItem"]').attr('expenseItem',budgetProj[0].mtlLibId);
                                checkData.expenseItem=budgetProj[0].mtlLibId
                                layer.close(index);
                            }else{
                                layer.close(index);
                                layer.open({
                                    type: 1,
                                    title: '选择费用项目',
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
                                                {field: 'mtlNo', title: '编码', minWidth: 120, sort: true, hide: false},
                                                {field: 'mtlName', title: '名称', minWidth: 120, sort: true, hide: false},
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
                                            checkData.expenseItem=budgetProj[0].mtlLibId
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0});
                                        }
                                    }
                                });
                            }
                        }
                        if(reimburseType=='05'){
                            var reimbursementDetailsData = getReimbursementDetailsData(false);
                            if(reimbursementDetailsData.dataArr.length>1){
                                var checkCbsId=checkStatus.data[0].cbsId;
                                var detailsCbsId=reimbursementDetailsData.dataArr[0].cbsId;
                                if(checkCbsId != detailsCbsId){
                                    layer.msg('请选择同一预算科目',{icon:0});
                                    return
                                }
                            }
                        }
                        // if(checkStatus.data[0].controlType=='04'){
                        //     if (callback) {
                        //         callback(checkStatus.data)
                        //     }
                        //     layer.close(index);
                        // }else{
                        //     if(checkStatus.data[0].budgetBalance<=0){
                        //         layer.msg('年度预算余额小于等于0，请重新选择！', {icon: 0});
                        //         return;
                        //     }
                        //     if(applicationAmountData){
                        //         if(applicationAmountData<=checkStatus.data[0].budgetBalance){
                        //             if (callback) {
                        //                 callback(checkStatus.data)
                        //             }
                        //
                        //             layer.close(index);
                        //         }else{
                        //             if(reimburseType=='05'){
                        //                 layer.msg('本次支付金额大于年度预算余额，请重新选择！', {icon: 0});
                        //                 return;
                        //             }else{
                        //                 layer.msg('报销金额大于年度预算余额，请重新选择！', {icon: 0});
                        //                 return;
                        //             }
                        //         }
                        //     }else{
                        //         if (callback) {
                        //             callback(checkStatus.data)
                        //         }
                        //
                        //         layer.close(index);
                        //     }
                        // }
                        if (callback) {
                            callback(checkData)
                        }

                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        }
    });
}

/**
 * 新增、编辑保存报销单
 * @param url
 * @param data
 */
function updateReimburse(url, data, callback) {
    $.ajax({
        url: url,
        data: data,
        dataType: 'json',
        contentType: "application/json;charset=UTF-8",
        type: 'post',
        success: function (res) {
            if (callback) {
                callback(res);
            }
        }
    });
}

/**
 * 获取提交时表单数据
 * @param baseObj
 * @return newData {}
 */
function getSubmitData(baseObj) {
    var newData = JSON.parse(JSON.stringify(baseObj));
    newData.createUser = $('#baseForm [name="createUser"]').val(); // 经办人
    newData.reimburseUser = $('#baseForm [name="reimburseUser"]').val(); // 报销人
    var deptName = ''; // 所属部门
    deptName = $('[name="reimburseBelongDept"]', $('#baseForm')).next().find('input').val();
    var nameArr = deptName.split(/\//);
    deptName = nameArr[nameArr.length - 1];
    newData.reimburseBelongDept = newData.reimburseBelongDept + ',|' + deptName + ',';
    if(reimburseType=='05'){
        // newData.reimburseBelongDept =deptName;
        //是否预付
        newData.whetherBudget = newData.whetherBudget == '1' ? '是' : '否';
        //本次支付金额
        newData.paymentMoney=newData.plbDeptContract[0].paymentMoney;
        //客商单位名称
        newData.merchantsUnitName=$('[name="merchantsUnitName"]', $('#baseForm')).val();
    }
    // 差旅类型
    if (newData.travelType) {
        newData.travelType = dictionaryObj['TRAVEL_TYPE']['object'][newData.travelType] || '';
    }
    // 是否超标
    newData.overStandard = newData.overStandard == '1' ? '是' : '否';

    // 是否分摊
    newData.ifShare = newData.ifShare == '1' ? '是' : '否';

    //发起类型
    newData.launchType=$('[name="launchType"]', $('#baseForm')).next().find('input').val();

    // 遍历预算执行表格获取每行数据
    var $trs = $('#reimbursementDetailsModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var dataObj = {
            expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
            itemName: $(this).find('input[name="deptItemId"]').val(), // 预算科目
            reimburseUser: $(this).find('input[name="reimburseUser"]').val(), // 报销人
            reimburseBelongDept: $(this).find('input[name="reimburseBelongDept"]').val(), // 所属部门
            budgetMoney: $(this).find('.budgetMoney').text(), // 年度预算总额
            budgetBalance: $(this).find('.budgetBalance').text(), // 年度预算余额
            reimbursementAmount: $(this).find('input[name="reimbursementAmount"]').val(), // 报销金额
            taxAmount: $(this).find('input[name="taxAmount"]').val(), // 税额
            amountExcludingTax: $(this).find('.amountExcludingTax').text(), // 不含税金额
            deptName: $(this).find('input[name="deptId"]').val(), // 费用承担部门
            itemDesc: $(this).find('input[name="itemDesc"]').val(), // 事项说明
            vehicleFile: $(this).find('input[name="vehicleFile"]').val() // 事项说明


        }
        if(reimburseType=='05'||reimburseType=='04'){
            dataObj.applicationAmount=$(this).find('input[name="applicationAmount"]').val();//资金支付-本次支付金额/限额费用-报销金额
        }
        var str = '';
        if (reimburseType == '04') {
            str = dataObj.reimburseUser + '`' + dataObj.reimburseBelongDept + '`' + dataObj.itemName + '`' + numFormat(dataObj.budgetMoney) + '`' + numFormat(dataObj.budgetBalance) + '`' + numFormat(dataObj.applicationAmount) + '`' + numFormat(dataObj.taxAmount) + '`' + numFormat(dataObj.amountExcludingTax) + '`' + dataObj.deptName + '`' + dataObj.itemDesc + '`';
        }else if(reimburseType =='05'){
            str = dataObj.itemName + '`' + numFormat(dataObj.budgetMoney) + '`' + numFormat(dataObj.budgetBalance) + '`' + numFormat(dataObj.applicationAmount) + '`' + dataObj.deptName + '`' + dataObj.itemDesc + '`';
        }else {
            str = dataObj.itemName + '`' + numFormat(dataObj.budgetMoney) + '`' + numFormat(dataObj.budgetBalance) + '`' + numFormat(dataObj.reimbursementAmount) + '`' + numFormat(dataObj.taxAmount) + '`' + numFormat(dataObj.amountExcludingTax) + '`' + dataObj.deptName + '`' + dataObj.itemDesc + '`';
        }
        dataArr.push(str);
    });
    var reimbursementDetails = dataArr.join('\r\n');
    if (reimburseType == '04') {
        reimbursementDetails += '|`````````';
    } else {
        reimbursementDetails += '|```````';
    }
    newData.reimbursementDetails = reimbursementDetails;

    // 遍历付款明细表格获取每行数据
    var $trs2 = $('#paymentDetailsModule').find('.layui-table-main tr');
    var paymentDataArr = [];
    $trs2.each(function () {
        var dataObj = {
            paymentType: $(this).find('input[name="paymentType"]').val(), // 付款方式
            collectionUser: $(this).find('input[name="collectionUser"]').val(), // 收款人
            collectionAccount: $(this).find('input[name="collectionAccount"]').val(), // 银行账号
            collectionBank:  $(this).find('input[name="collectionBank"]').val(), // 开户行
            collectionMoney: $(this).find('input[name="collectionMoney"]').val(), // 收款金额
            remarks: $(this).find('input[name="remarks"]').val() // 备注
        }
        var str = dataObj.paymentType + '`' + dataObj.collectionUser + '`' + dataObj.collectionAccount + '`' + dataObj.collectionBank + '`' + numFormat(dataObj.collectionMoney) + '`' + dataObj.remarks + '`';
        paymentDataArr.push(str);
    });
    var paymentDetails = paymentDataArr.join('\r\n');
    paymentDetails += '|`````';
    newData.paymentDetails = paymentDetails;

    if (reimburseType == '01' || reimburseType == '02') {
        newData.longDistanceCostTotal = numFormat($('#longDistanceCostTotal').val()); // 长途交通费合计
        newData.stayCostsTotal = numFormat($('#stayCostsTotal').val()); // 住宿费用合计
        newData.cityCostTotal = numFormat($('#cityCostTotal').val()); // 市内交通费合计
        newData.otherCostTotal = numFormat($('#otherCostTotal').val()); // 其他费用合计
        newData.subsidyAmountTotal = numFormat($('#subsidyAmountTotal').val()); // 补助费用合计
        newData.adjustAmountTotal = numFormat($('#adjustAmountTotal').val()); // 会计调整合计
        newData.amountIncludingTaxTotal = numFormat($('#amountIncludingTaxTotal').val()); // 报销金额合计(含税)
        newData.taxAmountTotal = numFormat($('#taxAmountTotal').val()); // 税额合计
        newData.anountExcludingTaxTotal = numFormat($('#anountExcludingTaxTotal').val()); // 报销金额合计(不含税)
    }

    return newData;
}

// 预算执行上传发票
$(document).on('click', '.choose_invoices', function () {
    var $this = $(this)
    var $ele = $(this).prev();
    var reimburseNo = $('input[name="reimburseNo"]', $('#baseForm')).val();
    openPwyWeb(reimburseId, reimburseNo, reimburseType, $ele, function (data) {
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
        $tr.find('.KD_amount').text(amount);

        $('[name="reimburseTotal"]', $('#baseForm')).val(getReimbursementDetailsData(false).amountTotal);
    });
});

// 选择部门
$(document).on('click', '.choose_dept', function () {
    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
        return false;
    }
    dept_id = $(this).attr('id');
    $.popWindow('/common/selectDept?0');
});

// 选人
$(document).on('click', '.choose_user', function () {
    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
        return false;
    }
    user_id = $(this).attr('id');
    $.popWindow('/common/selectUser?0');
});


//冲账后预付款金额计算
$(document).on('blur','#nhPrepaymentAmount',function(){
        var nhpVal=$(this).val();
        var budVal= $(this).parent().parent().parent().find('input[name="budgetAmount"]').val();
        var rebVal=$(this).parent().parent().parent().find('input[name="rebateAmount"]').val();
        if(budVal!=undefined&&budVal!=''&&rebVal!=undefined&&rebVal!=''){
            $(this).parent().parent().parent().find('input[name="hxPrepaymentAmount"]').val((budVal-rebVal-nhpVal))
        }
})


//合同信息选择客商单位名称
$(document).on('click','#merchantsUnitName',function(){
    var $that=$(this)
    layui.layer.open({
        type: 2,
        title: '选择收款人',
        area: ['80%', '80%'],
        maxmin: true,
        btnAlign: 'c',
        btn: ['确定'],
        content: ['/PlbCustomer/payee'].join(''),
        yes: function (index,layero) {
            var checkData=$(layero).find("iframe")[0].contentWindow.determineBtn();
            if(checkData !=undefined){
                if(checkData.length>0){
                    if(checkData[0].auditerStatus!='2'){
                        layer.msg('该客商未批准，请进行审批',{icon:0})
                        return;
                    }
                    if(checkData[0].plbCustomerBankList.length>0){
                        $that.attr('collectionAccount',(checkData[0].plbCustomerBankList[0].bankAccount));
                        $that.attr('collectionBank',checkData[0].plbCustomerBankList[0].bankOfDepositName);
                        $that.attr('collectionbankNo',checkData[0].plbCustomerBankList[0].bankOfDeposit);
                        $('[name="collectionAccount"]').val(checkData[0].plbCustomerBankList[0].bankAccount);
                        $('[name="collectionBank"]').val(checkData[0].plbCustomerBankList[0].bankOfDepositName);
                        $('[name="collectionBank"]').attr('collectionBankNo',checkData[0].plbCustomerBankList[0].bankOfDeposit);
                    }else{
                        layer.msg('该客商没有银行账号和开户行,请重新选择',{icon:0})
                        return
                    }
                   $that.val(checkData[0].customerName);
                   $that.attr('customerid',checkData[0].customerId);
                   $('[name="collectionUser"]').val(checkData[0].customerName);
                   $('[name="collectionUser"]').attr('customerId',checkData[0].customerId);
                   $('[name="collectionUser"]').attr('userType','2');
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
        content: ['/plbDeptSubcontract/newDeptContract  '].join(''),
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

//差旅 个人报销单预算执行报销金额
$(document).on('blur','[name="reimbursementAmount"]',function () {
    var whetherChargeMoney=$('[name="whetherChargeMoney"]:checked').val();
    if(whetherChargeMoney=='1'){
        var amountTotalNhp=getReimbursementWriteData().amountTotal;
        var amountTotalRei=getReimbursementDetailsData(false).amountTotal;
        var reimbursementDetailsData = getReimbursementDetailsData(true);
        if((amountTotalRei-amountTotalNhp)>=0){
            reimbursementDetailsData.dataArr[0].applicationAmount=BigNumber(amountTotalRei).minus(amountTotalNhp);
        }else{
            reimbursementDetailsData.dataArr[0].applicationAmount='0';
        }
        layui.table.reload('reimbursementDetailsTable',{
            data:reimbursementDetailsData.dataArr
        })

    }
})

//冲账选择是下面的本次执行金额监听value变化
$(document).on('input propertychange','[name="applicationAmount"]',function(){
    var $tr=$(this).parents('tr');
    var $that=$(this);
    var relVal=$tr.find('[name="reimbursementAmount"]').val();
    if(relVal=='0'){
        $that.val('0');
    }
})

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
                if (res.object.userExt.bankDeposit) {
                    $tr.find('input[name="collectionBank"]').val(res.object.userExt.bankDepositName);
                    $tr.find('input[name="collectionBank"]').attr('collectionBankNo',res.object.userExt.bankDeposit)
                } else {
                    $tr.find('input[name="collectionBank"]').removeAttr('collectionBankNo');
                    $tr.find('input[name="collectionBank"]').val('');
                }

            }
        });
    }
}

/**
 * 选部门完成回调
 * @param deptId 部门id
 */
function cbCallBack(deptId) {
    if ($('#' + dept_id).attr('name') == 'deptId') {
        var $tr = $('#' + dept_id).parents('tr');
        $tr.find('[name="deptItemId"]').val('').attr('rbsitemid', '').attr('cbsid', '');
        $tr.find('.budgetMoney').text('');
        $tr.find('.budgetBalance').text('');
    }
}

/**
 * 输入框改变后回调函数
 * @param value (改变后的值)
 * @param ele (dom元素)
 */
function afterFloatChange(value, ele) {
    var $ele = $(ele);

    var floatType = $ele.attr('floatType') || '';

    if (floatType) {
        switch (floatType) {
            case 'RD_reimbursementAmount': // 预算执行-报销金额
                var $tr = $ele.parents('tr');
                var budgetBalance = checkFloatNum($tr.find('.budgetBalance').text());
                // if (BigNumber(budgetBalance).lt(0)) {
                //     value = 0;
                //     $ele.val(value);
                // } else if (BigNumber(budgetBalance).lt(value)) {
                //     value = budgetBalance;
                //     $ele.val(value);
                // }
                var taxAmount = checkFloatNum($tr.find('input[name="taxAmount"]').val());
                var amountExcludingTax = BigNumber(value).minus(taxAmount);
                $tr.find('.amountExcludingTax').text(amountExcludingTax);
                var whetherChargeMoney=$('[name="whetherChargeMoney"]:checked').val();
                if(whetherChargeMoney=='0'){
                    $tr.find('.applicationAmount').text(value);
                }
                $('[name="reimburseTotal"]', $('#baseForm')).val(getReimbursementDetailsData(false).amountTotal);
                break;
            case 'RD_taxAmount': // 预算执行-税额
                var $tr = $ele.parents('tr');
                var applicationAmount = checkFloatNum($tr.find('input[name="reimbursementAmount"]').val());
                if(reimburseType=='04'){
                    applicationAmount=checkFloatNum($tr.find('input[name="applicationAmount"]').val());
                }
                var amountExcludingTax = BigNumber(applicationAmount).minus(value);
                $tr.find('.amountExcludingTax').text(amountExcludingTax);
                break;
            case 'LD_amount': // 长途交通费-报销金额
                var $parent = $ele.parents('tr');
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var adjustAmount = checkFloatNum($parent.find('input[name="adjustAmount"]').val()); // 会计调整金额
                var afterChangeAmount = BigNumber(value).plus(adjustAmount); // 调整后金额 (报销金额 + 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'LD_taxAmount': // 长途交通费-税额
                var $parent = $ele.parents('tr');
                // var amount = checkFloatNum($parent.find('input[name="amount"]').val()); // 报销金额
                var afterChangeAmount = checkFloatNum($parent.find('.afterChangeAmount').text()); // 调整后金额
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(value); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'LD_adjustAmount': // 长途交通费-会计调整金额
                var $parent = $ele.parents('tr');
                var amount = checkFloatNum($parent.find('input[name="amount"]').val()); // 报销金额
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var afterChangeAmount = BigNumber(amount).plus(value); // 调整后金额 (报销金额 + 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'CC_amount': // 市内交通费-报销金额
                var $parent = $ele.parents('tr');
                var adjustAmount = checkFloatNum($parent.find('input[name="adjustAmount"]').val()); // 会计调整金额
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var afterChangeAmount = BigNumber(value).plus(adjustAmount); // 调整后金额 (报销金额 + 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'CC_taxAmount': // 市内交通费-税额
                var $parent = $ele.parents('tr');
                var afterChangeAmount = checkFloatNum($parent.find('.afterChangeAmount').text()); // 调整后金额
                // var amount = checkFloatNum($parent.find('input[name="amount"]').val()); // 报销金额
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(value); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'CC_adjustAmount': // 市内交通费-会计调整金额
                var $parent = $ele.parents('tr');
                var amount = checkFloatNum($parent.find('input[name="amount"]').val()); // 报销金额
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var afterChangeAmount = BigNumber(amount).plus(value); // 调整后金额 (报销金额 + 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'SC_amountIncludingTax': // 住宿费-报销金额
                var $parent = $ele.parents('tr');
                var adjustAmount = checkFloatNum($parent.find('input[name="adjustAmount"]').val()); // 会计调整金额
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var afterChangeAmount = BigNumber(value).plus(adjustAmount); // 调整后金额 (报销金额 + 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(BigNumber(value).minus(taxAmount));
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'SC_taxAmount': // 住宿费明细-税额
                var $parent = $ele.parents('tr');
                // var amountIncludingTax = checkFloatNum($parent.find('input[name="amountIncludingTax"]').val()); // 报销金额
                var afterChangeAmount = checkFloatNum($parent.find('.afterChangeAmount').text()); // 调整后金额
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(value); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'SC_adjustAmount': // 住宿费明细-会计调整金额
                var $parent = $ele.parents('tr');
                var amount = checkFloatNum($parent.find('input[name="amountIncludingTax"]').val()); // 报销金额
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var afterChangeAmount = BigNumber(amount).plus(value); // 调整后金额 (报销金额 + 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'OC_amountIncludingTax': // 其他费明细-含税金额
                var $parent = $ele.parents('tr');
                var adjustAmount = checkFloatNum($parent.find('input[name="adjustAmount"]').val()); // 会计调整金额
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var afterChangeAmount = BigNumber(value).plus(adjustAmount); // 调整后金额 (报销金额 - 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'OC_taxAmount': // 其他费明细-税额
                var $parent = $ele.parents('tr');
                // var amountIncludingTax = checkFloatNum($parent.find('input[name="amountIncludingTax"]').val()); // 报销金额
                var afterChangeAmount = checkFloatNum($parent.find('.afterChangeAmount').text()); // 调整后金额
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(value); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'OC_adjustAmount': // 其他费明细-会计调整金额
                var $parent = $ele.parents('tr');
                var amount = checkFloatNum($parent.find('input[name="amountIncludingTax"]').val()); // 报销金额
                var taxAmount = checkFloatNum($parent.find('input[name="taxAmount"]').val()); // 税额
                var afterChangeAmount = BigNumber(amount).plus(value); // 调整后金额 (报销金额 + 会计调整金额)
                var amountExcludingTax = BigNumber(afterChangeAmount).minus(taxAmount); // 不含税金额 (调整后金额 - 税额)
                $parent.find('.afterChangeAmount').text(afterChangeAmount);
                $parent.find('.amountExcludingTax').text(amountExcludingTax);
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'S_adjustAmount': // 补助明细-会计调整金额
                // 重新计算调整后补助金额
                var $parent = $ele.parents('tr');
                var subsidyAmount = checkFloatNum($parent.find('.subsidyAmount').text());
                $parent.find('.afterChangeAmount').text(BigNumber(subsidyAmount).plus(value));
                // 重新汇总
                getTripDetailTotal();
                break;
            case 'RD_nhPrepaymentAmount': //预付核销-本次冲账金额
                var $parent = $ele.parents('tr');
                var reiBurNum=$parent.find('input[name="totalReimbursement"]').val();
                if (BigNumber(reiBurNum).lt(0)) {
                    value = 0;
                    $ele.val(value);
                } else if (BigNumber(reiBurNum).lt(value)) {
                    value = reiBurNum;
                    $ele.val(value);
                }
                //计算本次执行金额=预算执行报销金额总额-预付核销本次冲账金额总额
                var amountTotalRei=getReimbursementDetailsData(false).amountTotal
                var amountTotalNhp=getReimbursementWriteData().amountTotal
                var reimbursementDetailsData = getReimbursementDetailsData(true);
                if(reimbursementDetailsData.dataArr !=''&& reimbursementDetailsData.dataArr !=undefined){
                    if((amountTotalRei-amountTotalNhp)>=0){
                        reimbursementDetailsData.dataArr[0].applicationAmount=BigNumber(amountTotalRei).minus(amountTotalNhp);
                    }else{
                        reimbursementDetailsData.dataArr[0].applicationAmount='0';
                    }
                    layui.table.reload('reimbursementDetailsTable',{
                        data:reimbursementDetailsData.dataArr
                    })
                }
                break;
            case 'RD_totalReimbursement':  //预付核销-本次报销金额
                var $parent = $ele.parents('tr');
                var npNum=$parent.find('input[name="nhPrepaymentAmount"]').val();
                if(BigNumber(value).lt(npNum)){
                    value = npNum;
                    $ele.val(value);
                }
                break;
            case 'RD_applicationAmount': //限额费用 预算执行-报销金额
                var $tr = $ele.parents('tr');
                var budgetBalance = checkFloatNum($tr.find('.budgetBalance').text());
                // if (BigNumber(budgetBalance).lt(0)) {
                //     value = 0;
                //     $ele.val(value);
                // } else if (BigNumber(budgetBalance).lt(value)) {
                //     value = budgetBalance;
                //     $ele.val(value);
                // }
                var appNum=0;
                $('[name="applicationAmount"]').each(function(){
                    // appNum+=Number($(this).val());
                    appNum=BigNumber(appNum).plus($(this).val())
                })
                var taxAmount = checkFloatNum($tr.find('input[name="taxAmount"]').val());
                var amountExcludingTax = BigNumber(value).minus(taxAmount);
                $tr.find('.amountExcludingTax').text(amountExcludingTax);
                $('[name="reimburseTotal"]', $('#baseForm')).val(appNum);
                break;
            case 'RD_paymentAmount':
                //合同信息 本次支付金额
                // var naturePaymentVal=$('[name="naturePayment"]').val();
                var $tr = $ele.parents('tr');
                // var budgetBalance = checkFloatNum($tr.find('.budgetBalance').text());
                // if(naturePaymentVal =='10'){
                //     if (BigNumber(budgetBalance).lt(0)) {
                //         value = 0;
                //         $ele.val(value);
                //     } else if (BigNumber(budgetBalance).lt(value)) {
                //         value = budgetBalance;
                //         $ele.val(value);
                //     }
                // }
                var payTotal=0;
                $('[name="applicationAmount"]').each(function(){
                    //payTotal+=Number($(this).val())
                    payTotal=Number(BigNumber(payTotal).plus($(this).val()||'0'));
                })
                // if(budgetBalance !=0){
                //     if(payTotal>budgetBalance){
                //         payTotal=budgetBalance
                //     }
                // }
                $('[name="reimburseTotal"]', $('#baseForm')).val(payTotal);  // 基本信息报销金额
                $('[name="paymentMoney"]', $('#baseForm')).val(payTotal); //合同信息本次支付金额
                $('#paymentMoneyStr').val(number_chinese(payTotal)); //合同信息本次支付金额(大写)
                var paymentmentDetailsData = getPaymentmentDetailsData(true);
                if(paymentmentDetailsData.dataArr.length!=''&&paymentmentDetailsData.dataArr!=undefined){
                    paymentmentDetailsData.dataArr[0].collectionMoney=payTotal;
                    layui.table.reload('paymentDetailsTable',{
                        data:paymentmentDetailsData.dataArr
                    })
                }
                break;
            default:
                break;
        }
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

/***
 * 计算天数
 * @param beginTime (开始时间)
 * @param endTime (结束时间)
 * @returns {number}
 */
function getDays(beginTime, endTime) {
    var t1 = new Date(beginTime);
    var t2 = new Date(endTime);
    var time = t2.getTime() - t1.getTime();
    var days = Math.ceil(time / (1000 * 60 * 60 * 24)) + 1;
    return days;
}

/**
 * 获取预算核销明细数据
 * @param isEdit
 */

function getReimbursementWriteData(isEdit){
    //本次冲账金额总额
    var amountTotal = 0;
    var $trs = $('#reimbursementWriteModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function(){
        var dataObj={
            contractId:$(this).find('input[name="merchantsUnitName"]').attr('contractId') || '',
            chargemoneyId:$(this).find('input[name="merchantsUnitName"]').attr('chargemoneyId')||'',
            merchantsUnitName:$(this).find('input[name="merchantsUnitName"]').val()||'',
            reimburseNo:$(this).find('input[name="reimburseNo"]').val()||'',
            rbsItemId:$(this).find('input[name="reimburseNo"]').attr('rbsItemId')||'',
            capitalReimburseId:$(this).find('input[name="reimburseNo"]').attr('capitalReimburseId') || '',
            expenseItem:$(this).find('input[name="reimburseNo"]').attr('expenseItem') || '',
            reimburseId:$(this).find('input[name="reimburseNo"]').attr('reimburseId') || '',
            budgetAmount:$(this).find('input[name="budgetAmount"]').val() || '',
            rebateAmount:$(this).find('input[name="rebateAmount"]').val() || '',
            totalReimbursement:$(this).find('input[name="totalReimbursement"]').val() || '',
            nhPrepaymentAmount:$(this).find('input[name="nhPrepaymentAmount"]').val() || '',
            hxPrepaymentAmount:$(this).find('input[name="hxPrepaymentAmount"]').val()|| '',
            memo:$(this).find('input[name="memo"]').val() || '',
        }
        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.nhPrepaymentAmount)).toNumber();
        dataArr.push(dataObj);
    })
    return {
        dataArr:dataArr,
        amountTotal:amountTotal
    }
}
/**
 * 获取报销明细数据
 * @param isEdit (是否编辑)
 * @returns {{dataArr: *[], amountTotal: number}}
 */
function getReimbursementDetailsData(isEdit) {
    var whetherChargeMoney=$('[name="whetherChargeMoney"]:checked').val();
    // 报销金额总额
    var amountTotal = 0;
    //遍历表格获取每行数据
    var $trs = $('#reimbursementDetailsModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var listId = $(this).find('input[name="deptItemId"]').attr('listId') || '';
        var dataObj = {
            expenseItem: $(this).find('input[name="expenseItem"]').attr('expenseItem'), // 费用项目
            expenseItemName: $(this).find('input[name="expenseItem"]').val(),
            rbsItemId: $(this).find('input[name="deptItemId"]').attr('rbsItemId') || '',
            rbsId: $(this).find('input[name="deptItemId"]').attr('rbsId') || '',
            cbsId: $(this).find('input[name="deptItemId"]').attr('cbsId') || '',
            reimbursementAmount:$(this).find('input[name="reimbursementAmount"]').val(),
            taxAmount: $(this).find('input[name="taxAmount"]').val()||'',
            amountExcludingTax: $(this).find('.amountExcludingTax').text()||'',
            deptId: ($(this).find('input[name="deptId"]').attr('deptId') || '').replace(/,$/, ''),
            itemDesc: $(this).find('input[name="itemDesc"]').val(),
            vehicleFile: $(this).find('input[name="vehicleFile"]').val(),
            planTaskId: $(this).find('.planTaskId').attr('planTaskId'),
            taxRate: $(this).find('input[name="taxAmount"]').attr('taxRate') || 0
        }
        if (reimburseType == '04' ) {
            dataObj.reimburseUser = ($(this).find('input[name="reimburseUser"]').attr('user_id') || '').replace(/,$/, '');
            dataObj.reimburseBelongDept = ($(this).find('input[name="reimburseBelongDept"]').attr('dept_id') || '').replace(/,$/, '');
            dataObj.reimbursementAmount=$(this).find('input[name="applicationAmount"]').val();
        }
        if (reimburseType == '04'|| reimburseType == '05'||whetherChargeMoney=='1') {
            dataObj.applicationAmount=$(this).find('input[name="applicationAmount"]').val()
        }else{
            dataObj.applicationAmount=$(this).find('.applicationAmount').text()
        }
        if( reimburseType == '05'){
            dataObj.taxAmount=0
            dataObj.amountExcludingTax=dataObj.applicationAmount
            dataObj.applicationAmountOriginal=dataObj.applicationAmount
            dataObj.reimbursementAmount=dataObj.applicationAmount
        }
        if (reimburseType != '01' && reimburseType != '02') {
            var invoiceNos = '';
            var invoiceNoStr = '';
            $(this).find('.invoices_box span').each(function (i, v) {
                invoiceNos += $(v).attr('fid') + ',';
                invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
            });
            dataObj.invoiceNos = invoiceNos;
            dataObj.invoiceNoStr = invoiceNoStr;
        }

        if (listId) {
            dataObj.listId = listId;
        }

        if (isEdit) {
            dataObj.itemName = $(this).find('input[name="deptItemId"]').val();
            dataObj.budgetMoney = $(this).find('.budgetMoney').text();
            dataObj.budgetBalance = $(this).find('.budgetBalance').text();
            dataObj.deptName = $(this).find('input[name="deptId"]').val();
            dataObj.planTaskName = $(this).find('.planTaskId').text()

            if (reimburseType == '04') {
                dataObj.reimburseUserName = $(this).find('input[name="reimburseUser"]').val();
                dataObj.reimburseBelongDeptName = $(this).find('input[name="reimburseBelongDept"]').val();
            }
        }
        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.reimbursementAmount)).toNumber();
        dataArr.push(dataObj);
    });

    return {
        dataArr: dataArr,
        amountTotal: amountTotal
    }
}

/**
 * 获取长途交通费明细数据
 * @returns {{dataArr: *[], amountTotal: number, taxAmountTotal: number}}
 */
function getPlbLongdistanceCosts() {
    var amountTotal = 0; // 含税总额
    var taxAmountTotal = 0; // 税额总额
    var adjustAmountTotal = 0; // 会计调整金额总额
    // 遍历表格获取每行数据
    var $trs = $('#longDistanceTableModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var costId = $(this).find('input[name="vehicle"]').attr('costId') || '';
        var dataObj = {
            vehicle: $(this).find('input[name="vehicle"]').attr('vehicle') || '',
            rideStandard: $(this).find('.rideStandard').attr('rideStandard') || '',
            useDate: $(this).find('input[name="useDate"]').val(),
            leavePlace: $(this).find('input[name="leavePlace"]').val(),
            destination: $(this).find('input[name="destination"]').val(),
            amount: isPreview == '1' ? $(this).find('.amount').text() : $(this).find('input[name="amount"]').val(),
            taxAmount: isPreview == '1' ? $(this).find('.taxAmount').text() : $(this).find('input[name="taxAmount"]').val(),
            taxRate: $(this).find('input[name="taxAmount"]').attr('taxRate') || 0,
            amountExcludingTax: $(this).find('.amountExcludingTax').text(),
            adjustAmount: isPreview == '1' ? $(this).find('.adjustAmount').text() : $(this).find('input[name="adjustAmount"]').val(),
            afterChangeAmount: $(this).find('.afterChangeAmount').text(),
            remark: $(this).find('input[name="remark"]').val()
        }

        var invoiceNos = '';
        var invoiceNoStr = '';
        $(this).find('.invoices_box span').each(function (i, v) {
            invoiceNos += $(v).attr('fid') + ',';
            invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
        });
        dataObj.invoiceNos = invoiceNos;
        dataObj.invoiceNoStr = invoiceNoStr;

        if (costId) {
            dataObj.costId = costId;
        }

        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.amount)).toNumber();
        taxAmountTotal = BigNumber(taxAmountTotal).plus(checkFloatNum(dataObj.taxAmount)).toNumber();
        adjustAmountTotal = BigNumber(adjustAmountTotal).plus(checkFloatNum(dataObj.adjustAmount)).toNumber();
        dataArr.push(dataObj);
    });

    return {
        dataArr: dataArr,
        amountTotal: amountTotal,
        taxAmountTotal: taxAmountTotal,
        adjustAmountTotal: adjustAmountTotal
    }
}

/**
 * 获取市内交通费明细数据
 * @returns {{dataArr: *[], amountTotal: number, taxAmountTotal: number}}
 */
function getPlbCityCosts() {
    var amountTotal = 0; // 含税总额
    var taxAmountTotal = 0; // 税额总额
    var adjustAmountTotal = 0; // 会计调整金额总额
    //遍历表格获取每行数据
    var $trs = $('#cityCostTableModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var cityCostId = $(this).find('input[name="cityCostType"]').attr('cityCostId') || '';
        var dataObj = {
            cityCostType: $(this).find('input[name="cityCostType"]').attr('cityCostType') || '',
            invoiceType: $(this).find('input[name="invoiceType"]').attr('invoiceType') || '',
            useDate: $(this).find('input[name="useDate"]').val(),
            amount: isPreview == '1' ? $(this).find('.amount').text() : $(this).find('input[name="amount"]').val(),
            taxAmount: isPreview == '1' ? $(this).find('.taxAmount').text() : $(this).find('input[name="taxAmount"]').val(),
            taxRate: $(this).find('input[name="taxAmount"]').attr('taxRate') || 0,
            amountExcludingTax: $(this).find('.amountExcludingTax').text(),
            adjustAmount: isPreview == '1' ? $(this).find('.adjustAmount').text() : $(this).find('input[name="adjustAmount"]').val(),
            afterChangeAmount: $(this).find('.afterChangeAmount').text(),
            remark: $(this).find('input[name="remark"]').val()
        }

        var invoiceNos = '';
        var invoiceNoStr = '';
        $(this).find('.invoices_box span').each(function (i, v) {
            invoiceNos += $(v).attr('fid') + ',';
            invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
        });
        dataObj.invoiceNos = invoiceNos;
        dataObj.invoiceNoStr = invoiceNoStr;

        if (cityCostId) {
            dataObj.cityCostId = cityCostId;
        }

        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.amount)).toNumber();
        taxAmountTotal = BigNumber(taxAmountTotal).plus(checkFloatNum(dataObj.taxAmount)).toNumber();
        adjustAmountTotal = BigNumber(adjustAmountTotal).plus(checkFloatNum(dataObj.adjustAmount)).toNumber();
        dataArr.push(dataObj);
    });

    return {
        dataArr: dataArr,
        amountTotal: amountTotal,
        taxAmountTotal: taxAmountTotal,
        adjustAmountTotal: adjustAmountTotal
    }
}

/**
 * 获取住宿费明细数据
 * @returns {{dataArr: *[], amountTotal: number, taxAmountTotal: number}}
 */
function getPlbStayCosts() {
    var amountTotal = 0; // 含税总额
    var taxAmountTotal = 0; // 税额总额
    var adjustAmountTotal = 0; // 会计调整金额总额
    // 遍历表格获取每行数据
    var $trs = $('#stayCostTableModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var stayDate = ($(this).find('input[name="stayDate"]').val() || '').replace(/\s/g, '');
        var startDate = '';
        var endDate = '';
        if (stayDate) {
            startDate = stayDate.split('|')[0];
            endDate = stayDate.split('|')[1];
        }
        var stayCostId = $(this).find('input[name="stayPlace"]').attr('stayCostId') || '';

        var dataObj = {
            stayPlace: $(this).find('input[name="stayPlace"]').val(),
            startDate: startDate,
            endDate: endDate,
            stayDays: $(this).find('.stayDays').text(),
            stayStandard: $(this).find('.stayStandard').text(),
            invoiceType: $(this).find('input[name="invoiceType"]').attr('invoiceType') || '',
            amountIncludingTax: isPreview == '1' ? $(this).find('.amountIncludingTax').text() : $(this).find('input[name="amountIncludingTax"]').val(),
            taxAmount: isPreview == '1' ? $(this).find('.taxAmount').text() : $(this).find('input[name="taxAmount"]').val(),
            taxRate: $(this).find('input[name="taxAmount"]').attr('taxRate') || 0,
            amountExcludingTax: $(this).find('.amountExcludingTax').text(),
            adjustAmount: isPreview == '1' ? $(this).find('.adjustAmount').text() : $(this).find('input[name="adjustAmount"]').val(),
            afterChangeAmount: $(this).find('.afterChangeAmount').text(),
            remark: $(this).find('input[name="remark"]').val()
        }

        var invoiceNos = '';
        var invoiceNoStr = '';
        $(this).find('.invoices_box span').each(function (i, v) {
            invoiceNos += $(v).attr('fid') + ',';
            invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
        });
        dataObj.invoiceNos = invoiceNos;
        dataObj.invoiceNoStr = invoiceNoStr;

        if (stayCostId) {
            dataObj.stayCostId = stayCostId;
        }

        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.amountIncludingTax)).toNumber();
        taxAmountTotal = BigNumber(taxAmountTotal).plus(checkFloatNum(dataObj.taxAmount)).toNumber();
        adjustAmountTotal = BigNumber(adjustAmountTotal).plus(checkFloatNum(dataObj.adjustAmount)).toNumber();
        dataArr.push(dataObj);
    });

    return {
        dataArr: dataArr,
        amountTotal: amountTotal,
        taxAmountTotal: taxAmountTotal,
        adjustAmountTotal: adjustAmountTotal
    }
}

/**
 * 获取其他费用明细数据
 * @returns {{dataArr: *[], amountTotal: number, taxAmountTotal: number}}
 */
function getPlbOtherCosts() {
    var amountTotal = 0; // 含税总额
    var taxAmountTotal = 0; // 税额总额
    var adjustAmountTotal = 0; // 会计调整金额总额
    // 遍历表格获取每行数据
    var $trs = $('#otherCostTableModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var otherCostId = $(this).find('input[name="useDate"]').attr('otherCostId') || '';
        var dataObj = {
            useDate: $(this).find('input[name="useDate"]').val(),
            stayDesc: $(this).find('input[name="stayDesc"]').val(),
            invoiceType: $(this).find('input[name="invoiceType"]').attr('invoiceType') || '',
            amountIncludingTax: isPreview == '1' ? $(this).find('.amountIncludingTax').text() : $(this).find('input[name="amountIncludingTax"]').val(),
            taxAmount: isPreview == '1' ? $(this).find('.taxAmount').text() : $(this).find('input[name="taxAmount"]').val(),
            taxRate: $(this).find('input[name="taxAmount"]').attr('taxRate') || 0,
            amountExcludingTax: $(this).find('.amountExcludingTax').text(),
            adjustAmount: isPreview == '1' ? $(this).find('.adjustAmount').text() : $(this).find('input[name="adjustAmount"]').val(),
            afterChangeAmount: $(this).find('.afterChangeAmount').text(),
            remark: $(this).find('input[name="remark"]').val()
        }

        var invoiceNos = '';
        var invoiceNoStr = '';
        $(this).find('.invoices_box span').each(function (i, v) {
            invoiceNos += $(v).attr('fid') + ',';
            invoiceNoStr += $(v).text().replace(/,$/, '') + ',';
        });
        dataObj.invoiceNos = invoiceNos;
        dataObj.invoiceNoStr = invoiceNoStr;

        if (otherCostId) {
            dataObj.otherCostId = otherCostId;
        }

        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.amountIncludingTax)).toNumber();
        taxAmountTotal = BigNumber(taxAmountTotal).plus(checkFloatNum(dataObj.taxAmount)).toNumber();
        adjustAmountTotal = BigNumber(adjustAmountTotal).plus(checkFloatNum(dataObj.adjustAmount)).toNumber();
        dataArr.push(dataObj);
    });

    return {
        dataArr: dataArr,
        amountTotal: amountTotal,
        taxAmountTotal: taxAmountTotal,
        adjustAmountTotal: adjustAmountTotal
    }
}

/**
 * 获取补助费用明细数据
 * @returns {{dataArr: *[], amountTotal: number, adjustAmountTotal: number}}
 */
function getPlbSubsidyLists() {
    var amountTotal = 0; // 调整后补助金额总额
    var adjustAmountTotal = 0; // 会计调整金额总额
    // 遍历表格获取每行数据
    var $trs = $('#subsidyTableModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var stayDate = ($(this).find('input[name="subsidyDate"]').val() || '').replace(/\s/g, '');
        var startDate = '';
        var endDate = '';
        if (stayDate) {
            startDate = stayDate.split('|')[0];
            endDate = stayDate.split('|')[1];
        }
        var listId = $(this).find('input[name="subsidyType"]').attr('listId') || '';
        var dataObj = {
            subsidyType: $(this).find('input[name="subsidyType"]').attr('subsidyType') || '',
            startDate: startDate,
            endDate: endDate,
            subsidyDays: $(this).find('.subsidyDays').text(),
            subsidyStandard: $(this).find('.subsidyStandard').text(),
            subsidyAmount: $(this).find('.subsidyAmount').text(),
            adjustAmount: isPreview == '1' ? $(this).find('.adjustAmount').text() : $(this).find('input[name="adjustAmount"]').val(),
            afterChangeAmount: $(this).find('.afterChangeAmount').text(),
            remark: $(this).find('input[name="remark"]').val()
        }

        if (listId) {
            dataObj.listId = listId;
        }

        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.afterChangeAmount)).toNumber();
        adjustAmountTotal = BigNumber(adjustAmountTotal).plus(checkFloatNum(dataObj.adjustAmount)).toNumber();
        dataArr.push(dataObj);
    });
    return {
        dataArr: dataArr,
        amountTotal: amountTotal,
        adjustAmountTotal: adjustAmountTotal
    }
}

/**
 * 获取付款明细数据
 * @param isEdit
 * @returns {{dataArr: *[], amountTotal: number}}
 */
function getPaymentmentDetailsData(isEdit) {
    var amountTotal = 0;
    //遍历表格获取每行数据
    var $trs = $('#paymentDetailsModule').find('.layui-table-main tr');
    var dataArr = [];
    $trs.each(function () {
        var paymentId = $(this).find('input[name="paymentType"]').attr('paymentId') || '';

        var dataObj = {
            paymentType: $(this).find('input[name="paymentType"]').attr('paymentType') || '',
            collectionUser: '',
            customerId: '',
            collectionAccount: $(this).find('input[name="collectionAccount"]').val()||'',
            collectionBank: $(this).find('input[name="collectionBank"]').attr('collectionBankNo')||'',
            collectionBankName:$(this).find('input[name="collectionBank"]').val()||'',
            collectionMoney: $(this).find('input[name="collectionMoney"]').val()||'',
            remarks: $(this).find('input[name="remarks"]').val()||''
        }
        var $user = $(this).find('input[name="collectionUser"]');
        var userType = $user.attr('userType');
        if (userType == 2) {
            dataObj.customerId = $user.attr('customerId') || '';
        } else {
            dataObj.collectionUser = ($user.attr('user_id') || '').replace(/,$/, '');
        }

        if (isEdit) {
            var userName = $(this).find('input[name="collectionUser"]').val()||''
            if (userType == 2) {
                dataObj.customerName = userName;
            } else {
                dataObj.collectionUserName = userName;
            }
        }

        if (paymentId) {
            dataObj.paymentId = paymentId;
        }
        amountTotal = BigNumber(amountTotal).plus(checkFloatNum(dataObj.collectionMoney));
        dataArr.push(dataObj);
    });

    return {
        dataArr: dataArr,
        amountTotal: amountTotal
    }
}

/**
 * 计算行程明细汇总数据
 */
function getTripDetailTotal() {
    var PlbLongdistanceCost = getPlbLongdistanceCosts();
    var PlbCityCost = getPlbCityCosts();
    var PlbStayCost = getPlbStayCosts();
    var PlbOtherCost = getPlbOtherCosts();
    var PlbSubsidyList = getPlbSubsidyLists();

    // 长途交通费合计
    var longDistanceCostTotal = PlbLongdistanceCost.amountTotal;
    // 市内交通费合计
    var cityCostTotal = PlbCityCost.amountTotal;
    // 住宿费用合计
    var stayCostsTotal = PlbStayCost.amountTotal;
    // 其他费用合计
    var otherCostTotal = PlbOtherCost.amountTotal;
    // 调整后补助金额合计
    var subsidyAmountTotal = PlbSubsidyList.amountTotal;
    // 补助费用合计
    var subsidyAmount = BigNumber(subsidyAmountTotal).minus(PlbSubsidyList.adjustAmountTotal);
    // 会计调整合计
    var adjustAmountTotal = BigNumber(PlbLongdistanceCost.adjustAmountTotal).plus(PlbCityCost.adjustAmountTotal).plus(PlbStayCost.adjustAmountTotal).plus(PlbOtherCost.adjustAmountTotal).plus(PlbSubsidyList.adjustAmountTotal);
    // 报销金额合计(含税)
    var amountIncludingTaxTotal = BigNumber(longDistanceCostTotal).plus(stayCostsTotal).plus(cityCostTotal).plus(otherCostTotal).plus(subsidyAmount).plus(adjustAmountTotal);
    // 税额合计
    var taxAmountTotal = BigNumber(PlbLongdistanceCost.taxAmountTotal).plus(PlbCityCost.taxAmountTotal).plus(PlbStayCost.taxAmountTotal).plus(PlbOtherCost.taxAmountTotal);
    // 报销金额合计(不含税)
    var anountExcludingTaxTotal = BigNumber(amountIncludingTaxTotal).minus(taxAmountTotal);

    $('#longDistanceCostTotal').val(longDistanceCostTotal); // 长途交通费合计
    $('#stayCostsTotal').val(stayCostsTotal); // 市内交通费合计
    $('#cityCostTotal').val(cityCostTotal); // 住宿费用合计
    $('#otherCostTotal').val(otherCostTotal); // 其他费用合计
    $('#subsidyAmountTotal').val(subsidyAmount); // 补助费用合计
    $('#adjustAmountTotal').val(adjustAmountTotal); // 会计调整合计
    $('#amountIncludingTaxTotal').val(amountIncludingTaxTotal); // 报销金额合计(含税)
    $('#taxAmountTotal').val(taxAmountTotal); // 税额合计
    $('#anountExcludingTaxTotal').val(anountExcludingTaxTotal); // 报销金额合计(不含税)
}

/**
 * 重新计算住宿费用金额
 * @param $trs
 */
function recountStayCost($trs) {
    $trs.each(function () {
        var dataObj = {
            stayDays: $(this).find('.stayDays').text(),
            stayStandard: $(this).find('.stayStandard').text(),
            taxAmount: $(this).find('input[name="taxAmount"]').val()
        }
        var amountIncludingTax = BigNumber(checkFloatNum(dataObj.stayDays)).multipliedBy(checkFloatNum(dataObj.stayStandard));
        $(this).find('.amountIncludingTax').text(amountIncludingTax);
        $(this).find('.amountExcludingTax').text(BigNumber(amountIncludingTax).minus(checkFloatNum(dataObj.taxAmount)));
    });
}

/**
 * 重新计算补助费用金额
 * @param $trs
 */
function recountSubsidy($trs) {
    $trs.each(function () {
        var dataObj = {
            subsidyDays: $(this).find('.subsidyDays').text(),
            subsidyStandard: $(this).find('.subsidyStandard').text(),
            adjustAmount: $(this).find('input[name="adjustAmount"]').val()
        }

        var subsidyAmount = BigNumber(checkFloatNum(dataObj.subsidyDays)).multipliedBy(checkFloatNum(dataObj.subsidyStandard));
        $(this).find('.subsidyAmount').text(subsidyAmount);
        $(this).find('.afterChangeAmount').text(BigNumber(subsidyAmount).plus(checkFloatNum(dataObj.adjustAmount)));
    })
}

/**
 * 初始化基本信息
 */
function initBaseHtml() {
    var str = '';
    var disabledStr = '';
    if ((type == 3 && disabled == '1') || reimburseStatus == '4') {
        disabledStr = 'disabled';
    }
    if (reimburseType == '01') {
        str = [/* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据编号<span field="reimburseNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="reimburseNo" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销日期<span field="reimburseDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="reimburseDate" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">经办人<span field="createUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="createUser" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销人<span field="reimburseUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + (disabledStr || 'id="reimburseUser"') + ' placeholder="选择报销人" name="reimburseUser" readonly autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">所属部门<span field="reimburseBelongDept" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="reimburseBelongDept"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">费用类型<span field="travelType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="travelType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起类型<span field="launchType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="launchType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">开始日期<span field="startDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' id="startDate" name="startDate" readonly autocomplete="off" class="layui-input" style="cursor: pointer;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">结束日期<span field="endDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' id="endDate" name="endDate" readonly autocomplete="off" class="layui-input" style="cursor: pointer;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginProject" projId autocomplete="off" readonly class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程合同</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginContract" autocomplete="off" subcontractId readonly class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">研发项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="developProject" pjNumber autocomplete="off" readonly class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第五行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否超标<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="1" title="是">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">多币种<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" ' + disabledStr + ' name="multiCurrency" lay-filter="multiCurrency" value="1" title="是">' +
            '                       <input type="radio" ' + disabledStr + ' name="multiCurrency" lay-filter="multiCurrency" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否冲账<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" ' + disabledStr + ' name="whetherChargeMoney" lay-filter="whetherChargeMoney" value="1" title="是">' +
            '                       <input type="radio" ' + disabledStr + ' name="whetherChargeMoney" lay-filter="whetherChargeMoney" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item" style="display: none;">' +
            '                       <label class="layui-form-label form_label">报销金额(原币)<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="reimburseTotalOriginal" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第六行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item" style="display: none;">' +
            '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off" pointFlag="1" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销金额<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseTotal" autocomplete="off" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第七行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销事由<span field="reimburseDesc" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <textarea ' + disabledStr + ' name="reimburseDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否分摊<span field="ifShare" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						<input type="radio" name="ifShare" value="1" title="是">' +
            '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据标题</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="reimburseName" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">分摊部门</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="shareDept" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第七行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件数量</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input ' + disabledStr + ' type="text" name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs8" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent" class="file_content"></div>' +
            function () {
                if ((type == 3 && disabled == '1') && reimburseStatus != '4') {
                    return '';
                } else {
                    return '                               <div class="file_upload_box">' +
                        '                                   <a href="javascript:;" class="open_file">' +
                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                        '                                   </a>' +
                        '                                   <div class="progress">' +
                        '                                       <div class="bar"></div>' +
                        '                                   </div>' +
                        '                                   <div class="bar_text"></div>' +
                        '                               </div>';
                }
            }() +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */].join('');
    } else if (reimburseType == '02') {
        str = [/* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据编号<span field="reimburseNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseNo" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销日期<span field="reimburseDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="reimburseDate" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">经办人<span field="createUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="createUser" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销人<span field="reimburseUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + (disabledStr || 'id="reimburseUser"') + ' placeholder="选择报销人" name="reimburseUser" readonly autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">所属部门<span field="reimburseBelongDept" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="reimburseBelongDept"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">长途交通费标准<span field="transportationStandard" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="transportationStandard" autocomplete="off" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">开始日期<span field="startDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' id="startDate" name="startDate" readonly autocomplete="off" class="layui-input" style="cursor: pointer;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">结束日期<span field="endDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' id="endDate" name="endDate" readonly autocomplete="off" class="layui-input" style="cursor: pointer;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">费用类型<span field="travelType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="travelType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否超标<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="1" title="是">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item" style="display: none;">' +
            '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off" pointFlag="1" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第五行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销事由<span field="reimburseDesc" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <textarea ' + disabledStr + ' name="reimburseDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否分摊<span field="ifShare" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						<input type="radio" name="ifShare" value="1" title="是">' +
            '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据标题</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="reimburseName" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">分摊部门</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="shareDept" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第六行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件数量</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs8" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent" class="file_content"></div>' +
            function () {
                if ((type == 3 && disabled == '1') && reimburseStatus != '4') {
                    return '';
                } else {
                    return '                               <div class="file_upload_box">' +
                        '                                   <a href="javascript:;" class="open_file">' +
                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                        '                                   </a>' +
                        '                                   <div class="progress">' +
                        '                                       <div class="bar"></div>' +
                        '                                   </div>' +
                        '                                   <div class="bar_text"></div>' +
                        '                               </div>';
                }
            }() +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */].join('');
    } else if (reimburseType == '03') {
        str = [/* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据编号<span field="reimburseNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseNo" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销日期<span field="reimburseDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="reimburseDate" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">经办人<span field="createUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="createUser" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销人<span field="reimburseUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + (disabledStr || 'id="reimburseUser"') + ' placeholder="选择报销人" name="reimburseUser" readonly autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">所属部门<span field="reimburseBelongDept" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="reimburseBelongDept"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销金额<span field="reimburseTotal" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseTotal" autocomplete="off" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">费用类型<span field="travelType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="travelType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起类型<span field="launchType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="launchType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginProject" projId readonly  autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程合同</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginContract" readonly autocomplete="off" subcontractId class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">研发项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="developProject" readonly pjNumber autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            // '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            // '                   <div class="layui-form-item">' +
            // '                       <label class="layui-form-label form_label">车辆管理</label>' +
            // '                       <div class="layui-input-block form_block">' +
            // '                       <input type="text" name="vehicleFile" autocomplete="off" class="layui-input">' +
            // '                       </div>' +
            // '                   </div>' +
            // '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第五行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否冲账<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" ' + disabledStr + ' name="whetherChargeMoney" lay-filter="whetherChargeMoney" value="1" title="是">' +
            '                       <input type="radio" ' + disabledStr + ' name="whetherChargeMoney" lay-filter="whetherChargeMoney" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否超标<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="1" title="是">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第六行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item" style="display: none;">' +
            '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off" pointFlag="1" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件数量</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent" class="file_content"></div>' +
            function () {
                if ((type == 3 && disabled == '1') && reimburseStatus != '4') {
                    return '';
                } else {
                    return '                               <div class="file_upload_box">' +
                        '                                   <a href="javascript:;" class="open_file">' +
                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                        '                                   </a>' +
                        '                                   <div class="progress">' +
                        '                                       <div class="bar"></div>' +
                        '                                   </div>' +
                        '                                   <div class="bar_text"></div>' +
                        '                               </div>';
                }
            }() +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第七行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销事由<span field="reimburseDesc" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <textarea ' + disabledStr + ' name="reimburseDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否分摊<span field="ifShare" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						<input type="radio" name="ifShare" value="1" title="是">' +
            '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据标题</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="reimburseName" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">分摊部门</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="shareDept" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */].join('');
    } else if (reimburseType == '04') {
        str = [/* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据编号<span field="reimburseNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseNo" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销日期<span field="reimburseDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="reimburseDate" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">经办人<span field="createUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="createUser" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">申请部门<span field="reimburseBelongDept" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="reimburseBelongDept"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">费用类型<span field="travelType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="travelType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起类型<span field="launchType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="launchType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销金额<span field="reimburseTotal" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseTotal" autocomplete="off" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginProject" projId readonly autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7" >' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程合同</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginContract" autocomplete="off" subcontractId readonly class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">研发项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="developProject" readonly pjNumber autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否超标<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="1" title="是">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第五行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item" style="display: none;">' +
            '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off" pointFlag="1" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第六行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销事由<span field="reimburseDesc" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <textarea ' + disabledStr + ' name="reimburseDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否分摊<span field="ifShare" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						<input type="radio" name="ifShare" value="1" title="是">' +
            '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据标题</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="reimburseName" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">分摊部门</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="shareDept" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第七行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件数量</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs8" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent" class="file_content"></div>' +
            function () {
                if ((type == 3 && disabled == '1') && reimburseStatus != '4') {
                    return '';
                } else {
                    return '                               <div class="file_upload_box">' +
                        '                                   <a href="javascript:;" class="open_file">' +
                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                        '                                   </a>' +
                        '                                   <div class="progress">' +
                        '                                       <div class="bar"></div>' +
                        '                                   </div>' +
                        '                                   <div class="bar_text"></div>' +
                        '                               </div>';
                }
            }() +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */].join('');
    }else if(reimburseType == '05'){
        str =[
            /* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                     <div class="layui-form-item"> ' +
            '                       <label class="layui-form-label form_label">单据编号<span field="reimburseNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label> ' +
            '                         <div class="layui-input-block form_block"> ' +
            '                           <input type="text" name="reimburseNo" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7"> ' +
            '                         </div> ' +
            '                     </div> ' +
            '                </div> '+
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起部门<span field="reimburseBelongDept" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="reimburseBelongDept"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起人<span field="createUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="createUser" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起时间<span field="reimburseDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="reimburseDate" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起类型<span field="launchType" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <select ' + disabledStr + ' name="launchType"></select>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销金额<span field="reimburseTotal" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseTotal" autocomplete="off" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第三行 */
            '          <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginProject" projId readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;cursor: pointer">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">工程合同</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="enginContract" autocomplete="off" subcontractId readonly class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">研发项目</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="developProject" readonly pjNumber autocomplete="off" class="layui-input" style="cursor: pointer; background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '          </div>',
            /* endregion */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否有合同<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" name="whetherContract" lay-filter="whetherContract" value="1" title="是" checked>' +
            '                       <input type="radio" name="whetherContract" lay-filter="whetherContract" value="0" title="否">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否预付<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block" style="cursor: default;pointer-events: none">' +
            '                       <input type="radio" name="whetherBudget" lay-filter="whetherBudget" value="1" title="是" checked>' +
            '                       <input type="radio" name="whetherBudget" lay-filter="whetherBudget" value="0" title="否">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '          </div>',
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件数量</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input ' + disabledStr + ' type="text" name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent" class="file_content"></div>' +
            function () {
                if ((type == 3 && disabled == '1') && reimburseStatus != '4') {
                    return '';
                } else {
                    return '                               <div class="file_upload_box">' +
                        '                                   <a href="javascript:;" class="open_file">' +
                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                        '                                   </a>' +
                        '                                   <div class="progress">' +
                        '                                       <div class="bar"></div>' +
                        '                                   </div>' +
                        '                                   <div class="bar_text"></div>' +
                        '                               </div>';
                }
            }() +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第五行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">付款事由<span field="reimburseDesc" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <textarea ' + disabledStr + ' name="reimburseDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
        ].join('');
    }else if (reimburseType == '06') {
        str = [/* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据编号<span field="reimburseNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly name="reimburseNo" autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起单位<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起人<span field="createUser" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="createUser" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起部门<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">发起时间<span field="reimburseDate" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" name="reimburseDate" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否超标<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="1" title="是">' +
            '                       <input type="radio" name="overStandard" lay-filter="overStandard" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item" style="display: none;">' +
            '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off" pointFlag="1" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">报销事由<span field="reimburseDesc" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <textarea ' + disabledStr + ' name="reimburseDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">是否分摊<span field="ifShare" class="field_required">*</span></label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						<input type="radio" name="ifShare" value="1" title="是">' +
            '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">单据标题</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="reimburseName" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs12" style="display: none;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">分摊部门</label>' +
            '                       <div class="layui-input-block form_block">' +
            ' 						 <input type="text"  name="shareDept" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">合同名称</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' autocomplete="off" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">合同编号</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' autocomplete="off" class="layui-input">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">合同类别</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background-color: #e7e7e7;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">合同金额</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background-color: #e7e7e7;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">累计已结算金额</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background-color: #e7e7e7;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">累计已结算比例</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background-color: #e7e7e7;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">累计已支付金额</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background-color: #e7e7e7;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">累计已支付比例</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" readonly autocomplete="off" class="layui-input" style="background-color: #e7e7e7;">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
            /* endregion */
            /* region 第五行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件数量</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                       <input type="text" ' + disabledStr + ' name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs9" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">' +
            '                       <label class="layui-form-label form_label">附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '                           <div class="file_module">' +
            '                               <div id="fileContent" class="file_content"></div>' +
            function () {
                if ((type == 3 && disabled == '1') && reimburseStatus != '4') {
                    return '';
                } else {
                    return '                               <div class="file_upload_box">' +
                        '                                   <a href="javascript:;" class="open_file">' +
                        '                                   <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                                   <input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                        '                                   </a>' +
                        '                                   <div class="progress">' +
                        '                                       <div class="bar"></div>' +
                        '                                   </div>' +
                        '                                   <div class="bar_text"></div>' +
                        '                               </div>';
                }
            }() +
            '                           </div>' +
            '                       </div>' +
            '                   </div>' +
            '               </div>' +
            '           </div>'
            /* endregion */].join('');
    }

    $('#baseDiv').html(str);
}

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
            isBudgetFlow: true,
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

/**
 * 打印处理表格
 */
function printTable() {
    var styleArr = [
        '.print_table .layui-table-cell {width: auto;padding: 0;}',
        '.print_table{font-size: 14px; color: #666;}',
        '.print_table{width: 100%; border-collapse: collapse; border-spacing: 0;}',
        '.print_table th,.print_table td{line-height: 20px; padding: 9px 15px; border: 1px solid #ccc; text-align: left; font-size: 12px; color: #666;}',
        '.print_table a{color: #666; text-decoration:none;}',
        '.print_table *.layui-hide{display: none}'
    ]
    $('head').append('<style id="print_style">' + styleArr.join('') + '</style>')

    // 预算执行表格
    var $table1 = $("<table class='print_table'></table>");
    $table1.html($("#reimbursementDetailsModule .layui-table-box").find(".layui-table-header table").html());
    $table1.append($("[lay-id='reimbursementDetailsTable'] .layui-table-body.layui-table-main table").html());
    $table1.find("th.layui-table-patch").remove();
    $table1.find(".layui-table-col-special").remove();
    $('#reimbursementDetailsTable').hide().next().hide();
    $('#reimbursementDetailsModule').find('.layui-colla-content').append($table1);
    // 付款明细
    var $table2 = $("<table class='print_table'></table>");
    $table2.html($("#paymentDetailsModule .layui-table-box").find(".layui-table-header table").html());
    $table2.append($("[lay-id='paymentDetailsTable'] .layui-table-body.layui-table-main table").html());
    $table2.find("th.layui-table-patch").remove();
    $table2.find(".layui-table-col-special").remove();
    $('#paymentDetailsTable').hide().next().hide();
    $('#paymentDetailsModule').find('.layui-colla-content').append($table2);
    // 长途交通费
    if (!$('#longDistanceTableModule').parent().is(":hidden")) {
        var $table3 = $("<table class='print_table'></table>");
        $table3.html($("#longDistanceTableModule .layui-table-box").find(".layui-table-header table").html());
        $table3.append($("[lay-id='longDistanceTable'] .layui-table-body.layui-table-main table").html());
        $table3.find("th.layui-table-patch").remove();
        $table3.find(".layui-table-col-special").remove();
        $('#longDistanceTable').hide().next().hide();
        $('#longDistanceTableModule').append($table3);
    }
    // 市内交通费
    if (!$('#cityCostTableModule').parent().is(":hidden")) {
        var $table4 = $("<table class='print_table'></table>");
        $table4.html($("#cityCostTableModule .layui-table-box").find(".layui-table-header table").html());
        $table4.append($("[lay-id='cityCostTable'] .layui-table-body.layui-table-main table").html());
        $table4.find("th.layui-table-patch").remove();
        $table4.find(".layui-table-col-special").remove();
        $('#cityCostTable').hide().next().hide();
        $('#cityCostTableModule').append($table4);
    }
    // 住宿费
    if (!$('#stayCostTableModule').parent().is(":hidden")) {
        var $table5 = $("<table class='print_table'></table>");
        $table5.html($("#stayCostTableModule .layui-table-box").find(".layui-table-header table").html());
        $table5.append($("[lay-id='stayCostTable'] .layui-table-body.layui-table-main table").html());
        $table5.find("th.layui-table-patch").remove();
        $table5.find(".layui-table-col-special").remove();
        $('#stayCostTable').hide().next().hide();
        $('#stayCostTableModule').append($table5);
    }
    // 其他费用
    if (!$('#otherCostTableModule').parent().is(":hidden")) {
        var $table6 = $("<table class='print_table'></table>");
        $table6.html($("#otherCostTableModule .layui-table-box").find(".layui-table-header table").html());
        $table6.append($("[lay-id='otherCostTable'] .layui-table-body.layui-table-main table").html());
        $table6.find("th.layui-table-patch").remove();
        $table6.find(".layui-table-col-special").remove();
        $('#otherCostTable').hide().next().hide();
        $('#otherCostTableModule').append($table6);
    }
    // 补助明细
    if (!$('#subsidyTableModule').parent().is(":hidden")) {
        var $table7 = $("<table class='print_table'></table>");
        $table7.html($("#subsidyTableModule .layui-table-box").find(".layui-table-header table").html());
        $table7.append($("[lay-id='subsidyTable'] .layui-table-body.layui-table-main table").html());
        $table7.find("th.layui-table-patch").remove();
        $table7.find(".layui-table-col-special").remove();
        $('#subsidyTable').hide().next().hide();
        $('#subsidyTableModule').append($table7);
    }

    // 非ie浏览器
    if (!(!!window.ActiveXObject || "ActiveXObject" in window)) {
        window.print();

        $('#print_style').remove();
        $('.print_table').remove();
        $('#reimbursementDetailsTable').show().next().show();
        $('#paymentDetailsTable').show().next().show();
        if (!$('#longDistanceTableModule').parent().is(":hidden")) {
            $('#longDistanceTable').show().next().show();
        }
        // 市内交通费
        if (!$('#cityCostTableModule').parent().is(":hidden")) {
            $('#cityCostTable').show().next().show();
        }
        // 住宿费
        if (!$('#stayCostTableModule').parent().is(":hidden")) {
            $('#stayCostTable').show().next().show();
        }
        // 其他费用
        if (!$('#otherCostTableModule').parent().is(":hidden")) {
            $('#otherCostTable').show().next().show();
        }
        // 补助明细
        if (!$('#subsidyTableModule').parent().is(":hidden")) {
            $('#subsidyTable').show().next().show();
        }
    }
}

/**
 * 数字转化为中文大写
 */

function number_chinese(str) {
    var num = parseFloat(str);
    var strOutput = "",
        strUnit = '仟佰拾亿仟佰拾万仟佰拾元角分';
    num += "00";
    var intPos = num.indexOf('.');
    if (intPos >= 0){
        num = num.substring(0, intPos) + num.substr(intPos + 1, 2);
    }
    strUnit = strUnit.substr(strUnit.length - num.length);
    for (var i=0; i < num.length; i++){
        strOutput += '零壹贰叁肆伍陆柒捌玖'.substr(num.substr(i,1),1) + strUnit.substr(i,1);
    }
    return strOutput.replace(/零角零分$/, '整').replace(/零[仟佰拾]/g, '零').replace(/零{2,}/g, '零').replace(/零([亿|万])/g, '$1').replace(/零+元/, '元').replace(/亿零{0,3}万/, '亿').replace(/^元/, "零元")

}
