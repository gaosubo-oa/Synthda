<%--<%@ page language="java" contentType="text/html; charset=UTF-8"--%>
         <%--pageEncoding="UTF-8" %>--%>
<%--<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>--%>
<%--<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>--%>
<%--<%--%>
    <%--String notifyId = request.getParameter("notifyId");--%>
    <%--String path = request.getContextPath();--%>
    <%--String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";--%>
<%--%>--%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>会议详情</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <%--<script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>--%>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>

    <style>
        /*.nav{*/
        /*width: 70%;*/
        /*overflow: hidden;*/
        /*text-overflow: ellipsis;*/
        /*white-space: nowrap;*/
        /*height: 22px;*/
        /*line-height: 22px;*/
        /*margin-top: 15px;*/
        /*}*/
        #header{
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        #header a{
            color: #fff;
        }
        #header h1{
            color: #fff;
        }
        .ulli{
            margin: 0 20px;
            border-bottom: 1px solid #c8c7cc;
            height: 50px;
            line-height: 58px;
        }

        .nav{
            height: 31px;
            line-height: 28px;
            border: 1px solid #e1dddd;
            border-radius: 10px;
            width: 66%;
            margin-top: 13px;
            margin-right: 27px;
        }
        .nav span{
            width: 48%;
            display: inline-block;
            text-align: center;
        }
        #yspan ,#managerId{
            padding: 4px 10px;
            border-radius: 5px;
        }
        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }
        .mui-input-row label{
            padding-left: 0;
            font-family:'microsoft yahei';
            width: 96px;
        }
        .mui-input-row label~input{
            float: left;
            padding: 10px 0;
            width: calc(100% - 120px);
        }
        .mui-content {
            height: calc(100% - 45px);
            background: #fff;
        }
        #forms label,#forms1 label,#forms3 label,#forms4 label{
            width: 400px;
        }
        .mui-input-row span{
            /*float: right;*/
            line-height: 40px;
        }
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .radio_inline{
            display: inline-block;
            width: 65%;
        }
        .radio_inline label{
            width: 20%;
            padding-left: 40px;
            padding-right: 40px;
        }
        .radio_inline input[type=radio]{
            width: 15%;
            right:auto;
        }
        .must{
            color: red;
        }
    </style>
</head>
<body>

<%--<div class="content">

</div>--%>
<div class="mui-content" id="aaa" style="overflow: auto;">
    <ul>
        <%--<li class="ulli">
            <div class="fl" style="height: 50px">日程安排：</div>
            <div class="nav fr">
                <span class="navc fl">工作事务</span>
                <span  class="fr">个人事务</span>
            </div>
        </li>--%>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>名称：</label><input  readonly="readonly"  type="text" class="meetName  test_null" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>主题：</label><input  readonly="readonly"  type="text"  class=" subject test_null" style="margin-top: 10px;"  value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>申请人：</label><input  readonly="readonly"  type="text" style="margin-top: 10px;"  value="" class="test_null" id="tname"/></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="width: 100px;"><span class="must">*</span>联系电话：</label><input  readonly="readonly"  type="text" style="margin-top: 10px;"  class=" mobileNo test_null" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="padding:11px 0px">会议纪要员：</label><input  readonly="readonly"  type="text"  value="" class="" id="cname"/></li>
        <li class="mui-table-view-cell mui-input-row" id="demo"><span class="must">*</span>开始时间：<span class="result test_nullSpan" id="beginTime"></span></li>
        <li class="mui-table-view-cell mui-input-row"id="demo1"><span class="must">*</span>结束时间：<span class="result1 test_nullSpan " id="endTime"></span></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>会议室：</label><input  readonly="readonly"  type="text" id="yspan"  style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">审批管理员：</label><input  readonly="readonly"  type="text" id="managerId"  style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">出席人员（外部）：</label><input  readonly="readonly"  type="text"  style="margin-top: 5px;" class=" attendeeOut" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" ><span class="must">*</span>出席人员（内部）：</label><input  readonly="readonly"  type="text"  style="margin-top: 17px;" value="" class=" attendee test_null" id="inName" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" >会议室设备：</label><input  readonly="readonly"  type="text" value="" class="equipmentId"   id="equipmentName" /></li>
        <li class="mui-table-view-cell mui-input-row "><label class="mui-left" style="padding:11px 4px">写入日程安排：</label>
            <span id="isWriteCalendar"></span>  
        </li>
        <li class="mui-table-view-cell">
            <div class="new_type">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：
                <div class="fujian" style="display: inline-block"></div>
               <%-- <span class='mui-icon mui-icon-plus mui-pull-right' onclick="" id="uploadimg">
                        <form id="uploadimgform" target="uploadiframe" action="../upload?module=email" enctype="multipart/form-data" method="post">
                            <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="position: absolute;top:6px;opacity: 0;width: 70px;
                            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <a id="" style="cursor: pointer;"></a>
                        </form>
                    </span>--%>
            </div>
           <%-- <div class="log_share">
                <ul id="files" style="text-align:left;width: 85%;display: inline-block;">
                    &lt;%&ndash;<p id="empty" style="font-size:12px;color:#C6C6C6;">无上传文件</p>&ndash;%&gt;
                    <div style="font-size:12px;color:#C6C6C6;" id="query_uploadArr" style="display:block;">
                    </div>
                </ul>
            </div>--%>
        </li>
    </ul>
    <textarea name=""  readonly="readonly"  class="meetDesc"  style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
</div>
</body>
<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    <%--var sid = <%=meetRoomId%>;--%>
    var sid=$.GetRequest().sid
    $(function(){
        $.ajax({
            url:'/meeting/queryMeetingById',
            type:'get',
            data:{
                sid:sid
            },
            dataType:'json',
            success:function(res){
                var data=res.object
                $(".meetName").val(data.meetName)
                $(".subject").val(data.subject)
                $('#tname').val(data.userName)
                $('.mobileNo').val(data.mobileNo)
                $('#cname').val(data.recorderName)
                $("#beginTime").html(data.startTime)
                $("#endTime").html(data.endTime)
                $("#yspan").val(data.meetRoomName)
                $('#managerId').val(data.managerName)
                $(".attendeeOut").val(data.attendeeOut)
                $(".attendee").val(data.attendeeName)
                $(".equipmentId").val(data.equipmentNames)
                if(data.isWriteCalednar=='0'){
                    $('#isWriteCalendar').html('否')
                }else{
                    $('#isWriteCalendar').html('是')
                }
                var arrAttach2 = data.attachmentList;
                var stra2 = '';
                if (arrAttach2 && arrAttach2.length > 0){
                    for(var i=0;i<arrAttach2.length;i++){
                        stra2+= '<div class="dech" style="max-width: 550px;" deUrl="' + encodeURI(arrAttach2[i].attUrl)+ '"><a title="'+ arrAttach2[i].attachName +'" style="display:inline-block;width:100%;overflow: hidden; word-break:break-all;white-space: nowrap;text-overflow: ellipsis;" onclick="lookFujian($(this))" atturl="'+encodeURI(arrAttach2[i].attUrl)+'" NAME="' + arrAttach2[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach2[i].attachName + '</a></div>';
                    }
                } else {
                    stra2='无附件';
                }
                $('.fujian').html(stra2)
                $(".meetDesc").val(data.meetDesc)

            }
        })
    })
    function lookFujian(e) {
        var atturl = e.attr('atturl');
        var name = e.attr('name');
        var gs = name.substring(name.lastIndexOf(".")+1,name.length);
        if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
            // $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
            var domainS = document.location.origin;
            var imgUrl = domainS + '/xs?'+atturl
            layer.open({
                type: 1,
                title: false,
                area: ['90%', '50%'],
                offset: ['20%', '5%'],
                shade: 0.5,
                closeBtn: 0,
                shadeClose: true,
                content:'<img src="'+imgUrl+'" style="width:100%"/>'
            });
            // window.open("/xs?"+atturl)
        }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
            layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
            layer.msg('点击任意处关闭');
        }else if(gs == 'pdf'||gs == 'PDF'){
            $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
        }else {
            preview($(e))
            // var url = "/wps/info?"+ atturl +"&permission=read";
            // window.open(url)
        }
    }
    function preview(that,workNum) { //附件预览点击调取
        if(workNum == 1){
            var attrUrl = that.attr('atturl').split('&FILESIZE')[0];
        }else {
            var attrUrl = that.attr('atturl');
        }

        var url = attrUrl;
        if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1&&attrUrl.indexOf('isOld=1') == -1){
            var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                url = atturl1 + atturl2;
            }else{
                url = atturl1;
            }
        }
        var type = UrlGetRequest('?'+attrUrl)||'docx';
        if(type.indexOf('&') > -1){
            type = type.split('&')[0];
        }
        type = type.toLowerCase();
        if(type == 'pdf'){
            //$.popWindow('/common/pdfPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
            $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
        }else if(type == 'png' || type == 'jpg' ||  type == 'txt'){
            $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
        }else if(type == 'ofd'|| type=='OFD'){
            $.popWindow("../../lib/ofdViewer/viewer.html?file="+'/download?'+url , PreviewPage, '0', '0', '1200px', '600px')
        }else if(type == 'doc'||type == 'docx'||type == 'xls'||type == 'xlsx'||type == 'ppt'||type == 'pptx'){
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        documentPreviewOpen = res.object[0].paraValue;
                        if(documentPreviewOpen == 1){
                            $.ajax({
                                type:'get',
                                url:'/sysTasks/getOfficePreviewSetting',
                                dataType:'json',
                                success:function (res) {
                                    if(res.flag){
                                        var strOfficeApps = res.object.previewUrl;//在线预览服务地址

                                        $.ajax({
                                            url:'/onlyOfficeCode',
                                            dataType: 'json',
                                            type: 'post',
                                            success:function(res){
                                                if(res.flag){
                                                    var code = res.obj;
                                                    $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
                                                }
                                            }
                                        })
                                    }
                                }
                            })
                        }else if(documentPreviewOpen == 2){
                            if(type == 'xls'||type == 'xlsx'){
                                $.popWindow('/common/excelPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                            }else if(type == 'ppt'||type == 'pptx'){
                                $.popWindow('/common/pptPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                            }else{
                                location.href = '/common/officereader?'+url.split('&COMPANY=')[0];
                                // $.popWindow('','0','0','1200px','600px');
                            }
                        }else if(documentPreviewOpen == 3){
                            $.popWindow("/wps/info?"+ url +"&permission=read",'','0','0','1200px','600px');
                        }else if(documentPreviewOpen == 4){
                            $.popWindow("/common/onlyoffice?"+ url +"&edit=false",'','0','0','1200px','600px');
                        }
                    }
                }
            })
        } else{
            $.ajax({
                type:'get',
                url:'/sysTasks/getOfficePreviewSetting',
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        var strOfficeApps = res.object.previewUrl;//在线预览服务地址
                        if(strOfficeApps == ''){
                            strOfficeApps = 'https://owa-box.vips100.com';
                        }

                        $.ajax({
                            url:'/onlyOfficeCode',
                            dataType: 'json',
                            type: 'post',
                            success:function(res){
                                if(res.flag){
                                    var code = res.obj;
                                    $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
                                }
                            }
                        })


                    }
                }
            })
        }
    }
</script>
</html>