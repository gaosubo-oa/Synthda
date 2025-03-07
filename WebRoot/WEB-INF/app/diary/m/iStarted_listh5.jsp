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
	<title>我发起的</title>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
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
		/*列表整体左移*/
		/*.mui-ios .mui-table-view-cell{
          margin-left:-10px;
        }*/
	</style>
</head>
<body id="iStarted">
<!--<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
    <h1 class="mui-title">工作日志</h1>
    <a id="info" class="mui-icon mui-icon-more-filled mui-pull-right mui-nav-btn"></a>
</header>-->
<div class="mui-content">
	<div class="stat_sear">
		<!--<div class="started_me">我发起的</div>-->
		<div class="mui-input-row mui-search diarySearch">
			<input type="search" class="mui-input-clear" id="searchLog" placeholder="搜索日志">
		</div>
	</div>
	<ul class="mui-table-view list" id="list" style="padding-bottom:50px;">
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
<nav class="mui-bar mui-bar-tab" id="nav">
	<a class="mui-tab-item" href="javascript:;" id="jump_draft">
		<div class="box_bt">
			草稿箱
		</div>
	</a>
	<a class="mui-tab-item" href="javascript:;" id="jump_create">
		<div class="box_bt  log" >
			发起日志
		</div>
	</a>
</nav>
</body>
<script type="text/javascript">
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
            url: '/diary/getIndex',
            type: 'get',
            data:data,
            dataType:'json',
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
                id:'/diary/diaryConsulth5',
                url:'/diary/diaryConsulth5?id='+did
            });
        });
        mui(".mui-bar-tab").on("tap","#jump_create",function(){
            //发起日志
            mui.openWindow({
                id:'/diary/diaryCreateh5',
                url:'/diary/diaryCreateh5'
            });
        });
        mui(".mui-bar-tab").on("tap","#jump_draft",function(){
            //草稿箱
           alert("正在开发中！")
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
