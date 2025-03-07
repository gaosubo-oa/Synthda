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
    <title>领导活动安排详细信息</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../css/style.css" />
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../../css/news/new_news.css"/>

    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <style>

        #rs {
            display: inline-block;
            float: left;
            width: 78px;
            height: 38px;
            line-height: 35px;
            /*  margin-right: 30px;*/
            margin-top: 20px;
            margin-bottom: 20px;
            cursor: pointer;
            border-radius: 3px;
            background: url(../../img/newReturn.png) no-repeat;
            padding-left: 19px;
            font-size: 14px;
            margin-left: 50%;

        }


    </style>


</head>


<%--<script type="text/javascript" src="/inc/js_lang.php"></script>--%>
<%--<script type="text/javascript" src="/static/js/attach.js"></script>--%>

<body class="bodycolor">
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
    <tr>
        <td class="Big"><img src="../../img/contractinfo.png" width="17" height="17"><span class="big3">领导活动安排详细信息</span><br>
        </td>
    </tr>
</table>
<br>
<table class="TableBlock" width="90%" align="center">
    <tr>
        <td nowrap align="left" width="120" class="TableContent">活动名称：</td>
        <td nowrap align="left" class="TableData subject" width="180"></td>
        <td nowrap align="left" width="120" class="TableContent">项目：</td>
        <td nowrap align="left" class="TableData scheduleType" width="180"></td>
    </tr>
    <tr>
        <td nowrap align="left" width="120" class="TableContent">会议室：</td>
        <td nowrap align="left" class="TableData roomName" width="180"></td>
        <td nowrap align="left" width="120" class="TableContent">出席领导：</td>
        <td nowrap align="left" class="TableData leader" width="180"></td>
    </tr>

    <tr>
        <td nowrap align="left" width="120" class="TableContent">申请人：</td>
        <td nowrap align="left" class="TableData appUser" width="180"></td>
        <td nowrap align="left" width="120" class="TableContent">地点：</td>
        <td align="left" class="TableData location" width="180"></td>
    </tr>
    <tr>
        <td nowrap align="left" width="120" class="TableContent">开始日期：</td>
        <td nowrap align="left" class="TableData beginTimeStr" width="180"></td>
        <td nowrap align="left" width="120" class="TableContent">结束日期：</td>
        <td nowrap align="left" class="TableData endTimeStr" width="180"></td>
    </tr>

    <tr>
        <td nowrap align="left" width="120" class="TableContent">出席人员（内部)：</td>
        <td align="left" colspan="3" class="TableData attentee" width="180"></td>
    </tr>
    <tr>
        <td nowrap align="left" width="120" class="TableContent">承办单位：</td>
        <td align="left" colspan="3" class="TableData undertake" width="180"></td>
    </tr>
    <tr>
        <td nowrap align="left" width="120" class="TableContent">备注：</td>
        <td align="left" colspan="3" class="TableData remark" width="180"></td>
    </tr>





    <tr align="center" class="TableControl">
        <td colspan="4">
            <%--   <input type="button" value="关闭" class="BigButton" onClick="window.close();" title="关闭窗口">--%>
            <div id="rs" type="save" class="btn_return"><fmt:message code="notice.th.return" /></div>
        </td>
    </tr>
</table>
</body>
<script>
    $(function(){
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.small').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </p>')
                    }
                }
            }
        })
//        获取详情id
        var id=$.getQueryString('id');

        $('#rs').click(function(){
            window.close();
        })

        $.ajax({
            url: "/leaderschedule/selectScheduleById",
            type: "get",
            data: {
                'id': id
            },
            dataType: 'json',
            success: function (obj) {//回显数据
                var data=obj.object;


//                if(data.userName){
//                    $('.userName').html(data.userName);/*姓名*/
//                }else {
//                    var ll = '(<span style="color: red;">用户已删除</span>)'
//                    $('.userName').html(ll);/*姓名*/
//
//                }
                $('.subject').html(data.subject);
                $('.scheduleType').html(data.scheduleType);
                $('.location').html(data.location);

                $('.beginTimeStr').html(data.beginTimeStr);
                $('.endTimeStr').html(data.endTimeStr);
                $('.roomName').html(data.roomName);

                $('.universityLocation').html(data.universityLocation);
                $('.leader').html(data.leader);
                $('.attentee').html(data.attentee);

                $('.remark').html(data.remark);
                $('.appUser').html(data.appUser);
                $('.undertake').html(data.undertake);

            }
        })
    })
</script>
</html>


