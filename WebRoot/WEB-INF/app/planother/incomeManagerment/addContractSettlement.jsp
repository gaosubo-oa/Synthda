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
    <title>总包合同结算预览</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
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
    <script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>
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
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">总包合同结算主表</h2>
        <div class="layui-colla-content layui-show plan_base_info">
            <form class="layui-form" id="baseForm" lay-filter="baseForm">
                <div class="layui-row">
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">总包结算编号<span field="planNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planNo" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">建设单位<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">合同名称<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">合同金额<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">累计已结算金额<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">在途结算金额<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">本次结算金额<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">结算日期<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">备注<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-row">
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">结算年<span field="useDate" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">结算季<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">结算月<span field="planName" class="field_required">*</span></label>
                            <div class="layui-input-block form_block">
                                <input type="text" name="planName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-row">
                    <div class="layui-col-xs12" style="padding: 0 5px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label form_label">计算附件</label>
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

    <div class="layui-colla-item">
        <h2 class="layui-colla-title">分包明细</h2>
        <div class="layui-colla-content mtl_info layui-show">
            <div>
                <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>
            </div>
        </div>
    </div>
</div>

<script>
    var type =  $.GetRequest()['type'] || '';
    var mtlSettleupId = $.GetRequest()['mtlSettleupId'] || '';
    var runId = $.GetRequest()['runId'] || '';

    // 获取数据字典数据
    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {},
        MTL_VALUATION_UNIT:{}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,MTL_VALUATION_UNIT';
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
        var loadIndex = layer.load();
        // 获取项目信息
        if (runId) {
            $.get('/plbMtlSettleup/getSettleupByRunId', {runId: runId}, function (res) {
                layer.close(loadIndex);
                if (!res.flag) {
                    layer.msg('获取信息失败！', {icon: 2});
                }
                initPage(res.data);
            });
        } else if (mtlSettleupId) {
            $.get('/plbMtlSettleup/getDataByCondition', {mtlSettleupId: mtlSettleupId}, function (res) {
                layer.close(loadIndex);
                if (!res.flag)  {
                    layer.msg('获取信息失败！', {icon: 2});
                }
                initPage(res.data[0]);
            });
        } else {
            layer.close(loadIndex);
            layer.msg('获取信息失败！', {icon: 2});
            initPage();
        }
    });

    function initPage(settleupData) {
        layui.use(['form', 'table', 'element','laydate'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;

            var type = 4;

            if (settleupData) {

                fileuploadFn('#fileupload', $('#fileContent'));
                //新增时计划编号显示
                if (type == 0) {
                    // 获取自动编号
                    getAutoNumber({autoNumber: 'plbMtlPlan'}, function(res) {
                        $('input[name="planNo"]', $('#baseForm')).val(res);
                    });
                    $('.refresh_no_btn').show().on('click', function() {
                        getAutoNumber({autoNumber: 'plbMtlPlan'}, function(res) {
                            $('input[name="planNo"]', $('#baseForm')).val(res);
                        });
                    });

                    //默认当前时间
                    var year = new Date().getFullYear();
                    var month = new Date().getMonth()+1;
                    var day = new Date().getDate();
                    if (month < 10) {
                        month = "0" + month;
                    }
                    if (day < 10) {
                        day = "0" + day;
                    }
                    var today = year+"-" + month + "-" + day;
                    //计划时间默认填报时间，即当日
                    $('#planDate').val(today)
                }
                var materialDetailsTableData = [];
                //回显数据
                if (type == 1 || type == 4) {
                    form.val("formTest", data);

                    $('#planDate').val(data ? format(data.planDate) : '')

                    $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId', data.budgetItemId || '');

                    $('.plan_base_info input[name="wbsId"]').val(data.wbsName || '');
                    $('.plan_base_info input[name="wbsId"]').attr('wbsId', data.wbsId || '');
                    $('.plan_base_info input[name="cbsId"]').val(data.cbsName || '');
                    $('.plan_base_info input[name="cbsId"]').attr('cbsId', data.cbsId || '');
                    // 控制类型
                    $('.plan_base_info input[name="controlMode"]').val(dictionaryObj['CONTROL_TYPE']['object'][data.controlMode] || '');
                    $('.plan_base_info input[name="controlMode"]').attr('controlMode', data.controlMode || '');
                    // 计量单位
                    $('.plan_base_info input[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][data.valuationUnit] || '');
                    $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit', data.valuationUnit || '');

                    if (data.attachmentList && data.attachmentList.length > 0) {
                        var fileArr = data.attachmentList;
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

                    materialDetailsTableData = data.listWithBLOBs;

                    //查看详情
                    if(type==4){
                        $('.layui-layer-btn-c').hide()
                        $('#baseForm [name="planName"]').attr('disabled','true')
                        $('#useDate').attr('disabled','true')
                        $('#baseForm [name="remark"]').attr('disabled','true')
                        $('.file_upload_box').hide()
                        $('.deImgs').hide()
                        $('#createTime').attr('disabled','true')
                        $('#approvalDate').attr('disabled','true')
                        $('#auditerDate').attr('disabled','true')
                        $('.chooseManagementBudget').hide()
                    }
                }

                element.render();
                form.render();
                /*laydate.render({
                    elem: '#planDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.planDate) : ''
                });*/
                laydate.render({
                    elem: '#useDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.useDate) : ''
                });
                laydate.render({
                    elem: '#createTime' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.createTime) : ''
                });
                laydate.render({
                    elem: '#approvalDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.approvalDate) : ''
                });
                laydate.render({
                    elem: '#auditerDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.auditerDate) : ''
                });

                var cols=[
                    {type: 'numbers', title: '操作'},
                    {
                        field: 'planMtlName', title: '工程量', width: 200, templet: function (d) {
                            return '<input mtlPlanListId="' + (d.mtlPlanListId || '') + '" mtlLibId="'+(d.mtlLibId || '')+'" readonly type="text" name="planMtlName" class="layui-input" style="width: 90%;height: 100%;" value="' + (d.planMtlName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
                        }
                    },
                    {
                        field: 'planMtlStandard', title: '综合单价', templet: function (d) {
                            return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;" value="' + (d.planMtlStandard || '') + '">'
                        }
                    },
                    {
                        field: 'valuationUnit', title: '总价',
                        templet: function (d) {
                            return '<input type="text" valuationUnit="'+d.valuationUnit+'" name="valuationUnit" readonly class="layui-input '+(type==4 ?  '' : 'chooseMtlUnit')+'" style="height: 100%;cursor: pointer;" value="' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '') + '">'
                        }
                    },
                    {
                        field: 'directUnitPrice', title: '累计已结算工程量',
                    },
                    {
                        field: 'directUnitPrice', title: '累计已结算金额',
                    },
                    {
                        field: 'directUnitPrice', title: '在途结算工程量',
                    },
                    {
                        field: 'directUnitPrice', title: '在途结算金额',
                    },
                    {
                        field: 'directUnitPrice', title: '本次结算工程量',
                    },
                    {
                        field: 'directUnitPrice', title: '本次结算金额',
                    },

                ]
                if(type!=4){
                    cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                }
                table.render({
                    elem: '#materialDetailsTable',
                    data: materialDetailsTableData,
                    toolbar: '#toolbarDemoIn',
                    defaultToolbar: [''],
                    limit: 1000,
                    cols: [cols],
                    done:function () {
                        if(type==4){
                            $('.addRow').hide()
                        }
                    }
                });

            }
        });
    }
</script>
</body>
</html>

