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
	<title>新增质量整改</title>
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
	<%--<script type="text/javascript" src="../../js/common/fileupload.js"></script>--%>
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
			height: 32px;
		}
		#formTest .layui-form-select input,#lendListTest .layui-form-select input{
			height: 32px;
		}
		.layui-input{
			height: 32px !important;
		}
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
	</style>
</head>
<body>
<div class="mbox">
	<div class="layui-tab layui-tab-card" style="margin: 3px 0 10px 0;">
		<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">
		<%---------------------------------------------质量检查-------------------------------------------------%>
		<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">质量检查</div>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
			<div class="layui-inline" style="width: 98%;">
				<label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>隐患区域</label>
				<div class="layui-input-inline" style="width: 55%;">
					<input type="text" placeholder="请选择" disabled id="region" pid name="ttitle3" style="cursor: pointer;height: 38px !important;" autocomplete="off" class="layui-input">
					<div class="eleTree ele3" lay-filter="data3" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>
				 <%--<input type="text" id="region" lay-verify="required" name="region" autocomplete="off" class="layui-input">--%>
				 </div>
			</div>
		</div>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
			<div class="layui-inline" style="width: 98%;">
				 <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>质量控制点</label>
				 <div class="layui-input-inline" style="width: 55%;">
				 	<input type="text" disabled id="hiddenDanger" pid2 lay-verify="required" style="cursor: pointer;height: 38px !important;" name="ttitle4" autocomplete="off" class="layui-input">
				<%--<div class="eleTree ele4" lay-filter="data4" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>--%>
				 </div>
			</div>
		</div>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
			<div class="layui-inline" style="width: 98%;">
				 <label class="layui-form-label" style="width: 30%;">图纸位置</label>
				 <div class="layui-input-inline" style="width: 55%;margin-top: 6px;">
					 <span id="placeSpan" style="cursor: pointer;color:blue;"></span>
				 </div>
				<input hidden id="attachmentId" name="attachmentId"/>
				<input hidden id="attachmentName" name="attachmentName"/>
				<input hidden id="securityContentId" name="securityContentId"/>
			</div>
		</div>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
			<div class="layui-inline" style="width: 98%;">
				 <label class="layui-form-label" style="width: 30%;">重大隐患</label>
				 <div class="layui-input-inline" style="width: 55%;">
					 <input type="text" securityGrade id="dangerGrade" disabled lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input">
				 </div>
			</div>
		</div>
		<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">
			<div class="layui-inline" style="width: 98%;">
				<label class="layui-form-label" style="width: 15%;">检查内容</label>
				<div class="layui-input-inline" style="width: 75%;">
					<textarea type="text" pid3 disabled style="width:100%;min-height: 80px !important;" id="securityDanger" lay-verify="required" name="securityDanger" autocomplete="off" class="layui-input"></textarea>
				</div>
			</div>
		</div>
		<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">
			<div class="layui-inline" style="width: 98%;">
				 <label class="layui-form-label" style="width: 15%;">整改措施</label>
				 <div class="layui-input-inline" style="width: 75%;">
					 <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="securityDangerMeasures" lay-verify="required" name="securityDangerMeasures" autocomplete="off" class="layui-input"></textarea>
				 </div>
			</div>
		</div>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
			<div class="layui-form-item" style="width: 98%; pane="">
				<label class="layui-form-label" style="width: 30%;">是否需要整改</label>
				<div class="layui-input-block" style="width: 55%;">
					<input type="checkbox" name="close" disabled id="needRecification" pid5 lay-skin="switch" lay-filter="switchTest" lay-text="是|否">
				</div>
			</div>
		</div><br/>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="PeriodShow">
		    <div class="layui-inline" style="width: 98%;">
		         <label class="layui-form-label" style="width: 30%;">整改期限</label>
		         <div class="layui-input-inline" style="width: 55%;">
		             <input class="layui-input" disabled style="height: 38px !important;" lay-verify="required" id="rectificationPeriod">
		         </div>
		    </div>
		</div>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="PersionShow">
		    <div class="layui-inline" style="width: 98%;">
		         <label class="layui-form-label" style="width: 30%;">整改人</label>
		         <div class="layui-input-inline" style="width: 55%;">
		             <input class="layui-input" disabled style="height: 38px !important;" lay-verify="required" id="rectificationPersion">
		         </div>
		    </div>
		</div>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="switchShow">
			<div class="layui-form-item" style="width: 98%; pane="">
				<label class="layui-form-label" style="width: 30%;">是否需要验收</label>
				<div class="layui-input-block" style="width: 55%;">
					<input type="checkbox" disabled name="close" id="needAcceptance" pid7 lay-skin="switch" lay-filter="switchTest1" lay-text="是|否">
				</div>
			</div>
		</div><br/>
		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="acceptanceShow">
		    <div class="layui-inline" style="width: 98%;">
		         <label class="layui-form-label" style="width: 30%;">验收人</label>
		         <div class="layui-input-inline" style="width: 55%;">
		             <input class="layui-input" disabled style="height: 38px !important;"  lay-verify="required" id="acceptancePersion">
		         </div>
		    </div>
		</div>
		<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">
		    <div class="layui-inline" style="width: 98%;">
		         <label id="represent" class="layui-form-label" style="width: 15%;">隐患描述</label>
		         <div class="layui-input-inline" style="width: 75%;">
		             <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="securityDangerDesc" lay-verify="required" name="securityDangerDesc" autocomplete="off" class="layui-input"></textarea>
		         </div>
		    </div>
		</div>
		<div class="layui-input-inline"  style="margin-left: 130px;">
			<div id="fujians"></div>
			 <div id="fileAll">
				</div>
			<a href="javascript:;"  class="openFile" style="float: left;margin-top:8px;position:relative">
				<%--<img src="../img/mg11.png" alt="">
				<span>添加附件</span>--%>
				<input type="file" multiple id="fileupload" data-url="/upload?module=H5" disabled name="file">
				</a>
			</div>
			<%------------------------------------------------质量整改---------------------------------------------------%>
			<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">质量整改</div>
			<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">
				<div class="layui-inline" style="width: 98%;">
					<label class="layui-form-label" style="width: 15%;">整改描述</label>
					<div class="layui-input-inline" style="width: 75%;">
						<textarea type="text" style="width:100%;min-height: 80px !important;" id="rectificationDesc" lay-verify="required"  name="rectificationDesc" autocomplete="off" class="layui-input"></textarea>
					</div>
				</div>
			</div>
			<div class="layui-form-item" id="rectificationUser1" style="width: 47%;margin:10px 0;display: inline-block">
				<div class="layui-inline" style="width: 98%;">
					<label class="layui-form-label" style="width: 30%;">整改人</label>
					<div class="layui-input-inline" style="width: 55%;">
						<input class="layui-input" style="height: 38px !important;" lay-verify="required" disabled id="rectificationUser">
					</div>
				</div>
			</div>
			<div class="layui-form-item" id="rectificationTime1" style="width: 47%;margin:10px 0;display: inline-block">
				<div class="layui-inline" style="width: 98%;">
					<label class="layui-form-label" style="width: 30%;">整改时间</label>
					<div class="layui-input-inline" style="width: 55%;">
						<input type="text"  style="height: 38px !important;" lay-verify="required" autocomplete="off" class="layui-input"  id="rectificationTime">
					</div>
				</div>
			</div><br>
			<%--整改后图片--%>
			<div class="layui-input-inline" id="one11" style="margin-left: 130px;">
				<div id="fujians1"></div>
				<div id="fileAll1">
				</div>
				<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">
					<img src="../img/mg11.png" alt="">
					<span>添加附件</span>
					<input type="file" multiple id="fileupload1" data-url="/upload?module=H5"  name="file">
				</a>
			</div>
			<%--------------------------------------------------质量验收------------------------------------------------------%>
			<div id="acceptance1" style="display: none">
				<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">质量验收</div>
				<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">
					<div class="layui-inline" style="width: 98%;">
						<label class="layui-form-label" style="width: 15%;">验收描述</label>
						<div class="layui-input-inline" style="width: 75%;">
							<textarea type="text" style="width:100%;min-height: 80px !important;" id="acceptanceDesc" lay-verify="required"  name="acceptanceDesc" autocomplete="off" class="layui-input"></textarea>
						</div>
					</div>
				</div>
				<div class="layui-form-item" id="acceptanceUser1" style="width: 47%;margin:10px 0;display: inline-block">
					<div class="layui-inline" style="width: 98%;">
						<label class="layui-form-label" style="width: 30%;">验收人</label>
						<div class="layui-input-inline" style="width: 55%;">
							<input class="layui-input" style="height: 38px !important;" lay-verify="required" disabled id="acceptanceUser">
						</div>
					</div>
				</div>
				<div class="layui-form-item" id="acceptanceTime1" style="width: 47%;margin:10px 0;display: inline-block">
					<div class="layui-inline" style="width: 98%;">
						<label class="layui-form-label" style="width: 30%;">验收时间</label>
						<div class="layui-input-inline" style="width: 55%;">
							<input type="text"  style="height: 38px !important;" lay-verify="required" autocomplete="off" class="layui-input"  id="acceptanceTime">
						</div>
					</div>
				</div><br>
				<%--附件--%>
				<div class="layui-input-inline" style="margin-left: 130px;">
					<div id="fujians2"></div>
					<div id="fileAll2">
					</div>
					<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">
						<img src="../img/mg11.png" alt="">
						<span>添加附件</span>
						<input type="file" multiple id="fileupload2" data-url="/upload?module=H5"  name="file">
					</a>
				</div>
			</div>
		</div>
		</form>
	</div>
</div>

<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
	var securityInfoDate = parent.securityInfoDate;//质量整改
	//alert(securityInfoDate)
	var securityInfoDate1 = parent.securityInfoDate1;//质量验收
	//console.log(securityInfoDate1)
	var urlType = getUrlParam("urlType");//质量验收
	//console.log(urlType)

	var user_id;
	var detailsInit;
	var detailsInitData=[];
	var detailsInit2;
	var detailsInitData2=[];
	var dept_id;
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

		laydate.render({
			elem: '#rectificationTime'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
		});

		laydate.render({
			elem: '#acceptanceTime'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
		});

		if (urlType === 'acceptance'){
			<%--------------------------------------------------质量验收------------------------------------------------------%>
			$("#acceptance1").show();
			$("#one11").find("a img").hide();
			$("#one11").find("a span").hide();
			$("#rectificationDesc").attr("readOnly",true);
			$("#rectificationTime").attr("disabled","disabled");

			if(securityInfoDate1.recificationStatus == 2||securityInfoDate1.recificationStatus == 3){
				$("#acceptanceDesc").attr("readOnly",true);
				$("#acceptanceTime").attr("disabled","disabled");
			}

			if(securityInfoDate1.acceptanceUser == undefined||securityInfoDate1.acceptanceUser == null||securityInfoDate1.acceptanceUser == ''){
				$("#acceptanceUser1").hide();
				//$("#acceptanceTime1").hide();
			}



			//var detailsId = $("#detailsId").val();
			$('#region').val(securityInfoDate1.securityRegionName);//隐患区域
			$('#region').attr('pid',securityInfoDate1.securityRegionId);//隐患区域id
			$('#hiddenDanger').val(securityInfoDate1.securityKnowledgeName);//隐患项
			$('#hiddenDanger').attr('pid2',securityInfoDate1.securityKnowledgeId);//隐患项id
			$('#dangerGrade').val(securityInfoDate1.securityGradeName);//重大隐患
			$('#dangerGrade').attr('securityGrade',securityInfoDate1.securityGrade);
			$('#securityDangerMeasures').val(securityInfoDate1.securityDangerMeasures);//整改措施
			$('#securityDanger').val(securityInfoDate1.securityDanger);//检查内容
			$('#securityDanger').attr('pid3',securityInfoDate1.securityDangerId);//检查内容id

			//图纸位置
			if((securityInfoDate1.regionX!=undefined&&securityInfoDate1.regionX!="")&&(securityInfoDate1.regionY!=undefined&&securityInfoDate1.regionY!="")){
				$('#placeSpan').text("已标注");
			}else{
				$('#placeSpan').text("未标注");
			}

			//$("#needAcceptance").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value',securityInfoDate1.needAcceptance); //是否需要验收
			if(securityInfoDate1.needRecification===0||securityInfoDate1.needRecification==='0'){
				isShow=true;
				$('#needRecification').prop('checked','checked');
				$('#PeriodShow').show();
				$('#PersionShow').show();
				$('#switchShow').show();
				$('#represent').text('隐患描述');
				if(securityInfoDate1.needAcceptance===0||securityInfoDate1.needAcceptance==='0'){
					isShow1=true;
					$('#needAcceptance').prop('checked','checked');
					$('#acceptanceShow').show();
				}else {
					$('#acceptanceShow').hide();
				}
			}else {
				isShow=false;
				isShow1=false;
				$('#PeriodShow').hide();
				$('#PersionShow').hide();
				$('#switchShow').hide();
				$('#acceptanceShow').hide();
				$('#represent').text('检查情况');
			}
			//$('#needAcceptance').val(securityInfoDate1.needAcceptance);
			$("#rectificationPeriod").val(securityInfoDate1.rectificationPeriod);//整改期限
			$("#rectificationPersion").attr("user_id",securityInfoDate1.rectificationPersion);//整改人id
			$("#rectificationPersion").val(securityInfoDate1.rectificationPersionName);//整改人
			$("#acceptancePersion").attr("user_id",securityInfoDate1.acceptancePersion);//验收人id
			$("#acceptancePersion").val(securityInfoDate1.acceptancePersionName); //验收人
			$("#securityDangerDesc").val(securityInfoDate1.securityDangerDesc);//隐患描述

			//附件
			fileuploadFn('#fileupload', $('#fileAll'));

			var str = ''
			if(securityInfoDate1.attachmentList!=undefined&&securityInfoDate1.attachmentList.length>0){
				for(var i=0;i<securityInfoDate1.attachmentList.length;i++){
					str+='<div class="dech" deUrl="' +securityInfoDate1.attachmentList[i].attUrl + '"><img class="preview" style="width: 100px;" src="/xs?' + securityInfoDate1.attachmentList[i].attUrl + '" NAME="' + securityInfoDate1.attachmentList[i].attachName +'*"><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + securityInfoDate1.attachmentList[i].aid + '@' + securityInfoDate1.attachmentList[i].ym + '_' + securityInfoDate1.attachmentList[i].attachId +',"></div>'
				}
			}else{
				str='';
			}
			$('#fileAll').append(str)
			$("#securityContentId").val(securityInfoDate1.securityContentId);
			$("#rectificationDesc").val(securityInfoDate1.rectificationDesc);//整改描述
			$("#rectificationUser").attr("rectificationUserId",securityInfoDate1.rectificationUser);//整改人id
			$("#rectificationUser").val(securityInfoDate1.rectificationUserName);//整改人
			$("#rectificationTime").val(securityInfoDate1.rectificationTime);//整改时间

			$("#acceptanceDesc").val(securityInfoDate1.acceptanceDesc);//验收描述
			$("#acceptanceUser").attr("acceptanceUserId",securityInfoDate1.acceptanceUser);//验收人id
			$("#acceptanceUser").val(securityInfoDate1.acceptanceUserName);//验收人
			$("#acceptanceTime").val(securityInfoDate1.acceptanceTime);//验收时间

			//附件
			fileuploadFn('#fileupload1', $('#fileAll1'));

			var str1 = ''
			if(securityInfoDate1.rectificationAttachmentList!=undefined&&securityInfoDate1.rectificationAttachmentList.length>0){
				for(var i=0;i<securityInfoDate1.rectificationAttachmentList.length;i++){
					str1+='<div class="dech" deUrl="' +securityInfoDate1.rectificationAttachmentList[i].attUrl + '"><img class="preview" style="width: 100px;" src="/xs?' + securityInfoDate1.rectificationAttachmentList[i].attUrl + '" NAME="' + securityInfoDate1.rectificationAttachmentList[i].attachName +'*"><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + securityInfoDate1.rectificationAttachmentList[i].aid + '@' + securityInfoDate1.rectificationAttachmentList[i].ym + '_' + securityInfoDate1.rectificationAttachmentList[i].attachId +',"></div>'
				}
			}else{
				str1='';
			}
			$('#fileAll1').append(str1)

			$("#acceptanceDesc").val(securityInfoDate1.acceptanceDesc);//验收描述
			$("#acceptanceUser").attr("acceptanceUserId",securityInfoDate1.acceptanceUser);//验收人id
			$("#acceptanceUser").val(securityInfoDate1.acceptanceUserName);//验收人
			$("#acceptanceTime").val(securityInfoDate1.acceptanceTime);//验收时间

			//附件
			fileuploadFn('#fileupload2', $('#fileAll2'));

			var str2 = ''
			if(securityInfoDate1.acceptanceAttachmentList!=undefined&&securityInfoDate1.acceptanceAttachmentList.length>0){
				for(var i=0;i<securityInfoDate1.acceptanceAttachmentList.length;i++){
					str2+='<div class="dech" deUrl="' +securityInfoDate1.acceptanceAttachmentList[i].attUrl + '"><img class="preview" style="width: 100px;" src="/xs?' + securityInfoDate1.acceptanceAttachmentList[i].attUrl + '" NAME="' + securityInfoDate1.acceptanceAttachmentList[i].attachName +'*"><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + securityInfoDate1.acceptanceAttachmentList[i].aid + '@' + securityInfoDate1.acceptanceAttachmentList[i].ym + '_' + securityInfoDate1.acceptanceAttachmentList[i].attachId +',"></div>'
				}
			}else{
				str2='';
			}
			$('#fileAll2').append(str2)

			$('#placeSpan').on("click",function() {
				$.popWindow("/workflow/qualityManager/selectDrawing?layEvent4=examineTest1&securityContentId="+securityInfoDate1.securityContentId);
			})
		}else{
			if(securityInfoDate.recificationStatus == 1||securityInfoDate.recificationStatus == 3){
				$("#rectificationDesc").attr("readOnly",true);
				$("#rectificationTime").attr("disabled","disabled");
			}
			if(securityInfoDate.rectificationUser == undefined||securityInfoDate.rectificationUser == null||securityInfoDate.rectificationUser == ''){
				$("#rectificationUser1").hide();
				//$("#rectificationTime1").hide();
			}


			//fileuploadFn('#fileupload', $('#fileAll'));

			/*laydate.render({
                elem: '#rectificationPeriod'
                , trigger: 'click'//呼出事件改成click
            });*/
			//回显数据
			<%--------------------------------------------------质量整改------------------------------------------------------%>
			//var detailsId = $("#detailsId").val();
			$('#region').val(securityInfoDate.securityRegionName);//隐患区域
			$('#region').attr('pid',securityInfoDate.securityRegionId);//隐患区域id
			$('#hiddenDanger').val(securityInfoDate.securityKnowledgeName);//隐患项
			$('#hiddenDanger').attr('pid2',securityInfoDate.securityKnowledgeId);//隐患项id
			$('#dangerGrade').val(securityInfoDate.securityGradeName);//重大隐患
			$('#dangerGrade').attr('securityGrade',securityInfoDate.securityGrade);
			$('#securityDangerMeasures').val(securityInfoDate.securityDangerMeasures);//整改措施
			$('#securityDanger').val(securityInfoDate.securityDanger);//检查内容
			$('#securityDanger').attr('pid3',securityInfoDate.securityDangerId);//检查内容id

			//图纸位置
			if((securityInfoDate.regionX!=undefined&&securityInfoDate.regionX!="")&&(securityInfoDate.regionY!=undefined&&securityInfoDate.regionY!="")){
				$('#placeSpan').text("已标注");
			}else{
				$('#placeSpan').text("未标注");
			}

			//$("#needAcceptance").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value',securityInfoDate.needAcceptance); //是否需要验收
			if(securityInfoDate.needRecification===0||securityInfoDate.needRecification==='0'){
				isShow=true;
				$('#needRecification').prop('checked','checked');
				$('#PeriodShow').show();
				$('#PersionShow').show();
				$('#switchShow').show();
				$('#represent').text('隐患描述');
				if(securityInfoDate.needAcceptance===0||securityInfoDate.needAcceptance==='0'){
					isShow1=true;
					$('#needAcceptance').prop('checked','checked');
					$('#acceptanceShow').show();
				}else {
					$('#acceptanceShow').hide();
				}
			}else {
				isShow=false;
				isShow1=false;
				$('#PeriodShow').hide();
				$('#PersionShow').hide();
				$('#switchShow').hide();
				$('#acceptanceShow').hide();
				$('#represent').text('检查情况');
			}
			//$('#needAcceptance').val(securityInfoDate.needAcceptance);
			$("#rectificationPeriod").val(securityInfoDate.rectificationPeriod);//整改期限
			$("#rectificationPersion").attr("user_id",securityInfoDate.rectificationPersion);//整改人id
			$("#rectificationPersion").val(securityInfoDate.rectificationPersionName);//整改人
			$("#acceptancePersion").attr("user_id",securityInfoDate.acceptancePersion);//验收人id
			$("#acceptancePersion").val(securityInfoDate.acceptancePersionName); //验收人
			$("#securityDangerDesc").val(securityInfoDate.securityDangerDesc);//隐患描述

			//附件
			fileuploadFn('#fileupload', $('#fileAll'));
			var str = ''
			if(securityInfoDate.rectificationAttachmentList!=undefined&&securityInfoDate.rectificationAttachmentList.length>0){
				for(var i=0;i<securityInfoDate.rectificationAttachmentList.length;i++){
					str+='<div class="dech" deUrl="' +securityInfoDate.rectificationAttachmentList[i].attUrl + '"><img class="preview" style="width: 100px;" src="/xs?' + securityInfoDate.rectificationAttachmentList[i].attUrl + '" NAME="' + securityInfoDate.rectificationAttachmentList[i].attachName +'*"><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + securityInfoDate.rectificationAttachmentList[i].aid + '@' + securityInfoDate.rectificationAttachmentList[i].ym + '_' + securityInfoDate.rectificationAttachmentList[i].attachId +',"></div>'
				}
			}else{
				str='';
			}
			$('#fileAll1').append(str)
			$("#securityContentId").val(securityInfoDate.securityContentId);

			$("#rectificationDesc").val(securityInfoDate.rectificationDesc);//整改描述
			$("#rectificationUser").attr("rectificationUserId",securityInfoDate.rectificationUser);//整改人id
			$("#rectificationUser").val(securityInfoDate.rectificationUserName);//整改人
			$("#rectificationTime").val(securityInfoDate.rectificationTime);//整改时间

			$('#placeSpan').on("click",function() {
				$.popWindow("/workflow/qualityManager/selectDrawing?layEvent3=initialization1&securityContentId="+securityInfoDate.securityContentId);
			})
		}

		Array.prototype.remove = function(val) {
			var index = this.indexOf(val);
			if (index > -1) {
				this.splice(index, 1);
			}
		};
		form.render();//初始化表单
	})

	//整改后图片
	fileuploadFn('#fileupload1', $('#fileAll1'));
	//检查后图片
	fileuploadFn('#fileupload2', $('#fileAll2'));

	function getDate(){
		var obj = {};
		obj.rectificationDesc = $('#rectificationDesc').val();
		obj.rectificationUser = $('#rectificationUser').attr('rectificationUserId')
		obj.rectificationTime = $('#rectificationTime').val();
		//附件
		debugger
		var rectificationAttachmentId = '';
		var rectificationAttachmentName = '';
		for (var i = 0; i < $('#fileAll1 .dech').length; i++) {
			rectificationAttachmentId += $('#fileAll1 .dech').eq(i).find('input').val();
			rectificationAttachmentName += $('#fileAll1 img').eq(i).attr('name');
		}
		obj.rectificationAttachmentId  = rectificationAttachmentId;
		obj.rectificationAttachmentName = rectificationAttachmentName;
		return obj;
	}

	function getDate1(){
		var obj = {};
		obj.acceptanceDesc = $('#acceptanceDesc').val();
		obj.acceptanceUser = $('#acceptanceUser').attr('acceptanceUserId')
		obj.rectificationTime = $('#acceptanceTime').val();
		//附件
		var acceptanceAttachmentId = '';
		var acceptanceAttachmentName = '';
		for (var i = 0; i < $('#fileAll2 .dech').length; i++) {
			acceptanceAttachmentId += $('#fileAll2 .dech').eq(i).find('input').val();
			acceptanceAttachmentName += $('#fileAll2 img').eq(i).attr('name');
		}
		obj.acceptanceAttachmentId  = acceptanceAttachmentId;
		obj.acceptanceAttachmentName = acceptanceAttachmentName;
		return obj;
	}

	//删除附件
	$(document).on('click', '.deImgs', function () {
		var _this = this;
		var attUrl = $(this).parents('.dech').attr('deUrl');
		layer.confirm('确定删除该附件吗？', function (index) {
			$.ajax({
				type: 'get',
				url: '/delete?' + attUrl,
				dataType: 'json',
				success: function (res) {
					if (res.flag == true) {
						layer.msg('删除成功', {icon: 6, time: 1000});
						$(_this).parent().remove();
					} else {
						layer.msg('删除失败', {icon: 2, time: 1000});
					}
				}
			})
		});
	});

	function childFunc(){
		columnId = parent.columnTrId
		SettlementTable.reload({
			url: '/fileManage/getFile?columnIds='+columnId//数据接口
		});
	}
	function lookFile(repalogId){//查看附件
		if (repalogId == undefined || repalogId == "") {
			layer.msg("文件已被损坏，无法查看");
		} else {
			selectFile1(repalogId,'knowlage');
			//window.location.href = "/equipment/limsDownload?model=" + model + "&attachId=" + attachId  下载
		}
	}
	//查看附件
	function selectFile1(attchId,model) {
		if(attchId){
			//查看附件
			var data={
				attachId:attchId,
				model:model
			}
			var res=toAjaxT1("/equipment/selectAttchUrl",data);
			if(res.code==0){
				if(res.object){
					limsPreview1(res.object);
				}
			}
		}

	}
	//附件预览点击调取
	function limsPreview1(attrUrl) {
		var url = '';
		if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1){
			var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
			var atturl2 = '';
			if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
				for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
					atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
				}
				url = atturl1 + atturl2;
			}else{
				url = atturl1;
			}
		}
		if(limsUrlGetRequest('?'+attrUrl) == 'pdf' || limsUrlGetRequest('?'+attrUrl) == 'PDF'){
			layui.layer.open({
				type: 2,
				title: '预览',
				offset:["20px",""],
				content: "/pdfPreview?"+url,
				area: ['80%', '80%']
			})
			// $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
		}else if(limsUrlGetRequest('?'+attrUrl) == 'png' || limsUrlGetRequest('?'+attrUrl) == 'PNG'|| limsUrlGetRequest('?'+attrUrl) == 'jpg' || limsUrlGetRequest('?'+attrUrl) == 'JPG'|| limsUrlGetRequest('?'+attrUrl) == 'txt'|| limsUrlGetRequest('?'+attrUrl) == 'TXT'){
			layui.layer.open({
				type: 2,
				title: '预览',
				content: "/xs?"+url,
				offset:["20px",""],
				area: ['80%', '80%'],
				success:function(layero, index){
					var iframeWindow = window['layui-layer-iframe'+ index];
					var doc = $(iframeWindow.document);
					doc.find('img').css("width","100%");
				}
			})
			// $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
		}else{
			pdurl1(limsUrlGetRequest('?'+attrUrl),attrUrl)
			// $.ajax({
			//     type:'get',
			//     url:'/sysTasks/getOfficePreviewSetting',
			//     dataType:'json',
			//     success:function (res) {
			//         if(res.flag){
			//             var strOfficeApps = res.object.previewUrl;//在线预览服务地址
			//             if(strOfficeApps == ''){
			//                 strOfficeApps = 'https://view.officeapps.live.com';
			//             }
			//             layui.layer.open({
			//                 type: 2,
			//                 title: '预览',
			//                 offset:["20px",""],
			//                 content: strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),
			//                 area: ['80%', '80%']
			//             })
			//             // $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),'','0','0','1200px','600px')
			//         }
			//     }
			// })

		}
	}
	//判断是否显示空
	function isShowNull2(data) {
		if(data){
			return data
		}else{
			return "";
		}
	}
	//同步
	function toAjaxT1(url,data) {
		var result;
		$.ajax({
			url:url,
			data:data,
			type: 'post',
			async:false,
			dataType: 'json',
			success: function (res){
				result=res;
			}
		});
		return result;
	}
	//截取附件文件后缀
	function limsUrlGetRequest(name) {
		var attach=name
		return attach.substring(attach.lastIndexOf(".")+1,attach.length);
	}
	function pdurl1(gs,atturl){ //根据后缀判断选择调取那种打开方式
		if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
			var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
			var atturl2 = '';
			if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
				for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
					atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
				}
				atturl = atturl1 + atturl2;
			}else{
				atturl = atturl1;
			}
		}
		if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
			$.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
		}else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
			layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
			layer.msg('点击任意处关闭');
		}else if(gs == 'pdf'||gs == 'PDF'){
			$.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
		}else{
			var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
			$.ajax({
				url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
				type:'post',
				datatype:'json',
				async:false,
				success: function (res) {
					if(res.flag){
						if(res.object[0].paraValue == 0){
							//默认加载NTKO插件 进行跳转
							url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
						}else if(res.object[0].paraValue == 2){
							//默认加载NTKO插件 进行跳转
							url = "/wps/info?"+ atturl +"&permission=read";
						}
					}

				}
			})
			setTimeout(function(){
				$.popWindow(url,PreviewPage,'0','0','1200px','600px');
			}, 1000);
		}
	}
	function undefind_nullStr(value) {
		if(value==undefined){
			return ""
		}
		return value
	}
	function getAttachIds(obj) {
		return obj.aid+"@"+obj.ym+"_"+obj.attachId;
	}
	//图片上传 方法
	function fileuploadFn(formId,element) {
		var timer=null;
		// $('#uploadinputimg').fileupload({
		$(formId).fileupload({
			dataType:'json',
			progressall: function (e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
				$('#progress .bar').css(
						'width',
						progress + '%'
				);
				$('.barText').html(progress + '%');
				if(progress >= 100){  //判断滚动条到100%清除定时器
					timer=setTimeout(function () {
						$('#progress .bar').css(
								'width',
								0 + '%'
						);
						$('.barText').html('');
					},2000);

				}
			},
			done: function (e, data) {
				if(data.result.obj!=undefined){
					if(data.result.obj != ''){
						var data = data.result.obj;
						var str = '';
						var str1 = '';
						for (var i = 0; i < data.length; i++) {
							var gs = data[i].attachName.split('.')[1];
							if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
								var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
								var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
								var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
								var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

								str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img class="deImgs" style="cursor: pointer;margin-top: -40px;margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
							}
							/* else if(data[i].attachName.indexOf('+')!=-1){
                                     alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                             }*/
							else{ //后缀为这些的禁止上传
								str += '';
								layer.msg('只能上传图片!', {icon: 2, time: 1000});
								/*layer.alert('只能上传图片!',{},function(){
									layer.closeAll();
								});*/
							}
						}
						// $('.Attachment td').eq(1).append(str);
						console.log(element)
						element.append(str);
					}else{

						layer.msg('添加附件大小不能为空!', {icon: 2, time: 1000});
						/*layer.alert('添加附件大小不能为空!',{},function(){
							layer.closeAll();
						});*/
					}
				}else {
					if(data.result.datas != ''){
						var data = data.result.datas;
						var str = '';
						var str1 = '';
						for (var i = 0; i < data.length; i++) {
							var gs = data[i].attachName.split('.')[1];
							if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
								var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
								var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
								var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
								var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

								str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img class="deImgs" style="cursor: pointer;margin-top: -40px;margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
							}
							/* else if(data[i].attachName.indexOf('+')!=-1){
                                     alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                             }*/
							else{ //后缀为这些的禁止上传
								str += '';
								layer.msg('只能上传图片!', {icon: 2, time: 1000});
								/*layer.alert('只能上传图片!',{},function(){
									layer.closeAll();
								});*/
							}
						}
						// $('.Attachment td').eq(1).append(str);
						console.log(element)
						element.append(str);
					}else{
						layer.msg('添加附件大小不能为空!', {icon: 2, time: 1000});
						/*layer.alert('添加附件大小不能为空!',{},function(){
							layer.closeAll();
						});*/
					}
				}

			}
		});
	}

	$(document).on('click', '.preview', function () {
		var deUrl = $(this).attr("src").split('?')[1];
		layui.layer.open({
			type: 2,
			title: '预览',
			content: "/xs?"+encodeURI(deUrl),
			offset:["20px",""],
			area: ['70%', '90%'],
			success:function(layero, index){
				var iframeWindow = window['layui-layer-iframe'+ index];
				var doc = $(iframeWindow.document);
				doc.find('img').css("width","100%");
			}
		})
	})
</script>
</body>
</html>
