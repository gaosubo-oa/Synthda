<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<head>
    <title><fmt:message code="file.th.reminder" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>

    <style>
        html,body{
            height:100%;
            margin: 0px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            color: #666;
            background: #fff;
        }
        .head{
            border-bottom: 1px solid #9E9E9E;
            height: 43px;
        }
        .head div{
            float: left;
        }
        .content {
            min-width: 988px;
            height:94%;
        }

        .content .left {
            width: 250px;
            float: left;
            height: 100%;
            overflow-y: auto;
            overflow-x: hidden;
            border-right: #ccc 1px solid;
            margin-left: -135px;
        }

        .content .left .collect {
            width: 100%;
        }

        .content .left .collect div {
            width: 100%;
            overflow: hidden;
        }

        .content .left .collect span {
            display: block;
            width: 90%;
            padding-left: 10%;
            font-size: 11pt;
            height: 40px;
            line-height: 40px;
            border-bottom: #ddd 1px solid;
            cursor: pointer;
        }

        .content .right {
            font-size: 14px;
            overflow-y: auto;
        }

        #smsIframe {
            width: 100%;
        }

        .div_p {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: #494d59;
        }

        .collect div{
            background: url(/img/sys/icon_rightarrow_03.png) no-repeat 95% center;
        }
        .add_back{
            background-color: #2B7FE0;
            color: white;
            border-radius: 15px;
        }


    </style>

</head>
<body>
<div class="head">
    <div class="div_img" style="margin-top: 10px;margin-left: 16px">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_alart_03.png">
    </div>
    <div class="div_p">
        <fmt:message code="file.th.reminder" />
    </div>
</div>
<div class="content"    id="autoHeight">
    <div class="left">
        <div class="collect">
                <span class="unconfirmedSms add_back" style="width: 220px" ><p style="margin-left: 60px;"><fmt:message code="sms.th.UnconfirmedReminders" /></p></span>

                <span class="receivedSms" style="width: 220px"><p style="margin-left: 60px;"><fmt:message code="sms.th.ReceivedReminder" /></p></span>

                <span class="sentSms" style="width: 220px"><p style="margin-left: 60px;"><fmt:message code="sms.th.SendReminders" /></p></span>

                <span class="querySms" style="width: 220px" ><p style="margin-left: 65px;"><fmt:message code="sms.th.ReminderQuery" /></p></span>

        </div>
    </div>
    <div class="right">
        <iframe id="smsIframe" src="/sms/unconfirmedSmsPage" frameborder="0" style="height:520px"></iframe>
    </div>
</div>
<script type="text/javascript">
    $(function () {

        // 跳转到未确认提醒
        $('.unconfirmedSms').on('click',function () {
            $("#smsIframe").attr("src", "/sms/unconfirmedSmsPage");
        });
        // 跳转到已接收提醒
        $('.receivedSms').on('click',function () {
            $("#smsIframe").attr("src", "/sms/receivedSmsPage");
        });
        // 跳转到提醒查询
        $('.sentSms').on('click',function () {
            $("#smsIframe").attr("src", "/sms/sentSmsPage");
        });
        // 跳转到查询提醒
        $('.querySms').on('click',function () {
            $("#smsIframe").attr("src", "/sms/querySmsPage");
        });

//        $("#smsIframe").load(function () {
//            var mainheight = $(this).contents().find("body").height()+100;
//            if(mainheight<350){
//                mainheight = 520;
//            }
//            if(mainheight>=600){
//                mainheight = 520;
//            }
//            $(this).height(mainheight);
//        });
        var height=document.documentElement.clientHeight;
        $('#autoHeight').css('height',height-44+'px');
        $('#smsIframe').css('height',height-50+'px');

    });
    window.onresize=function(){
        var height = $('html').height();
        console.log(height)
        $('#autoHeight').height(height-44)
        $('#smsIframe').height(height-50)
    }
</script>
</body>
</html>
