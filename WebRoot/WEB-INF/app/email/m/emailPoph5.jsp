<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/mail.css" />
    <link rel="stylesheet" type="text/css" href="../../css/email/m/add_mail.css"/>
    <title><fmt:message code="common.th.selPeople" /></title>
    <style>
        html,body{
            height: 100%;
            width:100%;
            overflow: auto;
        }
        .mui-table-view-cell{
            padding: 6px 15px;
        }
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .mui-input-row label{
            padding-left: 0;font-family:'microsoft yahei';width: 80px;
        }
        .mui-input-row label~input{
            float: left;
            padding: 10px 0;
            width: calc(100% - 120px);
        }
        .mui-input-row span{
            float: right;
            line-height: 40px;
        }
        .mui-input-row span img{
            vertical-align: top;
        }
        .mui-text-justify{
            height: calc(100% - 100px) !important;
        }
        textarea{
            height: calc(100% - 40px) !important;
            border: 0;
            text-indent: 2em;
            padding: 10px;
        }
    </style>
</head>
<body>
<div class="mui-content" style="overflow: auto;">
    <!--<div class="mui-input-row mui-search" style="width:96%;margin: 10px auto 0;">
    <input type="search" id="search" class="mui-input-clear" placeholder="请输入关键字智能搜索">
</div>-->
    <div id="wrapper" class="mui-content">
        <ul class="mui-table-view mui-table-view-chevron" id="ul_calendar"> </ul>
    </div>

</div>
<script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
<script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
<script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
<script type="text/javascript" src="../../js/diary/m/vue.min.js" ></script>
<%--&lt;%&ndash;<script src="/ui/_js/base.js"></script>&ndash;%&gt;--%>
<script type="text/javascript">
        mui.ajax('http://app.oaoa.pro/app/mail/a/add.php',{
            data:{
                sflag:'1',
                tid_str:str1,
                cid_str:str2,
                mtiltle:document.getElementById("mtitle").value,
                message:document.getElementById("msg_str").value,
                remark:document.getElementById("start").innerHTML
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            beforeSend: function() {
                mui('#send').button('loading');
            },
            complete: function() {
                mui('#send').button('reset');
            },
            success:function(data){
                if( data.state=="ok"){
                    mid=data.bid;
                    num=data.count;
                    upload(mid,num);
                    plus.nativeUI.toast('<fmt:message code="user.th.PublishSuccessfully" />！','500') ;
                    mui.back();
                }else{
                    plus.nativeUI.toast('<fmt:message code="event.th.PublishingFailure" />！','500') ;
                }
            },
            error:function(e){
                mui.alert(JSON.stringify(e));
            }
        });
</script>
</body>
</html>