<%--
  Created by IntelliJ IDEA.
  User: 陈晟
  Date: 2021/4/2
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
    <title>经营跟踪</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js?20210413.1"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <%--<script src="/js/technical/technical.js?20210723"></script>--%>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>

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

        .layui-table-view .layui-table td {
            cursor: pointer;
        }


        #scrollModule {
            width: 70%;
            height: 100%;
            margin: 0 auto;
            padding: 10px 0;
            overflow-y: auto;
            overflow-x: hidden;
            box-sizing: border-box;
        }

        .label_item {
            padding: 4px 0;
        }

        .label_ttile {
            display: inline-block;
            width: 100px;
            text-align: left;
        }

        .label_con {
            display: inline-block;
            width: 55%;
            min-width: 300px;
            text-align: left;
        }

        .del_btn {
            float: right;
            margin-right: 50%;
        }

        .mtl_info .layui-table-cell,.mtl_info .layui-table-box,.mtl_info .layui-table-body {
            overflow: visible;
        }
        /* 设置下拉框的高度与表格单元格的高度相同 */
        .mtl_info td .layui-form-select {
            margin-top: -10px;
            margin-left: -15px;
            margin-right: -15px;
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
        .openFile input[type=file]{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        .mtl_info td[data-field="attachmentName"] .layui-table-cell{
            height: auto;
            overflow:visible;
            text-overflow:inherit;
            white-space:normal;
            word-break: break-word;
        }

        .layui-col-xs4{
            width: 20%;
        }
        .displayNone{
            display: none;
        }
    </style>
</head>
<body>

<div class="container" id="htm"></div>

<script type="text/html" id="delTarckTool">
    <button class="layui-btn layui-btn-xs" lay-event="add">加行</button>
</script>
<script type="text/html" id="toolbarDemoIn">
    {{#  if(!d.detailsStatus||d.detailsStatus=="0"){ }}
    <a class="layui-btn layui-btn-danger layui-btn-xs addRow" lay-event="del">删行</a>
    {{#  } }}

</script>
<script type="text/html" id="delTarckTool2">
    <button class="layui-btn layui-btn-xs" lay-event="add2">加行</button>
</script>
<script type="text/html" id="toolbarDemoIn2">
    {{#  if(!d.detailsStatus||d.detailsStatus=="0"){ }}
    <a class="layui-btn layui-btn-danger layui-btn-xs addRow" lay-event="del2">删行</a>
    {{#  } }}

</script>
<script type="text/html" id="internalBar">
    {{#  if(!d.detailsStatus||d.detailsStatus=="0"){ }}
    <a href="javascript:;" class="openFile" style="position:relative;" lay-event="butfile">
        <button type="button"  class="layui-btn layui-btn-xs" style="margin-right:10px;">
            <i class="layui-icon" >&#xe67c;</i>附件上传
        </button>
        <input type="file" multiple id={{"fileupload"+d.LAY_INDEX}} data-url="/upload?module=operateTarck"  name="file">
    </a>
    {{#  } }}

</script>
<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
   var registerId = getQueryString("manageTrackId");
   var runId = getQueryString("runId");

    var _disabled = getQueryString('disabled');
    var type = getQueryString("type");
    if('0'!=_disabled){
        type = 4
    }else {
        type = 2
    }

    var detaListData=[];
    var tracListData=[];

    var htm = '<div class="layui-collapse _disabled"> \n' +
        <%--    /* region 材料计划 */--%>
        '      <div class="layui-colla-item"> \n' +
        '            <div class="layui-colla-content layui-show plan_base_info"> \n' +
        '                   <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
        <%--                /* region 第一行 */--%>
        '                           <div class="layui-row"> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <input type="text" name="documnetNum" id="documnetNum" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                                                   </div> \n' +
        '                                            </div> \n' +
        '                                   </div> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                                                   </div> \n' +
        '                                            </div> \n' +
        '                                   </div> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">经营立项名称<span field="manageProjName" class="field_required">*</span></label>\n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                         <i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>' +
        '                                                       <input type="text" name="manageProjName" placeholder="请选择经营立项" style="cursor: pointer;background: #e7e7e7" id="manageProjName" readonly autocomplete="off" class="layui-input">\n' +
        '                                                       <input type="hidden" name="manageProjId"  id="manageProjId" readonly autocomplete="off" class="layui-input">\n' +
        '                                                    </div> \n' +
        '                                            </div> \n' +
        '                                   </div> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">经营立项编号<span field="manageProjNum" class="field_required">*</span></label> \n' +
        '                                                   <div class="layui-input-block form_block">\n' +
        '                                                       <input type="text" name="manageProjNum" id="manageProjNum" readonly autocomplete="off" class="layui-input " >\n' +
        '                                                   </div> \n' +
        '                                            </div> \n' +
        '                                    </div> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">预计变更收入<span field="estimateChangeInf" class="field_required">*</span></label>\n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <input type="text" name="estimateChangeInf" id="estimateChangeInf" readonly  autocomplete="off" class="layui-input" >\n' +
        '                                                   </div> \n' +
        '                                            </div> \n' +
        '                                   </div> \n' +
        /*'                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">经营立项类型<span field="manageProjType" class="field_required">*</span></label> \n' +
        '                                                   <div class="layui-input-block form_block">\n' +
        '                                                       <input type="text" name="totalManagementTargetName" id="totalManagementTargetName"  readonly autocomplete="off" class="layui-input " >\n' +
        '                                                   </div> \n' +
        '                                           </div> \n' +
        '                                   </div> \n' +*/
        '                            </div> \n' +
        <%--                /* endregion */--%>
        <%--                /* region 第二行 */--%>
        // '                           <div class="layui-row"> \n' +
        //
        // '                           </div> \n' +
        <%--                /* endregion */--%>
        <%--                /* region 第三行 */--%>
        '                           <div class="layui-row"> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">甲方确认后收入<span field="firstConfirmInf" class="field_required">*</span></label>\n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <input type="text" name="firstConfirmInf" id="firstConfirmInf" readonly autocomplete="off" class="layui-input">\n' +
        '                                                   </div> \n' +
        '                                           </div> \n' +
        '                                   </div> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">填报人<span field="controlMode" class="field_required">*</span></label> \n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <input type="text" name="createUserName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7" disabled>\n' +
        '                                                   </div> \n' +
        '                                            </div> \n' +
        '                                   </div> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">填报时间</label> \n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <input type="text" name="createTime" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7" disabled>\n' +
        // '                                                       <button type="button" id="choBtn" class="layui-btn layui-btn-xs" style="position: absolute;right: -98px;top: 0;height: 37px;font-size: 12px">选择跟踪目标</button>\n' +
        '                                                   </div>\n' +
        '                                            </div> \n' +
        '                                    </div> \n' +
        '                                   <div class="layui-col-xs4" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">备注</label> \n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <input type="text" name="demo" readonly autocomplete="off" class="layui-input"  >\n' +
        '                                                   </div> \n' +
        '                                            </div> \n' +
        '                                   </div> \n' +
        '                            </div> \n' +
        <%--                /* endregion */--%>
        <%--                /* region 第四行 */--%>
        '                           <div class="layui-row"> \n' +
        '                                   <div class="layui-col-xs6" style="padding: 0 5px;"> \n' +
        '                                           <div class="layui-form-item"> \n' +
        '                                                   <label class="layui-form-label form_label">项目立项内容<span field="manageProjCon" class="field_required">*</span></label> \n' +
        '                                                   <div class="layui-input-block form_block"> \n' +
        '                                                       <textarea name="manageProjCon" id="manageProjCon" readonly placeholder="请输入立项内容" class="layui-textarea"></textarea> \n' +
        '                                                   </div> \n' +
        '                                           </div> \n' +
        '                                   </div> \n' +
        '                            </div> \n' +
        <%--                /* endregion */--%>
        '                       </form> \n' +
        '                </div> \n' +
        '          </div> \n' +
        <%--    /* endregion */--%>
        <%--    /* region 进展明细 */--%>
        '      <div class="layui-colla-item"> \n' +
        '            <h2 class="layui-colla-title">进展明细</h2> \n' +
        '            <div class="layui-colla-content mtl_info layui-show"> \n' +
        <%--            /* region 第五行 */--%>
        '                <div class="layui-row">\n' +
        '                      <table id="detTarckTable" lay-filter="detTarckTable" class="layui-table"></table>\n' +
        '                </div> \n' +
        '            </div> \n' +
        '       </div> \n' +
        <%--    /* endregion */--%>
        <%--    /* region*/--%>
        '      <div class="layui-colla-item"> \n' +
        '            <h2 class="layui-colla-title">甲方确认</h2>\n' +
        '            <div class="layui-colla-content other_info layui-show"> \n' +
        <%--            /* region 第八行 */--%>
        '                 <div class="layui-row"> \n' +
        '                    <table id="otherTrackTab" lay-filter="otherTrackTab" class="layui-table"></table>\n' +
        '                 </div>\n' +
        <%--            /* region*/--%>
        '            </div>\n' +
        '        </div>\n' +
        '    </div>';
    $("#htm").html(htm)

    var dictionaryObj = {
        MANAGE_ITEM_TYPE: {},
        OUR_PROGRESS:{},
        CONSTRUCTION_UNIT_PRO:{}
    }
    var dictionaryStr = 'MANAGE_ITEM_TYPE,OUR_PROGRESS,CONSTRUCTION_UNIT_PRO';
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
        layui.use(['form', 'table', 'element', 'soulTable', 'eleTree','upload', 'flow','laydate'], function () {
            var form = layui.form,
                table = layui.table,
                element = layui.element,
                soulTable = layui.soulTable,
                eleTree = layui.eleTree,
                upload=layui.upload,
                layFlow = layui.flow,
                laydate = layui.laydate;


            var param = {};
            var fla = true;
            if(runId){
                param.runId=runId;
            }else if(registerId){
                param.registerId=registerId;
            }else{
                fla = false;
                layer.msg("信息获取失败！")
                return false;
            }
            if(fla){
                $.ajax({
                    url:"/operateTarck/getById",
                    data:param,
                    dataType:"json",
                    success:function(res){
                        if(res.code===0||res.code==="0"){
                            var data = res.obj;
                            if(data.detailList!=undefined){
                                detaListData=data.detailList;
                            }
                            if(data.tarckConfirmList!=undefined){
                                tracListData=data.tarckConfirmList;
                            }
                            //回显数据
                            if (data != undefined) {
                                //回显项目名称
                                getProjName('#projectName',data.projId)

                                form.val("baseForm", data);
                            }
                            table.render({
                                elem: '#detTarckTable',
                                data: detaListData,
                                toolbar: type==4?false:'#delTarckTool',
                                cols: [[
                                    {type: 'numbers', title: '序号',},
                                    {
                                        field: 'tarckDetailsDate',
                                        title: '日期',
                                        sort: true,
                                        minWidth: 60,
                                        event: 'dateSelection',
                                        templet: function (d) {
                                            return '<input type="text" manageTrackDetailedId="'+(d.manageTrackDetailedId||'')+'" detailsStatus="'+(d.detailsStatus||'')+'" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'disabled')+' name="tarckDetailsDate" class="layui-input" style="height: 100%;" value="' + (d.tarckDetailsDate || '') + '">'
                                        }
                                    },
                                    {field: 'ourProgress', title: '我方进展', minWidth: 100, templet: function (d) {
                                            var optionStr = '<option value="">请选择</option>';
                                            if(dictionaryObj.OUR_PROGRESS.object){
                                                for (index in dictionaryObj.OUR_PROGRESS.object){
                                                    if(d.ourProgress!=undefined&&index==d.ourProgress){
                                                        optionStr += '<option value="'+index+'" selected>'+dictionaryObj.OUR_PROGRESS.object[index]+'</option>';
                                                    }else{
                                                        optionStr += '<option value="'+index+'" >'+dictionaryObj.OUR_PROGRESS.object[index]+'</option>';
                                                    }
                                                }
                                                return '<select name="ourProgress" class="layui-input" style="height: 100%;"  '+(!d.detailsStatus||d.detailsStatus=="0"?'':'disabled')+' value="' + (d.ourProgress || '') + '">'+optionStr+'</select>'
                                            }else {
                                                return '';
                                            }
                                        }},
                                    {field: 'ourProgressExplain', title: '我方进展说明', minWidth: 120, templet: function (d) {
                                            return '<input type="text" name="ourProgressExplain" class="layui-input tips" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.ourProgressExplain || '') + '">'
                                        }},
                                    {field: 'constructionUnitPro', title: '建设单位进展', minWidth: 100, templet: function (d) {
                                            var optionStr = '<option value="">请选择</option>';
                                            if(dictionaryObj.CONSTRUCTION_UNIT_PRO.object){
                                                for (index in dictionaryObj.CONSTRUCTION_UNIT_PRO.object){
                                                    if(d.constructionUnitPro!=undefined&&index==d.constructionUnitPro){
                                                        optionStr += '<option value="'+index+'" selected>'+dictionaryObj.CONSTRUCTION_UNIT_PRO.object[index]+'</option>';
                                                    }else{
                                                        optionStr += '<option value="'+index+'" >'+dictionaryObj.CONSTRUCTION_UNIT_PRO.object[index]+'</option>';
                                                    }
                                                }
                                                return '<select name="constructionUnitPro" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'disabled')+' style="height: 100%;" value="' + (d.constructionUnitPro || '') + '">'+optionStr+'</select>'
                                            }else {
                                                return '';
                                            }
                                        }},
                                    {field: 'constructionUnitProExp', title: '建设单位进展说明', minWidth: 120, templet: function (d) {
                                            return '<input type="text" name="constructionUnitProExp" class="layui-input tips" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.constructionUnitProExp || '') + '">'
                                        }},
                                    {field: 'memo', title: '备注', minWidth: 100, templet: function (d) {
                                            return '<input type="text"  name="memo" class="layui-input tips" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.memo || '') + '">'
                                        }},
                                    {
                                        field: 'attachmentName',
                                        title: '附件内容',
                                        align: 'center',
                                        templet: function (d) {
                                            var fileArr = d.attachmentList;
                                            return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
                                                '</div>'
                                        }
                                    },
                                    {title: '附件', align: 'center', toolbar: '#internalBar', minWidth: 100},
                                    {align: 'center', toolbar: '#toolbarDemoIn', title: '操作', minWidth: 100}
                                ]],
                                done:function (res) {
                                    if(type==4){
                                        $('.addRow').hide()
                                    }
                                    $('.tips').on('mouseenter', function(){
                                        var content = $(this).val();
                                        if(!content){
                                            return false
                                        }

                                        this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
                                            time: -1
                                            ,maxWidth: 280
                                            ,tips: [3, '#3A3D49']
                                        });
                                    }).on('mouseleave', function(){
                                        layer.close(this.index);
                                    });
                                }
                            })
                            table.render({
                                elem: '#otherTrackTab',
                                data: tracListData,
                                toolbar: type==4?false:'#delTarckTool2',
                                cols: [[
                                    {field: 'detailed', title: '明细', sort: true, minWidth: 100, templet: function (d) {
                                            return '<input type="text" confirmId="'+(d.confirmId||'')+'" detailsStatus="'+(d.detailsStatus||'')+'" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+'  name="detailed" class="layui-input" style="height: 100%;" value="' + (d.detailed || '') + '">'
                                        }},
                                    {field: 'quantities', title: '工程量', sort: true, minWidth: 100, templet: function (d) {
                                            return '<input type="number" name="quantities" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.quantities || '') + '">'
                                        }},
                                    {field: 'unitPrice', title: '单价', sort: true, minWidth: 100, templet: function (d) {
                                            return '<input type="number" name="unitPrice" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;" value="' + (d.unitPrice || '') + '">'
                                        }},
                                    {field: 'totalPrice', title: '总价', sort: true, minWidth: 100, templet: function (d) {
                                            return '<input type="number" readonly name="totalPrice" class="layui-input" '+(!d.detailsStatus||d.detailsStatus=="0"?'':'readonly')+' style="height: 100%;background: #e7e7e7;" value="' + (d.totalPrice || '') + '">'
                                        }},
                                    {align: 'center', toolbar: '#toolbarDemoIn2', title: '操作', minWidth: 100,fixed:'right'}
                                ]],
                                done:function (res) {
                                    if(type==4){
                                        $('.addRow').hide()
                                    }
                                }
                            })
                            if(type==4){
                                $('._disabled').find('input,select,textarea').attr('disabled', 'disabled');
                                $('.file_upload_box').hide()
                                $('.deImgs').hide()
                            }
                            form.render();
                        }else{
                            layer.msg("信息获取失败！")
                            return false;
                        }
                    }
                })
            }
            //进展明细加行
            table.on('toolbar(detTarckTable)',function(obj){
                switch (obj.event) {
                    case 'add':
                        //遍历表格获取每行数据进行保存
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function (index) {
                            var attachId = '';
                            var attachName = '';
                            var attachmentList = [];
                            for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                                attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                                attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
                                var _obj ={
                                    attUrl:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
                                    attachId:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
                                    attachName:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
                                    size:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('size'),
                                    aid:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')),
                                    ym:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring($('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('_'))
                                }
                                attachmentList.push(_obj)
                            }
                            var oldDataObj = {
                                detailsStatus: $(this).find('input[name="tarckDetailsDate"]').attr('detailsStatus'),
                                tarckDetailsDate: $(this).find('input[name="tarckDetailsDate"]').val(),
                                ourProgress: $(this).find('select[name="ourProgress"]').val(),
                                ourProgressExplain: $(this).find('input[name="ourProgressExplain"]').val(),
                                constructionUnitPro: $(this).find('select[name="constructionUnitPro"]').val(),
                                constructionUnitProExp: $(this).find('input[name="constructionUnitProExp"]').val(),
                                memo: $(this).find('input[name="memo"]').val(),
                                attachmentId:attachId,
                                attachmentName:attachName,
                                attachmentList:attachmentList
                            }
                            var manageTrackDetailedId = $(this).find('input[name="tarckDetailsDate"]').attr("manageTrackDetailedId");
                            if(manageTrackDetailedId){
                                oldDataObj.manageTrackDetailedId=manageTrackDetailedId;
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        var addRowData = {

                        };
                        oldDataArr.push(addRowData);
                        table.reload('detTarckTable', {
                            data: oldDataArr
                        });
                        break;
                }
            })
            table.on('tool(detTarckTable)',function(obj){
                var data = obj.data;
                var layEvent = obj.event;
                var tr = obj.tr;
                //进展明细删行
                if (layEvent == 'del') {
                    if(data.manageTrackDetailedId){
                        $.ajax({
                            url: '/operateTarckDetails/del?isTarck=tarck&ids='+data.manageTrackDetailedId,
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                /*if (res.code==='0'||res.code===0) {
                                    layer.msg(res.msg, {icon: 1});
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }*/
                            }
                        });
                    }

                    obj.del();


                }else if (layEvent == 'dateSelection') {
                    var $tr = $('.mtl_info').find(tr.selector).find('input[name="tarckDetailsDate"]');
                    $tr.each(function (index,element) {
                        laydate.render({
                            elem: element
                            , trigger: 'click'
                            , format: 'yyyy-MM-dd'
                            // , format: 'yyyy-MM-dd HH:mm:ss'
                            //,value: new Date()
                        });
                    })
                }else if (layEvent == 'butfile') {
                    var $tr = tr.selector
                    fileuploadFn( $tr+' [id^=fileupload]', $( $tr+' [id^=fileAll]'));
                }
            })
            //甲方确认加行
            table.on('toolbar(otherTrackTab)',function(obj){
                switch (obj.event) {
                    case 'add2':
                        //遍历表格获取每行数据进行保存
                        var $tr = $('.other_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                detailsStatus: $(this).find('input[name="detailed"]').attr('detailsStatus'),
                                detailed: $(this).find('input[name="detailed"]').val(),
                                quantities: $(this).find('input[name="quantities"]').val(),
                                unitPrice: $(this).find('input[name="unitPrice"]').val(),
                                totalPrice: $(this).find('input[name="totalPrice"]').val()
                            }
                            var confirmId = $(this).find('input[name="detailed"]').attr("confirmId");
                            if(confirmId){
                                oldDataObj.confirmId=confirmId
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        var addRowData = {

                        };
                        oldDataArr.push(addRowData);
                        table.reload('otherTrackTab', {
                            data: oldDataArr
                        });
                        break;
                }
            })
            //甲方确认删行
            table.on('tool(otherTrackTab)',function(obj){
                var data = obj.data;
                var layEvent = obj.event;
                var tr = obj.tr;
                if (layEvent == 'del2') {
                    var totalPrice = $(tr).find('[name="totalPrice"]').val();
                    if(totalPrice!=undefined&&totalPrice!=""){
                        $("#firstConfirmInf").val(sub($("#firstConfirmInf").val(),totalPrice));
                    }
                    if(data.confirmId){
                        $.ajax({
                            url: '/operateTarckDetails/del?isTarck=confirm&ids='+data.confirmId,
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                /*if (res.code==='0'||res.code===0) {
                                    layer.msg(res.msg, {icon: 1});
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }*/
                            }
                        });
                    }

                    obj.del();
                }
            })

            //监听甲方确认单价
            $(document).on('blur', 'input[name="unitPrice"]', function () {
                var $tr = $('.other_info').find('.layui-table-main tr');
                var $tr2 = $('.other_info').find('.layui-table-main tr [name="totalPrice"]');
                //计算甲方确认总价
                if($(this).val() && $(this).parents('tr').find('[name="unitPrice"]').val()){
                    //总价
                    var totalPrice=0
                    //工程量
                    var quantities=$(this).parents('tr').find('input[name="quantities"]').val()
                    //单价
                    var unitPrice=$(this).parents('tr').find('input[name="unitPrice"]').val()
                    totalPrice=mul(quantities,unitPrice)
                    $(this).parents('tr').find('[name="totalPrice"]').val(retainDecimal(totalPrice,3))

                    //计算甲方确认后收入
                    var firstConfirmInf = 0;
                    $tr2.each(function (index,element) {
                        firstConfirmInf=accAdd(firstConfirmInf,$(element).val());
                    });
                    $('#firstConfirmInf').val(retainDecimal(firstConfirmInf,3))
                }
            });

        })
    }

    function childFunc() {
        if('0'!=_disabled){
            return true
        }
        var loadIndex = layer.load();
        //主表数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value;
        });
        if(type===1&&data!=undefined){
            if(data.manageTrackId!=undefined){
                obj.manageTrackId = data.manageTrackId;
            }
        }
        obj.projectId =$('#leftId').attr('projId');
        obj.manageTrackStatus = 0;

        /* // 判断必填项
         var requiredFlag = false;
         $('#baseForm').find('.field_required').each(function(){
             var field = $(this).attr('field');
             if (field && !obj[field] && obj[field] != '0') {
                 var fieldName = $(this).parent().text().replace('*', '');
                 layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                 requiredFlag = true;
                 return false;
             }
         });

         if (requiredFlag) {
             layer.close(loadIndex);
             return false;
         }*/

        //进展明细
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var detailList = [];
        $tr.each(function (index) {
            var attachId = '';
            var attachName = '';
            for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
                attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
                attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
            }
            var plbManageItemObj = {
                tarckDetailsDate: $(this).find('input[name="tarckDetailsDate"]').val(),
                ourProgress: $(this).find('select[name="ourProgress"]').val(),
                ourProgressExplain: $(this).find('input[name="ourProgressExplain"]').val(),
                constructionUnitPro: $(this).find('select[name="constructionUnitPro"]').val(),
                constructionUnitProExp: $(this).find('input[name="constructionUnitProExp"]').val(),
                memo: $(this).find('input[name="memo"]').val(),
                attachmentId:attachId,
                attachmentName:attachName
            }
            var manageTrackDetailedId = $(this).find('input[name="tarckDetailsDate"]').attr("manageTrackDetailedId");
            if(manageTrackDetailedId){
                plbManageItemObj.manageTrackDetailedId=manageTrackDetailedId;
            }
            detailList.push(plbManageItemObj);
        });
        obj.detailList = detailList;
        //甲方确认
        var $tr = $('.other_info').find('.layui-table-main tr');
        var tarckConfirmList = [];
        $tr.each(function () {
            var plbManageItemObj = {
                detailed: $(this).find('input[name="detailed"]').val(),
                quantities: $(this).find('input[name="quantities"]').val(),
                unitPrice: $(this).find('input[name="unitPrice"]').val(),
                totalPrice: $(this).find('input[name="totalPrice"]').val(),
            }
            var confirmId = $(this).find('input[name="detailed"]').attr("confirmId");
            if(confirmId){
                plbManageItemObj.confirmId=confirmId
            }
            tarckConfirmList.push(plbManageItemObj);
        });
        obj.tarckConfirmList = tarckConfirmList;

        var _flag = false;

        $.ajax({
            url: '/operateTarck/updateRegister',
            data:JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.code==='0'||res.code===0) {
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

</script>
</body>
</html>
