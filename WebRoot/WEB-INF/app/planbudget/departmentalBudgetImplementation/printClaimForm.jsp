<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>报销单</title>

    <style>
        .table {
            width: 100%;
        }
    </style>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210812.1"></script>
</head>
<body>
<object id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0" viewastext></object>
<div id="printWrapper">
    <table id="baseTable" class="table">
        <colgroup style="width: 10%;"></colgroup>
        <colgroup style="width: 20%;"></colgroup>
        <colgroup style="width: 10%;"></colgroup>
        <colgroup style="width: 20%;"></colgroup>
        <colgroup style="width: 10%;"></colgroup>
        <colgroup style="width: 20%;"></colgroup>
        <tbody>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        </tbody>
    </table>
</div>

<script>
    var reimburseType = $.GetRequest()['reimburseType'] || '';
    var reimburseId = $.GetRequest()['reimburseId'] || '';
    var runId = $.GetRequest()['runId'] || '';
    var flowId = $.GetRequest()['flowId'] || '';
    var prcsId = $.GetRequest()['prcsId'] || '';

    $('#baseTable tbody').append(initBaseTable())

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
        var loadIndex = layer.load();
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
        // 获取项目信息
        if (runId) {
            $.get('/plbDeptReimburse/getDataByRunId', {runId: runId}, function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    reimburseId = res.data.reimburseId;
                    initPage(res.data);
                } else {
                    layer.msg('获取信息失败！', {icon: 2});
                }
            })
        } else {
            $.get('/plbDeptReimburse/getDataByReimburseId', {reimburseId: reimburseId}, function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    initPage(res.data);
                } else {
                    layer.msg('获取信息失败！', {icon: 2});
                }
            });
        }
    });

    function initPage(data) {
        if (data) {
            initBaseData(data);
        }
    }

    function initBaseData(data) {
        $('.td-field').each(function() {
            var field = $(this).attr('field');
            var value = data[field] || '';
            if (field == 'createUser') {
                value = (data['createUserName'] || '').replace(/,$/, '');
            }
            if (field == 'reimburseUser') {
                value = (data['reimburseUserName'] || '').replace(/,$/, '');
            }
            if (field == 'reimburseBelongDept') {
                value = (data['reimburseBelongDeptName'] || '').replace(/,$/, '');
            }
            if (field == 'travelType') {
                value = dictionaryObj['TRAVEL_TYPE']['object'][data['travelType']] || '';
            }
            if (field == 'startDate') {
                value = format(data['startDate']);
            }
            if (field == 'endDate') {
                value = format(data['endDate']);
            }
            if (field == 'overStandard') {
                value = '否';
                if (data['overStandard'] == '1') {
                    value = '是';
                    $('.overStandardReason').show()
                }
            }
            if (field == 'multiCurrency') {
                value = '否';
                if (data['multiCurrency'] == '1') {
                    value = '是';
                    $('.reimburseTotalOriginal').show()
                }
            }
            if (field == 'fileContent') {
                if (data['attachments'] && data['attachments'].length > 0) {
                    value = getFileEleStr(data['attachments'], false)
                }
            }
            $(this).html(value);
        });
    }

    function initBaseTable () {
        var str = '';
        if (reimburseType == '01') {
            str = ['<tr>' +
            '<td>单据编号</td>' +
            '<td><span class="td-field" field="reimburseNo"></span></td>' +
            '<td>报销日期</td>' +
            '<td><span class="td-field" field="reimburseDate"></span></td>' +
            '<td>经办人</td>' +
            '<td><span class="td-field" field="createUser"></span></td>' +
            '</tr>',
                '<tr>' +
                '<td>报销人</td>' +
                '<td><span class="td-field" field="reimburseUser"></span></td>' +
                '<td>所属部门</td>' +
                '<td><span class="td-field" field="reimburseBelongDept"></span></td>' +
                '<td>费用类型</td>' +
                '<td><span class="td-field" field="travelType"></span></td>' +
                '</tr>',
                '<tr>' +
                '<td>开始日期</td>' +
                '<td><span class="td-field" field="startDate"></span></td>' +
                '<td>结束日期</td>' +
                '<td><span class="td-field" field="endDate"></span></td>' +
                '<td>报销金额</td>' +
                '<td><span class="td-field" field="reimburseTotal"></span></td>' +
                '</tr>',
                '<tr>' +
                '<td>是否超标</td>' +
                '<td><span class="td-field" field="overStandard"></span></td>' +
                ' <td>多币种</td>' +
                '<td><span class="td-field" field="multiCurrency"></span></td>' +
                '</tr>',
                '<tr>' +
                '<td class="overStandardReason" style="display: none;">超标原因</td>' +
                '<td class="overStandardReason" style="display: none;"><span class="td-field" field="overStandardReason"></span></td>' +
                '<td class="reimburseTotalOriginal" style="display: none;">报销金额(原币)</td>' +
                '<td class="reimburseTotalOriginal" style="display: none;"><span class="td-field" field="reimburseTotalOriginal"></span></td>' +
                '</tr>', +
                    '<tr>' +
                '<td>报销事由</td>' +
                '<td><span class="td-field" field="reimburseDesc"></span></td>' +
                '</tr>',
                '<tr>' +
                '<td>附件数量</td>' +
                '<td><span class="td-field" field="attachmentNum"></span></td>' +
                '<td>附件</td>' +
                '<td><span class="td-field" field="fileContent"></span></td>' +
                '</tr>'].join('')
        } else if (reimburseType == '02') {
            str = ['<tr>'+
            '<td>单据编号</td>'+
            '<td><span class="td-field" field="reimburseNo"></span></td>'+
            '<td>报销日期</td>'+
            '<td><span class="td-field" field="reimburseDate"></span></td>'+
            '<td>经办人</td>'+
            '<td><span class="td-field" field="createUser"></span></td>'+
            '</tr>',
                '<tr>'+
                '<td>报销人</td>'+
                '<td><span class="td-field" field="reimburseUser"></span></td>'+
                '<td>所属部门</td>'+
                '<td><span class="td-field" field="reimburseBelongDept"></span></td>'+
                '<td>长途交通费标准</td>'+
                '<td><span class="td-field" field="transportationStandard"></span></td>'+
                '</tr>',
                '<tr>'+
                '<td>开始日期</td>'+
                '<td><span class="td-field" field="startDate"></span></td>'+
                '<td>结束日期</td>'+
                '<td><span class="td-field" field="endDate"></span></td>'+
                '<td>费用类型</td>'+
                '<td><span class="td-field" field="travelType"></span></td>'+
                '</tr>',
                '<tr>'+
                '<td>是否超标</td>'+
                '<td><span class="td-field" field="overStandard"></span></td>'+
                '<td class="overStandardReason">超标原因</td>'+
                '<td class="overStandardReason"><span class="td-field" field="overStandardReason"></span></td>'+
                '</tr>',
                '<tr>'+
                '<td>报销事由</td>'+
                '<td><span class="td-field" field="reimburseDesc"></span></td>'+
                '</tr>',
                '<tr>'+
                '<td>附件数量</td>'+
                '<td><span class="td-field" field="attachmentNum"></span></td>'+
                '<td>附件</td>'+
                '<td><span class="td-field" field="fileContent"></span></td>'+
                '</tr>'].join('')
        } else if (reimburseType == '03' || reimburseType == '05') {
            str = ['<tr>'+
            '<td>单据编号</td>'+
            '<td><span class="td-field" field="reimburseNo"></span></td>'+
            '<td>报销日期</td>'+
            '<td><span class="td-field" field="reimburseDate"></span></td>'+
            '<td>经办人</td>'+
            '<td><span class="td-field" field="createUser"></span></td>'+
            '</tr>',
                '<tr>'+
                '<td>报销人</td>'+
                '<td><span class="td-field" field="reimburseUser"></span></td>'+
                '<td>所属部门</td>'+
                '<td><span class="td-field" field="reimburseBelongDept"></span></td>'+
                '<td>报销金额</td>'+
                '<td><span class="td-field" field="reimburseTotal"></span></td>'+
                '</tr>',
                '<tr>'+
                '<td>费用类型</td>'+
                '<td><span class="td-field" field="travelType"></span></td>'+
                '<td>是否超标</td>'+
                '<td><span class="td-field" field="overStandard"></span></td>'+
                '<td class="overStandardReason">超标原因</td>'+
                '<td class="overStandardReason"><span class="td-field" field="overStandardReason"></span></td>'+
                '</tr>',
                '<tr>'+
                '<td>报销事由</td>'+
                '<td><span class="td-field" field="reimburseDesc"></span></td>'+
                '</tr>',
                '<tr>'+
                '<td>附件数量</td>'+
                '<td><span class="td-field" field="attachmentNum"></span></td>'+
                '<td>附件</td>'+
                '<td><span class="td-field" field="fileContent"></span></td>'+
                '</tr>'].join('')
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
                '           </div>' ,
                /* endregion */
                /* region 第二行 */
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
                '                       <label class="layui-form-label form_label">申请部门<span field="reimburseBelongDept" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" id="reimburseBelongDept" readonly name="reimburseBelongDept" autocomplete="off" class="layui-input choose_dept" style="cursor: pointer;">' +
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
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item" style="display: none;">' +
                '                       <label class="layui-form-label form_label">超标原因<span class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" ' + disabledStr + ' name="overStandardReason" autocomplete="off" pointFlag="1" class="layui-input">' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '           </div>' ,
                /* endregion */
                /* region 第三行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">费用类型<span field="travelType" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <select '+disabledStr+' name="travelType"></select>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '           </div>',
                /* endregion */
                /* region 第四行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">报销事由<span field="reimburseDesc" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <textarea '+disabledStr+' name="reimburseDesc" placeholder="请输入内容" class="layui-textarea"></textarea>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs12" style="display: none;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">是否分摊<span field="ifShare" class="field_required">*</span></label>' +
                '                       <div class="layui-input-block form_block">' +
                ' 						<input type="radio" name="ifShare" value="1" title="是">'+
                '                       <input type="radio" name="ifShare" value="0" title="否" checked>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>' +
                '           </div>' ,
                /* endregion */
                /* region 第五行 */
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                '                   <div class="layui-form-item">' +
                '                       <label class="layui-form-label form_label">附件数量</label>' +
                '                       <div class="layui-input-block form_block">' +
                '                       <input type="text" '+disabledStr+' name="attachmentNum" autocomplete="off" class="layui-input input_floatNum">' +
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
                }()+
                '                           </div>' +
                '                       </div>' +
                '                   </div>' +
                '               </div>'+
                '           </div>' ,
                /* endregion */].join('');
        }

        return str;
    }
</script>
<%--        <script type="text/javascript" src="/js/editIEprint/index.js?20210811.4"></script>--%>
</body>
</html>