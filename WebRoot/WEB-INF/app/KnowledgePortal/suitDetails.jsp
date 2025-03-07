<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/7/3
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>公共文件柜详情</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script> <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>

    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js"></script>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        body{
            height: 100%;
            overflow-y: auto;
        }
        /*.header{*/
        /*    height: 50px;*/
        /*    !*background-color: #6ba1df;*!*/
        /*}*/
        .iconone{
            line-height: 50px;
            margin-left: 20px;
            font-size: 26px;
        }
        .content{
            margin: auto 5px;
        }
        .item{
            text-align: center;
            margin-top: 20px;
            font-size: 20px;
            color: #2a588c;
        }
        .content{
            font-size: 16px;
            /*color: #646464;*/
            /*line-height: 30px;*/
            line-height: 45px;
        }
        .details{
            color: #000;
            line-height: 25px;
            font-size: 15px;
        }
    </style>
</head>
<body>
<div>
    <div class="content">

    </div>
</div>
</body>
</html>
<script>

    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var contentId = getQueryString('contentId')
    $.ajax({
        url:'/newFileContent/getFilePubContent',
        type:'get',
        dataType:'json',
        data:{
            contentId: contentId,
            sortType:5
        },
        success:function(res){
            var data = res.data;
            var  str = '<div class="item">' + empty(data.subject) + '</div>\n' +
                '        <div class="content">\n' +
                '            <span>创建人:</span><span class="number">' + empty(data.createrName) + '</span>\n' +
                '            <span style="margin-left: 50px">' + empty(data.sendTime) + '</span>\n' +
                '        </div>\n' +
                '        <hr>\n' +
                '     <div style=" height: 100px;">\n'+
                function () {

                    if (data.content == ''){
                        return '<p style="color: #5d707c; text-align: center;">暂无内容</p>';
                    }else {
                        return '<p style="margin-left: 5px; font-size: 16px; color: black">文件内容：</p>' + '<p style="margin-left:5px; line-height: 25px;">' + data.content + '</p>';
                    }
                }()+
                '     </div>\n'+
                '        <div class="details" style="margin-left:5px">' +
                '           <ul>' +
                '            <div style="margin-top: 25px; font-size: 16px">附件文档：</div>\n' +
                function () {
                    var str2 = '';

                    var attachmentList = data.attachmentList;
                    if (attachmentList != undefined && attachmentList.length > 0){
                        for (var i = 0; i < attachmentList.length ; i++) {
                            str2 += '<li style="list-style:none; overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width: 350px; margin-top: 10px">' +
                                '            <img src="../img/file/m/ppt.jpg"  style="vertical-align:middle; width: 30px; height: 30px;">\n' +
                                '            <span style="vertical-align:middle; font-size: 15px; margin-top: 5px; margin-left: 5px" onclick="anios($(this))" url="' + location.protocol + '//' + location.host + '/download?' + attachmentList[i].attUrl+'"  name="'+ attachmentList[i].attachName +'">'+ empty(attachmentList[i].attachFile) +'                 ' + empty(attachmentList[i].size) +
                                '</span>\n'
                            '</li>';
                        }
                    }
                    return str2;
                }()+
                '           </ul>' +
                '        </div>\n'
            $('.content').html(str);
        }
    })



    function anios(e){
        var url = e.attr('url');
        var name = e.attr('name');
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            try{
                window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
            }catch(error){
                overLookFile(url,name);
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            Android.overLookFile(url,name);
        }

    }
    //返回功能
    mui('.header').on('tap','.iconone',function(){
        window.history.go(-1)
    })
    //判断返回是否为空
    function empty(esName) {
        if (esName==undefined ||esName==''){
            return ''
        }else{
            return esName
        }
    }
</script>