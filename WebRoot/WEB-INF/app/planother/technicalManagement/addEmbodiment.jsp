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
	<title>技术交底业务填报界面</title>
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
		/*.mbox{*/
		/*    padding: 0px;*/
		/*}*/
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
		/*滚动条样式*/
		/*.rtfix::-webkit-scrollbar {!*滚动条整体样式*!*/
		/*width: 4px;     !*高宽分别对应横竖滚动条的尺寸*!*/
		/*height: 10px;*/
		/*}*/
		/*.rtfix::-webkit-scrollbar-button{*/
		/*background-color: #000;*/
		/*border:1px solid #ccc;*/
		/*display:block;*/
		/*}*/
		/*.rtfix::-webkit-scrollbar-thumb {!*滚动条里面小方块*!*/
		/*border-radius: 5px;*/
		/*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
		/*background: rgba(0,0,0,0.2);*/
		/*}*/
		/*.rtfix::-webkit-scrollbar-track {!*滚动条里面轨道*!*/
		/*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
		/*border-radius: 0;*/
		/*background: rgba(0,0,0,0.1);}*/
		.eleTree{
			cursor: pointer;
		}
		.layui-table-view .layui-table td, .layui-table-view .layui-table th{
			padding: 3px 0;
		}
		.layui-tab layui-tab-card{
			margin-top: -4px;
		}
		.layui-tab-card>.layui-tab-title .layui-this:after {
			border-width: 0px;
		}
		.baseinfo td{
			padding: 5px 2px;
		}
		.active{
			display: none;
		}
		.back{
			background-color: #F2F2F2;
		}
		.layui-colla-item {
			position: relative;
		}
		.layui-collapse .layui-card-body{
			padding: 0 8px;
		}
		.repairLable{
			padding: 8px 15px;
			text-align: right;
			vertical-align: middle;
		}
		.layui-form-select dl dd{
			height: 32px;
			line-height: 32px;
		}
		.layui-form-select .layui-select-title .layui-input{
			height: 38px;
		}
		#formTest1 .layui-form-select input,#lendListTest .layui-form-select input{
			height: 38px;
		}
		/*.layui-input{*/
		/*    height: 32px !important;*/
		/*}*/
		.layui-form-item{
			margin-bottom: 5px; !important;
		}
		.layui-form-label{
			width: 70px; !important;
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
		.layui-layer .layui-layer-page  {
			z-index:19000000;
		}

		.con_left {
			float: left;
			width: 210px;
			height: 100%;
			margin-top: 10px;
		}
		.con_right {
			float: left;
			width: calc(100% - 230px);
			height: 100%;
			position: relative;
			overflow-y: auto;
			/*margin-top: 41px;*/
			/*left: -20px;*/
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
	<div class="layui-tab" style="margin: 3px 0 10px 0;">
		<form class="layui-form" id="baseForm" lay-filter="baseForm">
			<div class="layui-row">
				<div class="layui-col-xs4">
					<div class="layui-form-item">
						<label class="layui-form-label form_label">单据号<a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
						<div class="layui-form-block form_block">
							<input type="text" class="layui-input" name="embodimentNo" id="embodimentNo" readonly  autocomplete="off">
						</div>
					</div>
				</div>
			<div class="layui-col-xs4">
				<div class="layui-form-item">
					<label class="layui-form-label form_label">项目名称</label>
					<div class="layui-form-block form_block">
						<input type="text" class="layui-input" name="projectName" id="projectName" readonly  autocomplete="off">
					</div>
				</div>
			</div>
<%--			<div class="layui-col-xs4">--%>
<%--				<div class="layui-form-item">--%>
<%--					<label class="layui-form-label form_label">项目类型</label>--%>
<%--					<div class="layui-form-block form_block">--%>
<%--						<input type="text" class="layui-input" name="projectTypeName" id="projectTypeName" readonly  autocomplete="off">--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
			<div class="layui-col-xs4">
				<div class="layui-form-item">
					<label class="layui-form-label form_label">技术交底名称</label>
					<div class="layui-form-block form_block">
						<input type="text" class="layui-input" name="embodimentName" id="embodimentName"  placeholder="请填写技术交底名称"  autocomplete="off">
					</div>
				</div>
			</div>
			<div class="layui-col-xs4">
				<div class="layui-form-item">
					<label class="layui-form-label form_label">交底程度</label>
					<div class="layui-form-block form_block">
						<select id="embodimentType" name="embodimentType" class="disab" style="height: 38px;"></select>
					</div>
				</div>
			</div>
			<div class="layui-col-xs4">
				<div class="layui-form-item">
					<label class="layui-form-label form_label">技术方案名称</label>
					<div class="layui-form-block form_block">
						<input type="text" class="layui-input" name="superviseName" id="superviseName"  placeholder="请选择技术方案名称" readonly  autocomplete="off" style="background:#e7e7e7;cursor: pointer;">
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
			<div class="layui-col-xs4">
				<div class="layui-form-item">
					<label class="layui-form-label form_label">备注</label>
					<div class="layui-form-block form_block">
						<input type="text" class="layui-input" name="embodimentDesc" id="embodimentDesc"  autocomplete="off" >
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

	var detailsInit;
	var detailsInitData=[];
	var detailsInit2;
	var detailsInitData2=[];
	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var columnId = parent.columnTrId;//getUrlParam('columnId');
	var SettlementTable;

	layui.use(['table','layer','form','element','eleTree','upload','laydate'], function() {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var upload = layui.upload;
		var laydate = layui.laydate;


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



		if (urlType === 'addTest'){
			 if(projectId){
				//项目类型
				$.ajax({
					url:'/technicalManager/getProjInfoById?projectId='+projectId,
					dataType:'json',
					type:'post',
					success:function(res){
						$('#projectTypeName').val(res.obj.projType);
						$("#projectName").val(res.obj.projName);
						$("#projectName").attr("projectId",projectId);
					}
				})
			}
			$.ajax({
				url:'/planningManage/autoNumber?autoNumberType=jsjd',
				dataType:'json',
				type:'post',
				async: false,
				success:function(res){
					var _embodimentNo = res.obj;
					$('#embodimentNo').val(_embodimentNo);
					$('#userName').val(res.object.createUserName);
					$('#createTime').val(res.object.createDate)
				}
			})
		}else if(urlType =='editTest') {
			$.ajax({
				url:'/technicalManager/getTechnicalEmbodimentById?embodimentId='+embodimentId,
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent4').append(str);
			}
		}else if(urlType=="details"){
			$.ajax({
				url:'/technicalManager/getTechnicalEmbodimentById?embodimentId='+embodimentId,
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent4').append(str);
			}
			$('input').attr("disabled",true);
			$('select').attr("disabled",true);
			$('.openFile').hide();
			$('.deImgs').hide();
		}else if(runId){
            $.ajax({
				url:'/technicalManager/getTechnicalEmbodimentByRunId?runId='+runId,
				async:false,
				success:function(res){
					formData=res.obj
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent4').append(str);
			}
		}else if(urlType=="details"){
			$.ajax({
				url:'/technicalManager/getTechnicalEmbodimentById?embodimentId='+embodimentId,
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
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
					str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
							'<a fileExtension="' + fileExtension + '" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a>' +
							'<a class="download" style="padding-left: 5px" href="/download?' + encodeURI(deUrl) + '" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
				}
				$('#fileContent4').append(str);
			}

			if(_disabled=="1"){
				$('input').attr("disabled",true);
				$('select').attr("disabled",true);
				$('.openFile').hide();
				$('.deImgs').hide();
			}

		}

		var tableData=[];
		$(document).on('click', '#superviseName', function () {
			var superviseId = $("#superviseName").attr('superviseId');
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
						, url: '/technicalManager/selectTechnicalReport?projectId=' + projectId+'&auditerStatus=2'
						, page: true
						,cols: [[
							{type: 'radio'}
							,{field:'superviseNo', title:'单据号'}
							,{field:'projectName', title:'项目名称'}
							,{field:'projectTypeName', title:'项目类型'}
							,{field:'superviseName', title:'技术方案名称'}
							,{field:'superviseTypeName', title:'方案类型'}
							,{field:'userName', title:'填报人'}
							,{field:'createTime', title:'填报时间'}
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
							,{field:'superviseDesc', title:'备注'}
							,{title:'操作',align:'center',toolbar:'#toolDemo',minWidth:130}
						]]
						, limit: 10
						,done:function(res){
							if(superviseId){
								parent.setDatta(superviseId,res.data);
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
		obj.projectId = $("#projectName").attr("projectId");
		obj.superviseId=$('#superviseName').attr("superviseId");
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
		if(_disabled=="1"){
			return false
		}
		var datas = $('#baseForm').serializeArray();
		var obj = {}
		datas.forEach(function (item) {
			obj[item.name] = item.value;
		});
		obj.projectId = formData.projectId;
		obj.superviseId=formData.superviseId;
		obj.embodimentId=formData.embodimentId;
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

		var _flag = false;

		$.ajax({
			url:'/technicalManager/updateTechnicalEmbodiment',
			dataType:'json',
			type:'post',
			data:obj,
			success:function(res){
				if(res.code===0||res.code==="0"){
					layer.msg(res.msg,{icon:1});
					SettlementTable.reload()
					layer.close(index)
				}else{
					layer.msg(res.msg,{icon:0});
					_flag = true
				}
			}
		})
		if(_flag){
			return false;
		}
		return true;

	}
	function setDatta(obj){
		$('#superviseName').val(obj.superviseName);
		$("#superviseName").attr('superviseId',obj.superviseId);
	}


</script>
</body>
</html>
