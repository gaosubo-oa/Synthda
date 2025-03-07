<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="file.th.detail" /></title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.jqprint-0.3.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js?20220822.1"></script>
    <style>
        .head{
            font-size: 22px;
            color: #494d59;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .head span{
            margin-left: 24px;
            margin-top: 10px;
        }
        .content_table {
            margin: 20px auto;
            width: 88%;
        }
        a{
            text-decoration: none;
        }
        .closeWindow{
            width: 50px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            background: #2b7fe0;
            border-radius: 4px;
            cursor: pointer;
            color: #ffffff;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<div class="head">
    <span id="dome"><fmt:message code="doc_th_seeFile" /></span>
</div>

<div class="content">
    <table class="content_table">

    </table>
</div>
<iframe style="display:none" id="printIframe" src=""></iframe>
<script type="text/javascript">
    var runId=0;
    $(function () {
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('#dome').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                    }
                }
            }
        })
        var dataId = $.GetRequest().fileId;
        $.ajax({
            url: "/rmsFile/selectById",
            data: {
                fileId: dataId
            },
            type: "get",
            success: function (res) {
                var str = '';
                if (res.flag) {
                    var object = res.object;

                    // 密级判断
                    if(object.secret==1){
                        object.secret = '<fmt:message code="dem.th.PuDense" />';
                    }else if(object.secret==2){
                        object.secret = '<fmt:message code="doc.th.Top-secret" />';
                    }else if(object.secret==3){
                        object.secret = '<fmt:message code="doc.th.Confidential" />';
                    }else if(object.secret==4){
                        object.secret = '<fmt:message code="doc.th.Secret" />';
                    }else {
                        object.secret = '<fmt:message code="doc.th.Secret" />';
                    }
                    //紧急等级判断
                    if(object.urgency == '1'){
                        object.urgency='<fmt:message code="hr.th.EmployeeType" />';
                    }else{
                        object.urgency='';
                    }
                    //文件分类判断
                    if(object.fileType == '1'){
                        object.fileType='公文';
                    }else if(object.fileType == '2'){
                        object.fileType='资料';
                    }else {
                        object.fileType='';
                    }
                    //公文类别判断
                    if(object.fileKind == '1'){
                        object.fileKind='A';
                    }else if(object.fileKind == '2'){
                        object.fileKind='B';
                    }else if(object.fileKind == '3'){
                        object.fileKind='C';
                    }else if(object.fileKind == '4'){
                        object.fileKind='D';
                    }else {
                        object.fileKind='';
                    }
                    var arrAttach=object.attachmentList
                    var stra='';
                    if(arrAttach.length > 0){
                        for(var i=0;i<arrAttach.length;i++){
                            //href="/download?'+encodeURI(arrAttach[i].attUrl)+'"
                            var fileExtension=arrAttach[i].attachName.substring(arrAttach[i].attachName.lastIndexOf(".")+1,arrAttach[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(arrAttach[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = arrAttach[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+arrAttach[i].size;
                            stra += '<div class="dech" deUrl="' + deUrl+ '">' +
                                '<a NAME="' + arrAttach[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                '<img  src="/img/attachment_icon.png"/>' + arrAttach[i].attachName + '</a>' +
                                '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                '<a class="download" style="padding-left: 5px;display: none" href="/download?'+encodeURI(deUrl)+'" >' +
                                '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                '<a fileExtension="'+fileExtension+'" href="javascript:;"  style="padding-left: 5px" class="printing "  deUrl="' + deUrl+ '"  onclick="daPrinting($(this),0)">' +
                                '<img src="/img/attachmentIcon/icon_down.png" id="print"  style="padding: 0 5px;">打印</a>' +
                                '<input type="hidden" class="inHidden" value="' + arrAttach[i].aid + '@' + arrAttach[i].ym + '_' + arrAttach[i].attachId + ',">' +
                                '</div>'
                            //stra+= '<div class="dech" style="max-width: 550px;" deUrl="' + encodeURI(arrAttach[i].attUrl)+ '"><a title="'+ arrAttach[i].attachName +'" style="display:inline-block;width:100%;overflow: hidden; word-break:break-all;white-space: nowrap;text-overflow: ellipsis;"  NAME="' + arrAttach[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach[i].attachName + '</a></div>';
                        }
                    }else{
                        stra='<fmt:message code="hr.th.NoAttachments" />';
                    }




                    var data=object.attachmentList2;
                    var stra2='';
                    for(var i=0;i<data.length;i++){
                        var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                        var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                        var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
                        stra2 += '<div class="dech" deUrl="' + deUrl+ '">' +
                            '<a NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                            '<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
                            '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                            '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                            '<a class="download" style="padding-left: 5px;display: none" href="/download?'+encodeURI(deUrl)+'" >' +
                            '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                            '<a fileExtension="'+fileExtension+'" href="javascript:;"  style="padding-left: 5px" class="printing "  deUrl="' + deUrl+ '"  onclick="daPrinting($(this),0)">' +
                            '<img src="/img/attachmentIcon/icon_down.png" id="print"  style="padding: 0 5px;">打印</a>' +
                            '<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                            '</div>'
                        <%--str += '<div class="dech" deUrl="' + encodeURI(arrAttach[i].attUrl)+ '"><a href="/download?'+encodeURI(arrAttach[i].attUrl)+'" NAME="' + arrAttach[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + arrAttach[i].aid + '@' + arrAttach[i].ym + '_' + arrAttach[i].attachId + ',"></div>';--%>
                    }



                    // var arrAttach2 = object.attachmentList2;
                    // var stra2 = '';
                    // if (arrAttach2 && arrAttach2.length > 0){
                    //     for(var i=0;i<arrAttach2.length;i++){
                    //         stra2+= '<div class="dech" style="max-width: 550px;" deUrl="' + encodeURI(arrAttach2[i].attUrl)+ '"><a title="'+ arrAttach2[i].attachName +'" style="display:inline-block;width:100%;overflow: hidden; word-break:break-all;white-space: nowrap;text-overflow: ellipsis;" href="/download?'+encodeURI(arrAttach2[i].attUrl)+'" NAME="' + arrAttach2[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach2[i].attachName + '</a></div>';
                    //     }
                    // } else {
                    //     stra2='无公共附件';
                    // }

                    str += '<tr>' +
                        '   <td><fmt:message code="dem.th.FileNum" />：</td><td>'+object.fileCode+'</td>' +
                        '<td><fmt:message code="dem.th.DocumentWords" />：</td><td>'+object.fileSubject+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="dem.th.FileTitle" />：</td><td style="max-width: 300px;" title="'+object.fileTitle+'">'+object.fileTitle+'</td>' +
                        '<td><fmt:message code="dem.th.Supplemented" />：</td><td>'+object.fileTitle0+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="doc.th.DispatchUnit" />：</td><td>'+object.sendUnit+'</td>' +
                        '<td><fmt:message code="dem.th.DateWriting" />：</td><td>'+function () {
                            if(object.sendDate != undefined){
                                return object.sendDate;
                            }else{
                                return '';
                            }
                        }()+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="dem.th.Dense" />：</td><td>'+object.secret+'</td>' +
                        '<td><fmt:message code="dem.th.EmergencyGrade" />：</td><td>'+object.urgency+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="dem.th.FileClassification" />：</td><td>'+object.fileType+'</td>' +
                        '<td><fmt:message code="dem.thDocumentCategory" />：</td><td>'+object.fileKind+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="dem.th.FilePage" />：</td><td>'+object.filePage+'</td>' +
                        ' <td><fmt:message code="dem.th.Print" />：</td><td>'+object.printPage+'</td>' +
                        ' </tr>' +
                        ' <tr>' +
                        ' <td><fmt:message code="journal.th.Remarks" />：</td><td colspan="3">'+object.remark+'</td>' +
                        '</tr>' +
                        ' <tr>' +
                        ' <td style="min-width:80px;">文件正文：</td><td colspan="3">'+stra2+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td style="min-width:80px;">其它附件：</td><td colspan="3">'+stra+function(){
                            //lr添加按钮
                            if(object.runId!=null){
                             runId=object.runId
                            return "";
                                // '<button id="runIdButton" onclick="viewDetails()" style="width: 137px;\n' +
                                // '    height: 30px;\n' +
                                // '    line-height: 30px;\n' +
                                // '    text-align: center;\n' +
                                // '    background: #2b7fe0;\n' +
                                // '    border-radius: 4px;\n' +
                                // '    cursor: pointer;\n' +
                                // '    color: #ffffff;\n' +
                                // '    margin: 0 auto;">查看流程详情</button>'
                             }else{
                                return "";
                             }
                        }()+'</td>' +
                        '</tr>'+
                        '<tr>' +
                        '<td colspan="4"><div class="closeWindow">关闭</div></td>' +
                        '</tr>';
                }
                $('.content_table').html(str);
                if(object.download == 1){
                    $('.download').show()
                }else{
                    $('.download').hide()
                }
                if(object.print == 1){
                    $('.printing').show()
                }else{
                    $('.printing').hide()
                }
            },
            dataType: "json"
        });
        $('.content_table').on('click','.closeWindow',function () {
            window.close();

            var index = parent.layer.getFrameIndex(window.name);
            if (index) {
                parent.layer.close(index);
            }
        })
    })
    //lr添加查看权限
    function viewDetails () {

        $.ajax({
            type : "get",
            url : "/rmsFile/viewDetails",
            data: {
                "runId": runId
            },
            dataType:'json',
            success : function(result) {
                var data = result.object;
                if(result.flag){
                    window.open('/workflow/work/workformPreView?flowId='+data.flowId+'&runId='+data.runId);
                }else{
                    alert("对不起，您没有查看权限！")
                }
            }
        })
    }
</script>
<script>
    function daPrinting(_this,num){ //根据后缀判断选择调取那种打开方式
        console.log(_this)
        var atturl=_this.attr('deUrl')
        // var atturl=_this.parents('.dech').attr('deUrl')
        if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
            var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                atturl = atturl1 + atturl2;
            }else{
                atturl = atturl1;
            }
        }
        var gs=_this.attr('fileExtension')
        if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
            // $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
            var url1 = "/xs?"+atturl
            $('#printIframe').attr('src',url1)
            setTimeout(function(){
                if(num == 0){
                    $("#printIframe")[0].contentWindow.print();
                }else {
                    return url1
                }
            }, 1000)


        }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
            // layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
            var url2 = "/common/video?videoatturlsplit="+atturl
            $('#printIframe').attr('src',url2)
            setTimeout(function(){
                if(num == 0){
                    $("#printIframe")[0].contentWindow.print();
                }else {
                    return url2
                }
            }, 1000)

            layer.msg('点击任意处关闭');
        }else if(gs == 'pdf'||gs == 'PDF'){
            // $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
            var url3 = "/pdfPreview?"+atturl
            $('#printIframe').attr('src',url3)
            setTimeout(function() {
                if (num == 0) {
                    $("#printIframe")[0].contentWindow.print();
                } else {
                    return url3
                }
            },1000)
        }else{
            var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
            $.ajax({
                url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                type:'post',
                datatype:'json',
                async:false,
                success: function (res) {
                    if(res.flag){
                        if(res.object[0].paraValue == 0){
                            //默认加载NTKO插件 进行跳转
                            url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
                        }else if(res.object[0].paraValue == 2){
                            //默认加载NTKO插件 进行跳转
                            url = "/wps/info?"+ atturl +"&permission=read";
                        }else if(res.object[0].paraValue == 3){
                            //默认加载onlyoffice插件 进行跳转
                            url = "/common/onlyoffice?"+ atturl +"&edit=false";
                        }
                    }

                }
            })
            // $.popWindow(url,PreviewPage,'0','0','1200px','600px');
            $('#printIframe').attr('src',url)
            setTimeout(function() {
                if(num == 0){
                    $("#printIframe")[0].contentWindow.print();
                }else {
                    return url
                }
            },1000)




        }
    }
</script>
</body>
</html>
