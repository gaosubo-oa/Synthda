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
<head lang="en">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>实施策划交底业务填报界面</title>
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/common.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<script src="/lib/layui/layui/layui.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
	<script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?22120210830.1"></script>
	<script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>
	<style>
		html,body{
			background: #fff;
		}
		.layui-card-header{
			border-bottom: 1px solid #eee;
		}
		.mbox{
			padding: 0px;
		}
		.inbox{
			padding: 5px;
			padding-right: 30px;
		}
		.deptinput{
			display: inline-block;
			width: 75%;
		}
		.layui-btn{
			margin-left: 10px;
		}
		.layui-btn .layui-icon{
			margin-right: 0px;
		}
		.red{
			color: red;
			font-size: 16px;
		}
		.layui-form-label{
			padding: 8px 15px;
		}
		.layui-card-body{
			display: flex;
		}
		.layui-lf{
			min-width: 16%;
			overflow-x: auto;
			height: 600px !important;
		}
		.layui-rt{
			width: 84%;
			margin-left: 6px;
			margin-top:0px;
		}
		.treeTitle{
			display: flex;
			box-sizing: border-box;
			justify-content: center;
			align-items: center;
			width: 100%;
			height: 30px;
			background-color: #00a0e9;
			color: #fff;
			padding: 15px;
			position: relative;
		}
		.layui-nav-item,.layadmin-flexible{
			position: absolute;
			left: 5px;
			top: 23px;
			z-index: 9999999;
		}
		.rtfix{
			width:200px;
			overflow-x: scroll;
		}
		.bg{
			background-color: #F2F2F2;
		}
		.bgs{
			background-color: #F2F2F2;
		}
		.back{
			background-color: #ccc;
		}

		.eleTree{
			cursor: pointer;
		}
		.textAreaBox{
			width: 100%;
			max-width: 100%;
			cursor: pointer;
			margin: 0px;
			overflow-y:visible;
			min-height: 37px;
		}
		.openFile input[type=file]{
			position: absolute;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			width: 100%;
			height: 18px;
			z-index: 99;
			opacity: 0;
		}
		.operationDiv{
			position: absolute;
			top: -85px;
			width: 150px;
			border: #ccc 1px solid;
			border-radius: 4px;
			background-color: #ffffff;
			z-index: 99;
		}
		.operation{
			display: block;
			/*width: 100%;*/
			margin-left: 0px !important;
			height: 28px;
			padding-left: 10px;
			background: #fff;
			line-height: 28px;
		}
		.operation:hover{
			background-color: #cae1f7;
			color: #000000;
		}
		.layui-col-xs4{
			width: 20%;
			padding: 0 5px;
		}
		.form_label {
			float: none;
			padding: 9px 0;
			text-align: left;
			width: auto;
		}
		.form_block {
			margin: 0;
		}
		.refresh_no_btn {
			display: none;
			margin-left: 2%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}
	</style>
</head>
<body>
<div class="mbox">
	<div class="layui-tab" style="margin: 3px 10px;padding: 10px">
		<form class="layui-form" id="baseForm" lay-filter="baseForm">
			<div class="layui-row">
				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">单据号<a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
						<div class="layui-form-block form_block">
							<input type="text" class="layui-input" name="embodimentNo" id="embodimentNo"  autocomplete="off">
						</div>
					</div>
				</div>
				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">项目名称</label>
						<div class="layui-form-block form_block">
							<input type="text" class="layui-input" name="projectName" id="projectName"  autocomplete="off">
						</div>
					</div>
				</div>
<%--				<div class="layui-col-xs4">--%>
<%--					<div class="layui-form-item">--%>
<%--						<label class="layui-form-label form_label">项目类型</label>--%>
<%--						<div class="layui-form-block form_block">--%>
<%--							<input type="text" class="layui-input" name="projectTypeName" id="projectTypeName"  autocomplete="off">--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</div>--%>
				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">实施策划交底名称</label>
						<div class="layui-form-block form_block">
							<input type="text" class="layui-input" name="embodimentName" id="embodimentName"  placeholder="请输入实施策划交底名称" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">交底程度</label>
						<div class="layui-form-block form_block">
						<select id="embodimentType" name="embodimentType" ></select>
						</div>
					</div>
				</div>
				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">实施策划</label>
						<div class="layui-form-block form_block">
							<input type="text" class="layui-input" name="planingName" id="planingName" readonly placeholder="请选择实施策划" autocomplete="off" style="background:#e7e7e7;cursor: pointer;">
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">

				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">填报人</label>
						<div class="layui-form-block form_block">
							<input type="text" class="layui-input" name="userName" id="userName" readonly autocomplete="off" style="background:#e7e7e7;cursor: pointer;">
						</div>
					</div>
				</div>
				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">填报时间</label>
						<div class="layui-form-block form_block">
							<input type="text" class="layui-input" name="createTime" id="createTime" readonly autocomplete="off" style="background:#e7e7e7;cursor: pointer;">
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row" style="margin-top: 20px">
				<div class="layui-col-xs4"style="width: 100%">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">技术交底内容</label>
						<div class="layui-form-block form_block">
							<div class="layui-input-inline"  style="width: 100%">
								<div id="fileContent1">
								</div>
								<a href="javascript:;" class="openFile" style="position:relative">
									<img src="../img/mg11.png" alt="">
									<span>添加附件</span>
									<input type="file" multiple id="fileupload1" data-url="/upload?module=technical"  name="file">
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-col-xs4"style="width: 100%">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">技术交底会议纪要</label>
						<div class="layui-form-block form_block">
							<div class="layui-input-inline"  style="width: 100%">
								<div id="fileContent2">
								</div>
								<a href="javascript:;" class="openFile" style="position:relative">
									<img src="../img/mg11.png" alt="">
									<span>添加附件</span>
									<input type="file" multiple id="fileupload2" data-url="/upload?module=technical"  name="file">
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-col-xs4"style="width: 100%">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">技术交底签字记录</label>
						<div class="layui-form-block form_block">
							<div class="layui-input-inline"  style="width: 100%">
								<div id="fileContent3">
								</div>
								<a href="javascript:;" class="openFile" style="position:relative">
									<img src="../img/mg11.png" alt="">
									<span>添加附件</span>
									<input type="file" multiple id="fileupload3" data-url="/upload?module=technical"  name="file">
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-col-xs4"style="width: 100%">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">技术交底现场照片</label>
						<div class="layui-form-block form_block">
							<div class="layui-input-inline"  style="width: 100%">
								<div id="fileContent4">
								</div>
								<a href="javascript:;" class="openFile" style="position:relative">
									<img src="../img/mg11.png" alt="">
									<span>添加附件</span>
									<input type="file" multiple id="fileupload4" data-url="/upload?module=technical"  name="file">
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
	var urlType = getUrlParam("urlType");
	var embodimentId = getUrlParam("embodimentId");
	var projectId = getUrlParam("projectId");
	var runId=getUrlParam("runId");
	var _disabled=getUrlParam("disabled");
	var formData;
	var projectName = parent.projectNamee;
	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var columnId = parent.columnTrId;

	layui.use(['table','layer','form','element','eleTree','upload','laydate'], function() {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var upload = layui.upload;
		var laydate = layui.laydate;


		$('#projectName').val(projectName); //回显项目名称
		fileuploadFn('#fileupload1', $('#fileContent1'));
		fileuploadFn('#fileupload2', $('#fileContent2'));
		fileuploadFn('#fileupload3', $('#fileContent3'));
		fileuploadFn('#fileupload4', $('#fileContent4'));
		//渲染交底程度
		var $select1 = $("#embodimentType");
		var optionStr = '<option value="">请选择</option>';
		$.ajax({ //查询文档等级
			url: '/plbDictonary/selectDictionaryByNo?plbDictNo=EMBODIMENT_DEGREE',
			type: 'get',
			dataType: 'json',
			async:false,
			success: function (res) {
				var data=res.data
				if(data!=undefined&&data.length>0){
					for(var i=0;i<data.length;i++){
						optionStr += '<option value="' + data[i].plbDictNo + '">' + data[i].dictName + '</option>'
					}
				}
			}
		})
		$select1.html(optionStr);
		form.render();
		if (urlType === 'addTest'){
			//单据号
			$.ajax({
				url:'/planningManage/autoNumber?autoNumberType=chjd',
				dataType:'json',
				type:'post',
				async: false,
				success:function(res){
					var _embodimentNo = res.obj;
					$('#embodimentNo').val(_embodimentNo);
					$('#userName').val(res.object.createUserName);
					$('#createTime').val(res.object.createDate);
				}
			})
			//项目类型
			// $.ajax({
			// 	url:'/technicalManager/getProjInfoById?projectId='+projectId,
			// 	dataType:'json',
			// 	type:'post',
			// 	success:function(res){
			// 		$('#projectTypeName').val(res.obj.projType);
			// 	}
			// })
		}else if(urlType === 'editTest') {
			$.ajax({
				url:'/planningManage/getEmbodimentById?embodimentId='+embodimentId,
				async:false,
				success:function(res){
					formData=res.obj;
				}
			})
			form.val('baseForm',formData);
			if (formData.attachmentList1 && formData.attachmentList1.length > 0) {
				var fileArr = formData.attachmentList1;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent1').append(str);
			}
			if (formData.attachmentList2 && formData.attachmentList2.length > 0) {
				var fileArr = formData.attachmentList2;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent2').append(str);
			}
			if (formData.attachmentList3 && formData.attachmentList3.length > 0) {
				var fileArr = formData.attachmentList3;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent3').append(str);
			}
			if (formData.attachmentList4 && formData.attachmentList4.length > 0) {
				var fileArr = formData.attachmentList4;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent4').append(str);
			}
		}else if(urlType=="details"){
			$.ajax({
				url:'/planningManage/getEmbodimentById?embodimentId='+embodimentId,
				async:false,
				success:function(res){
					formData=res.obj;
				}
			})
			form.val('baseForm',formData);
			if (formData.attachmentList1 && formData.attachmentList1.length > 0) {
				var fileArr = formData.attachmentList1;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent1').append(str);
			}
			if (formData.attachmentList2 && formData.attachmentList2.length > 0) {
				var fileArr = formData.attachmentList2;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent2').append(str);
			}
			if (formData.attachmentList3 && formData.attachmentList3.length > 0) {
				var fileArr = formData.attachmentList3;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent3').append(str);
			}
			if (formData.attachmentList4 && formData.attachmentList4.length > 0) {
				var fileArr = formData.attachmentList4;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent4').append(str);
			}
			$('input').attr("disabled",true);
			$('select').attr("disabled",true);
			$(".openFile").hide();
			$('.deImgs').hide();
		}else if(runId){
			$.ajax({
				url:'/planningManage/getTechnicalEmbodimentByRunId?runId='+runId,
				async:false,
				success:function(res){
					formData=res.obj;
				}
			})
			form.val('baseForm',formData);
			if (formData.attachmentList1 && formData.attachmentList1.length > 0) {
				var fileArr = formData.attachmentList1;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent1').append(str);
			}
			if (formData.attachmentList2 && formData.attachmentList2.length > 0) {
				var fileArr = formData.attachmentList2;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent2').append(str);
			}
			if (formData.attachmentList3 && formData.attachmentList3.length > 0) {
				var fileArr = formData.attachmentList3;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent3').append(str);
			}
			if (formData.attachmentList4 && formData.attachmentList4.length > 0) {
				var fileArr = formData.attachmentList4;
				var str = '';
				for (var i = 0; i < fileArr.length; i++) {
					var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
					var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
					var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
					var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

					/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
					str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent4').append(str);
			}
		}








		var tableData=[];
		$(document).on('click', '#planingName', function () {
			var planingId = $("#planingName").attr('planingId');
			parent.layer.open({
				type: 1,
				title: '选择实施策划',
				area: ['80%', '80%'],
				btnAlign: 'c',
				btn: ['确定', '取消'],
				content: ['<div class="layui-form" id="objectives">' +
				//表格数据
				'       <div style="padding: 10px">' +
				'           <table id="reportTable" lay-filter="reportTable"></table>' +
				'      </div>' +
				'</div>'].join(''),
				success: function () {
					parent.layui.table.render({
						elem: '#reportTable'
						, url: '/planningManage/selectPlanning?projectId=' + projectId+'&auditerStatus=2'
						, page: true
						,cols: [[
							{type:'radio'}
							,{field: 'planingNo', title: '单据号',minWidth:150}
							, {field: 'projectName', title: '项目名称',minWidth:120}
							// , {field: 'projectTypeName', title: '项目类型',minWidth:100}
							, {field: 'planingName', title: '实施策划名称',minWidth:120}
							, {field: 'planingTypeName', title: '方案类型',minWidth:100}
							, {field: 'userName', title: '填报人',minWidth:100}
							, {field: 'createTime', title: '填报时间',minWidth:100}
							, {field:'currFlowUserName',title:'当前处理人',minWidth:120}
							, {field:'auditerStatus',title:"审批状态",templet: function (d) {
									var str = '';
									if (d.auditerStatus == '1') {
										var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
										str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
									} else if (d.auditerStatus == '2') {
										var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
										str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
									} else if (d.auditerStatus == '3') {
										str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
									} else {
										str = '未提交';
									}
									return str;
								}}
							, {field: 'planingDesc', title: '备注',align:'center',minWidth:100}
						]]
						, limit: 10
						,done:function(res){
							if(planingId){
								parent.setDatta(planingId,res.data);
							}
							tableData=res.data;

						}
					});
				},
				yes: function (index,layero) {
					var checkStatus =  parent.getDatta();
					if(checkStatus!=null){
						$.each($(parent)[0].$("iframe"),function (i, item) {
							var iframeFun = item.contentWindow.setDatta;
							if(iframeFun && typeof(iframeFun) == "function"){
								item.contentWindow.setDatta(checkStatus)
							}
						})
					}
					layer.close(index);
					parent.layui.layer.close(index);
				}, btn2: function (index, layero) {
					layer.close(index);
					parent.layui.layer.close(index);
				}
			});
		})


		form.render();//初始化表单
	})

	function getDate(){
		var datas = $('#baseForm').serializeArray();
		var obj = {}
		datas.forEach(function (item) {
			obj[item.name] = item.value;
		});
		obj.embodimentId=embodimentId;
		obj.projectId=projectId;
		obj.planingId=$("#planingName").attr('planingId')
		var attachmentId1 = '';
		var attachmentName1 = '';
		for (var i = 0; i < $('#fileContent1 .dech').length; i++) {
			attachmentId1 += $('#fileContent1 .dech').eq(i).find('input').val();
			attachmentName1 += $('#fileContent1 .dech').eq(i).find("a").eq(0).attr('name');
		}
		var attachmentId2 = '';
		var attachmentName2 = '';
		for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
			attachmentId2 += $('#fileContent2 .dech').eq(i).find('input').val();
			attachmentName2 += $('#fileContent2 .dech').eq(i).find("a").eq(0).attr('name');
		}
		var attachmentId3 = '';
		var attachmentName3 = '';
		for (var i = 0; i < $('#fileContent3 .dech').length; i++) {
			attachmentId3 += $('#fileContent3 .dech').eq(i).find('input').val();
			attachmentName3 += $('#fileContent3 .dech').eq(i).find("a").eq(0).attr('name');
		}
		var attachmentId4 = '';
		var attachmentName4 = '';
		for (var i = 0; i < $('#fileContent4 .dech').length; i++) {
			attachmentId4 += $('#fileContent4 .dech').eq(i).find('input').val();
			attachmentName4 += $('#fileContent4 .dech').eq(i).find("a").eq(0).attr('name');
		}
		obj.attachId1  = attachmentId1;
		obj.attachName1 = attachmentName1;
		obj.attachId2  = attachmentId2;
		obj.attachName2 = attachmentName2;
		obj.attachId3  = attachmentId3;
		obj.attachName3 = attachmentName3;
		obj.attachId4  = attachmentId4;
		obj.attachName4 = attachmentName4;
		return obj;
	}

	function childFunc(){
		var datas = $('#baseForm').serializeArray();
		var obj = {}
		datas.forEach(function (item) {
			obj[item.name] = item.value;
		});
		obj.embodimentId=formData.embodimentId;
		obj.projectId=formData.projectId;
		obj.planingId=formData.planingId;
		var attachmentId1 = '';
		var attachmentName1 = '';
		for (var i = 0; i < $('#fileContent1 .dech').length; i++) {
			attachmentId1 += $('#fileContent1 .dech').eq(i).find('input').val();
			attachmentName1 += $('#fileContent1 .dech').eq(i).find("a").eq(0).attr('name');
		}
		var attachmentId2 = '';
		var attachmentName2 = '';
		for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
			attachmentId2 += $('#fileContent2 .dech').eq(i).find('input').val();
			attachmentName2 += $('#fileContent2 .dech').eq(i).find("a").eq(0).attr('name');
		}
		var attachmentId3 = '';
		var attachmentName3 = '';
		for (var i = 0; i < $('#fileContent3 .dech').length; i++) {
			attachmentId3 += $('#fileContent3 .dech').eq(i).find('input').val();
			attachmentName3 += $('#fileContent3 .dech').eq(i).find("a").eq(0).attr('name');
		}
		var attachmentId4 = '';
		var attachmentName4 = '';
		for (var i = 0; i < $('#fileContent4 .dech').length; i++) {
			attachmentId4 += $('#fileContent4 .dech').eq(i).find('input').val();
			attachmentName4 += $('#fileContent4 .dech').eq(i).find("a").eq(0).attr('name');
		}
		obj.attachId1  = attachmentId1;
		obj.attachName1 = attachmentName1;
		obj.attachId2  = attachmentId2;
		obj.attachName2 = attachmentName2;
		obj.attachId3  = attachmentId3;
		obj.attachName3 = attachmentName3;
		obj.attachId4  = attachmentId4;
		obj.attachName4 = attachmentName4;
		$.ajax({
			url:'/planningManage/updateEmbodiment',
			dataType:'json',
			type:'post',
			data:obj,
			success:function(res){
				if(res.code===0||res.code==="0"){
					layer.msg(res.msg,{icon:1});
					layer.close(index)
				}else{
					layer.msg(res.msg,{icon:0});
				}
			}
		})
	}

	function setDatta(obj){
		$('#planingName').val(obj.planingName);
		$("#planingName").attr('planingId',obj.planingId);
	}
</script>
</body>
</html>
