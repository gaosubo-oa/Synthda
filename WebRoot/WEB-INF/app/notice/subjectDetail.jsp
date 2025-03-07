<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!--[if IE 6 ]> <html class="ie6 lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 6 ]> <html class="lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 7 ]> <html class="lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 8 ]> <html class="lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 9 ]> <html class="lte_ie9"> <![endif]-->
<!--[if (gte IE 10)|!(IE)]><!--><html><!--<![endif]-->
<head>
    <title><fmt:message code="notify.th.ViewAnnouncementNotice" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/notice/style.css" />
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
</head>
<!--<script src="/static/js/jquery-1.5.1/jquery.min.js"></script>-->
<script Language=JavaScript>

</script>

<body class="bodycolor">

<table class="TableBlock no-top-border " width="90%" align="center" >
    <tr>
        <td  width="100%" style="padding:0px">
            <table class="TableTop" width="100%" cellpadding="0" >
                <tr>
                    <td class="center" width="100%" ><span class="n_type"></span><span class="subject"></span></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="TableContent" align="right">
            <fmt:message code="notice.th.publishdepartment" />：<u class="dept" title="" style="cursor:hand"></u>&nbsp;&nbsp;
            <fmt:message code="notice.th.publisher" />：<u class="person" title="" style="cursor:hand"></u>&nbsp;&nbsp;
            <fmt:message code="notice.th.postedto" />：<i class="n_time"></i>
        </td>
    </tr>
    <tr>
        <td  colspan="2"  valign="top"  class="rich-content content" style="height:300px;font-size:12pt;">
            <p class="subject"></p> <br><br><fmt:message code="notice.th.keywordsOfThisArticle" />：<a class="keyword"></a></td>
    </tr>
    <tr align="center" class="TableControl">
        <td>
            &nbsp;
            <input type="button" value="<fmt:message code="global.lang.close" />" class="BigButton" onClick="window.close();">
            <input type="hidden" value="79" id="NOTIFYID">

        </td>
    </tr>
</table>
<script src="/module/ueditor/ueditor.parse.js"></script>
<script type="text/javascript">
    $(function(){
        /*查询某条公告数据的接口*/
        var notifyId=$.getQueryString("notifyId");

        $.ajax({
            url: '/notice/getNotifyByNotifyId',
            type: 'get',
            data: {
                notifyId: notifyId
            },
            dataType: 'json',
            success: function (obj) {
                var data=obj.object;
                if(obj.flag==true){
                    $('.n_type').html('['+data.typeId+']');
                    $('.subject').html(data.subject);
                    $('.dept').html(data.fromDeptStr);
                    $('.person').html(data.fromIdStr);
                    $('.n_time').html(data.sendTime);
                    $('.keyword').html(data.keyword);
                }
            }
        })
      /*  $('.SmallButton').on('click',function() {


            layer.confirm('确定清空查阅情况？', {
                btn: ['确定','<fmt:message code="license.cancel" />'], //按钮
                title:"清空查阅情况"
            }, function(){
                //确定删除，调接口
                $.ajax({
                    url: '/notice/updateNotify',
                    type: 'post',
                    data: {
                        notifyId: notifyId,
                        readers:''
                    },
                    dataType: 'json',
                    success: function (obj) {
                        window.location.reload();
                    }
                })

            }, function(){
                layer.closeAll();
            });
        })*/
    })
</script>
</body>
</html>
