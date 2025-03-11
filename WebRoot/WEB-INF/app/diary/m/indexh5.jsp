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
	<title></title>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
	<script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
	<link href="../lib/mui/mui/mui.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../css/diary/m/diary_base.css"/>
	<style>
		h1,h4{
			margin: 18px auto 10px auto;
			font-weight: 400 !important;
		}

		.mui-content{
			height: calc(100% - 72px);
			position: relative;
			background: #f5f5f5;
		}
		.my-card{
			position: relative;
			margin-top: -44px;
			box-shadow: none;
		}
		.mui-table-view.mui-grid-view{

		}
		.mui-card-content-inner{
			padding: 4px 15px;
		}
		.mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-object {
			width: 65%;
			max-width: 65%;
		}
		#footer{
			position: absolute;
			bottom: 10px;
			width: 100%;
		}
		.mui-btn-block{
			width: calc(100% - 20px);
			margin: auto;
			padding: 10px 0;
			background: #598fd6;
			border: #598fd6;
		}
		.add-icon{
			display:inline-block;
			height:15px;
			width:15px;
			margin-right: 8px;
			background: url(/img/diary/m/new.png) no-repeat bottom;
			background-size:cover ;
		}
		.mui-title-bar{
			position: relative;
			margin-left: 15px;
			display: inline-block;
			width: 3px;
			height: 16px;
			background: #ffa96f;
			vertical-align: sub;
		}
		.mui-card-header{
			display: inline-flex;
			width: calc(100% - 30px);
			padding-left: 8px;
		}
	</style>
</head>
<body id="diary">
<!--<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
    <h1 class="mui-title">???????</h1>
    <a id="info" class="mui-icon mui-icon-more-filled mui-pull-right mui-nav-btn"></a>
</header>-->
<div class="mui-content">
	<div class="mui-bg-positive">
		<h1 class="mui-text-center mui-num">0</h1>
		<h4 style="font-size: 16px;">待阅日志</h4>
		<h5 class="mui-check-btn mui-btn mui-btn-link" href="#" style="color: #fff;padding-top: 0;margin-top: 0;">点击查看</h5>
	</div>
	<div class="mui-card my-card">
		<i class="mui-title-bar"></i><div class="mui-card-header" >我的日志</div>
		<div class="mui-card-content">
			<div class="mui-card-content-inner">
				<ul class="mui-table-view mui-grid-view">
					<li class="mui-table-view-cell mui-media mui-col-xs-4">
						<a class="mui-table-view-cell" href="javascript:;" @click="jump_istarted">
							<img class="mui-media-object" src="/img/diary/m/icon_launch.png">

							<div class="mui-media-body">我发起的</div>
						</a>
					</li>
					<li class="mui-table-view-cell mui-media mui-col-xs-4">
						<a class="mui-table-view-cell" id="Received"  href="javascript:;" @click="jump_ireceived($event)">
							<img class="mui-media-object" src="/img/diary/m/icon_get.png">

							<div class="mui-media-body">我收到的</div>

						</a>
					</li>
					<li class="mui-table-view-cell mui-media mui-col-xs-4">
						<a class="mui-table-view-cell" href="javascript:;" @click="jump_share">
							<img class="mui-media-object" src="/img/diary/m/icon_search.png">

							<div class="mui-media-body">分享我的</div>
						</a>
					</li>
				</ul>
			</div>
		</div>
		<i class="mui-title-bar"></i>
		<div class="mui-card-header" >其他功能</div>
		<div class="mui-card-content">
			<div class="mui-card-content-inner">
				<ul class="mui-table-view mui-grid-view">
					<li class="mui-table-view-cell mui-media mui-col-xs-4">
						<a class="mui-table-view-cell" href="javascript:;" @click="jump_draft">
							<img class="mui-media-object" src="/img/diary/m/icon_draft.png">

							<div class="mui-media-body">草稿</div>
						</a>
					</li>
					<li class="mui-table-view-cell mui-media mui-col-xs-4">
						<a class="mui-table-view-cell" href="javascript:;" @click="jump_count">
							<img class="mui-media-object" src="/img/diary/m/icon_statistics.png">
							<div class="mui-media-body">统计</div>
						</a>
					</li>

				</ul>
			</div>
		</div>
	</div>


</div>
<footer id="footer">
	<div class="mui-bar-footer mui-text-center" id="jump_create" @click="jump_create">
		<div class="mui-btn mui-btn-primary mui-btn-block"><i class="mui-icon add-icon"style=""></i>新建日志</div>
	</div>
</footer>
</body>
<script type="text/javascript" charset="gbk">
    (function($, doc) {
        mui.init();
        var count='';
        var dia_id='';
        var state=""
        mui.ajax({
            type: 'POST',
            url: '/pda/diary/data/data.php?flag=12',
            dataType:'json',
            async:false,
            success:function(data){
                count=data.count;
                dia_id=data.DIA_ID;
                state=data.state;
                jQuery("#Received").attr("state",state);
                jQuery(".mui-num").html(count);

            }
        });

        mui(".mui-content").on('tap','.mui-bg-positive',function(){
            //alert(dia_id);
            mui.ajax({
                type: 'POST',
                url: '/pda/diary/data/data.php',
                dataType:'json',
                async:false,
                data:{
                    flag:14,
                    str:dia_id
                },
                success:function(data){
                    //console.log(data);
                    mui.openWindow({
                        id:'toread_list.php',
                        url:'toread_list.php?dia_id='+dia_id
                    });

                }
            });
        });
    })(mui, document);
    var vm=new Vue({
        el:'#diary',
        data:{
            name:'Vue.js'
        },
        methods:{
            jump_create:function(event){
                mui.openWindow({
                    url:'/diary/diaryCreateh5',
                    id:'Create'
                });
            },
            jump_istarted:function(event){
                mui.openWindow({
                    url:'/diary/iStartedListh5',
                    id:'iStarted'
                });
            },
            jump_ireceived:function(event){
               alert("正在开发中！")
            },
            jump_share:function(event){
                mui.openWindow({
                    url:'/diary/diaryShareListh5',
                    id:'share'
                });
            },
            jump_count:function(event){
                mui.openWindow({
                    url:'/diary/diaryCounth5',
                    id:'Count'
                });
            },
            jump_draft:function(event){
              alert("正在开发中!")
            }/*,
			 jump_my_list:function(event){
			 alert(dia_id);
			 $.ajax({
			 type: 'POST',
			 url: '/pda/diary/data/data.php?flag=14',
			 dataType:'json',
			 async:false,
			 data:{
			 str:dia_id
			 },
			 success:function(data){
			 console.log(data);

			 }
			 });

			 }*/
        }
    });
</script>
</html>
