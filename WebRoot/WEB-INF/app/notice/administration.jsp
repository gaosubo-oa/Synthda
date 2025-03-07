<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html><!--<![endif]-->
 <head>
    <title><fmt:message code="notice.title.notifynoticemanage" /></title><!-- 公告通知管理 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/notice/notify.css" />
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
  <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
    	#noticeQuery{width: 100%;}
    	#noticeQuery table tr td{padding:5px 5px;border-color:#ccc;}
    	.TableBlock{background-color:#fff;border-color:#aaa;}
    	.inPole{font-size: 14px;}
		textarea{min-width: 30%;min-height: 30px;margin: 5px 5px;}
		.inPole a{display: inline-block;padding: 3px 5px;text-decoration: none;}
		.add_img .addImg{display: inline-block;width: 20px;height: 10px;overflow: hidden;position: relative;}
		.add_img .addImg img{height: 100%;}
		.add_img .addImg .addIcon{position: absolute;top: 0;left: 0;}
		.add_img .addImg .clearIcon{position: absolute;top: 0;left: -20px;}
		#noRead{width: 100%;}
		#noRead span{display: block;width: 50%;margin: 20px auto;padding: 20px 20px;font-size: 25px;text-align: center;background-color: #6fb4fa;color: #fff;}
		.title{font-size: 16px;color: #124164;font-weight: bold;margin-top:20px;margin-left:20px;display: inline-block;}
		.M-box3{margin-left:100px;margin-top:10px;}
		.M-box3 a{margin: 0 3px;width: 29px;height: 20px;line-height: 20px;font-size: 12px;text-decoration: none;}
		.M-box3 .active{margin: 0px 3px;width: 25px;height: 20px;line-height: 20px;background: #2b7fe0;font-size: 12px;border: 1px solid #2b7fe0;}
		.jump-ipt{margin: 0 3px;width: 25px;height: 20px;line-height: 20px;font-size: 12px;}
		.M-box3 a:hover{background: #2b7fe0;}
		     	.break_td{
     		width: 100px;
		    overflow: hidden;
		    text-overflow: ellipsis;
		    white-space: nowrap;
     	}
    </style>
   <script type="text/javascript">
    	$(function(){
    			var data1={
    				"page":1,
    				"pageSize":10,
    				"useFlag":true
    			};
    			$.ajax({
						type:'get',
						url:'notifyManage',
						dataType:'json',
						data:data1,
						success:function(rsp){
							var data=rsp.obj;
								
							//console.log(data[0].name);				
							var str='';
							var str1='';
							for(var i=0;i<data.length;i++){
								var begindate = new Date(data[i].beginDate).Format('yyyy:MM:dd hh:mm:ss')
								str+='<tr class="TableLine1"><td nowrap align="center">'+data[i].users.userName+'</td><td nowrap align="center">'+data[i].typeName+'</td><td nowrap align="left"><div class="break_td" title="'+data[i].name+'">'+data[i].name+'</div></td><td nowrap align="center">'+data[i].subject+'</td><td nowrap align="center">'+data[i].sendTime+'<input type="hidden" id="'+data[i].notifyId+'"></td><td nowrap align="center">'+begindate+'</td><td nowrap align="center">&nbsp</td><td nowrap><a href="javascript:;" title="<fmt:message code="news.th.querysituation" />"> <fmt:message code="news.th.querysituation" /></a>&nbsp;<a href="javascript:;"> 生效</a>&nbsp;<a href="javascript:;" onclick="jump()" > 修改</a>&nbsp;<a href="javascript:;" onclick="delate('+data[i].notifyId+')"> <fmt:message code="global.lang.delete" /></a></td></tr>';

								//str1+='<input type="hidden" id="'+data[i].notifyId+'">';
							}
							$('.TableHeader').after(str); 
							
							$('.M-box3').pagination({
							    pageCount:1,
							    jump:true,
							    coping:true,
							    homePage:'<fmt:message code="global.page.first" />',
							    endPage:'<fmt:message code="global.page.last" />',
							    prevContent:'<fmt:message code="global.page.pre" />',
							    nextContent:'<fmt:message code="global.page.next" />',
							    jumpBtn:'<fmt:message code="global.page.jump" />'
							});
						}
				});
	    		
	    		
	    		
    	});
    	
    	function delate(id){
    		//alert(data[i].notifyId)
    		var msg='<fmt:message code="global.lang.sure" />?';
    		if (confirm(msg)==true){ 
			  	
			  	 $.ajax({
						type:'get',
						url:'deleteById',
						dataType:'json',
						data:{'id':id},
						success:function(){
							
							//location.reload();
						}
				}); 
				return true;
			 }else{ 
			 	return false; 
			 } 	
    	}    	
    	
    	
    	
    </script>
</head>

<body class="bodycolor">
<div class="muJump">
	<ul>
		<li class="jumpOn" id="NOTIFY"><a href="javascript:;"><fmt:message code="notice.th.notifymanage" /></a></li>
		<li><a href="add" id="NEWLY"><fmt:message code="notice.th.buildnotify" /></a></li>
		<li><a href="noticeQuery" ><fmt:message code="notice.title.announcementquery" /></a></li>
	</ul>
</div>
<div class="content">
	<!-- 公告管理 -->
	<div id="notify" style="overflow-y: scroll;display:block;">
		<table border="0" width="95%" cellspacing="0" cellpadding="3" class="small" align="center">
		  <tr>
		    <td class="Big">
		    	<img src="../img/notify_open.gif" align="absmiddle">
		    	<span class="big3"><fmt:message code="notice.th.managenotifynotice" /></span>&nbsp;
		       <select name="TYPE" class="BigSelect" onChange="change_type(this.value);">
		          	<option value="0" selected><fmt:message code="notice.type.alltype" /></option>
		         	<option value="01"><fmt:message code="notice.type.Decision" /></option>
					<option value="02"><fmt:message code="notice.type.notice" /></option>
					<option value="03"><fmt:message code="notice.type.Bulletin" /></option>
					<option value="04"><fmt:message code="notice.type.other" /></option>
		          	<option value="05"><fmt:message code="notice.type.notype" /></option>
		       </select>
		    </td>
		    <td align="right" valign="bottom" class="small1">
		    	<div class="M-box3"></div>
		    </td>
		  </tr>
		</table>
		<table class="TableList" width="95%" align="center" cellspacing="0" cellpadding="0">
		  <tr class="TableHeader">
		     <!--  <th nowrap align="center">选择</th> -->
		      <th nowrap align="center"><fmt:message code="notice.th.publisher" /></th>
		      <th nowrap align="center"><fmt:message code="notice.th.type" /></th>
		      <th nowrap align="center"><fmt:message code="notice.th.releasescope" /></th>
		      <th nowrap align="center"><fmt:message code="notice.th.title" /></th>
		   
		      <th nowrap align="center" style="cursor:pointer;"><u><fmt:message code="notice.th.createTime" /></u>
		      	<img border=0 src="../img/arrow_down.gif" width="11" height="10">
		      </th>
		      <th nowrap align="center" style="cursor:pointer;"><u><fmt:message code="notice.th.effectivedate" /></u></th>
		      <th nowrap align="center" style="cursor:pointer;"><u><fmt:message code="notice.th.endDate" /></u></th>
		      <!-- <th nowrap align="center"><fmt:message code="notice.th.state" /></th> -->
		      <th nowrap align="center"><fmt:message code="notice.th.operation" /></th>
		    </tr>
		</table>
	</div>
	<div class="div_iframe_newly" style="width: 100%;overflow-y: auto;overflow-x: hidden;float: left;height: 100%;display:none;">
		<div id="iframe1" class="iframe1" style="width: 100%;height: 100%;">
			<iframe  id="iframe_id" src="add" frameborder="0" height="100%" width="100%" noresize="noresize"></iframe>
		</div>
	</div>
	<div class="div_iframe_query" style="width: 85%;overflow-y: auto;overflow-x: hidden;float: left;height: 100%;display:none;">
		<div id="iframe1" class="iframe1" style="width: 100%;height: 100%;">
			<iframe  id="iframe_id" src="noticeQuery" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
		</div>
	</div>
</div>
	<script type="text/javascript">
		
		$(function(){
			$('.muJump ul li').click(function(){
				var index=$(this).index();
				$('.muJump ul li').removeClass('jumpOn');
	    		$(this).addClass('jumpOn');
	    		$('.content>div').eq(index).show().siblings().hide();
			})
		})
		
	</script>
</body>
</html>
