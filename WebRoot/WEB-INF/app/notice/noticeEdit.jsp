<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><fmt:message code="notice.th.notifyEdit" /></title>
		<meta name="renderer" content="webkit">
	    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
		<link rel="stylesheet" type="text/css" href="../css/notice/notice.css"/>
		<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/notice/attach.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/notice/wdatepicker.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
		<!--<script src="../js/index.js" type="text/javascript" charset="utf-8"></script>-->
		<script src="../js/notice/notice.js" type="text/javascript" charset="utf-8"></script>
	</head>
	<body>
		<div class="content">
			<div class="title">
				<img src="img/notify_new.gif" alt="" />
				<span><fmt:message code="notice.th.notifyEdit" /></span>
				<a href="javascript:;" id="noty"><fmt:message code="notice.th.choseformat" /></a>
				<div class="div_form" style="display: none;">
					<a href="javascript:;"><fmt:message code="notice.format.Commonformat" /></a>
					<a href="javascript:;"><fmt:message code="notice.format.MHTformat" /></a>
					<!--<a href="javascript:;">超级链接</a>-->
				</div>
			</div>
			
			<form action="" method="post" name="form1">
				<table cellspacing="0" cellpadding="0" class="tab">
					<tr>
						<td width="15%">
							<select name="type_name" id="type_id" title="<fmt:message code="notice.th.notice" />" style="width: 70%;">
					            <option value="00"><fmt:message code="notice.th.chosenotifytype" /></option>           
					            <option value="01"><fmt:message code="notice.type.Decision" /></option>
								<option value="02"><fmt:message code="notice.type.notice" /></option>
								<option value="03"><fmt:message code="notice.type.Bulletin" /></option>
								<option value="04"><fmt:message code="notice.type.other" /></option>
					         </select>
						</td>
						<td width="70%">
							<input type="text" class="in_title" id="txt_id" placeholder="<fmt:message code="notice.th.PleaseEnterTheTitle" />" styl="outline: none;"/><font color=red>(*)</font>
							 <a id="font_color_link" href="javascript:;" class="dropdown" >
							 	<span><fmt:message code="notice.th.SetTitlecolor" /></span>
							 	
							 </a>
							 <div class="worldColor" style="display: none;">
							 	<ul>
							 		<li class="black"></li>
							 		<li class="green"></li>
							 		<li class="blue"></li>
							 		<li class="blueviolet"></li>
							 		<li class="sandybrown"></li>
							 		<li class="red"></li>
							 	</ul>
							 </div>
						</td>
					</tr>
					<tr>
						<td width="15%">
							<fmt:message code="notice.th.IssuedByDepartment"/>
							：<br>
							<a href="javascript:;" id="href_txt">
							<fmt:message code="notice.th.PostedByPersonnelOrRoles" /></a>
						</td>
						<td width="70%">
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
									<a href="javascript:;" class="clear"><fmt:message code="global.lang.empty" /></a>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td width="15%"><fmt:message code="notice.th.PostedTime" />：</td>
						<td width="70%">
							<input id="test" name="SEND_TIME" class="laydate-icon">
							<a href="javascript:resetTime();" class="reset"><fmt:message code="notice.th.ResetToCurrentTime" /></a>
						</td>
					</tr>
					<!--<tr>
						<td width="15%">提醒：</td>
						<td width="70%">
							<input type="checkbox" name="SMS_REMIND1" id="SMS_REMIND1" checked>
							<label for="SMS_REMIND1">发送事务提醒消息</label>&nbsp;
							<label class='sms-remind-label'>
								<input type="checkbox" name="SNS_REMIND" id="SNS_REMIND" checked>分享到企业社区
							</label>
						</td>
					</tr>-->
					<tr>
						<td width="15%"><fmt:message code="notice.th.top" />：</td>
						<td width="70%">
							<input type="checkbox" name="TOP" id="TOP">
							<label for="TOP"><fmt:message code="notice.th.topMajor" /></label>
      						<input type="text" name="TOP_DAYS" size="3" maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')" class="BigInput" value="0">&nbsp;<fmt:message code="notice.th.endTop" />
						</td>
					</tr>
					<tr>
						<td width="15%"><fmt:message code="notice.th.contentValidity" />：</td>
						<td width="70%">
							<input class="BigInput" type="text" name="SUMMARY" cols="46" rows="2" size=60 maxlength="30" value="">(<fmt:message code="notice.th.enterAMaximumOf30Characters" />)
						</td>
					</tr>
					<tr>
						<td width="15%"><fmt:message code="notice.th.fileUpload" />：</td>
						<td width="70%">
					    <fmt:message code="notice.th.fileUpload" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							 <script id="container" name="content" type="text/plain" style="width: 99.9%;min-height: 200px;">
						    </script>
						</td>
						
					</tr>
					<tr>
						<td width="15%"><fmt:message code="notice.th.keyWord" />：</td>
						<td width="70%">
							<input type="text" name="KEYWORD" id='KEYWORD' class="BigInput"  size=50>
					      	<span id="tishi"></span>
					      	<a href='javascript:get_keyword();' class='A1'><fmt:message code="notice.th.AutomaticKeywordAcquisition" />
					      	</a>&nbsp;&nbsp;&nbsp;<fmt:message code="notice.th.keyContent" />
						</td>
					</tr>
					<tr class="last_tr">
						<td colspan="2">
							<div class="div_btn">
								<input type="button" id="btn1" value="<fmt:message code="global.lang.publish" />" />
								<input type="button" id="btn2" value="<fmt:message code="global.lang.save" />" />
							</div>
							
						</td>
					</tr>
				</table>
			</form>
			
		</div>
		<script type="text/javascript">
			//时间控件调用
			laydate({
			  elem: '#test', //目标元素。
			  format: 'YYYY-MM-DD hh:mm:ss', //日期格式
			  istime: true, //显示时、分、秒
			});
		 
		 
		 
	        var ue = UE.getEditor('container');
			ue.ready(function() {
			//设置编辑器的内容
				
				$("#sub1").on("click",function(){
					//获取html内容，返回: <p>hello</p>
					var html = ue.getContent();
					//获取纯文本内容，返回: hello
					var txt = ue.getContentTxt();
					alert(html+':'+txt);
					
				})
				
			});
	    </script>
	</body>
</html>


