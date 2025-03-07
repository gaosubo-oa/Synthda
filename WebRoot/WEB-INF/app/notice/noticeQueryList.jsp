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
    <title><fmt:message code="notice.title.notify" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/notice/notify.css" />
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
  	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
  	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
		.title{font-size: 16px;color: #124164;font-weight: bold;margin-top:20px;margin-left:20px;display: inline-block;}
		.M-box3{margin-left:100px;margin-top:10px;}
		.M-box3 a{margin: 0 3px;width: 29px;height: 20px;line-height: 20px;font-size: 12px;text-decoration: none;}
		.M-box3 .active{margin: 0px 3px;width: 25px;height: 20px;line-height: 20px;background: #2b7fe0;font-size: 12px;border: 1px solid #2b7fe0;}
		.jump-ipt{margin: 0 3px;width: 25px;height: 20px;line-height: 20px;font-size: 12px;}
		.M-box3 a:hover{background: #2b7fe0;}
		.laydate-icon{width:150px;}
    </style>
    <script type="text/javascript">
    	$(function(){
    			/* var data1={
    				"page":1,
    				"pageSize":5,
    				"useFlag":true
    			};
    			$.ajax({
						type:'get',
						url:'notifyList',
						dataType:'json',
						data:data1,
						success:function(rsp){
							var data=rsp.obj;	
							console.log(data[0].name);				
							var str='';
							for(var i=0;i<data.length;i++){
								str+='<tr class="TableLine1"><td nowrap align="center">'+data[i].name+'</td><td nowrap align="center">'+data[i].typeId+'</td><td nowrap align="left"><a href="javascript:;" noticeId="'+data[i].notifyId+'" class="windowOpen">'+data[i].subject+'</a></td><td nowrap align="center">'+data[i].toId+'</td><td nowrap align="center">'+data[i].sendTime+'</td></tr>';
								str1='<input type="hidden" id="'+data[i].notifyId+'">';
							}
							$('.TableHeader').after(str+str1); 
							
							$('.M-box3').pagination({
							    pageCount:10,
							    jump:true,
							    coping:true,
							    homePage:'<fmt:message code="global.page.first" />',
							    endPage:'<fmt:message code="global.page.last" />',
							    prevContent:'<fmt:message code="global.page.pre" />',
							    nextContent:'<fmt:message code="global.page.next" />',
							    jumpBtn:'<fmt:message code="global.page.jump" />'
							});
						}
				}); */
    	});	
    </script>
</head>

<body class="bodycolor">
<div class="content">

	<!-- 公告通知 start -->
	<div id="queryList" style="overflow-y: scroll;display:block;">
		<table border="0" width="95%" cellspacing="0" cellpadding="3" class="small" align="center">
		  <tr>
		    <td class="Big">
		    	<img src="../img/notify_open.gif" align="absmiddle">
		    	<span class="big3"><fmt:message code="notice.title.notify" /></span>&nbsp;
		       <select name="TYPE" class="BigSelect" onChange="change_type(this.value);">
		          	<option value="0" selected><fmt:message code="notice.type.alltype" /></option>
		         	<option value="01"><fmt:message code="notice.type.Decision" /></option>
					<option value="02"><fmt:message code="notice.type.notice" /></option>
					<option value="03"><fmt:message code="notice.type.Bulletin" /></option>
					<option value="04"><fmt:message code="notice.type.other" /></option>
		          	<option value="05"><fmt:message code="notice.type.notype" /></option>
		       </select>
		       <span><fmt:message code="notice.title.Releasedate" />:</span>
				<input id="test" name="SEND_TIME" class="laydate-icon">
				<input type="button" id="but" value="<fmt:message code="global.lang.ok" />" />
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
		      <th nowrap align="center"><fmt:message code="notice.th.title" /></th>
		   
		      <th nowrap align="center" style="cursor:pointer;"><u><fmt:message code="notice.th.releasescope" /></u>
		      	
		      </th>
		      <th nowrap align="center"><fmt:message code="notice.th.createTime" />
		      	<img border=0 src="../img/arrow_down.gif" width="11" height="10">
		      </th>
		    </tr>
		    <tr>
		    	<td><input type="button" name="Btn" class="Btn" id="Btn" value="<fmt:message code="notice.th.return" />"></td>
		    </tr>
		</table>
	</div> 
</div>

<script type="text/javascript">
			
			//时间控件调用
			var start = {
			  elem: '#start',
			  format: 'YYYY/MM/DD hh:mm:ss',
			 /* min: laydate.now(), //设定最小日期为当前日期*/
			 /* max: '2099-06-16 23:59:59', //最大日期*/
			  istime: true,
			  istoday: false,
			  choose: function(datas){
			     end.min = datas; //开始日选好后，重置结束日的最小日期
			     end.start = datas; //将结束日的初始值设定为开始日
			  }
			};
			var end = {
			  elem: '#end',
			  format: 'YYYY/MM/DD hh:mm:ss',
			  /*min: laydate.now(),*/
			  /*max: '2099-06-16 23:59:59',*/
			  istime: true,
			  istoday: false,
			  choose: function(datas){
			    start.max = datas; //结束日选好后，重置开始日的最大日期
			  }
			};
			laydate(start);
			laydate(end);
			
       		
</script>

</body>	
</html>
