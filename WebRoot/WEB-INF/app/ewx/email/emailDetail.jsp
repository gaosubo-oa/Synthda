<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String bodyId = request.getParameter("emailID");
    String bodyIds = request.getParameter("bodyId");
    String flag = request.getParameter("flag");

    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="format-detection"content="telephone=no">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>邮件详情</title>


    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/vue.min.js" ></script>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/mail.css" />
    <%--<script  src="js/iscroll.js"></script>--%>
    <style>
        .mui-bar-tab .mui-tab-item{
            width: 33%;
        }
        .mui-bar-tab~.mui-content{
            overflow-x: hidden;
            overflow-y: auto;
        }
        #fname{
            color: dodgerblue;
        }
        .count_show{
            padding: 15px 15px;
        }
        .accessory{
            margin-bottom: 30px;
        }
        .mui-bar{
            box-shadow: 0 0 5px grey;
        }
    </style>
</head>
<body>

<nav class="mui-bar mui-bar-tab " data-role="footer">
    <a class="mui-tab-item mui-icon mui-icon-chat" id="Popover_0" style="border-right: 1px solid #e2e2e2;" href="#modal"><span class="mui-bottom">回复</span></a>
    <a class="mui-tab-item mui-icon mui-icon mui-icon-redo" id="Popover_1" onclick="fn_chooseUsers()"  style="border-right: 1px solid #e2e2e2;"><span class="mui-bottom" >转发</span></a>
    <a class="mui-tab-item mui-icon mui-icon-compose" id="Popover_2"><span class="mui-bottom">新建</span></a>
</nav>
<div class="mui-content">
    <div class="mui-table">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell">发件人：<span id="fname" style=""></span></li>
            <li class="mui-table-view-cell">收件人：<span id="tname"></span></li>
            <li class="mui-table-view-cell">抄送人：<span id="cname"></span></li>
            <li class="mui-table-view-cell">标&nbsp;&nbsp;&nbsp;&nbsp;题：<span id="etitle"></span></li>
            <li class="mui-table-view-cell">时&nbsp;&nbsp;&nbsp;&nbsp;间：<span id="sendtime"></span></li>
        </ul>
    </div>

    <div class="count_show" style='padding: 15px 15px;' id="Message">
        <div class="accessory" id="accessory">
            <span>附&nbsp;&nbsp;&nbsp;&nbsp;件：</span>
            <div id="accessory1"></div>
        </div>
        <div class="mui-inner-wrap" id="mui-inner-wrap" style="min-height: 30px;"></div>

    </div>
</div>

<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
<script type="text/javascript" src="../../js/base/base.js"></script>
<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
<script type="text/javascript">

    var bodyId = <%=bodyId%>;
    var bodyId1 = <%=bodyIds%>;
    var flag = '<%=flag%>';
    var mtype,mid,uid;
    var type = $.GetRequest().dataType
    function plusReady(){
        // 在这里调用plus api
    }
    if(window.plus){
        plusReady();
    }else{
        document.addEventListener( 'plusready',plusReady,false);
    }
    window.addEventListener('newsId',function(event){
        mtype=event.detail.mtype;
        mid=event.detail.mid;
        uid=event.detail.uid;
        get_mail(bodyId,mid,uid);
    });
    /*点击回复邮件*/
    var btn3 = document.getElementById("Popover_0");
    btn3.addEventListener('tap', function() {
        bodyId = $(this).attr('emailId')
        mui.openWindow({
            url: '/ewx/replyEmail?emailId='+bodyId+'&dataType='+type,
        });

    });
    /*点击写邮件*/
    var btn2 = document.getElementById("Popover_2");
    btn2.addEventListener('tap', function() {
        mui.openWindow({
            url: '/ewx/addEmail?dataType='+type,
        });
    });
    /*点击转发*/
    var btn1 = document.getElementById("Popover_1");
    btn1.addEventListener('tap', function() {
        bodyId = $(this).attr('emailId')
        var data={
            mid:mid
        };
        mui.openWindow({
            url:'/ewx/turnEmail?emailId='+bodyId+'&dataType='+type,
            extras:data
        });
    });

    /*点击回复邮件*/
    var btn0 = document.getElementById("Popover_0");
    btn0.addEventListener('tap', function() {
        mui("#header2").on('tap', '#re_mail', function () {
            mui.ajax('http://app.oaoa.pro/app/mail/a/add.php', {
                data: {
                    sflag: 1,
                    mid: mid,
                    //dtype:'re',
                    message: document.getElementById("Messagetext").value
                    //uid:uid
                },
                dataType: 'json',//服务器返回json格式数据
                type: 'post',//HTTP请求类型
                success: function (data) {
                    //服务器返回响应，根据响应结果，分析是否登录成功；
                    if (data.state == 'ok') {
                        plus.nativeUI.toast('回复成功！', '500');
                        var parent1 = document.getElementById("Message");
                        //								parent1.removeChild(document.getElementById("Messagetext"));
                        //								var parent2=document.getElementById("header");
                        //								parent2.removeChild(document.getElementById("re_mail"));
                        mui.back();
                    }
                },
                error: function (xhr, type, errorThrown) {
                    //异常处理；
                    //console.log(type);
                }
            });

        });
    });

    if (flag == "inbox" || flag == "recycle") {
        mui.ajax('/email/queryByID', {
            data: {
                emailId: bodyId,
                flag: ""
            },
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                //console.log(JSON.stringify(data));
                if (data != null) {
                    if (data.object.attachment.length == 0) {
                        document.getElementById('accessory').style.display = 'none';
                    } else {
                        var data_file = data.object.attachment;
                        var accessory = "";
                        var str = data.object.attachmentName;
                        var strs = [];
                        strs = str.split("*");
                        for (var i = 0; i < data_file.length; i++) {
                            accessory += '<p style="position: relative"><span style="width: 73%;display: inline-block;">' + strs[i]+ '</span>' +
                                '<a style="display:inline-block;width:10%;color:dodgerblue;position: absolute;right: 11%" href="/download?' + encodeURI(data_file[i].attUrl) + '">下载</a>' +
                                '<a style="display:inline-block;width:10%;color:dodgerblue;position: absolute;right:0%" href="javascript:;" atturl="'+ encodeURI(data_file[i].attUrl) +'" name="'+data_file[i].attachName +'" onclick="lookDetail($(this))">预览</a>' +
                                '</p>';
                        }


                        var vds1 = JSON.stringify(strs);
                        localStorage.setItem("strs",vds1);
                    }
                    $('#Popover_0').attr('emailId',data.object.emailList[0].emailId)
                    $('#Popover_1').attr('emailId',data.object.emailList[0].emailId)
                    document.getElementById("fname").innerHTML = data.object.users.userName;
                    document.getElementById("tname").innerHTML = data.object.toName;
                    document.getElementById("cname").innerHTML = data.object.copyName;
                    document.getElementById("etitle").innerHTML = data.object.subject;
                    document.getElementById('sendtime').innerHTML = data.object.probablyDate;
                    document.getElementById('mui-inner-wrap').innerHTML = data.object.content;
                    document.getElementById('accessory1').innerHTML = accessory
                    localStorage.setItem("userName",data.object.users.userName);
                    localStorage.setItem("toName",data.object.toName);
                    localStorage.setItem("copyName",data.object.copyName);
                    localStorage.setItem("sendtime",data.object.probablyDate);
                    localStorage.setItem("subject",data.object.subject);
                    localStorage.setItem("bodyId",data.object.bodyId);
                    localStorage.setItem("emailId",data.object.emailList[0].emailId);
                    localStorage.setItem("content",data.object.content);


                }
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
    } else {
        mui.ajax('/email/queryByID', {
            data: {
                bodyId: bodyId1,
                flag: ""
//
            },
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                //console.log(JSON.stringify(data));
                if (data != null) {
                    if (data.object.attachment.length == 0) {
                        document.getElementById('accessory').style.display = 'none';
                    } else {
                        var data_file = data.object.attachment;
                        var accessory = "";
                        for (var i = 0; i < data_file.length; i++) {
                            accessory += '<p style="position:relative"><span style="width: 73%;display: inline-block;">' + data.object.attachmentName+ '</span>' +
                                '<a style="display:inline-block;width:12%;color:dodgerblue;position:absolute;right:12%" href="/download?' + encodeURI(data_file[i].attUrl) + '">下载</a>' +
                                '<a style="display:inline-block;width:12%;color:dodgerblue;position:absolute;right:0%" href="javascript:;" url="'+ encodeURI(data_file[i].attUrl) +'" onclick="lookDetail($(this))">查阅</a>' +
                                '</p>';
                        }
                    }

                    document.getElementById("fname").innerHTML = data.object.users.userName;
                    document.getElementById("tname").innerHTML = data.object.toName;
                    document.getElementById("cname").innerHTML = data.object.copyName;
                    document.getElementById("etitle").innerHTML = data.object.subject;
                    document.getElementById('sendtime').innerHTML = data.object.probablyDate;
                    document.getElementById('mui-inner-wrap').innerHTML = data.object.content;
                    $('#Popover_0').attr('emailId',data.object.bodyId)
                    $('#Popover_1').attr('emailId',data.object.bodyId)

                    document.getElementById('accessory1').innerHTML =accessory
                }
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；

            }
        });
    }
    function lookDetail(e){
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
</body>
</html>