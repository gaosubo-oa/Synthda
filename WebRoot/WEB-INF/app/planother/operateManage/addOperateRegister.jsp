<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/6/29
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增变更登记页面</title>
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
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108311509"></script>

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
/*
        .file_upload_box {
            position: relative;
            height: 22px;
            overflow: hidden;
        }
        .open_file {
            float: left;
            position:relative;
        }
*/
        /*.open_file input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }*/
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
            margin-left: 8%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .layui-col-xs4{
            width: 20%;
        }
    </style>
</head>
<body>
<div class="layui-collapse">
<%--    region 立项项目基础信息 --%>
     <div class="layui-colla-item">
            <div class="layui-colla-content layui-show plan_base_info"> 
                   <form class="layui-form" id="baseForm" lay-filter="baseForm">
<%--                 region 第一行 --%>
                           <div class="layui-row">
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">单据号<span field="registerNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
                                       <div class="layui-input-block form_block">
                                           <input type="text" readonly name="registerNo" autocomplete="off" class="layui-input">
                                       </div>
                                   </div>
                               </div>
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <input type="text" name="projectName" id="projectName" readonly  class="layui-input ">
                                       </div>
                                   </div>
                               </div>
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">变更单名称<span field="registerName" class="field_required">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <input type="text" name="registerName"  class="layui-input ">
                                       </div>
                                   </div>
                               </div>
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">变更单类别<span field="registerCategory" class="field_required">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <select name="registerCategory"><option value="">请选择</option></select>
                                       </div>
                                   </div>
                               </div>
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">变更单类型<span field="registerType" class="field_required">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <select name="registerType"><option value="">请选择</option></select>
                                       </div>
                                   </div>
                               </div>
                           </div>
<%--                /* endregion */--%>
<%--                /* region 第二行 */--%>
                           <div class="layui-row">
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">变更日期<span field="registerDate" class="field_required">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <input type="text" id="registerDate" name="registerDate" autocomplete="off" pointFlag="1" class="layui-input ">
                                       </div>
                                   </div>
                               </div>
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">施工图纸编号<span field="constructionDrawingsNo" class="field_required">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <input type="text" name="constructionDrawingsNo" autocomplete="off"  class="layui-input ">
                                       </div>
                                   </div>
                               </div>
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">备注</label>
                                       <div class="layui-input-block form_block">
                                           <textarea name="memo" placeholder="请输入备注内容" class="layui-textarea" style="height: 38px; min-height: 38px"></textarea>
                                       </div>
                                   </div>
                               </div>

                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">填报人<span field="itemAmount" style="color: red">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <input type="text" name="createUserName" autocomplete="off" pointFlag="1" class="layui-input " disabled>
                                       </div>
                                   </div>
                               </div>
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">填报时间<span field="itemAmount"style="color: red">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <input type="text" id="createTime" name="createTime" autocomplete="off" pointFlag="1" class="layui-input " disabled>
                                       </div>
                                   </div>
                               </div>
                           </div>
<%--                /* endregion */--%>
<%--                /* region 第三行 */--%>
                           <div class="layui-row">
                               <div class="layui-col-xs4" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">甲方是否已下达指令<span field="itemType" style="color: red">*</span></label>
                                       <div class="layui-input-block form_block">
                                           <input type="radio" name="firstPartyOrderFlag" lay-filter="firstPartyOrderFlag" value="0" title="是" checked>
                                           <input type="radio" name="firstPartyOrderFlag" lay-filter="firstPartyOrderFlag" value="1" title="否">
                                       </div>
                                   </div>
                               </div>

                               </div>
<%--                /* endregion */--%>
<%--                /* region 第四行 */--%>
<%--                           <div class="layui-row">--%>

<%--                           </div>--%>
<%--                /* endregion */--%>
<%--                /* region 第五行 */--%>
                           <div class="layui-row">
                               <div class="layui-col-xs6" style="padding: 0 5px;">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">变更内容说明</label>
                                       <div class="layui-input-block form_block">
                                           <textarea name="registerContent" placeholder="请输入变更内容说明" class="layui-textarea"></textarea>
                                       </div>
                                   </div>
                               </div>
                           </div>
<%--                /* endregion */--%>
<%--                /* region 第六行 */--%>
                           <div class="layui-row">
                               <div class="layui-col-xs12" style="padding: 0 5px;width: 100%">
                                   <div class="layui-form-item">
                                       <label class="layui-form-label form_label">附件</label>
                                       <div class="layui-input-inline" style="width: 100%">
                                           <div id="fileContent">
                                           </div>
                                           <a href="javascript:;"  class="openFile" style="position: relative" >
                                               <img src="../img/mg11.png" alt="">
                                               <span>添加附件</span>
                                               <input type="file" multiple id="fileupload" data-url="/upload?module=operateRegister" name="file">
                                           </a>
                                       </div>
                                   </div>
                               </div>
                           </div>
<%--                /* endregion */--%>
                       </form> 
                </div> 
          </div> 
<%--    /* endregion */--%>
    </div>
<script>
    function getUrlParam(name) {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return decodeURI(r[2]); return null;
    }
    var tableBtn=getUrlParam("tableBtn");
    var projectId=getUrlParam("projectId");
    var runId=getUrlParam("runId");
    var _disabled=getUrlParam('disabled');
    var registerId=getUrlParam("registerId");
    var dictionaryObj = {
        MANAGE_ITEM_TYPE: {},
        OPERATE_REGISTER_CATEGORY:{},
        OPERATE_REGISTER_TYPE:{}
    }

    $.ajaxSettings.async = false;
    var dictionaryStr = 'MANAGE_ITEM_TYPE,OPERATE_REGISTER_CATEGORY,OPERATE_REGISTER_TYPE';

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
            $('[name="registerCategory"]').append(dictionaryObj['OPERATE_REGISTER_CATEGORY']['str']);
            $('[name="registerType"]').append(dictionaryObj['OPERATE_REGISTER_TYPE']['str']);
            layui.form.render();
        }
    });

    $.ajaxSettings.async = true;
          var formData;
        layui.use(['form','laydate'],function(){
            var form=layui.form,
                laydate=layui.laydate;

            if(projectId){
                //回显项目名称
                getProjName('#projectName',projectId)
            }
            fileuploadFn('#fileupload', $('#fileContent'));
            if (tableBtn=="add"){
                $.ajax({
                    url:'/planningManage/autoNumber?autoNumberType=bgd',
                    success:function(res){
                        $('input[name="registerNo"]', $('#baseForm')).val(res.obj);
                        $('input[name="createUserName"]',$('#baseForm')).val(res.object.createUserName);
                        $('input[name="createTime"]', $('#baseForm')).val(res.object.createTime);
                    }
                })

                laydate.render({
                    elem:'#registerDate',
                    trigger:'click',
                    position:'absolute',
                    zIndex:9999
                })
                form.render();
            }else if(tableBtn=="edit"){
               $.ajax({
                   url:'/plbOperateManage/getRegisterById?registerId='+registerId+'',
                   async:false,
                   success:function(res){
                     formData=res.obj
                   }
               })
                form.val("baseForm", formData);
                if (formData.attachmentList && formData.attachmentList.length > 0) {
                    var fileArr = formData.attachmentList;
                    $('#fileContent').append(echoAttachment(fileArr));
                }
                laydate.render({
                    elem:'#registerDate',
                    trigger:'click',
                    position:'absolute',
                    zIndex:9999
                })
                form.render();
            }else if(tableBtn=="details"){
                $.ajax({
                    url:'/plbOperateManage/getRegisterById?registerId='+registerId+'',
                    async:false,
                    success:function(res){
                        formData=res.obj
                    }
                })
                form.val("baseForm", formData);
                if (formData.attachmentList && formData.attachmentList.length > 0) {
                    var fileArr = formData.attachmentList;
                    $('#fileContent').append(echoAttachment(fileArr));
                }
                $('input').attr("disabled",true);
                $("select").attr("disabled",true);
                $('.openFile').hide();
                $('.deImgs').hide();
                form.render();
            }else if(runId){
                $.ajax({
                    url:'/plbOperateManage/getRegisterById?runId='+runId,
                    async:false,
                    success:function(res){
                        formData=res.obj
                    }
                })
                form.val("baseForm", formData);
                if (formData.attachmentList && formData.attachmentList.length > 0) {
                    var fileArr = formData.attachmentList;
                    $('#fileContent').append(echoAttachment(fileArr));
                }
                if(_disabled=="1"||_disabled==1){
                    $('input').attr("disabled",true);
                    $("select").attr("disabled",true);
                    $('.openFile').hide();
                    $('.deImgs').hide();
                }
                form.render();
            }

        })
    // 子页面数据传向父页面
    function getData() {
        //附件
        var attachmentId = '';
        var attachmentName = '';
        //var attachmentList=[];
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            var att={
                attUrl:$('#fileContent .dech').eq(i).attr('deurl'),
                attachName:$('#fileContent img').eq(i).attr('name')
            }
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent img').eq(i).attr('name');
            //attachmentList[i]=att;
        }
        var obj={
            "projectId":projectId,
            "projectName":$("[name='projectName']").val(),
            "registerNo":$("[name='registerNo']").val(),
            "registerName":$("[name='registerName']").val(),
            "registerCategory":$("[name='registerCategory']").val(),
            "registerType":$("[name='registerType']").val(),
            "registerDate":$("[name='registerDate']").val(),
            "constructionDrawingsNo":$("[name='constructionDrawingsNo']").val(),
            "firstPartyOrderFlag":$("[name='firstPartyOrderFlag']:checked").val(),
            "registerContent":$("[name='registerContent']").val(),
            "memo":$("[name='memo']").val(),
            "attachmentId":attachmentId,
            "attachmentName":attachmentName,
        }
        // 判断必填项
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
            layer.close(index);
            return false;
        }

        return obj;
    };

    function childFunc(){
        if(_disabled&&_disabled=='1'){
            return true
        }
        var loadIndex = layer.load();
        //基本信息数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });
        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;


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

        if (requiredFlag) {
            layer.close(loadIndex);
            return false;
        }

        obj.compareTime = $('#compareTime').val() + ' 00:00:00'

        if (type == 1) {
            obj.contrastId = $('#htmBox').attr('contrastId');
        }else{
            obj.projId = parseInt($('#htmBox').attr('projId'));
        }

        var _flag = false;
        $.ajax({
            url: "/plbOperateManage/updateRegister",
            data: JSON.stringify(obj),
            dataType: 'json',
            type: 'post',
            contentType: "application/json;charset=UTF-8",
            success: function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});
                    layer.close(index);
                    /*tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();*/
                } else {
                    _flag = true
                    layer.msg('保存失败！', {icon: 2});
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
