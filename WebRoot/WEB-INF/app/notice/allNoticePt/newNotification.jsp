
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="notice.th.createANewNotification" /></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="../lib/ueditor/formdesign/bootstrap/css/bootstrap.css"/>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/formdesign/bootstrap/js/bootstrap.js?20200826" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <%--<script src="../js/jquery/jquery.cookie.js"></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="../js/email/fileupload.js"></script>
    <script src="/js/base/base.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>

        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .bar {
            height: 18px;
            background: green;
        }
        #edui1_iframeholder{
            height: 200px;
        }
        /*下拉多选样式*/
        .xm-select-demo .selected{
            background: none;
        }
    </style>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
<%--    <script src="/js/notice/newAndEdit.js?20200912.2"></script>--%>
<%--    <script src="/js/notice/flowNotice.js?20200518.1" type="text/javascript" charset="utf-8"></script>--%>

    <script>

    </script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png" alt="">
    <h2><fmt:message code="notice.th.createANewNotification" /></h2>

</div>
<div id="pagediv" class="tableMain">
    <form id="ajaxform" action="">
        <input type="hidden" name="tuisong" value="">
        <input type="hidden" name="format" value="0">
        <input type="hidden" name="publish" >
        <input type="hidden" name="notifyId">
        <input type="hidden" name="lastEditTimes">
        <input type="hidden" name="auditer">
        <input type="hidden" name="approveRemind" value="1">
        <input type="hidden" name="remind" value="1">
        <table>
            <tbody>
            <tr>
                <td width="20%">
                    <select name="typeId" onchange="typeIdStatic(this)">
                        <%--<option value=""><fmt:message code="news.th.type"/></option>--%>
                        <option value="" selected = 'selected'><fmt:message code="notice.type.notice" /></option>
                    </select>
                </td>
                <td width="80%" style="text-align: left">
                    <input type="text" name="subject" placeholder="<fmt:message code="global.lang.printsubject"/>">
                    <b>*</b>
                </td>
            </tr>
            <tr style="display: none">
                <td class="blue_text" width="20%">
                    <p style="margin-bottom:5px;"><fmt:message code="notice.th.IssuedByDepartment"/>：</p>
                    <%--<a href="javascript:;" class="deptandrole"><fmt:message code="notice.th.PostedByPersonnelOrRoles"/></a>--%>
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="" class="theControlData" readonly="readonly" id="department" style="width: 70%;" rows="5"></textarea>
                    <b>*</b>
                    <a href="javascript:;" class="addControls" data-type="1"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="toId">
                    <p><fmt:message code="vote.th.(UnionPersonnel)"/></p>
                </td>
            </tr>
            <tr class="deptrole" style="display: none">
                <td class="blue_text" width="20%">
                    <p ><fmt:message code="notice.th.role"/>：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="" class="theControlData" readonly="readonly" id="roleall" style="width: 70%;" rows="5"></textarea>
                    <a style="margin-left:5px;" href="javascript:;" class="addControls" data-type="2"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="privId">
                </td>
            </tr>
            <tr class="deptrole" style="display: table-row">
                <td class="blue_text" width="20%">
                    <p ><fmt:message code="notice.th.selectPersonnelToRelease" />：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="" class="theControlData" readonly="readonly" id="personnel" style="width: 70%;" rows="5"></textarea>
                    <a style="margin-left:5px;" href="javascript:;" class="addControls" data-type="3"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="userId">
                </td>
            </tr>
            <%--按人员类别发布--%>
            <tr style="display: none">
                <td class="blue_text" width="20%">
                    <p ><fmt:message code="notice.th.personnelCategoryScreening" />：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <div id="viewUserTypeSelect" class="xm-select-demo" style="width: 71%;"></div>
                    <input type="hidden" name="userType">
                </td>
            </tr>
            <%--拟稿部门--%>
            <tr>
                <td class="blue_text" width="20%">
                    <p ><fmt:message code="notice.th.draftingDepartment" />：</p>
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="" class="theControlData" id="draftDept" style="width: 70%;height: 40px" rows="5"></textarea>
                    <a style="margin-left:5px;" href="javascript:;" class="addControls" data-type="4"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="cleardate"><fmt:message code="global.lang.empty"/></a>
                    <input type="hidden" name="draftDept">
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.PostedTime"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <input style="width: 204px" type="text" name="sendTimes" readonly="readonly" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                    <b>*</b>
                    <a href="javascript:;" class="recoveryTime"><fmt:message code="notice.th.ResetToCurrentTime"/></a>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.validity"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <input style="width: 204px" readonly="readonly" type="text" name="beginDates" placeholder="<fmt:message code="adding.th.PleasePeriod"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
                    <span><fmt:message code="global.lang.to"/></span>
                    <input style="width: 204px" readonly="readonly" type="text" name="endDates"
                           placeholder="<fmt:message code="adding.th.PleasePeriod"/>"
                           onclick="laydate(dataobj)">
                    <span><fmt:message code="notice.th.null"/></span>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.reminder"/>：
                </td>
                <td width="80%" style="text-align: left" id="thing">
                    <input type="checkbox" name="thingDefault" checked="checked" value="0">
                    <span><fmt:message code="notice.th.remindermessage"/></span>
                    <input type="hidden" name="howRenind" >&nbsp;
                    <input type="checkbox" name="smsRemind" value="1" style="display: none">
                    <span style="display: none"><fmt:message code="vote.th.UseRemind"/></span>
                    <%--<input type="hidden" name="smsDefault" value="1">--%>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.top"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <input type="checkbox" name="topDing">
                    <input type="hidden" name="top" value="0">
                    <span><fmt:message code="notice.th.topMajor"/></span>
                    <input type="text" name="topDays" value="30" style="height: 20px;width: 23px;">
                    <span><fmt:message code="notice.th.endTop"/></span>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.contentValidity"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <textarea name="summary" placeholder="<fmt:message code="adding.th.PleaseIntroduction"/>"  id="" cols="50" rows="2" maxlength="100" style="background: #fff; height:100px "></textarea>
                    <span><fmt:message code="notice.th.contentHigh"/></span>
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.fileUpload"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <div id="fileAll">

                    </div>
                    <a href="javascript:;" class="openFile" style="float: left;">
                        <img src="../img/mg11.png" alt="">
                        <span><fmt:message code="email.th.addfile"/></span>
                        <input type="file" multiple id="fileupload" data-url="../upload?module=notify" name="file">
                    </a>
                    <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
                        <div class="bar" style="width: 0%;"></div>
                    </div>
                    <div class="barText" style="float: left;margin-left: 10px;"></div>
                    <input type="hidden" name="attachmentId">
                    <input type="hidden" name="attachmentName">
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="adding.th.Attachment"/>：
                </td>
                <td width="80%" style="text-align: left">
                    <input type="checkbox" id="download_ck" style="margin: -1px 0px 0px 0px" checked="checked"><label style="display: inline-block;margin-left: 5px" for="download_ck"><fmt:message code="adding.th.allow"/></label>
                    <input type="hidden" name="download" value="1" >
                </td>
            </tr>
            <tr>
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.receipt" />：
                </td>
                <td width="80%" style="text-align: left">
                    <input type="checkbox" id="back" style="margin: -1px 0px 0px 0px" name="isOpin" value="0" ><label style="display: inline-block;margin-left: 5px" for=""><fmt:message code="notice.th.receiptIsRequired" /></label>
                </td>
            </tr>
            <tr class="setHide" style="display:none">
                <td class="blue_text" width="20%">
                    <fmt:message code="notice.th.receiptFormSettings" />：
                </td>
                <td width="80%" style="text-align: left" >
                    <input type="text" name="field" placeholder="<fmt:message code="notice.th.fillInTheReceiptTitle" />（1)" style="width: 200px;"/>
                    <a href="javascript:;" id="add"><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" id="clear" style="display:none"><fmt:message code="global.lang.delete" /></a>
                    <input type="hidden" name="opinionFields" />
                    <input type="hidden" name="fieldTitles" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding: 5px;">
                    <div id="word_container" name="word_container">

                    </div>
                    <input type="hidden" name="content">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center" class="btnarr">
                    <a href="javascript:;" class="sendbtn" onclick="ajaxforms(1)"><fmt:message code="global.lang.publish"/></a>
                    <a style="display: none" href="javascript:;" class="tijiaobtn" ><fmt:message code="adding.th.Submit"/></a>
                    <a href="javascript:;" class="savebtn" onclick="ajaxforms(0)"><fmt:message code="global.lang.save"/></a>
                    <a href="javascript:;" class="backnotice"><fmt:message code="notice.th.return" /></a>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div style="display: none;">
    <form id="wordimportform" enctype="multipart/form-data">
        <input type="file" name="file" id="wordimportfile" onchange="javascript:asyncUploadFile()" />
        <%--<div id="query_uploadArr" name="query_uploadArr" style="display: none;width:240px;height:80px;float:left">--%>
        <%--</div>--%>
    </form>
</div>
<div class="modal fade" id="loadingModal" aria-hidden="false">
    <div style="width: 200px;height:20px; z-index: 20000; position: absolute; text-align: center; left: 50%; top: 50%;margin-left:-100px;margin-top:-10px">
        <div class="progress progress-striped active" style="margin-bottom: 0;">
            <div class="progress-bar" style="width: 100%;"></div>
        </div>
        <h5 style="color: #5BC0DE;"><fmt:message code="workflow.th.doing" />...</h5>
    </div>
</div>
<script>

    var viewUserTypeSelect=null;
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var typenotice = getQueryString("type");
    layui.use('xmSelect',function () {
        var xmSelect=layui.xmSelect
        // 获取按人员类别发布接口
        $.get('/code/getCode?parentNo=staffType', function(res){
            var data = [];
            if (res.flag && res.obj.length > 0) {
                data = res.obj;
            }
            viewUserTypeSelect=xmSelect.render({
                el: '#viewUserTypeSelect',
                toolbar: {
                    show: true,
                },
                autoRow: true,
                prop: {
                    name: 'codeName',
                    value: 'codeNo',
                },
                data: data
            });
        });
    })
    if(typenotice=="edit"){
        $(".backnotice").show();
    }else{
        $(".backnotice").hide();
    }

    ue = UE.getEditor('word_container',{elementPathEnabled : false});
    UEimgfuc();
    $('#back').click(function(){
        // console.log($(this).is(':checked'))
        if($(this).is(':checked')){
            $('.setHide').show()
        }else{
            $('.setHide').hide()
        }
    })
    $('#add').click(function(){
        var str = ' <input type="text" name="field" placeholder="<fmt:message code="notice.th.fillInTheReceiptTitle" />（'+($('[name="field"]').length+1)+')"  style="width: 200px;"/>'
        $('#clear').show()
        if($('[name="field"]').length>=10){
            $.layerMsg({content:'<fmt:message code="notice.th.addAMaximumOf10" />',icon:6})
        }else if($('[name="field"]').length==9){
            $('#add').hide()
            $('#add').before(str)
        }else{
            $('#add').before(str)
        }

    })
    $('#clear').click(function(){
        if($('[name="field"]').length<=1){
            $.layerMsg({content:'<fmt:message code="notice.th.leaveAtLeastOneTextBox" />',icon:6});
            $('#clear').hide()
        }else  if($('[name="field"]').length==2){
            $('#clear').hide()
            $('#add').prev().remove();
        }else{
            $('#add').show()
            $('#add').prev().remove();
        }

    })

    $(document).on('keyup','#draftDept',function (e) {
        if(e){
            $('#draftDept').attr('deptid','')
        }
    })
    $('.backnotice').click(function(){
        window.location.href='/notice/notiManagement';
    })
    function wordimport(key){
        var me=this;
        $("#wordimportfile").click();
    }

    $('#wordimportfile').fileupload({
        dataType:'json',
        done: function (e, data) {
            if(data.result.obj != ''){
                var data = data.result.obj;
                var str = '';
                var str1 = '';

                for (var i = 0; i < data.length; i++) {
                    var gs = data[i].attachName.split('.')[1];
                    if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php'||gs == 'xls'||gs == 'xlsx' ){
                        str += '';
                        layer.alert('<fmt:message code="notice.th.leaveAtLeastOneTextBox" />!',{},function(){
                            layer.closeAll();
                        });
                    }else{
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }
                }
            } else{
                //alert('添加附件大小不能为空!');
                layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                    layer.closeAll();
                });
            }
        }
    });
    function asyncUploadFile() {
        $("#loadingModal").modal('show');
        $("#loadingModal").modal({backdrop: 'static', keyboard: false});
        var formData = new FormData($('#wordimportform')[0]);
        $("#wordimportfile").val('');
        $.ajax({
            url:'/ueditor/wordToHtml?module=ueditor',
            type:'POST',
            data:formData,
            dataType:'text',
            cache: false,
            processData: false,
            contentType: false,
            success:function (result) {
                var obj=  JSON.parse(result);
                var valuecontent=obj.htmlContent;
                ue.execCommand('insertHtml', valuecontent);
                $("#loadingModal").modal('hide');
            },
            error:function (error) {
                // console.log(error);
                $("#loadingModal").modal('hide');
            }

        });
    }

    var getRequestObj=$.GetRequest();
    var user_id=null;
    var dept_id=null;
    var priv_id=null;
    var ue=null;



    function queryTime(type){
        function p(s) {
            return s < 10 ? '0' + s: s;
        }
        var myDate = new Date();
        //获取当前年
        var year=myDate.getFullYear();
        //获取当前月
        var month=myDate.getMonth()+1;
        //获取当前日
        var date=myDate.getDate();
        var h=myDate.getHours();       //获取当前小时数(0-23)
        var m=myDate.getMinutes();     //获取当前分钟数(0-59)
        var s=myDate.getSeconds();
        var now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
        if(type==undefined){
            return now;
        }else {
            return year+'-'+p(month)+"-"+p(date)
        }

    }
    var dataobj={istime: true, format: 'YYYY-MM-DD',min:queryTime(1)};
    function typeIdStatic(me) {
        if($(me).find('option:selected').attr('data-isEdit')=='1'){
            $('.tijiaobtn').show();
            $('.sendbtn').hide()
        }else {
            $('.tijiaobtn').hide();
            $('.sendbtn').show()
        }
    }


    function ajaxforms(type) {
        // console.log($('#ajaxform select[name="typeId"]').val())
        if(!$('#ajaxform select[name="typeId"]').val()){

            layer.msg('<fmt:message code="notice.th.pleaseSelectTheNotificationType" />！',{icon:0});
            return false
        }
        //判断如果是编辑页面且是保存按钮，就走新接口
        if(getRequestObj.type=='edit' && type==0){
            $('#ajaxform').attr('action','/notice/updateNotifys');
        }
        var isEdit=isPublish(getRequestObj.notifyId)
        if(isEdit==1){
            $.layerMsg({content:'<fmt:message code="notice.th.thisAnnouncementHasComeIntoEffect" />！',icon:0});
            parent.window.location.reload()
            return false
        }

        if(type==0) {
            if(getRequestObj.type!='edit'){
                $('[name="publish"]').val(type);
            }else {
                $('[name="publish"]').val('');
            }
        }else {
            $('[name="publish"]').val(type);
        }


        if(type!=2){
            $('[name="tuisong"]').val(type);
            // $('[name="tuisong"]').val(0);
        }
        var index1,index2,index3;

        if($('[name=subject]').val() == ''){
            layer.msg('<fmt:message code="notice.th.theTitleCannotBeLeftBlank" />！',{icon:2});
        }else if($('.barText').html() != '' && $('.barText').html()!="100%"){
            layer.msg('<fmt:message code="email.th.attachmentUploaded" />！',{icon:2});
        }else{

            if($('#personnel').attr('user_id')!=undefined) {
                $('#personnel').siblings('input[type=hidden]').val($('#personnel').attr('user_id'));
                index1 = 1;
            }else{
                index1 = 2;
            }
            if($('#roleall').attr('userpriv')!=undefined){
                $('#roleall').siblings('input[type=hidden]').val($('#roleall').attr('userpriv'));
                index2 = 1;
            }else{
                index2 = 2;
            }
            if($('#department').attr('deptid')!=undefined){
                $('#department').siblings('input[type=hidden]').val($('#department').attr('deptid'));
                index3 = 1;
            }else{
                index3 = 2;
            }
            /*按人员类别发布*/
            if(viewUserTypeSelect.getValue('valueStr')){
                $('[name="userType"]').val(viewUserTypeSelect.getValue('valueStr')+',')
            }
            /*拟稿部门*/
            if($('#draftDept').attr('deptid')){
                $('#draftDept').siblings('input[type=hidden]').val($('#draftDept').attr('deptid').replace(/,$/, ''));
            }else{
                $('#draftDept').siblings('input[type=hidden]').val($('#draftDept').val());
            }

            if(index1 == 2 && index3 == 2 &&index2 == 2){
                layer.msg('<fmt:message code="new.th.DepartmentRolePersonAtLeastFillInOne" />！',{icon:2});
            }else{
                var filearr=$('#fileAll .dech');
                var aId='';
                var uId='';
                for(var i=0;i<filearr.length;i++){
                    aId+=$(filearr[i]).find('input').val();
                    uId+=$(filearr[i]).find('a').attr('name');
                }
                $('[name="attachmentId"]').val(aId);
                $('[name="attachmentName"]').val(uId);
                $('[name="content"]').val(ue.getContent());
                var checkvalue=""
                $('#thing input[type="checkbox"]').each(function(i,v){
                    if($(this).is(':checked')){
                        checkvalue += $(this).val()+','
                    }
                })
                $('input[name="howRenind"]').val(checkvalue)
                if(type==1){
                    if(getRequestObj.notifyId!=undefined){
                        $('[name="lastEditTimes"]').val(queryTime())
                    }
                }

                if($('[name="isOpin"]').is(':checked')){
                    $('[name="isOpin"]').val(1)
                    var str=""
                    var strfield=""
                    $('[name="field"]').each(function (index) {
                        if($(this).val() == ''){
                            $.layerMsg({content:'<fmt:message code="event.th.titleCannotEmpty" />',icon:6})
                            return false ;
                        }
                        str += $(this).val()+'-'
                        strfield += $(this).val()+'(-)'
                    });
                    str = str.substr(0,str.length-1);
                    $('[name="opinionFields"]').val(str)
                    $('[name="fieldTitles"]').val(strfield)
                }else{
                    $('[name="opinionFields"]').val('')
                    $('[name="fieldTitles"]').val('')
                }


                $('#ajaxform').ajaxSubmit({
                    type: 'post',
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $.layerMsg({content: SuccessfulOperation, icon: 1}, function () {
                                if(getRequestObj.approve == 'true'){
                                    window.close();
                                    window.opener.location.reload();
                                }else{
                                    if(parent.$('[name="notices"]').length == 0){
                                        window.close();
                                    }else{
                                        /*parent.$('.head-top ul li').removeClass('active')
                                        $((parent.$('.head-top ul li'))[0]).addClass('active')
                                        parent.$('[name="notices"]').attr('src','../../notice/management')*/
                                        parent.window.location.reload()
                                    }

                                }
                            });
                        } else {
                            $.layerMsg({content: networkError, icon: 2});
                        }

                    }
                })
            }
        }

    }
    //在点击修改或编辑或审批时，如果已生效，则不允许操作
    function isPublish(notifyId){
        var isPublish=''
        $.ajax({
            url:'/notice/selectById',
            type:'get',
            data:{notifyId:notifyId},
            dataType:'json',
            async:false,
            success:function(res){
                if(res.flag && res.obj1 && res.obj1.publish==1){
                    isPublish=res.obj1.publish
                }
            }
        })
        return isPublish
    }

    $(function () {
        var runId1 = $.getQueryString("runId") || '';
        var chkValue1 = $.getQueryString("chkValue") || '';
        function GetDropDownBox(fn) {
            $.ajax({
                url: "/sys/getNotifyTypeList",
                type:'get',
                dataType:"JSON",
                data : {"CodeNos":"NOTIFY"},
                success:function(data){
                    var str='';
                    // var str='<option value="" data-isEdit="'+data.object.isEdit+'">'+notice_type_alltype+'</option>';

                    var arr=data.obj;
                    for(var i=0;i<arr.length;i++){
                        str += '<option value="'+arr[i].codeNo+'" data-isEdit="'+arr[i].isEdit+'">'+arr[i].codeName+'</option>'

                    }
                    $('[name="typeId"]').html(str)
                    if(chkValue1.indexOf('5')!=-1){
                        // 针对内部分发后的类型回显不上
                        $.ajax({
                            type:'get',
                            url:'/flowUtil/flowAttachDocument',
                            dataType:'json',
                            async:false,
                            data:{
                                runId:runId1,
                                module:"notify"
                            },
                            success:function (res) {
                                var data = res.obj;
                                var str = '';
                                $('#ajaxform select[name="typeId"]').val(res.obj1)
                            }

                        })

                    }
                    if(fn!=undefined){
                        fn()
                    }
                }

            })
        }
        ue = UE.getEditor('word_container',{elementPathEnabled : false});

        // 查询提醒权限
        $.ajax({
            type:'get',
            url:'/smsRemind/getRemindFlag',
            dataType:'json',
            data:{
                type:1
            },
            success:function (res) {
                if(res.flag){
                    if(res.obj.length>0){
                        var data = res.obj[0];
                        // 是否默认发送
                        if(data.isRemind=='0'){
                            $('input[name="thingDefault"]').prop("checked", false);
                        }else if(data.isRemind=='1'){
                            $('input[name="thingDefault"]').prop("checked", true);
                        }
                        // 是否手机短信默认提醒
                        if(data.isIphone=='0'){
                            $('input[name="smsRemind"]').prop("checked", false);
                        } else if (data.isIphone=='1'){
                            $('input[name="smsRemind"]').prop("checked", true);
                        }
                        // 是否允许发送事务提醒
                        if(data.isCan=='0'){
                            $('input[name="thingDefault"]').prop("checked", false);
                            $('input[name="smsRemind"]').prop("checked", false);
                            $('#thing').parent('tr').hide();
                        }

                    }
                }
            }
        })

        $('.deptandrole').click(function () {
            if($('.deptrole').is(':hidden')){
                $('.deptrole').show()
            }else {
                $('.deptrole').hide()
            }
        });

        $('[name="remindTixing"]').click(function () {
            if($(this).is(':checked')){
                $(this).siblings('input').val(1)
            }else {
                $(this).siblings('input').val(0)
            }
        });

        $('[name="topDing"]').click(function () {
            if($(this).is(':checked')){
                $(this).siblings('input[type=hidden]').val(1)
            }else {
                $(this).siblings('input[type=hidden]').val(0)
            }
        });

        $('[name="smsRemind"]').click(function () {
            if($(this).is(':checked')){
                $(this).nextAll('input[type=hidden]').val(0)
            }else {
                $(this).nextAll('input[type=hidden]').val(1)
            }
        });

        $('#download_ck').click(function () {
            if($(this).is(':checked')){
                $(this).siblings('input[type=hidden]').val(1)
            }else {
                $(this).siblings('input[type=hidden]').val(0)
            }
        });

        //        查询置顶天数
        $.ajax({
            type:'get',
            url:'/syspara/selectDemo',
            dataType:'json',
            data:{
                paraName:'NOTIFY_TOP_DAYS'
            },
            success:function (res) {
                if(res.flag){
                    if(res.object.paraValue == ''){
                        $('input[name="topDays"]').val('');
                    }else{
                        $('input[name="topDays"]').val(res.object.paraValue);
                    }
                }
            }
        })

        $('.addControls').click(function () {
            var type=$(this).attr('data-type');

            if(type==1){
                dept_id=$(this).siblings('textarea').prop('id');
                $.popWindow("../common/selectDept?allDept=1");
            }else if(type==2){
                priv_id=$(this).siblings('textarea').prop('id');
                $.popWindow("../common/selectPriv");
            }else if(type==3){
                user_id = $(this).siblings('textarea').prop('id');
                $.ajax({
                    url:'/imfriends/getIsFriends',
                    type:'get',
                    dataType:'json',
                    data:{},
                    success:function(obj){
                        if(obj.object == 1){
                            $.popWindow("../common/selectUserIMAddGroup");
                        }else{
                            $.popWindow("../common/selectUser");
                        }
                    },
                    error:function(res){
                        $.popWindow("../common/selectUser");
                    }
                })
            }else if(type==4){
                dept_id=$(this).siblings('textarea').prop('id');
                $.popWindow("../common/selectDept?0");
            }
        });

        $('.recoveryTime').click(function () {
            $(this).siblings('input').val(queryTime())
        });

        fileuploadFn('#fileupload',$('#fileAll'));


        $('.tijiaobtn').click(function () {
            if(!$('#ajaxform select[name="typeId"]').val()){
                layer.msg('<fmt:message code="addiing.th.bulletin" />！',{icon:0});
                return false
            }
            var isEdit=isPublish(getRequestObj.notifyId)
            if(isEdit==1){
                $.layerMsg({content:'<fmt:message code="notice.th.thisAnnouncementHasComeIntoEffect" />！',icon:0},function () {
                    parent.window.location.reload()
                });
                return false
            }
            layer.open({
                title:SubmitExaminationApproval,
                content:'' +
                    '<ul class="formUl">' +
                    '<li class="clearfix"><label>'+hr_th_Approver+'：</label><select name="shenpiren" id=""><option value="">'+ds+'</option></select></li>' +
                    '<li class="clearfix"><label>'+tixing+'：</label><label><input checked="checked" id="chcekedLab" type="checkbox" style="float: none">'+notice_th_remindermessage+'</label></li>' +
                    '</ul>',
                btn:[sure,cancel],
                success:function () {
                    $('input[name="tuisong"]').val('1');
                    $.get('/sys/getDeptManagers',function (json) {
                        if(json.flag){
                            var arr=json.obj;
                            var str='<option value="">'+ds+'</option>';
                            for(var i=0;i<arr.length;i++){
                                str+='<option value="'+arr[i].userId+'">'+arr[i].userName+'</option>'
                            }
                            $('[name="shenpiren"]').html(str)

                        }
                    },'json')
                    $('#chcekedLab').click(function () {
                        var state =$(this).prop("checked");
                        if(state==true){
                            $(this).prop("checked",true);
                            $('input[name="approveRemind"]').val('1');
                            $('input[name="tuisong"]').val('1');
                            $('input[name="remind"]').val('1');
                        }else{
                            $(this).prop("checked",false);
                            $('input[name="approveRemind"]').val('0');
                            $('input[name="tuisong"]').val('0');
                            $('input[name="remind"]').val('0');
                        }
                    })
                },
                yes:function (index) {

                    if($('[name="shenpiren"] option:selected').val() == ''){
                        layer.msg('<fmt:message code="notice.th.pleaseSelectTheApprover" />！',{icon:6});
                    }else {
                        $('[name="auditer"]').val($('[name="shenpiren"]').val());
                        ajaxforms(2)
                    }
                }
            })
        });


        if(getRequestObj.type=='new'){
            var txt = '<fmt:message code="notice.th.createANewNotification" />';
            $('.navigation').find('h2').text(txt);
            $('#ajaxform').attr('action','/notice/addNotify');
            $('[name="sendTimes"]').val(queryTime());


            GetDropDownBox(function () {
                if($('[name="typeId"]').find('option:selected').attr('data-isEdit')==1){
                    $('.sendbtn').hide();
                    $('.tijiaobtn').show()
                }
            });
            $('[name="beginDates"]').val(queryTime(1))

        }else {
            var txt="修改通知"
            $('.navigation').find('h2').text(txt);
            $('#ajaxform').attr('action','newUpdateNotify');
            $('[name="notifyId"]').val(getRequestObj.notifyId);
            ue.ready(function () {
                $.get('getOneById',{
                    notifyId:getRequestObj.notifyId,
                    permissionId:'1',
                    changId:'1'
                },function (json) {
                    if(json.flag){
                        var obj=json.object;
                        var arr=$('input');
                        (function (fn) {
                            for(var i=0;i<arr.length;i++){
                                for(var key in obj){
                                    if($(arr[i]).prop('name')==key){
                                        $(arr[i]).val(obj[key])
                                    }
                                }
                            }
                            fn()
                        })(function () {
                            if($('[name="top"]').val()==1){
                                $('[name="topDing"]').prop('checked',true);
                            }else{
                                $('[name="topDing"]').prop('checked',false);
                            }
                        });
                        $('[name="sendTimes"]').val(obj.notifyDateTime);
                        $('[name="beginDates"]').val(obj.begin);
                        $('[name="endDates"]').val(obj.end);
                        $('[name="summary"]').val(obj.summary);

                        if(obj.howRenind!=""&&obj.howRenind!=undefined){
                            $('input[name="thingDefault"]').prop('checked',false)
                            $('input[name="smsRemind"]').prop('checked',false)
                            var arr = obj.howRenind.split(',');
                            for(var i=0;i<arr.length;i++){
                                if(arr[i] == '0'){
                                    $('input[name="thingDefault"]').prop('checked','checked')
                                }else if(arr[i] == '1'){
                                    $('input[name="smsRemind"]').prop('checked','checked')
                                }
                            }
                        }else{
                            $('input[name="thingDefault"]').prop('checked',false)
                            $('input[name="smsRemind"]').prop('checked',false)
                        }

                        $('#department').val(obj.deprange);
                        $('#department').attr('deptid',obj.toId);
                        if(obj.privId!=''){
                            $('#roleall').attr('userpriv',obj.privId);
                            $('#roleall').val(obj.rolerange);
                            $('#roleall').parent().parent().show()
                        }

                        if(obj.userId!='') {
                            $('#personnel').val(obj.userrange);
                            $('#personnel').attr('user_id', obj.userId);
                            $('#personnel').parent().parent().show()
                        }
                        /*按人员类别发布*/
                        if(obj.userType) {
                            var userTypeArr = obj.userType.split(',');
                            viewUserTypeSelect.setValue(userTypeArr);
                        }
                        /*拟稿部门*/
                        if(obj.draftDept!='') {
                            $('#draftDept').val(obj.draftDeptName);
                            $('#draftDept').attr('deptid', obj.draftDept);
                        }
                        if(obj.download==0){
                            $('#download_ck').removeProp('checked')
                        }
                        if(obj.isOpin==1){
                            $('.setHide').show();
                            $('[name="isOpin"]').attr("checked","checked");
                        }
                        $('[name="field"]').remove();
                        if(("opinionFields" in obj)){
                            var opinions = obj.opinionFields.split("-");
                            var str2='';
                            if(opinions.length>=2){
                                $('#clear').show()
                            }
                            if(opinions.length>=10){
                                $('#add').hide()
                            }
                            $.each(opinions,function (index) {
                                str2 += ' <input type="text" name="field" value="'+opinions[index]+'"  style="width: 200px;"/>'
                            });
                            $('#add').before(str2)
                        }
                        ue.setContent(obj.content);
                        GetDropDownBox(function () {
                            $('[name="typeId"]').val(obj.typeId);
                            if($('[name="typeId"]').find('option:selected').attr('data-isEdit')=='1'){
                                if(getRequestObj.approve == 'true'){
                                    $('.sendbtn').show();
                                    $('.tijiaobtn').hide()
                                }else {
                                    $('.sendbtn').hide();
                                    $('.tijiaobtn').show()
                                }
                            }
                        });
                        var data = obj.attachment;
                        var str = '';;
                        for (var i = 0; i < data.length; i++) {
                            str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" style="color: #000;" NAME="'+data[i].attachName+'*" href="javascript:;">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                        }
                        $('#fileAll').append(str);

                    }else {
                        $.layerMsg({content: networkError, icon: 2});
                    }
                },'json')
            })

        }


        $(document).on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            layer.confirm(ConfirmAttachments, {
                btn: [sure,cancel], //按钮
                title:ifDelete
            }, function() {
                //确定删除，调接口
                $.ajax({
                    type: 'get',
                    url: '../delete',
                    dataType: 'json',
                    data: data,
                    success: function (res) {
                        if (res.flag) {
                            layer.msg(delc, {icon: 6});
                            dome.remove();
                        } else {
                            layer.msg(delf, {icon: 6});
                        }
                    }
                })
            })
        });

        $(document).on('click','.cleardate',function () {
            $(this).siblings('textarea').val('');
            $(this).siblings('textarea').attr('user_id','');
            $(this).siblings('textarea').attr('deptid','');
            $(this).siblings('textarea').attr('deptname','');
            $(this).siblings('textarea').attr('privid','');
            $(this).siblings('textarea').attr('userpriv','');
            $(this).siblings('textarea').attr('username','');
            $(this).siblings('textarea').attr('dataid','');
            $(this).siblings('textarea').attr('userprivname','');
        })
    });


    $(function () {
        ue.ready(function() {
            var runId = $.getQueryString("runId") || '';
            var chkValue = $.getQueryString("chkValue") || '';
            var flowContent = '';
            if(chkValue != ''){
                flowContent = '<link rel="stylesheet" type="text/css" href="/css/workflow/m_reset.css">' +
                    '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/new_work.css">' +
                    '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/bootstrap.css">' +
                    '<link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>' +
                    '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/handle.css"/>' +
                    '<link rel="stylesheet" type="text/css" href="/css/dept/roleAuthorization.css?20210311.1"/>' +
                    '<link rel="stylesheet" href="/css/workflow/work/workFormPreView.css?20191210.1"><style>.cont_form{height: auto;}</style>'
                // 表单信息
            }

            if(chkValue.indexOf('1')!=-1){
                try {
                    $(".cont_form script",window.opener.document).remove()
                    var form_content = $(".cont_form",window.opener.document).html();
                    flowContent+='<div class="cont_form" id="a2">'+form_content+'</div>';
                }catch (e) {
                    alert("表单出错，请回去重新选择！")
                    window.opener=null
                    window.top.open('','_self','')
                    window.close();
                }

            }

            // 附件信息
            if(chkValue.indexOf('2')!=-1){
                // if($(".theAttachment",window.opener.document).css('display')!='none'){
                //兼容win7系统的ie模式
                if(window.opener.document.querySelector('.theAttachment').style.display!='none'){
                    var attachment_content = $(".theAttachment",window.opener.document).html();
                    flowContent+='<div class="theAttachment">'+attachment_content+'</div>';
                    //此处附件显示和公共附件显示重复，暂时注释此处代码
                    // 请求接口 设置附件回显到公告附件
                    /* $.get('/flowUtil/flowAttach2Other',{
                         runId:runId,
                         module:"notify"
                     },function (res) {
                         var data = res.obj;
                         var str = '';
                         for (var i = 0; i < data.length; i++) {
                             str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" style="color: #000;" NAME="'+data[i].attachName+'*" href="javascript:;">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                         }
                         $('#fileAll').append(str);
                     })*/
                }
            }

            // 会签意见
            if(chkValue.indexOf('3')!=-1){
                // if($(".steptextcheck",window.opener.document).css('display')!='none'){
                //兼容win7系统的ie模式
                if(window.opener.document.querySelector('.steptextcheck').style.display!='none'){
                    var check_content = $(".steptextcheck",window.opener.document).html();
                    flowContent+='<div class="steptextcheck">'+check_content+'</div>'
                }
            }

            // 流程图
            if(chkValue.indexOf('4')!=-1){
                var liucheng_content = $(".steptextliucheng",window.opener.document).html();
                flowContent+='<div class="steptextliucheng">'+liucheng_content+'</div>'
            }

            // 公文正文
            if(chkValue.indexOf('5')!=-1){
                /*if($(".theAttachment",window.opener.document).css('display')!='none'){
                    var attachment_content = $(".theAttachment",window.opener.document).html();
                    flowContent+='<div class="theAttachment">'+attachment_content+'</div>';
                }*/
                // 请求接口 设置附件回显到公告附件
                $.get('/flowUtil/flowAttachDocument',{
                    runId:runId,
                    module:"notify"
                },function (res) {
                    var data = res.obj;
                    var str = '';
                    for (var i = 0; i < data.length; i++) {
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a href="/download?'+encodeURI(data[i].attUrl)+'" class="ATTACH_a" style="color: #2b7fe0;" NAME="'+data[i].attachName+'*" href="javascript:;"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }
                    $('#fileAll').append(str);
                    $('#ajaxform input[name="subject"]').val(res.object)
                    $('#ajaxform select[name="typeId"]').val(res.obj1)
                })
            }
            ue.setContent(flowContent);
        });

    });

</script>
</body>
</html>