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
    <title>通讯薄</title>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/mui/mui/mui.min.js"></script>
    <link href="/lib/mui/mui/mui.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="../css/addressBook/m/index.css"/>
    <script type="text/javascript" charset="utf-8">
      	mui.init();
    </script>
</head>
<body>
	<header class="mui-bar mui-bar-nav">
	    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
	    <h1 class="mui-title">通讯薄</h1>
	</header>
	<div class="mui-content">
		<div id="" class="search">
			<div class="mui-input-row mui-search" style="padding: 0px 5px;height: 44px;">
				<input type="search" class="mui-input-clear" id="searchLog" placeholder="输入关键字智能搜索">
			</div>
		</div>
		
	    <div id="centent" style="border-top:1px solid #e4e3e6">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell spacing"  uid="'+i.uid+'">
					<div class="simba_work">
						<img class="cal_type" src="">
					</div>
					<div class="simba_conter">
						<div class="simba_subject">姓名</div>
						<div class="simba_writing">手机号</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
	(function($, doc) {
		$.back=function(){
			plus.SimbaPlugin.quitApp();
		}
	
	})(mui, document);
	//跳转用户资料页面
	function fn_showUserInfo(uid){
		var accNbr = uid;
		var paramt = {
			"userId": accNbr
		};
		plus.SimbaPlugin.showUserInfo(paramt,
			function (data) {
				if (typeof data === "string") data = JSON.parse(data);
				//alert(JSON.stringify(data));
			},
			function (result) {
				alert('error: ' + JSON.stringify(result));
			}
		);
	}
	function searchdata(){
		var data = {
					"keyword":jQuery("#searchLog").val(), //搜索的内容
					"flag":3
				};
				console.log(data);
				mui.ajax('http://app.oaoa.pro/app/add_book/p/data.php',{
					data:data,
					dataType:'json',//服务器返回json格式数据
					type:'get',//HTTP请求类型
					success:function(data){
						var str = '<p class="nausize">搜索结果：'+data.count+'</p>';
						for (var i = 0; i < data.data.length; i++) {
							str+='<ul class="mui-table-view">'+
									'<li class="mui-table-view-cell spacing"  uid="'+data.data[i].uid+'">'+				
										'<div class="simba_work">'+
											'<img class="cal_type" src="'+data.data[i].avatar+'">'+
										'</div>'+
										'<div class="simba_conter">'+
											'<div class="simba_subject">'+data.data[i].name+'</div>'+
											'<div class="simba_writing">'+data.data[i].phone+'</div>'+
										'</div>'+			
									'</li>'+											    
								'</ul>';					
						};						   
						jQuery("#centent").html(str);	
					},
					error:function(xhr,type,errorThrown){
						//异常处理；
						console.log(type);
					}
			});
	}
	mui.ajax('http://101.201.28.214:8081/app/add_book/p/data.php',{
				dataType:'json',//服务器返回json格式数据
				type:'get',//HTTP请求类型
				data:{
					"flag":1
				},	
				success:function(obj){
					 var data=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
					 var str = '';
					 for(var i=0;i<data.length;i++){
					 	if(obj[data[i]]){
					 		str+='<p class="nausize">'+data[i]+'</p>';
					 		obj[data[i]].forEach(function(i,v){
					 			str+='<ul class="mui-table-view">'+
									    '<li class="mui-table-view-cell spacing"  uid="'+i.uid+'">'+				
											'<div class="simba_work">'+
												'<img class="cal_type" src="'+i.avatar+'">'+
											'</div>'+
											'<div class="simba_conter">'+
												'<div class="simba_subject">'+i.name+'</div>'+
												'<div class="simba_writing">'+i.phone+'</div>'+
											'</div>'+			
										'</li>'+											    
									'</ul>';					 								 			
					 		})										 		
					 	}					 						 						 	
					 }
					 				 
					jQuery("#centent").html(str);	
				
				},
				error:function(xhr,type,errorThrown){
					//异常处理；
					console.log(type);
				}
		
		
		})
		mui("#centent").on("tap","li",function(){
				var uid = this.getAttribute("uid");				
			  //打开资料页面
			  fn_showUserInfo(uid)
			 
					
		});
		//搜索功能
		var u=navigator.userAgent;
		if(!!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)){
			//获取IOS  eid
			jQuery("#searchLog").blur(function(){
				searchdata();			
			})	
		}else if(u.indexOf("Android")>-1||u.indexOf("Linux")>-1){
			//获取安卓  eid
			document.getElementById("searchLog").addEventListener("keydown",function(e){ 
		        if(13 == e.keyCode){ //点击了“搜索”  
		        	searchdata();
		           document.activeElement.blur();//隐藏软键盘 	
		        } 
		    },false);	
		}
		
		
		
	
	
	
	
	
</script>
</html>