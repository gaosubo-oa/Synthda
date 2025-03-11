<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html><head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.th.FileDetails"/></title>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            width: 100%;
        }
        a{
            text-decoration: none;
            color: #2B7FE0;
        }
        /* .detailsContent{width: 100%;overflow: hidden;background-color: #f6f7f9;} */
        .detailsContent {
            width: 80%;
            overflow: hidden;
            margin: 0 auto;
        }

        .detailsContent .title {
            width: 100%;
            text-align: center;
            line-height: 60px;
            color: #2a588c;
            font-size: 25px;
            font-weight: bold;
        }
        .divContent {
            width: 100%;
        }

        /*.divContent .divTxt {*/
            /*border-bottom: 1px solid #dedede;*/
            /*border-top: 1px solid #dedede;*/
        /*}*/

        .divTxt p {
            font-size: 14px;
            color: #444;
            line-height: 25px;
            margin-left: 20px;
        }

        .divContent .keyWord {
            margin: 0 0 10px 50px;
        }

        .divContent .keyWord span {
            margin-right: 10px;
            color: #2b7fe0;
        }
       .Table{
           width: 100%;
           table-layout: fixed;
       }
        .Table tr td{
            /*padding-left: 20px;*/
            font-size: 14px;
            padding: 20px 10px 10px 20px;
        }
        img{
            width: 20px;
            height: 20px;
            margin-right: 5px;
            vertical-align: middle;
        }
        .button_query {
            color: #FFF;
            font-size: 14px;
            width: 50px;
            height: 28px;
            line-height: 28px;
            background-color: rgb(0, 162, 212);
            display: inline-block;
            text-align: center;
            border-radius: 3px;
            margin-left: 10px;
            float: left;
        }
        #closeBtn{
            background-color: #f8f8f8;
            color:#666;
            border:#ccc 1px solid;
        }
        #deleteBtn {
            background-color: #dd6161;
            color: #fff;
            border: #c73d3d;
        }
        #editBtn{
            border:#0093c1;
        }
        .btn{
            width: 200px;
            position: fixed;
            bottom: 5%;
            right: 5%;
        }
    </style>
    <script type="text/javascript">
        $(function(){
            var conId=$.getQueryString('contentId');
            var childSortId=$.getQueryString('sortId');
            var deleteNum=$.getQueryString('deleteNum');
            var exportNum=$.getQueryString('exportNum');
            var editNum=$.getQueryString('editNum');
            if(deleteNum == '0'){
                $('#deleteBtn').hide();
            }else {
                $('#deleteBtn').show();
            }
            if(editNum == '0'){
                $('#editBtn').hide();
            }else {
                $('#editBtn').show();
            }
            $.ajax({
                type:'get',
                url:'../file/getContentById',
                dataType:'json',
                data:{'contentId':conId},
                success:function(res){
                    var data1=res.attachmentList;
                    var str='';
                    $('.title').text('');
                    $('.spanTxt').empty();
                    $('.attachMent').empty();

                    $('.title').text(res.subject);
                    if(res.content!=''){
                        $('.divTxt').html(res.content);
                    }else{
                        $('.divTxt').html('<p style="text-align: center;color:#999999;margin: 0px;margin-top: 20px;"><fmt:message code="main.th.TextContent"/></p>');
                    }
                    if(res.attachmentName!=''){
                        for(var i=0;i<data1.length;i++) {
                            if(exportNum == '1' || exportNum == undefined){
                                str += '<div>' +
                                    '<a style="color: black;cursor: auto;"  href="/download?' + encodeURI(data1[i].attUrl) + '">' +
                                    '<img src="../img/file/cabinet@.png"/>' + data1[i].attachName + '</a>' +
                                    '<a target="_blank" style="margin: 0 10px 0 30px;" href="'+function () {
                                        var importUrl = encodeURI(data1[i].attUrl);
                                        var d = /\.[^\.]+$/.exec(importUrl);
                                        var ds= d[0].slice(1,d[0].length).toLowerCase()
                                        if(ds=='pdf'){
                                            return '/pdfPreview'
                                        }else {
                                            return '/xs'
                                        }

                                    }()+'?' + encodeURI(data1[i].attUrl) + '">阅读</a>' +
                                    '<a href="/download?' + encodeURI(data1[i].attUrl) + '" style="margin-left:10px;"><fmt:message code="file.th.download" /></a>'+
                                    '</div>';
                            }else{
                                str += '<div>' +
                                    '<a href="javascript:;" style="color:#000;">' +
                                    '<img src="../img/file/cabinet@.png"/>' + data1[i].attachName + '</a>' +
                                    '</div>';
                            }

                        }
                    }
                    $('.attachMent').append(str);
                    $('.attachDesc').text(res.attachmentDesc)
                }
            })
            //<a href="/common/ntkoPreview?'+encodeURI(data1[i].attUrl)+'" target="_Blank" style="margin: 0 20px;"><fmt:message code="global.lang.view" /></a>
            //编辑按钮
            $('#editBtn').click(function(){
                //alert('这是编辑按钮')
                $.popWindow('/file/contentAdd?contentId='+conId+'&sortId='+childSortId,'编辑','100','300','860px','500px');
                //window.close();
                //window.location.href='/file/contentAdd?contentId='+conId+'&sortId='+childSortId;
            })
            //删除按钮
            $('#deleteBtn').click(function(){
                var fileId=[];
                fileId.push(conId);
                layer.confirm('<fmt:message code="workflow.th.suredel"/>', {
                    btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'] //按钮
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        type:'post',
                        url:'../file/batchDeleteConId',
                        dataType:'json',
                        data:{'fileId':fileId},
                        success:function(){
                            window.opener.parentajax(childSortId);
                            layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
                            window.close();
                            window.opener.location.reload();
                        }
                    })
                }, function(){
                    layer.closeAll();
                });
            })
            //关闭按钮
            $('#closeBtn').click(function(){
                window.close();
//                window.opener.queryAllDatasd();
//                window.opener.location.reload();
            })
        })
    </script>
</head>
<body>
<div class="detailsContent">
    <div class="title"></div>
    <div class="divContent">
        <div class="divTxt"></div>
        <div class="divContent1" style="padding-top:10px;margin-top: 65px;margin-bottom: 70px;">
            <table class="Table" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="width: 72px;;vertical-align: top;padding-right: 0px;font-weight: bold;color: #2a588c;"><fmt:message code="main.th.AttachmentFile"/>：</td>
                    <td class="attachMent" style="padding-left: 0px"></td>
                </tr>
                <tr>
                    <td style="width: 90px;padding-right: 0px;font-weight: bold;color: #2a588c;"><fmt:message code="doc.th.AppendixDescription"/>：</td>
                    <td class="attachDesc" style="padding-left: 0px"></td>
                </tr>
            </table>
        </div>
    </div>
    <div class="btn">
        <a href="javascript:;" id="editBtn" class="button_query" style="display: block;"><fmt:message code="global.lang.edit"/></a>
        <a href="javascript:;" id="deleteBtn" class="button_query" style="display: block;"><fmt:message code="global.lang.delete"/></a>
        <a href="javascript:;" id="closeBtn" class="button_query" style="display: block;"><fmt:message code="global.lang.close"/></a>
    </div>

</div>
<script>
    function openerShow(){
        window.opener.queryAllDatasd();
    }
</script>
</body></html>

