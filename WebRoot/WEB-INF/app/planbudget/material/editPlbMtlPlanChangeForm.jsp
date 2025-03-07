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
    <title>材料需求计划变更表单操作</title>

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
<div class="container">
    <div class="wrapper">

    </div>
   <%-- <div style="text-align: center;margin-top: 35px;">
        <button class="layui-btn layui-btn-normal" id="save">保存</button>
    </div>--%>
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
    var runId =  $.GetRequest()['runId'] || '';
    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {}
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
    });

    layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var xmSelect = layui.xmSelect;

        element.render();
        fileuploadFn('#fileupload', $('#fileContent'));

        //回显数据
        $.get('/plbMtlPlan/queryHistoryVersionByRunId', {runId: runId,reviseType:'09'}, function (res) {
            if (res.flag) {
                var data=res.data
                var content=''
                data.forEach(function (item,index) {
                    content=['<div class="layui-collapse">\n' ,
                        /* region 材料计划 */
                        '  <div class="layui-colla-item">\n' +
                        '    <h2 class="layui-colla-title">材料计划</h2>\n' +
                        '    <div class="layui-colla-content layui-show plan_base_info">' +
                        '       <form class="layui-form" lay-filter="formTest">',
                        /* region 第一行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">计划单编号<span field="planNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="planNo" value="'+(item.planNo || '')+'" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">计划名称<span field="planName" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="planName" value="'+(item.planName || '')+'" readonly autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">计划时间<span field="planDate" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="planDate" value="'+(item.planDate || '')+'" readonly  autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' ,
                        /* endregion */
                        /* region 第二行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">管理目标数量<span field="budgetItemId" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
                        '                       <input type="text" name="totalManagementTarget"  value="'+(item.totalManagementTarget || '')+'" readonly autocomplete="off" class="layui-input chooseManagementBudget" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">WBS<span field="wbsId" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="wbsId" value="'+(item.wbsName || '')+'" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">CBS<span field="cbsId" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="cbsId" value="'+(item.cbsName || '')+'" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' ,
                        /* endregion */
                        /* region 第三行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">控制方式<span field="controlMode" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="controlMode" value="'+(item.controlMode ? dictionaryObj['CONTROL_TYPE']['object'][item.controlMode] : '')+'" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">计量单位</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="valuationUnit" value="'+(item.valuationUnit ? dictionaryObj['CBS_UNIT']['object'][item.valuationUnit] : '')+'" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">管理目标总价</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" readonly name="mgeTargetPrice"  value="'+(item.mgeTargetPrice || '')+'"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' ,
                        /* endregion */
                        /* region 第四行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">累计已提需求计划量</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" readonly name="addupNeedAmount" value="'+(item.addupNeedAmount || '')+'" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">在途需求计划量</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" readonly name="onwayAmount" value="'+(item.onwayAmount || '')+'"  autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">需用日期<span field="useDate" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="useDate" readonly  value="'+format(item.useDate)+'"  autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' ,
                        /* endregion */
                        /* region 第六行*/
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">剩余可提需求计划金额</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" readonly name="surplusMoney" value="'+(item.surplusMoney || '')+'" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">需求计划量<span field="planAmount" class="field_required">*</span></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="planAmount" value="'+(item.planAmount || '')+'" readonly autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">需求计划金额</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="planMoney" readonly value="'+(item.planMoney || '')+'" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' ,
                        /* endregion */
                        /* region 第七行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">备注</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="remark"  value="'+(item.remark || '')+'" readonly  autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' ,
                        /* endregion */
                        /* region 第八行 */
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">附件</label>' +
                        '                       <div class="layui-input-block form_block">' +
                        '<div class="file_module">' +
                        '<div id="fileContent" class="file_content">' +
                        function () {
                            if (item.attachmentList && item.attachmentList.length > 0) {
                                var fileArr = item.attachmentList;
                                var str = '';
                                for (var i = 0; i < fileArr.length; i++) {
                                    var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                    var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

                                    str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
                                }
                               return str
                            }else{
                                return ''
                            }
                        }()+
                        '</div>' +
                       /* '<div class="file_upload_box">' +
                        '<a href="javascript:;" class="open_file">' +
                        '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                        '</a>' +
                        '<div class="progress" id="progress">' +
                        '<div class="bar"></div>\n' +
                        '</div>' +
                        '<div class="bar_text"></div>' +
                        '</div>' +*/
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
                        /* region 材料明细 */
                        '  <div class="layui-colla-item">\n' +
                        '    <h2 class="layui-colla-title">材料明细</h2>\n' +
                        '    <div class="layui-colla-content mtl_info layui-show">' +
                        '       <div>' +
                        '           <table id="materialDetailsTable'+index+'" lay-filter="materialDetailsTable"></table>' +
                        '      </div>' +
                        '    </div>\n' +
                        '  </div>\n' ,
                        /* endregion */
                        /* region 其他 */
                        '  <div class="layui-colla-item">\n' +
                        '    <h2 class="layui-colla-title">其他</h2>\n' +
                        '    <div class="layui-colla-content other_info layui-show">' ,
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">编制人<span style="margin: 0 10px;">流程定义某节点为编制节点</span>编制时间</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="createTime" value="'+format(item.createTime)+'" readonly autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                     <label class="layui-form-label form_label">审核人<span style="margin: 0 10px;">流程定义某节点为审核节点</span>审核时间</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="approvalDate" value="'+format(item.approvalDate)+'" readonly autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">审批人<span style="margin: 0 10px;">流程定义某节点为审批节点</span>审批时间</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="auditerDate"  value="'+format(item.auditerDate)+'" readonly autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' +
                        '   </div>' ,
                        /* endregion */
                        '  </div>\n' +
                        '</div>'].join('')
                    $('.wrapper').append(content)

                    var materialDetailsTableData=[]

                    materialDetailsTableData = item.listWithBLOBs ? item.listWithBLOBs  : [];

                    element.render();
                    form.render();

                    table.render({
                        elem: '#materialDetailsTable'+index,
                        data: materialDetailsTableData,
                       /* toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],*/
                        limit: 1000,
                        cols: [[
                            {type: 'numbers', title: '操作'},
                            {
                                field: 'planMtlName', title: '材料名称', width: 200, templet: function (d) {
                                    return '<input mtlPlanListId="' + (d.mtlPlanListId || '') + '" readonly type="text" name="planMtlName" class="layui-input" style="width: 90%;height: 100%;" value="' + (d.planMtlName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
                                }
                            },
                            {
                                field: 'planMtlStandard', title: '材料规格', templet: function (d) {
                                    return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;" value="' + (d.planMtlStandard || '') + '">'
                                }
                            },
                            {
                                field: 'valuationUnit', title: '计量单位',
                                templet: function (d) {
                                    return '<input type="text" valuationUnit="'+d.valuationUnit+'" name="valuationUnit" readonly class="layui-input chooseMtlUnit" style="height: 100%;cursor: pointer;" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                                }
                            },
                            {
                                field: 'directUnitPrice', title: '指导单价',
                            },
                            {
                                field: 'estiUnitPrice', title: '预计单价', templet: function (d) {
                                    return '<input type="text" name="estiUnitPrice" class="layui-input" readonly style="height: 100%;" value="' + (d.estiUnitPrice || '') + '">'
                                }
                            },
                            {
                                field: 'thisAmount', title: '本次数量', templet: function (d) {
                                    return '<input type="text" name="thisAmount" class="layui-input" readonly style="height: 100%;" value="' + (d.thisAmount || '') + '">'
                                }
                            },
                            {
                                field: 'usePlace', title: '使用部位', templet: function (d) {
                                    return '<input type="text" name="usePlace" class="layui-input" readonly style="height: 100%;" value="' + (d.usePlace || '') + '">'
                                }
                            },
                            // {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                        ]]
                    });
                })
            } else {
                layer.msg('获取信息失败！', {icon: 2});
            }
        });

        // 内部加行按钮
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    // 判断控制方式
                    var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';

                    if (!controlMode) {
                        layer.msg('请选择管理目标', {icon: 0, time: 1500});
                        return false;
                    }
                    var valuationUnit = '';
                    if (controlMode == '01') {
                        valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';
                    }

                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            planMtlName: $(this).find('input[name="planMtlName"]').val(),
                            planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                            valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                            directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                            estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                            thisAmount: $(this).find('input[name="thisAmount"]').val(),
                            usePlace: $(this).find('input[name="usePlace"]').val(),
                            mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId')
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    var addRowData = {
                        valuationUnit: valuationUnit
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
                if (data.mtlPlanListId) {
                    $.get('/plbMtlPlanList/deleteByMtlPlanListIds', {mtlPlanListIds: data.mtlPlanListId}, function(res){

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        planMtlName: $(this).find('input[name="planMtlName"]').val(),
                        planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                        valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                        directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                        estiUnitPrice: $(this).find('input[name="estiUnitPrice"]').val(),
                        thisAmount: $(this).find('input[name="thisAmount"]').val(),
                        usePlace: $(this).find('input[name="usePlace"]').val(),
                        mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId'),
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });
    });
</script>
</body>
</html>