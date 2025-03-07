<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>分享我的</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <link href="../lib/mui/mui/mui.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/m/iStarted.css">
    <link rel="stylesheet" href="../css/diary/m/diary_base.css" />
    <style>
        body {
            background-color: #fff;
        }
        .mui-segmented-control .mui-control-item {
            line-height: 32px;
        }
        .mui-table-view-cell {
            padding: 7px 15px;
            background: #fff;
        }
        .mui-segmented-control .mui-control-item.mui-active {
            background-color: #598FD6;
        }
        .mui-segmented-control {
            border: 1px solid #598FD6;
        }
        /*覆盖搜索框图标样式*/
        .mui-search .mui-placeholder .mui-icon{
            font-size:20px;
            color:#c1c1c1;
        }
    </style>
    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>
</head>
<body id="share">
<!--<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
    <h1 class="mui-title">工作日志</h1>
    <a id="info" class="mui-icon mui-icon-more-filled mui-pull-right mui-nav-btn"></a>
</header>-->
<div class="mui-content">
    <div class="stat_sear">
        <!--<div class="started_me">分享我的</div>-->
        <div class="mui-input-row mui-search diarySearch">
            <input type="search" class="mui-input-clear" id="searchLog" placeholder="搜索日志">
        </div>
        <!--<div class="mui-table-view-cell">
            <span class="mui-pull-right schedule_item">
                <div id="segmentedControl" class="mui-segmented-control">
                    <a class="mui-control-item mui-active" href="#item1">分享我的</a>
                    <a class="mui-control-item" href="#item2">可查询的</a>
                </div>
            </span>
       </div>-->
    </div>
    <ul class="mui-table-view list" id="list">
        <!--<li class="mui-table-view-cell">
            <h4>工作日报<span class="spot"></span></h4>
            <p>今日工作，市场推广计划实施有以下几个问题,例如</p>
            <div class="bt_dir">
                <span class="time">2017-11-24</span>
                <span class="comment">点评：6</span>
                <span class="consult">查阅：10</span>

            </div>
        </li>
        <li class="mui-table-view-cell">
            <h4>工作日报<span class="spot"></span></h4>
            <p>今日工作，市场推广计划实施有以下几个问题</p>
            <div class="bt_dir">
                <span class="time">2017-11-24</span>
                <span class="comment">点评：6</span>
                <span class="consult">查阅：10</span>

            </div>
        </li>
        <li class="mui-table-view-cell">
            <h4>工作日报<span class="spot"></span></h4>
            <p>今日工作，市场推广计划实施有以下几个问题</p>
            <div class="bt_dir">
                <span class="time">2017-11-24</span>
                <span class="comment">点评：6</span>
                <span class="consult">查阅：10</span>

            </div>
        </li>-->
    </ul>




</div>
</body>
<script type="text/javascript">
    var ispage ='0';
    var wait=null;var closewin=null;
    // H5 plus事件处理
    function plusReady(){
        wait=plus.nativeUI.showWaiting('正在加载');
        closewin= plus.nativeUI.closeWaiting();
    }
    if(window.plus){
        plusReady();
    }else{
        document.addEventListener("plusready",plusReady,false);
    }
    function loglist(){
        var data = {
            "page":1, //查看路径
            "pageSize":10,
            "useFlag":false
        };
        mui.ajax({
            url: '/diary/getOther',
            type: 'POST',
            data:data,
            dataType:'json',
            beforeSend: function() {
                wait;
            },
            complete: function() {
                closewin;
            },
            success:function(data){
                var li_inner='';
                if(data.obj.length>0){
                    for(var i=0;i<data.obj.length;i++){
                        if(data.obj[i].comTotal == 0){
                            li_inner+='<li class="mui-table-view-cell" did="'+data.obj[i].diaId+'"><h4><span class="tit_nane">'+data.obj[i].subject+'&nbsp;'+data.obj[i].userName+'&nbsp;'+data.obj[i].deptName+'</span><span class="spot"></span></h4><p>'+data.obj[i].content+'</p><div class="bt_dir"><span class="time">'+data.obj[i].diaDate+'</span><span class="comment">点评：'+data.obj[i].comTotal+'</span><span class="consult">查阅：'+data.obj[i].readers+'</span></div></li>';
                        }else{
                            li_inner+='<li class="mui-table-view-cell" did="'+data.obj[i].diaId+'"><h4><span class="tit_nane">'+data.obj[i].subject+'&nbsp;'+data.obj[i].userName+'&nbsp;'+data.obj[i].deptName+'</span></h4><p>'+data.obj[i].content+'</p><div class="bt_dir"><span class="time">'+data.obj[i].diaDate+'</span><span class="comment">点评：'+data.obj[i].comTotal+'</span><span class="consult">查阅：'+data.obj[i].readers+'</span></div></li>';
                        }
                    }
                    jQuery("#list").html(li_inner);
                }else{
                    jQuery("#list").html('<li class="mui-table-view-cell">暂无数据</li>');
                }
            }
        });
    }
    (function($, doc) {
        mui.init();
        loglist();
        mui("#list").on("tap","li",function(){
            var did = this.getAttribute("did");
            //打开详情
            mui.openWindow({
                id:'/diary/diaryReceivedDetailsh5',
                url:'/diary/diaryReceivedDetailsh5?id='+did
            });
        });
    })(mui, document);
    //搜索功能
    var u=navigator.userAgent;
    if(!!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)){
        //获取IOS  eid
        jQuery("#searchLog").blur(function(){
            loglist();
        })
    }else if(u.indexOf("Android")>-1||u.indexOf("Linux")>-1){
        //获取安卓  eid
        document.getElementById("searchLog").addEventListener("keydown",function(e){
            if(13 == e.keyCode){ //点击了“搜索”
                loglist();
                document.activeElement.blur();//隐藏软键盘
            }
        },false);
    }

</script>
</html>
