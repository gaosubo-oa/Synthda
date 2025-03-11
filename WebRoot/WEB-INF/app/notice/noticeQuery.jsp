<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><fmt:message code="notice.title.announcementquery" /></title>
		<meta name="renderer" content="webkit">
	    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
		
		<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			html,body{width: 100%;height: 100%;font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;font-size: 14px;}
			.inPole{font-size: 14px;}
			textarea{min-width: 30%;min-height: 30px;margin: 5px 5px;}
			.inPole a{display: inline-block;padding: 3px 5px;text-decoration: none;}
			 .add_img .addImg{display: inline-block;width: 20px;height: 10px;overflow: hidden;position: relative;}
			 .add_img .addImg img{height: 100%;}
			 .add_img .addImg .addIcon{position: absolute;top: 0;left: 0;}
			 .add_img .addImg .clearIcon{position: absolute;top: 0;left: -20px;}
		</style>
	</head>
	<body>
	<div id="noticeQuery" style="display: block;">
		<table class="TableBlock" width="550" align="center" border="1">
		  <form enctype="multipart/form-data" name="form1"></form>
		    <tbody><tr>
		      <td nowrap="" class="TableData"><fmt:message code="notice.th.publisher" />：</td>
		      <td class="TableData">
		        <div class="inPole">
					<textarea name="txt" disabled></textarea>
					<span class="add_img">
						<span class="addImg">
							<img src="img/org_select1.png" class="addIcon"/>
						</span>
						<a href="javascript:;" class="Add"><fmt:message code="global.lang.add" /></a>
					</span>
					<span class="add_img">
						<span class="addImg">
							<img src="img/org_select2.png" class="clearIcon"/>
						</span>
						<a href="javascript:;" class="clear"><fmt:message code="global.lang.delete" /></a>
					</span>
				</div>
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"><fmt:message code="notice.th.format" />：</td>
		      <td class="TableData">
		      <select name="FORMAT" class="BigSelect">
		        <option value="" selected=""><fmt:message code="notice.th.all" /></option>
		        <option value="0"><fmt:message code="notice.format.Commonformat" /></option>
		        <option value="1"><fmt:message code="notice.format.MHTformat" /></option>
		       <!--  <option value="2">超级链接</option> -->
		      </select>
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData"><fmt:message code="notice.th.type" />：</td>
		      <td class="TableData">
		        <select name="TYPE_ID" class="BigSelect">
		          <option value="" selected=""><fmt:message code="notice.th.all" /></option>
		          <option value="01"><fmt:message code="notice.type.Decision" /></option>
				  <option value="02"><fmt:message code="notice.type.notice" /></option>
				  <option value="03"><fmt:message code="notice.type.Bulletin" /></option>
				  <option value="04"><fmt:message code="notice.type.other" /></option>
		        </select>&nbsp;
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"><fmt:message code="notice.th.postedType" />：</td>
		      <td class="TableData">
		      <select name="PUBLISH" class="BigSelect">
		        <option value="" selected=""><fmt:message code="notice.th.all" /></option>
		        <option value="0"><fmt:message code="notice.th.unposted" /></option>
		        <option value="1"><fmt:message code="notice.th.posted" /></option>
		      </select>
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"> <fmt:message code="notice.th.ifTop" />：</td>
		      <td class="TableData">
		      <select name="TOP" class="BigSelect">
		        <option value="" selected=""><fmt:message code="notice.th.all" /></option>
		        <option value="0"><fmt:message code="notice.th.untoped" /></option>
		        <option value="1"><fmt:message code="notice.th.toped" /></option>
		      </select>
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"><fmt:message code="notice.th.title" />：</td>
		      <td class="TableData">
		        <input type="text" name="SUBJECT" size="33" maxlength="100" class="BigInput" value="">
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"> <fmt:message code="notice.title.Releasedate" />：</td>
		      <td class="TableData">
		        <input class="laydate-icon" id="start"> &nbsp;<fmt:message code="global.lang.to" />&nbsp;
		        <input class="laydate-icon" id="end">
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"> <fmt:message code="notice.th.content" />：</td>
		      <td class="TableData">
		        <input type="text" name="CONTENT" size="33" maxlength="200" class="BigInput" value="">
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"><fmt:message code="notice.th.effectiveType" />：</td>
		      <td class="TableData">
		      <select name="STAT" class="BigSelect">
		        <option value="" selected=""><fmt:message code="notice.th.all" /></option>
		        <option value="1"><fmt:message code="notice.th.uneffective" /></option>
		        <option value="2"><fmt:message code="notice.th.effectived" /></option>
		        <option value="3"><fmt:message code="notice.th.hasEnd" /></option>
		      </select>
		      </td>
		    </tr>
		    <tr>
		      <td nowrap="" class="TableData" width="100"><fmt:message code="notice.th.operation" />：</td>
		      <td class="TableData">
		        <input type="radio" name="OPERATION" id="OPERATION1" value="1" checked=""><label for="OPERATION1"><fmt:message code="global.lang.query" /></label>
		        <input type="radio" name="OPERATION" id="OPERATION2" value="2"><label for="OPERATION2"><fmt:message code="global.lang.delete" /></label>
		        <input type="radio" name="OPERATION" id="OPERATION3" value="3"><label for="OPERATION3">导出excel文件</label>
		      </td>
		    </tr>
		    <tr align="center" class="TableControl">
		      <td colspan="2" nowrap="">
		        <input type="submit" value="<fmt:message code="global.lang.ok" />" class="BigButton">&nbsp;&nbsp;
		        <input type="reset" value="<fmt:message code="global.lang.refillings" />" class="BigButton">&nbsp;&nbsp;
		      </td>
		    </tr>
		  </tbody>
		</table>
	</div>
	<!-- 查询列表  -->
	<div id="queryList" style="overflow-y: scroll;display:none;">
		<table border="0" width="95%" cellspacing="0" cellpadding="3" class="small" align="center">
		  <tr>
		    <td class="Big">
		    	<img src="../img/notify_open.gif" align="absmiddle">
		    	<span class="big3"><fmt:message code="notice.th.queryEnd" /></span>
		    </td>
			   		
		    <td align="right" valign="bottom" class="small1">
		    	<div class="M-box3"></div>
		    </td>
		  </tr>
		</table>
		<table class="TableList" width="95%" align="center" cellspacing="0" cellpadding="0">
		  <tr class="TableHead">
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
		    	<td colspan="5">
			    	<div class="divBtn">
			    		<input type="button" name="iBtn" class="iBtn" id="iBtn" value="<fmt:message code="notice.th.return" />" style="cursor: pointer;">
			    	</div>
		    	</td>
		    </tr>
		</table>
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
			laydate(end);//
			
       		/* $(function(){
       			
       			$('input[type="submit"]').click(function () {
					var typeId=$('select[name="TYPE_ID"] option:checked').val();
					var forMat=$('select[name="FORMAT"] option:checked').val();
					var subject=$('input[name="SUBJECT"]').val();
					var content=$('input[name="CONTENT"]').val();
					var data={
						'typeId':typeId,
						'sendTime':'2017-04-03 10:28:35',
						'subject':subject,
						'content':content,
						'format':forMat
					};
					
					$.ajax({
						type:"get",
						url:"notifyList",
						dataType:'json',
						data:data,
						success:function(){
					
							console('1223');
						}
					});
				});
       		}); */
    	</script>
	</body>
</html>

