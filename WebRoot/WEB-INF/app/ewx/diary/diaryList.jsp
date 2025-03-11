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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>草稿</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <link href="../../lib/mui/mui/mui.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/m/iStarted.css">
    <link rel="stylesheet" href="../css/diary/m/diary_base.css" />

    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>
    <style media="screen">
        /*覆盖搜索框的图标颜色*/
        .mui-search .mui-placeholder .mui-icon{
            font-size:20px;
            color:#c1c1c1;
        }
        /*修改底部发起日志按钮的边框颜色*/
        .log{
            border-color:#598fde;
        }
        /*覆盖底部按钮父元素边框颜色*/
        #nav{
            -webkit-box-shadow: 0 0 1px #d6d6d6;
        }
        .mui-table-view {
            background-color: transparent;
        }
        .list .spot {
            position: absolute;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #e36042;
            left: 4px;
            top: 16px;
        }
        .mui-table-view-cell:last-child:before, .mui-table-view-cell:last-child:after{
            height: 1px;
        }
        input[type='search'] {
            text-align: left;
        }
    </style>
</head>
<body id="iStarted">
<div class="mui-content">
    <div class="stat_sear">
        <div class="mui-input-row mui-search diarySearch">
            <input type="search" class="mui-input-clear" id="searchLog" placeholder="搜索日志">
        </div>
    </div>
    <div id="pullrefresh" class="mui-content  mui-scroll-wrapper" style="margin-top: 42px;">
        <div class="mui-scroll">
            <ul class="mui-table-view list" id="list" style="padding-bottom:50px;">
            </ul>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    var wait=null;var closewin=null;
    var type = $.GetRequest().type;
    var dataType = $.GetRequest().dataType;
    var page=1;
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
    function loglist(datas){
        var data = {
            "page":page, //查看路径
            "limit":10,
            "useFlag":true,
            "keyword":$('#searchLog').val()
        };
        // if(datas!=undefined){
        //     data.keyword = datas
        // }
        mui.ajax({
            url: '/diary/mobileTerminalMyDiaryDraft',
            type: 'get',
            data:data,
            dataType:'json',
            success:function(data){
                if(data.flag){
                    var li_inner='';
                    if(data.obj.length>0){
                        for(var i=0;i<data.obj.length;i++){
                            li_inner+='<li class="mui-table-view-cell" isComments="'+data.obj[i].isComments+'" did="'+data.obj[i].diaId+'">' +
                                function(){
                                    if(data.obj[i].readingStatus == '0'){
                                        return '<span class="spot"></span>'
                                    }else{
                                        return ''
                                    }
                                }()+
                                '<span class="tit_nane">'+data.obj[i].subject+'&nbsp;'+data.obj[i].userName+'&nbsp;'+data.obj[i].deptName+'</span>' +
                                '<p>'+data.obj[i].contentStr+'</p>' +
                                '<div class="bt_dir"><span class="time" style="font-size:13px">'+ data.obj[i].diaDate+'</span></div>' +
                                '</li>';
                        }
                        jQuery("#list").append(li_inner);
                        mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
                        page += 1;
                    }else{
                        jQuery("#list").html('<li class="mui-table-view-cell" style="text-align: center">暂无数据</li>');
                        mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
                    }
                }else{
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
                }

            }
        });
    }
    (function($, doc) {
        mui.init({
            pullRefresh : {
                container:'#pullrefresh',//待刷新区域标识，querySelector能定位的css选择器均可，比如：id、.class等
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
            loglist();
        }
        mui("#list").on("tap","li",function(){
            var did = this.getAttribute("did");
            var isComments = this.getAttribute("isComments");
            mui.openWindow({
                id:'/diary/diaryConsulth5',
                url:'/ewx/consult?id='+did+'&type=draft'
            });

        });
    })(mui, document);
    //搜索功能
    var u=navigator.userAgent;
    if(!!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)){
        //获取IOS  eid
        jQuery("#searchLog").blur(function(){
            var datas = $('#searchLog').val()
            page=1;
            jQuery("#list").html('')
            mui('#pullrefresh').pullRefresh().refresh(true);
            loglist();
        })
        jQuery(document).keyup(function(event){
            if(event.keyCode ==13){
                page=1;
                jQuery("#list").html('')
                mui('#pullrefresh').pullRefresh().refresh(true);
                var datas = $('#searchLog').val()
                loglist();
            }
        });
    }else if(u.indexOf("Android")>-1||u.indexOf("Linux")>-1){
        //获取安卓  eid
        document.getElementById("searchLog").addEventListener("keydown",function(e){
            if(13 == e.keyCode){ //点击了“搜索”
                page=1;
                jQuery("#list").html('')
                mui('#pullrefresh').pullRefresh().refresh(true);
                var datas = $('#searchLog').val()
                loglist();
                document.activeElement.blur();//隐藏软键盘
            }
        },false);
    }

</script>
</html>
