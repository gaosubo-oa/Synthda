<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/22
  Time: 9:41
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
    <title>其他费用需求计划流程审批</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108311508"></script>

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
        .layui-col-xs4{
            width:20%
        }
        .back{
            background-color: #F2F2F2;
        }
    </style>
</head>
<body>

<div class="container" id="htm"></div>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>


<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

   var runId = getQueryString("runId");

    var _disabled = getQueryString('disabled');
    //var type = getQueryString("type");
    var type;
    if('0'!=_disabled){
        type = 4
    }else {
        type = 1
    }

    var data = null

    var htm = ['<div class="layui-collapse">\n' ,
        /* region 材料计划 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">其他费用需求计划</h2>\n' +
        '    <div class="layui-colla-content layui-show plan_base_info">' +
        '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
        /* region 第一行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="documnetNum" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" style="background:#e7e7e7;" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">需求计划名称<span field="reiPlanName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="reiPlanName" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">编制时间<span field="createDate" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="createDate" readonly id="createDate" autocomplete="off" class="layui-input" style="background:#e7e7e7;width: 53%;display: inline-block">\n' +
        '                     <button type="button" class="layui-btn  layui-btn-sm chooseManagementBudget">选择管理目标</button>'+
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">WBS<span field="wbsName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="wbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '           </div>' ,
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">RBS<span field="rbsName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="rbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">CBS<span field="cbsName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="cbsName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">控制方式<span field="controlType" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="controlType"  readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">单位</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="itemUnit" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">管理目标数量<span field="manageTarNum" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
        '                       <input type="text" name="manageTarNum" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' ,
        /* endregion */
        /* region 第三行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">管理目标金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="manageTarAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 " style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">累计已发生报销金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="realOutMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 " style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">在途报销金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="trnAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 " style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次需求计划金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="estimateAmountSum"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">需用日期<span field="needDate" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="needDate" id="needDate" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' ,
        '           </div>' ,
        /* endregion */
        /* region 第四行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">备注</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="memo" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>',
        '           </div>',
        /* endregion */
        /* region 第五行 */
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
        '<input type="file" multiple id="fileupload" data-url="/upload?module=costReiPlanList" name="file">' +
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
        '           </div>' ,
        /* endregion */
        '       </form>' +
        '    </div>\n' +
        '  </div>\n' ,
        /* endregion */
        /* region 需求计划明细 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">需求计划明细</h2>\n' +
        '    <div class="layui-colla-content mtl_info layui-show">' +
        '       <div>' +
        '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
        '      </div>' +
        '    </div>\n' +
        '  </div>\n' ,
        /* endregion */
        '</div>'].join('');

    $("#htm").html(htm)

    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {},
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT';
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
        initPage();
    });


    function initPage() {
        layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            var eleTree = layui.eleTree;
            var layer = layui.layer;


            var param = {};
            var fla = true;
            if(runId){
                param.runId=runId;
            }else{
                fla = false;
                layer.msg("信息获取失败！")
                return false;
            }
            if(fla){
                $.ajax({
                    url:"/otherCostReiPlan/getById",
                    data:param,
                    dataType:"json",
                    success:function(res){
                        if(res.code===0||res.code==="0"){
                             data = res.obj;

                            fileuploadFn('#fileupload', $('#fileContent'));
                            //回显项目名称
                            getProjName('#projectName',data.projectId)

                            if(type != 4){
                                laydate.render({
                                    elem: '#needDate' //指定元素
                                    , trigger: 'click' //采用click弹出
                                    // , value: data ? format(data.needDate) : ''
                                });
                            }
                            var reiPlanListData = [];

                            //回显数据
                            if (type == 1 || type == 4) {

                                form.val("formTest", data);

                                $('.plan_base_info input[name="wbsName"]').attr('wbsId', data.wbsId || '');
                                $('.plan_base_info input[name="rbsName"]').attr('rbsId', data.rbsId || '');
                                $('.plan_base_info input[name="cbsName"]').attr('cbsId', data.cbsId || '');
                                // 控制方式
                                $('.plan_base_info input[name="controlType"]').val(dictionaryObj['CONTROL_TYPE']['object'][data.controlType] || '');
                                $('.plan_base_info input[name="controlType"]').attr('controlType', data.controlType || '');
                                // 单位
                                $('.plan_base_info input[name="itemUnit"]').val(dictionaryObj['CBS_UNIT']['object'][data.itemUnit] || '');
                                $('.plan_base_info input[name="itemUnit"]').attr('itemUnit', data.itemUnit || '');

                                if (data.attachmentList && data.attachmentList.length > 0) {
                                    var fileArr = data.attachmentList;
                                    $('#fileContent').append(echoAttachment(fileArr));
                                }

                                reiPlanListData = data.reiPlanList;

                                //查看详情
                                if(type==4){
                                    $('.plan_base_info input').attr('readonly', true);
                                    $('.file_upload_box').hide()
                                    $('.deImgs').hide()
                                    $('.chooseManagementBudget').hide()
                                }
                            }else{
                                // 获取自动编号
                                getAutoNumber({autoNumberType: 'otherCostReiPlan'}, function(res) {
                                    $('input[name="documnetNum"]', $('#baseForm')).val(res.obj);
                                    $('#createDate').val(res.object.createDate)
                                });
                                $('.refresh_no_btn').show().on('click', function() {
                                    getAutoNumber({autoNumberType: 'otherCostReiPlan'}, function(res) {
                                        $('input[name="documnetNum"]', $('#baseForm')).val(res.obj);
                                        $('#createDate').val(res.object.createDate)
                                    });
                                });
                            }

                            element.render();
                            form.render();

                            var cols=[
                                {type: 'numbers', title: '操作'},
                                {
                                    field: 'planListName', title: '名称', templet: function (d) {
                                        return '<input type="text" name="planListName" reiPlanId="'+(d.reiPlanId || '')+'" reiPlanListId="'+(d.reiPlanListId || '')+'" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.planListName || '') + '">'
                                    }
                                },
                                {
                                    field: 'departName', title: '单位', templet: function (d) {
                                        return '<input type="text" name="departName" class="layui-input" style="height: 100%;cursor: pointer" value="' + (d.departName || '') + '">'
                                    }
                                },
                                {
                                    field: 'currNum', title: '本次数量', templet: function (d) {
                                        return '<input type="number" name="currNum"  class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.currNum || '') + '">'
                                    }
                                },
                                {
                                    field: 'estimatePrice', title: '预计单价', templet: function (d) {
                                        return '<input type="number" name="estimatePrice" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimatePrice || '') + '">'
                                    }
                                },
                                {
                                    field: 'estimateAmount', title: '预计金额', templet: function (d) {
                                        return '<input type="number" name="estimateAmount" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.estimateAmount || '') + '">'
                                    }
                                },
                                {
                                    field: 'usePosition', title: '使用部位', templet: function (d) {
                                        return '<input type="text" name="usePosition" class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.usePosition || '') + '">'
                                    }
                                },
                            ]
                            if(type!=4){
                                cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                            }
                            table.render({
                                elem: '#materialDetailsTable',
                                data: reiPlanListData,
                                toolbar: '#toolbarDemoIn',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols],
                                done:function () {
                                    if(type==4){
                                        $('.addRow').hide()
                                        $('.mtl_info input').attr('readonly', true);
                                    }
                                }
                            })
                            element.render();
                            form.render()
                        }else{
                            layer.msg("信息获取失败！")
                            return false;
                        }
                    }
                })
            }

            // 内部加行按钮
            table.on('toolbar(materialDetailsTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        //遍历表格获取每行数据进行保存
                        var oldDataArr = materialDetailsData();

                        var addRowData = {
                            //valuationUnit: valuationUnit
                        };
                        oldDataArr.push(addRowData);
                        table.reload('materialDetailsTable', {
                            data: oldDataArr
                        });
                        break;
                }
            });
            // 内部删行操作
            table.on('tool(materialDetailsTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                if (layEvent === 'del') {
                    obj.del();
                    if (data.reiPlanListId) {
                        $.get('/otherCostReiPlan/delReiBud', {ids: data.reiPlanListId}, function(res){

                        });
                    }
                    //遍历表格获取每行数据进行保存
                    var oldDataArr = materialDetailsData();

                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });

                    //本次需求计划金额
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var estimateAmountSum=0
                    $tr.each(function () {
                        estimateAmountSum=accAdd(estimateAmountSum,$(this).find('input[name="estimateAmount"]').val())
                    });
                    $('#baseForm [name="estimateAmountSum"] ').val(retainDecimal(estimateAmountSum,2)||0)
                }
            });

            $(document).on('click', '.chooseManagementBudget', function() {

                var wbsSelectTree = null;
                var cbsSelectTree = null;
                var _this = $(this);
                layer.open({
                    type: 1,
                    title: '管理目标选择',
                    area: ['100%', '100%'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="layui-form" id="objectives">' +
                    //下拉选择
                    '           <div class="layui-row" style="margin-top: 10px">' +
                    '               <div class="layui-col-xs2">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                    '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                    '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs2">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                    '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                    '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs3">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label">WBS</label>\n' +
                    '                       <div class="layui-input-block">\n' +
                    '<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs3">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label">CBS</label>\n' +
                    '                       <div class="layui-input-block">\n' +
                    '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs2">' +
                    '<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 0 0 10px;">搜索<i class="layui-icon layui-icon-search" style="margin: 0 0 0 3px;"></i></button>' +
                    '               </div>' +
                    '           </div>' +
                    //表格数据
                    '       <div style="padding: 10px">' +
                    '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                    '      </div>' +
                    '</div>'].join(''),
                    success: function () {
                        // 获取WBS数据
                        $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId')}, function (res) {
                            wbsSelectTree = xmSelect.render({
                                el: '#wbsSelectTree',
                                content: '<div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                                name: 'wbsName',
                                prop: {
                                    name: 'wbsName',
                                    value: 'id'
                                }
                            });

                            eleTree.render({
                                elem: '#wbsTree',
                                data: res.obj,
                                highlightCurrent: true,
                                showLine: true,
                                defaultExpandAll: false,
                                request: {
                                    name: 'wbsName',
                                    children: "child"
                                }
                            });

                            // 树节点点击事件
                            eleTree.on("nodeClick(wbsTree)", function (d) {
                                var currentData = d.data.currentData;
                                var obj = {
                                    wbsName: currentData.wbsName,
                                    id: currentData.id
                                }
                                wbsSelectTree.setValue([obj]);
                            });
                        });

                        // 获取CBS数据
                        $.get('/plbCbsType/getAllList', function (res) {
                            cbsSelectTree = xmSelect.render({
                                el: '#cbsSelectTree',
                                content: '<div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                name: 'cbsName',
                                prop: {
                                    name: 'cbsName',
                                    value: 'cbsId'
                                }
                            });

                            eleTree.render({
                                elem: '#cbsTree',
                                data: res.data,
                                highlightCurrent: true,
                                showLine: true,
                                defaultExpandAll: false,
                                request: {
                                    name: 'cbsName',
                                    children: "childList"
                                }
                            });

                            // 树节点点击事件
                            eleTree.on("nodeClick(cbsTree)", function (d) {
                                var currentData = d.data.currentData;
                                var obj = {
                                    cbsName: currentData.cbsName,
                                    cbsId: currentData.cbsId
                                }
                                cbsSelectTree.setValue([obj]);
                            });
                        });

                        laodTable();

                        $('.search_mtl').on('click', function(){
                            var cbsId = cbsSelectTree.getValue('valueStr');
                            var wbsId = wbsSelectTree.getValue('valueStr');
                            var itemNo = $('[name="itemNo"]').val();
                            var itemName =$('[name="itemName"]').val();

                            laodTable(wbsId, cbsId,itemNo,itemName);
                        });

                        // 加载表格
                        function laodTable(wbsId, cbsId,itemNo,itemName) {
                            table.render({
                                elem: '#managementBudgetTable',
                                url: '/manageProject/getBudgetByProjId',
                                where: {
                                    projId: $('#leftId').attr('projId'),
                                    wbsId: wbsId || '',
                                    cbsId: cbsId || '',
                                    itemNo: itemNo || '',
                                    itemName: itemName || '',
                                    rbsTyep:'other'
                                },
                                page: true,
                                limit: 20,
                                request: {
                                    limitName: 'pageSize'
                                },
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    countName: 'count',
                                    dataName: 'data'
                                },
                                cols: [[
                                    {type: 'radio'},
                                    {
                                        field: 'wbsName', title: 'WBS',minWidth:100, templet: function(d) {
                                            var str = '';
                                            if (d.plbProjWbs) {
                                                str = d.plbProjWbs.wbsName;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'rbsName', title: 'RBS',minWidth:200, templet: function(d) {
                                            var str = '';
                                            if (d.plbRbs) {
                                                str = d.plbRbs.rbsLongName;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'cbsName', title: 'CBS',minWidth:100, templet: function (d) {
                                            var str = '';
                                            if (d.plbCbsTypeWithBLOBs) {
                                                str = d.plbCbsTypeWithBLOBs.cbsName;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'controlType', title: '控制类型', minWidth:120,templet: function (d) {
                                            return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                        }
                                    },
                                    {
                                        field: 'rbsUnit', title: '单位',minWidth:120, templet: function (d) {
                                            var str = '';
                                            if (d.plbRbs) {
                                                str = dictionaryObj['CBS_UNIT']['object'][d.plbRbs.rbsUnit] || '';
                                            }
                                            return str;
                                        }
                                    },
                                    // {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                    // {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                    {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                    // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                    {field: 'monQuata', title: '截止当前额度',minWidth:170},
                                    {field: 'realOutMoney', title: '截止当前已发生额度',minWidth:170},
                                    //{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                    //{field: 'manageestimateAmountSum', title: '管理目标金额余额',minWidth:150},
                                ]],
                                done:function(res){
                                    var _dataa=res.data;
                                    var _projBudgetId = $(_this).attr('projBudgetId')
                                    if(_projBudgetId){
                                        for(var i = 0 ; i <_dataa.length;i++){
                                            if(_dataa[i].projBudgetId == _projBudgetId){
                                                $('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
                                                //form.render('checkbox');
                                            }
                                        }
                                    }

                                }
                            });
                        }
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('managementBudgetTable').data[0];
                        if (checkStatus) {
                            $(_this).attr('projBudgetId',checkStatus.projBudgetId)
                            $('[name="wbsName"]').val(checkStatus.plbProjWbs?checkStatus.plbProjWbs.wbsName:'')
                            $('[name="wbsName"]').attr('wbsId',checkStatus.plbProjWbs?checkStatus.plbProjWbs.wbsId:'')
                            $('[name="cbsName"]').val(checkStatus.plbCbsTypeWithBLOBs?checkStatus.plbCbsTypeWithBLOBs.cbsName:'')
                            $('[name="cbsName"]').attr('cbsId',checkStatus.plbCbsTypeWithBLOBs?checkStatus.plbCbsTypeWithBLOBs.cbsId:'')
                            $('[name="rbsName"]').val(checkStatus.plbRbs?checkStatus.plbRbs.rbsLongName:'')
                            $('[name="rbsName"]').attr('rbsId',checkStatus.plbRbs?checkStatus.plbRbs.rbsId:'')
                            $('[name="controlType"]').val(dictionaryObj['CONTROL_TYPE']['object'][checkStatus.controlType] || '')
                            $('[name="controlType"]').attr('controlType',checkStatus.controlType||'')
                            $('[name="itemUnit"]').val(checkStatus.plbRbs?dictionaryObj['CBS_UNIT']['object'][checkStatus.plbRbs.rbsUnit]:'')
                            $('[name="itemUnit"]').attr('itemUnit',checkStatus.plbRbs?checkStatus.plbRbs.rbsUnit:'')
                            $('[name="manageTarNum"]').val(retainDecimal(checkStatus.manageTarNum,3)||'0')
                            $('[name="manageTarAmount"]').val(retainDecimal(checkStatus.manageTarAmount,2)||'0')
                            $('[name="realOutMoney"]').val(retainDecimal(checkStatus.realOutMoney,2)||'0')
                            $('[name="trnAmount"]').val(retainDecimal(checkStatus.trnApplicationAmount,2)||'0')


                            layer.close(index);

                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                });

            });

        })
    }

    //监听本次数量
    $(document).on('input propertychange', 'input[name="estimateAmount"]', function () {
        if($('#leftId').attr('_type')=='4'){
            return false
        }

        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var estimateAmountSum=0
        $tr.each(function () {
            estimateAmountSum=accAdd(estimateAmountSum,$(this).find('input[name="estimateAmount"]').val())
        });
        $('#baseForm [name="estimateAmountSum"] ').val(retainDecimal(estimateAmountSum,2)||0)
    });

    function materialDetailsData(){
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var materialDetailsArr = [];
        $tr.each(function () {
            var materialDetailsObj = {
                planListName: $(this).find('input[name="planListName"]').val()||'',
                departName: $(this).find('input[name="departName"]').val()||'',
                currNum: retainDecimal($(this).find('input[name="currNum"]').val(),3)||'',
                estimatePrice: retainDecimal($(this).find('input[name="estimatePrice"]').val(),3)||'',
                estimateAmount: retainDecimal($(this).find('input[name="estimateAmount"]').val(),2)||'',
                usePosition: $(this).find('input[name="usePosition"]').val()
            }
            if ($(this).find('input[name="planListName"]').attr('reiPlanId')) {
                materialDetailsObj.reiPlanId = $(this).find('input[name="planListName"]').attr('reiPlanId');
            }
            if ($(this).find('input[name="planListName"]').attr('reiPlanListId')) {
                materialDetailsObj.reiPlanListId = $(this).find('input[name="planListName"]').attr('reiPlanListId');
            }
            materialDetailsArr.push(materialDetailsObj);
        });
        return materialDetailsArr
    }


    function childFunc() {
        if('0'!=_disabled){
            return true
        }
        var loadIndex = layer.load();
        //材料计划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });
        obj.wbsId = $('.plan_base_info input[name="wbsName"]').attr('wbsId') || '';
        obj.rbsId = $('.plan_base_info input[name="rbsName"]').attr('rbsId') || '';
        obj.cbsId = $('.plan_base_info input[name="cbsName"]').attr('cbsId') || '';
        // 控制方式
        obj.controlType = $('.plan_base_info input[name="controlType"]').attr('controlType') || '';
        // 单位
        obj.itemUnit = $('.plan_base_info input[name="itemUnit"]').attr('itemUnit') || '';

        obj.projBudgetId = $('.plan_base_info .chooseManagementBudget').attr('projBudgetId') || '';
        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;
        //需求计划明细
        obj.reiPlanList = materialDetailsData();

        // 判断必填项
        var requiredFlag = false;
        $('#baseForm').find('.field_required').each(function(){
            var field = $(this).attr('field');
            if (!obj[field]) {
                var fieldName = $(this).parent().text().replace('*', '');
                layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                requiredFlag = true;
                return false;
            }
        });

        if(accAdd(accAdd(obj.realOutMoney,obj.trnAmount),obj.estimateAmountSum)>obj.manageTarAmount){
            layer.msg('累计已发生报销金额+在途报销金额+本次需求计划金额<=管理目标金额', {icon: 0, time: 3000});
            requiredFlag = true;
        }

        if (requiredFlag) {
            layer.close(loadIndex);
            return false;
        }

        if (type == 1) {
            obj.reiPlanId = data.reiPlanId
        }else{
            obj.projectId = parseInt(projId);
        }


        var _flag = false;

        $.ajax({
            url: '/otherCostReiPlan/updateById',
            data: JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.code=='0') {
                    layer.msg('保存成功！', {icon: 1});
                    /*layer.close(index);
                    tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();*/
                } else {
                    layer.msg(res.msg, {icon: 2});
                    _flag = true
                }
            }
        });

        if(_flag){
            return false;
        }
        return true;

    }
    function getAutoNumber(params, callback) {
        $.get('/planningManage/autoNumber', params, function (res) {
            callback(res);
        });
    }


</script>
</body>
</html>
