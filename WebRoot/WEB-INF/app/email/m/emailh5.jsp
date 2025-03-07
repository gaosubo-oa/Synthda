<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title><fmt:message code="email.title.inbox" /></title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
    <script type="text/javascript" src="../../lib/dropload/dropload.js"></script>
    <link href="../../lib/dropload/dropload.css" rel="stylesheet"/>
    <style>
        #Popover_0{
            background: rgb(255, 255, 255);
            box-shadow: none;
        }
        .nav{
            width: 70%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            height: 22px;
            line-height: 22px;
            margin-top: 15px;
        }
    </style>
</head>

<body data-role="page">
<header data-role="header" class="mui-bar mui-bar-nav" id="header">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title" id="mtitle"><fmt:message code="email.title.inbox" /></h1>
</header>
<nav class="mui-bar mui-bar-tab " data-role="footer">
    <a class="mui-tab-item mui-icon mui-icon-email" href="#Popover_0" style="border-right: 1px solid #e2e2e2;"><span class="mui-bottom"><fmt:message code="email.title.mailbox" /></span></a>
    <a class="mui-tab-item mui-icon mui-icon-compose" id="Popover_1" ><span class="mui-bottom"><fmt:message code="email.title.waitmail" /></span></a>
</nav>
<div id="Popover_0" class="mui-popover">
    <div class="mui-popover-arrow"></div>
    <ul class="mui-table-view" id="mailtype">
        <li class="mui-table-view-cell"><a href="#" data-type="inbox"><fmt:message code="email.title.inbox" /></a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="outbox"><fmt:message code="email.title.outbox" /></a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="noRead"><fmt:message code="email.th.unread" /></a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="drafts"><fmt:message code="email.title.draftbox" /></a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="recycle"><fmt:message code="email.title.wastebasket" /></a>
        </li>
    </ul>
</div>
<div class="mui-content" style="overflow: auto;">
    <!--<div class="mui-input-row mui-search" style="width:96%;margin: 10px auto 0;">
    <input type="search" id="search" class="mui-input-clear" placeholder="请输入关键字智能搜索">
</div>-->
    <div id="wrapper" class="mui-content">
        <ul class="mui-table-view mui-table-view-chevron" id="ul_calendar"> </ul>
    </div>

</div>

<script>
    var mtype='inbox'

    window.addEventListener('refresh',function(e){
        location.reload();
    });
    (function($, doc) {
//        var rmail='rmail';
////        get_data(rmail);
        mui('#ul_calendar').on('tap', 'a.mui-navigate-right', function() {
            var bodyId = this.getAttribute('bodyId');
            var href = this.href;
                if( mtype == "inbox"|| mtype =="recycle"){
                    mui.openWindow({
                        url: 'detailh5?flag='+mtype+'&emailID='+bodyId
                    });
                }else {
                    mui.openWindow({
                        url: 'detailh5?flag='+mtype+'&bodyId='+bodyId
                    });
                }
        });
        //向左侧滑删除本条数据
        mui('#ul_calendar').on('tap', '.mui-btn', function(event) {
            var btnArray = ['<fmt:message code="main.th.confirm" />', '<fmt:message code="depatement.th.quxiao" />'];
            var elem = this;
            var li = elem.parentNode.parentNode;
            var bodyId = elem.getAttribute('bodyId');
            mui.confirm('<fmt:message code="email.th.confirmToDeleteThisRecord" />？', ' ', btnArray, function(e) {
                var mid=elem.parentNode.parentNode.lastChild.firstChild.getAttribute('data-did');
                if (e.index == 0) {
                    if(mtype=="drafts") {
                        mui.ajax('/email/deleteDraftsEmail',{
                            data:{
                                bodyId:bodyId
                            },
                            dataType:'json',//服务器返回json格式数据
                            type:'get',//HTTP请求类型
                            success:function(data){
                                if(data.flag == true){
                                    mui.toast("<fmt:message code="license.delsucess" />！");
                                    li.parentNode.removeChild(li);
                                }else{
                                    mui.toast("<fmt:message code="license.deleSucess" />！");
                                }
                            }
                        });
                    } else {
                        mui.ajax('/email/deleteEmail',{
                            data:{
                                flag:mtype,
                                emailID:bodyId,
                                deleteFlag:0
                            },
                            dataType:'json',//服务器返回json格式数据
                            type:'get',//HTTP请求类型
                            success:function(data){
                                if(data.flag == true){
                                    mui.toast("<fmt:message code="license.delsucess" />！");
                                    li.parentNode.removeChild(li);
                                }else{
                                    mui.toast("<fmt:message code="license.deleSucess" />！");
                                }
                            }
                        });

                    }
                } else {
                    setTimeout(function() {
                        $.swipeoutClose(li);
                    }, 0);
                }
            });
        });
        /*收件箱，发件箱，油标箱，草稿等切换*/
        mui('#mailtype').on('tap', 'a', function() {
            mtype=event.target.getAttribute('data-type');
            var title=event.target.text;
            document.getElementById('mtitle').innerHTML= title;
            mui('#Popover_0').popover('hide');
            mui.ajax('/email/showEmail?flag='+mtype+'&page=1&pageSize=3&useFlag=false',{
                dataType:'json',//服务器返回json格式数据
                type:'get',//HTTP请求类型
                success:function(data){
                    var cal='';
                    $("#ul_calendar")[0].innerHTML='';
                    if( data.obj.length != 0){
                        for(var i=0;i<data.obj.length;i++){
                            var ics
                            if( mtype == "inbox"|| mtype =="recycle"){

                                ics=data.obj[i].emailList[0].emailId
                                console.log(ics)

                            }else {
                                ics=data.obj[i].bodyId
                            }
                            cal+='<li class="mui-table-view-cell mui-transitioning">' +
                                '<div class="mui-slider-right mui-disabled">' +
                                '<a class="mui-btn mui-btn-red" bodyId="'+ics+'"><fmt:message code="global.lang.delete" /></a>' +
                                '</div>' +
                                '<div class="mui-slider-handle">' +
                                '<a class="mui-navigate-right" href="/detail" bodyId="'+ics+'" >' +
                                '<p style="color:#333;font-size:1.1em">'+data.obj[i].users.userName+'<span style="font-size: 12px;color:#ccc;width: 65%;display: inline-block;text-align: right;">'+data.obj[i].probablyDate+'</span></p>' +
                                '<p class="nav">ReAll:<span >'+data.obj[i].subject+'</span></p>' +
                                '<div class="nav">'+data.obj[i].content+'</div>'+
                                '</a>' +
                                '</div>' +
                                '</li>';
                        }
                        $("#ul_calendar")[0].innerHTML = cal;
                    }else{
                        $("#ul_calendar")[0].innerHTML = '<li class="mui-table-view-cell"><fmt:message code="file.th.thereIsNoContentYet" /></li>';
                    }
                }
            });
        });
        /*点击写邮箱*/
        var btn = document.getElementById("Popover_1");
        btn.addEventListener('tap', function() {
            mui.openWindow({
                url: 'addMailh5',
                id:'add'
            });
        });
    })(mui, document);
    $(function(){
            // 页数
            var page = 0;
            // 每页展示5个
            var size = 7;

            // dropload
            $('#ul_calendar').dropload({
                scrollArea : window,
                domDown: {
                    domClass: 'dropload-down',
                    domRefresh: '<div class="dropload-refresh"><fmt:message code="notice.th.pullUpToLoadMore" /></div>',
                    domLoad: '<div class="dropload-load"><span class="loading"></span><fmt:message code="notice.th.loading" />...</div>',
                    domNoData: '<div class="dropload-noData"></div>'
                },
                loadDownFn : function(me){
                    page++;
                    // 拼接HTML
                    var app = '';
                    $.ajax({
                        type: 'GET',
                        url: '/email/showEmail',
                        data:{
                            flag:'inbox',
                            page:page,
                            pageSize:size,
                            useFlag:true
                        },
                        dataType: 'json',
                        success: function(res){
                            if( res.flag) {
                                $.each(res.obj, function (index, item) {
                                    app += '<li class="mui-table-view-cell mui-transitioning">' +
                                        '<div class="mui-slider-right mui-disabled">' +
                                        '<a class="mui-btn mui-btn-red" bodyId="' + item.emailList[0].emailId + '"><fmt:message code="global.lang.delete" /></a>' +
                                        '</div>' +
                                        '<div class="mui-slider-handle">' +
                                        '<a class="mui-navigate-right" href="/detailh5" bodyId="' + item.emailList[0].emailId + '">' +
                                        '<p style="color:#333;font-size:1.1em;height: 22px;line-height: 22px;"><span style="display: inline-block;float: left">' + item.users.userName + '</span><span style="font-size: 12px;color:#ccc;display: inline-block;float: right;padding-right: 10px;">' + item.probablyDate + '</span></p>' +
                                        '<p class="nav">ReAll:<span >' + item.subject + '</span></p>' +
                                        '<div class="nav">' + item.content + '</div>' +
                                        '</a>' +
                                        '</div>' +
                                        '</li>';
                                })
                                // 如果没有数据
                            }else{
                                // 锁定
                                me.lock();
                                // 无数据
                                me.noData();
                            }
                            // 为了测试，延迟1秒加载
                            setTimeout(function(){
                                // 插入数据到页面，放到最后面
                                $('.dropload-down').before(app);
                                // 每次数据插入，必须重置
                                me.resetload();
                            },1000);
                        },
                        error: function(xhr, type){
//                            alert('Ajax error!');
                            // 即使加载出错，也得重置
                            me.resetload();
                        }
                    });
                },
                threshold : 50
            });
    })
</script>
</body>
</html>