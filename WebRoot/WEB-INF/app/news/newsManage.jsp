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
	<head lang="en">
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><fmt:message code="news.th.newsmanage"/></title>
		<link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
		<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
		<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
		<link rel="stylesheet" type="text/css" href="../css/base.css"/>
		<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
		<!-- 新闻管理  -->
		<link rel="stylesheet" type="text/css" href="../css/news/management_query.css"/>
        
		<script src="/js/common/language.js"></script>
<%--		<script src="/js/xoajq/xoajq1.js" type="text/javascript"--%>
<%--		        charset="utf-8"></script>--%>
		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
		<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript"
		        charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript"
		        charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript"
		        charset="utf-8"></script>
		<script src="../js/news/page.js"></script>
		<script src="../lib/laydate/laydate.js"></script>
		<script src="../lib/layer/layer.js?20201106"></script>
		<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
		<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="/js/common/fileupload.js"></script>
		<!-- word文本编辑器 -->
		<%--    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>--%>
		<%--    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>--%>
		<%--    <script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>--%>
		
		<!-- kindeditor文本编辑器 -->
		<script charset="utf-8" src="/lib/kindeditor/kindeditor-all.js"></script>
		<script charset="utf-8" src="/lib/kindeditor/lang/zh-CN.js"></script>
		<script src="../../lib/layer/layer.js?20201106"></script>
		<script src="../js/jquery/jquery.cookie.js"></script>
		<script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
		<script src="/js/jquery/jquery.form.min.js"></script>
		<script type="text/javascript" src="../js/email/fileuploadPlus.js?20230529.2"></script>
		<script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="/js/email/fileupload.js"></script>
		<script type="text/javascript" src="/js/common/fileupload.js"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
        
        <style>
		* {
			padding: 0;
			margin: 0;
		}
		
		.release4 {
			margin-top: 10px;
		}
		
		#tr_td .publishtip {
			overflow: hidden;
			text-overflow: ellipsis;
			width: 100%;
			white-space: nowrap;
		}
		
		/*标题长时隐藏设置*/
		.title {
			width: 100%;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		
		#tr_td thead tr td {
			font-size: 13pt;
		}
		
		#j_tb tr td {
			font-size: 11pt;
		}
		
		.blue_text {
			font-size: 11pt;
		}
		
		select, input, textarea {
			font-size: 11pt;
		}
		
		.total .query_title {
			font-size: 13pt;
		}
		
		.bar {
			height: 18px;
			background: green;
		}
		
		.bar_ {
			height: 18px;
			background: green;
		}
		
		.top_box .t_box {
			float: left;
		}
		
		th {
			text-align: center;
		}
		
		.btn_ .preview {
			background: url(../../img/save.png) no-repeat;
		}
		
		#edui287_iframeholder {
			height: 190px;
		}
		
		#edui1_iframeholder {
			height: 190px;
		}
		
		input[type="button"], input[type="file"] {
			width: auto;
		}

		.navigation .left div {
			float: left;
		}
		.submit{
			margin-top: 21px;
			margin-left: 10px;
			background-image: url(../img/center_q.png);
		}
		.navigation .left {
			line-height: 82px;
		}
		.navigation .left .news {
			margin-top: -3px;
		}
		.enclosure div{
			display: block;
		}
		#qt{
			width: 99% !important;
		}
	</style>
	</head>
	
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    
	<body>
		<div id="newsPreview" style="display: none"></div>
		<div class="bx">
			<!--head开始-->
			<div class="head w clearfix">
				<ul class="index_head">
					<li data_id=""><span class="one headli1_1"><fmt:message code="news.th.newsmanage"/></span><img
							class="headli1_2" src="../img/twoth.png" alt=""/>
					</li>
					<li data_id="0"><span class="headli2_1"><fmt:message code="news.th.newbuild"/></span><img
							src="../img/twoth.png" alt="" class="headli2_2"/>
					</li>
					<li data_id="1"><span class="headli3"><fmt:message code="news.title.query"/></span></li>
				</ul>
			</div>
			<!--head通栏结束-->
			
			<!--navigation开始-->
			<div class="step1">
				<div class="navigation  clearfix">
					<div class="left">
						<img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinwenguanli.png">
						<div class="news">
							<fmt:message code="news.th.newsmanage"/>
						</div>
						<select name="TYPE" class="button1 nav_type" id="select">
							<%--    <option value="0" selected=""><fmt:message code="news.th.type"/></option>
								<option value="01"><fmt:message code="news.th.company"/></option>
								<option value="02"><fmt:message code="news.th.media"/></option>
								<option value="03"><fmt:message code="news.th.industry"/></option>
								<option value="04"><fmt:message code="news.th.partner"/></option>
								<option value="05"><fmt:message code="news.th.client"/></option>
								<option value="-1"><fmt:message code="news.th.none"/></option>--%>
						</select>
						<!-- 查询按钮 -->
						<!-- <div id="cx" class="submit">查询</div>	 -->
						<div id="cx" class="submit">
							<fmt:message code="global.lang.query"/>
						</div>
					</div>
				</div>
				<!--navigation结束-->
				
				<!--content部分开始-->
				<div>
					<div>
						<table id="tr_td" style="table-layout: fixed;">
							<thead>
								<tr>
									<td class="th" style="width: 8%;"><fmt:message code="global.lang.select"/></td>
									<td class="th" style="width: 10%;"><fmt:message code="notice.th.publisher"/></td>
									<td class="th" style="width: 8%;"><fmt:message code="notice.th.type"/></td>
									<td class="th" style="width: 17%;"><fmt:message code="notice.th.releasescope"/></td>
									<td class="th" style="width: 17%;"><fmt:message code="notice.th.title"/></td>
									<td class="th" style="width: 17%;"><fmt:message code="notice.th.PostedTime"/></td>
									<td class="th" style="width:10%;"><fmt:message code="news.th.clicknumber"/></td>
									<%--点击数--%>
									<%--<td class="th"><fmt:message code="news.th.commentnew"/></td>--%>
									<%--<td class="th" style="width: 7%;"><fmt:message code="notice.th.state"/></td>--%>
									<td class="th" style="width: 13%;"><fmt:message code="notice.th.postedType" /></td>
									<td class="th" style="width: 13%;"><fmt:message code="event.th.ApprovalStatus" /></td>
									<td class="th" style="width: 10%;"><fmt:message code="hr.th.Approver" /></td>
									<td class="th" style="width:20%;"><fmt:message code="notice.th.operation"/></td>
									<%--操作--%>
								</tr>
							</thead>
							<tbody id="j_tb">
							
							</tbody>
						</table>
					</div>
				</div>
				<!--content部分结束-->
			</div>
			
			<!-- 新建新闻页面 -->
			<div class="step2" style="display: none;margin-left: 10px;">
				<!-- 中间部分 -->
				<table class="newNews">
					<div class="nav_box clearfix">
						<div class="nav_t1"><img
								src="/img/commonTheme/${sessionScope.InterfaceModel}/xinwenxinjian.png"></div>
						<div class="nav_t2" class="news"><fmt:message code="news.th.newbuild"/></div>
						<%--<div class="nav_t3 sel format" id="query_format">--%>
						<%--&lt;%&ndash;<select name="" >&ndash;%&gt;--%>
						<%--<fmt:message code="notice.format.Commonformat"/>--%>
						<%--&lt;%&ndash;<div class="" ></div>&ndash;%&gt;--%>
						<%--&lt;%&ndash;</select>&ndash;%&gt;--%>
						<%--</div>--%>
					</div>
					<tbody>
					<tr>
						<td class="td_w">
							<!-- <div class="text1 blue_text">请选择新闻类型</div>
							<img class="text2" src="../img/mg1.png" alt=""/> -->
							<select name="" class="typeId" id="query_typeId">
								<%--   <option value="">&nbsp;<fmt:message code="news.th.selecttype"/></option>
								   <option value="01"><fmt:message code="news.th.company"/></option>
								   <option value="02"><fmt:message code="news.th.media"/></option>
								   <option value="03"><fmt:message code="news.th.industry"/></option>
								   <option value="04"><fmt:message code="news.th.partner"/></option>
								   <option value="05"><fmt:message code="news.th.client"/></option>--%>
							</select>
						</td>
						<td>
							<input class="td_title1" id="query_subject" type="text"
							       placeholder="<fmt:message code="new.th.putnew"/>"/>
							<img class="td_title2" src="../img/mg2.png" alt=""/>
						</td>
					</tr>

					<tr>
						<td class="blue_text" ><fmt:message code="new.th.titlePicture" />:</td>
						<td id="query_uploadArr_2"  style="position:relative;height: 40px!important;">
							<img style="left: 0;width:400px" class="img">
							<input type="file" name="file" id="uploadinputimg1"  style="position:absolute;z-index:10;background: red;
            width: 50px;
            left: 20px;opacity:0;
            top: 5px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0)"/>
							<a href="javascript:void(0)" class="chuan" style="position: absolute;
                        z-index: 1;
                        top: 20px;
                        color: #fff;
                        text-decoration: none;
                        left: 20px;
                        padding: 2px 10px;
                        border-radius: 4px;
                        background: cornflowerblue;"><fmt:message code="file.th.uploadPicture" /></a>

							<a href="javascript:void(0)" style="
                        z-index: 1;
                        bottom: 8px;
                        text-decoration: none;
                        left: 0px;
                        padding: 2px 10px;
                        border-radius: 4px;display:none"  class="yulan" typelook="1"><fmt:message code="global.lang.view" /></a>

							<a href="javascript:void(0)" style="
                        bottom: 36px;
                        text-decoration: none;
                        margin-left: 20px;
                        color:red;
                        padding: 2px 10px;
                        border-radius: 4px;display:none;" class="del delIndex"><fmt:message code="global.lang.delete" /></a>
							<input type="hidden" name="attachmentId2">
							<input type="hidden" name="attachmentName2">
						</td>
					</tr>
					<tr>
						<td class="blue_text"><fmt:message code="notice.th.IssuedByDepartment"/>：<br/></td>
						<%--隐藏按人员或角色发布--%>
						<td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="query_toId"
                              style="width: 70%;border-radius: 4px;" rows="4" dataid=""></textarea>
							<%--<input class="td_title1  release1"  id="query_toId" type="text"/>--%>
							<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
							<div class="release3" id="dept_add"><fmt:message code="global.lang.add"/></div>
							<div class="release4 empty" onclick="empty('query_toId')"><fmt:message
									code="global.lang.empty"/></div>
						
						</td>
					</tr>
					<tr id="role">
						<td class="blue_text"><fmt:message code="notice.th.role"/>：</td>
						<td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="query_privId"
                              style="width: 70%;border-radius: 4px;vertical-align: middle;" rows="4"
                              dataid=""></textarea>
							<%--<input class="td_title1  release1" id="query_privId" type="text"/>--%>
							<%--<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
							<div class="release3" id="priv_add"><fmt:message code="global.lang.add"/></div>
							<div class="release4 empty" onclick="empty1('query_privId')"><fmt:message
									code="global.lang.empty"/></div>
						</td>
					</tr>
					<tr id="man">
						<td class="blue_text"><fmt:message code="notice.th.somebody"/>：</td>
						<td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="query_userId"
                              style="width: 70%;border-radius: 4px;" rows="4" dataid=""></textarea>
							<%--<input class="td_title1  release1" id="query_userId" dataid="" type="text"/>--%>
							<%--<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
							<div class="release3" id="query_adduser"><fmt:message code="global.lang.add"/></div>
							<div class="release4 empty" onclick="empty2('query_userId')"><fmt:message
									code="global.lang.empty"/></div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.PostedTime"/>：
						</td>
						<td>
							<input class="td_title1 time_coumon" id="query_newTime" type="text"
							       placeholder="<fmt:message code="new.th.puttime"/>"/>
							<a href="javascript:;" id="step_release2">
								<div class="release3"><fmt:message code="notice.th.ResetToCurrentTime"/></div>
							</a>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="event.th.author" />:
						</td>
						<td>
							<input class="td_title1" id="author" type="text" placeholder="<fmt:message code="new.th.pleaseEnterTheAuthor" />"/>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="new.th.photography" />:
						</td>
						<td>
							<input class="td_title1" id="photographer" type="text" placeholder="<fmt:message code="new.th.pleaseEnterPhotography" />"/>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="news.th.comment"/>:
						</td>
						<td>
							<select name="" class="anonymityYn" id="query_anonymityYn">
								<option value="0"><fmt:message code="new.th.noanonymity"/></option>
								<option value="1"><fmt:message code="new.th.anonymous"/></option>
								<option value="2"><fmt:message code="new.th.prohibit"/></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.reminder"/>：
						</td>
						<td class="remind">
							<div><input class="news_t1 remindCheck" type="checkbox" checked="checked"/></div>
							<div class="news_t"><fmt:message code="notice.th.remindermessage"/></div>
							<%--&lt;%&ndash;<div><input class="news_t1" type="checkbox" checked/></div>&ndash;%&gt;--%>
							<%--&lt;%&ndash;<div class="news_t2"><fmt:message code="notice.th.share"/></div>&ndash;%&gt;--%>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.top"/>：
						</td>
						<td class="top_box">
							<div><input class="news_t1 " id="query_top" type="checkbox"/></div>
							<!-- <div><input type="checkbox" style="height:14px;width:14px;margin-top: 4px;"/></div> -->
							<!-- <div><img src="../img/mg4.png" alt=""/></div> -->
							<div class="news_t3"><fmt:message code="new.th.topMajor"/></div>
							<input class="t_box" id="add_topDate" type="text" value="0"/>
							<div class="news_t4"><fmt:message code="notice.th.endTop"/></div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.contentValidity"/>：
						</td>
						<td class="abstract">
							<div>
                        <textarea class="abstract1" name="summary" placeholder="<fmt:message code="new.th.putcontent"/>"
                                  id="ip4" cols="50" rows="2" maxlength="100"
                                  style="background: #fff;height: 100px"></textarea>
							</div>
							<div class="abstract2"><fmt:message code="notice.th.contentHigh"/></div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="news.th.toup"/>:
						</td>
						<td class="enclosure">
							<div id="query_uploadArr" style="display: block;">
							
							</div>
							<!--  <div class="enclosure_t"><a href="#">添加附件</a></div> -->
							<div style="float: left;">
								<form id="uploadimgform" style="float: left;margin: 0 20px 0 0;" target="uploadiframe"  action="../upload?module=news"  method="post" >
									<input type="file" multiple="multiple" name="file"  id="uploadinputimg"  class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
									<a href="#" id="uploadimg" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
								</form>
								<form id="uploadimgform2" style="float: left;margin: 0 20px 0 0;"   action=""  method="post" >
									<input webkitdirectory type="file" multiple="multiple" name="file"  id="Folder"  class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
									<a href="#" id=" upload" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message code="file.th.folderUpload" /></a>
								</form>
								<span id="fileTips" style="color: #b6b1b1"><fmt:message code="file.th.fileUploadDesc" /></span>
							</div>
							<div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
								<div class="bar" style="width: 0%;"></div>
							</div>
							<div class="barText" style="float: left;margin-left: 10px;"></div>
							<%--<div><img class="left_img" src="../img/mg12.png" alt=""/></div>--%>
							<%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.net"/></a></div>--%>
							<%--<div><img src="../img/mg13.png" alt=""/></div>--%>
							<%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.poto"/></a></div>--%>
							<%--<div><img src="../img/mg14.png" alt=""/></div>--%>
							<%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.up"/></a></div>--%>
						</td>
					</tr>
					<!--word编辑器-->
					<tr>
						<td colspan="2">
							<%--                    <div class="content" id="container" name="content" type="text/plain" style="width: 100%;"></div>--%>
							<div>
								<textarea id="newKindEditor" name="content" style="width:100%;height:300px;"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.keyWord"/>：
						</td>
						<td class="keyword">
							<input class="keyword_ip" id="query_keyword" type="text"
							       placeholder="<fmt:message code="notice.th.key"/>..."/>
							<%--<div class="keyword_t"><fmt:message code="notice.th.AutomaticKeywordAcquisition"/></div>--%>
							<div class="keyword_t2"><fmt:message code="notice.th.keyContent"/></div>
					
					</tr>
					</tbody>
				</table>
				<div class="foot_mg">
					<!--<img  id="hd" type="publish" class="fot_1 btn_ok" src="../img/mg5.png" alt=""/>
					 <img  id="rs" type="save" class="btn_ok"  src="../img/mg6.png" alt=""/>  -->
					<div class="btn_">
						<div id="hd" type="publish" class="fot_1 btn_ok"
						     style="width: 80px;color:#666666;background: url(../../img/publish.png) no-repeat;">
							<fmt:message
									code="global.lang.publish"/></div>
						<div id="rs" type="save" class="btn_style btn_ok" style="width: 80px;color:#666666;">
							<fmt:message
									code="global.lang.save"/></div>
						<div id="preview" class="preview" style="width: 80px;color:#666666;"><fmt:message code="global.lang.view" /></div>
					</div>
				</div>
			</div>
			
			<!-- 修改新闻页面 -->
			<div class="step3" style="display:none ;margin-left: 10px;">
				<!-- 中间部分 -->
				<table class="newNews">
					<div class="nav_box clearfix">
						<div class="nav_t1"><img
								src="/img/commonTheme/${sessionScope.InterfaceModel}/xinwenxinjian.png"></div>
						<div class="nav_t2" class="news"><fmt:message code="news.title.new"/></div>
						<div class="nav_t3 sel format" id="format_">
							<fmt:message code="notice.format.Commonformat"/>
						</div>
					</div>
					<tbody>
					<tr>
						<td class="td_w">
							<!-- <div class="text1 blue_text">请选择新闻类型</div>
							<img class="text2" src="../img/mg1.png" alt=""/> -->
							<select name="" id="step3_type" class="">
								<%-- <option value="">&nbsp;<fmt:message code="news.th.selecttype"/></option>
								 <option value="01"><fmt:message code="news.th.company"/></option>
								 <option value="02"><fmt:message code="news.th.media"/></option>
								 <option value="03"><fmt:message code="news.th.industry"/></option>
								 <option value="04"><fmt:message code="news.th.partner"/></option>
								 <option value="05"><fmt:message code="news.th.client"/></option>--%>
							</select>
						</td>
						<td>
							<input class="td_title1 subject" id="step3_ip1" type="text"
							       placeholder='<fmt:message code="new.th.putnew"/>'/><%--请输入新闻标题...--%>
							<img class="td_title2" src="../img/mg2.png" alt=""/>
						</td>
					</tr>
					<tr>
						<td class="blue_text"><fmt:message code="new.th.titlePicture" />:</td>
						<td id="query_uploadArr_1" style="position:relative;height: 40px!important;">
							<img style="left: 0;width:400px" class="img1">
							<input type="file" name="file" id="uploadinputimg2"  style="position:absolute;z-index:10;background: red;width: 50px;left: 20px;opacity:0;top: 5px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0)"/>
							<a href="javascript:void(0)" class="chuan1" style="position: absolute;z-index: 1; top: 20px; color: #fff;text-decoration: none;left: 20px; padding: 2px 10px; border-radius: 4px;background: cornflowerblue;"><fmt:message code="file.th.uploadPicture" /></a>
							<a href="javascript:void(0)" style="z-index: 1;bottom: 8px;text-decoration: none;line-height:20px;left: 0px; padding: 2px 10px;border-radius: 4px;display:none;"  class="yulan1" typelook="2"><fmt:message code="global.lang.view" /></a>
							<a href="javascript:void(0)" style=" bottom: 36px;text-decoration: none;margin-left: 20px;color:red;padding: 2px 10px;border-radius: 4px;display:none;" class="del1 delIndex1"><fmt:message code="global.lang.delete" /></a>
							<input type="hidden" name="attachmentId3">
							<input type="hidden" name="attachmentName3">
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<%--<fmt:message code="notice.th.IssuedByDepartment"/>：<br/><a href="javaScript:;" style="color: #207bd6;font-size: 14px;font-weight: normal;" id="personnel_" onclick="showAndHidden('personnel_','role_','man_')"><fmt:message code="notice.th.Hidden"/> </a>&lt;%&ndash;隐藏按人员或角色发布&ndash;%&gt;--%>
							<fmt:message code="notice.th.IssuedByDepartment"/>：<br/><%--隐藏按人员或角色发布--%>
						</td>
						<td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="step3_ip2" dataid="" resize="auto"
                              style="width:70%;border-radius: 4px;" rows="5"></textarea>
							<%--<input class="td_title1  release1 toId" type="text"id="step3_ip2"/>--%>
							<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
							<div class="release3" id="dept_add_"><fmt:message code="global.lang.add"/></div>
							<div class="release4 empty" onclick="empty('step3_ip2')"><fmt:message
									code="global.lang.empty"/></div>
						
						</td>
					</tr>
					<tr id="role_">
						<td class="blue_text">
							<fmt:message code="notice.th.role"/>：
						</td>
						<td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="privId_" dataid="" resize="auto"
                              style="width:70%;border-radius: 4px;" rows="5"></textarea>
							<%--<input class="td_title1  release1 toId" type="text"id="privId_"/>--%>
							<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
							<div class="release3" id="priv_add_"><fmt:message code="global.lang.add"/></div>
							<div class="release4 empty" onclick="empty1('privId_')"><fmt:message
									code="global.lang.empty"/></div>
						</td>
					</tr>
					<tr id="man_">
						<td class="blue_text">
							<fmt:message code="notice.th.somebody"/>：
						</td>
						<td>
                    <textarea readonly="readonly" class=" td_title1  release1" id="userId_" dataid="" resize="auto"
                              style="width:70%;border-radius: 4px;" rows="5"></textarea>
							<%--<input class="td_title1  release1 toId" type="text"id="userId_"/>--%>
							<img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>
							<div class="release3" id="adduser_"><fmt:message code="global.lang.add"/></div>
							<div class="release4 empty" onclick="empty2('userId_')"><fmt:message
									code="global.lang.empty"/></div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.PostedTime"/>：
						</td>
						<td>
							<input class="td_title1 newTime" id="step3_ip3" class="step3_te" type="text"
							       placeholder='<fmt:message code="new.th.puttime"/>'/><%--请输入发布时间...--%>
							<a href="javascript:;" id="step_release3">
								<div class="release3"><fmt:message code="news.th.SetToTheCurrentTime"/></div>
							</a><%--设置为当前时间--%>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="event.th.author" />:
						</td>
						<td>
							<input class="td_title1" id="author2" type="text" placeholder="<fmt:message code="new.th.pleaseEnterTheAuthor" />"/>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="new.th.photography" />:
						</td>
						<td>
							<input class="td_title1" id="photographer2" type="text" placeholder="<fmt:message code="new.th.pleaseEnterPhotography" />"/>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="news.th.comment"/>:
						</td>
						<td>
							<select name="step3_anonymityYn" class="" id="anonymityYn_">
								<option value="0"><fmt:message code="new.th.noanonymity"/></option>
								<option value="1"><fmt:message code="new.th.anonymous"/></option>
								<option value="2"><fmt:message code="new.th.prohibit"/></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.reminder"/>：
						</td>
						<td class="remind">
							<div><input class="news_t1 remindCheck1" type="checkbox" checked="checked"/></div>
							<div class="news_t"><fmt:message code="notice.th.remindermessage"/></div>
							<%--&lt;%&ndash;<div><input class="news_t1" type="checkbox" checked/></div>&ndash;%&gt;--%>
							<%--&lt;%&ndash;<div class="news_t2"><fmt:message code="notice.th.share"/></div>&ndash;%&gt;--%>
						</td>
					</tr>
					<%--<tr>--%>
					<%--<td class="blue_text">--%>
					<%--<fmt:message code="notice.th.reminder"/>：--%>
					<%--</td>--%>
					<%--<td class="remind">--%>
					<%--<div><input class="news_t1"  type="checkbox" checked/></div>--%>
					<%--<!--  <div><img src="../img/mg3.png" alt=""/></div> -->--%>
					<%--<div class="news_t"><fmt:message code="notice.th.remindermessage"/></div>--%>
					<%--&lt;%&ndash;<div><input class="news_t1" type="checkbox" checked/></div>&ndash;%&gt;--%>
					<%--&lt;%&ndash;<div class="news_t2"><fmt:message code="notice.th.share"/></div>&ndash;%&gt;--%>
					<%--</td>--%>
					<%--</tr>--%>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.top"/>：
						</td>
						<td class="top_box">
							<div><input class="news_t1" id="top_" type="checkbox"/></div>
							<div class="news_t3"><fmt:message code="new.th.topMajor"/></div>
							<input class="t_box topDays" id="topDays" type="text" placeholder="0"/>
							<div class="news_t4"><fmt:message code="notice.th.endTop"/></div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.contentValidity"/>：
						</td>
						<td class="abstract">
							<div>
                        <textarea class="abstract1 Content" name="summary"
                                  placeholder='<fmt:message code="new.th.putcontent"/>' id="step3_ip4" cols="50"
                                  rows="2" maxlength="100" style="background: #fff; height: 100px"></textarea>
							</div>
							<div class="abstract2"><fmt:message code="notice.th.contentHigh"/></div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="global.th.fileup"/>：
						</td>
						<td class="enclosure">
							<div id="query_uploadArr_" style="display:block;">
							</div>
							<div style="float: left;"><img src="../img/mg11.png" alt=""/></div>
							<!--  <div class="enclosure_t"><a href="#">添加附件</a></div> -->
							<div style="cursor: pointer;float: left;">
								<form id="uploadimgform_" target="uploadiframe" action="../upload?module=news"
								      enctype="multipart/form-data" method="post">
									<input type="file" multiple="multiple" name="file" id="uploadinputimg_"
									       class="w-icon5"
									       style="position: absolute;opacity: 0;width: 70px;
filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
									<a id="uploadimg_"><fmt:message code="notice.th.addfile"/></a>
								</form>
							</div>
							<div id="progress_" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
								<div class="bar_" style="width: 0%;"></div>
							</div>
							<div class="barText_" style="float: left;margin-left: 10px;"></div>
							<%--<div><img src="../img/mg12.png" alt=""/></div>--%>
							<%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.net"/></a></div>--%>
							<%--<div><img src="../img/mg13.png" alt=""/></div>--%>
							<%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.poto"/></a></div>--%>
							<%--<div><img src="../img/mg14.png" alt=""/></div>--%>
							<%--<div class="enclosure_t"><a href="#"><fmt:message code="notice.th.up"/></a></div>--%>
						</td>
					</tr>
					<!--word编辑器-->
					<tr>
						<td colspan="2">
							<div id="container3" name="content" type="text/plain" style="width: 100%;"></div>
							<div>
								<textarea id="editKindEditor" name="content"
								          style="width:100%;height:300px;"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td class="blue_text">
							<fmt:message code="notice.th.keyWord"/>：
						</td>
						<td class="keyword">
							<input class="keyword_ip step3_5 Keyword" id="ip5" type="text"
							       placeholder='<fmt:message code="news.th.PleaseEnterAKeyword"/>'/><%--请输入关键词...--%>
							<%--<div class="keyword_t"><fmt:message code="notice.th.AutomaticKeywordAcquisition"/></div>--%>
							
							<div class="keyword_t2"><fmt:message code="notice.th.keyContent"/></div>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="foot_mg">
					<!-- <img  id="hd" class="fot_1 submit_ok" src="../img/mg5.png" alt=""/> 发布
					<img  id="step3_rs" class="submit_ok"   src="../img/mg6.png" alt=""/> 保存 -->
					<div class="btn_">
						<div id="shenPi" data-type="1" type_="publish" class="fot_1 submit_ok"
						     style="width:80px;color:#666666; background: url(../img/publish.png) no-repeat;">
							<fmt:message
									code="global.lang.publish"/></div>
						<div id="rs" data-type="0" type_="save" class="btn_style submit_ok"
						     style="width:80px;color:#666666;">
							<fmt:message code="global.lang.save"/></div>
						<div id="goBack" style="width:80px;color:#666666;"><fmt:message code="notice.th.return"/></div>
						<div id="editPreview" class="preview" style="width:80px;color:#666666;"><fmt:message code="global.lang.view" /></div>
						<input id="hidden_id" type='hidden' value="">
					</div>
				</div>
			</div>
			<!--content部分结束-->
			
			<!-- 新闻查询 -->
			<div class="center" id="qt">
				<!--content部分开始-->
				<!-- 新闻nav部分 -->
				<div class="nav_box clearfix">
					<div class="nav_t1"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/xinwenQuery.png">
					</div>
					<div class="nav_t2" class="news"><fmt:message code="news.title.query"/></div>
				</div>
				<form id="queryNews">
					<table class="clearfix total">
						<tbody>
						<tr>
							<td colspan="2" class="query_title">
								<fmt:message code="global.lang.inputquerycondition"/>
							</td>
						</tr>
						
						<tr>
							<td class="td_w size_color">
								<fmt:message code="notice.th.format"/>：
							</td>
							<td>
								<select name="" class="format" id="format" style="width: 122px;">
									<option value="0"><fmt:message code="notice.format.Commonformat"/></option>
								
								</select>
							</td>
						</tr>
						<tr>
							<td class="blue_text size_color">
								<fmt:message code="notice.th.type"/>：
							</td>
							<td>
								<select name="" class="typeId" id="type_id" style="width:122px;">
								</select>
							</td>
						</tr>
						<tr>
							<td class="blue_text size_color">
								<fmt:message code="notice.th.state"/>：
							</td>
							<td>
								<select name="" class="publish" style="width:122px;">
									<option value="" selected=""><fmt:message code="notice.th.all"/></option>
									<option value="0"><fmt:message code="notice.th.unposted"/></option>
									<option value="1"><fmt:message code="notice.th.posted"/></option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="blue_text size_color">
								<fmt:message code="notice.th.ifTop"/>:
							</td>
							<td>
								<select name="" class="top" style="width:122px;">
									<option value="" selected=""><fmt:message code="notice.th.all"/></option>
									<option value="0"><fmt:message code="notice.th.untoped"/></option>
									<option value="1"><fmt:message code="notice.th.toped"/></option>
								</select>
							
							</td>
						</tr>
						<tr>
							<td class="blue_text size_color">
								<fmt:message code="new.th.whetherToApprove" />
							</td>
							<td>
								<select name="" class="auditerStatus" style="width:122px;">
									<option value="" selected=""><fmt:message code="notice.th.all"/></option>
									<option value="0"><fmt:message code="meet.th.PendingApproval" /></option>
									<option value="1"><fmt:message code="meet.th.Approval" /></option>
									<option value="2"><fmt:message code="meet.th.NotApprove" /></option>
								</select>
							
							</td>
						</tr>
						<tr>
							<td class="size_color">
								<fmt:message code="notice.th.title"/>:
							</td>
							<td>
								<input class="title_" id="subject" type="text"/>
							</td>
						</tr>
						<tr class="release">
							<td class="size_color">
								<fmt:message code="notice.title.Releasedate"/>:
							</td>
							<td>
								<input id="beginTime" class="date" type="text" style="float:left;"/>
								<div class="c_t"><fmt:message code="global.lang.to"/></div>
								<input id="endTime" class="date" type="text"/>
							
							</td>
						</tr>
						<tr>
							<td class="size_color"><fmt:message code="notice.th.content"/>:</td>
							<td>
								<input class="content_" id="content_" type="text"/>
							</td>
						</tr>
						<tr class="clack_t">
							<td class="size_color"><fmt:message code="news.th.clicks"/>:</td>
							<td>
								<input class="c_time c_time1" type="text" style="float: left"/>
								<div class="c_t"><fmt:message code="global.lang.to"/></div>
								<input class="c_time c_time2" type="text"/>
							</td>
						</tr>
						<tr class="operation">
							<td class="size_color"><fmt:message code="notice.th.operation"/>:</td>
							<td>
								<div><input type="radio" name="radio" value="1" checked></div>
								<div class="operation1"><fmt:message code="global.lang.query"/></div>
								<div><input type="radio" name="radio" value="2"></div>
								<div class="operation1"><fmt:message code="global.lang.delete"/></div>
								<!--  <input type="radio" name="radio"></input>
								<input type="radio" name="radio">删除</input> -->
							</td>
						</tr>
						<tr class="table_b">
							<td colspan="2">
								<div class="bt determine"><fmt:message code="global.lang.ok"/></div>
								<div class="exportNew" id="export"><fmt:message code="global.lang.report"/></div>
								<%--导出--%>
								<div onclick="Refillings('queryNews')"><fmt:message
										code="global.lang.refillings"/></div>
							</td>
						</tr>
						
						</tbody>
					</table>
				</form>
			</div>
			<div class="right">
				<!-- 分页按钮-->
				<div class="M-box3">
				</div>
			</div>
			<!--content部分结束-->
		</div>
		
		<script>
			var titlePicId = '';
			var titlePicName = '';

			$('.yulan').hide()
			$('.headli1_1').on('click',function(){
				$('.M-box3').show();
			})
			$('.yulan1').hide()
			$('.headli1_1').on('click',function(){
				$('.M-box3').show();
			})
			$('.headli3').on('click',function(){
				$('.M-box3').hide();
			})
			$('.headli2_1').on('click',function(){
				$('.M-box3').hide();
			})
			// $('#uploadimgform').click(function(){
			// 	alert('只允许上传为\'png\',\'jpg\'类型的图片！')
			// })
            //如果新闻需要审核，则不直接显示生效按钮
            var isEffect = false;
            // 审核新闻的类型(0为普通审核，1为流程审核)
            var checkNewsTypeObj = null;
            $.ajax({
                type: 'get',
                url: '/news/openNews',
                async: false,
                dataType: 'json',
                success: function (res) {
                    if (res.code == '1') {
                        isEffect = true;

                        $.get('/syspara/selectTheSysPara?paraName=NEWS_APPROVAL_TYPE', function (res) {
                            if (res.flag) {
                                var data = res.object[0];
                                checkNewsTypeObj = JSON.parse(data.paraValue);
                            }
                        });
                    }
                }
            })
            user_id = 'query_userId';//选人控件
            user_id = 'privId_';
            user_id = 'step3_ip2';
            pareValue = 0
            /* 新建页面附件添加 */
            $(function () {
                // 查询提醒权限
                $.ajax({
                    type: 'get',
                    url: '/smsRemind/getRemindFlag',
                    dataType: 'json',
                    data: {
                        type: 14
                    },
                    success: function (res) {
                        if (res.flag) {
                            if (res.obj.length > 0) {
                                var data = res.obj[0];
                                // 是否默认发送
                                if (data.isRemind == '0') {
                                    $('.remindCheck').prop("checked", false);
                                } else if (data.isRemind == '1') {
                                    $('.remindCheck').prop("checked", true);
                                }
                                // 是否手机短信默认提醒
                                /*if(data.isIphone=='0'){
								 $('input[name="smsRemind"]').prop("checked", false);
								 } else if (data.isIphone=='1'){
								 $('input[name="smsRemind"]').prop("checked", true);
								 }*/
                                // 是否允许发送事务提醒
                                if (data.isCan == '0') {
                                    $('.remindCheck').prop("checked", false);
                                    $('.remind').parent('tr').hide();
                                }

                            }
                        }
                    }
                })

                $.ajax({
                    type: 'get',
                    url: '/syspara/queryOrgScope',
                    dataType: 'json',
                    success: function (reg) {
                        var item = reg.object;
                        if (item.paraValue == 1 && $.cookie('userId') != 'admin') {
                            pareValue = 1
                            $('#personnel').text('<fmt:message code="notice.th.somebody" />')
                            // $('#role').hide()
                        } else {
                            $('#personnel').text('<fmt:message code="notice.th.PostedByPersonnelOrRoles" />')
                            pareValue = 0
                            // $('#role').show()
                        }
                    }
                })

                //页面加载时发送ajax获取下拉框数据
                var str = "<option value=\"0\" selected=\"\"><fmt:message code="news.th.type"/></option>";
                var str2 = "<option value=\"0\" selected=\"\"><fmt:message code="news.th.selecttype"/></option>";
                $.ajax({
                    url: "/code/GetDropDownBox",
                    type: 'get',
                    dataType: "JSON",
                    data: {"CodeNos": "NEWS"},
                    success: function (data) {
                        for (var proId in data) {
                            for (var i = 0; i < data[proId].length; i++) {
                                str += '<option value="' + data[proId][i].codeNo + '">' + data[proId][i].codeName + '</option>'
                                str2 += '<option value="' + data[proId][i].codeNo + '">' + data[proId][i].codeName + '</option>'
                            }
                        }
                        $('#select').append(str);
                        $('#query_typeId').append(str2);
                        $('#step3_type').append(str2);
                        $('#type_id').append(str);
                    }

                })

                fileuploadFn('#uploadinputimg', $('#query_uploadArr'));
                fileuploadFn('#uploadinputimg_', $('#query_uploadArr_'));
				fileuploadFn('#Folder', $('#query_uploadArr'));
				//解决拖拽上传执行多次接口，文件夹上传方法如果被点击后执行
				$("#uploadimgform2").on('click',function (){
					$("#uploadimgform2").attr("action","../upload?module=news")
				})

                $('#query_uploadArr').on('click', '.deImgs', function () {
                    var data = $(this).parents('.dech').attr('deUrl');
                    var dome = $(this).parents('.dech');
//                            alert(data);
//                            alert(dome);
                    deleteChatment(data, dome);
                });

				$('#query_uploadArr_2').on('click', '.delIndex', function () {
					var data = $('#query_uploadArr_2').attr('deurl');
					var dome = $(this).parents('.dech');
//                            alert(data);
//                            alert(dome);
					deleteChatment1(data, dome);
				});
				$('#query_uploadArr_1').on('click', '.delIndex1', function () {
					var data = $('#query_uploadArr_1').attr('deurl');
					var dome = $(this).parents('.dech');
					deleteChatment1(data, dome);
				});

<%--                $('#uploadinputimg_').fileupload({--%>
<%--                    dataType: 'json',--%>
<%--                    progressall: function (e, data) {--%>
<%--						var progress = parseInt(data.loaded / data.total * 95, 10);--%>
<%--						$('#progress .bar').css(--%>
<%--								'width',--%>
<%--								progress + '%'--%>
<%--						);--%>
<%--						$('.barText').html(progress + '%');--%>
<%--//                         if (progress >= 100) {--%>
<%--//                             timer = setTimeout(function () {--%>
<%--//                                 $('#progress_ .bar_').css(--%>
<%--//                                     'width',--%>
<%--//                                     0 + '%'--%>
<%--//                                 );--%>
<%--//                                 $('.barText_').html('');--%>
<%--// //                            $('#progress').hide();--%>
<%--// //                            $('.barText').hide();--%>
<%--//                             }, 2000);--%>
<%--//--%>
<%--//                         }--%>
<%--                    },--%>
<%--                    done: function (e, data) {--%>
<%--                        if (data.result.obj != '') {--%>
<%--                            var data = data.result.obj;--%>
<%--                            var str = '';--%>
<%--                            var str1 = '';--%>
<%--                            for (var i = 0; i < data.length; i++) {--%>
<%--                                var gs = data[i].attachName.split('.')[1];--%>
<%--                                if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') {--%>
<%--                                    str += '';--%>
<%--                                    layer.alert('<fmt:message code="dem.th.uploading" />!', {}, function () {--%>
<%--                                        layer.closeAll();--%>
<%--                                    });--%>
<%--                                } else {--%>
<%--                                    str += '<div class="dech" deUrl="' + encodeURI(data[i].attUrl) + '" style="display:block;"><a class="ATTACH_a" style="color: #000;" NAME="' + data[i].attachName + '*" href="javaecript:;">' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="' + data[i].attachName + '*"  class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';--%>
<%--                                }--%>
<%--                            }--%>
<%--                            // $('#query_uploadArr_').append(str);--%>
<%--							if(datas.result.msg == "OK"){--%>
<%--								$('#progress .bar').css('width', 100 + '%');--%>
<%--								$('.barText').html('100%');--%>
<%--							}--%>
<%--							element.append(str);--%>

<%--							if($('#progress .bar').css('width')  == '100%' ||  $('.barText').html() != '' ){--%>
<%--								timer=setTimeout(function () {--%>
<%--									$('#progress .bar').css('width', 0 + '%');--%>
<%--									$('.barText').html('');--%>
<%--								},1000);--%>
<%--							}--%>
<%--                        } else {--%>
<%--                            //alert('添加附件大小不能为空!');--%>
<%--                            layer.alert('<fmt:message code="dem.th.AddEmpty" />!', {}, function () {--%>
<%--                                layer.closeAll();--%>
<%--                            });--%>
<%--                        }--%>
<%--                    }--%>
<%--                });--%>
                $('#query_uploadArr_').on('click', '.deImgs', function () {
                    var data = $(this).parents('.dech').attr('deUrl');
                    var dome = $(this).parents('.dech');
//                            alert(data);
//                            alert(dome);
                    deleteChatment(data, dome);
                });


                /* word文本编辑器 */
                // var ue = UE.getEditor('container', {elementPathEnabled: false});//新建新闻页面
                // var sue = UE.getEditor('container3', {elementPathEnabled: false});//修改新闻页面
                // UEimgfuc();
                var data = {
                    read: $('.index_head .one').parent().attr('data_id'),
                    typeId: $('#select').val() == 0 ? '' : $('#select').val(),
                    nTime: $('#sendTime').val(),
                    page: 1,
                    pageSize: 5,
                    useFlag: true,
                    newsTime: '',
                    lastEditTime: '',
                    content: '',
                    subject: '',
                    format: '',
                    publish: '',
                    top: '',
                    clickCount: '',
                    click: '',
                    typeId: 0,
                    exportId: '1',
                    changeId: '1',
					titlePicId: $('input[name="attachmentId2"]').val(),
					titlePicName: $('input[name="attachmentName2"]').val(),


                };

                function clearData() {
                    data.read = '';
                    data.typeId = '';
                    data.nTime = '';
                    data.newsTime = '';
                    data.lastEditTime = '';
                    data.content = '';
                    data.subject = '';
                    data.format = '';
                    data.publish = '';
                    data.top = '';
                    data.clickCount = '';
                    data.click = '';
                    data.typeId = 0;
                    data.exportId = '';
                    changeId:'';
					titlePicId: $('input[name="attachmentId2"]').val();
					titlePicName: $('input[name="attachmentName2"]').val();
                }

                initPageList(function (pageCount) {
                    initPagination(pageCount, data.pageSize);
                });
                $(".index_head li").on('click',function () {
                    clearData()
                    $(this).find('span').addClass('one').parent().siblings('').find('span').removeClass('one');  // 删除其他兄弟元素的样式
                    // $(".news").html($(this).find('span').text());
                    data.read = $(this).attr('data_id');
                    data.typeId = $('#select').val() == 0 ? '' : $('#select').val();
                    data.nTime = $('#sendTime').val();
                    if (data.read == '') {
                        data.exportId = '1';
                        $('.step1').show();
                        $('.step2').hide();
                        $('.center').hide();
                        $('.step3').hide();
                        initPageList();
                    } else if (data.read == 1) {
                        $('.step1').hide();
                        $('.step2').hide();
                        $('.step3').hide();
                        $('.center').show();
                        $('#subject').val('');
                        $('#beginTime').val('');
                        $('#endTime').val('');
                        $('#select').val() == 0 ? '' : $('#select').val();
                        $('#content').val('');
                    }
                    //新建新闻
                    else if (data.read == 0) {
                        $.ajax({
                            type: 'get',
                            url: '/news/openNews',
                            dataType: 'json',
                            success: function (res) {
                                if (res.code == '1') {
                                    $('#hd').html('<fmt:message code="adding.th.Submit" />')
                                }
                            }
                        })

                        $.get('/ShowDownLoadQrCode', function (res) {
                            if (res.flag && res.object == 1) {
                                $('#query_toId').val('<fmt:message code="new.th.allDepartments" />').attr('deptid', "ALL_DEPT")
                            }
                        })

                        $("#query_newTime").val('');
                        $('.step1').hide();
                        $('.step2').show();
                        $('.step3').hide();
                        $('.center').hide();
                        queryTime();
                        $('#query_newTime').val(now);
                    }
                });

                function initPageList(cb) {
                    var usersName = $.cookie('userId');
                    $.ajax({
                        type: "get",
                        url: "/news/newsShow",
                        dataType: 'JSON',
                        data: data,
                        success: function (data) {
                            var news = "";
                            for (var i = 0; i < data.obj.length; i++) {
                                var toTypeName = ""
                                var deprange = "";
                                var rolerange = "";
                                var userrange = "";

                                if (data.obj[i].deprange) {
                                    deprange = data.obj[i].deprange;
                                }
                                if (data.obj[i].rolerange) {
                                    rolerange = data.obj[i].rolerange;
                                }
                                if (data.obj[i].userrange) {
                                    userrange = data.obj[i].userrange;
                                }
                                toTypeName = '<fmt:message code="userManagement.th.department" />：' + deprange + '-<fmt:message code="journal.th.user" />：' + userrange + '-<fmt:message code="userManagement.th.role" />:' + rolerange;
                                var alltype = deprange + userrange + rolerange;

                                var typeName = ""
                                if (data.obj[i].typeName == -1) {
                                    typeName = "";
                                } else {
                                    typeName = data.obj[i].typeName;
                                }

                                var comment = "";
                                if (data.obj[i].anonymityYn == 2) {
                                    comment = ""
                                } else {
                                    comment = '<fmt:message code="new.th.ManageComments" />'
                                    <%--管理评论--%>
                                }

                                news += "<tr class='trs' id='news_tr' rid='" + data.obj[i].newsId + "'><input class='input_hide' type='hidden' newsID='" + data.obj[i].newsId + "'>" +
                                    "<td>" + function () {
                                        if (data.obj1 != '1' && data.obj[i].auditerStatus == '1') {
                                            return ''
                                        } else if (data.obj[i].auditerStatus == '3') {
                                            return ''
                                        } else {
                                            return "<input class='checkChild' type='checkbox' conid=" + data.obj[i].newsId + " name='check' value=''>"
                                        }
                                    }() + "</td>" +//选择
                                    "<td class='name' nid='" + data.obj[i].newsId + "'>" + data.obj[i].providerName + "</td>" +//发布人
                                    "<td class='type' nid='" + data.obj[i].newsId + "'>" + typeName + "</td>" +//类型
                                    "<td class='cli' name='" + data.obj[i].depName + "'><div id='break" + data.obj[i].newsId + "' class='break_td  publishtip'  toTypeName=" + toTypeName + ">" + alltype + "</div></td>" +//发布范围
                                    "<td time='" + data.obj[i].subject + "'><a  style='color:#59b7fb'  href='#' newsId=" + data.obj[i].newsId + " class='windowOpen'><div id='subject" + data.obj[i].newsId + "' class='title' title='" + data.obj[i].subject + "'>";
                                if (data.obj[i].top == 1) {
                                    news += '<img src="/img/news/top.png" alt="" style="margin-right: 5px;vertical-align: middle;">'
                                }
                                news += data.obj[i].subject + "</div></a></td>" +//标题
                                    "<td  class='tim'>" + data.obj[i].newsDateTime + "</td>" +//发布时间
                                    "<td class='data'>" + data.obj[i].clickCount + "</td>" +//点击数
                                    //"<td class='num'>"+data.obj[i].newsId+"</td>"+//评论（条）
                                    "<td class='state' id=publish" + data.obj[i].newsId + ">" + function () {
                                        if (data.obj[i].publish == 0) {
                                            return '<fmt:message code="notice.th.unposted" />'
                                        } else if (data.obj[i].publish == 1) {
                                            return '<fmt:message code="notice.th.posted" />'
                                        } else if (data.obj[i].publish == 2) {
                                            return '<fmt:message code="notice.th.hasEnd" />'
                                        } else {
                                            return ''
                                        }
                                    }() + "</td>" +//发布状态
                                    "<td class='state' >" + function () {
                                        if (data.obj[i].auditerStatus == 0) {
                                            return '<fmt:message code="meet.th.PendingApproval" />'
                                        } else if (data.obj[i].auditerStatus == 1) {
                                            return '<fmt:message code="meet.th.Ratified" />'
                                        } else if (data.obj[i].auditerStatus == 2) {
                                            return '<fmt:message code="meet.th.NotApprove" />'
                                        } else if (data.obj[i].auditerStatus == 3) {
                                            return '<fmt:message code="new.th.processApproval" />'
                                        } else {
                                            return ''
                                        }
                                    }() + "</td>" +//批准状态
                                    "<td class='state'>" + function () {
                                        if (data.obj[i].auditerName) {
                                            return data.obj[i].auditerName
                                        } else {
                                            return ''
                                        }
                                    }() + "</td>" +//审批人
                                    "<td>" + function () {
                                        if (data.obj1 != '1' && data.obj[i].auditerStatus == '1') {
                                            return ''
                                        }
                                        //如果已生效，则不显示编辑
                                        else if (data.obj[i].publish == 1) {
                                            return ''
                                        } else if (data.obj[i].auditerStatus == '3') { // 如果是流程审批，不显示编辑
                                            return ''
                                        } else {
                                            return "<a  href='javascript:;' id='xg' tid='" + data.obj[i].newsId + "' style='color:#1772C0'>" + "<fmt:message code='depatement.th.modify' />" + "</a>&nbsp"
                                            <%--修改--%>
                                        }
                                    }() +

                                    "<a  href='javascript:;' style='color:#1772C0' class='windowOpen_comment' newsId=" + data.obj[i].newsId + " comment_number=" + data.obj[i].anonymityYn + ">" + comment + "</a>&nbsp;"
                                    + function () {
                                        if (data.obj[i].publish == 1) {
                                            return "<a  href='javascript:;' id=stop" + data.obj[i].newsId + " style='color:#1772C0' onclick='stop(" + data.obj[i].newsId + ",publish" + data.obj[i].newsId + ",stop" + data.obj[i].newsId + ")'><fmt:message code='notice.state.end' /></a>&nbsp;"
                                        } else {
                                            if (!isEffect) {
                                                return "<a  href='javascript:;' id=stop" + data.obj[i].newsId + " style='color:#1772C0' onclick='stop(" + data.obj[i].newsId + ",publish" + data.obj[i].newsId + ",stop" + data.obj[i].newsId + ")'><fmt:message code='notice.state.effective' /></a>&nbsp;"
                                            } else {
                                                return ''
                                            }
                                        }
                                    }() + function () {
                                        if (data.obj1 != '1' && data.obj[i].auditerStatus == '1') {
                                            return ''
                                        } else if (data.obj[i].auditerStatus == '3') {
                                            return ''
                                        } else {
                                            return "<a href='javascript:;' id='deleteData'  tid='" + data.obj[i].newsId + "' style='color:#E01919'>" + "<fmt:message code='global.lang.delete' />" + "</a>&nbsp"
                                            <%--删除--%>
                                        }
                                    }() +
                                    "</td></tr>"//操作
                            }
                            var last_str = '';
                            last_str += "<tr class='last_str'>" +
                                "<td  colspan='11' class='function'>" +
                                "<div><input id='checkedAll' class='checkChild' type='checkbox' conid='29' name='check' value=''><fmt:message code="notice.th.allchose" /></div>" + <%--全选--%>
                                "<div class='delete_check'><fmt:message code="news.th.deletenews" /></div>" + <%--删除所选新闻--%>
                                "<div class='find_detail' style='width: 66px;padding-left:35px;'><fmt:message code="news.th.querysituation" /></div>" + <%--查阅情况--%>
                                "<div class='news_notop'><fmt:message code="news.th.quittop" /></div>" + <%--取消置顶--%>
                                "<div class='news_top'><fmt:message code="notice.th.top" /></div>";
                            <%--置顶--%>
                            /*if(usersName =='admin'){
							 last_str+="<div class='delete_all' style='padding-left:36px;'>

                            <fmt:message code="news.th.deleteall" /></div>";
                    
                            <%--删除全部新闻--%>
                     }*/
                            last_str += "<div class='news_stop'><fmt:message code="news.th.end" /></div>" + <%--终止所选新闻--%>
                                function () {
                                    if (!isEffect) {
                                        return "<div class='news_inOperation'><fmt:message code="news.th.effective" /></div>"
                                    } else {
                                        return ''
                                    }
                                }() + <%--生效所选新闻--%>
                                "</td>" +
                                "</tr>";
                            $("#j_tb").html(news + last_str);
                            if (cb) {
                                cb(data.totleNum);
                            }
                            if (data.totleNum == 0) {
                                layer.msg('<fmt:message code="global.lang.nodata" />', {icon: 6});
                                <%--没有更多数据!--%>
                            }

                        }
                    })
                };
                /*发布范围的弹窗*/
                $('#tr_td').on('mouseenter', '.publishtip', function () {
                    var that = $(this);
                    var str = that.attr('toTypeName').replace(/-/g, '<br>')
                    layer.tips(str, that, {
                        tips: [1, '#3595CC'],
                        time: 10000
                    });
                });
                $('#tr_td').on('mouseleave', '.publishtip', function () {
                    layer.closeAll();

                });

                function initPagination(totalData, pageSize) {
                    $('.M-box3').pagination({
                        totalData: totalData,
                        showData: pageSize,
                        jump: true,
                        coping: true,
                        current: data.page,
                        homePage: '<fmt:message code="global.page.first" />',
                        endPage: '<fmt:message code="global.page.last" />',
                        prevContent: '<fmt:message code="global.page.pre" />',
                        nextContent: '<fmt:message code="global.page.next" />',
                        jumpBtn: '<fmt:message code="global.page.jump" />',
                        callback: function (index) {
                            data.page = index.getCurrent();
                            initPageList(function (pageCount) {
                                initPagination(pageCount, data.pageSize);
                            });
                        }
                    });
                }

                /* 新闻详情页 */
                $("#j_tb").on('click', '.windowOpen', function () {
                    var nid = $(this).attr('newsId');
                    //$.popWindow('detail?newsId='+nid,'<fmt:message code="news.th.newsDetail"/>','0','100','1200px','700px');
                    window.open('detail?newsId=' + nid, '<fmt:message code="news.th.newsDetail"/>');
                });
                /* 新闻管理评论页 */
                $("#j_tb").on('click', '.windowOpen_comment', function () {
                    var nid = $(this).attr('newsId');
                    var comment = $(this).attr('comment_number');
//                            $.popWindow('comment?newsId='+ nid +'&comment='+ comment +'','管理评论','0','100','1200px','700px');
                    window.open('comment?newsId=' + nid + '&comment=' + comment + '', '<fmt:message code="new.th.ManageComments" />');
                });
                /*删除时 调用的方法*/
                $("#j_tb").on('click', '#deleteData', function () {
                    //如果状态为已生效，则不允许删除
                    var publish = isEdit($(this))
                    if (publish == 1) {
                        layer.msg('<fmt:message code="new.th.thisNewsItemHasBeenPublished" />！', {icon: 0});
                        initPageList()
                        return false
                    }
                    var attR = $(this).parents('tr').find('input.input_hide').attr('newsID');
                    /* alert(attR);*/
                    var data = {
                        "newsId": attR
                    };
                    /* 调用插件弹窗 */
                    $.layerConfirm({
                        title: '<fmt:message code="menuSSetting.th.suredeleteMenu" />',
                        content: '<fmt:message code="menuSSetting.th.isdeleteMenu" />？',
                        icon: 0
                    }, function () {
                        $.ajax({
                            data: data,
                            type: "GET",
                            dataType: "JSON",
                            url: "/news/deleteNews",
                            success: function () {
                                location.reload();
                                //alert(data);
                            }
                        });
                    }, function () {
                        return false;
                    });
                });
                /* 新闻管理修改页面 */
                $("#j_tb").on('click', '#xg', function () {
                    //如果状态为已生效，则不允许进修改页面
                    var publish = isEdit($(this))
                    if (publish == 1) {
                        layer.msg('<fmt:message code="new.th.thisNewsItemHasBeenPublished" />！', {icon: 0});
                        initPageList()
                        return false
                    }
                    $.ajax({
                        type: 'get',
                        url: '/news/openNews',
                        dataType: 'json',
                        success: function (res) {
                            if (res.code == '1') {
                                $('#shenPi').html('<fmt:message code="adding.th.Submit" />')
                            }
                        }
                    })
                    var sue = ''//UE.getEditor('container3');//修改新闻页面

                    var id = $(this).attr('tid');
                    if (id == $(this).parent().parent().attr('rid')) {
                        //新闻详情获得内容：

                        $.ajax({
                            url: "/news/getOneById",
                            type: 'get',
                            dataType: "JSON",
                            data: {
                                "newsId": id,
                                "changId": "1"
                            },
                            success: function (data) {
								var datas = data.object.titlePicAttachment;
								if(datas!=undefined){
								var strid = datas.attachId;
								var strname = datas.attachName;
								$('[name="attachmentId3"]').val(datas.aid+'@'+datas.ym+'_'+strid+',');
								$('[name="attachmentName3"]').val(strname+'*');
								$('.yulan1').attr('data-url','/xs?'+datas.attUrl);
								$('.img1').attr('src', '/xs?'+datas.attUrl);
								$('#query_uploadArr_1').attr('deurl',datas.attUrl);
								$('.img1').css('display','block')
								$('.yulan1').show();
								$('.del1').show()
								$('.chuan1').hide()
								$(this).siblings('.sczs').html(' <img style="width:100%;height:100%;position: absolute;top:0;left:0" src="/xs?'+datas.attUrl+'" />\
                       <b style="    position: absolute;\
                       color: red;\
                       right: -2px;\
                       top: -10px;\
                       font-weight: bold;cursor: pointer;">x</b>')
							}


                                $("#step3_type").find("option[value=" + data.object.typeId + "]").attr("selected", true);//类型
                                $("#step3_ip2").val(data.object.deprange); //部门
                                $("#step3_ip2").attr("deptid", data.object.toId);
                                $("#privId_").val(data.object.rolerange); //角色
                                $("#privId_").attr("userpriv", data.object.privId);
                                $("#userId_").val(data.object.userrange); //人员
                                $("#userId_").attr("user_id", data.object.userId);
//                                $("#step3_ip4").val();//发布范围
                                $("#step3_ip1").val(data.object.subject);//标题
                                $("#anonymityYn_").find("option[value=" + data.object.anonymityYn + "]").attr("selected", true);//评论
                                $("#step3_ip3").val(data.object.newsDateTime);//发布时间
                                $("#hidden_id").val(data.object.newsId);
                                $("#step3_ip4").val(data.object.summary);
                                editKindEditorObj.html(data.object.content);
                                $("#step3_type").find("option[value=" + data.typeId + "]").attr("selected", true);//新闻类型
                                $("#ip5").val(data.object.keyword); //内容关键字
                                if (data.object.top == 1) {
                                    $('#top_').prop('checked', true);//是否置顶
                                }
                                ;
                                $("#topDays").text(data.object.topDays);
//                                            附件下载
                                var str1 = "";
                                var arr = new Array();
                                arr = data.object.attachment;
                                $('#newVote').empty();
                                $("#author2").val(data.object.author); // 作者
	                            $("#photographer2").val(data.object.photographer); // 摄影
                                if (data.attachmentName != '') {
                                    for (var i = 0; i < (arr.length); i++) {
										var fileExtension=arr[i].attachName.substring(arr[i].attachName.lastIndexOf(".")+1,arr[i].attachName.length);//截取附件文件后缀
										var attName = encodeURI(arr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
										var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
										var deUrl = arr[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+arr[i].size;
										str1 += '<div class="dech" deUrl="' + deUrl+ '" aid="' + arr[i].aid + '"  ym="' + arr[i].ym + '" attachId="' + arr[i].attachId + '" name="' + arr[i].attachName + '" fileSize="' + arr[i].fileSize + '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + arr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + arr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + arr[i].aid + '@' + arr[i].ym + '_' + arr[i].attachId + ',"></div>';
                                        /*str1 += '<div class="font_ dech" deUrl="' + arr[i].attUrl + '" style="display:block;"><a style="color: #000;" href="javascript:;"><img style="width:16px;" src="../img/file/cabinet@.png"/>' + arr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                                            '<input type="hidden" class="inHidden" NAME="' + arr[i].attachName + '*" value="' + arr[i].aid + '@' + arr[i].ym + '_' + arr[i].attachId + ',"></div>';*/
                                    }
                                    $('#query_uploadArr_').html(str1);
                                }
                                var titlePicAttachment = data.object.titlePicAttachment;
								var str2 = "";
                                // if(titlePicAttachment != undefined){
								// 	var fileExtension = titlePicAttachment.attachName.substring(titlePicAttachment.attachName.lastIndexOf(".")+1,titlePicAttachment.attachName.length);//截取附件文件后缀
								// 	var attName = encodeURI(titlePicAttachment.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
								// 	var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
								// 	var deUrl = titlePicAttachment.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+titlePicAttachment.size;
								// 	str2 = '<div class="dech" deUrl="' + deUrl+ '" aid="' + titlePicAttachment.aid + '"  ym="' + titlePicAttachment.ym + '" attachId="' + titlePicAttachment.attachId + '" name="' + titlePicAttachment.attachName + '" fileSize="' + titlePicAttachment.fileSize + '">' +
								// 			'<a href="/download?'+encodeURI(deUrl)+'" NAME="' + titlePicAttachment.attachName + '*" style="text-decoration:none;margin-left:5px;">' +
								// 			'<img  src="/img/attachment_icon.png"/>' + titlePicAttachment.attachName + '</a>' +
								// 			'<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
								// 			'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
								// 			'<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
								// 			'<a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" >' +
								// 			'<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
								// 			'<input type="hidden" class="inHidden" value="' + titlePicAttachment.aid + '@' + titlePicAttachment.ym + '_' + titlePicAttachment.attachId + ',"></div>';
								// 	$('#titleImg').html(str2);
								// 	$('[name="attachmentId3"]').val(titlePicAttachment.aid+'@'+titlePicAttachment.ym+'_'+ titlePicAttachment.attachId +',');
								// 	$('[name="attachmentName3"]').val(titlePicAttachment.attachName+'*');
                                // }

                            },
                            error: function () {
                                alert("<fmt:message code="global.th.error" />");
                                return;
                            }
                        });
                        <%--                sue.ready(function () {--%>
                        <%--                    $.ajax({--%>
                        <%--                        url: "/news/getOneById",--%>
                        <%--                        type: 'get',--%>
                        <%--                        dataType: "JSON",--%>
                        <%--                        data: {--%>
                        <%--                            "newsId": id,--%>
                        <%--                            "changId": "1"--%>
                        <%--                        },--%>
                        <%--                        success: function (data) {--%>
                        <%--                            $("#step3_type").find("option[value=" + data.object.typeId + "]").attr("selected", true);//类型--%>
                        <%--                            $("#step3_ip2").val(data.object.deprange); //部门--%>
                        <%--                            $("#step3_ip2").attr("deptid", data.object.toId);--%>
                        <%--                            $("#privId_").val(data.object.rolerange); //角色--%>
                        <%--                            $("#privId_").attr("userpriv", data.object.privId);--%>
                        <%--                            $("#userId_").val(data.object.userrange); //人员--%>
                        <%--                            $("#userId_").attr("user_id", data.object.userId);--%>
                        <%--//                                $("#step3_ip4").val();//发布范围--%>
                        <%--                            $("#step3_ip1").val(data.object.subject);//标题--%>
                        <%--                            $("#anonymityYn_").find("option[value=" + data.object.anonymityYn + "]").attr("selected", true);//评论--%>
                        <%--                            $("#step3_ip3").val(data.object.newsDateTime);//发布时间--%>
                        <%--                            $("#hidden_id").val(data.object.newsId);--%>
                        <%--                            $("#step3_ip4").val(data.object.summary);--%>
                        <%--                            sue.setContent(data.object.content);--%>
                        <%--                            $("#step3_type").find("option[value=" + data.typeId + "]").attr("selected", true);//新闻类型--%>
                        <%--                            $("#ip5").val(data.object.keyword); //内容关键字--%>
                        <%--                            if (data.object.top == 1) {--%>
                        <%--                                $('#top_').prop('checked', true);//是否置顶--%>
                        <%--                            }--%>
                        <%--                            ;--%>
                        <%--                            $("#topDays").text(data.object.topDays);--%>
                        <%--//                                            附件下载--%>
                        <%--                            var str1 = "";--%>
                        <%--                            var arr = new Array();--%>
                        <%--                            arr = data.object.attachment;--%>
                        <%--                            $('#newVote').empty();--%>
                        <%--                            if (data.attachmentName != '') {--%>
                        <%--                                for (var i = 0; i < (arr.length); i++) {--%>
                        <%--                                    str1 += '<div class="font_ dech" deUrl="' + arr[i].attUrl + '" style="display:block;"><a style="color: #000;" href="javascript:;"><img style="width:16px;" src="../img/file/cabinet@.png"/>' + arr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +--%>
                        <%--                                        '<input type="hidden" class="inHidden" NAME="' + arr[i].attachName + '*" value="' + arr[i].aid + '@' + arr[i].ym + '_' + arr[i].attachId + ',"></div>';--%>
                        <%--                                }--%>
                        <%--                                $('#query_uploadArr_').html(str1);--%>
                        <%--                            }--%>

                        <%--                        },--%>
                        <%--                        error: function () {--%>
                        <%--                            alert("<fmt:message code="global.th.error" />");--%>
                        <%--                            return;--%>
                        <%--                        }--%>
                        <%--                    });--%>
                        <%--                });--%>
                        $('.step1').hide();
                        $('.center').hide();
                        $('.step2').hide();
                        $('.step3').show();
                    }
                });

                function isEdit(me, type) {
                    var isEdit = ''
                    var newsId = ''
                    if (type == 1) {
                        newsId = me
                    } else {
                        newsId = me.attr('tid')
                    }
                    var data = {
                        newsId: newsId,
                        changId: ''
                    }
                    $.ajax({
                        type: 'get',
                        url: 'getOneById',
                        dataType: 'json',
                        async: false,
                        data: data,
                        success: function (res) {
                            if (res.object.publish == 1) {
                                isEdit = res.object.publish
                            }
                        }
                    })
                    return isEdit
                }
				var height = '';
				var width = '';
				$(document).on('delegate','.yulan','click',function () {
					if($(this).attr('typelook') == '1'){
						height = '482px';
						width = '568px';
					}
					layer.open({
						type: 1,
						title: false,
						closeBtn: 1,
						shade: false,
						shadeClose: true,
						area: [width,height],
						content: '<img class="picture" style="width:'+width + ';height: '+ height +'" src="'+$(this).attr('data-url')+'" alt="">',
						// success:function(){
						//     var layerInitWidth = $(".layui-layer").width(); //获取弹出层的大小
						//     var img = $('.picture');
						//     var realWidth;//真实的宽度
						//     var realHeight;//真实的高度
						//     //这里做下说明，$("<img/>")这里是创建一个临时的img标签，类似js创建一个new Image()对象！
						//     $("<img/>").attr("src", $(img).attr("src")).load(function() {
						//         realWidth = this.width;
						//         realHeight = this.height;
						//         if(realWidth>=layerInitWidth){
						//             $(img).css("width","100%").css("height","auto");
						//         }else{
						//             $(img).css("width",realWidth+'px').css("height",realHeight+'px');
						//         }
						//     });
						// }
					});



//        var str='<div style="z-index: 1000;position: fixed;top: 0;left: 0;right: 0;bottom: 0;' +
//            'background: rgba(111,111,111,.5)"><img width="165" height="61"' +
//            'style="z-index: 1000;position: fixed;top: 50%;margin-top: -30px;left: 50%;margin-left: -82px" src="'+$(this).attr('data-url')+'" alt="">' +
//            '<b class="guanbi" style="cursor:pointer;color: red;font-size: 18px;font-weight: bold;position: fixed;top: 76px;right: 20px;">x</b></div>';
//        $('body').append(str)
				})
				$(document).on('delegate','.yulan1','click',function () {
					if($(this).attr('typelook') == '2'){
						height = '482px';
						width = '568px';
					}
					layer.open({
						type: 1,
						title: false,
						closeBtn: 1,
						shade: false,
						shadeClose: true,
						area: [width,height],
						content: '<img class="picture" style="width:'+width + ';height: '+ height +'" src="'+$(this).attr('data-url')+'" alt="">',
						// success:function(){
						//     var layerInitWidth = $(".layui-layer").width(); //获取弹出层的大小
						//     var img = $('.picture');
						//     var realWidth;//真实的宽度
						//     var realHeight;//真实的高度
						//     //这里做下说明，$("<img/>")这里是创建一个临时的img标签，类似js创建一个new Image()对象！
						//     $("<img/>").attr("src", $(img).attr("src")).load(function() {
						//         realWidth = this.width;
						//         realHeight = this.height;
						//         if(realWidth>=layerInitWidth){
						//             $(img).css("width","100%").css("height","auto");
						//         }else{
						//             $(img).css("width",realWidth+'px').css("height",realHeight+'px');
						//         }
						//     });
						// }
					});



//        var str='<div style="z-index: 1000;position: fixed;top: 0;left: 0;right: 0;bottom: 0;' +
//            'background: rgba(111,111,111,.5)"><img width="165" height="61"' +
//            'style="z-index: 1000;position: fixed;top: 50%;margin-top: -30px;left: 50%;margin-left: -82px" src="'+$(this).attr('data-url')+'" alt="">' +
//            '<b class="guanbi" style="cursor:pointer;color: red;font-size: 18px;font-weight: bold;position: fixed;top: 76px;right: 20px;">x</b></div>';
//        $('body').append(str)
				})

				$(document).on('delegate','.delIndex1','click',function () {
					$(this).hide()
					$(this).siblings('.yulan1').hide()
					$(this).siblings('.img1').hide()
					$(this).siblings('.chuan1').show()
					$(this).siblings('span').css('margin-top','30px')
					$(this).next().val('');
					$(this).next().next().val('');


				})
				$('#uploadinputimg1').fileupload({//加载上以后启动上传
					dataType:'json',
					url:'/upload?module=news',
					done: function (e, data) {
						var datas = data.result.obj;
						var strid = datas[0].attachId;
						var strname = datas[0].attachName;
						$('[name="attachmentId2"]').val(datas[0].aid+'@'+datas[0].ym+'_'+strid+',');
						$('[name="attachmentName2"]').val(strname+'*');
						$(this).siblings('.yulan').attr('data-url','/xs?'+datas[0].attUrl);
						$(this).siblings('.img').attr('src', '/xs?' + datas[0].attUrl)
						$(this).siblings('.img').css('display','block')
						$(this).siblings('.yulan').show();
						$('#query_uploadArr_2').attr('deurl',datas[0].attUrl);
						$(this).siblings('.del').show()
						$(this).siblings('.chuan').hide()
						$(this).siblings('.sczs').html(' <img style="width:100%;height:100%;position: absolute;top:0;left:0" src="/xs?'+datas[0].attUrl+'" />\
                       <b style="    position: absolute;\
                       color: red;\
                       right: -2px;\
                       top: -10px;\
                       font-weight: bold;cursor: pointer;">x</b>')
					},success: function (res) {
						if(res.flag==false){
						layer.msg(res.msg,{},function(){

						});
						return false;
					}
					}
				});
				$('#uploadinputimg2').fileupload({//加载上以后启动上传
					dataType:'json',
					url:'/upload?module=news',
					done: function (e, data) {
						var datas = data.result.obj;
						var strid = datas[0].attachId;
						var strname = datas[0].attachName;
						$('[name="attachmentId3"]').val(datas[0].aid+'@'+datas[0].ym+'_'+strid+',');
						$('[name="attachmentName3"]').val(strname+'*');
						$(this).siblings('.yulan1').attr('data-url','/xs?'+datas[0].attUrl);
						$(this).siblings('.img1').attr('src', '/xs?' + datas[0].attUrl)
						$('#query_uploadArr_1').attr('deurl',datas[0].attUrl);
						$(this).siblings('.img1').css('display','block')
						$(this).siblings('.yulan1').show();
						$(this).siblings('.del1').show()
						$(this).siblings('.chuan1').hide()
						$(this).siblings('.sczs').html(' <img style="width:100%;height:100%;position: absolute;top:0;left:0" src="/xs?'+datas[0].attUrl+'" />\
                       <b style="    position: absolute;\
                       color: red;\
                       right: -2px;\
                       top: -10px;\
                       font-weight: bold;cursor: pointer;">x</b>')
					},success: function (res) {
						if(res.flag==false){
							layer.msg(res.msg,{},function(){

							});
							return false;
						}
					}
				});
				$(document).on('delegate','.delIndex','click',function () {
					$(this).hide()
					$(this).siblings('.yulan').hide()
					$(this).siblings('.img').hide()
					$(this).siblings('.chuan').show()
					$(this).siblings('span').css('margin-top','30px')
					$(this).next().val('');
					$(this).next().next().val('');


				})
                //编辑新闻页面   修改新闻页面保存时调用的方法***************
                $(".submit_ok").on('click',function () {
                    //如果状态为已生效，则不允许提交审批或保存
                    var publish = isEdit($("#hidden_id").val(), 1)
                    if (publish == 1) {
                        layer.msg('<fmt:message code="new.th.thisNewsItemHasBeenPublished" />！', {icon: 0});
                        $('.step3').hide()
                        $('.step1').show()
                        initPageList()
                        return false
                    }
                    var dataTypeId = $(this).attr('data-type');
                    var remindVal = 0;
                    if ($('.remindCheck1').is(":checked")) {
                        remindVal = 1;
                    }
                    var aId_ = '';
                    var uId_ = '';
                    for (var i = 0; i < $('#query_uploadArr_  .inHidden').length; i++) {
                        aId_ += $('#query_uploadArr_ .inHidden').eq(i).val();
                        uId_ += $('#query_uploadArr_ .inHidden').eq(i).attr('name');
                    }
                    
                    var data = {
                        "tuisong": dataTypeId,//推送标识
                        "newsId": $("#hidden_id").val(),
                        "subject": $("#step3_ip1").val(),    //标题
                        "newTime": $("#step3_ip3").val(),      //发布时间
                        "keyword": $("#ip5").val(),  //内容关键词
                        "topDays": $("#topDays").val(),// 限制新闻置顶时间
                        "content": editKindEditorObj.html(),//sue.getContent(),//  新闻内容
                        "toId": $("#step3_ip2").attr("deptid"),//发布部门
                        "keyword": $('#ip5').val(),//关键字
                        "summary": $('#step3_ip4').val(),//内容简介
                        "typeId": $('#step3_type option:checked').attr('value'),//新闻类型
                        "anonymityYn": $("#anonymityYn_ option:checked").attr('value'),//实名评论
                        "format": 0,//新闻格式(0-普通格式,1-MHT格式,2-超链接)
                        "publish": 0,  // 发布标识(0-未发布,1-已发布,2-已终止)
                        "top": $("#top_").eq(0).is(':checked') == false ? 0 : 1,//是否置顶(0-否,1-是)
                        "clickCount": '0',//点击数
                        "lastEditor": '1',//最后编辑人
                        "lastTime": new Date().Format('yyyy-MM-dd hh:mm:ss'),//最后编辑时间
                        "subjectColor": '1',//新闻标题颜色
                        "compressContent": '1',//压缩后的新闻内容
//                    "summary":$("#ip4").val(),//新闻内容简介  */
                        "attachmentId": aId_,//附件ID串
                        "attachmentName": uId_,//附件名称串
                        "privId": $("#privId_").attr("userpriv"),//发布角色 -
                        "userId": $("#userId_").attr("user_id"),//发布用户 -
                        "readers": '',//发布角色
                        "remind": remindVal,//提醒标识
                        'auditerStatus': '0',
	                    "author": $('#author2').val(), // 作者
	                    "photographer": $('#photographer2').val(), // 摄影
						"titlePicId": $('input[name="attachmentId3"]').val(),
						"titlePicName": $('input[name="attachmentName3"]').val(),
                    };
                    if($(this).attr("type_") == "publish"){
					 data.publish = '1';
					 };
                    if ($('#step3_ip1').val() == '') {
                        /* alert('请填写标题');*/
                        layer.msg('<fmt:message code="notify.th.PleaseFillTheTitle" />', {icon: 6});
                        return false;
                    } else if ($('#step3_ip2').val() == '' && $('#privId_').val() == '' && $('#userId_').val() == '') {
                        layer.msg('<fmt:message code="new.th.DepartmentRolePersonAtLeastFillInOne" />', {icon: 6});
                        return false;
                    } else if (editKindEditorObj.html() == '') { // sue.getContent()
                        layer.msg('<fmt:message code="new.th.PleaseFillInTheNewsContent" />', {icon: 6});
                        return false;
                    } else {
                        $.ajax({
                            type: 'get',
                            url: '/news/openNews',
                            dataType: 'json',
                            success: function (res) {
                                if (res.code == '1' && dataTypeId == 1) {
	                                var newsFlowId = '';
                                    // 流程审核必须选择新闻类型
                                    if (checkNewsTypeObj && checkNewsTypeObj.checkType == 1) {
                                        if (data.typeId == '0') {
                                            layer.msg('<fmt:message code="new.th.pleaseSelectTheNewsType" />', {icon: 6});
                                            return false;
                                        } else if (!checkNewsTypeObj.newsFlow || !checkNewsTypeObj.newsFlow[data.typeId]) {
                                            layer.msg('<fmt:message code="new.th.noAssociatedProcessHasBeenSetForThisNewsType" />', {icon: 6});
                                            return false;
                                        }
                                        newsFlowId = checkNewsTypeObj.newsFlow[data.typeId];
                                    }
                                    
                                    layer.open({
                                        title: SubmitExaminationApproval,
                                        content: '' +
                                            '<ul class="formUl">' +
                                            '<li class="clearfix"><label>' + hr_th_Approver + '：</label><select name="shenpiren" id=""><option value="">' + ds + '</option></select></li>' +
                                            '<li class="clearfix tixing"><label>' + tixing + '：</label><label><input checked="checked" name="approveRemind" id="chcekedLab" type="checkbox" style="float: none">' + notice_th_remindermessage + '</label></li>' +
                                            '</ul>',
                                        btn: [sure, cancel],
                                        success: function () {
                                            $('input[name="tuisong"]').val('1');
                                            $.get('/news/selectNewsAuditers', function (json) {
                                                if (json.flag) {
                                                    var arr = json.obj1;
                                                    var str = '';
                                                    for (var i = 0; i < arr.length; i++) {
                                                        str += '<option value="' + arr[i].userId + '">' + arr[i].userName + '</option>'
                                                    }
                                                    $('[name="shenpiren"]').html(str)
                                                }
                                            }, 'json');
                                            // 走流程审批
                                            if (checkNewsTypeObj && checkNewsTypeObj.checkType == 1) {
                                                $('#chcekedLab').prop('checked', false);
                                                $('.formUl .tixing').hide();
                                            }
                                        },
                                        yes: function (index) {
                                            if ($('input[name="approveRemind"]').val() != undefined) {
                                                if ($('input[name="approveRemind"]').is(":checked")) {
                                                    data.remind2 = '1'
                                                } else {
                                                    data.remind2 = '0'
                                                }
                                            }
                                            if ($('select[name="shenpiren"] option:checked').val() != undefined) {
                                                data.auditer = $('select[name="shenpiren"] option:checked').val()
                                            }
                                            
                                            if (!!newsFlowId) {
                                                newWorkFlow(newsFlowId, function (res) {
                                                    // 新闻保存关联的runId
                                                    data.runId = res.flowRun.runId;
                                                    data.auditerStatus = '3';
                                                    if (data.sortMainType == 'BUDGETTYPE') {
                                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + newsFlowId + '&type=new&flowStep=1&prcsId=1&tableName=budget&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                                                    } else {
                                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + newsFlowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                                                    }
                                                });
                                            }
                                            
                                            $.ajax({
                                                url: "/news/updateNews",
                                                type: 'post',
                                                dataType: "JSON",
                                                data: data,
                                                success: function (data) {
                                                    $.layerMsg({
                                                        content: '<fmt:message code="depatement.th.Modifysuccessfully" />',
                                                        icon: 1
                                                    });
	                                                
                                                    /*  initPageList(); */
                                                    setTimeout(function () {
                                                        $('.step1').show();
                                                        $('.center').hide();
                                                        $('.step2').hide();
                                                        $('.step3').hide();
                                                        location.reload();
                                                    }, 1000)
                                                },
                                                error: function (e) {
                                                    console.log(e);
                                                }
                                            });
                                        }
                                    })
                                } else {
                                    $.ajax({
                                        url: "/news/updateNews",
                                        type: 'post',
                                        dataType: "JSON",
                                        data: data,
                                        success: function (data) {
                                            $.layerMsg({
                                                content: '<fmt:message code="depatement.th.Modifysuccessfully" />！',
                                                icon: 1
                                            });


                                            /*  initPageList(); */
                                            setTimeout(function () {
                                                $('.step1').show();
                                                $('.center').hide();
                                                $('.step2').hide();
                                                $('.step3').hide();
                                                location.reload();
                                            }, 1000)
                                        },
                                        error: function (e) {
                                            console.log(e);
                                        }
                                    });
                                }
                            }
                        })
                    }
	                
                });
                /* 返回按钮 */
                $("#goBack").on('click',function () {
                    $('.step1').show();
                    $('.center').hide();
                    $('.step2').hide();
                    $('.step3').hide();
                });
                /* 选人控件修改页面 */
                $("#adduser_").on("click", function () {
                    user_id = "userId_";
                    $.ajax({
                        url: '/imfriends/getIsFriends',
                        type: 'get',
                        dataType: 'json',
                        data: {},
                        success: function (obj) {
                            if (obj.object == 1) {
                                $.popWindow("../common/selectUserIMAddGroup");
                            } else {
                                $.popWindow("../common/selectUser");
                            }
                        },
                        error: function (res) {
                            $.popWindow("../common/selectUser");
                        }
                    })
                });
                //选部门
                $('#dept_add_').on('click',function () {
                    dept_id = 'step3_ip2';
                    $.popWindow("../common/selectDept?allDept=1");
                });
                //选角色
                $('#priv_add_').on('click',function () {
                    priv_id = 'privId_';
                    $.popWindow("../common/selectPriv?1");
                });

                var now = null;

                function queryTime() {
                    function p(s) {
                        return s < 10 ? '0' + s : s;
                    }

                    var myDate = new Date();
                    //获取当前年
                    var year = myDate.getFullYear();
                    //获取当前月
                    var month = myDate.getMonth() + 1;
                    //获取当前日
                    var date = myDate.getDate();
                    var h = myDate.getHours();       //获取当前小时数(0-23)
                    var m = myDate.getMinutes();     //获取当前分钟数(0-59)
                    var s = myDate.getSeconds();

                    now = year + '-' + p(month) + "-" + p(date) + " " + p(h) + ':' + p(m) + ":" + p(s);
                }

                //获取当前时间 修改时页面
                queryTime();
                $("#step3_ip3").val(now);
                $("#step_release3").on('click',function () {
                    queryTime();
                    $("#step3_ip3").val(now);
                });

                //获取当前时间 新建时页面
//                        $("#query_newTime").val(now);
                $("#step_release2").on('click',function () {
                    queryTime();
                    $("#query_newTime").val(now);
                });


                /* 新闻查询按钮 */
                $('.submit').on('click',function () {
                    data.read = $('.index_head .one').parent().attr('data_id');
                    data.typeId = $('#select').val();
                    data.nTime = $('#sendTime').val();
                    data.exportId = '1';
                    initPageList(function (pageCount) {
                        initPagination(pageCount, data.pageSize);
                    });
                });
                //时间控件调用
                $('#btn_query').on('click',function () {
                    data.subject = $('#subject').val();
                    data.beginTime = $('#beginTime').val();
                    data.endTime = $('#endTime').val();
                    data.typeId = $('#select').val() == 0 ? '' : $('#select').val();
                    data.content = $('#content').val();
                    initPageList();
                    $('.step1').show();
                    $('.center').hide();
                });

                /* 新建新闻页面数据********************** */
				var isSave = true;
                $(".btn_ok").on("click", function () {
                    var remindVal = 0;
                    var dataTypeId = 0;
                    if ($('.remindCheck').is(":checked")) {
                        remindVal = 1;
                        dataTypeId = 1;
                    }
                    var aId = '';
                    var uId = '';
                    for (var i = 0; i < $('#query_uploadArr .inHidden').length; i++) {
                        aId += $('#query_uploadArr .inHidden').eq(i).val();
                        uId += $('#query_uploadArr .inHidden').eq(i).attr('NAME');
                    }
                    var data = {
                        "tuisong": dataTypeId,//推送标识
                        "subject": $("#query_subject").val(),    //标题
                        "newTime": $("#query_newTime").val(),      //发布时间
                        "keyword": $("#query_keyword").val(),  //内容关键词
                        "topDays": $("#add_topDate").val(),// 限制新闻置顶时间
                        "content": newKindEditorObj.html(), //ue.getContent(),//  新闻内容
                        "toId": $("#query_toId").attr("deptid"),//发布部门
                        "anonymityYn": $('#query_anonymityYn option:checked').attr('value'), //实名评论
                        "format": 0,//新闻格式(0-普通格式,1-MHT格式,2-超链接)
                        "typeId": $('#query_typeId option:checked').attr('value'),//新闻类型
                        "publish": 0,  // 发布标识(0-未发布,1-已发布,2-已终止)，保存
                        "top": $("#query_top").eq(0).is(':checked') == false ? 0 : 1,//是否置顶(0-否,1-是)
                        "subjectColor": '',//新闻标题颜色
                        "summary": $('#ip4').val(),//新闻内容简介  */
                        "attachmentId": aId,//附件ID串
                        "attachmentName": uId,//附件名称串
                        "privId": $("#query_privId").attr("userpriv"),//发布角色 -
                        "userId": $("#query_userId").attr("user_id"),//发布用户 -
                        "remind": remindVal,
	                    "author": $('#author').val(), // 作者
	                    "photographer": $('#photographer').val(), // 摄影
                        "titlePicId": $('input[name="attachmentId2"]').val(),
                        "titlePicName": $('input[name="attachmentName2"]').val(),
                    };
                    if ($(this).attr("type") == "publish") {
                        data.publish = '1';    //发布
                    } else {
                        data.publish = '0';    //保存
                    }
                    if ($('#query_subject').val() == '') {
                        /* alert('请填写标题');*/
                        layer.msg('<fmt:message code="notify.th.PleaseFillTheTitle" />', {icon: 6});
                        <%--请填写标题--%>
                        return false;
                    } else if ($('#query_toId').val() == '' && $('#query_privId').val() == '' && $('#query_userId').val() == '') {
                        layer.msg('<fmt:message code="new.th.DepartmentRolePersonAtLeastFillInOne" />', {icon: 6});
                        <%--部门、角色、人员至少填写一个--%>
                        return false;
                    } else if (newKindEditorObj.html() == '') { // ue.getContent()
                        layer.msg('<fmt:message code="new.th.PleaseFillInTheNewsContent" />', {icon: 6});
                        <%--请填写新闻内容--%>
                        return false;
                    } else if (data.publish == '1') {
                        $.ajax({
                            type: 'get',
                            url: '/news/openNews',
                            dataType: 'json',
                            success: function (res) {
                                if (res.code == '1') {
                                    var newsFlowId = '';
                                    // 流程审核必须选择新闻类型
                                    if (checkNewsTypeObj && checkNewsTypeObj.checkType == 1) {
                                        if (data.typeId == '0') {
                                            layer.msg('<fmt:message code="new.th.pleaseSelectTheNewsType" />', {icon: 6});
                                            return false;
                                        } else if (!checkNewsTypeObj.newsFlow || !checkNewsTypeObj.newsFlow[data.typeId]) {
                                            layer.msg('<fmt:message code="new.th.noAssociatedProcessHasBeenSetForThisNewsType" />', {icon: 6});
                                            return false;
                                        }
                                        newsFlowId = checkNewsTypeObj.newsFlow[data.typeId];
                                    }
                                    data.publish = '0';
                                    layer.open({
                                        title: SubmitExaminationApproval,
                                        content: '' +
                                            '<ul class="formUl">' +
                                            '<li class="clearfix"><label>' + hr_th_Approver + '：</label><select name="shenpiren" id=""><option value="">' + ds + '</option></select></li>' +
                                            '<li class="clearfix tixing"><label>' + tixing + '：</label><label><input checked="checked" name="approveRemind" id="chcekedLab" type="checkbox" style="float: none">' + notice_th_remindermessage + '</label></li>' +
                                            '</ul>',
                                        btn: [sure, cancel],
                                        success: function () {
                                            $('input[name="tuisong"]').val('1');
                                            $.get('/news/selectNewsAuditers', function (json) {
                                                if (json.flag) {
                                                    var arr = json.obj1;
                                                    var str = '';
                                                    for (var i = 0; i < arr.length; i++) {
                                                        str += '<option value="' + arr[i].userId + '">' + arr[i].userName + '</option>';
                                                    }
                                                    $('[name="shenpiren"]').html(str);
                                                }
                                            }, 'json');
                                            
                                            // 走流程审批
                                            if (checkNewsTypeObj && checkNewsTypeObj.checkType == 1) {
                                                $('#chcekedLab').prop('checked', false);
                                                $('.formUl .tixing').hide();
                                            }
                                        },
                                        yes: function (index) {
                                            if ($('input[name="approveRemind"]').val() != undefined) {
                                                if ($('input[name="approveRemind"]').is(":checked")) {
                                                    data.remind2 = '1'
                                                } else {
                                                    data.remind2 = '0'
                                                }
                                            }
                                            if ($('select[name="shenpiren"] option:checked').val() != undefined) {
                                                data.auditer = $('select[name="shenpiren"] option:checked').val()
                                            }
                                            layer.load(0, {shade: [0.2, '#ffffff']});
                                            
                                            if (!!newsFlowId) {
                                                newWorkFlow(newsFlowId, function (res) {
                                                    // 新闻保存关联的runId
                                                    data.runId = res.flowRun.runId;
                                                    data.auditerStatus = '3';
                                                    if (data.sortMainType == 'BUDGETTYPE') {
                                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + newsFlowId + '&type=new&flowStep=1&prcsId=1&tableName=budget&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                                                    } else {
                                                        $.popWindow("/workflow/work/workform?opflag=1&flowId=" + newsFlowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');
                                                    }
                                                });
                                            }
                                            
                                            $.ajax({
                                                url: "/news/sendNews",
                                                type: 'post',
                                                dataType: "JSON",
                                                data: data,
                                                success: function (data) {
                                                    $.layerMsg({
                                                        content: '<fmt:message code="user.th.PublishSuccessfully" />！',
                                                        icon: 1
                                                    }, function () {
                                                        $('.step1').show();
                                                        $('.center').hide();
                                                        $('.step2').hide();
                                                        $('.step3').hide();
                                                        location.reload();
                                                    });
                                                    layer.closeAll();
                                                },
                                                error: function (e) {
                                                    $.layerMsg({
                                                        content: '<fmt:message code="meet.th.SaveFailed" />！',
                                                        icon: 2
                                                    }, function () {<%--保存失败--%>
                                                    });
                                                }
                                            });
                                        }
                                    })
                                } else {
                                    data.publish = '1';
                                    layer.load(0, {shade: [0.2, '#ffffff']});
                                    $.ajax({
                                        url: "/news/sendNews",
                                        type: 'post',
                                        dataType: "JSON",
                                        data: data,
                                        success: function (data) {
                                            $.layerMsg({
                                                content: '<fmt:message code="user.th.PublishSuccessfully" />！',
                                                icon: 1
                                            }, function () {<%--发布成功--%>
//                                layer.msg('1', { icon:6});
                                                $('.step1').show();
                                                $('.center').hide();
                                                $('.step2').hide();
                                                $('.step3').hide();
                                                /*  initPageList(); */
                                                location.reload();
                                            });
                                            layer.closeAll();
                                        },
                                        error: function (e) {
                                            $.layerMsg({
                                                content: '<fmt:message code="meet.th.SaveFailed" />！',
                                                icon: 2
                                            }, function () {<%--保存失败--%>
                                            });

                                        }
                                    });
                                }
                            }
                        });
                    } else {
						if(!isSave) return $.layerMsg({content: '<fmt:message code="new.th.duplicateSavingIsProhibited" />！'})
						isSave = false
                        //如果点击保存按钮，则不传推送和remind
                        data.tuisong = 0;
                        data.remind = 0;
                        // layer.load(0, {shade: [0.2, '#ffffff']});

						$.ajax({
								url: "/news/sendNews",
								type: 'post',
								dataType: "JSON",
								data: data,
								success: function (data) {
									$.layerMsg({
										content: '<fmt:message code="diary.th.modify" />！',
										icon: 1
									}, function () {<%--保存成功--%>
										$('.step1').show();
										$('.center').hide();
										$('.step2').hide();
										$('.step3').hide();
										/*  initPageList(); */
										location.reload();
									});
									layer.closeAll();
								},
								error: function (e) {
									console.log(e);
								}
							});
                    }
                });
                /* 新建页面选人控件 */
                $("#query_adduser").on("click", function () {
                    user_id = "query_userId";
                    $.ajax({
                        url: '/imfriends/getIsFriends',
                        type: 'get',
                        dataType: 'json',
                        data: {},
                        success: function (obj) {
                            if (obj.object == 1) {
                                $.popWindow("../common/selectUserIMAddGroup");
                            } else {
                                $.popWindow("../common/selectUser");
                            }
                        },
                        error: function (res) {
                            $.popWindow("../common/selectUser");
                        }
                    })
                });
                //选部门
                $('#dept_add').on('click',function () {
                    dept_id = 'query_toId';
                    $.popWindow("../common/selectDept?allDept=1");
                });
                //选角色
                $('#priv_add').on('click',function () {
                    priv_id = 'query_privId';
                    $.popWindow("../common/selectPriv?1");
                });


                /!* 新闻管理 查询的确定按钮 *!/
                $('.determine').on('click',function () {
					$('.M-box3').show();
                    data.format = $('#format option:checked').attr('value');//新闻格式(0-普通格式,1-MHT格式,2-超链接)
                    data.typeId = $('#type_id option:checked').attr('value');//类型
                    data.publish = $('.publish option:checked').attr('value');//发布标识(0-未发布,1-已发布,2-已终止)
                    data.top = $('.top option:checked').attr('value');//是否置顶(0-否,1-是)
                    data.subject = $("#subject").val();//标题
                    data.newsTime = $("#beginTime").val();
                    data.lastEditTime = $("#endTime").val();//发布日期
                    data.content = $("#content_").val(); //内容
                    data.clickCount = $(".c_time1").val();
                    data.click = $(".c_time2").val();//点击次数
                    data.read = "";
                    data.exportId = 1;
                    data.changeId = $('input[name="radio"]:checked').val();
                    data.auditerStatus = $('.auditerStatus option:checked').attr('value');//是否审批
                    initPageList();
                    $('.step1').show();
                    $('.step2').hide();
                    $('.center').hide();
                    <%--location.reload();--%>
                });
                /*新闻查询导出方法*/
                $("#export").on('click',function () {
                    var format = $('#format option:checked').attr('value');//新闻格式(0-普通格式,1-MHT格式,2-超链接)
                    var typeId = $('#type_id option:checked').attr('value');//类型
                    var publish = $('.publish option:checked').attr('value');//发布标识(0-未发布,1-已发布,2-已终止)
                    var top = $('.top option:checked').attr('value');//是否置顶(0-否,1-是)
                    var subject = $("#subject").val();//标题
                    var newsTime = $("#beginTime").val();
                    var lastEditTime = $("#endTime").val();//发布日期
                    var content = $("#content_").val(); //内容
                    var clickCount = $(".c_time1").val();
                    var click = $(".c_time2").val();//点击次数
                    var read = "";
                    var exportId = 2;
                    var changeId = 1;
                    window.location.href = '/news/newsShow?format=' + format + '&typeId=' + typeId + '&publish=' + publish + '&top=' + top +
                        '&subject=' + subject + '&newsTime=' + newsTime + '&newsTime=' + newsTime + '&lastEditTime=' + lastEditTime + '&content=' + content + '&clickCount=' + clickCount +
                        '&click=' + click + '&read=""&exportId=2&changeId =1&page=1&pageSize=5&useFlag=false&changeId=1';
                });

                //点击全选
                $('#j_tb').on('click', '#checkedAll', function () {
                    var state = $(this).prop("checked");
                    if (state == true) {
                        $(this).prop("checked", true);
                        $(".checkChild").prop("checked", true);

                    } else {
                        $(this).prop("checked", false);
                        $(".checkChild").prop("checked", false);
                        ;

                    }
                });
                //点击删除选中按钮
                $('#j_tb').on('click', '.delete_check', function () {
                    var fileId = [];
                    $("#j_tb .checkChild:checkbox:checked").each(function () {
                        var conId = $(this).attr("conId");
                        /*  alert(conId);*/
                        fileId.push(conId);

                    })
                    if (fileId == '') {
                        $.layerMsg({content: '<fmt:message code="file.th.PleaseSelectFile"/>！', icon: 1});
                    } else {
                        /*    $('.contentTrs').remove();
						 $('.mainContent').show();
						 $('.details').hide();*/
                        dataDelete(fileId)
                    }
                });
                //查阅情况
                $('#j_tb').on('click', '.find_detail', function () {
                    var fileId = [];
                    $("#j_tb .checkChild:checkbox:checked").each(function () {
                        var conId = $(this).attr("conId");
                        fileId.push(conId);
                    });
                    if (fileId.length != 1) {
                        $.layerMsg({content: '<fmt:message code="new.th.CanOnlyChooseOne" />', icon: 0});
                        <%--只能选择一条--%>
                    } else {
                        var newsId = $("#j_tb .checkChild:checkbox:checked").attr("conId");
                        $.popWindow("findDetail?newsId=" + newsId, '<fmt:message code="news.th.querysituation" />', '0', '0', '1200px', '600px');
                        <%--查阅情况--%>
                    }
                });
                //取消置顶
                $('#j_tb').on('click', '.news_notop', function () {
                    var fileId = [];
                    $("#j_tb .checkChild:checkbox:checked").each(function () {
                        var conId = $(this).attr("conId");
                        fileId.push(conId);

                    })
                    if (fileId == '') {
                        $.layerMsg({content: '<fmt:message code="file.th.PleaseSelectFile"/>！', icon: 1});
                    } else {
                        layer.confirm('<fmt:message code="notice.th.cancelTop"/>？', {
                            <%--是否取消置顶--%>
                            btn: ['<fmt:message code="global.lang.ok"/>', '<fmt:message code="depatement.th.quxiao"/>'], //按钮  <%--确定 取消--%>
                            title: "<fmt:message code="notice.th.CancelTopFile" />"
                        }, function () {
                            //确定删除，调接口
                            $.ajax({
                                type: 'post',
                                url: '/news/updateByIds',
                                dataType: 'json',
                                data: {
                                    newsIds: fileId,
                                    top: '0'
                                },
                                success: function () {
                                    layer.msg('<fmt:message code="notice.th.CancelTopSuccess"/>', {icon: 6});
                                    <%--取消置顶成功--%>
                                    /* init(4,id,1);*/
                                    window.location.reload();
                                }
                            })

                        }, function () {
                            layer.closeAll();
                        });
                    }
                })
                //设置置顶
                $('#j_tb').on('click', '.news_top', function () {
                    var fileId = [];
                    $("#j_tb .checkChild:checkbox:checked").each(function () {
                        var conId = $(this).attr("conId");
                        fileId.push(conId);

                    })
                    if (fileId == '') {
                        $.layerMsg({content: '<fmt:message code="file.th.PleaseSelectFile"/>！', icon: 1});
                    } else {
                        layer.confirm('<fmt:message code="notice.th.ifTop"/>？', {
                            <%--是否置顶--%>
                            btn: ['<fmt:message code="global.lang.ok"/>', '<fmt:message code="depatement.th.quxiao"/>'], //按钮 <%-- 确定  取消--%>
                            title: '<fmt:message code="notice.th.TopFile"/>'  <%--置顶文件--%>
                        }, function () {
                            //确定删除，调接口
                            $.ajax({
                                type: 'post',
                                url: '/news/updateByIds',
                                dataType: 'json',
                                data: {
                                    newsIds: fileId,
                                    top: '1'
                                },
                                success: function () {
                                    layer.msg('<fmt:message code="notice.th.TopSuccess"/>', {icon: 6});
                                    <%--置顶成功--%>
                                    /* init(4,id,1);*/
                                    window.location.reload();
                                }
                            })

                        }, function () {
                            layer.closeAll();
                        });
                    }
                })
                //终止所选新闻
                $('#j_tb').on('click', '.news_stop', function () {
                    var fileId = [];
                    $("#j_tb .checkChild:checkbox:checked").each(function () {
                        var conId = $(this).attr("conId");
                        fileId.push(conId);

                    })
                    if (fileId == '') {
                        $.layerMsg({content: '<fmt:message code="file.th.PleaseSelectFile"/>！', icon: 1});
                    } else {
                        layer.confirm('<fmt:message code="new.th.WhetherItIsTerminated"/>？', {
                            <%--是否终止--%>
                            btn: ['<fmt:message code="global.lang.ok"/>', '<fmt:message code="depatement.th.quxiao"/>'], //按钮  <%--确定 取消--%>
                            title: '<fmt:message code="notice.th.TopFile"/>'  <%--置顶文件--%>
                        }, function () {
                            //确定删除，调接口
                            $.ajax({
                                type: 'post',
                                url: '/news/updateByIds',
                                dataType: 'json',
                                data: {
                                    newsIds: fileId,
                                    publish: '2'
                                },
                                success: function () {
                                    layer.msg('<fmt:message code="event.th.TerminationSuccess" />', {icon: 6});
                                    window.location.reload();
                                }
                            })

                        }, function () {
                            layer.closeAll();
                        });
                    }
                })
                //生效所选新闻
                $('#j_tb').on('click', '.news_inOperation', function () {
                    var fileId = [];
                    $("#j_tb .checkChild:checkbox:checked").each(function () {
                        var conId = $(this).attr("conId");
                        fileId.push(conId);

                    })
                    if (fileId == '') {
                        $.layerMsg({content: '<fmt:message code="file.th.PleaseSelectFile"/>！', icon: 1});
                    } else {
                        layer.confirm('<fmt:message code="new.th.WhetherItIsEffective"/>？', {
                            <%--是否生效--%>
                            btn: ['<fmt:message code="global.lang.ok"/>', '<fmt:message code="depatement.th.quxiao"/>'], //按钮 <%--确定 取消--%>
                            title: '<fmt:message code="notice.th.TopFile"/>' <%--置顶文件--%>
                        }, function () {
                            //确定删除，调接口
                            $.ajax({
                                type: 'post',
                                url: '/news/updateByIds',
                                dataType: 'json',
                                data: {
                                    newsIds: fileId,
                                    publish: '1'
                                },
                                success: function () {
                                    layer.msg('<fmt:message code="new.th.Effective"/>', {icon: 6});
                                    <%--生效成功--%>
                                    window.location.reload();
                                }
                            })

                        }, function () {
                            layer.closeAll();
                        });
                    }
                })


            });

            //批量删除封装的方法
            function dataDelete(arr) {
                layer.confirm('<fmt:message code="sup.th.Delete"/>？', {
                    <%--是否删除--%>
                    btn: ['<fmt:message code="global.lang.ok"/>', '<fmt:message code="depatement.th.quxiao"/>'], //按钮 <%--确定 取消--%>
                    title: '<fmt:message code="notice.th.DeleteFile"/>'  <%--删除文件--%>
                }, function () {
                    //确定删除，调接口
                    $.ajax({
                        type: 'get',
                        url: '/news/deleteByIds',
                        dataType: 'json',
                        data: {"newsIds": arr},
                        success: function () {
                            layer.msg('<fmt:message code="workflow.th.delsucess"/>', {icon: 6});
                            <%-- 删除成功--%>
                            window.location.reload();
                        }
                    })

                }, function () {
                    layer.closeAll();
                });

            }

            /* 新闻查询清空方法  */
            function Refillings(id) {
                document.getElementById(id).reset();
            }

            /* 新建新闻、修改新闻人员控件清空 */
            function empty(id) {
                $("#" + id).val("");
                $("#" + id).attr("deptid", "");
            };

            /* 新建新闻、修改新闻人员控件清空 */
            function empty1(id) {
                $("#" + id).val("");
                $("#" + id).attr("userpriv", "");
            };

            /* 新建新闻、修改新闻人员控件清空 */
            function empty2(id) {
                $("#" + id).val("");
                $("#" + id).attr("user_id", "");
                $("#" + id).attr("dataid", "");
            };

            /* 新闻人员控件显示和隐藏 */
            function showAndHidden(persion, role, man) {
                if ($("#" + persion).html() == '<fmt:message code="notice.th.PostedByPersonnelOrRoles" />' || $("#" + persion).html() == '<fmt:message code="notice.th.somebody" />') {<%--按人员或角色发布--%>

                    if (pareValue == 0) {
                        $("#" + persion).html('<fmt:message code="notice.th.Hidden" />');
                        <%--隐藏按人员或角色发布--%>
                        $("#" + role).show();
                    } else {
                        $("#" + persion).html('<fmt:message code="new.th.hideTheReleaseByPerson" />');
                        <%--隐藏按人员或角色发布--%>
                        $("#" + role).hide();
                    }

                    $("#" + man).show();
                } else {
                    if (pareValue == 0) {
                        $("#" + persion).html('<fmt:message code="notice.th.PostedByPersonnelOrRoles" />')

                    } else {
                        $("#" + persion).html('<fmt:message code="notice.th.somebody" />')

                    }
                    <%--$("#"+persion).html('<fmt:message code="notice.th.PostedByPersonnelOrRoles" />');&lt;%&ndash;按人员或角色发布&ndash;%&gt;--%>
                    $("#" + role).hide();
                    $("#" + man).hide();
                }
            }

            /* 终止和生效方法 */
            function stop(id, publishId, stopId) {
                layer.confirm('<fmt:message code="new.th.areYouSure" />' + $(stopId).html() + '<fmt:message code="new.th.youWantIt" />？', function (index) {
                    var pulbish;
                    var auditerStatus;
                    if ($(stopId).html() == '<fmt:message code="notice.state.end" />') {<%--终止--%>
                        pulbish = 0
						auditerStatus = 0
                    } else if ($(stopId).html() == '<fmt:message code="notice.state.effective" />') {<%--生效--%>
                        pulbish = 1
						auditerStatus = 1
                    }
                  /*  var data = {
                        "newsId": id,
                        "publish": pulbish,  // 发布标识(0-未发布,1-已发布,2-已终止)
                        "editPublish": "1"
                    };*/
					var data = {
						"newsId": id,
						"publish": pulbish,  // 发布标识(0-未发布,1-已发布,2-已终止)
						"auditerStatus": auditerStatus
					};
                    $.ajax({
                        <%--url: "/news/updateNews",--%>
                        url: "/news/upNewStatus",
                        type: 'get',
                        dataType: "JSON",
                        data: data,
                        success: function (data) {
                            $.layerMsg({
                                content: '<fmt:message code="depatement.th.Modifysuccessfully" />！',
                                icon: 1
                            }, function () {<%--修改完成--%>
                                window.location.reload()
                                // initPageList()
                                /* if($(stopId).html()=='

                                <fmt:message code="notice.state.end" />'){
                        
                                <%--终止--%>
                         $(publishId).html('终止');
                        
                                <%--已终止--%>
                         if(!isEffect){
                         $(stopId).html('
                        
                                <fmt:message code="notice.state.effective" />');
                        
                                <%--生效--%>
                         }else{
                         $(stopId).html('');
                         }
                         }else if($(stopId).html() == '
                        
                                <fmt:message code="notice.state.effective" />'){
                        
                                <%--生效--%>
                         $(publishId).html('
                        
                                <fmt:message code="notice.state.effective" />');
                        
                                <%--生效--%>
                         $(stopId).html('
                        
                                <fmt:message code="notice.state.end" />');
                        
                                <%--终止--%>
                         }*/
                            });

                        },
                        error: function (e) {
                            console.log(e);
                        }
                    });
                    layer.close(index);
                });
            }

            laydate({
                elem: '#query_newTime', //目标元素。
                format: 'YYYY-MM-DD hh:mm:ss', //日期格式
                istime: true, //显示时、分、秒
            });
            laydate({
                elem: '#step3_ip3', //目标元素。
                format: 'YYYY-MM-DD hh:mm:ss', //日期格式
                istime: true, //显示时、分、秒
            });

            //时间控件调用
            var start = {
                elem: '#beginTime',
                format: 'YYYY-MM-DD',
//                        min: laydate.now(), //设定最小日期为当前日期*/
                max: '2099-06-16 23:59:59', //最大日期*/
                istime: true,
                istoday: false,
                choose: function (datas) {
                    end.min = datas; //开始日选好后，重置结束日的最小日期
                    end.start = datas; //将结束日的初始值设定为开始日
                }
            };
            var end = {
                elem: '#endTime',
                format: 'YYYY-MM-DD',
//                        min: laydate.now(),
                max: '2099-06-16 23:59:59',
                istime: true,
                istoday: false,
                choose: function (datas) {
                    start.max = datas; //结束日选好后，重置开始日的最大日期
                }
            };
            laydate(start);
            laydate(end);

            //删除附件
            function deleteChatment(data, element) {

                layer.confirm('<fmt:message code="workflow.th.que" />？', {
                    <%--确定要删除吗--%>
                    btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮  <%--确定 取消--%>
                    title: '<fmt:message code="notice.th.DeleteAttachment" />'  <%--删除附件--%>
                }, function () {
                    //确定删除，调接口
                    $.ajax({
                        type: 'get',
                        url: '../delete',
                        dataType: 'json',
                        data: data,
                        success: function (res) {

                            if (res.flag == true) {
                                layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                                <%--删除成功--%>
                                element.remove();
                            } else {
                                layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 6});
                                <%--删除失败--%>
                            }
                        }
                    });

                }, function () {
                    layer.closeAll();
                });
            }

			//删除标题图片
			function deleteChatment1(data, element) {

				layer.confirm('确定要删除标题图片吗？', {
					<%--确定要删除吗--%>
					btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮  <%--确定 取消--%>
					title: '删除标题图片'  <%--删除附件--%>
				}, function () {
					//确定删除，调接口
					$.ajax({
						type: 'get',
						url: '../delete',
						dataType: 'json',
						data: data,
						success: function (res) {

							if (res.flag == true) {
								layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
								<%--删除成功--%>
								element.remove();
							} else {
								layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 6});
								<%--删除失败--%>
							}
						}
					});

				}, function () {
					layer.closeAll();
				});
			}

            //新闻预览页面
            $(document).on('click', '#preview', function () {
                // $('#newsPreview').html(UE.getEditor('container').getContent())
                $('#newsPreview').html(newKindEditorObj.html());
                window.open('/news/newsPreview');
            })
            //编辑新闻预览页面
            $(document).on('click', '#editPreview', function () {
                // $('#newsPreview').html(UE.getEditor('container3').getContent())
                $('#newsPreview').html(editKindEditorObj.html())
                window.open('/news/newsPreview')
            })

            /************** kindEditor编辑器 **************/
            var kindEditorOption = {
                themeType: 'simple', // 定义编辑器为简洁模式
                filterMode: false, // 开启过滤
                allowFileManager: true, // 开启文件空间
                uploadJson: '/ueditor/upload?module=news', // 上传接口
                filePostName: 'upfile', // 自定义后台接收的文件流参数名（默认为 imgFile）
                afterUploadStatusName: 'state', // 定义上传后判断的参数名（默认为 error）
                afterUploadSuccessCode: 'SUCCESS', // 定义上传成功后参数值（默认为 0）此处判断为===，必须保证类型也相同
                afterUploadErrorMsg: 'msg', // 定义上传失败后提示信息的参数名（默认为 message）
                afterUpload: function (url, data, name) {
                    console.log(url);
                    console.log(data);
                    console.log(name);
                }
            }
            // 新建新闻编辑器
            var newKindEditorObj = null;
            KindEditor.ready(function (K) {
                newKindEditorObj = K.create('#newKindEditor', kindEditorOption);
            });
            // 编辑新闻编辑器
            var editKindEditorObj = null;
            KindEditor.ready(function (K) {
                editKindEditorObj = K.create('#editKindEditor', kindEditorOption);
            });
            /************** kindEditor编辑器 **************/

            
            function newWorkFlow(flowId, cb) {
                $.ajax({
                    url: '/workflow/work/workfastAdd',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        flowId: flowId,
                        prcsId: 1,
                        flowStep: 1,
                        runId: '',
                        preView: 0
                    },
                    async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                    success: function (res) {
                        if (res.flag == true) {
                            var data = res.object;
                            cb(data);
                        }
                    }
                });
            }
		
		</script>
	</body>
</html>
