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
	<title>工作日志</title>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
	<script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
	<script src="../js/diary/m/starScore.js"></script>
	<link href="../lib/mui/mui/mui.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/diary/m/consult.css">
	<link rel="stylesheet" href="../css/diary/m/diary_base.css" />
	<style>
		/*星星样式*/
		.content{
			padding: 10px 20px;
			border-bottom: 1px solid #f5f5f5;
		}
		.title{
			font-size:14px;
			background:#dfdfdf;
			padding:10px;
			margin-bottom:10px;
		}
		.com_sum {
			display: inline-block;
			float:left;
			color: #333;
			font-size: 17px;
		}
		.block{
			display: inline-block;
			padding-left: 50px;
			line-height: 21px;
			float: left;
		}
		.block .star_score{
			float:left;
		}
		.star_list{
			height:21px;
			margin:50px;
			line-height:21px;
		}
		.block p,.block .attitude{
			padding-left:20px;
			line-height:21px;
			display:inline-block;
		}
		.block p{
			color:#ffa96f;
			font-size:16px;
			font-family:"微软雅黑";
		}

		.star_score {
			background:url("../../img/diary/m/stark2.png");
			width:160px;
			height:21px;
			position:relative;
		}

		.star_score a{
			height:21px;
			display:block;
			text-indent:-999em;
			position:absolute;
			left:0;
		}

		.star_score a:hover{
			background:url("../../img/diary/m/stars2.png");
			left:0;
		}

		.star_score a.clibg{
			background:url("../../img/diary/m/stars2.png");
			left:0;
		}

		#starttwo .star_score {
			background:url("../../img/diary/m/starky.png");
		}

		#starttwo .star_score a:hover{
			background:url("../../img/diary/m/starsy.png");
			left:0;
		}

		#starttwo .star_score a.clibg{
			background:url("../../img/diary/m/starsy.png");
			left:0;
		}

		/*星星样式*/

		.show_number{
			padding-left:50px;
			padding-top:20px;
		}

		.show_number li{
			width:240px;
			border:1px solid #ccc;
			padding:10px;
			margin-right:5px;
			margin-bottom:20px;
		}

		.atar_Show{
			background:url("../../img/diary/m/stark2.png");
			width:160px; height:21px;
			position:relative;
			float:left;
		}

		.atar_Show p{
			background:url("../../img/diary/m/stars2.png");
			width:160px; height:21px;
			left:0;
			height:21px;
			width:134px;
		}

		.show_number li span{
			display:inline-block;
			line-height:21px;
		}
		#com_submit {
			margin:0;
		}
	</style>
	<script type="text/javascript" charset="utf-8">
        mui.init();
	</script>
</head>
<body id="iStarted">
<!--<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
    <h1 class="mui-title">工作日志</h1>
    <a id="info" class="mui-icon mui-icon-more-filled mui-pull-right mui-nav-btn"></a>
</header>-->
<div class="mui-content" style="height:100%;">
	<div class="tit_con">
		<img class="portrait" src="../../img/diary/m/head.png" alt="" />
		<div class="clearfix">
			<span class="pull_left subject" id="subject">工作日志</span>
			<span class="pull_right time" id="time">2017-11-24</span>
		</div>
		<div class="initiator" id="pho_init">发起人：王鹏   市场部</div>
		<!--<div class="clearfix">
            <div class="pull_left score"><img class="fraction" src="/images/diary/icon_score.png" alt="" />评分：5.0</div>
            <div class="pull_right delete_font">删除</div>
            <div class="pull_right edit_font">编辑</div>
        </div>-->
	</div>
	<div class="explain">
		<p>今日工作，市场推广计划实施有以下几个问题同类产品竞争激烈，电商飞鼠发展，实体点销售下滑。</p>
		<p>男装相对运动企业，企业的门店数量、存货规模要小很多。门店数量的大概5000余家，一般是1000-3000家，调整起来相对容易</p>
	</div>
	<div class="content clearfix">
		<div class="com_sum">评分</div>
		<div id="startone"  class="block clearfix" >
			<div class="star_score"></div>
			<p style="float:left;"><span class="fenshu">0</span> 分</p>
			<!--<div class="attitude"></div>-->
		</div>
	</div>
	<textarea class="mui-text-justify" id="diary_connect" style="height:100% !important;border:none;margin-bottom:50px;" placeholder="请输入点评"></textarea>
</div>
<nav class="mui-bar mui-bar-tab ">
	<a class="mui-tab-item" href="#" style="padding:0px 10px;">
		<div class="box_bt" id="com_submit" style="background-color: #5890D7;">
			提交
		</div>
	</a>
</nav>

</body>
<script type="text/javascript">
    scoreFun($("#startone"));
    jQuery(function(){
        var str=location.href; //取得整个地址栏
        var num=str.indexOf("?")
        str=str.substr(num+1); //取得所有参数   stringvar.substr(start [, length ]
        did=str.split("=")[1];
        var data = {
            "diaId":did
        };
        var str="";
        var str2="";
        mui.ajax('/diary/getConByDiaId',{
            data:data,
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            beforeSend: function() {
                mui.plusReady(function() {
                    plus.nativeUI.showWaiting('正在加载');
                })
            },
            complete: function() {
                mui.plusReady(function() {
                    plus.nativeUI.closeWaiting();
                });
            },
            success:function(data){
                $("#subject").text(data.object.subject);
                $("#time").text(data.object.diaDate);
                $("#pho_init").text(data.object.userName);
                $(".explain").html('<pre>'+data.object.content+'</pre>')
            },
            error:function(xhr,type,errorThrown){
                //异常处理；
                console.log(type);
            }
        });
        mui(".mui-bar").on('tap','#com_submit',function(){
            var data = {
                "diaId":did,
                "content":$("#diary_connect").val()
            };
            mui.ajax('/diary/insertDiaryComment',{
                data:data,
                dataType:'json',//服务器返回json格式数据
                type:'get',//HTTP请求类型
                async: false,
                success:function(data){
                    self.location=document.referrer;
                },
                error:function(xhr,type,errorThrown){
                    //异常处理；
                    console.log(type);
                }
            });


        })






    })




</script>
</html>
