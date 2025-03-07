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
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="file.th.newfile" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/email/writeMail.css"/>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/email/writeMail.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>

    <style>
        table{margin-top:10px;}
        table tr td{padding-left:10px;}
        .files a{text-decoration: none;}
        .div_btn .sureBtn{
            float: left;
            margin-right: 20px;
            width: 77px;
            height: 37px;
            background: url("../img/icon_saved.png") no-repeat;
            /*background-size:100% 100%;*/
            line-height: 37px;
            cursor: pointer;
            border-right: #ccc 1px solid;
            border-radius: 5px;
        }
        .div_btn .saveBtn{
            float: left;
            width: 85px;
            height: 37px;
            background: url("../img/icon_sendNow.png") no-repeat;
            /*background-size:100% 100%;*/
            line-height: 37px;
            cursor: pointer;
            border-right: #ccc 1px solid;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<table class="TABLE" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
                <tr class="append_tr">
                    <td width="10%"><fmt:message code="file.th.name" />：</td>
                    <td width="89%">
                        <input type="text" id="txt1" value="" class="input_txt" />
                        <img class="td_title2" src="../img/mg2.png" alt="">
                    </td>
                </tr>
                <tr>
                    <td><fmt:message code="file.th.Sort" />：</td>
                    <td>
                        <input type="text" id="txt2" value="" class="input_txt" />
                        <img class="td_title2" src="../img/mg2.png" alt="">
                    </td>
                </tr>
                <tr>
                    <td width="10%">
                        <p><fmt:message code="file.th.filecontent" />：</p>

                    </td>
                    <td width="89%">
                        <div id="container" style="width: 99.9%;min-height: 300px;" name="content" type="text/plain"></div>
                     </td>
                 </tr>
                 <tr class="Attachment" style="width:100%;">
                       <td width="10%"><fmt:message code="depatement.th.Attachmentdocument" />：</td>
                       <td width="89%"   class="files" id="files_txt"></td>
                 </tr>
                <tr>
                <td><fmt:message code="email.th.filechose" />：</td>
            <td class="files" style="position: relative">

                <form id="uploadimgform" target="uploadiframe"  action="../upload?module=file_folder" enctype="multipart/form-data" method="post" >
                    <input type="file" name="file" id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;
                    filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                    <a href="javascript:;" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
                </form>

             </td>
                </tr>
                <tr>
                    <td><fmt:message code="doc.th.AppendixDescription" />：</td>
                    <td><input type="text" name="txt" id="txt3" class="txt"></td>
                 <tr>
                <tr>
                <td colspan="2">
                <div class="div_btn" style="width:190px;">
                     <div class="sureBtn" id="btn1"><span style="margin-left: 30px;"><fmt:message code="global.lang.save" /></span></div>
                     <div class="saveBtn" id="btn2"><span style="margin-left: 33px;"><fmt:message code="notice.th.return" /></span></div>
                    <!--<input type="button" id="btn1" value="确定" />
                    <input type="button" id="btn2" value="返回" />-->
                </div>

                </td>
                </tr>
                </table>


    <script type="text/javascript">
            var ue = UE.getEditor('container',{elementPathEnabled : false});
            $(function(){
                $('.TABLE').on('click','#selectUserO',function(){
                    user_id='copeNameText';
                    $.popWindow("../common/selectUser");
                })
                $('.TABLE').on('click','#selectUserT',function(){
                    user_id='secritText';
                    $.popWindow("../common/selectUser");
                })
                //附件上传方法

                $('#uploadinputimg').fileupload({
                    dataType:'json',
                    done: function (e, data) {
                        if(data.result.obj != ''){
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                var gs = data[i].attachName.split('.')[1];
                                if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ||gs == 'php'){
                                    str += '';
                                    layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                        layer.closeAll();
                                    });
                                }else{
                                    str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*" fileSize="' + data[i].fileSize + ',"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                                }
                            }
                            $('.Attachment td').eq(1).append(str);
                        }else{
                            //alert('添加附件大小不能为空!');
                            layer.alert('添加附件大小不能为空!',{},function(){
                                layer.closeAll();
                            });
                        }
                    }
                });

                $('.Attachment').on('click','.deImgs',function(){
                    var data=$(this).parents('.dech').attr('deUrl');
                    var dome=$(this).parents('.dech');
                    deleteChatment(data,dome);
                })
                if ($.getQueryString('contentId')){
                    $("title").html("<fmt:message code="sys.th.edit" />");
                    var conId=$.getQueryString('contentId');
                    var childSortId=$.getQueryString('sortId');
                    var conType=$.getQueryString('contype');
                    if(childSortId == ''){
                        childSortId = '0';
                    }
                    ue.ready(function(){
                        $.ajax({
                            type:'post',
                            url:'${pageContext.request.contextPath}/file/getContentById',
                            dataType:'json',
                            data:{'contentId':conId},
                            success:function(rsp){
                                var data1=rsp.attachmentList;
                                var str='';
                                var str1='';
                                $('#txt1').val('');
                                $('#txt2').val('');
                                ue.setContent('');
                                $('#files_txt').text('');
                                $('#txt3').val('');

                                for(var i=0;i<data1.length;i++){
                                    str+='<div class="dech" deUrl="'+encodeURI(data1[i].attUrl)+'"><a href="/download?'+encodeURI(data1[i].attUrl)+'" NAME="'+data1[i].attachName+'*"fileSize="' + data1[i].size + ',"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data1[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data1[i].aid+'@'+data1[i].ym+'_'+data1[i].attachId+',"></div>';
                                    /*str1+='<input type="hidden" class="inHidden" value="'+data1[i].aid+'@'+data1[i].ym+'_'+data1[i].attachId+',">';*/
                                }
                                $('#txt1').val(rsp.subject);
                                $('#txt2').val(rsp.contentNo);
                                ue.setContent(rsp.content);
                                /*$('#files_txt').text(rsp.attachmentName);*/
                                /*$('#files_txt').append(str+str1);*/
                                $('#files_txt').append(str);
                                $('#txt3').val(rsp.attachmentDesc);

                            }
                        })
                     })
                    //删除编辑中的附件
                    $('#files_txt').on('click','.deImgs',function(){
                        var data=$(this).parents('.dech').attr('deUrl');
                        var dome=$(this).parents('.dech');
                        deleteChatment(data,dome);
                    })
                    //编辑保存
                    $("#btn1").on("click",function(){
                        var subject=$('#txt1').val();
                        var contentNo=$('#txt2').val();
                        var html = ue.getContent();
                        var txt = ue.getContentTxt();
                        var attach=$('.Attachment td').eq(1).find('a');
                        var attachmentDesc=$('#txt3').val();
                        var aId='';
                        var uId='';
                        var fId='';
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            aId += $('.Attachment td .inHidden').eq(i).val();
                        }
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            uId += attach.eq(i).attr('NAME');
                        }
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            fId += attach.eq(i).attr('fileSize');
                        }
                        var data={
                            'contentId':conId,
                            'sortId':childSortId,
                            'subject':subject,
                            'contentNo':contentNo,
                            'content':html,
                            'attachmentId':aId,
                            'attachmentName':uId,
                            'attachmentDesc':attachmentDesc,
                            'fileSize':fId
                        };
                        $.ajax({
                            type:'post',
                            url:'${pageContext.request.contextPath}/file/updateContent',
                            dataType:'json',
                            data:data,
                            success:function(data1){
                                var flag=data1.flag;
                                if (flag==true){
                                    $.layerMsg({content:'<fmt:message code="menuSSetting.th.editSuccess" />！',icon:1},function(){
                                        if(conType == '1'){
                                            window.opener.parentajax(childSortId);
                                        }else if(conType == '2'){
                                            window.opener.queryOneDatasd(childSortId);
                                        }else {
//                                            window.opener.queryAllDatasd();
                                            window.opener.openerShow();
                                        }

                                        $('#txt1').val('');
                                        $('#txt2').val('');
                                        ue.setContent('');
                                        $('#files_txt').val('');
                                        $('#txt3').val('');
                                        window.close();
                                        window.opener.location.reload();
                                    });
                                }else{
//                                    $.layerMsg({content:data1.msg,icon:2},function(){
//                                    $.layerMsg({content:'新建失败！',icon:2})
                                    layer.msg('保存失败！', {icon: 2});
                                        <%--console.log('<fmt:message code="depatement.th.modifyfailed" />');--%>
//                                    });
                                }

                            }
                        });
                    })

                }else{
                    var sortId=$.getQueryString('sortId')
                    var txt="${text}";
                    $('#txt2').val('10');
                    //点击保存
                    $("#btn1").on("click",function(){
                        var subject=$('#txt1').val();
                        var contentNo=$('#txt2').val();
                        var html = ue.getContent();
                        var txt = ue.getContentTxt();
                        var attach=$('.Attachment td').eq(1).find('a');
                        var attachmentDesc=$('#txt3').val();
                        var aId='';
                        var uId='';
                        var fId='';
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            aId += $('.Attachment td .inHidden').eq(i).val();
                        }
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            uId += attach.eq(i).attr('NAME');
                        }
                        for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                            fId += attach.eq(i).attr('fileSize');
                        }
                        var data={
                            'sortId':sortId,
                            'subject':subject,
                            'contentNo':contentNo,
                            'content':html,
                            'attachmentId':aId,
                            'attachmentName':uId,
                            'attachmentDesc':attachmentDesc,
                            'fileSize':fId
                        };
                        if($('#txt1').val()=='' || $('#txt2').val()==''){
                            layer.msg('<fmt:message code="sup.th.With*" />！', {icon: 6});
                            return false;
                        }

                        $.ajax({
                            type:'post',
                            url:'${pageContext.request.contextPath}/file/saveContent',
                            dataType:'json',
                            data:data,
                            success:function(data1){
                                var flag=data1.flag;
                                if (flag==true){
                                    $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully" />！',icon:1},function(){
                                        window.opener.parentajax(sortId);
                                        $('#txt1').val('');
                                        $('#txt2').val('');
                                        ue.setContent('');
                                        $('#files_txt').val('');
                                        $('#txt3').val('');
                                        window.close();
                                    });
                                }else{
//                                    $.layerMsg({content:data1.msg,icon:2});
                                    layer.msg('新建失败！', {icon: 2});
                                }
                            }
                        });
                    })
                }
                //返回按钮
                $('#btn2').click(function(){
                    $('#txt1').val('');
                    $('#txt2').val('');
                    ue.setContent('');
                    $('#files_txt').val('');
                    $('#txt3').val('');
                    window.close();
                })

                //删除附件
                function deleteChatment(data,element){

                    layer.confirm('<fmt:message code="workflow.th.que" />？', {
                        btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
                        title:"<fmt:message code="notice.th.DeleteAttachment" />"
                    }, function(){
                        //确定删除，调接口
                        $.ajax({
                            type:'get',
                            url:'../delete',
                            dataType:'json',
                            data:data,
                            success:function(res){

                                if(res.flag == true){
                                    layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                                    element.remove();
                                }else{
                                    layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
                                }
                            }
                        });

                    }, function(){
                        layer.closeAll();
                    });
                }
            })



            </script>
</body>
</html>


