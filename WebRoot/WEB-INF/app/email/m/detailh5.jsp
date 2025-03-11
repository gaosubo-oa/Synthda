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
    <title><fmt:message code="email.th.mailDetails" /></title>
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
    </style>
</head>
<body>
<header class="mui-bar mui-bar-nav" id="header">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title" id="mtitle"><fmt:message code="email.th.mailDetails" /></h1>
</header>
<nav class="mui-bar mui-bar-tab " data-role="footer">
    <a class="mui-tab-item mui-icon mui-icon-chat" id="Popover_0" style="border-right: 1px solid #e2e2e2;" href="#modal"><span class="mui-bottom"><fmt:message code="global.lang.reply" /></span></a>
    <a class="mui-tab-item mui-icon mui-icon mui-icon-redo" id="Popover_1" onclick="fn_chooseUsers()"  style="border-right: 1px solid #e2e2e2;"><span class="mui-bottom" ><fmt:message code="email.th.transmit" /></span></a>
    <a class="mui-tab-item mui-icon mui-icon-compose" id="Popover_2"><span class="mui-bottom"><fmt:message code="global.lang.new" /></span></a>
</nav>
<div class="mui-content">
    <div class="mui-table">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell"><fmt:message code="email.th.sender" />：<span id="fname" style=""></span></li>
            <li class="mui-table-view-cell"><fmt:message code="email.th.recipients" />：<span id="tname"></span></li>
            <li class="mui-table-view-cell"><fmt:message code="email.th.carbonCopyRecipients" />：<span id="cname"></span></li>
            <li class="mui-table-view-cell"><fmt:message code="email.th.titleSpace" />：<span id="etitle"></span></li>
            <li class="mui-table-view-cell"><fmt:message code="email.th.timeSpace" />：<span id="sendtime"></span></li>
        </ul>
    </div>

    <div class="count_show" style='padding: 15px 15px;' id="Message">
        <div class="accessory" id="accessory">
            <span><fmt:message code="email.th.attachmentSpace2" />：</span>
            <div id="accessory1"></div>
        </div>
        <div class="mui-inner-wrap" id="mui-inner-wrap" style="min-height: 30px;"></div>

    </div>
</div>

<script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
<script type="text/javascript">

    var bodyId = <%=bodyId%>;
    var bodyId1 = <%=bodyIds%>;
    var flag = '<%=flag%>';
    var mtype,mid,uid;
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
        mui.openWindow({
            url: '/email/replyMailh5',
        });

    });
    /*点击写邮件*/
    var btn2 = document.getElementById("Popover_2");
    btn2.addEventListener('tap', function() {
        mui.openWindow({
            url: '/email/addMailh5',
        });
    });
    /*点击转发*/
    var btn1 = document.getElementById("Popover_1");
    btn1.addEventListener('tap', function() {
        var data={
            mid:mid
        };
        mui.openWindow({
            url:'/email/turnMailh5',
            id:'turn_mail.html',
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
                        plus.nativeUI.toast('<fmt:message code="doc.th.ReplySuccessfully" />！', '500');
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
                                if (data.object.length == 0) {
                                    document.getElementById('accessory').style.display = 'none';
                                } else {
                                    var data_file = data.object.attachment;
                                    var accessory = "";
                                    var str = data.object.attachmentName
                                    var strs = []
                                    strs = str.split("*");
                                    for (var i = 0; i < data_file.length; i++) {
                                        accessory += '<p><span style="width: 75%;display: inline-block;">' + strs[i]+ '</span><a style="display:inline-block;width:20%;color:dodgerblue" href="/download?' + encodeURI(data_file[i].attUrl) + '"><fmt:message code="file.th.download" /></a></p>';
                                    }

                                    var vds1 = JSON.stringify(strs);
                                    localStorage.setItem("strs",vds1);
                                }
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
                                if (data.object.length == 0) {
                                    document.getElementById('accessory').style.display = 'none';
                                } else {
                                    var data_file = data.object;
                                    var accessory = "";
                                    for (var i = 0; i < data_file.length; i++) {
                                        accessory += '<p><span style="width: 75%;display: inline-block;">' + data.object.attachmentName+ '</span><a style="display:inline-block;width:20%;color:dodgerblue" href="/download?' + encodeURI(data_file[i].attUrl) + '"><fmt:message code="file.th.download" /></a></p>';
                                    }
                                }

                                document.getElementById("fname").innerHTML = data.object.users.userName;
                                document.getElementById("tname").innerHTML = data.object.toName;
                                document.getElementById("cname").innerHTML = data.object.copyName;
                                document.getElementById("etitle").innerHTML = data.object.subject;
                                document.getElementById('sendtime').innerHTML = data.object.probablyDate;
                                document.getElementById('mui-inner-wrap').innerHTML = data.object.content;

                                document.getElementById('accessory1').innerHTML =accessory
                            }
                        },
                        error: function (xhr, type, errorThrown) {
                            //异常处理；

                        }
                    });
                }
</script>
</body>
</html>