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
    <title>收件箱</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
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
        .mui-bar{
            box-shadow: 0 0 5px grey;
        }
    </style>
</head>

<body data-role="page">

<nav class="mui-bar mui-bar-tab " data-role="footer">
    <a class="mui-tab-item mui-icon mui-icon-email" href="#Popover_0" style="border-right: 1px solid #e2e2e2;" ><span class="mui-bottom" id="mtitle">邮件箱</span></a>
    <a class="mui-tab-item mui-icon mui-icon-compose" id="Popover_1" ><span class="mui-bottom">写邮件</span></a>
</nav>
<div id="Popover_0" class="mui-popover">
    <div class="mui-popover-arrow"></div>
    <ul class="mui-table-view" id="mailtype">
        <li class="mui-table-view-cell"><a href="#" data-type="inbox">收件箱</a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="outbox">发件箱</a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="noRead">未读</a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="drafts">草稿箱</a>
        </li>
        <li class="mui-table-view-cell"><a href="#" data-type="recycle">废纸篓</a>
        </li>
    </ul>
</div>

<div id="wrappe" class="mui-content" style="overflow: auto;">
    <!--<div class="mui-input-row mui-search" style="width:96%;margin: 10px auto 0;">
    <input type="search" id="search" class="mui-input-clear" placeholder="请输入关键字智能搜索">
</div>-->
    <div id="wrapper" class="mui-content">
        <ul class="mui-table-view mui-table-view-chevron" id="ul_calendar"> </ul>
    </div>

</div>

<script>
    var mtype='inbox';
    var timer = ''
    var type = $.GetRequest().dataType;
    var datas = {}
    var page = 1;

    // window.addEventListener('refresh',function(e){
    //     location.reload();
    // });
    (function($, doc) {
        mui.init({
            pullRefresh : {
                container:'#wrappe',//待刷新区域标识，querySelector能定位的css选择器均可，比如：id、.class等
                up : {
                    height:50,//可选.默认50.触发上拉加载拖动距离
                    auto:true,//可选,默认false.自动上拉加载一次
                    contentrefresh : "正在加载...",//可选，正在加载状态时，上拉加载控件上显示的标题内容
                    contentnomore:'没有更多数据了',//可选，请求完毕若没有更多数据时显示的提醒内容；
                    callback :pullupRefresh //必选，刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；
                }
            }
        });
        function pullupRefresh(){
            droploading(mtype);
        }
        mui('#ul_calendar').on('tap', 'a.mui-navigate-right', function() {
            if( mtype == "inbox"|| mtype =="recycle"){
                var bodyId = this.getAttribute('emailId');
            }else{
                var bodyId = this.getAttribute('bodyId');
            }


            var href = this.href;
            if( mtype == "inbox"|| mtype =="recycle"){
                mui.openWindow({
                    url: '/ewx/emailDetail?flag='+mtype+'&emailID='+bodyId+'&dataType='+type
                });
            }else {
                mui.openWindow({
                    url: '/ewx/emailDetail?flag='+mtype+'&bodyId='+bodyId+'&dataType='+type
                });
            }
        });
        function check(name){
            if(name == undefined){
                return ''
            }else{
                return name;
            }
        }
        //向左侧滑删除本条数据
        mui('#ul_calendar').on('tap', '.mui-btn', function(event) {
            var btnArray = ['确认', '取消'];
            var elem = this;
            var li = elem.parentNode.parentNode;
            var bodyId = elem.getAttribute('bodyId');
            mui.confirm('确认删除该条记录？', ' ', btnArray, function(e) {
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
                                    mui.toast("删除成功！");
                                    li.parentNode.removeChild(li);
                                }else{
                                    mui.toast("删除失败！");
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
                                    mui.toast("删除成功！");
                                    li.parentNode.removeChild(li);
                                }else{
                                    mui.toast("删除失败！");
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
            // timer.clearTimeout()
            document.getElementById('mtitle').innerHTML= title;
            document.title = title
            mui('#Popover_0').popover('hide');
            page = 1;
            $("#ul_calendar")[0].innerHTML = '';
            droploading(mtype)

            // mui.ajax('/email/showEmail?flag='+mtype+'&page=1&pageSize=3&useFlag=true',{
            //     dataType:'json',//服务器返回json格式数据
            //     type:'get',//HTTP请求类型
            //     success:function(data){
            //         var cal='';
            //         $("#ul_calendar")[0].innerHTML='';
            //         if( data.obj.length != 0){
            //             for(var i=0;i<data.obj.length;i++){
            //                 var ics
            //                 if( mtype == "inbox"|| mtype =="recycle"){
            //
            //                     ics=data.obj[i].emailList[0].emailId
            //                 }else {
            //                     ics=data.obj[i].bodyId
            //                 }
            //
            //                 cal+='<li class="mui-table-view-cell mui-transitioning">' +
            //                     '<div class="mui-slider-right mui-disabled">' +
            //                     '<a class="mui-btn mui-btn-red" bodyId="'+ics+'">删除</a>' +
            //                     '</div>' +
            //                     '<div class="mui-slider-handle">' +
            //                     '<a class="mui-navigate-right" href="/detail" bodyId="'+ics+'" >' +
            //                     '<p style="color:#333;font-size:1.1em">'+function(){
            //                         if(data.obj[i].users==undefined){
            //                             return ''
            //                         }else if(data.obj[i].users.userName==undefined){
            //                             return ''
            //                         }else{
            //                             return data.obj[i].users.userName;
            //                         }
            //                     }()+'<span style="font-size: 12px;color:#ccc;width: 65%;display: inline-block;text-align: right;">'+data.obj[i].probablyDate+'</span></p>' +
            //                     '<p class="nav">ReAll:<span >'+data.obj[i].subject+'</span></p>' +
            //                     '<div class="nav">'+data.obj[i].content+'</div>'+
            //                     '</a>' +
            //                     '</div>' +
            //                     '</li>';
            //             }
            //             $("#ul_calendar")[0].innerHTML = cal;
            //         }else{
            //             $("#ul_calendar")[0].innerHTML = '<li class="mui-table-view-cell">暂无内容</li>';
            //         }
            //     }
            // });

        });
        /*点击写邮箱*/
        var btn = document.getElementById("Popover_1");
        btn.addEventListener('tap', function() {
            mui.openWindow({
                url: '/ewx/addEmail',
                id:'add'
            });
        });
    })(mui, document);
        function droploading(datas,flags){
            datas= {
                page:page,
                pageSize:7,
                useFlag:true,
                flag:mtype
            }
            // 拼接HTML
            var app = '';
            $.ajax({
                type: 'GET',
                url: '/email/showEmail',
                data:datas,
                dataType: 'json',
                success: function(res){
                    if( res.flag) {
                        if(res.obj.length > 0){
                            $.each(res.obj, function (index, item) {
                                app += '<li class="mui-table-view-cell mui-transitioning">' +
                                    '<div class="mui-slider-right mui-disabled">' +
                                    '<a class="mui-btn mui-btn-red" emailId="' + item.emailList[0].emailId + '" bodyId="' + item.bodyId + '">删除</a>' +
                                    '</div>' +
                                    '<div class="mui-slider-handle">' +
                                    '<a class="mui-navigate-right" href="javascript:;" emailId="' + item.emailList[0].emailId + '" bodyId="' + item.bodyId + '">' +
                                    '<p style="color:#333;font-size:1.1em;height: 22px;line-height: 22px;"><span style="display: inline-block;float: left">' + function(){
                                        if(item.users&&item.users.userName){
                                            return item.users.userName
                                        }else{
                                            return ''
                                        }
                                    }() + '</span><span style="font-size: 12px;color:#ccc;display: inline-block;float: right;padding-right: 10px;">' + item.probablyDate + '</span></p>' +
                                    '<p class="nav"><span >' + item.subject + '</span></p>' +
                                    '<div class="nav">' + item.content + '</div>' +
                                    '</a>' +
                                    '</div>' +
                                    '</li>';
                            })
                            // 如果没有数据
                            jQuery("#ul_calendar").append(app);
                            mui('#wrappe').pullRefresh().endPullupToRefresh(false);
                            page += 1;
                        }else{
                            app = '<p style="font-size: 18px;text-align: center;margin-top: 50px;height: 50px;line-height: 50px;">暂无数据</p>'
                            jQuery("#ul_calendar").append(app);
                            mui('#wrappe').pullRefresh().endPullupToRefresh(true);
                        }
                    }else{
                        mui('#wrappe').pullRefresh().endPullupToRefresh(true);
                    }
                },
                error: function(xhr, type){
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        }
</script>
</body>
</html>