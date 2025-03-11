<%--
  Created by IntelliJ IDEA.
  User: liruix
  Date: 2017/6/13
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<style>

</style>
<head>
    <title><fmt:message code="urlth.Nicknames" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">

<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.form.min.js"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>


    <style>
        .title{
            height:35px;
            line-height:35px;
        }
        .title span{
            margin-left:0px;
            font-size:22px;
            line-height:35px;
        }
        .title img{
            margin-left:15px;
            vertical-align: middle;
            width:24px;
            height:26px;
            padding-bottom:8px;
        }

        #btn1 {
            background: url("/img/confirm.png") no-repeat;
            border: none;
            width: 65px;
            padding-left: 6px;
            height: 29px;
            line-height: 29px;
            cursor: pointer;
        }
        #btn,#signBtn{
            cursor: pointer;
            background-color: #6299d9;
            padding: 2px 5px;
            border-radius: 4px;
            color: #fff;
        }
        .tr_td tr:nth-child(odd){
            background: #fff;
        }
        .tr_td tr:nth-child(1){
            background: #F6F7F9
        }
        .upsign{
            /*position: absolute;*/
            /*left: 0px;*/
            /*width: 107px;*/
            /*opacity: 0;*/
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
    <div class="title">
        <img src="../img/information.png" alt="个人资料">
        <span><fmt:message code="urlth.Nicknames" /></span>
    </div>
    <form method="post" action="/user/editUserExt" enctype="multipart/form-data" id="editUserExtForm">
        <table class="tr_td tableStyle" width="65%" align="center" style="margin-top:30px;">
            <tbody>
            <tr>
                <td colspan="2" style="text-align: center">
                    <fmt:message code="urlth.Nicknames" />
                </td>
            </tr>
            <tr>
                <td nowrap="" class="TableData" style="width: 88px;"><img src="../img/icon_petname.jpg" alt="昵称">&nbsp;<fmt:message code="ur.th.NicknamesUser" />：</td>
                <td nowrap="" class="TableData">
                    <input type="text" name="nickName" id="nickName" style="margin: 0;" class="inp" size="5" maxlength="10" value="">&nbsp;<br>
                </td>
            </tr>
            <tr>
                <td nowrap="" class="TableData"><img src="../img/icon_persignature.png" alt="讨论区签名档">&nbsp;<fmt:message code="url.th.Discussion" />：</td>
                <td nowrap="" class="TableData">
                    <input type="text" name="bbsSignature" id="bbsSignature" style="margin: 0" class="inp" size="25" maxlength="100" value="">&nbsp;
                </td>
            </tr>
            <tr class="setImg">
                <td nowrap="" class="TableData"><img src="../img/icon_perimg.jpg" alt="<fmt:message code="url.th.UploadPhotos" />">&nbsp;<fmt:message code="url.th.UploadPhotos" />：</td>
                <td nowrap="" class="TableData">
                    <span id="showImage" ></span>
                    <span id="btn"><fmt:message code="url.th.UploadPhotos" /></span>
                    <input type="hidden"  class="imageFile1 imageFile" name="avatar">
                    <input type="hidden"  class="imageFile1 imageFile0" name="avatar128" >
                    <input type="file"  name="imageFile" id="imageFile" class="BigInput imageFile2" size="40" title="选择图片" style="height: 27px;" onchange="getPhoto(this)">&nbsp;
                    <%-- <span>照片文件要求是jpg、jpeg、png格式，尺寸不能低于200*200像素。照片主要用于用户名片的显示。</span>--%>
                </td>
            </tr>

            <tr class="showImg" style="display: none">
                <td><img src="../img/icon_perhead.jpg" alt="头像">&nbsp;<fmt:message code="url.th.HeadPortrait" />:</td>
                <td>
                    <image  style="width:140px;height:140px;border-radius: 100%;border: 1px solid #d6d6d6;" id="image"> &nbsp;&nbsp;<input type="button" id="delImg" value="<fmt:message code="global.lang.delete" />"></image>
                </td>
            </tr>
            <tr class="writeSign">
                <td nowrap="" class="TableData"><img src="../img/icon_persignature.png" alt="手写签字">&nbsp;<fmt:message code="url.th.signaturePicture" />：</td>
                <td nowrap="" class="TableData" style="position:relative">
                    <div id="showSign" style="display: none;margin-bottom: 10px;vertical-align: middle"><img src="" alt="" style="width:140px;"><input type="button" id="delSign" style="margin-left:10px;" value="删除"></div>
                    <span id="signBtn"><fmt:message code="url.th.uploadSignaturePicture" /></span>
                    <input type="hidden"  class="signImageId" name="signImageId">
                    <input type="hidden"  class="signImageName" name="signImageName">
                    <input type="file"  name="file" id="uploadinputimg" class="upsign"  title="" style="height: 27px;position: absolute;top:3px;left:0px;opacity: 0;width:107px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)"  accept="image/png,image/jpg,image/jpeg,image/gif"  >


                    <%-- <span>照片文件要求是jpg、jpeg、png格式，尺寸不能低于200*200像素。照片主要用于用户名片的显示。</span>--%>
                </td>
            </tr>

            <tr>
                <td nowrap="" class="TableControl" colspan="2" align="center">
                    <div style="margin:0 auto;width: 130px">
                        <div class="Btn submitBut" id="btn1"><span style="margin-left: 14px;"><fmt:message code="global.lang.save" /></span></div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
    <iframe id="every_module" src="" frameborder="0" scrolling="yes" height="90%" width="100%" noresize="noresize" tid="2" style="display:none"></iframe>
</body>
<!--[if (gte IE 10)|(!IE)]> -->
<script>$('.imageFile2').remove();$('#editUserExtForm').attr('action','/user/editNewUserImg');</script>
<!-- <![endif]-->
<!--[if lt IE 10]>
<script>$('.imageFile1').remove();$('#btn').remove()</script>
<![endif]-->
<script>
    $(function () {
        init();
    })
    function init(){
        $.ajax({
            type: 'get',
            url: '../user/getUserByuid',
            dataType: 'json',
            data: uid={
                uid:-1
            },
            success: function (res) {
                if(res.flag){

                    $("#nickName").val(res.object.userExt.nickName);
                    $("#nickName").attr('sex',res.object.sex);
                    $("#nickName").attr('avatar',res.object.avatar128);
                    $("#bbsSignature").val(res.object.userExt.bbsSignature);
                    if(res.object.signImageName!=''&&res.object.signImageName!=undefined){
                        $('#showSign').show();

                        $('#showSign img').attr('src','/xs?'+encodeURI(res.object.attachment[0].attUrl))
                        $('.signImageId').val(res.object.signImageId)
                        $('.signImageName').val(res.object.signImageName)
                        $('#signBtn').hide();
                        $('#uploadinputimg').hide();
                    }else{
                        $('#showSign').hide();
                        $('#signBtn').show();
                        $('#uploadinputimg').show();
                    }
                    if(res.object.avatar==''){
                        $('.showImg').hide();
                    }else{
                        if(res.object.avatar == '0'){
                            $('#image').attr('src','../img/boyMax.png');
                        }else if(res.object.avatar == '1'){
                            $('#image').attr('src','../img/girlMax.png');
                        }else if(res.object.avatar == ''){
                            if(res.object.sex == '1'){
                                $('#image').attr('src','../img/girlMax.png');
                            }else{
                                $('#image').attr('src','../img/boyMax.png');
                            }
                        }else{
                            $('#image').attr('src','../img/user/'+res.object.avatar128);
                        }
                        $('.imageFile').val(res.object.avatar);
                        $('.imageFile0').val(res.object.avatar128);
                        $('.showImg').show();
                    }
                }
            }
        })
    }
    $(".submitBut").on('click',function () {
        $('#editUserExtForm').attr('action','/user/editNewUserImg')
        $('#editUserExtForm').ajaxSubmit({
            type:'post',
            dataType:'json',
            success:function (json) {
                if(json.flag) {
                    $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1}, function () {
                        parent.parent.location.reload();
                    });
                }else{
                    $.layerMsg({content: json.msg+'！', icon: 1}, function () {
                    });
                }
            }
        })
    })
    $('#delSign').on('click',function(){
        $('.signImageId').val('')
        $('.signImageName').val('')
        $('#showSign').hide();
        $('#signBtn').show();
        $('#uploadinputimg').show();
    })
    //上传图片
    $('#uploadinputimg').on('change',function(){
        var uploadType = ['image/jpeg','image/jpg','image/png','image/gif']
        if(uploadType.indexOf(this.files[0].type) > -1){
            fileuploadFn('#uploadinputimg',$('.Attachment td').eq(1));
        }else{
            $('#editUserExtForm').attr('action','')
            layer.alert('请上传图片!',{},function(){
                layer.closeAll();
            });
        }
    })
    fileuploadFn('#uploadinputimg',$('.Attachment td').eq(1));
    function fileuploadFn(formId,element) {
        $('#editUserExtForm').attr('action','/upload?module=user')

        // $('#uploadinputimg').fileupload({
        $(formId).fileupload({
            dataType:'json',

            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                layer.closeAll();
                            });
                        }else{
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
                            var name = data[i].attachName+'*'
                            var attId = data[i].aid + '@' + data[i].ym + '_' + data[i].attachId+','
                        }
                    }
                    $('#showSign').show();
                    $('#showSign img').attr('src','/xs?'+deUrl)
                    $('.signImageId').val(attId)
                    $('.signImageName').val(name);
                    $('#signBtn').hide();
                    $('#uploadinputimg').hide();
                    // $('.Attachment td').eq(1).append(str);
                    // element.append(str);
                }else{
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });
    }
    $('#btn').on('click',function(){
        $.ajax({
            type: 'get',
            url: '../sys/getAvatarUpload',
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    if (res.object.avatarUpload == '1') {
                        $('#editUserExtForm').hide();
                        $('#every_module').attr('src', 'form?avter=' + $("#nickName").attr("avatar") + '&sex=' + $("#nickName").attr("sex"))
                        $('#every_module').show();
                    } else {
                        $.layerMsg({content: '请到界面设置中开启允许此功能！', icon: 0}, function () {
                        });
                    }
                }
            }
        })
        <%--if($(document).height()<700){--%>
            <%--var height = 452;--%>
        <%--}else if($(document).height()>800){--%>
            <%--var height = 712;--%>
        <%--}else{--%>
            <%--var height = 612;--%>
        <%--}--%>
        <%--layer.open({--%>
            <%--type: 1,--%>
            <%--title: ['上传图片', 'background-color:#2b7fe0;color:#fff;'],--%>
            <%--area: ['800px', height+'px'],--%>
            <%--shadeClose: true, //点击遮罩关闭--%>
            <%--btn: ['<fmt:message code="global.lang.ok" />'],--%>
            <%--content:'<div style="width: 100%;height: 100%;"><iframe id="every_module" src="form?avter='+$("#nickName").attr('avatar')+'&sex='+$("#nickName").attr('sex')+'" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>',--%>
            <%--yes:function(index){--%>
                <%--$("#every_module").contents().find('#btnCrop').click();--%>
<%--//                layer.close(index);--%>
            <%--}--%>
        <%--})--%>
    })
    $('#delImg').on('click',function(){
        $("#imageFile").val('');
        $('.imageFile1').val('');
        $("#nickName").attr('avatar','');
        $("#nickName").attr('sex','');
        $('.setImg').show();
        $('.showImg').hide();
    })
    function getPhoto(node) {
        $('.showImg').hide();
    }

</script>
</html>
