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
    <link rel="stylesheet" type="text/css" href="/lib/ueditor/formdesign/bootstrap/css/bootstrap.css"/>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/formdesign/bootstrap/js/bootstrap.js?20200928" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/email/writeMail.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>

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
        .bar {
            height: 18px;
            background: green;
        }
    </style>
</head>
<body  onload="GetScannerName()">
<object classid="CLSID:9134F6A9-1FF8-420F-9E9E-DDD374C19715" id="FScanX" width="0" height="0"></object>
<table class="TABLE" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;width: 98%;">
    <tr class="append_tr">
        <td width="13%"><fmt:message code="file.th.name" /></td>
        <td width="87%">
            <input type="text" id="txt1" value="" class="input_txt" />
            <img class="td_title2" src="../img/mg2.png" alt="">
        </td>
    </tr>
    <tr>
        <td><fmt:message code="file.th.Sort" /></td>
        <td>
            <input type="text" id="txt2" value="" class="input_txt" />
            <img class="td_title2" src="../img/mg2.png" alt="">
        </td>
    </tr>
    <tr>
        <td width="10%">
            <p><fmt:message code="file.th.filecontent" /></p>

        </td>
        <td width="89%" style="padding: 10px;">
            <div id="container" style="width: 99.9%;min-height: 300px;" name="content" type="text/plain"></div>
        </td>
    </tr>
    <tr class="Attachment" style="width:100%;">
        <td width="10%"><fmt:message code="depatement.th.Attachmentdocument" /></td>
        <td width="89%"   class="files" id="files_txt"></td>
    </tr>
    <tr>
        <td width="10%"><fmt:message code="file.th.scanTypeSelection" /></td>
        <td width="89%" style="padding: 5px;" >
            <span><fmt:message code="file.th.scanningMethod" />：</span>
            <select name="" id="smType" style="height: 25px;">
                <option value="0"><fmt:message code="file.th.flatbed" /></option>
                <option value="1" selected><fmt:message code="file.th.ADFFront" /></option>
                <option value="2"><fmt:message code="file.th.ADFDouble-sided" /></option>
            </select>
            <span><fmt:message code="file.th.scanningMode" />：</span>
            <select name="" id="smms" style="height: 25px;">
                <option value="0" selected><fmt:message code="file.th.blackAndWhite" /></option>
                <option value="1" ><fmt:message code="file.th.grayScale" /></option>
                <option value="2" ><fmt:message code="file.th.color" /></option>
            </select>
            <span><fmt:message code="file.th.selectAScanner" />：</span>
            <select name="ScannerName" style="height: 25px;" id="ScannerName" onchange = "SelScanner()"></select>
        </td>
    </tr>
    <tr id="attachment">
        <td><fmt:message code="email.th.filechose" /></td>
        <td class="files" style="position: relative">
            <!-- <fmt:message code="email.th.addfile" /> -->
            <form id="uploadimgform" style="float: left;margin: 0 20px 0 0;" target="uploadiframe"  action="/upload?module=email"  method="post" >
                <input type="file" multiple="multiple" name="file"  id="uploadinputimg"  class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                <a href="#" id="uploadimg" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
            </form>
            <%--            <form id="fileform" style="float: left;margin: 0 20px 0 0;" target=""  action=""  method="post" >--%>
            <%--                <a href="#" id="uploadfile" style="display: inline-block;height: 20px;line-height: 20px" onclick="fileBox()"><img style="margin:3px 5px 0 0;float: left;" src="../img/mg12.png"/><fmt:message code="email.th.selectUpload" /></a>--%>
            <%--            </form>--%>
            <form id="uploadimgform2" style="float: left;margin: 0 20px 0 0;"   action=""  method="post" >
                <input webkitdirectory type="file" multiple="multiple" name="file"  id="Folder"  class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                <a href="#" id=" upload" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message code="file.th.folderUpload" /></a>
            </form>
            <span id="fileTips" style="color: #b6b1b1"><fmt:message code="file.th.fileUploadDesc" /></span>
            <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
                <div class="bar" style="width: 0%;"></div>
            </div>
            <div class="barText" style="float: left;margin-left: 10px;"></div>

            <%--            扫描按钮--%>
            <div style="margin-top:35px"><a href="javascript:;"  onclick="Scan()"><img style="margin-right:5px;" src="../img/icon_uplod.png"><fmt:message code="file.th.scanFiles" /></a>
            </div>

        </td>
    </tr>
    <tr>
        <td><fmt:message code="doc.th.AppendixDescription" /></td>
        <td style="padding: 5px 10px;"><input type="text" name="txt" id="txt3" class="txt" style="width: 30%;height: 30px;"></td>
    <tr>
    <tr id="reminds">
        <td><fmt:message code="sms.th.remind" /></td>
        <td style="padding: 5px 10px;">
            <input type="checkbox" name="remind" class="remindCheck" checked>
            <fmt:message code="notice.th.remindermessage" />&nbsp;
            <input type="checkbox" name="smsDefault"  class="smsDefault">
            <span class="hideSpan" ><fmt:message code="vote.th.UseRemind" /></span>
        </td>
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

<script type="text/javascript">
    // 隐藏附件上传
    $(function(){
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.TABLE').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 10px;"> 机密级★ </p>')
                    }
                }
            }
        })
        // 公共文件柜会报错所以try catch
        try {
            var totalFileSize = window.opener.document.getElementById("totalFileSize").innerHTML * 1;
            var folderCapacity = window.opener.document.getElementById("folderCapacity").innerHTML * 1;
            if (totalFileSize > folderCapacity) $('#attachment').hide();
        } catch (e) {}
    });
    <%--    下面是扫描仪的方法--%>
    var StartIndex = 1;//图像名称起始编号
    function GetScannerName() {
        var i = 0;
        setTimeout(function(){
            var ScannerCount = FScanX.GetScannerCount();
            var obj = document.getElementById("ScannerName");
            obj.options.length = 0;
            for (i = 0 ; i < ScannerCount ; i++) {
                var ScannerName = FScanX.GetScannerName(i);
                var objOption = document.createElement("OPTION");
                objOption.text = ScannerName;
                objOption.value = i;
                obj.options.add(objOption);
            }
            SelScanner();
        },500)

    }
    function SelScanner() {
        var obj = document.getElementById("ScannerName");
        var index = obj.selectedIndex;
        var ScannerName = obj.options[index].text;
        FScanX.SelScannerByName(ScannerName);
    }

    function isIE() {

        if (window.navigator.userAgent.indexOf("MSIE") >= 1)
            return true;
        else
            return false;
    }
    function Scan() {
        // alert(isIE())
        // if(isIE()){


        if($('#ScannerName').html()!=''){

            FScanX.ScanShowUI = 0;//显示UI扫描 1为显示，0为不显示
            FScanX.ShowThumb = 1;//扫描显示缩略图 1为显示，0为不显示
            FScanX.ScanSourceType = $('#smType').val();//扫描方式 0为平板，1为ADF正面，2为ADF双面
            FScanX.ScanPixelType = $('#smms').val();//扫描模式 0为黑白，1为灰度，2为彩色
            FScanX.ScanResolution = 200;//分辨率
            FScanX.Brightness = 0;//亮度
            FScanX.Contrast = 0;//对比度
            // var FilePath = 'D:\\test';//图像保存路径
            // var FilePrefix = 'img';//图像名称前缀
            // var IndexLength = 5;//图像编号长度
            // FScanX.SetImageName(FilePath, FilePrefix, StartIndex, IndexLength);
            FScanX.ImageFormat = 4;//图像格式  1为jpg 2为单页tif 3为单页pdf 4为多页pdf
            FScanX.CompressionRate = 70;//图像压缩质量
            FScanX.TiffCompressType = 0;//TIFF压缩方式 0为TIFF_JPEG 1为TIFF_G4FAX
            FScanX.PDFCompressType = 0;//PDF压缩方式 0为PDF_JPEG  1为PDF_G4FAX

            FScanX.Scan();

            var ScanImageCount = FScanX.GetScanImageCount();
            StartIndex = parseInt(StartIndex) + ScanImageCount;

            var j;
            for (j = 1 ; j < ScanImageCount+1 ; j++) {
                var path = FScanX.GetScanImagePath(j);

                var base64="data:application/pdf;base64,"+FScanX.GetImageBase64String(path)
                var strrep = FScanX.HttpSendFileEx(path, window.location.protocol+'//'+window.location.host);


                $.ajax({
                    url:'/uploadBase64',
                    dataType:'json',
                    data:{fileStr:base64,module:'file_folder'},
                    type:'post',
                    success:function(res){
                        if(res.flag){
                            var str='';
                            var data = res.obj;
                            str='<div class="dech" deUrl="'+encodeURI(data[0].attUrl)+'"><a href="/download?'+encodeURI(data[0].attUrl)+'" NAME="'+data[0].attachName+'*"fileSize="' + data[0].size + ',"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data[0].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" size="'+ data[i].size +'" value="'+data[0].aid+'@'+data[0].ym+'_'+data[0].attachId+',"></div>';
                            $('#files_txt').append(str)
                        }

                    }
                })
            }
        }else{
            $.layerMsg({content:'<fmt:message code="file.th.theScannerIsNotConnected" />',icon:6});
            return false;
        }
        // }else{
        //     $.layerMsg({content:'扫描文件仅支持IE浏览器以及方正D4280型号扫描仪',icon:6});
        //     return false;
        // }


    }


    var ue = UE.getEditor('container',{elementPathEnabled : false});
    UEimgfuc();
    $(function(){
        // 查询提醒权限
        var type = 20; // 个人文件柜
        var range = $.getQueryString('range') || "";
        if (range === "public") {
            type = 16;// 公共文件柜
        }
        $.ajax({
            type:'get',
            url:'/smsRemind/getRemindFlag',
            dataType:'json',
            data:{
                type: type
            },
            success:function (res) {
                if(res.flag){
                    if(res.obj.length>0){
                        var data = res.obj[0];
                        // 是否默认发送
                        if(data.isRemind=='0'){
                            $('.remindCheck').prop("checked", false);
                        }else if(data.isRemind=='1'){
                            $('.remindCheck').prop("checked", true);
                        }
                        // 是否手机短信默认提醒
                        if(data.isIphone=='0'){
                            $('.smsDefault').prop("checked", false);
                        } else if (data.isIphone=='1'){
                            $('.smsDefault').prop("checked", true);
                        }
                        // 是否允许发送事务提醒
                        if(data.isCan=='0'){
                            $('#reminds').hide();
                            $('.remindCheck').prop("checked", false);
                            $('.smsDefault').prop("checked", false);
                            // $('.remindCheck').parent('tr').hide();
                        }

                    }
                }
            }
        })

        //附件上传方法
        fileuploadFn('#uploadinputimg',$('.Attachment td').eq(1));
        fileuploadFn('#Folder',$('.Attachment td').eq(1));

        //解决拖拽上传执行多次接口，文件夹上传方法如果被点击后执行
        $("#uploadimgform2").click(function (){
            $("#uploadimgform2").attr("action","/upload?module=email")
        })
        function fileBox() {
            file_id='files_txt';
            model = 'email'
            $.popWindow("../common/selectNewFile?1");
        }
        $('.Attachment').on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            deleteChatment(data,dome);
        })
        if ($.getQueryString('contentId')){
            $("title").html("编辑文件");
            var conId=$.getQueryString('contentId');
            var childSortId=$.getQueryString('sortId');
            var conType=$.getQueryString('contype');
            var idea=$.getQueryString('contype');
            if(childSortId == ''){
                childSortId = '0';
            }
            var remindVal=0;
            if($('.remindCheck').is(":checked")){
                remindVal=1;
            }
            var smsDefault =1;
            if($('.smsDefault').is(":checked")){
                smsDefault=0;
            }
            ue.ready(function(){
                $.ajax({
                    type:'get',
                    url:'/newFileContent/getFilePubContent',
                    dataType:'json',
                    data:{'contentId':conId},
                    success:function(rsp){
                        var data1=rsp.data;
                        var str='';
                        var str1='';
                        var arrList=data1.attachmentList
                        $('#txt1').val('');
                        $('#txt2').val('');
                        ue.setContent('');
                        $('#files_txt').text('');
                        $('#txt3').val('');

                        for(var i=0;i<arrList.length;i++){
                            str+='<div class="dech" deUrl="'+encodeURI(arrList[i].attUrl)+'"><a href="/download?'+encodeURI(arrList[i].attUrl)+'" NAME="'+arrList[i].attachName+'*"fileSize="' + arrList[i].size + ',"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+arrList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" size="'+ data[i].size +'" value="'+arrList[i].aid+'@'+arrList[i].ym+'_'+arrList[i].attachId+',"></div>';
                            /*str1+='<input type="hidden" class="inHidden" value="'+data1[i].aid+'@'+data1[i].ym+'_'+data1[i].attachId+',">';*/
                        }
                        $('#txt1').val(data1.subject);
                        $('#txt2').val(data1.contentNo);
                        ue.setContent(data1.content);
                        /*$('#files_txt').text(rsp.attachmentName);*/
                        /*$('#files_txt').append(str+str1);*/
                        $('#files_txt').append(str);
                        $('#txt3').val(data1.attachmentDesc);

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
                var reNum=/^\d*$/;
                if(!reNum.test($('#txt2').val())){
                    $.layerMsg({content:'<fmt:message code="netdisk.th.theSerialNumberMustBeInNumericType" />',icon:2})
                    return false;
                }
                var subject=$('#txt1').val();
                var contentNo=$('#txt2').val();
                var html = ue.getContent();
                var txt = ue.getContentTxt();
                var attach=$('.Attachment td').eq(1).find('a');
                var attachmentDesc=$('#txt3').val();
                var aId='';
                var attachmentName='';
                var fId='';
                for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                    aId += $('.Attachment td .inHidden').eq(i).val();
                }
                for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                    attachmentName += $($('.dech').get(i)).children('[name!=""]').attr('name');
                }
                for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                    fId += $($('.dech').get(i)).children('.inHidden').attr('size') +',';
                }
                var data={
                    'contentId':conId,
                    'sortId':childSortId,
                    'subject':subject,
                    'contentNo':contentNo,
                    'content':html,
                    'attachmentId':aId,
                    'attachmentName':attachmentName,
                    'attachmentDesc':attachmentDesc,
                    'fileSize':fId,
                    // 'remind':remindVal,//事务提醒
                    // 'smsDefault':smsDefault //手机提醒
                    remind:function(){
                        if($('.remindCheck').prop('checked')==false){
                            return '0';
                        }else {
                            return '1';
                        }
                    },
                    smsDefault:function(){
                        if($('.smsDefault').prop('checked')==false){
                            return '0';
                        }else {
                            return '1';
                        }
                    }
                };
                if(idea != undefined){
                    data.sortType='5';
                }
                $.ajax({
                    type:'post',
                    url:'/newFileContent/updFilePubContent',
                    dataType:'json',
                    data:data,
                    success:function(data1){
                        var flag=data1.flag;
                        if (flag==true){
                            $.layerMsg({content:'<fmt:message code="menuSSetting.th.editSuccess" />！',icon:1},function(){
                                if(conType == '1'){
                                    window.opener.init(childSortId);
                                }else if(conType == '2'){
                                    window.opener.queryOneDatasd(childSortId);
                                }else {
                                    try {
                                        window.opener.queryAllDatasd();
                                    }catch (e) {

                                    }finally {
                                        window.close();
                                        // parent.location.reload();
                                        opener.location.reload();
                                    }
                                }
                                $('#txt1').val('');
                                $('#txt2').val('');
                                ue.setContent('');
                                $('#files_txt').val('');
                                $('#txt3').val('');
                                window.close();
//                                        window.opener.location.reload();
                            });
                        }else{
                            if(data1.msg == 'notEnough'){
                                layer.msg('<fmt:message code="workflow.th.InsufficientFolderCapacity" />！', {icon: 2});
                            }else{
                                layer.msg('<fmt:message code="depatement.th.modifyfailed" />！', {icon: 2});
                            }
                        }

                    }
                });
            })

        }else{
            var sortId=$.getQueryString('sortId')
            var idea=$.getQueryString('idea')
            var txt="${text}";
//                    $('#txt2').val('10')
            //点击保存
            $("#btn1").on("click",function(){
                var reNum=/^\d*$/;
                if(!reNum.test($('#txt2').val())){
                    $.layerMsg({content:'<fmt:message code="netdisk.th.theSerialNumberMustBeInNumericType" />',icon:2})
                    return false;
                }
                var subject=$('#txt1').val();
                var contentNo=$('#txt2').val();
                var html = ue.getContent();
                var txt = ue.getContentTxt();
                var attach=$('.Attachment td').eq(1).find('a');
                var attachmentDesc=$('#txt3').val();
                var aId='';
                var attachmentName='';
                var fId='';
                for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                    aId += $('.Attachment td .inHidden').eq(i).val();
                }
                for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                    attachmentName += $($('.dech').get(i)).children('[name!=""]').attr('name');
                }
                for(var i=0;i<$('.Attachment td .inHidden').length;i++){
                    fId += $($('.dech').get(i)).children('.inHidden').attr('size') +',';
                }
                var remindVal=0;
                if($('.remindCheck').is(":checked")){
                    remindVal=1;
                }
                var smsDefault =1;
                if($('.smsDefault').is(":checked")){
                    smsDefault=0;
                }
                var data={
                    'sortId':sortId,
                    'subject':subject,
                    'contentNo':contentNo,
                    'content':html,
                    'attachmentId':aId,
                    'attachmentName':attachmentName,
                    'attachmentDesc':attachmentDesc,
                    'fileSize':fId,
                    // 'remind':remindVal,//事务提醒
                    // 'smsDefault':smsDefault //手机提醒
                    remind:function(){
                        if($('.remindCheck').prop('checked')==false){
                            return '0';
                        }else {
                            return '1';
                        }
                    },
                    smsDefault:function(){
                        if($('.smsDefault').prop('checked')==false){
                            return '0';
                        }else {
                            return '1';
                        }
                    }
                };
                if(idea != undefined){
                    data.sortType='5';
                }
                if($('#txt1').val()==''){
                    layer.msg('<fmt:message code="sup.th.With*" />！', {icon: 6});
                    return false;
                }
                $.ajax({
                    type:'post',
                    url:'/newFileContent/insFilePubContent',
                    dataType:'json',
                    data:data,
                    success:function(data1){
                        var flag=data1.flag;
                        if (flag==true){
                            $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully" />！',icon:1},function(){
                                window.opener.init(sortId,idea);
                                $('#txt1').val('');
                                $('#txt2').val('');
                                ue.setContent('');
                                $('#files_txt').val('');
                                $('#txt3').val('');
                                window.close();
//                                        window.opener.parentajax(sortId,idea);

                            });
                        }else{
                            if(data1.msg == 'notEnough'){
                                layer.msg('<fmt:message code="workflow.th.InsufficientFolderCapacity" />！', {icon: 2});
                            }else{
                                layer.msg('<fmt:message code="depatement.th.modifyfailed" />！', {icon: 2});
                            }
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
                        layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
                            layer.closeAll();
                        });
                    }else{
                        str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                    }
                    <%--if(gs != 'doc' ){--%>
                    <%--str += '';--%>
                    <%--layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){--%>
                    <%--layer.closeAll();--%>
                    <%--});--%>
                    <%--}else{--%>
                    <%--str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';--%>
                    <%--}--%>
                }
                // $('#query_uploadArr').append(str);
                // $('#query_uploadArr').val();
            } else{
                //alert('添加附件大小不能为空!');
                layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                    layer.closeAll();
                });
            }
        }
    });
    function asyncUploadFile() {
        // $("#loadingModal").modal('show');
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


