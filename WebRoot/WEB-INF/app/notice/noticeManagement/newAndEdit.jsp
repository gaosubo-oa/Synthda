
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
    <title><fmt:message code="notice.th.buildnotify"/></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="../lib/ueditor/formdesign/bootstrap/css/bootstrap.css"/>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20230324.2" type="text/javascript" charset="utf-8"></script>
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
<%--    <script type="text/javascript" src="../js/email/fileuploadPlus.js?20230530"></script>--%>
<%--    <script type="text/javascript" src="../js/email/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/common/fileupload.js?20230529.3"></script>
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
        p{
            text-align: justify;
        }
        .obTitle{
            width: 25px;
        }
        .operation{
            display: inline-block;
        }
    </style>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/notice/newAndEdit.js?20230608.2"></script>
    <script src="/js/notice/flowNotice.js?20220601" type="text/javascript" charset="utf-8"></script>

    <script>

    </script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/newsManages2_1.png" alt="">
    <h2></h2>

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
                    <input type="text" name="subject" id="subject" placeholder="<fmt:message code="global.lang.printsubject"/>">
                    <b id="symbol">*</b>
                </td>
            </tr>
            <tr >
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
            <tr class="deptrole" style="display: table-row;">
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
            <tr>
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
                    <input style="width: 204px" readonly="readonly" type="text" name="beginDates" placeholder="<fmt:message code="adding.th.PleasePeriod"/>" onclick="laydate({istime: false, format: 'YYYY-MM-DD'})">
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
                    <input type="checkbox" name="smsRemind" value="1">
                    <span ><fmt:message code="vote.th.UseRemind"/></span>
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
                    <input type="text" name="topDays" value="" style="height: 20px;width: 23px;">
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
                    <a href="javascript:;" class="openFile" style="float: left;">
                        <img src="../img/mg11.png" alt="">
                        <span><fmt:message code="file.th.folderUpload" /></span>
                        <input webkitdirectory type="file" multiple id="fileupload2" data-url="../upload?module=notify" name="file">
                    </a>
                    <span id="fileTips" style="color: #b6b1b1"><fmt:message code="file.th.fileUploadDesc" /></span>
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
        <h5 style="color: #5BC0DE;"><fmt:message code="workflow.th.doing" /></h5>
    </div>
</div>
<script>

    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue==1){
                    $('.navigation').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 35px;margin-top: 10px;"> 机密级★ </p>')
                }
            }
        }
    })

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
    $('#back').on('click',function(){
        if($(this).is(':checked')){
            $('.setHide').show()
        }else{
            $('.setHide').hide()
        }
    })
    $('#add').on('click',function(){
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
    $('#clear').on('click',function(){
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
    $('.backnotice').on('click',function(){
        window.location.href='/notice/management';
    })
    function wordimport(key){
        var me=this;
        $("#wordimportfile").trigger('click');
    }
    getNoticeDays();
    var tDays = "";
    function getNoticeDays() {
        var  paraName = 'NOTIFY_TOP_DAYS'
        $.ajax({
            url:"/syspara/selectByParaName",
            type:'get',
            data:{paraName:paraName},
            success:function(res){
                if (res.flag){
                    tDays = res.object?res.object:0;
                    $("[name='topDays']").val(res.object);
                }
            }
        })
    }
    $("[name='topDays']").on("input",function() {
       var val = $(this).val();
        if(isNaN(val)) {
            layer.msg("<fmt:message code="notice.th.theEndTimeForPinningMustBeFilledWithNumbers" />",{icon:2})
            $(this).val("")
            return
        }
        if(+val > tDays) {
           layer.msg("<fmt:message code="notice.th.endTimeExceedingTheSetNumberOfDays" />",{icon:2})
            $(this).val(tDays)
            return
        }
        // if(parseInt(val) == 0){
        //     layer.msg("结束置顶时间不能为0",{icon:2})
        //     $(this).val(tDays)
        // }
    })
    //文件夹上传
    fileuploadFn('#fileupload2',$('#fileAll'));
    <%--$('#wordimportfile').fileupload({--%>
    <%--    dataType:'json',--%>
    <%--    done: function (e, data) {--%>
    <%--        if(data.result.obj != ''){--%>
    <%--            var data = data.result.obj;--%>
    <%--            var str = '';--%>
    <%--            var str1 = '';--%>

    <%--            for (var i = 0; i < data.length; i++) {--%>
    <%--                var gs = data[i].attachName.split('.')[1];--%>
    <%--                if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php'||gs == 'xls'||gs == 'xlsx' ){--%>
    <%--                    str += '';--%>
    <%--                    layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){--%>
    <%--                        layer.closeAll();--%>
    <%--                    });--%>
    <%--                }else{--%>
    <%--                    str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';--%>
    <%--                }--%>
    <%--                &lt;%&ndash;if(gs != 'doc' ){&ndash;%&gt;--%>
    <%--                &lt;%&ndash;str += '';&ndash;%&gt;--%>
    <%--                &lt;%&ndash;layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){&ndash;%&gt;--%>
    <%--                &lt;%&ndash;layer.closeAll();&ndash;%&gt;--%>
    <%--                &lt;%&ndash;});&ndash;%&gt;--%>
    <%--                &lt;%&ndash;}else{&ndash;%&gt;--%>
    <%--                &lt;%&ndash;str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';&ndash;%&gt;--%>
    <%--                &lt;%&ndash;}&ndash;%&gt;--%>
    <%--            }--%>
    <%--            // $('#query_uploadArr').append(str);--%>
    <%--            // $('#query_uploadArr').val();--%>
    <%--        } else{--%>
    <%--            //alert('添加附件大小不能为空!');--%>
    <%--            layer.alert('添加附件大小不能为空!',{},function(){--%>
    <%--                layer.closeAll();--%>
    <%--            });--%>
    <%--        }--%>
    <%--    }--%>
    <%--});--%>

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
                console.log(error);
                $("#loadingModal").modal('hide');
            }

        });
    }

</script>
</body>
</html>
