<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
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
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>新建公告</title>
		<meta name="renderer" content="webkit">
	    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<link rel="stylesheet" type="text/css" href=../lib/laydate.css"/>
		<link rel="stylesheet" type="text/css" href="../css/notice.css"/>
		<script src="../js/xoajq/xoajq2.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/attach.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/wdatepicker.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/mynotice/notice.js" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
	</head>
	<body>
		<div class="content">
			<div class="title">
				<img src="img/notify_new.gif" alt="" />
				<span>新建公告</span>
				<a href="javascript:;" id="noty">选择格式</a>
				<div class="div_form" style="display: none;">
					<a href="javascript:;">普通格式</a>
					<a href="javascript:;">MHT格式</a>
					<a href="javascript:;">超级链接</a>
				</div>
			</div>
			
			<form action="" method="post" name="form1">
				<table cellspacing="0" cellpadding="0" class="tab">
					<tr>
						<td width="15%">
							<select name="type_name" id="type_id" title="新闻" style="width: 70%;">
					            <option value="00">选择公告类型</option>
					            <option value="01"><fmt:message code="notice.type.Decision"/></option>
								<option value="02"><fmt:message code="notice.type.notice"/></option>
								<option value="03"><fmt:message code="notice.type.Bulletin"/></option>
								<option value="04"><fmt:message code="notice.type.other"/></option>
					         </select>
						</td>
						<td width="70%">
							<input type="text" class="in_title" id="txt_id" placeholder="请输入公告标题" styl="outline: none;"/><font color=red>(*)</font>
							 <a id="font_color_link" href="javascript:;" class="dropdown" >
							 	<span>设置标题颜色</span>
							 	
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
							按部门发布：<br>
							<a href="javascript:;" id="href_txt">按人员或角色发布</a>
						</td>
						<td width="70%">
							<div class="inPole">
								<textarea name="txt" disabled></textarea>
								<span class="add_img">
									<span class="addImg">
										<img src="img/org_select1.png" class="addIcon"/>
									</span>
									<a href="javascript:;" class="Add">添加</a>
								</span>
								<span class="add_img">
									<span class="addImg">
										<img src="img/org_select2.png" class="clearIcon"/>
									</span>
									<a href="javascript:;" class="clear">清除</a>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td width="15%">发布时间：</td>
						<td width="70%">
							<input id="test" name="SEND_TIME" class="laydate-icon">
							<a href="javascript:resetTime();" class="reset">重置为当前时间</a>
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
						<td width="15%">置顶：</td>
						<td width="70%">
							<input type="checkbox" name="TOP" id="TOP">
							<label for="TOP">使公告通知置顶，显示为重要</label>
      						<input type="text" name="TOP_DAYS" size="3" maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')" class="BigInput" value="0">&nbsp;天后结束置顶，0表示一直置顶 
						</td>
					</tr>
					<tr>
						<td width="15%">内容简介：</td>
						<td width="70%">
							<input class="BigInput" type="text" name="SUMMARY" cols="46" rows="2" size=60 maxlength="30" value="">(最多输入30个字)
						</td>
					</tr>
					<tr>
						<td width="15%">附件上传：</td>
						<td width="70%">
							附件上传
						</td>
					</tr>
					<tr>
						<td colspan="2">
							 <div id="container" name="content" type="text/plain" style="width: 99.9%;min-height: 200px;"></div>
						</td>
						
					</tr>
					<tr>
						<td width="15%">关键词：</td>
						<td width="70%">
							<input type="text" name="KEYWORD" id='KEYWORD' class="BigInput"  size=50>
					      	<span id="tishi"></span>
					      	<a href='javascript:get_keyword();' class='A1'>自动获取关键词
					      	</a>&nbsp;&nbsp;&nbsp;(您可以调整关键词内容，多个关键词请用,分隔)
						</td>
					</tr>
					<tr class="last_tr">
						<td colspan="2">
							<div class="div_btn">
								<input type="button" id="btn1" value="发布" />
								<input type="button" id="btn2" value="保存" />
							</div>
							
						</td>
					</tr>
				</table>
			</form>
			
		</div>
		<script type="text/javascript">
			
			//时间控件调用
			 laydate({
			  elem: '#test'      //目标元素。
			}); 
		 
	        var ue = UE.getEditor('container');
			$(function() {
			//设置编辑器的内容
				
				$("#btn2").on("click",function(){
					//获取html内容，返回: <p>hello</p>
					//var html = ue.getContent();
					//获取纯文本内容，返回: hello
					var val=$('#txt_id').val();
					var txt = ue.getContentTxt();
					
					var data={
						'fromId':'1',
						'typeId':'2',
						'Subjec':val
					}
					
					$.ajax({
						 type:'post',    
						 url:"addNotify",
						 dataType:'json',
						 async:false,
						 data:data,
						 success:function(){
							alert('123');
						}
					})
				})
				
			}); 
	    </script>
	</body>
</html>

